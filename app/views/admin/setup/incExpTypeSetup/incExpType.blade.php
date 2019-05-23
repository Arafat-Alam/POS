@if(!empty($incExps))
<div id="message" style="display: none;"></div>
<table class="table table-striped" width="100%">
	<thead class="table-head">
		<tr>
			<th>#</th>
			<th>Use For</th>
			<th>Type Name</th>
			<th>Action</th>
		</tr>
	</thead>
	<tbody>
		@foreach($incExps as $incExp)
		{{ Form::open(array('route' => 'admin.editIncExpType', 'id' => "incExp$incExp->type_id")) }}
		<tr>
			<td>{{ $incExp->type_id }}</td>
			<td>
				@if($incExp->used_for == 1)
					{{ 'Income' }}
				@else 
					{{ 'Expense' }}
				@endif
			</td>
			<td>
				<span>{{ $incExp->type_name }}</span>
				<input class="input-small" id="typeName{{ $incExp->type_id }}" style="display: none;" type="text" name="type_name" value="{{$incExp->type_name}}" />
			</td>
			<td class="span3">
				<a href="javascript:;" class="edit btn btn-primary" id="editIncExp_{{ $incExp->type_id }}" ><i class="icon-edit">&nbsp;Edit</i></a>
				<a href="javascript:;" style="display:none;" class="update btn btn-primary" id="saveIncExp_{{ $incExp->type_id }}" ><i class="icon-ok">&nbsp;Save</i></a>
				&nbsp; | &nbsp;
				<a href="javascript:;" class="btn btn-warning" onclick="return deleteConfirm('{{ $incExp->type_id }}')" id="typeId{{ $incExp->type_id }}"><i class="icon-trash">&nbsp;Inactive</i></a>
			</td>
		</tr>
		{{ Form::close() }}
		@endforeach
	</tbody>
</table>
@else
    <div class="empty-msg alert-block">
	  <button type="button" class="close" data-dismiss="alert">&#735;</button>
	  <h4>Nothing found!</h4>
		Thank You
	</div>
@endif
<script>
	$().ready(function(){
		$('.edit').click(function(){
			var data 	 = $(this).attr("id");
			var arr 	 = data.split('_');
			var typeId   = arr[1];	
			var typeName = $(this).parent().prev().children().html();
			$(this).parent().prev().children().next().show().val(typeName).prev().hide();// show input box and hide category name of <Span>//
			$(this).next().show(); //show update bottom
			$(this).hide();	//hide update bottom					
		});
		$('.update').click(function(){
			var data 	 	 = $(this).attr("id");
			var arr 	 	 =	data.split('_');
			var typeId   	 = arr[1];
			
			var update_btn	= $(this);	
			var edit_btn	= $(this).prev();
			
			var type_name	=  $("#typeName"+typeId).val();
			$.ajax({
				url  : "incExpTypeEdit/"+typeId,
				type : "GET",
				cache: false,
				dataType : 'json',
				data : {'type_name': type_name}, // serializes the form's elements.
				success : function(data){
					if(data.status == "success"){
						edit_btn.show();  //show Edit bottom
						update_btn.hide();//hide update bottom
						var updated_value = $('#typeName'+typeId).val();
						$('#typeName'+typeId).hide().prev().show().html(updated_value); // convert input field to text mode
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
	function deleteConfirm(typeId){
		var con = confirm("Do you want to delete?");
		if(con){
			$.ajax({
				url: "incExpTypeRemove/"+typeId,
				dataType:'json',
				success : function(data){
					if(data.status == 'success'){
						$("#typeId"+typeId).prev().parent().parent().fadeOut("slow");
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
