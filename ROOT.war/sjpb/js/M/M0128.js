var qcell;
var queryString;
var qCellList=[];
var listRow;
var headerRows ; 	//헤더라인수 
var rowIdx ;	//선택한 인덱스 전역변수관리
var isInitStyleQcell = false;

//2018.11.19 추가 S
var incMap;			//사건VO 맵
//2018.11.19 추가 E

$(document).ready(function(){
	
	
	pageInit();     
});

//화면 진입시 동작함
function pageInit(){
	
	//1. 2018.11.19 추가 S
	//검색조건 노출
	//사건에서 보여질 경우, 사건에 필요한것만 노출 
	incMap = setUiRcptNum(parent);
	//2018.11.19 추가 E
	
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
	}

	
	selectList(incMap.rcptNum);
	
	eventInitSetup();
}

//이벤트 세팅
function eventInitSetup() {
	
	//피의자 검색버튼
	$("#spBtn").off("click").on("click", function() {	
		commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face?rcptNum='+incMap.rcptNum, "1050px", "435px", callBackSearchSpSuccess);
	});
	
	//사건 검색버튼
//	$("#rcptIncNumBtn").off("click").on("click", function() {	
//		commonLayerPopup.openLayerPopup('/sjpb/Z/incLayerPopupList.face', "1050px", "600px", callBackSearchIncSuccess);
//	});
	
	$(".searchArea input[type=text],.searchArea select").keypress(function(e){
		if(e.keyCode == 13){
			e.stopPropagation();
			selectList();
		}
	});
	
	//출력 버튼 클릭
	$("#prnBtn").off("click").on("click", function() {		
		prnData();
	});
}

//초기화
function initData(type){
	//0: 신규입력 
	//1: 수정 
	
	//Map 초기화
	initM0128VOMap();
	
	//입력필드 초기화 
	var _$targetObj = $("#contentsArea");
	
	//input 값 초기화
	_$targetObj.find("span").html("");
	_$targetObj.find("input[type=hidden]").val("");
	_$targetObj.find("input[type=text]").val("");
	_$targetObj.find("input[type=radio]:checked").prop("checked", false);
	_$targetObj.find("textarea").text("");
	//_$targetObj.find("input[type=checkbox]:checked").prop("checked", false);
	
	//신규입력 or 수정 화면 컨트롤
	if (type == 0){
		$("#subTitle").html("신규");
		
		$("#rcptDt").html("신규");
		
		$("#rcptIncNum").html(isNull(incMap.rcptIncNum) ? "(피의자 선택시 자동입력)" : incMap.rcptIncNum);					//사건번호셋팅	//2018.11.19 추가 S
		$("#rcptNum").val(isNull(incMap.rcptNum) ? "" : incMap.rcptNum);												//사건접수번호셋팅	//2018.11.19 추가 S
		$("#rltActCriNmCdDesc").html("(피의자 선택시 자동입력)");
		
	}else{
		$("#subTitle").html("상세보기");
	}
	
}

//출력 
function prnData(){
	var vislRcdgMngBkNumList = [];
	for(var i = 2; i <= qcell.getRows("data")+1; i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			vislRcdgMngBkNumList.push(qcell.getRowData(i).vislRcdgMngBkNum);
		}	
	}
	var vislRcdgMngBkNumListMap = {
			"vislRcdgMngBkNumList":vislRcdgMngBkNumList
	}
	
	if(vislRcdgMngBkNumList.length != 0){
		//레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0128prnCheckReport.face", vislRcdgMngBkNumListMap, callBackPrnDataSuccess);
	}else{
		alert("출력할 대상을 선택해주세요.");
		return;
	}
}

//리포트 리스트 콜백 성공함수
function callBackPrnDataSuccess(data){
	
	m0128RTMap.rexdataset = data.rexdataset;
	
	var xmlString = objectToXml(m0128RTMap);
	
	$("#reptNm").val("M0128.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	
	//레포트 호출
	openReportService(reportForm);  
	
}

//화면(리스트)조회 (ajax)
function selectList(selectPkNum){
	
	//검색 유효성 체크
	var chkObjs = $("#searchArea");
	if(!chkValidate.check(chkObjs, true)) return;
	
	//2018.11.19 추가 S
	//사건에서 보여질 경우,
	if(parent.viewType == 'inc'){
		//해당사건번호만 노출함 
		m0128SCMap.rcptNumSc = incMap.rcptNum;
		
	}else{
		
		m0128SCMap.rcptIncNumSc = getFieldValue($("#rcptIncNumSc"));
//		m0128SCMap.sDateSc = getFieldValue($("#sDateSc"));
//		m0128SCMap.eDateSc = getFieldValue($("#eDateSc"));
		
		m0128SCMap.spNmSc = getFieldValue($("#spNmSc"));
		m0128SCMap.refcPersSc = getFieldValue($("#refcPersSc"));
		m0128SCMap.acqsPersSc = getFieldValue($("#acqsPersSc"));
//		m0128SCMap.tranPersSc = getFieldValue($("#tranPersSc"));
		m0128SCMap.sTrfDtSc = getFieldValue($("#sTrfDtSc"));
		m0128SCMap.eTrfDtSc = getFieldValue($("#eTrfDtSc"));
		m0128SCMap.regUserNmSc = getFieldValue($("#regUserNmSc"));
		
	}
	//2018.11.19 추가 E
	
	goAjax("/sjpb/M/M0128selectList.face", m0128SCMap, function (data){callBackSelectListSuccess(data, selectPkNum)},true);
}

////사건 검색 성공 콜백함수
//function callBackSearchIncSuccess(data){
//	
//	
//}

//피의자 검색 성공 콜백함수
function callBackSearchSpSuccess(data){
	
	var incSpVO = data;
	
	//피의자를 선택했을 경우에만, 
	if(data != undefined){
		
		$("#incSpNum").val(incSpVO.incSpNum);					//피의자번호
		$("#rltActCriNmCdDesc").html(incSpVO.rltActCriNmCdDesc);		//죄명
		
		$("input[name=spNm]").val(Base64.decode(incSpVO.spNm));		//피의자
		
	}
	
}


//압수부 리스트를 qCellList에 담는다.
function callBackSelectListSuccess(data, selectPkNum){	
	showList(data.qCell, selectPkNum);
}

//큐셀그리기
function showList(data, selectPkNum){
	if(data ==''|| data==' '){
		if(parent.viewType == 'inc'){
			insertDataView();
		}else{
			$("#docTab").hide();
		}
	}
	var QCELLProp = {
            "parentid" : "listSheet",
            "id"		: "cell",
            "rowheader" : "sequence",
            "selectmode": "row",
            "columns"	: [
            	{width: '4%',	key: 'checkbox',			title: ['',''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '7%',	key: 'rcptDt',				title: ['접수일자','접수일자'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYY-MM-DD hh:mm:ss", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '20%',	key: 'rcptIncNum',			title: ['사건번호','사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '16%',	key: 'rltActCriNmCdDesc',	title: ['죄명','죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '7%',	key: 'spNm',				title: ['영상녹화대상자','피의자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '7%',	key: 'refcPers',			title: ['영상녹화대상자','참고인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '7%',	key: 'acqsPers',			title: ['인수자','인수자'], options:{limit:'number'},		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '7%',	key: 'tranPers',			title: ['인계자','인계자'], options:{limit:'number'},		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '7%',	key: 'trfDt',				title: ['송치일자','송치일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},	                	
            	{width: '15%',	key: 'mngBkComn',			title: ['비고','비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '7%',	key: 'nmKor',				title: ['등록자','등록자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}
            ],
            "merge": {"header": "rowandcol"},
       		"rowheader"	: "sequence",
       		"data" : {"input":data}
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    
        headerRows = qcell.getRows("header");
        
        qcell.bind("click", eventFn);
        
        if (qcell.getRows("data") > 0) {
        	debugger;
        	//최초 로딩시
        	if(selectPkNum == null ||selectPkNum == "" || selectPkNum == " "){	//selectPkNum이 없으면 첫번째줄 선택
        		rowIdx = headerRows;
        		
        		
        		debugger;
        		selectData(qcell.getRowData(rowIdx).vislRcdgMngBkNum);	//TODO 페이지별 수정필요
        	//수정 후, 로딩시
        	}else{
        		selectData(selectPkNum);
        	}
        	
        	//qcell 첫번째줄에 초기 커스텀 스타일 추가 (후에, 클릭시 스타일 제거) 
    		var colCnt = qcell.getCols();
    		for (var i = 1; i < colCnt; i++) {
				qcell.setCellStyle(rowIdx, i, {"background-color" : "#c1c8e8 !important", "border-color" : "#a8b0d4 !important"});
				isInitStyleQcell = true;
			}
        	
        //데이터가 없을경우
        } else {
        	rowIdx = 0 + headerRows;
//        	insertDataView();  //No Data 신규등록화면 노출
        	
        }
}

//신규 입력 화면 노출 
function insertDataView(){
	
	//초기화 
	initData("0");
	
	handleUI();
}

//신규 저장
function insertData(){
	
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
		return;
	}
	
	//Map 데이터 갱신
	if(syncM0128VOMap(true)){	//TODO 페이지별 수정
		goAjax("/sjpb/M/M0128insertUpdateData.face", m0128VOMap, callBackInsertDataSuccess);
	}
}

//신규저장 성공 콜백함수
function callBackInsertDataSuccess(data){
	
	//성공
	if(data.m0128VO.result == "01"){
		alert("영상녹화물 관리대장이 등록되었습니다.");
		
		//리스트재조회
		selectList(data.m0128VO.vislRcdgMngBkNum);
		
	}else{
		alert(data.m0128VO.errMsg);
		
	}
}

//수정 
function updateData(){
	//Map 데이터 갱신
	if(syncM0128VOMap(true)){
		goAjax("/sjpb/M/M0128insertUpdateData.face", m0128VOMap, callBackUpdateDataSuccess);
	}
}

//수정 성공 콜백함수
function callBackUpdateDataSuccess(data){
	
	//성공
	if(data.m0128VO.result == "01"){
		alert("수정되었습니다.");
		
		//리스트재조회
		selectList(data.m0128VO.vislRcdgMngBkNum);
		
	}else{
		alert(data.m0128VO.errMsg);
		
	}
}

//데이터를 가져온다.
function selectData(selectPkNum){
	var reqMap = {
			vislRcdgMngBkNum : selectPkNum		//TODO 페이지마다 수정 
		}
	goAjaxDefault("/sjpb/M/M0128selectData.face", reqMap, callBackSelectDataSuccess);
}

//데이터 가져오기 성공 콜백함수
function callBackSelectDataSuccess(data){
	
	//초기화
	initData("1");
	
	m0128VOMap = data.m0128VO;
	
	if(m0128VOMap == null){
		alert("데이터에 문제가 있습니다. 관리자에게 문의하세요.");
		return;
	}
	
	//데이터 셋팅
	setFieldValue($("#vislRcdgMngBkNum"), m0128VOMap.vislRcdgMngBkNum);	
	setFieldValue($("#rcptNum"), m0128VOMap.rcptNum);	
	setFieldValue($("#incSpNum"), m0128VOMap.incSpNum);	
	
	//setFieldValue($("input[name=rcptDt]"), m0128VOMap.rcptDt);		
	setFieldValue($("#rcptDt"), m0128VOMap.rcptDt);		
	
	setFieldValue($("#rcptIncNum"), m0128VOMap.rcptIncNum);		
	setFieldValue($("#rltActCriNmCdDesc"), m0128VOMap.rltActCriNmCdDesc);		
	setFieldValue($("input[name=spNm]"), m0128VOMap.spNm);		
	setFieldValue($("input[name=refcPers]"), m0128VOMap.refcPers);		
	setFieldValue($("input[name=acqsPers]"), m0128VOMap.acqsPers);		
	setFieldValue($("input[name=tranPers]"), m0128VOMap.tranPers);		
	setFieldValue($("input[name=trfDt]"), m0128VOMap.trfDt);		
	setFieldValue($("#mngBkComn"), m0128VOMap.mngBkComn);			
	
	handleUI();
}

//상황에 맞는 화면노출
function handleUI(){
	
	//버튼 리스트 그리기
	var btnHtml = new StringBuffer();
	
	//신규 등록일 경우, 저장 버튼 노출 
	if(isNull(m0128VOMap.vislRcdgMngBkNum)){	//TODO 페이지별 수정
		areaSetWrite($("#contentsArea"));
		
		//TODO 테스트 데이터 입력 삭제 
		//btnHtml.append('<a href="javascript:setSjpbForsSuppWorkCustTestData();" class="btn_white"><span>테스트데이터입력</span></a>');
		btnHtml.append('<a href="javascript:insertData();" class="btn_light_blue save"><span>저장</span></a>');
		
	//수정일 경우, 수정 버튼 노출 
	}else{
		//로그인한 계정이 입력한 데이터일 경우 수정가 && 사건 > 문서관리에서 보여질경우 수정가능 //2018.11.19 추가 
		if($("#userId").val() == m0128VOMap.regUserId && parent.viewType == 'inc'){
			areaSetWrite($("#contentsArea"));
			btnHtml.append('<a href="javascript:updateData();" class="btn_light_blue_line appointed"><span>수정</span></a>');
			
		//그외 불가능 
		}else{
			areaSetReadOnly($("#contentsArea"));
			
		}
	}
	$("#btnAreaDiv").html(btnHtml.toString());
}

//컨텐츠 영역 readonly 처리 
function areaSetReadOnly(targetObj){
	//data-always 속성이 y 이면 항상 보인다는뜻. readonly처리하지않음
	targetObj.find("input:not([data-always=y]), select:not([data-always=y]), textarea:not([data-always=y])").each(function (){
		//입력 비활성화
		$(this).attr("disabled", "true");
		
	});
	
	//버튼 비활성화
	targetObj.find("a:not([data-always=y], [class*=jstree])").each(function (){
		//입력 비활성화
		$(this).hide();
	});
}

//컨텐츠 영역 readonly 처리 제거 
function areaSetWrite(targetObj){
	targetObj.find("input:not([data-always=y]), select:not([data-always=y]), textarea:not([data-always=y])").each(function (){
		//입력 활성화
		$(this).removeAttr("disabled");
		
	});
	
	//버튼 활성화
	targetObj.find("a:not([data-always=y], [class*=jstree])").each(function (){
		//입력 활성화
		$(this).show();
	});
}

//리스트 셀 클릭 이벤트
function eventFn(e){
	
	//선택한 인덱스 가져오기
	var colIdx = qcell.getIdx("col");
	rowIdx = qcell.getIdx("row");
	if(colIdx >0 && rowIdx > 0){
		if(colIdx != 1){
			//qcell 커스텀 스타일이 있는경우, 제거 
			if(isInitStyleQcell){
				qcell.clearCellStyles();
				isInitStyleQcell = false;
			}
			
			//포렌식지원업무현황상세 호출(헤더영역 아래부분 클릭했을시만)
			if (rowIdx > headerRows -1) {
				selectData(qcell.getRowData(rowIdx).vislRcdgMngBkNum);	//TODO 페이지별 수정
			}
		}
	}
}

//검색조건 초기화
function initSearchData(){
	var searchArea = $("div[class=searchArea]");
	
	//input 값 초기화
	searchArea.find("input[type=text]").val("");
	
	//select 값 초기화
	searchArea.find("select").each(function() {
		$(this).find("option:eq(0)").prop("selected", true);
		$(this).prev('.txt').text($(this).find('option:selected').text());
	});
	
	//검색맵 초기화
	initM0128SCMap();
}

//Map 데이터 갱신
function syncM0128VOMap(isValid) {
	
	//유효성체크 여부에 따라 체크함 
	if(isValid){
		//유효성 체크
		var chkObjs = $("#contentsArea");
		if(!chkValidate.check(chkObjs, true)) return;
		
		//커스텀
		//사건접수번호, 피의자번호 체크
		var rcptNum = $("#rcptNum").val();
		var incSpNum = $("#incSpNum").val();
		
		//사건접수번호, 피의자번호가 비어있으면 피의자 선택 alert노출
		if(isNull(rcptNum) || isNull(incSpNum)){
			alert("피의자를 선택해주세요.");
			return;
		}
	}
	
	//데이터셋팅
	m0128VOMap.vislRcdgMngBkNum = getFieldValue($("#vislRcdgMngBkNum"));
	m0128VOMap.rcptNum = getFieldValue($("#rcptNum"));
	m0128VOMap.incSpNum = getFieldValue($("#incSpNum"));
	
	m0128VOMap.refcPers = getFieldValue($("input[name=refcPers]"));
	m0128VOMap.acqsPers = getFieldValue($("input[name=acqsPers]"));
	m0128VOMap.tranPers = getFieldValue($("input[name=tranPers]"));
	m0128VOMap.trfDt = getFieldValue($("input[name=trfDt]"));
	m0128VOMap.mngBkComn = getFieldValue($("#mngBkComn"));
	
	return true;
	
}

//초기화
function initM0128VOMap(){
	m0128VOMap = {
		vislRcdgMngBkNum : ""
		,mngBkSiNum : ""
		,rcptNum : ""
		,incSpNum : ""
		,rcptDt : ""
		,refcPers : ""
		,acqsPers : ""
		,tranPers : ""
		,trfDt : ""
		,mngBkComn : ""
		,regUserId : ""
		,regDate : ""
		,updUserId : ""
		,updDate : ""          
	}
}

var m0128VOMap = {
		vislRcdgMngBkNum : ""
		,mngBkSiNum : ""
		,rcptNum : ""
		,incSpNum : ""
		,rcptDt : ""
		,refcPers : ""
		,acqsPers : ""
		,tranPers : ""
		,trfDt : ""
		,mngBkComn : ""
		,regUserId : ""
		,regDate : ""
		,updUserId : ""
		,updDate : ""
}

//초기화
function initM0128SCMap(){
	m0128SCMap = {
		rcptIncNumSc : ""	//사건번호
//		,sDateSc : ""	//접수일자 시작일
//		,eDateSc : ""	//접수일자 종료일
		,spNmSc : ""	//피의자
		,refcPersSc : ""	//참고인
		,acqsPersSc : ""	//인수자
		,tranPersSc : ""	//인계자
		,sTrfDtSc : ""		//송치일자 시작일
		,eTrfDtSc : ""		//송치일자 종료일
		,regUserNmSc : ""	//등록자
	}
}

//검색조건
var m0128SCMap = {
	rcptIncNumSc : ""	//사건번호
//	,sDateSc : ""	//접수일자 시작일
//	,eDateSc : ""	//접수일자 종료일
	,spNmSc : ""	//피의자
	,refcPersSc : ""	//참고인
	,acqsPersSc : ""	//인수자
	,tranPersSc : ""	//인계자
	,sTrfDtSc : ""		//송치일자 시작일
	,eTrfDtSc : ""		//송치일자 종료일
	,regUserNmSc : ""	//등록자
}

//리포트맵
var m0128RTMap = {
	rexdataset : null
}