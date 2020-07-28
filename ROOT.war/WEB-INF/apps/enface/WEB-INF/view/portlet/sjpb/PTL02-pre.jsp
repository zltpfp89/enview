<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(document).ready(function(){
	ajaxPTL02("/sjpb/Z/PTL02.face","PTL02");
	ajaxPTL02("/sjpb/Z/PTL0200.face","totalPTL02");
});
function ajaxPTL02(url,ptl02){
	$.ajax({
		url			: url,
		type		: "POST",
		dataType	: "json",
		data		: "{}",
		cache		: false,
		success: function (result) {
			if(ptl02 == "PTL02"){
				Highcharts.setOptions({
				     colors: [ '#5b98d1','#cfd8dc']
				    });
			}
			if(ptl02 == "totalPTL02"){
				Highcharts.setOptions({
				     colors: ['#ff9800','#cfd8dc']
				    });
			}

			
			var PTL02 = new Highcharts.chart(ptl02, {
				chart: {
			        plotBackgroundColor: null,
			        plotBorderWidth: null,
			        plotShadow: false,
			        type: 'pie'
			    },
			    title: {
			        text: '',
			    },
			    credits: {
			        enabled: false
			    },
			    exporting: { 
			    	enabled: false },
			    tooltip: {
			        headerFormat: '',
			        pointFormat: '<span style="color:{point.color}">\u25CF</span> <b> {point.name}</b><br/>' +
			            '<b>{point.y}%</b>'
			    },
			    plotOptions: {
			        pie: {
			            allowPointSelect: true,
			            cursor: 'pointer',
			            dataLabels: {
			                enabled: true,
			                format: '<b>{point.name}</b><br>{point.y} %',
			                distance: -30,
			                style: {
			                    fontWeight: 'bold'
			                }
			            },
			            center : ['50%','60%'],
			            size:'110%'
//			            showInLegend: true
			        },
			        series: {
			            animation: false,
			            turboThreshold: 0,
			            dataLabels: {
			              style: {
			            	color:'black',
			                fontSize: '13px',
			                fontWeight: 'bold',
			                textOutline: '1px 1px contrast'
			              },
			              enabled: true
			            }
			        }
			    },
			    series: [{
			    	minPointSize: 10,
			    	zMin: 0,
			        allowPointSelect: true,
			        keys: ['name', 'y', 'selected', 'sliced'],
			        data: [ [
			            '송치 : '+result.trnsr+'건',
			            result.trnsrPer,
			        	false
			     	],[
			            '입건 : '+result.prsct+'건',
			             result.prsctPer,
			            false
			        ]]
			    }],
			    responsive: {
			        rules: [{
			            condition: {
			                maxWidth: 300
			            },
			            chartOptions: {
			                legend: {
			                    layout: 'horizontal',
			                    align: 'right',
			                    verticalAlign: 'bottom'
			                }
			            }
			        }]
			    }
			});

		},
		error: function (xhr, status, error) {
			alert('서버오류 입니다. 관리자에게 확인하세요. ' + error);
		}
		
	});
}


</script>
<div class="portlet monitering">
	<h2>${part}사건현황 <span>모니터링</span></h2>
	<div class="graph_wrap">
		<div class="graph_box">		
			<div id="PTL02" style="width:110%; height:110%; float:left; margin: 0 auto; position:relative;"></div>
			<div style="position:absolute; top:30;left:20;">${orgName}</div>
		</div>
		<div class="graph_box">
			<div id="totalPTL02" style="width:110%; height:110%; float:left; margin: 0 auto; position:relative;"></div>
			<div style="position:absolute; top:30;left:20;">전체</div>
		</div>
	</div>
	<a href="#" class="more"><img src="/sjpb/images/icon_more.png" alt="더보기버튼"></a>

</div>
