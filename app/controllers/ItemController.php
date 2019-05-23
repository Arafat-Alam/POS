<?php

class ItemController extends \BaseController
{
    public $timestamp;

    public function __construct()
    {
        $this->beforeFilter('csrf', array('on' => 'post'));
        $this->timestamp = date('Y-m-d H:i:s');
    }
    
    public function getAllItemJsonData()
    {
        $all_items = DB::select("select iteminfos.item_id,iteminfos.item_name,iteminfos.upc_code, priceinfos.purchase_price,priceinfos.sale_price,iteminfos.price_id, COALESCE(all_item.g_qty, 0)as g_qty, COALESCE(all_item.s_qty, 0)as s_qty,sum(COALESCE(all_item.s_qty, 0) + COALESCE(all_item.g_qty, 0)) as total_qty
            from iteminfos
            left join priceinfos on priceinfos.price_id=iteminfos.price_id
            left join (
                select stk.item_id,stk.price_id,stk.purchase_price,stk.sale_price,stk.item_name,stk.upc_code,stk.s_qty,COALESCE(gdn.g_qty, 0)as g_qty, sum(COALESCE(stk.s_qty, 0) + COALESCE(gdn.g_qty, 0)) as total_qty 
                 from(
                         select iteminfos.item_id,iteminfos.price_id,p.purchase_price,p.sale_price, iteminfos.upc_code,iteminfos.item_name,COALESCE(sum(s.available_quantity), 0) as s_qty
                         from iteminfos
                         left outer join stockitems as s on s.item_id=iteminfos.item_id
                         left join priceinfos as p on p.price_id=iteminfos.price_id
                         where s.`status`=1
                         group by iteminfos.item_id
                         ) 
                         as stk
                         left outer join(
                                 select iteminfos.item_id,iteminfos.upc_code,iteminfos.item_name,COALESCE(sum(g.available_quantity), 0)  as g_qty
                                 from iteminfos
                                 right outer join godownitems as g on g.item_id=iteminfos.item_id
                                 where g.`status`=1
                                 group by iteminfos.item_id
                         ) 
                         as gdn on gdn.item_id=stk.item_id
                 group by stk.item_id
                 order by stk.item_name asc
                 ) as all_item on iteminfos.item_id=all_item.item_id
            where iteminfos.status=1
            group by iteminfos.item_id
            order by iteminfos.item_name asc");

        return Response::json(['data' => $all_items]);
    }

    public function allItemView()
    {
        $sql = DB::select("select stk.item_id,stk.item_name,stk.upc_code,stk.s_qty,COALESCE(gdn.g_qty, 0)as g_qty, sum(COALESCE(stk.s_qty, 0) + COALESCE(gdn.g_qty, 0)) as total_qty 
                from(
                        select iteminfos.item_id,iteminfos.upc_code,iteminfos.item_name,COALESCE(sum(s.available_quantity), 0) as s_qty
                        from iteminfos
                        left outer join stockitems as s on s.item_id=iteminfos.item_id
                        where s.`status`=1
                        group by iteminfos.item_id
                        ) as stk
                        left outer join(
                                select iteminfos.item_id,iteminfos.upc_code,iteminfos.item_name,COALESCE(sum(g.available_quantity), 0)  as g_qty
                                from iteminfos
                                right outer join godownitems as g on g.item_id=iteminfos.item_id
                                where g.`status`=1
                                group by iteminfos.item_id
                        ) as gdn on gdn.item_id=stk.item_id
                group by stk.item_id");
        return View::make('admin.items.viewAllItem');
    }

    public function getAllItemData()
    {

    }
    public function index()
    {
        return View::make('admin.items.viewItem');
    }
//=======Item Category========
    public function itemCategoryForm()
    {
        return View::make('admin.setup.itemCategorySetup.addItemCategory');
    }
    public function saveItemCategory()
    {
        try {
            $data = Input::all();
            $validator = Validator::make($data, Itemcategory::$rules);
            if ($validator->fails()) {
                return Redirect::back()->withErrors($validator)->withInput();
            }
            $item_category = array(
                'category_name' => Input::get('category_name'),
                'created_by' => Session::get('emp_id'),
                'created_at' => $this->timestamp
            );
            $insert = DB::table('itemcategorys')->insert($item_category);
            if ($insert) {
                return Redirect::to('admin/setup')->with('message', 'Added Successfully');
            }
            return Redirect::to('admin/setup')->with('errorMsg', 'Something must be wrong! Please check');
        } catch (\Exception $e) {
            Session::flash('mySqlError', $e->errorInfo[2]); // session set only once
            $err_msg = Lang::get("mysqlError." . $e->errorInfo[1]);
            return Redirect::to('admin/setup')->with('errorMsg', $err_msg)->withInput();
        }
    }
    public function itemCategoryView()
    {
        $item_categorys = DB::table('itemcategorys')->where('status', 1)->get();
        return View::make('admin.setup.itemCategorySetup.itemCategory', compact('item_categorys'));
    }
    public function editItemCategory($categoryId)
    {
        try {
            $data = Input::all();
            $validator = Validator::make($data, Itemcategory::$rules);
            if ($validator->fails()) {
                return Response::json(['status' => 'Validation Error occurred']);
            }
            $item_category = array(
                'category_name' => Input::get('category_name'),
                'updated_by' => Session::get('emp_id'),
                'updated_at' => $this->timestamp
            );

            $item_category = DB::table('itemcategorys')
                ->where('category_id', $categoryId)
                ->update($item_category);
            if ($item_category) {
                return Response::json(['status' => 'success']);
            }
            return Response::json(['status' => 'error']);
        } catch (\Exception $e) {
            Session::flash('mySqlError', $e->errorInfo[2]); // session set only once
            $err_msg = Lang::get("mysqlError." . $e->errorInfo[1]);
            return Response::json(['status' => $err_msg]);
        }
    }
    public function deleteItemCategory($categoryId)
    {
        $categoryItemDelete = DB::table('itemcategorys')
            ->where('category_id', $categoryId)
            ->update(array('status' => 0));
        if ($categoryItemDelete) {
            return Response::json(['status' => 'success']);
        }
        return Response::json(['status' => 'error']);
    }
//========Item Brand=============
    public function itemBrandForm()
    {
        return View::make('admin.setup.itemBrandSetup.addNewBrand');
    }
    public function saveItemBrand()
    {
        try {
            $data = Input::all();
            $validator = Validator::make($data, Itemcategory::$brand_rules);
            if ($validator->fails()) {
                return Redirect::back()->withErrors($validator)->withInput();
            }
            $item_category = array(
                'brand_name' => Input::get('brand_name'),
                'created_by' => Session::get('emp_id'),
                'created_at' => $this->timestamp
            );
            $insert = DB::table('itembrands')->insert($item_category);
            if ($insert) {
                return Redirect::to('admin/setup')->with('message', 'Added Successfully');
            }
            return Redirect::to('admin/setup')->with('errorMsg', 'Something must be wrong! Please check');
        } catch (\Exception $e) {
            return Redirect::to('admin/setup')->with('errorMsg', 'Duplicate entry found.')->withInput();
        }
    }
    public function itemBrandView()
    {
        $item_brands = DB::table('itembrands')->where('status', 1)->get();
        return View::make('admin.setup.itemBrandSetup.itemBrand', compact('item_brands'));
    }
    public function editItemBrand($brandId)
    {
        try {
            $data = Input::all();
            $validator = Validator::make($data, Itemcategory::$brand_rules);
            if ($validator->fails()) {
                return Response::json(['status' => 'Validation Error occurred']);
            }
            $item_brand = array(
                'brand_name' => Input::get('brand_name'),
                'updated_by' => Session::get('emp_id'),
                'updated_at' => $this->timestamp
            );
            $item_brand = DB::table('itembrands')
                ->where('brand_id', $brandId)
                ->update($item_brand);
            if ($item_brand) {
                return Response::json(['status' => 'success']);
            }
            return Response::json(['status' => 'error']);
        } catch (\Exception $e) {
            Session::flash('mySqlError', $e->errorInfo[2]); // session set only once
            $err_msg = Lang::get("mysqlError." . $e->errorInfo[1]);
            return Response::json(['status' => $err_msg]);
        }
    }
    public function deleteItemBrand($brandId)
    {
        $BrandItemDelete = DB::table('itembrands')
            ->where('brand_id', $brandId)
            ->update(array('status' => 0));
        if ($BrandItemDelete) {
            return Response::json(['status' => 'success']);
        }
        return Response::json(['status' => 'error']);
    }
//=======Item Location========
    public function itemLocationForm()
    {
        return View::make('admin.setup.itemLocationSetup.addItemLocation');
    }
    public function saveItemLocation()
    {
        try {
            $data = Input::all();
            $validator = Validator::make($data, Itemcategory::$location_rules);
            if ($validator->fails()) {
                return Redirect::back()->withErrors($validator)->withInput();
            }
            $item_location = array(
                'location_name' => Input::get('location_name'),
                'created_by' => Session::get('emp_id'),
                'created_at' => $this->timestamp
            );
            $insert = DB::table('itemlocations')->insert($item_location);
            if ($insert) {
                return Redirect::to('admin/setup')->with('message', 'Added Successfully');
            }
            return Redirect::to('admin/setup')->with('errorMsg', 'Something must be wrong! Please check');
        } catch (\Exception $e) {
            Session::flash('mySqlError', $e->errorInfo[2]); // session set only once
            $err_msg = Lang::get("mysqlError." . $e->errorInfo[1]);
            return Redirect::to('admin/setup')->with('errorMsg', $err_msg)->withInput();
        }
    }
    public function itemLocationView()
    {
        $item_locations = DB::table('itemlocations')->where('status', 1)->get();
        return View::make('admin.setup.itemLocationSetup.itemLocation', compact('item_locations'));
    }
    public function editItemLocation($locationId)
    {
        try {
            $data = Input::all();
            $validator = Validator::make($data, Itemcategory::$location_rules);
            if ($validator->fails()) {
                return Response::json(['status' => 'Validation Error occurred']);
            }
            $item_location = array(
                'location_name' => Input::get('location_name'),
                'updated_by' => Session::get('emp_id'),
                'updated_at' => $this->timestamp
            );
            $item_location = DB::table('itemlocations')
                ->where('location_id', $locationId)
                ->update($item_location);
            if ($item_location) {
                return Response::json(['status' => 'success']);
            }
            return Response::json(['status' => 'error']);
        } catch (\Exception $e) {
            Session::flash('mySqlError', $e->errorInfo[2]); // session set only once
            $err_msg = Lang::get("mysqlError." . $e->errorInfo[1]);
            return Response::json(['status' => $err_msg]);
        }
    }
    public function deleteItemLocation($locationId)
    {
        $locationItemDelete = DB::table('itemlocations')
            ->where('location_id', $locationId)
            ->update(array('status' => 0));
        if ($locationItemDelete) {
            return Response::json(['status' => 'success']);
        }
        return Response::json(['status' => 'error']);
    }
//========Item Company=============
    public function itemCompanyForm()
    {
        return View::make('admin.setup.itemCompanySetup.addNewCompany');
    }
    public function saveItemCompany()
    {
        try {
            $data = Input::all();
            $validator = Validator::make($data, Itemcategory::$company_rules);
            if ($validator->fails()) {
                return Redirect::back()->withErrors($validator)->withInput();
            }
            $item_company = array(
                'company_name' => Input::get('company_name'),
                'created_by' => Session::get('emp_id'),
                'created_at' => $this->timestamp
            );
            $insert = DB::table('companynames')->insert($item_company);
            if ($insert) {
                return Redirect::to('admin/setup')->with('message', 'Added Successfully');
            }
            return Redirect::to('admin/setup')->with('errorMsg', 'Something must be wrong! Please check');
        } catch (\Exception $e) {
            return Redirect::to('admin/setup')->with('errorMsg', 'Duplicate entry found.')->withInput();
        }
    }
    public function itemCompanyView()
    {
        $item_companys = DB::table('companynames')->where('status', 1)->get();
        return View::make('admin.setup.itemCompanySetup.itemCompany', compact('item_companys'));
    }
    public function editItemCompany($companyId)
    {
        try {
            $data = Input::all();
            $validator = Validator::make($data, Itemcategory::$company_rules);
            if ($validator->fails()) {
                return Response::json(['status' => 'Validation Error occurred']);
            }
            $item_company = array(
                'company_name' => Input::get('company_name'),
                'updated_by' => Session::get('emp_id'),
                'updated_at' => $this->timestamp
            );
            $update = DB::table('companynames')
                ->where('company_id', $companyId)
                ->update($item_company);
            if ($update) {
                return Response::json(['status' => 'success']);
            }
            return Response::json(['status' => 'error']);
        } catch (\Exception $e) {
            Session::flash('mySqlError', $e->errorInfo[2]); // session set only once
            $err_msg = Lang::get("mysqlError." . $e->errorInfo[1]);
            return Response::json(['status' => $err_msg]);
        }
    }
    public function deleteItemCompany($companyId)
    {
        $CompanyItemDelete = DB::table('companynames')
            ->where('company_id', $companyId)
            ->update(array('status' => 0));
        if ($CompanyItemDelete) {
            return Response::json(['status' => 'success']);
        }
        return Response::json(['status' => 'error']);
    }
//========Item=============
    public function multipleItemAdd() {
        // return 'hi';
        $company = DB::table('sub_companies')
            ->where('status', 1)
            ->orderBy('id', 'asc')
            ->lists('company_name', 'id');

        $suppliers = array(
            '' => 'Select Supplier') + DB::table('supplierinfos')
            ->where('status', 1)
            ->orderBy('supp_id', 'asc')
            ->lists('supp_or_comp_name', 'supp_id');
        $item_company = array(
            '' => 'Select Item Company') + DB::table('companynames')
            ->where('status', 1)
            ->orderBy('company_name', 'asc')
            ->lists('company_name', 'company_id');

        $item_categorys = array(
            '' => 'Select Item Category') + DB::table('itemcategorys')
            ->where('status', 1)
            ->orderBy('category_name', 'asc')
            ->lists('category_name', 'category_id');

        $item_brands = array(
            '' => 'Select Item Brand') + DB::table('itembrands')
            ->where('status', 1)
            ->orderBy('brand_name', 'asc')
            ->lists('brand_name', 'brand_id');
        $item_locations = array(
            '' => 'Select Item Location') + DB::table('itemlocations')
            ->where('status', 1)
            ->orderBy('location_name', 'asc')
            ->lists('location_name', 'location_id');

        return View::make('admin.items.addMultipleItem', compact('suppliers','company','item_categorys', 'item_brands', 'item_locations', 'item_company'));
    }
    public function saveMultipleItem() {
        $data = Input::all();
        DB::beginTransaction();
        try {
            for($i = 0; $i < count($data['item_name']);$i++){
                if($data['category_id'] < 0){
                    return Redirect::to('admin/items')->with('errorMsg', 'Select Category Please');
                }
                $item = array(
                    'item_name' => $data['item_name'][$i],
                    'upc_code' => $data['upc_code'][$i],
                    // 'item_point' => $data['item_point'][$i],
                    'company_id' => empty($data['company_id']) ? null : $data['company_id'],
                    'supplier_id' => empty($data['supplier_id']) ? null : $data['supplier_id'],
                    'item_company_id' => empty($data['item_company_id']) ? null : $data['item_company_id'],
                    'category_id' => $data['category_id'],
                    'brand_id' => empty($data['brand_id']) ? null : $data['brand_id'],
                    'location_id' => empty($data['location_id']) ? null : $data['location_id'],
                    'tax_amount' => 0,
                    'description' => $data['item_name'][$i],
                    'created_by' => Session::get('emp_id'),
                    'created_at' => $this->timestamp
                );
                $last_item_id = DB::table('iteminfos')->insertGetId($item);
                $price_data = array(
                    'item_id' => $last_item_id,
                    'purchase_price' => 0,
                    'sale_price' => 0,
                    'created_by' => Session::get('emp_id'),
                    'created_at' => $this->timestamp
                );
                $last_price_id = DB::table('priceinfos')->insertGetId($price_data);

                $update_item = array(
                    'price_id' => $last_price_id,
                    'updated_by' => Session::get('emp_id'),
                    'updated_at' => $this->timestamp
                );
                /*
                 * If UPC not provided, item id and y-m-d will make upc code. if upc code length is
                 * less than 7 digit, 0 will be concate to fillup desire range
                 * Example itemId=25, custom_upc_code=2500000, final_upc_code=1503232500000
                 */

                if (empty($item['upc_code'])) {
                    $custom_upc_code = $last_item_id;
                    $max = 7;
                    while (strlen($custom_upc_code) < $max) {
                        $custom_upc_code .= 0;
                    }
                    $update_item['upc_code'] = $data['company_id'] . date('ymd') . $custom_upc_code;
                }
                DB::table('iteminfos')->where('item_id', $last_item_id)
                    ->update($update_item);

            }
            DB::commit();
            return Redirect::to('admin/items')->with('message', ($i).' Items Added Successfully');
        } catch (\Exception $e) {
            // return $e;
            DB::rollback();
            Session::flash('mySqlError', $e->errorInfo[2]); // session set only once
            $err_msg = Lang::get("mysqlError." . $e->errorInfo[1]);
            return Redirect::to('admin/items')->with('errorMsg', $err_msg)->withInput();
        }
    }
    public function addItemForm()
    {
        $company = array(
            '' => 'Select Company') + DB::table('sub_companies')
            ->where('status', 1)
            ->orderBy('id', 'asc')
            ->lists('company_name', 'id');

        //temp code
        // $company = DB::table('sub_companies')
        //     ->where('status', 1)
        //     ->where('id', 1)
        //     ->orderBy('id', 'asc')
        //     ->lists('company_name', 'id');
        //temp code

        $suppliers = array(
            '' => 'Select Supplier') + DB::table('supplierinfos')
            ->where('status', 1)
            ->orderBy('supp_id', 'asc')
            ->lists('supp_or_comp_name', 'supp_id');
        $item_company = array(
            '' => 'Select Item Company') + DB::table('companynames')
            ->where('status', 1)
            ->orderBy('company_name', 'asc')
            ->lists('company_name', 'company_id');
        // $item_company = DB::table('companynames')
        //     ->where('status', 1)
        //     ->where('company_id', 223)
        //     ->orderBy('company_name', 'asc')
        //     ->lists('company_name', 'company_id');
        $item_categorys = array(
            '' => 'Select Item Category') + DB::table('itemcategorys')
            ->where('status', 1)
            ->orderBy('category_name', 'asc')
            ->lists('category_name', 'category_id');
        // $item_categorys = DB::table('itemcategorys')
        //     ->where('status', 1)
        //     ->where('category_id', 46)
        //     ->orderBy('category_name', 'asc')
        //     ->lists('category_name', 'category_id');
        $item_brands = array(
            '' => 'Select Item Brand') + DB::table('itembrands')
            ->where('status', 1)
            ->orderBy('brand_name', 'asc')
            ->lists('brand_name', 'brand_id');
        $item_locations = array(
            '' => 'Select Item Location') + DB::table('itemlocations')
            ->where('status', 1)
            ->orderBy('location_name', 'asc')
            ->lists('location_name', 'location_id');
        // $item_locations = DB::table('itemlocations')
        //     ->where('status', 1)
        //     ->where('location_id', 162)
        //     ->orderBy('location_name', 'asc')
        //     ->lists('location_name', 'location_id');
        return View::make('admin.items.addItem', compact('suppliers','company','item_categorys', 'item_brands', 'item_locations', 'item_company'));
    }

    public function saveItem()
    {
        DB::beginTransaction();
        try {
            $data = Input::all();
            $validator = Validator::make($data, Itemcategory::$item_rules);
            if ($validator->fails()) {
                return Redirect::back()->withErrors($validator)->withInput();
            }
            $item = array(
                'item_name' => Input::get('item_name'),
                'upc_code' => Input::get('upc_code'),
                'company_id' => empty(Input::get('company_id')) ? null : Input::get('company_id'),
                'supplier_id' => empty(Input::get('supplier_id')) ? null : Input::get('supplier_id'),
                'item_company_id' => empty(Input::get('item_company_id')) ? null : Input::get('item_company_id'),
                'category_id' => Input::get('category_id'),
                'brand_id' => empty(Input::get('brand_id')) ? null : Input::get('brand_id'),
                'location_id' => empty(Input::get('location_id')) ? null : Input::get('location_id'),
                'unit' => Input::get('unit'),
                
                'description' => Input::get('description'),
                'created_by' => Session::get('emp_id'),
                'created_at' => $this->timestamp
            );
            $last_item_id = DB::table('iteminfos')->insertGetId($item);
            $price_data = array(
                'item_id' => $last_item_id,
                'purchase_price' => 0,
                'sale_price' => 0,
                'created_by' => Session::get('emp_id'),
                'created_at' => $this->timestamp
            );
            $last_price_id = DB::table('priceinfos')->insertGetId($price_data);

            $update_item = array(
                'price_id' => $last_price_id,
                'updated_by' => Session::get('emp_id'),
                'updated_at' => $this->timestamp
            );
            /*
             * If UPC not provided, item id and y-m-d will make upc code. if upc code length is
             * less than 7 digit, 0 will be concate to fillup desire range
             * Example itemId=25, custom_upc_code=2500000, final_upc_code=1503232500000
             */

            if (empty($item['upc_code'])) {
                $custom_upc_code = $last_item_id;
                $max = 7;
                while (strlen($custom_upc_code) < $max) {
                    $custom_upc_code .= 0;
                }
                $update_item['upc_code'] = Input::get('company_id') . date('ymd') . $custom_upc_code;
            }
            DB::table('iteminfos')->where('item_id', $last_item_id)
                ->update($update_item);

            DB::commit();
            return Redirect::to('admin/items')->with('message', 'Added Successfully');
        } catch (\Exception $e) {
            DB::rollback();
            return $e;
            Session::flash('mySqlError', $e->errorInfo[2]); // session set only once
            $err_msg = Lang::get("mysqlError." . $e->errorInfo[1]);
            return Redirect::to('admin/items')->with('errorMsg', $err_msg)->withInput();
        }
    }
    public function saveItemCustom()
    {      
        // return Session::get('branch_id');

        print "<pre>";
        $allItems = $this->custArray();
        //print_r($allItems);
        //exit;
        foreach($allItems as $value){
            $singleItem = (object) $value;
            
            DB::beginTransaction();
            try {
                $item = array(
                    'item_name' => $singleItem->article_description,
                    'upc_code' => '',
                    'article_number' => $singleItem->article_number,
                    'company_id' => 1,
                    'supplier_id' => 1,
                    'item_company_id' => 1,
                    'category_id' => 1,
                    'brand_id' => 1,
                    'location_id' => null,
                    'unit' => 1,
                    'carton' => 1,
                    'description' => null,
                    'created_by' => Session::get('emp_id'),
                    'created_at' => $this->timestamp
                );
                $last_item_id = DB::table('iteminfos')->insertGetId($item);
                $price_data = array(
                    'item_id' => $last_item_id,
                    'purchase_price' => $singleItem->purchase_price,
                    'sale_price' => $singleItem->purchase_price,
                    'created_by' => Session::get('emp_id'),
                    'created_at' => $this->timestamp
                );
                $last_price_id = DB::table('priceinfos')->insertGetId($price_data);

                $update_item = array(
                    'price_id' => $last_price_id,
                    'updated_by' => Session::get('emp_id'),
                    'updated_at' => $this->timestamp
                );
                /*
                 * If UPC not provided, item id and y-m-d will make upc code. if upc code length is
                 * less than 7 digit, 0 will be concate to fillup desire range
                 * Example itemId=25, custom_upc_code=2500000, final_upc_code=1503232500000
                 */
                if (empty($item['upc_code'])) {
                    $custom_upc_code = '';
                    $idLength = strlen($last_item_id);
                    $max = 5;
                    while (strlen($custom_upc_code) < ($max-$idLength)) {
                        $custom_upc_code .= 0;
                    }
                    $custom_upc_code .= $last_item_id;
                    $update_item['upc_code'] = date('ymd') . $custom_upc_code;
                }
                DB::table('iteminfos')->where('item_id', $last_item_id)
                    ->update($update_item);
                DB::commit();
                // return Redirect::to('admin/items')->with('message', 'Added Successfully');
            } catch (\Exception $e) {
                DB::rollback();
                return $e;
                Session::flash('mySqlError', $e->errorInfo[2]); // session set only once
                $err_msg = Lang::get("mysqlError." . $e->errorInfo[1]);
                return Redirect::to('admin/items')->with('errorMsg', $err_msg)->withInput();
            }
        }
    }
    public function getAllItem()
    {
        return Datatable::query(DB::table('iteminfos as i')
            ->select('i.item_id', 'ic.category_name', 'com.company_name', 'i.upc_code', 'i.item_name', 'p.purchase_price', 'p.price_id', 'p.sale_price', 'i.tax_amount', 'i.offer')
            ->join('itemcategorys as ic', 'ic.category_id', '=', 'i.category_id')
            ->leftJoin('companynames as com', 'com.company_id', '=', 'i.item_company_id')
            ->leftJoin('itembrands as b', 'i.brand_id', '=', 'b.brand_id')
            ->leftJoin('priceinfos as p', 'i.price_id', '=', 'p.price_id')
            ->where('i.status', '=', '1')
            ->groupBy('i.item_id'))
            ->addColumn('#', function ($model) {
                return '<input type="checkbox" name="barcodeInfo[]" value="' . $model->item_id . '-' . $model->sale_price . '">';
            })
            ->showColumns('upc_code', 'item_name', 'company_name', 'category_name', 'purchase_price', 'sale_price')
            ->addColumn('action', function ($model) {
                $html = '<div class="btn-group">';
                $html .= '<a class="btn btn-primary btn-small" href="javascript:;" data-toggle="dropdown"><i class="icon-user icon-white"></i> Action</a>';
                $html .= '<a class="btn btn-primary btn-small dropdown-toggle" data-toggle="dropdown" href="javascript:;"><span class="caret"></span></a>';
                $html .= '<ul class="dropdown-menu">';
                $html .= '<li><a onclick="ItemEdit(' . $model->item_id . ')" href="#editItemModal"  role="button" data-toggle="modal"><i class="icon-edit"></i>&nbsp; Item info Edit</a></li>';
                $html .= '<li><a onclick="itemArticleEdit(' . $model->item_id . ')" href="#editItemModal"  role="button" data-toggle="modal"><i class="icon-edit"></i>&nbsp; Articles </a></li>';
                $html .= '<li><a onclick="ItemSuppliers(' . $model->item_id . ')" href="#viewItemSuppliers"  role="button" data-toggle="modal"><i class="icon-zoom-in"></i>&nbsp; Item Suppliers</a></li>';
                if (Session::get('role') == 2) {
                    $html .= '<li><a href="#" title="Inactive" onclick="return deleteConfirm(' . $model->item_id . ')" id="' . $model->item_id . '"><i class="icon-trash"></i> Delete</a></li>';
                }

                $html .= '</ul> ';

                $html .= '</div>';
                return $html;
            })
            ->searchColumns('upc_code', 'item_name', 'company_name', 'category_name')
            ->setSearchWithAlias()
            ->orderColumns('upc_code', 'item_name', 'company_name', 'category_name', 'purchase_price', 'sale_price', 'offer')
            ->make();
    }
    public function getItemData()
    {
        return Datatable::query(DB::table('stockitems as s')
            ->select('s.stock_item_id', 'i.item_id', 'ic.category_name', 'com.company_name', 'i.upc_code', 'i.item_name', 'p.purchase_price', 'p.price_id', 'p.sale_price', 'i.tax_amount', 'i.offer', DB::raw('SUM(s.available_quantity) as available_qty'), DB::raw('count(s.item_id) as differentPrice'))
            ->leftJoin('iteminfos as i', 's.item_id', '=', 'i.item_id')
            ->leftJoin('itemcategorys as ic', 'ic.category_id', '=', 'i.category_id')
            ->leftJoin('companynames as com', 'com.company_id', '=', 'i.item_company_id')
            ->leftJoin('itembrands as b', 'i.brand_id', '=', 'b.brand_id')
            ->leftJoin('itemlocations as l', 'i.location_id', '=', 'l.location_id')
            ->leftJoin('priceinfos as p', 's.price_id', '=', 'p.price_id')
            ->where('s.status', '=', '1')
            ->groupBy('s.item_id'))
            ->addColumn('#', function ($model) {
                if ($model->differentPrice > 1) {
                    return '';
                } else {
                    return '<input type="checkbox" name="barcodeInfo[]" value="' . $model->item_id . '-' . $model->sale_price . '">';
                }
            })
            ->showColumns('upc_code', 'item_name', 'purchase_price', 'sale_price', 'category_name', 'available_qty')
            ->addColumn('action', function ($model) {
                $html = '<div class="btn-group" style="width:170px;">';
                $html .= '<a class="btn btn-primary btn-small" href="javascript:;" data-toggle="dropdown"><i class="icon-user icon-white"></i> Action</a>';
                $html .= '<a class="btn btn-primary btn-small dropdown-toggle" data-toggle="dropdown" href="javascript:;"><span class="caret"></span></a>';
                $html .= '<ul class="dropdown-menu">';
                $html .= '<li><a onclick="ItemEdit(' . $model->item_id . ')" href="#editItemModal"  role="button" data-toggle="modal"><i class="icon-edit"></i>&nbsp; Item info Edit</a></li>';
                $html .= '<li><a onclick="itemArticleEdit(' . $model->item_id . ')" href="#editItemModal"  role="button" data-toggle="modal"><i class="icon-edit"></i>&nbsp; Articles </a></li>';
                $html .= '<li><a onclick="ItemSuppliers(' . $model->item_id . ')" href="#viewItemSuppliers"  role="button" data-toggle="modal"><i class="icon-zoom-in"></i>&nbsp; Item Suppliers</a></li>';
                if (Session::get('role') == 2) {
                    $html .= '<li><a href="#" title="Inactive" onclick="return deleteConfirm(' . $model->item_id . ')" id="' . $model->item_id . '"><i class="icon-trash"></i> Delete</a></li>';
                }

                if ($model->differentPrice > 1) {

                } else {
                    $html .= '<li><a onclick="editPrice(' . $model->stock_item_id . ')" href="#editPriceModal"  role="button" data-toggle="modal"><i class="icon-edit"></i>&nbsp; Price Edit</a></li>';
                    if (Session::get('role') == 2 || Session::get('role') == 1) {
                        $html .= '<li><a onclick="editQuantity(' . $model->stock_item_id . ')" href="#editQuantityModal"  role="button" data-toggle="modal"><i class="icon-pencil"></i>&nbsp; Quantity Edit</a></li>';
                    }
                }
                $html .= '</ul> ';

                if ($model->differentPrice > 1) {
                    $html .= '<a class="btn btn-success btn-small" style="margin-left: 3px;" title="Multiple prices are here" onclick="differentPrice(' . $model->item_id . ')" href="#diffPrice"  role="button" data-toggle="modal">Diff.Price</a>';
                }
                $html .= '</div>';
                return $html;
            })
            
            ->searchColumns('upc_code', 'item_name', 'company_name', 'category_name')
            ->setSearchWithAlias()
            ->orderColumns('upc_code', 'item_name', 'company_name', 'purchase_price', 'sale_price', 'category_name', 'available_qty')
            ->make();
    }
    public function editItemForm($itemId)
    {
        $iteminfos = DB::table('iteminfos')->where('item_id', $itemId)->first();

        $company = array(
            '' => 'Select Company') + DB::table('sub_companies')
            ->where('status', 1)
            ->orderBy('id', 'asc')
            ->lists('company_name', 'id');
        $suppliers = array(
            '' => 'Select Supplier') + DB::table('supplierinfos')
            ->where('status', 1)
            ->orderBy('supp_id', 'asc')
            ->lists('supp_or_comp_name', 'supp_id');
        $item_company = array(
            '' => 'Select Item Company') + DB::table('companynames')
            ->where('status', 1)
            ->orderBy('company_name', 'asc')
            ->lists('company_name', 'company_id');
        $item_categorys = array(
            '' => 'Please Select Item Category') + DB::table('itemcategorys')
            ->where('status', 1)
            ->orderBy('category_name', 'asc')
            ->lists('category_name', 'category_id');
        $item_brands = array(
            '' => 'Select Item Brand') + DB::table('itembrands')
            ->where('status', 1)
            ->orderBy('brand_name', 'asc')
            ->lists('brand_name', 'brand_id');
        $item_locations = array(
            '' => 'Select Item Location') + DB::table('itemlocations')
            ->where('status', 1)
            ->orderBy('location_name', 'asc')
            ->lists('location_name', 'location_id');

        return View::make('admin.items.editItemModal', compact('suppliers','company','iteminfos', 'item_categorys', 'item_brands', 'item_locations', 'item_company'));
    }
//Multiple Item Add
    public function itemArticleEditForm($itemId)
    {
        // return $itemId; 
        $iteminfos = DB::table('iteminfos')->where('item_id', $itemId)->first();
        // $customerInfo = DB::table('')
        $customerInfo = array(
            '' => 'Select customer') + DB::table('customerinfos')
            ->where('status', 1)
            ->orderBy('cus_id', 'asc')
            ->lists('full_name', 'cus_id');

        $articles = DB::table('customerarticles')
                            ->where('item_id', $itemId)
                            ->get(); 

        return View::make('admin.items.editArticale', compact('iteminfos','customerInfo','itemId','articles'));
    }

    public static function methodTest()
    {
        return 'hi';
    }

    public function saveArticle(){

        $data = Input::all();
        try{
            DB::beginTransaction();
            // print_r($data);
            $articleIds = DB::table('customerarticles')
                ->where('item_id',$data['item_id'])
                ->lists('customer_article_id');
            if(isset($data['customer_article_id'])){
                $deleteArray = array_diff($articleIds,$data['customer_article_id']);
                if (count($deleteArray) > 0) {
                    $delete = DB::table('customerarticles')
                        ->whereIn('customer_article_id',$deleteArray)
                        ->delete();
                }
            }
            foreach ($data['article_name'] as $key => $value) {
                if (isset($data['customer_article_id'][$key])) {
                    $update = DB::table('customerarticles')
                        ->where('customer_article_id',$data['customer_article_id'][$key])
                        ->update([
                            'article_name' => $data['article_name'][$key],
                            'updated_by' => Session::get('emp_id')
                        ]);
                }else{
                    // return $data['article_name'][$key];
                    $insert = DB::table('customerarticles')
                        ->insert([
                            'customer_id' => $data['customer_id'][$key],
                            'item_id' => $data['item_id'],
                            'article_name' => $data['article_name'][$key],
                            'status' => 1,
                            'created_by' => Session::get('emp_id')
                        ]);
                }
            }
            DB::commit();
        }catch(\Exception $e){
            DB::rollback();
            return $e;
            Session::flash('mySqlError', $e->errorInfo[2]); // session set only once
            $err_msg = Lang::get("mysqlError." . $e->errorInfo[1]);
            if (Request::ajax()) {
                return Response::json(['status' => 'Sorry ! Duplicate Entry Found.']);
            }
        }

        return Redirect::to('admin/viewAllItem')->with('message', 'Added Successfully');

    }
    public function viewItemSuppliers($itemId)
    {
        $supplierInfos = DB::table('itempurchases as ip')
            ->select('ip.i_purchase_id', 'ip.sup_invoice_id', 'ip.item_id', 'si.supp_id', 'spi.user_name', 'spi.supp_or_comp_name', 'spi.mobile', 'spi.present_address')
            ->leftJoin('supinvoices as si', 'si.sup_invoice_id', '=', 'ip.sup_invoice_id')
            ->leftJoin('supplierinfos as spi', 'spi.supp_id', '=', 'si.supp_id')
            ->where('ip.item_id', '=', $itemId)
            ->groupBy('si.supp_id')
            ->get();

        return View::make('admin.items.viewItemSuppliers', compact('supplierInfos'));
    }
    public function itemPriceEdit($stockItemId)
    {
        //echo $stockItemId;exit;
        $itemInfo = DB::table('stockitems')
            ->select('stockitems.stock_item_id', 'i.item_id', 'i.item_name', 'p.purchase_price', 'p.sale_price')
            ->leftJoin('iteminfos as i', 'stockitems.item_id', '=', 'i.item_id')
            ->leftJoin('priceinfos as p', 'stockitems.price_id', '=', 'p.price_id')
            ->where('stockitems.stock_item_id', '=', $stockItemId)
            ->first();
        //echo'<pre>';print_r($itemInfo);exit;
        return View::make('admin.items.editPriceModal', compact('itemInfo'));
    }
    public function savePriceEdit()
    {
        //echo '<pre>'; print_r(Input::all());exit;
        try {

            $item_id = Input::get('item_id');
            $purchase_price = Input::get('purchase_price');
            $sale_price = Input::get('sale_price');
            $stock_item_id = Input::get('stock_item_id');
            //echo $item_id.'&nbsp;'.$purchase_price.'&nbsp;'.$sale_price;exit;
            $priceInfo = DB::table('priceinfos')
                ->where('priceinfos.item_id', '=', $item_id)
                ->where('priceinfos.purchase_price', '=', $purchase_price)
                ->where('priceinfos.sale_price', '=', $sale_price)
                ->first();
            if ($priceInfo) {
                $price_id = $priceInfo->price_id;

            } else {
                $insertData = array(
                    'item_id' => $item_id,
                    'purchase_price' => $purchase_price,
                    'sale_price' => $sale_price,
                    'status' => 0,
                    'created_by' => Session::get('emp_id'),
                    'created_at' => $this->timestamp
                );
                $price_id = DB::table('priceinfos')->insertGetId($insertData);
            }
            $another_stock_item_id = DB::table('stockitems')
                ->where('stockitems.stock_item_id', '!=', $stock_item_id)
                ->where('stockitems.price_id', '=', $price_id)
                ->where('stockitems.item_id', '=', $item_id)
                ->first();
            if ($another_stock_item_id) {

                $disableDuplicate = DB::table('stockitems')
                    ->where('stock_item_id', $another_stock_item_id->stock_item_id)
                    ->update(array(
                        'available_quantity' => 0,
                        'status' => 0,
                    ));
                $updateStockPriceId = DB::table('stockitems')
                    ->where('stock_item_id', '=', $stock_item_id)
                    ->increment('available_quantity', $another_stock_item_id->available_quantity,
                        array(
                            'status' => 1,
                            'updated_by' => Session::get('emp_id'),
                            'updated_at' => $this->timestamp
                        )
                    );
                //check is it same price which you are doing to update?
                $selectOldPriceId = DB::table('stockitems')
                    ->where('stockitems.stock_item_id', $stock_item_id)
                    ->where('stockitems.price_id', '=', $price_id)
                    ->where('stockitems.item_id', '=', $item_id)
                    ->count();
                if ($selectOldPriceId == 0) {
                    //if the new price info dosen't matched to the existing stockItem Id
                    $selectUpdatedQuantity = DB::table('stockitems')
                        ->where('stockitems.stock_item_id', $stock_item_id)
                        ->first();
                    $newQUantity = $selectUpdatedQuantity->available_quantity;
                    $updateStockPriceId = DB::table('stockitems')
                        ->where('stock_item_id', $another_stock_item_id->stock_item_id)
                        ->update(array(
                            'available_quantity' => $newQUantity,
                            'status' => 1
                        ));
                    $resetOldStock = DB::table('stockitems')
                        ->where('stock_item_id', $stock_item_id)
                        ->update(array(
                            'available_quantity' => 0,
                            'status' => 0
                        ));
                }
            } else {
                $updateStockPriceId = DB::table('stockitems')
                    ->where('stock_item_id', $stock_item_id)
                    ->update(array('price_id' => $price_id));
            }
            if ($updateStockPriceId) {

                if (Request::ajax()) {
                    return Response::json(['status' => 'success']);
                }
                return Redirect::to('admin/items')->with('message', 'Updated Successfully');
            } else {
                if (Request::ajax()) {
                    return Response::json(['status' => 'Sorry ! Operation failed']);
                }
                return Redirect::to('admin/items')->with('message', 'Sorry ! Operation failed');
            }
        } catch (\Exception $e) {
            return $e;
            Session::flash('mySqlError', $e->errorInfo[2]); // session set only once
            $err_msg = Lang::get("mysqlError." . $e->errorInfo[1]);
            if (Request::ajax()) {
                return Response::json(['status' => 'Sorry ! Duplicate Entry Found.']);
            }
            return;
            //return Redirect::to('admin/items')->with('errorMsg', $err_msg)->withInput();
        }
    }
    public function editItemSave()
    {
        try {
            $data = Input::all();
            $validator = Validator::make($data, Itemcategory::$item_rules);
            if ($validator->fails()) {
                return Redirect::back()->withErrors($validator)->withInput();
            }
            $item_id = Input::get('item_id');
            $item_update = array(
                'item_name' => Input::get('item_name'),
                'upc_code' => Input::get('upc_code'),
                'company_id' => empty(Input::get('company_id')) ? null : Input::get('company_id'),
                'supplier_id' => empty(Input::get('supplier_id')) ? null : Input::get('supplier_id'),
                'item_company_id' => empty(Input::get('item_company_id')) ? null : Input::get('item_company_id'),
                'category_id' => Input::get('category_id'),
                'brand_id' => empty(Input::get('brand_id')) ? null : Input::get('brand_id'),
                'location_id' => empty(Input::get('location_id')) ? null : Input::get('location_id'),
                'description' => Input::get('description'),
                'unit' => Input::get('unit'),
                'updated_by' => Session::get('emp_id'),
                'updated_at' => $this->timestamp
            );
            //return $tie
            DB::table('iteminfos')->where('item_id', $item_id)->update($item_update);

            return Redirect::back()->with('message', 'Updated Successfully');
        } catch (\Exception $e) {
            Session::flash('mySqlError', $e->errorInfo[2]); // session set only once
            $err_msg = Lang::get("mysqlError." . $e->errorInfo[1]);
            return Redirect::to('admin/items')->with('errorMsg', $err_msg)->withInput();
        }
    }
    /*
     * Item Qty Eidt 
     */
    public function itemQtyEdit($stockItemId)
    {
        //echo $stockItemId;exit;
        $itemInfo = DB::table('stockitems')
            ->select('stockitems.stock_item_id', 'stockitems.available_quantity', 'i.item_name')
            ->leftJoin('iteminfos as i', 'stockitems.item_id', '=', 'i.item_id')
            ->where('stockitems.stock_item_id', '=', $stockItemId)
            ->first();
        return View::make('admin.items.editQtyModal', compact('itemInfo'));
    }
    public function saveQtyEdit()
    {
        try {
            $available_quantity = Input::get('available_quantity');
            $stock_item_id = Input::get('stock_item_id');

            $updateStockQty = DB::table('stockitems')
                ->where('stock_item_id', $stock_item_id)
                ->update(array(
                        'available_quantity' => $available_quantity,
                        'updated_by' => Session::get('emp_id'),
                        'status' => 1,
                        'updated_at' => $this->timestamp)
                );
            if ($updateStockQty) {
                return Redirect::to('admin/items')->with('message', 'Updated Successfully');
            }
            return Redirect::to('admin/items')->with('message', 'Sorry ! Operation failed');
        } catch (\Exception $e) {
            Session::flash('mySqlError', $e->errorInfo[2]); // session set only once
            $err_msg = Lang::get("mysqlError." . $e->errorInfo[1]);
            return Redirect::to('admin/items')->with('errorMsg', $err_msg)->withInput();
        }
    }

    public function itemRemove($itemId)
    {
        $itemRev = DB::table('iteminfos')
            ->where('item_id', $itemId)
            ->update(array('status' => 0));
        if ($itemRev) {
            return Response::json(['status' => 'success']);
        }
        return Response::json(['status' => 'error']);
    }

    public function differentPricesItem($itemId)
    {
        $itemInfo = DB::table('stockitems as s')
            ->join('priceinfos as p', 's.price_id', '=', 'p.price_id')
            ->where('s.item_id', $itemId)
            ->where('s.status', '=', 1)
            ->get();
        return View::make('admin.items.multipleItemViewModal', compact('itemInfo'));
    }
    /*
     * 	Godown Item
     */
    public function godownItem()
    {
        $title = ':: POSv2 :: - Godown Item List';
        return View::make('admin.items.viewGodownItem', compact('title'));
    }
    public function getGodownItemData()
    {
        return Datatable::query(DB::table('godownitems as gdi')
            ->select('gdi.godown_item_id', 'i.upc_code', 'i.item_id', 'i.item_name', 'com.company_name', 'b.brand_name', 'l.location_name', 'p.price_id', 'p.purchase_price', 'p.sale_price', 'i.tax_amount', DB::raw('SUM(gdi.available_quantity) as available_qty'), DB::raw('count(gdi.item_id) as differentPrice'))
            ->leftJoin('iteminfos as i', 'gdi.item_id', '=', 'i.item_id')
            ->leftJoin('companynames as com', 'com.company_id', '=', 'i.item_company_id')
            ->leftJoin('itembrands as b', 'i.brand_id', '=', 'b.brand_id')
            ->leftJoin('itemlocations as l', 'i.location_id', '=', 'l.location_id')
            ->leftJoin('priceinfos as p', 'gdi.price_id', '=', 'p.price_id')
            ->where('gdi.status', '=', '1')
            ->groupBy('gdi.item_id'))
            ->addColumn('#', function ($model) {
                if ($model->differentPrice > 1) {
                    return '';
                } else {
                    return '<input type="checkbox" name="barcodeInfo[]" value="' . $model->item_id . '-' . $model->sale_price . '">';
                }
            })
            ->showColumns('upc_code', 'item_name', 'company_name', 'brand_name', 'location_name', 'purchase_price', 'sale_price', 'available_qty')
            ->addColumn('Diff.Price', function ($model) {
                if ($model->differentPrice > 1) {
                    return '<a class="btn btn-success btn-small" style="margin-left: 3px;" title="Multiple prices are here" onclick="gdDifferentPrice(' . $model->item_id . ')" href="#diffPrice"  role="button" data-toggle="modal"> Details</a>';
                }
            })
            ->addColumn('Update', function ($model) {
                $html = '<a onclick="ItemEdit(' . $model->item_id . ')" href="#editItemModal"  data-toggle="modal" class="btn btn-warning btn-xs">Item Edit</a>';
                if ($model->differentPrice > 1) {
                    $html .= '<a onclick="differentItemPriceEdit(' . $model->item_id . ')" href="#diffPrice" data-toggle="modal" class="btn btn-primary btn-xs">Price Edit</a>';
                } else {
                    $html .= '<a onclick="ItemPriceEdit(' . $model->godown_item_id . ')" href="#editItemPriceModal" data-toggle="modal" class="btn btn-primary btn-xs">Price Edit</a>';
                }
                return $html;
            })
            ->searchColumns('upc_code', 'item_name', 'company_name')
            ->setSearchWithAlias()
            ->orderColumns('upc_code', 'item_name', 'company_name', 'brand_name', 'location_name', 'purchase_price', 'sale_price', 'available_qty')
            ->make();
    }
    public function goDownDifferentPricesItem($itemId)
    {
        $itemInfos = DB::table('godownitems')
            ->join('priceinfos as p', 'godownitems.price_id', '=', 'p.price_id')
            ->where('godownitems.item_id', $itemId)
            ->where('godownitems.status', '=', 1)
            ->get();
        return View::make('admin.items.multipleGodownItemModal', compact('itemInfos'));
    }
    /*
     * Recent Add Items
     */
    public function getRecentItems()
    {
        $title = ':: POSv2 :: - View Recent Add Items';
        return View::make('admin.items.viewRecentItem', compact('title'));
    }

    public function recentItemsDatable()
    {
        return Datatable::query(DB::table('iteminfos as i')
            ->leftJoin('itembrands as b', 'i.brand_id', '=', 'b.brand_id')
            ->leftJoin('itemlocations as l', 'i.location_id', '=', 'l.location_id')
            ->leftJoin('companynames as com', 'com.company_id', '=', 'i.item_company_id')
            ->leftJoin('itemcategorys as c', 'i.category_id', '=', 'c.category_id')
            ->leftJoin('priceinfos as p', 'i.price_id', '=', 'p.price_id')
            ->select('i.item_id', 'i.upc_code', 'i.item_name', 'com.company_name', 'b.brand_name', 'c.category_name', 'l.location_name', 'i.tax_amount', 'i.offer', 'p.created_at')
            ->where('p.purchase_price', 0)
            ->where('i.status', 1))
            ->showColumns('upc_code', 'item_name', 'company_name', 'brand_name', 'category_name', 'location_name', 'tax_amount', 'offer', 'created_at')
            ->addColumn('action', function ($model) {
                $html = '<div class="span3">
								<a class="btn btn-primary btn-small" onclick="ItemEdit(' . $model->item_id . ')" href="#editItemModal"  role="button" data-toggle="modal"><i class="icon-edit"></i> Edit</a>' . ' | ' .
                    '<a class="btn btn-warning btn-small" href="javascript:;" onclick="return deleteConfirm(' . $model->item_id . ')" id="' . $model->item_id . '"><i class="icon-remove"></i> Inactive</a>
							</div>';
                return $html;
            })
            ->searchColumns('upc_code', 'item_name', 'company_name')
            ->setSearchWithAlias()
            ->orderColumns('upc_code', 'item_name', 'company_name', 'brand_name', 'category_name', 'location_name', 'tax_amount', 'offer', 'created_at')
            ->make();
    }
    public function godownLowInventory()
    {
        return View::make('admin.items.viewGodownInventory');
    }
    public function getGLInventory()
    {
        return Datatable::query(DB::table('godownitems as g')
            ->select('g.godown_item_id', 'i.item_id', 'i.upc_code', 'com.company_name', 'i.item_name', 'p.purchase_price', 'p.sale_price', 'i.tax_amount', 'i.offer', DB::raw('SUM(g.available_quantity) as available_qty'))
            ->leftJoin('iteminfos as i', 'g.item_id', '=', 'i.item_id')
            ->leftJoin('companynames as com', 'com.company_id', '=', 'i.item_company_id')
            ->leftJoin('itembrands as b', 'i.brand_id', '=', 'b.brand_id')
            ->leftJoin('itemlocations as l', 'i.location_id', '=', 'l.location_id')
            ->leftJoin('priceinfos as p', 'g.price_id', '=', 'p.price_id')
            ->where('i.status', '=', '1')
            ->groupBy('g.item_id')
        //->having(DB::raw('sum(g.available_quantity)'), '<', 51)
        )
            ->addColumn('#', function ($model) {

                return '<input type="checkbox" name="barcodeInfo[]" value="' . $model->item_id . '-' . $model->sale_price . '">';

            })
            ->showColumns('upc_code', 'item_name', 'company_name', 'purchase_price', 'sale_price', 'offer', 'available_qty')
            ->searchColumns('upc_code', 'item_name', 'company_name')
            ->setSearchWithAlias()
            ->orderColumns('upc_code', 'item_name', 'company_name', 'purchase_price', 'sale_price', 'offer', 'available_qty')
            ->make();
    }
    public function stockLowInventory()
    {
        return View::make('admin.items.viewStockInventory');
    }
    public function getSLInventory()
    {
        return Datatable::query(DB::table('stockitems as s')
            ->select('s.stock_item_id', 'i.item_id', 'i.upc_code', 'com.company_name', 'i.item_name', 'p.purchase_price', 'p.sale_price', 'i.tax_amount', 'i.offer', DB::raw('SUM(s.available_quantity) as available_qty'))
            ->leftJoin('iteminfos as i', 's.item_id', '=', 'i.item_id')
            ->leftJoin('companynames as com', 'com.company_id', '=', 'i.item_company_id')
            ->leftJoin('itembrands as b', 'i.brand_id', '=', 'b.brand_id')
            ->leftJoin('itemlocations as l', 'i.location_id', '=', 'l.location_id')
            ->leftJoin('priceinfos as p', 's.price_id', '=', 'p.price_id')
            ->where('i.status', '=', '1')
            ->groupBy('s.item_id')
            ->having(DB::raw('sum(s.available_quantity)'), '<', 10)
        )
            ->addColumn('#', function ($model) {

            })
            ->showColumns('upc_code', 'item_name', 'company_name', 'purchase_price', 'sale_price', 'offer', 'available_qty')
            ->searchColumns('item_name', 'company_name', 'upc_code')
            ->setSearchWithAlias()
            ->orderColumns('upc_code', 'item_name', 'company_name', 'purchase_price', 'sale_price', 'offer', 'available_qty')
            ->make();
    }
    public function barcodeQueueAll()
    {
        $barcodeInfo = Input::get('barcodeInfo');
        //Session::forget('BarcodeQueueItems');
        //return Redirect::back();
        // echo'<pre>';print_r(Session::get('BarcodeQueueItems'));exit;

        if (empty($barcodeInfo)) {
            return Redirect::to('admin/items')->with('errorMsg', 'Please at least select one item!');
        }
        foreach ($barcodeInfo as $iteminfo) {
            $temp = "BarcodeQueueItems." . $iteminfo;
            // echo $temp;exit;
            Session::put("$temp", $iteminfo);

        }
        return Redirect::back()->with('message', 'Item added to barcode Queue');
    }
    public function generateBarcode()
    {
        $BarcodeQueueItems = Session::get('BarcodeQueueItems');

        if (empty($BarcodeQueueItems)) {
            $err_msg = "Please at first Item add to the Queue!";
            return Redirect::back()->with('errorMsg', $err_msg);
        } else {

            $itemBarcodeInfos = array();

            if (isset($BarcodeQueueItems)) {

                foreach ($BarcodeQueueItems as $item) {
                    $datas = array();
                    if (is_array($item) && count($item) > 0) {
                        $itemData = explode("-", $item['00']);
                        $datas['key'] = $item['00'];

                    } else {
                        $itemData = explode("-", $item);
                        $datas['key'] = $item;
                    }
                    //echo $itemData[0];   it is item id
                    $itemInfo = DB::table('iteminfos')
                        ->where('item_id', $itemData[0])
                        ->first();

                    $datas['upc_code'] = $itemInfo->upc_code;
                    $datas['item_name'] = $itemInfo->item_name;
                    $datas['sale_price'] = $itemData[1];
                    if (isset($itemInfo->available_quantity)) {
                        $datas['available_quantity'] = $itemInfo->available_quantity;
                    }else{
                        $datas['available_quantity'] = 1;
                    }
                    array_push($itemBarcodeInfos, $datas);
                }
                //echo'<pre>';print_r($itemBarcodeInfos);exit;
            }
            return View::make('admin.items.barcodeGenerator', compact('itemBarcodeInfos'));
        }
    }


    public function barcodePrint()
    {
        $barcode_quantity = Input::get('barcode_quantity');
        $itemInfo = Input::get('itemInfo');

        return View::make('admin.items.barcodePrint', compact('itemInfo', 'barcode_quantity'));
    }


    public function barcodeQueueEmpty()
    {

        Session::forget('BarcodeQueueItems');
        return Redirect::back('admin/items')->with('message', 'The Queue is empty now!');

    }

    public function barcodeQueueItemDelete($key)
    {
        Session::forget("BarcodeQueueItems.$key");
        return Redirect::back()->with('message', 'The item is deleted form Queue.');

    }

    public function itemGodownPriceEdit($godownItemId)
    {
        //echo $stockItemId;exit;
        $itemInfo = DB::table('godownitems')
            ->select('godownitems.godown_item_id', 'i.item_id', 'i.item_name', 'p.purchase_price', 'p.sale_price', 'p.price_id')
            ->leftJoin('iteminfos as i', 'godownitems.item_id', '=', 'i.item_id')
            ->leftJoin('priceinfos as p', 'godownitems.price_id', '=', 'p.price_id')
            ->where('godownitems.godown_item_id', '=', $godownItemId)
            ->first();
        //return $itemInfo;
        //echo'<pre>';print_r($itemInfo);exit;
        return View::make('admin.items.editGodownItemPriceModal', compact('itemInfo'));
    }

    public function itemGodownPriceEditSave()
    {

        $price_id = Input::get('price_id');
        $item_id = Input::get('item_id');
        $purchase_price = Input::get('purchase_price');
        $ex_purchase_price = Input::get('ex_purchase_price');
        $sale_price = Input::get('sale_price');

        $itemInfo = DB::table('itempurchases')
            ->select('itempurchases.*')
            ->where('itempurchases.item_id', '=', $item_id)
            ->where('itempurchases.price_id', '=', $price_id)
            ->get();
        foreach ($itemInfo as $purchaseItemInfo) {
            //multiple invoice found

            $sup_invoice_id = $purchaseItemInfo->sup_invoice_id;
            //check if multiple product purchase by one invoice_id

            $sup_invoice_info = DB::table('supinvoices')
                ->where('supinvoices.sup_invoice_id', '=', $sup_invoice_id)
                ->first();

            $selectItemPurchase = DB::table('itempurchases')
                ->where('itempurchases.sup_invoice_id', '=', $sup_invoice_id)
                ->where('itempurchases.item_id', '=', $item_id)
                ->where('itempurchases.price_id', '=', $price_id)
                ->first();
            $quantity = $selectItemPurchase->quantity;
            $i_purchase_id = $selectItemPurchase->i_purchase_id;
            $ex_amount = $sup_invoice_info->amount;

            $resetAmount = $ex_amount - ($ex_purchase_price * $quantity);
            $newAmount = $resetAmount + ($purchase_price * $quantity);
            DB::table('supinvoices')
                ->where('sup_invoice_id', $sup_invoice_id)
                ->update(array(
                    'amount' => $newAmount,
                    'pay' => $newAmount
                ));


            DB::table('itempurchases')
                ->where('i_purchase_id', $i_purchase_id)
                ->update(array(
                    'amount' => ($purchase_price * $quantity)
                ));


            DB::table('priceinfos')
                ->where('price_id', $price_id)
                ->update(array(
                    'purchase_price' => $purchase_price,
                    'sale_price' => $sale_price,
                    'updated_at' => date('Y-m-d h:i:s')
                ));
        }

        return Redirect::back()->with('message', 'Updated Successfully');

    }

    public function selectDifferentPriceItemFromGodown($itemId)
    {
        $itemInfos = DB::table('godownitems')
            ->join('priceinfos as p', 'godownitems.price_id', '=', 'p.price_id')
            ->where('godownitems.item_id', $itemId)
            ->where('godownitems.status', '=', 1)
            ->get();
        return View::make('admin.items.editGodownDifferentPrice', compact('itemInfos'));
    }

    public function udpateDifferentPriceItemToGodown()
    {
        echo "<pre>";
        $flag = 0;
        for ($j = 0; $j < sizeof(Input::get('purchase_price')); $j++) {
            $price_id = Input::get("price_id$j");
            if (isset($price_id)) {
                ++$flag;
            }
        }
        if ($flag > 1) {
            return "Multiple Checked. Please check only one.";
        }

        for ($i = 0; $i < sizeof(Input::get('purchase_price')); $i++) {
            if (Input::get("price_id$i")) {
                $price_id = Input::get("price_id$i");
                $purchase_price = Input::get('purchase_price')[$i];
                $sale_price = Input::get('sale_price')[$i];
            }

        }
        $total_quantity = Input::get('total_quantity');


        $item_id = Input::get('item_id');

        $purchaseItemInfo = DB::table('itempurchases')
            ->select('itempurchases.*', 'p.sale_price', 'p.purchase_price', 'si.amount as invoice_amount')
            ->join('priceinfos as p', 'itempurchases.price_id', '=', 'p.price_id')
            ->join('supinvoices as si', 'itempurchases.sup_invoice_id', '=', 'si.sup_invoice_id')
            ->where('itempurchases.item_id', '=', $item_id)
            //->where('itempurchases.price_id', '=', $price_id)
            ->get();
        //print_r($purchaseItemInfo);
//                exit;
        $totalRows = sizeof($purchaseItemInfo);
        $i = 1;
        foreach ($purchaseItemInfo as $eachItem) {
            $i_purchase_id = $eachItem->i_purchase_id;
            $sup_invoice_id = $eachItem->sup_invoice_id;
            $ex_amount = ($eachItem->quantity * $eachItem->purchase_price);
            $new_amount = ($total_quantity * $purchase_price); //new amount of all quantity
            $resetAmount = ($eachItem->invoice_amount - $ex_amount);

            DB::table('supinvoices')
                ->where('supinvoices.sup_invoice_id', $sup_invoice_id)
                ->update(array(
                    'amount' => $resetAmount,
                    'pay' => $resetAmount
                ));

            if ($i == $totalRows) {
                DB::table('itempurchases')
                    ->where('itempurchases.i_purchase_id', $i_purchase_id)
                    ->update(array(
                        'quantity' => $total_quantity,
                        'amount' => $new_amount
                    ));
                DB::table('itempurchases')
                    ->where('itempurchases.i_purchase_id', '!=', $i_purchase_id)
                    ->where('itempurchases.item_id', $item_id)
                    ->delete();
                DB::table('godownitems')
                    ->where('godownitems.price_id', $price_id)
                    ->where('godownitems.item_id', $item_id)
                    ->update(array(
                        'available_quantity' => $total_quantity
                    ));
                DB::table('godownitems')
                    ->where('godownitems.price_id', '!=', $price_id)
                    ->where('godownitems.item_id', $item_id)
                    ->delete();
                DB::table('supinvoices')
                    ->where('supinvoices.sup_invoice_id', $sup_invoice_id)
                    ->update(array(
                        'amount' => ($resetAmount + $new_amount),
                        'pay' => ($resetAmount + $new_amount)
                    ));
                DB::table('priceinfos')
                    ->where('priceinfos.price_id', $price_id)
                    ->update(array(
                        'purchase_price' => $purchase_price,
                        'sale_price' => $sale_price,
                        'status' => 1
                    ));
                DB::table('priceinfos')
                    ->where('priceinfos.price_id', '!=', $price_id)
                    ->where('priceinfos.item_id', $item_id)
                    ->update(array(
                        'status' => 0
                    ));

            }
            $i++;
        }

        return;
    }

    public function deleteGodownProduct()
    {
        echo "<pre>";
        $input['from'] = '2015-12-01';
        $input['to'] = '2016-01-20';

        $supInvoiceInfo = DB::table('supinvoices')
            ->whereBetween('supinvoices.transaction_date', array($input['from'], $input['to']))
            //->where('itempurchases.quantity', '>', 1)
            //->limit(20)
            ->get();
        print_r($supInvoiceInfo);
        foreach ($supInvoiceInfo as $eachInvoice) {
            $sup_invoice_id = $eachInvoice->sup_invoice_id;

            $purchaseItemInfo = DB::table('itempurchases')
                ->select('itempurchases.*', 'p.sale_price', 'p.purchase_price', 'si.amount as invoice_amount')
                ->join('priceinfos as p', 'itempurchases.price_id', '=', 'p.price_id')
                ->join('supinvoices as si', 'itempurchases.sup_invoice_id', '=', 'si.sup_invoice_id')
                ->whereBetween('itempurchases.created_at', array($input['from'], $input['to']))
                ->where('itempurchases.sup_invoice_id', '=', $sup_invoice_id)
                //->limit(2)
                ->get();

            foreach ($purchaseItemInfo as $eachPurchaseItem) {

                $item_id = $eachPurchaseItem->item_id;

                $price_id = $eachPurchaseItem->price_id;
                $item_quantity = round($eachPurchaseItem->quantity, 2);

                $eachGodownItem = DB::table('godownitems')
                    ->where('godownitems.item_id', $item_id)
                    ->where('godownitems.price_id', $price_id)
                    ->first();

                $exGodownQuantity = $eachGodownItem->available_quantity;
                $godown_item_id = $eachGodownItem->godown_item_id;
                $newGodownQuantity = ($exGodownQuantity - $item_quantity);
                $status = ($newGodownQuantity < 1) ? 0 : 1;
                DB::table('godownitems')
                    ->where('godownitems.godown_item_id', $godown_item_id)
                    ->update(array(
                        'available_quantity' => $newGodownQuantity,
                        'status' => $status,
                        'updated_at' => date('Y-md-d h:i:s')
                    ));


            } //end of item foreach
            DB::table('itempurchases')
                ->where('itempurchases.sup_invoice_id', $sup_invoice_id)
                ->delete();
            DB::table('supinvoices')
                ->where('supinvoices.sup_invoice_id', $sup_invoice_id)
                ->delete();

        }

        /*
            step1:
                delete from purchaseinfos according to i_purchase_id
                and fetch quantity , amount , sup_invoice_id , item_id ,price_id
            step2: update supinvoices according to sup_invoice_id. which dicrese total amount and pay
            setp3: at first check godowniteminfos by item_id and price_id
                   then  decrese available quantity from godowninfos table.
                   if quantity is 0 then status=0

        */

    }

    public function GetItemSupplier($name){
        $supplier = DB::table('supplierinfos')
            ->select([
                'supplierinfos.supp_id'
            ])
            ->where('supplierinfos.supp_or_comp_name',$name)
            ->first();
            if(count($supplier)>0){
                return $supplier->supp_id;
            }else{
                return '';
            }
    }
    public function GetItemCompany($name){
        $supplier = DB::table('companynames')
            ->select([
                'companynames.company_id'
            ])
            ->where('companynames.company_name',$name)
            ->first();
            if(count($supplier)>0){
                return $supplier->company_id;
            }else{
                return '';
            }
    }
    public function GetItemCategory($name){
        $supplier = DB::table('itemcategorys')
            ->select([
                'itemcategorys.category_id'
            ])
            ->where('itemcategorys.category_name',$name)
            ->first();
            if(count($supplier)>0){
                return $supplier->category_id;
            }else{
                return '';
            }
    }
    public function GetItemBrand($name){
        $supplier = DB::table('itembrands')
            ->select([
                'itembrands.brand_id'
            ])
            ->where('itembrands.brand_name',$name)
            ->first();
            if(count($supplier)>0){
                return $supplier->brand_id;
            }else{
                return '';
            }
    }
    public function addSupplier(){
        // return 'test';
        $items = $this->custArray();
        print "<pre>";
        // print_r($items);
        // exit;
            DB::beginTransaction();
        foreach($items as $key => $value){
            try {
                echo $this->GetItemCategory($value['Item_Category']).'==>';
                $item = array(
                    'item_name' => $value['Item_Name'],
                    'upc_code' => '',
                    'company_id' => 1,
                    'supplier_id' => $this->GetItemSupplier($value['Supplier_Name']),
                    'item_company_id' => $this->GetItemCompany($value['Item_Company']),
                    'category_id' => $this->GetItemCategory($value['Item_Category']),
                    'brand_id' => $this->GetItemBrand($value['Brand_Name']),
                    'unit' => 'PCS',
                    
                    'description' => '',
                    'created_by' => Session::get('emp_id'),
                    'created_at' => $this->timestamp
                );
                $last_item_id = DB::table('iteminfos')->insertGetId($item);
                $price_data = array(
                    'item_id' => $last_item_id,
                    'purchase_price' => 0,
                    'sale_price' => 0,
                    'created_by' => Session::get('emp_id'),
                    'created_at' => $this->timestamp
                );
                $last_price_id = DB::table('priceinfos')->insertGetId($price_data);

                $update_item = array(
                    'price_id' => $last_price_id,
                    'updated_by' => Session::get('emp_id'),
                    'updated_at' => $this->timestamp
                );
                if (empty($item['upc_code'])) {
                    $custom_upc_code = $last_item_id;
                    $max = 7;
                    while (strlen($custom_upc_code) < $max) {
                        $custom_upc_code .= 0;
                    }
                    $update_item['upc_code'] = '1'. date('ymd') . $custom_upc_code;
                }
                DB::table('iteminfos')->where('item_id', $last_item_id)
                    ->update($update_item);
                echo $key.'===>'.$value['Item_Name'].'<br>';
                // return Redirect::to('admin/items')->with('message', 'Added Successfully');
            } catch (\Exception $e) {
                DB::rollback();
                return $e;
                Session::flash('mySqlError', $e->errorInfo[2]); // session set only once
                $err_msg = Lang::get("mysqlError." . $e->errorInfo[1]);
                // return Redirect::to('admin/items')->with('errorMsg', $err_msg)->withInput();
            }      
        }
        DB::commit();
        return 'success';
    }
    
    public function putStockItem()
    {
        $items = $this->custArray();
        // print "<pre>";
        // print_r($items);
        // return;
        foreach($items as $key => $value){
            if($value['purchase_price'] > 0){
                $item_id = $value['sl_no'];
                $data=DB::table('iteminfos')
                    ->leftjoin('priceinfos', 'priceinfos.price_id', '=', 'iteminfos.price_id')
                    ->select('iteminfos.item_id', 'iteminfos.item_name', 'priceinfos.price_id', 'priceinfos.purchase_price', 'priceinfos.sale_price')
                    ->where('priceinfos.status', '=', 1)
                    ->where('iteminfos.item_id', '=', $item_id)
                    //->orWhere('iteminfos.upc_code', '=', $item_id)
                    ->first();
                //echo'<pre>';print_r($data);exit;
                if(!$data){
                    // return $value['UPC_Code'];
                    return Redirect::to('purchase/purchases')->with('errorMsg', "This product are not available in the item list");
                }
                $item_info=array();
                $item_info['item_id']=$data->item_id;
                $item_info['item_name']=$data->item_name;
                $item_info['price_id']=$data->price_id;
                $item_info['purchase_price']=$value['purchase_price'];
                $item_info['sale_price']=$value['sale_price'];
                
                $item_info['quantity']=($value['qty'] > 0) ? $value['qty'] : 1;
                $item_info['discount']=0;
                $item_info['discount']=round($item_info['discount'],2);
                $item_info['total']=($item_info['purchase_price']*$item_info['quantity'])-$item_info['discount'];

                $item_id=$data->item_id;
                if(Session::get("items.$item_id")){
                    $item_info['quantity']=Session::get("items.$item_id.quantity")+1;
                    $item_info['purchase_price']=Session::get("items.$item_id.purchase_price");
                    $item_info['sale_price']=Session::get("items.$item_id.sale_price");
                    $item_info['discount']=Session::get("items.$item_id.discount");
                    $item_info['discount']=round($item_info['discount'],2);
                    $item_info['total']=(Session::get("items.$item_id.purchase_price")*$item_info['quantity'])-$item_info['discount'];
                }
                $item_info['total']=round($item_info['total'],2);
                Session::put("items.$item_id", $item_info);
            }
        }
    }

    public function stockItemArray()
    {
        return array(
    0 => array('SL No.' => '1', 'UPC_Code' => '11804157640000', 'Item_Name' => 'Aerosol-350ml', 'p_p' => '0', 'qty' => '0'),
    1 => array('SL No.' => '2', 'UPC_Code' => '11804157650000', 'Item_Name' => 'Aerosol-475ml', 'p_p' => '198', 'qty' => '22'),
    2 => array('SL No.' => '3', 'UPC_Code' => '11804157660000', 'Item_Name' => 'Aerosol-750ml', 'p_p' => '0', 'qty' => '0'),
    3 => array('SL No.' => '4', 'UPC_Code' => '11804157670000', 'Item_Name' => 'Air Freshner -300ml', 'p_p' => '142', 'qty' => '0'),
    4 => array('SL No.' => '5', 'UPC_Code' => '11804157680000', 'Item_Name' => 'Air Freshner-300ml', 'p_p' => '170', 'qty' => '11'),
    5 => array('SL No.' => '6', 'UPC_Code' => '11804157690000', 'Item_Name' => 'Air Freshner-300ml(02)', 'p_p' => '158', 'qty' => '0'),
    6 => array('SL No.' => '7', 'UPC_Code' => '11804157700000', 'Item_Name' => 'Airfreshner-325ml', 'p_p' => '155', 'qty' => '2'),
    7 => array('SL No.' => '8', 'UPC_Code' => '11804228600000', 'Item_Name' => 'Almonds (Kathbadam) - 100gm', 'p_p' => '85', 'qty' => '0'),
    8 => array('SL No.' => '9', 'UPC_Code' => '11804228610000', 'Item_Name' => 'Almonds (Kathbadam) - 250gm', 'p_p' => '212', 'qty' => '0'),
    9 => array('SL No.' => '10', 'UPC_Code' => '11804229470000', 'Item_Name' => 'Anti Cutter Deli', 'p_p' => '0', 'qty' => '0'),
    10 => array('SL No.' => '11', 'UPC_Code' => '11804229460000', 'Item_Name' => 'Anti Cutter Deli - Small', 'p_p' => '17.33', 'qty' => '6'),
    11 => array('SL No.' => '12', 'UPC_Code' => '11804229480000', 'Item_Name' => 'Anti Cutter SDI', 'p_p' => '24', 'qty' => '11'),
    12 => array('SL No.' => '13', 'UPC_Code' => '11804229490000', 'Item_Name' => 'Anti Cutter SDI Blade 9MM', 'p_p' => '7.22', 'qty' => '8'),
    13 => array('SL No.' => '14', 'UPC_Code' => '11804228620000', 'Item_Name' => 'Apple (Green)', 'p_p' => '0', 'qty' => '0'),
    14 => array('SL No.' => '15', 'UPC_Code' => '11804228630000', 'Item_Name' => 'Apple (Red)', 'p_p' => '0', 'qty' => '0'),
    15 => array('SL No.' => '16', 'UPC_Code' => '11807059840000', 'Item_Name' => 'Ball Pen Linc Glycer (Red)', 'p_p' => '7.88', 'qty' => '11'),
    16 => array('SL No.' => '17', 'UPC_Code' => '11807059850000', 'Item_Name' => 'Ball Pen Linc Glycer (Green)', 'p_p' => '7.8', 'qty' => '12'),
    17 => array('SL No.' => '18', 'UPC_Code' => '11807059860000', 'Item_Name' => 'Ball Pen Linc Glycer (Blue)', 'p_p' => '7.8', 'qty' => '11'),
    18 => array('SL No.' => '19', 'UPC_Code' => '11804229530000', 'Item_Name' => 'Ball Pen Linc Glycer (Black)', 'p_p' => '7.16', 'qty' => '6'),
    19 => array('SL No.' => '20', 'UPC_Code' => '11804229520000', 'Item_Name' => 'Ball Pen Matador All Time', 'p_p' => '4.27', 'qty' => '96'),
    20 => array('SL No.' => '21', 'UPC_Code' => '11804229500000', 'Item_Name' => 'Ball Pen Matador Orbit', 'p_p' => '0', 'qty' => '0'),
    21 => array('SL No.' => '22', 'UPC_Code' => '11804229510000', 'Item_Name' => 'Ball Pen Matador Pin Point', 'p_p' => '0', 'qty' => '0'),
    22 => array('SL No.' => '23', 'UPC_Code' => '11804229540000', 'Item_Name' => 'Battery Pencil - AA - Sony', 'p_p' => '8.65', 'qty' => '50'),
    23 => array('SL No.' => '24', 'UPC_Code' => '11804229570000', 'Item_Name' => 'Battery Pencil - AA - Sun Light', 'p_p' => '13', 'qty' => '30'),
    24 => array('SL No.' => '25', 'UPC_Code' => '11804229550000', 'Item_Name' => 'Battery Remote - AAA - Sony', 'p_p' => '11.5', 'qty' => '60'),
    25 => array('SL No.' => '26', 'UPC_Code' => '11804229560000', 'Item_Name' => 'Battery Remote - AAA - Sony Alkaline', 'p_p' => '0', 'qty' => '0'),
    26 => array('SL No.' => '27', 'UPC_Code' => '11804229580000', 'Item_Name' => 'Battery Remote - AAA - Sun Light', 'p_p' => '9.5', 'qty' => '30'),
    27 => array('SL No.' => '28', 'UPC_Code' => '11804157710000', 'Item_Name' => 'Baygon', 'p_p' => '295', 'qty' => '0'),
    28 => array('SL No.' => '29', 'UPC_Code' => '11804228640000', 'Item_Name' => 'Beef', 'p_p' => '0', 'qty' => '0'),
    29 => array('SL No.' => '30', 'UPC_Code' => '11804228650000', 'Item_Name' => 'Bin Bag (24x38) - Black', 'p_p' => '80', 'qty' => '0'),
    30 => array('SL No.' => '31', 'UPC_Code' => '11804228660000', 'Item_Name' => 'Bin Bag (28x52) - Black', 'p_p' => '80', 'qty' => '0'),
    31 => array('SL No.' => '32', 'UPC_Code' => '11804229600000', 'Item_Name' => 'Binder Clip 1" Inch - 12Pcs', 'p_p' => '20.84', 'qty' => '33'),
    32 => array('SL No.' => '33', 'UPC_Code' => '11804229610000', 'Item_Name' => 'Binder Clip 2" Inch - 12Pcs', 'p_p' => '60', 'qty' => '17'),
    33 => array('SL No.' => '34', 'UPC_Code' => '11804229590000', 'Item_Name' => 'Binder Clip 3/4" Inch - 12Pcs', 'p_p' => '17', 'qty' => '35'),
    34 => array('SL No.' => '35', 'UPC_Code' => '11804228670000', 'Item_Name' => 'Bitter Gourd', 'p_p' => '0', 'qty' => '0'),
    35 => array('SL No.' => '36', 'UPC_Code' => '11804229650000', 'Item_Name' => 'Board Marker Doller', 'p_p' => '0', 'qty' => '0'),
    36 => array('SL No.' => '37', 'UPC_Code' => '11804229640000', 'Item_Name' => 'Board Marker Red Leaf', 'p_p' => '0', 'qty' => '0'),
    37 => array('SL No.' => '38', 'UPC_Code' => '11807059870000', 'Item_Name' => 'Board Pin Plastic Box Big', 'p_p' => '37', 'qty' => '1'),
    38 => array('SL No.' => '39', 'UPC_Code' => '11804229660000', 'Item_Name' => 'Board Pin Plastic Box', 'p_p' => '14', 'qty' => '3'),
    39 => array('SL No.' => '40', 'UPC_Code' => '11804228680000', 'Item_Name' => 'Bottle Gourd', 'p_p' => '0', 'qty' => '0'),
    40 => array('SL No.' => '41', 'UPC_Code' => '11804229680000', 'Item_Name' => 'Box File Deli', 'p_p' => '0', 'qty' => '0'),
    41 => array('SL No.' => '42', 'UPC_Code' => '11804229670000', 'Item_Name' => 'Box File Paper', 'p_p' => '0', 'qty' => '0'),
    42 => array('SL No.' => '43', 'UPC_Code' => '11804228690000', 'Item_Name' => 'Bread (Diabetic)', 'p_p' => '0', 'qty' => '0'),
    43 => array('SL No.' => '44', 'UPC_Code' => '11804228700000', 'Item_Name' => 'Brinjal - Round', 'p_p' => '0', 'qty' => '0'),
    44 => array('SL No.' => '45', 'UPC_Code' => '11804228710000', 'Item_Name' => 'Brinjal - Stick', 'p_p' => '0', 'qty' => '0'),
    45 => array('SL No.' => '46', 'UPC_Code' => '11804228720000', 'Item_Name' => 'Brocoli', 'p_p' => '0', 'qty' => '0'),
    46 => array('SL No.' => '47', 'UPC_Code' => '11804228730000', 'Item_Name' => 'Butter - 100gm', 'p_p' => '0', 'qty' => '0'),
    47 => array('SL No.' => '48', 'UPC_Code' => '11804228740000', 'Item_Name' => 'Butter - 200gm', 'p_p' => '165', 'qty' => '0'),
    48 => array('SL No.' => '49', 'UPC_Code' => '11804228750000', 'Item_Name' => 'Cabbage', 'p_p' => '0', 'qty' => '0'),
    49 => array('SL No.' => '50', 'UPC_Code' => '11804157720000', 'Item_Name' => 'Canderal -300 Tablet', 'p_p' => '249', 'qty' => '28'),
    50 => array('SL No.' => '51', 'UPC_Code' => '11804157730000', 'Item_Name' => 'Canderal -75gm', 'p_p' => '220', 'qty' => '5'),
    51 => array('SL No.' => '52', 'UPC_Code' => '11804228760000', 'Item_Name' => 'Capcicum - Green', 'p_p' => '0', 'qty' => '0'),
    52 => array('SL No.' => '53', 'UPC_Code' => '11804228770000', 'Item_Name' => 'Capcicum - Red', 'p_p' => '0', 'qty' => '0'),
    53 => array('SL No.' => '54', 'UPC_Code' => '11804228780000', 'Item_Name' => 'Capcicum - Yellow', 'p_p' => '0', 'qty' => '0'),
    54 => array('SL No.' => '55', 'UPC_Code' => '11804229760000', 'Item_Name' => 'Carbon Paper Kores Both Sided', 'p_p' => '235', 'qty' => '7'),
    55 => array('SL No.' => '56', 'UPC_Code' => '11804228790000', 'Item_Name' => 'Carrot - 1kg', 'p_p' => '0', 'qty' => '0'),
    56 => array('SL No.' => '57', 'UPC_Code' => '11804228800000', 'Item_Name' => 'Cat Litter', 'p_p' => '500', 'qty' => '0'),
    57 => array('SL No.' => '58', 'UPC_Code' => '11804228810000', 'Item_Name' => 'Cauliflower', 'p_p' => '0', 'qty' => '0'),
    58 => array('SL No.' => '59', 'UPC_Code' => '11804229710000', 'Item_Name' => 'CD Marker Twin Marker - Both Side', 'p_p' => '16', 'qty' => '21'),
    59 => array('SL No.' => '60', 'UPC_Code' => '11804229700000', 'Item_Name' => 'CD Melody', 'p_p' => '11.5', 'qty' => '50'),
    60 => array('SL No.' => '61', 'UPC_Code' => '11804229690000', 'Item_Name' => 'CD YDD', 'p_p' => '9.5', 'qty' => '50'),
    61 => array('SL No.' => '62', 'UPC_Code' => '11804228820000', 'Item_Name' => 'Chicken(Boiler)', 'p_p' => '0', 'qty' => '0'),
    62 => array('SL No.' => '63', 'UPC_Code' => '11804228830000', 'Item_Name' => 'Chicken(Local)', 'p_p' => '0', 'qty' => '0'),
    63 => array('SL No.' => '64', 'UPC_Code' => '11804157740000', 'Item_Name' => 'Clorox - 200ml', 'p_p' => '200', 'qty' => '2'),
    64 => array('SL No.' => '65', 'UPC_Code' => '11804157750000', 'Item_Name' => 'Coconut Broom', 'p_p' => '20', 'qty' => '6'),
    65 => array('SL No.' => '66', 'UPC_Code' => '11804157760000', 'Item_Name' => 'Coffe Mate', 'p_p' => '210', 'qty' => '8'),
    66 => array('SL No.' => '67', 'UPC_Code' => '11804157770000', 'Item_Name' => 'Coil Mortein', 'p_p' => '0', 'qty' => '0'),
    67 => array('SL No.' => '68', 'UPC_Code' => '11804157790000', 'Item_Name' => 'Coil Supreme', 'p_p' => '60', 'qty' => '2'),
    68 => array('SL No.' => '69', 'UPC_Code' => '11804157780000', 'Item_Name' => 'Coil Tulshi', 'p_p' => '45', 'qty' => '37'),
    69 => array('SL No.' => '70', 'UPC_Code' => '11804229750000', 'Item_Name' => 'Color Pencil Favor Castel - Big', 'p_p' => '0', 'qty' => '0'),
    70 => array('SL No.' => '71', 'UPC_Code' => '11804157800000', 'Item_Name' => 'Condenced Milk', 'p_p' => '43', 'qty' => '0'),
    71 => array('SL No.' => '72', 'UPC_Code' => '11804157810000', 'Item_Name' => 'Condenced Milk (02)', 'p_p' => '0', 'qty' => '0'),
    72 => array('SL No.' => '73', 'UPC_Code' => '11804228840000', 'Item_Name' => 'Coriendar Leaf', 'p_p' => '0', 'qty' => '0'),
    73 => array('SL No.' => '74', 'UPC_Code' => '11804229770000', 'Item_Name' => 'Correction Pen Huajie', 'p_p' => '18.34', 'qty' => '6'),
    74 => array('SL No.' => '75', 'UPC_Code' => '11804228850000', 'Item_Name' => 'Cucumber', 'p_p' => '0', 'qty' => '0'),
    75 => array('SL No.' => '76', 'UPC_Code' => '11804157820000', 'Item_Name' => 'Dettol - 180 ml Refill', 'p_p' => '0', 'qty' => '0'),
    76 => array('SL No.' => '77', 'UPC_Code' => '11804157830000', 'Item_Name' => 'Dettol-750ml', 'p_p' => '190', 'qty' => '2'),
    77 => array('SL No.' => '78', 'UPC_Code' => '11804229800000', 'Item_Name' => 'Display Book 60 Pocket', 'p_p' => '0', 'qty' => '0'),
    78 => array('SL No.' => '79', 'UPC_Code' => '11804229810000', 'Item_Name' => 'Duster Cloth', 'p_p' => '12', 'qty' => '70'),
    79 => array('SL No.' => '80', 'UPC_Code' => '11804228860000', 'Item_Name' => 'Egg', 'p_p' => '0', 'qty' => '0'),
    80 => array('SL No.' => '81', 'UPC_Code' => '11804157840000', 'Item_Name' => 'Facial Tissue', 'p_p' => '41.2', 'qty' => '29'),
    81 => array('SL No.' => '82', 'UPC_Code' => '11804157850000', 'Item_Name' => 'Facial Tissue (02)', 'p_p' => '0', 'qty' => '0'),
    82 => array('SL No.' => '83', 'UPC_Code' => '11804157860000', 'Item_Name' => 'Facial Tissue (03)', 'p_p' => '0', 'qty' => '0'),
    83 => array('SL No.' => '84', 'UPC_Code' => '11804228870000', 'Item_Name' => 'Fish - Ayer', 'p_p' => '0', 'qty' => '0'),
    84 => array('SL No.' => '85', 'UPC_Code' => '11804228880000', 'Item_Name' => 'Fish - Baim', 'p_p' => '0', 'qty' => '0'),
    85 => array('SL No.' => '86', 'UPC_Code' => '11804228890000', 'Item_Name' => 'Fish - Batashi', 'p_p' => '0', 'qty' => '0'),
    86 => array('SL No.' => '87', 'UPC_Code' => '11804228900000', 'Item_Name' => 'Fish - Bele', 'p_p' => '0', 'qty' => '0'),
    87 => array('SL No.' => '88', 'UPC_Code' => '11804228910000', 'Item_Name' => 'Fish - Boyal', 'p_p' => '0', 'qty' => '0'),
    88 => array('SL No.' => '89', 'UPC_Code' => '11804228920000', 'Item_Name' => 'Fish - Chitol', 'p_p' => '0', 'qty' => '0'),
    89 => array('SL No.' => '90', 'UPC_Code' => '11804228930000', 'Item_Name' => 'Fish - Grass Carp', 'p_p' => '0', 'qty' => '0'),
    90 => array('SL No.' => '91', 'UPC_Code' => '11804228940000', 'Item_Name' => 'Fish - Ilish', 'p_p' => '0', 'qty' => '0'),
    91 => array('SL No.' => '92', 'UPC_Code' => '11804228950000', 'Item_Name' => 'Fish - Kajuli', 'p_p' => '0', 'qty' => '0'),
    92 => array('SL No.' => '93', 'UPC_Code' => '11804228960000', 'Item_Name' => 'Fish - Katla', 'p_p' => '0', 'qty' => '0'),
    93 => array('SL No.' => '94', 'UPC_Code' => '11804228970000', 'Item_Name' => 'Fish - Kechki', 'p_p' => '0', 'qty' => '0'),
    94 => array('SL No.' => '95', 'UPC_Code' => '11804228980000', 'Item_Name' => 'Fish - Koi', 'p_p' => '0', 'qty' => '0'),
    95 => array('SL No.' => '96', 'UPC_Code' => '11804228990000', 'Item_Name' => 'Fish - Koral', 'p_p' => '0', 'qty' => '0'),
    96 => array('SL No.' => '97', 'UPC_Code' => '11804229000000', 'Item_Name' => 'Fish - Magor', 'p_p' => '0', 'qty' => '0'),
    97 => array('SL No.' => '98', 'UPC_Code' => '11804229010000', 'Item_Name' => 'Fish - Mola', 'p_p' => '0', 'qty' => '0'),
    98 => array('SL No.' => '99', 'UPC_Code' => '11804229020000', 'Item_Name' => 'Fish - Mrigel', 'p_p' => '0', 'qty' => '0'),
    99 => array('SL No.' => '100', 'UPC_Code' => '11804229030000', 'Item_Name' => 'Fish - Pabda', 'p_p' => '0', 'qty' => '0'),
    100 => array('SL No.' => '101', 'UPC_Code' => '11804229040000', 'Item_Name' => 'Fish - Pangash', 'p_p' => '0', 'qty' => '0'),
    101 => array('SL No.' => '102', 'UPC_Code' => '11804229050000', 'Item_Name' => 'Fish - Poa', 'p_p' => '0', 'qty' => '0'),
    102 => array('SL No.' => '103', 'UPC_Code' => '11804229060000', 'Item_Name' => 'Fish - Prawn(Medium)', 'p_p' => '0', 'qty' => '0'),
    103 => array('SL No.' => '104', 'UPC_Code' => '11804229070000', 'Item_Name' => 'Fish - Prawn(Small)', 'p_p' => '0', 'qty' => '0'),
    104 => array('SL No.' => '105', 'UPC_Code' => '11804229080000', 'Item_Name' => 'Fish - Puti', 'p_p' => '0', 'qty' => '0'),
    105 => array('SL No.' => '106', 'UPC_Code' => '11804229090000', 'Item_Name' => 'Fish - Rita', 'p_p' => '0', 'qty' => '0'),
    106 => array('SL No.' => '107', 'UPC_Code' => '11804229100000', 'Item_Name' => 'Fish - Rui', 'p_p' => '0', 'qty' => '0'),
    107 => array('SL No.' => '108', 'UPC_Code' => '11804229110000', 'Item_Name' => 'Fish - Shing', 'p_p' => '0', 'qty' => '0'),
    108 => array('SL No.' => '109', 'UPC_Code' => '11804229120000', 'Item_Name' => 'Fish - Shol', 'p_p' => '0', 'qty' => '0'),
    109 => array('SL No.' => '110', 'UPC_Code' => '11804229130000', 'Item_Name' => 'Fish - Shorputi', 'p_p' => '0', 'qty' => '0'),
    110 => array('SL No.' => '111', 'UPC_Code' => '11804229140000', 'Item_Name' => 'Fish - Silver Carp', 'p_p' => '0', 'qty' => '0'),
    111 => array('SL No.' => '112', 'UPC_Code' => '11804229150000', 'Item_Name' => 'Fish - Taki', 'p_p' => '0', 'qty' => '0'),
    112 => array('SL No.' => '113', 'UPC_Code' => '11804229160000', 'Item_Name' => 'Fish - Telapia', 'p_p' => '0', 'qty' => '0'),
    113 => array('SL No.' => '114', 'UPC_Code' => '11804229170000', 'Item_Name' => 'Fish - Tengra', 'p_p' => '0', 'qty' => '0'),
    114 => array('SL No.' => '115', 'UPC_Code' => '11804157870000', 'Item_Name' => 'Flower Broom', 'p_p' => '35', 'qty' => '0'),
    115 => array('SL No.' => '116', 'UPC_Code' => '11804229180000', 'Item_Name' => 'Garlic', 'p_p' => '110', 'qty' => '0'),
    116 => array('SL No.' => '117', 'UPC_Code' => '11804229190000', 'Item_Name' => 'Gourd', 'p_p' => '0', 'qty' => '0'),
    117 => array('SL No.' => '118', 'UPC_Code' => '11804229200000', 'Item_Name' => 'Green Banana', 'p_p' => '0', 'qty' => '0'),
    118 => array('SL No.' => '119', 'UPC_Code' => '11804229210000', 'Item_Name' => 'Green Chilli', 'p_p' => '0', 'qty' => '0'),
    119 => array('SL No.' => '120', 'UPC_Code' => '11804229220000', 'Item_Name' => 'Green Papaya', 'p_p' => '0', 'qty' => '0'),
    120 => array('SL No.' => '121', 'UPC_Code' => '11804157880000', 'Item_Name' => 'Green Tea-60gm', 'p_p' => '135', 'qty' => '4'),
    121 => array('SL No.' => '122', 'UPC_Code' => '11804157890000', 'Item_Name' => 'Harpic Flashmetic Comod Bar', 'p_p' => '90', 'qty' => '10'),
    122 => array('SL No.' => '123', 'UPC_Code' => '11804157900000', 'Item_Name' => 'Harpic Liquid 750ml', 'p_p' => '90', 'qty' => '30'),
    123 => array('SL No.' => '124', 'UPC_Code' => '11804229780000', 'Item_Name' => 'Index File-2inch Huajie', 'p_p' => '75', 'qty' => '31'),
    124 => array('SL No.' => '125', 'UPC_Code' => '11804229790000', 'Item_Name' => 'Index File-3inch Huajie', 'p_p' => '73', 'qty' => '5'),
    125 => array('SL No.' => '126', 'UPC_Code' => '11804157910000', 'Item_Name' => 'Kitchen Tissue', 'p_p' => '42.5', 'qty' => '8'),
    126 => array('SL No.' => '127', 'UPC_Code' => '11804229230000', 'Item_Name' => 'Ladies Finger', 'p_p' => '0', 'qty' => '0'),
    127 => array('SL No.' => '128', 'UPC_Code' => '11804229240000', 'Item_Name' => 'Lifebuoy - 100gm-lemon', 'p_p' => '25.78', 'qty' => '23'),
    128 => array('SL No.' => '129', 'UPC_Code' => '11804157920000', 'Item_Name' => 'Lifebuoy - 100gm', 'p_p' => '25.78', 'qty' => '2'),
    129 => array('SL No.' => '130', 'UPC_Code' => '11804157930000', 'Item_Name' => 'Lifebuoy Liquid 180 ml', 'p_p' => '46.7', 'qty' => '17'),
    130 => array('SL No.' => '131', 'UPC_Code' => '11807059880000', 'Item_Name' => 'Lux - 150gm', 'p_p' => '37.58', 'qty' => '10'),
    131 => array('SL No.' => '132', 'UPC_Code' => '11807059890000', 'Item_Name' => 'Lux - 100gm', 'p_p' => '28.5', 'qty' => '10'),
    132 => array('SL No.' => '133', 'UPC_Code' => '11804157940000', 'Item_Name' => 'Lux - 75gm', 'p_p' => '22.08', 'qty' => '58'),
    133 => array('SL No.' => '134', 'UPC_Code' => '11804157950000', 'Item_Name' => 'Lux - 40gm', 'p_p' => '8.94', 'qty' => '5'),
    134 => array('SL No.' => '135', 'UPC_Code' => '11804229250000', 'Item_Name' => 'Malta', 'p_p' => '0', 'qty' => '0'),
    135 => array('SL No.' => '136', 'UPC_Code' => '11804229260000', 'Item_Name' => 'Me-O Dry Food', 'p_p' => '230', 'qty' => '0'),
    136 => array('SL No.' => '137', 'UPC_Code' => '11804229270000', 'Item_Name' => 'Me-O Wet Food (Can)', 'p_p' => '140', 'qty' => '0'),
    137 => array('SL No.' => '138', 'UPC_Code' => '11804157960000', 'Item_Name' => 'Milk Powder-1kg', 'p_p' => '552', 'qty' => '4'),
    138 => array('SL No.' => '139', 'UPC_Code' => '11804157970000', 'Item_Name' => 'Milk Powder-1kg (02)', 'p_p' => '430', 'qty' => '1'),
    139 => array('SL No.' => '140', 'UPC_Code' => '11804157980000', 'Item_Name' => 'Milk Powder-500gm', 'p_p' => '274', 'qty' => '9'),
    140 => array('SL No.' => '141', 'UPC_Code' => '11804157990000', 'Item_Name' => 'Milk Powder-500gm (02)', 'p_p' => '0', 'qty' => '0'),
    141 => array('SL No.' => '142', 'UPC_Code' => '11804158000000', 'Item_Name' => 'Milk Powder-500gm(03)', 'p_p' => '219', 'qty' => '4'),
    142 => array('SL No.' => '143', 'UPC_Code' => '11807059900000', 'Item_Name' => 'Milk Powder-400gm Dano', 'p_p' => '219', 'qty' => '11'),
    143 => array('SL No.' => '144', 'UPC_Code' => '11804158010000', 'Item_Name' => 'Milk Powder-500gm(04)', 'p_p' => '269', 'qty' => '14'),
    144 => array('SL No.' => '145', 'UPC_Code' => '11804158020000', 'Item_Name' => 'MOP', 'p_p' => '100', 'qty' => '4'),
    145 => array('SL No.' => '146', 'UPC_Code' => '11804158030000', 'Item_Name' => 'MOP Head', 'p_p' => '40', 'qty' => '17'),
    146 => array('SL No.' => '147', 'UPC_Code' => '11804158040000', 'Item_Name' => 'Mr. Brasso - 350 ml Refill', 'p_p' => '70', 'qty' => '25'),
    147 => array('SL No.' => '148', 'UPC_Code' => '11804158050000', 'Item_Name' => 'Mr. Brasso with Spray - 350ml', 'p_p' => '90', 'qty' => '6'),
    148 => array('SL No.' => '149', 'UPC_Code' => '11804158060000', 'Item_Name' => 'Napthalene', 'p_p' => '0', 'qty' => '0'),
    149 => array('SL No.' => '150', 'UPC_Code' => '11804158070000', 'Item_Name' => 'Nescafe Classic-100gm', 'p_p' => '215', 'qty' => '2'),
    150 => array('SL No.' => '151', 'UPC_Code' => '11804158080000', 'Item_Name' => 'Nescafe Gold-200gm', 'p_p' => '570', 'qty' => '3'),
    151 => array('SL No.' => '152', 'UPC_Code' => '11804158090000', 'Item_Name' => 'Nescafe Original-200gm', 'p_p' => '315', 'qty' => '5'),
    152 => array('SL No.' => '153', 'UPC_Code' => '11804158100000', 'Item_Name' => 'Nimki Biscuit', 'p_p' => '60', 'qty' => '0'),
    153 => array('SL No.' => '154', 'UPC_Code' => '11804158110000', 'Item_Name' => 'Odonil', 'p_p' => '35', 'qty' => '13'),
    154 => array('SL No.' => '155', 'UPC_Code' => '11804229280000', 'Item_Name' => 'Onion (Indian)', 'p_p' => '0', 'qty' => '0'),
    155 => array('SL No.' => '156', 'UPC_Code' => '11804229290000', 'Item_Name' => 'Onion (Local)', 'p_p' => '0', 'qty' => '0'),
    156 => array('SL No.' => '157', 'UPC_Code' => '11804229300000', 'Item_Name' => 'Orange', 'p_p' => '0', 'qty' => '0'),
    157 => array('SL No.' => '158', 'UPC_Code' => '11804158120000', 'Item_Name' => 'Orchid', 'p_p' => '25.5', 'qty' => '43'),
    158 => array('SL No.' => '159', 'UPC_Code' => '11804229820000', 'Item_Name' => 'Pen Holder Wood', 'p_p' => '135', 'qty' => '5'),
    159 => array('SL No.' => '160', 'UPC_Code' => '11804158130000', 'Item_Name' => 'Phenyle-1L', 'p_p' => '82', 'qty' => '2'),
    160 => array('SL No.' => '161', 'UPC_Code' => '11804229310000', 'Item_Name' => 'Pistachios (Pestabadam) - 100gm', 'p_p' => '0', 'qty' => '0'),
    161 => array('SL No.' => '162', 'UPC_Code' => '11804229320000', 'Item_Name' => 'Pointer Gourd', 'p_p' => '0', 'qty' => '0'),
    162 => array('SL No.' => '163', 'UPC_Code' => '11804229330000', 'Item_Name' => 'Potato', 'p_p' => '0', 'qty' => '0'),
    163 => array('SL No.' => '164', 'UPC_Code' => '11804229340000', 'Item_Name' => 'Puffed Rice - 1kg', 'p_p' => '105', 'qty' => '0'),
    164 => array('SL No.' => '165', 'UPC_Code' => '11804229350000', 'Item_Name' => 'Puffed Rice - 500gm', 'p_p' => '0', 'qty' => '0'),
    165 => array('SL No.' => '166', 'UPC_Code' => '11804229360000', 'Item_Name' => 'Raisins (Kishmish) - 100gm', 'p_p' => '44', 'qty' => '0'),
    166 => array('SL No.' => '167', 'UPC_Code' => '11804229370000', 'Item_Name' => 'Raisins (Kishmish) - 250gm', 'p_p' => '110', 'qty' => '0'),
    167 => array('SL No.' => '168', 'UPC_Code' => '11804158140000', 'Item_Name' => 'Rin Powder-1kg', 'p_p' => '89.67', 'qty' => '14'),
    168 => array('SL No.' => '169', 'UPC_Code' => '11804158150000', 'Item_Name' => 'Rin Powder-500gm', 'p_p' => '47.38', 'qty' => '16'),
    169 => array('SL No.' => '170', 'UPC_Code' => '11804158160000', 'Item_Name' => 'Rok - 900ml', 'p_p' => '140', 'qty' => '9'),
    170 => array('SL No.' => '171', 'UPC_Code' => '11804158170000', 'Item_Name' => 'Rok 350ml - Rifill', 'p_p' => '60', 'qty' => '0'),
    171 => array('SL No.' => '172', 'UPC_Code' => '11804158180000', 'Item_Name' => 'Rok Bleaching Powder - 500gm', 'p_p' => '40', 'qty' => '0'),
    172 => array('SL No.' => '173', 'UPC_Code' => '11804158190000', 'Item_Name' => 'Rok with Spray - 350ml', 'p_p' => '95', 'qty' => '0'),
    173 => array('SL No.' => '174', 'UPC_Code' => '11804158200000', 'Item_Name' => 'Roof Broom Long & Plastic', 'p_p' => '130', 'qty' => '0'),
    174 => array('SL No.' => '175', 'UPC_Code' => '11804229830000', 'Item_Name' => 'Rubber Band Small Packet', 'p_p' => '0', 'qty' => '0'),
    175 => array('SL No.' => '176', 'UPC_Code' => '11804229380000', 'Item_Name' => 'Salad Leaf', 'p_p' => '0', 'qty' => '0'),
    176 => array('SL No.' => '177', 'UPC_Code' => '11804229390000', 'Item_Name' => 'Salted Biscuit', 'p_p' => '0', 'qty' => '0'),
    177 => array('SL No.' => '178', 'UPC_Code' => '11804158210000', 'Item_Name' => 'Savlon - 180 ml Refill', 'p_p' => '49', 'qty' => '0'),
    178 => array('SL No.' => '179', 'UPC_Code' => '11804158220000', 'Item_Name' => 'Savlon-1L', 'p_p' => '195', 'qty' => '0'),
    179 => array('SL No.' => '180', 'UPC_Code' => '11804229620000', 'Item_Name' => 'Scale Steel - 12"', 'p_p' => '10.4', 'qty' => '29'),
    180 => array('SL No.' => '181', 'UPC_Code' => '11804229630000', 'Item_Name' => 'Scale Steel - 6"', 'p_p' => '6.5', 'qty' => '7'),
    181 => array('SL No.' => '182', 'UPC_Code' => '11804229400000', 'Item_Name' => 'Snake Gourd', 'p_p' => '0', 'qty' => '0'),
    182 => array('SL No.' => '183', 'UPC_Code' => '11804229410000', 'Item_Name' => 'Sponge Gourd', 'p_p' => '0', 'qty' => '0'),
    183 => array('SL No.' => '184', 'UPC_Code' => '11804158230000', 'Item_Name' => 'Steel Scrubber Sun', 'p_p' => '6.67', 'qty' => '16'),
    184 => array('SL No.' => '185', 'UPC_Code' => '11804158240000', 'Item_Name' => 'Steel Scrubber Master', 'p_p' => '9.17', 'qty' => '18'),
    185 => array('SL No.' => '186', 'UPC_Code' => '11804229420000', 'Item_Name' => 'String Bean', 'p_p' => '0', 'qty' => '0'),
    186 => array('SL No.' => '187', 'UPC_Code' => '11804158250000', 'Item_Name' => 'Sugar-1kg Teer', 'p_p' => '59', 'qty' => '5'),
    187 => array('SL No.' => '188', 'UPC_Code' => '11804158260000', 'Item_Name' => 'Sugar-1kg Fresh', 'p_p' => '57', 'qty' => '0'),
    188 => array('SL No.' => '189', 'UPC_Code' => '11804158270000', 'Item_Name' => 'Sugar-500gm', 'p_p' => '30', 'qty' => '1'),
    189 => array('SL No.' => '190', 'UPC_Code' => '11804158280000', 'Item_Name' => 'Sunsilk 375 ml', 'p_p' => '242.5', 'qty' => '6'),
    190 => array('SL No.' => '191', 'UPC_Code' => '11804158290000', 'Item_Name' => 'Sunsilk 7ml Minipack', 'p_p' => '1.89', 'qty' => '6'),
    191 => array('SL No.' => '192', 'UPC_Code' => '11804158300000', 'Item_Name' => 'Surf Excel-1kg', 'p_p' => '149', 'qty' => '3'),
    192 => array('SL No.' => '193', 'UPC_Code' => '11804158310000', 'Item_Name' => 'Surf Excel-500gm', 'p_p' => '78.93', 'qty' => '3'),
    193 => array('SL No.' => '194', 'UPC_Code' => '11804158320000', 'Item_Name' => 'Surf Excel-Mini Pack', 'p_p' => '4.49', 'qty' => '3'),
    194 => array('SL No.' => '195', 'UPC_Code' => '11804229430000', 'Item_Name' => 'Sweet Pumpkin', 'p_p' => '0', 'qty' => '0'),
    195 => array('SL No.' => '196', 'UPC_Code' => '11804158330000', 'Item_Name' => 'Tea-200gm Ispahani', 'p_p' => '72.5', 'qty' => '0'),
    196 => array('SL No.' => '197', 'UPC_Code' => '11804158340000', 'Item_Name' => 'Tea-200gm Taza', 'p_p' => '76.92', 'qty' => '36'),
    197 => array('SL No.' => '198', 'UPC_Code' => '11804158350000', 'Item_Name' => 'Tea-400gm Ispahani', 'p_p' => '142', 'qty' => '0'),
    198 => array('SL No.' => '199', 'UPC_Code' => '11804158360000', 'Item_Name' => 'Tea-400gm Sylon', 'p_p' => '148', 'qty' => '5'),
    199 => array('SL No.' => '200', 'UPC_Code' => '11804158370000', 'Item_Name' => 'Tea-400gm Taza', 'p_p' => '149', 'qty' => '23'),
    200 => array('SL No.' => '201', 'UPC_Code' => '11804158380000', 'Item_Name' => 'Tea-50Bag Ispahani', 'p_p' => '67', 'qty' => '19'),
    201 => array('SL No.' => '202', 'UPC_Code' => '11804158390000', 'Item_Name' => 'Tea-50Bag Taza', 'p_p' => '72.5', 'qty' => '0'),
    202 => array('SL No.' => '203', 'UPC_Code' => '11804158400000', 'Item_Name' => 'Tea-Twinings-Earl Grey', 'p_p' => '300', 'qty' => '0'),
    203 => array('SL No.' => '204', 'UPC_Code' => '11804158410000', 'Item_Name' => 'Tissue-Napkin Bashundhara', 'p_p' => '39', 'qty' => '26'),
    204 => array('SL No.' => '205', 'UPC_Code' => '11804158420000', 'Item_Name' => 'Tissue-Napkin Meghna', 'p_p' => '39', 'qty' => '0'),
    205 => array('SL No.' => '206', 'UPC_Code' => '11804158430000', 'Item_Name' => 'Toilet Tissue', 'p_p' => '13', 'qty' => '80'),
    206 => array('SL No.' => '207', 'UPC_Code' => '11804158440000', 'Item_Name' => 'Toilet Tissue (02)', 'p_p' => '62', 'qty' => '0'),
    207 => array('SL No.' => '208', 'UPC_Code' => '11804158450000', 'Item_Name' => 'Toilet Tissue (03)', 'p_p' => '14', 'qty' => '0'),
    208 => array('SL No.' => '209', 'UPC_Code' => '11804229440000', 'Item_Name' => 'Tomato - 1kg', 'p_p' => '0', 'qty' => '0'),
    209 => array('SL No.' => '210', 'UPC_Code' => '11804158460000', 'Item_Name' => 'Trix - 250ml Refill', 'p_p' => '31.5', 'qty' => '0'),
    210 => array('SL No.' => '211', 'UPC_Code' => '11804158470000', 'Item_Name' => 'Trix 500ml Bottle', 'p_p' => '68', 'qty' => '7'),
    211 => array('SL No.' => '212', 'UPC_Code' => '11804158480000', 'Item_Name' => 'Vim - 250ml Bottle', 'p_p' => '32.43', 'qty' => '11'),
    212 => array('SL No.' => '213', 'UPC_Code' => '11804158490000', 'Item_Name' => 'Vim - 500ml Bottle', 'p_p' => '72.5', 'qty' => '16'),
    213 => array('SL No.' => '214', 'UPC_Code' => '11804158500000', 'Item_Name' => 'Vim Powder 500gm Bottle', 'p_p' => '27', 'qty' => '24'),
    214 => array('SL No.' => '215', 'UPC_Code' => '11804158510000', 'Item_Name' => 'Vim-325gm Bar', 'p_p' => '27', 'qty' => '36'),
    215 => array('SL No.' => '216', 'UPC_Code' => '11804158520000', 'Item_Name' => 'Vixol White 500 ml (Thailand)', 'p_p' => '110', 'qty' => '2'),
    216 => array('SL No.' => '217', 'UPC_Code' => '11804229450000', 'Item_Name' => 'Watermelon', 'p_p' => '0', 'qty' => '0'),
    217 => array('SL No.' => '218', 'UPC_Code' => '11804158530000', 'Item_Name' => 'Wheel Powder-1kg', 'p_p' => '64', 'qty' => '0'),
    218 => array('SL No.' => '219', 'UPC_Code' => '11804158540000', 'Item_Name' => 'Wheel Powder-500gm', 'p_p' => '34.68', 'qty' => '12'),
    219 => array('SL No.' => '220', 'UPC_Code' => '11804158550000', 'Item_Name' => 'Zero Cal-100 Tablet', 'p_p' => '115', 'qty' => '0'),
    220 => array('SL No.' => '221', 'UPC_Code' => '11804158560000', 'Item_Name' => 'Zero Cal-Suger 75 Pices', 'p_p' => '148', 'qty' => '11'),
);
    }

    public function custArray(){
        return array(
    0 => array('SL_NO' => '1', 'article_number' => '30000011', 'article_description' => 'FA ROLL ON CARIBBIAN LEMON 50ML', 'purchase_price' => '105'),
    1 => array('SL_NO' => '2', 'article_number' => '30000045', 'article_description' => 'FA ROLL ON AQUA FRESH 50ML', 'purchase_price' => '105'),
    2 => array('SL_NO' => '3', 'article_number' => '30000046', 'article_description' => 'FA ROLL ON MEN PERFECT WAVE 50ML', 'purchase_price' => '129.08'),
    3 => array('SL_NO' => '4', 'article_number' => '30000047', 'article_description' => 'FA BODY SPRAY AQUA 200ML DE', 'purchase_price' => '190'),
    4 => array('SL_NO' => '5', 'article_number' => '30000070', 'article_description' => 'JOHNSON\'S BABY SOFT CREAM 100ML FR', 'purchase_price' => '303.78'),
    5 => array('SL_NO' => '6', 'article_number' => '30000077', 'article_description' => 'JOHNSON\'S BABY OIL 300ML IT', 'purchase_price' => '269'),
    6 => array('SL_NO' => '7', 'article_number' => '30000078', 'article_description' => 'JOHNSON\'S BABY OIL 500ML IT', 'purchase_price' => '421.36'),
    7 => array('SL_NO' => '8', 'article_number' => '30000080', 'article_description' => 'JOHNSON\'S BABY LOTION PINK 200ML IT', 'purchase_price' => '240'),
    8 => array('SL_NO' => '9', 'article_number' => '30000081', 'article_description' => 'JOHNSON\'S BABY LOTION PINK 300ML IT', 'purchase_price' => '300'),
    9 => array('SL_NO' => '10', 'article_number' => '30000082', 'article_description' => 'JOHNSON\'S BABY LOTION PINK 500ML IT', 'purchase_price' => '405'),
    10 => array('SL_NO' => '11', 'article_number' => '30000102', 'article_description' => 'JOHNSON\'S BABY OIL 100ML IN', 'purchase_price' => '153'),
    11 => array('SL_NO' => '12', 'article_number' => '30000111', 'article_description' => 'JOHNSON\'S BABY HAIR OIL 100ML IN', 'purchase_price' => '122.48'),
    12 => array('SL_NO' => '13', 'article_number' => '30000225', 'article_description' => 'FA BODY SPRAY EXOTIC GARDEN 200ML DE', 'purchase_price' => '181.25'),
    13 => array('SL_NO' => '14', 'article_number' => '30000262', 'article_description' => 'NIZORAL SHAMPOO KETOCONAZOLE 50ML TH', 'purchase_price' => '343.25'),
    14 => array('SL_NO' => '15', 'article_number' => '30000274', 'article_description' => 'JOHNSON\'S BABY MILK BATH 100ML MY', 'purchase_price' => '115'),
    15 => array('SL_NO' => '16', 'article_number' => '30000275', 'article_description' => 'JOHNSON\'S BABY MILK LOTION 200ML MY', 'purchase_price' => '260'),
    16 => array('SL_NO' => '17', 'article_number' => '30000391', 'article_description' => 'FA BODY SPRAY CARIBBIAN LEMON 200ML DE', 'purchase_price' => '190'),
    17 => array('SL_NO' => '18', 'article_number' => '30001320', 'article_description' => 'JOHNSON\'S BABY SHAMPOO 475ML IN.', 'purchase_price' => '485.1'),
    18 => array('SL_NO' => '19', 'article_number' => '30001321', 'article_description' => 'CLEAN & CLEAR F.WASH DEEP ACTION 80ML IN', 'purchase_price' => '207'),
    19 => array('SL_NO' => '20', 'article_number' => '30001696', 'article_description' => 'FA ROLL ON PINK PASSION FLORAL 50ML DE', 'purchase_price' => '129.08'),
    20 => array('SL_NO' => '21', 'article_number' => '30001697', 'article_description' => 'FA ROLL ON NUTRI SKIN CARE COMPLEX 50ML', 'purchase_price' => '129.08'),
    21 => array('SL_NO' => '22', 'article_number' => '30001698', 'article_description' => 'FA BODY SPRAY MEN SPEEDSTER 200ML DE', 'purchase_price' => '181.25'),
    22 => array('SL_NO' => '23', 'article_number' => '30002397', 'article_description' => 'JOHNSON\'S BABY GIFT BOX MEDIUM', 'purchase_price' => '570'),
    23 => array('SL_NO' => '24', 'article_number' => '30003123', 'article_description' => 'FA BODY SPRAY PURPLE PASSION 200ML', 'purchase_price' => '190'),
    24 => array('SL_NO' => '25', 'article_number' => '30003124', 'article_description' => 'FA BODY SPRAY FLORAL PROTECT 200ML', 'purchase_price' => '181.25'),
    25 => array('SL_NO' => '26', 'article_number' => '30003125', 'article_description' => 'FA BODY SPRAY PINK PASSION 200ML', 'purchase_price' => '181.25'),
    26 => array('SL_NO' => '27', 'article_number' => '30003784', 'article_description' => 'NIZORAL SHAMPOO KETOCONAZOLE 100ML TH', 'purchase_price' => '573.75'),
    27 => array('SL_NO' => '28', 'article_number' => '30003999', 'article_description' => 'FA BODY SPRAY NATURAL & FRESH 200ML', 'purchase_price' => '181.25'),
    28 => array('SL_NO' => '29', 'article_number' => '30004232', 'article_description' => 'JOHNSON\'S BABY BEDTIME LOTION 500ML MY', 'purchase_price' => '353.4'),
    29 => array('SL_NO' => '30', 'article_number' => '30004234', 'article_description' => 'JOHNSON\'S BABY POWDER 200G IN', 'purchase_price' => '136'),
    30 => array('SL_NO' => '31', 'article_number' => '30005998', 'article_description' => 'MOTHERCARE BABY LOTION 300ML GB', 'purchase_price' => '485'),
    31 => array('SL_NO' => '32', 'article_number' => '30006023', 'article_description' => 'MAYBELLINE COLOSSAL KAJAL 6H 0.35G CN', 'purchase_price' => '257.37'),
    32 => array('SL_NO' => '33', 'article_number' => '30006032', 'article_description' => 'MOTHERCARE BABY BODY WASH 300ML GB', 'purchase_price' => '485'),
    33 => array('SL_NO' => '34', 'article_number' => '30006034', 'article_description' => 'MOTHERCARE BABY OIL 300ML GB', 'purchase_price' => '515'),
    34 => array('SL_NO' => '35', 'article_number' => '30006042', 'article_description' => 'GATSBY WATER GLOSS SOFT 150G ID', 'purchase_price' => '135'),
    35 => array('SL_NO' => '36', 'article_number' => '30006043', 'article_description' => 'GATSBY WATER GLOSS HYPER SOLID 150G ID', 'purchase_price' => '135'),
    36 => array('SL_NO' => '37', 'article_number' => '30006077', 'article_description' => 'ZEST SOAP ICE FRESH 175G SA', 'purchase_price' => '83.17'),
    37 => array('SL_NO' => '38', 'article_number' => '30006078', 'article_description' => 'ZEST SOAP LEMON FRESH 175G SA', 'purchase_price' => '83.17'),
    38 => array('SL_NO' => '39', 'article_number' => '30006079', 'article_description' => 'LOREAL ELV.SHAMPOO ARGIN RESIST 400ML FR', 'purchase_price' => '436.08'),
    39 => array('SL_NO' => '40', 'article_number' => '30006080', 'article_description' => 'LOREAL ELV.SHAMPOO TOTL REPAIR5 400ML FR', 'purchase_price' => '436.08'),
    40 => array('SL_NO' => '41', 'article_number' => '30006197', 'article_description' => 'KIWI EXPRESS SHINE BLACK 7ML IN', 'purchase_price' => '105.9'),
    41 => array('SL_NO' => '42', 'article_number' => '30006275', 'article_description' => 'LAKME KAJAL 0.20G IN', 'purchase_price' => '81.01'),
    42 => array('SL_NO' => '43', 'article_number' => '30006276', 'article_description' => 'LAKME EYELINER IN LINER WATER RES 9ML IN', 'purchase_price' => '133.46'),
    43 => array('SL_NO' => '44', 'article_number' => '30006402', 'article_description' => 'VIVEL SOAP ALMOND OIL & SHEA BUTTER 125G', 'purchase_price' => '95.05'),
    44 => array('SL_NO' => '45', 'article_number' => '30006403', 'article_description' => 'VIVEL SOAP NUTRITIOUS FRUIT OIL 125G', 'purchase_price' => '95.05'),
    45 => array('SL_NO' => '46', 'article_number' => '30006409', 'article_description' => 'WILD STONE BODY SPRAY H.ENERGY 150ML IN', 'purchase_price' => '228.49'),
    46 => array('SL_NO' => '47', 'article_number' => '30006410', 'article_description' => 'WILD STONE BODY SPRAY JUICE 150ML IN', 'purchase_price' => '228.49'),
    47 => array('SL_NO' => '48', 'article_number' => '30006411', 'article_description' => 'WILD STONE BODY SPRAY RED 150ML IN', 'purchase_price' => '228.49'),
    48 => array('SL_NO' => '49', 'article_number' => '30006412', 'article_description' => 'WILD STONE BODY SPRAY N.RIDER 150ML IN', 'purchase_price' => '228.49'),
    49 => array('SL_NO' => '50', 'article_number' => '30006419', 'article_description' => 'DOVE SHOWER GEL REVIVE 250ML GB', 'purchase_price' => '209.57'),
    50 => array('SL_NO' => '51', 'article_number' => '30006420', 'article_description' => 'DOVE SHOWER GEL BURST 250ML GB', 'purchase_price' => '209.57'),
    51 => array('SL_NO' => '52', 'article_number' => '30006421', 'article_description' => 'DOVE SHOWER CRM DEEPLY NOURISH 250ML GB', 'purchase_price' => '209.57'),
    52 => array('SL_NO' => '53', 'article_number' => '30006422', 'article_description' => 'DOVE SHOWER CREAM CREAM OIL 250ML GB', 'purchase_price' => '209.57'),
    53 => array('SL_NO' => '54', 'article_number' => '30006471', 'article_description' => 'LOREAL ELV.SHAMPOO COLOUR PROT 400ML GB', 'purchase_price' => '436.08'),
    54 => array('SL_NO' => '55', 'article_number' => '30006474', 'article_description' => 'LOREAL ELV.SHAMPOO ANTI-BRAKGE 400ML FR', 'purchase_price' => '436.08'),
    55 => array('SL_NO' => '56', 'article_number' => '30006476', 'article_description' => 'LOREAL ELV.SHAMPOO SMTH INTENSE 400ML FR', 'purchase_price' => '436.08'),
    56 => array('SL_NO' => '57', 'article_number' => '30006534', 'article_description' => 'LISTERINE MOUTH WASH TOTAL CARE 750ML TH', 'purchase_price' => '466.2'),
    57 => array('SL_NO' => '58', 'article_number' => '30006535', 'article_description' => 'LISTERINE MOUTH WASH TOTAL CARE 250ML TH', 'purchase_price' => '223.63'),
    58 => array('SL_NO' => '59', 'article_number' => '30006538', 'article_description' => 'TRESEMME SHAMPOO DEEP REPAIR 480ML TH', 'purchase_price' => '421.38'),
    59 => array('SL_NO' => '60', 'article_number' => '30006918', 'article_description' => 'AYUR FACE WASH GREEN APPL&HONEY 100ML IN', 'purchase_price' => '156.7'),
    60 => array('SL_NO' => '61', 'article_number' => '30006922', 'article_description' => 'AYUR FACE GEL LEMON & HONEY 100ML IN', 'purchase_price' => '156.7'),
    61 => array('SL_NO' => '62', 'article_number' => '30006923', 'article_description' => 'AYUR FACE GEL PAPAYA 100ML IN', 'purchase_price' => '156.7'),
    62 => array('SL_NO' => '63', 'article_number' => '30007041', 'article_description' => 'GATSBY HAIR GEL ORANGE 150ML TUB CN', 'purchase_price' => '100'),
    63 => array('SL_NO' => '64', 'article_number' => '30007042', 'article_description' => 'GATSBY HAIR GEL GREEN 150ML TUB CN', 'purchase_price' => '100'),
    64 => array('SL_NO' => '65', 'article_number' => '30007043', 'article_description' => 'GATSBY HAIR GEL WHITE 150ML TUB CN', 'purchase_price' => '100'),
    65 => array('SL_NO' => '66', 'article_number' => '30007258', 'article_description' => 'DR. WEST TOOTHBRUSH JUNIOR OM', 'purchase_price' => '38'),
    66 => array('SL_NO' => '67', 'article_number' => '30007260', 'article_description' => 'BAJAJ ALMOND HAIR OIL 100ML IN', 'purchase_price' => '105'),
    67 => array('SL_NO' => '68', 'article_number' => '30007427', 'article_description' => 'JOHNSON’S BABY SHAMPOO 200ML MY', 'purchase_price' => '205'),
    68 => array('SL_NO' => '69', 'article_number' => '30007428', 'article_description' => 'JOHNSON’S BABY SHAMPOO 300ML IT', 'purchase_price' => '234'),
    69 => array('SL_NO' => '70', 'article_number' => '30007429', 'article_description' => 'JOHNSON’S BABY SHAMPOO 100ML MY', 'purchase_price' => '105'),
    70 => array('SL_NO' => '71', 'article_number' => '30007430', 'article_description' => 'JOHNSON’S BABY MILK CREAM 100ML TH', 'purchase_price' => '362'),
    71 => array('SL_NO' => '72', 'article_number' => '30007431', 'article_description' => 'JOHNSON’S BABY CREAM 100G TH', 'purchase_price' => '362'),
    72 => array('SL_NO' => '73', 'article_number' => '30007432', 'article_description' => 'JOHNSON’S BABY MILK CREAM 50ML TH', 'purchase_price' => '243'),
    73 => array('SL_NO' => '74', 'article_number' => '30007433', 'article_description' => 'JOHNSON’S BABY CREAM 50G TH', 'purchase_price' => '243'),
    74 => array('SL_NO' => '75', 'article_number' => '30007437', 'article_description' => 'JOHNSON\'S BABY SOAP MOISTURE 75G TH', 'purchase_price' => '48'),
    75 => array('SL_NO' => '76', 'article_number' => '30007438', 'article_description' => 'CLEAN & CLEAR FACE WASH FAIRNESS 80G IN', 'purchase_price' => '184'),
    76 => array('SL_NO' => '77', 'article_number' => '30007439', 'article_description' => 'CLEAN & CLEAR DAILY SCRUB BLACKHD 80G IN', 'purchase_price' => '196'),
    77 => array('SL_NO' => '78', 'article_number' => '30007440', 'article_description' => 'CLEAN & CLEAR FAIRNESS CREAM 40G IN', 'purchase_price' => '180.66'),
    78 => array('SL_NO' => '79', 'article_number' => '30007448', 'article_description' => 'LOREAL SHAMPOO TOTAL REPAIR 360ML IN', 'purchase_price' => '431.18'),
    79 => array('SL_NO' => '80', 'article_number' => '30007449', 'article_description' => 'LOREAL SHAMPOO FALL REPAIR 360ML IN', 'purchase_price' => '431.18'),
    80 => array('SL_NO' => '81', 'article_number' => '30007450', 'article_description' => 'KENSPECKLE HAIR SOFT GEL 60CAPSULS CN', 'purchase_price' => '129'),
    81 => array('SL_NO' => '82', 'article_number' => '30007593', 'article_description' => 'TIDE PLUS DETERGENT PWDR 500G IN', 'purchase_price' => '122.42'),
    82 => array('SL_NO' => '83', 'article_number' => '30007649', 'article_description' => 'VASELINE LOTION COCOA RADIANT 600ML GB', 'purchase_price' => '625'),
    83 => array('SL_NO' => '84', 'article_number' => '30007917', 'article_description' => 'GILLETTE SHAVE GEL SENSITIVE SKN 238G GB', 'purchase_price' => '257.33'),
    84 => array('SL_NO' => '85', 'article_number' => '30007918', 'article_description' => 'GILLETTE SHAVE GEL MOIST. HYD 238G GB', 'purchase_price' => '257.33'),
    85 => array('SL_NO' => '86', 'article_number' => '30007919', 'article_description' => 'GILLETTE SHAVE FOAM NORMAL 200ML GB', 'purchase_price' => '170'),
    86 => array('SL_NO' => '87', 'article_number' => '30007920', 'article_description' => 'GILLETTE SHAVE FOAM EMPFINDLICH 200ML GB', 'purchase_price' => '170'),
    87 => array('SL_NO' => '88', 'article_number' => '30007921', 'article_description' => 'GILLETTE SHAVE GEL SENSITIVE SKN 70ML GB', 'purchase_price' => '155'),
    88 => array('SL_NO' => '89', 'article_number' => '30007922', 'article_description' => 'GILLETTE SENSOR EXCEL RAZOR + 2 CART US', 'purchase_price' => '366.51'),
    89 => array('SL_NO' => '90', 'article_number' => '30007923', 'article_description' => 'GILLETTE SENSOR EXCEL 3BLADES PL', 'purchase_price' => '241.17'),
    90 => array('SL_NO' => '91', 'article_number' => '30007924', 'article_description' => 'GILLETTE SENSOR EXCEL 5BLADES PL', 'purchase_price' => '345.86'),
    91 => array('SL_NO' => '92', 'article_number' => '30008054', 'article_description' => 'FEVICOL SUPER GLUE 3G CN', 'purchase_price' => '20'),
    92 => array('SL_NO' => '93', 'article_number' => '30008055', 'article_description' => 'GILLETTE FUSION GEL HYDRATING 200ML GB', 'purchase_price' => '305'),
    93 => array('SL_NO' => '94', 'article_number' => '30008056', 'article_description' => 'GILLETTE MACH3 GEL CLOSE FRESH 200ML GB', 'purchase_price' => '305'),
    94 => array('SL_NO' => '95', 'article_number' => '30008330', 'article_description' => 'LUX BODY WASH MAGICAL SPELL 500ML TH', 'purchase_price' => '439'),
    95 => array('SL_NO' => '96', 'article_number' => '30008331', 'article_description' => 'LUX BODY WASH SOFT TOUCH 550ML TH', 'purchase_price' => '439'),
    96 => array('SL_NO' => '97', 'article_number' => '30008332', 'article_description' => 'LUX BODY WASH WHITE IMPRESS 500ML TH', 'purchase_price' => '439'),
    97 => array('SL_NO' => '98', 'article_number' => '30008342', 'article_description' => 'LUX HAND WASH SHIMMERNG SEA 250ML PMP GB', 'purchase_price' => '233.45'),
    98 => array('SL_NO' => '99', 'article_number' => '30008343', 'article_description' => 'GILLETTE FUSION GEL COOLING  200ML GB', 'purchase_price' => '305'),
    99 => array('SL_NO' => '100', 'article_number' => '30008344', 'article_description' => 'GILLETTE SERIES  GEL SENSITIVE 200ML GB', 'purchase_price' => '285'),
    100 => array('SL_NO' => '101', 'article_number' => '30008348', 'article_description' => 'TRESEMME COND SPLIT RECOVERY 480ML TH', 'purchase_price' => '496'),
    101 => array('SL_NO' => '102', 'article_number' => '30008349', 'article_description' => 'TRESEMME COND PLATINUM STRENGTH 480ML TH', 'purchase_price' => '496'),
    102 => array('SL_NO' => '103', 'article_number' => '30008350', 'article_description' => 'LISTERINE MOUTHWASH ORIGINAL 750ML TH', 'purchase_price' => '575'),
    103 => array('SL_NO' => '104', 'article_number' => '30008352', 'article_description' => 'GILLETTE FUSION PROGLIDE RAZOR+2CART PL', 'purchase_price' => '680.45'),
    104 => array('SL_NO' => '105', 'article_number' => '30008354', 'article_description' => 'GILLETTE SENSOR EXCEL CARTRIDGE 10PCS PL', 'purchase_price' => '672.03'),
    105 => array('SL_NO' => '106', 'article_number' => '30008632', 'article_description' => 'WATSON MINT DENTAL FLOSSERS 50PCS TH', 'purchase_price' => '122.95'),
    106 => array('SL_NO' => '107', 'article_number' => '30008633', 'article_description' => 'WATSON  DENTAL FLOSSERS 50PCS TH', 'purchase_price' => '122.95'),
    107 => array('SL_NO' => '108', 'article_number' => '30008634', 'article_description' => 'TRESEMME ALOE VERA SHAMPOO 946ML US', 'purchase_price' => '597'),
    108 => array('SL_NO' => '109', 'article_number' => '30008635', 'article_description' => 'TRESEMME ALOE VERA CONDITIONER 946ML US', 'purchase_price' => '597'),
    109 => array('SL_NO' => '110', 'article_number' => '30008637', 'article_description' => 'TRESEMME VITAMIN E CONDITIONER 946ML US', 'purchase_price' => '597'),
    110 => array('SL_NO' => '111', 'article_number' => '30008639', 'article_description' => 'TRESEMME VITAMIN B1 SHAMPOO 946ML', 'purchase_price' => '597'),
    111 => array('SL_NO' => '112', 'article_number' => '30008879', 'article_description' => 'GILLETTE MACH3 HD RAZOR+1 BLAD IN', 'purchase_price' => '237.79'),
    112 => array('SL_NO' => '113', 'article_number' => '30008883', 'article_description' => 'LOREAL KAJAL MAGIQUE BLACK 12H 0.35G IN', 'purchase_price' => '331.59'),
    113 => array('SL_NO' => '114', 'article_number' => '30008884', 'article_description' => 'SENSODYNE MOUTH WASH 300ML', 'purchase_price' => '404.95'),
    114 => array('SL_NO' => '115', 'article_number' => '30008886', 'article_description' => 'ORAL-B MOUTH WASH SENSITIVE 300ML', 'purchase_price' => '300'),
    115 => array('SL_NO' => '116', 'article_number' => '30008887', 'article_description' => 'AXE AFTER SHAVE CLICK 100ML', 'purchase_price' => '271.56'),
    116 => array('SL_NO' => '117', 'article_number' => '30008888', 'article_description' => 'AXE AFTER SHAVE DARK TEMPTATION 100ML', 'purchase_price' => '271.56'),
    117 => array('SL_NO' => '118', 'article_number' => '30008889', 'article_description' => 'AXE AFTER SHAVE AFRICA 100ML', 'purchase_price' => '271.56'),
    118 => array('SL_NO' => '119', 'article_number' => '30008890', 'article_description' => 'OLD SPICE AFTER SHAVE ORGNL SPRAY 150ML', 'purchase_price' => '492.61'),
    119 => array('SL_NO' => '120', 'article_number' => '30008985', 'article_description' => 'GARNIER FRUCTIS SHAMPOO GOODBY DAM 175ML', 'purchase_price' => '262.02'),
    120 => array('SL_NO' => '121', 'article_number' => '30008986', 'article_description' => 'GARNIER FRUCTIS COND GOODBY DAM 175ML', 'purchase_price' => '262.02'),
    121 => array('SL_NO' => '122', 'article_number' => '30008990', 'article_description' => 'GARNIER PURE ACTIVE FOAM MUL ACT 100ML', 'purchase_price' => '328.73'),
    122 => array('SL_NO' => '123', 'article_number' => '30008991', 'article_description' => 'GARNIER MEN TURBO LIGHT SCRUB ICY 100ML', 'purchase_price' => '328.73'),
    123 => array('SL_NO' => '124', 'article_number' => '30008992', 'article_description' => 'JOHNSON\'S BABY NAPPY CREAM 100ML', 'purchase_price' => '361.15'),
    124 => array('SL_NO' => '125', 'article_number' => '30009091', 'article_description' => 'FA ROLL ON  EXOTIC GARDEN FRESH 50ML', 'purchase_price' => '129.08'),
    125 => array('SL_NO' => '126', 'article_number' => '30009092', 'article_description' => 'FA ROLL ON  SENSITIVE EXTRA MILD 50ML', 'purchase_price' => '129.08'),
    126 => array('SL_NO' => '127', 'article_number' => '30009093', 'article_description' => 'FA BODY SPRAY CARE & PROTECT 200ML', 'purchase_price' => '181.25'),
    127 => array('SL_NO' => '128', 'article_number' => '30009096', 'article_description' => 'PALMOLIVE SHOWER GEL MINERAL MASSG 500ML', 'purchase_price' => '348'),
    128 => array('SL_NO' => '129', 'article_number' => '30009098', 'article_description' => 'FEVI STIK SUPER GLUE STICK 15G', 'purchase_price' => '45'),
    129 => array('SL_NO' => '130', 'article_number' => '30009099', 'article_description' => 'FEVICOL MR EASY FLOW WHITE ADHESIV 22.5G', 'purchase_price' => '27'),
    130 => array('SL_NO' => '131', 'article_number' => '30009100', 'article_description' => 'FEVICOL MR  WHITE ADHESIVE 50G', 'purchase_price' => '38'),
    131 => array('SL_NO' => '132', 'article_number' => '30009101', 'article_description' => 'FEVIGUM LIME PIDILITE 18ML', 'purchase_price' => '17.63'),
    132 => array('SL_NO' => '133', 'article_number' => '30009102', 'article_description' => 'RANGEELA PAPER GLITTER 6 SHADES 30ML', 'purchase_price' => '68'),
    133 => array('SL_NO' => '134', 'article_number' => '30009142', 'article_description' => 'GARNIER MEN TURBO LIGHT FOAM 100ML', 'purchase_price' => '303.6'),
    134 => array('SL_NO' => '135', 'article_number' => '30009143', 'article_description' => 'GARNIER MEN TURBO LIGHT COOL FOAM 100ML', 'purchase_price' => '303.6'),
    135 => array('SL_NO' => '136', 'article_number' => '30009144', 'article_description' => 'GARNIER MEN TUR LIGHT CHARCOL FOAM 100ML', 'purchase_price' => '303.6'),
    136 => array('SL_NO' => '137', 'article_number' => '30009146', 'article_description' => 'NIVEA MEN FACE WASH OIL CONTROL 100ML IN', 'purchase_price' => '300.3'),
    137 => array('SL_NO' => '138', 'article_number' => '30009148', 'article_description' => 'NIVEA MEN FACE WASH DRK SPOT REDCT 100ML', 'purchase_price' => '300.3'),
    138 => array('SL_NO' => '139', 'article_number' => '30009149', 'article_description' => 'NIVEA MEN FACE MOISTURIZER WHITNG 40ML', 'purchase_price' => '304.95'),
    139 => array('SL_NO' => '140', 'article_number' => '30009300', 'article_description' => 'GARNIER FRUCTIS SHAMPOO&COND 2IN1 250ML', 'purchase_price' => '273.53'),
    140 => array('SL_NO' => '141', 'article_number' => '30009301', 'article_description' => 'GARNIER FRUCTIS SHAMPOO COLOR LAST 250ML', 'purchase_price' => '273.53'),
    141 => array('SL_NO' => '142', 'article_number' => '30009302', 'article_description' => 'GARNIER FRUCTIS COND COLOUR LAST 250ML', 'purchase_price' => '273.53'),
    142 => array('SL_NO' => '143', 'article_number' => '30009303', 'article_description' => 'GARNIER FRUCTIS SHAMPOO REP & SHIN 250ML', 'purchase_price' => '273.53'),
    143 => array('SL_NO' => '144', 'article_number' => '30009304', 'article_description' => 'GARNIER FRUCTIS COND REPAIR & SHIN 250ML', 'purchase_price' => '273.53'),
    144 => array('SL_NO' => '145', 'article_number' => '30009305', 'article_description' => 'GARNIER FRUCTIS SHAMPOO SLEK &SHIN 250ML', 'purchase_price' => '273.53'),
    145 => array('SL_NO' => '146', 'article_number' => '30009306', 'article_description' => 'GARNIER FRUCTIS COND SLEEK & SHINE 250ML', 'purchase_price' => '273.53'),
    146 => array('SL_NO' => '147', 'article_number' => '30009307', 'article_description' => 'GARNIER FRUCTIS COND STRNGT & SHIN 250ML', 'purchase_price' => '273.53'),
    147 => array('SL_NO' => '148', 'article_number' => '30009308', 'article_description' => 'GARNIER FRUCTIS H.OIL GOODBYE DAM 200ML', 'purchase_price' => '226.8'),
    148 => array('SL_NO' => '149', 'article_number' => '30009422', 'article_description' => 'STAY COOL MOUTH SPRAY SPEARMINT 20ML GB', 'purchase_price' => '90.45'),
    149 => array('SL_NO' => '150', 'article_number' => '30009423', 'article_description' => 'STAY COOL MOUTH SPRAY COOL MINT 20ML GB', 'purchase_price' => '90.45'),
    150 => array('SL_NO' => '151', 'article_number' => '30010395', 'article_description' => 'PALMER\'S STRETCH MARKS CREAM 156G', 'purchase_price' => '411.6'),
    151 => array('SL_NO' => '152', 'article_number' => '30010396', 'article_description' => 'VICKS VAPORUB OINTMENT COLDS RELIEF 100G', 'purchase_price' => '330'),
    152 => array('SL_NO' => '153', 'article_number' => '30010397', 'article_description' => 'VICKS VAPORUB OINTMENT COLDS RELIEF 50G', 'purchase_price' => '225'),
    153 => array('SL_NO' => '154', 'article_number' => '30010398', 'article_description' => 'AXE BRAND UNIVERSAL OIL QUICK RELIF 56ML', 'purchase_price' => '392'),
    154 => array('SL_NO' => '155', 'article_number' => '30010399', 'article_description' => 'AXE BRAND UNIVERSAL OIL QUICK RELIF 28ML', 'purchase_price' => '275'),
    155 => array('SL_NO' => '156', 'article_number' => '30010400', 'article_description' => 'TIGER BALM RED OINTMENT 19.4G', 'purchase_price' => '147'),
    156 => array('SL_NO' => '157', 'article_number' => '30010599', 'article_description' => 'GILLETE ENDURANCE DEO STICK COL WAV 113G', 'purchase_price' => '318.48'),
    157 => array('SL_NO' => '158', 'article_number' => '30010600', 'article_description' => 'GILLETTE SPORT DEO STICK TRIUMPH 113G', 'purchase_price' => '318.48'),
    158 => array('SL_NO' => '159', 'article_number' => '30010601', 'article_description' => 'BRUT DEODORENT STICK 63G', 'purchase_price' => '200.89'),
    159 => array('SL_NO' => '160', 'article_number' => '30010602', 'article_description' => 'FINESSE ENHANCING SMPO & CNDITINER 384M', 'purchase_price' => '381.22'),
    160 => array('SL_NO' => '161', 'article_number' => '30010603', 'article_description' => 'FINESSE MOISTURIZING SHAMPOO 710M', 'purchase_price' => '730.09'),
    161 => array('SL_NO' => '162', 'article_number' => '30010604', 'article_description' => 'GILLETTE AFTER SHAVE LOTION COND 75M', 'purchase_price' => '342.95'),
    162 => array('SL_NO' => '163', 'article_number' => '30010605', 'article_description' => 'GILLETTE CLEAR GEL POWER RUSH 85G', 'purchase_price' => '235.2'),
    163 => array('SL_NO' => '164', 'article_number' => '30010670', 'article_description' => 'FA SOAP COMBO', 'purchase_price' => '218'),
    164 => array('SL_NO' => '165', 'article_number' => '30011095', 'article_description' => 'LOREAL GO 360 CLEAN SCRUB 178ML US', 'purchase_price' => '485.1'),
    165 => array('SL_NO' => '166', 'article_number' => '30011096', 'article_description' => 'CUBA EDT FOR MEN 35ML FR', 'purchase_price' => '395'),
    166 => array('SL_NO' => '167', 'article_number' => '30012078', 'article_description' => 'TRESEMME SHAMPOO PLATINUM STRENGTH 150ML', 'purchase_price' => '208.73'),
    167 => array('SL_NO' => '168', 'article_number' => '30012079', 'article_description' => 'TRESEMME CONDITIONER SPLIT RECOVERY 170M', 'purchase_price' => '208.73'),
    168 => array('SL_NO' => '169', 'article_number' => '30012080', 'article_description' => 'TRESEMME SHAMPOO SPLIT RECOVERY 150ML', 'purchase_price' => '214'),
    169 => array('SL_NO' => '170', 'article_number' => '30012081', 'article_description' => 'TRESEMME SHAMPOO HAIR FALL 190ML', 'purchase_price' => '240.41'),
    170 => array('SL_NO' => '171', 'article_number' => '30012082', 'article_description' => 'TRESEMME SHAMPOO KERATIN SMOOTH 170ML', 'purchase_price' => '234'),
    171 => array('SL_NO' => '172', 'article_number' => '30012083', 'article_description' => 'TRESEMME SHAMPOO SMOOTH & SHINE 190ML', 'purchase_price' => '240.41'),
    172 => array('SL_NO' => '173', 'article_number' => '30012084', 'article_description' => 'PIERRE CARDIN BODY SPRAY DEODORANT 128G', 'purchase_price' => '309.63'),
    173 => array('SL_NO' => '174', 'article_number' => '30012085', 'article_description' => 'PIERRE CARDIN POUR MONSIEUR 128G', 'purchase_price' => '309.63'),
    174 => array('SL_NO' => '175', 'article_number' => '30012086', 'article_description' => 'PIERRE CARDIN POUR HOMME 128G', 'purchase_price' => '309.63'),
    175 => array('SL_NO' => '176', 'article_number' => '30012087', 'article_description' => 'FA ROLL ON MEN PERFECT WAVE 50ML', 'purchase_price' => '129.08'),
    176 => array('SL_NO' => '177', 'article_number' => '30012088', 'article_description' => 'FA ROLL ON MYSTIC MOMENTS 50ML', 'purchase_price' => '129.08'),
    177 => array('SL_NO' => '178', 'article_number' => '30012089', 'article_description' => 'FA ROLL ON BLUE ROMANCE 50ML', 'purchase_price' => '129.08'),
    178 => array('SL_NO' => '179', 'article_number' => '30012090', 'article_description' => 'FA ROLL ON PURPLE PASSION 50ML', 'purchase_price' => '129.08'),
    179 => array('SL_NO' => '180', 'article_number' => '30012091', 'article_description' => 'OLD SPICE BODY SPRAY LAGOON 150ML', 'purchase_price' => '193.06'),
    180 => array('SL_NO' => '181', 'article_number' => '30012092', 'article_description' => 'OLD SPICE BODY SPRAY ICE ROCK 150ML', 'purchase_price' => '193.06'),
    181 => array('SL_NO' => '182', 'article_number' => '30012097', 'article_description' => 'JOHNSONS BABY SHAMPOO GERMEN TRIGO 500ML', 'purchase_price' => '416.48'),
    182 => array('SL_NO' => '183', 'article_number' => '30012098', 'article_description' => 'JOHNSONS BABY SHAMPOO LAVANDA 500ML', 'purchase_price' => '416.48'),
    183 => array('SL_NO' => '184', 'article_number' => '30012099', 'article_description' => 'JOHNSONS BABY SHAMPOO CAMOMILA 500ML', 'purchase_price' => '416.48'),
    184 => array('SL_NO' => '185', 'article_number' => '30012100', 'article_description' => 'JOHNSONS BABY LOTION EXTRACARE 200ML', 'purchase_price' => '230'),
    185 => array('SL_NO' => '186', 'article_number' => '30012101', 'article_description' => 'PEPSODENT TOOTHPEST STRAWBERY BUBBLE 50G', 'purchase_price' => '88.2'),
    186 => array('SL_NO' => '187', 'article_number' => '30012102', 'article_description' => 'PEPSODENT TOOTHPEST ORANGE FRUITY 50G', 'purchase_price' => '88.2'),
    187 => array('SL_NO' => '188', 'article_number' => '30012649', 'article_description' => 'VASELINE LOTION ALOE SOOTHE 600 ML', 'purchase_price' => '625'),
    188 => array('SL_NO' => '189', 'article_number' => '30012650', 'article_description' => 'VASELINE LOTION ADVANCED REPAIR 600 ML', 'purchase_price' => '590'),
    189 => array('SL_NO' => '190', 'article_number' => '30012651', 'article_description' => 'VASELINE LOTION MEN BODY & FACE 600 ML', 'purchase_price' => '590'),
    190 => array('SL_NO' => '191', 'article_number' => '30012652', 'article_description' => 'VASELINE LOTION ESSENTIAL HEALING 600 ML', 'purchase_price' => '625'),
    191 => array('SL_NO' => '192', 'article_number' => '30012653', 'article_description' => 'JOHNSONS BABY LOTION 500ML MY', 'purchase_price' => '435'),
    192 => array('SL_NO' => '193', 'article_number' => '30012654', 'article_description' => 'JOHNSONS BABY BATH 300 ML', 'purchase_price' => '215'),
    193 => array('SL_NO' => '194', 'article_number' => '30013078', 'article_description' => 'MOTHERCARE BABY LOTION PINK 500 ML', 'purchase_price' => '535'),
    194 => array('SL_NO' => '195', 'article_number' => '30013079', 'article_description' => 'MOTHERCARE BABY TOP TO TOE WASH 500 ML', 'purchase_price' => '535'),
    195 => array('SL_NO' => '196', 'article_number' => '30013080', 'article_description' => 'MOTHERCARE BABY GOODBYE TERS SHMPO 500ML', 'purchase_price' => '535'),
    196 => array('SL_NO' => '197', 'article_number' => '30013081', 'article_description' => 'MOTHERCARE BABY BUBBLE BATH 500 ML', 'purchase_price' => '535'),
    197 => array('SL_NO' => '198', 'article_number' => '30013082', 'article_description' => 'JOHNSON\'S BABY TOP 2 TOE MOIST. CRM 100M', 'purchase_price' => '325'),
    198 => array('SL_NO' => '199', 'article_number' => '30013083', 'article_description' => 'JOHNSON\'S BABY LOTION ANTI-MOSQUITO 100M', 'purchase_price' => '416.47'),
    199 => array('SL_NO' => '200', 'article_number' => '30013084', 'article_description' => 'JOHNSON\'S BABY BATH 500ML', 'purchase_price' => '390.02'),
    200 => array('SL_NO' => '201', 'article_number' => '30013085', 'article_description' => 'JOHNSON\'S BABY BATH MILK+RICE  500ML', 'purchase_price' => '430'),
    201 => array('SL_NO' => '202', 'article_number' => '30013093', 'article_description' => 'JOHNSON\'S BABY TOP TO TOE WASH 100ML MY', 'purchase_price' => '110'),
    202 => array('SL_NO' => '203', 'article_number' => '30013094', 'article_description' => 'JOHNSON\'S BABY MILK LOTION 100ML IN', 'purchase_price' => '138'),
    203 => array('SL_NO' => '204', 'article_number' => '30013095', 'article_description' => 'JOHNSON\'S BABY LOTION 500ML TH', 'purchase_price' => '575'),
    204 => array('SL_NO' => '205', 'article_number' => '30013749', 'article_description' => 'LISTERINE MOUTH WASH TOTAL CARE 500ML TH', 'purchase_price' => '410'),
    205 => array('SL_NO' => '206', 'article_number' => '30013750', 'article_description' => 'JOHNSONIS BABY OLEO  ALOE VERA 500ML IT', 'purchase_price' => '440'),
    206 => array('SL_NO' => '207', 'article_number' => '30013751', 'article_description' => 'JOHNSONIS BABY LOTION 100ML MY', 'purchase_price' => '145'),
    207 => array('SL_NO' => '208', 'article_number' => '30013752', 'article_description' => 'JOHNSONIS BABY SFT&SHINY SHAMPO 200ML TH', 'purchase_price' => '220'),
    208 => array('SL_NO' => '209', 'article_number' => '30013753', 'article_description' => 'JOHNSONIS BABY OIL 125ML MY', 'purchase_price' => '160'),
    209 => array('SL_NO' => '210', 'article_number' => '30013754', 'article_description' => 'JOHNSONIS BABY LOTION 200ML ID', 'purchase_price' => '264'),
    210 => array('SL_NO' => '211', 'article_number' => '30013755', 'article_description' => 'JOHNSONIS SOFT & SMOOTH POWDER  200ML TH', 'purchase_price' => '175'),
    211 => array('SL_NO' => '212', 'article_number' => '30013756', 'article_description' => 'CLEAN & CLEAR FCIAL CLNSR BERRY 100ML TH', 'purchase_price' => '180'),
    212 => array('SL_NO' => '213', 'article_number' => '30013757', 'article_description' => 'CLEAN & CLEAR FCIAL CLNSR LMN  100ML TH', 'purchase_price' => '180'),
    213 => array('SL_NO' => '214', 'article_number' => '30013758', 'article_description' => 'CLEAN & CLEAR FCIAL CLNSR APLE  100ML TH', 'purchase_price' => '180'),
    214 => array('SL_NO' => '215', 'article_number' => '30013970', 'article_description' => 'PEPSODENT TRIPLE CLEAN FAMILI TOOTH BRUS', 'purchase_price' => '65'),
    215 => array('SL_NO' => '216', 'article_number' => '30013971', 'article_description' => 'PEPSODENT ACTION 123 TOOTH BRUSH MEDIUM', 'purchase_price' => '92'),
    216 => array('SL_NO' => '217', 'article_number' => '30013972', 'article_description' => 'PEPSODENT ACTION 123 TOOTH BRUSH SOFT', 'purchase_price' => '92'),
    217 => array('SL_NO' => '218', 'article_number' => '30013973', 'article_description' => 'PEPSODENT VERTICAL EXPERT TOOTH BRUSH', 'purchase_price' => '143'),
    218 => array('SL_NO' => '219', 'article_number' => '30013974', 'article_description' => 'SENSODYNE  PRECISION TOOTH BRUSH', 'purchase_price' => '65'),
    219 => array('SL_NO' => '220', 'article_number' => '30013976', 'article_description' => 'JOHNSONS BABY MILK SOAP 100G', 'purchase_price' => '64'),
    220 => array('SL_NO' => '221', 'article_number' => '30013977', 'article_description' => 'JOHNSONS BABY MOISTURIZER SOAP 100G', 'purchase_price' => '64'),
    221 => array('SL_NO' => '222', 'article_number' => '30013978', 'article_description' => 'PONDS ACNE CLEAR WHITE FOAM 100ML', 'purchase_price' => '258'),
    222 => array('SL_NO' => '223', 'article_number' => '30013979', 'article_description' => 'PONDS WHITE BEAUTY PEARL CLEANSING GEL 1', 'purchase_price' => '258'),
    223 => array('SL_NO' => '224', 'article_number' => '30013980', 'article_description' => 'PONDS CLEAR SOLUTION FACIAL SCRUB 100G', 'purchase_price' => '258'),
    224 => array('SL_NO' => '225', 'article_number' => '30013981', 'article_description' => 'DOVE CARING PROTECTION BODY WASH 250ML', 'purchase_price' => '208'),
    225 => array('SL_NO' => '226', 'article_number' => '30013982', 'article_description' => 'DOVE GO FRESH BODY WASH 250ML', 'purchase_price' => '208'),
    226 => array('SL_NO' => '227', 'article_number' => '30013983', 'article_description' => 'DOVE PURELY PAMPERING BODY WASH 250ML', 'purchase_price' => '208'),
    227 => array('SL_NO' => '228', 'article_number' => '30014282', 'article_description' => 'MOTHER CARE BABY NAPY CREM 150ML JR GB', 'purchase_price' => '590'),
    228 => array('SL_NO' => '229', 'article_number' => '30014283', 'article_description' => 'MOTHER CARE BABY MILK BATH 300 ML GB', 'purchase_price' => '500'),
    229 => array('SL_NO' => '230', 'article_number' => '30014284', 'article_description' => 'MOTHER CARE BABY SHAMPOO 300 ML GB', 'purchase_price' => '500'),
    230 => array('SL_NO' => '231', 'article_number' => '30014285', 'article_description' => 'MOTHER CARE BABY POWDER 150 GM GB', 'purchase_price' => '500'),
    231 => array('SL_NO' => '232', 'article_number' => '30014445', 'article_description' => 'PINK MAGIC LIP', 'purchase_price' => '26'),
    232 => array('SL_NO' => '233', 'article_number' => '30014446', 'article_description' => 'BABY CLR LIP BALM CHERRY KISS 4.5G TH', 'purchase_price' => '74'),
    233 => array('SL_NO' => '234', 'article_number' => '30014447', 'article_description' => 'BABY CLR LIP BALM PINK LOLITA 4.5G TH', 'purchase_price' => '74'),
    234 => array('SL_NO' => '235', 'article_number' => '30014448', 'article_description' => 'BABY  ELECTRO POP CLR 3.5G LIP BALM TH', 'purchase_price' => '88'),
    235 => array('SL_NO' => '236', 'article_number' => '30014449', 'article_description' => 'BABY ELECTRO POP BERRY 3.5G LIP BALM TH', 'purchase_price' => '88'),
    236 => array('SL_NO' => '237', 'article_number' => '30014450', 'article_description' => 'BABY  ELCTRO POP NO CLR LIP BALM 3.5G TH', 'purchase_price' => '88'),
    237 => array('SL_NO' => '238', 'article_number' => '30014451', 'article_description' => 'WINTER LV MAN DP HYDRATING LIP BALM 5.6G', 'purchase_price' => '62'),
    238 => array('SL_NO' => '239', 'article_number' => '30014452', 'article_description' => 'WINTER LV MAN PSTV ENERGY LIP BALM TH', 'purchase_price' => '62'),
    239 => array('SL_NO' => '240', 'article_number' => '30014453', 'article_description' => 'ROSE LIP OIL TH', 'purchase_price' => '110'),
    240 => array('SL_NO' => '241', 'article_number' => '30014454', 'article_description' => 'NIVEA LIP  STAR FRUIT STRAWBWRRY 2.4G TH', 'purchase_price' => '42'),
    241 => array('SL_NO' => '242', 'article_number' => '30014455', 'article_description' => 'NIVEA LIP FRUIT SHINE BERRY 4.8G TH', 'purchase_price' => '78'),
    242 => array('SL_NO' => '243', 'article_number' => '30014456', 'article_description' => 'NIVEA LIP  FRUIT SHINE CHERRY 4.8G TH', 'purchase_price' => '78'),
    243 => array('SL_NO' => '244', 'article_number' => '30014457', 'article_description' => 'LABELLO FRUITY SHINE 4.8G TH', 'purchase_price' => '70'),
    244 => array('SL_NO' => '245', 'article_number' => '30014458', 'article_description' => 'LABELLO SOFT ROSE  4.8G TH', 'purchase_price' => '70'),
    245 => array('SL_NO' => '246', 'article_number' => '30014459', 'article_description' => 'LABELLO HYDRO CARE 4.8G TH', 'purchase_price' => '70'),
    246 => array('SL_NO' => '247', 'article_number' => '30014460', 'article_description' => 'LABELLO PEARLY SHINE 4.8G TH', 'purchase_price' => '58'),
    247 => array('SL_NO' => '248', 'article_number' => '30014461', 'article_description' => 'LABELLO CLASSIC CARE 4.8G TH', 'purchase_price' => '70'),
    248 => array('SL_NO' => '249', 'article_number' => '30014463', 'article_description' => 'JERGENS MUSK  LOTION 400ML AE', 'purchase_price' => '455'),
    249 => array('SL_NO' => '250', 'article_number' => '30014464', 'article_description' => 'JERGENS MUSK  LOTION 200ML AE', 'purchase_price' => '245'),
    250 => array('SL_NO' => '251', 'article_number' => '30014491', 'article_description' => 'VASELINE  PROTECTIVE BABY JELLY 250 ML', 'purchase_price' => '290'),
    251 => array('SL_NO' => '252', 'article_number' => '30014492', 'article_description' => 'VASELINE PROTECTIVE BABY JELLY 100 ML', 'purchase_price' => '175'),
    252 => array('SL_NO' => '253', 'article_number' => '30014493', 'article_description' => 'VASELINE MEN PETROLEUM JELLY  250 ML', 'purchase_price' => '297'),
    253 => array('SL_NO' => '254', 'article_number' => '30014494', 'article_description' => 'VASELINE MEN PETROLEUM JELLY  100 ML', 'purchase_price' => '180'),
    254 => array('SL_NO' => '255', 'article_number' => '30014495', 'article_description' => 'VASELINE HEALTHY PETROLEUM JELLY  250 ML', 'purchase_price' => '297'),
    255 => array('SL_NO' => '256', 'article_number' => '30014496', 'article_description' => 'VASELINE HEALTHY PETROLEUM JELLY 100 ML', 'purchase_price' => '180'),
);
    }


}