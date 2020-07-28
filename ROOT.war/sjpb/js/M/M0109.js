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
	
	fn_M0109_pageInit();     
	
	if(parent.viewType == 'inc'){
		//피의자 검색버튼
		$("#spBtn").off("click").on("click", function() {	
			commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face?rcptNum='+incMap.rcptNum, "1050px", "435px", callBackFn_M0109_searchIncSpSuccess);
		});
	}
	
});
//화면 진입시 동작함
function fn_M0109_pageInit(){
	qCellList=[];
	
	queryString=$("#m0109_searchList").serialize();
	//검색조건 노출
	//사건에서 보여질 경우, 사건에 필요한것만 노출 (본인데이터만)
	if(parent.viewType == 'inc'){
		queryString += "&rcptNumSc="+incMap.rcptNum;
	}
	goAjax("/sjpb/M/M0109selectList.face",queryString,callBackFn_M0109_selectListSuccess,true);
}
//압수·수색·검증영장신청부 리스트 그리기.
function callBackFn_M0109_selectListSuccess(data){	

	if(data.qCell ==''|| data.qCell==' '){
		if(parent.viewType == 'inc'){
			fn_M0109_newSeizSech();
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
            	{width: '50',	key: 'checkbox',			title: ['',''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '100',	key: 'docNum',			title: ['문서번호','문서번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '150',	key: 'rcptIncNum',			title: ['사건번호','사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'attoNm',			title: ['변호인','변호인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'seizObj',			title: ['압수할 물건','압수할 물건'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'sechPlaBodyObj',			title: ['수색 검증할 장소, 신체 또는 물건','수색 검증할 장소, 신체 또는 물건'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'overWeekResn',			title: ['7일을 넘는 유효기간을 필요로 하는 취지와 사유','7일을 넘는 유효기간을 필요로 하는 취지와 사유'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'overTwoPersRes',			title: ['둘 이상의 영장을 신청하는 취지와 사유','둘 이상의 영장을 신청하는 취지와 사유'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'midNightExecResn',			title: ['일출 전 또는 일몰 후 집행을 필요로 하는 취지와 사유','일출 전 또는 일몰 후 집행을 필요로 하는 취지와 사유'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'persGendAndHealth',			title: ['신체검사를 받을 자의 성별, 건강상태','신체검사를 받을 자의 성별, 건강상태'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'prgsNum',			title: ['진행번호','진행번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'nmKor',			title: ['작성자','작성자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'reqDt',			title: ['신청연월일','신청연월일'],		sort:true, move:true, resize: true,  options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'reqPersNm',			title: ['신청자','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'reqPersTitl',			title: ['신청자','관직'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spNm',			title: ['피의자','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spIdNum',			title: ['피의자','주민등록번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spJob',			title: ['피의자','직업'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spAddr',			title: ['피의자','주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rltActCriNmCdDesc',			title: ['죄명','죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'pstrRjctDt',			title: ['검사기각','검사기각'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'judgRjctDt',			title: ['판사기각','판사기각'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'seizSechIsue',			title: ['발부','발부'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'valdPi',			title: ['유효기간','유효기간'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'execDt',			title: ['집행','일시'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'execPla',			title: ['집행','장소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'execHandRst',			title: ['집행','처리결과'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'seizSechComn',			title: ['비고','비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}           	
            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(2, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0109VOMap = qcell.getRowData(2);
	    	fn_M0109_selectSeizSechSetting();
	    	//수정세팅
	    	updateYN();
		}
}
//압수·수색·검증영장신청부 셀클릭 이벤트
function eventFn(e){
	// 선택한 인덱스 가져오기
	if(rowIdx == null){
		rowIdx = 2;//초기값 설정
	}else{
		rowIdx = qcell.getIdx("row");	
	}
	//기존 체크박스 열번호
	var pastchk = qcell.getIdx("row","focus","previous") == -1?2:qcell.getIdx("row","focus","previous");
	
	//기존 체크항목 해제
	qcell.removeRowStyle(pastchk);

	//새로 선택한 행 스타일적용
	qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
	
	freezeInput(true); // 입력 비활성화
	fn_M0109_initM0109VOMap(); // 맵초기화
	m0109VOMap = qcell.getRowData(rowIdx);
	$("#afterDiv").show();
	//압수·수색·검증영장신청부 데이터 세팅
	fn_M0109_selectSeizSechSetting();
	//수정세팅
	updateYN();
}
//압수·수색·검증영장신청부 데이터 세팅
function fn_M0109_selectSeizSechSetting(){	
	getAreaMap($("#M0109SeizSech"), m0109VOMap);

	$("#incNum").html(m0109VOMap.rcptIncNum);
	$("#cmbkPreIncNum").html(m0109VOMap.cmbkPreIncNum);
	$("#incSpNum").val(m0109VOMap.incSpNum);
	$("#spNm").html(m0109VOMap.spNm);								// 피의자 성명 출력
	$("#criNm").html(m0109VOMap.criNm);	
}

//수정 가능 버튼 보이기 여부
function updateYN(){
	if(parent.viewType == 'inc'){
		if(m0109VOMap.regUserId == $("#userId").val() ){
			freezeInput(false); // 입력 활성화
			$("#btnSearchInc").show(); // 검색버튼보이기
			$("#btnUpdateSeizSech").show();  //수정버튼 보이기
			$("#btnPrnReport").show();
			$("#btnReqPrnReport").show();
		}else{
			freezeInput(true); // 입력 비활성화
			$("#btnUpdateSeizSech").hide();  //수정버튼 숨기기
	
		}
		$("#btnInsertSeizSech").hide();  //저장버튼 숨기기
	}else{
		$("#btnPrnReport").show();
		$("#btnReqPrnReport").show();
	}
	
}

//사건검색 성공함수
function callBackFn_M0109_searchIncSpSuccess(data){

	$("#incSpNum").val(data.incSpNum);
	$("input[name=spNm]").val(Base64.decode(data.spNm));						// 피의자 성명 출력
	$("#spIdNum").html(Base64.decode(data.spIdNum));							// 피의자 주민등록번호 출력
	$("#spJob").html(Base64.decode(data.spJob));								// 피의자 직업 출력
	$("#spAddr").html(Base64.decode(data.spAddr));								// 피의자 주거 출력
	$("#rltActCriNmCdDesc").html(data.rltActCriNmCdDesc);						// 피의자 죄명 출력
}



//맵초기화
function fn_M0109_initM0109VOMap() {
	m0109VOMap={
			"seizSechWrntReqNum":""
			,"prgsNum":""
			,"rcptNum":""
			,"rcptIncNum":""
			,"incSpNum":""
			,"spNm":""
			,"spIdNum":""
			,"spJob":""
			,"spAddr":""
			,"rltActCriNmCdDesc":""
			,"reqDt":""
			,"reqPersTitl":""
			,"pstrRjctDt":""
			,"judgRjctDt":""
			,"seizSechIsue":""
			,"valdPi":""
			,"execDt":""
			,"execPla":""
			,"execHandRst":""
			,"seizSechComn":""
			,"regUserId":""
			,"nmKor":""
			,"docNum":""			
			,"attoNm":""			
			,"seizObj":""			
			,"sechPlaBodyObj":""	
			,"overWeekResn":""	
			,"overTwoPersRes":""	
			,"midNightExecResn":""
			,"persGendAndHealth":""
	}
}

//신규등록
function fn_M0109_newSeizSech(){
	
	fn_M0109_initM0109VOMap(); //맵초기화
	fn_M0109_selectSeizSechSetting(); // 데이터 세팅	
	freezeInput(false); // 입력 활성화
	$("#btnSearchInc").show(); // 검색버튼보이기
	$("#btnInsertSeizSech").show(); // 저장버튼 보이기	
	$("#btnUpdateSeizSech").hide(); // 수정버튼 숨기기	
	$("#btnPrnReport").hide();
	$("#btnReqPrnReport").hide();
	
	$("#afterDiv").hide();
	$("#prgsNum").html("신규");
	$("#rcptNum").val(incMap.rcptNum);
	$("#incNum").html(isNull(incMap.rcptIncNum) ? "(피의자 선택시 자동입력)" : incMap.rcptIncNum);					//사건번호 세팅
	$("#spIdNum").html("(피의자 선택시 자동입력)");
	$("#spJob").html("(피의자 선택시 자동입력)");
	$("#spAddr").html("(피의자 선택시 자동입력)");
	$("#rltActCriNmCdDesc").html("(피의자 선택시 자동입력)");
	
}
//등록하기
function fn_M0109_insertSeizSech(){
	
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
		return;
	}
		
	//유효성검사
	setAreaMap($("#M0109SeizSech"), m0109VOMap);
	m0109VOMap.rcptNum = $("#rcptNum").val();
	m0109VOMap.incSpNum = $("#incSpNum").val();
	m0109VOMap.rcptIncNum = $("#incNum").html();
	
	if(m0109VOMap.incSpNum == null || m0109VOMap.incSpNum == "" || m0109VOMap.incSpNum ==" "){
		alert("피의자를 선택해주세요.");
		return;
	}
	
	goAjaxDefault("/sjpb/M/M0109insertSeizSech.face",m0109VOMap,callBackFn_M0109_insertSeizSechSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsertSeizSech").hide(); //저장버튼 숨기기

}

//등록성공함수 호출
function callBackFn_M0109_insertSeizSechSuccess(data){
	if(data == 1){
		alert("압수·수색·검증영장신청부가 등록되었습니다.");
	}else{
		alert("압수·수색·검증영장신청부 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0109_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0109_updateSeizSech(){
	
	setAreaMap($("#M0109SeizSech"), m0109VOMap);
	m0109VOMap.rcptNum = $("#rcptNum").val();
	m0109VOMap.incSpNum = $("#incSpNum").val();
	m0109VOMap.rcptIncNum = $("#incNum").html();
	
	goAjaxDefault("/sjpb/M/M0109updateSeizSech.face",m0109VOMap,callBackFn_M0109_updateSeizSechSuccess);
}
//수정성공함수 호출
function callBackFn_M0109_updateSeizSechSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0109_pageInit();
	freezeInput(true); // 입력 비활성화
}
//압수·수색·검증영장신청부 출력
function fn_M0109_prnReport() {
	var seizSechWrntReqNumMap ={
			"seizSechWrntReqNum":m0109VOMap.seizSechWrntReqNum
	};
	
	//압수·수색·검증영장신청부 리스트 레포트 성공함수 호출
	goAjaxDefault("/sjpb/M/M0109prnReport.face",seizSechWrntReqNumMap, callBackFn_M0109_prtSeizSechReportSuccess);
}

//압수·수색·검증영장신청부 체크리스트 출력
function fn_M0109_prnCheckReport() {
	var seizSechWrntReqNumList = [];
	for(var i = 2; i <= qcell.getRows("data")+1; i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			seizSechWrntReqNumList.push(qcell.getRowData(i).seizSechWrntReqNum);
		}	
	}

	if(seizSechWrntReqNumList.length != 0){		
		var seizSechWrntReqNumListMap = {
				"seizSechWrntReqNumList":seizSechWrntReqNumList
		}
		//압수·수색·검증영장신청부 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0109prnCheckReport.face",seizSechWrntReqNumListMap, callBackFn_M0109_prtSeizSechReportSuccess);
		
	}else{
		alert("출력할 대상을 선택해주세요.");
		return;
	}

}

//압수·수색·검증영장신청부 출력 성공함수
function callBackFn_M0109_prtSeizSechReportSuccess(data){
	M0109RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0109RTMap);
	$("#reptNm").val("M0109.crf"); //레포트 파일명
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
//초기화
function fn_M0109_init(form){
	$("#"+form)[0].reset();	
}

//신청서 출력
function requestReport(){
	
	$("#reptNm").val("M0214.crf"); //레포트 파일명
	$("#SEQNUM").val(m0109VOMap.seizSechWrntReqNum);
	//레포트 호출
	openReportServiceFSS(reportForm); 
}
//맵
var m0109VOMap={
		"seizSechWrntReqNum":""
		,"prgsNum":""
		,"rcptNum":""
		,"rcptIncNum":""
		,"incSpNum":""
		,"spNm":""
		,"spIdNum":""
		,"spJob":""
		,"spAddr":""
		,"rltActCriNmCdDesc":""
		,"reqDt":""
		,"reqPersTitl":""
		,"pstrRjctDt":""
		,"judgRjctDt":""
		,"seizSechIsue":""
		,"valdPi":""
		,"execDt":""
		,"execPla":""
		,"execHandRst":""
		,"seizSechComn":""
		,"regUserId":""
		,"nmKor":""
		,"docNum":""			
		,"attoNm":""			
		,"seizObj":""			
		,"sechPlaBodyObj":""	
		,"overWeekResn":""	
		,"overTwoPersRes":""	
		,"midNightExecResn":""
		,"persGendAndHealth":""
}
//리포트맵
var M0109RTMap = {
	rexdataset : null
}