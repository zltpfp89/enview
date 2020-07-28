<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 
<script type="text/javascript" src="<%=request.getContextPath()%>/widget/javascript/FusionCharts.js">
</script>

<script type="text/javascript" >
window.onload = HearMemoryChart;
	var sec=60;
	
	function HearMemoryChart()
	{ 
		
	var choicevalue  = document.getElementById("time_name").value;
	
	//alert(a);
	sec = choicevalue;
	var myChart = new FusionCharts("<%=request.getContextPath()%>/widget/Charts/RealTimeLine.swf", "ChId1", "600", "350", "0", "0");
	myChart.setDataXML(getxml()); 
	myChart.render("chartdiv"); 
	} 

function getxml()
	{ 
	var str1 = null;
	var path = "<%=request.getContextPath()%>/widget/data/MemoryValue.jsp";
	
	//alert(path);
	//alert("select = "+ sec);
	str1 += "<chart caption='Enview Memory Monitor' subCaption='' dataStreamURL=' " + path + "' refreshInterval='" + sec + "' numberPrefix=''  numDisplaySets='10'  xAxisName='Time' showRealTimeValue='1' realTimeValuePadding='50' labelDisplay='Rotate' slantLabels='1'>";
	str1 += "<categories>";
	str1 += "</categories>";
	str1 += "<dataset seriesName='Memory' showValues='1'>";
	str1 += "</dataset>";
	str1 += "<styles>";
	str1 += "<definition>";
	str1 += "<style type='font' name='captionFont' color='red' size='14' />";
	str1 += "</definition>";
	str1 += "<application>";
	str1 += "<apply toObject='Caption' styles='captionFont' />";
	str1 += "<apply toObject='Realtimevalue' styles='captionFont' />";
	str1 += "</application>";
	str1 += "</styles>";
	str1 += "</chart>";
return str1; 
	} 
	</script> 
</head>
<body>
    <select onchange="HearMemoryChart()" align="right" id="time_name">
           <option value="60">Time Select</option>
           <option value="5">05 sec </option>
           <option value="15">15 sec </option>
           <option value="30">30 sec </option>
           <option value="45">45 sec </option>
           <option value="60">01 min </option>
           <option value="300">05 min</option>
           <option value="600">10 min</option>
           <option value="1200">20 min</option>
           <option value="1800">30 min</option>
           <option value="3600">60 min</option>
     </select>
     
<br><br><br><br>
<div id="chartdiv" align="center"></div> 
</body>
</html>