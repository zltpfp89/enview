<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="portlet p_22 monitering">
	
	<div id="ptl0201" style="width:95%; height:90%; float:left; margin:0 0; position:absolute;">
		
	</div>
	<h2 style="position:absolute; background-color:white">사건현황 <span>모니터링</span></h2>
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
			     colors: [ '#5b98d1','#bfd8e3','#698AF4','#9FAEE1']
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
			    	allowDecimals : false,
			        min: 0,
			        title: {
			            text: ''
			        },
			        labels: {
			            //overflow: 'justify',
			            enabled: true,
			            allowDecimals : false
			            //,
			            //formatter : function(){
			            //	return parseInt(this.value);
			            //}
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
			        name: '전체 입건',
			        data: [data.preTotalCount.prsct, data.curTotalCount.prsct]
			    },
			    {
			        name: '전체 지휘',
			        data: [data.preTotalCount.cmd, data.curTotalCount.cmd]
			    },
			    {
			        name: '전체 송치',
			        data: [data.preTotalCount.trnsr, data.curTotalCount.trnsr]
			    },
			    {
			        name: '전체 처분',
			        data: [data.preTotalCount.disp, data.curTotalCount.disp]
			    }]
			});
		},
			error: function (xhr, status, error) {
				alert('서버오류 입니다. 관리자에게 확인하세요. ' + error);
			}
			
		});
	}
</script>