<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>

<html>

<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
 
<link rel="stylesheet" href="./css/bootstrap.css"  type="text/css"/>
<link rel="stylesheet" href="./css/glyphicons.css"  type="text/css"/>
<link rel="stylesheet" href="./css/bootstrap-responsive.css"  type="text/css"/>
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
<script src="./js/bootstrap.js"></script>
<style type="text/css">
.accordion-toggle:hover {
	text-decoration:none;
}
/*
.panel-group .accordion-toggle:hover span {
	text-decoration:underline;
}

.panel-title .accordion-toggle:before {
	font-family:FontAwesome;
	font-size:16px;
	margin-right:5px;
	vertical-align:-1px;
}

 
.panel-group .accordion-toggle:not(.collapsed):before{
	content:'\f067';	
	margin-left:0px;
} 

.panel-group .accordion-toggle.collapsed:before{
	content:'\f068';	
	margin-left:0px;
} 
 */
.panel-title .accordion-toggle:after {
    /* symbol for "opening" panels */
	font-family:FontAwesome;
	font-size:16px;
    content: '\f068';    /* adjust as needed, taken from bootstrap.css */
    float: right;        /* adjust as needed */

}
.panel-title .accordion-toggle.collapsed:after {
    /* symbol for "collapsed" panels */
    font-family:FontAwesome;
	font-size:16px;
    content: '\f067';  
}

.container {
width: 600px !important;
}

.container > .content {
text-align: center;
background-color: #ffffff;
padding: 20px;
margin: 0 -20px;
-webkit-border-radius: 10px 10px 10px 10px;
-moz-border-radius: 10px 10px 10px 10px;
border-radius: 10px 10px 10px 10px;
-webkit-box-shadow: 0 1px 2px rgba(0,0,0,.15);
-moz-box-shadow: 0 1px 2px rgba(0,0,0,.15);
box-shadow: 0 1px 2px rgba(0,0,0,.15);
}
</style>
<!-- <script>
function dropdown(){
	
	$('#plus').hide();
	$('#minus').show();
	
}

function dropdown2(){
	
	$('#plus2').hide();
	$('#minus2').show();
	
}
</script> -->
<body>
		<div class="container">
			<div class="alert alert-success">
			  <button type="button" class="close" data-dismiss="alert">&times;</button>
			  <strong>WASSUP</strong>
			</div>
		</div>
	<%-- <select id="teamlimit" name="teamlimit" class="input-large" onchange="alterTeamLimit()">
						      <option value="4" selected>4</option>
						      <option value="5">5</option>
						      <option value="6">6</option>
						    </select>
						    
						    
						    <script>
						    function alterTeamLimit() {
						    	alert('hello');
						    
						    }
						    </script>
						    
			<select id="orgType" name="orgType" class="input-large">

			<%
		    	  OrganizationDataManager orgdm = new OrganizationDataManager();
			    	  ArrayList<Organization> orgs  = orgdm.retrieveAll();
					  
			    	  for(int i = 0; i < orgs.size(); i++){
			    		Organization org = orgs.get(i); 
			    		String orgType = org.getOrgType();
					   %>
					    	<option value="<%=orgType%>"><%=orgType%></option>
					    <%
					    }
					    %>
					
		     </select>   --%>
</body>

</html>