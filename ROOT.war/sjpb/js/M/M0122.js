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
	
	fn_M0122_pageInit(); 
	
	if(parent.viewType == 'inc'){
		//피의자 검색버튼
		$("#spBtn").off("click").on("click", function() {	
			commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face?rcptNum='+incMap.rcptNum, "1050px", "435px", callBackFn_M0122_searchRcptIncSuccess);
		});
	}
	
});
//화면 진입시 동작함
function fn_M0122_pageInit(){
	qCellList=[];
	queryString = $("#m0122_searchList").serialize();
	var d = document.m0122_searchList;
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
	goAjax("/sjpb/M/M0122selectList.face",queryString,callBackFn_M0122_selectListSuccess,true);
}
//통신사실 확인자료제공 요청허가신청부 리스트 그리기.
function callBackFn_M0122_selectListSuccess(data){	

	if(data.qCell ==''|| data.qCell==' '){
		if(parent.viewType == 'inc'){
			fn_M0122_new();
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
            	{width: '100',	key: 'nmKor',			title: ['작성자','작성자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spNm',			title: ['피의자','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spIdNum',			title: ['피의자','주민등록번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spJob',			title: ['피의자','직업'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spAddr',			title: ['피의자','주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rltActCriNmCdDesc',			title: ['죄명','죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'teleOprt',			title: ['전기통신사업자','전기통신사업자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'reqResn',			title: ['요청사유','요청사유'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'subsConn',			title: ['해당가입자와의 연관성','해당가입자와의 연관성'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'requMatr',			title: ['필요한 자료의 범위','필요한 자료의 범위'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'reClamResn',			title: ['재청구의 취지 및 이유','재청구의 취지 및 이유'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'prgsNum',			title: ['진행번호','진행번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},	
            	{width: '100',	key: 'cmctCnfmType',			title: ['종류','종류'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cmctCnfmTrgt',			title: ['대상','대상'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cmctCnfmRnge',			title: ['범위','범위'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'emgyDtaSupyDt',			title: ['긴급으로 자료를 제공받은 일시','긴급으로 자료를 제공받은 일시'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'reqDt',			title: ['신청 및 발부존류일시','신청'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'isueDt',			title: ['신청 및 발부존류일시','발부'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rjctDt',			title: ['신청 및 발부존류일시','기각'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'reReqDt',			title: ['신청 및 발부존류일시','재신청'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'reReqIsueDt',			title: ['신청 및 발부존류일시','발부'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'reReqRjctDt',			title: ['신청 및 발부존류일시','기각'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rcptDt',			title: ['수령 및 반환','수령연월일'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rcptPersTitl',			title: ['수령 및 반환','수령자의 관직'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rcptPersNm',			title: ['수령 및 반환','수령자의 이름'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'poRetnDt',			title: ['수령 및 반환','검찰반환연월일'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cmctCnfmComn',			title: ['비고','비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
            	
            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(2, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0122VOMap = qcell.getRowData(2);
	    	fn_M0122_selectSetting();
	    	//수정세팅
	    	updateYN();
		}
}
//통신사실 확인자료제공 요청허가신청부 셀클릭 이벤트
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
			fn_M0122_initM0122VOMap(); // 맵초기화
			m0122VOMap = qcell.getRowData(rowIdx);
			$("#afterDiv").show();
			//통신사실 확인자료제공 요청허가신청부 데이터 세팅
			fn_M0122_selectSetting();
			
			//수정세팅
			updateYN();
		}
	}
}
//통신사실 확인자료제공 요청허가신청부 데이터 세팅
function fn_M0122_selectSetting(){
	
	getAreaMap($("#M0122"), m0122VOMap);
	$("#incNum").html(m0122VOMap.rcptIncNum);
	$("#rcptNum").val(m0122VOMap.rcptNum);

	
}

//수정 세팅
function updateYN(){
	if(parent.viewType == 'inc'){
		if(m0122VOMap.regUserId == $("#userId").val() ){
			freezeInput(false); // 입력 활성화
			$("#btnUpdate").show();  //수정버튼 보이기
		}else{
			freezeInput(true); // 입력 비활성화
			$("#btnUpdate").hide();  //수정버튼 숨기기
		}
		$("#btnInsert").hide();  //저장버튼 숨기기
	}
	$("#btnReqPrtArstWrnt").show();// 신청서 출력 버튼 보이기
	$("#btnPrtArstWrnt").show();// 대장 출력 버튼 보이기
}

//사건검색 성공함수
function callBackFn_M0122_searchRcptIncSuccess(data){
	$("#incSpNum").val(data.incSpNum);						
	$("input[name=spNm]").val(Base64.decode(data.spNm));					// 피의자 성명 출력
	$("#spIdNum").html(Base64.decode(data.spIdNum));						// 피의자 주민등록번호 출력
	$("#spJob").html(Base64.decode(data.spJob));							// 피의자 직업 출력
	$("#spAddr").html(Base64.decode(data.spAddr));							// 피의자 주거 출력
	$("#rltActCriNmCdDesc").html(data.rltActCriNmCdDesc);					// 피의자 죄명 출력
}

//맵초기화
function fn_M0122_initM0122VOMap() {
	m0122VOMap={
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
				,"docNum":""							// 문서번호
				,"teleOprt":""							// 전기통신사업자
				,"reqResn":""							// 요청사유
				,"subsConn":""							// 해당가입자와의 연관성
				,"requMatr":""							// 필요한 자료의 범위
				,"reClamResn":""						// 재청구의 취지 및 이유
	}
	
}


//신규등록
function fn_M0122_new(){
	
	$("#afterDiv").hide();//대장 입력폼 숨기기
	$("#btnReqPrtArstWrnt").hide();// 신청서 출력 버튼 숨기기
	$("#btnPrtArstWrnt").hide();// 대장 출력 버튼 숨기기
	
	fn_M0122_initM0122VOMap(); //맵초기화
	fn_M0122_selectSetting(); // 데이터 세팅	
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
function fn_M0122_insert(){
	
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
		return;
	}
	
	setAreaMap($("#M0122"), m0122VOMap);
	m0122VOMap.rcptIncNum = $("#incNum").html();
	m0122VOMap.rcptNum = $("#rcptNum").val();
	//유효성검사
	if(m0122VOMap.incSpNum == null || m0122VOMap.incSpNum == "" || m0122VOMap.incSpNum ==" "){
		alert("피의자를 선택해주세요.");
		return;
	}
	
	goAjaxDefault("/sjpb/M/M0122insert.face",m0122VOMap,callBackFn_M0122_insertSuccess);
	
	$("#btnInsert").hide(); //저장버튼 숨기기
	
}
//등록성공함수
function callBackFn_M0122_insertSuccess(data){
	if(data == 1){
		alert("통신사실확인자료제공요청허가신청부가 등록되었습니다.");
	}else{
		alert("통신사실확인자료제공요청허가신청부 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0122_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0122_update(){
	setAreaMap($("#M0122"), m0122VOMap);
	m0122VOMap.rcptIncNum = $("#incNum").html();
	m0122VOMap.rcptNum = $("#rcptNum").val();
	
	goAjaxDefault("/sjpb/M/M0122update.face",m0122VOMap,callBackFn_M0122_updateSuccess);
}
//수정 성공함수
function callBackFn_M0122_updateSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0122_pageInit();
	freezeInput(true); // 입력 비활성화
}
//통신사실 확인자료제공 요청허가신청부 출력
function fn_M0122_prtReport() {
	var cmctCnfmReqApprNumMap = {
			"cmctCnfmReqApprNum" : document.M0122.cmctCnfmReqApprNum.value
	};
	
	//구속영장신청부 리스트 레포트 성공함수 호출
	goAjaxDefault("/sjpb/M/M0122prnReport.face", cmctCnfmReqApprNumMap, callBackFn_M0122_prnReportSuccess);
}
//통신사실 확인자료제공 요청허가신청부 출력 성공함수
function callBackFn_M0122_prnReportSuccess(data){
	M0122RTMap.rexdataset = data.rexdataset;
	var xmlString = objectToXml(M0122RTMap);
	$("#reptNm").val("M0122.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	//레포트 호출
	openReportService(reportForm); 
}
function fn_M0122_prnCheckReport(){
	var cmctCnfmReqApprNumList = [];
	for(var i = 2; i <= qcell.getRows("data")+1; i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			cmctCnfmReqApprNumList.push(qcell.getRowData(i).cmctCnfmReqApprNum);
		}	
	}
	var cmctCnfmReqApprNumListMap = {
			"cmctCnfmReqApprNumList":cmctCnfmReqApprNumList
	}
	
	if(cmctCnfmReqApprNumList.length != 0){
		//통신사실 확인자료제공 요청허가신청부 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0122prnCheckReport.face", cmctCnfmReqApprNumListMap, callBackFn_M0122_prnReportSuccess);
	}else{
		alert("출력할 대상을 선택해주세요.");
		return;
	}
}
//입력화면 비/활성화
function freezeInput(tf) {
	$("#contentsArea input").attr("disabled",tf);
	$("#contentsArea select").attr("disabled",tf);
	$("#contentsArea a").attr("disabled",tf);
}

//신청서 출력
function requestReport(){
	$("#reptNm").val("M0203.crf"); //레포트 파일명
	$("#SEQNUM").val(m0122VOMap.cmctCnfmReqApprNum);
	//레포트 호출
	openReportServiceFSS(reportForm); 
}

var m0122VOMap={
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
		,"docNum":""							// 문서번호
		,"teleOprt":""							// 전기통신사업자
		,"reqResn":""							// 요청사유
		,"subsConn":""							// 해당가입자와의 연관성
		,"requMatr":""							// 필요한 자료의 범위
		,"reClamResn":""						// 재청구의 취지 및 이유
}
//리포트맵
var M0122RTMap = {
	rexdataset : null
}