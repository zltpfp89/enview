var qcell;
var queryString=$("#m0108_searchList").serialize();
var qCellList=[];
var rowIdx=1;
$(document).ready(function(){
	fn_M0108_pageInit();     
});
//화면 진입시 동작함
function fn_M0108_pageInit(){
	qCellList=[];
	goAjax("/sjpb/M/M0108selectList.face",queryString,callBackFn_M0108_selectListSuccess);
}
//피의자소재발견처리부 리스트 그리기.
function callBackFn_M0108_selectListSuccess(data){	
	if(data.qCell ==''|| data.qCell==' '){
		$("#contentsArea").hide();
	}else{
		$("#contentsArea").show();
	}
	
	var QCELLProp = {
            "parentid" : "listSheet",
            "id"		: "cell",
            "rowheader" : "sequence",
            "selectmode": "row",
            "merge": {"header": "rowandcol"},
       		"data" : {"input":data.qCell},
            "columns"	: [
            	{width: '100',	key: 'handBkSiNum',			title: ['순번'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spNm',			title: ['피의자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'whabDvDt',			title: ['소재발견일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'whabDvRsn',			title: ['소재발견사유'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'whabDvReptDt',			title: ['소재발견보고일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'criNm',			title: ['죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'wantRelsDt',			title: ['수배해제일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cmbkPreIncNum',			title: ['재기전사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'trfDt',			title: ['송치일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'trfOp',			title: ['송치의견'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'respMb',			title: ['담당자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spWhabDvHandBkComn',			title: ['비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}

            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0108VOMap = qcell.getRowData(1);
	    	fn_M0108_selectSpWhabSetting();
	    	//수정세팅
	    	updateYN();
		}
}
//피의자소재발견처리부 셀클릭 이벤트
function eventFn(e){
	// 선택한 인덱스 가져오기
	if(rowIdx == null){
		rowIdx = 3;//초기값 설정
	}else{
		rowIdx = qcell.getIdx("row");	
	}
	//기존 체크박스 열번호
	var pastchk = qcell.getIdx("row","focus","previous") == -1?1:qcell.getIdx("row","focus","previous");
	
	//기존 체크항목 해제
	qcell.removeRowStyle(pastchk);

	//새로 선택한 행 스타일적용
	qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
	
	m0108VOMap = qcell.getRowData(rowIdx);

	//피의자소재발견처리부 데이터 세팅
	fn_M0108_selectSpWhabSetting();
	//수정세팅
	updateYN();
}
//피의자소재발견처리부 데이터 세팅
function fn_M0108_selectSpWhabSetting(){	
	getAreaMap($("#M0108SpWhab"), m0108VOMap);
	$("#cmbkPreIncNum").html(m0108VOMap.cmbkPreIncNum);
	$("#incSpNum").val(m0108VOMap.incSpNum);
	$("#spNm").html(m0108VOMap.spNm);								// 피의자 성명 출력
	$("#criNm").html(m0108VOMap.criNm);	
}

//수정 가능 버튼 보이기 여부
function updateYN(){
	debugger;
	if(m0108VOMap.regUserId == $("#userId").val() ){
		freezeInput(false); // 입력 활성화
		$("#btnSearchInc").show(); // 검색버튼보이기
		$("#btnUpdateSpWhab").show();  //수정버튼 보이기
	}else{
		freezeInput(true); // 입력 비활성화
		$("#btnUpdateSpWhab").hide();  //수정버튼 숨기기
	}

}

//사건검색 팝업창
function fn_M0108_searchIncSp(){
	commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face', "1050px", "550px", callBackFn_M0108_searchIncSpSuccess);
}

//사건검색 성공함수
function callBackFn_M0108_searchIncSpSuccess(data){
	debugger;
	$("#rcptNum").val(data.rcptNum);
	$("#cmbkPreIncNum").html(data.incNum);
	$("#incSpNum").val(data.incSpNum);
	$("#spNm").html(Base64.decode(data.spNm));								// 피의자 성명 출력
	$("#criNm").html(data.rltActCriNmCdDesc);					// 피의자 죄명 출력
}
//피의자소재발견처리부 출력
function fn_M0108_prtSpWhabReport() {
	queryString = $("#m0108_searchList").serialize();
	
	//피의자소재발견처리부 리스트 레포트 성공함수 호출
	goAjaxDefault("/sjpb/M/M0108selectList.face",queryString, callBackFn_M0108_prtSpWhabReportSuccess);
}
//피의자소재발견처리부 출력 성공함수
function callBackFn_M0108_prtSpWhabReportSuccess(data){
	M0108RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0108RTMap);
	$("#reptNm").val("M0108.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	console.log(xmlString);
	//레포트 호출
	openReportService(reportForm); 
}

//맵초기화
function fn_M0108_initM0108VOMap() {
	m0108VOMap={
			"spWhabDvHandBkNum":""
			,"handBkSiNum":""
			,"incSpNum":""
			,"spNm":""
			,"whabDvDt":""
			,"whabDvRsn":""
			,"whabDvReptDt":""
			,"criNm":""
			,"wantRelsDt":""
			,"cmbkPreIncNum":""
			,"trfDt":""
			,"trfOp":""
			,"respMb":""
			,"spWhabDvHandBkComn":""
			,"rcptNum":""
			,"regUserId":""
	}
}

//신규등록
function fn_M0108_newSpWhab(){
	$("#contentsArea").show();
	fn_M0108_initM0108VOMap(); //맵초기화
	fn_M0108_selectSpWhabSetting(); // 데이터 세팅	
	freezeInput(false); // 입력 활성화
	$("#btnSearchInc").show(); // 검색버튼보이기
	$("#btnInsertSpWhab").show(); // 저장버튼 보이기	
	$("#btnUpdateSpWhab").hide(); // 수정버튼 숨기기	
	
}
//등록하기
function fn_M0108_insertSpWhab(){
	//유효성검사
	
	setAreaMap($("#M0108SpWhab"), m0108VOMap);
	m0108VOMap.rcptNum = $("#rcptNum").val();
	m0108VOMap.incSpNum = $("#incSpNum").val();
	m0108VOMap.cmbkPreIncNum = $("#cmbkPreIncNum").html();
	m0108VOMap.criNm = $("#criNm").html();
	
	goAjaxDefault("/sjpb/M/M0108insertSpWhab.face",m0108VOMap,callBackFn_M0108_insertSpWhabSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsertSpWhab").hide(); //저장버튼 숨기기

}

//등록성공함수 호출
function callBackFn_M0108_insertSpWhabSuccess(data){
	if(data == 1){
		alert("피의자소재발견처리부가 등록되었습니다.");
	}else{
		alert("피의자소재발견처리부 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0108_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0108_updateSpWhab(){
	
	setAreaMap($("#M0108SpWhab"), m0108VOMap);
	m0108VOMap.rcptNum = $("#rcptNum").val();
	m0108VOMap.incSpNum = $("#incSpNum").val();
	m0108VOMap.cmbkPreIncNum = $("#cmbkPreIncNum").html();
	m0108VOMap.criNm = $("#criNm").html();
	
	goAjaxDefault("/sjpb/M/M0108updateSpWhab.face",m0108VOMap,callBackFn_M0108_updateSpWhabSuccess);
}
//수정성공함수 호출
function callBackFn_M0108_updateSpWhabSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0108_pageInit();
	freezeInput(true); // 입력 비활성화
}
//입력화면 비/활성화
function freezeInput(tf) {
	$("#contentsArea input").attr("disabled",tf);
	$("#contentsArea select").attr("disabled",tf);
	$("#contentsArea a").attr("disabled",tf);
}
//초기화
function fn_M0108_init(form){
	$("#"+form)[0].reset();	
}
//맵
var m0108VOMap={
		"spWhabDvHandBkNum":""
		,"handBkSiNum":""
		,"incSpNum":""
		,"spNm":""
		,"whabDvDt":""
		,"whabDvRsn":""
		,"whabDvReptDt":""
		,"criNm":""
		,"wantRelsDt":""
		,"cmbkPreIncNum":""
		,"trfDt":""
		,"trfOp":""
		,"respMb":""
		,"spWhabDvHandBkComn":""
		,"rcptNum":""
		,"regUserId":""
}
//리포트맵
var M0108RTMap = {
	rexdataset : null
}