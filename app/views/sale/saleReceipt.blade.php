
@extends('_layouts.default')
@section('content')
<? $created=substr(Session::get('receipt_info.created_at'),0,10); ?>
	<!--Receipt-->	
	<div class="row">
		<div class="span12" style="margin-right: 10px;">    	
			<article class="head-receipt">
				<ul style="list-style-type:none; margin: 0;">
             @if (Session::has('company_info'))	
				  <!-- <li><strong class="company-name">{{ Session::get('company_info')->company_name }}</strong></li> -->
				  <li>
				  	<img src="{{asset('img/memo-logo.png')}}" class="" style="padding-right: 15px;height: 40px;" alt="title">
				  </li>
				  <!-- <li><img src="{{asset('img/company_logo.jpg')}}" class="" style="padding:15px; height: 80px; width: 320px;" alt="title"></li> -->
				  <li>{{ Session::get('company_info')->address }}</li>
				  <li>{{ Session::get('company_info')->web_address }}</li>
			 @endif
				</ul>
			 @if (Session::has('receipt_info'))	
			 <center>
			 <table>
				<tbody style='line-height:12px; font-size:10px'>
					<tr style="border-bottom: 1px solid #ccc; width:50%; margin: 3px auto;">
						<td colspan="3" style="text-align:center;"><b>Sales Receipt</b></td>
					</tr>
					@if(!empty(Session::get('receipt_info.customer_name')))
					<tr>
						<td align="right">Customer Name</td>
						<td>&nbsp;&nbsp; : &nbsp;</td>
						<td align="left">{{ Session::get('receipt_info.customer_name') }}</td>
					</tr>
					@endif
					<tr style='' width='100%'>
						<td align="right">Transaction Date</td>
						<td>&nbsp;&nbsp; : &nbsp;</td>
						<td align="left">
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
						<td align="right">Invoice No</td>
						<td>&nbsp;&nbsp; : &nbsp;</td>
						<td align="left">{{ Session::get('receipt_info.invoice_id') }}</td>
					</tr>
					<tr>
						<td align="right">Sold By</td>
						<td>&nbsp;&nbsp; : &nbsp;</td>
						<td align="left"><b>{{ Session::get('receipt_info.emp_name') }}</b></td>
					</tr>
				</tbody>
			 @endif
			 </table> 
			 </center>
			</article>	
			@if(Session::has('receipt_item_infos'))
			<table class="item-sales" style='width:100%'>
				<thead class="table-receipt-head">
					<tr>
						<th></th>
						<th width='50%'>Item</th>
						<th width='20%'>Price</th>
						<th width='10%'>Qty.</th>
						<th width="20%">Total</th>
					</tr>
				</thead>
				<tbody style='font-size:13px'>
					<? $i = 0;  $quantity=0; $totalPoint = 0;?>
					@foreach(Session::get('receipt_item_infos') as $receipt_item_info)
					<? $i++; ?>
					@if($receipt_item_info['sale_quantity']>0)
					<tr class="tr-receipt">
						<td>{{ $i }}.</td>
						<td width='50%' nowrap><span style='text-align:left; font-weight: bold;'>{{substr($receipt_item_info['item_name'],0,29)}}
							@if(strlen($receipt_item_info['item_name']) > 29)
							-
							<br><br>
							{{substr($receipt_item_info['item_name'],29,59)}}-
							<br><br>
							{{substr($receipt_item_info['item_name'],59)}}
							@endif
						</span>
					</td>
						<td width='20%'>{{ $receipt_item_info['sale_price'] }}</td>
						<td width='10%'><? $quantity+=$receipt_item_info['sale_quantity']; ?>{{ $receipt_item_info['sale_quantity'] }}</td>
						<td width='20%'>{{ $receipt_item_info['total'] }}</td>
					</tr>
					@endif
					@endforeach
				@endif
				@if (Session::has('receipt_info'))
					<tr>
						<td colspan="5" style="text-align: center;font-weight:bold;" align="center">Total Qty.
						<b style='text-align:left; font-size:14px;'>(<? echo $quantity; ?>)</b></td>

					</tr>
					<tr>
						<td colspan='4'  style="line-height: 8px; text-align: right;">Sub Total :</td>
						<td style="line-height: 8px; text-align: right; padding-right: 14px; ">
							{{ Session::get('receipt_info.total_amount')+Session::get('receipt_info.invoice_discount')+Session::get('receipt_info.point_taka') }}
						</td>
					</tr>
					<tr>
						<td colspan='4'  style="line-height: 8px; text-align: right;">Payment Type :</td>
						<td style="line-height: 8px; text-align: right; padding-right: 14px; ">{{ Session::get('receipt_info.payment_type_name') }}</td>
					</tr>
					<tr>
						<td colspan="4" style="line-height: 5px; text-align: right;">Discount&nbsp;(Tk) :</td>
						<td style="line-height: 5px; text-align: right; padding-right: 18px;">{{ Session::get('receipt_info.invoice_discount') }}</td>
					</tr>
					<tr>
						<td colspan="4" style="line-height: 5px; text-align: right;">Total :</td>
						<td style="line-height: 5px; text-align: right; padding-right: 18px;">{{ Session::get('receipt_info.total_amount')}}</td>
					</tr>
					<tr>
						<td colspan="4" style="line-height: 5px; text-align: right;"><b>Paid :</b></td>
						<td style="line-height: 5px; text-align: right;  padding-right: 18px;"><b>{{ Session::get('receipt_info.pay') }}</b></td>
					</tr>
					<tr>
						<td colspan="4" style="line-height: 5px; text-align: right;">Due :</td>
						<td style="line-height: 5px; text-align: right;  padding-right: 18px;">{{ Session::get('receipt_info.due') }}</td>
					</tr>
					<tr>
						<td colspan="4" style="line-height: 5px; text-align: right;">Pay Note :</td>
						<td style="line-height: 5px; text-align: right; padding-right: 18px;">{{ Session::get('receipt_info.pay_note') }}</td>
					</tr>
					<tr>
						<td colspan="4" style="line-height: 5px; text-align: right;">Return :</td>
						<td style="line-height: 5px; text-align: right; padding-right: 18px;">{{ Session::get('receipt_info.pay_note') - Session::get('receipt_info.pay') }}</td>
					</tr>
				</tbody>
			</table>
				
			<article style="clear:both; text-align: center;">
				<h6>Thanks for being with us</h6>
				<h6 style="font-size: 10px !important;">Sold goods are not returnable.</h6>
				<div align="center">
					{{ DNS1D::getBarcodeHTML(Session::get('receipt_info.invoice_id'), "C128", 1, 25) }}					
					<strong>{{ Session::get('receipt_info.invoice_id') }}</strong>				
				</div>
				<!-- <p style="float:right;">Developed By : <strong>UB Automation</strong></p> -->
				
			</article>
			@endif
		</div>		
	</div>
	
	<script type="text/javascript">
		 window.onload = function () {
			window.print();
			// setTimeout(function(){window.location = "{{ URL::to('sale/sales') }}"}, 3000);
		  	if({{Session::get('isAutoPrintAllow')}}==1){
			  window.print();
			  // setTimeout(function(){window.location = "{{ URL::to('sale/sales') }}"}, 200000);
		  	}
		}
	</script>
@stop

