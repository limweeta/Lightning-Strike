<html>
<style type="text/css" title="currentStyle">
	@import "./css/style.css";
</style>
<link rel="stylesheet" href="./css/bootstrap.css"  type="text/css"/>
	
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script src="./js/bootstrap.js"></script>

<body>
<%@include file="template.jsp"%>

<%
	Calendar now = Calendar.getInstance();
	int currYear = now.get(Calendar.YEAR);
	int currMth = now.get(Calendar.MONTH); 
%>
<div class="container">
<div class="content">
<h3>Export CSV</h3>
<form name="exportTeam" method="post" action="exportTeam">
	<div class="control-group">
		  <label class="control-label" for="projectterm">Project Term</label>
		  <div class="controls">
		   <select id="term" name="term" class="input-large">
		   <option value="16">Test Data Here</option>
		    	  <%
		    	  TermDataManager termdm = new TermDataManager();
		    	  ArrayList<Term> terms  = termdm.retrieveFromNextSem();
				  int currTermId = termdm.retrieveTermId(currYear, currMth);
				  
		    	  for(int i = 0; i < terms.size(); i++){
		    		Term showTerm = terms.get(i); 
		    		if((currTermId + 1) == showTerm.getId()){	
		    	%>
		    	  <option value="<%=showTerm.getId()%>" selected><%=showTerm.getAcadYear() + " T" + showTerm.getSem() %></option>
		    	 <%
		    		}else{
    			%>
		    	  <option value="<%=showTerm.getId()%>"><%=showTerm.getAcadYear() + " T" + showTerm.getSem() %></option>
		    	 <%	
		    		}
		    	  }
		    	 %>
		    	 </select>
		  </div>
	</div>
	<input type="submit" class="btn btn-success" value="Export">
</form>
</div>
</div>
</body>
</html>