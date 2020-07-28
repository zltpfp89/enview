<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
$(document).ready(function(){
	ajaxPTL06("/sjpb/Z/PTL06.face");
});
function ajaxPTL06(url){
	$.ajax({
		url			: url,
		type		: "POST",
		dataType	: "json",
		data		: "{}",
		cache		: false,
		success: function (result) {
			
			Highcharts.setOptions({
			     colors: [ '#2E9AFE','#008d62']
			});
			
			var month=[];
			var prsct=[];
			var trnsr=[];
			$.each(result.monCountList, function(index, item) {
				month.push(item.month);
				prsct.push(parseInt(item.prsct));
				trnsr.push(parseInt(item.trnsr));
			});
			var PTL06 = new Highcharts.chart('PTL06', {

			    title: {
			    	text:'',
//			        text: '<h2 style="color:#24356f; font-weight:500; font-size:18px;">'+result.part+'월별<span style="color:#595959; font-weight:400;">사건현황</span></h2>',
			        align:'left'
			    },
			    
			    xAxis: {
			        categories: month
			    },

			    yAxis: {
			        title: {
			            text: ''
			        	
			        }
			    },
			    
			    tooltip: {
			        crosshairs: true,
			        shared: true
			    },
			    credits: {
		            enabled: false
		        },
		        exporting: { 
			    	enabled: false 
			    },
			    plotOptions: {
			        series: {
			            cursor: 'pointer',
			            point: {
			                events: {
			                    click: function (e) {
			                        hs.htmlExpand(null, {
			                            pageOrigin: {
			                                x: e.pageX || e.clientX,
			                                y: e.pageY || e.clientY
			                            },
			                            headingText: this.series.name,
			                            maincontentText:  this.x+ ':<br/> ' +
			                                this.y ,
			                            width: 200
			                        });
			                    }
			                }
			            },
			            marker: {
			                lineWidth: 1
			            },
			            showInLegend: true
			        }
			    },

			    series: [{
			        name: '입건',
			    	data: prsct
// 			        data:[15,20,66,44,11,33,11,24,55,12,55,11]
			    }
			    , {
			        name: '송치',
			    	data: trnsr
// 			    	data:[44,11,22,77,20,16,30,24,25,40,5,30]
			    }],

			    responsive: {
			        rules: [{
			            condition: {
			                maxWidth: 500
			            },
			            chartOptions: {
			                legend: {
			                    layout: 'horizontal',
			                    align: 'right',
			                    verticalAlign: 'top'
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
<div class="portlet">	
	<div id="PTL06" style="width:480px; height:100%; float:left; margin:0 auto; position:relative"></div>
	<h2 style="position:absolute;">${part}월별<span>사건현황</span></h2>
</div>
