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
	fn_M0113_pageInit();  
});
//화면 진입시 동작함
function fn_M0113_pageInit(){
	qCellList=[];
	
	queryString=$("#m0113_searchList").serialize();
	var d = document.m0113_searchList;
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
	
	goAjax("/sjpb/M/M0113selectList.face",queryString,callBackFn_M0113_selectListSuccess,true);
}
//체포구속인접견부 리스트 그리기.
function callBackFn_M0113_selectListSuccess(data){	

	if(data.qCell ==''|| data.qCell==' '){
		if(parent.viewType == 'inc'){
			fn_M0113_new();
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
            	{width: '10%',	key: 'cstdPernNum',			title: ['유치인번호','유치인번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '15%',	key: 'rcptIncNum',			title: ['사건번호','사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'nmKor',			title: ['작성자','작성자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'rcpnReqPersNm',			title: ['접견신청서','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'rcpnReqPersAddr',			title: ['접견신청서','주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'cstdPersRelt',			title: ['유치인과의 관계','유치인과의 관계'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '11%',	key: 'careDiv',			title: ['수발의 구별','수발의 구별'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '11%',	key: 'trptDt',			title: ['교통일시','교통일시'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '11%',	key: 'letrContGist',			title: ['서신내용의 요지','서신내용의 요지'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '6%',	key: 'cathArstTrptComn',			title: ['비고','비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '11%',	key: 'handOffi',			title: ['취급자','취급자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(2, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0113VOMap = qcell.getRowData(2);
	    	fn_M0113_selectSetting();
	    	//수정세팅
	    	updateYN();
		}
}
//체포구속인 접견부 셀클릭 이벤트
function eventFn(e){
	// 선택한 인덱스 가져오기
	var colIdx = qcell.getIdx("col");
	rowIdx = qcell.getIdx("row");	

	if(colIdx >0 && rowIdx > 0){
		if(colIdx != 1){
			qcell.clearCellStyles();
			qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");	
			
			freezeInput(true); // 입력 비활성화
			fn_M0113_initM0113VOMap(); // 맵초기화
			m0113VOMap = qcell.getRowData(rowIdx);
		
			//체포구속인접견부 데이터 세팅
			fn_M0113_selectSetting();
			//수정세팅
			updateYN();
		}
	}
}
//체포구속인접견부 데이터 세팅
function fn_M0113_selectSetting(){	

	getAreaMap($("#M0113"), m0113VOMap);
	$("#incNum").html(m0113VOMap.rcptIncNum);
	$("#spNm").empty();
	$("#spNm").html("("+m0113VOMap.spNm+")");
	$("#incSpNum").val(m0113VOMap.incSpNum);	
	$("#rcptNum").val(m0113VOMap.rcptNum);
	$("#incNum").html(m0113VOMap.rcptIncNum);
	
}
//수정 가능 버튼 보이기 여부
function updateYN(){
	if(parent.viewType == 'inc'){
		if(m0113VOMap.regUserId == $("#userId").val() ){
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
//사건검색 팝업창
function fn_M0113_searchIncSp(){
	commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face?rcptNum='+incMap.rcptNum, "1050px", "550px", callBackFn_M0113_searchIncSpSuccess);
}

//사건검색 성공함수
function callBackFn_M0113_searchIncSpSuccess(data){
	$("#incSpNum").val(data.incSpNum);
	$("#spNm").html("("+Base64.decode(data.spNm)+")");  // 피의자 성명 출력
}

//맵초기화
function fn_M0113_initM0113VOMap() {
	m0113VOMap={
			"cathArstTrptNum":""
			,"rcptNum":""
			,"rcptIncNum":""
			,"incSpNum":""
			,"cstdPernNum":""
			,"spNm":""
			,"rcpnReqPersNm":""
			,"rcpnReqPersAddr":""
			,"cstdPersRelt":""
			,"careDiv":""
			,"trptDt":""
			,"letrContGist":""
			,"cathArstTrptComn":""
			,"handOffi":""
			,"regUserId":""
			,"nmKor":""
	}
}

//신규등록
function fn_M0113_new(){

	fn_M0113_initM0113VOMap(); //맵초기화
	fn_M0113_selectSetting(); // 데이터 세팅	
	$("#cstdPernNum").html(incMap.rcptIncNum); //유치인번호 -> 사건번호 세팅
	$("#rcptNum").val(incMap.rcptNum); // 접수번호 세팅
	$("#spNm").html("(피의자를 선택해주세요.)");
	
	freezeInput(false); // 입력 활성화
	
	$("#btnInsert").show(); // 저장버튼 보이기	
	$("#btnUpdate").hide(); // 수정버튼 숨기기	
	$("#btnSearchInc").show(); // 검색버튼 숨기기	
	
}
//등록하기
function fn_M0113_insert(){

	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
		return;
	}
	
	setAreaMap($("#M0113"), m0113VOMap);
	m0113VOMap.rcptNum = $("#rcptNum").val();
	m0113VOMap.incSpNum = $("#incSpNum").val();
	m0113VOMap.cstdPernNum = $("#cstdPernNum").html();

	if(m0113VOMap.incSpNum == null || m0113VOMap.incSpNum == "" || m0113VOMap.incSpNum ==" "){
		alert("피의자를 선택해주세요.");
		return;
	}
	
	goAjaxDefault("/sjpb/M/M0113insert.face",m0113VOMap,callBackFn_M0113_insertSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsertPern").hide(); //저장버튼 숨기기

}

//등록성공함수 호출
function callBackFn_M0113_insertSuccess(data){
	
	if(data == 1){
		alert("체포구속인교통부가 등록되었습니다.");
	}else{
		alert("체포구속인교통부 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0113_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0113_update(){
	
	setAreaMap($("#M0113"), m0113VOMap);
	m0113VOMap.rcptNum = $("#rcptNum").val();
	m0113VOMap.incSpNum = $("#incSpNum").val();
	m0113VOMap.rcptIncNum = $("#incNum").html();
	
	goAjaxDefault("/sjpb/M/M0113update.face",m0113VOMap,callBackFn_M0113_updateSuccess);
}
//수정성공함수 호출
function callBackFn_M0113_updateSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0113_pageInit();
	freezeInput(true); // 입력 비활성화
}
//체포구속인접견부 출력
function fn_M0113_prnCheckReport() {
	var cathArstTrptNumList = [];
	for(var i = 2; i <= qcell.getRows("data")+1; i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			cathArstTrptNumList.push(qcell.getRowData(i).cathArstTrptNum);
		}	
	}
	var cathArstTrptNumListMap = {
			"cathArstTrptNumList":cathArstTrptNumList
	}
	
	if(cathArstTrptNumList.length != 0){
		//체포구속인접견부 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0113prnCheckReport.face", cathArstTrptNumListMap, callBackFn_M0113_prnCheckReportSuccess);
	}else{
		alert("출력할 대상을 선택해주세요.");
		return;
	}
	
}

//체포구속인접견부 출력 성공함수
function callBackFn_M0113_prnCheckReportSuccess(data){
	M0113RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0113RTMap);
	$("#reptNm").val("M0113.crf"); //레포트 파일명
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
var m0113VOMap={
		"cathArstTrptNum":""
		,"rcptNum":""
		,"rcptIncNum":""
		,"incSpNum":""
		,"cstdPernNum":""
		,"spNm":""
		,"rcpnReqPersNm":""
		,"rcpnReqPersAddr":""
		,"cstdPersRelt":""
		,"careDiv":""
		,"trptDt":""
		,"letrContGist":""
		,"cathArstTrptComn":""
		,"handOffi":""
		,"regUserId":""
		,"nmKor":""
}
//리포트맵
var M0113RTMap = {
	rexdataset : null
}