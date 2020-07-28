$(document).ready(function(){
//	ajaxPTL02("/sjpb/Z/PTL02.face","PTL02");
//	ajaxPTL02("/sjpb/Z/PTL0200.face","totalPTL02");
//	ajaxPTL06("/sjpb/Z/PTL06.face");
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
			            '송치 : '+ result.trnsr+'건',
//			            result.trnsrPer,
			            30,
			        	false
			     	],[
			            '입건 : '+result.prsct+'건',
//			             result.prsctPer,
			            30,
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
//			    	data: prsct
			        data:[15,20,66,44,11,33,11,24,55,12,55,11]
			    }
			    , {
			        name: '송치',
//			    	data: trnsr
			    	data:[44,11,22,77,20,16,30,24,25,40,5,30]
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
