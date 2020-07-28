var qcell;
var queryString=$("#m0105_searchList").serialize();
var qCellList=[];
var rowIdx=2;
$(document).ready(function(){
	fn_M0105_pageInit();     
});
//화면 진입시 동작함
function fn_M0105_pageInit(){
	qCellList=[];
	goAjax("/sjpb/M/M0105selectList.face",queryString,callBackFn_M0105_selectListSuccess);
}
//체포구속영장집행원부 리스트 그리기.
function callBackFn_M0105_selectListSuccess(data){	
	if(data.qCell ==''|| data.qCell==' '){
		$("#contentsArea").hide();
	}else{
		$("#contentsArea").show();
	}
	
	var QCELLProp = {
            "parentid" : "listSheet",
            "id"		: "cell",
            "rowheader" : "sequence",
            "selectmode": "row",
            "merge": {"header": "rowandcol"},
       		"data" : {"input":data.qCell},
            "columns"	: [
            	{width: '8%',	key: 'execNum',			title: ['집행번호','집행번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'bookNum',			title: ['영장번호','영장번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'divCdDesc',			title: ['구분','구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'spNm',			title: ['피의자','피의자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'rltActCriNmCdDesc',			title: ['죄명','죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'execCmdPatmDt',			title: ['집행지휘 또는 촉탁','연월일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'execCmdPatmOfic',			title: ['집행지휘 또는 촉탁','관서'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'wrntValdPi',			title: ['영장유효기간','영장유효기간'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'handExecDt',			title: ['처리','집행'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'handExecIncp',			title: ['처리','집행불능'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'handExecRetnDt',			title: ['처리','반환일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '10%',	key: 'cathArstWrntComn',			title: ['비고','비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(2, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0105VOMap = qcell.getRowData(2);
	    	fn_M0105_selectCathArstSetting();
	    	//수정세팅
	    	updateYN();
		}
}
//구속영장신청부 셀클릭 이벤트
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
	
	m0105VOMap = qcell.getRowData(rowIdx);

	//체포영장신청부 데이터 세팅
	fn_M0105_selectCathArstSetting();
	//수정세팅
	updateYN();
}
//구속영장신청부 데이터 세팅
function fn_M0105_selectCathArstSetting(){	
	getAreaMap($("#M0105CathArst"), m0105VOMap);
	Fn_M_Date(m0105VOMap.handExecDt,"handExecDt");
	$("#divCd").val(m0105VOMap.divCd);

}

//수정 가능 버튼 보이기 여부
function updateYN(){
	if(m0105VOMap.regUserId == $("#userId").val() ){
		freezeInput(false); // 입력 활성화
		$("#btnUpdateCathArst").show();  //수정버튼 보이기
	}else{
		freezeInput(true); // 입력 비활성화
		$("#btnUpdateCathArst").hide();  //수정버튼 숨기기
	}
	
	$("#btnInsertCathArst").hide();
}
//사건검색 팝업창
function fn_M0105_searchIncSp(){
	commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face', "1050px", "550px", callBackFn_M0105_searchIncSpSuccess);
}
//사건검색 성공함수
function callBackFn_M0105_searchIncSpSuccess(data){
	$("#rcptNum").val(data.rcptNum);
	$("#incSpNum").val(data.incSpNum);
	$("#spNm").html(Base64.decode(data.spNm));								// 피의자 성명 출력
	$("#rltActCriNmCdDesc").html(data.rltActCriNmCdDesc);					// 피의자 죄명 출력
}
//체포구속영장집행원부 출력
function fn_M0105_prtCathArstReport() {

	//체포구속영장집행원부 리스트 레포트 성공함수 호출
	goAjaxDefault("/sjpb/M/M0105selectList.face",queryString, callBackFn_M0105_prtCathArstReportSuccess);
}
//체포구속영장집행원부 출력 성공함수
function callBackFn_M0105_prtCathArstReportSuccess(data){
	M0105RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0105RTMap);
	$("#reptNm").val("M0105.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	console.log(xmlString);
	//레포트 호출
	openReportService(reportForm); 
}
//맵초기화
function fn_M0105_initM0105VOMap() {
	m0105VOMap={
				"cathArstWrntExecNum":""		//체포구속영장집행원부번호
				,"rcptNum":""					//접수번호
				,"execNum":""					//집행번호
				,"bookNum":""					//영장번호
				,"divCd":""						//구분코드
				,"incSpNum":""					//피의자번호
				,"spNm":""						//피의자이름
				,"rltActCriNmCdDesc":""			//죄명
				,"execCmdPatmDt":""				//집행지휘 또는 촉탁일시
				,"execCmdPatmOfic":""			//집행지휘 또는 촉탁관서
				,"wrntValdPi":""				//영장유효기간
				,"handExecDt":""				//처리집행일시
				,"handExecIncp":""				//처리집행불능
				,"handExecRetnDt":""			//처리집행반환일자
				,"cathArstWrntComn":""			//비고
				,"regUserId":""					//등록자	
	}
}

//신규등록
function fn_M0105_newCathArst(){
	$("#contentsArea").show();
	fn_M0105_initM0105VOMap(); //맵초기화
	fn_M0105_selectCathArstSetting(); // 데이터 세팅	
	freezeInput(false); // 입력 활성화
	$("#btnSearchSp").show(); // 검색버튼보이기
	$("#btnInsertCathArst").show(); // 저장버튼 보이기	
	$("#btnUpdateCathArst").hide(); // 수정버튼 숨기기	
	
}
//등록하기
function fn_M0105_insertCathArst(){
	//유효성검사
	
	setAreaMap($("#M0105CathArst"), m0105VOMap);
	m0105VOMap.rcptNum = $("#rcptNum").val();
	m0105VOMap.incSpNum = $("#incSpNum").val();
	m0105VOMap.divCd = $("#divCd").val();
	m0105VOMap.handExecDt = Fn_M_setDate($("#handExecDtCal").val(),$("#handExecDtHour").val(),$("#handExecDtMin").val());

	goAjaxDefault("/sjpb/M/M0105insertCathArst.face",m0105VOMap,callBackFn_M0105_insertCathArstSuccess);
	
	$("#btnSearchSp").hide(); // 검색버튼 숨기기
	$("#btnInsertCathArst").hide(); //저장버튼 숨기기
}

//등록성공함수 호출
function callBackFn_M0105_insertCathArstSuccess(data){
	if(data == 1){
		alert("체포구속영장집행원부가 등록되었습니다.");
	}else{
		alert("체포구속영장집행원부 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0105_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0105_updateCathArst(){
	setAreaMap($("#M0105CathArst"), m0105VOMap);
	m0105VOMap.rcptNum = $("#rcptNum").val();
	m0105VOMap.rcptIncNum = $("#rcptIncNum").html();
	m0105VOMap.divCd = $("#divCd").val();
	m0105VOMap.handExecDt = Fn_M0105_setDate($("#handExecDtCal").val(),$("#handExecDtHour").val(),$("#handExecDtMin").val());
	
	goAjaxDefault("/sjpb/M/M0105updateCathArst.face",m0105VOMap,callBackFn_M0105_updateCathArstSuccess);
}
//수정성공함수 호출
function callBackFn_M0105_updateCathArstSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0105_pageInit();
	freezeInput(true); // 입력 비활성화
}
//입력화면 비/활성화
function freezeInput(tf) {
	$("#contentsArea input").attr("disabled",tf);
	$("#contentsArea select").attr("disabled",tf);
	$("#contentsArea a").attr("disabled",tf);
}
//초기화
function fn_M0105_init(form){
	$("#"+form)[0].reset();	
}
//맵
var m0105VOMap={
		"cathArstWrntExecNum":""		//체포구속영장집행원부번호
		,"rcptNum":""					//접수번호
		,"execNum":""					//집행번호
		,"bookNum":""					//영장번호
		,"divCd":""						//구분코드
		,"incSpNum":""					//피의자번호
		,"spNm":""						//피의자이름
		,"rltActCriNmCdDesc":""			//죄명
		,"execCmdPatmDt":""				//집행지휘 또는 촉탁일시
		,"execCmdPatmOfic":""			//집행지휘 또는 촉탁관서
		,"wrntValdPi":""				//영장유효기간
		,"handExecDt":""				//처리집행일시
		,"handExecIncp":""				//처리집행불능
		,"handExecRetnDt":""			//처리집행반환일자
		,"cathArstWrntComn":""			//비고
		,"regUserId":""					//등록자	
}
//리포트맵
var M0105RTMap = {
	rexdataset : null
}