<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>M.B.S CORPORATION</title>
	<link rel="stylesheet" href="{{asset('css/bootstrap.min.css')}}">
    <link rel="stylesheet" href="{{asset('css/new-custom.css')}}">
</head>
<body>
	<? $created=substr(Session::get('receipt_info.created_at'),0,10); ?>
<page size="A4">
	<div class="wrapper mbs">
		<div class="my-container">
			<div class="my-c-md-2 logo">
				<img src="{{asset('img/invoice-img/mbs-logo.png')}}" alt="M.B.S CORPORATION">
			</div>
			<div class="my-c-md-8 top-title">
				<h1>M.B.S CORPORATION</h1>
				<p>All Kinds of Foreign Cosmetics Import, Whole Sale & Supply</p>
			</div>
		</div>

		<div class="my-container">
			<div class="my-c-md-6">
				<span class="inv-title">INVOICE</span>
			</div>
			<div class="my-c-md-4">
				<ul class="supply-po">
					<li>Branch: {{ Session::get('receipt_info.branch_name')}}</li>
					<li>P.O No: {{ Session::get('receipt_info.po_no')}}</li>
					<li>Supply Code: {{ Session::get('receipt_info.supply_code')}}</li>
				</ul>
			</div>
		</div>

		<div class="my-container">
			<div class="my-c-md-10">
				<p>NO: <b>{{ Session::get('receipt_info.invoice_id') }}</b></p>
			</div>
		</div>

		<div class="my-container">
			<div class="my-c-md-6">
				<p>Name: {{Session::get('receipt_info.customer_full_name') }}</p>
			</div>
			<div class="my-c-md-4">
				<p style="padding-left: 30px;">Date: 
					<?php 
                        if($created == Session::get('receipt_info.date')){

                            $transDateArr =explode(' ', Helper::dateFormat(Session::get('receipt_info.created_at')));
                            echo $transDateArr[0];
                        }else{
                             echo Helper::dateFormat(Session::get('receipt_info.date'));
                        }
                    ?>
				</p>
			</div>
		</div>

		<div class="my-container">
			<div class="my-c-md-10">
				<p>Address: {{ Session::get('receipt_info.cust_address') }}</p>
			</div>
		</div>

		<div class="my-container">
			<div class="my-c-md-10">
				<table style="width:99%">
					<tr class="t-head">
						<th>S.N</th>
						<th>Article No.</th>
						<th>Item Name</th>
						<th>Qty.</th>
						<th>U. Price</th>
						<th>Value</th>
					</tr>
					 <? $i = 0;  $quantity=0; $totalPoint = 0;?>
                    @if(Session::has('receipt_item_infos'))
                        @foreach(Session::get('receipt_item_infos') as $receipt_item_info)
                            <? $i++; ?>
                            @if($receipt_item_info['sale_quantity']>0)
							<tr>
								<td>{{ $i }}</td>
								<td>{{ $receipt_item_info['article_name'] }}</td>
								<td>
									<span style='text-align:left; font-weight: bold;'>{{substr($receipt_item_info['item_name'],0,50)}}
                                        @if(strlen($receipt_item_info['item_name']) > 50)
                                        -<br>
                                        {{substr($receipt_item_info['item_name'],50,89)}}-
                                        <br>
                                        {{substr($receipt_item_info['item_name'],89)}}
                                        @endif
                                    </span>
                               	</td>
								<td align="Center"><? $quantity+=$receipt_item_info['sale_quantity']; ?>{{ $receipt_item_info['sale_quantity'] }}</td>
								<td align="right">{{ $receipt_item_info['sale_price'] }}</td>
								<td align="right">{{ $receipt_item_info['total'] }}</td>
							</tr>
                            @endif
                        @endforeach
                    @endif

					<tr style="color: #023E94; font-weight: bold;">
						<td colspan="3">Taka in words:: <span>
							<?php 
                            $f = new \NumberFormatter("en", \NumberFormatter::SPELLOUT);
                            echo ucwords($f->format( Session::get('receipt_info.total_amount'))); ?> Taka Only
						</span></td>
						<td align="right">Total Qty. = <?php echo $quantity; ?></td>
						<td align="right">Total Value = </td>
						<td align="right">{{ Session::get('receipt_info.total_amount')}}</td>
					</tr>
					<tr>
						<td colspan="6">&nbsp;</td>
					</tr>
				</table>
			</div>
		</div>

		<br><br>
		<div class="my-container">
			<div class="my-c-md-5">
				<p class="overline pull-left">Received by</p>
			</div>
			<div class="my-c-md-5">
				<p class="overline pull-right">For - M.B.S Corporation</p>
			</div>
		</div>
		<br>
		<footer style="">
			<div class="my-container">
				<div class="myc-md-10">
					<p>Shop # 27, Gulshan Shopping Center (4th Floor), Gulshan-1, Dhaka-1212.</p>
					<p>Mobile: <a href="tel:+8801720564461">01720 564461</a>, <a href="tel:+8801989704053">01989 704053</a> E-mail: <a href="mailto:mbs_corporation@yahoo.com">
						mbs_corporation@yahoo.com</a></p>
				</div>
			</div>,

		</footer>
	</div>
</page>

<!--	<page size="A4" layout="landscape"></page>-->

	<!-- <page size="A5"></page>
	<page size="A5" layout="landscape"></page>
	<page size="A3"></page>
	<page size="A3" layout="landscape"></page> -->
	<script type="text/javascript">
         window.onload = function () {
            // window.print();
            // setTimeout(function(){window.location = "{{ URL::to('sale/sales') }}"}, 3000);
            if({{Session::get('isAutoPrintAllow')}}==1){
              // window.print();
              // setTimeout(function(){window.location = "{{ URL::to('sale/sales') }}"}, 200000);
            }
        }
    </script>
</body>
</html>