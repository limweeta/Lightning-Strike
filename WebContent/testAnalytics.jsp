
<script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
<script src="resources/d3.chart.min.js" charset="utf-8"></script>
<%	
TermDataManager termdm = new TermDataManager();
ArrayList<Term> allTerms = termdm.retrieveAll();
 %>
<form action="">

<h4>Choose which data you would like to view</h4>
<select name="type">
	<option value=1>Projects by Technology</option>
	<option value=2>Projects by Industry</option>
	<option value=3>Teams by Preferred Technology</option>
	<option value=4>Teams by Preferred Industry</option>
	<option value=5>Students by Skills</option>
</select>

<h4>Term</h4>

Select Term: 
<select name="term">
	<option value="0" selected>-</option>
	<%
	for(int i = 0; i < allTerms.size(); i++){
		Term term = allTerms.get(i);
		%>
		<option value="<%=term.getId()%>"><%="AY" + term.getAcadYear() + " T" + term.getSem() %></option>
		<%
	}
	%>
</select>
<input type="submit" value="View" />
</form>
<%
String title = "";
int type = 5;
try{
 	type = Integer.parseInt(request.getParameter("type"));
}catch(Exception e){
	type = 5;
}

int term = 0;
try{
	term = Integer.parseInt(request.getParameter("term"));
}catch(Exception e){
	term = 0;
}
%>

<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<%
AnalyticsDataManager adm = new AnalyticsDataManager();

TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> dataMap = null;
String dataType = "";
switch(type){
	case 1:
		dataMap = adm.projectByTech(term);
		dataType = "Tech";
		title = "Projects by Technology";
		break;
	case 2:
		dataMap = adm.projectByInd(term);
		title = "Projects by Industry";
		dataType = "Ind";
		break;
	case 3:
		dataMap = adm.teamByTech(term);
		title = "Teams by Preferred Technology";
		dataType = "Tech";
		break;
	case 4:
		dataMap = adm.teamByInd(term);
		title = "Teams by Preferred Technology";
		dataType = "Ind";
		break;
	case 5:
		dataMap = adm.studentBySkill(term);
		title = "Students by Skill";
		dataType = "Skill";
		break;
	default:
		dataMap = adm.studentBySkill(term);
		title = "Students by Skill";
		dataType = "Skill";
		break;
}


//TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> projIndMap = adm.projectByInd();

//TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> teamIndMap = adm.teamByInd();
//TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> teamTechMap = adm.teamByTech();

//TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> studentSkillMap = adm.studentBySkill();

%>
<h1><%=title %></h1>
<div id="bargraph" >
</div>

<style>
        .Barchart .label {
          font-size: 10px;
        }
        .Barchart .ylabels .tick line {
          fill: none;
          stroke: #222;
          stroke-width: 1px;
          shape-rendering: crispEdges;
        }
        .Barchart path.domain {
          fill: none;
          stroke: #222;
          stroke-width: 1px;
          shape-rendering: crispEdges;
        }
        .Barchart .bars rect.bar {
          fill: #97E8A2;
        }
      </style>
<script src='resources/jquery.min.js'></script>
<script>
d3.chart('BarChart', {
  initialize: function() {
    var chart = this;

    // default height and width
    chart.w = chart.base.attr('width') || 200;
    chart.h = chart.base.attr('height') || 150;

    // chart margins to account for labels.
    // we may want to have setters for this
    // if we were letting the users customize this too
    chart.margins = {
      top : 10,
      bottom : 15,
      left : 50,
      right : 0,
      padding : 10
    };

    // default chart ranges
    chart.x =  d3.scale.linear()
      .range([0, chart.w - chart.margins.left]);

    chart.y = d3.scale.linear()
      .range([chart.h - chart.margins.bottom, 0]);

    chart.base
      .classed('Barchart', true);

    // non data driven areas (as in not to be independatly drawn)
    chart.areas = {};

    // make sections for labels and main area
    //  _________________
    // |Y|    bars      |
    // | |              |
    // | |              |
    // | |              |
    // | |______________|
    //   |      X       |

    // -- areas
    chart.areas.ylabels = chart.base.append('g')
      .classed('ylabels', true)
      .attr('width', chart.margins.left)
      .attr('height', chart.h - chart.margins.bottom - chart.margins.top)
      .attr('transform', 'translate('+(chart.margins.left-1)+',0)');

    chart.areas.bars = chart.base.append('g')
      .classed('bars', true)
      .attr('width', chart.w - chart.margins.left)
      .attr('height', chart.h - chart.margins.bottom - chart.margins.top)
      .attr('transform', 'translate(' + chart.margins.left + ',' + chart.margins.top+')');

    chart.areas.xlabels = chart.base.append('g')
      .classed('xlabels', true)
      .attr('width', chart.w - chart.margins.left)
      .attr('height', chart.margins.bottom)
      .attr('transform', 'translate(' + chart.margins.left + ',' +
        (chart.h - chart.margins.bottom) + ')');

    // make actual layers
    chart.layer('bars', chart.areas.bars, {
      // data format:
      // [ { name : x-axis-bar-label, value : N }, ...]
      dataBind : function(data) {

        // save the data in case we need to reset it
        chart.data = data;

        // how many bars?
        chart.bars = data.length;

        // compute box size
        chart.bar_width = (chart.w - chart.margins.left - ((chart.bars - 1) *
          chart.margins.padding)) / chart.bars;

        // adjust the x domain - the number of bars.
        chart.x.domain([0, chart.bars]);

        // adjust the y domain - find the max in the data.
        chart.datamax = chart.usermax || d3.max(data, function(d) { 
          return d.value; 
        });
        chart.y.domain([0, chart.datamax]);

        // draw yaxis
        var yAxis = d3.svg.axis()
          .scale(chart.y)
          .orient('left')
          .ticks(6);

        chart.areas.ylabels
          .call(yAxis);

        return this.selectAll('rect')
          .data(data);
      },
      insert : function() {
        return this.append('rect')
          .classed('bar', true);
      }
    });

    // a layer for the x text labels.
    chart.layer('xlabels', chart.areas.xlabels, {
      dataBind : function(data) {
        // first append a line to the top.
        this.append('line')
          .attr('x1', 0)
          .attr('x2', chart.w - chart.margins.left)
          .attr('y1', 0)
          .attr('y2', 0)
          .style('stroke', '#222')
          .style('stroke-width', '1')
          .style('shape-rendering', 'crispEdges');


        return this.selectAll('text')
          .data(data);
      },
      insert : function() {
        return this.append('text')
          .classed('label', true)
          .attr('text-anchor', 'middle')
          .attr('x', function(d, i) {
            return chart.x(i) - 0.5 + chart.bar_width/2;
          })
          .attr('dy', '1em')
          .text(function(d) {
            return d.name;
          });
      }
    });

    // on new/update data
    // render the bars.
    var onEnter = function() {
      this.attr('x', function(d, i) {
            return chart.x(i) - 0.5;
          })
          .attr('y', function(d) {
            return chart.h - chart.margins.bottom - chart.margins.top - chart.y(chart.datamax - d.value) - 0.5;
          })
          .attr('val', function(d) {
            return d.value;
          })
          .attr('width', chart.bar_width)
          .attr('height', function(d) {
            //return chart.h - chart.margins.bottom - chart.y(chart.datamax - d.value);
            return chart.y(chart.datamax - d.value);
          });
    };

    chart.layer('bars').on('enter', onEnter);
    chart.layer('bars').on('update', onEnter);
  },

  // return or set the max of the data. otherwise
  // it will use the data max.
  max : function(datamax) {
    if (!arguments.length) {
      return this.usermax;
    }

    this.usermax = datamax;

    this.draw(this.data);

    return this;
  },

  width : function(newWidth) {
    if (!arguments.length) {
      return this.w;
    }
    // save new width
    this.w = newWidth;

    // adjust the x scale range
    this.x =  d3.scale.linear()
      .range([this.margins.left, this.w - this.margins.right]);

    // adjust the base width
    this.base.attr('width', this.w);

    this.draw(this.data);

    return this;
  },

  height : function(newHeight) {
    if (!arguments.length) {
      return this.h;
    }

    // save new height
    this.h = newHeight;

    // adjust the y scale
    this.y = d3.scale.linear()
      .range([this.h - this.margins.top, this.margins.bottom]);

    // adjust the base width
    this.base.attr('height', this.h);

    this.draw(this.data);
    return this;
  }
});

var barchart = d3.select('#bargraph')
  .append('svg')
  .attr('height', 500)
  .attr('width', 1200)
  .chart('BarChart');

<%
HashMap<Integer, String> map2 = new HashMap<Integer, String>();
TechnologyDataManager techdm = new TechnologyDataManager();
IndustryDataManager idm = new IndustryDataManager();
SkillDataManager skdm = new SkillDataManager();

for (Map.Entry<String, TreeMap<Integer, ArrayList<Integer>>> entry : dataMap.entrySet())
{
	map2 = new HashMap<Integer, String>();
	
	String term2 = entry.getKey();
	TreeMap<Integer, ArrayList<Integer>> data = entry.getValue();
	int graphNum = 0;
	for(Map.Entry<Integer, ArrayList<Integer>> entry2 : data.entrySet()){
		graphNum++;
		int dataid = entry2.getKey();
		int numOfValues = entry2.getValue().size();
		
		try{
			
			if(dataType.equalsIgnoreCase("Tech")){
				Technology tech = techdm.retrieve(dataid);
				map2.put(graphNum, "{ name : '" + tech.getTechName() + "', value : " + numOfValues + " }");
			}else if(dataType.equalsIgnoreCase("Ind")){
				Industry ind = idm.retrieve(dataid);
				map2.put(graphNum, "{ name : '" +ind.getIndustryName() + "', value : " + numOfValues + " }");
			}else{
				Skill skill = skdm.retrieve(dataid);
				map2.put(graphNum, "{ name : '" + skill.getSkillName() + "', value : " + numOfValues + " }");
			}
		}catch(Exception e){}
		
	}
	
	
}

String jsonString = "";
for (Map.Entry<Integer, String> entry : map2.entrySet()) {
	jsonString = jsonString + entry.getValue().toString()+",";
	
}
%>
barchart.draw([
	 <%= jsonString %>
]);

</script>
 
<br>
