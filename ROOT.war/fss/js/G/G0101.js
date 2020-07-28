$(document).ready(function(){
	pageInit();
});

var g0101VOMap = new Object();

//화면 진입시 동작함
function pageInit(){
	selectList();
	
	//이벤트바인딩
	eventSetup();
}

//이벤트 세팅
function eventSetup() {
	
	$("#dateSc").on("change", function(){
		if(!isNull($(this).val())){
			selectList($(this).val());
		}
	});
	
	$("select[name=forsInveReqStatCd]").on("change", function(){
		
		//지원불가의경우
		if($(this).val() == "99"){
			//일반요청 숨김
			$("#contentsArea").find("tr[data-name=reqbk]").hide();
			$("div[data-name=reqbk]").hide();
			
			//지원불가 노출
			$("#contentsArea").find("tr[data-name=offischdmng]").show();
			$("div[data-name=offischdmng]").show();
			
		}else{
			//일반요청 노출
			//$("#contentsArea").find("tr[data-name=reqbk]").show();
			
			$("#contentsArea").find("tr[data-name=reqbk]").show();
			
			
			
			//포렌식 담당자일경우
			if(SJPBRole.getDgtFrsRoleYn()){
				//1. 상태수정 가능해야함. 
				$("select[name=forsInveReqStatCd]").removeAttr("disabled");
				
				//2. 요청자수정 가능해야함.
				$("tr[name=reqMbNmTR1]").hide();
				$("tr[name=reqMbNmTR2]").show();
				
			}else{
				$("select[name=forsInveReqStatCd]").attr("disabled","true");
				
				$("tr[name=reqMbNmTR1]").show();
				$("tr[name=reqMbNmTR2]").hide();
			}
			
			
			
			$("div[data-name=reqbk]").show();
			
			//지원불가 숨김
			$("#contentsArea").find("tr[data-name=offischdmng], div[data-name=offischdmng]").hide();
			$("div[data-name=offischdmng]").hide();
			
		}
	});
	
	
	$("#searchArea input[type=text]").keypress(function(e){
		if(e.keyCode == 13){
			e.stopPropagation();
			doSearch();
		}
	});
	
}

//리스트 검색
function doSearch(){
	selectList($("#dateSc").val());
}

//초기화
function initData(type){
	//0: 신규입력 
	//1: 수정 
	
	//Map 초기화
//	initG0101VOMap();
//	initreqBkVOMap();
//	initoffiSchdMngVOMap();
	
	var contentsArea = $("#contentsArea");
	
	//input 값 초기화
	contentsArea.find("input[type=hidden]").val("");
	contentsArea.find("input[type=text]").val("");
	contentsArea.find("textarea").text("");
	
	//select값 초기화
	contentsArea.find("select").each(function(){
		var self = $(this);
		//첫번째 option 선택
		self.find("option:eq(0)").prop("selected", true);
		self.prev(".txt").text(self.find('option:selected').text());
	});
	
	//일반요청 노출
	$("#contentsArea").find("tr[data-name=reqbk]").show();
	$("div[data-name=reqbk]").show();
	
	//지원불가 숨김
	$("#contentsArea").find("tr[data-name=offischdmng]").hide();
	$("div[data-name=offischdmng]").hide();
	
	//신규입력 or 수정 화면 컨트롤
	if (type == 0){
		
	}else{
		
	}
	
}

//디지털포렌식지원요청 화면(리스트)조회 (ajax)
function selectList(date){
	
	var g0101VO = new Object();
	
	if(!isNull(date)){
		g0101VO.dateSc = date;
		$("#dateSc").val(date);
	}
	
	goAjaxDefault("/sjpb/G/selctList.face", g0101VO, callBackSelectListSuccess);
}

//디지털포렌식지원요청 화면(리스트)조회 콜백함수
function callBackSelectListSuccess(data){
	
	g0101VOMap = data.g0101VO;
	
	//디지털포렌식 리스트 그리기
	var listHtml = new StringBuffer();
	
	listHtml.append('<table class="list" cellpadding="0" cellspacing="0">									');
	listHtml.append('	<caption>게시판쓰기</caption>                                                            ');
	listHtml.append('	<colgroup>                                                                          ');
	listHtml.append('		<col width="8%" />                                                              ');
	listHtml.append('		<col width="*%" />                                                              ');
	listHtml.append('		<col width="*%" />                                                              ');
	listHtml.append('		<col width="*%" />                                                              ');
	listHtml.append('		<col width="*%" />                                                              ');
	listHtml.append('		<col width="*%" />                                                              ');
	listHtml.append('		<col width="*%" />                                                              ');
	listHtml.append('	</colgroup>                                                                         ');
	listHtml.append('	<thead>                                                                             ');
	listHtml.append('		<tr>                                                                            ');
	
	$.each(g0101VOMap.forsInveReqBkVOList, function(i, forsInveReqBkVO) {
		var thContents = "";
		//일요일 : 글시체 레드
		if(i == 0){
			thContents = '<span class="red">'+forsInveReqBkVO.dateDayNm+'<br />'+forsInveReqBkVO.dateDay+'</span>';
			
		//월,화,수,목,금,토
		}else{
			thContents = forsInveReqBkVO.dateDayNm+'<br />'+forsInveReqBkVO.dateDay;
		}
		listHtml.append('			<th class="C w_line">'+thContents+'</th>                                                        ');
	});
	
	listHtml.append('		</tr>                                                                           ');
	listHtml.append('	</thead>                                                                            ');
	listHtml.append('	<tbody>                                                                             ');
	listHtml.append('		<tr style="cursor:Pointer; border-bottom: 2px dotted #d1d2d3 !important">                                                                            ');
	
	var reqBkTitle = "";
	var reqBkContent = "";
	
	var offiSchdMngContent = "";
	
	var reqBkHtml = new StringBuffer();
	var offiSchdMng = new StringBuffer();
	
	//포렌식조사의뢰 리스트 
	$.each(g0101VOMap.forsInveReqBkVOList, function(i, forsInveReqBkVO) {
		offiSchdMngContent = "";
		
		//의뢰가 없으면 
		if(isNull(forsInveReqBkVO.forsInveReqSiNum)){
			reqBkHtml.append("			<td class=\"C w_line\" onclick=\"updateReqBkView('1','"+forsInveReqBkVO.inDate+"')\"></td>                                                         ");

		//의뢰가 있으면
		}else{
			reqBkTitle = forsInveReqBkVO.forsInveReqStatCd == "01" ? "요청<br/>("+forsInveReqBkVO.incNum+")" : "확정<br/>("+forsInveReqBkVO.incNum+")";
			reqBkContent = forsInveReqBkVO.criTmNm + "<br/>" + forsInveReqBkVO.nmKor;
			
			reqBkHtml.append("			<td class=\"C w_line\" onclick=\"updateReqBkView('1','"+forsInveReqBkVO.inDate+"')\">"+reqBkTitle+"<br/><br/>"+reqBkContent+"</td>                                                         ");
			
		}
		
		//담당자 일정, 
		//포렌식조사일정관리 리스트 
		$.each(g0101VOMap.forsInveOffiSchdMngVOList, function(i, forsInveOffiSchdMngVO) {
			//포렌식조사일정이 있으며 && 해당 날짜인경우 
			if(!isNull(forsInveOffiSchdMngVO.schdMngSiNum) && forsInveOffiSchdMngVO.inDate == forsInveReqBkVO.inDate){
				if(!isNull(offiSchdMngContent)){
					offiSchdMngContent += "<br/>";
				}
				offiSchdMngContent += forsInveOffiSchdMngVO.nmKor + (isNull(forsInveOffiSchdMngVO.schdRsn) ? "" : "("+ forsInveOffiSchdMngVO.schdRsn+")" ) ;
			}
		});
		offiSchdMng.append("			<td class=\"C w_line\" onclick=\"updateReqBkView('2','"+forsInveReqBkVO.inDate+"')\">"+offiSchdMngContent+"</td>                                                         ");
	});
	
	listHtml.append(reqBkHtml);
	listHtml.append('		</tr>                                                                           ');
	listHtml.append('		<tr style="cursor:Pointer;">                                                                            ');
	listHtml.append(offiSchdMng);
	listHtml.append('		</tr>                                                                           ');
	listHtml.append('	</tbody>                                                                            ');
	listHtml.append('</table>                                                                               ');
	
	$("#listAreaContents").html(listHtml.toString());
	
	//M월 W주차 셋팅 
	$("#calTitleSpan").html(g0101VOMap.weekOfMonth);
	$("#calendar_perv").attr("href", "javascript:selectList('"+g0101VOMap.prevDateSc+"')");
	$("#calendar_next").attr("href", "javascript:selectList('"+g0101VOMap.nextDateSc+"')");
	
//	$("#calendar_perv").off("click").on("click", function(){
//		selectList(g0101VOMap.prevDateSc);
//	});
//	
//	$("#calendar_next").off("click").on("click", function(){
//		selectList(g0101VOMap.nextDateSc);
//	});
	
	//해당 날짜의 수정, 신규 화면 노출함
	updateReqBkView("1", g0101VOMap.dateSc);
}

//수정 화면 노출 
function updateReqBkView(type, date){
	//type 1 : 포렌식요청 영역 노출
	//type 2 : 포렌식담당자 일정등록 영역 노출 
	
	g0101VOMap.dateSc = date;
	
	goAjax("/sjpb/G/updateReqBkView.face", g0101VOMap, function(data){ callBackUpdateReqBkViewSuccess(data, type) } );
}

//수정 화면 노출 성공 콜백함수 
function callBackUpdateReqBkViewSuccess(data, type){
	//type 1 : 포렌식요청 영역 클릭
	//type 2 : 포렌식담당자 일정등록 영역 클릭
	
	//데이터 셋팅 
	g0101VOMap = data.g0101VO;
	
	
	//신규
	if(g0101VOMap.forsInveReqSiNum == null){	
		insertReqBkView(type);
		
	//수정
	}else{
		
		//초기화
		initData("1");
		
		//셋팅 시작
		
		//히든값
		setFieldValue($("input[name=forsInveReqSiNum]"), g0101VOMap.forsInveReqSiNum);		//포렌식의뢰일련번호
		setFieldValue($("input[name=forsInveReqMb]"), g0101VOMap.forsInveReqMb);			//요청자ID
		
		//날짜셋팅 
		setFieldValue($("#inveDate"), g0101VOMap.dateSc);
		
		setFieldValue($("select[name=forsInveReqStatCd]"), g0101VOMap.forsInveReqStatCd);	//상태
		
		setFieldValue($("input[name=inveReqBeDt]"), g0101VOMap.inveReqBeDt);	//요청일시작
		setFieldValue($("input[name=inveReqEdDt]"), g0101VOMap.inveReqEdDt);	//요청일종료
		
		setFieldValue($("#forcInveReqMbNm_TR1"), g0101VOMap.nmKor);				//요청자이름(일반수사관 노출)
		setFieldValue($("input[name=forcInveReqMbNm_TR2]"), g0101VOMap.nmKor);	//요청자이름(포렌식담당자 노출)
		
		setFieldValue($("input[name=dtaCollArea]"), g0101VOMap.dtaCollArea);	//지역
		
		setFieldValue($("input[name=incNum]"), g0101VOMap.incNum);				//지역
		setFieldValue($("textarea[name=reqComn]"), g0101VOMap.reqComn);			//비고
		
		//포렌식수사관일정관리셋팅 
		setOffiSchdMngValue();
		
		//상황에 맞는 화면 노출 
		handleUI(type);
	}
}

//포렌식수사관일정관리셋팅 
function setOffiSchdMngValue(){
	//포렌식담당자의 경우, 지원불가 데이터도 셋팅함 .
	if(SJPBRole.getDgtFrsRoleYn()){
		
		//해당일 일정 데이터가 있을 경우에만 셋팅 
		if(g0101VOMap.forsInveOffiSchdMngVO != null && !isNull(g0101VOMap.forsInveOffiSchdMngVO.schdMngSiNum)){	
			//히든값
			setFieldValue($("input[name=schdMngSiNum]"), g0101VOMap.forsInveOffiSchdMngVO.schdMngSiNum);		//포렌식일정관리일련번호
			
			setFieldValue($("input[name=schdBeDt]"), g0101VOMap.forsInveOffiSchdMngVO.schdBeDt);	//지원불가일시작
			setFieldValue($("input[name=schdEdDt]"), g0101VOMap.forsInveOffiSchdMngVO.schdEdDt);	//지원불가일종료
			
			setFieldValue($("input[name=schdRsn]"), g0101VOMap.forsInveOffiSchdMngVO.schdRsn);				//사유
			setFieldValue($("textarea[name=schdComn]"), g0101VOMap.forsInveOffiSchdMngVO.schdComn);			//비고
		
		}else{
			
			setFieldValue($("input[name=schdBeDt]"), g0101VOMap.dateSc);	//지원불가일시작
			setFieldValue($("input[name=schdEdDt]"), g0101VOMap.dateSc);	//지원불가일종료
			
		}
	}
}

//컨텐츠 영역 readonly 처리 
function areaSetReadOnly(targetObj){
	targetObj.find("input:not([data-readonly=y]), select:not([data-readonly=y]), textarea:not([data-readonly=y])").each(function (){
		//입력 비활성화
		$(this).attr("disabled", "true");
		
	});
}

//컨텐츠 영역 readonly 처리 제거 
function areaSetWrite(targetObj){
	targetObj.find("input:not([data-readonly=y]), select:not([data-readonly=y]), textarea:not([data-readonly=y])").each(function (){
		//입력 활성화
		$(this).removeAttr("disabled");
		
	});
}

//상황에맞는 화면 노출 
function handleUI(type){
	//type 1 : 포렌식요청 영역 클릭
	//type 2 : 포렌식담당자 일정등록 영역 클릭
	
	//요청 버튼 리스트 그리기
	var reqbkBtnHtml = new StringBuffer();
	
	//지원불가 버튼 리스트 그리기 
	var offischdmngBtnHtml = new StringBuffer();
	
	
	//포렌식요청 영역 버튼 노출
	//신규 등록일 경우, 요청 버튼 노출 
	if(isNull(g0101VOMap.forsInveReqSiNum)){
		
		reqbkBtnHtml.append('<a href="javascript:insertReqBk();" class="btn_blue"><span>요청</span></a>');
		
		//컨텐츠 수정가능 (disabled 제거)
		areaSetWrite($("#contentsArea"));
		
	//수정/조회일 경우, 
	//1. 포렌식 담당자일 경우, [확정, 수정, 취소] 버튼 노출 
	//1-1. 포렌식 담당자일 경우, 본인 지원불가 선택시에만 [수정, 취소] 버튼 노출 
	//2. 요청자일경우, [수정, 취소] 버튼 노출
	//3. 요청자가 아닐경우, 조회만 가능 
	}else{
		
		//포렌식 담당자일경우
		if(SJPBRole.getDgtFrsRoleYn()){
			
			//요청인 경우, 확정 버튼 노출  
			if(g0101VOMap.forsInveReqStatCd == "01"){
				reqbkBtnHtml.append('<a href="javascript:fixReqBk();" class="btn_grey"><span>확정</span></a>');
			}
			
			reqbkBtnHtml.append('<a href="javascript:updateReqBk();" class="btn_blue"><span>수정</span></a>');
			reqbkBtnHtml.append('<a href="javascript:deleteReqBk();" class="btn_white"><span>취소</span></a>');
			
		}else{
			
			//요청자일 경우
			if($("#userId").val() == g0101VOMap.forsInveReqMb){
				
				//요청일 경우에만, 수정, 취소 가능 
				if(g0101VOMap.forsInveReqStatCd == "01"){
					reqbkBtnHtml.append('<a href="javascript:updateReqBk();" class="btn_blue"><span>수정</span></a>');
					reqbkBtnHtml.append('<a href="javascript:deleteReqBk();" class="btn_white"><span>취소</span></a>');
				}
				
				//컨텐츠 수정가능 (disabled 제거)
				areaSetWrite($("#contentsArea"));
				
			//요청자가 아닐경우
			}else{
				//컨텐츠 수정불가 (disabled)
				areaSetReadOnly($("#contentsArea"));
			}
		}
	}
	
	
	//포렌식담당자 일정등록 영역 버튼 노출
	//포렌식 담당자일경우
	if(SJPBRole.getDgtFrsRoleYn()){
		//수정일 경우, 요청, 취소 버튼 노출 
		if(g0101VOMap.forsInveOffiSchdMngVO != null && !isNull(g0101VOMap.forsInveOffiSchdMngVO.schdMngSiNum)){	
			
			//지원불가 노출일경우, 본인일정에서만 수정, 취소 버튼 노출 
			//요청자일 경우
			if($("#userId").val() == g0101VOMap.forsInveOffiSchdMngVO.forsCriOffi){
				offischdmngBtnHtml.append('<a href="javascript:updateOffiSchdMng();" class="btn_blue"><span>수정</span></a>');
				offischdmngBtnHtml.append('<a href="javascript:deleteOffiSchdMng();" class="btn_white"><span>취소</span></a>');
			}
		
		//신규 등록일 경우, 요청 버튼 노출 
		}else{
			offischdmngBtnHtml.append('<a href="javascript:insertOffiSchdMng();" class="btn_blue"><span>저장</span></a>');
			
		}
	}
	
	//포렌식 담당자일경우
	if(SJPBRole.getDgtFrsRoleYn()){
		//1. 상태수정 가능해야함. 
		$("select[name=forsInveReqStatCd]").removeAttr("disabled");
		
		//2. 요청자수정 가능해야함.
		$("tr[name=reqMbNmTR1]").hide();
		$("tr[name=reqMbNmTR2]").show();
		
		//포렌식 담당자가, 포렌식 담당자 일정등록 영역 클릭했을 경우에만, 지원불가 화면 노출 
		if(type == "2"){	//포렌식담당자 일정등록 영역 클릭
			setFieldValue($("select[name=forsInveReqStatCd]"), "99");	//지원불가 
			$("select[name=forsInveReqStatCd]").trigger("change");
		}	
		
	}else{
		$("select[name=forsInveReqStatCd]").attr("disabled","true");
		
		$("tr[name=reqMbNmTR1]").show();
		$("tr[name=reqMbNmTR2]").hide();
	}
	
	$("#reqbkBtnAreaDiv").html(reqbkBtnHtml.toString());
	$("#offischdmngBtnAreaDiv").html(offischdmngBtnHtml.toString());
	
	autoResize();
	
}

//지원불가 삭제 
function deleteOffiSchdMng(){
	//삭제한다.
	if(confirm("삭제하시겠습니까?") == true){
		goAjax("/sjpb/G/deleteOffiSchdMng.face", g0101VOMap, callBackDeleteOffiSchdMngSuccess);
	}else{
		return;
	}
}

//지원불가 삭제 성공 콜백함수 
function callBackDeleteOffiSchdMngSuccess(data){
	//성공
	if(data.g0101VO.result == "01"){
		alert("삭제 성공!!");
		selectList(g0101VOMap.dateSc);
		
	}else{
		//alert("일정 등록 실패[중복일확인]!!");
		alert("삭제 실패 관리자에 문의해주세요.");
	}
	
}

//지원불가 저장 
function insertOffiSchdMng(){
	//Map 데이터 갱신
	if(syncOffiSchdMngVOMap(true)){
		goAjax("/sjpb/G/insertUpdateOffiSchdMng.face", offiSchdMngVOMap, callBackInsertOffiSchdMngSuccess);
	}
}

//지원불가 저장 성공 콜백함수
function callBackInsertOffiSchdMngSuccess(data){
	//성공
	if(data.g0101VO.result == "01"){
		alert("일정 등록 성공!!");
		selectList(g0101VOMap.dateSc);
		
	}else{
		//alert("일정 등록 실패[중복일확인]!!");
		alert("등록 불가능한 일자 입니다.");
	}
}

//지원불가 수정 
function updateOffiSchdMng(){
	//Map 데이터 갱신
	if(syncOffiSchdMngVOMap(true)){
		goAjax("/sjpb/G/insertUpdateOffiSchdMng.face", offiSchdMngVOMap, callBackUpdateOffiSchdMngSuccess);
	}
}

//지원불가 수정 성공 콜백함수
function callBackUpdateOffiSchdMngSuccess(data){
	//성공
	if(data.g0101VO.result == "01"){
		alert("일정 수정 성공!!");
		selectList(g0101VOMap.dateSc);
		
	}else{
		//alert("일정 등록 실패[중복일확인]!!");
		alert("수정 불가능한 일자 입니다.");
	}
}

//요청 확정
function fixReqBk(){
	//확정한다.
	if(confirm("확정하시겠습니까?") == true){
		
		g0101VOMap.inveFiDt = g0101VOMap.dateSc;
		g0101VOMap.forsInveReqStatCd = "02";		//확정
		
		goAjax("/sjpb/G/fixReqBk.face", g0101VOMap, callBackFixReqBkSuccess);
	}else{
		return;
	}
}

//요청 확정 성공 콜백함수
function callBackFixReqBkSuccess(data){
	//성공
	if(data.g0101VO.result == "01"){
		alert("확정 성공!!");
		selectList(g0101VOMap.dateSc);
		
	}else{
		alert("확정 실패!!");
	}
}

//요청 삭제(취소)
function deleteReqBk(){
	//삭제한다.
	if(confirm("삭제하시겠습니까?") == true){
		goAjax("/sjpb/G/deleteReqBk.face", g0101VOMap, callBackDeleteReqBkSuccess);
	}else{
		return;
	}
}

//요청 삭제(취소) 성공 콜백함수 
function callBackDeleteReqBkSuccess(data){
	//성공
	if(data.g0101VO.result == "01"){
		alert("취소 성공!!");
		selectList(data.g0101VO.inveReqBeDt);
		
	}else{
		alert("취소 실패!!");
	}
}

//신규 요청화면 노출 
function insertReqBkView(type){
	
	//초기화
	initData("0");
	
	//날짜셋팅 
	setFieldValue($("#inveDate"), g0101VOMap.dateSc);		
	
	setFieldValue($("input[name=inveReqBeDt]"), g0101VOMap.dateSc);
	setFieldValue($("input[name=inveReqEdDt]"), g0101VOMap.dateSc);
	
	setFieldValue($("input[name=forsInveReqMb]"), $("input[name=userId]").val());		//조사요청자 셋팅
	
	setFieldValue($("#forcInveReqMbNm_TR1"), $("input[name=userName]").val());				//요청자이름(일반수사관 노출)
	setFieldValue($("input[name=forcInveReqMbNm_TR2]"), $("input[name=userName]").val());	//요청자이름(포렌식담당자 노출)
	
	//포렌식수사관일정관리셋팅 
	setOffiSchdMngValue();
	
	//상황에 맞는 화면 노출
	handleUI(type);
}

//신규 요청 
function insertReqBk(){
	//Map 데이터 갱신
	if(syncG0101VOMap(true)){
		goAjax("/sjpb/G/insertUpdateReqBk.face", g0101VOMap, callBackInsertReqBkSuccess);
	}
}

//TODO 요청 신규, 요청 수정 합쳐도 될것. 콜백함수로직 같게 해도되나?
//신규요청 성공 콜백함수
function callBackInsertReqBkSuccess(data){
	//성공
	if(data.g0101VO.result == "01"){
		alert("요청성공!");
		selectList(g0101VOMap.dateSc);
	
	}else{
		//alert("요청일 중에 중복된 날짜가 있습니다.");
		alert("요청 불가능한 일자 입니다.");
		
	}
}

//요청 수정한다 
function updateReqBk(){
	//수정한다.
	if(confirm("수정하시겠습니까?") == true){
		//Map 데이터 갱신
		if(syncG0101VOMap(true)){
			goAjax("/sjpb/G/insertUpdateReqBk.face", g0101VOMap, callBackUpdateReqBkSuccess);
		}
		
	}else{
		return;
	}
}

//요청 수정 성공 콜백함수
function callBackUpdateReqBkSuccess(data){
	//성공
	if(data.g0101VO.result == "01"){
		alert("수정성공!");
		selectList(g0101VOMap.dateSc);
	
	}else{
		//alert("요청일 중에 중복된 날짜가 있습니다.");
		alert("요청 불가능한 일자 입니다.");
		
	}
}

//요청자 수정 팝업
function setForcInveReqMbNm(){
	commonLayerPopup.openLayerPopup('/sjpb/Z/layerPopupList.face?chkType=radio', "700px", "600px", callBackSetForcInveReqMbNmSuccess); //담당수사관
}

//요청자 수정 팝업 성공 콜백함수
function callBackSetForcInveReqMbNmSuccess(data){
	var JsonData = JSON.parse(data);
	
	//ID 셋팅 
	$("#forsInveReqMb").val(JsonData.person[0].userId);
	
	//이름 셋팅 
	$("input[name=forcInveReqMbNm_TR2]").val(JsonData.person[0].userName);
}

//Map 데이터 갱신
function syncG0101VOMap(isValid) {
	
	//유효성체크 여부에 따라 체크함 
	if(isValid){
		//유효성 체크
		var chkObjs = $("#contentsArea tr[data-name=reqbk]");
		if(!chkValidate.check(chkObjs, true)) return;
	}
	
	//포렌식정보
	g0101VOMap.forsInveReqSiNum = $("#forsInveReqSiNum").val();		//포렌식조사의뢰일련번호
	
	g0101VOMap.forsInveReqStatCd = $("select[name=forsInveReqStatCd]").val();		//조사의뢰시작일자
	
	g0101VOMap.inveReqBeDt = $("input[name=inveReqBeDt]").val();		//조사의뢰시작일자
	g0101VOMap.inveReqEdDt = $("input[name=inveReqEdDt]").val();		//조사의뢰종료일자
	g0101VOMap.forsInveReqMb  = $("input[name=forsInveReqMb]").val();	//조사요청자
	
	g0101VOMap.dtaCollArea  = $("input[name=dtaCollArea]").val();		//자료수집지역
	g0101VOMap.incNum  = $("input[name=incNum]").val();					//사건번호
	g0101VOMap.reqComn  = $("textarea[name=reqComn]").val();			//요청비고
	
	return true;
	
}

//Map 데이터 갱신(지원불가)
function syncOffiSchdMngVOMap(isValid){
	
	//유효성체크 여부에 따라 체크함 
	if(isValid){
		//유효성 체크
		var chkObjs = $("#contentsArea tr[data-name=offischdmng]");
		if(!chkValidate.check(chkObjs, true)) return;
	}
	
	//일정관리정보
	offiSchdMngVOMap.schdMngSiNum = $("#schdMngSiNum").val();		//일정관리일련번호
	
	offiSchdMngVOMap.schdBeDt = $("input[name=schdBeDt]").val();		//일정시작일자
	offiSchdMngVOMap.schdEdDt = $("input[name=schdEdDt]").val();		//일정종료일자
	
	offiSchdMngVOMap.schdRsn = $("input[name=schdRsn]").val();			//일정사유
	offiSchdMngVOMap.schdComn = $("textarea[name=schdComn]").val();		//비고
	
	return true;
}

//초기화
function initG0101VOMap(){
	g0101VOMap = {
			forsInveReqSiNum : ""	//포렌식조사의뢰일련번호
			,inveReqBeDt : ""		//조사의뢰시작일자
			,inveReqEdDt : ""		//조사의뢰종료일자
			,inveFiDt : ""			//조사확정일자
			,forsInveReqStatCd : ""	//조사의뢰상태코드
			,forsInveReqMb : ""		//조사요청자
			,respCriOffi : ""		//담당수사관
			,dtaCollArea : ""		//자료수집지역
			,incNum : ""			//사건번호
			,reqComn : ""			//요청비고
			,regUserId : ""			//등록자
			,regDate : ""			//등록일자
			,updUserId : ""			//수정자
			,updDate : ""			//수정일자
			,forsInveReqBkVOList : null	//포렌식조사의뢰대장 리스트
			,forsInveOffiSchdMngVOList : null	//포렌식조사일정관리 리스트
		}
}

//초기화
function initreqBkVOMap(){
	reqBkVOMap ={
			forsInveReqSiNum : ""	//포렌식조사의뢰일련번호
			,inveReqBeDt : ""		//조사의뢰시작일자
			,inveReqEdDt : ""		//조사의뢰종료일자
			,inveFiDt : ""			//조사확정일자
			,forsInveReqStatCd : ""	//조사의뢰상태코드
			,forsInveReqMb : ""		//조사요청자
			,respCriOffi : ""		//담당수사관
			,dtaCollArea : ""		//자료수집지역
			,incNum : ""			//사건번호
			,reqComn : ""			//요청비고
			,regUserId : ""			//등록자
			,regDate : ""			//등록일자
			,updUserId : ""			//수정자
			,updDate : ""			//수정일자
		}
}

//초기화
function initoffiSchdMngVOMap(){
	offiSchdMngVOMap ={
			schdMngSiNum : ""	//일정관리일련번호
			,forsCriOffi : ""	//포렌식수사관(FK)
			,schdBeDt : ""		//일정시작일자
			,schdEdDt : ""		//일정종료일자
			,schdStatCd : "01"	//일정상태코드
			,schdRsn : ""		//일정사유
			,schdComn : ""		//비고
			,regUserId : ""		//등록자
			,regDate : ""		//등록일자
			,updUserId : ""		//수정자
			,updDate : ""		//수정일자

		}
}

//포렌식
var g0101VOMap = {
	forsInveReqSiNum : ""	//포렌식조사의뢰일련번호
	,inveReqBeDt : ""		//조사의뢰시작일자
	,inveReqEdDt : ""		//조사의뢰종료일자
	,inveFiDt : ""			//조사확정일자
	,forsInveReqStatCd : ""	//조사의뢰상태코드
	,forsInveReqMb : ""		//조사요청자
	,respCriOffi : ""		//담당수사관
	,dtaCollArea : ""		//자료수집지역
	,incNum : ""			//사건번호
	,reqComn : ""			//요청비고
	,regUserId : ""			//등록자
	,regDate : ""			//등록일자
	,updUserId : ""			//수정자
	,updDate : ""			//수정일자
	,forsInveReqBkVOList : null	//포렌식조사의뢰대장 리스트
	,forsInveOffiSchdMngVOList : null	//포렌식조사일정관리 리스트
}

//포렌식조사의뢰대장 VO
var reqBkVOMap ={
	forsInveReqSiNum : ""	//포렌식조사의뢰일련번호
	,inveReqBeDt : ""		//조사의뢰시작일자
	,inveReqEdDt : ""		//조사의뢰종료일자
	,inveFiDt : ""			//조사확정일자
	,forsInveReqStatCd : ""	//조사의뢰상태코드
	,forsInveReqMb : ""		//조사요청자
	,respCriOffi : ""		//담당수사관
	,dtaCollArea : ""		//자료수집지역
	,incNum : ""			//사건번호
	,reqComn : ""			//요청비고
	,regUserId : ""			//등록자
	,regDate : ""			//등록일자
	,updUserId : ""			//수정자
	,updDate : ""			//수정일자
}

//포렌식조사일정관리 VO
var offiSchdMngVOMap ={
	schdMngSiNum : ""	//일정관리일련번호
	,forsCriOffi : ""	//포렌식수사관(FK)
	,schdBeDt : ""		//일정시작일자
	,schdEdDt : ""		//일정종료일자
	,schdStatCd : "01"	//일정상태코드
	,schdRsn : ""		//일정사유
	,schdComn : ""		//비고
	,regUserId : ""		//등록자
	,regDate : ""		//등록일자
	,updUserId : ""		//수정자
	,updDate : ""		//수정일자

}



