<style type="text/css">
	.modal{
		max-width: 600px !important;
	}
</style>
{{ Form::model($iteminfos,  array('route' => 'admin.editArticleSave.post', $iteminfos->item_id, 'id' => 'addItemform', 'class' => 'form-horizontal')) }}
	{{ Form::hidden('item_id', $iteminfos->item_id)}}
<div id="art">
	@if(count($articles) > 0)
		@foreach($articles as $key => $value)
		<div class="row">
			<div class="control-group ">
				<div style="width: 100%"> 
					<div style="width: 49.5%; float: left;">
						<label style="width: 100%; margin-left: 35px; ">Customer Name</label>	
						<div style="width: 100%; margin-left: 35px;" >
							{{ Form::select('customer_id[]', $customerInfo, $value->customer_id, array('class' => 'form-control', 'required' => 'required')) }}
						</div>
					</div>

					<div style="width: 49.5% ; float: right;">
						<label  style="width: 100%; ">Article No</label>	
						<div style="width: 100%; ">
							<input class="form-control" type="text" name="article_name[]" value="{{ $value->article_name }}">
							<input class="form-control" type="hidden" name="item_id" value="{{ $itemId }}">
							<input class="form-control" type="hidden" name="customer_article_id[]" value="{{ $value->customer_article_id }}">
							<span class="btn btn-danger removeExist">-</span>
						</div>
					</div>
				</div>		
			</div> 
		</div>
		@endforeach
		<span class="btn btn-success" onclick="addMore()" style="margin-left: 40%; ">Add More</span>
	@else
		<div class="row">
			<div class="control-group ">
				<div style="width: 100%"> 
					<div style="width: 49.5%; float: left;">
						<label style="width: 100%; margin-left: 35px; ">Customer Name</label>	
						<div style="width: 100%; margin-left: 35px;" >
							{{ Form::select('customer_id[]', $customerInfo, array('class' => 'form-control', 'required' => 'required')) }}
						</div>
					</div>

					<div style="width: 49.5% ; float: right;">
						<label  style="width: 100%; ">Article No</label>	
						<div style="width: 100%; ">
							<input class="form-control" type="text" name="article_name[]" >
							<input class="form-control" type="hidden" name="item_id" value="{{ $itemId }}">
							<span class="btn btn-success" onclick="addMore()">+</span>
						</div>
					</div>
				</div>		
			</div> 
		</div>
	@endif
</div>
	
	<div class="modal-footer">
		{{ Form::submit('Save Changes', array('class' => 'btn btn-primary')) }}
		<button type="button" class="btn" data-dismiss="modal">Close</button>
	</div>
{{ Form::close() }}
<!-- <?php foreach ($customerInfo as $key => $value) {	 ?>
		<?php echo $key; ?><?php echo "== > ".$value."<br>"; ?>
<?php } ?> -->
<script>

		var count = 0;

		$('.removeExist').on('click',function(){
			if (confirm("Are you sure?")) {
				$(this).parent().parent().parent().parent().remove();
			}
		});
	function addMore(){
		var html = '<div class="row rows'+count+'">';
		html += '<div class="control-group ">';
		html +=	'<div style="width: 100%"> ';
		html +=		'<div style="width: 49.5%; float: left;">';
		html +=			'<label style="width: 100%; margin-left: 35px; ">Customer Name</label>';	
		html +=			'<div style="width: 100%; margin-left: 35px;" >';
		//html +=				'{{ Form::select("custimer_id", '<?php $customerInfo ?>', ' <?php $customerInfo ?>', array("class" => "form-control", "required" => "required")) }}';
		html +=			'<select class="form-control" required="required" name="customer_id[]">';
					<?php foreach ($customerInfo as $key => $value) { ?>
		html +=					"<option value='"+'<?php echo $key; ?>'+"'>"+'<?php echo $value; ?>'+"</option>";
					<?php } ?>
		html +=			'</select>';
		html +=			'</div>';
		html +=		'</div>';

		html +=		'<div style="width: 49.5% ; float: right;">';
		html +=			'<label  style="width: 100%; ">Article No</label>';	
		html +=			'<div style="width: 100%; ">';
		html +=			'<input class="form-control" type="text" name="article_name[]" > ';
		//html +=				"{{ Form::select('custimer_id', "<?php $customerInfo ?>", "<?php $customerInfo ?>", array('class' => 'form-control', 'required' => 'required')) }}";
		html +=		'<span class="btn btn-danger" onclick="rmRow('+count+')">-</span>';
		html +=			'</div>';
		html +=		'</div>';
		html +=	'</div>	';	
		html += '</div>'; 
		html += '</div>';
		count++;
		$("#art").append(html);

	}
	function rmRow(rows){
		$('.rows'+rows).remove();
	}

	$(function(){
		var addItemform = $('#addItemform');

		jQuery.validator.addMethod("alphaspace", function(value, element) {
		   return this.optional(element) || value == value.match(/^[-a-zA-Z0-9_ ]+$/);
		}, "Only letters, Numbers & Space/underscore Allowed.");

		jQuery.validator.addMethod("floatNumber", function(value, element) {
		   return this.optional(element) || value == value.match(/^-?(?:\d+|\d{1,3}(?:,\d{3})+)?(?:\.\d{1,2})?$/);
		}, "Value must be float or int after (.) only contain two decimal place.");
		// validate form for Item Category
		addItemform.validate({
		  rules: {
		   item_name: {
			   required: true
			},
		   upc_code: {
			   alphaspace: true,
			   required: true
			},
		   tax_amount: {
			   floatNumber: true,
			   required: true
			},
		   location: {
			   alphaspace: true,
			   required: true
			}
		  }, messages: {
				//'category_name'	: { required:  '<span class="error">Category Name required.</span>' },					
			},
			ignore : ':hidden'
		});
	});
</script>