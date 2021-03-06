<script>
        $().ready(function(){
            //Auto Complete for Item Search
            $("#auto_search_item").autocomplete("{{route('sale.itemAutoSuggest')}}", {
                width: 260,
                matchContains: true,
                queryDelay : 0,
                formatItem: function(row) {
                    return row[1];
                },
            });
            //Submit Search Item Form
            $("#auto_search_item").result(function(event, data, formatted) {
                $("#formItemLocation").submit();
            });
            //Customer auto suggest
            $("#customerAutoSugg").autocomplete("{{route('sale.autoCustomerSuggest')}}", {
                width: 260,
                matchContains: true,
                queryDelay : 0,
                formatItem: function(row) {
                    return row[1];
                }
            });
            //Submit Supplier Form
            $("#customerAutoSugg").result(function(event, data, formatted) {
                $("#customerForm").submit();
            });
            //Discount Calculate for percent
            var totalAmount = parseFloat($("#total_amount").html());
            if(totalAmount>=1000){
                autoDiscountCalculation(totalAmount);
            }
            function autoDiscountCalculation(totalAmount){
                var discountPercent= parseFloat($("#cust_type_discount_percent").val());
                 if(discountPercent>0){
                     var discountAmount= ((totalAmount*discountPercent)/100).toFixed(0);
                     $("#dis_percent").val(discountPercent+" %");
                     $("#dis_taka").val(discountAmount);
                     $("#pay_amount").html(totalAmount-discountAmount);
                     $("#appendedPrependedInput").val(totalAmount-discountAmount);
                 }
            }

            $('.itemAddCartForm').on('submit', function(e){
                e.preventDefault();
                var self = $(this);
                var token = $(this).serializeArray()[0].value;
                var item_id = $('.item_id').val();
                if(item_id == ''){
                    alert('Select an item please.');
                    return false;
                }
                $.ajaxSetup({
                    headers: { 'X-CSRF-Token' : token }
                });
                var content = '';
                $.ajax({
                    url      : "{{url('sale/addItemToOrderChart')}}",
                    type     : "POST",
                    cache    : false,
                    dataType : 'json',
                    data     : {item_id: item_id,_token:token},
                    success  : function(data){
                        var i = 1;
                        if(data.success == true && data.append_flag === false){
                            content += '<tr>'+                       
                                '<td>'+(data.allItem)+'</td>'+
                                '<td>'+
                                    '<span class="span3">'+data.item.item_name+
                                        '<input type="hidden" name="key" value="'+data.item.key+'">'+
                                        '<input type="hidden" name="item_id" value="'+data.item.item_id+'">'+
                                        '<input type="hidden" name="price_id" value="'+data.item.price_id+'">'+
                                        '<input type="hidden" name="item_name" value="'+data.item.item_name+'">'+
                                        '<input type="hidden" id="pcsPerCarton_'+data.item.key+'" name="pcs_per_carton" value="'+data.item.pcs_per_carton+'">'+
                                    '</span>'+
                                '</td>';
                                var setStyle = "";
                                var dozzStyle = "";
                                if(data.item.unit == 1 || data.item.unit == 3) {
                                    dozzStyle = 'style="float: left; margin-right: 20px; display: none"';
                                // console.log(dozzStyle);
                                }else if(data.item.unit == 2){
                                    dozzStyle = 'style="float: left; margin-right: 20px;"';
                                }
                                if(data.item.unit == 1 || data.item.unit == 2) {
                                    setStyle = 'style="float: left; margin-right: 20px; display: none"';
                                }else if(data.item.unit == 3){
                                    setStyle = 'style="float: left; margin-right: 20px;"';
                                }
                                content += '<td colspan="2">'+
                                    '<div class="span3">'+
                                        '<div class="span1" style="float: left; margin-right: 20px;"><label>PCS</label>'+
                                            '<input style="width: 100%;" class="span1 saleQuanty" id="pcs_'+data.item.key+'" type="text" name="sale_quantity"  autocomplete="off" value="'+data.item.sale_quantity+'"/></div>'+
                                        '<div '+dozzStyle+' class="span1"><label>Dozz</label><input style="width: 100%;" id="saleQuantityDozz_'+data.item.key+'"" class="span1 saleQuanty" type="text" name="sale_quantity_dozz"  autocomplete="off" value="'+data.item.dozz.toFixed(4)+'" /></div>'+
                                        '<div '+setStyle+' class="span1"><label>Set</label><input style="width: 100%;" id="saleQuantitySet_'+data.item.key+'" class="span1 saleQuanty" type="text" name="sale_quantity_set"  autocomplete="off" value="'+data.item.set.toFixed(4)+'" /></div>'+
                                        '<div style="float: left;" class="span1"><label>Carton</label><input style="width: 100%;" id="saleQuantityCarton_'+data.item.key+'" class="span1 saleQuanty" type="text" name="sale_quantity_carton"  autocomplete="off" value="'+data.item.carton.toFixed(4)+'" /></div>'+
                                    '</div>'+
                                        '<input class="span1 floatingCheck" type="text" id="discount_'+data.item.key+'" name="discount" autocomplete="off" value="'+data.item.discount+'" readonly="" style="display: none;" />'+
                                '</td> <td>';
                                if (parseInt(data.item.sale_quantity) == 0) {
                                    content += '<input class="span1 available_quantity" id="availableQuantity_'+data.item.key+'" style="background-color:red; color:#fff;"  type="text" readonly name="available_quantity" value="'+data.item.available_quantity+'" />';
                                }else{
                                    content += '<input class="span1 available_quantity" id="availableQuantity_'+data.item.key+'"  type="text" readonly name="available_quantity" value="'+data.item.available_quantity+'" />';
                                }
                                content += '</td> <td>'+
                                    '<input class="span1 price_change saleQuanty" type="text" id="price_'+data.item.key+'" name="sale_price" value="'+data.item.sale_price+'" />'+
                                    '<input type="hidden" id="purchasePrice_'+data.item.key+'" name="purchase_price" value="'+data.item.purchase_price+'" />'+
                                '</td>'+
                                '<td>'+
                                    '<input type="text" name="total" id="total_'+data.item.key+'" class="span1 disabled" disabled="" value="'+data.item.total+'" />'+
                                '</td>'+
                                '<td class="span2" style="width: 90px;">'+
                                    '<button type="submit" style="display:none;" class="edit btn btn-primary" name="edit_delete" value="edit"><i class="icon-edit"></i></button>'+
                                    '<button type="submit" class="btn btn-warning btn-delete" id="delete_'+data.item.key+'" name="edit_delete"><i class="icon-trash"></i></button>'+
                                '</td>'+
                            '</tr>';
                            $('.addTr').append(content);
                            $('#auto_search_item').val('');
                            $('#cartAddedQty').html(data.allItem);
                            $('#toalQuantity').html(data.allItem);
                            calculate();
                        } else{
                            var qty = $('#pcs_'+data.item.key).val();
                            // alert(qty);
                            $('#pcs_'+data.item.key).val(parseInt(qty)+1);
                            // $('#pcs_'+data.item.key).next();
                            $("#saleQuantityCarton_"+data.item.key).val(data.item.carton);
                            $("#saleQuantityDozz_"+data.item.key).val(data.item.dozz);
                            $("#saleQuantitySet_"+data.item.key).val(data.item.set);
                            $("#total_"+data.item.key).val(data.item.sale_quantity*data.item.sale_price);
                            $('#auto_search_item').val('');
                            $('#cartAddedQty').html(data.allItem);
                            $('#toalQuantity').html(data.allItem);
                            calculate();
                        }
                        // console.log(data.allItem);
                    }
                });                 
            });
            $(document).on('change','.saleQuanty',function(e){
                doItemEdit(e,$(this));
            });
            function doItemEdit(e,thisId){
                e.preventDefault();
                var key = thisId.attr('id').split('_')[1];
                var sale_quantity       = $("#pcs_"+key);
                var availableQuantity   = $("#availableQuantity_"+key);
                var saleQuantityCarton  = $("#saleQuantityCarton_"+key);
                var saleQuantityDozz    = $("#saleQuantityDozz_"+key);
                var saleQuantitySet     = $("#saleQuantitySet_"+key);
                var pcsPerCarton        = $("#pcsPerCarton_"+key);
                var sale_price          = $("#price_"+key);
                var purchase_price      = parseFloat($("#purchasePrice_"+key).val());

                if(parseFloat(sale_price.val()) < purchase_price){
                    alert('Sale price can not less then purchase price.!');
                    sale_price.val(purchase_price);
                }
                if (parseFloat(sale_quantity.val()) > parseFloat(availableQuantity.val())) {
                    sale_quantity.val(availableQuantity.val());
                }

                $.ajax({
                    url      : "{{url('sale/editDeleteItemForSaleOrder')}}",
                    type     : "GET",
                    cache    : false,
                    dataType : 'json',
                    data     : {
                        key: key,
                        edit_delete:"edit",
                        purchase_price:purchase_price,
                        sale_price:sale_price.val(),
                        sale_quantity:sale_quantity.val(),
                        sale_quantity_carton:saleQuantityCarton.val(),
                        sale_quantity_dozz:saleQuantityDozz.val(),
                        sale_quantity_set:saleQuantitySet.val(),
                        discount:0,
                    },
                    success  : function(data){
                        if (data.success === true) {
                            sale_quantity.val(data.item_info.sale_quantity);
                            saleQuantityCarton.val(data.item_info.carton);
                            saleQuantityDozz.val(data.item_info.dozz);
                            saleQuantitySet.val(data.item_info.set);
                            sale_price.val(data.item_info.sale_price);
                            pcsPerCarton.val(data.item_info.pcs_per_carton);
                            $("#total_"+key).val(data.item_info.sale_quantity*data.item_info.sale_price);
                            // console.log(data.item_info);
                            calculate();
                        }
                    }
                });
            }
            function calculate(){
                $.ajax({
                    url: "{{url('sale/saleOrderFormCalculate')}}",
                    success: function(data){
                        // console.log(data.totalItemQuantity);
                        $("#topTotalQuantity").html(data.totalItemQuantity);
                        $("#total_amount").html(data.subTotalAmount);
                        $("#totalItem").html(data.totalItem);
                        var discount = parseFloat($("#dis_taka").val());
                        // alert(discount);
                        var totalAmount = data.subTotalAmount-discount;
                        $("#due").html(totalAmount);
                        $("#pay_amount").html(totalAmount);
                    },
                    error: function(){
                    }
                });
            }
            $(document).on('click','.btn-delete',function(e){
                e.preventDefault();
                var key = $(this).attr('id').split('_')[1];
                var self = $(this);
                $.ajax({
                    url      : "{{url('sale/editDeleteItemForSaleOrder')}}",
                    type     : "GET",
                    cache    : false,
                    dataType : 'json',
                    data     : {key: key,edit_delete:""},
                    success  : function(data){
                        if (data.success === true) {
                            self.parent().parent().remove();
                        }
                    }
                });
            });

            $('#appendedPrependedInput').keyup(function(){
                //var discount_taka = parseFloat(this.value);
                var regex =  /^\d*(?:\.{1}\d+)?$/;
                var pay =parseFloat(this.value);
                var $payable = parseFloat($('#pay_amount').html());
                //alert(pay>$payable)
                var pay_note =parseFloat(document.getElementById("paynote").value);
                var return_taka=0;
                if(this.value==''){
                    this.value=null;
                    $('#due').html($payable.toFixed(2));
                    $('#return_taka').html(0.00);
                }
                else{
                    if (this.value.match(regex)) {  
                        if(pay>$payable){
                            this.value=$payable;
                            $('#due').html(0.00);
                            $('#return_taka').html((isNaN(pay_note-$payable)) ?0:(pay_note-$payable).toFixed(2));
                        }
                        else{
                        $('#due').html(($payable-pay).toFixed(2));
                        $('#return_taka').html((isNaN(pay_note-pay)) ?0:(pay_note-pay).toFixed(2));
                        }                                   
                    }                                  
                    else{   
                        this.value='';
                        $('#due').html($payable.toFixed(2));
                        $('#return_taka').html(0.00);
                    }
                }
            });
            
            $('.floatingCheck').keyup(function(){
                var intRegex = /^\d+$/;
                var floatRegex = /^((\d+\.(\.\d *)?)|((\d*\.)?\d+))$/;
                var str = $(this).val();
                if(this.value==''){
                   this.value='';
                }
                else if(intRegex.test(str) || floatRegex.test(str)) {
                }
                else{
                    alert('Wrong Data');
                    this.value ='';
                }
            });
          $('.saleQuanty').blur(function(){
                var intRegex = /^\d+$/;
                var floatRegex = /^((\d+\.(\.\d *)?)|((\d*\.)?\d+))$/;
                var str = $(this).val();
                if(this.value==''){
                   this.value=1;
                }
                else if(this.value=='0') {
                    this.value=1;
                }
                else if(intRegex.test(str) || floatRegex.test(str)) {
                }
                else{
                    alert('Wrong Data');
                    this.value = 1;
                }
            });
            //for input box tooltip
            $('input[type=text][name=discount_percent]').tooltip({
                placement: "right",
                trigger: "hover"
            });
        });
        function saleQuantyCheck() {
            saleQuanty.value = 22;
        }
        function isUnRegisteredCustomer() {
            var customer = document.getElementById("customer").value;
            var $total_amount = parseFloat($('#total_amount').html());
            if($total_amount==0){
               alert("Error! There is no selected item for sale.");
               return false;
            }
            if(!customer){
                //payabe cash check//
                if(parseFloat($("#paynote").val()) < parseFloat($("#appendedPrependedInput").val())){
                    alert("Sorry you can'\t pay less than amount");
                    return false;
                }
                var $due = $('#due').html();
                if($due>0){
                    alert("Error! Unregistered Customer Can not allow for due.");
                    return false;
                }
                var confirmation=confirm("Are you sure to complete the sale?");
                if(confirmation){
                    return true;
                }
                return false;
            }else{
                if(parseFloat($("#paynote").val()) < parseFloat($("#appendedPrependedInput").val())){
                    alert("Sorry you can'\t pay less than amount");
                    return false;
                }
                var confirmation=confirm("Are you sure to complete the sale?");
                if(confirmation){
                    return true;
                }
                return false;
            }
        }
    </script>