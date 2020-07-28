$(document).ready(function(){
	pageInit();
});

var h0101VOMap = new Object();
var isInitStyleQcell = false;
var headerRows ; 	//헤더라인수 
var rowIdx ;	//선택한 인덱스 전역변수관리
var qcell;

//화면 진입시 동작함
function pageInit(){
	selectList();
	
	//이벤트바인딩
	eventSetup();
}

//이벤트 세팅
function eventSetup() {
	
	$(".searchArea input[type=text]").keypress(function(e){
		if(e.keyCode == 13){
			e.stopPropagation();
			doSearch();
		}
	});
	
	//출력 버튼 클릭
	$("#prnBtn").off("click").on("click", function() {		
		prnIntiInc();
	});
	
}

//출력 
function prnIntiInc(){
	selectListReport();
}

//리포트 리스트를 가져온다. 
function selectListReport(){
	goAjax("/sjpb/H/selectList.face", h0101SCMap, callBackSelectListReportSuccess);
}

//리포트 리스트 콜백 성공함수
function callBackSelectListReportSuccess(data){
	
	console.log(JSON.stringify(data));
	h0101RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(h0101RTMap);
	
	$("#reptNm").val("H0101.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	
	//레포트 호출
	openReportService(reportForm);  
	
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
	initH0101SCMap();
}


//리스트 검색
function doSearch(){

	h0101SCMap.incNumSc = getFieldValue($("#incNumSc"));
	h0101SCMap.criTmSc = getFieldValue($("#criTmSc"));
	h0101SCMap.sDateSc = getFieldValue($("#sDateSc"));
	h0101SCMap.eDateSc = getFieldValue($("#eDateSc"));
	
	goAjax("/sjpb/H/selectList.face", h0101SCMap, callBackSelectListSuccess);
}

//초기화
function initData(type){
	//0: 신규입력 
	//1: 수정 
	
	//Map 초기화
	initH0101VOMap();
	
	//입력필드 초기화 
	var _$targetObj = $("#contentsArea");
	
	//input 값 초기화
	_$targetObj.find("input[type=hidden]").val("");
	_$targetObj.find("input[type=text]").val("");
	_$targetObj.find("input[type=radio]:checked").prop("checked", false);
	//_$targetObj.find("input[type=checkbox]:checked").prop("checked", false);
	
	//신규입력 or 수정 화면 컨트롤
	if (type == 0){
		$("#subTitle").html("신규");
	}else{
		$("#subTitle").html("상세보기");
	}
	
}

//디지털포렌식지원업무현황 화면(리스트)조회 (ajax)
function selectList(forsSuppSiNum){
	goAjax("/sjpb/H/selectList.face", h0101SCMap, function (data){callBackSelectListSuccess(data, forsSuppSiNum)});
}

//디지털포렌식지원업무현황 화면(리스트)조회 성공 콜백함수
function callBackSelectListSuccess(data, forsSuppSiNum){
	
	var QCELLProp = {
            "parentid" : "sheet",
            "id"		: "qcell",
            "merge"		: {header : "rowandcol"},
            "data"		: {"input" : data.qCell},
            "selectmode": "row",
            "columns"	: [
            	{width: '4%',	key: 'checkbox',			title: [''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '5%',	key: 'recdSiNum',			title: ['연번', '연번'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '10%',	key: 'incNum',				title: ['사건번호', '사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '5%',	key: 'mediSiNum',			title: ['매체연번', '매체연번'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '10%',	key: 'criTm',				title: ['수사팀', '수사팀'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '8%',	key: 'respIo',				title: ['담당수사관', '담당수사관'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'compNmAddr',			title: ['업체명(주소)', '업체명(주소)'],			sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '8%',	key: 'revSeizPers',			title: ['피압수자', '피압수자'],			sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '7%',	key: 'docuNum',				title: ['수집 및 분석', '문서번호'],			sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '10%',	key: 'collDt',				title: ['수집 및 분석', '수집일시'],			sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '10%',	key: 'anasDt',				title: ['수집 및 분석', '분석일시'],			sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '8%',	key: 'anasOffi',			title: ['수집 및 분석', '분석관'],			sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}
            	],
			//"rowheader"	: "sequence",
			"frozencols" : 5
        };
	
		
        QCELL.create(QCELLProp);
        qcell = QCELL.getInstance("qcell");
        headerRows = qcell.getRows("header");
        
        qcell.bind("click", eventFn);
        
        if (qcell.getRows("data") > 0) {
        	
        	//최초 로딩시
        	if(forsSuppSiNum == null){	//forsSuppSiNum이 없으면 첫번째줄 선택
        		rowIdx = headerRows;
        		//debugger;
        		selectSuppWork(qcell.getRowData(rowIdx).forsSuppSiNum);
        	//수정 후, 로딩시
        	}else{
        		selectSuppWork(forsSuppSiNum);
        	}
        	
        	//qcell 첫번째줄에 초기 커스텀 스타일 추가 (후에, 클릭시 스타일 제거) 
    		var colCnt = qcell.getCols();
    		for (var i = 0; i < colCnt; i++) {
				qcell.setCellStyle(rowIdx, i, {"background-color" : "#c1c8e8 !important", "border-color" : "#a8b0d4 !important"});
				isInitStyleQcell = true;
			}
        	
        //데이터가 없을경우
        } else {
        	rowIdx = 0 + headerRows;
        	insertSuppWorkView();  //No Data 신규등록화면 노출
        	
        }
}

//포렌식지원업무현황을 가져온다.
function selectSuppWork(forsSuppSiNum){
	var reqMap = {
			forsSuppSiNum : forsSuppSiNum
		}
	goAjaxDefault("/sjpb/H/selectSuppWork.face", reqMap, callBackSelectSuppWorkSuccess);
}

//포렌식지원업무현황 가져오기 성공 콜백함수
function callBackSelectSuppWorkSuccess(data){
	
	//초기화
	initData("1");
	
	h0101VOMap = data.h0101VO;
	
	if(h0101VOMap == null){
		alert("포렌식지원업무현황 데이터에 문제가 있습니다. 관리자에게 문의하세요.");
		return;
	}
	
	//포렌식지원업무현황정보 셋팅 
	setFieldValue($("#forsSuppSiNum"), h0101VOMap.forsSuppSiNum);		//포렌식지원일련번호
	
	setFieldValue($("input[name=recdSiNum]"), h0101VOMap.recdSiNum);		//연번
	setFieldValue($("input[name=incNum]"), h0101VOMap.incNum);				//사건번호
	setFieldValue($("input[name=criTm]"), h0101VOMap.criTm);				//수사팀
	setFieldValue($("input[name=respIo]"), h0101VOMap.respIo);				//탐당수사관
	setFieldValue($("input[name=revSeizPers]"), h0101VOMap.revSeizPers);	//피압수자
	setFieldValue($("input[name=compNmAddr]"), h0101VOMap.compNmAddr);		//업체명(주소)
	setFieldValue($("input[name=docuNum]"), h0101VOMap.docuNum);			//문서번호
	setFieldValue($("input[name=anasOffi]"), h0101VOMap.anasOffi);			//분석관
	setFieldValue($("input[name=collDt]"), h0101VOMap.collDt);				//수집일시
	
	setFieldValue($("input[name=anasDt]"), h0101VOMap.anasDt);			//분석일시
	setFieldValue($("input[name=mediDiv]"), h0101VOMap.mediDiv);		//매체구분
	setFieldValue($("input[name=mediType]"), h0101VOMap.mediType);		//매체종류
	setFieldValue($("input[name=phonNum]"), h0101VOMap.phonNum);		//전화번호
	setFieldValue($("input[name=modlInfo]"), h0101VOMap.modlInfo);		//모델정보
	setFieldValue($("input[name=obsrYn]"), h0101VOMap.obsrYn);			//참관여부
	setFieldValue($("input[name=obsrDt]"), h0101VOMap.obsrDt);			//참관일
	setFieldValue($("input[name=obsrPern]"), h0101VOMap.obsrPern);		//참관인
	setFieldValue($("input[name=obsrRmComn]"), h0101VOMap.obsrRmComn);	//비고
	
	setFieldValue($("input[name=digtTrfDt]"), h0101VOMap.digtTrfDt);			//송치일시
	setFieldValue($("input[name=digtTrfSiNum]"), h0101VOMap.digtTrfSiNum);		//순번
	setFieldValue($("input[name=digtTrfMngNum]"), h0101VOMap.digtTrfMngNum);	//관리번호
	setFieldValue($("textarea[name=suppWorkComn]"), h0101VOMap.suppWorkComn);	//비고
	
	handleUI();
}

//상황에 맞는 화면노출
function handleUI(){
	
	//버튼 리스트 그리기
	var btnHtml = new StringBuffer();
	
	//신규 등록일 경우, 저장 버튼 노출 
	if(isNull(h0101VOMap.forsSuppSiNum)){
		//TODO 테스트 데이터 입력 삭제 
		btnHtml.append('<a href="javascript:setSjpbForsSuppWorkCustTestData();" class="btn_white"><span>테스트데이터입력</span></a>');
		btnHtml.append('<a href="javascript:insertSuppWork();" class="btn_blue"><span>저장</span></a>');
		
	//수정일 경우, 수정 버튼 노출 
	}else{
		btnHtml.append('<a href="javascript:updateSuppWork();" class="btn_blue"><span>수정</span></a>');
		
	}
	
	$("#btnAreaDiv").html(btnHtml.toString());
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
		selectSuppWork(qcell.getRowData(rowIdx).forsSuppSiNum);
	}
}

//수정 
function updateSuppWork(){
	//Map 데이터 갱신
	if(syncH0101VOMap(true)){
		goAjax("/sjpb/H/insertUpdateSuppWork.face", h0101VOMap, callBackUpdateSuppWorkSuccess);
	}
}

//수정 성공 콜백함수
function callBackUpdateSuppWorkSuccess(data){
	
	alert("수정성공!!");
	
	//리스트재조회
	selectList(data.h0101VO.forsSuppSiNum);
	
}

//삭제 
function deleteSuppWork(){
	
	//TODO 처리 ?
//	//포렌식 담당자만 삭제 가능 
//	if(SJPBRole.getDgtFrsRoleYn()){
//		
//	}
	
	//선택된 ROW가져오기 
	var h0101VOArray = new Array();
	
	for(var i = 0; i < qcell.getColData(0).length; i++){
		if(qcell.getColData(0)[i] == true){
			
			var h0101VOTmp = new Object();
			//h0101VOTmp = qcell.getRowData(i+1);
			h0101VOTmp = qcell.getRowData(i+headerRows);
			
			h0101VOArray.push(h0101VOTmp);
		}
	}
	
	//체크여부확인 
	if(h0101VOArray.length == 0){
		alert("하나이상 체크해주세요.");
		return;
	}
	
	//병합한다.
	if(confirm("삭제하시겠습니까?") == true){
		var reqMap = {
				h0101VOList : h0101VOArray
		}
		
		goAjax("/sjpb/H/deleteSuppWork.face", reqMap, callBackDeleteSuppWorkSuccess);
	}else{
		return;
	}
}

//삭제 성공 콜백 함수 
function callBackDeleteSuppWorkSuccess(data){
	//성공
	if(data.h0101VO.result == "01"){
		alert("삭제 성공!!");
		
		//리스트재조회
		selectList();
		
	}else{
		var errMsg = "";
		if(data.h0101VO.errMsg != null){
			errMsg = data.h0101VO.errMsg;
		}else{
			errMsg = "삭제 실패 관리자에 문의해주세요.";
		}
		alert(errMsg);
	}
}

//신규 입력 화면 노출 
function insertSuppWorkView(){
	
	//초기화 
	initData("0");
	
	handleUI();
}

//신규 저장
function insertSuppWork(){
	//Map 데이터 갱신
	if(syncH0101VOMap(true)){
		goAjax("/sjpb/H/insertUpdateSuppWork.face", h0101VOMap, callBackInsertSuppWorkSuccess);
	}
}

//신규저장 성공 콜백함수
function callBackInsertSuppWorkSuccess(data){
	alert("신규저장성공!!");
	
	//리스트재조회
	selectList(data.h0101VO.forsSuppSiNum);
	
}


//TODO 삭제 필요 - 디지털포렌식지원업무현황 테스트 데이터 셋팅 
function setSjpbForsSuppWorkCustTestData(){
	var thisName = "";
	$("#contentsArea").find("input, select, span").each(function(){
		
		if(thisName == $(this).attr("name")){
			return true;
		}
		thisName = $(this).attr("name");
		var nodeName = $(this)[0].nodeName.toUpperCase();
		
		if(nodeName == "SELECT"){
			setSelectBoxIndex($(this), 1);
		}else if(nodeName == "INPUT"){
			var type = $(this).attr("type").toUpperCase();
			if(type == "TEXT"){
				setFieldValue( $(this), "1");
			}else if(type == "RADIO"){
				setFieldValue( $(this), "1");
			}else if(type == "CHECKBOX"){
				setFieldValue( $(this), "1");
			}
		}
	});
}

//Map 데이터 갱신
function syncH0101VOMap(isValid) {
	
	//유효성체크 여부에 따라 체크함 
	if(isValid){
		//유효성 체크
		var chkObjs = $("#contentsArea");
		if(!chkValidate.check(chkObjs, true)) return;
	}
	
	h0101VOMap.recdSiNum = getFieldValue($("input[name=recdSiNum]"));		//연번
	
	//h0101VOMap.mediSiNum = getFieldValue($("input[name=mediSiNum]"));		//매체연번
	h0101VOMap.incNum = getFieldValue($("input[name=incNum]"));				//사건번호
	h0101VOMap.criTm = getFieldValue($("input[name=criTm]"));				//수사팀
	h0101VOMap.respIo = getFieldValue($("input[name=respIo]"));				//담당수사관
	h0101VOMap.compNmAddr = getFieldValue($("input[name=compNmAddr]"));		//업체명(주소)
	h0101VOMap.revSeizPers = getFieldValue($("input[name=revSeizPers]"));	//피압수자
	h0101VOMap.docuNum = getFieldValue($("input[name=docuNum]"));			//문서번호
	h0101VOMap.collDt = getFieldValue($("input[name=collDt]"));				//수집일시
	h0101VOMap.anasDt = getFieldValue($("input[name=anasDt]"));				//분석일시
	h0101VOMap.anasOffi = getFieldValue($("input[name=anasOffi]"));			//분석관
	h0101VOMap.mediDiv = getFieldValue($("input[name=mediDiv]"));			//매체구분
	h0101VOMap.mediType = getFieldValue($("input[name=mediType]"));			//매체종류
	
	
	h0101VOMap.phonNum = getFieldValue($("input[name=phonNum]"));			//전화번호
	h0101VOMap.modlInfo = getFieldValue($("input[name=modlInfo]"));			//모델정보
	h0101VOMap.obsrYn = getFieldValue($("input[name=obsrYn]"));				//참관여부
	h0101VOMap.obsrDt = getFieldValue($("input[name=obsrDt]"));				//참관일
	h0101VOMap.obsrPern = getFieldValue($("input[name=obsrPern]"));			//참관인
	h0101VOMap.obsrRmComn = getFieldValue($("input[name=obsrRmComn]"));		//참관실비고
	h0101VOMap.digtTrfDt = getFieldValue($("input[name=digtTrfDt]"));		//디지털송치일시
	h0101VOMap.digtTrfSiNum = getFieldValue($("input[name=digtTrfSiNum]"));	//디지털송치순번
	h0101VOMap.digtTrfMngNum = getFieldValue($("input[name=digtTrfMngNum]"));	//디지털송치관리번호
	h0101VOMap.suppWorkComn = getFieldValue($("textarea[name=suppWorkComn]"));		//지원업무비고
	
	return true;
	
}

//초기화
function initH0101VOMap(){
	h0101VOMap = {
			forsSuppSiNum : ""		//포렌식지원일련번호
			,forsSuppPublYr : ""	//포렌식지원발행년도
			,recdSiNum : ""			//연번
			,mediSiNum : ""			//매체연번
			,incNum : ""			//사건번호
			,criTm : ""				//수사팀
			,respIo : ""			//담당수사관
			,compNmAddr : ""		//업체명(주소)
			,revSeizPers : ""		//피압수자
			,docuNum : ""			//문서번호
			,collDt : ""			//수집일시
			,anasDt : ""			//분석일시
			,anasOffi : ""			//분석관
			,mediDiv : ""			//매체구분
			,mediType : ""			//매체종류
			,phonNum : ""			//전화번호
			,modlInfo : ""			//모델정보
			,obsrYn : ""			//참관여부
			,obsrDt : ""			//참관일
			,obsrPern : ""			//참관인
			,obsrRmComn : ""		//참관실비고
			,suppWorkComn : ""		//지원업무비고
			,digtTrfDt : ""			//디지털송치일시
			,digtTrfSiNum : ""		//디지털송치순번
			,digtTrfMngNum : ""		//디지털송치관리번호
			,regUserId : ""         //등록자
			,regDate : ""           //등록일자
			,updUserId : ""         //수정자
			,updDate : ""           //수정일자
		}                           
}


//포렌식
var h0101VOMap = {
		forsSuppSiNum : ""		//포렌식지원일련번호
		,forsSuppPublYr : ""	//포렌식지원발행년도
		,recdSiNum : ""			//연번
		,mediSiNum : ""			//매체연번
		,incNum : ""			//사건번호
		,criTm : ""				//수사팀
		,respIo : ""			//담당수사관
		,compNmAddr : ""		//업체명(주소)
		,revSeizPers : ""		//피압수자
		,docuNum : ""			//문서번호
		,collDt : ""			//수집일시
		,anasDt : ""			//분석일시
		,anasOffi : ""			//분석관
		,mediDiv : ""			//매체구분
		,mediType : ""			//매체종류
		,phonNum : ""			//전화번호
		,modlInfo : ""			//모델정보
		,obsrYn : ""			//참관여부
		,obsrDt : ""			//참관일
		,obsrPern : ""			//참관인
		,obsrRmComn : ""		//참관실비고
		,suppWorkComn : ""		//지원업무비고
		,digtTrfDt : ""			//디지털송치일시
		,digtTrfSiNum : ""		//디지털송치순번
		,digtTrfMngNum : ""		//디지털송치관리번호
		,regUserId : ""         //등록자
		,regDate : ""           //등록일자
		,updUserId : ""         //수정자
		,updDate : ""           //수정일자
}

//초기화
function initH0101SCMap(){
	h0101SCMap = {
		incNumSc : ""	//사건번호
		,criTmSc : ""	//수사팀
		,sDateSc : ""	//분석시작일
		,eDateSc : ""	//분석종료일
	}
}

//검색조건
var h0101SCMap = {
	incNumSc : ""	//사건번호
	,criTmSc : ""	//수사팀
	,sDateSc : ""	//분석시작일
	,eDateSc : ""	//분석종료일
}

//리포트맵
var h0101RTMap = {
	rexdataset : null
}
