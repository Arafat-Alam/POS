@extends('_layouts.default')
<?php //echo'<pre>';print_r($purchasereturn);exit; ?>
@section('content')
<style type="text/css">
    @media print{
        strong{
            color: black !important;
        }
        h3{
            color: black !important;
        }
    }
</style>
<div class="row print_disable" style="margin-bottom: 20px;">
    <div class="span12">
        @include('_sessionMessage')
        <div class="invoice-reg print_disable">
            {{ Form::open(array('route' => 'summary.dailyledger', 'class' => 'form-horizontal')) }}
            <div class="control-group" align="center">
                <i class="icon-calendar"></i>&nbsp; Select Date : {{ Form::text('from', $from, array('class' => 'span2 datepicker', 'data-date-format'=> 'yyyy-mm-dd', 'placeholder' => 'Form date')) }}
                &nbsp;&nbsp;&nbsp;
                <input class="btn btn-primary" type="submit" value="Search">
            </div> <!-- /control-group -->
            {{ Form::close() }}
        </div>
    </div>
</div>
<article style="margin-bottom: 3px;; background: #EEEEEE; padding : 20px 0 7px; border-top: 1px solid #003454;">
    <div style="text-align: center; margin-bottom:1px">
        <img src="{{asset('img/company_logo.png')}}" class="" style="padding-right: 15px;height: 70px;" alt="title">
    </div>
    
    <strong style="font-size: 2em;"><i class="icon-credit-card"></i> Summary : Daily Ledger </strong>
    <strong style="float: right; margin: 6px 5px"><i class="icon-calendar"></i>&nbsp; Date : <span style="font-weight: normal;">{{ Helper::onlyDMY($from) }}</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-weight: normal;">&nbsp;&nbsp;</span></strong>
</article>
<div class="row div-print" style="margin-bottom: 3px;">
    <div class="span6">
        <div class="widget-header setup-title"> <i class="icon-credit-card"></i>
            <h3>Collection</h3>
        </div>
        <table class="table table-bordered" style="margin: 0; padding:0;">
            <tbody>
                <tr>
                    <td><strong style="float:left;">Sales Payment Received</strong></td>
                    <td><strong style="color: green; font-size: 1.5em;">{{$sale->sale_pay}} </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tk</td>
                </tr>
                <tr>
                    <td><strong style="float:left;">Due Collection Received</strong></td>
                    <td><strong style="color: green; font-size: 1.5em;">{{ $cusDuePayment->total_amount }} </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tk</td>
                </tr>
                <tr>
                    <td> &nbsp; </td>
                    <td> &nbsp;</td>
                </tr>
                <tr>
                    <td> &nbsp;</td>
                    <td> &nbsp;</td>
                </tr>
                <?php
                    $total_cash_received = $sale->sale_pay + $cusDuePayment->total_amount;
                ?> 
                <tr>
                    <td><strong style="float:left; ">Total Cash Received </strong></td>
                    <td><strong style="font-size: 1.5em; color: green">{{$total_cash_received}} </strong>&nbsp;&nbsp;&nbsp;Tk</td>
                </tr>
            </tbody>
        </table>			
    </div>
    <div class="span5">				
        <div class="widget-header setup-title"> <i class="icon-arrow-left"></i>
            <h3>Expenses</h3>
        </div>
        <table class="table table-bordered" style="margin: 0; padding:0;">
            <tbody>
                    <tr>
                        <td><strong style="float:left;">Purchase Paid </strong></td>
                        <td>
                            @if($purchase->purchase_pay>0)
                                <strong style="color: #f70b20; font-size: 1.5em;">
                                    {{$purchase->purchase_pay}}
                                </strong> Tk
                            @endif
                        </td>
                    </tr>
                    <tr>
                        <td><strong style="float:left;">Sale Return Paid </strong></td>
                        <td>
                            @if($salereturn->salereturn_amount>0)
                                <strong style="color: #f70b20; font-size: 1.5em;">
                                    {{$salereturn->salereturn_amount}}
                                </strong> Tk
                            @endif
                        </td>
                    </tr>
                    <tr>
                        <td><strong style="float:left;">Supplier Payment</strong></td>
                        <td>
                            @if($supDuePayment->total_amount>0)
                                <strong style="color: #f70b20; font-size: 1.5em;">
                                    {{ $supDuePayment->total_amount }}
                                </strong> Tk
                            @endif
                        </td>
                    </tr>
                    <tr>
                        <td><strong style="float:left;">Other Expenses</strong></td>

                        <td>
                            @if($other_expense>0)
                                <strong style="color: #f70b20; font-size: 1.5em;">
                                    {{$other_expense}}
                                </strong> Tk
                            @endif
                        </td>
                    </tr>
                    <?php
                        $total_paid_from_cash = $purchase->purchase_pay + $salereturn->salereturn_amount + $supDuePayment->total_amount + $other_expense;
                    ?>
                    <tr>
                        <td><strong style="float:left;">Total Cash Paid</strong></td>
                        <td class="span2"><strong style="color: #f70b20; font-size: 1.5em;">{{$total_paid_from_cash}}</strong>&nbsp;Tk</td>
                    </tr>
            </tbody>
        </table>
    </div>
</div>
    <div class="span10">   
        <br>
        <table class="table table-bordered">
            <tbody>
                <?php $balance_amount = $total_cash_received - $total_paid_from_cash; ?>
                    <tr>
                        <td style="font-size: 1.5em;">
                            Balance Amount
                        </td>
                        <td>:</td>
                        <td>
                            <strong @if($balance_amount<0) style="color: #f70b20; font-size: 1.5em;" @else style="color: green; font-size: 1.5em;" @endif>
                                {{$balance_amount}} Tk
                            </strong>
                        </td>
                    </tr>
            </tbody>
        </table>
    </div>
@stop