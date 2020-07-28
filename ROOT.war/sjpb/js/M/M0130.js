var qcell;
var queryString;
var qCellList=[];
var rowIdx=2;
var incMap;
$(document).ready(function(){
	
	incMap = setUiRcptNum(parent);
	
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
	}
	
	fn_M0130_pageInit();  
	
});
//화면 진입시 동작함
function fn_M0130_pageInit(){
	qCellList=[];
	
	queryString=$("#m0130_searchList").serialize();

	var d = document.m0130_searchList;
	if (d.regStart.value != ' ' || d.regStart.value != null || d.regEnd.value != ' ' || d.regEnd.value != null) {
		if (d.regStart.value != ' ' && d.regStart.value != null && d.regEnd.value != ' ' && d.regEnd.value != null) {
			if (d.regStart.value > d.regEnd.value) {
				alert("시작일이 종료일보다 큽니다. 다시 설정해주세요.");
				return ;
			}
		} else {
			alert("기간을 입력해주세요.");
			return ;
		}
	}

	goAjax("/sjpb/M/M0130selectList.face",queryString,callBackFn_M0130_selectListSuccess,true);
}
//범죄신고접수대장 리스트 그리기.
function callBackFn_M0130_selectListSuccess(data){	

	if(data.qCell ==''|| data.qCell==' '){
		if(parent.viewType == 'inc'){
			fn_M0130_new();
		}else{
			$("#docTab").hide();
		}
	}
	
	var QCELLProp = {
            "parentid" : "listSheet",
            "id"		: "cell",
            "rowheader" : "sequence",
            "selectmode": "row",
            "merge": {"header": "rowandcol"},
       		"data" : {"input":data.qCell},
            "columns"	: [
            	{width: '5%',	key: 'checkbox',			title: [''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '10%',	key: 'criNotiSiNum',			title: ['연번'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'rcptDt',			title: ['접수일자'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'notiPernNm',			title: ['신고인 성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '25%',	key: 'notiCont',			title: ['신고내용'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '20%',	key: 'notiCnttNum',			title: ['신고인연락처'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'notiAplt',			title: ['신고 접수자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'trsr',			title: ['취급자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0130VOMap = qcell.getRowData(1);
	    	fn_M0130_selectSetting();
	    	//수정세팅
	    	updateYN();
		}
}

//접견등금지결정처리 셀클릭 이벤트
function eventFn(e){
	// 선택한 인덱스 가져오기
	var colIdx = qcell.getIdx("col");
	rowIdx = qcell.getIdx("row");	

	if(colIdx >0 && rowIdx > 0){
		if(colIdx != 1){
			qcell.clearCellStyles();
			qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
			
			freezeInput(true); // 입력 비활성화
			fn_M0130_initM0130VOMap(); // 맵초기화
			m0130VOMap = qcell.getRowData(rowIdx);
		
			//범죄신고접수대장 데이터 세팅
			fn_M0130_selectSetting();
			//수정세팅
			updateYN();
		}
	}
	
}

//범죄신고접수대장 데이터 세팅
function fn_M0130_selectSetting(){	

	getAreaMap($("#M0130"), m0130VOMap);
}

//수정 가능 버튼 보이기 여부
function updateYN(){
	if(parent.viewType == 'inc'){
		if(m0130VOMap.regUserId == $("#userId").val() ){
			freezeInput(false); // 입력 활성화
			$("#btnUpdate").show();  //수정버튼 보이기
			$("#btnSearchInc").show(); // 검색버튼보이기
			
		}else{
			freezeInput(true); // 입력 비활성화
			$("#btnUpdate").hide();  //수정버튼 숨기기
	
		}
		$("#btnInsert").hide();  //저장버튼 숨기기
	}
}

//맵초기화
function fn_M0130_initM0130VOMap() {
	m0130VOMap={
			"criNotiRcptNum":""
			,"criNotiSiNum":""
			,"rcptDt":""
			,"notiPernNm":""
			,"notiCont":""
			,"notiCnttNum":""
			,"notiAplt":""
			,"trsr":""
			,"regUserId":""
	}
}

//신규등록
function fn_M0130_new(){

	fn_M0130_initM0130VOMap(); //맵초기화
	fn_M0130_selectSetting(); // 데이터 세팅
	$("#criNotiSiNum").html("신규");
	
	freezeInput(false); // 입력 활성화
	
	$("#btnInsert").show(); // 저장버튼 보이기	
	$("#btnUpdate").hide(); // 수정버튼 숨기기	
	
}
//등록하기
function fn_M0130_insert(){
	
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
		return;
	}
	
	//유효성검사
	setAreaMap($("#M0130"), m0130VOMap);


	goAjaxDefault("/sjpb/M/M0130insert.face",m0130VOMap,callBackFn_M0130_insertSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsertPern").hide(); //저장버튼 숨기기

}

//등록성공함수 호출
function callBackFn_M0130_insertSuccess(data){
	
	if(data == 1){
		alert("범죄신고접수대장가 등록되었습니다.");
	}else{
		alert("범죄신고접수대장 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0130_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0130_update(){
	
	setAreaMap($("#M0130"), m0130VOMap);
	
	goAjaxDefault("/sjpb/M/M0130update.face",m0130VOMap,callBackFn_M0130_updateSuccess);
}
//수정성공함수 호출
function callBackFn_M0130_updateSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0130_pageInit();
	freezeInput(true); // 입력 비활성화
}

//범죄신고접수대장 출력
function fn_M0130_prnCheckReport() {
	var criNotiRcptNumList = [];
	for(var i = 1; i <= qcell.getRows("data"); i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			criNotiRcptNumList.push(qcell.getRowData(i).criNotiRcptNum);
		}	
	}
	var criNotiRcptNumListMap = {
			"criNotiRcptNumList":criNotiRcptNumList
	}
	
	if(criNotiRcptNumList.length != 0){
		//범죄신고접수대장 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0130prnCheckReport.face",criNotiRcptNumListMap,callBackFn_M0130_prnCheckReportSuccess);
	}else{
		alert("출력할 대상을 선택해주세요.");
		return;
	}
	
}
//범죄신고접수대장 출력 성공함수
function callBackFn_M0130_prnCheckReportSuccess(data){
	M0130RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0130RTMap);
	$("#reptNm").val("M0130.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	//레포트 호출
	openReportService(reportForm); 
}
//입력화면 비/활성화
function freezeInput(tf) {
	$("#contentsArea input").attr("disabled",tf);
	$("#contentsArea select").attr("disabled",tf);
	//$("#contentsArea a").attr("disabled",tf);
	$("#contentsArea textarea").attr("disabled",tf);
}

//맵
var m0130VOMap={
			"criNotiRcptNum":""
			,"criNotiSiNum":""
			,"rcptDt":""
			,"notiPernNm":""
			,"notiCont":""
			,"notiCnttNum":""
			,"notiAplt":""
			,"trsr":""
			,"regUserId":""
}
//리포트맵
var M0130RTMap = {
	rexdataset : null
}