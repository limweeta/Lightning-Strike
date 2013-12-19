Number of Projects
<script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
<script src="resources/d3.chart.min.js" charset="utf-8"></script>
<div id="bargraph" >
</div>

<%@ page import="manager.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*" %>
<%
AnalyticsDataManager adm = new AnalyticsDataManager();

TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> projSkillMap = adm.projectBySkills();
TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> projTechMap = adm.projectByTech();
TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> projIndMap = adm.projectByInd();

TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> teamIndMap = adm.teamByInd();
TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> teamTechMap = adm.teamByTech();

TreeMap<String, TreeMap<Integer, ArrayList<Integer>>> studentSkillMap = adm.studentBySkill();

Set set = projSkillMap.entrySet();
Iterator i2 = set.iterator(); 

%>
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
  .attr('height', 300)
  .attr('width', 400)
  .chart('BarChart');





<%
HashMap<String, Integer> map1 = new HashMap<String, Integer>();
map1.put("AY11/12 T1", 1);
map1.put("AY11/12 T2", 2);
map1.put("AY12/13 T1", 3);
map1.put("AY12/13 T2", 4);
map1.put("AY13/14 T1", 5);
map1.put("AY13/14 T2", 6);

HashMap<Integer, String> map2 = new HashMap<Integer, String>();
map2.put(1, "{ name : 'AY11/12 T1', value : 29 }");
map2.put(2, "{ name : 'AY11/12 T2', value : 32 }");
map2.put(3, "{ name : 'AY12/13 T1', value : 48 }");
map2.put(4, "{ name : 'AY12/13 T2', value : 49 }");
map2.put(5, "{ name : 'AY13/14 T1', value : 58 }");
map2.put(6, "{ name : 'AY13/14 T2', value : 68 }");

System.out.println(request.getParameter("termEnd"));
System.out.println(map1.get(request.getParameter("termEnd")));
int start = map1.get(request.getParameter("termStart")==null?"AY11/12 T1":request.getParameter("termStart"));
int end = map1.get(request.getParameter("termEnd")==null?"AY13/14 T2":request.getParameter("termEnd"));
if(start==0) start=1;
if(end==0) end=6;
String jsonString = "";
for (int i = start ; i <= end; i++) {
	jsonString = jsonString + map2.get(i).toString()+",";
	
}
%>
barchart.draw([
	 <%= jsonString %>
]);



</script>
 
<br>

<form action="">

From 

<select name="termStart">
<option value="AY11/12 T1" selected>AY2011/2012 T1</option>
<option value="AY11/12 T2">AY2011/2012 T2</option>
<option value="AY12/13 T1">AY2012/2013 T1</option>
<option value="AY12/13 T2">AY2012/2013 T2</option>
<option value="AY13/14 T1">AY2013/2014 T1</option>
<option value="AY13/14 T2">AY2013/2014 T2</option>
</select>

To

<select name="termEnd">
<option value="AY11/12 T1">AY2011/2012 T1</option>
<option value="AY11/12 T2">AY2011/2012 T2</option>
<option value="AY12/13 T1">AY2012/2013 T1</option>
<option value="AY12/13 T2">AY2012/2013 T2</option>
<option value="AY13/14 T1" selected>AY2013/2014 T1</option>
<option value="AY13/14 T2">AY2013/2014 T2</option>
</select>

<br/><br/>

<div id="option">
 	<!-- <input name= "updateButton"
 		type= "button"
 		value= "Update"
 		style= "right"
 		onclick ="updateData()"/> -->
 	<input type="submit" value="Update">
 </div>
</form>

 
 
 <div>
		<p>
		Raw Data:<br />
		
             	2011/2012 T1 : 29<br />
             	
             	2011/2012 T2 : 32<br />
             	
             	2012/2013 T1 : 48<br />
             	
             	2012/2013 T2 : 49<br />
             	
             	2013/2014 T1 : 58<br />
             	
             	2013/2014 T2 : 68<br />
            
		</p>
</div>
<hr />
Project By Skills -- Map Format: Year, Skill Id, Project Id
<hr /><br />
<%


for (Map.Entry<String, TreeMap<Integer, ArrayList<Integer>>> entry : projSkillMap.entrySet())
{
	out.println(entry.getKey() + "/" + entry.getValue() + "<br /><br />");
}

%>
<hr />
<br />
