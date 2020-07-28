var qcell;
var queryString;
var qCellList=[];
var rowIdx=2;
$(document).ready(function(){
	fn_M0199_pageInit(); 		
});
//화면 진입시 동작함
function fn_M0199_pageInit(){
	qCellList=[];
	queryString = $("#m0199_searchList").serialize();
	var d = document.m0199_searchList;
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

	goAjax("/sjpb/M/M0199selectList.face",queryString,callBackFn_M0199_selectListSuccess);
}
//진정사건부 리스트 그리기.
function callBackFn_M0199_selectListSuccess(data){	
	if(data.qCell ==''|| data.qCell==' '){
		fn_M0199_new();
	}
	
	//Base64 디코드ffunction freezeInput
	$.each(data.qCell, function(i, dataTmp) {
		dataTmp.ptinNm = Base64.decode(dataTmp.ptinNm);
		dataTmp.ptinAddr = Base64.decode(dataTmp.ptinAddr);
		dataTmp.spPtinNm = Base64.decode(dataTmp.spPtinNm);
		dataTmp.spPtinIdNum = Base64.decode(dataTmp.spPtinIdNum);
		dataTmp.spPtinAddr = Base64.decode(dataTmp.spPtinAddr);
		dataTmp.spPtinJob = Base64.decode(dataTmp.spPtinJob);
	});
	
	var QCELLProp = {
            "parentid" : "listSheet",
            "id"		: "cell",
            "rowheader" : "sequence",
            "selectmode": "row",
            "merge": {"header": "rowandcol"},
       		"data" : {"input":data.qCell},
            "columns"	: [
            	{width: '50',	key: 'checkbox',			title: ['',''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '100',	key: 'prgsNum',			title: ['진행번호','진행번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rcptDt',			title: ['수리','수리'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'chifPstr',			title: ['주임검사','주임검사'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'ptinNm',			title: ['진정인','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'ptinAddr',			title: ['진정인','주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spPtinNm',			title: ['피진정인','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spPtinIdNum',			title: ['피진정인','주민등록번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spPtinAddr',			title: ['피진정인','주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spPtinJob',			title: ['피진정인','직업'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'incCmdDt',			title: ['진정사건지휘','연월일'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'incCmdOfic',			title: ['진정사건지휘','관서'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'incCmdReptPi',			title: ['진정사건지휘','보고기한'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'incCmdReptDt',			title: ['진정사건지휘','보고연월일'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'edDt',			title: ['종결','연월일'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'edSpll',			title: ['종결','주문'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'ptinRstNotcDt',			title: ['진정인결과통지','진정인결과통지'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'ptinComn',			title: ['비고','비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(2, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0199VOMap = qcell.getRowData(2);
	    	fn_M0199_selectSetting();
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
			qcell.clearCellStyles();
			qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
			
			freezeInput(true); // 입력 비활성화
			fn_M0199_initM0199VOMap(); // 맵초기화
			m0199VOMap = qcell.getRowData(rowIdx);
			
			//진정사건부 데이터 세팅
			fn_M0199_selectSetting();
			
			//수정세팅
			updateYN();
		}
	}
}
//구속영장신청부 데이터 세팅
function fn_M0199_selectSetting(){
	
	getAreaMap($("#M0199"), m0199VOMap);
	if(m0199VOMap.spPtinIdNum != '' && m0199VOMap.spPtinIdNum != null){
		var idNum = m0199VOMap.spPtinIdNum.split('-');
		m0199VOMap.spPtinIdNum_A = idNum[0];
		m0199VOMap.spPtinIdNum_B = idNum[1];	
		$("#spPtinIdNum_A").val(m0199VOMap.spPtinIdNum_A);
		$("#spPtinIdNum_B").val(m0199VOMap.spPtinIdNum_B);
	}
	
}

//수정 세팅
function updateYN(){
	if(m0199VOMap.regUserId == $("#userId").val() ){
		freezeInput(false); // 입력 활성화
		$("#btnUpdate").show();  //수정버튼 보이기
	}else{
		freezeInput(true); // 입력 비활성화
		$("#btnUpdate").hide();  //수정버튼 숨기기
	}
	$("#btnInsert").hide();  //저장버튼 숨기기
}

//맵초기화
function fn_M0199_initM0199VOMap() {
	m0199VOMap={
				"ptinIncBkNum":""					// 진정사건부번호
				,"prgsNum":""						// 진행번호 
				,"rcptDt":""						// 수리일자
				,"chifPstr":""						// 주임검사
				,"ptinNm":""						// 진정인성명  
				,"ptinAddr":""						// 진정인주거
				,"spPtinNm":""						// 피진정인성명
				,"spPtinIdNum":""					// 피진정인주민등록번호
				,"spPtinIdNum_A":""					// 피진정인주민등록번호앞자리
				,"spPtinIdNum_B":""					//  피진정인주민등록번호뒷자리
				,"spPtinAddr":""					//  피진정인주거
				,"spPtinJob":""						//  피진정인직업
				,"incCmdDt":""						// 진정사건지휘연월일
				,"incCmdOfic":""					// 진정사건지휘관서
				,"incCmdReptPi":""					//  진정사건지휘보고기한
				,"incCmdReptDt":""					// 진정사건지휘보고연월일
				,"edDt":""							// 종결연월일  
				,"edSpll":""						// 종결주문  
				,"ptinRstNotcDt":""					// 진정인결과통지일
				,"ptinComn":""						// 비고 
				,"regUserId":""						// 등록자 
	}
	
}


//신규등록
function fn_M0199_new(){

	fn_M0199_initM0199VOMap(); //맵초기화
	fn_M0199_selectSetting(); // 데이터 세팅	
	$("#prgsNum").html("신규");
	freezeInput(false); // 입력 활성화
	
	$("#btnInsert").show(); // 저장버튼 보이기	
	$("#btnUpdate").hide(); // 수정버튼 숨기기
	autoResize();

}
//등록하기
function fn_M0199_insert(){

	setAreaMap($("#M0199"), m0199VOMap);
	//주민등록번호 합치기
	if(m0199VOMap.spPtinIdNum_B != ''){
		m0199VOMap.spPtinIdNum = m0199VOMap.spPtinIdNum_A+'-'+m0199VOMap.spPtinIdNum_B;
	}else{
		m0199VOMap.spPtinIdNum = m0199VOMap.spPtinIdNum_A;
	}
	//암호화
	m0199VOMap.ptinNm = Base64.encode(m0199VOMap.ptinNm);
	m0199VOMap.ptinAddr = Base64.encode(m0199VOMap.ptinAddr);
	m0199VOMap.spPtinNm = Base64.encode(m0199VOMap.spPtinNm);
	m0199VOMap.spPtinIdNum = Base64.encode(m0199VOMap.spPtinIdNum);
	m0199VOMap.spPtinAddr = Base64.encode(m0199VOMap.spPtinAddr);
	m0199VOMap.spPtinJob = Base64.encode(m0199VOMap.spPtinJob);
	
	goAjaxDefault("/sjpb/M/M0199insert.face",m0199VOMap,callBackFn_M0199_insertSuccess);
	
	$("#btnInsert").hide(); //저장버튼 숨기기
	
}
//등록성공함수
function callBackFn_M0199_insertSuccess(data){
	if(data == 1){
		alert("진정사건부가 등록되었습니다.");
	}else{
		alert("진정사건부가 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0199_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0199_update(){
	setAreaMap($("#M0199"), m0199VOMap);
	//주민등록번호 합치기
	if(m0199VOMap.spPtinIdNum_B != ''){
		m0199VOMap.spPtinIdNum = m0199VOMap.spPtinIdNum_A+'-'+m0199VOMap.spPtinIdNum_B;
	}else{
		m0199VOMap.spPtinIdNum = m0199VOMap.spPtinIdNum_A;
	}
	//암호화
	m0199VOMap.ptinNm = Base64.encode(m0199VOMap.ptinNm);
	m0199VOMap.ptinAddr = Base64.encode(m0199VOMap.ptinAddr);
	m0199VOMap.spPtinNm = Base64.encode(m0199VOMap.spPtinNm);
	m0199VOMap.spPtinIdNum = Base64.encode(m0199VOMap.spPtinIdNum);
	m0199VOMap.spPtinAddr = Base64.encode(m0199VOMap.spPtinAddr);
	m0199VOMap.spPtinJob = Base64.encode(m0199VOMap.spPtinJob);
	
	goAjaxDefault("/sjpb/M/M0199update.face",m0199VOMap,callBackFn_M0199_updateSuccess);
}
//수정 성공함수
function callBackFn_M0199_updateSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0199_pageInit();
	freezeInput(true); // 입력 비활성화
}
//진정사건부 출력
function fn_M0199_prnReport() {
	var ptinIncBkNumMap = {
			"ptinIncBkNum" : document.M0199.ptinIncBkNum.value
	};
	
	//구속영장신청부 리스트 레포트 성공함수 호출
	goAjaxDefault("/sjpb/M/M0199prnReport.face", ptinIncBkNumMap, callBackFn_M0199_prnReportSuccess);
}
//진정사건부 출력 성공함수
function callBackFn_M0199_prnReportSuccess(data){
	M0199RTMap.rexdataset = data.qCell;
	var xmlString = objectToXml(M0199RTMap);
	$("#reptNm").val("M0199.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	
	//레포트 호출
	openReportService(reportForm); 
}
function fn_M0199_prnCheckReport(){
	var ptinIncBkNumList = [];
	for(var i = 2; i <= qcell.getRows("data")+1; i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			ptinIncBkNumList.push(qcell.getRowData(i).ptinIncBkNum);
		}	
	}
	var ptinIncBkNumListMap = {
			"ptinIncBkNumList":ptinIncBkNumList
	}
	
	if(ptinIncBkNumList.length != 0){
		//진정사건부 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0199prnCheckReport.face", ptinIncBkNumListMap, callBackFn_M0199_prnReportSuccess);
	}else{
		alert("출력할 대상을 선택해주세요.");
		return;
	}
}
//입력화면 비/활성화
function freezeInput(tf) {
	$("#contentsArea input").attr("disabled",tf);
	$("#contentsArea select").attr("disabled",tf);
	//$("#contentsArea a").attr("disabled",tf);
	$("#contentsArea textarea").attr("disabled",tf);
}

var m0199VOMap={
		"ptinIncBkNum":""					// 진정사건부번호
		,"prgsNum":""						// 진행번호 
		,"rcptDt":""						// 수리일자
		,"chifPstr":""						// 주임검사
		,"ptinNm":""						// 진정인성명  
		,"ptinAddr":""						// 진정인주거
		,"spPtinNm":""						// 피진정인성명
		,"spPtinIdNum":""					// 피진정인주민등록번호
		,"spPtinIdNum_A":""					// 피진정인주민등록번호앞자리
		,"spPtinIdNum_B":""					//  피진정인주민등록번호뒷자리
		,"spPtinAddr":""					//  피진정인주거
		,"spPtinJob":""						//  피진정인직업
		,"incCmdDt":""						// 진정사건지휘연월일
		,"incCmdOfic":""					// 진정사건지휘관서
		,"incCmdReptPi":""					//  진정사건지휘보고기한
		,"incCmdReptDt":""					// 진정사건지휘보고연월일
		,"edDt":""							// 종결연월일  
		,"edSpll":""						// 종결주문  
		,"ptinRstNotcDt":""					// 진정인결과통지일
		,"ptinComn":""						// 비고 
		,"regUserId":""						// 등록자 		
}
//리포트맵
var M0199RTMap = {
	rexdataset : null
}