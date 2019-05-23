<?php
	$created=substr(Session::get('receipt_info.created_at'),0,10); 
?>
<!DOCTYPE html>
<html>
<head>
	<title>Komdam Invoice</title>
	{{ HTML::style('css/bootstrap.min.css') }}
	<style type="text/css">
		.wrapper{
		    border: 1px solid transparent;
		    height: 1180px;
			width: 810px;
		    margin: 0px auto;
		    border: 1px solid black;	    
		}
		.wrapper-content{
			margin-top: 150px;
			padding: 10px;
		}
		.heading{
			text-align: center;
			text-decoration: underline;
			margin-bottom: 30px;
		}
		.header{
			width: 100%;
		}
		.client{
			width: 50%;
			float: left;
		}
		.invoice-details{
			width: 50%;
			float: left;
			margin-bottom: 20px;
		}
		.invoice-details-table{
			margin-left: 42%;
			border-collapse: collapse;
		}
		.invoice-details-table td,th{
			text-align: left;
			border: 1px solid black;
			padding: 5px;
		}
		.content{
			width: 100%;
			min-height: 600px;
		}
		.product-details-table{
			width: 100%;
			border-collapse: collapse;
		}
		.product-details-table th,td{
			text-align: left;
			border: 1px solid black;
			padding: 5px;
		}
		.footer{
			width: 100%;
		}
		.footer ol{
			margin-left: 7px;
			padding-left: 7px;
		}
		.signature{
			padding-top: 70px;
			font-weight: bolder;
		}
		.signature span{			
			border-top: 1px solid black;
			padding-right: 50px;
		}
		.delivery{
			width: 50%;
			float: left;
		}
		.received{
			width: 50%;
			float: left;
		}
		.delivery>table{
			width: 90%;
			border-collapse: collapse;
		}
		.received>table{
			width: 90%;
			border-collapse: collapse;
		}

		@media print{
			.chalanBtn{
				display: none;
			}
		}
	</style>
</head>
<body>
	<div class="chalanBtn">
		<a class="btn btn-success btn-sm pull-right" href="{{ URL::to('sale/sales') }}" style="margin-right: 5px;">
			Go To Sale Form
		</a>
	</div>
<div class="wrapper">
	<div class="wrapper-content">
		<h3 class="heading">DELIVERY CHALAN</h3>
		<div class="header">
			@if (Session::has('receipt_info'))	
				@if(!empty(Session::get('receipt_info.customer_name')))
			<div class="client">
				<p>Client : {{ Session::get('receipt_info.customer_full_name') }}</p>
				<p>Address : {{ substr(Session::get('receipt_info.cust_address'),0,100) }}</p>
			</div>
			@else
			<div class="client">
				<p>Client : </p>
				<p>Address : </p>
			</div>
			@endif
			<div class="invoice-details">
				<table class="invoice-details-table">
					<tr>
						<th>Delivery Date</th>
						<td>
							<?php 
								if($created==Session::get('receipt_info.date')){
									$transDateArr =explode(' ', Helper::dateFormat(Session::get('receipt_info.created_at')));
									echo $transDateArr[0];
								}else{
									echo Helper::dateFormat(Session::get('receipt_info.date'));
								}
							?>
						</td>
					</tr>
					<tr>
						<th>Invoice No</th>
						<td>15165151161161</td>
					</tr>
					<tr>
						<th>
							{{ Session::get('receipt_info.invoice_id') }}
						</th>
						<td>
							{{Helper::dateFormat(Session::get('receipt_info.date'))}}
						</td>
					</tr>
				</table>
			</div>
		</div>
		@endif
		@if(Session::has('receipt_item_infos'))
		<div class="content">
			<table class="product-details-table">
				<tr>
					<th>SL No</th>
					<th>Product</th>
					<th>Quantity</th>
					<th>Remark</th>
				</tr>
				<? $i = 0;  $quantity=0; $totalPoint = 0;?>
					@foreach(Session::get('receipt_item_infos') as $receipt_item_info)
					<? $i++;?>
					@if($receipt_item_info['sale_quantity']>0)
				<tr>
					<td>{{ $i }}</td>
					<td>{{ substr($receipt_item_info['item_name'],0,100) }}</td>
					<td><? $quantity+=$receipt_item_info['sale_quantity']; ?>{{ $receipt_item_info['sale_quantity'] }}</td>
					<td></td>
				</tr>
				@endif
					@endforeach
			</table>
		</div>
		<div class="footer">
			<p>I have Received all the products</p>
			<div class="delivery">
				<table>
					<tr>
						<th style="text-align: center;">Delivered By </th>
					</tr>
					<tr>
						<td>Name : </td>
					</tr>
					<tr>
						<td>Designation : </td>
					</tr>
					<tr>
						<td>Date</td>
					</tr>
					<tr>
						<td>Time</td>
					</tr>
					<tr>
						<td>Signature</td>
					</tr>
				</table>
			</div>
			<div class="received">
				<table>
					<tr>
						<th style="text-align: center;">Received By </th>
					</tr>
					<tr>
						<td>Name : </td>
					</tr>
					<tr>
						<td>Designation : </td>
					</tr>
					<tr>
						<td>Date</td>
					</tr>
					<tr>
						<td>Time</td>
					</tr>
					<tr>
						<td>Signature</td>
					</tr>
				</table>
			</div>
		</div>
		@endif
	</div>
</div>

</body>
<script type="text/javascript">
 	window.onload = function () {
	window.print();
	  if({{Session::get('isAutoPrintAllow')}}==1){
		  window.print();
		  setTimeout(function(){window.location = "{{ URL::to('sale/sales') }}"}, 200000);
	  }
	}
</script>
</html>