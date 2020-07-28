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
	
	fn_M0129_pageInit();  

	if(parent.viewType == 'inc'){
		//피의자 검색버튼
		$("#spBtn").off("click").on("click", function() {	
			commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face?rcptNum='+incMap.rcptNum, "1050px", "435px", callBackFn_M0129_searchIncSpSuccess);
		});
	}
	
});
//화면 진입시 동작함
function fn_M0129_pageInit(){
	qCellList=[];
	
	queryString=$("#m0129_searchList").serialize();

	var d = document.m0129_searchList;
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
	goAjax("/sjpb/M/M0129selectList.face",queryString,callBackFn_M0129_selectListSuccess,true);
}
//접견등금지결정처리 리스트 그리기.
function callBackFn_M0129_selectListSuccess(data){	

	if(data.qCell ==''|| data.qCell==' '){
		if(parent.viewType == 'inc'){
			fn_M0129_new();
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
            	{width: '20%',	key: 'rcptIncNum',			title: ['사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'prgsNum',			title: ['진행번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'deciDt',			title: ['결정일'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'sjpbPolfOffi',			title: ['특별사법경찰관'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'criNm',			title: ['죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'spNm',			title: ['피의자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'deciRsn',			title: ['결정이유'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'phbtCont',			title: ['금지내용'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'cnclDt',			title: ['취소일'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'cnclRsn',			title: ['취소사유'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'rcpnComn',			title: ['비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}

            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0129VOMap = qcell.getRowData(1);
	    	fn_M0129_selectSetting();
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
			fn_M0129_initM0129VOMap(); // 맵초기화
			m0129VOMap = qcell.getRowData(rowIdx);
		
			//접견등금지결정처리 데이터 세팅
			fn_M0129_selectSetting();
			//수정세팅
			updateYN();
		}
	}
	
}

//접견등금지결정처리 데이터 세팅
function fn_M0129_selectSetting(){	

	getAreaMap($("#M0129"), m0129VOMap);
	$("#incSpNum").val(m0129VOMap.incSpNum);	
	$("#rcptNum").val(m0129VOMap.rcptNum);
	$("#spNm").html(m0129VOMap.spNm);
}

//사건검색 성공함수
function callBackFn_M0129_searchIncSpSuccess(data){
	$("#incSpNum").val(data.incSpNum);
	$("input[name=spNm]").val(Base64.decode(data.spNm));						// 피의자 성명 출력
}

//수정 가능 버튼 보이기 여부
function updateYN(){
	if(parent.viewType == 'inc'){
		if(m0129VOMap.regUserId == $("#userId").val() ){
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
function fn_M0129_initM0129VOMap() {
	m0129VOMap={
			"rcpnPhbtHandNum":""
			,"prgsNum":""
			,"rcptNum":""
			,"rcptIncNum":""
			,"incSpNum":""
			,"spNm":""
			,"deciDt":""
			,"sjpbPolfOffi":""
			,"criNm":""
			,"deciRsn":""
			,"phbtCont":""
			,"cnclDt":""
			,"cnclRsn":""
			,"rcpnComn":""
			,"regUserId":""
	}
}

//신규등록
function fn_M0129_new(){

	fn_M0129_initM0129VOMap(); //맵초기화
	fn_M0129_selectSetting(); // 데이터 세팅
	$("#rcptNum").val(incMap.rcptNum); // 접수번호 세팅
	$("#prgsNum").html("신규");
	
	freezeInput(false); // 입력 활성화
	
	$("#btnSearchInc").show(); // 검색버튼보이기
	$("#btnInsert").show(); // 저장버튼 보이기	
	$("#btnUpdate").hide(); // 수정버튼 숨기기	
	
}
//등록하기
function fn_M0129_insert(){
	
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
		return;
	}
	
	//유효성검사
	setAreaMap($("#M0129"), m0129VOMap);
	m0129VOMap.rcptNum = $("#rcptNum").val();
	m0129VOMap.incSpNum = $("#incSpNum").val();
	
	
	if(m0129VOMap.incSpNum == null || m0129VOMap.incSpNum == "" || m0129VOMap.incSpNum ==" "){
		alert("피의자를 선택해주세요.");
		return;
	}

	goAjaxDefault("/sjpb/M/M0129insert.face",m0129VOMap,callBackFn_M0129_insertSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsertPern").hide(); //저장버튼 숨기기

}

//등록성공함수 호출
function callBackFn_M0129_insertSuccess(data){
	
	if(data == 1){
		alert("접견 등 금지결정 처리부가 등록되었습니다.");
	}else{
		alert("접견 등 금지결정 처리부 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0129_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0129_update(){
	
	setAreaMap($("#M0129"), m0129VOMap);
	m0129VOMap.rcptNum = $("#rcptNum").val();
	m0129VOMap.incSpNum = $("#incSpNum").val();
	
	goAjaxDefault("/sjpb/M/M0129update.face",m0129VOMap,callBackFn_M0129_updateSuccess);
}
//수정성공함수 호출
function callBackFn_M0129_updateSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0129_pageInit();
	freezeInput(true); // 입력 비활성화
}

//접견 등 금지결정 처리부 출력
function fn_M0129_prnCheckReport() {
	var rcpnPhbtHandNumList = [];
	for(var i = 1; i <= qcell.getRows("data"); i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			rcpnPhbtHandNumList.push(qcell.getRowData(i).rcpnPhbtHandNum);
		}	
	}
	var rcpnPhbtHandNumListMap = {
			"rcpnPhbtHandNumList":rcpnPhbtHandNumList
	}
	
	if(rcpnPhbtHandNumList.length != 0){
		//접견 등 금지결정 처리부 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0129prnCheckReport.face",rcpnPhbtHandNumListMap,callBackFn_M0129_prnCheckReportSuccess);
	}else{
		alert("출력할 대상을 선택해주세요.");
		return;
	}
	
}
//통신제한조치집행위탁허가신청부 출력 성공함수
function callBackFn_M0129_prnCheckReportSuccess(data){
	M0129RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0129RTMap);
	$("#reptNm").val("M0129.crf"); //레포트 파일명
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
var m0129VOMap={
			"rcpnPhbtHandNum":""
			,"prgsNum":""
			,"rcptNum":""
			,"rcptIncNum":""
			,"incSpNum":""
			,"spNm":""
			,"deciDt":""
			,"sjpbPolfOffi":""
			,"criNm":""
			,"deciRsn":""
			,"phbtCont":""
			,"cnclDt":""
			,"cnclRsn":""
			,"rcpnComn":""
			,"regUserId":""
}
//리포트맵
var M0129RTMap = {
	rexdataset : null
}