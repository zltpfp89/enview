var qcell;
var queryString;
var qCellList=[];
var listRow;
var headerRows ; 	//헤더라인수 
var rowIdx ;	//선택한 인덱스 전역변수관리
var isInitStyleQcell = false;

$(document).ready(function(){
	
	
	pageInit();     
});

//화면 진입시 동작함
function pageInit(){
	selectList();
	
	eventInitSetup();
}

//이벤트 세팅
function eventInitSetup() {
	
	//피의자 검색버튼
	$("#spBtn").off("click").on("click", function() {	
		commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face', "1050px", "550px", callBackSearchSpSuccess);
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
		
		$("#rcptIncNum").html("(피의자 선택시 자동입력)");
		$("#rltActCriNmCdDesc").html("(피의자 선택시 자동입력)");
		
	}else{
		$("#subTitle").html("상세보기");
	}
	
}

//출력 
function prnData(){
	goAjax("/sjpb/M/M0128selectList.face", m0128SCMap, callBackPrnDataSuccess);
}

//리포트 리스트 콜백 성공함수
function callBackPrnDataSuccess(data){
	
	console.log(JSON.stringify(data));
	m0128RTMap.rexdataset = data.qCell;
	
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
	
	m0128SCMap.rcptIncNumSc = getFieldValue($("#rcptIncNumSc"));
	m0128SCMap.sDateSc = getFieldValue($("#sDateSc"));
	m0128SCMap.eDateSc = getFieldValue($("#eDateSc"));
	
	m0128SCMap.spNmSc = getFieldValue($("#spNmSc"));
	m0128SCMap.refcPersSc = getFieldValue($("#refcPersSc"));
	m0128SCMap.acqsPersSc = getFieldValue($("#acqsPersSc"));
	m0128SCMap.tranPersSc = getFieldValue($("#tranPersSc"));
	m0128SCMap.sTrfDtSc = getFieldValue($("#sTrfDtSc"));
	m0128SCMap.eTrfDtSc = getFieldValue($("#eTrfDtSc"));
	m0128SCMap.regUserNmSc = getFieldValue($("#regUserNmSc"));
	
	goAjax("/sjpb/M/M0128selectList.face", m0128SCMap, function (data){callBackSelectListSuccess(data, selectPkNum)});
}

////사건 검색 성공 콜백함수
//function callBackSearchIncSuccess(data){
//	
//	console.log(data);
//	
//}

//피의자 검색 성공 콜백함수
function callBackSearchSpSuccess(data){
	
	var incSpVO = data;
	
	//피의자를 선택했을 경우에만, 
	if(data != undefined){
		
		$("#rcptNum").val(incSpVO.rcptNum);						//접수번호
		$("#incSpNum").val(incSpVO.incSpNum);					//피의자번호
		$("#rcptIncNum").html(incSpVO.incNum);						//사건번호
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
	
	var QCELLProp = {
            "parentid" : "listSheet",
            "id"		: "cell",
            "rowheader" : "sequence",
            "selectmode": "row",
            "columns"	: [
            	//{width: '4%',	key: 'checkbox',			title: ['',''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '7%',	key: 'rcptDt',				title: ['접수일자','접수일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '7%',	key: 'rcptIncNum',			title: ['사건번호','사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '29%',	key: 'rltActCriNmCdDesc',	title: ['죄명','죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
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
        	
        	//최초 로딩시
        	if(selectPkNum == null){	//selectPkNum이 없으면 첫번째줄 선택
        		rowIdx = headerRows;
        		//debugger;
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
	//Map 데이터 갱신
	if(syncM0128VOMap(true)){	//TODO 페이지별 수정
		goAjax("/sjpb/M/M0128insertUpdateData.face", m0128VOMap, callBackInsertDataSuccess);
	}
}

//신규저장 성공 콜백함수
function callBackInsertDataSuccess(data){
	
	//성공
	if(data.m0128VO.result == "01"){
		alert("신규저장성공!!");
		
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
		alert("수정성공!!");
		
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
	
	//포렌식지원업무현황정보 셋팅 
//	setFieldValue($("#forsSuppSiNum"), h0101VOMap.forsSuppSiNum);		//포렌식지원일련번호
//	
//	setFieldValue($("input[name=recdSiNum]"), h0101VOMap.recdSiNum);		//연번
//	setFieldValue($("input[name=incNum]"), h0101VOMap.incNum);				//사건번호
//	setFieldValue($("input[name=criTm]"), h0101VOMap.criTm);				//수사팀
//	setFieldValue($("input[name=respIo]"), h0101VOMap.respIo);				//탐당수사관
//	setFieldValue($("input[name=revSeizPers]"), h0101VOMap.revSeizPers);	//피압수자
//	setFieldValue($("input[name=compNmAddr]"), h0101VOMap.compNmAddr);		//업체명(주소)
//	setFieldValue($("input[name=docuNum]"), h0101VOMap.docuNum);			//문서번호
//	setFieldValue($("input[name=anasOffi]"), h0101VOMap.anasOffi);			//분석관
//	setFieldValue($("input[name=collDt]"), h0101VOMap.collDt);				//수집일시
//	
//	setFieldValue($("input[name=anasDt]"), h0101VOMap.anasDt);			//분석일시
//	setFieldValue($("input[name=mediDiv]"), h0101VOMap.mediDiv);		//매체구분
//	setFieldValue($("input[name=mediType]"), h0101VOMap.mediType);		//매체종류
//	setFieldValue($("input[name=phonNum]"), h0101VOMap.phonNum);		//전화번호
//	setFieldValue($("input[name=modlInfo]"), h0101VOMap.modlInfo);		//모델정보
//	setFieldValue($("input[name=obsrYn]"), h0101VOMap.obsrYn);			//참관여부
//	setFieldValue($("input[name=obsrDt]"), h0101VOMap.obsrDt);			//참관일
//	setFieldValue($("input[name=obsrPern]"), h0101VOMap.obsrPern);		//참관인
//	setFieldValue($("input[name=obsrRmComn]"), h0101VOMap.obsrRmComn);	//비고
//	
//	setFieldValue($("input[name=digtTrfDt]"), h0101VOMap.digtTrfDt);			//송치일시
//	setFieldValue($("input[name=digtTrfSiNum]"), h0101VOMap.digtTrfSiNum);		//순번
//	setFieldValue($("input[name=digtTrfMngNum]"), h0101VOMap.digtTrfMngNum);	//관리번호
//	setFieldValue($("textarea[name=suppWorkComn]"), h0101VOMap.suppWorkComn);	//비고
	
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
		btnHtml.append('<a href="javascript:insertData();" class="btn_blue"><span>저장</span></a>');
		
	//수정일 경우, 수정 버튼 노출 
	}else{
		//로그인한 계정이 입력한 데이터일 경우 수정가능 
		if($("#userId").val() == m0128VOMap.regUserId){
			areaSetWrite($("#contentsArea"));
			btnHtml.append('<a href="javascript:updateData();" class="btn_blue"><span>수정</span></a>');
			
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
	rowIdx = qcell.getIdx("row");
	
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



//function openDialog(row, val, obj){
//	commonLayerPopup.openLayerPopup('/sjpb/M/AddIncMast.face', "1000px", "430px", function(data){ callBackOpenDialogSuccess(data, row, obj) });
//}
//
////검색을 통해서 신규사건을 추가한다.
//function callBackOpenDialogSuccess(data, row, obj) {
//	qcell.setRowData(parseInt(row),{"rcptIncNum":data[0].rcptIncNum,"rcptNum":data[0].rcptNum});
//}

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
		,sDateSc : ""	//접수일자 시작일
		,eDateSc : ""	//접수일자 종료일
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
	,sDateSc : ""	//접수일자 시작일
	,eDateSc : ""	//접수일자 종료일
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