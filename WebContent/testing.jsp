<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>

<html>

<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
<script type="text/javascript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
<script src="js/jquery.autocomplete.js"></script>  
<link rel="stylesheet" href="./css/bootstrap.css"  type="text/css"/>

<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script src="./js/bootstrap.js"></script>

<body>

<%-- 	<div class = "span9 well">
		<div class = "span9">
			<table>
				<tr>
				     <td><input type="checkbox" onclick="toggleInd(this)" />&nbsp;Select All</td>
			     </tr>
		    	<tr>
					 <%
					  IndustryDataManager idm = new IndustryDataManager();
					  ArrayList<Industry> industries = idm.retrieveAll();
					 
					  for(int i = 0; i < industries.size(); i++){
						  Industry ind = industries.get(i);
						  %><td>
						  <input type="checkbox" name="industry" value="<%=ind.getIndustryId()%>">&nbsp;<span class="label label-default"><%=ind.getIndustryName() %></span>&nbsp;&nbsp;
						  </td>
						  <%
						  if((i+1) % 3 == 0){
							  %>
							  </tr><tr>
							  <%
						  }
					  }
					  %>
			  	</tr>
			</table>
		</div>
	</div>
	 --%>
	<div class="panel-group" id="accordion">
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
		          Preferred Industry
		        </a>
		      </h4>
		    </div>
		    <div id="collapseOne" class="panel-collapse collapse in">
		      <div class="panel-body">
		 			<table>
						<tr class="spaceunder">
						     <td><input type="checkbox" onclick="toggleSkill(this)" />&nbsp;<span class="label label-default">Select All</span></td>
					     </tr>
				    	<tr class="spaceunder">
							 <%
							    IndustryDataManager idm = new IndustryDataManager();
							    ArrayList<Industry> allInd = idm.retrieveAll();
							    count = 0;
								checked = false;
								for(int i = 0; i < allInd.size(); i++){
									checked = false;
									%>
									
									<%
									Industry hasInd = allInd.get(i);
									count++;
									for(int j  = 0; j < allInd.size(); j++){
										if(idm.hasPrefInd(teamId, hasInd.getIndustryId())){
											checked=true;
										}
										%>
										<%
									}
									if(checked){
									%>
								<td>
								  <input type="checkbox" name="industry" value="<%=allInd.get(i).getIndustryId() %>" checked="checked">&nbsp;<span class="label label-default"><%=allInd.get(i).getIndustryId() %></span>&nbsp;&nbsp;
								  </td><td></td>
								   <%
								  }else{
								  %><td>
								  <input type="checkbox" name="industry" value="<%=allInd.get(i).getIndustryId() %>">&nbsp;<span class="label label-default"><%=allInd.get(i).getIndustryId() %></span>&nbsp;&nbsp;
								  </td><td></td>
								  <%  
									}
								  
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
		  </div>
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
		          Preferred Technology
		        </a>
		      </h4>
		    </div>
		    <div id="collapseTwo" class="panel-collapse collapse">
		      <div class="panel-body">
			    	<table>
						<tr class="spaceunder">
						     <td><input type="checkbox" onclick="toggleTech(this)" />&nbsp;<span class="label label-default">Select All</span></td>
					     </tr>
				    	<tr class="spaceunder">
							<%
							    ArrayList<Technology> allTech = techdm.retrieveAll();
							    int count = 0;
								boolean checked = false;
								for(int i = 0; i < allTech.size(); i++){
									checked = false;
									%>
									
									<%
									Technology hasTech = allTech.get(i);
									count++;
									for(int j  = 0; j < allTech.size(); j++){
										if(techdm.hasPrefTech(teamId, hasTech.getId())){
											checked=true;
										}
										%>
										<%
									}
									if(checked){
								%>
								<td>
								  <input type="checkbox" name="technology" value="<%=allTech.get(i).getId() %>" checked="checked">&nbsp;<span class="label label-default"><%=allTech.get(i).getId() %></span>&nbsp;&nbsp;
								  </td><td></td>
								   <%
								  }else{
								  %><td>
								  <input type="checkbox" name="technology" value="<%=allTech.get(i).getId() %>">&nbsp;<span class="label label-default"><%=allTech.get(i).getId() %>></span>&nbsp;&nbsp;
								  </td><td></td>
								  <%  
									}
								  
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
		  </div>
	  </div>
	
	
</body>

</html>