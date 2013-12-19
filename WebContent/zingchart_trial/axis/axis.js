//Create the SVG Viewport
 var svgContainer = d3.select("body").append("svg")
                                      .attr("width", 40)
                                      .attr("height", 100);
 
 //Create the Scale we will use for the Axis
 var axisScale = d3.scale.linear()
                          .domain([0, 100])
                          .range([0, 400]);

//Create the Axis
var xAxis = d3.svg.axis()
                   .scale(axisScale);


//Create an SVG group Element for the Axis elements and call the xAxis function
var xAxisGroup = svgContainer.append("g")
                              .call(xAxis);

