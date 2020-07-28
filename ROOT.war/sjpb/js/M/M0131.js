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
	
	fn_M0131_pageInit();  

	if(parent.viewType == 'inc'){
		//피의자 검색버튼
		$("#spBtn").off("click").on("click", function() {	
			commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face?rcptNum='+incMap.rcptNum, "1050px", "435px", callBackFn_M0131_searchIncSpSuccess);
		});
	}
	
});
//화면 진입시 동작함
function fn_M0131_pageInit(){
	qCellList=[];
	
	queryString=$("#m0131_searchList").serialize();

	var d = document.m0131_searchList;
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
	goAjax("/sjpb/M/M0131selectList.face",queryString,callBackFn_M0131_selectListSuccess,true);
}
//지명수배 및 통보대장 리스트 그리기.
function callBackFn_M0131_selectListSuccess(data){	

	if(data.qCell ==''|| data.qCell==' '){
		if(parent.viewType == 'inc'){
			fn_M0131_new();
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
            	{width: '20%',	key: 'rcptIncNum',			title: ['사건번호','사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'nmKor',			title: ['작성자','작성자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'incTrfReq',			title: ['사건송치','청자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'incTrfDt',			title: ['사건송치','일자'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'incTrfNum',			title: ['사건송치','번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'wantDt',			title: ['수배번호','일자'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'wantNum',			title: ['수배번호','번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'wantCoprDt',			title: ['수배번호','공조일자'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'wantCoprNum',			title: ['수배번호','공조번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '4%',	key: 'spNm',			title: ['피의자','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '4%',	key: 'age',			title: ['피의자','연령'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '4%',	key: 'gendDivDesc',			title: ['피의자','성별'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '4%',	key: 'spIdNum',			title: ['피의자','주민등록번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'criNm',			title: ['죄명','죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'idctPiDt',			title: ['공소시효만료일자','공소시효만료일자'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'homtAddr',			title: ['연고지 수사상황','등록기준지 또는 주소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'homtBulnCont',			title: ['연고지 수사상황','회보내용'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'wantRelsRsn',			title: ['수배해제','사유'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'wantRelsDt',			title: ['수배해제','일자'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '5%',	key: 'wantRelsNum',			title: ['수배해제','번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}


            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(2, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0131VOMap = qcell.getRowData(2);
	    	fn_M0131_selectSetting();
	    	//수정세팅
	    	updateYN();
		}
}

//지명수배 및 통보대장 셀클릭 이벤트
function eventFn(e){
	// 선택한 인덱스 가져오기
	var colIdx = qcell.getIdx("col");
	rowIdx = qcell.getIdx("row");	

	if(colIdx >0 && rowIdx > 0){
		if(colIdx != 1){
			qcell.clearCellStyles();
			qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
			
			freezeInput(true); // 입력 비활성화
			fn_M0131_initM0131VOMap(); // 맵초기화
			m0131VOMap = qcell.getRowData(rowIdx);
		
			//지명수배 및 통보대장 데이터 세팅
			fn_M0131_selectSetting();
			//수정세팅
			updateYN();
		}
	}
	
}

//지명수배 및 통보대장 데이터 세팅
function fn_M0131_selectSetting(){	

	getAreaMap($("#M0131"), m0131VOMap);
	$("#incSpNum").val(m0131VOMap.incSpNum);	
	$("#rcptNum").val(m0131VOMap.rcptNum);
	$("#spNm").html(m0131VOMap.spNm);
	$("#wantNum").html(m0131VOMap.wantNum);
}

//사건검색 성공함수
function callBackFn_M0131_searchIncSpSuccess(data){
	$("#incSpNum").val(data.incSpNum);
	$("input[name=spNm]").val(Base64.decode(data.spNm));						// 피의자 성명 출력
	$("#spIdNum").html(Base64.decode(data.spIdNum));							// 피의자 주민등록번호 출력

	spIdNumDivision(Base64.decode(data.spIdNum));  // 개인정보 세팅
}
//개인정보 세팅
function spIdNumDivision(spIdNum){
	var num = (spIdNum).substring(8,7); //구별자
	var age = (spIdNum).substring(0,2); // 태어난 년도
	var year = new Date().getFullYear(); //현재년도
	//성별구분
	if(num == '1' || num == '3' || num == '5' || num == '7'){
		$("#gendDivDesc").html("남성");
	}else if(num == '2' || num == '4' || num == '6' || num == '8'){
		$("#gendDivDesc").html("여성");
	}else{
		$("#gendDivDesc").html("");
	}
	//나이 세팅
	if(num == '1' || num == '2' || num == '5' || num == '6'){
		$("#age").html((year-(1900+parseInt(age))+1)+"세");
	}else if(num == '3' || num == '4' || num == '7' || num == '8'){
		$("#age").html((year-(2000+parseInt(age))+1)+"세");
	}else{
		$("#age").html("");
	}
}
//수정 가능 버튼 보이기 여부
function updateYN(){
	if(parent.viewType == 'inc'){
		if(m0131VOMap.regUserId == $("#userId").val() ){
			freezeInput(false); // 입력 활성화
			$("#btnUpdate").show();  //수정버튼 보이기
			$("#btnSearchInc").show(); // 검색버튼보이기
			
		}else{
			freezeInput(true); // 입력 비활성화
			$("#btnUpdate").hide();  //수정버튼 숨기기
	
		}
		$("#btnInsert").hide();  //저장버튼 숨기기
	}
}

//맵초기화
function fn_M0131_initM0131VOMap() {
	m0131VOMap={
			"apptWantNotcNum":""
			,"incSpNum":""
			,"rcptNum":""
			,"incTrfReq":""
			,"incTrfDt":""
			,"incTrfNum":""
			,"wantDt":""
			,"wantNum":""
			,"wantCoprDt":""
			,"wantCoprNum":""
			,"spNm":""
			,"spIdNum":""
			,"gendDivDesc":""
			,"age":""
			,"criNm":""
			,"idctPiDt":""
			,"homtAddr":""
			,"homtBulnCont":""
			,"wantRelsRsn":""
			,"wantRelsDt":""
			,"wantRelsNum":""
			,"regUserId":""
	}
}

//신규등록
function fn_M0131_new(){

	fn_M0131_initM0131VOMap(); //맵초기화
	fn_M0131_selectSetting(); // 데이터 세팅
	$("#rcptNum").val(incMap.rcptNum); // 접수번호 세팅
	$("#age").html("(피의자 선택시 자동 입력)");
	$("#gendDivDesc").html("(피의자 선택시 자동 입력)");
	$("#spIdNum").html("(피의자 선택시 자동 입력)");
	$("#wantNum").html("(자동 입력)");
	
	freezeInput(false); // 입력 활성화
	
	$("#btnSearchInc").show(); // 검색버튼보이기
	$("#btnInsert").show(); // 저장버튼 보이기	
	$("#btnUpdate").hide(); // 수정버튼 숨기기	
	
}
//등록하기
function fn_M0131_insert(){
	
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
		return;
	}
	
	//유효성검사
	setAreaMap($("#M0131"), m0131VOMap);
	m0131VOMap.rcptNum = $("#rcptNum").val();
	m0131VOMap.incSpNum = $("#incSpNum").val();
	
	
	if(m0131VOMap.incSpNum == null || m0131VOMap.incSpNum == "" || m0131VOMap.incSpNum ==" "){
		alert("피의자를 선택해주세요.");
		return;
	}

	goAjaxDefault("/sjpb/M/M0131insert.face",m0131VOMap,callBackFn_M0131_insertSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsertPern").hide(); //저장버튼 숨기기

}

//등록성공함수 호출
function callBackFn_M0131_insertSuccess(data){
	
	if(data == 1){
		alert("지명수배 및 통보대장이 등록되었습니다.");
	}else{
		alert("지명수배 및 통보대장 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0131_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0131_update(){
	
	setAreaMap($("#M0131"), m0131VOMap);
	m0131VOMap.rcptNum = $("#rcptNum").val();
	m0131VOMap.incSpNum = $("#incSpNum").val();
	
	goAjaxDefault("/sjpb/M/M0131update.face",m0131VOMap,callBackFn_M0131_updateSuccess);
}
//수정성공함수 호출
function callBackFn_M0131_updateSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0131_pageInit();
	freezeInput(true); // 입력 비활성화
}

//지명수배 및 통보대장 출력
function fn_M0131_prnCheckReport() {
	var apptWantNotcNumList = [];
	for(var i = 2; i <= qcell.getRows("data")+1; i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			apptWantNotcNumList.push(qcell.getRowData(i).apptWantNotcNum);
		}	
	}
	var apptWantNotcNumListMap = {
			"apptWantNotcNumList":apptWantNotcNumList
	}
	
	if(apptWantNotcNumList.length != 0){
		//지명수배 및 통보대장 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0131prnCheckReport.face",apptWantNotcNumListMap,callBackFn_M0131_prnCheckReportSuccess);
	}else{
		alert("출력할 대상을 선택해주세요.");
		return;
	}
	
}
//지명수배 및 통보대장 출력 성공함수
function callBackFn_M0131_prnCheckReportSuccess(data){
	M0131RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0131RTMap);
	$("#reptNm").val("M0131.crf"); //레포트 파일명
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
var m0131VOMap={
			"apptWantNotcNum":""
			,"incSpNum":""
			,"rcptNum":""
			,"incTrfReq":""
			,"incTrfDt":""
			,"incTrfNum":""
			,"wantDt":""
			,"wantNum":""
			,"wantCoprDt":""
			,"wantCoprNum":""
			,"spNm":""
			,"spIdNum":""
			,"gendDivDesc":""
			,"age":""
			,"criNm":""
			,"idctPiDt":""
			,"homtAddr":""
			,"homtBulnCont":""
			,"wantRelsRsn":""
			,"wantRelsDt":""
			,"wantRelsNum":""
			,"regUserId":""
}
//리포트맵
var M0131RTMap = {
	rexdataset : null
}