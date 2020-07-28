var qcell;
var queryString;
var qCellList=[];
var rowIdx=3;
var incMap;	
$(document).ready(function(){
	incMap = setUiRcptNum(parent);
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
	}
	fn_M0106_pageInit();     
	
	if(parent.viewType == 'inc'){
		//피의자 검색버튼
		$("#spBtn").off("click").on("click", function() {	
			commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face?rcptNum='+incMap.rcptNum, "1050px", "435px", callBackFn_M0106_searchIncSpSuccess);
		});
	}
	
});
//화면 진입시 동작함
function fn_M0106_pageInit(){
	qCellList=[];
	queryString=$("#m0106_searchList").serialize();
	var d = document.m0106_searchList;
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
	goAjax("/sjpb/M/M0106selectList.face",queryString,callBackFn_M0106_selectListSuccess,true);
}
//긴급체포원부 리스트 그리기.
function callBackFn_M0106_selectListSuccess(data){	

	if(data.qCell ==''|| data.qCell==' '){
		if(parent.viewType == 'inc'){
			fn_M0106_newEmgyCath();
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
            	{width: '100',	key: 'execNum',			title: ['집행번호','집행번호','집행번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '150',	key: 'rcptIncNum',			title: ['사건번호','사건번호','사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'nmKor',			title: ['작성자','작성자','작성자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spNm',			title: ['피의자','성명','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spIdNum',			title: ['피의자','주민등록번호','주민등록번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spJob',			title: ['피의자','직업','직업'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spAddr',			title: ['피의자','주거','주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rltActCriNmCdDesc',			title: ['죄명','죄명','죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'emgyCathDocFillDt',			title: ['긴급체포작성연월일','긴급체포작성연월일','긴급체포작성연월일'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'emgyCathDt',			title: ['긴급체포','체포한 일시','체포한 일시'],		sort:true, move:true, resize: true,options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh시 mm분"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'emgyCathPla',			title: ['긴급체포','체포한 장소','체포한 장소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'emgyCathPersTitl',			title: ['긴급체포','체포자의 관직','체포자의 관직'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'emgyCathPersNm',			title: ['긴급체포','체포자의 성명','체포자의 성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'emgyCathCstdDt',			title: ['긴급체포','인치한 일시','인치한 일시'],		sort:true, move:true, resize: true,options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh시 mm분"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'emgyCathCstdPla',			title: ['긴급체포','인치한 장소','인치한 장소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'emgyCathDetnDt',			title: ['긴급체포','구금한 일시','구금한 일시'],		sort:true, move:true, resize: true,options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh시 mm분"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'emgyCathDetnPla',			title: ['긴급체포','구금한 장소','구금한 장소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'attoNm',			title: ['변호인','변호인','변호인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'dentPersNm',			title: ['구금 집행자','성명','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'dentPersTitl',			title: ['구금 집행자','관직','관직'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'relsPla',			title: ['석방한 장소','석방한 장소','석방한 장소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'relsPersNm',			title: ['석방한 자','성명','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'relsPersTitl',			title: ['석방한 자','관직','관직'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'pstrCmdApprDt',			title: ['긴급체포','검사지휘','승인'],		sort:true, move:true, resize: true,options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh시 mm분"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'pstrCmdNonApprDt',			title: ['긴급체포','검사지휘','불승인'],		sort:true, move:true, resize: true,options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh시 mm분"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'relsDt',			title: ['석방','일시','일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'relsRsn',			title: ['석방','사유','사유'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'arstWrntReqBkNum',			title: ['구속영장신청','신청부번호','신청부번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'arstWrntIsueDt',			title: ['구속영장신청','발부연월일','발부연월일'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
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
	$("#afterDiv").show();
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
			fn_M0106_initM0106VOMap(); // 맵초기화
			m0106VOMap = qcell.getRowData(rowIdx);
		
			//긴급체포원부 데이터 세팅
			fn_M0106_selectEmgyCathSetting();
			//수정세팅
			updateYN();
		}
	}
}
//긴급체포원부 데이터 세팅
function fn_M0106_selectEmgyCathSetting(){	
	getAreaMap($("#M0106EmgyCath"), m0106VOMap);

	$("#execNum").html(m0106VOMap.execNum); // 집행번호 세팅
	$("#incNum").html(m0106VOMap.rcptIncNum); //사건번호 세팅
	
	Fn_M_SettingDate(m0106VOMap.emgyCathDt,"emgyCathDt");
	Fn_M_SettingDate(m0106VOMap.emgyCathCstdDt,"emgyCathCstdDt");
	Fn_M_SettingDate(m0106VOMap.emgyCathDetnDt,"emgyCathDetnDt");
	Fn_M_SettingDate(m0106VOMap.pstrCmdApprDt,"pstrCmdApprDt");
	Fn_M_SettingDate(m0106VOMap.pstrCmdNonApprDt,"pstrCmdNonApprDt");
	setFieldValue($("#relsRsn"), m0106VOMap.relsRsn);
	if(m0106VOMap.relsRsn == "구속영장청구 불요" || m0106VOMap.relsRsn == "추가수사필요"|| m0106VOMap.relsRsn == "" || m0106VOMap.relsRsn == null){
		//setFieldValue($("#relsRsn"), m0106VOMap.relsRsn);
		$("#relsRsnEtc").attr("disabled","disabled");
	}else{
		$("#relsRsn").val("기타");
		m0106VOMap.relsRsn = $("#relsRsnEtc").val();
		$("#relsRsnEtc").removeAttr("disabled");
	}
	
	
	
}
//시,분,초 날짜형식 세팅
function fn_M0106_joinDate(vo){
	vo.emgyCathDt = Fn_M_StoreDate($("#emgyCathDtCal").val(),$("#emgyCathDtHour").val(),$("#emgyCathDtMin").val());
	vo.emgyCathCstdDt = Fn_M_StoreDate($("#emgyCathCstdDtCal").val(),$("#emgyCathCstdDtHour").val(),$("#emgyCathCstdDtMin").val());
	vo.emgyCathDetnDt = Fn_M_StoreDate($("#emgyCathDetnDtCal").val(),$("#emgyCathDetnDtHour").val(),$("#emgyCathDetnDtMin").val());
	vo.pstrCmdApprDt = Fn_M_StoreDate($("#pstrCmdApprDtCal").val(),$("#pstrCmdApprDtHour").val(),$("pstrCmdApprDtMin").val());
	vo.pstrCmdNonApprDt = Fn_M_StoreDate($("#pstrCmdNonApprDtCal").val(),$("#pstrCmdNonApprDtHour").val(),$("#pstrCmdNonApprDtMin").val());
}
//수정 가능 버튼 보이기 여부
function updateYN(){
	if(parent.viewType == 'inc'){
		if(m0106VOMap.regUserId == $("#userId").val() ){
			freezeInput(false); // 입력 활성화
			$("#btnUpdateEmgyCath").show();  //수정버튼 보이기
		}else{
			freezeInput(true); // 입력 비활성화
			$("#btnUpdateEmgyCath").hide();  //수정버튼 숨기기
		}
		$("#btnInsertEmgyCath").hide();  //저장버튼 숨기기
	}
	$("#btnReqPrtEmgyCath").show();//신청서 출력 버튼 보이기
	$("#btnPrtEmgyCath").show();//대장 출력 버튼 보이기
}

//사건검색 성공함수
function callBackFn_M0106_searchIncSpSuccess(data){
	
	$("#incNum").val(data.incNum);
	$("#incSpNum").val(data.incSpNum);
	$("input[name=spNm]").val(Base64.decode(data.spNm));					// 피의자 성명 출력
	$("#spIdNum").html(Base64.decode(data.spIdNum));						// 피의자 주민등록번호 출력
	$("#spJob").html(Base64.decode(data.spJob));							// 피의자 직업 출력
	$("#spAddr").html(Base64.decode(data.spAddr));							// 피의자 주거 출력
	$("#rltActCriNmCdDesc").html(data.rltActCriNmCdDesc);					// 피의자 죄명 출력
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
			,"nmKor":"" 					// 작성자 이름
			,"attoNm":""					// 변호인 
			,"dentPersNm":""				// 구금 집행자 성명
			,"dentPersTitl":""				// 구금 집행자 관직
			,"relsPla":""					// 석방한 장소
			,"relsPersNm":""				// 석방한 자의 성명
			,"relsPersTitl":""				// 석방한 자의 관직
	}
	Fn_M_CleanDate("emgyCathDt");
	Fn_M_CleanDate("emgyCathCstdDt");
	Fn_M_CleanDate("emgyCathDetnDt");
	Fn_M_CleanDate("pstrCmdApprDt");
	Fn_M_CleanDate("pstrCmdNonApprDt");
}

//신규등록
function fn_M0106_newEmgyCath(){
	$("#afterDiv").hide();	//대장 입력 폼 숨기기
	$("#btnReqPrtEmgyCath").hide();//신청서 출력 버튼 숨기기
	$("#btnPrtEmgyCath").hide();//대장 출력 버튼 숨기기
	
	fn_M0106_initM0106VOMap(); //맵초기화
	fn_M0106_selectEmgyCathSetting(); // 데이터 세팅	
	
	freezeInput(false); // 입력 활성화
	
	$("#btnSearchInc").show(); // 검색버튼보이기
	$("#btnInsertEmgyCath").show(); // 저장버튼 보이기	
	$("#btnUpdateEmgyCath").hide(); // 수정버튼 숨기기	
	
	$("#rcptNum").val(incMap.rcptNum);
	$("#execNum").html("신규");
	$("#rcptNum").html(incMap.rcptNum);
	$("#incNum").html(isNull(incMap.rcptIncNum) ? "(피의자 선택시 자동입력)" : incMap.rcptIncNum);					//사건번호 세팅
	$("#spIdNum").html("(피의자 선택시 자동입력)");
	$("#spJob").html("(피의자 선택시 자동입력)");
	$("#spAddr").html("(피의자 선택시 자동입력)");
	$("#rltActCriNmCdDesc").html("(피의자 선택시 자동입력)");
	
}
//등록하기
function fn_M0106_insertEmgyCath(){
	
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
		return;
	}
	
	//유효성검사
	setAreaMap($("#M0106EmgyCath"), m0106VOMap);
	m0106VOMap.rcptNum = $("#rcptNum").val();
	m0106VOMap.rcptIncNum = $("#incNum").val();
	m0106VOMap.incSpNum = $("#incSpNum").val();
	
	if(m0106VOMap.incSpNum == null || m0106VOMap.incSpNum == "" || m0106VOMap.incSpNum ==" "){
		alert("피의자를 선택해주세요.");
		return;
	}
	setFieldValue($("#relsRsn"), m0106VOMap.relsRsn);
	if(m0106VOMap.relsRsn == "기타"){
		m0106VOMap.relsRsn = $("#relsRsnEtc").val();
	}
	
	
	if(Fn_M_CheckingDate("체포한 일시",$("#emgyCathDtCal").val(),$("#emgyCathDtHour").val(),$("#emgyCathDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("인치한 일시",$("#emgyCathCstdDtCal").val(),$("#emgyCathCstdDtHour").val(),$("#emgyCathCstdDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("구금한 일시",$("#emgyCathDetnDtCal").val(),$("#emgyCathDetnDtHour").val(),$("#emgyCathDetnDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("긴급지휘 승인",$("#pstrCmdApprDtCal").val(),$("#pstrCmdApprDtHour").val(),$("#pstrCmdApprDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("긴급지휘 불승인",$("#pstrCmdNonApprDtCal").val(),$("#pstrCmdNonApprDtHour").val(),$("#pstrCmdNonApprDtMin").val()) == false) return;
	fn_M0106_joinDate(m0106VOMap);
	

	goAjaxDefault("/sjpb/M/M0106insertEmgyCath.face",m0106VOMap,callBackFn_M0106_insertEmgyCathSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsertEmgyCath").hide(); //저장버튼 숨기기

}
function changeRsnEtc(relsRsn){

	if("기타".indexOf(relsRsn) > -1){
		$("#relsRsnEtc").removeAttr("disabled");
		
	}else{
		$("#relsRsnEtc").attr("disabled","disabled");
	}
	
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
	m0106VOMap.rcptIncNum = $("#incNum").val();
	//setFieldValue($("#relsRsn"), m0106VOMap.relsRsn);
	m0106VOMap.relsRsn = $("#relsRsn").val();
	if(m0106VOMap.relsRsn == "기타"){
		m0106VOMap.relsRsn = $("#relsRsnEtc").val();
	}
	
	if(Fn_M_CheckingDate("체포한 일시",$("#emgyCathDtCal").val(),$("#emgyCathDtHour").val(),$("#emgyCathDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("인치한 일시",$("#emgyCathCstdDtCal").val(),$("#emgyCathCstdDtHour").val(),$("#emgyCathCstdDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("구금한 일시",$("#emgyCathDetnDtCal").val(),$("#emgyCathDetnDtHour").val(),$("#emgyCathDetnDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("긴급지휘 승인",$("#pstrCmdApprDtCal").val(),$("#pstrCmdApprDtHour").val(),$("#pstrCmdApprDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("긴급지휘 불승인",$("#pstrCmdNonApprDtCal").val(),$("#pstrCmdNonApprDtHour").val(),$("#pstrCmdNonApprDtMin").val()) == false) return;
	fn_M0106_joinDate(m0106VOMap);
	debugger;
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
	//$("#contentsArea a").attr("disabled",tf);
}
//긴급체포원부 출력
function fn_M0106_prnEmgyCathReport() {
	
	var sjpbEmgyCathBookNumMap ={
			sjpbEmgyCathBookNum:m0106VOMap.sjpbEmgyCathBookNum
	};
	
	//긴급체포원부 리스트 레포트 성공함수 호출
	goAjaxDefault("/sjpb/M/M0106prnReport.face",sjpbEmgyCathBookNumMap, callBackFn_M0106_prnEmgyCathReportSuccess);
}
//긴급체포원부 출력
function fn_M0106_prnEmgyCathCheckReport() {
	var sjpbEmgyCathBookNumList = [];
	for(var i = 3; i <= qcell.getRows("data")+2; i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			sjpbEmgyCathBookNumList.push(qcell.getRowData(i).sjpbEmgyCathBookNum);
		}	
	}
	var sjpbEmgyCathBookNumListMap = {
			"sjpbEmgyCathBookNumList":sjpbEmgyCathBookNumList
	}
	
	if(sjpbEmgyCathBookNumList.length != 0){
		//긴급체포원부 체크리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0106prnCheckReport.face", sjpbEmgyCathBookNumListMap, callBackFn_M0106_prnEmgyCathReportSuccess);
	}else{
		alert("출력할 대상을 선택해주세요.");
		return;
	}
	
}

//긴급체포원부 출력 성공함수
function callBackFn_M0106_prnEmgyCathReportSuccess(data){
	M0106RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0106RTMap);
	$("#reptNm").val("M0106.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	//레포트 호출
	openReportService(reportForm); 
}
//긴급체포원부 출력 성공함수
function callBackFn_M0106_prnEmgyCathReportSuccess(data){
	M0106RTMap.rexdataset = data.qCell;
	
	var xmlString = objectToXml(M0106RTMap);
	$("#reptNm").val("M0106.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	//레포트 호출
	openReportService(reportForm); 
}
//신청서 출력
function requestReport(){
	$("#reptNm").val("M0212.crf"); //레포트 파일명
	$("#SEQNUM").val(m0106VOMap.sjpbEmgyCathBookNum);
	//레포트 호출
	openReportServiceFSS(reportForm); 
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
		,"nmKor":""						// 작성자이름
		,"attoNm":""					// 변호인 
		,"dentPersNm":""				// 구금 집행자 성명
		,"dentPersTitl":""				// 구금 집행자 관직
		,"relsPla":""					// 석방한 장소
		,"relsPersNm":""				// 석방한 자의 성명
		,"relsPersTitl":""				// 석방한 자의 관직
}
//리포트맵
var M0106RTMap = {
	rexdataset : null
}