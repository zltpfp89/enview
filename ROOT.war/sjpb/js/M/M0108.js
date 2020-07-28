var qcell;
var queryString;
var qCellList=[];
var rowIdx=1;
var incMap;	
$(document).ready(function(){
	//사건 세팅
	incMap = setUiRcptNum(parent);
	
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
	}
	
	fn_M0108_pageInit();     
	
	if(parent.viewType == 'inc'){
		//피의자 검색버튼
		$("#spBtn").off("click").on("click", function() {	
			commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face?rcptNum='+incMap.rcptNum, "1050px", "435px", callBackFn_M0108_searchIncSpSuccess);
		});
	}
	
});
//화면 진입시 동작함
function fn_M0108_pageInit(){
	qCellList=[];
	
	queryString=$("#m0108_searchList").serialize();
	var d = document.m0108_searchList;
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
	
	goAjax("/sjpb/M/M0108selectList.face",queryString,callBackFn_M0108_selectListSuccess,true);
}
//피의자소재발견처리부 리스트 그리기.
function callBackFn_M0108_selectListSuccess(data){	

	if(data.qCell ==''|| data.qCell==' '){
		if(parent.viewType == 'inc'){
			fn_M0108_newSpWhab();
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
            	{width: '8%',	key: 'handBkSiNum',			title: ['순번'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'nmKor',			title: ['작성자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'spNm',			title: ['피의자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '7%',	key: 'whabDvDt',			title: ['소재발견일자'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'whabDvRsn',			title: ['소재발견사유'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'whabDvReptDt',			title: ['소재발견보고일'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'criNm',			title: ['죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'wantRelsDt',			title: ['수배해제일자'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '15%',	key: 'cmbkPreIncNum',			title: ['재기전사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'trfDt',			title: ['송치일'],		sort:true, move:true, resize: true,  options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'trfOp',			title: ['송치의견'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'respMb',			title: ['담당자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '8%',	key: 'spWhabDvHandBkComn',			title: ['비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}

            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0108VOMap = qcell.getRowData(1);
	    	fn_M0108_selectSpWhabSetting();
	    	//수정세팅
	    	updateYN();
		}
}
//피의자소재발견처리부 셀클릭 이벤트
function eventFn(e){
	// 선택한 인덱스 가져오기
	var colIdx = qcell.getIdx("col");
	rowIdx = qcell.getIdx("row");
	
	if(colIdx >0 && rowIdx > 0){
		if(colIdx != 1){
			//기존 체크박스 열번호
			var pastchk = qcell.getIdx("row","focus","previous") == -1? 1 : qcell.getIdx("row","focus","previous");
			
			//기존 체크항목 해제
			qcell.removeRowStyle(pastchk);
		
			//새로 선택한 행 스타일적용
			qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
			
			freezeInput(true); // 입력 비활성화
			fn_M0108_initM0108VOMap(); // 맵초기화
			m0108VOMap = qcell.getRowData(rowIdx);
		
			//피의자소재발견처리부 데이터 세팅
			fn_M0108_selectSpWhabSetting();
			//수정세팅
			updateYN();
		}
	}
}
//피의자소재발견처리부 데이터 세팅
function fn_M0108_selectSpWhabSetting(){	
	getAreaMap($("#M0108SpWhab"), m0108VOMap);
	$("#cmbkPreIncNum").html(m0108VOMap.cmbkPreIncNum);
	$("#incSpNum").val(m0108VOMap.incSpNum);
	$("#spNm").html(m0108VOMap.spNm);								// 피의자 성명 출력
	$("#criNm").html(m0108VOMap.criNm);	
}

//수정 가능 버튼 보이기 여부
function updateYN(){
	if(parent.viewType == 'inc'){
		if(m0108VOMap.regUserId == $("#userId").val() ){
			freezeInput(false); // 입력 활성화
			$("#btnSearchInc").show(); // 검색버튼보이기
			$("#btnUpdateSpWhab").show();  //수정버튼 보이기
		}else{
			freezeInput(true); // 입력 비활성화
			$("#btnUpdateSpWhab").hide();  //수정버튼 숨기기
		}
		$("#btnInsertSpWhab").hide();  //저장버튼 숨기기
	}
}

//사건검색 성공함수
function callBackFn_M0108_searchIncSpSuccess(data){

	$("input[name=spNm]").val(Base64.decode(data.spNm));								// 피의자 성명 출력
	$("#incSpNum").val(data.incSpNum);								// 피의자 번호
	$("#criNm").html(data.rltActCriNmCdDesc);					// 피의자 죄명 출력
}

//맵초기화
function fn_M0108_initM0108VOMap() {
	m0108VOMap={
			"spWhabDvHandBkNum":""
			,"handBkSiNum":""
			,"rcptIncNum":""
			,"incSpNum":""
			,"spNm":""
			,"whabDvDt":""
			,"whabDvRsn":""
			,"whabDvReptDt":""
			,"criNm":""
			,"wantRelsDt":""
			,"cmbkPreIncNum":""
			,"trfDt":""
			,"trfOp":""
			,"respMb":""
			,"spWhabDvHandBkComn":""
			,"rcptNum":""
			,"regUserId":""
			,"nmKor":""
	}
}

//신규등록
function fn_M0108_newSpWhab(){
	
	fn_M0108_initM0108VOMap(); //맵초기화
	fn_M0108_selectSpWhabSetting(); // 데이터 세팅	
	freezeInput(false); // 입력 활성화
	$("#btnSearchInc").show(); // 검색버튼보이기
	$("#btnInsertSpWhab").show(); // 저장버튼 보이기	
	$("#btnUpdateSpWhab").hide(); // 수정버튼 숨기기	

	$("#rcptNum").val(incMap.rcptNum);
	$("#handBkSiNum").html("신규");
	$("#cmbkPreIncNum").html(isNull(incMap.rcptIncNum) ? "(피의자 선택시 자동입력)" : incMap.rcptIncNum);					//사건번호 세팅
	$("#spIdNum").html("(피의자 선택시 자동입력)");
	$("#rltActCriNmCdDesc").html("(피의자 선택시 자동입력)");
}
//등록하기
function fn_M0108_insertSpWhab(){
	
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
		return;
	}
	
	//유효성검사
	setAreaMap($("#M0108SpWhab"), m0108VOMap);
	
	m0108VOMap.rcptNum = $("#rcptNum").val();
	m0108VOMap.incSpNum = $("#incSpNum").val();
	m0108VOMap.cmbkPreIncNum = $("#cmbkPreIncNum").html();
	m0108VOMap.criNm = $("#criNm").html();
	
	if(m0108VOMap.incSpNum == null || m0108VOMap.incSpNum == "" || m0108VOMap.incSpNum ==" "){
		alert("피의자를 선택해주세요.");
		return;
	}
	
	goAjaxDefault("/sjpb/M/M0108insertSpWhab.face",m0108VOMap,callBackFn_M0108_insertSpWhabSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsertSpWhab").hide(); //저장버튼 숨기기

}

//등록성공함수 호출
function callBackFn_M0108_insertSpWhabSuccess(data){
	if(data == 1){
		alert("피의자소재발견처리부가 등록되었습니다.");
	}else{
		alert("피의자소재발견처리부 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0108_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0108_updateSpWhab(){
	
	setAreaMap($("#M0108SpWhab"), m0108VOMap);
	m0108VOMap.rcptNum = $("#rcptNum").val();
	m0108VOMap.incSpNum = $("#incSpNum").val();
	m0108VOMap.cmbkPreIncNum = $("#cmbkPreIncNum").html();
	m0108VOMap.criNm = $("#criNm").html();
	
	goAjaxDefault("/sjpb/M/M0108updateSpWhab.face",m0108VOMap,callBackFn_M0108_updateSpWhabSuccess);
}
//수정성공함수 호출
function callBackFn_M0108_updateSpWhabSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0108_pageInit();
	freezeInput(true); // 입력 비활성화
}
//피의자소재발견처리부 출력
function fn_M0108_prnReport() {
	var spWhabDvHandBkNumMap ={
			"spWhabDvHandBkNum":m0108VOMap.spWhabDvHandBkNum
	};
	
	//피의자소재발견처리부 리스트 레포트 성공함수 호출
	goAjaxDefault("/sjpb/M/M0108prnReport.face",spWhabDvHandBkNumMap, callBackFn_M0108_prnReportSuccess);
}
//피의자소재발견처리부 체크리스트 출력
function fn_M0108_prnCheckReport() {
	var spWhabDvHandBkNumList = [];
	for(var i = 0; i <= qcell.getRows("data"); i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			spWhabDvHandBkNumList.push(qcell.getRowData(i).spWhabDvHandBkNum);
		}	
	}

	if(spWhabDvHandBkNumList.length != 0){		
		var spWhabDvHandBkNumListMap = {
				"spWhabDvHandBkNumList":spWhabDvHandBkNumList
		}
		//피의자소재발견처리부 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0108prnCheckReport.face",spWhabDvHandBkNumListMap, callBackFn_M0108_prnReportSuccess);
		
	}else{
		alert("출력할 대상을 선택해주세요.");
		return;
	}

}
//피의자소재발견처리부 출력 성공함수
function callBackFn_M0108_prnReportSuccess(data){
	M0108RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0108RTMap);
	$("#reptNm").val("M0108.crf"); //레포트 파일명
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
function fn_M0108_init(form){
	$("#"+form)[0].reset();	
}
//맵
var m0108VOMap={
		"spWhabDvHandBkNum":""
		,"handBkSiNum":""
		,"rcptIncNum":""
		,"incSpNum":""
		,"spNm":""
		,"whabDvDt":""
		,"whabDvRsn":""
		,"whabDvReptDt":""
		,"criNm":""
		,"wantRelsDt":""
		,"cmbkPreIncNum":""
		,"trfDt":""
		,"trfOp":""
		,"respMb":""
		,"spWhabDvHandBkComn":""
		,"rcptNum":""
		,"regUserId":""
		,"nmKor":""
}
//리포트맵
var M0108RTMap = {
	rexdataset : null
}