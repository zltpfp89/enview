$(document).ready(function(){
	pageInit();
});

var n0201VOMap = new Object();
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

	n0201SCMap.cmctCmpyCd = getFieldValue($("#cmctCmpyCdSc"));
	n0201SCMap.cmctDtaSbjt = getFieldValue($("#cmctDtaSbjtSc"));
	n0201SCMap.moblPhonNum = getFieldValue($("#moblPhonNumSc"));

	goAjax("/sjpb/N/selectCmctList.face", n0201SCMap, callBackSelectListSuccess);
}

//초기화
function initData(type){
	//0: 신규입력 
	//1: 수정 
	
	//Map 초기화
	initN0201VOMap();
	
	//입력필드 초기화 
	var _$targetObj = $("#contentsArea");
	
	//input 값 초기화
	_$targetObj.find("input[type=hidden]").val("");
	_$targetObj.find("input[type=text]").val("");
	_$targetObj.find("input[type=radio]:checked").prop("checked", false);
	setFieldValue($("select[name=cmctCmpyCd]"), "-1");
	
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
function selectList(cmctDtaBkNum){
	goAjax("/sjpb/N/selectCmctList.face", n0201SCMap, function (data){callBackSelectListSuccess(data, cmctDtaBkNum)});
}

//디지털포렌식지원업무현황 화면(리스트)조회 성공 콜백함수
function callBackSelectListSuccess(data, cmctDtaBkNum){
	
	var QCELLProp = {
            "parentid" : "sheet",
            "id"		: "qcell",
            "merge"		: {header : "rowandcol"},
            "data"		: {"input" : data.qCell},
            "selectmode": "row",
            "columns"	: [
            	{width: '4%',	key: 'checkbox',			title: [''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'cmctCmpyNm',			title: ['통신사'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '17%',	key: 'cmctDtaSbjt',			title: ['제목'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},  
            	{width: '20%',	key: 'moblPhonNum',			title: ['휴대폰번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},            	
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
        	if(cmctDtaBkNum == null){	//cmctDtaBkNum이 없으면 첫번째줄 선택
        		rowIdx = headerRows;
        		//debugger;
        		selectCmctDtaInfo(qcell.getRowData(rowIdx).cmctDtaBkNum);
        	//수정 후, 로딩시
        	}else{
        		selectCmctDtaInfo(cmctDtaBkNum);
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
        	insertCmctDtaViewBtn();  //No Data 신규등록화면 노출
        	
        }
}

function detailButtonHtml(id, row, col, val, obj){
	var html = '';
	var url = "/sjpb/N/N0202.face?cmctDtaBkNum="+obj.cmctDtaBkNum;
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
function selectCmctDtaInfo(cmctDtaBkNum){
	var reqMap = {
			cmctDtaBkNum : cmctDtaBkNum
		}
	goAjaxDefault("/sjpb/N/selectCmctDtaInfo.face", reqMap, callBackSelectCmctDtaInfoSuccess);
}

//포렌식지원업무현황 가져오기 성공 콜백함수
function callBackSelectCmctDtaInfoSuccess(data){
	
	//초기화
	initData("1");
	
	n0201VOMap = data.n0201VO;
	
	if(n0201VOMap == null){
		alert("통신분석 관리 대장 정보 데이터에 문제가 있습니다. 관리자에게 문의하세요.");
		return;
	}
	//포렌식지원업무현황정보 셋팅 
	setFieldValue($("#cmctDtaBkNum"), n0201VOMap.cmctDtaBkNum);		//포렌식지원일련번호
	
	setFieldValue($("input[name=cmctDtaSbjt]"), n0201VOMap.cmctDtaSbjt);		//연번
	setFieldValue($("input[name=moblPhonNum]"), n0201VOMap.moblPhonNum);				//사건번호	
	setFieldValue($("select[name=cmctCmpyCd]"), n0201VOMap.cmctCmpyCd);

	var html = "";
	$.each(n0201VOMap.cmctDtaFileVOList, function(index,item){
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
	if(isNull(n0201VOMap.cmctDtaBkNum)){
		btnHtml.append('<a href="javascript:insertCmctDta();" class="btn_blue"><span>저장</span></a>');
		
	//수정일 경우, 수정 버튼 노출 
	}else{
		btnHtml.append('<a href="javascript:updateCmctDta();" class="btn_blue"><span>수정</span></a>');
		
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
		selectCmctDtaInfo(qcell.getRowData(rowIdx).cmctDtaBkNum);
	}
}

//수정 
function updateCmctDta(){
	
	//Map 데이터 갱신
	
	if(syncN0201VOMap(true)){
		goAjax("/sjpb/N/insertCmctDta.face", n0201VOMap, callBackUpdateCmctDtaSuccess);
	}
	
}

//수정 성공 콜백함수
function callBackUpdateCmctDtaSuccess(data){
	alert("수정되었습니다.");
	selectList(data.n0201VO.cmctDtaBkNum);
	
}

//삭제 
function deleteCmctDta(){
	
	
	//선택된 ROW가져오기 
	var n0201VOArray = new Array();
	
	for(var i = 0; i < qcell.getColData(0).length; i++){
		if(qcell.getColData(0)[i] == true){
			
			var n0201VOTmp = new Object();
			//h0101VOTmp = qcell.getRowData(i+1);
			n0201VOTmp = qcell.getRowData(i+headerRows);
			
			n0201VOArray.push(n0201VOTmp);
		}
	}
	
	//체크여부확인 
	if(n0201VOArray.length == 0){
		alert("하나이상 체크해주세요.");
		return;
	}
	
	//병합한다.
	if(confirm("삭제하시겠습니까?") == true){
		var reqMap = {
				n0201VOList : n0201VOArray
		}
		
		goAjax("/sjpb/N/deleteCmctDtaInfo.face", reqMap, callBackDeleteCmctDtaSuccess);
	}else{
		return;
	}
}

//삭제 성공 콜백 함수 
function callBackDeleteCmctDtaSuccess(data){
	//성공
	if(data.n0201VO.result == "01"){
		alert("삭제되었습니다.");
		selectList();
		
	}else{
		var errMsg = "";
		if(data.n0201VO.errMsg != null){
			errMsg = data.n0201VO.errMsg;
		}else{
			errMsg = "삭제 실패 관리자에 문의해주세요.";
		}
		alert(errMsg);
	}
}

//신규 입력 화면 노출 
function insertCmctDtaViewBtn(){
	
	//초기화 
	initData("0");
	
	handleUI();
	
	//iframe 사이즈조절
	autoResize();
}

//신규 저장
function insertCmctDta(){
	//Map 데이터 갱신
	ekrFile.setForm();
	if(syncN0201VOMap(true)){
		goAjax("/sjpb/N/insertCmctDta.face", n0201VOMap, callBackInsertSuppWorkSuccess);
	}
}

//신규저장 성공 콜백함수
function callBackInsertSuppWorkSuccess(data){
	alert("신규로 등록되었습니다.");
	
	//리스트재조회
	selectList(data.n0201VO.cmctDtaBkNum);
	
}

function fn_cmctTemplateDown(value){
	if(value =='1'){
		alert("템플릿을 선택하세요.");
		return false;
	}else invisible.location.href=value;
}



//Map 데이터 갱신
function syncN0201VOMap(isValid) {
	
	//유효성체크 여부에 따라 체크함 
	if(isValid){
		//유효성 체크
		var chkObjs = $("#contentsArea");
		if(!chkValidate.check(chkObjs, true)) return;
	}
	n0201VOMap.cmctDtaSbjt = getFieldValue($("input[name=cmctDtaSbjt]"));				//사건번호
	n0201VOMap.moblPhonNum = getFieldValue($("input[name=moblPhonNum]"));				//수사팀
	n0201VOMap.cmctCmpyCd = getFieldValue($("select[name=cmctCmpyCd]"));				//담당수사관                   
    n0201VOMap.fileId  = getFieldValue($("input[name=fileId]"));	
    n0201VOMap.fileNm  = getFieldValue($("input[name=fileNm]"));	
    n0201VOMap.fileSize  = getFieldValue($("input[name=fileSize]"));	
    n0201VOMap.fileType  = getFieldValue($("input[name=fileType]"));	
    n0201VOMap.filePath  = getFieldValue($("input[name=filePath]"));	
    n0201VOMap.fileCtype  = getFieldValue($("input[name=fileCtype]"));	
    n0201VOMap.fileCnt  = getFieldValue($("input[name=fileCnt]"));	
    n0201VOMap.delFileIds  = getFieldValue($("input[name=delFileIds]"));	
	return true;
	
}

//초기화
function initN0201VOMap(){
	n0201VOMap = {
			cmctDtaBkNum : ""		//포렌식지원일련번호
			,cmctDtaSbjt : ""	//포렌식지원발행년도
			,moblPhonNum : ""			//연번
			,cmctCmpyCd : ""			//매체연번
		}                           
}


//포렌식
var n0201VOMap = {
		cmctDtaBkNum : ""		//포렌식지원일련번호
		,cmctDtaSbjt : ""	//포렌식지원발행년도
		,moblPhonNum : ""			//연번
		,cmctCmpyCd : ""			//매체연번
		,cmctDtaFileVOList : null
}

//초기화
function initN0201SCMap(){
	n0201SCMap = {
		cmctCmpyCd : ""	//금융코드
		,cmctDtaSbjt : ""	//제목
		,moblPhonNum : ""	// 영장대상 계좌번호
	}
}

//검색조건
var n0201SCMap = {
	cmctCmpyCd : ""	//금융코드
	,cmctDtaSbjt : ""	//제목
	,moblPhonNum : ""	// 영장대상 계좌번호
}

//리포트맵
var n0201RTMap = {
	rexdataset : null
}
