<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${cPath}/Highcharts/highcharts.js"></script>
<script src="${cPath}/Highcharts/highcharts-more.js"></script>
<script src="${cPath}/Highcharts/modules/series-label.js"></script>
<script src="${cPath}/Highcharts/modules/exporting.js"></script>
<script src="${cPath}/Highcharts/modules/export-data.js"></script>
<script src="${cPath}/Highcharts/modules/variable-pie.js"></script>
<script src="${cPath}/Highcharts/modules/exporting.js"></script>
<script src="${cPath}/Highcharts/modules/export-data.js"></script>
<script type="text/javascript" src="${cPath}/sjpb/js/Z/common.js"></script>
</head>
<body>
<div id="asd">

</div>

<script>
$(document).ready(function(){
	ajaxPTL02("/sjpb/Z/PTL02.face");
});
function ajaxPTL02(url){
	$.ajax({
		url			: url,
		type		: "POST",
		dataType	: "json",
		data		: "{}",
		cache		: false,
		success: function (data) {
	debugger;
			var PTL02 = new Highcharts.chart('asd', {
			    chart: {
			        type: 'bar'
			    },
			    title: {
			        text: '',
			    },
			    credits: {
			        enabled: false
			    },
			    exporting: { 
			    	enabled: false 
			    },
			    xAxis: {
			        categories: [data.preYear, data.curYear],
			        title: {
			            text: null
			        }
			    },
			    yAxis: {
			        min: 0,
			        title: {
			            text: '건수',
			            align: 'high'
			        },
			        labels: {
			            overflow: 'justify'
			        }
			    },
			    tooltip: {
			    	valueSuffix: '건'
			    },
			    plotOptions: {
			        bar: {
			            dataLabels: {
			                enabled: true
			            }
			        }
			    },
			    legend: {
			        layout: 'vertical',
			        align: 'right',
			        verticalAlign: 'top',
			        x: -40,
			        y: 80,
			        floating: true,
			        borderWidth: 1,
			        backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
			        shadow: true
			    },
			    credits: {
			        enabled: false
			    },
			    series: [{
			        name: data.preTmCount.criTmNm+' 입건',
// 			        data:[20,30]
			        data: [data.preTmCount.prsct, data.curTmCount.prsct]
			    }, 
			    {
			        name: data.preTmCount.criTmNm+' 송치',
// 			        data:[10,20]
			        data: [data.preTmCount.trnsr, data.curTmCount.trnsr]
			    }, 
			    {
			        name: '전체 입건',
// 			        data:[55,11]
			        data: [data.preTotalCount.prsct, data.curTotalCount.prsct]
			    },
			    {
			        name: '전체 송치',
// 			        data:[55,77]
			        data: [data.preTotalCount.trnsr, data.curTotalCount.trnsr]
			    }]
			});
		},
			error: function (xhr, status, error) {
				alert('서버오류 입니다. 관리자에게 확인하세요. ' + error);
			}
			
		});
	}
</script>
</body>
</html>