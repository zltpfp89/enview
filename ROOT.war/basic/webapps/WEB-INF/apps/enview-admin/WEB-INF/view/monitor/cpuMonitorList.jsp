<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 
<script type="text/javascript" src="<%=request.getContextPath()%>/widget/javascript/FusionCharts.js">
</script>

<script type="text/javascript" >
window.onload = CpuChart;
	var sec2=60;
	
	function CpuChart()
	{ 
		
	var choicevalue2  = document.getElementById("time_name2").value;
	
	//alert(a);
	sec2 = choicevalue2;
	var myChart2 = new FusionCharts("<%=request.getContextPath()%>/widget/Charts/RealTimeLine.swf", "ChId1", "600", "350", "0", "0");
	myChart2.setDataXML(getxml2()); 
	myChart2.render("chartdiv2"); 
	} 

function getxml2()
	{ 
	var str2 = null; 
	var path2 = "<%=request.getContextPath()%>/widget/data/CpuValue.jsp";
	
	//alert("select = "+ sec2);
	str2 += "<chart caption='Enview CPU Monitor' subCaption='' dataStreamURL='" + path2 + "' refreshInterval='" + sec2 + "' numDisplaySets='20' yAxisMaxValue='100' decimals='0'   numberSuffix='%'  numberPrefix='' xAxisName='Time' showRealTimeValue='1' realTimeValuePadding='50' labelDisplay='Rotate' slantLabels='1'>";
	str2 += "<categories>";
	str2 += "</categories>";
	str2 += "<dataset seriesName='CPU' showValues='1'>";
	str2 += "</dataset>";
	str2 += "<styles>";
	str2 += "<definition>";
	str2 += "<style type='font' name='captionFont' color='red' size='14' />";
	str2 += "</definition>";
	str2 += "<application>";
	str2 += "<apply toObject='Caption' styles='captionFont' />";
	str2 += "<apply toObject='Realtimevalue' styles='captionFont' />";
	str2 += "</application>";
	str2 += "</styles>";
	str2 += "</chart>";
return str2; 
	} 
	</script> 
</head>

<body>
	<select onchange="CpuChart()" align="right" id="time_name2">
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
<div id="chartdiv2" align="center"></div> 
</body>
</html>