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
	fn_M0103_pageInit(); 
	
	if(parent.viewType == 'inc'){
		//피의자 검색버튼
		$("#spBtn").off("click").on("click", function() {	
			commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face?rcptNum='+incMap.rcptNum, "1050px", "435px", callBackFn_M0103_searchRcptIncSuccess);
		});
	}
	
});
//화면 진입시 동작함
function fn_M0103_pageInit(){
	qCellList=[];
	queryString = $("#m0103_searchList").serialize();
	var d = document.m0103_searchList;
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
	goAjax("/sjpb/M/M0103selectList.face",queryString,callBackFn_M0103_selectListSuccess,true);
}
//구속영장신청부 리스트 그리기.
function callBackFn_M0103_selectListSuccess(data){	
	if(data.qCell ==''|| data.qCell==' '){
		if(parent.viewType == 'inc'){
			fn_M0103_newArstWrnt();
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
            	{width: '100',	key: 'chifPstr',			title: ['주임검사','주임검사','주임검사'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'reqOfic',			title: ['신청관서','신청관서','신청관서'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spNm',			title: ['피의자','성명','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spIdNum',			title: ['피의자','주민등록번호','주민등록번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spJob',			title: ['피의자','직업','직업'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spAddr',			title: ['피의자','주거','주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rltActCriNmCdDesc',			title: ['죄명','죄명','죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathDt',			title: ['체포','일시','일시'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh:mm"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathTpCdDesc',			title: ['체포','유형','유형'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathPrgsNum',			title: ['체포','진행번호','진행번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'wrntPstrRjctDt',			title: ['영장신청 및 발부','검사기각','검사기각'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh:mm"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'wrntJudgRjctDt',			title: ['영장신청 및 발부','판사기각','판사기각'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh:mm"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'wrntIsueDt',			title: ['영장신청 및 발부','발부','발부'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh:mm"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'wrntReReqDt',			title: ['영장신청 및 발부','재신청','신청'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh:mm"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'wrntReReqPstrRjctDt',			title: ['영장신청 및 발부','재신청','검사기각'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh:mm"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'wrntReReqJudgRjctDt',			title: ['영장신청 및 발부','재신청','판사기각'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh:mm"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'wrntReReqIsueDt',			title: ['영장신청 및 발부','재신청','발부'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh:mm"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spItrgAplt',			title: ['영장신청 및 발부','피의자심문','신청인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spItrgSiNum',			title: ['영장신청 및 발부','피의자심문','일련번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spItrgPstrNm',			title: ['영장신청 및 발부','피의자심문','검사 또는 판사명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spItrgRcptDt',			title: ['영장신청 및 발부','피의자심문','접수일시'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh:mm"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spItrgApltTitl',			title: ['영장신청 및 발부','피의자심문','접수자관직'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spItrgApltNm',			title: ['영장신청 및 발부','피의자심문','접수자성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spItrgArstDt',			title: ['영장신청 및 발부','피의자심문','구인일시'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh:mm"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'valdPi',			title: ['유효기간','유효기간','유효기간'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'relsDt',			title: ['석방','연월일','연월일'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'relsRsn',			title: ['석방','사유','사유'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'arstWrntRetn',			title: ['반환','반환','반환'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'arstWrntComn',			title: ['비고','비고','비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}
            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(3, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0103VOMap = qcell.getRowData(3);
	    	fn_M0103_selectArstWrntSetting();
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
			var pastchk = qcell.getIdx("row","focus","previous") == -1?3:qcell.getIdx("row","focus","previous");
			
			//기존 체크항목 해제
			qcell.removeRowStyle(pastchk);
		
			//새로 선택한 행 스타일적용
			qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
			
			freezeInput(true); // 입력 비활성화
			fn_M0103_initM0103VOMap(); // 맵초기화
			m0103VOMap = qcell.getRowData(rowIdx);
			$("#afterDiv").show();
			//구속영장신청부 데이터 세팅
			fn_M0103_selectArstWrntSetting();
			
			//수정세팅
			updateYN();
		}
	}
}
//구속영장신청부 데이터 세팅
function fn_M0103_selectArstWrntSetting(){
	
	getAreaMap($("#M0103ArstWrnt"), m0103VOMap);
	$("#incNum").html(m0103VOMap.rcptIncNum);
	$("#rcptNum").val(m0103VOMap.rcptNum);
	$("#incSpNum").val(m0103VOMap.incSpNum);

	setFieldValue($("#cathTpCd"), m0103VOMap.cathTpCd);
	setFieldValue($("#nessSel"), m0103VOMap.nessSel);
	
	Fn_M_SettingDate(m0103VOMap.cathDt,"cathDt");
	Fn_M_SettingDate(m0103VOMap.wrntPstrRjctDt,"wrntPstrRjctDt");
	Fn_M_SettingDate(m0103VOMap.wrntJudgRjctDt,"wrntJudgRjctDt");
	Fn_M_SettingDate(m0103VOMap.wrntIsueDt,"wrntIsueDt");
	Fn_M_SettingDate(m0103VOMap.wrntReReqDt,"wrntReReqDt");
	Fn_M_SettingDate(m0103VOMap.wrntReReqPstrRjctDt,"wrntReReqPstrRjctDt");
	Fn_M_SettingDate(m0103VOMap.wrntReReqJudgRjctDt,"wrntReReqJudgRjctDt");
	Fn_M_SettingDate(m0103VOMap.wrntReReqIsueDt,"wrntReReqIsueDt");
	Fn_M_SettingDate(m0103VOMap.spItrgRcptDt,"spItrgRcptDt");
	Fn_M_SettingDate(m0103VOMap.spItrgArstDt,"spItrgArstDt");

}
function fn_M0103_joinDate(vo){
	vo.cathDt = Fn_M_StoreDate($("#cathDtCal").val(),$("#cathDtHour").val(),$("#cathDtMin").val());
	vo.wrntPstrRjctDt = Fn_M_StoreDate($("#wrntPstrRjctDtCal").val(),$("#wrntPstrRjctDtHour").val(),$("#wrntPstrRjctDtMin").val());
	vo.wrntJudgRjctDt = Fn_M_StoreDate($("#wrntJudgRjctDtCal").val(),$("#wrntJudgRjctDtHour").val(),$("#wrntJudgRjctDtMin").val());
	vo.wrntIsueDt = Fn_M_StoreDate($("#wrntIsueDtCal").val(),$("#wrntIsueDtHour").val(),$("#wrntIsueDtMin").val());
	vo.wrntReReqDt = Fn_M_StoreDate($("#wrntReReqDtCal").val(),$("#wrntReReqDtHour").val(),$("#wrntReReqDtMin").val());
	vo.wrntReReqPstrRjctDt = Fn_M_StoreDate($("#wrntReReqPstrRjctDtCal").val(),$("#wrntReReqPstrRjctDtHour").val(),$("#wrntReReqPstrRjctDtMin").val());
	vo.wrntReReqJudgRjctDt = Fn_M_StoreDate($("#wrntReReqJudgRjctDtCal").val(),$("#wrntReReqJudgRjctDtHour").val(),$("#wrntReReqJudgRjctDtMin").val());
	vo.wrntReReqIsueDt = Fn_M_StoreDate($("#wrntReReqIsueDtCal").val(),$("#wrntReReqIsueDtHour").val(),$("#wrntReReqIsueDtMin").val());
	vo.spItrgRcptDt = Fn_M_StoreDate($("#spItrgRcptDtCal").val(),$("#spItrgRcptDtHour").val(),$("#spItrgRcptDtMin").val());
	vo.spItrgArstDt = Fn_M_StoreDate($("#spItrgArstDtCal").val(),$("#spItrgArstDtHour").val(),$("#spItrgArstDtMin").val());

}
//수정 세팅
function updateYN(){
	if(parent.viewType == 'inc'){
		if(m0103VOMap.regUserId == $("#userId").val() ){
			freezeInput(false); // 입력 활성화
			$("#btnUpdateArstWrnt").show();  //수정버튼 보이기
			$("#btnSearchInc").show(); // 검색버튼보이기
		}else{
			freezeInput(true); // 입력 비활성화
			$("#btnUpdateArstWrnt").hide();  //수정버튼 숨기기
			$("#btnSearchInc").hide(); // 검색버튼숨기기
		}
		$("#btnInsertArstWrnt").hide();  //저장버튼 숨기기
	}
		$("#btnPrtArstWrnt").show();
		$("#btnReqPrtArstWrnt").show();
	
}

//사건검색 성공함수
function callBackFn_M0103_searchRcptIncSuccess(data){
	$("#incSpNum").val(data.incSpNum);						
	$("input[name=spNm]").val(Base64.decode(data.spNm));					// 피의자 성명 출력
	$("#spIdNum").html(Base64.decode(data.spIdNum));						// 피의자 주민등록번호 출력
	$("#spJob").html(Base64.decode(data.spJob));							// 피의자 직업 출력
	$("#spAddr").html(Base64.decode(data.spAddr));							// 피의자 주거 출력
	$("#rltActCriNmCdDesc").html(data.rltActCriNmCdDesc);					// 피의자 죄명 출력
}

//맵초기화
function fn_M0103_initM0103VOMap() {
	m0103VOMap={
			"arstWrntReqBkNum":""					//구속영장신청부번호
			,"prgsNum":""							// 진행번호 
			,"rcptIncNum":""						// 사건번호 
			,"rcptNum":""							// 접수번호
			,"chifPstr":""							// 주임검사 
			,"reqOfic":""							// 신청관서 
			,"chifPstr":""							// 주임검사
			,"incSpNum":""							// 피의자 번호 
			,"spNm":""								// 피의자 성명 
			,"spIdNum":""							// 피의자 주민등록번호 
			,"spJob":""								// 피의자 직업 
			,"spAddr":""							// 피의자 주거 
			,"rltActCriNmCdDesc":""					// 죄명 
			,"cathDt":""							// 체포일시 
			,"cathTpCdDesc":""						// 체포유형
			,"cathPrgsNum":""						// 체포진행번호
			,"wrntPstrRjctDt":""					// 영장신청검사기각 
			,"wrntJudgRjctDt":""					// 영장신청판사기각  
			,"wrntIsueDt":""						// 영장신청발부 
			,"wrntReReqDt":""						// 재신청신청 
			,"wrntReReqPstrRjctDt":""				// 재신청검사기각 
			,"wrntReReqJudgRjctDt":""				// 재신청판사기각 
			,"wrntReReqIsueDt":""					// 재신청발부  
			,"spItrgAplt":""						// 피의자심문신청인 
			,"spItrgSiNum":""						// 피의자심문일련번호 
			,"spItrgPstrNm":""						// 검사또는판사명 
			,"spItrgRcptDt":""						// 접수일시 
			,"spItrgApltTitl":""					// 접수자관직 
			,"spItrgApltNm":""						// 접수자성명 
			,"spItrgArstDt":""						// 구인일시 
			,"valdPi":""							// 유효기간 
			,"relsDt":""							// 석방연월일 
			,"relsRsn":""							// 석방사유 
			,"arstWrntRetn":""						// 반환 
			,"arstWrntComn":""						// 비고  
			,"nmKor":""								// 작성자이름
			,"docNum":""							// 문서번호
			,"attoNm":""							// 변호인
			,"nessSel":""							// 필요적 고려사항
			,"arstPla":""							// 구속장소
			,"overWeekResn":""						// 7일을 넘는 유효기간을 필요로 하는 취지와 사유
			,"overTwoPersRes":""					// 둘 이상의 영장을 신청하는 취지와 사유
	}
	Fn_M_CleanDate("cathDt");
	Fn_M_CleanDate("wrntPstrRjctDt");
	Fn_M_CleanDate("wrntJudgRjctDt");
	Fn_M_CleanDate("wrntIsueDt");
	Fn_M_CleanDate("wrntReReqDt");
	Fn_M_CleanDate("wrntReReqPstrRjctDt");
	Fn_M_CleanDate("wrntReReqJudgRjctDt");
	Fn_M_CleanDate("wrntReReqIsueDt");
	Fn_M_CleanDate("spItrgRcptDt");
	Fn_M_CleanDate("spItrgArstDt");
	
}


//신규등록
function fn_M0103_newArstWrnt(){
	$("#afterDiv").hide();
	$("#btnPrtArstWrnt").hide();
	$("#btnReqPrtArstWrnt").hide();
	fn_M0103_initM0103VOMap(); //맵초기화
	fn_M0103_selectArstWrntSetting(); // 데이터 세팅	
	freezeInput(false); // 입력 활성화
	$("#btnSearchInc").show(); // 검색버튼보이기
	$("#btnInsertArstWrnt").show(); // 저장버튼 보이기	
	$("#btnUpdateArstWrnt").hide(); // 수정버튼 숨기기
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
function fn_M0103_insertArstWrnt(){
	
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
		return;
	}
	setAreaMap($("#M0103ArstWrnt"), m0103VOMap);
	m0103VOMap.rcptIncNum = $("#incNum").html();
	m0103VOMap.rcptNum = $("#rcptNum").val();
	m0103VOMap.arstWrntReqBkNum = $("#arstWrntReqBkNum").val();
	m0103VOMap.cathTpCd = $("#cathTpCd").val();
	m0103VOMap.nessSel = $("#nessSel").val();
	//유효성검사
	if(m0103VOMap.incSpNum == null || m0103VOMap.incSpNum == "" || m0103VOMap.incSpNum ==" "){
		alert("피의자를 선택해주세요.");
		return;
	}
	
	if(Fn_M_CheckingDate("체포일시",$("#cathDtCal").val(),$("#cathDtHour").val(),$("#cathDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("영장신청 및 발부 검사기각",$("#wrntPstrRjctDtCal").val(),$("#wrntPstrRjctDtHour").val(),$("#wrntPstrRjctDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("영장신청 및 발부 판사기각",$("#wrntJudgRjctDtCal").val(),$("#wrntJudgRjctDtHour").val(),$("#wrntJudgRjctDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("영장신청 및 발부 발부",$("#wrntIsueDtCal").val(),$("#wrntIsueDtHour").val(),$("#wrntIsueDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("영장신청 및 발부 재신청 신청",$("#wrntReReqDtCal").val(),$("#wrntReReqDtHour").val(),$("#wrntReReqDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("영장신청 및 발부 재신청 검사기각",$("#wrntReReqPstrRjctDtCal").val(),$("#wrntReReqPstrRjctDtHour").val(),$("#wrntReReqPstrRjctDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("영장신청 및 발부 재신청 판사기각",$("#wrntReReqJudgRjctDtCal").val(),$("#wrntReReqJudgRjctDtHour").val(),$("#wrntReReqJudgRjctDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("영장신청 및 발부 재신청 발부",$("#wrntReReqIsueDtCal").val(),$("#wrntReReqIsueDtHour").val(),$("#wrntReReqIsueDtMin").val()) == false) "noDate";
	if(Fn_M_CheckingDate("영장신청 및 발부 피의자심문 접수일시",$("#spItrgRcptDtCal").val(),$("#spItrgRcptDtHour").val(),$("#spItrgRcptDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("영장신청 및 발부 피의자심문 구인일시",$("#spItrgArstDtCal").val(),$("#spItrgArstDtHour").val(),$("#spItrgArstDtMin").val()) == false) return;
	
	fn_M0103_joinDate(m0103VOMap);
	
	goAjaxDefault("/sjpb/M/M0103insertArstWrnt.face",m0103VOMap,callBackFn_M0103_insertArstWrntSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsertArstWrnt").hide(); //저장버튼 숨기기
	
}
//등록성공함수
function callBackFn_M0103_insertArstWrntSuccess(data){
	if(data == 1){
		alert("구속영장신청부가 등록되었습니다.");
	}else{
		alert("구속영장신청부 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0103_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0103_updateArstWrnt(){
	setAreaMap($("#M0103ArstWrnt"), m0103VOMap);
	m0103VOMap.rcptIncNum = $("#incNum").html();
	m0103VOMap.incSpNum = $("#incSpNum").val();
	m0103VOMap.rcptNum = $("#rcptNum").val();
	m0103VOMap.arstWrntReqBkNum = $("#arstWrntReqBkNum").val();
	m0103VOMap.cathTpCd = $("#cathTpCd").val();
	m0103VOMap.nessSel = $("#nessSel").val();
	
	if(Fn_M_CheckingDate("체포일시",$("#cathDtCal").val(),$("#cathDtHour").val(),$("#cathDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("영장신청 및 발부 검사기각",$("#wrntPstrRjctDtCal").val(),$("#wrntPstrRjctDtHour").val(),$("#wrntPstrRjctDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("영장신청 및 발부 판사기각",$("#wrntJudgRjctDtCal").val(),$("#wrntJudgRjctDtHour").val(),$("#wrntJudgRjctDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("영장신청 및 발부 발부",$("#wrntIsueDtCal").val(),$("#wrntIsueDtHour").val(),$("#wrntIsueDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("영장신청 및 발부 재신청 신청",$("#wrntReReqDtCal").val(),$("#wrntReReqDtHour").val(),$("#wrntReReqDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("영장신청 및 발부 재신청 검사기각",$("#wrntReReqPstrRjctDtCal").val(),$("#wrntReReqPstrRjctDtHour").val(),$("#wrntReReqPstrRjctDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("영장신청 및 발부 재신청 판사기각",$("#wrntReReqJudgRjctDtCal").val(),$("#wrntReReqJudgRjctDtHour").val(),$("#wrntReReqJudgRjctDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("영장신청 및 발부 재신청 발부",$("#wrntReReqIsueDtCal").val(),$("#wrntReReqIsueDtHour").val(),$("#wrntReReqIsueDtMin").val()) == false) "noDate";
	if(Fn_M_CheckingDate("영장신청 및 발부 피의자심문 접수일시",$("#spItrgRcptDtCal").val(),$("#spItrgRcptDtHour").val(),$("#spItrgRcptDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("영장신청 및 발부 피의자심문 구인일시",$("#spItrgArstDtCal").val(),$("#spItrgArstDtHour").val(),$("#spItrgArstDtMin").val()) == false) return;
	
	fn_M0103_joinDate(m0103VOMap);
	
	goAjaxDefault("/sjpb/M/M0103updateArstWrnt.face",m0103VOMap,callBackFn_M0103_updateArstWrntSuccess);
}
//수정 성공함수
function callBackFn_M0103_updateArstWrntSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0103_pageInit();
	freezeInput(true); // 입력 비활성화
}
//구속영장신청부 출력
function fn_M0103_prnReport() {
	var arstWrntReqBkNumMap = {
			"arstWrntReqBkNum" : document.M0103ArstWrnt.arstWrntReqBkNum.value
	};
	
	//구속영장신청부 리스트 레포트 성공함수 호출
	goAjaxDefault("/sjpb/M/M0103prnReport.face", arstWrntReqBkNumMap, callBackFn_M0103_prnReportSuccess);
}
//구속영장신청부 출력 성공함수
function callBackFn_M0103_prnReportSuccess(data){
	M0103RTMap.rexdataset = data.rexdataset;
	var xmlString = objectToXml(M0103RTMap);
	$("#reptNm").val("M0103.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	//레포트 호출
	openReportService(reportForm); 
}
function fn_M0103_prtCheck(){
	var arstWrntReqBkNumList = [];
	for(var i = 3; i <= qcell.getRows("data")+2; i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			arstWrntReqBkNumList.push(qcell.getRowData(i).arstWrntReqBkNum);
		}	
	}
	var arstWrntReqBkNumListMap = {
			"arstWrntReqBkNumList":arstWrntReqBkNumList
	}
	
	if(arstWrntReqBkNumList.length != 0){
		//구속영장신청부 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0103prnCheckReport.face", arstWrntReqBkNumListMap, callBackFn_M0103_prnReportSuccess);
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
}

//신청서 출력
function requestReport(){
	m0103VOMap.arstWrntReqBkNum = data.qCell;
	
	var xmlString = objectToXml(M0103RTMap);
	$("#reptNm").val("M0213.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	//레포트 호출
	openReportService(reportForm); 
}
//신청서 출력
function requestReport(){
	
	$("#reptNm").val("M0213.crf"); //레포트 파일명
	$("#SEQNUM").val(m0103VOMap.arstWrntReqBkNum);
	//레포트 호출
	openReportServiceFSS(reportForm); 
}
var m0103VOMap={
		"arstWrntReqBkNum":""					//구속영장신청부번호
		,"prgsNum":""							// 진행번호 
		,"rcptIncNum":""						// 사건번호
		,"rcptNum":""							// 접수번호
		,"chifPstr":""							// 주임검사 
		,"reqOfic":""							// 신청관서 
		,"chifPstr":""							// 주임검사 
		,"incSpNum":""							// 피의자 번호 
		,"spNm":""								// 피의자 성명
		,"spIdNum":""							// 피의자 주민등록번호 
		,"spJob":""								// 피의자 직업 
		,"spAddr":""							// 피의자 주거 
		,"rltActCriNmCdDesc":""					// 죄명 
		,"cathDt":""							// 체포일시 
		,"cathTpCdDesc":""						// 체포유형 
		,"cathPrgsNum":""						// 체포진행번호
		,"wrntPstrRjctDt":""					// 영장신청검사기각  
		,"wrntJudgRjctDt":""					// 영장신청판사기각 
		,"wrntIsueDt":""						// 영장신청발부 
		,"wrntReReqDt":""						// 재신청신청  
		,"wrntReReqPstrRjctDt":""				// 재신청검사기각  
		,"wrntReReqJudgRjctDt":""				// 재신청판사기각
		,"wrntReReqIsueDt":""					// 재신청발부 
		,"spItrgAplt":""						// 피의자심문신청인 
		,"spItrgSiNum":""						// 피의자심문일련번호 
		,"spItrgPstrNm":""						// 검사또는판사명 
		,"spItrgRcptDt":""						// 접수일시  
		,"spItrgApltTitl":""					// 접수자관직 
		,"spItrgApltNm":""						// 접수자성명 
		,"spItrgArstDt":""						// 구인일시 
		,"valdPi":""							// 유효기간 
		,"relsDt":""							// 석방연월일 
		,"relsRsn":""							// 석방사유 
		,"arstWrntRetn":""						// 반환 
		,"arstWrntComn":""						// 비고 
		,"nmKor":""								// 작성자이름
		,"docNum":""							// 문서번호
		,"attoNm":""							// 변호인
		,"nessSel":""							// 필요적 고려사항
		,"arstPla":""							// 구속장소
		,"overWeekResn":""						// 7일을 넘는 유효기간을 필요로 하는 취지와 사유
		,"overTwoPersRes":""					// 둘 이상의 영장을 신청하는 취지와 사유
}
//리포트맵
var M0103RTMap = {
	rexdataset : null
}