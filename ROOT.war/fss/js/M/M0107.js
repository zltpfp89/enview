var qcell;
var queryString=$("#m0107_searchList").serialize();
var qCellList=[];
var rowIdx=3;
$(document).ready(function(){
	fn_M0107_pageInit();     
});
//화면 진입시 동작함
function fn_M0107_pageInit(){
	qCellList=[];
	goAjax("/sjpb/M/M0107selectList.face",queryString,callBackFn_M0107_selectListSuccess);
}
//현행범인체포원부 리스트 그리기.
function callBackFn_M0107_selectListSuccess(data){	
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
            	{width: '100',	key: 'execNum',			title: ['진행번호','진행번호','진행번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rcptIncNum',			title: ['사건번호','사건번호','사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spNm',			title: ['피의자','성명','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spIdNum',			title: ['피의자','주민등록번호','주민등록번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spJob',			title: ['피의자','직업','직업'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spAddr',			title: ['피의자','주거','주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rltActCriNmCdDesc',			title: ['죄명','죄명','죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'flgtOfdrCathDocFillDt',			title: ['현행범인체포서 또는 현행범인인수서 작성일','현행범인체포서 또는 현행범인인수서 작성일','현행범인체포서 또는 현행범인인수서 작성일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathDt',			title: ['현행범인체포 및 인수','체포한 일시','체포한 일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathPla',			title: ['현행범인체포 및 인수','체포한 장소','체포한 장소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathPersNm',			title: ['현행범인체포 및 인수','체포자','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathPersSsn',			title: ['현행범인체포 및 인수','체포자','주민등록번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathPersAddr',			title: ['현행범인체포 및 인수','체포자','주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathPersTitl',			title: ['현행범인체포 및 인수','체포자','관직'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'acqsDt',			title: ['현행범인체포 및 인수','인수한 일시','인수한 일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'acqsPla',			title: ['현행범인체포 및 인수','인수한 장소','인수한 장소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'acqsPersTitl',			title: ['현행범인체포 및 인수','인수한 자','관직'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'acqsPersNm',			title: ['현행범인체포 및 인수','인수한 자','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cstdDt',			title: ['현행범인체포 및 인수','인치한 일시','인치한 일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cstdPla',			title: ['현행범인체포 및 인수','인치한 장소','인치한 장소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'detnDt',			title: ['현행범인체포 및 인수','구금한 일시','구금한 일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'detnPla',			title: ['현행범인체포 및 인수','구금한 장소','구금한 장소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'relsDt',			title: ['석방','일시','일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'relsRsn',			title: ['석방','사유','사유'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'arstWrntReqBkNum',			title: ['구속영장신청','신청부번호','신청부번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'arstWrntReqIsueDt',			title: ['구속영장신청','발부연월일','발부연월일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'flgtOfdrCathBookComn',			title: ['비고','비고','비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
            	

            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(3, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0107VOMap = qcell.getRowData(3);
	    	fn_M0107_selectFlgtOfdrCathSetting();
	    	//수정세팅
	    	updateYN();
		}
}
//현행범인체포원부 셀클릭 이벤트
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
	
	m0107VOMap = qcell.getRowData(rowIdx);

	//현행범인체포원부 데이터 세팅
	fn_M0107_selectFlgtOfdrCathSetting();
	//수정세팅
	updateYN();
}
//현행범인체포원부 데이터 세팅
function fn_M0107_selectFlgtOfdrCathSetting(){	
	getAreaMap($("#M0107FlgtOfdrCath"), m0107VOMap);
	Fn_M0107_Date(m0107VOMap.cathDt,"cathDt");
	Fn_M0107_Date(m0107VOMap.acqsDt,"acqsDt");
	Fn_M0107_Date(m0107VOMap.cstdDt,"cstdDt");
	Fn_M0107_Date(m0107VOMap.detnDt,"detnDt");
	Fn_M0107_Date(m0107VOMap.relsDt,"relsDt");

}
function Fn_M0107_Date(data,str){
	var year = isNull(data) ? "" : data.substring(0,4)+"-";
	var Month = isNull(data) ? "" : data.substring(4,6)+"-";
	var Day = isNull(data) ? "" : data.substring(6,8);
	var Hour = isNull(data) ? "" : data.substring(8,10);
	var Min = isNull(data) ? "" : data.substring(10,12);
	$("#"+str+"Cal").val(year+Month+Day);
	$("#"+str+"Hour").val(Hour);
	$("#"+str+"Min").val(Min);
}
//수정 가능 버튼 보이기 여부
function updateYN(){
	if(m0107VOMap.regUserId == $("#userId").val() ){
		freezeInput(false); // 입력 활성화
		$("#btnUpdateFlgtOfdrCath").show();  //수정버튼 보이기
	}else{
		freezeInput(true); // 입력 비활성화
		$("#btnUpdateFlgtOfdrCath").hide();  //수정버튼 숨기기
	}

}
//사건검색 팝업창
function fn_M0107_searchIncSp(){
	commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face', "1050px", "550px", callBackFn_M0107_searchIncSpSuccess);
}
//사건검색 성공함수
function callBackFn_M0107_searchIncSpSuccess(data){
	$("#rcptNum").val(data.rcptNum);
	$("#rcptIncNum").val(data.incNum);
	$("#incSpNum").val(data.incSpNum);
	$("#spNm").html(Base64.decode(data.spNm));								// 피의자 성명 출력
	$("#spIdNum").html(Base64.decode(data.spIdNum));						// 피의자 주민등록번호 출력
	$("#spJob").html(Base64.decode(data.spJob));							// 피의자 직업 출력
	$("#spAddr").html(Base64.decode(data.spAddr));							// 피의자 주거 출력
	$("#rltActCriNmCdDesc").html(data.rltActCriNmCdDesc);					// 피의자 죄명 출력
}
//현행범인체포원부 출력
function fn_M0107_prtFlgtOfdrCathReport() {
	queryString = $("#m0107_searchList").serialize();
	
	//현행범인체포원부 리스트 레포트 성공함수 호출
	goAjaxDefault("/sjpb/M/M0107selectList.face",queryString, callBackFn_M0107_prtFlgtOfdrCathReportSuccess);
}
//현행범인체포원부 출력 성공함수
function callBackFn_M0107_prtFlgtOfdrCathReportSuccess(data){
	M0107RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0107RTMap);
	$("#reptNm").val("M0107.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	console.log(xmlString);
	//레포트 호출
	openReportService(reportForm); 
}
//맵초기화
function fn_M0107_initM0107VOMap() {
	m0107VOMap={
			"flgtOfdrCathBookNum":""		// 현행범인체포원부번호
			,"execNum":""					// 진행번호
			,"rcptNum":""					// 접수번호
			,"rcptIncNum":""				// 사건번호
			,"incSpNum":""					// 사건피의자번호
			,"spNm":""						// 피의자 성명
			,"spIdNum":""					// 피의자 주민등록번호
			,"spJob":""						// 피의자 직업
			,"spAddr":""					// 피의자 주소
			,"rltActCriNmCdDesc":""			// 죄명
			,"flgtOfdrCathDocFillDt":""		// 현행범인체포서작성일
			,"cathDt":""					// 체포일시
			,"cathPla":""					// 체포장소
			,"cathPersSsn":""				// 체포자 주민등록번호
			,"cathPersAddr":""				// 체포자 주거
			,"cathPersTitl":""				// 체포자 관직
			,"cathPersNm":""				// 체포자 성명
			,"acqsDt":""					// 인수일시
			,"acqsPla":""					// 인수장소
			,"acqsPersTitl":""				// 인수자 관직
			,"acqsPersNm":""				// 인수자 성명
			,"cstdDt":""					// 인치일시
			,"cstdPla":""					// 인치장소
			,"detnDt":""					// 구금일시
			,"detnPla":""					// 구금장소					
			,"relsDt":""					// 석방일시		
			,"relsRsn":""					// 석방사유
			,"arstWrntReqBkNum":""			// 구속영장신청부번호
			,"arstWrntReqIsueDt":""			// 구속영장발부일시
			,"flgtOfdrCathBookComn":""		// 비고
			,"regUserId":""					// 등록자
	}
}

//신규등록
function fn_M0107_newFlgtOfdrCath(){
	$("#contentsArea").show();
	fn_M0107_initM0107VOMap(); //맵초기화
	fn_M0107_selectFlgtOfdrCathSetting(); // 데이터 세팅	
	freezeInput(false); // 입력 활성화
	$("#btnSearchInc").show(); // 검색버튼보이기
	$("#btnInsertFlgtOfdrCath").show(); // 저장버튼 보이기	
	$("#btnUpdateFlgtOfdrCath").hide(); // 수정버튼 숨기기	
	
}
//등록하기
function fn_M0107_insertFlgtOfdrCath(){
	//유효성검사
	
	setAreaMap($("#M0107FlgtOfdrCath"), m0107VOMap);
	m0107VOMap.rcptNum = $("#rcptNum").val();
	m0107VOMap.incSpNum = $("#incSpNum").val();
	m0107VOMap.cathDt = Fn_M0107_setDate($("#cathDtCal").val(),$("#cathDtHour").val(),$("#cathDtMin").val());
	m0107VOMap.acqsDt = Fn_M0107_setDate($("#acqsDtCal").val(),$("#acqsDtHour").val(),$("#acqsDtMin").val());
	m0107VOMap.cstdDt = Fn_M0107_setDate($("#cstdDtCal").val(),$("#cstdDtHour").val(),$("#cstdDtMin").val());
	m0107VOMap.detnDt = Fn_M0107_setDate($("#detnDtCal").val(),$("#detnDtHour").val(),$("#detnDtMin").val());
	m0107VOMap.relsDt = Fn_M0107_setDate($("#relsDtCal").val(),$("#relsDtHour").val(),$("#relsDtMin").val());
	
	goAjaxDefault("/sjpb/M/M0107insertFlgtOfdrCath.face",m0107VOMap,callBackFn_M0107_insertFlgtOfdrCathSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsertFlgtOfdrCath").hide(); //저장버튼 숨기기

}
function Fn_M0107_setDate(Cal,Min,Hour){
	var Year = isNull(Cal) ? "" : Cal.substring(0,4);
	var Month = isNull(Cal) ? "" : Cal.substring(5,7);
	var Day = isNull(Cal) ? "" : Cal.substring(8,10);
	var Hour = isNull(Min) ? "" : ("00"+Min).slice(-2);
	var Min = isNull(Hour) ? "" : ("00"+Hour).slice(-2);
	return Year+Month+Day+Hour+Min;
}
//등록성공함수 호출
function callBackFn_M0107_insertFlgtOfdrCathSuccess(data){
	if(data == 1){
		alert("현행범인체포원부가 등록되었습니다.");
	}else{
		alert("현행범인체포원부 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0107_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0107_updateFlgtOfdrCath(){
	
	setAreaMap($("#M0107FlgtOfdrCath"), m0107VOMap);
	m0107VOMap.rcptNum = $("#rcptNum").val();
	m0107VOMap.rcptIncNum = $("#rcptIncNum").val();

	m0107VOMap.cathDt = Fn_M0107_setDate($("#cathDtCal").val(),$("#cathDtHour").val(),$("#cathDtMin").val());
	m0107VOMap.acqsDt = Fn_M0107_setDate($("#acqsDtCal").val(),$("#acqsDtHour").val(),$("#acqsDtMin").val());
	m0107VOMap.cstdDt = Fn_M0107_setDate($("#cstdDtCal").val(),$("#cstdDtHour").val(),$("#cstdDtMin").val());
	m0107VOMap.detnDt = Fn_M0107_setDate($("#detnDtCal").val(),$("#detnDtHour").val(),$("#detnDtMin").val());
	m0107VOMap.relsDt = Fn_M0107_setDate($("#relsDtCal").val(),$("#relsDtHour").val(),$("#relsDtMin").val());
	
	goAjaxDefault("/sjpb/M/M0107updateFlgtOfdrCath.face",m0107VOMap,callBackFn_M0107_updateFlgtOfdrCathSuccess);
}
//수정성공함수 호출
function callBackFn_M0107_updateFlgtOfdrCathSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0107_pageInit();
	freezeInput(true); // 입력 비활성화
}
//입력화면 비/활성화
function freezeInput(tf) {
	$("#contentsArea input").attr("disabled",tf);
	$("#contentsArea select").attr("disabled",tf);
	$("#contentsArea a").attr("disabled",tf);
}
//초기화
function fn_M0107_init(form){
	$("#"+form)[0].reset();	
}
//맵
var m0107VOMap={
		"flgtOfdrCathBookNum":""		// 현행범인체포원부번호
		,"execNum":""					// 진행번호
		,"rcptNum":""					// 접수번호
		,"rcptIncNum":""				// 사건번호
		,"incSpNum":""					// 사건피의자번호
		,"spNm":""						// 피의자 성명
		,"spIdNum":""					// 피의자 주민등록번호
		,"spJob":""						// 피의자 직업
		,"spAddr":""					// 피의자 주소
		,"rltActCriNmCdDesc":""			// 죄명
		,"flgtOfdrCathDocFillDt":""		// 현행범인체포서작성일
		,"cathDt":""					// 체포일시
		,"cathPla":""					// 체포장소
		,"cathPersSsn":""				// 체포자 주민등록번호
		,"cathPersAddr":""				// 체포자 주거
		,"cathPersTitl":""				// 체포자 관직
		,"cathPersNm":""				// 체포자 성명
		,"acqsDt":""					// 인수일시
		,"acqsPla":""					// 인수장소
		,"acqsPersTitl":""				// 인수자 관직
		,"acqsPersNm":""				// 인수자 성명
		,"cstdDt":""					// 인치일시
		,"cstdPla":""					// 인치장소
		,"detnDt":""					// 구금일시
		,"detnPla":""					// 구금장소					
		,"relsDt":""					// 석방일시		
		,"relsRsn":""					// 석방사유
		,"arstWrntReqBkNum":""			// 구속영장신청부번호
		,"arstWrntReqIsueDt":""			// 구속영장발부일시
		,"flgtOfdrCathBookComn":""		// 비고
		,"regUserId":""					// 등록자
}
//리포트맵
var M0107RTMap = {
	rexdataset : null
}