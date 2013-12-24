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
    /* symbol for "collapsed" panels */
    font-family:FontAwesome;
	font-size:16px;
    content: '\f067'; 
    float:right; 
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
<%
TechnologyDataManager tdm = new TechnologyDataManager();
int numOfCat = tdm.retrieveNoOfTechCat();
%>
<script>
$(document).ready(function(){
    var next = 1;
    $(".add-more").click(function(e){
        e.preventDefault();
        var addto = "#field" + next;
        next = next + 1;
        var newIn = '</br>' ;
        var newInput = $(newIn);
        $(addto).after(newInput);
        $("#field" + next).attr('data-source',$(addto).attr('data-source'));
        $("#count").val(next);  
    });
});
</script>
<body>
	<div class="container">
	<div class="row">
		<input type="hidden" name="count" value="1" />
        <div class="control-group" id="fields">
            <label class="control-label" for="field1">Nice Multiple Form Fields</label>
            <div class="controls" id="profs"> 
                <div class="input-append">
                    <input autocomplete="off" class="span3" id="field1" name="prof1" type="text" placeholder="Type something (it has typeahead too)" data-provide="typeahead" data-items="8" data-source='["Aardvark","Beatlejuice","Capricorn","Deathmaul","Epic"]'/><button id="b1" class="btn btn-info add-more" type="button">+</button>
                </div>
            <br>
            <small>Press + to add another form field :)</small>
            </div>
        </div>
	</div>
</div>

<%-- <div class="panel panel-default">
			    <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#collapseTwo" style="cursor:pointer;">
			      <h4 class="panel-title">
			        <a class="accordion-toggle">
			          Preferred Technology
			        </a>
			      </h4>
			    </div>
			    <div id="collapseTwo" class="panel-collapse collapse in">
			      <div class="panel-body">
				    	<table>
							<tr class="spaceunder">
							     <td><input type="checkbox" onclick="toggleTech(this)" />&nbsp;<span class="label label-default">Select All</span></td>
						     </tr>
					    	<tr class="spaceunder">
								<%
								  TechnologyDataManager tdm = new TechnologyDataManager();
								  ArrayList<Technology> technologies = tdm.retrieveAll();
								 
								  for(int i = 0; i < technologies.size(); i++){
									  Technology tech = technologies.get(i);
									  %><td>
									  <input type="checkbox" name="technology" value="<%=tech.getId()%>">&nbsp;<span class="label label-default"><%=tech.getTechName() %></span>&nbsp;&nbsp;
									  </td><td></td>
									   <%
									  if((i+1) % 3 == 0){
									  %>
								  </tr><tr class="spaceunder">
								  <%
									  }
								  }
								  %>
						  	</tr>
						</table> 
					</div>
			    </div>
			  </div> --%>
		
</body>

</html>