$(document).ready(function(){
	
	//페이지 진입시 위반유형별 성공함수 호출
	goAjaxDefault("/sjpb/J/J0101List.face",J0101SCMap,callBackFn_selectListSuccess);

	//엑셀 다운로드
	$("#exceldown").click(function(){
		
		var properties = {
				filename: "위반유형별_통계",
				url: '/excelDownload.face',
				border: true, // border 처리
				headershow: true, // header 출력
				colwidth: true, // col의 width 'px' 적용
				huge: false //대용량 여부

			};
		listQcell.excelDownload(properties);
	  });
});
//부서 수사현황 검색리스트를 가져온다. (ajax)
function fn_searchList() {
	setAreaMap($("#j_searchList"), J0101SCMap);
	var d = document.j_searchList;

	
	var d = document.j_searchList;
	if (d.regStart.value != ' ' || d.regStart.value != null
			|| d.regEnd.value != ' ' || d.regEnd.value != null) {
		if (d.regStart.value != ' ' && d.regStart.value != null
				&& d.regEnd.value != ' ' && d.regEnd.value != null) {
			if (d.regStart.value > d.regEnd.value) {
				alert("시작일이 종료일보다 큽니다. 다시 설정해주세요.");
				return ;
			}
		} else {
			alert("기간을 입력해주세요.");
			return ;
		}
	}
	
	if( d.year.value != '' && d.year.value != null && d.regStart.value != '' && d.regStart.value != null ){
		alert("기간과 년도중 하나만 선택해주세요.");
		return;
	}
	
	J0101SCMap.year = d.year.value;
	if(J0101SCMap.regStart != '' && J0101SCMap.regStart != ' ' && J0101SCMap.regStart != null){
		day = J0101SCMap.regStart.toString()+"~"+J0101SCMap.regEnd.toString()
	}else if(J0101SCMap.year != '' && J0101SCMap.year != ' ' && J0101SCMap.year != null){
		day = J0101SCMap.year.toString();
	}
	
	//부서 수사현황 리스트를 가지고 온다.
	goAjaxDefault("/sjpb/J/J0101List.face", J0101SCMap, callBackFn_selectListSuccess);

}

//범죄수사자료조회관리대장 리스트 성공함수. (ajax)
function callBackFn_selectListSuccess(data){
	var QCELLProp = {
			"parentid" : "sheet",
			"id" : "cell",
			"data" : {
				"input" : data.qCell
			},
			"rowheader" : "sequence",
			"merge": {"header": "rowandcol"},
			"selectmode": "row",
			"columns" : [ 
				{ width : '33%', key : 'sort', title : ['구분'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '33%', key : 'typeNum', title : ['건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize13' } }, 
				{ width : '34%', key : 'typeNumPer', title : ['백분율'], sort : true, move : true, resize : true,options:{format:{type:"string",rule:"@%"}}, styleclassname : { data : 'aligncenter fontsize13' } }, 
				],
			"frozencols" : 3,
		};
		QCELL.create(QCELLProp);
	
		listQcell = QCELL.getInstance("cell");
		
		J0101_chart(data.qCell);

}
function J0101_chart(result){
	var sort=[];
	var typeNum=[];
	var typeNumPer=[];
	$.each(result, function(index, item) {
		sort.push(item.sort);
		typeNum.push(parseInt(item.typeNum));
		typeNumPer.push(parseInt(item.typeNumPer));
	});
	
//	var J0101 = new Highcharts.chart("J0101Pie", {
//		chart: {
//	        plotBackgroundColor: null,
//	        plotBorderWidth: null,
//	        plotShadow: false,
//	        type: 'pie'
//	    },
//	    title: {
//	        text: '',
//	    },
//	    credits: {
//	        enabled: false
//	    },
//	    exporting: { 
//	    	enabled: false },
//	    tooltip: {
//	        headerFormat: '',
//	        pointFormat: '<span style="color:{point.color}">\u25CF</span> <b> {point.name}</b><br/>' +
//	            '<b>{point.y}%</b>'
//	    },
//	    plotOptions: {
//	        pie: {
//	            allowPointSelect: true,
//	            cursor: 'pointer',
//	            dataLabels: {
//	                enabled: true,
//	                format: '<b>{point.name}</b><br>{point.y} %',
//	                distance: -30,
//	                style: {
//	                    fontWeight: 'bold'
//	                }
//	            },
//	            center : ['50%','60%'],
//	            size:'110%'
////	            showInLegend: true
//	        },
//	        series: {
//	            animation: false,
//	            turboThreshold: 0,
//	            dataLabels: {
//	              style: {
//	            	color:'black',
//	                fontSize: '13px',
//	                fontWeight: 'bold',
//	                textOutline: '1px 1px contrast'
//	              },
//	              enabled: true
//	            }
//	        }
//	    },
////	    xAxis: {
////	        categories: sort
////	    },
//	    series: [{
//	    	minPointSize: 10,
//	    	zMin: 0,
//	        allowPointSelect: true,
//	        keys: ['name', 'y', 'selected', 'sliced'],
//	        data: [ {
//	        		name: '건수',
//			    	data: typeNumPer
//		            
//	        }]
//	    }],
//	    responsive: {
//	        rules: [{
//	            condition: {
//	                maxWidth: 300
//	            },
//	            chartOptions: {
//	                legend: {
//	                    layout: 'horizontal',
//	                    align: 'right',
//	                    verticalAlign: 'bottom'
//	                }
//	            }
//	        }]
//	    }
//	});
	
	
	var J0101Bar = new Highcharts.chart('J0101Bar', {

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

	        categories: sort,
	        
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
//		        borderWidth: 1,
	        backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
//		        shadow: true
	    },
	    series: [{
	    	name: '건수',
	    	data: typeNum
	    }]
	});
	
	
	
}
var J0101VOMap={
	sort : "",
	typeNum : "",
	typeNumPer : ""
};
//검색조건
var J0101SCMap = {
	"year" : ""
	,"regStart" : ""
	,"regEnd" : ""
}