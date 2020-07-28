var qcell;
var queryString;
var qCellList=[];
var rowIdx=2;
var incMap;
$(document).ready(function(){
	incMap = setUiRcptNum(parent);
	fn_M0111_pageInit();  


});
//화면 진입시 동작함
function fn_M0111_pageInit(){
	qCellList=[];
	
	queryString=$("#m0111_searchList").serialize();
	//검색조건 노출
	//사건에서 보여질 경우, 사건에 필요한것만 노출 (본인데이터만)
	if(parent.viewType == 'inc'){
		queryString += "&rcptNumSc="+incMap.rcptNum;
	}
	goAjax("/sjpb/M/M0111selectList.face",queryString,callBackFn_M0111_selectListSuccess);
}
//체포구속인명부서식 리스트 그리기.
function callBackFn_M0111_selectListSuccess(data){	
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
            	{width: '12%',	key: 'atdcReqDt',			title: ['출석요구일시','출석요구일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'atdcPersDivDesc',			title: ['출석자','구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'atdcPersNm',			title: ['출석자','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '14%',	key: 'rcptIncNum',			title: ['사건번호','사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'atdcReqNotcDt',			title: ['출석요구통지','통지일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'atdcReqNotcWayDesc',			title: ['출석요구통지','방법'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'atdcReqRst',			title: ['결과','결과'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '14%',	key: 'atdcReqRespMb',			title: ['담당자확인','담당자확인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(2, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0111VOMap = qcell.getRowData(2);
	    	fn_M0111_selectAtdcReqSetting();
	    	//수정세팅
	    	updateYN();
		}
}
//체포구속인명부서식 셀클릭 이벤트
function eventFn(e){
	// 선택한 인덱스 가져오기
	if(rowIdx == null){
		rowIdx = 2;//초기값 설정
	}else{
		rowIdx = qcell.getIdx("row");	
	}
	//기존 체크박스 열번호
	var pastchk = qcell.getIdx("row","focus","previous") == -1?2:qcell.getIdx("row","focus","previous");
	
	//기존 체크항목 해제
	qcell.removeRowStyle(pastchk);

	//새로 선택한 행 스타일적용
	qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
	
	m0111VOMap = qcell.getRowData(rowIdx);

	//체포구속인명부서식 데이터 세팅
	fn_M0111_selectAtdcReqSetting();
	//수정세팅
	updateYN();
}
//체포구속인명부서식 데이터 세팅
function fn_M0111_selectAtdcReqSetting(){	

	getAreaMap($("#M0111Pern"), m0111VOMap);
	$("#incNum").html(m0111VOMap.rcptIncNum);
	$("#divCdCath").val(m0111VOMap.divCd);
	$("#incSpNum").val(m0111VOMap.incSpNum);	
	$("#rcptNum").val(m0111VOMap.rcptNum);
	$("#incNum").html(m0111VOMap.rcptIncNum);
	$("#atdcPersDiv").val(m0111VOMap.atdcPersDiv).prop("selected",true);
	$("#atdcReqNotcWay").val(m0111VOMap.atdcReqNotcWay).prop("selected",true);
	$("#atdcPersNm").html(m0111VOMap.atdcPersNm);
	
}

//수정 가능 버튼 보이기 여부
function updateYN(){

	if(m0111VOMap.regUserId == $("#userId").val() ){
		freezeInput(false); // 입력 활성화
		$("#btnSearchInc").show(); // 검색버튼보이기
		$("#btnUpdatePern").show();  //수정버튼 보이기
		
	}else{
		freezeInput(true); // 입력 비활성화
		$("#btnUpdatePern").hide();  //수정버튼 숨기기

	}
	$("#btnInsertPern").hide();  //저장버튼 숨기기
}

//사건검색 팝업창
function fn_M0111_searchIncSp(){
	commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face?rcptNum='+incMap.rcptNum, "1050px", "550px", callBackFn_M0111_searchIncSpSuccess);
}

//사건검색 성공함수
function callBackFn_M0111_searchIncSpSuccess(data){

	$("#rcptNum").val(data.rcptNum);
	$("#incSpNum").val(data.incSpNum);
	$("#spNm").val(Base64.decode(data.spNm));								// 피의자 성명 출력
	$("#spIdNum").html(Base64.decode(data.spIdNum));							// 피의자 주민등록번호 출력
	$("#spJob").html(Base64.decode(data.spJob));								// 피의자 직업 출력
	$("#spAddr").html(Base64.decode(data.spAddr));							// 피의자 주거 출력
	$("#rltActCriNmCdDesc").html(data.rltActCriNmCdDesc);					// 피의자 죄명 출력
}
//출석요구통지부 출력
function fn_M0111_prtPernReport() {
	queryString = $("#m0111_searchList").serialize();
	
	//출석요구통지부 리스트 레포트 성공함수 호출
	goAjaxDefault("/sjpb/M/M0111selectList.face",queryString, callBackFn_M0111_prtPernReportSuccess);
}
//출석요구통지부 출력 성공함수
function callBackFn_M0111_prtPernReportSuccess(data){
	M0111RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0110RTMap);
	$("#reptNm").val("M0111.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	console.log(xmlString);
	//레포트 호출
	openReportService(reportForm); 
}

//맵초기화
function fn_M0111_initM0111VOMap() {
	m0111VOMap={
			"atdcReqNotcNum":""
			,"atdcReqDt":""
			,"atdcPersDiv":""
			,"atdcPersNm":""
			,"rcptNum":""
			,"atdcReqNotcDt":""
			,"atdcReqNotcWay":""
			,"atdcReqRst":""
			,"atdcReqRespMb":""
			,"regUserId":""
	}
}

//신규등록
function fn_M0111_newPern(){

	$("#contentsArea").show();
	fn_M0111_initM0111VOMap(); //맵초기화
	fn_M0111_selectPernSetting(); // 데이터 세팅	
	freezeInput(false); // 입력 활성화
	$("#btnSearchInc").show(); // 검색버튼보이기
	$("#btnInsertPern").show(); // 저장버튼 보이기	
	$("#btnUpdatePern").hide(); // 수정버튼 숨기기	
	$("#incNum").html(incMap.rcptIncNum);
	$("#rcptNum").val(incMap.rcptNum);
}
//등록하기
function fn_M0111_insertPern(){
	//유효성검사

	setAreaMap($("#M0111Pern"), m0111VOMap);
	m0111VOMap.rcptNum = $("#rcptNum").val();
	m0111VOMap.incSpNum = $("#incSpNum").val();
	m0111VOMap.rcptIncNum = $("#incNum").html();
	m0111VOMap.atdcPersDiv = $("#atdcPersDiv").val();
	m0111VOMap.atdcReqNotcWay = $("#atdcReqNotcWay").val();
	if($("#spDiv").is(":visible")){
		m0111VOMap.atdcPersNm = $("#spNm").val();
	}
	if($("#refeDiv").is(":visible")){
		m0111VOMap.atdcPersNm = $("#refeNm").val();
	}
	

	goAjaxDefault("/sjpb/M/M0111insertPern.face",m0111VOMap,callBackFn_M0111_insertPernSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsertPern").hide(); //저장버튼 숨기기

}

//등록성공함수 호출
function callBackFn_M0111_insertPernSuccess(data){
	if(data == 1){
		alert("체포구속인명부서식가 등록되었습니다.");
	}else{
		alert("체포구속인명부서식 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0111_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0111_updatePern(){
	
	setAreaMap($("#M0111Pern"), m0111VOMap);
	m0111VOMap.rcptNum = $("#rcptNum").val();
	m0111VOMap.incSpNum = $("#incSpNum").val();
	m0111VOMap.rcptIncNum = $("#incNum").html();
	
	goAjaxDefault("/sjpb/M/M0111updatePern.face",m0111VOMap,callBackFn_M0111_updatePernSuccess);
}
//수정성공함수 호출
function callBackFn_M0111_updatePernSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0110_pageInit();
	freezeInput(true); // 입력 비활성화
}
//입력화면 비/활성화
function freezeInput(tf) {
	$("#contentsArea input").attr("disabled",tf);
	$("#contentsArea select").attr("disabled",tf);
	$("#contentsArea a").attr("disabled",tf);
}
//초기화
function fn_M0111_init(form){
	$("#"+form)[0].reset();	
}
//맵
var m0111VOMap={
		"atdcReqNotcNum":""
		,"atdcReqDt":""
		,"atdcPersDiv":""
		,"atdcPersNm":""
		,"rcptNum":""
		,"atdcReqNotcDt":""
		,"atdcReqNotcWay":""
		,"atdcReqRst":""
		,"atdcReqRespMb":""
		,"regUserId":""
}
//리포트맵
var M0111RTMap = {
	rexdataset : null
}