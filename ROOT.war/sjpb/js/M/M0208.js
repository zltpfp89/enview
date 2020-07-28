var qcell;
var queryString;
var qCellList=[];
var listRow;
var headerRows ; 	//헤더라인수 
var rowIdx ;	//선택한 인덱스 전역변수관리

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
	
	if(incMap.combIncYn != "N" && incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
	}
	
	selectList();
	
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
	initM0208VOMap();
	
	//입력필드 초기화 
	var _$targetObj = $("#contentsArea");
	
	//input 값 초기화
	_$targetObj.find("span").html("");
	_$targetObj.find("input[type=hidden]").val("");
	_$targetObj.find("input[type=text]").val("");
	_$targetObj.find("input[type=radio]:checked").prop("checked", false);
	_$targetObj.find("textarea").text("");
	_$targetObj.find("textarea").html("");
	_$targetObj.find("textarea").val("");
	//_$targetObj.find("input[type=checkbox]:checked").prop("checked", false);
	
	//신규입력 or 수정 화면 컨트롤
	if (type == 0){
		$("#subTitle").html("신규");
		
		$("#reqDt").html("신규");
		
		$("#rcptIncNum").html(isNull(incMap.rcptIncNum) ? "(피의자 선택시 자동입력)" : incMap.rcptIncNum);					//사건번호셋팅	//2018.11.19 추가 S
		$("#rcptNum").val(isNull(incMap.rcptNum) ? "" : incMap.rcptNum);												//사건접수번호셋팅	//2018.11.19 추가 S
		
	}else{
		$("#subTitle").html("상세보기");
	}
	
}



//화면(리스트)조회 (ajax)
function selectList(selectPkNum){
	//selectPkNum 값이 있는경우는, 신규생성, 수정 후에 리스트 조회할때,
	//따라서 신규생성, 수정 후 리스트조회는 검색 조건 초기화.
	if(!isNull(selectPkNum)){
		initSearchData();	//검색조건 초기화
	}
	
	//TODO 페이지별 수정
	//검색 유효성 체크
	var chkObjs = $("#searchArea");
	if(!chkValidate.check(chkObjs, true)) return;
	
	//2018.11.19 추가 S
	//사건에서 보여질 경우,
	if(parent.viewType == 'inc'){
		//해당사건번호만 노출함 
		m0208SCMap.rcptNumSc = incMap.rcptNum;
		
	}else{
		setAreaMap($("#searchArea"), m0208SCMap);
		
	}
	//2018.11.19 추가 E
	
//	m0208SCMap.rcptIncNumSc = getFieldValue($("#rcptIncNumSc"));
//	m0208SCMap.apprSiNumSc = getFieldValue($("#apprSiNumSc"));
//	m0208SCMap.sReqDtSc = getFieldValue($("#sReqDtSc"));
//	m0208SCMap.eReqDtSc = getFieldValue($("#eReqDtSc"));
//	m0208SCMap.apltNmSc = getFieldValue($("#apltNmSc"));
//	m0208SCMap.notcTrgtPersSc = getFieldValue($("#notcTrgtPersSc"));
//	m0208SCMap.sHandDtSc = getFieldValue($("#sHandDtSc"));
//	m0208SCMap.eHandDtSc = getFieldValue($("#eHandDtSc"));
//	m0208SCMap.sApprDtSc = getFieldValue($("#sApprDtSc"));
//	m0208SCMap.eApprDtSc = getFieldValue($("#eApprDtSc"));
//	m0208SCMap.regUserNmSc = getFieldValue($("#regUserNmSc"));
	
	goAjax("/sjpb/M/M0208selectList.face", m0208SCMap, function (data){callBackSelectListSuccess(data, selectPkNum)},true);
}

////사건 검색 성공 콜백함수
//function callBackSearchIncSuccess(data){
//	
//	
//}


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
            	{width: '150',	key: 'rcptIncNum',				title: ['사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '100',	key: 'docNum',			title: ['문서번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'recvNm',			title: ['수신'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'susp',			title: ['혐의'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '200',	key: 'persMatt',			title: ['피의자 인적사항'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '200',	key: 'crimRecr',			title: ['범죄경력자료'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '200',	key: 'crimPoint',			title: ['범죄사실의 요지'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '200',	key: 'crimNameAndAtto',			title: ['죄명 및 적용법조'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '200',	key: 'srchAndCrimRecg',			title: ['수사단서 및 범죄 인지 경위'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'nmKor',				title: ['등록자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '100',	key: 'regDate',				title: ['작성일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}          	
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
        	
        	//최초 로딩시
        	if(selectPkNum == null){	//selectPkNum이 없으면 첫번째줄 선택
        		rowIdx = headerRows;
        		
        		selectData(qcell.getRowData(rowIdx).crimRepoNum);	//TODO 페이지별 수정필요
        	//수정 후, 로딩시
        	}else{
        		selectData(selectPkNum);
        	}

        	//셀 선택 백그라운드 지정
        	qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");  
        	
        //데이터가 없을경우
        } else {
        	rowIdx = 0 + headerRows;
        	insertDataView();  //No Data 신규등록화면 노출
        	
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
	if(syncM0208VOMap(true)){	//TODO 페이지별 수정
		
		goAjax("/sjpb/M/M0208insertUpdateData.face", m0208VOMap, callBackInsertDataSuccess);
	}
}

//신규저장 성공 콜백함수
function callBackInsertDataSuccess(data){
	
	//성공
	if(data.M0208VO.result == "01"){
		alert("범죄인지보고서가 등록되었습니다.");
		
		//rowIdx를 맨 위로 설정함. 
		rowIdx = headerRows;
		$("#btnInsert").hide();
		//리스트재조회
		selectList(data.M0208VO.crimRepoNum);
		
	}else{
		alert(data.M0208VO.errMsg);
		
	}
}

//수정 
function updateData(){
	//Map 데이터 갱신
	if(syncM0208VOMap(true)){
		goAjax("/sjpb/M/M0208insertUpdateData.face", m0208VOMap, callBackUpdateDataSuccess);
	}
}

//수정 성공 콜백함수
function callBackUpdateDataSuccess(data){
	
	//성공
	if(data.m0208VO.result == "01"){
		alert("수정되었습니다.");
		
		//리스트재조회
		selectList(data.m0208VO.crimRepoNum);
		
	}else{
		alert(data.m0208VO.errMsg);
		
	}
}

//데이터를 가져온다.
function selectData(selectPkNum){
	var reqMap = {
			crimRepoNum : selectPkNum		//TODO 페이지마다 수정 
		}
	goAjaxDefault("/sjpb/M/M0208selectData.face", reqMap, callBackSelectDataSuccess);
}

//데이터 가져오기 성공 콜백함수
function callBackSelectDataSuccess(data){
	
	//초기화
	initData("1");
	
	m0208VOMap = data.M0208VO;
	
	if(m0208VOMap == null){
		alert("데이터에 문제가 있습니다. 관리자에게 문의하세요.");
		return;
	}
	
	//데이터 셋팅
	getAreaMap($("#contentsArea"), m0208VOMap);
	setFieldValue($("#crimRepoNum"), m0208VOMap.crimRepoNum);	
	setFieldValue($("#rcptNum"), m0208VOMap.rcptNum);	
//	setFieldValue($("#incSpNum"), m0208VOMap.incSpNum);	
//	setFieldValue($("#spIdNum"), m0208VOMap.incSpNum);	
//	setFieldValue($("#spJob"), m0208VOMap.incSpNum);	
//	setFieldValue($("#spAddr"), m0208VOMap.incSpNum);	
	
//	setFieldValue($("#rcptDt"), m0208VOMap.rcptDt);		
//	
	setFieldValue($("#rcptIncNum"), m0208VOMap.rcptIncNum);		
//	setFieldValue($("#rltActCriNmCdDesc"), m0208VOMap.rltActCriNmCdDesc);		
//	setFieldValue($("input[name=spNm]"), m0208VOMap.spNm);		
//	setFieldValue($("input[name=refcPers]"), m0208VOMap.refcPers);		
//	setFieldValue($("input[name=acqsPers]"), m0208VOMap.acqsPers);		
//	setFieldValue($("input[name=tranPers]"), m0208VOMap.tranPers);		
//	setFieldValue($("input[name=trfDt]"), m0208VOMap.trfDt);		
//	setFieldValue($("#mngBkComn"), m0208VOMap.mngBkComn);			
	
	
	handleUI();
}

//상황에 맞는 화면노출
function handleUI(){
	
	//버튼 리스트 그리기
	var btnHtml = new StringBuffer();
	
	//신규 등록일 경우, 저장 버튼 노출 
	if(isNull(m0208VOMap.crimRepoNum)){	//TODO 페이지별 수정
		areaSetWrite($("#contentsArea"));
		//TODO 테스트 데이터 입력 삭제 
		//btnHtml.append('<a href="javascript:setSjpbForsSuppWorkCustTestData();" class="btn_white"><span>테스트데이터입력</span></a>');
		btnHtml.append('<a href="javascript:insertData();" class="btn_light_blue save"><span>저장</span></a>');
	//수정일 경우, 수정 버튼 노출 
	}else{
		btnHtml.append('<a href="javascript:requestReport();" class="btn_white print"><span>신청서 출력</span></a>');
		//로그인한 계정이 입력한 데이터일 경우 수정가능 && 사건 > 문서관리에서 보여질경우 수정가능 //2018.11.19 추가 
		if($("#userId").val() == m0208VOMap.regUserId && parent.viewType == 'inc'){
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
	
			//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
			qcell.removeRowStyle(qcell.getIdx("row","focus","previous") == -1?1:qcell.getIdx("row","focus","previous"));
			qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
			
			//데이터상세 호출(헤더영역 아래부분 클릭했을시만)
			if (rowIdx > headerRows -1) {
				selectData(qcell.getRowData(rowIdx).crimRepoNum);	//TODO 페이지별 수정
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
	initM0208SCMap();
}

//Map 데이터 갱신
function syncM0208VOMap(isValid) {
	
	//유효성체크 여부에 따라 체크함 
	if(isValid){
		//유효성 체크
		var chkObjs = $("#contentsArea");
		if(!chkValidate.check(chkObjs, true)) return;
		
		//커스텀
		//사건접수번호, 피의자번호 체크
		var rcptNum = $("#rcptNum").val();
		var incSpNum = $("#incSpNum").val();
		
		
	}
	
	//데이터셋팅
	setAreaMap($("#contentsArea"), m0208VOMap);
	m0208VOMap.rcptNum = getFieldValue($("#rcptNum"));
	
	return true;
	
}
//신청서 출력
function requestReport(){
	$("#reptNm").val("M0208.crf"); //레포트 파일명
	$("#SEQNUM").val(m0208VOMap.crimRepoNum);
	//레포트 호출
	openReportServiceFSS(reportForm); 
}
//초기화
function initM0208VOMap(){
	m0208VOMap = {
		crimRepoNum : ""
		,rcptNum : ""
		,rcptIncNum : ""
		,docNum : ""
		,recvNm : ""
		,susp : ""
		,persMatt : ""
		,crimRecr : ""
		,crimPoint : ""
		,crimNameAndAtto : ""
		,srchAndCrimRecg : ""
		,regUserId : ""
		,regDate : ""
		,updUserId : ""
		,updDate : ""
		,nmKor :""
	}
}

var m0208VOMap = {
		crimRepoNum : ""
		,rcptNum : ""
		,rcptIncNum : ""
		,docNum : ""
		,recvNm : ""
		,susp : ""
		,persMatt : ""
		,crimRecr : ""
		,crimPoint : ""
		,crimNameAndAtto : ""
		,srchAndCrimRecg : ""
		,regUserId : ""
		,regDate : ""
		,updUserId : ""
		,updDate : ""
		,nmKor : ""
}

//초기화
function initM0208SCMap(){
	m0208SCMap = {
		rcptIncNumSc : ""	//사건번호
		,sReqDtSc : ""	//신청일자 시작일
		,eReqDtSc : ""	//신청일자 종료일
		,regUserNmSc : ""	//등록자
	}
}

//검색조건
var m0208SCMap = {
	rcptIncNumSc : ""	//사건번호
	,sReqDtSc : ""	//신청일자 시작일
	,eReqDtSc : ""	//신청일자 종료일
	,regUserNmSc : ""	//등록자
}

//리포트맵
var m0208RTMap = {
	rexdataset : null
}