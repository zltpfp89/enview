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
	fn_M0102_pageInit();

	  
});
//화면 진입시 동작함
function fn_M0102_pageInit(){
	qCellList=[];
	queryString = $("#m0102_searchList").serialize();
	var d = document.m0102_searchList;
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
	goAjax("/sjpb/M/M0102selectList.face",queryString,callBackFn_M0102_selectListSuccess);
}
//압수부 리스트 그리기.
function callBackFn_M0102_selectListSuccess(data){	

	if(data.qCell ==''|| data.qCell==' '){
		if(parent.viewType == 'inc'){
			fn_M0102_new();
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
            	{width: '5%',	key: 'checkbox',			title: ['','']},
            	{width: '7%',	key: 'seizBkNum',			title: ['번호','압수부'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '7%',	key: 'seizProdNum',			title: ['번호','압수물'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'rcptIncNum',			title: ['범죄사건부번호','범죄사건부번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '7%',	key: 'seizDt',	type:"input",			title: ['압수연월일','압수연월일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'},options : {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}},
            	{width: '7%',	key: 'seizProdKind',	type:"input",			title: ['압수물건','품종'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '7%',	key: 'seizProdQnty',	type:"input",			title: ['압수물건','수량'], options:{limit:'number'},		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '8%',	key: 'ownrNm',	type:"input",			title: ['소유자의 주거성명','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},	                	
            	{width: '8%',	key: 'ownrAddr',	type:"input",			title: ['소유자의 주거성명','주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},	                	
            	{width: '8%',	key: 'revIpdrNm',	type:"input",			title: ['피압수자의 주거성명','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},	                	
            	{width: '8%',	key: 'revIpdrAddr',	type:"input",			title: ['피압수자의 주거성명','주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},	                	
            	{width: '8%',	key: 'csdnNm',	type:"input",			title: ['보관자 확인','보관자 확인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},               	
            	{width: '8%',	key: 'trsrNm',		type:"input",		title: ['취급자확인','취급자확인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},             	
            	{width: '7%',	key: 'dipDt',	type:"input",			title: ['처분','연월일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'},options : {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}} },            	
            	{width: '7%',	key: 'dipGist',	type:"input",			title: ['처분','요지'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}} ,          	
            	{width: '7%',	key: 'seizBkComn',	type:"input",			title: ['비고','비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}
            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(2, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0102VOMap = qcell.getRowData(2);
	    	fn_M0102_selectSetting();
	    	//수정세팅
	    	updateYN();

		}
}
//구속영장신청부 셀클릭 이벤트
function eventFn(e){
	var colIdx = qcell.getIdx("col");
	
	// 선택한 인덱스 가져오기
	rowIdx = qcell.getIdx("row");	

	if(colIdx >0 && rowIdx > 0){
		if(colIdx != 1){
			if(rowIdx == null){
				rowIdx = 2;//초기값 설정
			}
			//기존 체크박스 열번호
			var pastchk = qcell.getIdx("row","focus","previous") == -1?2:qcell.getIdx("row","focus","previous");
			
			//기존 체크항목 해제
			qcell.removeRowStyle(pastchk);
		
			//새로 선택한 행 스타일적용
			qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
			
			freezeInput(true); // 입력 비활성화
			fn_M0102_initM0102VOMap(); // 맵초기화
			m0102VOMap = qcell.getRowData(rowIdx);
			
			//압수부 데이터 세팅
			fn_M0102_selectSetting();
			
			//수정세팅
			updateYN();
		}
	}
}
//압수부 데이터 세팅
function fn_M0102_selectSetting(){
	
	getAreaMap($("#M0102"), m0102VOMap);
	$("#incNum").html(m0102VOMap.rcptIncNum);
	$("#rcptNum").val(m0102VOMap.rcptNum);
	$("#seizProdQnty").val(m0102VOMap.seizProdQnty);
}

function updateYN(){
	if(parent.viewType == "inc"){
		if(m0102VOMap.regUserId == $("#userId").val() ){
			freezeInput(false); // 입력 활성화
			$("#btnUpdate").show();  //수정버튼 보이기
			$("#btnSearchInc").show(); // 검색버튼보이기
		}else{
			freezeInput(true); // 입력 비활성화
			$("#btnUpdate").hide();  //수정버튼 숨기기
			$("#btnSearchInc").hide(); // 검색버튼숨기기
		}
		$("#btnInsert").hide();  //저장버튼 숨기기
	}
}

//맵초기화
function fn_M0102_initM0102VOMap() {
	m0102VOMap={
			"seizBkSiNum":""
			,"seizBkNum":""
			,"seizProdNum":""
			,"rcptIncNum":""
			,"rcptNum":""
			,"seizDt":""
			,"seizProdKind":""
			,"seizProdQnty":""
			,"ownrNm":""
			,"ownrAddr":""
			,"revIpdrNm":""
			,"revIpdrAddr":""
			,"csdnNm":""
			,"trsrNm":""
			,"dipDt":""
			,"dipGist":""
			,"seizBkComn":""
			,"regUserId":""
	}
}


//신규등록
function fn_M0102_new(){

	fn_M0102_initM0102VOMap(); //맵초기화
	fn_M0102_selectSetting(); // 데이터 세팅	
	$("#incNum").html(incMap.rcptIncNum);
	$("#rcptNum").val(incMap.rcptNum);
	$("#seizProdQnty").val();
	
	freezeInput(false); // 입력 활성화
	
	$("#btnInsert").show(); // 저장버튼 보이기	
	$("#btnUpdate").hide(); // 수정버튼 숨기기	
	
}
//등록하기
function fn_M0102_insert(){
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
		return;
	}
	
	setAreaMap($("#M0102"), m0102VOMap);
	m0102VOMap.rcptIncNum = $("#incNum").html();
	m0102VOMap.rcptNum = $("#rcptNum").val();
	m0102VOMap.seizBkSiNum = $("#seizBkSiNum").val();
	m0102VOMap.seizProdQnty = $("#seizProdQnty").val();
	
	goAjaxDefault("/sjpb/M/M0102insert.face",m0102VOMap,callBackFn_M0102_insertSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsert").hide(); //저장버튼 숨기기
	
}
//등록 성공함수
function callBackFn_M0102_insertSuccess(data){
	if(data == 1){
		alert("압수부가 등록되었습니다.");
	}else{
		alert("압수부 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0102_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0102_update(){
	setAreaMap($("#M0102"), m0102VOMap);
	m0102VOMap.rcptIncNum = $("#incNum").html();
	m0102VOMap.rcptNum = $("#rcptNum").val();
	m0102VOMap.seizBkSiNum = $("#seizBkSiNum").val();
	m0102VOMap.seizProdQnty = $("#seizProdQnty").val();

	goAjaxDefault("/sjpb/M/M0102update.face",m0102VOMap,callBackFn_M0102_updateSuccess);
}
//수정성공함수
function callBackFn_M0102_updateSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0102_pageInit();
	freezeInput(true); // 입력 비활성화
}
//압수부 출력
function fn_M0102_prtCheckReport() {
	var seizBkSiNumList = [];
	for(var i = 2; i <= qcell.getRows("data")+1; i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			seizBkSiNumList.push(qcell.getRowData(i).seizBkSiNum);
		}	
	}
	var seizBkSiNumListMap = {
			"seizBkSiNumList":seizBkSiNumList
	}
	
	if(seizBkSiNumList.length != 0){
		//압수부 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0102prnCheckReport.face", seizBkSiNumListMap, callBackFn_M0102_prtCheckReportSuccess);
	}else{
		alert("출력할 대상을 선택해주세요.");
		return;
	}
}
//압수부 출력 성공함수
function callBackFn_M0102_prtCheckReportSuccess(data){
	M0102RTMap.rexdataset = data.rexdataset;
	
	var xmlString = objectToXml(M0102RTMap);
	$("#reptNm").val("M0102.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	//레포트 호출
	openReportService(reportForm); 
}
//입력화면 비/활성화
function freezeInput(tf) {
	$("#contentsArea input").attr("disabled",tf);
	$("#contentsArea select").attr("disabled",tf);
	//$("#contentsArea a").attr("disabled",tf);
}

var m0102VOMap={
		"seizBkSiNum":""
		,"seizBkNum":""
		,"seizProdNum":""
		,"rcptIncNum":""
		,"rcptNum":""
		,"seizDt":""
		,"seizProdKind":""
		,"seizProdQnty":""
		,"ownrNm":""
		,"ownrAddr":""
		,"revIpdrNm":""
		,"revIpdrAddr":""
		,"csdnNm":""
		,"trsrNm":""
		,"dipDt":""
		,"dipGist":""
		,"seizBkComn":""	
		,"regUserId":""
}
//리포트맵
var M0102RTMap = {
	rexdataset : null
}

//압수부 엑셀 파일 업로드
function uploadSeizExcelData(){
	ekrFile.setForm();
	
	var fileMap = {
				"fileId" : getFieldValue($("input[name=fileId]"))          ,
				"fileNm" : getFieldValue($("input[name=fileNm]"))          ,
				"fileSize" : getFieldValue($("input[name=fileSize]"))	   ,
				"fileType" : getFieldValue($("input[name=fileType]"))	   ,
				"filePath" : getFieldValue($("input[name=filePath]"))	   ,
				"fileCtype" : getFieldValue($("input[name=fileCtype]"))	   ,
				"fileCnt" : getFieldValue($("input[name=fileCnt]"))	       ,
				"delFileIds": getFieldValue($("input[name=delFileIds]"))	
				};

	goAjax("/sjpb/M/insertSeizDtaDtl.face", fileMap, callBackUplodateSeizExcelDataSuccess);
}

function callBackUplodateSeizExcelDataSuccess(){
	//selectList();
	ekrFile.fileUploadCallback();
	//insertSeizExcelUploadViewCloseBtn();
	//페이지 리셋
	fn_M0102_pageInit();
	freezeInput(true); // 입력 비활성화
}