$(function(){
	pageInit();
});

var qcell; //내사리스트
var qcellH; //내사이력리스트
var qcellDT; //파일리스트

//화면 진입시 동작함
function pageInit(){
	
	//리스트가져오기
	selectIntiIncList();
	//이벤트바인딩
	eventSetup();
	
	//수사관인 경우
	if (SJPBRole.getInvigtorRoleYn()) {
		$("#criArea01").show();		
		$("#apprArea01").hide();
	} else {
		$("#criArea01").hide();
		$("#apprArea01").show();
	}
	
	//화면사이즈 갱신
	autoResize();
}

//이벤트처리
function eventSetup() {
		
	//신규 버튼 클릭
	$("#newBtn").off("click").on("click", function() {		
		newIntiInc();
	});	
	
	//인쇄 버튼 클릭
	$("#prnBtn").off("click").on("click", function() {		
		prnIntiInc();
	});
	
	//승인이력 탭 클릭
	$("#taskHistTab").on("click", function() {		
		selectIncTaskHist(a0101VOMap.rcptNum);
	});
	
	//서식관리 탭 클릭
	$("#criIncDtaTab").on("click", function() {
		renderDTTable(a0101VOMap.criIncDtaFileVOList);
	});	
		
	//리스트 토글
	$("#toggleCriBtn, #toggleApprBtn").on("click", function() {	
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
		
	//서식관리탭의 내사저장
	$("#fileBtn").off("click").on("click", function() {		
		if ($('#deptTree').jstree(true).get_selected()[0] == undefined) {
			alert("서식종류를 먼저 선택해 주세요!")
			return false;
		}		
		updateCriIncDta();
	});
		
	//서식관리탭의 검색버튼
	$("#srchDTBtn").off("click").on("click", function() {	
		
		selectCriIncDtaList();
	});
	
	//서식관리탭의 초기화버튼
	$("#initDTBtn").off("click").on("click", function() {	
		var searchArea = $("#criIncDtaCatgDiv");		
		//input 값 초기화
		searchArea.find("input[type=text]").val("");
		
		//select 값 초기화
		searchArea.find("select").each(function() {
			$(this).find("option:eq(0)").prop("selected", true);
			$(this).prev('.txt').text($(this).find('option:selected').text());
		});
		
		//검색맵 초기화
		a0102SCMap = {				
			rcptNum : "" //사건번호
			,criDtaCatgSC : "" //수사자료분류
			,criDtaFileNmSC : "" //수사자료파일명
			,criDtaUsrNmSC : "" //수사자료작성자
		}	
	});	
	
}

//신규
function newIntiInc() {
	
	//신규등록화면
	newIntiIncSetup(true);
			
	//수사관이고 등록작업중(13) 또는 내사작업중(10)인 경우
	if (SJPBRole.getInvigtorRoleYn() && (a0101VOMap.criStatCd == "10" || a0101VOMap.criStatCd == "13")) {
		
		$("#btnArea_EditButtons").html(handleBtnGroup(true));
		$("#btnArea_EditButtons a:last").attr("class", "btn_blue");
		$("#criArea02").show();
		$("#apprArea02").hide();
		
		//사건저장
		$("#saveBtn").off("click").on("click", function() {
			insertIntiInc();
		});
		
		//사건저장및등록요청
		$("#saveNRegBtn").off("click").on("click", function() {
			insertNRegIntiInc();
		});		
		
	}
	//화면사이즈 갱신
	autoResize();
}

//출력
function prnIntiInc() {
	selectIntiIncReport();
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
	
	//검색맵 초기화
	a0101SCMap = {
			criTmIdSC : ""       //담당수사팀
			,nmKorSC : ""         //담당수사관
			,beDtFromSC : ""      //착수일자(From)
			,beDtToSC : ""        //착수일자(To)
			,criStatSC : ""       //내사상태	
	}	
}

//이벤트 내사자 영역 세팅
function eventSpSetup() {
	
	$("table[name=incSptable]").each (function (index) {
		
		var tableIndex = $(this).data("table-index");

		//개인 법인 변경
	    $("input[name=indvCorpDiv"+tableIndex+"]").on("click, change", function() {
	    	
	    	if ($("input[name=indvCorpDiv"+tableIndex+"]:checked").val() == "1") {   //개인
	    		$("#incSptable"+tableIndex).find("span[name=spNmTitle]").html("성명");      		
	    		$("#incSptable"+tableIndex).find("tr[name=homcForcPernDiv"+tableIndex+"TR]").show();
	    		
	    		if ($("input[name=homcForcPernDiv"+tableIndex+"]:checked").val() == "1") {  //내국인
		    		$("#incSptable"+tableIndex).find("span[name=spIdNumTitle]").html("주민등록번호");
		    	} else {  //외국인
		    		$("#incSptable"+tableIndex).find("span[name=spIdNumTitle]").html("외국인등록번호");
		    	}
	    		
	    		$("#incSptable"+tableIndex).find("input[name=spIdNumA]").attr("data-type","rnnFront");
	    		$("#incSptable"+tableIndex).find("input[name=spIdNumB]").attr("data-type","rnnBack");
	    		
	    		$("#incSptable"+tableIndex).find("input[name=spCorpIdNumA]").attr("data-type","");
	    		$("#incSptable"+tableIndex).find("input[name=spCorpIdNumB]").attr("data-type","");
	    		
	    		$("#incSptable"+tableIndex).find("tr[name=indvTR1]").show();
	    		$("#incSptable"+tableIndex).find("tr[name=corpTR1]").hide();
	    		$("#incSptable"+tableIndex).find("tr[name=indvTR2]").show();
	    		$("#incSptable"+tableIndex).find("tr[name=corpTR2]").hide();	
	    		
	    		$("#incSptable"+tableIndex).find("input[name=spIndvNm]").data("optional-value",false);
	    		$("#incSptable"+tableIndex).find("input[name=spCorpNm]").data("optional-value",true);	    		
	    		
	    	} else {  //법인
	    		$("#incSptable"+tableIndex).find("span[name=spNmTitle]").html("법인명");
	    		$("#incSptable"+tableIndex).find("tr[name=homcForcPernDiv"+tableIndex+"TR]").hide();
	    		
	    		$("#incSptable"+tableIndex).find("tr[name=indvTR1]").hide();
	    		$("#incSptable"+tableIndex).find("tr[name=corpTR1]").show();
	    		$("#incSptable"+tableIndex).find("tr[name=indvTR2]").hide();
	    		$("#incSptable"+tableIndex).find("tr[name=corpTR2]").show();	    		
	    		
	    		$("#incSptable"+tableIndex).find("input[name=spCorpIdNumA]").attr("data-type","bizIdFront");
	    		$("#incSptable"+tableIndex).find("input[name=spCorpIdNumB]").attr("data-type","bizIdBack");
	    		
	    		$("#incSptable"+tableIndex).find("input[name=spIdNumA]").attr("data-type","");
	    		$("#incSptable"+tableIndex).find("input[name=spIdNumB]").attr("data-type","");
	    			    		
	    		$("#incSptable"+tableIndex).find("input[name=spIndvNm]").data("optional-value",true);
	    		$("#incSptable"+tableIndex).find("input[name=spCorpNm]").data("optional-value",false);
	    		
	    		
	    	}
	    	
		});
	    
	    //내외국인 변경
	    $("input[name=homcForcPernDiv"+tableIndex+"]").on("click, change", function() {	 
	    	
	    	if ($("input[name=homcForcPernDiv"+tableIndex+"]:checked").val() == "1") {  //내국인
	    		$("#incSptable"+tableIndex).find("span[name=spIdNumTitle]").html("주민등록번호");
	    		$("#incSptable"+tableIndex).find("input[name=spIdNumA]").attr("title","주민등록번호");
	    		$("#incSptable"+tableIndex).find("input[name=spIdNumB]").attr("title","주민등록번호");
	    	} else {  //외국인
	    		$("#incSptable"+tableIndex).find("span[name=spIdNumTitle]").html("외국인등록번호");
	    		$("#incSptable"+tableIndex).find("input[name=spIdNumA]").attr("title","외국인등록번호");
	    		$("#incSptable"+tableIndex).find("input[name=spIdNumB]").attr("title","외국인등록번호");
	    	}
	    	
		});
	    
	    
	    $("input[name=indvCorpDiv"+tableIndex+"]").trigger("change");
	    $("input[name=homcForcPernDiv"+tableIndex+"]").trigger("change");
    
	});
	
	
	//주민번호 앞자리 키업 이벤트
	$("input[name=spIdNumA]").on("keyup", function() {
		var idNum = $(this).val();
		if (idNum != "" && idNum.length == 6) {
			$(this).closest("table[name=incSptable]").find("input[name=spIdNumB]").focus();
		}
	}); 	
    
	//주민번호 뒷자리 변경
	$("input[name=spIdNumB]").on("change", function() {	
				
		var idNum = $(this).val();
		if (idNum != "" && !isNaN(idNum)) {
			if (parseInt(idNum.charAt(0))%2 == 1) {
				$(this).closest("table[name=incSptable]").find("input[name=gendDiv]").val("M");	
				$(this).closest("table[name=incSptable]").find("span[name=gendDivSpan]").html("(남)");
			} else {
				$(this).closest("table[name=incSptable]").find("input[name=gendDiv]").val("W");
				$(this).closest("table[name=incSptable]").find("span[name=gendDivSpan]").html("(여)");
			}
		} else {
			$(this).closest("table[name=incSptable]").find("input[name=gendDiv]").val("");	
			$(this).closest("table[name=incSptable]").find("span[name=gendDivSpan]").html("");
		}
	});  
	
	
	//data-type이 숫자, 주민등록번호일 경우에는 숫자만 입력가능하도록 설정 
	$("input[data-type=phone], input[data-type*=rnn], input[data-type=number]").keydown(function(e){
		setKeyDownNum(e);
	});
	
	
	//법인 등록번호 앞자리 키업 이벤트
	$("input[name=spCorpIdNumA]").on("keyup", function() {
		var idNum = $(this).val();
		if (idNum != "" && idNum.length == 6) {
			$(this).closest("table[name=incSptable]").find("input[name=spCorpIdNumB]").focus();
		}
	});
	
	//연락처 앞자리 키업 이벤트
	$("input[name=spCnttNumA]").on("keyup", function() {
		var idNum = $(this).val();
		if (idNum != "" && idNum.length == 3) {
			$(this).closest("table[name=incSptable]").find("input[name=spCnttNumB]").focus();
		}
	});
	
	//연락처 중간자리 키업 이벤트
	$("input[name=spCnttNumB]").on("keyup", function() {
		var idNum = $(this).val();
		if (idNum != "" && idNum.length == 4) {
			$(this).closest("table[name=incSptable]").find("input[name=spCnttNumC]").focus();
		}
	}); 	
	
	$("input[name=spIdNumB]").trigger("change");
		
}



//피내사자 영역 추가버튼
function spAdd(obj) {
	
	if ($(obj).attr("disabled") == "disabled") return;
	
	var recordMax = parseInt($("#incSpContents").data("record-max"))+1;
	$(obj).closest("div[name=incSpDiv]").after(renderIncSpHtml(recordMax, {"incSpNum":"","rcptNum":"","spTpCd":"1","spIdNum":"","indvCorpDiv":"1","homcForcPernDiv":"1","gendDiv":"","spNm":"","spAddr":"","spJob":"","spBsnsNm":"","spCnttNum":"","incSpComn":"","spStatCd":"1","recdType":"I"}));
	$("#incSpContents").data("record-max",recordMax);
	eventSpSetup();
	//화면사이즈 갱신
	autoResize();
}

//피내사자 영역 삭제버튼
function spSub(obj) {
	
	if ($(obj).attr("disabled") == "disabled") return;
	
	if ($("div[name=incSpDiv]").size() > 1) {
		$(obj).closest("div[name=incSpDiv]").attr("data-sp-stat-cd","0").data("sp-stat-cd","0").attr("data-recd-type","D").data("recd-type","D").hide();		
		$(obj).closest("div[name=incSpDiv]").find("input").each(function() {
			$(this).data("optional-value",true);			
		});
		
		
	
	} 
	//화면사이즈 갱신
	autoResize();
} 	

//피내사자 영역 위로 이동 버튼
function spUp(obj) {
	
	if ($(obj).attr("disabled") == "disabled") return;
	
	$(obj).closest("div[name=incSpDiv]").prevAll("div[name=incSpDiv][data-sp-stat-cd=1]:first").before($(obj).closest("div[name=incSpDiv]"));
	
	//화면사이즈 갱신
	autoResize();
} 	

//피내사자 영역 아래로 이동 버튼
function spDown(obj) {
	
	if ($(obj).attr("disabled") == "disabled") return;
	
	$(obj).closest("div[name=incSpDiv]").nextAll("div[name=incSpDiv][data-sp-stat-cd=1]:first").after($(obj).closest("div[name=incSpDiv]"));
	
	//화면사이즈 갱신
	autoResize();
} 	

// 신규내사 등록화면
function newIntiIncSetup(isNew) {	
	
	//데이터맵초기화
	initA0101VOMap();
	//화면갱신
	syncA0101VOPage();
	
	//화면초기화
	if (isNew) {  //신규
		$('#intiNum').html("신규등록");
		$('#criStatDesc').html("신규등록");		
		$("li.m2,li.m3").hide();
		setFieldValue($("select[name=fdCd]"), $("select[name=fdCd] option:first").val());
		$("#incSpContents").html(renderIncSpHtml(1, {"incSpNum":"","rcptNum":"","spTpCd":"1","spIdNum":"","indvCorpDiv":"1","homcForcPernDiv":"1","gendDiv":"","spNm":"","spAddr":"","spJob":"","spBsnsNm":"","spCnttNum":"","incSpComn":""}));
		$("#incSpContents").data("record-max", "1");
		
	} else {
		$("#incSpContents").html("");
	}
	
	freezeInput(false); //입력화면 활성화
	eventSpSetup();
	
	//작성서식목록
	renderDTTable(a0101VOMap.criIncDtaFileVOList);
	
	$("#intiIncTab").trigger('click');
	
	//화면사이즈 갱신
	autoResize();
	
}

//사건관리 화면(리스트)을 가져온다. (ajax)
function selectIntiIncList(){
	
	//최소화 되어 있으면 검색중단
	if(!$('#sheet:visible').length) return;
	
	//검색조건
	a0101SCMap.criTmIdSC = $('#criTmIdSC').val();
	a0101SCMap.nmKorSC = $('#nmKorSC').val();
	if ($('#beDtFromSC').val() != "") {
		a0101SCMap.beDtFromSC = $('#beDtFromSC').val() + " 00:00:00";
	}
	if ($('#beDtToSC').val() != "") {
		a0101SCMap.beDtToSC = $('#beDtToSC').val() + " 23:59:59";
	}
	a0101SCMap.criStatSC = $('#criStatSC').val();  //내사상태
	
	$.ajax({
		 type: "POST",
		 url: "/sjpb/A/selectIntiIncList.face",
		 data : a0101SCMap,
		 datatype : 'json',
		 success: callBackSelectIntiIncListSuccess,
		 error: function( xhr, status, error)	 {
			 alert('서버오류 입니다. 관리자에게 확인하세요. ' + error);
		 }
	});
	
}

//사건관리 리스트 콜백함수
function callBackSelectIntiIncListSuccess(data) {
		
	 var QCELLProp = {
         "parentid" : "sheet",
         "id"		: "qcell",
         "data"		: {"input" : data.qCell},
         "selectmode": "cell",         
         "columns"	: [
         	{width: '10%',	key: 'rcptIncNum',			title: ['내사번호'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
         	{width: '10%',	key: 'beDt',				title: ['착수일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
         	{width: '30%',	key: 'criTmNm',			title: ['담당팀'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
         	{width: '10%',	key: 'nmKor',				title: ['담당수사관'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
         	{width: '30%',	key: 'criStatDesc',				title: ['내사상태'], 		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
         	{width: '10%',	key: 'chaIncNum',				title: ['사건번호'],			sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}
         	]         
         , "rowheaders": ["sequence"]         
     };
     QCELL.create(QCELLProp);
     qcell = QCELL.getInstance("qcell");
     qcell.bind("click", eventFn);
     
     //최초 로딩시
     if (qcell.getRows("data") > 0) {
        //셀 선택 백그라운드 지정
    	qcell.setRowStyle(1, {"background-color" : "#c1c8e8", "border-color" : "#a8b0d4"}, "data");   	 
        a0101VOMap = qcell.getRowData(1);
		a0101VOMap.wfNum = "1";
        selectIntiIncDts();
     } else {	            	
     	newIntiIncSetup(false);  //No Data
     }
}


//리스트 셀 클릭 이벤트 
function eventFn(e){
	
	//선택한 인덱스 가져오기
	var rowIdx = qcell.getIdx("row");
	
	//기존 체크항목 해제와 새로 선택한 행 체크박스 선택
	qcell.removeRowStyle(qcell.getIdx("row","focus","previous") == -1?1:qcell.getIdx("row","focus","previous"));
	qcell.setRowStyle(rowIdx, {"background-color" : "#c1c8e8 ", "border-color" : "#a8b0d4 "}, "data");
	
	//내사상세 호출
	if (rowIdx > 0) {		
		a0101VOMap = qcell.getRowData(rowIdx);
		a0101VOMap.wfNum = "1";
		
		if (a0101VOMap.rcptNum != "") {		
			selectIntiIncDts();
		}
	}

}



//내사상세를 가져온다. 
function selectIntiIncDts(){
	
	goAjax("/sjpb/A/selectIntiIncDts.face", a0101VOMap, callBackSelectIntiIncDtsSuccess);	
	
}



//피의자 영역 HTML 생성
function renderIncSpHtml(index, incSpVO) {
	
	var incSpVOSB = new StringBuffer();
	
	incSpVOSB.append("			<div id=\"incSpDiv"+index+"\" name=\"incSpDiv\" data-sp-stat-cd=\""+incSpVO.spStatCd+"\" data-recd-type=\""+incSpVO.recdType+"\" >  																																			");                                  			
    incSpVOSB.append("               <div class=\"btnArea\">                                                                                                                                        ");
    incSpVOSB.append("               	   <div class=\"r_btn\">                                                                                                                                    ");
    incSpVOSB.append("                       <a href=\"javascript:void(0)\" onclick=\"javascript:spAdd(this);\" ><img src=\"/sjpb/images/plus_icon.png\" alt=\"더하기버튼\" /></a>                                                                             ");
    incSpVOSB.append("                       <a href=\"javascript:void(0)\" onclick=\"javascript:spSub(this);\" ><img src=\"/sjpb/images/minus_icon.png\" alt=\"빼기버튼\" /></a>                                                                             ");
    incSpVOSB.append("                       <a href=\"javascript:void(0)\" onclick=\"javascript:spUp(this);\" ><img src=\"/sjpb/images/Add_icon.png\" alt=\"올리기버튼\" /></a>                                                                              ");
    incSpVOSB.append("                       <a href=\"javascript:void(0)\" onclick=\"javascript:spDown(this);\" ><img src=\"/sjpb/images/delete_icon.png\" alt=\"내리기버튼\" /></a>                                                                           ");
    incSpVOSB.append("                   </div>                                                                                                                                                     ");
    incSpVOSB.append("               </div>		                                                                                                                                                    ");
    incSpVOSB.append("               <table class=\"list\" cellpadding=\"0\" cellspacing=\"0\" id=\"incSptable"+index+"\" name=\"incSptable\" data-inc-sp-num=\""+incSpVO.incSpNum+"\" data-table-index=\""+index+"\">      ");
    incSpVOSB.append("					<input type=\"hidden\" name=\"spTpCd\" value=\""+incSpVO.spTpCd+"\" />  ");
	incSpVOSB.append("					<input type=\"hidden\" name=\"spIdNum\" value=\""+incSpVO.spIdNum+"\" />  ");	
	incSpVOSB.append("					<input type=\"hidden\" name=\"gendDiv\" value=\""+incSpVO.gendDiv+"\" />  ");
	incSpVOSB.append("					<input type=\"hidden\" name=\"inqOrd\" value=\""+incSpVO.inqOrd+"\" />  ");	    
	incSpVOSB.append("					<input type=\"hidden\" name=\"spNm\" value=\""+incSpVO.Spnm+"\" />  ");	
    incSpVOSB.append("                   <colgroup>                                                                                                                                                 ");
    incSpVOSB.append("                   <col width=\"10%\" />                                                                                                                                      ");
    incSpVOSB.append("                   <col width=\"15%\" />                                                                                                                                      ");
    incSpVOSB.append("                   <col width=\"30%\" />                                                                                                                                      ");
    incSpVOSB.append("                   <col width=\"15%\" />                                                                                                                                      ");
    incSpVOSB.append("                   <col width=\"30%\" />                                                                                                                                      ");
    incSpVOSB.append("                   </colgroup>                                                                                                                                                ");
    incSpVOSB.append("                   <tbody>                                                                                                                                                    ");
    incSpVOSB.append("                       <tr>                                                                                                                                                   ");
    incSpVOSB.append("                           <th class=\"C line_right\" rowspan=\"6\">피내사자 정보</th>                                                                                              ");
    incSpVOSB.append("                           <th class=\"C\">구분 <em>*</em></th>                                                                                                                            ");
    incSpVOSB.append("                           <td class=\"L\" colspan=\"3\">                                                                                                                                   ");
    incSpVOSB.append("                               <input type=\"radio\" class=\"radio_pd radio_first\" name=\"indvCorpDiv"+index+"\" id=\"indvCorpDivA"+index+"\" value=\"1\" "+(incSpVO.indvCorpDiv==1?"checked":"")+"/><label for=\"indvCorpDivA"+index+"\">개인</label>                    ");
    incSpVOSB.append("                               <input type=\"radio\" class=\"radio_pd\" name=\"indvCorpDiv"+index+"\" id=\"indvCorpDivB"+index+"\" value=\"2\" "+(incSpVO.indvCorpDiv==2?"checked":"")+"/><label for=\"indvCorpDivB"+index+"\">법인</label>                                ");
    incSpVOSB.append("                           </td>                                                                                                                                              ");
    incSpVOSB.append("                       </tr>                                                                                                                                                  ");    
	incSpVOSB.append("					     <tr name=\"indvTR1\">                                                                                                                                                     ");    
    incSpVOSB.append("                           <th class=\"C\">내 외국인 <em>*</em></th>                                                                                                                         ");
    incSpVOSB.append("                           <td class=\"L\">                                                                                                                                   ");
    incSpVOSB.append("                               <input type=\"radio\" class=\"radio_pd radio_first\" name=\"homcForcPernDiv"+index+"\" id=\"homcForcPernDivA"+index+"\" value=\"1\" "+(incSpVO.homcForcPernDiv==1?"checked":"")+"/><label for=\"homcForcPernDivA"+index+"\">내국인</label>              ");
    incSpVOSB.append("                               <input type=\"radio\" class=\"radio_pd\" name=\"homcForcPernDiv"+index+"\" id=\"homcForcPernDivB"+index+"\" value=\"2\" "+(incSpVO.homcForcPernDiv==2?"checked":"")+"/><label for=\"homcForcPernDivB"+index+"\">외국인</label>                          ");
    incSpVOSB.append("                           </td>                                                                                                                                              ");
    incSpVOSB.append("                           <th class=\"C\">성명 <em>*</em></th>                                                                                                                            ");
    incSpVOSB.append("                           <td class=\"L\" colspan=\"3\">                                                                                                                     ");
    incSpVOSB.append("                               <label for=\"spIndvNm"+index+"\"></label><input type=\"text\" class=\"w100per\" name=\"spIndvNm\" id=\"spIndvNm"+index+"\" data-type=\"name\" data-optional-value=false maxlength=\"20\" title=\"성명\" value=\""+incSpVO.spNm+"\" />                                                          ");
    incSpVOSB.append("                           </td>                                                                                                                                              ");
    incSpVOSB.append("                       </tr>                                                                                                                                                  ");
    incSpVOSB.append("					     <tr name=\"corpTR1\">                                                                                                                                                     ");
    incSpVOSB.append("                           <th class=\"C\">법인명 <em>*</em></th>                                                                                                                            ");
    incSpVOSB.append("                           <td class=\"L\" colspan=\"3\">                                                                                                                     ");
    incSpVOSB.append("                               <label for=\"spCorpNm"+index+"\"></label><input type=\"text\" class=\"w100per\" name=\"spCorpNm\" id=\"spCorpNm"+index+"\" data-type=\"name\" data-optional-value=true maxlength=\"20\" title=\"법인명\" value=\""+incSpVO.spNm+"\" />                                                          ");
    incSpVOSB.append("                           </td>                                                                                                                                              ");
    incSpVOSB.append("                       </tr>                                                                                                                                                  ");    
    incSpVOSB.append("                       <tr name=\"indvTR2\">                                                                                                                                                   ");
    incSpVOSB.append("                           <th class=\"C\"><span name=\"spIdNumTitle\">주민등록번호</span></th>                                                                                                                        ");
    incSpVOSB.append("                           <td class=\"L\">                                                                                                                     ");
    incSpVOSB.append("                               <label for=\"spIdNumA"+index+"\"></label><input type=\"text\" class=\"txt_20per\" name=\"spIdNumA\" id=\"spIdNumA"+index+"\" data-type=\"rnnFront\" value=\""+getIdNumA(incSpVO.spIdNum)+"\" data-optional-value=true maxlength=\"6\" size=\"6\" />       ");
	incSpVOSB.append("								~ <label for=\"spIdNumB"+index+"\"></label><input type=\"text\" class=\"txt_20per\" name=\"spIdNumB\" id=\"spIdNumB"+index+"\" data-type=\"rnnBack\" title=\"주민등록번호\" value=\""+getIdNumB(incSpVO.spIdNum)+"\" data-optional-value=true  maxlength=\"7\" size=\"7\" />          ");
	incSpVOSB.append("								  &nbsp;<span name=\"gendDivSpan\"></span> 		     ");	
    incSpVOSB.append("                           </td>                                                                                                                                              ");
    incSpVOSB.append("                           <th class=\"C\">직업</th>                                                                                                                        ");
    incSpVOSB.append("                           <td class=\"L\" colspan=\"3\">                                                                                                        ");
    incSpVOSB.append("                               <label for=\"spJob"+index+"\"></label><input type=\"text\" class=\"w100per\" name=\"spJob\" id=\"spJob"+index+"\"  maxlength=\"50\" value=\""+incSpVO.spJob+"\" />  ");    
    incSpVOSB.append("                           </td>                                                                                                                                              ");    
    incSpVOSB.append("                       </tr>	                                                                                                                                                ");
    incSpVOSB.append("                       <tr name=\"corpTR2\">                                                                                                                            ");
    incSpVOSB.append("                           <th class=\"C\">법인등록번호</th>                                                                                                                       ");
    incSpVOSB.append("                           <td class=\"L\" colspan=\"3\">                                                                                                                     ");
    incSpVOSB.append(" 								<label for=\"spCorpIdNumA"+index+"\"></label><input type=\"text\" class=\"w15per\"  name=\"spCorpIdNumA\" name=\"spCorpIdNumA"+index+"\" data-type=\"bizIdFront\" title=\"법인등록번호\" value=\""+getCorpIdNumA(incSpVO.spIdNum)+"\" maxlength=\"6\" data-optional-value=true  size=\"6\" />  ");
    incSpVOSB.append("                               ~ <label for=\"spCorpIdNumB"+index+"\"></label><input type=\"text\" class=\"w15per\" name=\"spCorpIdNumB\" name=\"spCorpIdNumB"+index+"\" data-type=\"bizIdMid\" title=\"법인등록번호\" value=\""+getCorpIdNumB(incSpVO.spIdNum)+"\" maxlength=\"7\" data-optional-value=true  size=\"7\" />  ");
    incSpVOSB.append("                           </td>                                                                                                                                              ");
    incSpVOSB.append("                       </tr>                                                                                                                                                  ");
    incSpVOSB.append("                       <tr>                                                                                                                                                   ");
    incSpVOSB.append("                           <th class=\"C\">주소</th>                                                                                                                            ");
    incSpVOSB.append("                           <td class=\"L\" colspan=\"3\">                                                                                                                     ");
    incSpVOSB.append("                               <label for=\"spAddr"+index+"\"></label><input type=\"text\" class=\"w100per\" name=\"spAddr\" id=\"spAddr"+index+"\" value=\""+incSpVO.spAddr+"\" />                                                        ");
    incSpVOSB.append("                           </td>                                                                                                                                              ");
    incSpVOSB.append("                       </tr>                                                                                                                                                  ");
	incSpVOSB.append("					   <tr>                                                                                                                                                     ");
    incSpVOSB.append("                           <th class=\"C\">연락처</th>                                                                                                                           ");
    incSpVOSB.append("                           <td class=\"L\" >                                                                                                                     ");
    incSpVOSB.append(" 							  <label for=\"spCnttNumA"+index+"\"></label><input type=\"text\" class=\"w30per\" name=\"spCnttNumA\" id=\"spCnttNumA"+index+"\" value=\""+getCnttNumA(incSpVO.spCnttNum)+"\" maxlength=\"3\" />                                                        ");
    incSpVOSB.append("                               ~ <label for=\"spCnttNumB"+index+"\"></label><input type=\"text\" class=\"w30per\" name=\"spCnttNumB\" id=\"spCnttNumB"+index+"\" value=\""+getCnttNumB(incSpVO.spCnttNum)+"\" maxlength=\"4\" />                                                   ");
    incSpVOSB.append("                               ~ <label for=\"spCnttNumC"+index+"\"></label><input type=\"text\" class=\"w30per\" name=\"spCnttNumC\" id=\"spCnttNumC"+index+"\" value=\""+getCnttNumC(incSpVO.spCnttNum)+"\" maxlength=\"4\" />                                                   ");
    incSpVOSB.append("                           </td>                                                                                                                                              ");
    incSpVOSB.append("                           <th class=\"C\">업소명</th>                                                                                                                           ");
    incSpVOSB.append("                           <td class=\"L\" colspan=\"3\">                                                                                                                     ");
    incSpVOSB.append(" 						     <label for=\"spBsnsNm"+index+"\"></label><input type=\"text\" class=\"w50per\" name=\"spBsnsNm\" id=\"spBsnsNm"+index+"\" value=\""+incSpVO.spBsnsNm+"\" maxlength=\"50\" />                                                        ");    
    incSpVOSB.append("                           </td>                                                                                                                                              ");    
    incSpVOSB.append("                     </tr>                                                                                                                                                  ");
	incSpVOSB.append("					   <tr>                                                                                                                                                     ");
    incSpVOSB.append("                           <th class=\"C\">내사할 사항</th>                                                                                                                        ");
    incSpVOSB.append("                           <td class=\"L\" colspan=\"3\">                                                                                                                     ");
    incSpVOSB.append("                               <label for=\"incSpComn"+index+"\"></label><input type=\"text\" class=\"w100per\" name=\"incSpComn\" id=\"incSpComn"+index+"\" value=\""+incSpVO.incSpComn+"\" />                                                     ");
    incSpVOSB.append("                           </td>                                                                                                                                              ");
    incSpVOSB.append("                       </tr>	                                                                                                                                                ");
    incSpVOSB.append("             	   </tbody>                                                                                                                                                     ");
    incSpVOSB.append("              	 </table>                                                                                                                                                   ");
    incSpVOSB.append("          	 </div>                                                                                                                                                         ");
	
	return incSpVOSB.toString();
	
}


// 내사상세 콜백함수
function callBackSelectIntiIncDtsSuccess(data){
	console.log(JSON.stringify(data));
	
	a0101VOMap = data.a0101VO;
	
	syncA0101VOPage();
	
	
}


//수사자료 데이터 표시
function renderDTTable(qcellData) {	
	
	if (qcellData == null) qcellData = [];
	
	 var QCELLProp = {
	         "parentid" : "sheetDT",
	         "id"		: "qcellDT",
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
	     QCELL.create(QCELLProp);
	     qcellDT = QCELL.getInstance("qcellDT");
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



//입력화면 비/활성화
function freezeInput(tf) {
	$("#contents input").attr("disabled",tf);
	$("#contents select").attr("disabled",tf);
	$("#contents textarea").attr("disabled",tf);
	$("#contents a").attr("disabled",tf);
}


//타스크이름 가져오기
function getTaskNm(taskNm) {
	if (taskNm == null) taskNm = "";
	if (taskNm.indexOf(' ') > 0) {
		taskNm = taskNm.substr(0, taskNm.indexOf(' '));
	}  
	return taskNm;
}


//워크플로우 상태이행처리
function executeTask(data){
	
	
	if (data) {
		a0101VOMap = data.a0101VO;	
		syncA0101TKMap();
	}
	console.log(JSON.stringify(a0101TKMap));
	
	$.ajax({		
		 type: "POST",
		 url: "/sjpb/A/executeTask.face",
		 data : JSON.stringify(a0101TKMap),
		 datatype : 'json',	 
		 contentType : "application/json; charset=UTF-8",
		 success: callBackexecuteTaskSuccess,
		 error: function( xhr, status, error)	 {
			 alert('서버오류 입니다. 관리자에게 확인하세요. ' + error);
		 }
	});
}

//워크플로우 상태이행처리 콜백처리
function callBackexecuteTaskSuccess(data) {
	console.log(JSON.stringify(data));
	alert("정상적으로 처리되었습니다.");
	
	//리스트 재조회
	selectIntiIncList();
}



//유저와 타스크상태에 따른 버튼 활성화 처리
function handleBtnGroup(isNew) {
	
	var taskTrstVOSB = new StringBuffer();
	
	//수사관이고 내사중인 경우
	if (SJPBRole.getInvigtorRoleYn() && (a0101VOMap.criStatCd == "10" || a0101VOMap.criStatCd == "13")) {		
		taskTrstVOSB.append(" <a href=\"#\" class=\"btn_white\" id=\"saveBtn\"><span>저 장</span></a> ");		
	}
	
	if (isNew) { //신규등록
		taskTrstVOSB.append(" <a href=\"#\" class=\"btn_blue\" id=\"saveNRegBtn\"><span>등록요청</span></a> ");	
	} else { //기존내사
		$.each(a0101VOMap.taskTrstVOList, function(index, taskTrstVO) {
			console.log(taskTrstVO.trstStatNm);
			console.log(taskTrstVO.trstStatNum);
			console.log(taskTrstVO.taskRespMb);
			console.log(taskTrstVO.criStatCd);
			if (SJPBRole.getHasAnyRole(taskTrstVO.taskRoleCd) && (taskTrstVO.criStatCd != null)) {	//역할에 맞는 버튼만 보이도록 처리		
				taskTrstVOSB.append(" <a href=\"#\" class=\"btn_white\" name=\"trstBtn\" value=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-nm=\""+taskTrstVO.trstStatNm+"\" data-trst-stat-num=\""+taskTrstVO.trstStatNum+"\" data-cri-stat-cd=\""+taskTrstVO.criStatCd+"\" ><span>"+taskTrstVO.trstStatNm+"</span></a> ");			
			}
		});
	}
	
	return taskTrstVOSB.toString();
	
}


//내사승인이력을 가져온다. 
function selectIncTaskHist(rcptNum){
	
	$.ajax({
		 type: "POST",
		 url: "/sjpb/Z/selectIncTaskHist.face",
		 data : { rcptNum : rcptNum},
		 datatype : 'json',
		 success: callBackSelectIncTaskHistSuccess,
		 error: function( xhr, status, error)	 {
			 alert('서버오류 입니다. 관리자에게 확인하세요. ' + error);
		 }
	});
}

//내사승인이력 콜백함수
function callBackSelectIncTaskHistSuccess(data){
	
	
	console.log(JSON.stringify(data));
	
	a0101VOMap.incTaskHistVOList = data.qCell;
	
	if ($("li.m3 > div.tab_mini_contents").is(":visible")) {
		renderIncTaskHistTab();
	}
	
}

//내사승인이력 화면렌더링
function renderIncTaskHistTab() {
	
	 var QCELLProp = {
             "parentid" : "sheetH",
             "id"		: "qcellH",
             "data"		: {"input" : a0101VOMap.incTaskHistVOList},
             "selectmode": "row",               
             "columns"	: [
                {width: '10%',	key: 'taskNm',			title: ['단계'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
                {width: '10%',	key: 'trstStatNm',			title: ['확인'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
                {width: '20%',	key: 'criTmNm',			title: ['수사팀'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
                {width: '10%',	key: 'nmKor',			title: ['담당자'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},
                {width: '20%',	key: 'regDate',			title: ['일시'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}},            
                {width: '30%',	key: 'taskComn',			title: ['의견'],		sort:true, move:true, resize: true, styleclassname: {data: 'aligncenter fontsize13'}}
             	]
               , "rowheaders": ["sequence"]
         };
     QCELL.create(QCELLProp);	
	
}



//내사사건을 등록한다. (ajax)
function insertIntiInc(){	
	
	//맵갱신
	syncA0101VOMap();	
	console.log(JSON.stringify(a0101VOMap));	
	
	
		
	//유효성 체크
	var chkObjs = $("#contentsArea");
	if(!chkValidate.check(chkObjs, true)) return;
	
	$.ajax({		
		 type: "POST",
		 url: "/sjpb/A/insertIntiInc.face",
		 data : JSON.stringify(a0101VOMap),
		 datatype : 'json',	 
		 contentType : "application/json; charset=UTF-8",
		 success: callBackInsertIntiIncSuccess,
		 error: function( xhr, status, error)	 {
			 alert('서버오류 입니다. 관리자에게 확인하세요. ' + error);
		 }
	});
}
	
//내사사건 등록 콜백함수	
function callBackInsertIntiIncSuccess(data){
	console.log(JSON.stringify(data));
	a0101VOMap = data.a0101VO;
	alert("정상적으로 처리되었습니다.");
	//리스트 갱신
	selectIntiIncList();
}


//내사사건을 저장및등록요청한다. (ajax)
function insertNRegIntiInc(){
	
	//맵갱신
	syncA0101VOMap();
	
	console.log(JSON.stringify(a0101VOMap));	
	
	//유효성 체크
	var chkObjs = $("#contentsArea");
	if(!chkValidate.check(chkObjs, true)) return;
	
	$.ajax({		
		 type: "POST",
		 url: "/sjpb/A/insertIntiInc.face",
		 data : JSON.stringify(a0101VOMap),
		 datatype : 'json',	 
		 contentType : "application/json; charset=UTF-8",
		 success: callBackInsertNRegIntiIncSuccess,
		 error: function( xhr, status, error)	 {
			 alert('서버오류 입니다. 관리자에게 확인하세요. ' + error);
		 }
	});
}


//내사사건 저장및 등록요청 콜백함수	
function callBackInsertNRegIntiIncSuccess(data){
	
	a0101VOMap = data.a0101VO;	
	console.log(JSON.stringify(data));
	
	a0101TKMap.rcptNum = a0101VOMap.rcptNum;
	a0101TKMap.taskNum = a0101VOMap.taskNum;	
	a0101TKMap.trstStatNm = a0101VOMap.taskTrstVOList[0].trstStatNm;
	a0101TKMap.trstStatNum = a0101VOMap.taskTrstVOList[0].trstStatNum;
	a0101TKMap.taskRespMb = $("#userId").val();
	a0101TKMap.taskComn = $("#taskComn").val();
	a0101TKMap.criStatCd = a0101VOMap.taskTrstVOList[0].criStatCd;
	a0101TKMap.regUserId = $("#userId").val(); 
	a0101TKMap.updUserId = $("#userId").val();	
	
	syncA0101TKMap(); //맵동기화
	
	executeTask(data);
}


//내사사건 업데이트
function updateIntiInc(callback) {
		
	//맵갱신
	syncA0101VOMap();		
	console.log(JSON.stringify(a0101VOMap));
	
	//유효성 체크
	var chkObjs = $("#contentsArea");
	if(!chkValidate.check(chkObjs, true)) return;	

	//내사저장
	if (typeof callback == 'function') {
	    goAjax("/sjpb/A/updateIntiInc.face", a0101VOMap, callback);
	} else {
	    goAjax("/sjpb/A/updateIntiInc.face", a0101VOMap, callBackUpdateIntiIncSuccess);
	}
	
}

//내사사건 업데이트 콜백함수
function callBackUpdateIntiIncSuccess(data) {
	
	a0101VOMap = data.a0101VO;
	alert("정상적으로 저장되었습니다.");
	console.log(JSON.stringify(data));
	
	selectIntiIncList();
}

//Map 데이터 초기화
function initA0101VOMap() {	
	
	a0101VOMap = {
		    rcptNum : ""	       //접수번호
		    ,rcptIncNum : ""     //접수사건번호
			,rcptTpCd : "1"       //접수유형코드
			,criStatCd : "13"      //수사상태코드 (등록작업중)
			,fdCd : ""           //사건분야코드
			,criTmId : $("#orgCd").val()        //수사팀계정
			,dvForm : "01"         //발각형태
			,beDt : $("#today").val()           //착수일자
			,edDt : "" 			 //종결일자
			,pareRcptNum : ""    //부모접수번호	
			,infwDiv : "01"      //유입유형 01:일반	
			,intiNum : ""        //내사번호
			,criCmdDt : ""       //수사지휘일자
			,chaIncNum : ""      //입건사건번호
			,criStatDesc : "신규등록"      //수사상태설명
			,wfNum : "1"          //WFID
			,nmKor : $("#userName").val()  //담당수사관
			,criTmNm : $("#criTmNm").val() //담당팀
			,incSpVOList : null  //피내사자정보
			,criIncDtaVOList : null  //수사사건자료
			,criIncDtaFileVOList : null  //수사사건자료파일
			,incTaskHistVOList : null  //내사사건이력
			,regUserId : $("#userId").val()      //등록자
			,regDate : ""        //등록일자
			,updUserId : $("#userId").val()      //수정자
			,updDate : ""        //수정일자			
		};	
	
	a0101VOMap.incSpVOList = [{"incSpNum":"","rcptNum":"","spTpCd":"1","spIdNum":"","indvCorpDiv":"1","homcForcPernDiv":"1","gendDiv":"","spNm":"","spAddr":"","spJob":"","spBsnsNm":"","spCnttNum":"","incSpComn":""}];
	
}


//피내사자 데이터 갱신
function syncIncSpVOList(paramMap) {
	
	//피내사자
	var incSpVOArray = new Array();	
	$("table[name=incSptable]").each(function(index) {	
		
		var tableIndex = $(this).data("table-index");
		
		if ($(this).find("input[name=indvCorpDiv"+tableIndex+"]:checked").val() == "1") { //개인
			$(this).find("input[name=spIdNum]").val($(this).find("input[name=spIdNumA]").val() + "-" + $(this).find("input[name=spIdNumB]").val());
			$(this).find("input[name=spNm]").val($(this).find("input[name=spIndvNm]").val());
		} else { //법인
			$(this).find("input[name=spIdNum]").val($(this).find("input[name=spCorpIdNumA]").val() + "-" + $(this).find("input[name=spCorpIdNumB]").val());
			$(this).find("input[name=spNm]").val($(this).find("input[name=spCorpNm]").val());
			$(this).find("input[name=gendDiv]").val("");
		}
		
		var incSpVO = {				
			incSpNum :$(this).data("inc-sp-num")
			,rcptNum : a0101VOMap.rcptNum
			,spTpCd : "1"
			,spIdNum : Base64.encode($(this).find("input[name=spIdNum]").val()) 
			,indvCorpDiv : $(this).find("input[name=indvCorpDiv"+tableIndex+"]:checked").val()
			,homcForcPernDiv : $(this).find("input[name=homcForcPernDiv"+tableIndex+"]:checked").val()
			,gendDiv : $(this).find("input[name=gendDiv]").val()
			,spNm : Base64.encode($(this).find("input[name=spNm]").val())
			,spAddr : Base64.encode($(this).find("input[name=spAddr]").val())
			,spJob : Base64.encode($(this).find("input[name=spJob]").val())
			,spBsnsNm : Base64.encode($(this).find("input[name=spBsnsNm]").val())
			,spCnttNum : Base64.encode($(this).find("input[name=spCnttNumA]").val() + "-" +  $(this).find("input[name=spCnttNumB]").val())
			,incSpComn : $(this).find("input[name=incSpComn]").val()
			,spStatCd : $(this).closest("div[name=incSpDiv]").data("sp-stat-cd")
			,recdType : $(this).closest("div[name=incSpDiv]").data("recd-type")
			,inqOrd : index
			,regUserId : a0101VOMap.updUserId
			,updUserId : a0101VOMap.updUserId
		}
		incSpVOArray.push(incSpVO);
	});
	paramMap.incSpVOList = incSpVOArray;	
	
}

//수사사건자료 데이터 갱신
function syncCriIncDtaVOList() {

	var noCatgData = true;
	if (a0101VOMap.criIncDtaVOList) {
		$.each(a0101VOMap.criIncDtaVOList, function(index, criIncDtaVO) {
			if (criIncDtaVO.criDtaCatgCd == $('#deptTree').jstree(true).get_selected()[0]) {
				noCatgData = false;
			}
		});
	}
	if (noCatgData) {
		var criIncDtaVOArray = new Array();	
		$.each(a0101VOMap.criIncDtaVOList, function(index, criIncDtaVO) {
			criIncDtaVOArray.push(criIncDtaVO);
		});
		var criIncDtaVO = {
				criDtaNum : ""
				,rcptNum : a0101VOMap.rcptNum
				,criDtaCatgCd : $('#deptTree').jstree(true).get_selected()[0]
				,criReptCont : ""
				,regUserId :  a0101VOMap.updUserId
				,updUserId :  a0101VOMap.updUserId
				,recdType : "I"
		}
		criIncDtaVOArray.push(criIncDtaVO);
		a0101VOMap.criIncDtaVOList = criIncDtaVOArray;
	}

}


//첨부파일 데이터 갱신
function syncSjpbFileVOList(files) {

	if ( sjpbFile.vaultUploader) {
		var sjpbFileVOArray = new Array();	
		var fileList = sjpbFile.vaultUploader.getData();
		console.log(fileList);
		
		if (files.length > 0) {  
			for (var i = 0 ; i < fileList.length ; i++) {					
				var sjpbFileVO = {
					fileNm : fileList[i].name
				   ,fileMask : fileList[i].serverName
				   ,fileSize : fileList[i].size
				   ,regUserId : $("#userId").val()
				   ,updUserId : $("#userId").val()
				}
				sjpbFileVOArray.push(sjpbFileVO);
			}
		}
		
		
		$.each(a0101VOMap.criIncDtaVOList, function(index, criIncDtaVO) {
			if (criIncDtaVO.criDtaCatgCd == $('#deptTree').jstree(true).get_selected()[0]) {
				criIncDtaVO.sjpbFileVOList = sjpbFileVOArray;
			}
		});
		
	}
	
}

//Map 데이터 갱신
function syncA0101TKMap() {	
	a0101TKMap.incSpVOList = a0101VOMap.incSpVOList;
	a0101TKMap.criIncDtaVOList = a0101VOMap.criIncDtaVOList;
}

//Map 데이터 갱신
function syncA0101VOMap() {
	//피내사자	
	syncIncSpVOList(a0101VOMap);
	
	//수사사건자료
	syncCriIncDtaVOList(a0101VOMap);
	
	//내사분야
	a0101VOMap.fdCd = $("select[name=fdCd]").val();
	
	//유입구분
	a0101VOMap.infwDiv = $("select[name=infwDiv]").val();	
	
	//등록일자
	a0101VOMap.beDt = $("input[name=beDt]").val();	
	
	//수사지휘일자
	a0101VOMap.criCmdDt = $("input[name=criCmdDt]").val();
	
	//내사종결일자
	a0101VOMap.edDt = $("input[name=edDt]").val();
	
	//수사지휘결과
	a0101VOMap.criCmdCont = $("textarea[name=criCmdCont]").val();
	
	//종결처리결과
	a0101VOMap.edHandRstCont = $("textarea[name=edHandRstCont]").val();
}

//화면 갱신
function syncA0101VOPage() {

	$('#intiNumTD').html(a0101VOMap.intiNum);
	$('#rcptNum').val(a0101VOMap.rcptNum);
	$('#criStatDesc').html(a0101VOMap.criStatDesc);
	$("#regDtTD").html(a0101VOMap.regDate);	
	$("#chaIncNumTD").html(a0101VOMap.chaIncNum);
	
	setFieldValue($("select[name=fdCd]"), a0101VOMap.fdCd);
	setFieldValue($("select[name=infwDiv]"), a0101VOMap.infwDiv);
	$("input[name=beDt]").val(a0101VOMap.beDt);
	$("input[name=edDt]").val(a0101VOMap.edDt);
	$("input[name=criCmdDt]").val(a0101VOMap.criCmdDt);
	
	//수사지휘결과
	$("textarea[name=criCmdCont]").val(a0101VOMap.criCmdCont);
	
	//종결처리결과
	$("textarea[name=edHandRstCont]").val(a0101VOMap.edHandRstCont);	
	
	$("#criArea02").hide();
	$("#apprArea02").hide();		
	
	//등록작업중인 경우 수사지휘, 종결 영역 숨기기 처리
	if (a0101VOMap.criStatCd == "13") {
		$("div[name=criIncDtaDiv]").hide();
	} else {
		$("div[name=criIncDtaDiv]").show();
	}	
	
	var incSpVOHtml = "";
	$.each(a0101VOMap.incSpVOList, function(index, incSpVO) {
		
		console.log(incSpVO.incSpNum);
		incSpVO.spIdNum = Base64.decode(incSpVO.spIdNum);
		incSpVO.spNm = Base64.decode(incSpVO.spNm);
		incSpVO.spAddr = Base64.decode(incSpVO.spAddr);
		incSpVO.spJob = Base64.decode(incSpVO.spJob);
		incSpVO.spBsnsNm = Base64.decode(incSpVO.spBsnsNm);
		incSpVO.spCnttNum = Base64.decode(incSpVO.spCnttNum);
		incSpVOHtml += renderIncSpHtml(index+1, incSpVO);
	});
		
	$("#incSpContents").html(incSpVOHtml);
	$("#incSpContents").data("record-max", $("div[name=incSpDiv").size());
	
	//내사승인이력
	selectIncTaskHist(a0101VOMap.rcptNum);
	
	//유저와 타스크상태에 따른 버튼 활성화 처리
	var trstBtnGroupHtml = handleBtnGroup(false);

	freezeInput(true); //입력화면 비활성화
	
	//수사관이고 등록작업중(13) 또는 내사작업중(10)인 경우
	if (SJPBRole.getInvigtorRoleYn() && (a0101VOMap.criStatCd == "10" || a0101VOMap.criStatCd == "13")) {
		$("#btnArea_EditButtons").html(trstBtnGroupHtml);
		$("#btnArea_EditButtons a:last").attr("class", "btn_blue");
		$("#criArea02").show();
		$("#apprArea02").hide();
		
		freezeInput(false); //입력화면 활성화
	}
	
	//송치관이고 내사등록작업중 (14) 인 경우
	if (SJPBRole.getTrnsrRoleYn() && a0101VOMap.criStatCd == "14") {
		$("#apprArea_EditButtons").html(trstBtnGroupHtml);
		$("#apprArea_EditButtons a:first").attr("class", "btn_blue");
		$("#taskNmTD").html(getTaskNm(a0101VOMap.taskNm));
		$("#criArea02").hide();
		if (trstBtnGroupHtml != "") {
			$("#apprArea02").show();
		} else {
			$("#apprArea02").hide();
		}
		//결재의견만 활성화
		$("#taskComn").val("").attr("disabled",false);
		
	}	
	
	//사건저장
	$("#saveBtn").on("click", function() {		
		if (a0101VOMap.rcptNum == "") { //신규등록
			insertIntiInc();
		} else {    //업데이트
			updateIntiInc();
		}	
	});
	
	//타스크이행
	$("a[name=trstBtn]").on("click", function() {

		console.log($(this).data("trst-stat-num"));
		console.log($(this).data("cri-stat-cd"));
		
		a0101TKMap.rcptNum = a0101VOMap.rcptNum;
		a0101TKMap.taskNum = a0101VOMap.taskNum;	
		a0101TKMap.trstStatNm = $(this).data("trst-stat-nm")
		a0101TKMap.trstStatNum = $(this).data("trst-stat-num")
		a0101TKMap.taskRespMb = $("#userId").val();
		a0101TKMap.taskComn = $("#taskComn").val();
		a0101TKMap.criStatCd = $(this).data("cri-stat-cd")
		a0101TKMap.regUserId = $("#userId").val(); 
		a0101TKMap.updUserId = $("#userId").val();	
		
		a0101TKMap.incSpVOList = a0101VOMap.incSpVOList;
		a0101TKMap.criIncDtaVOList = a0101VOMap.criIncDtaVOList;		
				
		//입건종결(11) 또는 내사종결(12) 인 경우
		if (a0101TKMap.criStatCd == "11" || a0101TKMap.criStatCd == "12") {			
			//종결일시 필수처리
			$("#edDt").attr("data-optional-value", "false").data("optional-value", false);
		} 
		
		if ($(this).parent('div.r_btn').attr("id") == "apprArea_EditButtons") { //승인자
			executeTask();
		} else {	//수사관 
			updateIntiInc(executeTask);
		}
		
		//종결일시 옵션처리
		$("#edDt").attr("data-optional-value", "true").data("optional-value", true);
	
	});	
	
	//피내사자 영역 이벤트 설정
	eventSpSetup();
	
	//서식관리,승인내역탭 보이기
	$("li.m2,li.m3").show();
		
	//수사자료 리스팅	
	renderDTTable(a0101VOMap.criIncDtaFileVOList);
	
	//화면사이즈 갱신
	autoResize();
}



//내사사건부 리포트 리스트를 가져온다. 
function selectIntiIncReport(){
	
	//검색조건
	a0101SCMap.criTmIdSC = $('#criTmIdSC').val();
	a0101SCMap.nmKorSC = $('#nmKorSC').val();
	if ($('#beDtFromSC').val() != "") {
		a0101SCMap.beDtFromSC = $('#beDtFromSC').val() + " 00:00:00";
	}
	if ($('#beDtToSC').val() != "") {
		a0101SCMap.beDtToSC = $('#beDtToSC').val() + " 23:59:59";
	}
	a0101SCMap.criStatSC = $('#criStatSC').val();  //내사상태
	
	$.ajax({
		 type: "POST",
		 url: "/sjpb/A/selectIntiIncReport.face",
		 data : a0101SCMap,
		 datatype : 'json',
		 success: callBackSelectIntiIncReportSuccess,
		 error: function( xhr, status, error)	 {
			 alert('서버오류 입니다. 관리자에게 확인하세요. ' + error);
		 }
	});
}


//사건관리 리스트 콜백함수
function callBackSelectIntiIncReportSuccess(data) {
	
	console.log(JSON.stringify(data));
	a0101RTMap.rexdataset = data.rexdataset;
	
	var xmlString = objectToXml(a0101RTMap);
	
	$("#reptNm").val("A0101.crf"); //레포트 파일명
	$("#xmlData").val(xmlString);
	
	//레포트 호출
	openReportService(reportForm);  
	
}


//수사사건자료리스트를 가져온다.
function selectCriIncDtaList(){
	
	//검색조건
	a0102SCMap.rcptNum = a0101VOMap.rcptNum;
	a0102SCMap.criDtaCatgSC = $('#criDtaCatgSC').val();
	a0102SCMap.criDtaFileNmSC = $('#criDtaFileNmSC').val();
	a0102SCMap.criDtaUsrNmSC = $('#criDtaUsrNmSC').val();  

	goAjax("/sjpb/A/selectCriIncDtaList.face", a0102SCMap, callBackSelectCriIncDtaListSuccess);
	
}

//수사사건자료리스트 콜백함수
function callBackSelectCriIncDtaListSuccess(data) {	
	
	console.log(JSON.stringify(data));
	renderDTTable(data.qCell);
}



//수사자료 업데이트
function updateCriIncDta() {
	
	//맵갱신	
	syncA0101VOMap();		
	console.log(JSON.stringify(a0101VOMap));
	
	//유효성 체크
	var chkObjs = $("#contentsArea");
	if(!chkValidate.check(chkObjs, true)) return;
	
	if ( sjpbFile.vaultUploader) {
		sjpbFile.vaultUploader.attachEvent("onUploadComplete", function (files) {				
			syncSjpbFileVOList(files);			
			sjpbFile.isNewFile = false;
			sjpbFile.isCancel = false;			
		
			goAjax("/sjpb/A/updateCriIncDta.face", a0101VOMap, callBackUpdateCriIncDtaSuccess);
		
		});		
		
		if (sjpbFile.isNewFile) { //업로드 대상이 있는 경우			
			sjpbFile.vaultUploader.upload();
		} else {  //업로드 대상이 없는 경우			
			a0101VOMap.sjpbFileVOList = null;
			sjpbFile.isCancel = false;
		} 
		
	}
	
}

//수사자료 업데이트 콜백함수
function callBackUpdateCriIncDtaSuccess(data) {
	
	alert("정상적으로 저장되었습니다.");
	a0101VOMap = data.a0101VO;
	fn_init();
	
	console.log(JSON.stringify(data));	
	selectCriIncDtaList();
	
}


//내사사건
var a0101VOMap = {
    rcptNum : ""	       //접수번호
    ,rcptIncNum : ""     //접수사건번호
	,rcptTpCd : ""       //접수유형코드
	,criStatCd : ""      //수사상태코드
	,fdCd : ""           //사건분야코드
	,criTmId : ""        //수사팀계정
	,dvForm : ""         //발각형태
	,beDt : ""           //착수일자
	,edDt : ""           //종결일자
	,pareRcptNum : ""    //부모접수번호	
	,intiNum : ""        //내사번호
	,criCmdDt : ""       //수사지휘일자
	,criCmdCont : ""     //수사지휘결과
	,edHandRstCont : ""  //종결처리결과	
	,intiEdDt : ""	   //수사종결일자
	,chaIncNum : ""      //입건사건번호
	,criStatDesc : ""      //수사상태설명
	,wfNum : "1"          //WFID		
	,taskNum : ""         //활성타스크번호
	,taskNm : ""         //활성타스크이름
	,taskRespMb : ""      //활성타스크소유코드
	,nmKor : ""           //담당수사관	
	,infwDiv : ""         //유입구분
	,incSpVOList : null  //피내사자정보
	,criIncDtaVOList : null  //수사사건자료
	,incTaskHistVOList : null  //내사사건이력
	,taskTrstVOList : null //타스크이행	
	,sjpbFileVOList : null //첨부파일리스트
	,regUserId : ""      //등록자
	,regDate : ""        //등록일자
	,updUserId : ""      //수정자
	,updDate : ""        //수정일자	
}

//검색조건
var a0101SCMap = {
	criTmIdSC : ""       //담당수사팀
	,nmKorSC : ""         //담당수사관
	,beDtFromSC : ""      //착수일자(From)
	,beDtToSC : ""        //착수일자(To)
	,criStatSC : ""       //내사상태
}

// 수사자료 검색조건
var a0102SCMap = {		
	rcptNum : "" //접수번호
	,criDtaCatgSC : "" //수사자료분류
	,criDtaFileNmSC : "" //수사자료파일명
	,criDtaUsrNmSC : "" //수사자료작성자
}

//타스크
var a0101TKMap = {		
	wfNum : "1"          //내사 WFID
	,rcptNum : ""	      //접수번호
	,taskNum : ""         //활성타스크번호
	,trstStatNm : ""      //타스크이행명
	,trstStatNum : ""      //타스크이행번호
	,taskRespMb : ""      //타스크소유자	
	,taskComn : ""        //타스크코멘트
	,edDt : ""            //내사종료일자	criStatCd = 11(입건종결), 12(내사종결)
	,criStatCd : ""       //수사상태코드
	,regUserId : ""      //등록자
	,updUserId : ""       //수정자
	,chaWfNum : "2"  //인지사건  WFID	
}


//리포트맵
var a0101RTMap = {
	rexdataset : null
}