$(function(){
	pageInit();
});

var qcell;     //인사관리리스트

//화면 진입시 동작함
function pageInit(){
	
	//인사관리 화면(리스트)을 가져온다.	
	selectCriMbMngList();
	
	//이벤트바인딩
	eventSetup();
	
	//경력관리탭 이벤트 설정
	eventSetupCR();
	
	//전문관관리탭 이벤트 설정
	eventSetupPO();		
	
	//버튼그룹 설정
	handleBtnGroup();
	
}

//이벤트처리
function eventSetup() {
	
	//검색조건 초기화
	$("#initBtn").on("click", function() {
		var searchArea = $("div[class=searchArea]");		
		//input 값 초기화
		searchArea.find("input[type=text]").val("");
		
		//select 값 초기화
		searchArea.find("select").each(function() {
			$(this).find("option:eq(0)").prop("selected", true);
			$(this).prev('.txt').text($(this).find('option:selected').text());
		});
		
		//검색맵 초기화
		l0101SCMap = {
		    rcptIncNumSC : "" //사건번호
		   ,spNmSC : "" //피의자	   
		   ,incCriNmSC : "" //위법조항	  
		   ,stsGrapFillDtFromSC : ""   //작성일자 시작일자
		   ,stsGrapFillDtToSC : ""     //작성일자 종료일자			   
		}	
	});
	
	//조건검색호출
	$("#srchBtn").on("click", function() {
		selectCriMbMngList();
	});	
	
	
	$(".searchArea input[type=text],.searchArea select").keypress(function(e){
		if(e.keyCode == 13){
			e.stopPropagation();
			selectCriMbMngList();
		}
	});
	
	
	//추가
	$("#addBtn").off("click").on("click", function() {		
		addNewCriMbMngDts(); //신규유저추가	
		$("#criMbDtsTab").trigger('click');
	});
	
	//저장
	$("#saveBtn").off("click").on("click", function() {		
		
		//유효성 체크
		/*
		var chkObjs = $("#contents");
		if(!chkValidate.check(chkObjs, true)) return;		
		*/
		//syncL0101VOMap();
		
		if (l0101VOMap.recdType == "I") {
			if(syncL0101VOMap(true)){
				insertCriMbMngDts(); //인사관리 업데이트
			}
		} else {
			if(syncL0101VOMap(true)){
				debugger;
				updateCriMbMngDts(); //인사관리 업데이트
			}
		}
	});
	
	//비밀번호 초기화	
	$("#pwdBtn").off("click").on("click", function() {
		
		//패스워드 생성
		l0101VOMap.criMbPwd = password_generator(8);
		l0101VOMap.criMbPwdRe = l0101VOMap.criMbPwd;
		$("#criMbPwd").val(l0101VOMap.criMbPwd);
		$("#criMbPwdRe").val(l0101VOMap.criMbPwdRe);
		$("#genPwdSpan").html(l0101VOMap.criMbPwdRe);
			
	});	
	
	//계정중복확인
	$("#dupBtn").off("click").on("click", function() {
		checkDupId();
	});
	
}


//Map 데이터 갱신
function syncL0101VOMap(isValid) {
	
	//유효성체크 여부에 따라 체크함 
	if(isValid){
		//유효성 체크
		var chkObjs = $("#criMbDtsTab");
		if(!chkValidate.check(chkObjs, true)) return;
	}
	
	l0101VOMap.nmKor = getFieldValue($("#nmKor"));
	l0101VOMap.isEnabled = getFieldValue($("select[name=isEnabled]"));
	l0101VOMap.criMbId = getFieldValue($("#criMbId"));
	l0101VOMap.criMbPwd = Base64.encode(getFieldValue($("#criMbPwd")));
	l0101VOMap.criMbPwdRe = Base64.encode(getFieldValue($("#criMbPwdRe")));
	l0101VOMap.criMbSroc = getFieldValue($("select[name=criMbSroc]"));
	l0101VOMap.criMbClas = getFieldValue($("select[name=criMbClas]"));
	l0101VOMap.criMbPosi = getFieldValue($("select[name=criMbPosi]"));	
	l0101VOMap.dispGuof = getFieldValue($("select[name=dispGuof]"));
	l0101VOMap.criTmId = getFieldValue($("select[name=criTmId]"));
	l0101VOMap.sexFlag = getFieldValue($("select[name=sexFlag]"));	
	l0101VOMap.regNo = getFieldValue($("#regNo"));	
	l0101VOMap.initApptDt = getFieldValue($("#initApptDt"));
	l0101VOMap.currPosiDt = getFieldValue($("#currPosiDt"));
	l0101VOMap.criOffiApptDt = getFieldValue($("#criOffiApptDt"));
	l0101VOMap.criOffiEdDt = getFieldValue($("#criOffiEdDt"));
	l0101VOMap.criProfOffiBeDt = getFieldValue($("#criProfOffiBeDt"));
	l0101VOMap.criProfOffiEdDt = getFieldValue($("#criProfOffiEdDt"));	
	/*l0101VOMap.homeAddr1 = getFieldValue($("#homeAddr1"));
	l0101VOMap.homeAddr2 = getFieldValue($("#homeAddr2"))
	l0101VOMap.mobileTel = getFieldValue($("#mobileTelA")) + "-" + getFieldValue($("#mobileTelB")) + "-" + getFieldValue($("#mobileTelC"));	*/
	l0101VOMap.intro = getFieldValue($("#intro"));
	l0101VOMap.acesIp = getFieldValue($("#acesIpA")) + "." + getFieldValue($("#acesIpB")) + "." + getFieldValue($("#acesIpC")) + "." + getFieldValue($("#acesIpD"));	
	l0101VOMap.emailAddr = getFieldValue($("#emailAddr"));
	
	l0101VOMap.dispBeDt = getFieldValue($("#dispBeDt"));
	l0101VOMap.dispEdDt = getFieldValue($("#dispEdDt"));
	l0101VOMap.miPreDeptNm = getFieldValue($("#miPreDeptNm"));
	l0101VOMap.moAftrDeptNm = getFieldValue($("#moAftrDeptNm"));
	l0101VOMap.sprPsn = getFieldValue($("select[name=sprPsn]"));	
	debugger;
	return true;
}


//인사관리 화면(리스트)을 가져온다. 
function selectCriMbMngList(){
	
	//최소화 되어 있으면 검색중단
	if(!$('#sheet:visible').length) return;
	
	l0101SCMap.criTmIdSC = $("#criTmIdSC").val(); //수사팀
	l0101SCMap.nmKorSC = $("#nmKorSC").val();   //수사관
	l0101SCMap.criMbStatSC = $("#criMbStatSC").val();   //상태
		
	goAjax("/sjpb/L/selectCriMbMngList.face", l0101SCMap, callBackSelectCriMbMngListSuccess)
	
}


//인사관리 화면(리스트) 콜백함수
function callBackSelectCriMbMngListSuccess(data) {
   
    var QCELLProp = {
       "parentid" : "sheet",
       "id"		: "qcell",
       "data"		: {"input" : data.qCell},
       "selectmode": "cell",         
       "columns"	: [	    		    	   
       	{width: '25%',	key: 'criTmNm',			title: ['수사팀'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
       	{width: '15%',	key: 'nmKor',			title: ['이름'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},       	
       	{width: '15%',	key: 'criMbId',			    title: ['계정'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
       	{width: '15%',	key: 'isEnabledDesc',			title: ['계정상태'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
       	{width: '15%',	key: 'criMbPosiDesc',			title: ['직위'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},       	
       	{width: '15%',	key: 'criMbClasDesc',			title: ['직급'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
       	]
         , "rowheaders": ["sequence"]
       /*
   		 , "pagination":
         {
             "unitlist": [5, 10, 20, 30, 40, 50, 100, 150]
           , "pageunit": 5
           , "pagecount": 10
           , "mode": 'extend'
           , "extendmove": true
         }
         */   			
   };	
	
	
   QCELL.create(QCELLProp);
   qcell = QCELL.getInstance("qcell");
   qcell.bind("click", eventClickFn);
   
   //최초 로딩시
   if (qcell.getRows("data") > 0) {
	   qcell.setRowStyle(1, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
	   
	   l0101VOMap = qcell.getRowData(1);
	   selectCriMbMngDts();
	   
   } 
   
}

//인사관리 상세를 가져온다. 
function selectCriMbMngDts(){
	
	goAjax("/sjpb/L/selectCriMbMngDts.face", l0101VOMap, callBackSelectCriMbMngDtsSuccess);
	
}


//인사관리 상세 콜백함수
function callBackSelectCriMbMngDtsSuccess(data) {
	
	
	l0101VOMap = data.l0101VO;	
	l0102VOMap.criMbId = l0101VOMap.criMbId;
	l0103VOMap.criMbId = l0101VOMap.criMbId;
	syncL0101VOPage();
	
	//계정중복확인 버튼영역
	$("#dupDiv").hide();
	
	//탭별 조회기능
	if ($("li.m2 > div.tab_mini_contents").is(":visible")) { //경력관리
		selectCarrMngList();
	} else if ($("li.m3 > div.tab_mini_contents").is(":visible")) { //전문관관리
		selectProfOffiMngList();
	} 	
	
}



//계정중복확인 
function checkDupId(){
	var criMbId = getFieldValue($("#criMbId"));
	if(criMbId == null || criMbId == ""){
		alert("계정을 입력하세요.");
		return false;
	}
	syncL0101VOMap(false);
	goAjax("/sjpb/L/selectCriMbMngDts.face", l0101VOMap, callBackCheckDupIdSuccess);
	
}


//계정중복확인 콜백함수
function callBackCheckDupIdSuccess(data) {
	
	
	
	if (data.l0101VO == undefined) {
		$("#isDupId").val("N");
		$("#criMbId").attr("readonly",true);
		$("#dupBtn span").html("계정사용가능");
		alert("해당계정은 사용가능합니다.");
	} else {
		$("#isDupId").val("Y");
		$("#criMbId").attr("readonly",false);
		$("#dupBtn span").html("계정중복확인");
		alert("해당계정은 사용 불가능합니다.");
	}
	
}	



//화면 갱신
function syncL0101VOPage() {
	
	

	setFieldValue($("#nmKor"), l0101VOMap.nmKor);
	setFieldValue($("select[name=isEnabled]"), l0101VOMap.isEnabled);
	setFieldValue($("select[name=isEnabled]"), l0101VOMap.criMbStat);
	setFieldValue($("#criMbId"), l0101VOMap.criMbId);
	setFieldValue($("select[name=criMbSroc]"), l0101VOMap.criMbSroc);
	setFieldValue($("select[name=criMbClas]"), l0101VOMap.criMbClas);
	setFieldValue($("select[name=criMbPosi]"), l0101VOMap.criMbPosi);
	setFieldValue($("select[name=dispGuof]"), l0101VOMap.dispGuof);
	setFieldValue($("select[name=criTmId]"), l0101VOMap.criTmId);
	setFieldValue($("select[name=sexFlag]"), l0101VOMap.sexFlag);
	setFieldValue($("#initApptDt"), l0101VOMap.initApptDt);
	setFieldValue($("#currPosiDt"), l0101VOMap.currPosiDt);
	setFieldValue($("#criOffiApptDt"), l0101VOMap.criOffiApptDt);
	setFieldValue($("#criOffiEdDt"), l0101VOMap.criOffiEdDt);
	setFieldValue($("#criProfOffiBeDt"), l0101VOMap.criProfOffiBeDt);
	setFieldValue($("#criProfOffiEdDt"), l0101VOMap.criProfOffiEdDt);	
	setFieldValue($("#regNo"), l0101VOMap.regNo);
	/*
	setFieldValue($("#homeAddr1"), l0101VOMap.homeAddr1);
	setFieldValue($("#homeAddr2"), l0101VOMap.homeAddr2);
	setFieldValue($("#mobileTelA"), getCnttNumA(l0101VOMap.mobileTel));
	setFieldValue($("#mobileTelB"), getCnttNumB(l0101VOMap.mobileTel));
	setFieldValue($("#mobileTelC"), getCnttNumC(l0101VOMap.mobileTel));	
	*/
	setFieldValue($("#intro"), l0101VOMap.intro);	
	setFieldValue($("#acesIpA"), getAcesIpA(l0101VOMap.acesIp));
	setFieldValue($("#acesIpB"), getAcesIpB(l0101VOMap.acesIp));
	setFieldValue($("#acesIpC"), getAcesIpC(l0101VOMap.acesIp));
	setFieldValue($("#acesIpD"), getAcesIpD(l0101VOMap.acesIp));
	setFieldValue($("#emailAddr"), l0101VOMap.emailAddr);	
	setFieldValue($("#dispBeDt"), l0101VOMap.dispBeDt);	
	setFieldValue($("#dispEdDt"), l0101VOMap.dispEdDt);	
	setFieldValue($("#miPreDeptNm"), l0101VOMap.miPreDeptNm);	
	setFieldValue($("#moAftrDeptNm"), l0101VOMap.moAftrDeptNm);	
	setFieldValue($("select[name=sprPsn]"), l0101VOMap.sprPsn);
	setFieldValue($("#criMbPwd"), "");
	setFieldValue($("#criMbPwdRe"), "");
	if (l0101VOMap.recdType == "I") {
		$("#criMbId").removeAttr('readonly');
	} else {
		$("#criMbId").attr('readonly','readonly');
	}
		
	$("#authFailures").html(l0101VOMap.authFailures);
	$("#genPwdSpan").html("");
	
}

//인사관리 마스터 추가 
function insertCriMbMngDts(){	
	
	if($("#isDupId").val() == "Y") {
		alert("계정중복확인을 먼저 선택해주세요.");
		return false;
	}
	
	if (l0101VOMap.criMbPwd != l0101VOMap.criMbPwdRe) {
		alert("비밀번호와 비밀번호 확인이 동일하지 않습니다.");
		return false;
	}	
	
	goAjax("/sjpb/L/insertCriMbMngDts.face", l0101VOMap, callBackInsertCriMbMngDtsSuccess);	
}


//인사관리 마스터 추가 콜백함수
function callBackInsertCriMbMngDtsSuccess(data) {
	
	alert("정상적으로 신규유저가 추가되었습니다.");
	selectCriMbMngList(); //신규 호출
}

//인사관리 업데이트 
function updateCriMbMngDts(){
	
	if (l0101VOMap.criMbPwd != l0101VOMap.criMbPwdRe) {
		alert("비밀번호와 비밀번호 확인이 동일하지 않습니다.");
		return false;
	}	
	
	goAjax("/sjpb/L/updateCriMbMngDts.face", l0101VOMap, callBackUpdateCriMbMngDtsSuccess);	
	
}


//인사관리 업데이트 콜백함수
function callBackUpdateCriMbMngDtsSuccess(data) {
	
	alert("정상적으로 저장되었습니다.");
	selectCriMbMngList(); //신규 호출
}



//changePassword
//비밀번호 초기화
function changePassword(){
	
	l0101VOMap.criMbPwd = Base64.encode(l0101VOMap.criMbId);
	l0101VOMap.criMbPwdRe = Base64.encode(l0101VOMap.criMbId);
	
	goAjax("/sjpb/L/changePassword.face", l0101VOMap, callBackChangePasswordSuccess);	
}


//비밀번호 초기화 콜백함수
function callBackChangePasswordSuccess(data) {
	
	alert("정상적으로 비밀번호가 초기화되었습니다.");
	
}


//리스트 셀 클릭 이벤트 
function eventClickFn(e){
	
	var objQCell = e.data.target;
	
	//선택한 인덱스 가져오기
	var rowIdx = qcell.getIdx("row");
	var colIdx = qcell.getSelectedCol();

	qcell.removeRowStyle(qcell.getIdx("row","focus","previous") == -1?1:qcell.getIdx("row","focus","previous"));
	qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
		
	//상세 호출
	if (rowIdx > 0) {
		l0101VOMap = qcell.getRowData(rowIdx);
		selectCriMbMngDts();
	}
}

//신규 유저 생성 데이터 설정
function addNewCriMbMngDts() {

	l0101VOMap = {		
			criMbClas : ""
			,criMbId : ""
			,criMbPosi : ""
			,criMbPosiDesc : ""
			,criMbSroc : ""
			,criMbStat : "1"
			,criOffiApptDt : ""
			,criOffiEdDt : ""
			,criProfOffiBeDt : ""
			,criProfOffiEdDt : ""
			,criProfOffiYn : ""
			,criTmId : ""
			,criTmNm : ""
			,currPosiDt : ""
			,dispGuof : ""
			,initApptDt : ""
			,isEnabled : "1"
			,isEnabledDesc : ""
			,kindCd : ""
			,kindCdDesc : ""
			,nmKor : ""
			,regDate : ""
			,regUserId : $("#userId").val()
			,updDate : ""
			,updUserId : $("#userId").val()
			,regNo : ""
			,homeAddr1 : ""
			,homeAddr2 : ""
			,mobileTelP1 : ""
			,mobileTelP2 : ""
			,mobileTelP3 : ""
			,intro : ""	
			,acesIp : ""	
			,emailAddr : "" 	
			,recdType : "I"	
			,dispBeDt : ""
			,dispEdDt : ""
			,miPreDeptNm : ""
			,moAftrDeptNm : ""
			,sprPsn :""
		};
		syncL0101VOPage();
		
		//계정중복체크 N
		$("#isDupId").val("Y");
		$("#criMbId").attr("readonly",false);
		$("#dupBtn span").html("계정중복확인");
		$("#dupDiv").show();
		$("#genPwdSpan").html("");
}

//유저와 타스크상태에 따른 버튼 활성화 처리
function handleBtnGroup() {
	
	//인사담당자가 아니면 읽기 전용 처리
	if (!SJPBRole.getHrRoleYn()) {
		$("a.btn_white, a.btn_blue").each(function(index) {
			if (($(this).attr("id") == "initBtn") || ($(this).attr("id") == "srchBtn") ) {
				$(this).show();
			} else {
				$(this).hide();
			}
		});
	}
	
}

//인사관리 데이터맵
var l0101VOMap = {		
	criMbClas : ""
	,criMbId : ""
	,criMbPwd : ""
	,criMbPwdRe : ""	
	,criMbPosi : ""
	,criMbPosiDesc : ""
	,criMbSroc : ""
	,criMbStat : ""
	,criOffiApptDt : ""
	,criOffiEdDt : ""
	,criProfOffiBeDt : ""
	,criProfOffiEdDt : ""
	,criProfOffiYn : ""
	,criTmId : ""
	,criTmNm : ""
	,currPosiDt : ""
	,dispGuof : ""
	,initApptDt : ""
	,isEnabled : ""
	,isEnabledDesc : ""
	,kindCd : ""
	,kindCdDesc : ""
	,nmKor : ""
	,regDate : ""
	,regUserId : ""
	,updDate : ""
	,updUserId : ""
	,regNo : ""
	,homeAddr1 : ""
	,homeAddr2 : ""
	,mobileTelP1 : ""
	,mobileTelP2 : ""
	,mobileTelP3 : ""
	,intro : ""	
	,acesIp : ""	
	,emailAddr : "" 	
	,recdType : ""
	,dispBeDt : ""
	,dispEdDt : ""
	,miPreDeptNm : ""
	,moAftrDeptNm : ""
	,sprPsn :""
}

//검색조건
var l0101SCMap = {
   criTmIdSC : "" //사건번호
  ,nmKorSC : "" //피의자	   
  ,criMbStatSC : "" //위법조항
}
