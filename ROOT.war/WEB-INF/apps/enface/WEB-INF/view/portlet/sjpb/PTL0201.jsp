<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="portlet p_22 monitering">
	
	<div id="ptl0201" style="width:95%; height:90%; float:left; margin:0 0; position:absolute;">
		
	</div>
	<h2 style="position:absolute; background-color:white">${part}사건현황 <span>모니터링</span></h2>
<!-- 	<a href="#" class="more"><img src="/sjpb/images/icon_more.png" alt="더보기버튼"></a> -->

</div>
<script>
$(document).ready(function(){
	ajaxPTL0201("/sjpb/Z/PTL0201.face");
});
function ajaxPTL0201(url){
	$.ajax({
		url			: url,
		type		: "POST",
		dataType	: "json",
		data		: "{}",
		cache		: false,
		success: function (data) {
			Highcharts.setOptions({
			     colors: [ '#949494','#808080','#5b98d1','#cfd8dc']
			    });	
			var PTL02 = new Highcharts.chart('ptl0201', {
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
			            text: ''
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
			        layout: 'horizontal',
			        align: 'right',
			        verticalAlign: 'top',
			        x: 0,
			        y: -15,
			        floating: true,
// 			        borderWidth: 1,
			        backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
// 			        shadow: true
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