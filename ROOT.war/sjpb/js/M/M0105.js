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
	fn_M0105_pageInit();    
	
	if(parent.viewType == 'inc'){
		//피의자 검색버튼
		$("#spBtn").off("click").on("click", function() {	
			commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face?rcptNum='+incMap.rcptNum, "1050px", "435px", callBackFn_M0105_searchIncSpSuccess);
		});
	}
	
});
//화면 진입시 동작함
function fn_M0105_pageInit(){
	qCellList=[];
	queryString=$("#m0105_searchList").serialize();
	var d = document.m0105_searchList;
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
	
	goAjax("/sjpb/M/M0105selectList.face",queryString,callBackFn_M0105_selectListSuccess,true);
}
//체포구속영장집행원부 리스트 그리기.
function callBackFn_M0105_selectListSuccess(data){	

	if(data.qCell ==''|| data.qCell==' '){
		if(parent.viewType == 'inc'){
			fn_M0105_newCathArst();
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
            	{width: '7%',	key: 'execNum',			title: ['집행번호','집행번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'bookNum',			title: ['영장번호','영장번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '12%',	key: 'rcptIncNum',			title: ['사건번호','사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'nmKor',			title: ['작성자','작성자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'divCdDesc',			title: ['구분','구분'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'spNm',			title: ['피의자','피의자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'rltActCriNmCdDesc',			title: ['죄명','죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'execCmdPatmDt',			title: ['집행지휘 또는 촉탁','연월일'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'execCmdPatmOfic',			title: ['집행지휘 또는 촉탁','관서'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'wrntValdPi',			title: ['영장유효기간','영장유효기간'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'handExecDt',			title: ['처리','집행'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh시 mm분"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'handExecIncp',			title: ['처리','집행불능'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'handExecRetnDt',			title: ['처리','반환일자'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'cathArstWrntComn',			title: ['비고','비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
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
			fn_M0105_initM0105VOMap(); // 맵초기화
			m0105VOMap = qcell.getRowData(rowIdx);
		
			//체포영장신청부 데이터 세팅
			fn_M0105_selectCathArstSetting();
			//수정세팅
			updateYN();
		}
	}
}
//구속영장신청부 데이터 세팅
function fn_M0105_selectCathArstSetting(){	
	getAreaMap($("#M0105CathArst"), m0105VOMap);
	
	setFieldValue($("#divCd"), m0105VOMap.divCd);
	
	Fn_M_SettingDate(m0105VOMap.handExecDt,"handExecDt");

}
//시,분,초 날짜형식 세팅
function fn_M0105_joinDate(vo){
	vo.handExecDt = Fn_M_StoreDate($("#handExecDtCal").val(),$("#handExecDtHour").val(),$("#handExecDtMin").val());
}
//수정 가능 버튼 보이기 여부
function updateYN(){
	if(parent.viewType == 'inc'){
		if(m0105VOMap.regUserId == $("#userId").val() ){
			freezeInput(false); // 입력 활성화
			$("#btnUpdateCathArst").show();  //수정버튼 보이기
			$("#btnSearchInc").show(); // 검색버튼보이기
		}else{
			freezeInput(true); // 입력 비활성화
			$("#btnUpdateCathArst").hide();  //수정버튼 숨기기
			$("#btnSearchInc").hide(); // 검색버튼보이기
		}
		
		$("#btnInsertCathArst").hide();  //저장버튼 숨기기
	}
}
//사건검색 팝업창
function fn_M0105_searchIncSp(){
	commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face?rcptNum='+incMap.rcptNum, "1050px", "550px", callBackFn_M0105_searchIncSpSuccess);
}
//사건검색 성공함수
function callBackFn_M0105_searchIncSpSuccess(data){
	
	$("#incSpNum").val(data.incSpNum);
	$("input[name=spNm]").val(Base64.decode(data.spNm));								// 피의자 성명 출력
	$("#rltActCriNmCdDesc").html(data.rltActCriNmCdDesc);					// 피의자 죄명 출력
}

//맵초기화
function fn_M0105_initM0105VOMap() {
	m0105VOMap={
				"cathArstWrntExecNum":""		//체포구속영장집행원부번호
				,"rcptNum":""					//접수번호
				,"rcptIncNum":""				//사건번호
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
				,"nmKor":""						//작성자이름
	}
	Fn_M_CleanDate("handExecDt");
}

//신규등록
function fn_M0105_newCathArst(){
	
	fn_M0105_initM0105VOMap(); //맵초기화
	fn_M0105_selectCathArstSetting(); // 데이터 세팅	
	freezeInput(false); // 입력 활성화
	$("#btnSearchSp").show(); // 검색버튼보이기
	$("#btnInsertCathArst").show(); // 저장버튼 보이기	
	$("#btnUpdateCathArst").hide(); // 수정버튼 숨기기	
	$("#execNum").html("신규");
	$("#bookNum").html("신규");
	$("#incNum").html(isNull(incMap.rcptIncNum) ? "(피의자 선택시 자동입력)" : incMap.rcptIncNum);
	$("#rcptNum").val(incMap.rcptNum);//사건번호 세팅
	$("#rltActCriNmCdDesc").html("(피의자 선택시 자동입력)");
}
//등록하기
function fn_M0105_insertCathArst(){
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
		return;
	}
	//유효성검사
	setAreaMap($("#M0105CathArst"), m0105VOMap);
	m0105VOMap.rcptNum = $("#rcptNum").val();
	m0105VOMap.incSpNum = $("#incSpNum").val();
	m0105VOMap.divCd = $("#divCd").val();
	if(m0105VOMap.incSpNum == null || m0105VOMap.incSpNum == "" || m0105VOMap.incSpNum ==" "){
		alert("피의자를 선택해주세요.");
		return;
	}
	
	if(Fn_M_CheckingDate("처리 집행",$("#handExecDtCal").val(),$("#handExecDtHour").val(),$("#handExecDtMin").val()) == false) return;
	fn_M0105_joinDate(m0105VOMap);
	
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
	m0105VOMap.incSpNum = $("#incSpNum").val();
	m0105VOMap.divCd = $("#divCd").val();
	
	if(Fn_M_CheckingDate("처리 집행",$("#handExecDtCal").val(),$("#handExecDtHour").val(),$("#handExecDtMin").val()) == false) return;
	
	fn_M0105_joinDate(m0105VOMap);
	
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
//체포구속영장집행원부 출력
function fn_M0105_prnCheckReport() {
	var cathArstWrntExecNumList = [];
	for(var i = 2; i <= qcell.getRows("data")+1; i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			cathArstWrntExecNumList.push(qcell.getRowData(i).cathArstWrntExecNum);
		}	
	}
	var cathArstWrntExecNumListMap = {
			"cathArstWrntExecNumList":cathArstWrntExecNumList
	}
	
	if(cathArstWrntExecNumList.length != 0){
		//체포구속영장집행원부 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0105prnCheckReport.face", cathArstWrntExecNumListMap, callBackFn_M0105_prnCheckReportSuccess);
	}else{
		alert("출력할 대상을 선택해주세요.");
		return;
	}
}
//체포,구속영장집행원부 출력 성공함수
function callBackFn_M0105_prnCheckReportSuccess(data){
	M0105RTMap.rexdataset = data.rexdataset;
	
	var xmlString = objectToXml(M0105RTMap);
	$("#reptNm").val("M0105.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	//레포트 호출
	openReportService(reportForm); 
}

function fn_M0105_prnReport(){
	var cathArstWrntExecNumMap={
			"cathArstWrntExecNum" : document.M0105CathArst.cathArstWrntExecNum.value
	};
	
	goAjaxDefault("/sjpb/M/M0105prnReport.face", cathArstWrntExecNumMap, callBackFn_M0105_prnCheckReportSuccess);
}
//입력화면 비/활성화
function freezeInput(tf) {
	$("#contentsArea input").attr("disabled",tf);
	$("#contentsArea select").attr("disabled",tf);
	//$("#contentsArea a").attr("disabled",tf);
}


//초기화
function fn_M0105_init(form){
	$("#"+form)[0].reset();	
}
//맵
var m0105VOMap={
		"cathArstWrntExecNum":""		//체포구속영장집행원부번호
		,"rcptNum":""					//접수번호
		,"rcptIncNum":""				//사건번호
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
		,"nmKor":""						//작성자이름
}
//리포트맵
var M0105RTMap = {
	rexdataset : null
}