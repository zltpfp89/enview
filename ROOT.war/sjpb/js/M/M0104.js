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
	fn_M0104_pageInit();  
	
	if(parent.viewType == 'inc'){
		//피의자 검색버튼
		$("#spBtn").off("click").on("click", function() {	
			commonLayerPopup.openLayerPopup('/sjpb/Z/spLayerPopupList.face?rcptNum='+incMap.rcptNum, "1050px", "435px", callBackFn_M0104_searchRcptIncSuccess);
		});
	}
	
});
//화면 진입시 동작함
function fn_M0104_pageInit(){
	qCellList=[];
	
	//검색조건 노출
	queryString=$("#m0104_searchList").serialize();
	var d = document.m0104_searchList;
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
	//사건에서 보여질 경우, 사건에 필요한것만 노출 (본인데이터만)
	if(parent.viewType == 'inc'){
		queryString += "&rcptNumSc="+incMap.rcptNum;
	}
	goAjax("/sjpb/M/M0104selectList.face",queryString,callBackFn_M0104_selectListSuccess,true);
}
//구속영장신청부 리스트 그리기.
function callBackFn_M0104_selectListSuccess(data){	

	if(data.qCell ==''|| data.qCell==' '){
		if(parent.viewType == 'inc'){
			fn_M0104_newCathWrnt();
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
            	{width: '100',	key: 'reqDt',			title: ['신청일자','신청일자'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh시 mm분"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'apltTitl',			title: ['신청자관직','신청자관직'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'apltNm',			title: ['신청자성명','신청자성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spNm',			title: ['피의자','성명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spIdNum',			title: ['피의자','주민등록번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spJob',			title: ['피의자','직업'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'spAddr',			title: ['피의자','주거'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'rltActCriNmCdDesc',			title: ['피의자','죄명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'attoNm',			title: ['변호인','변호인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'overWeekResn',			title: ['7일을 넘는 유효기간을 필요로 하는 취지와 사유','7일을 넘는 유효기간을 필요로 하는 취지와 사유'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'overTwoPersRes',			title: ['둘 이상의 영장을 신청하는 취지와 사유','둘 이상의 영장을 신청하는 취지와 사유'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'prgsNum',			title: ['진행번호','진행번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathWrntPstrRjctDt',			title: ['검사기각','검사기각'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh시 mm분"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathWrntJudgRjctDt',			title: ['판사기각','판사기각'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh시 mm분"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathWrntIsueDt',			title: ['발부','발부'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh시 mm분"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathWrntReReqDt',			title: ['재신청','신청'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh시 mm분"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathWrntReReqPstrRjctDt',			title: ['재신청','검사기각'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh시 mm분"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathWrntReReqJudgRjctDt',			title: ['재신청','판사기각'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh시 mm분"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathWrntReReqIsueDt',			title: ['재신청','발부'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh시 mm분"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'valdPi',			title: ['유효기간','유효기간'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'execDt',			title: ['집행','일시'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDDhhmm", rule: "YYYY.MM.DD hh시 mm분"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'execPla',			title: ['집행','장소'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'execHandRst',			title: ['집행','처리결과'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'arstWrntReqBkNum',			title: ['구속영장신청','신청부번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'arstWrntReqIsueDt',			title: ['구속영장신청','발부연월일'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'relsDt',			title: ['석방','연월일'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'relsRsn',			title: ['석방','사유'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathWrntRetn',			title: ['반환','반환'],		sort:true, move:true, resize: true, options: {format: {type:"date",origin:"YYYYMMDD", rule: "YYYY.MM.DD"}}, styleclassname: {data: 'aligncenter fontsize18'}},
            	{width: '100',	key: 'cathWrntComn',			title: ['비고','비고'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize18'}}

            ]
            
        };
		QCELL.create(QCELLProp);
	    qcell = QCELL.getInstance("cell");
	    qcell.bind("click", eventFn);
	    if (qcell.getRows("data") > 0) {
	    	qcell.setRowStyle(2, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");
    		//첫번째 피의자 정보 세팅
	    	m0104VOMap = qcell.getRowData(2);
	    	fn_M0104_selectCathWrntSetting();
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
			fn_M0104_initM0104VOMap(); // 맵초기화
			m0104VOMap = qcell.getRowData(rowIdx);
			$("#afterDiv").show();
			//체포영장신청부 데이터 세팅
			fn_M0104_selectCathWrntSetting();
			//수정세팅
			updateYN();
		}
	}
}

//체포영장신청부 데이터 세팅
function fn_M0104_selectCathWrntSetting(){	
	
	getAreaMap($("#M0104CathWrnt"), m0104VOMap);
	
	$("#incNum").html(m0104VOMap.rcptIncNum);
	$("#rcptNum").val(m0104VOMap.rcptNum);
	
	Fn_M_SettingDate(m0104VOMap.reqDt,"reqDt");
	Fn_M_SettingDate(m0104VOMap.cathWrntPstrRjctDt,"cathWrntPstrRjctDt");
	Fn_M_SettingDate(m0104VOMap.cathWrntJudgRjctDt,"cathWrntJudgRjctDt");
	Fn_M_SettingDate(m0104VOMap.cathWrntIsueDt,"cathWrntIsueDt");
	Fn_M_SettingDate(m0104VOMap.cathWrntReReqDt,"cathWrntReReqDt");
	Fn_M_SettingDate(m0104VOMap.cathWrntReReqPstrRjctDt,"cathWrntReReqPstrRjctDt");
	Fn_M_SettingDate(m0104VOMap.cathWrntReReqJudgRjctDt,"cathWrntReReqJudgRjctDt");
	Fn_M_SettingDate(m0104VOMap.cathWrntReReqIsueDt,"cathWrntReReqIsueDt");
	Fn_M_SettingDate(m0104VOMap.execDt,"execDt");
}
//시,분,초 날짜형식 세팅
function fn_M0104_joinDate(vo){
	vo.reqDt = Fn_M_StoreDate($("#reqDtCal").val(),$("#reqDtHour").val(),$("#reqDtMin").val());
	vo.cathWrntPstrRjctDt = Fn_M_StoreDate($("#cathWrntPstrRjctDtCal").val(),$("#cathWrntPstrRjctDtHour").val(),$("#cathWrntPstrRjctDtMin").val());
	vo.cathWrntJudgRjctDt = Fn_M_StoreDate($("#cathWrntJudgRjctDtCal").val(),$("#cathWrntJudgRjctDtHour").val(),$("#cathWrntJudgRjctDtMin").val());
	vo.cathWrntIsueDt = Fn_M_StoreDate($("#cathWrntIsueDtCal").val(),$("#cathWrntIsueDtHour").val(),$("#cathWrntIsueDtMin").val());
	vo.cathWrntReReqDt = Fn_M_StoreDate($("#cathWrntReReqDtCal").val(),$("#cathWrntReReqDtHour").val(),$("#cathWrntReReqDtMin").val());
	vo.cathWrntReReqPstrRjctDt = Fn_M_StoreDate($("#cathWrntReReqPstrRjctDtCal").val(),$("#cathWrntReReqPstrRjctDtHour").val(),$("#cathWrntReReqPstrRjctDtMin").val());
	vo.cathWrntReReqJudgRjctDt = Fn_M_StoreDate($("#cathWrntReReqJudgRjctDtCal").val(),$("#cathWrntReReqJudgRjctDtHour").val(),$("#cathWrntReReqJudgRjctDtMin").val());
	vo.cathWrntReReqIsueDt = Fn_M_StoreDate($("#cathWrntReReqIsueDtCal").val(),$("#cathWrntReReqIsueDtHour").val(),$("#cathWrntReReqIsueDtMin").val());
	vo.execDt = Fn_M_StoreDate($("#execDtCal").val(),$("#execDtHour").val(),$("#execDtMin").val());
}
//수정 가능 버튼 보이기 여부
function updateYN(){
	if(parent.viewType == 'inc'){
		if(m0104VOMap.regUserId == $("#userId").val() ){
			freezeInput(false); // 입력 활성화
			$("#btnUpdateCathWrnt").show();  //수정버튼 보이기
			$("#btnSearchInc").show(); // 검색버튼보이기
		}else{
			freezeInput(true); // 입력 비활성화
			$("#btnUpdateCathWrnt").hide();  //수정버튼 숨기기
			$("#btnSearchInc").hide(); // 검색버튼숨기기
		}
		$("#btnInsertCathWrnt").hide();  //저장버튼 숨기기
		$("#btnReqPrtCathWrnt").show();  //신청서 출력 보이기
		$("#btnPrtCathWrnt").show();  //대장 출력 보이기
	}
}

//사건검색 성공함수
function callBackFn_M0104_searchRcptIncSuccess(data){

	$("#rcptNum").val(data.rcptNum);
	$("#incSpNum").val(data.incSpNum);
	$("#incNum").html(data.incNum);
	$("input[name=spNm]").val(Base64.decode(data.spNm));								// 피의자 성명 출력
	$("#spIdNum").html(Base64.decode(data.spIdNum));						// 피의자 주민등록번호 출력
	$("#spJob").html(Base64.decode(data.spJob));							// 피의자 직업 출력
	$("#spAddr").html(Base64.decode(data.spAddr));							// 피의자 주거 출력
	$("#rltActCriNmCdDesc").html(data.rltActCriNmCdDesc);					// 피의자 죄명 출력
}

//맵초기화
function fn_M0104_initM0104VOMap() {
	m0104VOMap={
				"cathWrntReqBkNum":"" 				//체포영장신청부번호
				,"prgsNum":""						//진행번호
				,"rcptIncNum":""					// 사건번호 
				,"rcptNum":""						//접수번호
				,"reqDt":""							//신청일
				,"apltTitl":""						//신청자관직
				,"apltNm":""						//신청자성명
				,"incSpNum":""						//피의자번호
				,"spNm":""							// 피의자 성명 
				,"spIdNum":""						// 피의자 주민등록번호 
				,"spJob":""							// 피의자 직업 
				,"spAddr":""						// 피의자 주거 
				,"rltActCriNmCdDesc":""				// 죄명 
				,"cathWrntPstrRjctDt":""			//검사기각일시
				,"cathWrntJudgRjctDt":""			//판사기각일시			
				,"cathWrntIsueDt":""				//발부일시
				,"cathWrntReReqDt":""				//재신청일시
				,"cathWrntReReqPstrRjctDt":""		//재신청검사기각일시
				,"cathWrntReReqJudgRjctDt":""		//재신청판사기각일시
				,"cathWrntReReqIsueDt":""			//재신청발부일시
				,"valdPi":""						//유효기간
				,"execDt":""						//집행일시
				,"execPla":""						//집행장소
				,"execHandRst":""					//집행처리결과
				,"arstWrntReqBkNum":""				//구속영장신청신청부번호
				,"arstWrntReqIsueDt":""				//구속영장신청발부연월일
				,"relsDt":""						//석방연월일
				,"relsRsn":""						//석방사유
				,"cathWrntRetn":""					//반환
				,"cathWrntComn":""					//비고 
				,"regUserId":""
				,"nmKor":""
				,"docNum":"" 						//문서번호
				,"attoNm":""						//변호인
				,"overWeekResn":""					//7일을 넘는 유효기간을 필요로 하는 취지와 사유
				,"overTwoPersRes":""				//둘 이상의 영장을 신청하는 취지와 사유
	}
	Fn_M_CleanDate("reqDt");
	Fn_M_CleanDate("cathWrntPstrRjctDt");
	Fn_M_CleanDate("cathWrntJudgRjctDt");
	Fn_M_CleanDate("cathWrntIsueDt");
	Fn_M_CleanDate("cathWrntReReqDt");
	Fn_M_CleanDate("cathWrntReReqPstrRjctDt");
	Fn_M_CleanDate("cathWrntReReqJudgRjctDt");
	Fn_M_CleanDate("cathWrntReReqIsueDt");
	Fn_M_CleanDate("execDt");
}

//신규등록
function fn_M0104_newCathWrnt(){
	
	$("#afterDiv").hide();	//대장 양식 숨기기
	$("#btnReqPrtCathWrnt").hide();	//신청서 출력 버튼 보이기
	$("#btnPrtCathWrnt").hide();//대장 출력 버튼 보이기
	
	fn_M0104_initM0104VOMap(); //맵초기화
	fn_M0104_selectCathWrntSetting(); // 데이터 세팅	
	freezeInput(false); // 입력 활성화
	$("#btnSearchInc").show(); // 검색버튼보이기
	$("#btnInsertCathWrnt").show(); // 저장버튼 보이기	
	$("#btnUpdateCathWrnt").hide(); // 수정버튼 숨기기	
	$("#rcptNum").val(incMap.rcptNum);
	$("#prgsNum").html("신규");
	$("#incNum").html(isNull(incMap.rcptIncNum) ? "(피의자 선택시 자동입력)" : incMap.rcptIncNum);					//사건번호 세팅
	$("#spIdNum").html("(피의자 선택시 자동입력)");
	$("#spJob").html("(피의자 선택시 자동입력)");
	$("#spAddr").html("(피의자 선택시 자동입력)");
	$("#rltActCriNmCdDesc").html("(피의자 선택시 자동입력)");
}
//등록하기
function fn_M0104_insertCathWrnt(){
	//유효성검사
	if(incMap.combIncYn != "N"&& incMap.pareIncNum != incMap.incNum){
		alert("병합된 사건입니다. "+incMap.pareIncNum+"사건에서 진행가능합니다.");
		return;
	}
	setAreaMap($("#M0104CathWrnt"), m0104VOMap);
	m0104VOMap.rcptNum = $("#rcptNum").val();
	m0104VOMap.incSpNum = $("#incSpNum").val();
	m0104VOMap.rcptIncNum = $("#incNum").html();

	if(m0104VOMap.incSpNum == null || m0104VOMap.incSpNum == "" || m0104VOMap.incSpNum ==" "){
		alert("피의자를 선택해주세요.");
		return;
	}
	
	if(Fn_M_CheckingDate("신청일자",$("#reqDtCal").val(),$("#reqDtHour").val(),$("#reqDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("검사기각",$("#cathWrntPstrRjctDtCal").val(),$("#cathWrntPstrRjctDtHour").val(),$("#cathWrntPstrRjctDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("판사기각",$("#cathWrntJudgRjctDtCal").val(),$("#cathWrntJudgRjctDtHour").val(),$("#cathWrntJudgRjctDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("발부",$("#cathWrntIsueDtCal").val(),$("#cathWrntIsueDtHour").val(),$("#cathWrntIsueDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("재신청 신청",$("#cathWrntReReqDtCal").val(),$("#cathWrntReReqDtHour").val(),$("#cathWrntReReqDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("재신청 검사기각",$("#cathWrntReReqPstrRjctDtCal").val(),$("#cathWrntReReqPstrRjctDtHour").val(),$("#cathWrntReReqPstrRjctDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("영재신청 판사기각",$("#cathWrntReReqJudgRjctDtCal").val(),$("#cathWrntReReqJudgRjctDtHour").val(),$("#cathWrntReReqJudgRjctDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("재신청 발부",$("#cathWrntReReqIsueDtCal").val(),$("#cathWrntReReqIsueDtHour").val(),$("#cathWrntReReqIsueDtMin").val()) == false) "noDate";
	if(Fn_M_CheckingDate("집행일시",$("#execDtCal").val(),$("#execDtHour").val(),$("#execDtMin").val()) == false) return;
	
	fn_M0104_joinDate(m0104VOMap);
	
	goAjaxDefault("/sjpb/M/M0104insertCathWrnt.face",m0104VOMap,callBackFn_M0104_insertCathWrntSuccess);
	
	$("#btnSearchInc").hide(); // 검색버튼 숨기기
	$("#btnInsertCathWrnt").hide(); //저장버튼 숨기기
	
}

//등록성공함수 호출
function callBackFn_M0104_insertCathWrntSuccess(data){
	if(data == 1){
		alert("체포영장신청부가 등록되었습니다.");
	}else{
		alert("체포영장신청부 등록실패하였습니다.");
	}
	//페이지 리셋
	fn_M0104_pageInit();
	freezeInput(true); // 입력 비활성화
}
//수정
function fn_M0104_updateCathWrnt(){
	setAreaMap($("#M0104CathWrnt"), m0104VOMap);
	m0104VOMap.rcptNum = $("#rcptNum").val();
	m0104VOMap.incSpNum = $("#incSpNum").val();
	m0104VOMap.rcptIncNum = $("#incNum").html();
	
	if(Fn_M_CheckingDate("신청일자",$("#reqDtCal").val(),$("#reqDtHour").val(),$("#reqDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("검사기각",$("#cathWrntPstrRjctDtCal").val(),$("#cathWrntPstrRjctDtHour").val(),$("#cathWrntPstrRjctDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("판사기각",$("#cathWrntJudgRjctDtCal").val(),$("#cathWrntJudgRjctDtHour").val(),$("#cathWrntJudgRjctDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("발부",$("#cathWrntIsueDtCal").val(),$("#cathWrntIsueDtHour").val(),$("#cathWrntIsueDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("재신청 신청",$("#cathWrntReReqDtCal").val(),$("#cathWrntReReqDtHour").val(),$("#cathWrntReReqDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("재신청 검사기각",$("#cathWrntReReqPstrRjctDtCal").val(),$("#cathWrntReReqPstrRjctDtHour").val(),$("#cathWrntReReqPstrRjctDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("영재신청 판사기각",$("#cathWrntReReqJudgRjctDtCal").val(),$("#cathWrntReReqJudgRjctDtHour").val(),$("#cathWrntReReqJudgRjctDtMin").val()) == false) return;
	if(Fn_M_CheckingDate("재신청 발부",$("#cathWrntReReqIsueDtCal").val(),$("#cathWrntReReqIsueDtHour").val(),$("#cathWrntReReqIsueDtMin").val()) == false) "noDate";
	if(Fn_M_CheckingDate("집행일시",$("#execDtCal").val(),$("#execDtHour").val(),$("#execDtMin").val()) == false) return;
	
	fn_M0104_joinDate(m0104VOMap);
	
	goAjaxDefault("/sjpb/M/M0104updateCathWrnt.face",m0104VOMap,callBackFn_M0104_updateCathWrntSuccess);
}
//수정성공함수 호출
function callBackFn_M0104_updateCathWrntSuccess(data){
	if(data == 1){
		alert("수정되었습니다.");
	}else{
		alert("수정에 실패하였습니다.");
	}
	//페이지 리셋
	fn_M0104_pageInit();
	freezeInput(true); // 입력 비활성화
}
//체포영장신청부 출력
function fn_M0104_prnReport() {
	var cathWrntReqBkNumMap = {
			"cathWrntReqBkNum" : document.M0104CathWrnt.cathWrntReqBkNum.value
	};
	//체포영장신청부 레포트 성공함수 호출
	goAjaxDefault("/sjpb/M/M0104prnReport.face", cathWrntReqBkNumMap, callBackFn_M0104_prtCathWrntReportSuccess);
}
//체포영장신청부 출력 성공함수
function callBackFn_M0104_prtCathWrntReportSuccess(data){
	M0104RTMap.rexdataset = data.rexdataset;
	
	var xmlString = objectToXml(M0104RTMap);
	$("#reptNm").val("M0104.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	//레포트 호출
	openReportService(reportForm); 
}
//체포영장신청부 체크리스트 출력
function fn_M0104_prnCheckReport() {
	
	var cathWrntReqBkNumList = [];
	for(var i = 2; i <= qcell.getRows("data")+1; i++){
		if(JSON.stringify(qcell.getCellLabel(i,1)) == "true"){
			cathWrntReqBkNumList.push(qcell.getRowData(i).cathWrntReqBkNum);
		}	
	}
	var cathWrntReqBkNumListMap = {
			"cathWrntReqBkNumList":cathWrntReqBkNumList
	}
	
	if(cathWrntReqBkNumList.length != 0){
		//체포영장신청부 체크 리스트 레포트 성공함수 호출
		goAjaxDefault("/sjpb/M/M0104prnCheckReport.face", cathWrntReqBkNumListMap, callBackFn_M0104_prtCathWrntReportSuccess);
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
//초기화
function fn_M0104_init(form){
	$("#"+form)[0].reset();	
}

//신청서 출력
function requestReport(){
	$("#reptNm").val("M0211.crf"); //레포트 파일명
	$("#SEQNUM").val(m0104VOMap.cathWrntReqBkNum);
	//레포트 호출
	openReportServiceFSS(reportForm); 
}

//맵
var m0104VOMap={
		"cathWrntReqBkNum":"" 				//체포영장신청부번호
		,"prgsNum":""						//진행번호
		,"rcptIncNum":""						// 사건번호
		,"rcptNum":""						//접수번호
		,"reqDt":""							//신청일
		,"apltTitl":""						//신청자관직
		,"apltNm":""						//신청자성명
		,"incSpNum":""						//피의자번호
		,"spNm":""								// 피의자 성명 
		,"spIdNum":""							// 피의자 주민등록번호 
		,"spJob":""								// 피의자 직업 
		,"spAddr":""							// 피의자 주거 
		,"rltActCriNmCdDesc":""					// 죄명 
		,"cathWrntPstrRjctDt":""			//검사기각일시
		,"cathWrntJudgRjctDt":""			//판사기각일시			
		,"cathWrntIsueDt":""				//발부일시
		,"cathWrntReReqDt":""				//재신청일시
		,"cathWrntReReqPstrRjctDt":""		//재신청검사기각일시
		,"cathWrntReReqJudgRjctDt":""		//재신청판사기각일시
		,"cathWrntReReqIsueDt":""			//재신청발부일시
		,"valdPi":""						//유효기간
		,"execDt":""						//집행일시
		,"execPla":""						//집행장소
		,"execHandRst":""					//집행처리결과
		,"arstWrntReqBkNum":""				//구속영장신청신청부번호
		,"arstWrntReqIsueDt":""				//구속영장신청발부연월일
		,"relsDt":""						//석방연월일
		,"relsRsn":""						//석방사유
		,"cathWrntRetn":""					//반환
		,"cathWrntComn":""					//비고
		,"regUserId":""
		,"nmKor":""
		,"docNum":"" 						//문서번호
		,"attoNm":""						//변호인
		,"overWeekResn":""					//7일을 넘는 유효기간을 필요로 하는 취지와 사유
		,"overTwoPersRes":""				//둘 이상의 영장을 신청하는 취지와 사유
}
//리포트맵
var M0104RTMap = {
	rexdataset : null
}