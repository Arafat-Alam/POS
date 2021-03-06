{{ Form::open(array('route' => 'admin.addItemLocation.post', 'id' => 'formItemLocation', 'class' => 'form-horizontal')) }}
	
	<div class="control-group">		
		{{ Form::label('location_name', 'Location Name', ['class' => 'control-label']) }}
		<div class="controls">
			{{ Form::text('location_name', null, array('class' => 'span3', 'placeholder' => 'Enter Item Location Name')) }}
		</div> <!-- /controls -->					
	</div> <!-- /control-group -->	
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
		{{ Form::submit('Save Changes', array('class' => 'btn btn-primary')) }}
	</div>
	
{{ Form::close() }}
<script>
	$(function(){
		var formItemLocation = $('#formItemLocation');

		jQuery.validator.addMethod("alphaspace", function(value, element) {
		   return this.optional(element) || value == value.match(/^[-a-zA-Z0-9_ ]+$/);
		}, "Only letters, Numbers & Space/underscore Allowed.");
		// validate form for Item Category
		formItemLocation.validate({
		  rules: {
		   location_name: {
			   alphaspace: true,
			   required: true
			}
		  }, messages: {
				//'location_name'	: { required:  '<span class="error">Category Name required.</span>' },					
			},
			ignore				: ':hidden'	
		});
	});
</script>