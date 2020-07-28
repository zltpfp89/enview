var qcell;
var queryString=$("#m0103_searchList").serialize();
var qCellList=[];
var rowIdx=1;
$(document).ready(function(){
	fn_M0103_pageInit();     
});
//화면 진입시 동작함
function fn_M0103_pageInit(){
	qCellList=[];
	queryString = $("#m0103_searchList").serialize();
	goAjax("/sjpb/M/M0103selectList.face",queryString,callBackFn_M0103_selectListSuccess);
}
//구속영장신청부 리스트 그리기.
function callBackFn_M0103_selectListSuccess(data){	
	var QCELLProp = {
            "parentid" : "listSheet",
            "id"		: "cell",
            "rowheader" : "sequence",
            "selectmode": "row",
            "merge": {"header": "rowandcol"},
       		"data" : {"input":data.qCell},
            "columns"	: [
            	{width: '100',	key: 'prgsNum',			title: ['진행번호','진행번호','진행번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rcptIncNum',			title: ['사건번호','사건번호','사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'chifPstr',			title: ['주임검사','주임검사','주임검사'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'reqOfic',			title: ['신청관서','신청관서','신청관서'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spNm',			title: ['피의자','성명','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spIdNum',			title: ['피의자','주민등록번호','주민등록번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spJob',			title: ['피의자','직업','직업'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spAddr',			title: ['피의자','주거','주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rltActCriNmCdDesc',			title: ['죄명','죄명','죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathDt',			title: ['체포','일시','일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathTpCdDesc',			title: ['체포','유형','유형'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathPrgsNum',			title: ['체포','진행번호','진행번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'wrntPstrRjctDt',			title: ['영장신청 및 발부','검사기각','검사기각'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'wrntJudgRjctDt',			title: ['영장신청 및 발부','판사기각','판사기각'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'wrntIsueDt',			title: ['영장신청 및 발부','발부','발부'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'wrntReReqDt',			title: ['영장신청 및 발부','재신청','신청'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'wrntReReqPstrRjctDt',			title: ['영장신청 및 발부','재신청','검사기각'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'wrntReReqJudgRjctDt',			title: ['영장신청 및 발부','재신청','판사기각'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'wrntReReqIsueDt',			title: ['영장신청 및 발부','재신청','발부'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spItrgAplt',			title: ['영장신청 및 발부','피의자심문','신청인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spItrgSiNum',			title: ['영장신청 및 발부','피의자심문','일련번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spItrgPstrNm',			title: ['영장신청 및 발부','피의자심문','검사 또는 판사명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spItrgRcptDt',			title: ['영장신청 및 발부','피의자심문','접수일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spItrgApltTitl',			title: ['영장신청 및 발부','피의자심문','접수자관직'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spItrgApltNm',			title: ['영장신청 및 발부','피의자심문','접수자성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spItrgArstDt',			title: ['영장신청 및 발부','피의자심문','구인일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'valdPi',			title: ['유효기간','유효기간','유효기간'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'relsDt',			title: ['석방','연월일','연월일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'relsRsn',			title: ['석방','사유','사유'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'arstWrntRetn',			title: ['반환','반환','반환'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'arstWrntComn',			title: ['비고','비고','비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(3, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0103VOMap = qcell.getRowData(3);
	    	fn_M0103_selectArstWrntSetting();
	    	//수정세팅
	    	updateYN();
		}
}
//구속영장신청부 셀클릭 이벤트
function eventFn(e){
	// 선택한 인덱스 가져오기
	if(rowIdx == null){
		rowIdx = 3;//초기값 설정
	}else{
		rowIdx = qcell.getIdx("row");	
	}
	//기존 체크박스 열번호
	var pastchk = qcell.getIdx("row","focus","previous") == -1?3:qcell.getIdx("row","focus","previous");
	
	//기존 체크항목 해제
	qcell.removeRowStyle(pastchk);

	//새로 선택한 행 스타일적용
	qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
	
	freezeInput(true); // 입력 비활성화
	m0103VOMap = qcell.getRowData(rowIdx);
	
	//구속영장신청부 데이터 세팅
	fn_M0103_selectArstWrntSetting();
	
	//수정세팅
	updateYN();
}
//구속영장신청부 데이터 세팅
function fn_M0103_selectArstWrntSetting(){
	
	getAreaMap($("#M0103ArstWrnt"), m0103VOMap);
	Fn_M_Date(m0103VOMap.cathDt,"cathDt");
	Fn_M_Date(m0103VOMap.wrntPstrRjctDt,"wrntPstrRjctDt");
	Fn_M_Date(m0103VOMap.wrntJudgRjctDt,"wrntJudgRjctDt");
	Fn_M_Date(m0103VOMap.wrntIsueDt,"wrntIsueDt");
	Fn_M_Date(m0103VOMap.wrntReReqDt,"wrntReReqDt");
	Fn_M_Date(m0103VOMap.wrntReReqPstrRjctDt,"wrntReReqPstrRjctDt");
	Fn_M_Date(m0103VOMap.wrntReReqJudgRjctDt,"wrntReReqJudgRjctDt");
	Fn_M_Date(m0103VOMap.wrntReReqIsueDt,"wrntReReqIsueDt");
	Fn_M_Date(m0103VOMap.spItrgRcptDt,"spItrgRcptDt");
	Fn_M_Date(m0103VOMap.spItrgArstDt,"spItrgArstDt");


}
function updateYN(){
	if(m0103VOMap.regUserId == $("#userId").val() ){
		freezeInput(false); // 입력 활성화
		$("#btnUpdateArstWrnt").show();  //수정버튼 보이기
	}else{
		freezeInput(true); // 입력 비활성화
		$("#btnUpdateArstWrnt").hide();  //수정버튼 숨기기
	}
}
//사건검색 팝업창
function fn_M0103_searchRcptInc(){
	commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face', "1050px", "550px", callBackFn_M0103_searchRcptIncSuccess);
}
//사건검색 성공함수
function callBackFn_M0103_searchRcptIncSuccess(data){
	$("#rcptNum").val(data.rcptNum);
	$("#incSpNum").val(data.incSpNum);
	$("#incNum").html(data.incNum);
	$("#spNm").html(Base64.decode(data.spNm));								// 피의자 성명 출력
	$("#spIdNum").html(Base64.decode(data.spIdNum));						// 피의자 주민등록번호 출력
	$("#spJob").html(Base64.decode(data.spJob));							// 피의자 직업 출력
	$("#spAddr").html(Base64.decode(data.spAddr));							// 피의자 주거 출력
	$("#rltActCriNmCdDesc").html(data.rltActCriNmCdDesc);					// 피의자 죄명 출력
}
//구속영장신청부 출력
function fn_M0103_prtArstWrntReport() {
	var arstWrntReqBkNumMap = {
			"arstWrntReqBkNum" : document.M0103ArstWrnt.arstWrntReqBkNum.value
	};

	//구속영장신청부 리스트 레포트 성공함수 호출
	goAjaxDefault("/sjpb/M/M0103selectList.face", arstWrntReqBkNumMap, callBackFn_M0103_prtArstWrntReportSuccess);
}
//구속영장신청부 출력 성공함수
function callBackFn_M0103_prtArstWrntReportSuccess(data){
	M0103RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0103RTMap);
	$("#reptNm").val("M0103.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	console.log(xmlString);
	//레포트 호출
	openReportService(reportForm); 
}
//맵초기화
function fn_M0103_initM0103VOMap() {
	m0103VOMap={
			"arstWrntReqBkNum":""					//구속영장신청부번호
			,"prgsNum":""							// 진행번호 
			,"rcptIncNum":""						// 사건번호 
			,"chifPstr":""							// 주임검사 
			,"reqOfic":""							// 신청관서 
			,"chifPstr":""							// 주임검사 
			,"spNm":""								// 피의자 성명 
			,"spIdNum":""							// 피의자 주민등록번호 
			,"spJob":""								// 피의자 직업 
			,"spAddr":""							// 피의자 주거 
			,"rltActCriNmCdDesc":""					// 죄명 
			,"cathDt":""							// 체포일시 
			,"cathDtCal":""							// 체포일시 
			,"cathDtHour":""							// 체포일시 
			,"cathDtMin":""							// 체포일시 
			,"cathTpCdDesc":""						// 체포유형 
			,"wrntPstrRjctDt":""					// 영장신청검사기각 
			,"wrntPstrRjctDtCal":""					// 영장신청검사기각 
			,"wrntPstrRjctDtHour":""					// 영장신청검사기각 
			,"wrntPstrRjctDtMin":""					// 영장신청검사기각 
			,"wrntJudgRjctDt":""					// 영장신청판사기각 
			,"wrntJudgRjctDtCal":""					// 영장신청판사기각 
			,"wrntJudgRjctDtHour":""					// 영장신청판사기각 
			,"wrntJudgRjctDtMin":""					// 영장신청판사기각 
			,"wrntIsueDt":""						// 영장신청발부 
			,"wrntIsueDtCal":""						// 영장신청발부 
			,"wrntIsueDtHour":""						// 영장신청발부 
			,"wrntIsueDtMin":""						// 영장신청발부 
			,"wrntReReqDt":""						// 재신청신청 
			,"wrntReReqDtCal":""						// 재신청신청 
			,"wrntReReqDtHour":""						// 재신청신청 
			,"wrntReReqDtMin":""						// 재신청신청 
			,"wrntReReqPstrRjctDt":""				// 재신청검사기각 
			,"wrntReReqPstrRjctDtCal":""				// 재신청검사기각 
			,"wrntReReqPstrRjctDtHour":""				// 재신청검사기각 
			,"wrntReReqPstrRjctDtMin":""				// 재신청검사기각 
			,"wrntReReqJudgRjctDt":""				// 재신청판사기각 
			,"wrntReReqJudgRjctDtCal":""				// 재신청판사기각 
			,"wrntReReqJudgRjctDtHour":""				// 재신청판사기각 
			,"wrntReReqJudgRjctDtMin":""				// 재신청판사기각 
			,"wrntReReqIsueDt":""					// 재신청발부 
			,"wrntReReqIsueDtCal":""					// 재신청발부 
			,"wrntReReqIsueDtHour":""					// 재신청발부 
			,"wrntReReqIsueDtMin":""					// 재신청발부 
			,"spItrgAplt":""						// 피의자심문신청인 
			,"spItrgSiNum":""						// 피의자심문일련번호 
			,"spItrgPstrNm":""						// 검사또는판사명 
			,"spItrgRcptDt":""						// 접수일시 
			,"spItrgRcptDtCal":""						// 접수일시 
			,"spItrgRcptDtHour":""						// 접수일시 
			,"spItrgRcptDtMin":""						// 접수일시 
			,"spItrgApltTitl":""					// 접수자관직 
			,"spItrgApltNm":""						// 접수자성명 
			,"spItrgArstDt":""						// 구인일시 
			,"spItrgArstDtCal":""						// 구인일시 
			,"spItrgArstDtHour":""						// 구인일시 
			,"spItrgArstDtMin":""						// 구인일시 
			,"valdPi":""							// 유효기간 
			,"relsDt":""							// 석방연월일 
			,"relsRsn":""							// 석방사유 
			,"arstWrntRetn":""						// 반환 
			,"arstWrntComn":""						// 비고  
	}
}


//신규등록
function fn_M0103_newArstWrnt(){
	fn_M0103_initM0103VOMap(); //맵초기화
	fn_M0103_selectArstWrntSetting(); // 데이터 세팅	
	freezeInput(false); // 입력 활성화
	$("#btnSearchInc").show(); // 검색버튼보이기
	$("#btnInsertArstWrnt").show(); // 저장버튼 보이기	
	
}
//등록하기
function fn_M0103_insertArstWrnt(){
	//유효성검사
	
	setAreaMap($("#M0103ArstWrnt"), m0103VOMap);
	m0103VOMap.cathDt = Fn_M_setDate($("#cathDtCal").val(),$("#cathDtHour").val(),$("#cathDtMin").val());
	m0103VOMap.wrntPstrRjctDt = Fn_M_setDate($("#wrntPstrRjctDtCal").val(),$("#wrntPstrRjctDtHour").val(),$("#wrntPstrRjctDtMin").val());
	m0103VOMap.wrntJudgRjctDt = Fn_M_setDate($("#wrntJudgRjctDtCal").val(),$("#wrntJudgRjctDtHour").val(),$("#wrntJudgRjctDtMin").val());
	m0103VOMap.wrntIsueDt = Fn_M_setDate($("#wrntIsueDtCal").val(),$("#wrntIsueDtHour").val(),$("#wrntIsueDtMin").val());
	m0103VOMap.wrntReReqDt = Fn_M_setDate($("#wrntReReqDtCal").val(),$("#wrntReReqDtHour").val(),$("#wrntReReqDtMin").val());
	m0103VOMap.wrntReReqPstrRjctDt = Fn_M_setDate($("#wrntReReqPstrRjctDtCal").val(),$("#wrntReReqPstrRjctDtHour").val(),$("#wrntReReqPstrRjctDtMin").val());
	m0103VOMap.wrntReReqJudgRjctDt = Fn_M_setDate($("#wrntReReqJudgRjctDtCal").val(),$("#wrntReReqJudgRjctDtHour").val(),$("#wrntReReqJudgRjctDtMin").val());
	m0103VOMap.wrntReReqIsueDt = Fn_M_setDate($("#wrntReReqIsueDtCal").val(),$("#wrntReReqIsueDtHour").val(),$("#wrntReReqIsueDtMin").val());
	m0103VOMap.spItrgRcptDt = Fn_M_setDate($("#spItrgRcptDtCal").val(),$("#spItrgRcptDtHour").val(),$("#spItrgRcptDtMin").val());
	m0103VOMap.spItrgArstDt = Fn_M_setDate($("#spItrgArstDtCal").val(),$("#spItrgArstDtHour").val(),$("#spItrgArstDtMin").val());
	m0103VOMap.cathDt = Fn_M_setDate($("#Cal").val(),$("#Hour").val(),$("#Min").val());
	m0103VOMap.cathDt = Fn_M_setDate($("#Cal").val(),$("#Hour").val(),$("#Min").val());
	goAjax("/sjpb/M/M0103insertArstWrnt.face",m0103VOMap,callBackFn_M0103_insertArstWrntSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsertArstWrnt").hide(); //저장버튼 숨기기
	
}

function callBackFn_M0103_insertArstWrntSuccess(data){
	if(data == 1){
		alert("구속영장신청부가 등록되었습니다.");
	}else{
		alert("구속영장신청부 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0103_pageInit();
	freezeInput(true); // 입력 비활성화
}

function fn_M0103_updateArstWrnt(){
	setAreaMap($("#M0103ArstWrnt"), m0103VOMap);
	m0103VOMap.cathDt = Fn_M_setDate($("#cathDtCal").val(),$("#cathDtHour").val(),$("#cathDtMin").val());
	m0103VOMap.wrntPstrRjctDt = Fn_M_setDate($("#wrntPstrRjctDtCal").val(),$("#wrntPstrRjctDtHour").val(),$("#wrntPstrRjctDtMin").val());
	m0103VOMap.wrntJudgRjctDt = Fn_M_setDate($("#wrntJudgRjctDtCal").val(),$("#wrntJudgRjctDtHour").val(),$("#wrntJudgRjctDtMin").val());
	m0103VOMap.wrntIsueDt = Fn_M_setDate($("#wrntIsueDtCal").val(),$("#wrntIsueDtHour").val(),$("#wrntIsueDtMin").val());
	m0103VOMap.wrntReReqDt = Fn_M_setDate($("#wrntReReqDtCal").val(),$("#wrntReReqDtHour").val(),$("#wrntReReqDtMin").val());
	m0103VOMap.wrntReReqPstrRjctDt = Fn_M_setDate($("#wrntReReqPstrRjctDtCal").val(),$("#wrntReReqPstrRjctDtHour").val(),$("#wrntReReqPstrRjctDtMin").val());
	m0103VOMap.wrntReReqJudgRjctDt = Fn_M_setDate($("#wrntReReqJudgRjctDtCal").val(),$("#wrntReReqJudgRjctDtHour").val(),$("#wrntReReqJudgRjctDtMin").val());
	m0103VOMap.wrntReReqIsueDt = Fn_M_setDate($("#wrntReReqIsueDtCal").val(),$("#wrntReReqIsueDtHour").val(),$("#wrntReReqIsueDtMin").val());
	m0103VOMap.spItrgRcptDt = Fn_M_setDate($("#spItrgRcptDtCal").val(),$("#spItrgRcptDtHour").val(),$("#spItrgRcptDtMin").val());
	m0103VOMap.spItrgArstDt = Fn_M_setDate($("#spItrgArstDtCal").val(),$("#spItrgArstDtHour").val(),$("#spItrgArstDtMin").val());

	goAjax("/sjpb/M/M0103updateArstWrnt.face",m0103VOMap,callBackFn_M0103_updateArstWrntSuccess);
}
function callBackFn_M0103_updateArstWrntSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0103_pageInit();
	freezeInput(true); // 입력 비활성화
}
//입력화면 비/활성화
function freezeInput(tf) {
	$("#contentsArea input").attr("disabled",tf);
	$("#contentsArea select").attr("disabled",tf);
	$("#contentsArea a").attr("disabled",tf);
}
//chrlghk
function fn_M0103_init(form){
	$("#"+form)[0].reset();	
}
var m0103VOMap={
		"arstWrntReqBkNum":""					//구속영장신청부번호
		,"prgsNum":""							// 진행번호 
		,"rcptIncNum":""						// 사건번호 
		,"chifPstr":""							// 주임검사 
		,"reqOfic":""							// 신청관서 
		,"chifPstr":""							// 주임검사 
		,"spNm":""								// 피의자 성명 
		,"spIdNum":""							// 피의자 주민등록번호 
		,"spJob":""								// 피의자 직업 
		,"spAddr":""							// 피의자 주거 
		,"rltActCriNmCdDesc":""					// 죄명 
		,"cathDt":""							// 체포일시 
		,"cathDtCal":""							// 체포일시 
		,"cathDtHour":""							// 체포일시 
		,"cathDtMin":""							// 체포일시 
		,"cathTpCdDesc":""						// 체포유형 
		,"wrntPstrRjctDt":""					// 영장신청검사기각 
		,"wrntPstrRjctDtCal":""					// 영장신청검사기각 
		,"wrntPstrRjctDtHour":""					// 영장신청검사기각 
		,"wrntPstrRjctDtMin":""					// 영장신청검사기각 
		,"wrntJudgRjctDt":""					// 영장신청판사기각 
		,"wrntJudgRjctDtCal":""					// 영장신청판사기각 
		,"wrntJudgRjctDtHour":""					// 영장신청판사기각 
		,"wrntJudgRjctDtMin":""					// 영장신청판사기각 
		,"wrntIsueDt":""						// 영장신청발부 
		,"wrntIsueDtCal":""						// 영장신청발부 
		,"wrntIsueDtHour":""						// 영장신청발부 
		,"wrntIsueDtMin":""						// 영장신청발부 
		,"wrntReReqDt":""						// 재신청신청 
		,"wrntReReqDtCal":""						// 재신청신청 
		,"wrntReReqDtHour":""						// 재신청신청 
		,"wrntReReqDtMin":""						// 재신청신청 
		,"wrntReReqPstrRjctDt":""				// 재신청검사기각 
		,"wrntReReqPstrRjctDtCal":""				// 재신청검사기각 
		,"wrntReReqPstrRjctDtHour":""				// 재신청검사기각 
		,"wrntReReqPstrRjctDtMin":""				// 재신청검사기각 
		,"wrntReReqJudgRjctDt":""				// 재신청판사기각 
		,"wrntReReqJudgRjctDtCal":""				// 재신청판사기각 
		,"wrntReReqJudgRjctDtHour":""				// 재신청판사기각 
		,"wrntReReqJudgRjctDtMin":""				// 재신청판사기각 
		,"wrntReReqIsueDt":""					// 재신청발부 
		,"wrntReReqIsueDtCal":""					// 재신청발부 
		,"wrntReReqIsueDtHour":""					// 재신청발부 
		,"wrntReReqIsueDtMin":""					// 재신청발부 
		,"spItrgAplt":""						// 피의자심문신청인 
		,"spItrgSiNum":""						// 피의자심문일련번호 
		,"spItrgPstrNm":""						// 검사또는판사명 
		,"spItrgRcptDt":""						// 접수일시 
		,"spItrgRcptDtCal":""						// 접수일시 
		,"spItrgRcptDtHour":""						// 접수일시 
		,"spItrgRcptDtMin":""						// 접수일시 
		,"spItrgApltTitl":""					// 접수자관직 
		,"spItrgApltNm":""						// 접수자성명 
		,"spItrgArstDt":""						// 구인일시 
		,"spItrgArstDtCal":""						// 구인일시 
		,"spItrgArstDtHour":""						// 구인일시 
		,"spItrgArstDtMin":""						// 구인일시 
		,"valdPi":""							// 유효기간 
		,"relsDt":""							// 석방연월일 
		,"relsRsn":""							// 석방사유 
		,"arstWrntRetn":""						// 반환 
		,"arstWrntComn":""						// 비고 
		
}
//리포트맵
var M0103RTMap = {
	rexdataset : null
}