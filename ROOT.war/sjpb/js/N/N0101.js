$(document).ready(function(){
	pageInit();
});

var n0101VOMap = new Object();
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
	goAjax("/sjpb/N/selectList.face", n0101SCMap, callBackSelectListReportSuccess);
}

//리포트 리스트 콜백 성공함수
function callBackSelectListReportSuccess(data){
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

	n0101SCMap.fincCd = getFieldValue($("#fincCdSc"));
	n0101SCMap.fincDtaSbjt = getFieldValue($("#fincDtaSbjtSc"));
	n0101SCMap.wrntTrgtAcctNum = getFieldValue($("#wrntTrgtAcctNumSc"));

	goAjax("/sjpb/N/selectList.face", n0101SCMap, callBackSelectListSuccess);
}

//초기화
function initData(type){
	//0: 신규입력 
	//1: 수정 
	
	//Map 초기화
	initN0101VOMap();
	
	//입력필드 초기화 
	var _$targetObj = $("#contentsArea");
	
	//input 값 초기화
	_$targetObj.find("input[type=hidden]").val("");
	_$targetObj.find("input[type=text]").val("");
	_$targetObj.find("input[type=radio]:checked").prop("checked", false);
	setFieldValue($("select[name=fincCd]"), "-1");
	
	//신규입력 or 수정 화면 컨트롤
	if (type == 0){
		ekrFile.fileUploadCallback();
		$("#subTitle").html("신규");
		//$("#viewDiv").hide();
		$("#insertDiv").show();
		$("#insertTDiv").show();
	}else{
		$("#subTitle").html("상세보기");
		//$("#viewDiv").show();
		$("#insertDiv").hide();	
		$("#insertTDiv").hide();
	}
	
}  //

//디지털포렌식지원업무현황 화면(리스트)조회 (ajax)
function selectList(fincDtaBkNum){
	goAjax("/sjpb/N/selectList.face", n0101SCMap, function (data){callBackSelectListSuccess(data, fincDtaBkNum)});
}

//디지털포렌식지원업무현황 화면(리스트)조회 성공 콜백함수
function callBackSelectListSuccess(data, fincDtaBkNum){
	
	var QCELLProp = {
            "parentid" : "sheet",
            "id"		: "qcell",
            "merge"		: {header : "rowandcol"},
            "data"		: {"input" : data.qCell},
            "selectmode": "row",
            "columns"	: [
            	{width: '4%',	key: 'checkbox',			title: [''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'fincNm',			title: ['계좌은행'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '17%',	key: 'fincDtaSbjt',			title: ['제목'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},  
            	{width: '20%',	key: 'wrntTrgtAcctNum',			title: ['계좌번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},            	
            	{width: '13%',	key: 'regDate',			title: ['등록일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '13%',	key: 'endDate',			title: ['데이터초기화 일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'remainDay',			title: ['남은 일자'],	type:'html',	sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'},options: {html: {data: remainDayHtml}}}, 
            	{width: '8%',	key: 'viewBtn',			title: ['내용보기'],	type:'html',	sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'},options: {html: {data: detailButtonHtml}}}, 
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
        	if(fincDtaBkNum == null){	//fincDtaBkNum이 없으면 첫번째줄 선택
        		rowIdx = headerRows;
        		//debugger;
        		selectFincDtaInfo(qcell.getRowData(rowIdx).fincDtaBkNum);
        	//수정 후, 로딩시
        	}else{
        		selectFincDtaInfo(fincDtaBkNum);
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
        	insertFincDtaViewBtn();  //No Data 신규등록화면 노출
        	
        }
}

function detailButtonHtml(id, row, col, val, obj){
	var html = '';
	var url = "/sjpb/N/N0102.face?fincDtaBkNum="+obj.fincDtaBkNum;
	html = "<a href='"+url+"'  class='btn_blue'><span>조회</span></a>";
	return html;
}


function remainDayHtml(id, row, col, val, obj){
	var html = '';
	if(isNull(val)){
		html = val;
	} else {
		html = "<font color='red'>"+val+"</span>";
	}
	return html;
}


//포렌식지원업무현황을 가져온다.
function selectFincDtaInfo(fincDtaBkNum){
	var reqMap = {
			fincDtaBkNum : fincDtaBkNum
		}
	goAjaxDefault("/sjpb/N/selectFincDtaInfo.face", reqMap, callBackSelectFincDtaInfoSuccess);
}

//포렌식지원업무현황 가져오기 성공 콜백함수
function callBackSelectFincDtaInfoSuccess(data){
	
	//초기화
	initData("1");
	
	n0101VOMap = data.n0101VO;
	
	if(n0101VOMap == null){
		alert("금융분석 관리 대장 정보 데이터에 문제가 있습니다. 관리자에게 문의하세요.");
		return;
	}

	//포렌식지원업무현황정보 셋팅 
	setFieldValue($("#fincDtaBkNum"), n0101VOMap.fincDtaBkNum);		//포렌식지원일련번호
	
	setFieldValue($("input[name=fincDtaSbjt]"), n0101VOMap.fincDtaSbjt);		//연번
	setFieldValue($("input[name=wrntTrgtAcctNum]"), n0101VOMap.wrntTrgtAcctNum);				//사건번호	
	setFieldValue($("select[name=fincCd]"), n0101VOMap.fincCd);

	var html = "";
	$.each(n0101VOMap.cmctFincDtaFileVOList, function(index,item){
		html += "<li><a href ='/sjpb/Z/download.face?fileId="+item.fileId+"'>"+item.fileNm+"</a></li>";
	});
	$("#fileList").html(html);
	
	
	
	
	handleUI();
}

//상황에 맞는 화면노출
function handleUI(){
	
	//버튼 리스트 그리기
	var btnHtml = new StringBuffer();
	
	//신규 등록일 경우, 저장 버튼 노출 
	if(isNull(n0101VOMap.fincDtaBkNum)){
		btnHtml.append('<a href="javascript:insertFincDta();" class="btn_blue"><span>저장</span></a>');
		
	//수정일 경우, 수정 버튼 노출 
	}else{
		btnHtml.append('<a href="javascript:updateFincDta();" class="btn_blue"><span>수정</span></a>');
		
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
		selectFincDtaInfo(qcell.getRowData(rowIdx).fincDtaBkNum);
	}
}

//수정 
function updateFincDta(){
	
	//Map 데이터 갱신
	
	if(syncN0101VOMap(true)){
		goAjax("/sjpb/N/insertFincDta.face", n0101VOMap, callBackUpdateFincDtaSuccess);
	}
	
}

//수정 성공 콜백함수
function callBackUpdateFincDtaSuccess(data){
	alert("수정되었습니다.");
	selectList(data.n0101VO.fincDtaBkNum);
	
}

//삭제 
function deleteFincDta(){
	
	
	//선택된 ROW가져오기 
	var n0101VOArray = new Array();
	
	for(var i = 0; i < qcell.getColData(0).length; i++){
		if(qcell.getColData(0)[i] == true){
			
			var n0101VOTmp = new Object();
			//h0101VOTmp = qcell.getRowData(i+1);
			n0101VOTmp = qcell.getRowData(i+headerRows);
			
			n0101VOArray.push(n0101VOTmp);
		}
	}
	
	//체크여부확인 
	if(n0101VOArray.length == 0){
		alert("하나이상 체크해주세요.");
		return;
	}
	
	//병합한다.
	if(confirm("삭제하시겠습니까?") == true){
		var reqMap = {
				n0101VOList : n0101VOArray
		}
		
		goAjax("/sjpb/N/deleteFincDtaInfo.face", reqMap, callBackDeleteFincDtaSuccess);
	}else{
		return;
	}
}

//삭제 성공 콜백 함수 
function callBackDeleteFincDtaSuccess(data){
	//성공
	if(data.n0101VO.result == "01"){
		alert("삭제되었습니다.");
		selectList();
		
	}else{
		var errMsg = "";
		if(data.n0101VO.errMsg != null){
			errMsg = data.n0101VO.errMsg;
		}else{
			errMsg = "삭제 실패 관리자에 문의해주세요.";
		}
		alert(errMsg);
	}
}

//신규 입력 화면 노출 
function insertFincDtaViewBtn(){
	
	//초기화 
	initData("0");
	
	handleUI();
	
	autoResize();
}

//신규 저장
function insertFincDta(){
	//Map 데이터 갱신
	ekrFile.setForm();
	if(syncN0101VOMap(true)){
		goAjax("/sjpb/N/insertFincDta.face", n0101VOMap, callBackInsertSuppWorkSuccess);
	}
}

//신규저장 성공 콜백함수
function callBackInsertSuppWorkSuccess(data){
	alert("신규로 등록되었습니다.");
	
	//리스트재조회
	selectList(data.n0101VO.fincDtaBkNum);
	
}

function fn_bankTemplateDown(value){
	if(value =='1'){
		alert("템플릿을 선택하세요.");
		return false;
	}else invisible.location.href=value;
}

//Map 데이터 갱신
function syncN0101VOMap(isValid) {
	
	//유효성체크 여부에 따라 체크함 
	if(isValid){
		//유효성 체크
		var chkObjs = $("#contentsArea");
		if(!chkValidate.check(chkObjs, true)) return;
	}
	n0101VOMap.fincDtaSbjt = getFieldValue($("input[name=fincDtaSbjt]"));				//사건번호
	n0101VOMap.wrntTrgtAcctNum = getFieldValue($("input[name=wrntTrgtAcctNum]"));				//수사팀
	n0101VOMap.fincCd = getFieldValue($("select[name=fincCd]"));				//담당수사관                   
    n0101VOMap.fileId  = getFieldValue($("input[name=fileId]"));	
    n0101VOMap.fileNm  = getFieldValue($("input[name=fileNm]"));	
    n0101VOMap.fileSize  = getFieldValue($("input[name=fileSize]"));	
    n0101VOMap.fileType  = getFieldValue($("input[name=fileType]"));	
    n0101VOMap.filePath  = getFieldValue($("input[name=filePath]"));	
    n0101VOMap.fileCtype  = getFieldValue($("input[name=fileCtype]"));	
    n0101VOMap.fileCnt  = getFieldValue($("input[name=fileCnt]"));	
    n0101VOMap.delFileIds  = getFieldValue($("input[name=delFileIds]"));	
	return true;
	
}

//초기화
function initN0101VOMap(){
	n0101VOMap = {
			fincDtaBkNum : ""		//포렌식지원일련번호
			,fincDtaSbjt : ""	//포렌식지원발행년도
			,wrntTrgtAcctNum : ""			//연번
			,fincCd : ""			//매체연번
		}                           
}


//포렌식
var n0101VOMap = {
		fincDtaBkNum : ""		//포렌식지원일련번호
		,fincDtaSbjt : ""	//포렌식지원발행년도
		,wrntTrgtAcctNum : ""			//연번
		,fincCd : ""			//매체연번
		,cmctFincDtaFileVOList : null
}

//초기화
function initN0101SCMap(){
	n0101SCMap = {
		incCd : ""	//금융코드
		,fincDtaSbjt : ""	//제목
		,wrntTrgtAcctNum : ""	// 영장대상 계좌번호
	}
}

//검색조건
var n0101SCMap = {
	fincCd : ""	//금융코드
	,fincDtaSbjt : ""	//제목
	,wrntTrgtAcctNum : ""	// 영장대상 계좌번호
}

//리포트맵
var n0101RTMap = {
	rexdataset : null
}
