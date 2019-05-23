<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Famous Corporation</title>
    <link rel="stylesheet" href="{{asset('css/bootstrap.min.css')}}">
    <link rel="stylesheet" href="{{asset('css/new-custom.css')}}">
</head>
<body>
    <? $created=substr(Session::get('receipt_info.created_at'),0,10); ?>
<page size="A4">
    <div class="wrapper fc">
        <div class="my-container">
            <div class="my-c-md-10 cell">
                <p class="pull-right">Cell: <a href="tel:+8801919172717">01919 172717</a></p>
            </div>

            <div class="my-c-md-2 logo">
                <img src="{{asset('img/invoice-img/fc-logo.png')}}" alt="Famous CORPORATION">
            </div>
            <div class="my-c-md-8 top-title">
                <h1>Famous <span style="color: #C10000;">Corporation</span></h1>
                <p>A Trusted Supplier of All Kinds of Food & Cosmetics </p>
            </div>
        </div>

        <div class="my-container">
            <div class="my-c-md-10">
                <p>NO: <b>{{ Session::get('receipt_info.invoice_id') }}</b></p>
            </div>
        </div>


        <div class="my-container">
            <div class="my-c-md-10">
                <table style="width:99%">
                    <tr>
                        <td colspan="2" style="border-bottom: 2px solid #fff;">&nbsp;</td>
                        <td style="text-align: center;"><h2>Invoice</h2></td>
                        <td colspan="3">Branch: {{ Session::get('receipt_info.branch_name')}}</td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <div class="my-c-md-8">Name: <span>{{ Session::get('receipt_info.customer_full_name') }}</span></div>
                            <div class="my-c-md-2" style="margin-left: -50px;">P.O No: {{ Session::get('receipt_info.po_no')}}</div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <div class="my-c-md-8">Address: {{ Session::get('receipt_info.cust_address') }}</div>
                            <div class="my-c-md-2" style="margin-left: -50px;">Date: 
                            <?php 
                                if($created==Session::get('receipt_info.date')){

                                    $transDateArr =explode(' ', Helper::dateFormat(Session::get('receipt_info.created_at')));
                                    echo $transDateArr[0];
                                }else{
                                     echo Helper::dateFormat(Session::get('receipt_info.date'));
                                }
                            ?>
                            </div>
                        </td>
<!--                        <td colspan="3">Address:</td>-->
<!--                        <td colspan="3" style="border-left: 2px solid #fff;">Date:</td>-->
                    </tr>
                    <tr>
                        <td colspan="6">&nbsp;</td>
                    </tr>
                    <tr class="t-head">
                        <th>S.N</th>
                        <th>Article  No.</th>
                        <th width="60%">Item Name</th>
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
                                    <span style='text-align:left; font-weight: bold;'>
                                    {{substr($receipt_item_info['item_name'],0,50)}}
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
                    <tr style="font-weight: bold;">
                        <td colspan="3">Taka in words: <span>
                            <?php 
                            $f = new \NumberFormatter("en", \NumberFormatter::SPELLOUT);
                            echo ucwords($f->format( Session::get('receipt_info.total_amount'))); ?> Taka Only
                        </span></td>
                        <td align="right">Total Qty. = <?php echo $quantity; ?></td>
                        <td align="right">Total Value =</td>
                        <td align="right">{{ Session::get('receipt_info.total_amount')}}</td>
                    </tr>



                    <tr style="border-left: 2px solid white; border-right: 2px solid white;">
                        <td colspan="6">
                            <br><br>
                            <div class="my-c-md-5">
                                <p class="overline pull-left">Received by &nbsp;&nbsp;&nbsp;&nbsp;</p>
                            </div>
                            <div class="my-c-md-5">
                                <p class="overline pull-right">&nbsp;&nbsp;For: Famous Corporation</p>
                            </div>
                        </td>
                    </tr>

                    <tr style="font-weight: bold; border-top: 1px solid #000;">
                        <td colspan="3" style="background-color: #fff;">
                            <p>Shop # 12, Gulshan Shopping Center (4th Floor), Gulshan-1, Dhaka-1212.</p>
                        </td>
                        <td colspan="3" style="background-color: #fff; color: #000;">
                            <p>E-mail: <a href="Famous.corporation.bd@gmail.com" style="color: #000;">Famous.corporation.bd@gmail.com</a></p>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

    </div>
</page>

<!--	<page size="A4" layout="landscape"></page>-->

<!-- <page size="A5"></page>
<page size="A5" layout="landscape"></page>
<page size="A3"></page>
<page size="A3" layout="landscape"></page> -->
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
</body>
</html>