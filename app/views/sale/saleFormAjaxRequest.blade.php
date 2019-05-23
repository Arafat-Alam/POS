<script>
        $().ready(function(){
             //Auto Complete for Item Search
             $("#auto_search_item").on('keydown', function(){
                    var customer = $("#customer").val();
                    if(customer.length < 1){
                        alert('Please select a customer ');
                        return false;
                    }
             });
             $("#auto_search_item").autocomplete("{{route('sale.itemAutoSuggest')}}", {
                width: 260,
                matchContains: true,
                queryDelay : 0,
                formatItem: function(row) {
                    // console.log(row);
                    return row[1];
                },
            });
            //Submit Search Item Form
            $("#auto_search_item").result(function(event, data, formatted) {
                
                // console.log(event);
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
            if(totalAmount >= 1000){
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
                    url      : "{{url('sale/itemAddTochart')}}",
                    type     : "POST",
                    cache    : false,
                    dataType : 'json',
                    data     : {item_id: item_id,_token:token},
                    success  : function(data){
                        // console.log(data);
                        // return false;
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
                                    '</span>'+
                                '</td>';
                                content += '<td colspan="2">'+
                                    '<div class="span3">'+
                                        '<div class="span1" style="float: left; margin-right: 20px;"><label>PCS</label>'+
                                            '<input style="width: 100%;" class="span1 saleQuanty" id="pcs_'+data.item.key+'" type="text" name="sale_quantity"  autocomplete="off" value="'+data.item.sale_quantity+'"/></div>'+
                                        '<input class="span1 floatingCheck" type="text" id="discount_'+data.item.key+'" name="discount" autocomplete="off" value="'+data.item.discount+'" readonly="" style="display: none;" />'+
                                    '</div>'+
                                '</td>'+
                                '<td>';
                                if (parseInt(data.item.sale_quantity) == 0) {
                                    content += '<input class="span1 available_quantity" id="availableQuantity_'+data.item.key+'" style="background-color:red; color:#fff;"  type="text" readonly name="available_quantity" value="'+data.item.available_quantity+'" />';
                                }else{
                                    content += '<input class="span1 available_quantity" id="availableQuantity_'+data.item.key+'"  type="text" readonly name="available_quantity" value="'+data.item.available_quantity+'" />';
                                }
                                content += '</td>'+
                                '<td>'+
                                    '<input class="span1 price_change saleQuanty" type="text" id="price_'+data.item.key+'" name="sale_price" value="'+data.item.sale_price+'" />'+
                                    '<input type="hidden" name="purchase_price" id="purchasePrice_'+data.item.key+'" value="'+data.item.purchase_price+'" />'+
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
            $(document).on('submit','.formEditDelete',function(e){
                e.preventDefault();
            });
            function doItemEdit(e,thisId){
                e.preventDefault();
                var key = thisId.attr('id').split('_')[1];
                var sale_quantity       = $("#pcs_"+key);
                var availableQuantity   = $("#availableQuantity_"+key);
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
                    url      : "{{url('sale/editDeleteItem')}}",
                    type     : "GET",
                    cache    : false,
                    dataType : 'json',
                    data     : {
                        key: key,
                        edit_delete:"edit",
                        sale_price:sale_price.val(),
                        purchase_price:purchase_price,
                        sale_quantity:sale_quantity.val(),
                        discount:0,
                    },
                    success  : function(data){
                        if (data.success === true) {
                            sale_quantity.val(data.item_info.sale_quantity);
                            sale_price.val(data.item_info.sale_price);
                            $("#total_"+key).val(data.item_info.sale_quantity*data.item_info.sale_price);
                            // console.log(data.item_info);
                            calculate();
                        }
                    }
                });
            }
            function calculate(){
                $.ajax({
                    url: "{{url('sale/saleFormCalculate')}}",
                    success: function(data){
                        // console.log(data.totalItemQuantity);
                        $("#topTotalQuantity").html(data.totalItemQuantity);
                        $("#total_amount").html(data.subTotalAmount);
                        $("#totalItem").html(data.totalItem);
                        var discount = parseFloat($("#dis_taka").val());
                        // alert(discount);
                        var totalAmount = data.subTotalAmount-discount;
                        $("#pay_amount").html(totalAmount);
                        // $("#appendedPrependedInput").val(totalAmount);
                        $("#due").html(totalAmount);
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
                    url      : "{{url('sale/editDeleteItem')}}",
                    type     : "GET",
                    cache    : false,
                    dataType : 'json',
                    data     : {key: key,edit_delete:""},
                    success  : function(data){
                        if (data.success === true) {
                            self.parent().parent().remove();
                            calculate();
                        }
                    }
                });
            });
            // $('.saleQuanty').on('keydown',function(e){
            //     var id = $(this).attr('id');
            //     var keyArray = id.split('_');
            //     var key = keyArray[1];
            //     alert('hi');
            //     // $("#pcs_"+key).val(2+1);
            // });

            $('#dis_percent').keyup(function(){
                var $total_amount = $('#total_amount').html();
                var $point_taka = parseFloat($('#point_taka').html());
                if(isNaN($point_taka)){
                    $point_taka = 0;
                }
                var max_dis_percent = parseFloat(document.getElementById("max_dis_percent").value);
                var discount_percent=parseFloat(this.value);
                if(isNaN(discount_percent)){
                    discount_percent = 0;
                }
                var discount_taka=0;
                var $sub_total_amount=($total_amount-$point_taka).toFixed(2);
                var $sub_total_percent=(($sub_total_amount*100)/$total_amount);
                var intRegex = /^\d+$/;
                var floatRegex = /^((\d+\.(\.\d *)?)|((\d*\.)?\d+))$/;
                var str = $(this).val();
                if(this.value==''){
                   this.value=null;
                    $('#dis_taka').val(0);
                    $('#pay_amount').html(($total_amount-$point_taka).toFixed(2));
                    $('#appendedPrependedInput').val(($total_amount-$point_taka).toFixed(2));
                }
                else if(intRegex.test(str) || floatRegex.test(str)) {
                    $('#dis_taka').attr('readonly','readonly');
                    var new_discount_percent1=0;
                    var new_discount_percent2=0;
                    var confirm_discount_percent=0;
                    if(discount_percent>max_dis_percent){
                        if(max_dis_percent>$sub_total_percent){
                            new_discount_percent1=$sub_total_percent;
                        }
                        else{
                            new_discount_percent1=max_dis_percent;
                        }
                    }
                    if(discount_percent>$sub_total_percent){
                        new_discount_percent2=$sub_total_percent;
                    }
                    new_discount_percent1=parseFloat(new_discount_percent1);
                    new_discount_percent2=parseFloat(new_discount_percent2);

                    if((new_discount_percent1==0) && (new_discount_percent2==0)){
                       // alert("no break one");
                        this.value=this.value;
                        confirm_discount_percent=parseFloat(this.value);
                    }
                    else if((new_discount_percent1==0)&&(new_discount_percent2>0)){
                       // alert("first break one");
                       // alert(new_discount_taka2);
                        this.value=new_discount_percent2.toFixed(2);
                        confirm_discount_percent=parseFloat(new_discount_percent2);
                    }
                    else if((new_discount_percent1!=0)&&(new_discount_percent2==0)){
                        //alert("2nd break one");
                        this.value=new_discount_percent1.toFixed(2);
                        confirm_discount_percent=parseFloat(new_discount_percent1);
                    }
                    else{

                        if(new_discount_percent1<new_discount_percent2){
                            this.value=new_discount_percent1.toFixed(2);
                            confirm_discount_percent=parseFloat(new_discount_percent1);
                        }
                        else{
                            this.value=new_discount_percent2.toFixed(2);
                            confirm_discount_percent=parseFloat(new_discount_percent2);
                        }
                    }
                    discount_taka=(($total_amount/100)*confirm_discount_percent);
                    $('#dis_taka').val(discount_taka.toFixed(2));
                    $('#pay_amount').html(($total_amount-(discount_taka+$point_taka)).toFixed(2));
                    $('#appendedPrependedInput').val(($total_amount-(discount_taka+$point_taka)).toFixed(2));
                }
                else{
                    alert('Wrong Data');
                    this.value = '';
                    $('#dis_taka').val(0.00);
                    $('#pay_amount').html(($total_amount-$point_taka).toFixed(2));
                    $('#appendedPrependedInput').val(($total_amount-$point_taka).toFixed(2));
                    $('#due').html(0.00);
                    return false;
                }
            });
            //Discount Calculate for Taka
            $('#dis_taka').keyup(function(){                
                var $total_amount = $('#total_amount').html();
                var $point_taka = parseFloat($('#point_taka').html());
                if(isNaN($point_taka)){
                    $point_taka = 0;
                }
                var max_dis_percent = parseFloat(document.getElementById("max_dis_percent").value);
                var max_dis_taka=(($total_amount/100)*max_dis_percent);                              
                var $sub_total_amount=($total_amount-$point_taka).toFixed(2);
                var discount_taka=parseFloat(this.value);
                if(isNaN(discount_taka)){
                    discount_taka = 0;
                }   
                var intRegex = /^\d+$/;
                var floatRegex = /^((\d+\.(\.\d *)?)|((\d*\.)?\d+))$/;
                var str = $(this).val();                                            
                if(this.value==''){
                   this.value=null;
                    $('#dis_percent').val(0);
                    $('#pay_amount').html(($total_amount-$point_taka).toFixed(2));
                    $('#appendedPrependedInput').val(($total_amount-$point_taka).toFixed(2));
                }
                else if(intRegex.test(str) || floatRegex.test(str)) {                                    
                    $('#dis_percent').attr('readonly','readonly');
                    var new_discount_taka1=0;
                    var new_discount_taka2=0;
                    var confirm_discount=0;
                    if(discount_taka>max_dis_taka){
                        if(max_dis_taka>$sub_total_amount){
                            new_discount_taka1=$sub_total_amount;
                        }
                        else{
                            new_discount_taka1=max_dis_taka;
                        }
                    }
                    if(discount_taka>$sub_total_amount){
                        new_discount_taka2=$sub_total_amount;
                    }
                    new_discount_taka1=parseFloat(new_discount_taka1);
                    new_discount_taka2=parseFloat(new_discount_taka2);

                    if((new_discount_taka1==0) && (new_discount_taka2==0)){
                        this.value=this.value;
                        confirm_discount=parseFloat(this.value);
                    }
                    else if((new_discount_taka1==0)&&(new_discount_taka2>0)){
                       
                        this.value=new_discount_taka2.toFixed(2);
                        confirm_discount=parseFloat(new_discount_taka2);

                    }
                    else if((new_discount_taka1!=0)&&(new_discount_taka2==0)){
                        //alert("2nd break one");
                        this.value=new_discount_taka1.toFixed(2);
                        confirm_discount=parseFloat(new_discount_taka1);
                    }
                    else{
                        if(new_discount_taka1<new_discount_taka2){
                            
                            this.value=new_discount_taka1.toFixed(2);
                            confirm_discount=parseFloat(new_discount_taka1);
                        }
                        else{
                            this.value=new_discount_taka2.toFixed(2);
                            confirm_discount=parseFloat(new_discount_taka2);
                        }
                    }
                    $('#dis_percent').val((((confirm_discount*100)/$total_amount).toFixed(2))+' %');
                    $('#pay_amount').html(($total_amount-(confirm_discount+$point_taka)).toFixed(2));
                    $('#appendedPrependedInput').val(($total_amount-(confirm_discount+$point_taka)).toFixed(2));
                }                                
                else{
                    alert('Wrong Data');
                    this.value = '';
                    $('#dis_percent').val(0.00);
                    $('#pay_amount').html(($total_amount-$point_taka).toFixed(2));
                    $('#appendedPrependedInput').val(($total_amount-$point_taka).toFixed(2));
                    $('#due').html(0.00);
                    return false;
                }
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
            $('#paynote').keyup(function(){
                var regex =  /^\d*(?:\.{1}\d+)?$/;
                var pay_taka = parseFloat(document.getElementById("appendedPrependedInput").value);
                var pay_note =parseFloat(this.value);
                var return_taka=0;
                if(this.value==''){
                    this.value=null;
                    $('#return_taka').html(0.00);
                }
                else{
                    if (this.value.match(regex)) {                                        
                        $('#return_taka').html((pay_note-pay_taka).toFixed(2));
                    } else {   
                        this.value='';
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
        }
        else{
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
        function addInvoiceToQueue() {
            var customer = document.getElementById("customer").value;
            var x = document.getElementById("addInvoiceToQueue");
            
            if(customer){
                window.location="{{URL::to('sale/addInvoiceToQueue')}}";
            }
            else{   
            x.setAttribute("href", "#addInvoiceToQueueModal");
            }

        }

         function isSureToDeleteInvoiceFromQueue() { 
            var confirmation=confirm("Are you sure to delete the invoice from queue ?");
            if(confirmation){
               return true;
            }
            else{
                return false;
            }  
        }
         function isSureToReloadInvoiceFromQueue() { 
            var confirmation=confirm("Are you sure to reload the invoice from queue ?");
            if(confirmation){
               return true;
            }
            else{
                return false;
            }  
        }
    </script>