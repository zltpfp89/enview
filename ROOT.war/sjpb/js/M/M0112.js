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
	
	fn_M0112_pageInit();  
});
//화면 진입시 동작함
function fn_M0112_pageInit(){
	qCellList=[];
	queryString=$("#m0112_searchList").serialize();
	
	var d = document.m0112_searchList;
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
	
	goAjax("/sjpb/M/M0112selectList.face",queryString,callBackFn_M0112_selectListSuccess,true);
}
//체포구속인접견부 리스트 그리기.
function callBackFn_M0112_selectListSuccess(data){	

	if(data.qCell ==''|| data.qCell==' '){
		if(parent.viewType == 'inc'){
			fn_M0112_new();
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
            	{width: '5%',	key: 'checkbox',			title: ['',''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '12%',	key: 'cstdPernNum',			title: ['유치인번호','유치인번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '15%',	key: 'rcptIncNum',			title: ['사건번호','사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'nmKor',			title: ['작성자','작성자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'rcpnReqDocNm',			title: ['접견신청서','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'rcpnReqDocAddr',			title: ['접견신청서','주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'cstdPernRelt',			title: ['유치인과의 관계','유치인과의 관계'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'rcpnDt',			title: ['접견일시','접견일시'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'cvstGist',			title: ['담화의 요지','담화의 요지'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '9%',	key: 'cathArstRcpnComn',			title: ['비고','비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '11%',	key: 'prscOffi',			title: ['입회관','입회관'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.clearCellStyles();
	    	qcell.setRowStyle(2, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0112VOMap = qcell.getRowData(2);
	    	fn_M0112_selectSetting();
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
			
			freezeInput(true); // 입력 비활성화
			fn_M0112_initM0112VOMap(); // 맵초기화
			m0112VOMap = qcell.getRowData(rowIdx);
		
			//체포구속인접견부 데이터 세팅
			fn_M0112_selectSetting();
			//수정세팅
			updateYN();
		}
	}
}
//체포구속인접견부 데이터 세팅
function fn_M0112_selectSetting(){	

	getAreaMap($("#M0112"), m0112VOMap);
	$("#incNum").html(m0112VOMap.rcptIncNum);
	$("#spNm").empty();
	$("#spNm").html("("+m0112VOMap.spNm+")");
	$("#incSpNum").val(m0112VOMap.incSpNum);	
	$("#rcptNum").val(m0112VOMap.rcptNum);
	$("#incNum").html(m0112VOMap.rcptIncNum);
	
}

//사건검색 팝업창
function fn_M0112_searchIncSp(){
	commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face?rcptNum='+incMap.rcptNum, "1050px", "550px", callBackFn_M0112_searchIncSpSuccess);
}

//사건검색 성공함수
function callBackFn_M0112_searchIncSpSuccess(data){
	$("#incSpNum").val(data.incSpNum);
	$("#spNm").html("("+Base64.decode(data.spNm)+")");  // 피의자 성명 출력
}

//수정 가능 버튼 보이기 여부
function updateYN(){
	if(parent.viewType == 'inc'){
		if(m0112VOMap.regUserId == $("#userId").val() ){
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



//맵초기화
function fn_M0112_initM0112VOMap() {
	m0112VOMap={
			"cathArstRcpnNum":""
			,"rcptNum":""
			,"rcptIncNum":""
			,"incSpNum":""
			,"cstdPernNum":""
			,"spNm":""
			,"rcpnReqDocNm":""
			,"rcpnReqDocAddr":""
			,"cstdPernRelt":""
			,"rcpnDt":""
			,"cvstGist":""
			,"cathArstRcpnComn":""
			,"prscOffi":""
			,"regUserId":""
			,"nmKor":""
	}
}

//신규등록
function fn_M0112_new(){

	fn_M0112_initM0112VOMap(); //맵초기화
	fn_M0112_selectSetting(); // 데이터 세팅	
	$("#cstdPernNum").html(incMap.rcptIncNum); //유치인번호 -> 사건번호 세팅
	$("#rcptNum").val(incMap.rcptNum); // 접수번호 세팅
	$("#spNm").html("(피의자를 선택해주세요.)");
	
	freezeInput(false); // 입력 활성화
	
	$("#btnInsert").show(); // 저장버튼 보이기	
	$("#btnUpdate").hide(); // 수정버튼 숨기기	
	$("#btnSearchInc").show(); // 검색버튼 숨기기	
	
}
//등록하기
function fn_M0112_insert(){

	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
		return;
	}
	
	setAreaMap($("#M0112"), m0112VOMap);
	m0112VOMap.rcptNum = $("#rcptNum").val();
	m0112VOMap.incSpNum = $("#incSpNum").val();
	m0112VOMap.cstdPernNum = $("#cstdPernNum").html();

	if(m0112VOMap.incSpNum == null || m0112VOMap.incSpNum == "" || m0112VOMap.incSpNum ==" "){
		alert("피의자를 선택해주세요.");
		return;
	}

	goAjaxDefault("/sjpb/M/M0112insert.face",m0112VOMap,callBackFn_M0112_insertSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsertPern").hide(); //저장버튼 숨기기

}

//등록성공함수 호출
function callBackFn_M0112_insertSuccess(data){
	
	if(data == 1){
		alert("체포구속인접견부가 등록되었습니다.");
	}else{
		alert("체포구속인접견부 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0112_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0112_update(){
	
	setAreaMap($("#M0112"), m0112VOMap);
	m0112VOMap.rcptNum = $("#rcptNum").val();
	m0112VOMap.incSpNum = $("#incSpNum").val();
	m0112VOMap.rcptIncNum = $("#incNum").html();
	
	goAjaxDefault("/sjpb/M/M0112update.face",m0112VOMap,callBackFn_M0112_updateSuccess);
}
//수정성공함수 호출
function callBackFn_M0112_updateSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0112_pageInit();
	freezeInput(true); // 입력 비활성화
}
//체포,구속인접견부 출력
function fn_M0112_prnCheckReport() {
	var cathArstRcpnNumList = [];
	for(var i = 2; i <= qcell.getRows("data")+1; i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			cathArstRcpnNumList.push(qcell.getRowData(i).cathArstRcpnNum);
		}	
	}
	var cathArstRcpnNumListMap = {
			"cathArstRcpnNumList":cathArstRcpnNumList
	}
	
	if(cathArstRcpnNumList.length != 0){
		//체포,구속인접견부 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0112prnCheckReport.face", cathArstRcpnNumListMap, callBackFn_M0112_prnCheckReportSuccess);
	}else{
		alert("출력할 대상을 선택해주세요.");
		return;
	}
	
}

//체포,구속인접견부 출력 성공함수
function callBackFn_M0112_prnCheckReportSuccess(data){
	M0112RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0112RTMap);
	$("#reptNm").val("M0112.crf"); //레포트 파일명
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
var m0112VOMap={
		"cathArstRcpnNum":""
		,"rcptNum":""
		,"rcptIncNum":""
		,"incSpNum":""
		,"cstdPernNum":""
		,"spNm":""
		,"rcpnReqDocNm":""
		,"rcpnReqDocAddr":""
		,"cstdPernRelt":""
		,"rcpnDt":""
		,"cvstGist":""
		,"cathArstRcpnComn":""
		,"prscOffi":""
		,"regUserId":""
		,"nmKor":""
}
//리포트맵
var M0112RTMap = {
	rexdataset : null
}