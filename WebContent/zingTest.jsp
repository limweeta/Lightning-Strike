
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>ZingChart Docs</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="ZingChart Documentation">
	<meta name="author" content="ZingChart">
	<link href="./css/bootstrap.min.css" rel="stylesheet">
	<style type="text/css">
	body {
		padding-top: 60px;
		padding-bottom: 40px;
	}
	</style>
	<link href="./css/bootstrap-responsive.min.css" rel="stylesheet">
	<!--[if lt IE 9]>
	<script src="resources/html5.js"></script>
	<![endif]-->

	<link rel="shortcut icon" href="favicon.ico">

	<script src="./resources/jquery.min.js"></script>

	<script src="./css/prettify.js"></script>
	<link href="./css/prettify.css" rel="stylesheet">

	<link href="./resources/zcdocs.css" rel="stylesheet">

	<script src="./area_blue.js"></script>
	<noscript>
		<div class="box">
			Some browsers (e.g. Internet Explorer) may have by default security settings that restrict the execution of JavaScript code when the html pages are loaded locally.
			<br>In order to fully experience the ZingChart demos when using these browsers, the pages should be opened via a web server, and/or by using the "Load data from JavaScript object" option.
		</div>
	</noscript>

</head>

<body onload="prettyPrint()">

	<div class="navbar navbar-fixed-top" id="topbar">
		<div class="navbar-inner">
			<div class="container">
				<a class="brand" href="../index.html"><b><span style="color:#fff">Zing</span><span style="color:#00BBF1">Chart</span></b> <span style="color:#fff">Docs</span></a>
			</div>
		</div>
	</div>

	<div class="container">

<script type="text/javascript">
function render() {
	var sDataSource = document.getElementById('datasource').value;
	zingchart.OFFSET = 1;
	zingchart.render({
		id : 'zc',
		output : 'svg',
		width : 500,
		height : 400,
		dataurl : (sDataSource=='url'?'area_blue.txt':null),
		data : (sDataSource=='js'?gdata:null)
	});
}

$(document).ready(function() {

if (window.location.protocol == 'file:') {
	document.getElementById('localajax').style.display = 'block';
}



zingchart.loadModules('api,debug,tooltip');


zingchart.MODULESDIR = "./zingchart_trial/html5_scripts/modules/";
render();



});
</script>

		<p id="localajax" class="alert">
			Some browsers (e.g. Chrome) restrict by default the use of AJAX calls (via <code>dataurl</code> parameter of the <code>render()</code> call) when the pages are loaded locally.
			<br>In order to fully experience the ZingChart demos when using these browsers, the pages should be opened via a web server, and/or by using the "Load data from JavaScript object" option.
		</p>
		<p>
			Load data from
			<select id="datasource" onchange="render()">
				<option value="js" selected="selected">JavaScript object</option>
				<option value="url">URL</option>
			</select>
		</p>

		<div class="well" id="zc" style="float:left;width:500px;height:400px"></div>

		

		<div style="clear:both"></div>

		<hr>

		<footer>
			<p>
				ZingChart &copy; 2013 PINT, Inc. - doc version 0.130920
				<br>
				ZingChart <a href="http://www.zingchart.com/legal/tc.php" target="_blank">Terms and Conditions</a> and <a href="http://www.zingchart.com/privacy/" target="_blank">Privacy Policy</a>.
			</p>
		</footer>

	</div>

	<script src="./resources/bootstrap.min.js"></script>

	<script src="./zingchart_trial/html5_scripts/modules/zingchart-html5-core-min.js"></script>

	<script src="./zingchart_trial/html5_scripts/license.js"></script>

</body>
</html>