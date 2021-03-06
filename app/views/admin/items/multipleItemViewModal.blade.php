<p>
<a href="#" id="barcodeQueueDiff" class="btn btn-info"><i class="icon-print"></i>&nbsp; Barcode Queue</a>
</p>
<div id="status" style="display: none;"></div>
		{{ Form::open(array('route' => 'barcode.queue.all','id'=>'itemFormDiff')) }}
<table class="table table-bordered">
    <thead class="table-head">
        <tr>
            <th></th>
            <th>Purchase Price</th>
            <th>Sales Price</th>
            <th>Available Quantity</th>
            <th>Entry Date</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
		
        @foreach($itemInfo as $item)
        <tr>
        	<td>
        		<input type="checkbox" name="barcodeInfo[]" value="{{ $item->item_id }}-{{$item->sale_price}}">
			
        	</td>
			<input type="hidden" name="item_id" value="{{ $item->item_id }}" />
			<input id="purPrice{{$item->stock_item_id}}" type="hidden" name="purchase_price" value="{{ $item->purchase_price }}" />
			<input id="stockId{{$item->stock_item_id}}" type="hidden" name="stock_item_id" value="{{ $item->stock_item_id }}" />
			<td>{{ $item->purchase_price }}</td>
            <td>
				<span>{{ $item->sale_price }}</span>
				<input id="{{ $item->stock_item_id }}" class="input-small saleCheck" type="text" name="sale_price" value="{{$item->sale_price}}" style="display: none;" />
			</td>
            <td>{{ $item->available_quantity }}</td>
            <td>{{
					Helper::dateFormat($item->created_at)
                }}
            </td>
			<td class="span2">
				<a href="javascript:;" class="edit btn btn-primary" id="editDiffPrice_{{ $item->stock_item_id }}" ><i class="icon-edit">&nbsp;Edit Price</i></a>
				<a href="javascript:;" style="display:none;" class="update btn btn-primary" id="saveDiffPrice_{{ $item->stock_item_id }}" ><i class="icon-ok">&nbsp;Save Changes</i></a>
			</td>

        </tr>
        @endforeach
    </tbody>
</table>
        {{ Form::close()}}
	<script>
		$(function(){	

			$("#barcodeQueueDiff").click(function(){
				$("#itemFormDiff").submit();
			});		
						
			$('.edit').click(function(){
				var data 	  = $(this).attr("id");
				var arr 	  = data.split('_');
				var stockId   = arr[1];	
				var sale_price = $(this).parent().prev().prev().prev().children().html();
				//alert(sale_price);
				$(this).parent().prev().prev().prev().children().next().show().val(sale_price).prev().hide();// show input box and hide category name of <Span>//
				$(this).next().show(); //show save bottom
				$(this).hide();	//hide edit bottom					
			});
			$('.saleCheck').keyup(function(){
				var sale_price = parseFloat(this.value);
				if(isNaN(sale_price)){
					this.value = '';
				}

			});
			$('.update').click(function(){
				var data 	 = $(this).attr("id");
				var arr 	 =	data.split('_');
				var stockId      = arr[1];		
				
				var update_btn	= $(this);	
				var edit_btn	= $(this).prev();
				
				var token 	   = $('input[name=_token]').val();
				var stockItemId	   =  $("#stockId"+stockId).val();
				var item_id 	   = $('input[name=item_id]').val();
				var purchase_price = $('#purPrice'+stockId).val();		
				//alert(token);
				var sale_price	   =  $("#"+stockId).val();
				
				$.ajax({
					url  : "PriceEditSave",
					type : "POST",
					cache: false,
					dataType : 'json',
					data : {'_token': token, 'stock_item_id': stockItemId,'item_id': item_id, 'purchase_price': purchase_price, 'sale_price': sale_price}, // serializes the form's elements.
					success : function(data){
						if(data.status == "success"){
							edit_btn.show();  //show Edit bottom
							update_btn.hide();//hide update bottom
							var updated_value = $('#'+stockId).val();
							$('#'+stockId).hide().prev().show().html(updated_value); // convert input field to text mode
							$('#status').html('<strong class="ajax-message-suc"><i class="icon-ok"></i> Update Successfully </strong>');
							$('#status').css('display', 'block').fadeOut(5000);
						} else{
							$('#status').html('<strong class="ajax-message-err"><i class="icon-warning-sign"></i> '+data.status+' </strong>');
							$('#status').css('display', 'block').fadeOut(5000);
						}
					}
				}); 
			});
		});
	</script>