<html>
<head>
<style type="text/css">

	.container > .content {
	
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
<script type="text/javascript">
   
    $(function() {
        $( "#from" ).datepicker({
          defaultDate: "+1w",
          changeMonth: true,
          numberOfMonths: 3,
          onClose: function( selectedDate ) {
            $( "#to" ).datepicker( "option", "minDate", selectedDate );
          }
        });
        $( "#to" ).datepicker({
          defaultDate: "+1w",
          changeMonth: true,
          numberOfMonths: 3,
          onClose: function( selectedDate ) {
            $( "#from" ).datepicker( "option", "maxDate", selectedDate );
          }
        });
      });
	</script>	
<%@include file="template.jsp"%>
 <%
	SponsorDataManager sponsordm = new SponsorDataManager();
	ArrayList<Sponsor> allSponsors = sponsordm.retrieveAll();
	Calendar now = Calendar.getInstance();
	int currYear = now.get(Calendar.YEAR);
	int currMth = now.get(Calendar.MONTH);
%>
</head>
<body>
	<div class="container" id="content-container">
		<div class="content">
			<%
						String message = (String) session.getAttribute("message"); 
						if(message == null || message.isEmpty()){
							message = "";
						}else{
					%>
						<div class="alert alert-success" align="center">
									  <button type="button" class="close" data-dismiss="alert">&times;</button>
									  <strong><%=message %></strong>
									</div>
					<%
						session.removeAttribute("message");
						}
					%>
			<form name="deleteSponsor" action="deleteSponsor" method="post" class="form-horizontal">
						<fieldset>
						<legend>Delete Sponsor</legend>
						<div class="span7">
						<div class="control-group">
						  <label class="control-label" for="deleteSponsor">Delete Sponsor</label>
						  <div class="controls">
						   		<input id="sponsorUsername" type="text" placeholder="Sponsor Username" name="sponsorUsername">
						  </div>
						</div>
						<div class="control-group">
						  <div class="controls">
						    <input type="submit" value="Remove" class="btn btn-warning">
						  </div>
						</div>
						</br>
						</div>
						</fieldset>
					</form>
				
		</div>
	</div>
</body>
</html>