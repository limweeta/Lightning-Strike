nv.addGraph(function() {
 2     var chart = nv.models.multiBarChart();
 3 
 4     chart.xAxis
 5         .tickFormat(d3.format(',f'));
 6 
 7     chart.yAxis
 8         .tickFormat(d3.format(',.1f'));
 9 
10     d3.select('#chart1 svg')
11         .datum(exampleData())
12       .transition().duration(500).call(chart);
13 
14     nv.utils.windowResize(chart.update);
15 
16     return chart;
17 });
18 
19 
20 
21 
22 function exampleData() {
23   return stream_layers(3,10+Math.random()*100,.1).map(function(data, i) {
24     return {
25       key: 'Stream' + i,
26       values: data
27     };
28   });
29 }