var listQcell;
var map=[];
$(document).ready(function(){
	var date = new Date();
	
	var year = date.getFullYear(); // 년
	var month = date.getMonth()+1; //월
	var day = date.getDate(); //일

	if((day+"").length < 2){
		day = "0" +day;
	}
	var getToday = year+"-"+month+"-"+day;
	
	//페이지 진입시 인사현황 전문관직원 현황 출력시 성공함수 호출
	goAjaxDefault("/sjpb/J/J0405List.face",map,callBackFn_selectListSuccess);
	
	//엑셀다운로드
	$("#exceldown").click(function(){
		
		var properties = {
				filename: "전문관직원현황_"+getToday,
				url: '/excelDownload.face',
				border: true, // border 처리
				headershow: true, // header 출력
				colwidth: true, // col의 width 'px' 적용
				huge: false //대용량 여부

			};
		listQcell.excelDownload(properties);
		
		
	  });
	
});

//전문관직원 현황리스트 성공함수. (ajax)
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
				{ width : '8%', key : 'dept', title : ['소속부서'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '8%', key : 'team', title : ['소속팀'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '8%', key : 'criMbSpoc', title : ['직렬'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '8%', key : 'criMbClas', title : ['직급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '8%', key : 'nmKor', title : ['성명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '7%', key : 'genDiv', title : ['성별'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '7%', key : 'birDt', title : ['생년\n월일'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '7%', key : 'initApptDt', title : ['최초\n임용일'], sort : true, move : true, resize : true, options: {format: {type:"date",origin:"YYYY-MM-DD", rule: "YYYY.MM.DD"}}, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '7%', key : 'currPosiDt', title : ['현\n직급일'], sort : true, move : true, resize : true, options: {format: {type:"date",origin:"YYYY-MM-DD", rule: "YYYY.MM.DD"}}, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '7%', key : 'criOffiApptDt', title : ['전입일'], sort : true, move : true, resize : true, options: {format: {type:"date",origin:"YYYY-MM-DD", rule: "YYYY.MM.DD"}}, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '9%', key : 'workDt', title : ['재직\n기간'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '7%', key : 'criProfOffiBeDt', title : ['전문관\n지정일'], sort : true, move : true, options: {format: {type:"date",origin:"YYYY-MM-DD", rule: "YYYY.MM.DD"}}, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '9%', key : 'criProfOffiDt', title : ['전문관\n근무기간'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }
				
				],
			"frozencols" : 9,
		};
		QCELL.create(QCELLProp);
	
		listQcell = QCELL.getInstance("cell");


}

