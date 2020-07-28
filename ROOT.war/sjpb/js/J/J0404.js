var listQcell;
var map=[];
$(document).ready(function(){
	
	//페이지 진입시 인사현황 구직원 현황 출력시 성공함수 호출
	goAjaxDefault("/sjpb/J/J0404List.face",map,callBackFn_selectListSuccess);
	
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
				filename: "구직원현황_"+getToday,
				url: '/excelDownload.face',
				border: true, // border 처리
				headershow: true, // header 출력
				colwidth: true, // col의 width 'px' 적용
				huge: false //대용량 여부

			};
		listQcell.excelDownload(properties);
		
		
	  });
	
});

//시직원 현황리스트 성공함수. (ajax)
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
				{ width : '6%', key : 'dispGuof', title : ['소속\n구청'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'criMbSpoc', title : ['직렬'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '4%', key : 'criMbClas', title : ['직급'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'nmKor', title : ['성명'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'genDiv', title : ['성별'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'birDt', title : ['생년\n월일'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'initApptDt', title : ['최초\n임용일'], sort : true, move : true, resize : true, options: {format: {type:"date",origin:"YYYY-MM-DD", rule: "YYYY.MM.DD"}}, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'currPosiDt', title : ['현\n직급일'], sort : true, move : true, resize : true, options: {format: {type:"date",origin:"YYYY-MM-DD", rule: "YYYY.MM.DD"}}, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'criOffiApptDt', title : ['전입일'], sort : true, move : true, resize : true, options: {format: {type:"date",origin:"YYYY-MM-DD", rule: "YYYY.MM.DD"}}, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '13%', key : 'dispDt', title : ['파견기간'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'dept', title : ['소속부서'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'team', title : ['소속팀'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '5%', key : 'criMbPosi', title : ['직위'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'workDt', title : ['재직\n기간'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'miPreDeptNm', title : ['전입\n전부서'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }, 
				{ width : '6%', key : 'intro', title : ['기타사항'], sort : true, move : true, resize : true, styleclassname : { data : 'aligncenter fontsize17' } }
				
				],
			"frozencols" : 9,
		};
		QCELL.create(QCELLProp);
	
		listQcell = QCELL.getInstance("cell");


}

