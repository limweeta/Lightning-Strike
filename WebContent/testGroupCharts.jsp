<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<meta charset="utf-8">
<style>

body {
  font: 10px sans-serif;
}

.axis path,
.axis line {
  fill: none;
  stroke: #000;
  shape-rendering: crispEdges;
}

.bar {
  fill: steelblue;
}

.x.axis path {
  display: none;
}

</style>
<body>
<div>
<form action="generateAnalyticsCSV" method="post">
View: 
<select name="viewType">
	<option value="1">Projects by Industry</option>
	<option value="2">Projects by Technology</option>
	<option value="3">Projects by Skills</option>
	<option value="4">Students By Skill</option>
	<option value="5">Teams by Preferred Industry</option>
	<option value="6">Teams by Preferred Technology</option>
</select>
<input type="submit" value="View" />
</form>
</div>

<br /><br /><br />

</body>
<%
TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> data = (TreeMap<String, TreeMap<Integer, ArrayList<Integer>>>) request.getAttribute("data");
String dataType = (String) request.getAttribute("dataType");
String factor = (String) request.getAttribute("factor");
String title = (String) request.getAttribute("title");
String text = "";

ProjectDataManager pdm = new ProjectDataManager();
StudentDataManager stdm = new StudentDataManager();
TeamDataManager tdm = new TeamDataManager();
IndustryDataManager idm = new IndustryDataManager();
SkillDataManager skdm = new SkillDataManager();
TechnologyDataManager techdm = new TechnologyDataManager();
if(data != null){
	for (Map.Entry<String, TreeMap<Integer, ArrayList<Integer>>> entry : data.entrySet())
	{
		text += "<u>" + entry.getKey() + "</u> <br /> ";
		TreeMap<Integer, ArrayList<Integer>> mapValue = entry.getValue();
		for (Map.Entry<Integer, ArrayList<Integer>> entryValue : mapValue.entrySet()){
			ArrayList<Integer> rawMap = entryValue.getValue();
			if(factor.equalsIgnoreCase("Skill")){
				Skill skill = skdm.retrieve(entryValue.getKey());
				text += skill.getSkillName() + " - " + Integer.toString(rawMap.size()) + " <br /> ";
			}else if(factor.equalsIgnoreCase("Industry")){
				Industry industry = idm.retrieve(entryValue.getKey());
				text += industry.getIndustryName() + " - " + Integer.toString(rawMap.size()) + " <br /> ";
			}else if(factor.equalsIgnoreCase("Tech")){
				Technology technology = techdm.retrieve(entryValue.getKey());
				text += technology.getTechName() + " - " + Integer.toString(rawMap.size()) + " <br /> ";
			}
		}
		text += "<br />";
	}
	out.println("<h2>" + title + "</h2>");
	out.println(text);
}
%>

<script src="http://d3js.org/d3.v3.min.js"></script>


<script>

var margin = {top: 20, right: 20, bottom: 30, left: 40},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

var x0 = d3.scale.ordinal()
    .rangeRoundBands([0, width], .1);

var x1 = d3.scale.ordinal();

var y = d3.scale.linear()
    .range([height, 0]);

var color = d3.scale.ordinal()
    .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);

var xAxis = d3.svg.axis()
    .scale(x0)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left")
    .tickFormat(d3.format(".2s"));

var svg = d3.select("body").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

d3.csv("test.csv", function(error, data) {
	  var ageNames = d3.keys(data[0]).filter(function(key) { return key !== "State"; });

  data.forEach(function(d) {
    d.ages = ageNames.map(function(name) { return {name: name, value: +d[name]}; });
  });

  x0.domain(data.map(function(d) { return d.State; }));
  x1.domain(ageNames).rangeRoundBands([0, x0.rangeBand()]);
  y.domain([0, d3.max(data, function(d) { return d3.max(d.ages, function(d) { return d.value; }); })]);

  svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis);

  svg.append("g")
      .attr("class", "y axis")
      .call(yAxis)
    .append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 6)
      .attr("dy", ".71em")
      .style("text-anchor", "end")
      .text("Population");

  var state = svg.selectAll(".state")
      .data(data)
    .enter().append("g")
      .attr("class", "g")
      .attr("transform", function(d) { return "translate(" + x0(d.State) + ",0)"; });

  state.selectAll("rect")
      .data(function(d) { return d.ages; })
    .enter().append("rect")
      .attr("width", x1.rangeBand())
      .attr("x", function(d) { return x1(d.name); })
      .attr("y", function(d) { return y(d.value); })
      .attr("height", function(d) { return height - y(d.value); })
      .style("fill", function(d) { return color(d.name); });

  var legend = svg.selectAll(".legend")
      .data(ageNames.slice().reverse())
    .enter().append("g")
      .attr("class", "legend")
      .attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; });

  legend.append("rect")
      .attr("x", width - 18)
      .attr("width", 18)
      .attr("height", 18)
      .style("fill", color);

  legend.append("text")
      .attr("x", width - 24)
      .attr("y", 9)
      .attr("dy", ".35em")
      .style("text-anchor", "end")
      .text(function(d) { return d; });

});

</script>
