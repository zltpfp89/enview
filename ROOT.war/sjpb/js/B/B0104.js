$(document).ready(function(){
	pageInit();
});

//var isInitStyleQcell = false;
var rowIdx ;	//선택한 인덱스 전역변수관리
var qcell;
var qcellHist;
//var qcell1;
var b0101VOMap = new Object();
var isRootInc;	//병합된 자식사건 여부
var isSpUpdate = false;	//피의자 수정가능여부

var countSp = 0;	//라디오박스 아이디 구분을 위해 커스텀

var initRcptNum = "";

//화면 진입시 동작함
function pageInit(){
	
	//initRcptNum 가 있으면, 
	if(typeof initRcptNumTmp != 'undefined'){
		initRcptNum = initRcptNumTmp;
	}
	
	selectList(initRcptNum, true);
	
	//이벤트바인딩
	eventInitSetup();
	
	$("#exceldownIncPrnBtn").show();
	
	//송치관일경우, 범죄사건부출력 버튼 노출 2018.12.04 추가 
	//if(SJPBRole.getTrnsrRoleYn() || SJPBRole.getTimhderRoleYn() || SJPBRole.getRoleGnlaffYn()){
	//	$("#exceldownIncPrnBtn").show();
	//}else{
	//	$("#exceldownIncPrnBtn").hide();
	//}
	
	//달력이벤트
	$(".datepicker").datepicker({
		  dateFormat: "yy-mm-dd" ,
		  changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
		  changeYear: true,
		  showButtonPanel: true,
		  currentText: '오늘 날짜'
	});
	
	//오픈전에 송치관이 아니면 사건등록, 사건병합, 사건분리 미노출, S 2018.12.05 (property 값 사용함)
//	if(IS_ALL_UPDATE_YN == "Y" && !SJPBRole.getTrnsrRoleYn()){
//		$("#insertIncMastViewBtn").hide();
//		$("#unCombIncMastBtn").hide();
//		$("#combIncMastBtn").hide();
//	}
	//송치관일경우, 오픈전에 모든 사건 수정 가능한 버튼 생성 E 2018.12.05
}

function checkDownloadCheck(){
    if (document.cookie.indexOf("fileDownload=false") == -1) {
            var date = new Date(1000);
            document.cookie = "fileDownload=; expires=" + date.toUTCString() + "; path=/";
            //프로그래스바 OFF 
            holdonClose();
            return;
        }
       setTimeout(checkDownloadCheck , 100);
}

//이벤트 세팅
function eventInitSetup() {
	//리스트 토글
	$("#toggleCriBtn").on("click", function() {	
		if($('#sheet:visible').length) {
	        $(this).find("span").html("리스트 펼치기");	        
	        $(this).removeClass("btn_blue").addClass("btn_white");
	        $('#sheet').hide();
		} else {
			$(this).find("span").html("리스트 접기");			
			$(this).removeClass("btn_white").addClass("btn_blue");
			$('#sheet').show();
		}
		//화면사이즈 갱신
		autoResize();
	});	
	
	//범죄사건부출력 2018.12.04 추가
	$("#exceldownIncPrnBtn").click(function(){
		
		//호출전, fildDownload 쿠키값 false
		setCookie("fileDownload","false"); 
		
		//로딩바 show 
		holdonShow();
		
	    var properties = {
	        filename: "범죄사건부"
	      , url: '/excelDownload.face'  	
	      , fileExt : 'xls'
	      , border: true 
	      , headershow: true 
	      , colwidth: true
	      , label: true
	      , huge : true
	      , param: {
	    	  	pageId 		: "B0101"
	    	  	,yearSc 	: $("#yearSc").val()
	    	  	,fdCdSc 	: $("#fdCdSc").val()
		  		,criTmSc 	: $("#criTmSc").val()
		  		,rcptIncNumSc: $("#rcptIncNumSc").val()
		  		,criStatSc 	: $("#criStatSc").val()
		  		,dvFormSc 	: $("#dvFormSc").val()
		  		,sDateSc 	: $("#sDateSc").val()
		  		,eDateSc 	: $("#eDateSc").val()
		  		,rltActCriNmSc : $("#rltActCriNmSc").val()
		  		,vioContSc 	: $("#vioContSc").val()
		  		,trfNumSc 	: $("#trfNumSc").val()
		  		,spNmSc 	: $("#spNmSc").val()
		  		,criMbNmSc 	: $("#criMbNmSc").val()
		  		,infwDivSc 	: $("#infwDivSc").val()
	      }
	    };
	    
	    qcell.excelDownload(properties);
	    
	    //호출후, fildDownload 쿠키값 체크후 로딩바 제거 
	    checkDownloadCheck();
	    
	  });
	
	//서식관리 탭 클릭 2018.12.03 수사기록주석
//	$("#criIncDtaTab").on("click", function() {
//		renderDTTable(b0101VOMap.criIncDtaFileVOList, "1");
//	});	
//	
	//서식관리탭의 저장 2018.12.03 수사기록주석
//	$("#fileBtn").off("click").on("click", function() {		
//		if ($('#deptTree').jstree(true).get_selected()[0] == undefined) {
//			alert("서식종류를 먼저 선택해 주세요.")
//			return false;
//		}		
//		updateCriIncDta();
//	});
//	
//	//서식관리탭의 검색버튼 2018.12.03 수사기록주석
//	$("#srchDTBtn").off("click").on("click", function() {	
//		selectCriIncDtaList();
//	});
	
//	//서식관리탭의 초기화버튼 2018.12.03 수사기록주석
//	$("#initDTBtn").off("click").on("click", function() {	
//		var searchArea = $("#criIncDtaCatgDiv");		
//		//input 값 초기화
//		searchArea.find("input[type=text]").val("");
//		
//		//select 값 초기화
//		searchArea.find("select").each(function() {
//			$(this).find("option:eq(0)").prop("selected", true);
//			$(this).prev('.txt').text($(this).find('option:selected').text());
//		});
//		
//		//검색맵 초기화
//		b0101SCMap = {				
//			rcptNum : "" //사건번호
//			,criDtaCatgSC : "" //수사자료분류
//			,criDtaFileNmSC : "" //수사자료파일명
//			,criDtaUsrNmSC : "" //수사자료작성자
//		}	
//	});	
	
	$(".searchArea input[type=text],.searchArea select").keypress(function(e){
		if(e.keyCode == 13){
			e.stopPropagation();
			selectList();
		}
	});
	
	//서식종류 검색 2018.12.03 수사기록주석
//	$(".p_search input[type=text],.p_search select").keypress(function(e){
//		if(e.keyCode == 13){
//			e.stopPropagation();
//			selectCriIncDtaList();
//		}
//	});
	
	//탭 클릭시, 아래 영역 크기 잡기
	$(".tabtitle").on("click", function(){
		//화면사이즈 갱신
		autoResize();
	});
	/*
	$("#fdCdSc").on("change", function(){
		//위반법률 검색영역 재구성 
		changeFdCdSc(0,true);
	});
	*/
}

//이벤트 세팅
function eventSetup() {
	/*
	$("#dvForm").off("change").on("change", function(){
		
		var reqMap = {
				dvForm : $(this).val()
			}
			
			goAjaxDefault("/sjpb/B/changeDvForm.face", reqMap, callBackChangeDvFormSuccess);
		
	});
	*/
}

//이벤트 사건 
function eventIncSetup(){
	/*
	//발각형태 변경
	$("select[name=dvForm]").on("change", function() {
		
		$(this).prev('.txt').text($(this).find('option:selected').text());
		
		//인지인경우
		if($(this).val() == "01"){
			//고발기관 미노출 
			$("td[data-name=fdCdTD]").attr("colspan","3");
			$("th[data-name=chaIttTH]").hide();
			$("td[data-name=chaIttTD]").hide();
			
		//고소고발인경우 
		}else{
			//고발기관 노출 
			$("td[data-name=fdCdTD]").removeAttr("colspan");
			$("th[data-name=chaIttTH]").show();
			$("td[data-name=chaIttTD]").show();
			
		}
		
	});
	
	$("select[name=dvForm]").trigger("change");
	*/
}

//이벤트 피의자 영역 세팅
function eventSpSetup(i) {
	
	//i : 몇번째 영역만 바인딩 할지 결정
	if(isNull(i)){
		var personinfo = $("div[data-name=personinfo]");
	}else{
		var personinfo = $("div[data-name=personinfo]").eq(i-1);
	}
	
	personinfo.each (function (index) {
		
		var tableIndex = $(this).data("table-index");

		//개인 법인 변경
	    $("input[data-name=indvCorpDiv]").off("click, change").on("click, change", function() {
	    	
	    	var targetTbody = $(this).closest("tbody");
	    	if (targetTbody.find("input[data-name=indvCorpDiv]:checked").val() == "1") {   //개인
	    		
	    		if (targetTbody.find("input[data-name=homcForcPernDiv]:checked").val() == "1") {  //내국인
	    			targetTbody.find("span[name=spIdNumTitle]").html("주민등록번호");
		    	} else {  //외국인
		    		targetTbody.find("span[name=spIdNumTitle]").html("외국인등록번호");
		    	}
	    		
	    		targetTbody.find("input[name=spIdNumA]").attr("data-type","rnnFront");
	    		targetTbody.find("input[name=spIdNumB]").attr("data-type","rnnBack");

	    		targetTbody.find("input[name=spCorpIdNumA]").attr("data-type","");
	    		targetTbody.find("input[name=spCorpIdNumB]").attr("data-type","");
	    		
	    		targetTbody.find("tr[name=indvTR1]").show();
	    		targetTbody.find("tr[name=corpTR1]").hide();
	    		targetTbody.find("tr[name=indvTR2]").show();
	    		targetTbody.find("tr[name=corpTR2]").hide();	
	    		
	    		targetTbody.find("input[name=spIndvNm]").data("optional-value",false);
	    		targetTbody.find("input[name=spCorpNm]").data("optional-value",true);	 
	    		
	    	} else {  //법인
	    		
	    		targetTbody.find("tr[name=indvTR1]").hide();
	    		targetTbody.find("tr[name=corpTR1]").show();
	    		targetTbody.find("tr[name=indvTR2]").hide();
	    		targetTbody.find("tr[name=corpTR2]").show();	    		
	    		
	    		targetTbody.find("input[name=spIdNumA]").attr("data-type","");
	    		targetTbody.find("input[name=spIdNumB]").attr("data-type","");

	    		targetTbody.find("input[name=spCorpIdNumA]").attr("data-type","bizIdFront");
	    		targetTbody.find("input[name=spCorpIdNumB]").attr("data-type","bizIdBack");
	    		
	    		targetTbody.find("input[name=spIndvNm]").data("optional-value",true);
	    		targetTbody.find("input[name=spCorpNm]").data("optional-value",false);	 
	    		    
	    	}
		});
	    
	    //내외국인 변경
	    $("input[data-name=homcForcPernDiv]").off("click, change").on("click, change", function() {	
	    	
	    	var targetTbody = $(this).closest("tbody");
	    	
	    	if (targetTbody.find("input[data-name=homcForcPernDiv]:checked").val() == "1") {  //내국인
	    		targetTbody.find("span[name=spIdNumTitle]").html("주민등록번호");
	    		targetTbody.find("input[name=spIdNumA]").attr("title","주민등록번호");
	    		targetTbody.find("input[name=spIdNumB]").attr("title","주민등록번호");
	    	} else {  //외국인
	    		targetTbody.find("span[name=spIdNumTitle]").html("외국인등록번호");
	    		targetTbody.find("input[name=spIdNumA]").attr("title","외국인등록번호");
	    		targetTbody.find("input[name=spIdNumB]").attr("title","외국인등록번호");
	    	}
	    	
		});
	    
	    $("input[data-name=indvCorpDiv]").trigger("change");
	    $("input[data-name=homcForcPernDiv]").trigger("change");
	});

	
	//주민번호 뒷자리 변경
	$("input[name=spIdNumB]").off("change").on("change", function() {
		//var targetPersonInfo = $(this).closest(".personinfo");
		var targetPersonInfo = $(this).closest("div[data-name=personinfo]");
		var idNum = $(this).val();
		if (idNum != "" && !isNaN(idNum)) {
			if (parseInt(idNum.charAt(0))%2 == 1) {
				targetPersonInfo.find("input[name=gendDiv]").val("M");	
				targetPersonInfo.find("span[name=gendDivSpan]").html("(남)");
			} else {
				targetPersonInfo.find("input[name=gendDiv]").val("W");
				targetPersonInfo.find("span[name=gendDivSpan]").html("(여)");
			}
		}else{
			targetPersonInfo.find("input[name=gendDiv]").val("");
			targetPersonInfo.find("span[name=gendDivSpan]").html("");
		}
	});  
	
	//피의자 정보 수정 레이어 팝업 노출 2018.12.15
	$("a[name=updateSpVioBtn]").off("click").on("click", function(){
		
		//commonLayerPopup.openLayerPopup('/sjpb/B/B0301.face', "800px", "650px", function(data){ callBackB0201Success(data, "/sjpb/B/updateIncMast.face", callBackUpdateIncidentSuccess)});
		commonLayerPopup.openLayerPopup('/sjpb/B/B0301.face', "800px", "800px", callBackB0301Success );
		
		//상단으로 올림
		parent.fn_scrollTop();
		
	});
	
	$("input[name=spIdNumB]").trigger("change");
}

//피의자 정보 수정 레이어 팝업 성공 콜백함수 
function callBackB0301Success(data){
	//새로고침 
	selectList(b0101VOMap.rcptNum);
	//selectIncident(b0101VOMap.rcptNum);
}

//changeDvForm 성공콜백함수
function callBackChangeDvFormSuccess(data){
	
	var fdCodeHtml = new StringBuffer();
	fdCodeHtml.append('				   		<option value="" selected="selected">선택</option>							');
	$.each(data.fdKndList, function(i, fd) {
		fdCodeHtml.append('						<option value="'+fd.code+'" data-criTmId="'+fd.criTmId+'" data-criTmNm="'+fd.criTmNm+'">'+fd.codeName+'</option>                                                                                                          ');
	});
	$("#fdCd").html(fdCodeHtml.toString());
	
	//인지일경우
	if(data.dvForm == "01"){
		
		//2) 구분
		var orgCd = $("#orgCd").val();																	//공통
		
		//구분값이 있을때에만 option 선택
		if(!isNull(orgCd)){
			$("#fdCd option[data-critmid="+orgCd+"]:eq(0)").prop("selected",true);							//공통
		}
		
		$("#fdCd").prev(".txt").text($("#fdCd").find('option:selected').text());						//공통
		$("#fdCd").attr("onchange","changeFdCdSc(1,false)");												//공통
		
		//3) 수사팀배정
		setFieldValue($("#fdCd"), "");
		changeFdCdSc(1,true);																				//공통
		
		var userId = $("#userId").val();																//공통
		var userName = $("#userName").val();															//공통		
		
		$("#criMbNmKorMain").val(userName);																//공통
		$("#criMbNmKorMain").attr("data-criMbId", userId);												//공통	
		$("#criMbNmKorMain").attr("disabled","true");													//공통		
										
	//고소/고발일경우
	}else{
		//$("#fdCd").attr("onchange","changeFdCdSc(1,true)");
		
		//setFieldValue($("#fdCd"), "");
		//changeFdCdSc(1,true);
		
		
		$("#criMbNmKorMain").val("");																
		$("#criMbNmKorMain").attr("data-criMbId", "");												
		$("#criMbNmKorMain").attr("disabled","true");	
		
	}
}

//타스크 버튼 이벤트 
function eventTaskBtn(){
	//타스크이행
	$("a[name=trstBtn]").off("click").on("click", function() {

		//console.log($(this).data("trst-stat-num"));
		//console.log($(this).data("cri-stat-cd"));
		
		b0101TKMap.wfNum = $(this).data("wf-num");
		b0101TKMap.rcptNum = b0101VOMap.rcptNum;
		b0101TKMap.taskNum = b0101VOMap.taskNum;	
		b0101TKMap.trstStatNm = $(this).data("trst-stat-nm");
		b0101TKMap.trstStatNum = $(this).data("trst-stat-num");
		b0101TKMap.taskRespMb = $("#userId").val();
		b0101TKMap.taskComn = $("#taskComn").val();
		b0101TKMap.criStatCd = $(this).data("cri-stat-cd");
		b0101TKMap.regUserId = $("#userId").val(); 
		b0101TKMap.updUserId = $("#userId").val();
		
		syncB0101VOMap();
		
		
		if ($(this).parent('div.r_btn').attr("id") == "apprArea_EditButtons") { //승인자
			executeTask();
		} else {	//수사관 
			var updateType = $(this).data("update-type");
			updateIncident(updateType);
		}	
	
	});	
}

//리스트 셀 클릭 이벤트
function eventFn(e){
	
	//qcell 커스텀 스타일이 있는경우, 제거 
//	if(isInitStyleQcell){
//		qcell.clearCellStyles();
//		isInitStyleQcell = false;
//	}
	
	//체크박스선택은 제외 
	if(qcell.getIdx("col") != 0){
		//선택한 인덱스 가져오기
		rowIdx = qcell.getIdx("row");
		
		//qcell 커스텀 스타일이 있는경우, 제거 
		qcell.clearCellStyles();
		
		//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
		//qcell.removeRowStyle(qcell.getIdx("row","focus","previous") == -1?1:qcell.getIdx("row","focus","previous"));
		qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
		
		
		//사건상세 호출
		if (rowIdx > 0) {
			selectIncidentLog(qcell.getRowData(rowIdx).rcptNum);
		}
	}
}


//초기화
function initData(type){
	//0: 신규입력 
	//1: 수정 
	
	//Map 초기화
	initB0101VOMap();
	initAccessMap();
	initB0101TKMap();
	
	$("#tab_mini_m1_contents").html("");	//영역초기화
	
	//수사정보탭 버튼영역 초기화
	//$("#btnArea_EditButtons_tab2").html("");	 
	
	//통계원표 영역 초기화 
	initStsGrap("1");
	
	$("#tab_small_m1_contents").hide();		//통계원표 숨기기 
	
	//서브 탭 초기화 
	handleTab();
	
	//신규입력 or 수정 화면 컨트롤
	if (type == 0){
		currRowNum = null;
		isSpUpdate = true;
	}else{
		isSpUpdate = false;
	}
	
}

//검색조건 초기화
function initSearchData(){
	var searchArea = $("div[class=searchArea]");
	
	//input 값 초기화
	searchArea.find("input[type=text]").val("");
	
	//select 값 초기화
	searchArea.find("select").each(function() {
		$(this).find("option:eq(0)").prop("selected", true);
		$(this).prev('.txt').text($(this).find('option:selected').text());
	});
}



//사건관리 화면(리스트)조회 (ajax)
function selectList(rcptNum, isInit){
	//rcptNum : 조회 할 접수번호 
	//isInit : 페이지 처음 들어왔을때, 호출여부 
	
	
	//최소화 되어 있으면 검색중단
	if(!$('#sheet:visible').length) return;
	
	//검색 유효성 체크
	var chkObjs = $("#searchArea");
	if(!chkValidate.check(chkObjs, true)) return;
	
	var b0101VO = new Object();
	
	//페이지 처음 호출일경우 rcptNum 값이 있으면, rcptNum 을 검색조건에 추가함 
	if(isInit && !isNull(rcptNum)){
		b0101VO.rcptNumSc = rcptNum;
		
	}else{
		b0101VO.yearSc = $("#yearSc").val();
		b0101VO.fdCdSc = $("#fdCdSc").val();
		b0101VO.criTmSc = $("#criTmSc").val();
		b0101VO.rcptIncNumSc = $("#rcptIncNumSc").val();
		b0101VO.criStatSc = $("#criStatSc").val();
		b0101VO.dvFormSc = $("#dvFormSc").val();
		b0101VO.sDateSc = $("#sDateSc").val();
		b0101VO.eDateSc = $("#eDateSc").val();
		b0101VO.rltActCriNmSc = $("#rltActCriNmSc").val();
		b0101VO.vioContSc = $("#vioContSc").val();
		b0101VO.trfNumSc = $("#trfNumSc").val();
		b0101VO.spNmSc = $("#spNmSc").val();
		b0101VO.criMbNmSc = $("#criMbNmSc").val();
		b0101VO.infwDivSc = $("#infwDivSc").val();
	}
	
	goAjaxDefault("/sjpb/B/selctList.face", b0101VO, function(data){ callBackSelectListSuccess(data, rcptNum, isInit) });
	
}

//사건관리 화면(리스트)조회 콜백함수
function callBackSelectListSuccess(data, rcptNum, isInit){
	
	var QCELLProp = {
            "parentid" : "sheet",
            "id"		: "qcell",
            "data"		: {"input" : data.qCell},
            "selectmode": "row",
            "columns"	: [
            	{width: '10%',	key: 'poIncNum',			title: ['검찰사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '10%',	key: 'rcptOrdNum',			title: ['접수번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '10%',	key: 'incNum',				title: ['사건번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '10%',	key: 'beDt',				title: ['수리일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '7%',	key: 'dvFormDesc',			title: ['발각형태'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '7%',	key: 'nmKor',				title: ['담당수사관'],			sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'rltActCriNmCdDesc',	title: ['위반법률 및 죄명'],			sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '10%',	key: 'vioCont',				title: ['위반 내용'],			sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '8%',	key: 'spNm',				title: ['피의자'],			sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '13%',	key: 'criStatDesc',			title: ['상태'],			sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}
            	],
			//"rowheader"	: "sequence",
			"frozencols" : 5
        };
        QCELL.create(QCELLProp);
        qcell = QCELL.getInstance("qcell");
        qcell.bind("click", eventFn);
        
        if (qcell.getRows("data") > 0) {
        	
        	//최초 로딩시
        	if(isNull(rcptNum)){	//rcptNum이 없으면 첫번째줄 선택
        		rowIdx = 1;
        		if(isInit){
        			selectIncidentLog(qcell.getRowData(1).rcptNum);
        		}else selectIncident(qcell.getRowData(1).rcptNum);   		
        		
        	//수정 후, 로딩시
        	}else{
        		
        		//페이지 처음 호출일경우 rcptNum 값이 있으면 
        		if(isInit){
        			rowIdx = 1;
        			selectIncidentLog(rcptNum);
        		}else selectIncident(rcptNum);
        		
        		
        	}
        	
    		 //셀 선택 백그라운드 지정
        	if(qcell.getIdx("col") != 0){
        		qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");   
        		//isInitStyleQcell = true;
        	}
        	
        //데이터가 없을경우
        } else {
        	rowIdx = 0;
        	insertIncMastView();  //No Data 신규등록화면 노출
        }
        
}

//사건상세(이력플래그추가)를 가져온다.
function selectIncidentLog(rcptNum){
	var reqMap = {
		rcptNum : rcptNum,
		loadLog : "Y"
	}
	
	goAjaxDefault("/sjpb/B/selctIncident.face", reqMap, callBackSelectIncidentSuccess);
	
}


//사건상세를 가져온다.
function selectIncident(rcptNum){
	
	var reqMap = {
		rcptNum : rcptNum
	}
	
	goAjaxDefault("/sjpb/B/selctIncident.face", reqMap, callBackSelectIncidentSuccess);
	
}

//사건상세 콜백함수
function callBackSelectIncidentSuccess(data){
	
	//초기화
	initData("1");
	
	b0101VOMap = data.b0101VO;
	
	if(b0101VOMap == null){
		alert("사건 데이터에 문제가 있습니다. 관리자에게 문의하세요.");
		return;
	}

	var isReLoadActVio = false;	//위반법률이 없어서, 새로 입력화면을 넣어줄때 관련된 위반법률만 보여주도록 리로드 여부 
	
	//병합된 자식 사건일경우 버튼 막음 S 2018.11.29
	isRootInc = true;
	if(b0101VOMap.combIncYn == 'Y' && b0101VOMap.pareIncNum != b0101VOMap.incNum ){
		//병합된 자식사건이므로 저장을 제외한 진행 버튼 막음 
		isRootInc = false;
	}
	//병합된 자식 사건일경우 버튼 막음 E 2018.11.29
	
	var orgCd = $("#orgCd").val();		//수사팀코드
	//var kindCd = $("#kindCd").val();	//수사단원구분
	 
	 //사건정보 셋팅 
	 $("#incNum").html(b0101VOMap.rcptIncNum);							//사건번호
	 //$("#dvForm").val(b0101VOMap.dvForm).prop("selected", true);		//발각형태 -->검찰이첩
	 //$("#chaItt").val(b0101VOMap.chaItt).prop("selected", true);		//이첩기관 --> 남부지검
	 //$("#infwDiv").val(b0101VOMap.infwDiv).prop("selected", true);		//유입구분-->이첩
	 
	 
	//접근한 계정의 사건 권한 조회 
	var criLvCd;
	$.each(b0101VOMap.incCriMbVOList, function(i, incCriMb) {
		if($("#userId").val() == incCriMb.criMbId){
			accessMap.criLvCd = incCriMb.criLvCd;
		}
	});
	 
	
	//1. '사건정보' 탭 데이터 셋팅
	
	 //사건정보 셋팅 (테이블 그리기)
	 var spHtml = new StringBuffer();
	 
	spHtml.append('<table class="list" cellpadding="0" cellspacing="0">																																																	');											
	spHtml.append('   <colgroup>                                                                                                                                                                                                                                        ');
	spHtml.append('	   <col width="15%" />                                                                                                                                                                                                                              ');
	spHtml.append('	   <col width="35%" />                                                                                                                                                                                                                              ');
	spHtml.append('	   <col width="15%" />                                                                                                                                                                                                                              ');
	spHtml.append('	   <col width="35%" />                                                                                                                                                                                                                              ');
	spHtml.append('   </colgroup>                                                                                                                                                                                                                                       ');
	spHtml.append('   <tbody>                                                                                                                                                                                                                                           ');
	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C">사건번호</th>                                                                                                                                                                                                                      ');
	//spHtml.append('		   <td class="L">'+( isNull(b0101VOMap.rcptIncNum) ? "신규등록" : b0101VOMap.rcptIncNum )+'</td>                                                                                                                                                                                                      ');
	
	var incNumMsg = isNull(b0101VOMap.pareRcptNum) ? "" : " (병합된 사건입니다. "+b0101VOMap.pareIncNum+" 사건에서 진행 가능합니다.)";
	
	spHtml.append('		   <td class="L">'+( isNull(b0101VOMap.incNum) ? "신규등록" : b0101VOMap.incNum + incNumMsg )+'</td>                                                                                                                                                                                                      ');
	
	//금감원추가 컬럼!
	spHtml.append('		   <th class="C">접수번호</th>                                                                                                                                                                                                                      ');
	spHtml.append('		   <td class="L">'+( isNull(b0101VOMap.rcptOrdNum) ? "신규등록" : b0101VOMap.rcptOrdNum )+'</td>                                                                                                                                                                                                      ');
	spHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C">검찰사건번호 <em class=\"red\">*</em></th>                                                                                                                                                                                                                      ');
	spHtml.append('		   <td class="L"><input type="text" class="w100per" id="poIncNum" name="poIncNum" data-type="required" value="'+(isNull(b0101VOMap.poIncNum) ? "" : b0101VOMap.poIncNum )+'" data-always="y" title="검찰사건번호" maxlength="20"/> </td>                                                                                                                                                                                                      ');
	spHtml.append('		   <th class="C">발각형태 <em class=\"red\">*</em></th>                                                                                                                                                                                                                      ');
	spHtml.append('		   <td class="L">                                  ');
	spHtml.append('	   			<div class="inputbox w80per">                                                       ');	
	spHtml.append('	   				<p class="txt"></p>                                                   ');	
	spHtml.append('				   	<select name="dvForm" id="dvForm" data-type="select" data-optional-value="false" title="발각형태" >                                                                                                                                                                                                                             ');
	spHtml.append('						<option value="">선택</option>');
	
	$.each(data.dvFormKndList, function(k, dvForm) {
		spHtml.append('					<option value="'+dvForm.code+'" '+(b0101VOMap.dvForm == dvForm.code ? "selected=\"selected\"":"")+' >'+dvForm.codeName+'</option>');
	});
	spHtml.append('	   				</select>                                                                       ');	
	spHtml.append('	   			</div>                                                                              ');	
	spHtml.append('	   		</td>                                                                              ');		
	
	spHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C">종목</th>                                                                                                                                                                                                                      ');
	spHtml.append('		   <td class="L"><input type="text" class="w100per" id="stock" name="stock" data-stock="" value="'+(isNull(b0101VOMap.stock) ? "" : b0101VOMap.stock )+'" title="종목"/> </td>                                                                                                                                                                                                      ');
	spHtml.append('		   <th class="C">착수일시</th>                                                                                                                                                                                                                      ');
	spHtml.append('		   <td class="L"><input type="text" class="w100per calendar datepicker" name="beDt" id="beDt" value="'+(isNull(b0101VOMap.beDt) ? "" : b0101VOMap.beDt )+'" title="착수일시" readonly />');
	spHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C">처리일시</th>                                                                                                                                                                                                                      ');
	spHtml.append('		   <td class="L"><input type="text" class="w100per calendar datepicker" name="proDt" id="proDt" value="'+(isNull(b0101VOMap.proDt) ? "" : b0101VOMap.proDt )+'" title="처리일시" readonly />');
	spHtml.append('		   <th class="C">수리일시</th>                                                                                                                                                                                                                      ');
	spHtml.append('		   <td class="L"><input type="text" class="w100per calendar datepicker" name="acptDt" id="acptDt" value="'+(isNull(b0101VOMap.acptDt) ? "" : b0101VOMap.acptDt )+'" title="수리일시" readonly />');
	
	spHtml.append('	   </tr>                                                                                                                                                                                                                                             ');	
	//spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	//spHtml.append('		   <th class="C">수사팀 배정</th>                                                                                                                                                                                                                    ');
	//spHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	//spHtml.append('			<p class="searchinput">                                                                                                                                                                                                                     ');
	//spHtml.append('			<label for="criTmNm"></label><input type="text" class="w100per" id="criTmNm" name="criTmNm" data-criTmId="'+b0101VOMap.criTmId+'" value="'+b0101VOMap.criTmNm+'" disabled="true" data-always="y"/>                              ');
	//spHtml.append('			</p>                                                                                                                                                                                                                                        ');
	//spHtml.append('		</td>                                                                                                                                                                                                                                           ');
	//spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
	
	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');	
	spHtml.append('		   <th class="C">담당 수사관</th>                                                                                                                                                                                                                    ');
	spHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	spHtml.append('			<p class="searchinput">                                                                                                                                                                                                                     ');
	
	var isIncCriMbMain = false;
	$.each(b0101VOMap.incCriMbVOList, function(i, incCriMb) {
		
		if(incCriMb.criLvCd == "01"){	//담당수사관
			spHtml.append('			<label for="criMbNmKorMain"></label><input type="text" class="w100per" id="criMbNmKorMain" name="criMbNmKorMain" value="'+incCriMb.nmKor+'" data-name="criMb" data-criMbId="'+incCriMb.criMbId+'" disabled="true" data-always="y"/><a class="btn_search" id="criMbNmKorMainBtn" name="criMbNmKorMainBtn" href="javascript:setCriMbNmKorMain();" style="display:none;" data-always="y"><img src="/sjpb/images/btn_search.png" alt="search" /></a>             ');
			isIncCriMbMain = true;
			return false;	//break , 담당수사관은 한명만 있으므로
		}
	});
	
	//담당수사관이 없으면 
	if(!isIncCriMbMain){
		spHtml.append('			<label for="criMbNmKorMain"></label><input type="text" class="w100per" id="criMbNmKorMain" name="criMbNmKorMain" value="" data-name="criMb" data-criMbId="" disabled="true" data-always="y"/><a class="btn_search" id="criMbNmKorMainBtn" name="criMbNmKorMainBtn" href="javascript:setCriMbNmKorMain();" style="display:none;" data-always="y"><img src="/sjpb/images/btn_search.png" alt="search" /></a>             ');
	}
	
	spHtml.append('			</p>                                                                                                                                                                                                                                        ');
	spHtml.append('		</td>                                                                                                                                                                                                                                           ');
	                                                                                                                                                                                                                                        
	//금감원추가
	//지휘자 추가
	spHtml.append('		   <th class="C">지휘자</th>                                                                                                                                                                                                                    ');
	spHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	spHtml.append('			<p class="searchinput">                                                                                                                                                                                                                     ');
	spHtml.append('			<label for="dirId"></label><input type="text" class="w100per" id="dirId" name="dirId" value="'+(isNull(b0101VOMap.dirNm) ? "" : b0101VOMap.dirNm )+'" data-dirid="'+b0101VOMap.dirId+'" title="지휘자" /><a class="btn_search" id="dirIdBtn" name="dirIdBtn" href="javascript:setDirId();" ><img src="/sjpb/images/btn_search.png" alt="search" /></a>             ');
	spHtml.append('			</p>                                                                                                                                                                                                                                        ');
	spHtml.append('		</td>                                                                                                                                                                                                                                           ');
	spHtml.append('	   </tr>    ');
	spHtml.append('</table>');
	
	
	                        
	countSp = 0;	//라디오박스 아이디 구분을 위해 커스텀
	spHtml.append(renderSpHtml(data, b0101VOMap.incSpVOList, ""));	//피의자 데이터
	
	spHtml.append('<table class="list" cellpadding="0" cellspacing="0">																					');
	spHtml.append('	<input type="hidden" id="incOccrAreaXcd" name="incOccrAreaXcd" value="'+b0101VOMap.incOccrAreaXcd+'" />	');
	spHtml.append('	<input type="hidden" id="incOccrAreaYcd" name="incOccrAreaYcd" value="'+b0101VOMap.incOccrAreaYcd+'" />	');
	spHtml.append('	<caption>게시판쓰기</caption>                                                                                                            ');
	spHtml.append('	<colgroup>                                                                                                                          ');
	spHtml.append('		<col width="15%" />                                                                                                             ');
	spHtml.append('		<col width="*%" />                                                                                                              ');
	spHtml.append('	</colgroup>                                                                                                                         ');
	spHtml.append('	<tbody>                                                                                                                             ');
	spHtml.append('		<tr>                                                                                                                          ');
	spHtml.append('			<th class="C first th_line" scope="col" ><span class="table_title">범죄장소</span></th>                                         ');
	spHtml.append('			<td class="L td_line">                                                                                                      ');
	spHtml.append('				<label for="incOccrAreaAddr"></label><input type="text" class="w50per" name="incOccrAreaAddr" id="incOccrAreaAddr" value="'+(isNull(b0101VOMap.incOccrAreaAddr) ? "" : b0101VOMap.incOccrAreaAddr )+'"/>                                                                    ');
	spHtml.append('			</td>                                                                                                                       ');
	spHtml.append('		</tr>                                                                                                                            ');
	spHtml.append('		<tr>                                                                                                                          ');
	spHtml.append('			<th class="C first th_line" scope="col" ><span class="table_title">범죄일시</span></th>                                         ');
	spHtml.append('			<td class="L td_line">                                                                                                      ');
	spHtml.append('				<label for="criDt"></label><input type="text" class="w100per" name="criDt" id="criDt" value="'+(isNull(b0101VOMap.criDt) ? "" : b0101VOMap.criDt )+'"/>                                                                    ');
	spHtml.append('			</td>                                                                                                                       ');
	spHtml.append('		</tr>                                                                                                                            ');
	
	
	spHtml.append('		<tr>                                                                                                                          ');
	spHtml.append('			<th class="C">피해자 성명</th>                                         ');
	spHtml.append('			<td class="L">                                                                                                      ');
	spHtml.append('			   <label for="vicmNm"></label><input type="text" class="w100per" id="vicmNm" name="vicmNm" value="'+b0101VOMap.vicmNm+'"/>                                                                                                                                                    ');
	spHtml.append('			</td>                                                                                                                       ');
	spHtml.append('		</tr>                                                                                                                            ');
	
	spHtml.append('		<tr>                                                                                                                          ');
	spHtml.append('			<th class="C">피해자 피해정도</th>                                         ');
	spHtml.append('			<td class="L">                                                                                                      ');
	spHtml.append('			   <label for="damgDegr"></label><input type="text" class="w100per" id="damgDegr" name="damgDegr" value="'+b0101VOMap.damgDegr+'"/>                                                                                                                                                    ');
	spHtml.append('			</td>                                                                                                                       ');
	spHtml.append('		</tr>                                                                                                                            ');
	
	spHtml.append('		<tr>                                                                                                                          ');
	spHtml.append('			<th class="C">압수번호</th>                                         ');
	spHtml.append('			<td class="L">                                                                                                      ');
	spHtml.append('			   <label for="seizNum"></label><input type="text" class="w100per" id="seizNum" name="seizNum" value="'+b0101VOMap.seizNum+'"/>                                                                                                                                                    ');
	spHtml.append('			</td>                                                                                                                       ');
	spHtml.append('		</tr>                                                                                                                            ');
	
	spHtml.append('		<tr>                                                                                                                          ');
	spHtml.append('			<th class="C">수사미결사건철번호</th>                                         ');
	spHtml.append('			<td class="L">                                                                                                      ');
	spHtml.append('			   <label for="criPendIncFileNum"></label><input type="text" class="w100per" id="criPendIncFileNum" name="criPendIncFileNum" value="'+b0101VOMap.criPendIncFileNum+'"/>                                                                                                                                                    ');
	spHtml.append('			</td>                                                                                                                       ');
	spHtml.append('		</tr>                                                                                                                            ');

	
	
	spHtml.append('		<tr>                                                                                                                            ');
	spHtml.append('			<th class="C first th_line" scope="col" ><span class="table_title">사건내용<br>(인지보고서 또는 고발개요)</span></th>                                         ');
	spHtml.append('			<td class="L td_line">                                                                                                      ');
	spHtml.append('				<textarea id="incCont" name="incCont" cols="" rows="" >'+(isNull(b0101VOMap.incCont) ? "" : b0101VOMap.incCont)+'</textarea>                                                                    ');
	spHtml.append('			</td>                                                                                                                       ');
	spHtml.append('		</tr>                                                                                                                           ');
	
	spHtml.append('	</tbody>                                                                                                                            ');
	spHtml.append('</table>                                                                                                                             ');
	
	spHtml.append('<div class="btnArea" id="criArea02">                                                                                                                                                                                                                                ');
	spHtml.append('   <div class="r_btn" id="btnArea_EditButtons"></div>                                                                                                                     ');
	spHtml.append('</div>                                                                                                                                                                                                                                               ');

	spHtml.append('<div class="btnArea" id="apprArea02" style="display:none">');
	
	spHtml.append('<div style="height:100px">																								');
	spHtml.append('	<table class="list" name="apprAreaTable" cellpadding="0" cellspacing="0" data-cri-dta-num="" data-cri-dta-catg-cd="06"> ');
	spHtml.append('		   <colgroup>                                                                                                       ');
	spHtml.append('		   <col width="10%" />                                                                                              ');
	spHtml.append('		   <col width="15%" />                                                                                              ');
	spHtml.append('		   <col width="30%" />                                                                                              ');
	spHtml.append('		   <col width="15%" />                                                                                              ');
	spHtml.append('		   <col width="30%" />                                                                                              ');
	spHtml.append('		   </colgroup>                                                                                                      ');
	spHtml.append('		   <tbody>                                                                                                          ');
	spHtml.append('			   <tr>                                                                                                         ');
	spHtml.append('				   <th class="C line_right" rowspan="2">등록</th>                                                             ');
	spHtml.append('				   <th class="C">등록요청</th>                                                                                  ');
	spHtml.append('				   <td class="L" colspan="3" id="taskNmTD">		                                                            ');   
	spHtml.append('				   </td>                                                                                                    ');
	spHtml.append('			   </tr>		                                                       	                                        ');              
	spHtml.append('			   <tr>                                                                                                         ');
	spHtml.append('				   <th class="C">등록의견</th>                                                                                  ');
	spHtml.append('				   <td class="L" colspan="3">                                                                               ');
	spHtml.append('					   <label for="txt_05"></label><input type="text" class="w100per" id="taskComn" name="taskComn" />      ');
	spHtml.append('				   </td>                                                                                                    ');
	spHtml.append('			   </tr>	                                                                                                    ');
	spHtml.append('		   </tbody>                                                                                                         ');
	spHtml.append('	</table>                                                                                                                ');
	spHtml.append('</div>                                                                                                                   ');
	
	spHtml.append('		<div class="r_btn" id="apprArea_EditButtons"></div>');
	spHtml.append('</div>   ');
	
	$("#tab_mini_m1_contents").html(spHtml.toString());	
	
	//2. '수사정보' 탭 데이터 셋팅 (삭제됨 20181116)
	//$("#criCont").text( isNull(b0101VOMap.criCont) ? "" : b0101VOMap.criCont );
	
	//첫번째 '사건정보' 탭 활성화 (클릭)
	$('.tab_mini_wrap').find('>ul>li>a:eq(0)').click();
	
	//피의자 이벤트 바인딩
	eventSpSetup();
	
	//selct 퍼블 이벤트 바인딩
	setDefaultEvent();
	
	//사건 이벤트 바인딩
	eventIncSetup();
	
	//피의자 버튼 컨트롤
	spBtnControl();
	
	//유저와 상태에 따른 버튼 활성화 처리
	handleBtn();
	
	//유저와 상태에 따른 UI 처리 
	handleUi();
	
	//유저와 상태에 따른 탭 활성화 처리
	handleTab();
	
	//유저와 타스크상태에 따른 버튼 활성화 처리
	handleTab1BtnGroup();
	
	//화면사이즈 갱신
	autoResize();
	
	//타스크이행
	eventTaskBtn();
	
	//수사자료 리스팅	
	//renderDTTable(b0101VOMap.criIncDtaFileVOList, "1");
	
	//위반법률 리로드 (사건에 저장된 위반법률이 없을 경우에만 동작함)
	if(isReLoadActVio){
		//구분선택 트리거
		changeFdCdSc(1,false);
	}
	
	//달력이벤트
	$(".datepicker").datepicker({
		  dateFormat: "yy-mm-dd" ,
		  changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
		  changeYear: true,
		  showButtonPanel: true,
		  currentText: '오늘 날짜'
	});
	
//	//문서관리 초기화
//	$("#docMngframe").contents().find("#docIframe").attr("src","");
	
}

//컨텐츠 영역 readonly 처리 
function areaSetReadOnly(targetObj){
	//data-always 속성이 y 이면 항상 보인다는뜻. readonly처리하지않음
	targetObj.find("input:not([data-always=y]), select:not([data-always=y]), textarea:not([data-always=y])").each(function (){
		//입력 비활성화
		$(this).attr("disabled", "true");
		
	});
	
	//버튼 비활성화
	targetObj.find("a:not([data-always=y], [class*=jstree])").each(function (){
		//입력 비활성화
		$(this).hide();
	});
}

//컨텐츠 영역 readonly 처리 제거 
function areaSetWrite(targetObj){
	targetObj.find("input:not([data-always=y]), select:not([data-always=y]), textarea:not([data-always=y])").each(function (){
		//입력 활성화
		$(this).removeAttr("disabled");
		
	});
	
	//버튼 활성화
	targetObj.find("a:not([data-always=y], [class*=jstree])").each(function (){
		//입력 활성화
		$(this).show();
	});
}
/*
//타스크 탈 대상만 비활성화 처리
function areaSetTask(targetObj){
	targetObj.find("input[data-task=y]").each(function (){
		//입력 비활성화
		$(this).attr("disabled", "true");
		
	});
}
*/
//유저와 상태에 따른 탭 활성화 처리
function handleTab(){
	var scriStatCd = isNull(b0101VOMap.criStatCd) ? 30 : Number(b0101VOMap.criStatCd) ;
	
	//수사착수 전단계 : 사건정보 노출
	if(scriStatCd == 21){
		$(".tab_mini_wrap>ul>li:eq(0)").show();		//사건정보
		$(".tab_mini_wrap>ul>li:eq(1)").hide();		//수사정보
		//$(".tab_mini_wrap>ul>li:eq(2)").hide();		//서식관리
		$(".tab_mini_wrap>ul>li:eq(2)").hide();		//문서관리
		$(".tab_mini_wrap>ul>li:eq(3)").hide();		//통계원표
		$(".tab_mini_wrap>ul>li:eq(4)").hide();		//송치정보
		$(".tab_mini_wrap>ul>li:eq(5)").hide();		//수사기록철
	//수사 착수단계	
	}else if(scriStatCd == 20 || scriStatCd ==30 ){
		$(".tab_mini_wrap>ul>li:eq(0)").show();		//사건정보
		$(".tab_mini_wrap>ul>li:eq(1)").show();		//수사정보
		//$(".tab_mini_wrap>ul>li:eq(2)").hide();		//서식관리
		$(".tab_mini_wrap>ul>li:eq(2)").hide();		//문서관리
		$(".tab_mini_wrap>ul>li:eq(3)").hide();		//통계원표
		$(".tab_mini_wrap>ul>li:eq(4)").hide();		//송치정보
		$(".tab_mini_wrap>ul>li:eq(5)").hide();		//수사기록철
	
	//수사단계 : 사건정보, 수사정보, 통계원표 노출
	}else if(scriStatCd == 22 || scriStatCd == 24 ||( 40 <= scriStatCd && scriStatCd < 60) ){
		$(".tab_mini_wrap>ul>li:eq(0)").show();		//사건정보
		$(".tab_mini_wrap>ul>li:eq(1)").show();		//수사정보
		//$(".tab_mini_wrap>ul>li:eq(2)").show();		//서식관리
		$(".tab_mini_wrap>ul>li:eq(2)").show();		//문서관리
		
		if(scriStatCd == 53 || scriStatCd ==58){	//지휘"가"[53], 재지휘"가"[58]
			$(".tab_mini_wrap>ul>li:eq(3)").show();		//통계원표
		}else{
			$(".tab_mini_wrap>ul>li:eq(3)").hide();		//통계원표
		}
		$(".tab_mini_wrap>ul>li:eq(4)").show();		//송치정보	
		$(".tab_mini_wrap>ul>li:eq(5)").show();		//수사기록철
	//송치단계 : 사건정보, 수사정보, 통계원표, 송치정보 노출
	}else if(70 <= scriStatCd && scriStatCd < 99){
		$(".tab_mini_wrap>ul>li:eq(0)").show();		//사건정보
		$(".tab_mini_wrap>ul>li:eq(1)").show();		//수사정보
		//$(".tab_mini_wrap>ul>li:eq(2)").show();		//서식관리
		$(".tab_mini_wrap>ul>li:eq(2)").show();		//문서관리
		$(".tab_mini_wrap>ul>li:eq(3)").show();		//통계원표		
		$(".tab_mini_wrap>ul>li:eq(4)").show();		//송치정보
		$(".tab_mini_wrap>ul>li:eq(5)").show();		//수사기록철
	}else if(scriStatCd==99){
		$(".tab_mini_wrap>ul>li:eq(0)").show();		//사건정보
		$(".tab_mini_wrap>ul>li:eq(1)").show();		//수사정보
		$(".tab_mini_wrap>ul>li:eq(2)").hide();		//문서관리
		$(".tab_mini_wrap>ul>li:eq(3)").hide();		//통계원표
		$(".tab_mini_wrap>ul>li:eq(5)").show();		//수사기록철
	}
	
}

//유저와 상태에 따른 UI 처리 
function handleUi(){
	
	var scriStatCd = isNull(b0101VOMap.criStatCd) ? 30 : Number(b0101VOMap.criStatCd) ;
	
	//송치관 && (수사관 || 팀장 || 과장 || 단장) 의 중복역할 고려 
	//수사관 || 팀장 || 과장 || 단장의 역할의경우 중복이 되더라도 공통 프로세스.
	
	//1) 발각형태
	//$("#dvForm").attr("disabled","true"); //수정불가
	
	//수사관 || 팀장 || 과장 || 단장 역할 공통(인지)
	if(SJPBRole.getInvigtorRoleYn()){
		
		//신규등록일경우 아래 설정 
		// 1) 발각형태 		- 인지 
		// 2) 구분			- 본인 팀의 구분 
		// 3) 수사팀배정	- 본인 팀 
		// 4) 담당수사관 	- 본인 
		if(isNull(b0101VOMap.rcptNum)){
			//1) 발각형태
			//$("#dvForm").attr("disabled","true");															
			/*
			//인지일경우에만 수사팀, 담당 수사관 셋팅
			if($("#dvForm").val() == "01"){
			
				//2) 구분
				var orgCd = $("#orgCd").val();	
				
				//구분값이 있을때에만 option 선택
				if(!isNull(orgCd)){
					$("#fdCd option[data-critmid="+orgCd+"]:eq(0)").prop("selected",true);	
				}
										
				$("#fdCd").prev(".txt").text($("#fdCd").find('option:selected').text());						
				//$("#fdCd").attr("disabled","true");	//수사팀하나에 구분이 여려개일수 있으므로, 열어둔다
				$("#fdCd").removeAttr("disabled");
				$("#fdCd").attr("onchange","changeFdCdSc(1,false)");												
				
				//3) 수사팀배정
				changeFdCdSc(1,true);																				
				
				var userId = $("#userId").val();																
				var userName = $("#userName").val();																	
				
				$("#criMbNmKorMain").val(userName);																//공통
				$("#criMbNmKorMain").attr("data-criMbId", userId);												//공통	
				//$("#criMbNmKorMain").attr("disabled","true");													//공통		
			}else{
				areaSetWrite($(".tab_mini_contents"));
			}
			*/
		//수정, 조회일경우
		}else{
			
			//1) 발각형태
			//$("#dvForm").attr("disabled","true");
			//2) 구분 (변경을 허용하면, 지정된 담당 수사관에 문제가 발생한다. 단, 등록작업중일 경우에는 수정 가능해야함.)
			//if( !(scriStatCd == 21 || scriStatCd == 31 ||scriStatCd == 40 ||scriStatCd == 50 ||scriStatCd == 51 ||scriStatCd == 52 ||scriStatCd == 53 ||scriStatCd == 54 ||scriStatCd == 55 ||scriStatCd == 56 ||scriStatCd == 57 ||scriStatCd == 58 ||scriStatCd == 59 ) ){
			//	$("#fdCd").attr("disabled","true");
			//}
			
			//4) 담당수사관 
			//$("#criMbNmKorMain").attr("disabled","true");
			/*
			//로그인한 계정이 해당사건의 참조, 권한이없을경우 : 조회만가능
			if(accessMap.criLvCd == "03" || accessMap.criLvCd == ""){
				
				//조회만가능
				areaSetReadOnly($(".tab_mini_contents"));
				
				//조회만가능
				//서식관리탭
//				areaSetReadOnly($("#tab_mini_m1_contents"));	//사건정보 탭
//				areaSetReadOnly($("#tab_mini_m2_contents"));	//수사정보 탭
//				areaSetReadOnly($("#tab_mini_m4_contents"));	//통계원표 탭
//				areaSetReadOnly($("#tab_mini_m5_contents"));	//송치정보 탭
				
				
			//권한이 있을경우, 수정가능 
			}else{
				*/
				
				//수사상태가 [ 사건임시저장(21), 사건이첩(20), 수사사건부등록(22), 수사중(40), 지휘부결(54), 재지휘부결(59), 송치부결(74), 재송치부결(79) ] 일 경우에만 수정가능 
				if( "21,20,22,40,54,59,74,79".indexOf(scriStatCd) != -1 ){
					isSpUpdate = true;	//피의자 정보 Map에 담기 여부  
					areaSetWrite($("#tab_mini_m1_contents"));
				}else{
					isSpUpdate = false;	//피의자 정보 Map에 담기 여부  
					areaSetReadOnly($("#tab_mini_m1_contents"));
				}
					/*
					//사건임시저장일때만, 피의자 ,법률 수정가능 2018.12.14 추가
					if(scriStatCd == 21){
						isSpUpdate = true;	//피의자 정보 Map에 담기 여부  
					// 수현 - 지휘접수전까지, 법률 수정가능 2018.12.14 추가
					}else if(scriStatCd >= 20 && scriStatCd < 52 ){
						isSpUpdate = true;	//피의자 정보 Map에 담기 여부  
						//areaSetTask($(".personinfo"));
						
						//피의자 수정 버튼 노출은 수사중(40), 수사사건부등록(22)일 경우에만 노출함 
						if(scriStatCd == 40 || scriStatCd == 22 ){
							
							if(b0101VOMap.pareRcptNum == "" || b0101VOMap.pareRcptNum == " " || b0101VOMap.pareRcptNum == null){
								$("a[name=updateSpVioBtn]").show();	//피의자 수정 버튼 
							}
						}
						
						//$("#fdCd").attr("onchange","changeFdCdSc(1,false)");
						
						//changeFdCdSc(1,false);
					}else{
						//피의자 수정불가능 
						areaSetReadOnly($(".personinfo"));
						isSpUpdate = false;	//피의자 정보 Map에 담기 여부
						
						//피의자 수정 버튼 노출은 수사중(40), 지휘요청(50)일 경우에만 노출함 
//						if(scriStatCd == 40 || scriStatCd == 50){
//							
//							if(b0101VOMap.pareRcptNum == "" || b0101VOMap.pareRcptNum == " " || b0101VOMap.pareRcptNum == null){
//								$("a[name=updateSpVioBtn]").show();	//피의자 수정 버튼 
//							}
//						}
					}
					
					if(accessMap.criLvCd != "03" && accessMap.criLvCd != "" ){
						isSpUpdate = true;
						areaSetWrite($(".law"));
					}
				}else{
					
					areaSetReadOnly($(".tab_mini_contents"));
					//피의자 수정 승인타스크 탔을경우 수정 불가능
					if(accessMap.criLvCd != "03" && accessMap.criLvCd != "" && scriStatCd != 42 &&scriStatCd != 43 &&scriStatCd != 44 &&scriStatCd != 45 &&scriStatCd != 46 &&scriStatCd != 60 &&scriStatCd != 61 &&scriStatCd != 62){
						isSpUpdate = true;
						areaSetWrite($(".law"));
					}
				}
				
				}else{
				isSpUpdate = false;	//피의자 정보 Map에 담기 여부
				areaSetReadOnly($(".tab_mini_contents"));
				
			}*/
			
			
		}
	}
	/*
	//수사역할이 없을경우에 수정불가 
	}else{
		areaSetReadOnly($(".tab_mini_contents"));
	}
		*/
	
	if(SJPBRole.getRoleMastYn()){
		if(IS_ALL_UPDATE_YN == "Y" && scriStatCd <= 52 ){
			isSpUpdate = true;	//피의자 정보 Map에 담기 여부  
			
			//구분변경가능 
			//$("#fdCd").removeAttr("disabled");
			
			//수사관변경가능 
			$("#criMbNmKorMainBtn").show();
			$("#criMbNmKorSubBtn").show();
			$("#criMbNmKorRefBtn").show();
			
			
			
			areaSetWrite($(".tab_mini_contents"));
		}
	}
	
}



//유저와 타스크상태에 따른 버튼 활성화 처리
function handleTab1BtnGroup() {
	//인지, 입건, 수사단계일 경우에만 사건수정가능하므로, 첫번째탭 버튼 노출
	var taskTrstVOSB_tab1 = new StringBuffer();
	//var taskTrstVOSB_tab2 = new StringBuffer();
	
	//인지등록작업중, 입건등록작업중일 경우,
	if(b0101VOMap.criStatCd == "21" || b0101VOMap.criStatCd == "31"){
		// 사건삭제 - 수현
		taskTrstVOSB_tab1.append(" <a href=\"javascript:Fn_b_deleteIncMast("+b0101VOMap.rcptNum+");\" class=\"btn_white\" name=\"incDeleteBtn\"> <span>사건삭제</span></a>");
		//워크플로우가 만들어졌고, 워크플로우 타야함
		taskTrstVOSB_tab1.append('<a name="updateIncidentBtn" href="javascript:updateIncident(1);" class="btn_white" data-always="y"><span>임시저장</span></a>');
		
		if(isRootInc){
			$.each(b0101VOMap.taskTrstVOList, function(index, taskTrstVO) {
				if (SJPBRole.getHasAnyRole(taskTrstVO.taskRoleCd)) {	//역할에 맞는 버튼만 보이도록 처리	
					taskTrstVOSB_tab1.append(" <a href=\"javascript:void(0);\" class=\"btn_white\" name=\"trstBtn\" value=\""+taskTrstVO.trstStatNm+"\" data-update-type=\"2\" data-trst-stat-nm=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-num=\""+taskTrstVO.trstStatNum+"\" data-cri-stat-cd=\""+taskTrstVO.criStatCd+"\" data-wf-num=\""+taskTrstVO.wfNum+"\" data-always=\"y\"><span>"+taskTrstVO.trstStatNm+"</span></a> ");			
				}
			});
		}
		
	}else if(b0101VOMap.criStatCd == "20" ){//사건이첩
		
		isSpUpdate = true;	//피의자수정 
		taskTrstVOSB_tab1.append('<a name="updateIncidentBtn" href="javascript:updateIncident(1);" class="btn_white" data-always="y"><span>저 장</span></a>');
		
		
		if(isRootInc){
			$.each(b0101VOMap.taskTrstVOList, function(index, taskTrstVO) {
				
				if (SJPBRole.getHasAnyRole(taskTrstVO.taskRoleCd)) {	//역할에 맞는 버튼만 보이도록 처리	
					taskTrstVOSB_tab1.append(" <a href=\"javascript:void(0);\" class=\"btn_white\" name=\"trstBtn\" value=\""+taskTrstVO.trstStatNm+"\" data-update-type=\"2\" data-trst-stat-nm=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-num=\""+taskTrstVO.trstStatNum+"\" data-cri-stat-cd=\""+taskTrstVO.criStatCd+"\" data-wf-num=\""+taskTrstVO.wfNum+"\" data-always=\"y\"><span>"+taskTrstVO.trstStatNm+"</span></a> ");			
				}
			});
		}
	}else if(b0101VOMap.criStatCd == "23" || b0101VOMap.criStatCd == "22"){//사건중지  부서장승인, 수사사건부 등록
		
		if(isRootInc){
			$.each(b0101VOMap.taskTrstVOList, function(index, taskTrstVO) {
				
				if (SJPBRole.getHasAnyRole(taskTrstVO.taskRoleCd)&& taskTrstVO.viewYn != 'N') {	//역할에 맞는 버튼만 보이도록 처리	
					taskTrstVOSB_tab1.append(" <a href=\"javascript:void(0);\" class=\"btn_white\" name=\"trstBtn\" value=\""+taskTrstVO.trstStatNm+"\" data-update-type=\"2\" data-trst-stat-nm=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-num=\""+taskTrstVO.trstStatNum+"\" data-cri-stat-cd=\""+taskTrstVO.criStatCd+"\" data-wf-num=\""+taskTrstVO.wfNum+"\" data-always=\"y\"><span>"+taskTrstVO.trstStatNm+"</span></a> ");			
				}
			});
		}
		
	//승인프로세스(입건등록요청, , 수정요청)
	//}else if(b0101VOMap.criStatCd == "20" || b0101VOMap.criStatCd == "42" || b0101VOMap.criStatCd == "43" || b0101VOMap.criStatCd == "45" || b0101VOMap.criStatCd == "46" ){
	}else if(b0101VOMap.criStatCd == "45" || b0101VOMap.criStatCd == "46" ){
		
	
		if(isRootInc){
			
			//버튼 노출여부 
			var isTrstBtnView = false;
			//송치관, 과장은 역할만 의존해서 버튼 노출하고, 
			if(SJPBRole.getTrnsrRoleYn() || SJPBRole.getDrhfRoleYn()){
				isTrstBtnView = true;
			
			//그외, 팀장, 서무는 자기 팀일 경우에만 역할에 의존해서 버튼 노출한다. 
			}else{
				//로그인한 계정이 속한 팀 사건만 수정가능 2019.01.02
				if($("#orgCd").val() == b0101VOMap.criTmId){
					isTrstBtnView = true;
					
				}
			}
			//if(b0101VOMap.criStatCd == "20" && accessMap.criLvCd == "01"){
			//	taskTrstVOSB_tab1.append(" <a href=\"javascript:Fn_b_deleteIncMast("+b0101VOMap.rcptNum+");\" class=\"btn_blue\" name=\"incDeleteBtn\"> <span>사건삭제</span></a>");
			//}
			if(isTrstBtnView){
				$.each(b0101VOMap.taskTrstVOList, function(index, taskTrstVO) {
					if (SJPBRole.getHasAnyRole(taskTrstVO.taskRoleCd)) {	//역할에 맞는 버튼만 보이도록 처리
						taskTrstVOSB_tab1.append(" <a href=\"javascript:void(0);\" class=\"btn_white\" name=\"trstBtn\" value=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-nm=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-num=\""+taskTrstVO.trstStatNum+"\" data-cri-stat-cd=\""+taskTrstVO.criStatCd+"\" data-wf-num=\""+taskTrstVO.wfNum+"\" data-always=\"y\"><span>"+taskTrstVO.trstStatNm+"</span></a> ");			
					}
				});
			}
			
		}
		
	//담당수사관 배정중
	}else if(b0101VOMap.criStatCd == "30"){
		/*
		//송치관일경우, 고소/고발 담당자 배청 요청단계에서 사건저장 가능하도록 수정(피의자추가삭제가능) 2019.01.01
		if(SJPBRole.getTrnsrRoleYn()){
			isSpUpdate = true;	//피의자수정 
			taskTrstVOSB_tab1.append('<a name="updateIncidentBtn" href="javascript:updateIncident(1);" class="btn_white" data-always="y"><span>저 장</span></a>');
		}
		*/
		
		// 사건삭제 - 수현
		//taskTrstVOSB_tab1.append(" <a href=\"javascript:Fn_b_deleteIncMast("+b0101VOMap.rcptNum+");\" class=\"btn_white\" name=\"incDeleteBtn\"> <span>사건삭제</span></a>");
		
		
		isSpUpdate = true;	//피의자수정 
		taskTrstVOSB_tab1.append('<a name="updateIncidentBtn" href="javascript:updateIncident(1);" class="btn_white" data-always="y"><span>저 장</span></a>');
		
		
		//부서장역할 수사담당자 지정
		if(isRootInc){
			$.each(b0101VOMap.taskTrstVOList, function(index, taskTrstVO) {
				if (SJPBRole.getHasAnyRole(taskTrstVO.taskRoleCd)) {	//역할에 맞는 버튼만 보이도록 처리	
					taskTrstVOSB_tab1.append(" <a href=\"javascript:void(0);\" class=\"btn_white\" name=\"trstBtn\" value=\""+taskTrstVO.trstStatNm+"\" data-update-type=\"30\" data-trst-stat-nm=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-num=\""+taskTrstVO.trstStatNum+"\" data-cri-stat-cd=\""+taskTrstVO.criStatCd+"\" data-wf-num=\""+taskTrstVO.wfNum+"\" data-always=\"y\"><span>"+taskTrstVO.trstStatNm+"</span></a> ");			
				}
			});
		}
		
	//수사단계(수사착수, 재수사, 지휘부결, 재지휘부결)일 경우,
	}else if(b0101VOMap.criStatCd == "40" || b0101VOMap.criStatCd == "54" || b0101VOMap.criStatCd == "59"|| b0101VOMap.criStatCd == "74" || b0101VOMap.criStatCd == "79"){
		
		taskTrstVOSB_tab1.append('<a name="updateIncidentBtn" href="javascript:updateIncident(1);" class="btn_white" data-always="y"><span>저 장</span></a>');
	
	//지휘접수요청일 경우, 사건수정 가능 
	}else if(b0101VOMap.criStatCd == "50"){
		//로그인한 계정이 해당사건의 참조, 권한이없을경우 : 조회만가능
		if(accessMap.criLvCd == "03" || accessMap.criLvCd == ""){
			
		//권한이 있을경우, 수정가능 
		}else{
			taskTrstVOSB_tab1.append('<a name="updateIncidentBtn" href="javascript:updateIncident(1);" class="btn_white" data-always="y"><span>저 장</span></a>');
			
		}
	
		
	}else{
		if( b0101VOMap.criStatCd != 42 &&b0101VOMap.criStatCd != 43 &&b0101VOMap.criStatCd != 44 &&b0101VOMap.criStatCd != 45 &&b0101VOMap.criStatCd != 46 &&b0101VOMap.criStatCd != 60 &&b0101VOMap.criStatCd != 61 &&b0101VOMap.criStatCd != 62){
			if(accessMap.criLvCd != "03" && accessMap.criLvCd != ""){
				taskTrstVOSB_tab1.append('<a name="updateIncidentBtn" href="javascript:updateIncident(1);" class="btn_white" data-always="y"><span>저 장</span></a>');
			}
		
		}
		/*
		if($("#orgCd").val() == b0101VOMap.criTmId){
			if(SJPBRole.getTimhderRoleYn() || SJPBRole.getRoleGnlaffYn()){
				taskTrstVOSB_tab1.append('<a name="updateIncidentBtn" href="javascript:updateCriMb();" class="btn_white" data-always="y"><span>수사관지정</span></a>');
			}
		}
		*/
	}
	
	
	
	//송치관일경우, 오픈전에 모든 사건 수정 가능한 버튼 생성 S 2018.12.05 (property 값 사용함)
//	if(IS_ALL_UPDATE_YN == "Y" && SJPBRole.getRoleMastYn() && b0101VOMap.criStatCd <= 52 ){
	if( b0101VOMap.criStatCd != 42 &&b0101VOMap.criStatCd != 43 &&b0101VOMap.criStatCd != 44 &&b0101VOMap.criStatCd != 45 &&b0101VOMap.criStatCd != 46 &&b0101VOMap.criStatCd != 60 &&b0101VOMap.criStatCd != 61 &&b0101VOMap.criStatCd != 62){	
		if(IS_ALL_UPDATE_YN == "Y" && SJPBRole.getRoleMastYn()  ){
			if(taskTrstVOSB_tab1.toString().indexOf("updateIncident(1)") == -1){
				areaSetWrite($(".tab_mini_contents"));
				taskTrstVOSB_tab1.append('<a name="updateIncidentBtn" href="javascript:updateIncident(1);" class="btn_white" data-always="y"><span>저 장</span></a>');
			}
		}
	}
	//송치관일경우, 오픈전에 모든 사건 수정 가능한 버튼 생성 E 2018.12.05
	
		
	//버튼 노출
	var trstBtnGroupHtml_tab1 = taskTrstVOSB_tab1.toString();
	//var trstBtnGroupHtml_tab2 = taskTrstVOSB_tab2.toString();
	
	//승인인경우 
	// 1) 송치관이며, 수사상태가 입건등록요청[20] 번일 경우
	// 2) 팀장이며, 수사상태가 고발반송팀장승인요청[45] 번일 경우, 서무 추가 2019.01.02
	// 3) 과장이며, 수사상태가 고발반송과장승인요청[46] 번일 경우
	if ((SJPBRole.getTrnsrRoleYn() && b0101VOMap.criStatCd == "20") 
//			|| (SJPBRole.getTimhderRoleYn() && b0101VOMap.criStatCd == "42")
//			|| (SJPBRole.getDrhfRoleYn() && b0101VOMap.criStatCd == "43")
//			|| ((SJPBRole.getTimhderRoleYn() || SJPBRole.getRoleGnlaffYn()) && b0101VOMap.criStatCd == "45")
//			|| (SJPBRole.getDrhfRoleYn() && b0101VOMap.criStatCd == "46")
		) {//송치관이고 수사상태가 입건등록요청일경우!!!
		$("#apprArea_EditButtons").html(trstBtnGroupHtml_tab1);
		$("#apprArea_EditButtons a:first").attr("class", "btn_blue");
		$("#taskNmTD").html(getTaskNm(b0101VOMap.taskNm));
		$("#criArea02").hide();
		if (trstBtnGroupHtml_tab1 != "") {
			$("#apprArea02").show();
		} else {
			$("#apprArea02").hide();
		}
		
		//결재의견만 활성화
		$("#taskComn").val("").attr("disabled",false);
		
	}else if ( ((SJPBRole.getTimhderRoleYn() || SJPBRole.getRoleGnlaffYn()) && b0101VOMap.criStatCd == "45")
				|| (SJPBRole.getDrhfRoleYn() && b0101VOMap.criStatCd == "46" 
				|| (( SJPBRole.getDeptRoleYn() || SJPBRole.getSubDeptRoleYn() ) && b0101VOMap.criStatCd == "23"))
			) {//사건중지
		
			$("#apprArea_EditButtons").html(trstBtnGroupHtml_tab1);
			$("#apprArea_EditButtons a:first").attr("class", "btn_blue");
			$("#taskNmTD").html(getTaskNm(b0101VOMap.taskNm));
			$("#criArea02").hide();
			if (trstBtnGroupHtml_tab1 != "") {
				$("#apprArea02").show();
			} else {
				$("#apprArea02").hide();
			}
			
			//결재의견만 활성화
			$("#taskComn").val("").attr("disabled",false);

		
	}else{
		
		$("#btnArea_EditButtons").html(trstBtnGroupHtml_tab1);
		$("#btnArea_EditButtons a:last").attr("class", "btn_blue");
		$("#criArea02").show();
		$("#apprArea02").hide();
		
	}
	
}

//유저와 상태에 따른 버튼 활성화 처리
function handleBtn(){
	
	var scriStatCd = isNull(b0101VOMap.criStatCd) ? 30 : Number(b0101VOMap.criStatCd) ;

	//수사관일경우 수사관 검색 버튼 활성화(수사관)
	if(SJPBRole.getDeptRoleYn() || SJPBRole.getSubDeptRoleYn()){
		if("30,40,54,59,74,79".indexOf(scriStatCd) != -1){
			$("#criMbNmKorMainBtn").show();	//주수사관 검색 버튼 활성화
		}

	}else if (SJPBRole.getInvigtorRoleYn()) {
		
		$("#criMbNmKorMainBtn").hide();	//주수사관 검색 버튼 비활성화
		$("#criMbNmKorRefBtn").hide();	//참조수사관 검색 버튼 비활성화
		$("a[data-name=removeRefCriMbliBtn]").hide();	//참조수사관 삭제 버튼 비활성화
		
		//로그인한 계정이 해당사건의 담당 수사관일 경우 : 수사관 지정가능
		if(accessMap.criLvCd == "01"){
			
			//수사 단계, 지휘부결(54), 재지휘부결(59) 에서만 수사관 수정 가능 
			if(scriStatCd == "40" || scriStatCd == "54" || scriStatCd == "59" || scriStatCd == "74" || scriStatCd == "79"){
				$("#criMbNmKorSubBtn").show();	//수사관 검색 버튼 활성화
				$("a[data-name=removeSubCriMbliBtn]").show();	//수사관 삭제 버튼 활성화
			}else{
				$("#criMbNmKorSubBtn").hide();	//수사관 검색 버튼 비활성화
				$("a[data-name=removeSubCriMbliBtn]").hide();	//수사관 삭제 버튼 비활성화
			}
			
		//로그인한 계정이 해당사건의 수사관일 경우 : 담당 수사관과 동일하지만 수사관 지정 불가능 
		}else if(accessMap.criLvCd == "02"){
			$("#criMbNmKorSubBtn").hide();	//수사관 검색 버튼 비활성화
			$("a[data-name=removeSubCriMbliBtn]").hide();	//수사관 삭제 버튼 비활성화
			
		//로그인한 계정이 해당사건의 참조 수사관일 경우 : 조회만가능
		}else{
			$("#criMbNmKorSubBtn").hide();	//수사관 검색 버튼 비활성화
			$("a[data-name=removeSubCriMbliBtn]").hide();	//수사관 삭제 버튼 비활성화
		}
		
	//
	}else if(SJPBRole.getTimhderRoleYn()){
		$("#criMbNmKorMainBtn").show();	//주수사관 검색 버튼 활성화
		$("#criMbNmKorSubBtn").show();	//수사관 검색 버튼 활성화
		$("a[data-name=removeSubCriMbliBtn]").show();	//수사관 삭제 버튼 활성화
		
		$("#criMbNmKorRefBtn").show();	//참조수사관 검색 버튼 활성화
		
		$("a[data-name=removeRefCriMbliBtn]").show();	//참조수사관 삭제 버튼 활성화
		//수사팀장 수사관 검색 버튼 활성화(담당수사관, 수사관, 참조수사관), 서무 추가 2019.01.02
	}else if(SJPBRole.getTimhderRoleYn()){
		//$("#criMbNmKorMainBtn").show();	//주수사관 검색 버튼 활성화
		$("#criMbNmKorSubBtn").show();	//수사관 검색 버튼 활성화
		$("a[data-name=removeSubCriMbliBtn]").show();	//수사관 삭제 버튼 활성화
		
		$("#criMbNmKorRefBtn").show();	//참조수사관 검색 버튼 활성화
		$("a[data-name=removeRefCriMbliBtn]").show();	//참조수사관 삭제 버튼 활성화
		
	//과장일경우 수사관 검색 버튼 비활성화(담당수사관, 수사관, 참조수사관)
	}else if(SJPBRole.getDrhfRoleYn()){
		$("#criMbNmKorMainBtn").hide();
		
		$("#criMbNmKorSubBtn").hide();
		$("a[data-name=removeSubCriMbliBtn]").hide();	//수사관 삭제 버튼 비활성화
		
		$("#criMbNmKorRefBtn").hide();
		$("a[data-name=removeRefCriMbliBtn]").hide();	//참조수사관 삭제 버튼 비활성화
	//송치관일 경우
	}else if(SJPBRole.getTrnsrRoleYn()){
		$("#criMbNmKorMainBtn").hide();	//주수사관 검색 버튼 비활성화
		
		$("#criMbNmKorSubBtn").hide();	//수사관 검색 버튼 비활성화
		$("a[data-name=removeSubCriMbliBtn]").hide();	//수사관 삭제 버튼 비활성화
		
		$("#criMbNmKorRefBtn").hide();	//참조수사관 검색 버튼 비활성화
		$("a[data-name=removeRefCriMbliBtn]").hide();	//참조수사관 삭제 버튼 비활성화
		
	//단장일 경우
	}else if(SJPBRole.getHeaderRoleYn()){
		$("#criMbNmKorMainBtn").hide();	//주수사관 검색 버튼 비활성화
		
		$("#criMbNmKorSubBtn").hide();	//수사관 검색 버튼 비활성화
		$("a[data-name=removeSubCriMbliBtn]").hide();	//수사관 삭제 버튼 비활성화
		
		$("#criMbNmKorRefBtn").hide();	//참조수사관 검색 버튼 비활성화
		$("a[data-name=removeRefCriMbliBtn]").hide();	//참조수사관 삭제 버튼 비활성화
		
	//역할이 없을경우 모두 비활성화
	}else{
		$("#criMbNmKorMainBtn").hide();	//주수사관 검색 버튼 비활성화
		$("#criMbNmKorSubBtn").hide();	//수사관 검색 버튼 비활성화
		$("a[data-name=removeSubCriMbliBtn]").hide();	//수사관 삭제 버튼 비활성화
		$("#criMbNmKorRefBtn").hide();	//참조수사관 검색 버튼 비활성화
		$("a[data-name=removeRefCriMbliBtn]").hide();	//참조수사관 삭제 버튼 비활성화
	}
	
	//서무추가 2019.01.02
	//팀장과 동일 역할 
	if(SJPBRole.getRoleGnlaffYn()){
		$("#criMbNmKorMainBtn").show();	//주수사관 검색 버튼 활성화
		$("#criMbNmKorSubBtn").show();	//수사관 검색 버튼 활성화
		$("a[data-name=removeSubCriMbliBtn]").show();	//수사관 삭제 버튼 활성화
		
		$("#criMbNmKorRefBtn").show();	//참조수사관 검색 버튼 활성화
		$("a[data-name=removeRefCriMbliBtn]").show();	//참조수사관 삭제 버튼 활성화
	}
	
}

//수사정보를 업데이트한다. (삭제됨 20181116)
//function updateInvestigation(callBackFunc){
//	
//	b0101VOMap.criCont = $("#criCont").text();	//사건내용
//	
//	//워크플로우번호
//	b0101VOMap.wfNum = b0101TKMap.wfNum;
//	
//	goAjax("/sjpb/B/updateInvestigation.face", b0101VOMap, function(data){ callBackUpdateInvestigationSuccess(data, callBackFunc) });
//	
//}

////수사정보 업데이트 성공 콜백함수
//function callBackUpdateInvestigationSuccess(data, callBackFunc){
//	//isReq : 수사지휘 요청 여부
//	alert("수사정보 수정성공!!");
//	
//	//수사지휘요청타스크 진행 
//	if(callBackFunc != null){	
//		if (typeof callBackFunc == "function") {
//			callBackFunc(data);
//		}
//		
//	}else{
//		//리스트 재조회
//		selectList(b0101VOMap.rcptNum);
//	}
//}

//사건을 업데이트 한다.
function updateIncident(type){
	//type : 0 = 초기생성 : 등록작업중 상태에서 업데이트 (워크플로우생성) - 타스크 진행 (삭제)
	//type : 1 = 일반 업데이트 - 타스크 진행
	//type : 3 = (수사중상태) 수사지휘 요청, 사건중지요청 - 타스크 진행 
	//type : 4 = 송치요청, 재송치요청, 송치완료 - 타스크 진행 
	//type : 5 = 처분등록 - 타스크 진행
	//type : 6 = 처분수정 - 타스크 진행 안함 
	//type : 7 = 판결등록 - 타스크 진행 
	//type : 8 = 판결수정 - 타스크 진행 안함
	//type : 30 = 입건-> 팀장이 수사관지정할 경우, 피의자 중복검사 하지않음
	
	if(type == 1){
		
		//유효성 체크
		var chkObjs = $("#tab_mini_m1_contents");
		if(!chkValidate.check(chkObjs, true)) return;
		
		//맵갱신
		syncB0101VOMap();
		
		//사건이 수사착수단계 이후 일경우에만, 변경이력을 수집한다. 
		var scriStatCd = isNull(b0101VOMap.criStatCd) ? 30 : Number(b0101VOMap.criStatCd) ;
		if(scriStatCd >= 40){
			
			//사건변경이력 입력 팝업창 노출후, 사건수정
			commonLayerPopup.openLayerPopup('/sjpb/B/B0201.face?updateType=1', "800px", "350px", function(data){ callBackB0201Success(data, "/sjpb/B/updateIncMast.face", callBackUpdateIncidentSuccess)});	
			
			//상단으로 올림
			parent.fn_scrollTop();
			
		}else{
			
			//다음타스크진행안함
			
			goAjax("/sjpb/B/inquirySp.face", b0101VOMap, function(data){callBackInquirySpSuccess(data, "/sjpb/B/updateIncMast.face", callBackUpdateIncidentSuccess)});
		}
		
	//반송종결 
	//수사정보 업데이트 후, 수사지휘 요청한다. 
	}else if(type == 3){
		
		//사건중지요청 
		//if(b0101TKMap.criStatCd == "45"){
			//사건변경이력 입력 팝업창 노출후, 사건중지
			//commonLayerPopup.openLayerPopup('/sjpb/B/B0201.face?updateType=2', "800px", "350px", function(data){ callBackB0201EndSuccess(data, executeTask)});	
			
			//상단으로 올림
			//parent.fn_scrollTop();
			
		//수사지휘요청, 재수사지휘요청
		//}else if(b0101TKMap.criStatCd == "50" || b0101TKMap.criStatCd == "55"){
		if(b0101TKMap.criStatCd == "50" || b0101TKMap.criStatCd == "55"){	
			var reqMap3 = {
					rcptNum : b0101VOMap.rcptNum 
			}
			goAjaxDefault("/sjpb/B/selectIncidentStat.face", reqMap3, selectStsGrapCheck);
		}
		
		
	//송치요청, 재송치요청, 송치완료
	}else if(type == 4){
		
		//사건송치건 생성 + 타스크진행 (사건 업데이트 없이 진행함)
		var reqMap = new Object();
		reqMap.b0101VO = b0101VOMap;
		syncB0101TKMap();
		callBackInsertIncMastSuccess(reqMap, selectTrfInfo);
	
	//처분등록 - 타스크진행
	}else if(type == 5){
		//타스크 진행이 처분테이블에 등록후, ajax로 진행되므로 혹시 테이블만 등록되고 타스크 진행안하는 에러가 발생할 수 있음.
		//이때, 다시 insert 하려면 키값 중복으로 에러가 나기 때문에 처음 insert도 delete 후, insert로 구현함 
		
		//유효성 체크
		var chkObjs = $("#ocrt_list_tab2_div");
		if(!chkValidate.check(chkObjs, true)) return;
		
		var b0101VOMapTmp = new Object();
		syncIncDipRstVOList(b0101VOMapTmp);
		syncB0101TKMap();
		goAjax("/sjpb/B/insertUpdateIncDipRst.face", b0101VOMapTmp, function(data){ callBackInsertIncMastSuccess(data, selectTrfInfo) });
		
	//처분수정 - 타스크진행안함
	}else if(type == 6){
		//delete 후, update로 구현함 
		
		//유효성 체크
		var chkObjs = $("#ocrt_list_tab2_div");
		if(!chkValidate.check(chkObjs, true)) return;
		
		var b0101VOMapTmp = new Object();
		syncIncDipRstVOList(b0101VOMapTmp);
		goAjax("/sjpb/B/insertUpdateIncDipRst.face", b0101VOMapTmp, callBackUpdateIncDipRstSuccess);
	
	//판결등록 - 타스크진행
	}else if(type == 7){
		//타스크 진행이 판결테이블에 등록후, ajax로 진행되므로 혹시 테이블만 등록되고 타스크 진행안하는 에러가 발생할 수 있음.
		//이때, 다시 insert 하려면 키값 중복으로 에러가 나기 때문에 처음 insert도 delete 후, insert로 구현함 
		
		//유효성 체크
		var chkObjs = $("#ocrt_list_tab3_div");
		if(!chkValidate.check(chkObjs, true)) return;
		
		var b0101VOMapTmp = new Object();
		syncIncJdtRstVOList(b0101VOMapTmp);
		syncB0101TKMap();
		goAjax("/sjpb/B/insertUpdateIncJdtRst.face", b0101VOMapTmp, function(data){ callBackInsertIncMastSuccess(data, selectTrfInfo) });
		
	//판결수정 - 타스크진행안함
	}else if(type == 8){
		//delete 후, update로 구현함 
		
		//유효성 체크
		var chkObjs = $("#ocrt_list_tab3_div");
		if(!chkValidate.check(chkObjs, true)) return;
		
		var b0101VOMapTmp = new Object();
		syncIncJdtRstVOList(b0101VOMapTmp);
		goAjax("/sjpb/B/insertUpdateIncJdtRst.face", b0101VOMapTmp, callBackUpdateIncJdtRstSuccess);
		
	//피의자 중복검사 하지않음, 다음타스크진행
	}else if(type == 30){
		//맵갱신
		syncB0101VOMap();
		
		//주 수사관이 지정되어있는지 확인! 
		var isSetMainCriMb = false;
		$.each(b0101VOMap.incCriMbVOList, function(i, incCriMbVO) {
			if(incCriMbVO.criLvCd == "01"){		//주수사관이 지정되어있음
				isSetMainCriMb = true;
				return false;
			}
		});
		
		//주 수사관이 지정되어있지 않으면, 진행안함
		if(!isSetMainCriMb){
			alert("담당 수사관을 지정해주세요.");
			return;
		}
		syncB0101TKMap();
		
		goAjax("/sjpb/B/updateIncMast.face", b0101VOMap, callBackInsertIncMastSuccess);
		
	}else{
		//인지, 임시저장후, 등록요청할때 여기 탐 
		//송치관일경우에만, 오픈전에 사건 생성 가능 S 2018.12.05 (property 값 사용함)
		if(!chkIsAllUpdateYn()){
			return;
		}
		//송치관일경우에만, 오픈전에 사건 생성 가능 E 2018.12.05
		
		//유효성 체크
		var chkObjs = $("#tab_mini_m1_contents");
		if(!chkValidate.check(chkObjs, true)) return;
		
		//맵갱신
		syncB0101VOMap();
		/*
		var rstYN = "Y";
		$.each(b0101VOMap.incSpVOList, function(i, incSpVO) {
			
			$.each(incSpVO.actVioVOList,function(i,actVioVO){
				
				if(actVioVO.actVioClaVOList.length == 0){
					rstYN = "N";
				}else{
					if(actVioVO.actVioClaVOList.length == 0){
						rstYN = "N";
					}else{
						var actVioClaNmYN = actVioVO.actVioClaVOList[0].actVioClaNm;
						var vioContYN = actVioVO.vioCont;
						var rltActCriNmCdYN = actVioVO.rltActCriNmCd;
						if( actVioClaNmYN == null || actVioClaNmYN == ""||vioContYN == null||vioContYN ==  "" || rltActCriNmCdYN == null || rltActCriNmCdYN == ""){
									
							rstYN = "N";
						}
					}
				}
			});

		});
		
		if(rstYN == "N"){
			alert("위반법률, 위반조항, 위반내용을 입력하세요.");	
			return;
		}
		*/
		//syncB0101TKMap();
		//다음타스크진행
		goAjax("/sjpb/B/inquirySp.face", b0101VOMap, function(data){callBackInquirySpSuccess(data, "/sjpb/B/updateIncMast.face", callBackUpdateIncMastSuccessExecute)});
		
	}
}

function selectStsGrapCheck(data){
	//통계원표를 모두 입력했는지 확인한다. 
	
	b0101VOMap = data.b0101VO;
	
	if(isAllCheckGrap()){
		//맵갱신
		//syncB0101VOMap();
		//updateInvestigation(callBackInsertIncMastSuccess);
//		var reqMap = new Object();
//		reqMap.b0101VO = b0101VOMap;
//		callBackInsertIncMastSuccess(reqMap);
		executeTask();
	//통계원표가 모두 입력이 안된 상태(진행안됨)
	}else{
		var spChk = "Y";
		$.each(b0101VOMap.incSpVOList, function(i, incSpVO) {
			var idNumlen = (Base64.decode(incSpVO.spIdNum)).length;
			var spNm = Base64.decode(incSpVO.spNm);
			if(spNm.indexOf("성명불상") != -1 || spNm.indexOf("성명 불상") != -1){
				
			}else{
				if(idNumlen != 14 ||spNm == "" ||spNm == null ||incSpVO.spAddr == "" ||incSpVO.spAddr == null){
					alert("피의자의 성명, 주민등록번호, 주소를 입력하셔야 통계원표 입력이 가능합니다.");
					spChk = "N";
					return false;
				}
			}
		});
		if(spChk == "Y"){
			alert("통계원표를 입력해 주세요.");
		}
	}
}


function hasDuplicates(array) { 
    return (new Set(array)).size !== array.length; 
} 

//사건중지 process
function callBackB0201EndSuccess(data, callBackFunction){
	
	//변경상세내용 값이 없으면 진행하지 않음
	if(isNull(data.mfCont) || isNull(data.mfCd)){
		alert("중지사유를 입력해주세요.");
		//진행하지 않음 
	
	//변경이력값이 있음 
	}else{
		//변경상세내용셋팅
		b0101TKMap.taskComn = data.mfCont;
		b0101TKMap.stop = data.stop;
		b0101TKMap.trstStatNum = data.trstStatNum;
		b0101TKMap.taskNum = data.taskNum;
		b0101TKMap.criStatCd = data.criStatCd;
		if (typeof callBackFunction == "function") {
			callBackFunction();
		}
	}
	
}

function callBackB0201Success(data, url, callBackFunction){

	//변경내용, 변경상세내용 중 하나라도 값이 없으면 진행하지 않음
	if(isNull(data.mfCd) || isNull(data.mfCont)){
		alert("변경내용을 입력해주세요.");
		//진행하지 않음 
	
	//변경이력값이 있음 
	}else{
		//변경내용, 변경상세내용셋팅
		b0101VOMap.mfCd = data.mfCd;
		b0101VOMap.mfCont = data.mfCont;
		
		goAjax("/sjpb/B/inquirySp.face", b0101VOMap, function(data){callBackInquirySpSuccess(data, url, callBackFunction)});
		
	}
	
}

//운영전, 송치관만 사건 등록 가능. 2018.12.05
function chkIsAllUpdateYn(){
//	if(IS_ALL_UPDATE_YN == "Y"){
//		if(!SJPBRole.getTrnsrRoleYn()){
//			alert("시스템 오픈 전, 송치관만 사건 저장이 가능합니다.");
//			return false;
//		}else{
//			return true;
//		}
//	}
	return true;
}

//팀장이 수사관을 수정한다. 
function updateCriMb(){
	//맵갱신
	syncB0101VOMap();
	
	if(b0101VOMap.criStatCd == '30'){
		goAjax("/sjpb/B/updateCriMb.face", b0101VOMap, callBackupdateCriMbSuccess);
	}else {
		//commonLayerPopup.openLayerPopup('/sjpb/B/B0201.face?updateType=1', "800px", "350px", function(data){ callBackB0201Success2(data, "/sjpb/B/updateCriMb.face", callBackupdateCriMbSuccess)});
		commonLayerPopup.openLayerPopup('/sjpb/B/B0201.face?updateType=1', "800px", "350px", function(data){ callBackB0201Success2(data, "/sjpb/B/updateIncMast.face", callBackupdateCriMbSuccess)});	
		parent.fn_scrollTop();
	}
	
}

function callBackB0201Success2(data, url, callBackFunction){
	//변경내용, 변경상세내용 중 하나라도 값이 없으면 진행하지 않음
	if(isNull(data.mfCd) || isNull(data.mfCont)){
		alert("변경내용을 입력해주세요.");
		//진행하지 않음 
	
	//변경이력값이 있음 
	}else{
		//변경내용, 변경상세내용셋팅
		b0101VOMap.mfCd = data.mfCd;
		b0101VOMap.mfCont = data.mfCont;
		
		goAjax("/sjpb/B/inquirySp.face", b0101VOMap, function(data){callBackInquirySpSuccess2(data, url, callBackFunction)});
		
	}
	
}

function callBackInquirySpSuccess2(data, url, callbackFunction){
	goAjax(url, b0101VOMap, callbackFunction);

}




//수사관 수정 성공 콜백함수
function callBackupdateCriMbSuccess(data){
	alert("수사관 지정이 되었습니다.");
	//리스트 재조회
	selectList(data.b0101VO.rcptNum);
	
}

//사건업데이트 성공 콜백함수 (타스크진행안함)
function callBackUpdateIncidentSuccess(data){
	alert("사건이 수정 되었습니다.");
	//리스트 재조회
	selectList(data.b0101VO.rcptNum);
	
}

//사건등록 화면을 노출한다. 
function insertIncMastView(){
	
	goAjaxDefault("/sjpb/B/insertIncMastView.face", null, callBackInsertIncMastViewSuccess);
	
}

//사건등록 화면을 노출 콜백함수
function callBackInsertIncMastViewSuccess(data){
	
	//초기화 
	initData("0");
	
	var orgCd = $("#orgCd").val();		//수사팀코드
	//var kindCd = $("#kindCd").val();	//수사단원구분
	
	//사건정보 셋팅 (테이블 그리기)
	var spHtml = new StringBuffer();
	
	
	spHtml.append('<table class="list" cellpadding="0" cellspacing="0">																																																	');											
	spHtml.append('   <colgroup>                                                                                                                                                                                                                                        ');
	spHtml.append('	   <col width="15%" />                                                                                                                                                                                                                              ');
	spHtml.append('	   <col width="35%" />                                                                                                                                                                                                                              ');
	spHtml.append('	   <col width="15%" />                                                                                                                                                                                                                              ');
	spHtml.append('	   <col width="35%" />                                                                                                                                                                                                                              ');
	spHtml.append('   </colgroup>                                                                                                                                                                                                                                       ');
	spHtml.append('   <tbody>                                                                                                                                                                                                                                           ');
	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C">사건번호</th>                                                                                                                                                                                                                      ');
	spHtml.append('		   <td class="L">신규등록</td>                                                                                                                                                                                                      ');
	//금감원추가 컬럼!
	spHtml.append('		   <th class="C">접수번호</th>                                                                                                                                                                                                                      ');
	spHtml.append('		   <td class="L">'+( isNull(b0101VOMap.rcptOrdNum) ? "신규등록" : b0101VOMap.rcptOrdNum )+'</td>                                                                                                                                                                                                      ');
	spHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C">검찰사건번호 <em class=\"red\">*</em></th>                                                                                                                                                                                                                      ');
	spHtml.append('		   <td class="L"><input type="text" class="w100per" id="poIncNum" name="poIncNum" data-poIncNum="" value="" data-always="y" title="검찰사건번호" maxlength="20"/> </td>                                                                                                                                                                                                      ');
	spHtml.append('		   <th class="C">발각형태 <em class=\"red\">*</em></th>                                                                                                                                                                                                                      ');
	spHtml.append('		   <td class="L">                                  ');
	spHtml.append('	   			<div class="inputbox w80per">                                                       ');	
	spHtml.append('	   				<p class="txt"></p>                                                   ');	
	spHtml.append('				   	<select name="dvForm" id="dvForm" data-type="select" data-optional-value="false" title="발각형태" >                                                                                                                                                                                                                             ');
	spHtml.append('						<option value="">선택</option>');
	$.each(data.dvFormKndList, function(k, dvForm) {
		spHtml.append('					<option value="'+dvForm.code+'" >'+dvForm.codeName+'</option>');
	});
	spHtml.append('	   				</select>                                                                       ');	
	spHtml.append('	   			</div>                                                                              ');	
	spHtml.append('	   		</td>                                                                              ');		
	spHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C">종목</th>                                                                                                                                                                                                                      ');
	spHtml.append('		   <td class="L"><input type="text" class="w100per" id="stock" name="stock" data-stock="" value="" /> </td>                                                                                                                                                                                                      ');
	spHtml.append('		   <th class="C">착수일시</th>                                                                                                                                                                                                                      ');
	spHtml.append('		   <td class="L"><input type="text" class="w100per calendar datepicker" name="beDt" id="beDt" value="" title="착수일시" readonly />');
	spHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C">처리일시</th>                                                                                                                                                                                                                      ');
	spHtml.append('		   <td class="L"><input type="text" class="w100per calendar datepicker" name="proDt" id="proDt" value="" title="처리일시" readonly />');
	spHtml.append('		   <th class="C">수리일시</th>                                                                                                                                                                                                                      ');
	spHtml.append('		   <td class="L"><input type="text" class="w100per calendar datepicker" name="acptDt" id="acptDt" value="" title="수리일시" readonly />');
	
	spHtml.append('	   </tr>                                                                                                                                                                                                                                             ');	
	//spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	//spHtml.append('		   <th class="C">수사팀 배정</th>                                                                                                                                                                                                                    ');
	//spHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	//spHtml.append('			<p class="searchinput">                                                                                                                                                                                                                     ');
	//spHtml.append('			<label for="criTmNm"></label><input type="text" class="w100per" id="criTmNm" name="criTmNm" data-criTmId="" value="" disabled="true" data-always="y"/>                             ');
	//spHtml.append('			</p>                                                                                                                                                                                                                                        ');
	//spHtml.append('		</td>                                                                                                                                                                                                                                           ');
	//spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
	
	spHtml.append('	   <tr>                                                                                                                                                                                                                                            ');
	spHtml.append('		   <th class="C">담당 수사관</th>                                                                                                                                                                                                                    ');
	spHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	spHtml.append('			<p class="searchinput">                                                                                                                                                                                                                     ');
	spHtml.append('			<label for="criMbNmKorMain"></label><input type="text" class="w100per" id="criMbNmKorMain" name="criMbNmKorMain" value="" data-name="criMb" data-criMbId="" disabled="true" data-always="y"/><a class="btn_search" id="criMbNmKorMainBtn" name="criMbNmKorMainBtn" href="#" style="display:none;" data-always="y"><img src="/sjpb/images/btn_search.png" alt="search" /></a>             ');
	spHtml.append('			</p>                                                                                                                                                                                                                                        ');
	spHtml.append('		</td>                                                                                                                                                                                                                                           ');
	//금감원추가
	//지휘자 추가
	spHtml.append('		   <th class="C">지휘자</th>                                                                                                                                                                                                                    ');
	spHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	spHtml.append('			<p class="searchinput">                                                                                                                                                                                                                     ');
	spHtml.append('			<label for="dirId"></label><input type="text" class="w100per" id="dirId" name="dirId" value="" data-name="dirId" data-dirId="" /><a class="btn_search" id="dirIdBtn" name="dirIdBtn" href="javascript:setDirId();" ><img src="/sjpb/images/btn_search.png" alt="search" /></a>             ');
	spHtml.append('			</p>                                                                                                                                                                                                                                        ');
	spHtml.append('		</td>                                                                                                                                                                                                                                           ');
	spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
	
	//금감원주석
	//수사관,참조수사관 선택 영역 삭제
	//	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
//	spHtml.append('		   <th class="C">수사관</th>                                                                                                                                                                                                                       ');
//	spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
//	spHtml.append('			   <div class="list_box">                                                                                                                                                                                                                   ');
//	spHtml.append('				   <ul id="criMbNmKorSubArea">                                                                                                                                                                                                                                 ');
	//spHtml.append('					   <li><span>홍길동</span><a href="#" class="list_box_close"><img src="/sjpb/images/btn_box_close.png" alt="닫기 버튼" /></a></li>                                                                       ');
	//spHtml.append('					   <li><span>김철수</span><a href="#" class="list_box_close"><img src="/sjpb/images/btn_box_close.png" alt="닫기 버튼" /></a></li>                                                                       ');
//	spHtml.append('				   </ul>                                                                                                                                                                                                                                ');
//	spHtml.append('				   <a href="javascript:setCriMbNmKorSub();" id="criMbNmKorSubBtn" name="criMbNmKorSubBtn" class="btn_gray" style="display:none;" data-always="y"><span>검색</span></a>                                                                                                                                                                                     ');
//	spHtml.append('			   </div>                                                                                                                                                                                                                                   ');
//	spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
//	spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
//	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
//	spHtml.append('		   <th class="C">참조</th>                                                                                                                                                                                                                        ');
//	spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
//	spHtml.append('			   <div class="list_box">                                                                                                                                                                                                                   ');
//	spHtml.append('				   <ul id="criMbNmKorRefArea">                                                                                                                                                                                                                                 ');
	//spHtml.append('					   <li><span>홍길동</span><a href="#" class="list_box_close"><img src="/sjpb/images/btn_box_close.png" alt="닫기 버튼" /></a></li>                                                                       ');
	//spHtml.append('					   <li><span>김철수</span><a href="#" class="list_box_close"><img src="/sjpb/images/btn_box_close.png" alt="닫기 버튼" /></a></li>                                                                       ');
//	spHtml.append('				   </ul>                                                                                                                                                                                                                                ');
//	spHtml.append('				   <a href="javascript:setCriMbNmKorRef();" id="criMbNmKorRefBtn" name="criMbNmKorRefBtn" class="btn_gray" style="display:none;" data-always="y"><span>검색</span></a>                                                                                                                                                                                     ');
//	spHtml.append('			   </div>                                                                                                                                                                                                                                   ');
//	spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
//	spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
//	spHtml.append('   </tbody>                                                                                                                                                                                                                                          ');
	spHtml.append('</table>                                                                                                                                                                                                                                             ');
	
	
	
	spHtml.append('<div class="personinfo" data-name="personinfo">                                                                                                                                                                                                                                ');
	
	spHtml.append('<div class="btnArea">                                                                                                                                                                                                                                ');
	spHtml.append('	  <div class="r_btn">                                                                                                                                                                                                                                  ');
	spHtml.append('	   <a name="sp_add_btn" onclick="javascript:spAdd(this);" href="javascript:void(0);"><img src="/sjpb/images/plus_icon.png" alt="더하기버튼" /></a>                                                                                                                                           ');
	spHtml.append('	   <a name="sp_sub_btn" onclick="javascript:spSub(this);" href="javascript:void(0);"><img src="/sjpb/images/minus_icon.png" alt="빼기버튼" /></a>                                                                                                                                           ');
	spHtml.append('	   <a name="sp_up_btn" onclick="javascript:spUp(this);" href="javascript:void(0);"><img src="/sjpb/images/Add_icon.png" alt="올리기버튼" /></a>                                                                                                                                            ');
	spHtml.append('	   <a name="sp_down_btn" onclick="javascript:spDown(this);" href="javascript:void(0);"><img src="/sjpb/images/delete_icon.png" alt="내리기버튼" /></a>                                                                                                                                         ');
	spHtml.append('   </div>                                                                                                                                                                                                                                            ');
	spHtml.append('</div>                                                                                                                                                                                                                                               ');
	spHtml.append('<table name="grid-table-sp" class="list" cellpadding="0" cellspacing="0">                                                                                                                                                                                                 ');
	
	spHtml.append('	<input type="hidden" name="spIdNum" value="" />  ');
	spHtml.append('	<input type="hidden" name="gendDiv" value="" />  ');	
	spHtml.append('	<input type="hidden" name="spNm" value="" />  ');
	spHtml.append('	<input type="hidden" name="updateCd" value="C" />   ');
	spHtml.append('	<input type="hidden" name="h_incSpNum" value="" />   ');
	
	spHtml.append('   <colgroup>                                                                                                                                                                                                                                        ');
	spHtml.append('   <col width="10%" />                                                                                                                                                                                                                               ');
	spHtml.append('   <col width="15%" />                                                                                                                                                                                                                               ');
	spHtml.append('   <col width="30%" />                                                                                                                                                                                                                               ');
	spHtml.append('   <col width="15%" />                                                                                                                                                                                                                               ');
	spHtml.append('   <col width="30%" />                                                                                                                                                                                                                               ');
	spHtml.append('   </colgroup>                                                                                                                                                                                                                                       ');
	spHtml.append('   <tbody>                                                                                                                                                                                                                                           ');
	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C line_right" rowspan="15">피의자 정보</th>                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C">구분 <em class=\"red\">*</em></th>                                                                                                                                                                                                                        ');
	spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                               ');
	
	//첫번재 클래스 
	var classTmp = "";
	$.each(data.indvCorpDivKndList, function(j, indvCorpDiv) {
		
		classTmp = "";
		if(j == 0){
			classTmp = " radio_first";
		}
		
		//spHtml.append('			   <input id="indvCorpDiv_'+j+'" name="indvCorpDiv_'+'0'+'" data-name="indvCorpDiv" type="radio" class="radio_pd radio_first" value="'+indvCorpDiv.code+'" /><label for="indvCorpDiv_'+j+'">'+indvCorpDiv.codeName+'</label>                                                                                                               ');
		spHtml.append('			   <input id="indvCorpDiv_'+j+'" name="indvCorpDiv_'+'0'+'" data-name="indvCorpDiv" type="radio" class="radio_pd'+classTmp+'" value="'+indvCorpDiv.code+'" '+(j == 0 ? "checked=\"checked\"":"")+'/><label for="indvCorpDiv_'+j+'">'+indvCorpDiv.codeName+'</label>                                                                                                               ');
	});
	spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	spHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
	spHtml.append('	   <tr name="indvTR1">                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C">내 외국인 <em class=\"red\">*</em></th>                                                                                                                                                                                                                     ');
	spHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
	
	$.each(data.homcForcPernDivKndList, function(j, homcForcPernDiv) {
		
		classTmp = "";
		if(j == 0){
			classTmp = " radio_first";
		}
		
		spHtml.append('			   <input id="homcForcPernDiv_'+j+'" name="homcForcPernDiv_'+'0'+'" data-name="homcForcPernDiv" type="radio" class="radio_pd'+classTmp+'" value="'+homcForcPernDiv.code+'" '+(j == 0 ? "checked=\"checked\"":"")+'/><label for="homcForcPernDiv_'+j+'">'+homcForcPernDiv.codeName+'</label>                                                                                                          ');
	});
	
	spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	spHtml.append('		   <th class="C">성명 <em class=\"red\">*</em></th>                                                                                                                                                                                                                       ');
	spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
	spHtml.append('			   <label for="spIndvNm_0"></label><input type="text" class="w100per" id="spIndvNm_0" name="spIndvNm" data-type="name" data-optional-value=false maxlength="20" title="성명" />                                                                                                                                                    ');
	spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
	spHtml.append('	   <tr name="corpTR1">                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C">법인명 <em class=\"red\">*</em></th>                                                                                                                                                                                                                       ');
	spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
	spHtml.append('			   <label for="spCorpNm_0"></label><input type="text" class="w100per" id="spCorpNm_0" name="spCorpNm" data-type="name" data-optional-value=true maxlength="20" title="법인명"/>                                                                                                                                                    ');
	spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
	spHtml.append('	   <tr name="indvTR2">                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C"><span name="spIdNumTitle">주민등록번호</span></th>                                                                                                                                                                                                                    ');
	spHtml.append('		   <td class="L">                                                                                                                                                                                                                   ');
	spHtml.append('			   <label for="spIdNumA_0"></label><input type="text" class="w40per" id="spIdNumA_0" name="spIdNumA" value="" data-type="rnnFront" data-optional-value=true maxlength="6" size="6" title="주민등록번호"/>                                                            ');
	spHtml.append('		   	   ~ <label for="spIdNumB_0"></label><input type="text" class="w40per" id="spIdNumB_0" name="spIdNumB" value="" data-type="rnnBack" data-optional-value=true maxlength="7" size="7" title="주민등록번호"/>                                                                                                                                                                                                                                        ');
	spHtml.append('		   		&nbsp;<span name=\"gendDivSpan\"></span>                ');
	spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	spHtml.append('		   <th class="C">직업</th>                                                                                                                                                                                                                    ');
	spHtml.append('		   <td class="L">                                                                                                                                                                                                                   ');
	spHtml.append('           <label for="spJob_0"></label><input type="text" class="w100per" name="spJob" id="spJob_0" maxlength="50" value="" />  ');
	spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
	spHtml.append('	   <tr name="corpTR2">                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C">법인등록번호</th>                                                                                                                                                                                                                    ');
	spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
	spHtml.append('			   <label for="spCorpIdNumA_0"></label><input type="text" class="w40per" id="spCorpIdNumA_0" name="spCorpIdNumA" value="" data-type="bizIdFront" title="법인등록번호" maxlength="6" data-optional-value=true  size="6"/>                                                                  ');
	spHtml.append('		       ~ <label for="spCorpIdNumB_0"></label><input type="text" class="w40per" id="spCorpIdNumB_0" name="spCorpIdNumB" value="" data-type="bizIdBack" title="법인등록번호" maxlength="7" data-optional-value=true  size="7"/>                                                                                                                                                                                                                                    ');
	spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C">주소 <em class=\"red\">*</em></th>                                                                                                                                                                                                                        ');
	spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
	spHtml.append('			   <label for="spAddr_0"></label><input type="text" class="w100per" id="spAddr_0" name="spAddr" data-type="required" title="주소"/>                                                                                                                                                    ');
	spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C">연락처</th>                                                                                                                                                                                                                       ');
	spHtml.append('		   <td class="L">                                                                                                                                                                                                                   ');
	spHtml.append('			  <label for="spCnttNumA_0"></label><input type="text" class="w25per" id="spCnttNumA_0" name="spCnttNumA" maxlength="3"/> ~ <label for="spCnttNumB_0"></label><input type="text" class="w25per" id="spCnttNumB_0" name="spCnttNumB" maxlength="4"/> ~ <label for="spCnttNumC_0"></label><input type="text" class="w25per" id="spCnttNumC_0" name="spCnttNumC" maxlength="4" />                                                            ');
	spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	spHtml.append('		   <th class="C">업소명</th>                                                                                                                                                                                                                       ');
	spHtml.append('		   <td class="L">                                                                                                                                                                                                                   ');
	spHtml.append(' 			<label for="spBsnsNm_0"></label><input type="text" class="w100per" name="spBsnsNm" id="spBsnsNm_0" value="" maxlength="50" />                                                        ');
	spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
	
	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	spHtml.append('	   <td class="L" colspan="4">                                                                                                                                                                                                                       ');
	spHtml.append('	   	<div class="law" data-name="law">																				');	
	spHtml.append('			<input type="hidden" name="actVio_incSpNum" value="" />  ');
	spHtml.append('			<input type="hidden" name="actVio_actVioNum" value="" />  ');
	spHtml.append('			<input type="hidden" name="updateCd" value="C" />  ');
	spHtml.append('	   		<div class="btnArea">                                                                       ');	
	spHtml.append('	   			<div class="r_btn magin_btn_bottom">                                                    ');	
	spHtml.append('	   				<a name="law_add_btn" onclick="javascript:spAdd(this);" href="javascript:void(0);"><img src="/sjpb/images/plus_icon.png" alt="더하기버튼" /></a>                                                                                                                                           ');
	spHtml.append('	   				<a name="law_sub_btn" onclick="javascript:spSub(this);" href="javascript:void(0);"><img src="/sjpb/images/minus_icon.png" alt="빼기버튼" /></a>                                                                                                                                           ');
	spHtml.append('	   				<a name="law_up_btn" onclick="javascript:spUp(this);" href="javascript:void(0);"><img src="/sjpb/images/Add_icon.png" alt="올리기버튼" /></a>                                                                                                                                            ');
	spHtml.append('	   				<a name="law_down_btn" onclick="javascript:spDown(this);" href="javascript:void(0);"><img src="/sjpb/images/delete_icon.png" alt="내리기버튼" /></a>                                                                                                                                         ');
	spHtml.append('	   			</div>                                                                                  ');	
	spHtml.append('	   		</div>                                                                                      ');	
	spHtml.append('	   		<ul>                                                                                        ');	
	spHtml.append('	   			<li><span class="title">위반법률 및 죄명 <em class=\"red\">*</em></span>                                                ');	
	spHtml.append('	   				<div class="inputbox w80per">                                                       ');	
	

	var rltActCriNmCodeHtml = new StringBuffer();

	
	rltActCriNmCodeHtml.append('						<option value="">선택</option>                                                                                                          ');
	$.each(data.rltActCriNmKndList, function(k, rltActCriNm) {
		
		rltActCriNmCodeHtml.append('						<option value="'+rltActCriNm.code+'" >'+rltActCriNm.codeName+'</option>                                                                                                          ');
	});
	
	
	spHtml.append('	   					<p class="txt">선택 (사건구분을 먼저 선택해주세요.)</p>                                                             ');	
	spHtml.append('				   <select name="rltActCriNmCd"  data-type="select" data-optional-value="false" title="위반법률 및 죄명" >                                                                                                                                                                                                                             ');
	spHtml.append(rltActCriNmCodeHtml);
	spHtml.append('	   					</select>                                                                       ');	
	spHtml.append('	   				</div>                                                                              ');	
	spHtml.append('	   			</li>                                                                                   ');	
	spHtml.append('	   			<li><span class="title">위반내용 <em class=\"red\">*</em></span>                                                     ');	
	spHtml.append('	   				<label for="vioCont_0_0"></label><input type="text" class="w80per" id="vioCont_0_0" name="vioCont" data-type="name" data-optional-value=false maxlength="20" title="위반내용"/>');
	spHtml.append('	   			</li>                                                                                   ');	
	spHtml.append('	   			<li><span class="title">위반조항 </span>                                                     ');	
	spHtml.append('			 		<label for="actVioClaNm_0_0_0"></label><input type="text" class="w10per txt_first" id="actVioClaNm_0_0_0" name="actVioClaNm" />                                                                                                                                           ');
	spHtml.append('			   		<label for="actVioClaNm_0_0_1"></label><input type="text" class="w10per" id="actVioClaNm_0_0_1" name="actVioClaNm" />                                                                                                                                                     ');
	spHtml.append('			   		<label for="actVioClaNm_0_0_2"></label><input type="text" class="w10per" id="actVioClaNm_0_0_2" name="actVioClaNm" />                                                                                                                                                     ');
	spHtml.append('			   		<label for="actVioClaNm_0_0_3"></label><input type="text" class="w10per" id="actVioClaNm_0_0_3 name="actVioClaNm" />                                                                                                                                                     ');
	spHtml.append('			   		<label for="actVioClaNm_0_0_4"></label><input type="text" class="w10per" id="actVioClaNm_0_0_4" name="actVioClaNm" />                                                                                                                                                     ');
	spHtml.append('			   		<label for="actVioClaNm_0_0_5"></label><input type="text" class="w10per" id="actVioClaNm_0_0_5" name="actVioClaNm" />                                                                                                                                                     ');
	spHtml.append('	   			</li>                                                                                   ');	
	spHtml.append('	   		</ul>                                                                                       ');	
	spHtml.append('	   	</div>                                                                                          ');	
	
	spHtml.append('		 </td>                                                                                                                                                                                                                                        ');
	spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
	
	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C">조회</th>                                                                                                                                                                                                                       ');
	spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                               ');
	spHtml.append('			   <div class="inputbox w40per">                                                                                                                                                                                                           ');
	var spInqCodeHtml = new StringBuffer();
	$.each(data.spInqKndList, function(i, spInq) {
		spInqCodeHtml.append('						<option value="'+spInq.code+'" >'+spInq.codeName+'</option>                                                                                                          ');
	});
	spHtml.append('			   <p class="txt">선택</p>                                                                                                                                                                                                                      ');
	spHtml.append('				   <select id="spInqCd" name="spInqCd">                                                                                                                                                                                                                             ');
	spHtml.append('				   		<option value="">선택</option>							');
	spHtml.append(spInqCodeHtml);
	spHtml.append('				   </select>                                                                                                                                                                                                                            ');
	spHtml.append('			   </div>                                                                                                                                                                                                                                   ');
	spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
	
	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C">체포영장</th>                                                                                                                                                                                                                        ');
	spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
	spHtml.append('			   <label for="cathWrnt_0"></label><input type="text" class="w100per" id="cathWrnt_0" name="cathWrnt" />                                                                                                                                                    ');
	spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C">긴급체포</th>                                                                                                                                                                                                                        ');
	spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
	spHtml.append('			   <label for="emgyCath_0"></label><input type="text" class="w100per" id="emgyCath_0" name="emgyCath" />                                                                                                                                                    ');
	spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C">현행범인체포</th>                                                                                                                                                                                                                        ');
	spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
	spHtml.append('			   <label for="flgtOfdrCath_0"></label><input type="text" class="w100per" id="flgtOfdrCath_0" name="flgtOfdrCath" />                                                                                                                                                    ');
	spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C">구속영장</th>                                                                                                                                                                                                                        ');
	spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
	spHtml.append('			   <label for="arstWrnt_0"></label><input type="text" class="w100per" id="arstWrnt_0" name="arstWrnt" />                                                                                                                                                    ');
	spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
	spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
	spHtml.append('		   <th class="C">인치구금</th>                                                                                                                                                                                                                        ');
	spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
	spHtml.append('			   <label for="inchDetn_0"></label><input type="text" class="w100per" id="inchDetn_0" name="inchDetn" />                                                                                                                                                    ');
	spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
	spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
	
	
	spHtml.append('   </tbody>                                                                                                                                                                                                                                          ');
	spHtml.append('</table>                                                                                                                                                                                                                                             ');
	spHtml.append('</div>                                                                                                                                                                                                                                             ');
	
	spHtml.append('<table class="list" cellpadding="0" cellspacing="0">																					');
	spHtml.append('	<input type="hidden" id="incOccrAreaXcd" name="incOccrAreaXcd" />	');
	spHtml.append('	<input type="hidden" id="incOccrAreaYcd" name="incOccrAreaYcd" />	');
	spHtml.append('	<caption>게시판쓰기</caption>                                                                                                            ');
	spHtml.append('	<colgroup>                                                                                                                          ');
	spHtml.append('		<col width="15%" />                                                                                                             ');
	spHtml.append('		<col width="*%" />                                                                                                              ');
	spHtml.append('	</colgroup>                                                                                                                         ');
	spHtml.append('	<tbody>                                                                                                                             ');
	spHtml.append('		<tr>                                                                                                                            ');
	spHtml.append('			<th class="C first th_line" scope="col" ><span class="table_title">범죄장소</span></th>                                         ');
	spHtml.append('			<td class="L td_line">                                                                                                      ');
	spHtml.append('				<label for="incOccrAreaAddr"></label><input type="text" class="w50per" name="incOccrAreaAddr" id="incOccrAreaAddr"/>                                                                    ');
	spHtml.append('			</td>                                                                                                                       ');
	spHtml.append('		</tr>                                                                                                                            ');
	
	spHtml.append('		<tr>                                                                                                                          ');
	spHtml.append('			<th class="C first th_line" scope="col" ><span class="table_title">범죄일시</span></th>                                         ');
	spHtml.append('			<td class="L td_line">                                                                                                      ');
	spHtml.append('				<label for="criDt"></label><input type="text" class="w100per" name="criDt" id="criDt" value=""/>                                                                    ');
	spHtml.append('			</td>                                                                                                                       ');
	spHtml.append('		</tr>                                                                                                                            ');
	
	
	spHtml.append('		<tr>                                                                                                                          ');
	spHtml.append('			<th class="C">피해자 성명</th>                                         ');
	spHtml.append('			<td class="L">                                                                                                      ');
	spHtml.append('			   <label for="vicmNm"></label><input type="text" class="w100per" id="vicmNm" name="vicmNm" value=""/>                                                                                                                                                    ');
	spHtml.append('			</td>                                                                                                                       ');
	spHtml.append('		</tr>                                                                                                                            ');
	
	spHtml.append('		<tr>                                                                                                                          ');
	spHtml.append('			<th class="C">피해자 피해정도</th>                                         ');
	spHtml.append('			<td class="L">                                                                                                      ');
	spHtml.append('			   <label for="damgDegr"></label><input type="text" class="w100per" id="damgDegr" name="damgDegr" value=""/>                                                                                                                                                    ');
	spHtml.append('			</td>                                                                                                                       ');
	spHtml.append('		</tr>                                                                                                                            ');
	
	spHtml.append('		<tr>                                                                                                                          ');
	spHtml.append('			<th class="C">압수번호</th>                                         ');
	spHtml.append('			<td class="L">                                                                                                      ');
	spHtml.append('			   <label for="seizNum"></label><input type="text" class="w100per" id="seizNum" name="seizNum" value=""/>                                                                                                                                                    ');
	spHtml.append('			</td>                                                                                                                       ');
	spHtml.append('		</tr>                                                                                                                            ');
	
	spHtml.append('		<tr>                                                                                                                          ');
	spHtml.append('			<th class="C">수사미결사건철번호</th>                                         ');
	spHtml.append('			<td class="L">                                                                                                      ');
	spHtml.append('			   <label for="criPendIncFileNum"></label><input type="text" class="w100per" id="criPendIncFileNum" name="criPendIncFileNum" value=""/>                                                                                                                                                    ');
	spHtml.append('			</td>                                                                                                                       ');
	spHtml.append('		</tr>                                                                                                                            ');

	spHtml.append('		<tr>                                                                                                                            ');
	spHtml.append('			<th class="C first th_line" scope="col" ><span class="table_title">사건내용<br>(인지보고서 또는 고발개요)</span></th>                                         ');
	spHtml.append('			<td class="L td_line">                                                                                                      ');
	spHtml.append('				<textarea id="incCont" name="incCont" cols="" rows="" ></textarea>                                                                    ');
	spHtml.append('			</td>                                                                                                                       ');
	spHtml.append('		</tr>                                                                                                                           ');
	
	spHtml.append('	</tbody>                                                                                                                            ');
	spHtml.append('</table>                                                                                                                             ');
	
	spHtml.append('<div class="btnArea" id="criArea02">                                                                                                                                                                                                                                ');
	spHtml.append('   <div class="r_btn" id="btnArea_EditButtons"><a href="javascript:saveIncMast();" class="btn_white"><span>임시저장</span></a><a href="javascript:insertIncMast();" class="btn_blue"><span>사건등록</span></a></div>                                                                                                                     ');
	spHtml.append('</div>                                                                                                                                                                                                                                               ');
	
	spHtml.append('<div class="btnArea" id="apprArea02" style="display:none">');
	
	spHtml.append('<div style="height:100px">																								');
	spHtml.append('	<table class="list" name="apprAreaTable" cellpadding="0" cellspacing="0" data-cri-dta-num="" data-cri-dta-catg-cd="06"> ');
	spHtml.append('		   <colgroup>                                                                                                       ');
	spHtml.append('		   <col width="10%" />                                                                                              ');
	spHtml.append('		   <col width="15%" />                                                                                              ');
	spHtml.append('		   <col width="30%" />                                                                                              ');
	spHtml.append('		   <col width="15%" />                                                                                              ');
	spHtml.append('		   <col width="30%" />                                                                                              ');
	spHtml.append('		   </colgroup>                                                                                                      ');
	spHtml.append('		   <tbody>                                                                                                          ');
	spHtml.append('			   <tr>                                                                                                         ');
	spHtml.append('				   <th class="C line_right" rowspan="2">등록</th>                                                             ');
	spHtml.append('				   <th class="C">등록요청</th>                                                                                  ');
	spHtml.append('				   <td class="L" colspan="3" id="taskNmTD">		                                                            ');   
	spHtml.append('				   </td>                                                                                                    ');
	spHtml.append('			   </tr>		                                                       	                                        ');              
	spHtml.append('			   <tr>                                                                                                         ');
	spHtml.append('				   <th class="C">등록의견</th>                                                                                  ');
	spHtml.append('				   <td class="L" colspan="3">                                                                               ');
	spHtml.append('					   <label for="txt_05"></label><input type="text" class="w100per" id="taskComn" name="taskComn" />      ');
	spHtml.append('				   </td>                                                                                                    ');
	spHtml.append('			   </tr>	                                                                                                    ');
	spHtml.append('		   </tbody>                                                                                                         ');
	spHtml.append('	</table>                                                                                                                ');
	spHtml.append('</div>                                                                                                                   ');
	
	spHtml.append('		<div class="r_btn" id="apprArea_EditButtons"></div>');
	spHtml.append('</div>   ');
	
	
	$("#tab_mini_m1_contents").html(spHtml.toString());	
	
	//첫번째 '사건정보' 탭 활성화 (클릭)
	$('.tab_mini_wrap').find('>ul>li>a:eq(0)').click();
	
	
	
	//피의자 이벤트 바인딩
	eventSpSetup();
	
	//페이지 이벤트 바인딩
	eventSetup();
	
	//selct 퍼블 이벤트 바인딩
	setDefaultEvent();
	
	//사건 이벤트 바인딩
	eventIncSetup();
	
	//피의자 버튼 컨트롤
	spBtnControl();
	
	//유저와 상태에 따른 버튼 활성화 처리
	handleBtn();
	
	//유저와 상태에 따른 UI 처리 
	handleUi();
	
	//유저와 상태에 따른 탭 활성화 처리
	handleTab();
	
	//화면사이즈 갱신
	autoResize();
	
	//달력이벤트
	$(".datepicker").datepicker({
		  dateFormat: "yy-mm-dd" ,
		  changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
		  changeYear: true,
		  showButtonPanel: true,
		  currentText: '오늘 날짜'
	});
	
}

//피의자, 법률 버튼 컨트롤
function spBtnControl(){
	//1. 피의자 버튼 컨트롤 
	//		1) 피의자가 1명일경우, "-", "아래이동", "위로이동" 버튼은 비활성화
	if($("div[data-name=personinfo]:visible").length < 2){
		
		$("a[name=sp_sub_btn]").removeAttr("onclick");
		$("a[name=sp_up_btn]").removeAttr("onclick");
		$("a[name=sp_down_btn]").removeAttr("onclick");
		
		//이미지 변경하기
//		$("a[name=sp_sub_btn] img").attr("src", "/sjpb/images/minus_disabled_icon.png");
//		$("a[name=sp_up_btn] img").attr("src", "/sjpb/images/Add_disabled_icon.png");
//		$("a[name=sp_down_btn] img").attr("src", "/sjpb/images/delete_disabled_icon.png");
	}else{
		$("a[name=sp_sub_btn]").attr("onclick", "javascript:spSub(this);");
		$("a[name=sp_up_btn]").attr("onclick", "javascript:spUp(this);");
		$("a[name=sp_down_btn]").attr("onclick", "javascript:spDown(this);");
		
		//이미지 변경하기
//		$("a[name=sp_sub_btn] img").attr("src", "/sjpb/images/minus_icon.png");
//		$("a[name=sp_up_btn] img").attr("src", "/sjpb/images/Add_icon.png");
//		$("a[name=sp_down_btn] img").attr("src", "/sjpb/images/delete_icon.png");
	}
	
	//2) 첫번째 피의자는 위로이동 버튼 비활성화
	$("a[name=sp_up_btn]:first").removeAttr("onclick");
//	$("a[name=sp_up_btn]:first img").attr("src", "/sjpb/images/Add_disabled_icon.png");
	
	//3) 마지막 피의자는 아래이동 버튼 비활성화
	$("a[name=sp_down_btn]:visible:last").removeAttr("onclick");
//	$("a[name=sp_down_btn]:last img").attr("src", "/sjpb/images/Add_disabled_icon.png");
	
	
	//2. 법률 버튼 컨트롤
	//	1) 법률이 1개일경우, "-", "아래이동", "위로이동" 버튼은 비활성화
	$("div[data-name=personinfo]:visible").each(function(){
		
		if($(this).find(".law:visible").length < 2){
			
			$(this).find("a[name=law_sub_btn]").removeAttr("onclick");
			$(this).find("a[name=law_up_btn]").removeAttr("onclick");
			$(this).find("a[name=law_down_btn]").removeAttr("onclick");
			
			//이미지 변경하기
//			$(this).find("a[name=law_sub_btn] img").attr("src", "/sjpb/images/minus_disabled_icon.png");
//			$(this).find("a[name=law_up_btn] img").attr("src", "/sjpb/images/Add_disabled_icon.png");
//			$(this).find("a[name=law_down_btn] img").attr("src", "/sjpb/images/delete_disabled_icon.png");
		}else{
			
			$(this).find("a[name=law_sub_btn]").attr("onclick", "javascript:spSub(this);");
			$(this).find("a[name=law_up_btn]").attr("onclick", "javascript:spUp(this);");
			$(this).find("a[name=law_down_btn]").attr("onclick", "javascript:spDown(this);");
			
			//이미지 변경하기
//			$(this).find("a[name=law_sub_btn] img").attr("src", "/sjpb/images/minus_icon.png");
//			$(this).find("a[name=law_up_btn] img").attr("src", "/sjpb/images/Add_icon.png");
//			$(this).find("a[name=law_down_btn] img").attr("src", "/sjpb/images/delete_icon.png");
		}
		
		//2) 첫번째 법률은 위로이동 버튼 비활성화
		$(this).find("a[name=law_up_btn]:first").removeAttr("onclick");
//		$(this).find("a[name=law_up_btn]:first img").attr("src", "/sjpb/images/Add_disabled_icon.png");
		
		//3) 마지막 법률은 아래이동 버튼 비활성화
		$(this).find("a[name=law_down_btn]:visible:last").removeAttr("onclick");
//		$(this).find("a[name=law_down_btn]:last img").attr("src", "/sjpb/images/Add_disabled_icon.png");
		
	});
	
}


//피의자, 법률정보를 추가한다. 
function spAdd(obj){
	//선택한 피의자 영역을 잡고
	var targetObj = $(obj).closest(".btnArea").parent("div");
	
	//clone 복사시 select박스의 selectd값이 없어지는것 방지 
	//targetObj.find("select option:selected").attr("selected","selected");
	//targetObj.find("select option:selected").prop("selected",true);
	
	var cloneObj = targetObj.clone(true);
	
	//대상 Div의 data-name
	var cloneObjName = cloneObj.data("name");
	
	//법률정보 1개만 남기기 
//	if(cloneObjName == 'personinfo'){
//		cloneObj.find("div[data-name=law]").each(function(index){
//			if(index > 0){
//				$(this).remove();
//			}
//		});
//	}
	
	//input, 성별 값 초기화
	cloneObj.find("input[type=hidden]").val("");
	
	cloneObj.find("span[name=gendDivSpan]").html("");
	
	//cloneObj updateCd 'C'(생성) 으로 셋팅
	cloneObj.find("input[name=updateCd]").val("C");
	
	//select값 초기화
	//1. 법률정보 추가일 경우에는 모든 필드 초기화함 
	if(cloneObjName == "law"){
		cloneObj.find("input[type=text]").val("");
		cloneObj.find("select").each(function(){
			var self = $(this);
			//첫번째 option 선택
			$(this).val("");
//			self.find("option").prop("selected", false);
//			self.find("option:eq(0)").prop("selected", true);
			//self.find("option").removeAttr("selected");
			//self.find("option:eq(0)").attr("selected", "selected");
			self.prev(".txt").text(self.find('option:selected').text());
		});
	
	//2. 피의자정보 추가일 경우에는 법률정보 필드는 초기화하지않음 	
	}else{
		cloneObj.find("input[type=text]:not([name=vioCont], [name=actVioClaNm])").val("");

		cloneObj.find("select").each(function(){
			var self = $(this);
			var targetName = $(this).attr("name");
			
			if(targetName == "rltActCriNmCd"){
				//기존값 유지
				
				var prevTxt = self.prev(".txt").text();
				var selfVal = "";
				self.find("option").each(function(){
					if($(this).html() == prevTxt){
						selfVal = $(this).val();
						return false;
					}
				});
				
				$(this).val(selfVal);
				
				//self.find("option[value="+self.val()+"]").prop("selected", true);
				//self.find("option:eq(0)").prop("selected", true);
				//self.find("option[value="+self.val()+"]").prop("selected", true);
			}else{
				//첫번째 option 선택
				$(this).val("");
//				self.find("option").prop("selected", false);
//				self.find("option:eq(0)").prop("selected", true);
//				self.find("option").removeAttr("selected");
//				self.find("option:eq(0)").attr("selected", "selected");
				
			}
			self.prev(".txt").text(self.find('option:selected').text());
		});
		
		//		cloneObj.find("select:not([name=rltActCriNmCd])").each(function(){
//			var self = $(this);
//			
//			//첫번째 option 선택
//			self.find("option:eq(0)").prop("selected", true);
//			self.prev(".txt").text(self.find('option:selected').text());
//		});
		
		
	}
	
	//radio 필드 name +"_"+피의자수 , 유니크하기 위해서
	cloneObj.find("input[type=radio]").each(function(){
		var oldName = $(this).attr("name");
		var newName = oldName+"_"+$("div[data-name=personinfo]").length;

		$(this).attr("name", newName);
	});
	
	//label, id 필드 +"_" , 유니크하기 위해서
	cloneObj.find("label").each(function(){
		var oldId = $(this).attr("for");
		var newId = oldId+"_"+$("div[data-name=personinfo]").length;
		
		$(this).attr("for", newId);
		$(this).parent().find("input[id="+oldId+"]").attr("id", newId);
	});
	
	//선택한 피의자 영역 뒤에 붙인다.
	targetObj.after(cloneObj);
	
	//피의자 이벤트 바인딩
	eventSpSetup(cloneObj.index());
	alert("피의자가 추가되었습니다.");
	//selct 퍼블 이벤트 바인딩
//	setDefaultEvent();
	
	//피의자 버튼 컨트롤
	spBtnControl();
	
	//화면사이즈 갱신
	autoResize();
}

//피의자, 법률정보를 삭제한다.
function spSub(obj){
	//선택한 피의자 영역을 잡고
	var targetObj = $(obj).closest(".btnArea").parent("div");
	
	//대상 Div의 data-name
	var targetObjName = $(obj).closest(".btnArea").parent("div").data("name");
	
	//삭제한다.
	if(confirm("삭제하시겠습니까?") == true){
		//targetObj.remove();
		
		//1. hide 시킨다. 
		targetObj.hide();
		//2. updateCd 값을 'D'로 셋팅한다. (피의자, 법률을 같이 사용하기 위해 targetObj바로 밑의 'updateCd'를 찾는다.)  
		targetObj.find("input[name=updateCd]:eq(0)").val("D");
		//3. 필수값을 해제한다. 
		targetObj.find("input[data-type]").data("optional-value",true)
		//4. 맨 마지막으로 이동시킨다. 
		targetObj.parent().find("div[data-name="+targetObjName+"]:last").after(targetObj);
		
	}else{
		return;
	}
	
	//피의자 버튼 컨트롤
	spBtnControl();
	
	//화면사이즈 갱신
	autoResize();
}

//피의자, 법률정보를 위로 이동한다.
function spUp(obj){
	//선택한 피의자 영역을 잡고
	var targetObj = $(obj).closest(".btnArea").parent("div");
	
	targetObj.prev("div").before(targetObj);

	//피의자 버튼 컨트롤
	spBtnControl();
}

//피의자, 법률정보를 아래로 이동한다. 
function spDown(obj){
	//선택한 피의자 영역을 잡고
	var targetObj = $(obj).closest(".btnArea").parent("div");
	
	targetObj.next("div").after(targetObj);
	
	//피의자 버튼 컨트롤
	spBtnControl();
}

//사건을 저장한다.
function saveIncMast(){
	
	//송치관일경우에만, 오픈전에 사건 생성 가능 S 2018.12.05 (property 값 사용함)
	if(!chkIsAllUpdateYn()){
		return;
	}
	//송치관일경우에만, 오픈전에 사건 생성 가능 E 2018.12.05
	
	//유효성 체크
	var chkObjs = $("#tab_mini_m1_contents");
	if(!chkValidate.check(chkObjs, true)) return;
	
	//맵갱신
	syncB0101VOMap();
	
	//접수사건번호셋팅여부
	//b0101VOMap.isSetIncNum = "N";
	//임시저장여부
	b0101VOMap.isSave = "Y";
	
	//생성시 워크플로우번호 
	//b0101VOMap.wfNum = b0101TKMap.wfNum;
	setInitWfNum();
	
	goAjax("/sjpb/B/inquirySp.face", b0101VOMap, function(data){callBackInquirySpSuccess(data, "/sjpb/B/insertIncMast.face", callBackSaveIncMastSuccess)});
	
}

//사건 저장 성공 콜백함수
function callBackSaveIncMastSuccess(data){
	 alert("사건이 저장 되었습니다.");
	 
	//리스트 재조회
	selectList();
}

//사건 생성시, 워크플로우번호 셋팅 
function setInitWfNum(){
	/*
	var fdCd = $("#dvForm").val();
	
	//인지, 워크플로우번호 : 2
	if(fdCd == "01"){	
		b0101VOMap.wfNum = "2";
		b0101VOMap.criStatCd = "21";	//인지 등록작업중
		
	//고소/고발, 워크플로우번호 : 3 
	}else if(fdCd == "02"){	
		b0101VOMap.wfNum = "3";
		b0101VOMap.criStatCd = "31";	//입건 등록작업중
	}
	*/
	
	b0101VOMap.wfNum = "4";
	b0101VOMap.criStatCd = "21";	//수사사건부 등록
	
}

//사건을 등록한다. (ajax)
function insertIncMast(){
	
	//송치관일경우에만, 오픈전에 사건 생성 가능 S 2018.12.05 (property 값 사용함)
	if(!chkIsAllUpdateYn()){
		return;
	}
	//송치관일경우에만, 오픈전에 사건 생성 가능 E 2018.12.05
	
	if(!confirm("사건을 등록하시겠습니까?")){
		return;
	}
		
	

	
	//유효성 체크
	var chkObjs = $("#tab_mini_m1_contents");
	if(!chkValidate.check(chkObjs, true)) return;
	
	//생성시 워크플로우번호 
	setInitWfNum();

	//맵갱신
	syncB0101VOMap();

	//syncB0101TKMap();
	
	//if(b0101VOMap.dvForm == "01"){
	//	if(b0101VOMap.incCont == "" || b0101VOMap.incCont == null){
	//		alert("사건내용(인지보고서 또는 고발개요)을 입력해주세요.");
	//		return;
	//	}
	//}
	
	goAjax("/sjpb/B/inquirySp.face", b0101VOMap, function(data){callBackInquirySpSuccess(data, "/sjpb/B/insertIncMast.face", callBackInsertIncMastSuccess)});
}

//피의자 조회 성공 콜백 함수
function callBackInquirySpSuccess(data, url, callbackFunction){
	
	 //사건 피의자로 등록된 전과가 있음 
	 if(data.result != null && data.result.length > 0){
		 var confirmMessage = new StringBuffer();
		 confirmMessage.append("사건 피의자로 등록 되어있습니다. 진행하시겠습니까? \n");
		 $.each(data.result , function(i, incSpVO) {
			 var spNmDec = Base64.decode(incSpVO.spNm);
			 if(incSpVO.indvCorpDiv == "1"){	//개인
				 confirmMessage.append("[ 성명 : "+spNmDec+" ] ");
				 
			 }else{	//법인
				 confirmMessage.append("[ 법인명 : "+spNmDec+" ] ");
			 }
			 
			 
		 });
		 
		 if(confirm(confirmMessage) == true){
			//사건등록, 수정 진행 
			goAjax(url, b0101VOMap, callbackFunction);
			 
		 }else{
			 //사건등록, 수정 중지.
			return;
		 }
		 
	 }else{
		//사건등록, 수정 진행 
		goAjax(url, b0101VOMap, callbackFunction);
		 
	 }
}
//수정 성공 콜백함수
function callBackUpdateIncMastSuccessExecute(data, callbackFunction){
	
	 
	
	b0101VOMap = data.b0101VO;
	
	
	//console.log(JSON.stringify(data));
	
	/*b0101TKMap.wfNum = b0101VOMap.wfNum;
	b0101TKMap.rcptNum = b0101VOMap.rcptNum;
	b0101TKMap.taskNum = b0101VOMap.taskNum;	
	b0101TKMap.trstStatNm = b0101VOMap.taskTrstVOList[0].trstStatNm;
	b0101TKMap.trstStatNum = b0101VOMap.taskTrstVOList[0].trstStatNum;
	b0101TKMap.taskRespMb = $("#userId").val();
	b0101TKMap.taskComn = $("#taskComn").val();
	b0101TKMap.criStatCd = b0101VOMap.taskTrstVOList[0].criStatCd;
	b0101TKMap.regUserId = $("#userId").val(); 
	b0101TKMap.updUserId = $("#userId").val();	
*/
	 
	executeTask(callbackFunction);
	
}
//사건등록  성공 콜백함수
function callBackInsertIncMastSuccess(data, callbackFunction){
	
	 
	
	b0101VOMap = data.b0101VO;
	
	syncB0101TKMap();
	//console.log(JSON.stringify(data));
	
	/*b0101TKMap.wfNum = b0101VOMap.wfNum;
	b0101TKMap.rcptNum = b0101VOMap.rcptNum;
	b0101TKMap.taskNum = b0101VOMap.taskNum;	
	b0101TKMap.trstStatNm = b0101VOMap.taskTrstVOList[0].trstStatNm;
	b0101TKMap.trstStatNum = b0101VOMap.taskTrstVOList[0].trstStatNum;
	b0101TKMap.taskRespMb = $("#userId").val();
	b0101TKMap.taskComn = $("#taskComn").val();
	b0101TKMap.criStatCd = b0101VOMap.taskTrstVOList[0].criStatCd;
	b0101TKMap.regUserId = $("#userId").val(); 
	b0101TKMap.updUserId = $("#userId").val();	
*/
	 
	executeTask(callbackFunction);
	
}

//워크플로우 상태이행처리
function executeTask(callbackFunction){
	
	goAjax("/sjpb/B/executeTask.face", b0101TKMap, function(data){ callBackexecuteTaskSuccess(data, callbackFunction)});
}

//워크플로우 상태이행처리 콜백처리
function callBackexecuteTaskSuccess(data, callbackFunction) {
	//console.log(JSON.stringify(data));
	alert("정상적으로 처리되었습니다.");
	
	//변경된 상태 저장 
	b0101VOMap.criStatCd = data.criStatCd;
	
	if (typeof callbackFunction == "function") {
		callbackFunction(data);
	}else{
		//리스트 재조회
		selectList();
	}
}


//사건을 병합한다. (ajax)
function combIncMast(){
	
	var qcell = QCELL.getInstance("qcell");
	
	//선택된 ROW의 rcptNum가져오기 
	var b0101VOArray = new Array();
	var trsnCobUserId = "";
	
	for(var i = 0; i < qcell.getColData(0).length; i++){
		if(qcell.getColData(0)[i] == true){
			/*
			//자식사건은 병합 불가능 2018.12.07
			if(qcell.getRowData(i+1).combIncYn == 'Y' && qcell.getRowData(i+1).pareIncNum != qcell.getRowData(i+1).incNum ){
				alert("병합된 자식 사건은 다시 병합 할 수 없습니다.");
				return;
			}
			
			//본인 사건만 병합가능 ,지휘단계일경우 송치관 병합 가
			if($("#userId").val() != qcell.getRowData(i+1).criMbMainUserId ){
				alert("사건병합은 담당수사관만 요청 가능합니다.");
				return;
			}
			
			//수사 단계에서만 병합 가능, [수사착수(40),(50),(51), 지휘부결(54), 재지휘부결(59)]
			if( !(qcell.getRowData(i+1).criStatCd == "40"|| qcell.getRowData(i+1).criStatCd == "50"|| qcell.getRowData(i+1).criStatCd == "51" || qcell.getRowData(i+1).criStatCd == "54" || qcell.getRowData(i+1).criStatCd == "59") ){
				alert("사건병합은 수사중, 지휘결과 '부', 재지휘결과 '부' 대상으로만 가능합니다.");
				return;
			}
			*/
			
			//수현 - 1203

			//본인 사건만 병합가능 
			if($("#userId").val() == qcell.getRowData(i+1).criMbMainUserId){
				//수사 단계에서만 병합 가능, [수사착수(40), 지휘부결(54), 재지휘부결(59)]
				if( !(qcell.getRowData(i+1).criStatCd == "40" || qcell.getRowData(i+1).criStatCd == "54" || qcell.getRowData(i+1).criStatCd == "59") ){
					alert("사건병합은 수사중, 지휘결과 '부', 재지휘결과 '부' 대상으로만 가능합니다.");
					return;
				}
			}else{
				if( SJPBRole.getTrnsrRoleYn() ){ //송치관 사건병합
					if( trsnCobUserId == "" ){ //처음 설정
						trsnCobUserId = qcell.getRowData(i+1).criMbMainUserId;
					}
					if(trsnCobUserId != qcell.getRowData(i+1).criMbMainUserId){
						alert("사건병합은 담당수사관이 동일해야 요청 가능합니다.");
						return;
					}
					//[지휘접수요청(50), 재지휘접수요청(55)]
					if( !(qcell.getRowData(i+1).criStatCd == "50" || qcell.getRowData(i+1).criStatCd == "55")  ){
						alert("송치관 사건병합은 지휘접수요청, 재지휘접수요청 대상으로만 가능합니다.");
						return;
					}
					
				}else{
					alert("사건병합은 담당수사관만 요청 가능합니다.");
					return;
				}
			}
			 
			var b0101VO = new Object();
			b0101VO = qcell.getRowData(i+1);
			
			b0101VOArray.push(b0101VO);
		}
	}
	
	if(b0101VOArray == null || b0101VOArray.length < 2){
		alert("사건을 2개이상 선택해주세요.");
		return;
	}
	
	
	
	
	//병합한다.
	if(confirm("병합하시겠습니까?") == true){
		var reqMap = {
				b0101VOList : b0101VOArray
		}
		
		goAjax("/sjpb/B/combIncMast.face", reqMap, callBackCombIncMastSuccess);
	}else{
		return;
	}
}

//사건 병합 성공 콜백함수
function callBackCombIncMastSuccess(data){
	 alert("사건이 병합 되었습니다.");
	 
	//리스트 재조회
	selectList();
}

//첨부파일 다운 셀표현
function fnData(id, row, col, val, obj){
  var html = '';  
  if(val == ''){
    html = val;
  } else {
    html = '<a href="/sjpb/Z/download.face?fileId='+obj.atchFileId+'" download >'+val+'<a>';
  }

  return html;
}


//수사자료 데이터 표시
function renderDTTable(qcellData, type) {	
	//type 1 : 서식자료 
	//type 2 : 송치자료 
	//type 3 : 수사지휘자료
	
	var sheetId = "";
	var parentId = "";
	
	//서식자료 
	if(type == "1"){
		sheetId = "qcellDT";
		parentId = "sheetDT";
		
	}else if(type == "2"){
		sheetId = "qcellTrfDT";
		parentId = "sheetTrfDT";
		
	}else if(type == "3"){
		sheetId = "qcellIncCmdDT";
		parentId = "sheetIncCmdDT";
		
	}
	
	
	if (qcellData == null) qcellData = [];
	
	//사건 > 서식관리, 삭제 버튼 추가 2018.11.20
	if(type == "1"){
		var QCELLProp = {
		         "parentid" : parentId,
		         "id"		: sheetId,
		         "data"		: {"input" : qcellData},
		         "selectmode": "cell",         
		         "columns"	: [
		         	{width: '25%',	key: 'criDtaCatgDesc',			title: ['서식명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
		         	{width: '25%',	key: 'atchFileNm',				title: ['관련서식 파일명'],	type: "html", options: {html: {data: fnData}},	sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
		         	{width: '20%',	key: 'updUserNm',			title: ['작성자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
		         	{width: '20%',	key: 'updDate',				title: ['작성일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
		         	{width: '10%',	key: '',				title: [''], type: "html", options: {html: {data: fnDeleteData}},		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}
		         	]         
		         , "rowheaders": ["sequence"]	         
		     };
		
	}else{
		var QCELLProp = {
		         "parentid" : parentId,
		         "id"		: sheetId,
		         "data"		: {"input" : qcellData},
		         "selectmode": "cell",         
		         "columns"	: [
		         	{width: '25%',	key: 'criDtaCatgDesc',			title: ['서식명'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
		         	{width: '25%',	key: 'atchFileNm',				title: ['관련서식 파일명'],	type: "html", options: {html: {data: fnData}},	sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
		         	{width: '25%',	key: 'updUserNm',			title: ['작성자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
		         	{width: '25%',	key: 'updDate',				title: ['작성일자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},	         	
		         	]         
		         , "rowheaders": ["sequence"]	         
		     };
		
	}
	 
	     QCELL.create(QCELLProp);
	     qcellDT = QCELL.getInstance(sheetId);
}

//qcell 삭제버튼 그리기 
function fnDeleteData(id, row, col, val, obj){
	
	var html = "";
	
	//본인이 등록한 파일만 삭제 가능 
	if($("#userId").val() == obj.regUserId){
		
		var scriStatCd = isNull(b0101VOMap.criStatCd) ? 30 : Number(b0101VOMap.criStatCd) ;
		//수사상태가 [ 인지>등록작업중(21), 수사착수(40), 지휘부결(54), 재지휘부결(59), 송치부결(74), 재송치부결(79) ] 일 경우에만 수정가능 
		if(scriStatCd == 21 || scriStatCd == 40 || scriStatCd == 54 || scriStatCd == 59 || scriStatCd == 74 || scriStatCd == 79){
			html = "<a href=\"javascript:deleteFileData('"+obj.atchFileId+"')\" >삭제<a>";
			
		//수정 불가능 (수정가능한 상태가 아님)
		}else{
			
		}
		
	}
	
	return html;
}

//파일삭제 
function deleteFileData(atchFileId){
	
	//삭제한다.
	if(confirm("삭제하시겠습니까?") == true){
		//법률위반리스트를 가져온다.
		var reqMap = {
				atchFileId : atchFileId
				,rcptNum : b0101VOMap.rcptNum
			}
		goAjax("/sjpb/Z/deleteFile.face", reqMap, callBackDeleteFileDataSuccess);
		
	}
	
}

//파일삭제 성공 콜백함수 
function callBackDeleteFileDataSuccess(data){
	
	//성공
	if(data.sjpbCriIncDtaFileVO.result == "01"){
		alert("파일이 삭제 되었습니다.");
		
		b0101VOMap.criIncDtaFileVOList = data.criIncDtaFileVOList;
		b0101VOMap.criIncDtaVOList = data.criIncDtaVOList;
		
		//작성서식 목록 새로고침
		renderDTTable(b0101VOMap.criIncDtaFileVOList, "1");
		
	}else{
		alert(data.sjpbCriIncDtaFileVO.errMsg);
		
	}
	
}

//타스크이름 가져오기
function getTaskNm(taskNm) {
	if (taskNm == null) taskNm = "";
	if (taskNm.indexOf(' ') > 0) {
		taskNm = taskNm.substr(0, taskNm.indexOf(' '));
	}  
	return taskNm;
}

//구분 선택에 따른 수사팀 노출
function changeFdCdSc(type, isCriMbReset){
	//type - 0 : 상단 검색 영역의 구분선택 
	//type - 1 : 하단 상세 영역의 구분선택
	//isCriMbReset - true : 구분만 변경하고 담당 수사관은 초기화 하지 않음
	var targetObj ;
	
	if(type == 0){
		targetObj = $("#fdCdSc");
		
	}else {
		targetObj = $("#fdCd");
		
		var criTmNm = $("#fdCd option:selected").attr("data-criTmNm");
		$("#criTmNm").val(criTmNm);
		
		//담당수사관 초기화
		//수사관 -> 사건등록 -> 본인이 속한 팀의 구분이 여러개일 경우, 
		//	구분만 변경하고 담당 수사관은 초기화 하지 않기 위해
		if(isCriMbReset){
			$("#criMbNmKorMain").val("");
			$("#criMbNmKorMain").attr("data-criMbId","");
		}
		
	}
	
	//법률위반리스트를 가져온다.
	var reqMap = {
			fdCd : getFieldValue(targetObj)
		}
	goAjaxDefault("/sjpb/B/getRltActList.face", reqMap, function(data){ callBackGetRltActListSuccess(data, type) });
}

//법률위반리스트 성공 콜백함수
function callBackGetRltActListSuccess(data, type){
	//type - 0 : 상단 검색 영역의 구분선택 
	//type - 1 : 하단 상세 영역의 구분선택
	var targetObj ;
	
	if(type == 0){
		targetObj = $("select[name=rltActCriNmSc]");
		
	}else {
		targetObj = $("select[name=rltActCriNmCd]");
	}
	
	var rltActCriNmCodeHtml = new StringBuffer();
	
	rltActCriNmCodeHtml.append('						<option value="" >선택</option>                                                                                                          ');
	$.each(data.rltActCriNmKndList, function(k, rltActCriNm) {
		rltActCriNmCodeHtml.append('						<option value="'+rltActCriNm.code+'">'+rltActCriNm.codeName+'</option>                                                                                                          ');
	});
	
	targetObj.html(rltActCriNmCodeHtml.toString());
	
	//select값 초기화
	targetObj.each(function(){
		setFieldValue($(this), "");
	});
	
}

//사건이력 조회 탭 선택 
function incMastHistTab(){
	
	goAjax("/sjpb/B/incMastHistList.face", b0101VOMap, callBackIncMastHistTabSuccess);
	
}

//사건이력 조회 탭 선택 성공함수 
function callBackIncMastHistTabSuccess(data){
	var QCELLProp = {
            "parentid" : "sheetHist",
            "id"		: "qcellHist",
            "data"		: {"input" : data.qCellHist},
            "selectmode": "row",
            "columns"	: [
            	{width: '15%',	key: 'updDate',			title: ['수정일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '15%',	key: 'updUserIdNm',		title: ['수정자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '20%',	key: 'mfCdDesc',			title: ['수정내용'], 	type: "html", options: {html: {data: fnMfCdDescData}},		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
            	{width: '50%',	key: 'mfCont',				title: ['상세내용'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}
            	],
			//"rowheader"	: "sequence",
			"frozencols" : 3
        };
        QCELL.create(QCELLProp);
        qcellHist = QCELL.getInstance("qcellHist");
	
}

function fnMfCdDescData(id, row, col, val, obj){
	var html = "";
	
	var mfCdTmp = "";
	if(!isNull(obj.mfCd)){
		mfCdTmp = obj.mfCd;
	}
	
	//피의자정보일경우, 비교화면 a태그 넣기   
	if(mfCdTmp.indexOf("02") != -1){
		html = "<a href=\"javascript:compareIncHist('"+obj.rcptNum+"','"+obj.incMfNum+"')\" >"+obj.mfCdDesc+"<a>";
	}else{
		html = obj.mfCdDesc;
	}
	
	return html;
}

function compareIncHist(rcptNum,incMfNum){
	
	var spHistForm = document.spHistPopForm;
	
	var url = "/sjpb/B/popup/B0302.face";
	
	window.open("", "spHistForm", "width=1200, height=800, toolbar=no, menubar=no, scrollbars=yes, resizable=yes" );
	
	$("#rcptNum").val(rcptNum);	//사건수정번호 셋팅
	$("#incMfNum").val(incMfNum);	//사건수정번호 셋팅 
	
	spHistForm.action = url;
	spHistForm.method = "post";
	spHistForm.target = "spHistForm";
	spHistForm.submit();
}

//피의자 그리기 
function renderSpHtml(data, incSpVOList, subSpTitle){
	
	var spHtml = new StringBuffer();
	
	var b0101VOMapTmp = data.b0101VO;
	
	//피의자
	var spNum = 0;
	$.each(incSpVOList, function(i, incSpVO) {
		
		var spIdNumDec =  Base64.decode(incSpVO.spIdNum);
		var spNmDec = Base64.decode(incSpVO.spNm);
		var spAddrDec = Base64.decode(incSpVO.spAddr);
		var spCnttNumDec = Base64.decode(incSpVO.spCnttNum);
		var spJobDec = Base64.decode(incSpVO.spJob);
		var spBsnsNmDec = Base64.decode(incSpVO.spBsnsNm);
		
		spNum++;
		
		spHtml.append('<div class="personinfo" data-name="personinfo">                     ');
		
		spHtml.append('<div class="btnArea">                                                                                                                                                                                                                                ');
		spHtml.append('	<div class="r_btn" name="spBtnArea">                                                                                                                                                                                                                                  ');
		
		//사건번호가 생성되면, 피의자 추가 삭제는 안됨 
		var scriStatCd = isNull(b0101VOMapTmp.criStatCd) ? 0 : Number(b0101VOMapTmp.criStatCd) ;
		
		
		
	
		//수사중 상태 이후에는 피의자 추가 삭제 노출 안함 
		if(scriStatCd < 40 || ( scriStatCd <= 52 && IS_ALL_UPDATE_YN == "Y" && SJPBRole.getRoleMastYn() )){
			spHtml.append('	   <a name="sp_add_btn" onclick="javascript:spAdd(this);" href="javascript:void(0);"><img src="/sjpb/images/plus_icon.png" alt="더하기버튼" /></a>                                                                                                                                           ');
			spHtml.append('	   <a name="sp_sub_btn" onclick="javascript:spSub(this);" href="javascript:void(0);"><img src="/sjpb/images/minus_icon.png" alt="빼기버튼" /></a>                                                                                                                                           ');
		}
		
		spHtml.append('	   <a name="sp_up_btn" onclick="javascript:spUp(this);" href="javascript:void(0);"><img src="/sjpb/images/Add_icon.png" alt="올리기버튼" /></a>                                                                                                                                            ');
		spHtml.append('	   <a name="sp_down_btn" onclick="javascript:spDown(this);" href="javascript:void(0);"><img src="/sjpb/images/delete_icon.png" alt="내리기버튼" /></a>                                        ');
		spHtml.append('   </div>                                                                                                                                    ');
		spHtml.append('</div>																																							');
		
		spHtml.append('<table name="grid-table-sp" class="list" cellpadding="0" cellspacing="0">                                                                                                                                                                                                 ');
		
		spHtml.append('	<input type="hidden" name="spIdNum" value="'+spIdNumDec+'" />  ');
		spHtml.append('	<input type="hidden" name="gendDiv" value="'+incSpVO.gendDiv+'" />  ');
		spHtml.append('	<input type="hidden" name="spNm" value="'+spNmDec+'" />  ');
		spHtml.append('	<input type="hidden" name="rcptNum" value="'+incSpVO.rcptNum+'" />  ');
		spHtml.append('	<input type="hidden" name="updateCd" value="U" />   ');
		spHtml.append('	<input type="hidden" name="h_incSpNum" value="'+incSpVO.incSpNum+'" />   ');
		
		spHtml.append('   <colgroup>                                                                                                                                                                                                                                        ');
		spHtml.append('   <col width="8%" />                                                                                                                                                                                                                               ');
		spHtml.append('   <col width="13%" />                                                                                                                                                                                                                               ');
		spHtml.append('   <col width="35%" />                                                                                                                                                                                                                               ');
		spHtml.append('   <col width="13%" />                                                                                                                                                                                                                               ');
		spHtml.append('   <col width="35%" />                                                                                                                                                                                                                               ');
		spHtml.append('   </colgroup>                                                                                                                                                                                                                                       ');
		spHtml.append('   <tbody>                                                                                                                                                                                                                                           ');
		spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		
		var subSpTitleTmp = "";
		if(!isNull(subSpTitle)){
			subSpTitleTmp = subSpTitle + "<br/>";
		}
		
		spHtml.append('		   <th class="C line_right" rowspan="15"> '+subSpTitleTmp+' 피의자<br/>정보                                                                                                                                                                                             ');
		//피의자 정보 수정 프로세스 추가 2012.12.15
		//spHtml.append('				<br/><input type="button" name="updateSpVioBtn" value="수정" data-always="y" style="display:none;"/>');
		//spHtml.append('				<br/><a href ="#." class="btn_gray" name="updateSpVioBtn" data-always="y" style="display:none;"><span>수정</span></a>');
		spHtml.append('			</th>');
		
		spHtml.append('		   <th class="C">구분 <em class=\"red\">*</em></th>                                                                                                                                                                                                                        ');
		spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                               ');
		
		//첫번째 엘리먼트 클래스 
		var classTmp = "";
		$.each(data.indvCorpDivKndList, function(j, indvCorpDiv) {
			
			//첫번째 엘리먼트 클래스 
			classTmp = "";
			if(j == 0){
				classTmp = " radio_first";
			}
			
			spHtml.append('			   <input id="indvCorpDiv_'+countSp+'_'+i+'_'+j+'" name="indvCorpDiv_'+countSp+'_'+i+'" data-name="indvCorpDiv" type="radio" class="radio_pd'+classTmp+'" value="'+indvCorpDiv.code+'" '+(incSpVO.indvCorpDiv == indvCorpDiv.code ? "checked=\"checked\"":"" )+' /><label for="indvCorpDiv_'+countSp+'_'+i+'_'+j+'">'+indvCorpDiv.codeName+'</label>                                                                                                               ');
		});
		
		spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		spHtml.append('	   </tr>                                                                                                                                                                                                                                             ');
		spHtml.append('	   <tr name="indvTR1">                                                                                                                                                                                                                                             ');
		spHtml.append('		   <th class="C">내 외국인 <em class=\"red\">*</em></th>                                                                                                                                                                                                                     ');
		spHtml.append('		   <td class="L">                                                                                                                                                                                                                               ');
		
		$.each(data.homcForcPernDivKndList, function(j, homcForcPernDiv) {
			
			//첫번째 엘리먼트 클래스 
			classTmp = "";
			if(j == 0){
				classTmp = " radio_first";
			}
			
			spHtml.append('			   <input id="homcForcPernDiv_'+countSp+'_'+i+'_'+j+'" name="homcForcPernDiv_'+countSp+'_'+i+'" data-name="homcForcPernDiv" type="radio" class="radio_pd'+classTmp+'" value="'+homcForcPernDiv.code+'" '+(incSpVO.homcForcPernDiv == homcForcPernDiv.code ? "checked=\"checked\"":"")+'/><label for="homcForcPernDiv_'+countSp+'_'+i+'_'+j+'">'+homcForcPernDiv.codeName+'</label>                                                                                                          ');
		});
		
		spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		spHtml.append('		   <th class="C">성명 <em class=\"red\">*</em></th>                                                                                                                                                                                                                       ');
		spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
		spHtml.append('			   <label for="spIndvNm_'+countSp+'_'+i+'"></label><input type="text" class="w100per" id="spIndvNm_'+countSp+'_'+i+'" name="spIndvNm" value="'+ spNmDec+'" data-type="name" data-optional-value=false maxlength="20" title="성명"/>                                                                                                                                                    ');
		spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		spHtml.append('	   <tr name="corpTR1">                                                                                                                                                                                                                                             ');
		spHtml.append('		   <th class="C">법인명 <em class=\"red\">*</em></th>                                                                                                                                                                                                                       ');
		spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
		spHtml.append('			   <label for="spCorpNm_'+countSp+'_'+i+'"></label><input type="text" class="w100per" id="spCorpNm_'+countSp+'_'+i+'" name="spCorpNm" value="'+ spNmDec+'" data-type="name" data-optional-value=true maxlength="20" title="법인명" />                                                                                                                                                    ');
		spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		spHtml.append('	   <tr name="indvTR2">                                                                                                                                                                                                                                             ');
		spHtml.append('		   <th class="C"><span name="spIdNumTitle">주민등록번호</span></th>                                                                                                                                                                                                                    ');
		spHtml.append('		   <td class="L">                                                                                                                                                                                                                   ');
		spHtml.append('			   <label for="spIdNumA_'+countSp+'_'+i+'"></label><input type="text" class="w40per" id="spIdNumA_'+countSp+'_'+i+'" name="spIdNumA" value="'+getIdNumA(spIdNumDec)+'" data-type="rnnFront" data-optional-value=true maxlength="6" size="6" title="주민등록번호"/>                                                            ');
		spHtml.append('		   	   ~ <label for="spIdNumB_'+countSp+'_'+i+'"></label><input type="text" class="w47per" id="spIdNumB_'+countSp+'_'+i+'" id="spIdNumB_'+i+'" name="spIdNumB" value="'+getIdNumB(spIdNumDec)+'" data-type="rnnBack" data-optional-value=true maxlength="7" size="7" title="주민등록번호"/>                                                                                                                                                                                                                                        ');
		spHtml.append('		   		&nbsp;<span name=\"gendDivSpan\"></span>                ');
		spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		spHtml.append('		   <th class="C">직업</th>                                                                                                                                                                                                                    ');
		spHtml.append('		   <td class="L">                                                                                                                                                                                                                   ');
		spHtml.append('            <label for="spJob_'+countSp+'_'+i+'"></label><input type="text" class="w100per" name="spJob" id="spJob_'+countSp+'_'+i+'" maxlength="50" value="'+spJobDec+'" />  ');
		spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		spHtml.append('	   <tr name="corpTR2">                                                                                                                                                                                                                                             ');
		spHtml.append('		   <th class="C">법인등록번호</th>                                                                                                                                                                                                                    ');
		spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
		spHtml.append('			   <label for="spCorpIdNumA_'+countSp+'_'+i+'"></label><input type="text" class="w40per" id="spCorpIdNumA_'+countSp+'_'+i+'" name="spCorpIdNumA" value="'+getCorpIdNumA(spIdNumDec)+'" data-type="bizIdFront" title="법인등록번호" maxlength="6" data-optional-value=true  size="6"/>                                                                  ');
		spHtml.append('		       ~ <label for="spCorpIdNumB_'+countSp+'_'+i+'"></label><input type="text" class="w40per" id="spCorpIdNumB_'+countSp+'_'+i+'" name="spCorpIdNumB" value="'+getCorpIdNumB(spIdNumDec)+'" data-type="bizIdBack" title="법인등록번호" maxlength="7" data-optional-value=true  size="7"/>                                                                                    ');
		spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		spHtml.append('		   <th class="C">주소 <em class=\"red\">*</em></th>                                                                                                                                                                                                                        ');
		spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
		spHtml.append('			   <label for="spAddr_'+countSp+'_'+i+'"></label><input type="text" class="w100per" id="spAddr_'+countSp+'_'+i+'" name="spAddr" value="'+spAddrDec+'" data-type="required" title="주소"/>                                                                                                                                                    ');
		spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		spHtml.append('		   <th class="C">연락처</th>                                                                                                                                                                                                                       ');
		spHtml.append('		   <td class="L">                                                                                                                                                                                                                   ');
		spHtml.append('			 <label for="spCnttNumA_'+countSp+'_'+i+'"></label><input type="text" class="w25per" id="spCnttNumA_'+countSp+'_'+i+'" name="spCnttNumA" value="'+getCnttNumA(spCnttNumDec)+'" maxlength="3"/>  ~ <label for="spCnttNumB_'+i+'"></label><input type="text" class="w25per" id="spCnttNumB_'+i+'" name="spCnttNumB" value="'+getCnttNumB(spCnttNumDec)+'" maxlength="4"/> ~ <label for="spCnttNumC_'+i+'"></label><input type="text" class="w25per" id="spCnttNumC_'+i+'" name="spCnttNumC" value="'+getCnttNumC(spCnttNumDec)+'" maxlength="4"/>                                                            ');
		spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		spHtml.append('		   <th class="C">업소명</th>                                                                                                                                                                                                                       ');
		spHtml.append('		   <td class="L">                                                                                                                                                                                                                   ');
		spHtml.append(' 			<label for="spBsnsNm_'+countSp+'_'+i+'"></label><input type="text" class="w100per" name="spBsnsNm" id="spBsnsNm_'+countSp+'_'+i+'" value="'+spBsnsNmDec+'" maxlength="50" />                                                        ');
		spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		
		spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		spHtml.append('	   <td colspan="4" class="L">																			');
		
		//위반법률이 있으면 그리고, 없다면 아래 입력하는 화면을 노출한다. 2018.12.10 수정
		if(incSpVO.actVioVOList != null){
			$.each(incSpVO.actVioVOList, function(j, ActVioVO) {
				spHtml.append('	   	<div class="law" data-name="law">                                                                                   ');
				spHtml.append('			<input type="hidden" name="actVio_incSpNum" value="'+ActVioVO.incSpNum+'" />  ');
				spHtml.append('			<input type="hidden" name="actVio_actVioNum" value="'+ActVioVO.actVioNum+'" />  ');
				spHtml.append('			<input type="hidden" name="updateCd" value="U" />  ');
				spHtml.append('	   		<div class="btnArea">                                                                           ');
				spHtml.append('	   			<div class="r_btn magin_btn_bottom" name="lawBtnArea">                                                        ');
				spHtml.append('	   				<a name="law_add_btn" onclick="javascript:spAdd(this);" href="javascript:void(0);"><img src="/sjpb/images/plus_icon.png" alt="더하기버튼" /></a>                                                                                                                                           ');
				spHtml.append('	   				<a name="law_sub_btn" onclick="javascript:spSub(this);" href="javascript:void(0);"><img src="/sjpb/images/minus_icon.png" alt="빼기버튼" /></a>                                                                                                                                           ');
				spHtml.append('	   				<a name="law_up_btn" onclick="javascript:spUp(this);" href="javascript:void(0);"><img src="/sjpb/images/Add_icon.png" alt="올리기버튼" /></a>                                                                                                                                            ');
				spHtml.append('	   				<a name="law_down_btn" onclick="javascript:spDown(this);" href="javascript:void(0);"><img src="/sjpb/images/delete_icon.png" alt="내리기버튼" /></a>                                                                                                                                         ');
				spHtml.append('	   			</div>                                                                                      ');
				spHtml.append('	   		</div>                                                                                          ');
				spHtml.append('	   		<ul>                                                                                            ');
				spHtml.append('	   			<li><span class="title">위반법률 및 죄명 <em class=\"red\">*</em></span>                                                    ');
				spHtml.append('	   				<div class="inputbox w80per">                                                           ');
				
				var isSetRltActCriNm = false;
				var rltActCriNmCodeName="";
				var rltActCriNmCodeHtml = new StringBuffer();
				
				
				if(isNull(ActVioVO.rltActCriNmCd)){
					rltActCriNmCodeName="선택";
					//rltActCriNmCodeHtml.append('						<option value="" selected="selected">선택</option>                                                                                                          ');
				}
				
				rltActCriNmCodeHtml.append('						<option value="">선택</option>                                                                                                          ');
				$.each(data.rltActCriNmKndList, function(k, rltActCriNm) {
					if(ActVioVO.rltActCriNmCd == rltActCriNm.code){
						rltActCriNmCodeName = rltActCriNm.codeName;
						isSetRltActCriNm = true;
					}
					if(ActVioVO.rltActCriNmCd == rltActCriNm.code){
						
					}
					rltActCriNmCodeHtml.append('						<option value="'+rltActCriNm.code+'" '+(ActVioVO.rltActCriNmCd == rltActCriNm.code ? "selected=\"selected\"":"")+'>'+rltActCriNm.codeName+'</option>                                                                                                          ');
				});
				
				//사건에 해당하는 구분값과 연관되어있는 죄명이 없어서 안보일경우에는 저장된데이터를 보여준다.  
				if(!isSetRltActCriNm){
					rltActCriNmCodeName=ActVioVO.rltActCriNmCdDesc;
					rltActCriNmCodeHtml.append('						<option value="'+ActVioVO.rltActCriNmCd+'" selected="selected">'+ActVioVO.rltActCriNmCdDesc+'</option>                                                                                                          ');
				}
				
				spHtml.append('	   					<p class="txt">'+rltActCriNmCodeName+'</p>                                                                 ');
				spHtml.append('	   					<select name="rltActCriNmCd" data-type="select" data-optional-value="false" title="위반법률 및 죄명" >                                                                            ');
				spHtml.append(rltActCriNmCodeHtml);
				spHtml.append('	   					</select>                                                                           ');
				spHtml.append('	   				</div>                                                                                  ');
				spHtml.append('	   			</li>                                                                                       ');
				spHtml.append('	   			<li><span class="title">위반내용 <em class=\"red\">*</em></span>                                                         ');
				spHtml.append('	   				<label for="vioCont_'+countSp+'_'+i+'_'+j+'"></label><input type="text" class="w80per" id="vioCont_'+countSp+'_'+i+'_'+j+'" name="vioCont" value="'+getParamValue(ActVioVO.vioCont)+'" data-type="name" data-optional-value=false maxlength="40" title="위반내용"/>    ');
				spHtml.append('	   			</li>                                                                                       ');
				spHtml.append('	   			<li><span class="title">위반조항</span>                                                         ');
				
				var actVioClaCount = 0;
				$.each(ActVioVO.actVioClaVOList, function(k, actVioCla) {
					if(k == 0){
						spHtml.append('			   <label for="actVioClaNm_'+countSp+'_'+i+'_'+j+'_'+k+'"></label><input type="text" class="w10per txt_first" id="actVioClaNm_'+countSp+'_'+i+'_'+j+'_'+k+'" name="actVioClaNm" value="'+actVioCla.actVioClaNm+'" />                                                                                                                                           ');
					}else{
						spHtml.append('			   <label for="actVioClaNm_'+countSp+'_'+i+'_'+j+'_'+k+'"></label><input type="text" class="w10per" id="actVioClaNm_'+countSp+'_'+i+'_'+j+'_'+k+'" name="actVioClaNm" value="'+actVioCla.actVioClaNm+'" />                                                                                                                                           ');
					}
					actVioClaCount++;
				});
				
				//최대 6개까지 노출
				for (var k = actVioClaCount; k < 6; k++) {
					if(k == 0){
						spHtml.append('			   <label for="actVioClaNm_'+countSp+'_'+i+'_'+j+'_'+k+'"></label><input type="text" class="w10per txt_first" id="actVioClaNm_'+countSp+'_'+i+'_'+j+'_'+k+'" name="actVioClaNm" />                                                                                                                                          ');
					}else{
						spHtml.append('			   <label for="actVioClaNm_'+countSp+'_'+i+'_'+j+'_'+k+'"></label><input type="text" class="w10per" id="actVioClaNm_'+countSp+'_'+i+'_'+j+'_'+k+'" name="actVioClaNm" />                                                                                                                                         ');	
					}
				}
				
				spHtml.append('	   			</li>                                                                                       ');
				spHtml.append('	   		</ul>                                                                                           ');
				spHtml.append('	   	</div>                                                                                              ');
			});
			
		//사건에 저장된 위반법률이 없다면 입력하는 화면 노출. 2018.12.10 수정
		}else{
			isReLoadActVio = true;
			spHtml.append('	   	<div class="law" data-name="law">																				');	
			spHtml.append('			<input type="hidden" name="actVio_incSpNum" value="" />  ');
			spHtml.append('			<input type="hidden" name="actVio_actVioNum" value="" />  ');
			spHtml.append('			<input type="hidden" name="updateCd" value="C" />  ');
			spHtml.append('	   		<div class="btnArea">                                                                       ');	
			spHtml.append('	   			<div class="r_btn magin_btn_bottom">                                                    ');	
			spHtml.append('	   				<a name="law_add_btn" onclick="javascript:spAdd(this);" href="javascript:void(0);"><img src="/sjpb/images/plus_icon.png" alt="더하기버튼" /></a>                                                                                                                                           ');
			spHtml.append('	   				<a name="law_sub_btn" onclick="javascript:spSub(this);" href="javascript:void(0);"><img src="/sjpb/images/minus_icon.png" alt="빼기버튼" /></a>                                                                                                                                           ');
			spHtml.append('	   				<a name="law_up_btn" onclick="javascript:spUp(this);" href="javascript:void(0);"><img src="/sjpb/images/Add_icon.png" alt="올리기버튼" /></a>                                                                                                                                            ');
			spHtml.append('	   				<a name="law_down_btn" onclick="javascript:spDown(this);" href="javascript:void(0);"><img src="/sjpb/images/delete_icon.png" alt="내리기버튼" /></a>                                                                                                                                         ');
			spHtml.append('	   			</div>                                                                                  ');	
			spHtml.append('	   		</div>                                                                                      ');	
			spHtml.append('	   		<ul>                                                                                        ');	
			spHtml.append('	   			<li><span class="title">위반법률 및 죄명 <em class=\"red\">*</em></span>                                                ');	
			spHtml.append('	   				<div class="inputbox w80per">                                                       ');	
			
			var rltActCriNmCodeHtml = new StringBuffer();
			
			//구분 선택할때 그리는것으로 수정함 
			rltActCriNmCodeHtml.append('						<option value="" >선택 (사건구분을 먼저 선택해주세요.)</option>                                                                                                          ');
			
			spHtml.append('	   					<p class="txt">선택 (사건구분을 먼저 선택해주세요.)</p>                                                             ');	
			spHtml.append('				   <select name="rltActCriNmCd" data-type="select" data-optional-value="false" title="위반법률 및 죄명" >                                                                                                                                                                                                                             ');
			spHtml.append(rltActCriNmCodeHtml);
			spHtml.append('	   					</select>                                                                       ');	
			spHtml.append('	   				</div>                                                                              ');	
			spHtml.append('	   			</li>                                                                                   ');	
			spHtml.append('	   			<li><span class="title">위반내용 <em class=\"red\">*</em></span>                                                     ');	
			spHtml.append('	   				<label for="vioCont_'+countSp+'_0_0"></label><input type="text" class="w80per" id="vioCont_'+countSp+'_0_0" name="vioCont" data-type="required"/>');
			spHtml.append('	   			</li>                                                                                   ');	
			spHtml.append('	   			<li><span class="title">위반조항 <em class=\"red\">*</em></span>                                                     ');	
			spHtml.append('			 		<label for="actVioClaNm_'+countSp+'_0_0_0"></label><input type="text" class="w10per txt_first" id="actVioClaNm_'+countSp+'_0_0_0" name="actVioClaNm" />                                                                                                                                           ');
			spHtml.append('			   		<label for="actVioClaNm_'+countSp+'_0_0_1"></label><input type="text" class="w10per" id="actVioClaNm_'+countSp+'_0_0_1" name="actVioClaNm" />                                                                                                                                                     ');
			spHtml.append('			   		<label for="actVioClaNm_'+countSp+'_0_0_2"></label><input type="text" class="w10per" id="actVioClaNm_'+countSp+'_0_0_2" name="actVioClaNm" />                                                                                                                                                     ');
			spHtml.append('			   		<label for="actVioClaNm_'+countSp+'_0_0_3"></label><input type="text" class="w10per" id="actVioClaNm_'+countSp+'_0_0_3 name="actVioClaNm" />                                                                                                                                                     ');
			spHtml.append('			   		<label for="actVioClaNm_'+countSp+'_0_0_4"></label><input type="text" class="w10per" id="actVioClaNm_'+countSp+'_0_0_4" name="actVioClaNm" />                                                                                                                                                     ');
			spHtml.append('			   		<label for="actVioClaNm_'+countSp+'_0_0_5"></label><input type="text" class="w10per" id="actVioClaNm_'+countSp+'_0_0_5" name="actVioClaNm" />                                                                                                                                                     ');
			spHtml.append('	   			</li>                                                                                   ');	
			spHtml.append('	   		</ul>                                                                                       ');	
			spHtml.append('	   	</div>                                                                                          ');	
			
		}
		
		
		
		spHtml.append('	   	</td>                                                                                                ');
		spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		
		spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		spHtml.append('		   <th class="C">조회</th>                                                                                                                                                                                                                       ');
		spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                               ');
		spHtml.append('			   <div class="inputbox w40per">                                                                                                                                                                                                           ');
		var spInqCodeName="";
		var spInqCodeHtml = new StringBuffer();
		$.each(data.spInqKndList, function(i, spInq) {
			if(incSpVO.spInqCd == spInq.code){
				spInqCodeName = spInq.codeName;
			}
			spInqCodeHtml.append('						<option value="'+spInq.code+'" '+(incSpVO.spInqCd == spInq.code ? "selected=\"selected\"":"")+'>'+spInq.codeName+'</option>                                                                                                          ');
		});
		spHtml.append('			   <p class="txt">'+spInqCodeName+'</p>                                                                                                                                                                                                                      ');
		spHtml.append('				   <select id="spInqCd_'+countSp+'" name="spInqCd">                                                                                                                                                                                                                             ');
		spHtml.append('				   		<option value="">선택</option>							');
		spHtml.append(spInqCodeHtml);
		spHtml.append('				   </select>                                                                                                                                                                                                                            ');
		spHtml.append('			   </div>                                                                                                                                                                                                                                   ');
		spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		
		spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		spHtml.append('		   <th class="C">체포영장</th>                                                                                                                                                                                                                        ');
		spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
		spHtml.append('			   <label for="cathWrnt_'+countSp+'_0"></label><input type="text" class="w100per" id="cathWrnt_'+countSp+'_0" name="cathWrnt" value="'+incSpVO.cathWrnt+'"/>                                                                                                                                                    ');
		spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		spHtml.append('		   <th class="C">긴급체포</th>                                                                                                                                                                                                                        ');
		spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
		spHtml.append('			   <label for="emgyCath_'+countSp+'_0"></label><input type="text" class="w100per" id="emgyCath_'+countSp+'_0" name="emgyCath" value="'+incSpVO.emgyCath+'"/>                                                                                                                                                    ');
		spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		spHtml.append('		   <th class="C">현행범인체포</th>                                                                                                                                                                                                                        ');
		spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
		spHtml.append('			   <label for="flgtOfdrCath_'+countSp+'_0"></label><input type="text" class="w100per" id="flgtOfdrCath_'+countSp+'_0" name="flgtOfdrCath" value="'+incSpVO.flgtOfdrCath+'"/>                                                                                                                                                    ');
		spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		spHtml.append('		   <th class="C">구속영장</th>                                                                                                                                                                                                                        ');
		spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
		spHtml.append('			   <label for="arstWrnt_'+countSp+'_0"></label><input type="text" class="w100per" id="arstWrnt_'+countSp+'_0" name="arstWrnt" value="'+incSpVO.arstWrnt+'"/>                                                                                                                                                    ');
		spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		spHtml.append('	   <tr>                                                                                                                                                                                                                                             ');
		spHtml.append('		   <th class="C">인치구금</th>                                                                                                                                                                                                                        ');
		spHtml.append('		   <td class="L" colspan="3">                                                                                                                                                                                                                   ');
		spHtml.append('			   <label for="inchDetn_'+countSp+'_0"></label><input type="text" class="w100per" id="inchDetn_'+countSp+'_0" name="inchDetn" value="'+incSpVO.inchDetn+'"/>                                                                                                                                                    ');
		spHtml.append('		   </td>                                                                                                                                                                                                                                        ');
		spHtml.append('	   </tr>                                                                                                                                                                                                                                            ');
		
		
		spHtml.append('   </tbody>                                                                                                                                                                                                                                          ');
		spHtml.append('</table>                                                                                                                                                                                                                                             ');
		spHtml.append('</div>                                                                                                                                                                                                                                             ');
		
		countSp++;
	});
	
	
	return spHtml;
}




//수사사건자료리스트를 가져온다.
function selectCriIncDtaList(){

	//검색조건
	b0101SCMap.rcptNum = b0101VOMap.rcptNum;
	b0101SCMap.criDtaCatgSC = $('#criDtaCatgSC').val();
	b0101SCMap.criDtaFileNmSC = $('#criDtaFileNmSC').val();
	b0101SCMap.criDtaUsrNmSC = $('#criDtaUsrNmSC').val();  

	goAjax("/sjpb/B/selectCriIncDtaList.face", b0101SCMap, callBackSelectCriIncDtaListSuccess);
	
}

//수사사건자료리스트 콜백함수
function callBackSelectCriIncDtaListSuccess(data) {	
	
	//console.log(JSON.stringify(data));
	renderDTTable(data.qCell, "1");
}

//수사자료 업데이트 2018.12.03 수사기록주석
//function updateCriIncDta() {
//	
//	//맵갱신
//	syncCriIncDtaVOList(b0101VOMap);
//	//syncB0101VOMap();		
//	//console.log(JSON.stringify(b0101VOMap));
//	
//	//유효성 체크
//	//var chkObjs = $("#contentsArea");
//	//if(!chkValidate.check(chkObjs, true)) return;
//	
//	if ( sjpbFile.vaultUploader) {
//		sjpbFile.vaultUploader.attachEvent("onUploadComplete", function (files) {				
//			syncSjpbFileVOList(files);			
//			sjpbFile.isNewFile = false;
//			sjpbFile.isCancel = false;			
//		
//			goAjax("/sjpb/B/updateCriIncDta.face", b0101VOMap, callBackUpdateCriIncDtaSuccess);
//		
//		});		
//		
//		if (sjpbFile.isNewFile) { //업로드 대상이 있는 경우			
//			sjpbFile.vaultUploader.upload();
//		} else {  //업로드 대상이 없는 경우			
//			b0101VOMap.sjpbFileVOList = null;
//			sjpbFile.isCancel = false;
//		} 
//		
//	}
//	
//}
//
////수사자료 업데이트 콜백함수
//function callBackUpdateCriIncDtaSuccess(data) {
//	
//	alert("정상적으로 저장되었습니다.");
//	b0101VOMap = data.b0101VO;
//	fn_init();
//	
//	console.log(JSON.stringify(data));	
//	selectCriIncDtaList();
//	
//}

//문서관리 추가 S 2018.11.19 
function selectDocMngList(){
	
	if( (b0101VOMap.combIncYn == 'Y'&& b0101VOMap.pareIncNum == b0101VOMap.incNum )||b0101VOMap.combIncYn == 'N' ){
		//문서관리 iframe 그리기 
		$("#docMngframe").attr("src", "/sjpb/M/M0101.face");
		
	}else{
		alert("병합된 사건입니다. "+b0101VOMap.pareIncNum+"사건에서 진행가능합니다.");
		$("#docMngframe").attr("src", "/sjpb/M/M0101.face");
//		$("#docMngframe").html("<span>병합된 사건입니다. "+b0101VOMap.pareIncNum+"사건에서 진행가능합니다.</span>");
		
	}
	//초기화
	//$("#docMngframe").contents().find("#docIframe").attr("src","");
}

//문서관리 추가 E 2018.11.19


//Map 데이터 초기화
function initB0101VOMap() {	
	b0101VOMap = {
			rcptNum : ""	       //접수번호
		    ,rcptIncNum : ""     //접수사건번호
			,rcptTpCd : "2"       //접수유형코드
			,criStatCd : ""      //수사상태코드 
			,fdCd : ""           //사건분야코드
			,criTmId : ""        //수사팀계정
			,dvForm : ""         //발각형태
			,beDt : ""           //착수일자
			,edDt : ""           //종결일자
			,pareRcptNum : ""    //부모접수번호	
			,incNum	: ""		//상세사건번호
		    ,chaDt : ""			//입건일자
		    ,chaItt : ""		//고발기관
		    ,incCont : ""		//사건내용
		    ,criCont : ""		//수사내용
		    ,trfNum : ""		//송치번호
		    ,chaIttDesc : ""	//고발기관설명
		    ,dvFormDesc : ""	//발각형태설명
		    ,criTmNm :""		//수사팀명
			,regUserId : ""      //등록자
			,regDate : ""        //등록일자
			,combIncYn : "N"		//병합사건여부
			,infwDiv : ""		//유입구분
			,vicmNm : ""			//피해자이름
		    ,damgDegr : ""			//피해정도
		    ,seizNum : ""			//압수번호
		    ,criPendIncFileNum : ""	//수사미결사건철번호
			,updUserId : ""      //수정자
			,updDate : ""        //수정일자
			,incCriMbVOList : null	//피의자정보
			,incSpVOList : null		//수사관정보	
			,isSave : "N"			//'저장' 여부
			,isNextStep : "N"		//다음단계진행여부(상태값)
			,criIncDtaVOList : null  //수사사건자료
			,criIncDtaFileVOList : null  //수사사건자료파일
			,mfCd : ""		//변경내용
			,mfCont : ""	//변경 상세 내용
		};	
}

function initB0101TKMap(){
	b0101TKMap = {		
			//wfNum : SJPBRole.getTrnsrRoleYn() ? "3" : "2"	//WFID [송치관 : 3, 수사관,과장,팀장 : 2]
			wfNum : ""	//WFID
			,rcptNum : ""	      //접수번호
			,taskNum : ""         //활성타스크번호
			,trstStatNm : ""      //타스크이행명
			,trstStatNum : ""      //타스크이행번호
			,taskRespMb : ""      //타스크소유자	
			,taskComn : ""        //타스크코멘트
			,edDt : ""            //종결일자
			,criStatCd : ""       //수사상태코드
			,regUserId : ""      //등록자
			,updUserId : ""       //수정자		
		}
}

//Map 데이터 초기화
function initAccessMap(){
	accessMap = {
		criLvCd : ""	//접근권한
	}
}

//수사관 데이터 갱신
function syncincCriMbList(paramMap){
	
	//수사관 셋팅 
	var incCriMbVOArray = new Array();
	
	// 1) 메인수사관 1명 (필수)
	var incCriMbVOMain = new Object();
	
	incCriMbVOMain.criMbId = $("input[name=criMbNmKorMain]").attr("data-criMbId");
	incCriMbVOMain.criLvCd = "01";
	
	//혹시나,, 아이디(data-criMbId)가 없을수도 있나?
	if(!isNull(incCriMbVOMain.criMbId)){
		incCriMbVOArray.push(incCriMbVOMain);
	}
	
	// 2) 수사관 n명
	$("#criMbNmKorSubArea li").each(function(i) {
		var incCriMbVOSub = new Object();
		
		incCriMbVOSub.criMbId = $(this).attr("data-criMbId");
		incCriMbVOSub.criLvCd = "02";
			
		incCriMbVOArray.push(incCriMbVOSub);
	});
	
	// 2) 참조수사관 n명
	$("#criMbNmKorRefArea li").each(function(i) {
		var incCriMbVORef = new Object();
		
		incCriMbVORef.criMbId = $(this).attr("data-criMbId");
		incCriMbVORef.criLvCd = "03";
		
		incCriMbVOArray.push(incCriMbVORef);
	});
	
	paramMap.incCriMbVOList = incCriMbVOArray;
	
}

//피의자 데이터 갱신
function syncIncSpVOList(paramMap) {
	
	//피의자정보 셋팅 n명
	//radio 는 data-name 으로 찾는다. 
	var incSpVOArray = new Array();
	$("div[data-name=personinfo]").each(function(i) {
		
		if ($(this).find("input[data-name=indvCorpDiv]:checked").val() == "1") { //개인
			$(this).find("input[name=spIdNum]").val($(this).find("input[name=spIdNumA]").val() + "-" + $(this).find("input[name=spIdNumB]").val());
			$(this).find("input[name=spNm]").val($(this).find("input[name=spIndvNm]").val());
		} else { //법인
			$(this).find("input[name=spIdNum]").val($(this).find("input[name=spCorpIdNumA]").val() + "-" + $(this).find("input[name=spCorpIdNumB]").val());
			$(this).find("input[name=spNm]").val($(this).find("input[name=spCorpNm]").val());
			$(this).find("input[name=gendDiv]").val("");
		}
		
		
		var incSpVO = {
			incSpNum : $(this).find("input[name=h_incSpNum]").val()
			,rcptNum : $(this).find("input[name=rcptNum]").val()
			,spTpCd : "2"
			,spIdNum : Base64.encode($(this).find("input[name=spIdNum]").val())
			,indvCorpDiv : $(this).find("input[data-name=indvCorpDiv]:checked").val()
			,homcForcPernDiv : $(this).find("input[data-name=homcForcPernDiv]:checked").val()
			,gendDiv : $(this).find("input[name=gendDiv]").val()
			,spNm : Base64.encode($(this).find("input[name=spNm]").val())
			,spAddr : Base64.encode($(this).find("input[name=spAddr]").val())
			,spJob : Base64.encode($(this).find("input[name=spJob]").val())
			,spBsnsNm : Base64.encode($(this).find("input[name=spBsnsNm]").val())
			,spCnttNum : Base64.encode($(this).find("input[name=spCnttNumA]").val() + "-" +  $(this).find("input[name=spCnttNumB]").val() + "-" +  $(this).find("input[name=spCnttNumC]").val())
			,inqOrd : i+1
			,updateCd : $(this).find("input[name=updateCd]:eq(0)").val()
			,spInqCd : $(this).find("select[name=spInqCd]").val()
			,cathWrnt : $(this).find("input[name=cathWrnt]").val()
			,emgyCath : $(this).find("input[name=emgyCath]").val()
			,flgtOfdrCath : $(this).find("input[name=flgtOfdrCath]").val()
			,arstWrnt : $(this).find("input[name=arstWrnt]").val()
			,inchDetn : $(this).find("input[name=inchDetn]").val()
		}
		
		//법률정보
		var actVioVOArray = new Array();
		
		$($(this).find(".law")).each(function(j) {
			var ActVioVO = {
					incSpNum : $(this).find("input[name=actVio_incSpNum]").val()		
					,actVioNum : $(this).find("input[name=actVio_actVioNum]").val()		
					,rltActCriNmCd : $(this).find("select[name=rltActCriNmCd]").val()
					,vioCont : $(this).find("input[name=vioCont]").val()
					,inqOrd : j+1
					,updateCd : $(this).find("input[name=updateCd]:eq(0)").val()
			}
			
			//위반조항
			var actVioClaVOArray = new Array();
			
			$(this).find("input[name=actVioClaNm]").each(function(k){
				if(!isNull($(this).val())){
					var ActVioClaVO = {
							inqOrd : k+1
							,actVioClaNm : $(this).val()
					}
					actVioClaVOArray.push(ActVioClaVO);
				}
			});
			
			//위반조항 셋팅
			ActVioVO.actVioClaVOList = actVioClaVOArray;
		
			//법률위반 셋팅
			actVioVOArray.push(ActVioVO);
		});
		
		incSpVO.actVioVOList = actVioVOArray;
		incSpVOArray.push(incSpVO);
	});
	
	paramMap.incSpVOList = incSpVOArray;
}

//Map 데이터 갱신
function syncB0101VOMap() {
	
	//사건정보
	//금감원추가
	//b0101VOMap.dvForm = $("#dvForm").val();		//발각형태  03:검찰이첩
	b0101VOMap.dvForm = $("select[name=dvForm]").val();;		//발각형태  03:검찰이첩
	b0101VOMap.fdCd = "01";			//구분 사건분야 01 :금융
	b0101VOMap.chaItt = "01";		//이첩기관(남부지검)
	b0101VOMap.infwDiv = "10";//유입구분
	//b0101VOMap.criTmId = $("#criTmNm").val();
	b0101VOMap.criTmId = $("#orgCd").val();//금감원 팀배정
	//b0101VOMap.criTmId = $("#fdCd option:selected").attr("data-criTmId");	//수사팀배정
	 
	//금감원추가 컬럼!
	b0101VOMap.poIncNum = $("#poIncNum").val();			//검찰사건번호
	b0101VOMap.beDt = $("#beDt").val();			//착수일시
	b0101VOMap.stock = $("#stock").val();		//종목
	b0101VOMap.proDt = $("#proDt").val();		//처리일시
	b0101VOMap.acptDt = $("#acptDt").val();		//수리일시
	b0101VOMap.dirId = $("#dirId").attr("data-dirId");		//지휘자
	
	b0101VOMap.incOccrAreaAddr = $("#incOccrAreaAddr").val();	//사건발생지역주소
	b0101VOMap.incOccrAreaXcd = $("#incOccrAreaXcd").val();	//사건발생지역X좌표
	b0101VOMap.incOccrAreaYcd = $("#incOccrAreaYcd").val();	//사건발생지역Y좌표
	b0101VOMap.criDt = $("#criDt").val();	//범죄일시
	
	b0101VOMap.vicmNm = $("#vicmNm").val();	//피해자이름
	b0101VOMap.damgDegr = $("#damgDegr").val();	//피해정도
	b0101VOMap.seizNum = $("#seizNum").val();	//압수번호
	b0101VOMap.criPendIncFileNum = $("#criPendIncFileNum").val();	//수사미결사건철번호
	
	b0101VOMap.incCont = $("#incCont").val();	//수사내용
	
	//피의자 수정가능 상태일경우에만 피의자 데이터 담음 2018.12.14 
	b0101VOMap.isSpUpdate = isSpUpdate ? "Y" : "N";	//피의자 수정여부
	if(isSpUpdate){
		syncIncSpVOList(b0101VOMap);
	}
	
	//수사관
	syncincCriMbList(b0101VOMap);
	
	//수사사건자료 2018.12.03 수사기록주석
	//syncCriIncDtaVOList(b0101VOMap);
	
}
function syncB0101TKMap() {
	
	b0101TKMap.wfNum = b0101VOMap.wfNum;
	b0101TKMap.rcptNum = b0101VOMap.rcptNum;
	b0101TKMap.taskNum = b0101VOMap.taskNum;	
	b0101TKMap.trstStatNm = b0101VOMap.taskTrstVOList[0].trstStatNm;
	b0101TKMap.trstStatNum = b0101VOMap.taskTrstVOList[0].trstStatNum;
	b0101TKMap.taskRespMb = $("#userId").val();
	b0101TKMap.taskComn = $("#taskComn").val();
	b0101TKMap.criStatCd = b0101VOMap.taskTrstVOList[0].criStatCd;
	b0101TKMap.regUserId = $("#userId").val(); 
	b0101TKMap.updUserId = $("#userId").val();	
}
//수현1226
function updateSuspendInc(){

	//타스크 기본세팅!
	b0101TKMap.rcptNum = b0101VOMap.rcptNum;
	b0101TKMap.wfNum = b0101VOMap.wfNum;
	
	b0101TKMap.taskRespMb = $("#userId").val();
	b0101TKMap.regUserId = $("#userId").val(); 
	b0101TKMap.updUserId = $("#userId").val();
	
	var wfNum = b0101VOMap.wfNum.toString();
	//사건변경이력 입력 팝업창 노출후, 사건중지
	commonLayerPopup.openLayerPopup('/sjpb/B/B0201.face?updateType=2&wfNum='+wfNum, "800px", "350px", function(data){ callBackB0201EndSuccess(data, executeTask)});	
	
	//상단으로 올림
	parent.fn_scrollTop();
	
}


//사건
var b0101VOMap = {
	rcptNum : ""	       //시스템번호
	,poIncNum : ""		//검찰접수번호
	,rcptOrdNum : ""	//접수번호
    ,rcptIncNum : ""     //접수사건번호
    ,stock : ""			//종목 
	,rcptTpCd : ""       //접수유형코드
	,criStatCd : ""      //수사상태코드
	,fdCd : ""           //사건분야코드
	,criTmId : ""        //수사팀계정
	,dvForm : ""         //발각형태
	,beDt : ""           //착수일자
	,edDt : ""           //종결일자
	,dirId : ""			//지휘자
	,dirNm : ""			//지휘자이름
	,acptDt : ""		//수리일자
	,proDt : ""			//처리일자
	,pareRcptNum : ""    //부모접수번호	
    ,incNum	: ""		//상세사건번호
    ,chaDt : ""			//입건일자
    ,chaItt : ""		//고발기관
    ,incCont : ""		//사건내용
    //,criCont : ""		//수사내용
    ,trfNum : ""		//송치번호
    ,chaIttDesc : ""	//고발기관설명
    ,dvFormDesc : ""	//발각형태설명
    ,criTmNm :""		//수사팀명
    ,combIncYn : ""		//병합사건여부
    ,infwDiv : ""		//유입구분
    ,vicmNm : ""			//피해자이름
    ,damgDegr : ""			//피해정도
    ,seizNum : ""			//압수번호
    ,criPendIncFileNum : ""	//수사미결사건철번호
	,regUserId : ""      //등록자
	,regDate : ""        //등록일자
	,updUserId : ""      //수정자
	,updDate : ""        //수정일자	
	//,isSetIncNum : ""		//접수사건번호셋팅여부
	,isSave : ""			//'저장' 여부
	,isNextStep : ""	//다음단계 진행여부
	,criIncDtaVOList : null  //수사사건자료
	,criIncDtaFileVOList : null  //수사사건자료파일
	,mfCd : ""		//변경내용
	,mfCont : ""	//변경 상세 내용
}




//접근정보
var accessMap = {
	criLvCd : ""	//접근권한
}

//타스크
var b0101TKMap = {		
	wfNum : ""				//WFID 
	,rcptNum : ""	      //접수번호
	,taskNum : ""         //활성타스크번호
	,trstStatNm : ""      //타스크이행명
	,trstStatNum : ""      //타스크이행번호
	,taskRespMb : ""      //타스크소유자	
	,taskComn : ""        //타스크코멘트
	,mfCd : ""        	  //변경코드
	,edDt : ""            //종결일자
	,criStatCd : ""       //수사상태코드
	,regUserId : ""      //등록자
	,updUserId : ""       //수정자		
}

//수사자료 검색조건
var b0101SCMap = {		
	rcptNum : "" //접수번호
	,criDtaCatgSC : "" //수사자료분류
	,criDtaFileNmSC : "" //수사자료파일명
	,criDtaUsrNmSC : "" //수사자료작성자
}

//공통스크립트 가져옴
function setDefaultEvent(){
	$('.inputbox').find('select').each(function() {
		var self = $(this),
			parentBox = self.parents('.inputbox'),
			change = function() {
				$(this).prev('.txt').text($(this).find('option:selected').text());
			},
			focusin = function() {
				$(this).parents('.inputbox').addClass('selected');
			},
			focusout = function() {
				$(this).parents('.inputbox').removeClass('selected');
			};

		self.css({

			'height' : parentBox.height() + 'px'
		}).on({
			'change' : change,
			'focusin' : focusin,
			'focusout' : focusout
		});
	}).end().find('.txt').each(function(){
		var self = $(this);
		self.text(self.next('select').find('option:selected').text());
	});
	
}

//수사관 셋팅 콜백함수. 
function callBackSetCriMbSuccess(data, type){
	//type 1 : 담당수사관 콜백
	//type 2 : 수사관 콜백
	//type 3 : 참조수사관 콜백
	//type 4 : 지휘자 콜백
	
	var JsonData = JSON.parse(data);
	
	//기존에 있는 수사관에 추가해서 들어가야함 . 
	//중복제거 로직 추가
	var criMbData = [];
	var isDuplication = false;
	
	//1. 중복체크를 위해 기존 수사관들을 배열에 넣음 (담당, 수사관, 참조수사관 모두) _ 테이블상, 중복으로 들어가면 안됨
	$("input[data-name=criMb], li[data-name=criMb]").each(function(i){
		criMbData.push($(this).attr("data-criMbId"));
	});
	
	//담당수사관
	if(type == "1"){
		
		var userIdTmp = "";
		var userNameTmp = "";
		
		$.each(JsonData.person, function(i, person) {
			//2. 중복체크
			if($.inArray(person.userId, criMbData) == -1){
				//중복체크 완료
				userIdTmp = person.userId;
				userNameTmp = person.userName;
			}else{
				isDuplication = true;
			}
		});
		
		if(isDuplication){
			alert("중복으로 지정하려는 수사관이 있습니다.");
		}
		
		//ID 셋팅 
		$("#criMbNmKorMain").attr("data-crimbid", userIdTmp);
		
		//이름 셋팅 
		$("#criMbNmKorMain").val(userNameTmp);
		
		
	//수사관, 참조수사관 
	}else if(type == "4"){
		//ID 셋팅 
		$("#dirId").attr("data-dirId", JsonData.person[0].userId);
		
		//이름 셋팅 
		$("#dirId").val(JsonData.person[0].userName);
	}else{
		var criMbHtml = new StringBuffer();
		
		var typeStr = "";
		
		//수사관
		if(type == "2"){
			typeStr = "Sub"; 
		}else{
			typeStr = "Ref";
		}
		
		$.each(JsonData.person, function(i, person) {
			//2. 중복체크
			if($.inArray(person.userId, criMbData) == -1){
				//중복체크 완료
				criMbHtml.append('					   <li data-name="criMb" data-criMbId="'+person.userId+'"><span>'+person.userName+'</span><a href="javascript:void(0);" onclick="removeCriMbli(this);" class="list_box_close" data-name="remove"'+typeStr+'"CriMbliBtn" data-always="y"><img src="/sjpb/images/btn_box_close.png" alt="닫기 버튼" /></a></li>                                                                       ');
			}else{
				isDuplication = true;
			}
		});
		
		if(isDuplication){
			alert("중복으로 지정하려는 수사관이 있습니다.");
		}
		
		$("#criMbNmKor"+typeStr+"Area").append(criMbHtml.toString());
	}
	
}

//담당수사관 셋팅 
function setCriMbNmKorMain(){
	commonLayerPopup.openLayerPopup('/sjpb/Z/layerMyPopupList.face?chkType=radio', "700px", "600px", function(data) { callBackSetCriMbSuccess(data, "1")}); //담당수사관
}

//수사관 셋팅 
function setCriMbNmKorSub(){
	commonLayerPopup.openLayerPopup('/sjpb/Z/layerMyPopupList.face?chkType=checkbox', "1000px", "600px", function(data) { callBackSetCriMbSuccess(data, "2")}); // 수사관
}

//참조수사관 셋팅 
function setCriMbNmKorRef(){
	commonLayerPopup.openLayerPopup('/sjpb/Z/layerPopupList.face?chkType=checkbox', "906px", "600px", function(data) { callBackSetCriMbSuccess(data, "3")});	//참조수사관
}

//금감원추가
//지휘자 셋팅 
function setDirId(){
	commonLayerPopup.openLayerPopup('/sjpb/Z/layerMyPopupList.face?chkType=radio', "700px", "600px", function(data) { callBackSetCriMbSuccess(data, "4")}); //지휘자
}
//수사관, 참조수사관 삭제 
function removeCriMbli(obj){
	$(obj).closest("li").remove();
}

function Fn_b_deleteIncMast(rcptNum){
	var map = {
			"rcptNum" : rcptNum
	}
	if(confirm("사건을 삭제하시겠습니까?")){
		goAjaxDefault("/sjpb/B/deleteIncMast.face",map,function(data){callBackFn_b_deleteIncMastSuccess(data)});
	}
	
}
function callBackFn_b_deleteIncMastSuccess(data){
	if(data == '1'){
		alert("사건이 삭제되었습니다.");
		selectList();
	}else{
		alert("사건 삭제에 실패하였습니다.시스템 관리자에게 문의하세요.");
	}
}