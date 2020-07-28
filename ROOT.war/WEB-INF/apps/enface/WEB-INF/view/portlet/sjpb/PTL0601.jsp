<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="portlet">
	<div id="container" style="width:480px; height:230px;"></div>
<!-- 	<a href="javascript:void(0);" class="more"><img src="/sjpb/images/icon_more.png" alt="더보기버튼"></a> -->
</div>
<script>
window.onload = function(){
	var part = '<c:out value="${part}"/>';
	alert(part);
	goAjax("/sjpb/Z/PTL0601.face", "{}", callBackSuccess);
}
function callBackSuccess(result){
	var month=[];
	var secinv=[];
	var prsct=[];
	$.each(result, function(index, monCountList) {
		month.push(monCountList.month);
		secinv.push(parseInt(monCountList.secinv));
		prsct.push(parseInt(monCountList.prsct));
	});
	Highcharts.chart('container', {

	    title: {
	        text: '월별사건현황'
	    },
	    
	    xAxis: {
	        categories: month
	    },

	    yAxis: {
	        title: {
	            text: '건수'
	        }
	    },
	    
	    legend: {
	        layout: 'vertical',
	        align: 'right',
	        verticalAlign: 'middle'
	    },
	    
	    tooltip: {
	        crosshairs: true,
	        shared: true
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
	            }
	        }
	    },

	    series: [{
	        name: '내사',
	    	data:secinv
	    }
	    , {
	        name: '입건',
	    	data:prsct
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

}
</script>


