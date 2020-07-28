var listQcell;
var day="";
$(document).ready(function(){
	var fdCdArray = [];
	var values = document.getElementsByName("fdCd");
	for(var i=0;i<values.length;i++){
		if(values[i].checked){
			fdCdArray.push(values[i].value);
		}
	}
	
	setAreaMap($("#j_searchList"), J0103SCMap);
	J0103SCMap.fdCdArray = fdCdArray.toString();
	J0103SCMap.year = new Date().getFullYear();
	day = J0103SCMap.year.toString();
	//페이지 진입시 분야별 수사현황출력시 성공함수 호출
	goAjaxDefault("/sjpb/J/J0103List.face",J0103SCMap,callBackFn_selectListSuccess);

	//엑셀 다운로드
	$("#exceldown").click(function(){
		
		var properties = {
				filename: "수사단계별_통계_"+day,
				url: '/excelDownload.face',
				border: true, // border 처리
				headershow: true, // header 출력
				colwidth: true, // col의 width 'px' 적용
				huge: false //대용량 여부

			};
		listQcell.excelDownload(properties);
		
		
	  });
	
	//사건분야 
	$("#total").click(function(){
		if($("#total").prop("checked")){
			$("input[name=fdCd").prop("checked",true);
		}else{
			$("input[name=fdCd").prop("checked",false);
		}
	});
	
});
//부서 수사현황 검색리스트를 가져온다. (ajax)
function fn_searchList() {
	setAreaMap($("#j_searchList"), J0103SCMap);
	
	var fdCdArray = [];
	var values = document.getElementsByName("fdCd");
	for(var i=0;i<values.length;i++){
		if(values[i].checked){
			fdCdArray.push(values[i].value);
		}
	}
	/*
	if(fdCdArray.length ==0){
		alert("분야를 선택해주세요.");
		return;
	}
	*/
	
	J0103SCMap.fdCdArray = fdCdArray.toString();
	
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
	
	J0103SCMap.year = d.year.value;
	if(J0103SCMap.regStart != '' && J0103SCMap.regStart != ' ' && J0103SCMap.regStart != null){
		day = J0103SCMap.regStart.toString()+"~"+J0103SCMap.regEnd.toString()
	}else if(J0103SCMap.year != '' && J0103SCMap.year != ' ' && J0103SCMap.year != null){
		day = J0103SCMap.year.toString();
	}
	//부서 수사현황 리스트를 가지고 온다.
	goAjaxDefault("/sjpb/J/J0103List.face", J0103SCMap, callBackFn_selectListSuccess);

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
				{ width : '10%', key : 'sort', title : ['구분'], sort : true, move : false, resize : false, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '15%', key : 'total', title : ['계'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '15%', key : 'prsct', title : ['입건'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '15%', key : 'cmd', title : ['지휘'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '15%', key : 'trs', title : ['송치'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '15%', key : 'disp', title : ['처분'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '15%', key : 'trsPer', title : ['송치율(%)'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '15%', key : 'etc', title : ['사건종결'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				],
			"frozencols" : 6,
		};
		QCELL.create(QCELLProp);

		
		listQcell = QCELL.getInstance("cell");
				
		J0103_chart(data.qCell[0]);

}

function J0103_chart(result){
//	var J0103 = new Highcharts.chart("J0103Pie", {
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
//	    series: [{
//	    	minPointSize: 10,
//	    	zMin: 0,
//	        allowPointSelect: true,
//	        keys: ['name', 'y', 'selected', 'sliced'],
//	        data: [ [
//		            '사건종결 : '+result.etc+'건',
//		            result.etc,
//		        	false
//		     	],[
//	     			'송치 : '+result.trs+'건',
//	     			result.trs,
//	     			false
//	     		],[
//		            '수사중 : '+result.invst+'건',
//		             result.invst,
//		            false
//		        ],[
//		            '입건 : '+result.prsct+'건',
//		             result.prsct,
//		            false
//		        ]]
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
	
	
	var J0103Bar = new Highcharts.chart('J0103Bar', {

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

	        //categories: ["입건", "수사중", "송치"]
	        
	    	type:'category'
	    	
	    },
	    yAxis: {
	    	allowDecimals : false,
	        min: 0,
	        title: {
	            text: ''
	        }
//	        labels: {
//	            //overflow: 'justify',
//	            enabled: true,
//	            allowDecimals : false
//	            //,
//	            //formatter : function(){
//	            //	return parseInt(this.value);
//	            //}
//	        }
	    },
	    tooltip: {

	    	pointFormat: '<b>{point.y}</b>건<br/>'
	    },
	    plotOptions: {
	        bar: {
	            dataLabels: {
	                enabled: true
	            }
	        }
	    },
	    legend: {
	    	enabled:false
	    },
//	    legend: {
//	        layout: 'horizontal',
//	        align: 'right',
//	        verticalAlign: 'top',
//	        x: 0,
//	        y: -15,
//	        floating: true,
////		        borderWidth: 1,
//	        backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
////		        shadow: true
//	    },
	    series: [
	    	{	
	    		name:'',
//	    	
	    		colorByPoint:true,
	    		data:[
	    			{
			        name: '입건',
			        y: result.prsct,
			        drilldown:'입건'
			    	},{
			        name: '지휘',
			        y: result.cmd
				    },
				    {
			        name: '송치',
			        y: result.trs
				    },
				    {
				    name: '처분',
				    y: result.disp
				    }
				    ]
	    	
	    	}]
	});
	
	
	
}


var J0103VOMap={
	sort : "",
	prsct : "",
	invst : "",
	trsPer : "",
	trs : "",
	etc : "" 
};
//검색조건
var J0103SCMap = {
	"regStart" : ""
	,"regEnd" : ""
	,"fdCdArray" : ""
	,"year" : ""
}