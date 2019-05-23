@extends('_layouts.default')
@section('content')
    <?php 
        $amount=0;
        if(Session::get('saleItems')){
            foreach(Session::get('saleItems') as $item)
            $amount=$amount+$item['total'];
        }
        $invoicesInQueue=count(Session::get('saleInvoiceQueue'));
    ?>
        @if(Session::get('saleInvoiceQueue'))
        <div id="sticky">
        <ul id="example-1" class="sticklr stick-que">
            <li>
                <a href="javascript:;" title="Sales Queue">{{ HTML::image('img/nav_icon/purchase.png', 'title', array('class' => 'sticky_icon')) }} <span class="notification-count">{{$invoicesInQueue}}</span></a>
                <ul style="">
                    <li class="sticklr-title">
                        <a href="#">Queue List</a>
                    </li>
                    @foreach(Session::get('saleInvoiceQueue') as $customer => $invoice)
                    <li>
                        {{ Form::open(array('route' => 'sale.reloadDeleteInvoiceQueueElement', 'id' => 'formReloadDeleteInvoiceQueueElement', 'class' => 'form-horizontal')) }}
                            {{$customer}}
                            <input type="hidden" name="customer" value="{{$customer}}">
                           <span id="btn-queue">
                            <button type="submit" class="btn btn-info btn-small" name="reloadDelete"  onclick="isSureToReloadInvoiceFromQueue();"><i class="setup-icon icon-undo"></i></button>
                            <!-- <a class="btn btn-success btn-small" ><i class="setup-icon icon-print"></i></a> -->
                            <button type="submit"  class="btn btn-warning btn-small" name="reloadDelete" value="delete"  onclick="return isSureToDeleteInvoiceFromQueue();"><i class="icon-remove"></i></button>
                           </span>
                        {{ Form::close() }}
                    </li>
                    @endforeach
                </ul>
            </li>             
        </ul>  
        </div>
        @endif
    <div class="row">
        <div class="span8">
            <div style="height:24px;" class='label label-info'>
            <h4><i class='icon-shopping-cart'></i> Sales Register 
            @if(Session::get('saleItems'))
                <a style="float:right;"  id="addInvoiceToQueue" role="button" data-toggle="modal" onclick="addInvoiceToQueue();" class="btn btn-success btn-small">Hold this invoice</a>
                <a style="float:right;"  class="btn btn-warning btn-small" href="{{route('sale.emptyCart')}}">Clear Screen</a>
            @endif
            <span id='topTotalQuantity' class='label label-warning' style='font-size:22px; border-radius:90px;'></span>
            <a href="{{route('sale.salesOrder')}}" class="btn btn-small btn-success" style="margin-left: 50px;">
                <i class='icon-forward'></i> Go to Sales Order
            </a> 
            </h4> 
            </div>
            <table class="table table-bordered" width="100%">
                <thead class="table-head">
                    <tr>
                        <th>SL</th>
                        <th colspan="2" style="width: 200px;">Item Name</th>
                        <th>Sale Qty.</th>      
                        <th>Available Qty.</th>
                        <th>Sale Price</th>
                        <th style="width: 50px;">Total</th>
                        <th style="width: 90px;">Action</th>
                    </tr>
                </thead>
                <tbody class="addTr">
                    <?php 
                        $i=0; $invoice_total=0; 
                        if(Session::get('saleItems')){
                            $reverse_items= Session::get('saleItems');
                        }
                        $totalQuantity = 0;
                        $totalPoint = 0;
                    ?>
                    @if(Session::get('saleItems'))
                        @foreach($reverse_items as $key => $item)
                            <? $invoice_total=$invoice_total+$item['total'];
                            $totalQuantity+=$item['sale_quantity'];
                            //$totalPoint = $totalPoint + ($item['item_point'] * $item['sale_quantity']);
                            ?>
                            {{ Form::open(array('route' => 'sale.editDeleteItem', 'class' => 'form-horizontal formEditDelete')) }}
                                <tr>                            
                                    <td id="sl_{{$key+1}}">{{++$i}}</td>
                                    <td colspan="2" style="width: 200px;">
                                        <span class="span3">
                                            {{$item['item_name']}}
                                            <input type="hidden" name="key" value="{{$item['key']}}">
                                            <input type="hidden" name="item_id" value="{{$item['item_id']}}">
                                            <input type="hidden" name="price_id" value="{{$item['price_id']}}">
                                            <input type="hidden" name="item_name" value="{{$item['item_name']}}">
                                            <input type="hidden" id="availableQuantity_{{$key}}" name="available_quantity" value="{{$item['available_quantity']}}">
                                        </span>
                                    </td>
                                    <td>
                                        <div class="span2">
                                            <label>PCS</label>
                                            <input class="span1 saleQuanty" id="pcs_{{$key}}" type="text" name="sale_quantity"  autocomplete="off" value="{{$item['sale_quantity']}}"/>
                                            <input class="span1 floatingCheck" type="text" name="discount" id="discount_{{$key}}" autocomplete="off" value="{{$item['discount']}}" readonly="" style="display: none;" />
                                        </div>
                                    </td>
                                    <td>
                                        @if($item['sale_quantity']==0)
                                                <input class="span1 available_quantity" style="background-color:red; color:#fff;"  type="text" readonly name="available_quantity" value="{{$item['available_quantity']}}" />
                                            @else
                                                <input class="span1 available_quantity"  type="text" readonly name="available_quantity" value="{{$item['available_quantity']}}" />
                                        @endif
                                    </td>
                                    <td>
                                        <input class="span1 price_change saleQuanty" type="text" name="sale_price" id="price_{{$key}}" value="{{$item['sale_price']}}" readonly="" />
                                        <input type="hidden" name="purchase_price" id="purchasePrice_{{$key}}" value="{{$item['purchase_price']}}" />
                                    </td>
                                    <td>
                                        <input type="text" name="total" id="total_{{$key}}"  class="span1 disabled" disabled="" value="{{$item['total']}}" />
                                    </td>
                                    <td class="span2" style="width: 90px;">
                                        <button style="display:none;" type="submit" class="edit btn btn-primary" name="edit_delete" value="edit"><i class="icon-edit"></i></button>
                                        <button type="submit" class="btn btn-warning btn-delete" id="delete_{{$key}}" name="edit_delete"><i class="icon-trash"></i></button>
                                    </td>
                                </tr>
                            {{ Form::close() }}
                        @endforeach
                    @endif
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="8" style="text-align:center; color:#E98203;">
                        <strong>Total Item : <span id="cartAddedQty">{{count(Session::get('saleItems'))}}</span></strong>
                        <input type='hidden' id='toalQuantity' value='{{ $totalQuantity }}'>
                        <td>
                    </tr>
                </tfoot>
            </table>
            <div class="invoice-reg"><input type="hidden" id="max_dis_percent" value="{{Session::get('max_inv_dis_percent');}}">
                <!-- {{Session::get('max_inv_dis_percent');}}!-->
                @include('_sessionMessage')
                {{ Form::open(array('route' => 'sale.addItemToChart', 'id' => 'formItemLocation', 'class' => 'form-horizontal itemAddCartForm')) }}
                    <div class="control-group">
                        {{ Form::label('search_item', 'Find/Scan Item', ['class' => 'control-label', 'style' => 'font-weight:bold;margin-top:7px;font-size:18px;']) }}
                        <div class="controls">
                            {{ Form::text('item_id', null, array('class' => 'span6 item_id','autofocus'=>'yes','id'=>'auto_search_item', 'placeholder' => 'Start Typing item\'s name or scan barcode...','style' => 'height: 30px;border: 1px solid #125f0d;')) }}
                             <input type="hidden" name="com" id="company" value="{{Session::get('sale_invoice_info.cus_id')}}">
                        </div> <!-- /controls -->
                    </div> <!-- /control-group -->
                {{ Form::close() }}
            </div>
        </div>
        <div class="span4" style="/*position: fixed;*/ left: 858px;">
            <div class="invoice-right">
                {{ Form::open(array('route' => 'sale.selectDeleteCustomer','autocomplete'=>'off', 'id' => 'customerForm', 'style' => 'margin : 0 0 9px !important;')) }}
                    
                                <!-- <input type="hidden" name="com" id="company" value="{{Session::get('sale_invoice_info.full_name')}}"> -->
                    @if(Session::get('sale_invoice_info.user_name'))                                        
                        <div class="control-group hr">
                            <label class="control-label" for="supplier_name"><strong style="font-size: 1.1em;"><u>Customer</u></strong></label>
                            <div class="controls">
                                <table class="table table-striped" style="margin: 0; padding:0;">
                                    <tbody> 
                                        <tr>
                                            <td>Customer Name</td>
                                            <td>:</td>
                                            <td><strong id="customer_name" style="color: green; font-size: 1.4em;">
                                                {{Session::get('sale_invoice_info.full_name')}}
                                                <input type="hidden" id="customer" value="{{Session::get('sale_invoice_info.user_name')}}">
                                                <input type="hidden" id="cust_type_discount_percent" value="0">
                                            </strong>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <button type="submit" style="margin: 3px 0 3px" class="btn btn-warning" name="customer" value="delete"><i class="icon-trash"></i> &nbsp;Remove</button>
                            </div> <!-- /controls -->
                        </div>
                    @else
                        

                        <div class="control-group hr">
                            <label class="control-label" for="supplier"><b style="font-size: 22px; color: red;">Select Customer</b></label>
                            <div class="controls">
                                {{Form::text('national_id', null, array('class' => 'span3', 'id' => 'customerAutoSugg', 'placeholder' => 'Start Typing Customer\'s name...'))}}
                                <input type="hidden" id="customer" value="">
                            </div> <!-- /controls -->
                        </div>
                    @endif
                {{ Form::close() }}
                <div>
                    {{ Form::open(array('route' => 'sale.invoiceAndSale','autocomplete'=>'off', 'class' => 'form-horizontal', 'style' => 'margin : 0 0 1px !important;')) }}
                    <div class="control-group hr">
                        <label class="control-label" for="company" style="width: 115px; float: left; margin-top: 5px;"><b style="font-size: 14px; color: green; margin-left: 5px;">Select Company</b></label>
                        <div class="controls" style="margin-left: 0px;">
                            <!-- {{ Form::Label('item', 'Item:') }} -->
                            {{ Form::select('com_id', $subCompanies, Session::get('sale_order_invoice_info.com_id'), ['class' => 'form-control']) }}
                        </div> <!-- /controls -->
                    </div>
                    <table class="table table-striped" style="margin: 0; padding:0;">
                        <tbody>
                        @if(Session::get('sale_invoice_info.full_name') == 'Other')
                        <tr>
                            <td>Customer Name</td>
                            <td>:</td>
                            <td><input type="text" name="customer_name" placeholder="Customer Name Here"></td>
                        </tr>
                        @endif
                        <tr>
                            <td>Branch </td>
                            <td>:</td>
                            <td style="padding:0;">
                                <span> {{Helper::getBranchName()}}</span>
                            </td>
                        </tr>
                        @if(Session::get('backdate_sales')==0)
                        <input name="date" type="hidden" value="<?= date("Y-m-d") ?>">
                        @else
                            <tr>
                                <td>Date </td>
                                <td>:</td>
                                <td style="padding:0;">
                                    <input id="dp3" name="date" data-date="<?= date("Y-m-d") ?>" data-date-format="yyyy-mm-dd" class="datepicker span2" type="text" value="<?= date("Y-m-d") ?>">
                                </td>
                            </tr>
                            @endif
                            <tr>
                                <td>Payment Type</td>
                                <td>:</td>
                                <td style="padding:0;">
                                    {{ Form::select('payment_type_id', $payment_type, 1, ['class' => 'span3', 'style' => 'margin-top: 3px;']) }}
                                </td>
                            </tr>
                            <tr>
                                <td>P:O No</td>
                                <td>:</td>
                                <td style="padding: 0;">
                                    <input class="form-control" type="text" name="po_no" value="{{Session::get('sale_order_invoice_info.po_no')}}">
                                </td>
                            </tr>
                            <tr>
                                <td>Branch Name</td>
                                <td>:</td>
                                <td style="padding: 0;">
                                    <input class="form-control" type="text" name="branch_name" value="{{Session::get('sale_order_invoice_info.branch_name')}}">
                                </td>
                            </tr>
                            <tr>
                                <td>Supply Code </td>
                                <td>:</td>
                                <td style="padding: 0;">
                                    <input class="form-control" type="text" name="supply_code" value="{{Session::get('sale_order_invoice_info.supply_code')}}">
                                </td>
                            </tr>
                            <tr>
                                <td>Sub Total Amount</td>
                                <td>:</td>
                                <td><strong id="total_amount" style="color: green; font-size: 1.4em;">{{$invoice_total}}</strong></td>
                            </tr>
                            <tr>
                                <td>Discount</td>
                                <td>:</td>
                                <td style="padding:0;">
                                    <input style="margin-top: 3px; width:95px;" type="text" maxlength="5" readonly id="dis_percent" name="discount_percent" data-toggle="tooltip" title="Discount (%)" value="%"  placeholder="Discount(%)">&nbsp;&nbsp;
                                    <input style="margin-top: 3px; width:95px;"  type="text" maxlength="10" id="dis_taka" name="invoice_discount"  data-toggle="tooltip" title="Discount (Tk.)" placeholder="Discount(Taka)" value="0">
                                </td>
                            </tr>
                            <tr>
                                <td>Total Amount (Tk)</td>
                                <td>:</td>
                                <td><strong id="pay_amount" style="color: red; font-size: 2.4em; font-family:Times;">
                                @if(Session::get('sale_invoice_info.user_name'))
                                <?php
                                    $amountTaka = $invoice_total-Session::get('invoice_info.invoice_discount');
                                    echo $amountTaka;
                                ?>
                                @else
                                {{$invoice_total-Session::get('invoice_info.invoice_discount')}}
                                @endif
                                </strong></td>
                            </tr>
                            <tr>
                                <td>Pay</td>
                                <td>:</td>
                                <td style="padding:0;">
                                    <div class="input-prepend input-append">
                                        <input class="span2" type="text" id="appendedPrependedInput" maxlength="10" class="span2" name="pay" value="{{$amount}}">
                                        <!--<input class="span2" type="text" id="appendedPrependedInput" maxlength="10" class="span2" name="pay" value="">-->
                                    </div>
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td>Pay Note</td>
                                <td>:</td>
                                <td style="padding:0;">
                                    <input type="text" class="span2" id="paynote" autocomplete="off" maxlength="10" name="paynote" value="">
                                </td>
                            </tr>
                            <tr>
                                <td>Due</td>
                                <td>:</td>
                                <td><strong id="due" style="color: green; font-size: 1.4em;">0.00</strong></td>
                            </tr>
                            @if(Session::has('sale_invoice_info.customer_due'))
                            @if(Session::get('sale_invoice_info.customer_due') > 0)
                            <tr>
                                <td>Previous Due</td>
                                <td>:</td>
                                <td><strong id="due" style="color: green; font-size: 1.4em;">{{Session::get('sale_invoice_info.customer_due')}}</strong></td>
                            </tr>
                            @endif
                            @endif
                        </tbody>
                    </table>
                    <div style="text-align: left; margin-left: 10px;">
                        <button type="submit" class="btn btn-danger" onclick="return isUnRegisteredCustomer();">Complete Sale</button>
                    </div>
                    {{ Form::close() }}
                </div>
            </div>
        </div>
    </div>
    {{ HTML::script('js/jquery-ui.min.js') }}
    @include('sale.saleFormAjaxRequest')
    <div id="addInvoiceToQueueModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="addInvoiceToQueueModalLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&#735;</button>
            <h3 id="itemEditModalLabel"><i class="icon-edit-sign"></i>&nbsp; Add Invoice To Queue</h3>
        </div>
        <div class="modal-body" id="addInvoiceToQueueModalBody">
                {{ Form::open(array('route' => 'sale.addInvoiceToQueue.post', 'id' => 'formAddInvoiceToQueue', 'class' => 'form-horizontal')) }}
                <div class="control-group">     
                    {{ Form::label('Customer', 'Customer', ['class' => 'control-label']) }}
                    <div class="controls">
                        {{ Form::text('customer', null, array('class' => 'span3', 'placeholder' => 'Enter Customer Name or Mobile','autofocus'=>'yes')) }}
                    </div> <!-- /controls -->                   
                </div> <!-- /control-group -->  
                <div class="modal-footer">
                    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
                    {{ Form::submit('Save', array('class' => 'btn btn-primary')) }}
                </div>
                {{ Form::close() }}
        </div>
    </div>
    <script>
    $(function(){
        var formAddInvoiceToQueue = $('#formAddInvoiceToQueue');

        formAddInvoiceToQueue.validate({
          rules: {
           customer: {
               required: true
            }
          }, messages: {
            },
            ignore: ':hidden'   
        });
    });
$(window).load(function(){
        salesInit();
        $('#topTotalQuantity').html($('#toalQuantity').val());
    });
    function salesInit() {
        shortcut.add("Alt+c", function() {
            window.location = "{{route('sale.emptyCart')}}";
        });
        shortcut.add("Alt+f", function() {
            $("#paynote").focus();
            //window.location = "{{route('sale.emptyCart')}}";
        });
    }
</script>
@stop
@section('stickyInfo')
<div id="sticky" style="text-align: center;">        
	<ul id="example-3" class="sticklr" style="margin-left:5px;color:#ffffff;background-color: #053a64;font-size:18px;font-family:monospace;">
		<li>S</li><li>a</li><li>l</li><li>e</li><li>s</li>
	</ul>       
</div>
@stop