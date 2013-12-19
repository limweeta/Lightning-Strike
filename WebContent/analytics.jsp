<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>D3: Drawing divs, spaced out</title>
		<script type="text/javascript" src="http://d3js.org/d3.v3.min.js"></script>
		<style type="text/css">
		
			div.bar {
				display: inline-block;
				width: 20px;
				height: 75px;	/* Gets overriden by D3-assigned height below */
				margin-right: 2px;
				background-color: green;
			}
		
		</style>
	</head>
	
	<body>
	<form name="analytics" action="analytics" method="post">
		<table>
			<tr>
				<td valign="top">
					View Data for the following:<br />
					<input type="radio" name="table" value="Supervisors" /> Supervisors<br />
					<input type="radio" name="table" value="Students" /> Students<br />
					<input type="radio" name="table" value="Teams" /> Teams<br />
					<input type="radio" name="table" value="Projects" /> Projects<br />
					<input type="radio" name="table" value="Sponsors" /> Sponsors<br />
				</td>
				<td valign="top">
					in the following period: <br />
					<select name="duration">
						<option value=0>All Time</option>
						<%
						for(int i = 0; i < 10; i++){
							%>
							<option value="<%=i+1%>"><%=i+1%> semester(s) ago</option>
							<%
						}
						%>
					</select>
				</td>
			</tr>
		</table>
	</form>
<br />
	
	<%
	TermDataManager termdm = new TermDataManager();
	TeamDataManager tdm = new TeamDataManager();
	Map<Integer, Integer> teamsByTerm = tdm.analyticsRetrieveTeamByTerm();
	
	String nullCounter = "0";
	ArrayList<String> term = new ArrayList<String>();
	ArrayList<String> occurrences = new ArrayList<String>();
	for (Integer name: teamsByTerm.keySet()){

        String key = name.toString();
        String value = teamsByTerm.get(name).toString();  
        System.out.println(key + " " + value);  
		
        
        if(!key.equalsIgnoreCase("0")){
			term.add(termdm.retrieve(Integer.parseInt(key)).getAcadYear() + " T" + termdm.retrieve(Integer.parseInt(key)).getSem());
			occurrences.add(value);
        }else{
        	nullCounter = value;
        }
	} 
	%>
	Number of Teams in each term<br />
		
		<script type="text/javascript">
		
			var dataset = [ 
			               <%
	                       for(int i = 0; i < occurrences.size(); i++){
	                       	out.println("\""+occurrences.get(i)+"\",");
	                       }
	                       %>
			                ];
			
			d3.select("body").selectAll("div")
				.data(dataset)
				.enter()
				.append("text")
				.append("div")
				.attr("class", "bar")
				.style("height", function(d) {
					var barHeight = d * 5;
					return barHeight + "px";
				});
			
		</script>
		
		<div class="ui-widget">
		<p>
		Raw Data:<br />
		<%
             for(int i = 0; i < term.size(); i++){
             	String termName = term.get(i);
             	%>
             	<%=termName + " : " + occurrences.get(i) %><br />
             	<%
             }
             %>
             Invalid Data: <%=nullCounter %>
		</p>
		<script src="./zingchart_trial/axis/axis.js"></script>
</div>

<div class="ui-widget">
		TEST
</div>
 


 
 
 
 
</body>
</html>

		
	