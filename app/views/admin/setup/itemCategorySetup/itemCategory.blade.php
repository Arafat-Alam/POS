<div id="message" style="display: none;"></div>
<table class="table table-striped" width="100%">
	<thead class="table-head">
		<tr>
			<th>#</th>
			<th>Category Name</th>
			<th>Action</th>
		</tr>
	</thead>
	<tbody>
		@foreach($item_categorys as $item_category)
		{{ Form::open(array('route' => 'admin.editItemCategory.post', 'id' => "itemCategory$item_category->category_id")) }}
		<tr>
			<td class="">{{ $item_category->category_id }}</td>
			<td class="">
				<span>{{ $item_category->category_name }}</span>
				<input id="category_name{{ $item_category->category_id }}" style="display: none;" type="text" name="category_name" value="{{$item_category->category_name}}" />
			</td>
			<td class="span3">
				<a href="javascript:;" class="edit btn btn-primary" id="editItemCategory_{{ $item_category->category_id }}" ><i class="icon-edit">&nbsp;Edit</i></a>
				<a href="javascript:;" style="display:none;" class="update btn btn-primary" id="updateItemCategory_{{ $item_category->category_id }}" ><i class="icon-edit">&nbsp;update</i></a>
				&nbsp; | &nbsp;
				<a href="javascript:;" class="btn btn-warning" onclick="return deleteConfirm('{{ $item_category->category_id }}')" id="categoryId{{ $item_category->category_id }}"><i class="icon-trash">&nbsp;Inactive</i></a>
			</td>
		</tr>
		{{ Form::close() }}
		@endforeach
	</tbody>
</table>
<script>
	$().ready(function(){
		$('.edit').click(function(){
			var data 	 	 = $(this).attr("id");
			var arr 	 	 = data.split('_');
			var categoryId   = arr[1];			
			var categoryName = $(this).parent().prev().children().html();
			//$(this).parent().prev().children().html($('#'+categoryId)).show();
			$(this).parent().prev().children().next().show().val(categoryName).prev().hide();// show input box and hide category name of <Span>//
			$(this).next().show(); //show update bottom
			$(this).hide();	//hide update bottom					
		});
		$('.update').click(function(){
			var data 	 	 = $(this).attr("id");
			var arr 	 	 =	data.split('_');
			var categoryId   = arr[1];
			
			var update_btn	= $(this);	
			var edit_btn	= $(this).prev();
			
			var cat_name	=  $("#category_name"+categoryId).val();
			
			$.ajax({
				url  : "itemCategoryEdit/"+categoryId,
				type : "GET",
				cache: false,
				dataType : 'json',
				data : "category_name="+cat_name, // serializes the form's elements.
				success : function(data){
					if(data.status == "success"){
						edit_btn.show();  //show Edit bottom
						update_btn.hide();//hide update bottom
						var updated_value = $('#category_name'+categoryId).val();
						$('#category_name'+categoryId).hide().prev().show().html(updated_value); // convert input field to text mode
						$('#message').html('<strong class="ajax-message-suc"><i class="icon-ok"></i> Update Successfully </strong>');
						$('#message').css('display', 'block').fadeOut(10000);
					} else{
						$('#message').html('<strong class="ajax-message-err"><i class="icon-warning-sign"></i> '+data.status+' </strong>');
						$('#message').css('display', 'block').fadeOut(10000);
					}
				}
			}); 
		});
	});
	
	//Delete Operation
	function deleteConfirm(categoryId){
		var con = confirm("Do you want to delete?");
		if(con){
			$.ajax({
				url: "itemCategoryRemove/"+categoryId,
				dataType:'json',
				success : function(data){
					if(data.status == 'success'){
						$("#categoryId"+categoryId).prev().parent().parent().fadeOut("slow");
						$('#message').html('<strong class="ajax-message-suc"><i class="icon-ok"></i> Delete Successfully</strong>');
						$('#message').css('display', 'block').fadeOut(5000);				
					} else{
						$('#message').html('<strong class="ajax-message-err"><i class="icon-warning-sign"></i> Something worng!</strong>');
						$('#message').css('display', 'block').fadeOut(5000);						
					}
				},
				error: function(){}
			});
			return true;
		}
		else{
			return false;
		}
	}
</script>
