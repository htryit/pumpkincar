
<!DOCTYPE html>
<html lang="zh-CN" class="ua-windows ua-webkit">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="renderer" content="webkit">
	<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>Pumpkin Car</title>
	<style>
		.wrap {
			margin:0 auto;
			text-align:center;
		}
		.ctrl {
			margin:0 auto;
			margin-top:20px;
			width:320px;
		}
		
		.motor {
			width:150px;
			height:150px;
			position:relative;
			float:left;
		}
		
		.camera {
			border:solid 1px #eee;
			background-color:#edc;
			height:150px;
			width:150px;
			float:right;
		}
		
		.motor input {
			width:60px;
			height:40px;
			line-height:40px;
			font-size:24px;
			margin:5px;
			position:absolute;
		}
		
		.ml {
			top:50px;
			left:0px;
		}
		
		.mf {
			top:0px;
			left:40px;
		}
		
		.mr {
			top:50px;
			left:80px;
		}
		
		.mb {
			top:100px;
			left:40px;
		}
		
		h1 {
			font-size:32px;
			font-weight:normal;
		}
	</style>
</head>
<body>
<div class="wrap">
<h1>Pumpkin Car</h1>
<div>
<!--img id="imgpreview" src="http://192.168.6.20:8080/?action=stream" /-->
</div>
<div class="ctrl">
	<div class="motor">
		<input type="button" value="←" class="mop ml" opt=3 />
		<input type="button" value="↑"  class="mop mf"  opt=1 />
		<input type="button" value="→"  class="mop mr"  opt=4 />
		<input type="button" value="↓"  class="mop mb"  opt=2 />
	</div>
	<div class="camera" id="camera"></div>
</div>
</div>
<div id="test"></div>
<script src="jquery.js" type="text/javascript"></script>
<script>
$(function() {	
	var ismobile = function() {
		var app = navigator.appVersion;
		return (app.indexOf('Mobile') != -1 || app.indexOf('iPad') != -1 || app.indexOf('iPhone') != -1 || app.indexOf('Android') != -1);
	}
	
	var sendopt = function(controller, opt, callback) {
		$.ajax({
			url :'/' + controller + '?opt=' + opt,
			type:'get',
			success:function(result) {				
				if(callback) {
					callback(result);
				}
			}
		});
	}
	
	var gettouchposition = function(evt) {
		var position = {x:0, y:0};
		if (ismobile()) {
			//mobile
			var targetindex = 0;
			if (evt.originalEvent.changedTouches.length > 1) {
				for(var i = 0; i < evt.originalEvent.changedTouches.length; i++) {
					if (evt.originalEvent.changedTouches[i].target.className == 'camera') {
						targetindex = i;
						break;
					}
				}
			} 
			
			position.x = parseInt(evt.originalEvent.changedTouches[targetindex].clientX);
			position.y = parseInt(evt.originalEvent.changedTouches[targetindex].clientY);
		} else {
			//pc
			position.x = evt.originalEvent.x;
			position.y = evt.originalEvent.y;
		}
		
		return position;
	}
	
	var touchevent = {"touchstart":"touchstart", "touchmove":"touchmove", "touchend":"touchend"};
	var cpos = null;
	var ispress = false;
	
	if (!ismobile()) {
		touchevent.touchstart = "mousedown";
		touchevent.touchmove = "mousemove";
		touchevent.touchend = "mouseup";
	} 

	$('input.mop').bind(touchevent.touchstart, function() {
		var btn = $(this);
		var opt = parseInt($(this).attr('opt'));
		sendopt('motor', opt);
	});
	
	$('input.mop').bind(touchevent.touchend ,function() {
		sendopt('motor', 5);//stop
	});
	

	$('div.camera').bind(touchevent.touchstart ,function(evt) {
		ispress = true;	
		cpos = gettouchposition(evt);
	});
	
	$('div.camera').bind(touchevent.touchmove ,function(evt) {
		var bcacl = true;
		if (!ismobile() && !ispress) {
			bcacl = false;
		}
		if (bcacl) {
			var pos = gettouchposition(evt);
			var ox = 0;
			var oy = 0;
			if (cpos != null) {
				ox = pos.x - cpos.x;
				oy = pos.y - cpos.y;
			}
			
			//$("#test").html(pos.x +","+pos.y +"####"+ox+","+oy);		
		}
		//$("#test").html($(evt.originalEvent.changedTouches[0].target).attr('class'));
		evt.preventDefault();
	});
	
	$('div.camera').bind(touchevent.touchend ,function(evt) {
		ispress = false;
		cpos = null;
	});
	
	/*
	$("#test").html(navigator.userAgent +"<br/>"+navigator.appVersion + "<br/><br/>" + ismobile());
	
	
	$('input.opt').click(function() {
		var btn = $(this);
		var opt = parseInt($(this).attr('opt'));
		var run = $(this).attr('run');
		
		if (opt < 5) {
			if (run == 1) {
				opt = 5;
				$(this).attr('run', 0);
			}  else {
				$(this).attr('run', 1);
			}
		}
		
		$.ajax({
			url :'/ctrl?opt='+opt,
			type:'get',
			success:function() {				
				if (opt == 8) {
					btn.attr('opt',7);
				
				setTimeout(function() {
						$("#imgpreview").attr('src', 'http://192.168.6.20:8080/?action=stream&t='+Math.random());
					}, 1000);
				} else if (opt == 7) {
					btn.attr('opt',8);
				}
			}
		});
	});*/
	
});
</script>
</body>
</html>


