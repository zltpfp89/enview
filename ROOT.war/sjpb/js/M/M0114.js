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
	
	fn_M0114_pageInit();  
});
//화면 진입시 동작함
function fn_M0114_pageInit(){
	qCellList=[];
	
	queryString=$("#m0114_searchList").serialize();
	
	var d = document.m0114_searchList;
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
	
	goAjax("/sjpb/M/M0114selectList.face",queryString,callBackFn_M0114_selectListSuccess,true);
}
//체포구속인진료부 리스트 그리기.
function callBackFn_M0114_selectListSuccess(data){	

	if(data.qCell ==''|| data.qCell==' '){
		if(parent.viewType == 'inc'){
			fn_M0114_new();
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
            	{width: '15%',	key: 'rcptIncNum',			title: ['사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '13%',	key: 'nmKor',			title: ['작성자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '13%',	key: 'cstdPersNm',			title: ['유치인 성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '13%',	key: 'dgnsDctrNm',			title: ['진단의사의 성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '13%',	key: 'csltCau',			title: ['진료의 원인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '14%',	key: 'csltDt',			title: ['진료일시'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '14%',	key: 'dgnsRst',			title: ['진단의 결과'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'cathArstCsltComn',			title: ['비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '14%',	key: 'prscOffi',			title: ['입회관'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
//	    	qcell.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
	    	qcell.clearCellStyles();
	    	qcell.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0114VOMap = qcell.getRowData(1);
	    	fn_M0114_selectSetting();
	    	//수정세팅
	    	updateYN();
		}
}
//체포구속인접견부 셀클릭 이벤트
function eventFn(e){
	// 선택한 인덱스 가져오기
	var colIdx = qcell.getIdx("col");
	rowIdx = qcell.getIdx("row");	
	
	if(colIdx >0 && rowIdx > 0){
		if(colIdx != 1){
			qcell.clearCellStyles();
			qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
			//기존 체크박스 열번호
//			var pastchk = qcell.getIdx("row","focus","previous") == -1?1:qcell.getIdx("row","focus","previous");
			
			//기존 체크항목 해제
//			qcell.removeRowStyle(pastchk);
		
			//새로 선택한 행 스타일적용
//			qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
			freezeInput(true); // 입력 비활성화
			fn_M0114_initM0114VOMap(); // 맵초기화
			m0114VOMap = qcell.getRowData(rowIdx);
		
			//체포구속인진료부 데이터 세팅
			fn_M0114_selectSetting();
			//수정세팅
			updateYN();
		}
	}
}
//체포구속인진료부 데이터 세팅
function fn_M0114_selectSetting(){	

	getAreaMap($("#M0114"), m0114VOMap);
	$("#incNum").html(m0114VOMap.rcptIncNum);
	$("#cstdPersNm").html(m0114VOMap.cstdPersNm);
	$("#incSpNum").val(m0114VOMap.incSpNum);	
	$("#rcptNum").val(m0114VOMap.rcptNum);
	$("#incNum").html(m0114VOMap.rcptIncNum);
	
}

//수정 가능 버튼 보이기 여부
function updateYN(){
	if(parent.viewType == 'inc'){
		if(m0114VOMap.regUserId == $("#userId").val() ){
			freezeInput(false); // 입력 활성화
			$("#btnUpdate").show();  //수정버튼 보이기
			$("#btnSearchInc").show(); // 검색버튼 보이기
		}else{
			freezeInput(true); // 입력 비활성화
			$("#btnUpdate").hide();  //수정버튼 숨기기
	
		}
		$("#btnInsert").hide();  //저장버튼 숨기기
	}
}

//사건검색 팝업창
function fn_M0114_searchIncSp(){
	commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face?rcptNum='+incMap.rcptNum, "1050px", "550px", callBackFn_M0114_searchIncSpSuccess);
}

//사건검색 성공함수
function callBackFn_M0114_searchIncSpSuccess(data){
	$("#incSpNum").val(data.incSpNum);
	$("#cstdPersNm").html(Base64.decode(data.spNm));  // 피의자 성명 출력
}

//맵초기화
function fn_M0114_initM0114VOMap() {
	m0114VOMap={
			"cathArstCsltNum":""
			,"rcptNum":""
			,"incSpNum":""
			,"cstdPersNm":""
			,"dgnsDctrNm":""
			,"csltCau":""
			,"csltDt":""
			,"dgnsRst":""
			,"cathArstCsltComn":""
			,"prscOffi":""
			,"regUserId":""
	}
}

//신규등록
function fn_M0114_new(){

	fn_M0114_initM0114VOMap(); //맵초기화
	fn_M0114_selectSetting(); // 데이터 세팅	
	$("#rcptNum").val(incMap.rcptNum); // 접수번호 세팅
	$("#cstdPersNm").html("(피의자를 선택해주세요.)");
	
	freezeInput(false); // 입력 활성화
	
	$("#btnInsert").show(); // 저장버튼 보이기	
	$("#btnUpdate").hide(); // 수정버튼 숨기기	
	$("#btnSearchInc").show(); // 검색버튼 숨기기	
	
}
//등록하기
function fn_M0114_insert(){
	
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
		return;
	}

	setAreaMap($("#M0114"), m0114VOMap);
	m0114VOMap.rcptNum = $("#rcptNum").val();
	m0114VOMap.incSpNum = $("#incSpNum").val();
	m0114VOMap.cstdPersNm = $("#cstdPersNm").html();

	if(m0114VOMap.incSpNum == null || m0114VOMap.incSpNum == "" || m0114VOMap.incSpNum ==" "){
		alert("피의자를 선택해주세요.");
		return;
	}
	
	goAjaxDefault("/sjpb/M/M0114insert.face",m0114VOMap,callBackFn_M0114_insertSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsertPern").hide(); //저장버튼 숨기기

}

//등록성공함수 호출
function callBackFn_M0114_insertSuccess(data){
	
	if(data == 1){
		alert("체포구속인진료부가 등록되었습니다.");
	}else{
		alert("체포구속인진료부 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0114_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0114_update(){
	
	setAreaMap($("#M0114"), m0114VOMap);
	m0114VOMap.rcptNum = $("#rcptNum").val();
	m0114VOMap.incSpNum = $("#incSpNum").val();
	m0114VOMap.rcptIncNum = $("#incNum").html();
	m0114VOMap.cstdPersNm = $("#cstdPersNm").html();
	
	goAjaxDefault("/sjpb/M/M0114update.face",m0114VOMap,callBackFn_M0114_updateSuccess);
}
//수정성공함수 호출
function callBackFn_M0114_updateSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0114_pageInit();
	freezeInput(true); // 입력 비활성화
}

//체포구속인진료부 출력
function fn_M0114_prnCheckReport() {
	var cathArstCsltNumList = [];
	for(var i = 1; i <= qcell.getRows("data")+1; i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			cathArstCsltNumList.push(qcell.getRowData(i).cathArstCsltNum);
		}	
	}
	var cathArstCsltNumListMap = {
			"cathArstCsltNumList":cathArstCsltNumList
	}
	
	if(cathArstCsltNumList.length != 0){
		//체포구속인진료부 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0114prnCheckReport.face", cathArstCsltNumListMap, callBackFn_M0114_prnCheckReportSuccess);
	}else{
		alert("출력할 대상을 선택해주세요.");
		return;
	}
	
}
//체포구속인진료부 출력 성공함수
function callBackFn_M0114_prnCheckReportSuccess(data){
	M0114RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0114RTMap);
	$("#reptNm").val("M0114.crf"); //레포트 파일명
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
var m0114VOMap={
		"cathArstCsltNum":""
		,"rcptNum":""
		,"incSpNum":""
		,"cstdPersNm":""
		,"dgnsDctrNm":""
		,"csltCau":""
		,"csltDt":""
		,"dgnsRst":""
		,"cathArstCsltComn":""
		,"prscOffi":""
		,"regUserId":""
}
//리포트맵
var M0114RTMap = {
	rexdataset : null
}