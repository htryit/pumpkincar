
var http = require('http');
var fs = require('fs');
var url = require('url');

var exec = require('child_process').exec;


function webcam(op) {
	var last = exec('sudo /etc/init.d/webcam ' + op);
	last.stdout.on('data',function(data) {
		//console.log(data);
	});
}

function motorrun(op) {
	var last = exec('sudo /home/pi/pumpkincar/motor '+op);
	last.stdout.on('data', function(data) {
		//console.log(data);	
	});
}

http.createServer(function(req, res) {
	var pathname = url.parse(req.url).pathname;
	var args = url.parse(req.url,true).query;
	var outfilename = '';
	
	if (pathname == '/') {
		outfilename = 'index.tpl';
		webcam('start');
		motorrun(0);		
	} else if (pathname == '/jquery.js') {
		outfilename = 'jquery.js';
	} else if (pathname == "/motor") {		
		if (args.opt != null) {
			var opt = parseInt(args.opt);
			console.log('motor:' + opt);
			motorrun(opt);
		}
	} else if (pathname == "/holder") {
		// camera
		if (args.opt != null) {
			
		}
	}
	
	
	if (outfilename != '') {
		fs.readFile(outfilename, function(err, file) {
			res.end(file);
		})
	} else {
		res.end('');
	}

}).listen(2014);
console.log('Server running at 2014.');
