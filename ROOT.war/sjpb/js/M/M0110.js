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
	
	fn_M0110_pageInit();  
	
	$('#atdcPersDiv').change(function(){
   		if( $('#atdcPersDiv option:selected').val() == "01"){ //피의자
   			$("#atdcPersNm").hide();
   			$("#spDiv").show();
   			$("#refeDiv").hide();
   		}else if( $('#atdcPersDiv option:selected').val() == "02"){ //참고인
   			$("#atdcPersNm").hide();
   			$("#spDiv").hide();
   			$("#refeDiv").show();
   		}else{
   			$("#atdcPersNm").show();
   			$("#spDiv").hide();
   			$("#refeDiv").hide();
   		}

 	});
	
	if(parent.viewType == 'inc'){
		//피의자 검색버튼
		$("#spBtn").off("click").on("click", function() {	
			commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face?rcptNum='+incMap.rcptNum, "1050px", "435px", callBackFn_M0110_searchIncSpSuccess);
		});
	}

});
//화면 진입시 동작함
function fn_M0110_pageInit(){
	qCellList=[];
	
	queryString=$("#m0110_searchList").serialize();
	//검색조건 노출
	//사건에서 보여질 경우, 사건에 필요한것만 노출 (본인데이터만)
	if(parent.viewType == 'inc'){
		queryString += "&rcptNumSc="+incMap.rcptNum;
	}
	goAjax("/sjpb/M/M0110selectList.face",queryString,callBackFn_M0110_selectListSuccess,true);
}
//출석요구통지부 리스트 그리기.
function callBackFn_M0110_selectListSuccess(data){	

	if(data.qCell ==''|| data.qCell==' '){
		if(parent.viewType == 'inc'){
			fn_M0110_newAtdcReq();
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
            	{width: '5%',	key: 'checkbox',			title: [''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '12%',	key: 'docNum',			title: ['문서번호','문서번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'rcptIncNum',			title: ['사건번호','사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'atdcReqDt',			title: ['출석요구일시','출석요구일시'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'atdcPersDivDesc',			title: ['출석자','구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'atdcPersNm',			title: ['출석자','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'incPoint',			title: ['사건의 요지','사건의 요지'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'reqDocs',			title: ['구비서류 등','구비서류 등'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'nmKor',			title: ['작성자','작성자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'atdcReqNotcDt',			title: ['출석요구통지','통지일'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'atdcReqNotcWayDesc',			title: ['출석요구통지','방법'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '11%',	key: 'atdcReqRst',			title: ['결과','결과'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'atdcReqRespMb',			title: ['담당자확인','담당자확인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(2, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0110VOMap = qcell.getRowData(2);
	    	fn_M0110_selectAtdcReqSetting();
	    	//수정세팅
	    	updateYN();
		}
}
//출석요구통지부 셀클릭 이벤트
function eventFn(e){

	// 선택한 인덱스 가져오기
	var colIdx = qcell.getIdx("col");
	rowIdx = qcell.getIdx("row");	

	if(colIdx >0 && rowIdx > 0){
		if(colIdx != 1){
			//기존 체크박스 열번호
			var pastchk = qcell.getIdx("row","focus","previous") == -1?2:qcell.getIdx("row","focus","previous");
			
			//기존 체크항목 해제
			qcell.removeRowStyle(pastchk);
		
			//새로 선택한 행 스타일적용
			qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
			
			freezeInput(true); // 입력 비활성화
			fn_M0110_initM0110VOMap(); // 맵초기화
			m0110VOMap = qcell.getRowData(rowIdx);
			$("#afterDiv").show();
			//출석요구통지부 데이터 세팅
			fn_M0110_selectAtdcReqSetting();
			//수정세팅
			updateYN();
		}
	}
}
//출석요구통지부 데이터 세팅
function fn_M0110_selectAtdcReqSetting(){	

	getAreaMap($("#M0110AtdcReq"), m0110VOMap);
	$("#incNum").html(m0110VOMap.rcptIncNum);
	$("#spNm").html(m0110VOMap.spNm);
	$("#divCdCath").val(m0110VOMap.divCd);
	$("#incSpNum").val(m0110VOMap.incSpNum);	
	$("#rcptNum").val(m0110VOMap.rcptNum);
	$("#incNum").html(m0110VOMap.rcptIncNum);
//	$("#atdcPersNm").html(m0110VOMap.atdcPersNm);

	setFieldValue($("#atdcPersDiv"), m0110VOMap.atdcPersDiv);
	if( m0110VOMap.atdcPersDiv == "01"){ //피의자
			$("#atdcPersNm").hide();
			$("#spDiv").show();
			$("#spNm").val(m0110VOMap.atdcPersNm);
			$("#spNm").html(m0110VOMap.atdcPersNm);
			$("#refeDiv").hide();
		}else if( m0110VOMap.atdcPersDiv == "02"){ //참고인
			$("#atdcPersNm").hide();
			$("#spDiv").hide();
			$("#refeDiv").show();
			$("#refeNm").val(m0110VOMap.atdcPersNm);
		}
	setFieldValue($("#atdcReqNotcWay"), m0110VOMap.atdcReqNotcWay);
}

//수정 가능 버튼 보이기 여부
function updateYN(){
	if(parent.viewType == 'inc'){
		if(m0110VOMap.regUserId == $("#userId").val() ){
			freezeInput(false); // 입력 활성화
			$("#btnSearchInc").show(); // 검색버튼보이기
			$("#btnUpdateAtdcReq").show();  //수정버튼 보이기
			
		}else{
			freezeInput(true); // 입력 비활성화
			$("#btnUpdateAtdcReq").hide();  //수정버튼 숨기기
	
		}
		$("#btnInsertAtdcReq").hide();  //저장버튼 숨기기
	}
	$("#btnPrtAtdcReq").show();//대장출력버튼 보이기
	$("#btnReqPrn").show();	//신청서 출력버튼 보이기
}

//사건검색 성공함수
function callBackFn_M0110_searchIncSpSuccess(data){

	$("#incSpNum").val(data.incSpNum);
	$("input[name=spNm]").val(Base64.decode(data.spNm));								// 피의자 성명 출력
}


//맵초기화
function fn_M0110_initM0110VOMap() {
	m0110VOMap={
			"atdcReqNotcNum":""
			,"atdcReqDt":""
			,"atdcPersDiv":""
			,"atdcPersNm":""
			,"rcptNum":""
			,"atdcReqNotcDt":""
			,"atdcReqNotcWay":""
			,"atdcReqRst":""
			,"atdcReqRespMb":""
			,"regUserId":""
			,"nmKor":""
			,"docNum":""
			,"incPoint":""
			,"reqDocs":""
	}
}

//신규등록
function fn_M0110_newAtdcReq(){
	$("#afterDiv").hide();//대장입력폼 숨기기
	fn_M0110_initM0110VOMap(); //맵초기화
	fn_M0110_selectAtdcReqSetting(); // 데이터 세팅
	
	$("#btnReqPrn").hide();	//신청서 출력버튼 숨기기
	
	freezeInput(false); // 입력 활성화
	
	$("#btnSearchInc").show(); // 검색버튼보이기
	$("#btnInsertAtdcReq").show(); // 저장버튼 보이기	
	$("#btnUpdateAtdcReq").hide(); // 수정버튼 숨기기	
	
	$("#rcptNum").val(incMap.rcptNum); // 접수번호 세팅
	$("#execNum").html("신규");
	$("#incNum").html(isNull(incMap.rcptIncNum) ? "(피의자 선택시 자동입력)" : incMap.rcptIncNum);					//사건번호 세팅
	$("#atdcPersNm").html("(출석자 구분을 선택해주세요.)");
}
//등록하기
function fn_M0110_insertAtdcReq(){

	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
		return;
	}
	
	setAreaMap($("#M0110AtdcReq"), m0110VOMap);
	m0110VOMap.rcptNum = $("#rcptNum").val();
	m0110VOMap.incSpNum = $("#incSpNum").val();
	m0110VOMap.rcptIncNum = $("#incNum").html();
	m0110VOMap.atdcPersDiv = $("#atdcPersDiv").val();
	m0110VOMap.atdcReqNotcWay = $("#atdcReqNotcWay").val();
	
	if($("#spDiv").is(":visible")){
		m0110VOMap.atdcPersNm = $("input[name=spNm]").val();
	}
	if($("#refeDiv").is(":visible")){
		m0110VOMap.atdcPersNm = $("#refeNm").val();
	}
	//유효성검사
	if(m0110VOMap.atdcPersDiv == null || m0110VOMap.atdcPersDiv == "" || m0110VOMap.atdcPersDiv ==" "){
		alert("출석자구분을 입력해주세요.");
		return;
	}else{
		if(m0110VOMap.atdcPersNm == null || m0110VOMap.atdcPersNm == "" || m0110VOMap.atdcPersNm ==" "){
			alert("출석자를 입력해주세요.");
			return;
		}
	}

	goAjaxDefault("/sjpb/M/M0110insertAtdcReq.face",m0110VOMap,callBackFn_M0110_insertAtdcReqSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsertAtdcReq").hide(); //저장버튼 숨기기

}

//등록성공함수 호출
function callBackFn_M0110_insertAtdcReqSuccess(data){
	if(data == 1){
		alert("출석요구통지부가 등록되었습니다.");
	}else{
		alert("출석요구통지부 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0110_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0110_updateAtdcReq(){
	
	setAreaMap($("#M0110AtdcReq"), m0110VOMap);
	m0110VOMap.rcptNum = $("#rcptNum").val();
	m0110VOMap.incSpNum = $("#incSpNum").val();
	m0110VOMap.rcptIncNum = $("#incNum").html();
	m0110VOMap.atdcPersDiv = $("#atdcPersDiv").val();
	m0110VOMap.atdcReqNotcWay = $("#atdcReqNotcWay").val();
	if($("#spDiv").is(":visible")){
		m0110VOMap.atdcPersNm = $("#spNm").val();
	}
	if($("#refeDiv").is(":visible")){
		m0110VOMap.atdcPersNm = $("#refeNm").val();
	}
	
	//유효성검사
	if(m0110VOMap.atdcPersDiv == null || m0110VOMap.atdcPersDiv == "" || m0110VOMap.atdcPersDiv ==" "){
		alert("출석자구분을 입력해주세요.");
		return;
	}else{
		if(m0110VOMap.atdcPersNm == null || m0110VOMap.atdcPersNm == "" || m0110VOMap.atdcPersNm ==" "){
			alert("출석자를 입력해주세요.");
			return;
		}
	}
	
	
	goAjaxDefault("/sjpb/M/M0110updateAtdcReq.face",m0110VOMap,callBackFn_M0110_updateAtdcReqSuccess);
}
//수정성공함수 호출
function callBackFn_M0110_updateAtdcReqSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0110_pageInit();
	freezeInput(true); // 입력 비활성화
}

//출석요구통지부 출력
function fn_M0110_prnCheckReport() {
	var atdcReqNotcNumList = [];
	for(var i = 2; i <= qcell.getRows("data")+1; i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			atdcReqNotcNumList.push(qcell.getRowData(i).atdcReqNotcNum);
		}	
	}
	var atdcReqNotcNumListMap = {
			"atdcReqNotcNumList":atdcReqNotcNumList
	}
	
	if(atdcReqNotcNumList.length != 0){
		//출석요구통지부 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0110prnCheckReport.face", atdcReqNotcNumListMap, callBackFn_M0110_prnCheckReportSuccess);
	}else{
		alert("출력할 대상을 선택해주세요.");
		return;
	}
	
}
//출석요구통지부 출력 성공함수
function callBackFn_M0110_prnCheckReportSuccess(data){
	M0110RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0110RTMap);
	$("#reptNm").val("M0110.crf"); //레포트 파일명
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
//신청서 출력
function requestReport(){
	var reptNm = "";
	if("01".indexOf(m0110VOMap.atdcPersDiv) > -1){//피의자
		reptNm = "M0209.crf";
	}else if("02".indexOf(m0110VOMap.atdcPersDiv) > -1){//참고인
		reptNm = "M0210.crf";
	}else{
		alert("출석자 구분을 선택해주세요.");
		return;
	}
	$("#reptNm").val(reptNm); //레포트 파일명
	$("#SEQNUM").val(m0110VOMap.atdcReqNotcNum);
	//레포트 호출
	openReportServiceFSS(reportForm); 
}
//맵
var m0110VOMap={
		"atdcReqNotcNum":""
		,"atdcReqDt":""
		,"atdcPersDiv":""
		,"atdcPersNm":""
		,"rcptNum":""
		,"atdcReqNotcDt":""
		,"atdcReqNotcWay":""
		,"atdcReqRst":""
		,"atdcReqRespMb":""
		,"regUserId":""
		,"nmKor":""
		,"docNum":""
		,"incPoint":""
		,"reqDocs":""
}
//리포트맵
var M0110RTMap = {
	rexdataset : null
}