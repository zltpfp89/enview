var qcell;
var queryString=$("#m0106_searchList").serialize();
var qCellList=[];
var rowIdx=3;
$(document).ready(function(){
	fn_M0106_pageInit();     
});
//화면 진입시 동작함
function fn_M0106_pageInit(){
	qCellList=[];
	goAjax("/sjpb/M/M0106selectList.face",queryString,callBackFn_M0106_selectListSuccess);
}
//긴급체포원부 리스트 그리기.
function callBackFn_M0106_selectListSuccess(data){	
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
            	{width: '100',	key: 'execNum',			title: ['집행번호','집행번호','집행번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rcptIncNum',			title: ['사건번호','사건번호','사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spNm',			title: ['피의자','성명','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spIdNum',			title: ['피의자','주민등록번호','주민등록번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spJob',			title: ['피의자','직업','직업'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spAddr',			title: ['피의자','주거','주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rltActCriNmCdDesc',			title: ['죄명','죄명','죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'emgyCathDocFillDt',			title: ['긴급체포작성연월일','긴급체포작성연월일','긴급체포작성연월일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'emgyCathDt',			title: ['긴급체포','체포한 일시','체포한 일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'emgyCathPla',			title: ['긴급체포','체포한 장소','체포한 장소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'emgyCathPersTitl',			title: ['긴급체포','체포자의 관직','체포자의 관직'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'emgyCathPersNm',			title: ['긴급체포','체포자의 성명','체포자의 성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'emgyCathCstdDt',			title: ['긴급체포','인치한 일시','인치한 일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'emgyCathCstdPla',			title: ['긴급체포','인치한 장소','인치한 장소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'emgyCathDetnDt',			title: ['긴급체포','구금한 일시','구금한 일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'emgyCathDetnPla',			title: ['긴급체포','구금한 장소','구금한 장소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'pstrCmdApprDt',			title: ['긴급체포','검사지휘','승인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'pstrCmdNonApprDt',			title: ['긴급체포','검사지휘','불승인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'relsDt',			title: ['석방','일시','일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'relsRsn',			title: ['석방','사유','사유'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'arstWrntReqBkNum',			title: ['구속영장신청','신청부번호','신청부번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'arstWrntIsueDt',			title: ['구속영장신청','발부연월일','발부연월일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'sjpbEmgyCathBookComn',			title: ['비고','비고','비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(3, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0106VOMap = qcell.getRowData(3);
	    	fn_M0106_selectEmgyCathSetting();
	    	//수정세팅
	    	updateYN();
		}
}
//긴급체포원부 셀클릭 이벤트
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
	
	m0106VOMap = qcell.getRowData(rowIdx);

	//긴급체포원부 데이터 세팅
	fn_M0106_selectEmgyCathSetting();
	//수정세팅
	updateYN();
}
//긴급체포원부 데이터 세팅
function fn_M0106_selectEmgyCathSetting(){	
	getAreaMap($("#M0106EmgyCath"), m0106VOMap);
	Fn_M_Date(m0106VOMap.emgyCathDt,"emgyCathDt");
	Fn_M_Date(m0106VOMap.emgyCathCstdDt,"emgyCathCstdDt");
	Fn_M_Date(m0106VOMap.emgyCathDetnDt,"emgyCathDetnDt");
	Fn_M_Date(m0106VOMap.pstrCmdApprDt,"pstrCmdApprDt");
	Fn_M_Date(m0106VOMap.pstrCmdNonApprDt,"pstrCmdNonApprDt");

}

//수정 가능 버튼 보이기 여부
function updateYN(){
	if(m0106VOMap.regUserId == $("#userId").val() ){
		freezeInput(false); // 입력 활성화
		$("#btnUpdateEmgyCath").show();  //수정버튼 보이기
	}else{
		freezeInput(true); // 입력 비활성화
		$("#btnUpdateEmgyCath").hide();  //수정버튼 숨기기
	}

}
//사건검색 팝업창
function fn_M0106_searchIncSp(){
	commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face', "1050px", "550px", callBackFn_M0106_searchIncSpSuccess);
}
//사건검색 성공함수
function callBackFn_M0106_searchIncSpSuccess(data){
	$("#rcptNum").val(data.rcptNum);
	$("#rcptIncNum").val(data.incNum);
	$("#incSpNum").val(data.incSpNum);
	$("#spNm").html(Base64.decode(data.spNm));								// 피의자 성명 출력
	$("#spIdNum").html(Base64.decode(data.spIdNum));						// 피의자 주민등록번호 출력
	$("#spJob").html(Base64.decode(data.spJob));							// 피의자 직업 출력
	$("#spAddr").html(Base64.decode(data.spAddr));							// 피의자 주거 출력
	$("#rltActCriNmCdDesc").html(data.rltActCriNmCdDesc);					// 피의자 죄명 출력
}
//긴급체포원부 출력
function fn_M0106_prtEmgyCathReport() {
	
	var sjpbEmgyCathBookNumMap ={
			sjpbEmgyCathBookNum:m0106VOMap.sjpbEmgyCathBookNum
	};
	
	//긴급체포원부 리스트 레포트 성공함수 호출
	goAjaxDefault("/sjpb/M/M0106selectList.face",sjpbEmgyCathBookNumMap, callBackFn_M0106_prtEmgyCathReportSuccess);
}
//긴급체포원부 출력
function fn_M0106_prtEmgyCathListReport() {
	queryString = $("#m0106_searchList").serialize();
	
	//긴급체포원부 리스트 레포트 성공함수 호출
	goAjaxDefault("/sjpb/M/M0106selectList.face",queryString, callBackFn_M0106_prtEmgyCathReportSuccess);
}

//긴급체포원부 출력 성공함수
function callBackFn_M0106_prtEmgyCathReportSuccess(data){
	M0106RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0106RTMap);
	$("#reptNm").val("M0106.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	console.log(xmlString);
	//레포트 호출
	openReportService(reportForm); 
}
//맵초기화
function fn_M0106_initM0106VOMap() {
	m0106VOMap={
			"sjpbEmgyCathBookNum":""		// 긴급체포원부번호
			,"execNum":""					// 집행번호
			,"rcptNum":""					// 접수번호
			,"rcptIncNum":""				// 사건번호
			,"incSpNum":""					// 사건피의자번호
			,"spNm":""						// 피의자 성명
			,"spIdNum":""					// 피의자 주민등록번호
			,"spJob":""						// 피의자 직업
			,"spAddr":""					// 피의자 주소
			,"rltActCriNmCdDesc":""			// 죄명
			,"emgyCathDocFillDt":""			// 긴급체포서 작성일시
			,"emgyCathDt":""				// 긴급체포일
			,"emgyCathPla":""				// 긴급체포장소
			,"emgyCathPersTitl":""			// 긴급체포자 관직
			,"emgyCathPersNm":""			// 긴급페포자 성명
			,"emgyCathCstdDt":""			// 긴급체포 인치일시
			,"emgyCathCstdPla":""			// 긴급체포인치일시
			,"emgyCathDetnDt":""			// 긴급체포인치일시
			,"emgyCathDetnPla":""			// 긴급체포구금장소			
			,"pstrCmdApprDt":""				// 검사지휘승인일시			
			,"pstrCmdNonApprDt":""			// 검사지휘불승인일시		
			,"relsDt":""					// 석방일시		
			,"relsRsn":""					// 석방사유
			,"arstWrntReqBkNum":""			// 구속영장신청부번호
			,"arstWrntIsueDt":""			// 구속영장발부일시
			,"sjpbEmgyCathBookComn":""		// 비고
			,"regUserId":""					// 등록자
	}
}

//신규등록
function fn_M0106_newEmgyCath(){
	$("#contentsArea").show();
	fn_M0106_initM0106VOMap(); //맵초기화
	fn_M0106_selectEmgyCathSetting(); // 데이터 세팅	
	freezeInput(false); // 입력 활성화
	$("#btnSearchInc").show(); // 검색버튼보이기
	$("#btnInsertEmgyCath").show(); // 저장버튼 보이기	
	$("#btnUpdateEmgyCath").hide(); // 수정버튼 숨기기	
	
}
//등록하기
function fn_M0106_insertEmgyCath(){
	//유효성검사
	
	setAreaMap($("#M0106EmgyCath"), m0106VOMap);
	m0106VOMap.rcptNum = $("#rcptNum").val();
	m0106VOMap.incSpNum = $("#incSpNum").val();
	m0106VOMap.emgyCathDt = Fn_M_setDate($("#emgyCathDtCal").val(),$("#emgyCathDtHour").val(),$("#emgyCathDtMin").val());
	m0106VOMap.emgyCathCstdDt = Fn_M_setDate($("#emgyCathCstdDtCal").val(),$("#emgyCathCstdDtHour").val(),$("#emgyCathCstdDtMin").val());
	m0106VOMap.emgyCathDetnDt = Fn_M_setDate($("#emgyCathDetnDtCal").val(),$("#emgyCathDetnDtHour").val(),$("#emgyCathDetnDtMin").val());
	m0106VOMap.pstrCmdApprDt = Fn_M_setDate($("#pstrCmdApprDtCal").val(),$("#pstrCmdApprDtHour").val(),$("#pstrCmdApprDtMin").val());
	m0106VOMap.pstrCmdNonApprDt = Fn_M_setDate($("#pstrCmdNonApprDtCal").val(),$("#pstrCmdNonApprDtHour").val(),$("#pstrCmdNonApprDtMin").val());

	goAjaxDefault("/sjpb/M/M0106insertEmgyCath.face",m0106VOMap,callBackFn_M0106_insertEmgyCathSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsertEmgyCath").hide(); //저장버튼 숨기기

}

//등록성공함수 호출
function callBackFn_M0106_insertEmgyCathSuccess(data){
	if(data == 1){
		alert("긴급체포원부가 등록되었습니다.");
	}else{
		alert("긴급체포원부 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0106_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0106_updateEmgyCath(){
	
	setAreaMap($("#M0106EmgyCath"), m0106VOMap);
	m0106VOMap.rcptNum = $("#rcptNum").val();
	m0106VOMap.rcptIncNum = $("#rcptIncNum").val();

	m0106VOMap.emgyCathDt = Fn_M_setDate($("#emgyCathDtCal").val(),$("#emgyCathDtHour").val(),$("#emgyCathDtMin").val());
	m0106VOMap.emgyCathCstdDt = Fn_M_setDate($("#emgyCathCstdDtCal").val(),$("#emgyCathCstdDtHour").val(),$("#emgyCathCstdDtMin").val());
	m0106VOMap.emgyCathDetnDt = Fn_M_setDate($("#emgyCathDetnDtCal").val(),$("#emgyCathDetnDtHour").val(),$("#emgyCathDetnDtMin").val());
	m0106VOMap.pstrCmdApprDt = Fn_M_setDate($("#pstrCmdApprDtCal").val(),$("#pstrCmdApprDtHour").val(),$("#pstrCmdApprDtMin").val());
	m0106VOMap.pstrCmdNonApprDt = Fn_M_setDate($("#pstrCmdNonApprDtCal").val(),$("#pstrCmdNonApprDtHour").val(),$("#pstrCmdNonApprDtMin").val());
	
	goAjaxDefault("/sjpb/M/M0106updateEmgyCath.face",m0106VOMap,callBackFn_M0106_updateEmgyCathSuccess);
}
//수정성공함수 호출
function callBackFn_M0106_updateEmgyCathSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0106_pageInit();
	freezeInput(true); // 입력 비활성화
}
//입력화면 비/활성화
function freezeInput(tf) {
	$("#contentsArea input").attr("disabled",tf);
	$("#contentsArea select").attr("disabled",tf);
	$("#contentsArea a").attr("disabled",tf);
}
//초기화
function fn_M0106_init(form){
	$("#"+form)[0].reset();	
}
//맵
var m0106VOMap={
		"sjpbEmgyCathBookNum":""		// 긴급체포원부번호
		,"execNum":""					// 집행번호
		,"rcptNum":""					// 접수번호
		,"rcptIncNum":""				// 사건번호
		,"incSpNum":""					// 사건피의자번호
		,"spNm":""						// 피의자 성명
		,"spIdNum":""					// 피의자 주민등록번호
		,"spJob":""						// 피의자 직업
		,"spAddr":""					// 피의자 주소
		,"rltActCriNmCdDesc":""			// 죄명
		,"emgyCathDocFillDt":""			// 긴급체포서 작성일시
		,"emgyCathDt":""				// 긴급체포일
		,"emgyCathPla":""				// 긴급체포장소
		,"emgyCathPersTitl":""			// 긴급체포자 관직
		,"emgyCathPersNm":""			// 긴급페포자 성명
		,"emgyCathCstdDt":""			// 긴급체포 인치일시
		,"emgyCathCstdPla":""			// 긴급체포인치일시
		,"emgyCathDetnDt":""			// 긴급체포인치일시
		,"emgyCathDetnPla":""			// 긴급체포구금장소			
		,"pstrCmdApprDt":""				// 검사지휘승인일시			
		,"pstrCmdNonApprDt":""			// 검사지휘불승인일시		
		,"relsDt":""					// 석방일시		
		,"relsRsn":""					// 석방사유
		,"arstWrntReqBkNum":""			// 구속영장신청부번호
		,"arstWrntIsueDt":""			// 구속영장발부일시
		,"sjpbEmgyCathBookComn":""		// 비고
		,"regUserId":""					// 등록자
}
//리포트맵
var M0106RTMap = {
	rexdataset : null
}