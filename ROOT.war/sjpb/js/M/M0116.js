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
	fn_M0116_pageInit(); 
	
	if(parent.viewType == 'inc'){
		//피의자 검색버튼
		$("#spBtn").off("click").on("click", function() {	
			commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face?rcptNum='+incMap.rcptNum, "1050px", "435px", callBackFn_M0116_searchRcptIncSuccess);
		});
	}
	
});
//화면 진입시 동작함
function fn_M0116_pageInit(){
	qCellList=[];
	queryString = $("#m0116_searchList").serialize();
	var d = document.m0116_searchList;
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
	goAjax("/sjpb/M/M0116selectList.face",queryString,callBackFn_M0116_selectListSuccess,true);
}
//구속영장신청부 리스트 그리기.
function callBackFn_M0116_selectListSuccess(data){	

	if(data.qCell ==''|| data.qCell==' '){
		if(parent.viewType == 'inc'){
			fn_M0116_new();
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
            	{width: '50',	key: 'checkbox',			title: ['','',''], 	type:'checkbox',	style:{data:{"background-color":"gray"}}, options:{wholeselect:true},	  resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '100',	key: 'prgsNum',			title: ['진행번호','진행번호','진행번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '150',	key: 'rcptIncNum',			title: ['사건번호','사건번호','사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'nmKor',			title: ['작성자','작성자','작성자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spNm',			title: ['피의자','성명','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spNm',			title: ['피의자','성명','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spIdNum',			title: ['피의자','주민등록번호','주민등록번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spJob',			title: ['피의자','직업','직업'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spAddr',			title: ['피의자','주거','주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rltActCriNmCdDesc',			title: ['죄명','죄명','죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cmctRstrType',			title: ['종류','종류','종류'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cmctRstrWay',			title: ['방법','방법','방법'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'dipTrgt',			title: ['처분','대상','대상'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'dipRnge',			title: ['처분','범위','범위'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rstrActnDt',			title: ['긴급통신제한조치일자','긴급통신제한조치일자','긴급통신제한조치일자'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'apprPi',			title: ['허가','기간','기간'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'execPla',			title: ['허가','장소','장소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'extsPiBeDt',			title: ['연장기간','시작일','시작일'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'extsPiEdDt',			title: ['연장기간','종료일','종료일'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'reqApprReqDt',			title: ['허가신청 및 발부','신청','허가신청'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'reqExtsReqDt',			title: ['허가신청 및 발부','신청','연장신청'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'isueApprReqDt',			title: ['허가신청 및 발부','발부','허가신청'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'isueExtsReqDt',			title: ['허가신청 및 발부','발부','연장신청'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rjctApprReqDt',			title: ['허가신청 및 발부','기각','허가신청'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rjctExtsReqDt',			title: ['허가신청 및 발부','기각','연장신청'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'reReqApprReqDt',			title: ['허가신청 및 발부','재신청','허가신청'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'reReqExtsReqDt',			title: ['허가신청 및 발부','재신청','연장신청'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'reReqIsueApprReqDt',			title: ['허가신청 및 발부','발부','허가신청'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'reReqIsueExtsReqDt',			title: ['허가신청 및 발부','발부','연장신청'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'reReqRjctApprReqDt',			title: ['허가신청 및 발부','기각','허가신청'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'reReqRjctExtsReqDt',			title: ['허가신청 및 발부','기각','연장신청'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'apprRcptDt',			title: ['허가신청 및 발부','허가신청','수령연월일'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'apprRcptPersTitl',			title: ['허가신청 및 발부','허가신청','수령자의 관직'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'apprRcptPersNm',			title: ['허가신청 및 발부','허가신청','수령자의 성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'extsRcptDt',			title: ['허가신청 및 발부','연장신청','수령연월일'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'extsRcptPersTitl',			title: ['허가신청 및 발부','연장신청','수령자의 관직'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'extsRcptPersNm',			title: ['허가신청 및 발부','연장신청','수령자의 성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'poRetnDt',			title: ['검찰반환연월일','검찰반환연월일','검찰반환연월일'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cmctRstrComn',			title: ['비고','비고','비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(3, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0116VOMap = qcell.getRowData(3);
	    	fn_M0116_selectSetting();
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
			fn_M0116_initM0116VOMap(); // 맵초기화
			m0116VOMap = qcell.getRowData(rowIdx);
			
			//구속영장신청부 데이터 세팅
			fn_M0116_selectSetting();
			
			//수정세팅
			updateYN();
		}
	}
}
//구속영장신청부 데이터 세팅
function fn_M0116_selectSetting(){
	
	getAreaMap($("#M0116"), m0116VOMap);
	$("#incNum").html(m0116VOMap.rcptIncNum);
	$("#rcptNum").val(m0116VOMap.rcptNum);

	
}

//수정 세팅
function updateYN(){
	if(parent.viewType == 'inc'){
		if(m0116VOMap.regUserId == $("#userId").val() ){
			freezeInput(false); // 입력 활성화
			$("#btnUpdate").show();  //수정버튼 보이기
		}else{
			freezeInput(true); // 입력 비활성화
			$("#btnUpdate").hide();  //수정버튼 숨기기
		}
		$("#btnInsert").hide();  //저장버튼 숨기기
	}
}

//사건검색 성공함수
function callBackFn_M0116_searchRcptIncSuccess(data){
	$("#incSpNum").val(data.incSpNum);						
	$("input[name=spNm]").val(Base64.decode(data.spNm));					// 피의자 성명 출력
	$("#spIdNum").html(Base64.decode(data.spIdNum));						// 피의자 주민등록번호 출력
	$("#spJob").html(Base64.decode(data.spJob));							// 피의자 직업 출력
	$("#spAddr").html(Base64.decode(data.spAddr));							// 피의자 주거 출력
	$("#rltActCriNmCdDesc").html(data.rltActCriNmCdDesc);					// 피의자 죄명 출력
}

//맵초기화
function fn_M0116_initM0116VOMap() {
	m0116VOMap={
			"cmctCnfmReqApprNum":""					// 통신사실확인자료제공요청허가신청부번호
				,"prgsNum":""							// 진행번호 
				,"rcptIncNum":""						// 사건번호
				,"rcptNum":""							// 접수번호
				,"incSpNum":""							// 피의자 번호  
				,"spNm":""								// 피의자 성명 
				,"spIdNum":""							// 피의자 주민등록번호 
				,"spJob":""								// 피의자 직업 
				,"spAddr":""							// 피의자 주거 
				,"rltActCriNmCdDesc":""					// 죄명 
				,"cmctCnfmType":""						// 종류 
				,"cmctCnfmTrgt":""						// 대상 
				,"cmctCnfmRnge":""						// 범위
				,"emgyDtaSupyDt":""						// 긴급으로자료를제공받은일시  
				,"reqDt":""								// 신청일시 
				,"isueDt":""							// 발부일시 
				,"rjctDt":""							// 기각일시  
				,"reReqDt":""							// 재신청일시  
				,"reReqIsueDt":""						// 재신청발부일시
				,"reReqRjctDt":""						// 재신청기각일시 
				,"rcptDt":""							// 수령일시 
				,"rcptPersTitl":""						// 수령자의관직 
				,"rcptPersNm":""						// 수령자의성명 
				,"poRetnDt":""							// 검찰반환연월  
				,"cmctCnfmComn":""						// 비고
				,"regUserId":""							// 등록자 
				,"nmKor":""								// 작성자
	}
	
}


//신규등록
function fn_M0116_new(){

	fn_M0116_initM0116VOMap(); //맵초기화
	fn_M0116_selectSetting(); // 데이터 세팅	
	freezeInput(false); // 입력 활성화
	$("#btnSearchInc").show(); // 검색버튼보이기
	$("#btnInsert").show(); // 저장버튼 보이기	
	$("#btnUpdate").hide(); // 수정버튼 숨기기
	$("#prgsNum").html("신규");
	$("#incNum").html(isNull(incMap.rcptIncNum) ? "(피의자 선택시 자동입력)" : incMap.rcptIncNum);					//사건번호 세팅
	$("#spIdNum").html("(피의자 선택시 자동입력)");
	$("#spJob").html("(피의자 선택시 자동입력)");
	$("#spAddr").html("(피의자 선택시 자동입력)");
	$("#rltActCriNmCdDesc").html("(피의자 선택시 자동입력)");
	$("#incNum").html(incMap.rcptIncNum);
	$("#rcptNum").val(incMap.rcptNum);
}
//등록하기
function fn_M0116_insert(){
	
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
		return;
	}
	
	setAreaMap($("#M0116"), m0116VOMap);
	m0116VOMap.rcptIncNum = $("#incNum").html();
	m0116VOMap.rcptNum = $("#rcptNum").val();
	//유효성검사
	if(m0116VOMap.incSpNum == null || m0116VOMap.incSpNum == "" || m0116VOMap.incSpNum ==" "){
		alert("피의자를 선택해주세요.");
		return;
	}
	
	goAjaxDefault("/sjpb/M/M0116insert.face",m0116VOMap,callBackFn_M0116_insertSuccess);
	
	$("#btnInsert").hide(); //저장버튼 숨기기
	
}
//등록성공함수
function callBackFn_M0116_insertSuccess(data){
	if(data == 1){
		alert("통신사실확인자료제공요청허가신청부가 등록되었습니다.");
	}else{
		alert("통신사실확인자료제공요청허가신청부 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0116_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0116_update(){
	setAreaMap($("#M0116"), m0116VOMap);
	m0116VOMap.rcptIncNum = $("#incNum").html();
	m0116VOMap.rcptNum = $("#rcptNum").val();
	
	goAjaxDefault("/sjpb/M/M0116update.face",m0116VOMap,callBackFn_M0116_updateSuccess);
}
//수정 성공함수
function callBackFn_M0116_updateSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0116_pageInit();
	freezeInput(true); // 입력 비활성화
}
//구속영장신청부 출력
function fn_M0116_prnReport() {
	var cmctCnfmReqApprNumMap = {
			"cmctCnfmReqApprNum" : document.M0122.cmctCnfmReqApprNum.value
	};
	
	//구속영장신청부 리스트 레포트 성공함수 호출
	goAjaxDefault("/sjpb/M/M0116prnReport.face", cmctCnfmReqApprNumMap, callBackFn_M0116_prnReportSuccess);
}
//구속영장신청부 출력 성공함수
function callBackFn_M0116_prnReportSuccess(data){
	M0116RTMap.rexdataset = data.qCell;
	var xmlString = objectToXml(M0116RTMap);
	$("#reptNm").val("M0116.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	//레포트 호출
	openReportService(reportForm); 
}
function fn_M0116_prnCheckReport(){
	var cmctRstrApprReqNumList = [];
	for(var i = 3; i <= qcell.getRows("data")+2; i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			cmctRstrApprReqNumList.push(qcell.getRowData(i).cmctRstrApprReqNum);
		}	
	}
	var cmctRstrApprReqNumListMap = {
			"cmctRstrApprReqNumList":cmctRstrApprReqNumList
	}
	
	if(cmctRstrApprReqNumList.length != 0){
		//구속영장신청부 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0116prnCheckReport.face", cmctRstrApprReqNumListMap, callBackFn_M0116_prnReportSuccess);
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

var m0116VOMap={
		"cmctRstrApprReqNum":""					// 통신제한조치허가신청부번호
		,"prgsNum":""							// 진행번호 
		,"rcptIncNum":""						// 사건번호
		,"rcptNum":""							// 접수번호
		,"incSpNum":""							// 피의자 번호  
		,"spNm":""								// 피의자 성명 
		,"spIdNum":""							// 피의자 주민등록번호 
		,"spJob":""								// 피의자 직업 
		,"spAddr":""							// 피의자 주거 
		,"rltActCriNmCdDesc":""					// 죄명 
		,"cmctRstrType":""						// 종류 
		,"cmctRstrWay":""						// 방법 
		,"dipTrgt":""							// 처분대상
		,"dipRnge":""							// 처분범위  
		,"rstrActnDt":""						// 긴급통신제한조치일자 
		,"apprPi":""							// 허가기간 
		,"execPla":""							// 집행장소  
		,"extsPiBeDt":""						// 연장기간시작일시  
		,"extsPiEdDt":""						// 연장기간종료일시
		,"reqApprReqDt":""						// 신청허가신청일시 
		,"reqExtsReqDt":""						// 신청연장신청일시 
		,"isueApprReqDt":""						// 발부허가신청일시 
		,"isueExtsReqDt":""						// 발부연장신청일시 
		,"rjctApprReqDt":""						// 기각허가신청일시  
		,"rjctExtsReqDt":""						// 기각연장신청일시
		,"reReqApprReqDt":""					// 재신청허가신청일시
		,"reReqExtsReqDt":""					// 재신청연장신청일시
		,"reReqIsueApprReqDt":""				// 재신청발부허가신청일시
		,"reReqIsueExtsReqDt":""				// 재신청발부연장신청일시
		,"reReqRjctApprReqDt":""				// 재신청기각허가신청일시
		,"reReqRjctExtsReqDt":""				// 재신청기각연장신청일시
		,"apprRcptDt":""						// 허가신청수령연월일
		,"apprRcptPersTitl":""					// 허가신청수령자의관직
		,"apprRcptPersNm":""					// 허가신청수령자의성명
		,"extsRcptDt":""						// 연장신청수령연월일
		,"extsRcptPersTitl":""					// 연장신청수령자의관직
		,"extsRcptPersNm":""					// 연장신청수령자의성명
		,"poRetnDt":""							// 검찰반환연월일
		,"cmctRstrComn":""						// 비고
		,"regUserId":""							// 등록자 
		,"nmKor":""								// 작성자
}
//리포트맵
var M0116RTMap = {
	rexdataset : null
}