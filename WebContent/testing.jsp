<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>

<html>

<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
<script type="text/javascript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
<script src="js/jquery.autocomplete.js"></script>  
<link rel="stylesheet" href="./css/bootstrap.css"  type="text/css"/>
<link rel="stylesheet" href="./css/glyphicons.css"  type="text/css"/>
<link rel="stylesheet" href="./css/bootstrap-responsive.css"  type="text/css"/>
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script src="./js/bootstrap.js"></script>
<script>
$(document).ready(function(){    
    $('#collapseFive').on('click', '.accordion-toggle', function () {
       $(".icon icon-minus").removeClass("icon icon-plus").addClass("icon icon-minus");
    });

    $('#collapseFive').on('click', '.accordion-toggle', function () {
       $(".icon icon-plus").removeClass("icon icon-minus").addClass("icon icon-plus");
    });
});
</script>
<body>

		<div class="panel-group" id="accordion">
		  <div class="panel panel-default">
			    <div class="panel-heading">
			      <h4 class="panel-title">
			        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseFive">
			          Team Skills 
			        </a>
			      </h4>
			    </div>
			    <div id="collapseFive" class="panel-collapse collapse">
			      <div class="panel-body">
				    	
					</div>
			    </div>
			  </div>
			  </div>
			  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
		          Preferred Skills
		        </a>
		      </h4>
		    </div>
		    <div id="collapseTwo" class="panel-collapse collapse">
		      <div class="panel-body">
		 			</div>
		    </div>
		  </div>
	
</body>

</html>