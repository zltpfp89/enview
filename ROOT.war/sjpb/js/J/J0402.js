var listQcell;
var map=[];
$(document).ready(function(){
	
	//페이지 진입시 인사현황 소속별현황 출력시 성공함수 호출
	goAjaxDefault("/sjpb/J/J0402List.face",map,callBackFn_selectListSuccess);
	var date = new Date();
	
	var year = date.getFullYear(); // 년
	var month = date.getMonth()+1; //월
	var day = date.getDate(); //일

	if((day+"").length < 2){
		day = "0" +day;
	}
	var getToday = year+"-"+month+"-"+day;
	
	//엑셀다운로드
	$("#exceldown").click(function(){
		
		var properties = {
				filename: "소속별현황_"+getToday,
				url: '/excelDownload.face',
				border: true, // border 처리
				headershow: true, // header 출력
				colwidth: true, // col의 width 'px' 적용
				huge: false //대용량 여부

			};
		listQcell.excelDownload(properties);
		
		
	  });
	
});

//소속별 현황리스트 성공함수. (ajax)
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
				{ width : '10%', key : 'sort', title : ['구분','구분'], sort : true, move : false, resize : false, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'allMem', title : ['전직원','소계'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'all03', title : ['전직원','3급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'all04', title : ['전직원','4급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'all05', title : ['전직원','5급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'all06', title : ['전직원','6급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'all07', title : ['전직원','7급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'all08', title : ['전직원','8급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'all09', title : ['전직원','9급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'cityMem', title : ['시 직원','소계'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'city03', title : ['시 직원','3급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'city04', title : ['시 직원','4급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'city05', title : ['시 직원','5급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'city06', title : ['시 직원','6급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'city07', title : ['시 직원','7급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'city08', title : ['시 직원','8급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'city09', title : ['시 직원','9급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'townMem', title : ['구직원','소계'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } },
				{ width : '5%', key : 'town05', title : ['구직원','5급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } },
				{ width : '5%', key : 'town06', title : ['구직원','6급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } },
				{ width : '5%', key : 'town07', title : ['구직원','7급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } },
				{ width : '5%', key : 'town08', title : ['구직원','8급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } },
				{ width : '5%', key : 'town09', title : ['구직원','9급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }
				],
			"frozencols" : 9,
		};
		QCELL.create(QCELLProp);
	
		listQcell = QCELL.getInstance("cell");


}

var J0401VOMap={
	sort : "",
	allMem : "",
	all03 : "",
	all04 : "",
	all05 : "",
	all06 : "",
	all07 : "",
	all08 : "",
	all09 : "",
	cityMem : "",
	city03 : "",
	city04 : "",
	city05 : "",
	city06 : "",
	city07 : "",
	city08 : "",
	city09 : "",
	townMem : "",
	town05 : "",
	town06 : "",
	town07 : "",
	town08 : "",
	town09 : "",
};
