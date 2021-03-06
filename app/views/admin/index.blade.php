@extends('_layouts.default')

@section('content')
<style type="text/css">
/*	html,body {
    height: 100%;
}*/
#clocks {
    background: #ffffff;
    background: radial-gradient(ellipse at center,  #0a2e38  0%, #000000 70%);
    background-size: 100%;
}
#clocks p {
    margin: 0;
    padding: 0;
    color: #daf6ff;
    text-shadow: 0 0 20px #00bfff, 0 0 20px rgba(10, 175, 230, 0);
    margin-left: 4%;
    /*font: 13px/1.3em 'Open Sans';*/

    /*display: block;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;*/
}
#clock {
    font-family: 'Share Tech Mono', monospace;
    color: #ffffff;
    text-align: center;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    /*color: #daf6ff;
    text-shadow: 0 0 20px rgba(10, 175, 230, 1),  0 0 20px rgba(10, 175, 230, 0);*/
    color: #daf6ff;
    text-shadow: 0 0 20px #00bfff, 0 0 20px rgba(10, 175, 230, 0);
}
    .time {
        letter-spacing: 0.05em;
        font-size: 50px;
        padding: 5px 0;
    }
    .date {
        letter-spacing: 0.1em;
        font-size: 24px;
    }
    .text {
        letter-spacing: 0.1em;
        font-size: 12px;
        padding: 20px 0 0;
    }

</style>
	<div class="row">		
		<div class="span12">
			@include('_sessionMessage')	
		</div>			
		<div class="span4">
		  <div class="widget widget-nopad">
			<!-- /widget-header -->
			<div class="widget-content">
			  <div class="widget big-stats-container">
				<div class="widget-content">
				  <!-- <div id="clock" class="light">
						<div class="display">
							<div class="weekdays"></div>
							<div class="ampm"></div>
							<div class="alarm"></div>
							<div class="digits"></div>
						</div>
					</div> -->
					<div id="clocks">
					    <p class="date" style="margin-left: 15%;"></p>
					    <p class="time"></p>
					</div>
				</div>
				<!-- /widget-content --> 			
			  </div>
			</div>
		  </div>
		  <!-- /widget -->
		  {{ HTML::image('img/memo-logo-ex.png','title', array('class' => 'company_logo','style'=>'    padding-left: 40px;height: 70px;width: 300px;')) }}
		</div>
			<?

//only module, which has no sub Module
  // $modulesWithoutSub=DB::table('moduleemppermissions')
  //          ->join('modulenames', 'moduleemppermissions.module_id', '=', 'modulenames.module_id')
  //          ->select('modulenames.*')
  //          ->where('moduleemppermissions.status', '=',1)
  //          ->where('emp_id', '=', Session::get('emp_id'))
  //          ->orderBy('modulenames.sorting', 'asc')
  //          ->get();
  //          dd($modulesWithoutSub);
			?>
		<div class="span8">		
			  <div class="widget">
				<!-- /widget-header -->
				<div class="widget-content">
				  <div class="shortcuts"> 
				  
          @if (count($modulesWithoutSub) >1) 
          @foreach ($modulesWithoutSub as $moduleWithoutSub)
            			<a href="{{Route("$moduleWithoutSub->module_url")}}" class="shortcut">
							{{ HTML::image('img/nav_icon/'.$moduleWithoutSub->icon.'','title', array('class' => 'icon')) }} <span class="shortcut-label">{{$moduleWithoutSub->module_name}}</span> 
						</a>
            @endforeach
          @endif
					</div>
				  <!-- /shortcuts -->
					</div>
				<!-- /widget-content --> 
			  </div>
		</div>
	</div>
	
	<!-- Clock Js-->
	{{ HTML::script('js/clock.js') }}
	{{ HTML::script('js/moment.min.js') }}
	<script type="text/javascript">
		setInterval(function(){ formatAMPM(); }, 500);
		function formatAMPM() {
		var d = new Date(),
			second = d.getSeconds();
		    minutes = d.getMinutes().toString().length == 1 ? '0'+d.getMinutes() : d.getMinutes(),
		    hours = d.getHours().toString().length == 1 ? '0'+d.getHours() : d.getHours(),
		    ampm = d.getHours() >= 12 ? 'pm' : 'am',
		    months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
		    days = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
		    $('.date').html(days[d.getDay()]+' '+months[d.getMonth()]+' '+d.getDate()+' '+d.getFullYear());
		    $('.time').html( hours+':'+minutes+':'+second+''+ampm);
		}
	</script>
@stop
@section('stickyInfo')
<!-- <div id="sticky" style="text-align: center;">        
	<ul id="example-3" class="sticklr" style="margin-left:5px;color:#ffffff;background-color: #053a64;font-size:18px;font-family:monospace;">
		<li>D</li><li>a</li><li>s</li><li>h</li><li>b</li><li>o</li><li>a</li><li>r</li><li>d</li>
	</ul>       
</div> -->
@stop