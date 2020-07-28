var qcell;
//var queryString=$("#m0107_searchList").serialize();
var queryString;
var qCellList=[];
var rowIdx=3;

//0. 2018.11.19 추가 S
var incMap;			//사건VO 맵
//2018.11.19 추가 E

$(document).ready(function(){
	//1. 2018.11.19 추가 S
	incMap = setUiRcptNum(parent);
	//2018.11.19 추가 E
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
	}
	fn_M0107_pageInit();  
	
	if(parent.viewType == 'inc'){
		//피의자 검색버튼
		$("#spBtn").off("click").on("click", function() {	
			commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face?rcptNum='+incMap.rcptNum, "1050px", "435px", callBackFn_M0107_searchIncSpSuccess);
		});
	}
	
});
//화면 진입시 동작함
function fn_M0107_pageInit(){
	qCellList=[];
	var queryString=$("#m0107_searchList").serialize();
	var d = document.m0107_searchList;
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
	//1. 2018.11.19 추가 S
	//검색조건 노출
	//사건에서 보여질 경우, 사건에 필요한것만 노출 (본인데이터만)
	if(parent.viewType == 'inc'){
		queryString += "&rcptNumSc="+incMap.rcptNum;
	}
	//1. 2018.11.19 추가 E
	//2. 2018.11.19 추가 S 검색관련 rcptNum(Sc) VO, sql에 추가 
	goAjax("/sjpb/M/M0107selectList.face",queryString,callBackFn_M0107_selectListSuccess,true);
	
}
//현행범인체포원부 리스트 그리기.
function callBackFn_M0107_selectListSuccess(data){	

	if(data.qCell ==''|| data.qCell==' '){
		if(parent.viewType == 'inc'){
			fn_M0107_newFlgtOfdrCath();
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
            	{width: '100',	key: 'execNum',			title: ['진행번호','진행번호','진행번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '150',	key: 'rcptIncNum',			title: ['사건번호','사건번호','사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'nmKor',			title: ['작성자','작성자','작성자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spNm',			title: ['피의자','성명','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spIdNum',			title: ['피의자','주민등록번호','주민등록번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spJob',			title: ['피의자','직업','직업'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spAddr',			title: ['피의자','주거','주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rltActCriNmCdDesc',			title: ['죄명','죄명','죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'flgtOfdrCathDocFillDt',			title: ['현행범인체포서 또는 현행범인인수서 작성일','현행범인체포서 또는 현행범인인수서 작성일','현행범인체포서 또는 현행범인인수서 작성일'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathDt',			title: ['현행범인체포 및 인수','체포한 일시','체포한 일시'],		sort:true, move:true, resize: true,options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh시 mm분"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathPla',			title: ['현행범인체포 및 인수','체포한 장소','체포한 장소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathPersNm',			title: ['현행범인체포 및 인수','체포자','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathPersSsn',			title: ['현행범인체포 및 인수','체포자','주민등록번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathPersAddr',			title: ['현행범인체포 및 인수','체포자','주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathPersTitl',			title: ['현행범인체포 및 인수','체포자','관직'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'acqsDt',			title: ['현행범인체포 및 인수','인수한 일시','인수한 일시'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh시 mm분"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'acqsPla',			title: ['현행범인체포 및 인수','인수한 장소','인수한 장소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'acqsPersTitl',			title: ['현행범인체포 및 인수','인수한 자','관직'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'acqsPersNm',			title: ['현행범인체포 및 인수','인수한 자','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cstdDt',			title: ['현행범인체포 및 인수','인치한 일시','인치한 일시'],		sort:true, move:true, resize: true,options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh시 mm분"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cstdPla',			title: ['현행범인체포 및 인수','인치한 장소','인치한 장소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'detnDt',			title: ['현행범인체포 및 인수','구금한 일시','구금한 일시'],		sort:true, move:true, resize: true,options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh시 mm분"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'detnPla',			title: ['현행범인체포 및 인수','구금한 장소','구금한 장소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'relsDt',			title: ['석방','일시','일시'],		sort:true, move:true, resize: true,options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh시 mm분"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'relsRsn',			title: ['석방','사유','사유'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'arstWrntReqBkNum',			title: ['구속영장신청','신청부번호','신청부번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'arstWrntReqIsueDt',			title: ['구속영장신청','발부연월일','발부연월일'],		sort:true, move:true, resize: true,options: {format: {type: "date", origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'flgtOfdrCathBookComn',			title: ['비고','비고','비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'docType',			title: ['문서유형','문서유형','문서유형'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'attoNm',			title: ['변호인','변호인','변호인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'crimAndArrsResn',			title: ['범죄사실 및 체포의 사유','범죄사실 및 체포의 사유','범죄사실 및 체포의 사유'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
            	

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
	var colIdx = qcell.getIdx("col");
	rowIdx = qcell.getIdx("row");
	
	if(colIdx >0 && rowIdx > 0){
		if(colIdx != 1){
			//기존 체크박스 열번호
			var pastchk = qcell.getIdx("row","focus","previous") == -1?3:qcell.getIdx("row","focus","previous");
			
			//기존 체크항목 해제
			qcell.removeRowStyle(pastchk);
		
			//새로 선택한 행 스타일적용
			qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
			
			freezeInput(true); // 입력 비활성화
			fn_M0107_initM0107VOMap(); // 맵초기화
			m0107VOMap = qcell.getRowData(rowIdx);
			$("#afterDiv").show();
			//현행범인체포원부 데이터 세팅
			fn_M0107_selectFlgtOfdrCathSetting();
			//수정세팅
			updateYN();
		}
	}
}
//현행범인체포원부 데이터 세팅
function fn_M0107_selectFlgtOfdrCathSetting(){	
	setFieldValue($("#docType"), m0107VOMap.docType);
	getAreaMap($("#M0107FlgtOfdrCath"), m0107VOMap);
	$("#incNum").html(m0107VOMap.rcptIncNum);
	Fn_M_SettingDate(m0107VOMap.cathDt,"cathDt");
	Fn_M_SettingDate(m0107VOMap.acqsDt,"acqsDt");
	Fn_M_SettingDate(m0107VOMap.cstdDt,"cstdDt");
	Fn_M_SettingDate(m0107VOMap.detnDt,"detnDt");
	Fn_M_SettingDate(m0107VOMap.relsDt,"relsDt");
}
//시,분,초 날짜형식 세팅
function fn_M0107_joinDate(vo){
	vo.cathDt = Fn_M_StoreDate($("#cathDtCal").val(),$("#cathDtHour").val(),$("#cathDtMin").val());
	vo.acqsDt = Fn_M_StoreDate($("#acqsDtCal").val(),$("#acqsDtHour").val(),$("#acqsDtMin").val());
	vo.cstdDt = Fn_M_StoreDate($("#cstdDtCal").val(),$("#cstdDtHour").val(),$("#cstdDtMin").val());
	vo.detnDt = Fn_M_StoreDate($("#detnDtCal").val(),$("#detnDtHour").val(),$("#detnDtMin").val());
	vo.relsDt = Fn_M_StoreDate($("#relsDtCal").val(),$("#relsDtHour").val(),$("#relsDtMin").val());
}
//수정 가능 버튼 보이기 여부
function updateYN(){
	if(parent.viewType == 'inc'){
		if(m0107VOMap.regUserId == $("#userId").val() && parent.viewType == 'inc'){		//4. 2018.11.19 추가 사건 > 문서관리에서 보여질경우 수정가능 
			freezeInput(false); // 입력 활성화
			$("#btnUpdateFlgtOfdrCath").show();  //수정버튼 보이기
		}else{
			freezeInput(true); // 입력 비활성화
			$("#btnUpdateFlgtOfdrCath").hide();  //수정버튼 숨기기
		}
		$("#btnInsertFlgtOfdrCath").hide();  //저장버튼 숨기기
		
	}
	$("#btnReqprnReport").show();  //신청서 출력 버튼 보이기
	$("#btnprnReport").show();  //대장 출력 버튼 보이기
}
//사건검색 성공함수
function callBackFn_M0107_searchIncSpSuccess(data){
	
	$("#incNum").val(data.incNum);
	$("#incSpNum").val(data.incSpNum);
	$("input[name=spNm]").val(Base64.decode(data.spNm));					// 피의자 성명 출력
	$("#spIdNum").html(Base64.decode(data.spIdNum));						// 피의자 주민등록번호 출력
	$("#spJob").html(data.spJob);							// 피의자 직업 출력
	$("#spAddr").html(Base64.decode(data.spAddr));							// 피의자 주거 출력
	$("#rltActCriNmCdDesc").html(data.rltActCriNmCdDesc);					// 피의자 죄명 출력
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
			,"nmKor":""						// 작성자
			,"docType":""					// 문서유형
			,"attoNm":""					// 변호인
			,"crimAndArrsResn":""			// 범죄사실 및 체포의 사유
	}
	Fn_M_CleanDate("cathDt");
	Fn_M_CleanDate("acqsDt");
	Fn_M_CleanDate("cstdDt");
	Fn_M_CleanDate("detnDt");
	Fn_M_CleanDate("relsDt");
}

//신규등록
function fn_M0107_newFlgtOfdrCath(){
	$("#afterDiv").hide();		//대장 입력폼 숨기기
	$("#btnReqprnReport").hide();  //신청서 출력 버튼 슴기기
	$("#btnprnReport").hide();  //대장 출력 버튼 숨기기
	
	fn_M0107_initM0107VOMap(); //맵초기화
	fn_M0107_selectFlgtOfdrCathSetting(); // 데이터 세팅	
	freezeInput(false); // 입력 활성화
	$("#btnSearchInc").show(); // 검색버튼보이기
	$("#btnInsertFlgtOfdrCath").show(); // 저장버튼 보이기	
	$("#btnUpdateFlgtOfdrCath").hide(); // 수정버튼 숨기기	

	$("#rcptNum").val(incMap.rcptNum);
	$("#execNum").html("신규");
	$("#incNum").html(isNull(incMap.rcptIncNum) ? "(피의자 선택시 자동입력)" : incMap.rcptIncNum);					//사건번호 세팅
	$("#spIdNum").html("(피의자 선택시 자동입력)");
	$("#spJob").html("(피의자 선택시 자동입력)");
	$("#spAddr").html("(피의자 선택시 자동입력)");
	$("#rltActCriNmCdDesc").html("(피의자 선택시 자동입력)");
	
}
//등록하기
function fn_M0107_insertFlgtOfdrCath(){
	
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
		return;
	}
	
	//유효성검사
	setAreaMap($("#M0107FlgtOfdrCath"), m0107VOMap);
	m0107VOMap.rcptNum = $("#rcptNum").val();
	m0107VOMap.incSpNum = $("#incSpNum").val();
	m0107VOMap.docType = $("#docType").val();
	
	if(m0107VOMap.incSpNum == null || m0107VOMap.incSpNum == "" || m0107VOMap.incSpNum ==" "){
		alert("피의자를 선택해주세요.");
		return;
	}
	
	if(Fn_M_CheckingDate("체포한 일시",$("#cathDtCal").val(),$("#cathDtHour").val(),$("#cathDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("인수한 일시",$("#acqsDtCal").val(),$("#acqsDtHour").val(),$("#acqsDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("안치한 일시",$("#cstdDtCal").val(),$("#cstdDtHour").val(),$("#cstdDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("구금한 일시",$("#detnDtCal").val(),$("#detnDtHour").val(),$("#detnDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("석방 일시",$("#relsDtCal").val(),$("#relsDtHour").val(),$("#relsDtMin").val()) == false) return;
	fn_M0107_joinDate(m0107VOMap);
	
	goAjaxDefault("/sjpb/M/M0107insertFlgtOfdrCath.face",m0107VOMap,callBackFn_M0107_insertFlgtOfdrCathSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsertFlgtOfdrCath").hide(); //저장버튼 숨기기

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
	m0107VOMap.rcptIncNum = $("#incNum").val();
	m0107VOMap.docType = $("#docType").val();
	
	if(Fn_M_CheckingDate("처리 집행",$("#cathDtCal").val(),$("#cathDtHour").val(),$("#cathDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("처리 집행",$("#acqsDtCal").val(),$("#acqsDtHour").val(),$("#acqsDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("처리 집행",$("#cstdDtCal").val(),$("#cstdDtHour").val(),$("#cstdDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("처리 집행",$("#detnDtCal").val(),$("#detnDtHour").val(),$("#detnDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("처리 집행",$("#relsDtCal").val(),$("#relsDtHour").val(),$("#relsDtMin").val()) == false) return;
	fn_M0107_joinDate(m0107VOMap);
	
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
	//$("#contentsArea a").attr("disabled",tf);
}
//현행범인체포원부 출력
function fn_M0107_prnReport() {
	var flgtOfdrCathBookNumMap ={
			"flgtOfdrCathBookNum":m0107VOMap.flgtOfdrCathBookNum
	};
	//현행범인체포원부 리스트 레포트 성공함수 호출
	goAjaxDefault("/sjpb/M/M0107prnReport.face",flgtOfdrCathBookNumMap, callBackFn_M0107_prnReportSuccess);
}
//현행범인체포원부 출력
function fn_M0107_prnCheckReport() {
	var flgtOfdrCathBookNumList = [];
	for(var i = 3; i <= qcell.getRows("data")+2; i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			flgtOfdrCathBookNumList.push(qcell.getRowData(i).flgtOfdrCathBookNum);
		}	
	}

	if(flgtOfdrCathBookNumList.length != 0){		
		var flgtOfdrCathBookNumListMap = {
				"flgtOfdrCathBookNumList":flgtOfdrCathBookNumList
		}
		//현행범인체포원부 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0107prnCheckReport.face",flgtOfdrCathBookNumListMap, callBackFn_M0107_prnReportSuccess);
		
	}else{
		alert("출력할 대상을 선택해주세요.");
		return;
	}
}
//현행범인체포원부 출력 성공함수
function callBackFn_M0107_prnReportSuccess(data){
	M0107RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0107RTMap);
	$("#reptNm").val("M0107.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	//레포트 호출
	openReportService(reportForm); 
}

//신청서 출력
/*function requestReport(){
	
	$("#reptNm").val("M0201.crf"); //레포트 파일명
	$("#seqNum").val(m0107VOMap.flgtOfdrCathBookNum);
	//레포트 호출
	openReportService(reportForm); 
}*/

//초기화
function fn_M0107_init(form){
	$("#"+form)[0].reset();	
}
//신청서 출력
function requestReport(){
	var reptNum = "";
	
	if($("#docType").val().indexOf("현행범인인수서") > -1){
		reptNum = "M0202.crf";
	}else if($("#docType").val().indexOf("현행범인체포서") > -1){
		reptNum = "M0201.crf";
	}else{
		alert("작성 문서 유형을 선택해주세요.");
		return;
	}
	$("#reptNm").val(reptNum); //레포트 파일명
	$("#SEQNUM").val(m0107VOMap.flgtOfdrCathBookNum);
	//레포트 호출
	openReportServiceFSS(reportForm); 
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
		,"nmKor":""						// 작성자
		,"docType":""					// 문서유형
		,"attoNm":""					// 변호인
		,"crimAndArrsResn":""			// 범죄사실 및 체포의 사유
}
//리포트맵
var M0107RTMap = {
	rexdataset : null
}