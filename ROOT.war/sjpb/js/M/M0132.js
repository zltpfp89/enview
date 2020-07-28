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
	
	fn_M0132_pageInit();  

	if(parent.viewType == 'inc'){
		//피의자 검색버튼
		$("#spBtn").off("click").on("click", function() {	
			commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face?rcptNum='+incMap.rcptNum, "1050px", "435px", callBackFn_M0132_searchIncSpSuccess);
		});
	}
	
});
//화면 진입시 동작함
function fn_M0132_pageInit(){
	qCellList=[];
	
	queryString=$("#m0132_searchList").serialize();

	var d = document.m0132_searchList;
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
	goAjax("/sjpb/M/M0132selectList.face",queryString,callBackFn_M0132_selectListSuccess,true);
}
//지명수배 및 통보대장 리스트 그리기.
function callBackFn_M0132_selectListSuccess(data){	

	if(data.qCell ==''|| data.qCell==' '){
		if(parent.viewType == 'inc'){
			fn_M0132_new();
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
            	{width: '6%',	key: 'execNum',			title: ['집행번호','집행번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '20%',	key: 'rcptIncNum',			title: ['사건번호','사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '6%',	key: 'nmKor',			title: ['작성자','작성자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '6%',	key: 'clamNm',			title: ['청구인','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '6%',	key: 'clamIdNum',			title: ['청구인','주민등록번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '6%',	key: 'clamAddr',			title: ['청구인','주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '6%',	key: 'clamSpRelt',			title: ['청구인','피의자와의 관계'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '6%',	key: 'spNm',			title: ['피의자','피의자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '6%',	key: 'criNm',			title: ['죄명','죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'cathArstDt',			title: ['체포구속일자','체포구속일자'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'rcptDt',			title: ['접수연월일','접수연월일'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'devrAppr',			title: ['교부허가','교부허가'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'devrNonAppr',			title: ['교부불허가','교부불허가'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'recvDt',			title: ['수령연월일','수령연월일'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '6%',	key: 'clamSgn',			title: ['청구인의 성명 또는 날인','청구인의 성명 또는 날인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '6%',	key: 'cathComn',			title: ['비고','비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}

            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(2, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0132VOMap = qcell.getRowData(2);
	    	fn_M0132_selectSetting();
	    	//수정세팅
	    	updateYN();
		}
}

//지명수배 및 통보대장 셀클릭 이벤트
function eventFn(e){
	// 선택한 인덱스 가져오기
	var colIdx = qcell.getIdx("col");
	rowIdx = qcell.getIdx("row");	

	if(colIdx >0 && rowIdx > 0){
		if(colIdx != 1){
			qcell.clearCellStyles();
			qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
			
			freezeInput(true); // 입력 비활성화
			fn_M0132_initM0132VOMap(); // 맵초기화
			m0132VOMap = qcell.getRowData(rowIdx);
		
			//지명수배 및 통보대장 데이터 세팅
			fn_M0132_selectSetting();
			//수정세팅
			updateYN();
		}
	}
	
}

//지명수배 및 통보대장 데이터 세팅
function fn_M0132_selectSetting(){	

	getAreaMap($("#M0132"), m0132VOMap);
	$("#incSpNum").val(m0132VOMap.incSpNum);
	$("#incNum").html(m0132VOMap.rcptIncNum);
	$("#rcptNum").val(m0132VOMap.rcptNum);
	$("#spNm").html(m0132VOMap.spNm);
}

//사건검색 성공함수
function callBackFn_M0132_searchIncSpSuccess(data){
	$("#incSpNum").val(data.incSpNum);
	$("input[name=spNm]").val(Base64.decode(data.spNm));						// 피의자 성명 출력
	
}

//수정 가능 버튼 보이기 여부
function updateYN(){
	if(parent.viewType == 'inc'){
		if(m0132VOMap.regUserId == $("#userId").val() ){
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
function fn_M0132_initM0132VOMap() {
	m0132VOMap={
			"cathArstWrntNum":""
			,"incSpNum":""
			,"rcptNum":""
			,"rcptIncNum":""
			,"execNum":""
			,"clamNm":""
			,"clamIdNum":""
			,"clamAddr":""
			,"clamSpRelt":""
			,"spNm":""
			,"criNm":""
			,"cathArstDt":""
			,"rcptDt":""
			,"devrAppr":""
			,"devrNonAppr":""
			,"recvDt":""
			,"clamSgn":""
			,"cathComn":""
			,"regUserId":""
	}
}

//신규등록
function fn_M0132_new(){

	fn_M0132_initM0132VOMap(); //맵초기화
	fn_M0132_selectSetting(); // 데이터 세팅
	$("#rcptNum").val(incMap.rcptNum); // 접수번호 세팅
	$("#execNum").html("신규"); // 집행번호 세팅
	$("#incNum").html(isNull(incMap.rcptIncNum) ? "(피의자 선택시 자동입력)" : incMap.rcptIncNum);
	
	
	freezeInput(false); // 입력 활성화
	
	$("#btnSearchInc").show(); // 검색버튼보이기
	$("#btnInsert").show(); // 저장버튼 보이기	
	$("#btnUpdate").hide(); // 수정버튼 숨기기	
	
}
//등록하기
function fn_M0132_insert(){
	
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
		return;
	}
	
	//유효성검사
	setAreaMap($("#M0132"), m0132VOMap);
	m0132VOMap.rcptNum = $("#rcptNum").val();
	m0132VOMap.incSpNum = $("#incSpNum").val();
	
	
	if(m0132VOMap.incSpNum == null || m0132VOMap.incSpNum == "" || m0132VOMap.incSpNum ==" "){
		alert("피의자를 선택해주세요.");
		return;
	}

	goAjaxDefault("/sjpb/M/M0132insert.face",m0132VOMap,callBackFn_M0132_insertSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsertPern").hide(); //저장버튼 숨기기

}

//등록성공함수 호출
function callBackFn_M0132_insertSuccess(data){
	
	if(data == 1){
		alert("체포․구속영장등본교부대장이 등록되었습니다.");
	}else{
		alert("체포․구속영장등본교부대장 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0132_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0132_update(){
	
	setAreaMap($("#M0132"), m0132VOMap);
	m0132VOMap.rcptNum = $("#rcptNum").val();
	m0132VOMap.incSpNum = $("#incSpNum").val();
	m0132VOMap.rcptIncNum = $("#incNum").html();
	
	goAjaxDefault("/sjpb/M/M0132update.face",m0132VOMap,callBackFn_M0132_updateSuccess);
}
//수정성공함수 호출
function callBackFn_M0132_updateSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0132_pageInit();
	freezeInput(true); // 입력 비활성화
}

//지명수배 및 통보대장 출력
function fn_M0132_prnCheckReport() {
	var cathArstWrntNumList = [];
	for(var i = 2; i <= qcell.getRows("data")+1; i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			cathArstWrntNumList.push(qcell.getRowData(i).cathArstWrntNum);
		}	
	}
	var cathArstWrntNumListMap = {
			"cathArstWrntNumList":cathArstWrntNumList
	}
	
	if(cathArstWrntNumList.length != 0){
		//지명수배 및 통보대장 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0132prnCheckReport.face",cathArstWrntNumListMap,callBackFn_M0132_prnCheckReportSuccess);
	}else{
		alert("출력할 대상을 선택해주세요.");
		return;
	}
	
}
//지명수배 및 통보대장 출력 성공함수
function callBackFn_M0132_prnCheckReportSuccess(data){
	M0132RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0132RTMap);
	$("#reptNm").val("M0132.crf"); //레포트 파일명
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
var m0132VOMap={
			"cathArstWrntNum":""
			,"incSpNum":""
			,"rcptNum":""
			,"rcptIncNum":""
			,"execNum":""
			,"clamNm":""
			,"clamIdNum":""
			,"clamAddr":""
			,"clamSpRelt":""
			,"spNm":""
			,"criNm":""
			,"cathArstDt":""
			,"rcptDt":""
			,"devrAppr":""
			,"devrNonAppr":""
			,"recvDt":""
			,"clamSgn":""
			,"cathComn":""
			,"regUserId":""
	}
//리포트맵
var M0132RTMap = {
	rexdataset : null
}