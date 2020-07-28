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
	
	fn_M0133_pageInit();  

	if(parent.viewType == 'inc'){
		//피의자 검색버튼
		$("#spBtn").off("click").on("click", function() {	
			commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face?rcptNum='+incMap.rcptNum, "1050px", "435px", callBackFn_M0133_searchIncSpSuccess);
		});
	}
	
});
//화면 진입시 동작함
function fn_M0133_pageInit(){
	qCellList=[];
	
	queryString=$("#m0133_searchList").serialize();

	var d = document.m0133_searchList;
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
	
	//검색조건 노출
	//사건에서 보여질 경우, 사건에 필요한것만 노출 (본인데이터만)
	if(parent.viewType == 'inc'){
		queryString += "&rcptNumSc="+incMap.rcptNum;
	}
	goAjax("/sjpb/M/M0133selectList.face",queryString,callBackFn_M0133_selectListSuccess,true);
}
//통신제한조치집행대장 리스트 그리기.
function callBackFn_M0133_selectListSuccess(data){	

	if(data.qCell ==''|| data.qCell==' '){
		if(parent.viewType == 'inc'){
			fn_M0133_new();
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
            	{width: '5%',	key: 'checkbox',			title: ['',''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '20%',	key: 'rcptIncNum',			title: ['사건번호','사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'nmKor',			title: ['작성자','작성자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'cnsmApprExecNum',			title: ['집행번호','집행번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'apprDocNum',			title: ['허가서번호','허가서번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'spNm',			title: ['성명','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'cmctRstrActnPurp',			title: ['통신제한조치','목적'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'cmctRstrActnTrgt',			title: ['통신제한조치','대상'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'cmctRstrActnType',			title: ['통신제한조치','종류'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'cmctRstrActnPi',			title: ['통신제한조치','기간'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'execCnsmDt',			title: ['집행위탁','연월일'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'execCnsmOfic',			title: ['집행위탁','관서'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'execDt',			title: ['집행일시','집행일시'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'cnsmApprExecComn',			title: ['비고','비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(2, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0133VOMap = qcell.getRowData(2);
	    	fn_M0133_selectSetting();
	    	//수정세팅
	    	updateYN();
		}
}

//통신제한조치집행대장 셀클릭 이벤트
function eventFn(e){
	// 선택한 인덱스 가져오기
	var colIdx = qcell.getIdx("col");
	rowIdx = qcell.getIdx("row");	

	if(colIdx >0 && rowIdx > 0){
		if(colIdx != 1){
			qcell.clearCellStyles();
			qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
			
			freezeInput(true); // 입력 비활성화
			fn_M0133_initM0133VOMap(); // 맵초기화
			m0133VOMap = qcell.getRowData(rowIdx);
		
			//통신제한조치집행대장 데이터 세팅
			fn_M0133_selectSetting();
			//수정세팅
			updateYN();
		}
	}
}

//통신제한조치집행대장 데이터 세팅
function fn_M0133_selectSetting(){	

	getAreaMap($("#M0133"), m0133VOMap);
	$("#incNum").html(m0133VOMap.rcptIncNum);
	$("#incSpNum").val(m0133VOMap.incSpNum);	
	$("#rcptNum").val(m0133VOMap.rcptNum);
	$("#incNum").html(m0133VOMap.rcptIncNum);
	$("#spNm").html(m0133VOMap.spNm);
}

//사건검색 성공함수
function callBackFn_M0133_searchIncSpSuccess(data){
	
	$("#incSpNum").val(data.incSpNum);
	$("input[name=spNm]").val(Base64.decode(data.spNm));								// 피의자 성명 출력
}

//수정 가능 버튼 보이기 여부
function updateYN(){
	if(parent.viewType == 'inc'){
		if(m0133VOMap.regUserId == $("#userId").val() ){
			freezeInput(false); // 입력 활성화
			$("#btnUpdate").show();  //수정버튼 보이기
			$("#btnSearchInc").show(); // 검색버튼 보이기
		}else{
			freezeInput(true); // 입력 비활성화
			$("#btnUpdate").hide();  //수정버튼 숨기기
			$("#btnSearchInc").hide(); // 검색버튼 보이기
		}
		$("#btnInsert").hide();  //저장버튼 숨기기	
	}
}

//맵초기화
function fn_M0133_initM0133VOMap() {
	m0133VOMap={
			"cmctRstrExecNum":""
			,"cnsmApprExecNum":""
			,"apprDocNum":""
			,"rcptNum":""
			,"incSpNum":""
			,"spNm":""
			,"cmctRstrActnPurp":""
			,"cmctRstrActnTrgt":""
			,"cmctRstrActnType":""
			,"cmctRstrActnPi":""
			,"execCnsmDt":""
			,"execCnsmOfic":""
			,"execDt":""
			,"cnsmApprExecComn":""
			,"regUserId":""
	}
}

//신규등록
function fn_M0133_new(){

	fn_M0133_initM0133VOMap(); //맵초기화
	fn_M0133_selectSetting(); // 데이터 세팅	
	$("#incNum").html(incMap.rcptIncNum); // 사건번호 세팅
	$("#rcptNum").val(incMap.rcptNum); // 접수번호 세팅
	$("#cnsmApprExecNum").html("신규");
	$("#incNum").html(isNull(incMap.rcptIncNum) ? "(피의자 선택시 자동입력)" : incMap.rcptIncNum);					//사건번호 세팅
	
	freezeInput(false); // 입력 활성화
	
	$("#btnSearchInc").show(); // 검색버튼보이기
	$("#btnInsert").show(); // 저장버튼 보이기	
	$("#btnUpdate").hide(); // 수정버튼 숨기기	
	
}
//등록하기
function fn_M0133_insert(){
	
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
		return;
	}
	
	//유효성검사
	setAreaMap($("#M0133"), m0133VOMap);
	m0133VOMap.rcptNum = $("#rcptNum").val();
	m0133VOMap.incSpNum = $("#incSpNum").val();
	m0133VOMap.rcptIncNum = $("#incNum").html();
	
	
	if(m0133VOMap.incSpNum == null || m0133VOMap.incSpNum == "" || m0133VOMap.incSpNum ==" "){
		alert("피의자를 선택해주세요.");
		return;
	}

	if(m0133VOMap.apprDocNum == null || m0133VOMap.apprDocNum == "" || m0133VOMap.apprDocNum ==" "){
		alert("허가서 번호를 입력해주세요.");
		return;
	}
	goAjaxDefault("/sjpb/M/M0133insert.face",m0133VOMap,callBackFn_M0133_insertSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsertPern").hide(); //저장버튼 숨기기

}

//등록성공함수 호출
function callBackFn_M0133_insertSuccess(data){
	
	if(data == 1){
		alert("통신제한조치집행대장이 등록되었습니다.");
	}else{
		alert("통신제한조치집행대장 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0133_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0133_update(){
	
	setAreaMap($("#M0133"), m0133VOMap);
	m0133VOMap.rcptNum = $("#rcptNum").val();
	m0133VOMap.incSpNum = $("#incSpNum").val();
	m0133VOMap.rcptIncNum = $("#incNum").html();
	
	goAjaxDefault("/sjpb/M/M0133update.face",m0133VOMap,callBackFn_M0133_updateSuccess);
}
//수정성공함수 호출
function callBackFn_M0133_updateSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0133_pageInit();
	freezeInput(true); // 입력 비활성화
}

//통신제한조치집행대장 출력
function fn_M0133_prnCheckReport() {
	var cmctRstrExecNumList = [];
	for(var i = 2; i <= qcell.getRows("data")+1; i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			cmctRstrExecNumList.push(qcell.getRowData(i).cmctRstrExecNum);
		}	
	}
	var cmctRstrExecNumListMap = {
			"cmctRstrExecNumList":cmctRstrExecNumList
	}
	
	if(cmctRstrExecNumList.length != 0){
		//통신제한조치집행대장 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0133prnCheckReport.face",cmctRstrExecNumListMap, callBackFn_M0133_prnCheckReportSuccess);
	}else{
		alert("출력할 대상을 선택해주세요.");
		return;
	}
	
}
//통신제한조치집행대장 출력 성공함수
function callBackFn_M0133_prnCheckReportSuccess(data){
	M0133RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0133RTMap);
	$("#reptNm").val("M0133.crf"); //레포트 파일명
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
var m0133VOMap={
		"cmctRstrExecNum":""
		,"cnsmApprExecNum":""
		,"apprDocNum":""
		,"rcptNum":""
		,"incSpNum":""
		,"spNm":""
		,"cmctRstrActnPurp":""
		,"cmctRstrActnTrgt":""
		,"cmctRstrActnType":""
		,"cmctRstrActnPi":""
		,"execCnsmDt":""
		,"execCnsmOfic":""
		,"execDt":""
		,"cnsmApprExecComn":""
		,"regUserId":""
}
//리포트맵
var M0133RTMap = {
	rexdataset : null
}