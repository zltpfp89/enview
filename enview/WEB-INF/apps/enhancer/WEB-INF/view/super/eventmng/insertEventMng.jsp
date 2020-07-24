<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="com.saltware.enhancer.admin.event.model.EventMngVO" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.saltware.enview.multiresource.MultiResourceBundle"%>
<%@ page import="com.saltware.enview.multiresource.EnviewMultiResourceManager"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %> 
<%@ page import="com.saltware.enview.Enview" %> 

<%
  Map userInfoMap = null;
  userInfoMap = EnviewSSOManager.getUserInfoMap(request);
  String langKnd = (String)userInfoMap.get("lang_knd");
  String saUid = (String)userInfoMap.get("user_id");
  String siteName = (String)userInfoMap.get("site_name");
  MultiResourceBundle msgs = null;
  msgs = EnviewMultiResourceManager.getInstance().getBundle(langKnd);

  String flag = "Y";

  //이벤트시간 분리
  EventMngVO eventMngVO = (com.saltware.enhancer.admin.event.model.EventMngVO)request.getAttribute("eventMngVO");
  String startTime = (String)eventMngVO.getSTART_TIME();
  String startHour = (startTime.split(":"))[0];
  String startMin  = (startTime.split(":"))[1];
  String endTime = (String)eventMngVO.getEND_TIME();
  String endHour = (endTime.split(":"))[0];
  String endMin  = (endTime.split(":"))[1];

  request.setAttribute("menuAuth",flag);
  request.setAttribute("langKnd",langKnd);
  request.setAttribute("saUid",saUid);
  request.setAttribute("siteName",siteName);

  request.setAttribute("startHour",startHour);
  request.setAttribute("startMin",startMin);
  request.setAttribute("endHour",endHour);
  request.setAttribute("endMin",endMin);
 %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<title>이벤트관리</title>
<%-- <link href="<%=request.getContextPath()%>/hancer/css/super/event/cssbasic.css" rel="stylesheet" type="text/css" /> --%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/contents.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/super/event/objCalendarCtrl.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/super/event/jquery-1.4.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/super/event/validUtil.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/super/event/eventEdit.js"></script>
<script type="text/javascript">
<!--
	<c:if test="${!empty attachFileList}">
		<c:forEach items="${attachFileList}" var="fList">
			ebEdit.fileList += "<c:out value="${fList.FILE_MASK}"/>-<c:out value="${fList.FILE_SIZE}"/>";
		</c:forEach>
    </c:if>
	window.onload   = ebEdit.edit_init;
	window.onunload = ebEdit.edit_destroy;
//-->
</script>
<script type="text/javascript">
	var rootPath = '<c:out value="${pageContext.request.contextPath}"/>';
	var resPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/hancer";
	var actPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/hancer/event";
	var eventPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/event";
	var mainForm = document.getElementById("setTransfer");
	var lang_knd = '<c:out value="${paramMap.LANG_KND}"/>';
	
	//장소찾기 팝업
	function srchPlace(){
		var sUrl = eventPath+"/placePopUp.hanc?lang_knd="+lang_knd;
		var sStatus="toolbar=0,status=0,scrollbars=1,resizable=0";
		openWinCenter(sUrl,"_blank",600,350,sStatus);
	}
	
	//장소찿기팝업 리턴데이터 셋팅(학내검색)
	function setPlaceData(placeVal){
		var rtnVal = placeVal;
		if(rtnVal == ""){
			if(document.getElementById("mngMode").value == "WRITE" && document.getElementById("place").value == ""){
				alert('<%=msgs.getString("ev.hnevent.msg.event.noSelectPlace")%>');
			}	
			if(document.getElementById("mngMode").value == "MODIFY"){
				alert('<%=msgs.getString("ev.hnevent.msg.event.noChange")%>');
			}
		}else{
			//장소입력값에 동/장소명 셋팅
			document.getElementById("place").value = (rtnVal.split(':')[0]).split('/')[1];
			
			//저장시 전송될 장소정보 셋팅
			document.getElementById("placeNo").value = (rtnVal.split(':')[0]).split('/')[0];
			if(lang_knd == 'ko'){
				document.getElementById("placeNameKor").value = (rtnVal.split(':')[0]).split('/')[1];
				document.getElementById("placeNameEng").value = (rtnVal.split(':')[1]).split('/')[0];
			}
			if(lang_knd == 'en'){
				document.getElementById("placeNameEng").value = (rtnVal.split(':')[0]).split('/')[1];
				document.getElementById("placeNameKor").value = (rtnVal.split(':')[1]).split('/')[0];
			}
			document.getElementById("placeSubNo").value = (rtnVal.split(':')[1]).split('/')[1];
			document.getElementById("placeLat").value = (rtnVal.split(':')[1]).split('/')[2];
			document.getElementById("placeLon").value = (rtnVal.split(':')[1]).split('/')[3];
		}
	}
	
	//장소찾기팝업 리턴데이터 셋팅(직접입력)
	function setPlaceDataSelf(placeVal){
		var rtnVal = placeVal;
		if(rtnVal == ""){
			if(document.getElementById("mngMode").value == "WRITE" && document.getElementById("place").value == ""){
				alert('<%=msgs.getString("ev.hnevent.msg.event.noSelectPlace")%>');
			}	
			if(document.getElementById("mngMode").value == "MODIFY"){
				alert('<%=msgs.getString("ev.hnevent.msg.event.noChange")%>');
			}
		}else{
			//장소입력값에 장소명 셋팅
			document.getElementById("place").value = rtnVal;
			
			//저장시 전송될 장소정보 셋팅
			document.getElementById("placeNameKor").value = rtnVal;
			document.getElementById("placeNameEng").value = rtnVal;
			
			//직접입력시 장소명(KOR/ENG)을 제외한 정보는 없음
			document.getElementById("placeNo").value = "";
			document.getElementById("placeSubNo").value = "";
			document.getElementById("placeLat").value = "";
			document.getElementById("placeLon").value = "";
		}
	}

	//대상그룹 팝업
	function srchEvTarget(){
		var sTargetCd = document.getElementById("eventTargetCd").value;
		var sUrl = eventPath+"/selectGroupList.hanc?target_cd="+sTargetCd;
		var sStatus="toolbar=0,status=0,scrollbars=1,resizable=0";
		openWinCenter(sUrl,"_blank",450,500,sStatus)
	}
	
	//대상그룹 팝업 리턴데이터 셋팅
	function setEvTarget(targetVal){
		var rtnVal = targetVal;
		if(rtnVal == "" || (rtnVal.split('/')[0]) == ""){
			if(document.getElementById("mngMode").value == "WRITE" && document.getElementById("target").value == "")
				alert('<%=msgs.getString("ev.hnevent.msg.event.noSelectGroup")%>');
			if(document.getElementById("mngMode").value == "MODIFY")
				alert('<%=msgs.getString("ev.hnevent.msg.event.noChange")%>');
		}else{
			//저장시 전송될 대상그룹정보 셋팅 :: eventTargetCd를','를 구분자로 merge / eventTargetNm을','를 구분자로 merge ->서버에서 파싱하여 사용
			var gpCode = rtnVal.split('/')[0]; //그룹코드
			var gpName = rtnVal.split('/')[1]; //그룹명
			document.getElementById("eventTargetCd").value = gpCode;
			document.getElementById("eventTargetNm").value = gpName;
			document.getElementById("target").value = gpName;
		}
	}
	
	//이벤트삭제처리(상태변경)
	function deleteEvent(){
		if(confirm('<%=msgs.getString("ev.hnevent.msg.event.delete")%>')){
			var seq = document.getElementById("eventSeq").value;
			$.ajax({ 
			   type: "POST", 
			   url: actPath+"/deleteEvent.hanc", 
			   data: "EVENT_SEQ="+seq,
			   dataType:"text",
			   success: function(data){ 
					if(data == 'NoError'){
						if(lang_knd == 'ko')
							alert("삭제되었습니다.");
						if(lang_knd == 'en')
							alert("Deleted.");
					}else{
						alert(data);
					}
					//삭제후 목록으로 이동
					backToAppList();
			   }, 
			   error: function(request, status, error) {
					alert('<%=msgs.getString("ev.hnevent.msg.event.deleteError")%>');
					alert(request.responseText);
			   }
			});
		}else{
			return;
		}
	}

	//게시기간 Delimeter 삭제
	function delDateMask(){
		maskOff(document.getElementById("date1").id);
		maskOff(document.getElementById("date2").id);
		maskOff(document.getElementById("date3").id);
		maskOff(document.getElementById("date4").id);
	}
	
	//게시기간 유효성 검사 실패시 Delimeter 삽입
	function addDateMask(){
		maskOn(document.getElementById("date1").id);
		maskOn(document.getElementById("date2").id);
		maskOn(document.getElementById("date3").id);
		maskOn(document.getElementById("date4").id);
	}

	//이벤트 데이터 검사 & 저장
	function saveEvent(){
		if(document.getElementById('adminRole').value == 'Y') {
			document.getElementById('DOMAIN_ID').value = document.getElementById("domain").options[document.getElementById("domain").selectedIndex].value;
		}
		
		//이미지파일 여부검사
		var imgKor = document.getElementById('imgfile').value;
		var imgEng = document.getElementById('imgfile2').value;
		var lang_knd = '<c:out value="${paramMap.LANG_KND}"/>';
		if(imgKor !=""){
			if(!isImageFile(imgKor)){
				if(lang_knd == 'ko')
					alert('<%=msgs.getString("ev.hnevent.msg.event.invalidFile")%>');
				if(lang_knd == 'en')
					alert('<%=msgs.getString("ev.hnevent.msg.event.invalidFile")%>');

				document.getElementById('imgfile').focus();
				return;
			}
		}
		if(imgEng !=""){
			if(!isImageFile(imgEng)){
				if(lang_knd == 'ko')
					alert('<%=msgs.getString("ev.hnevent.msg.event.invalidFile")%>');
				if(lang_knd == 'en')
					alert('<%=msgs.getString("ev.hnevent.msg.event.invalidFile")%>');

				document.getElementById('imgfile2').focus();
				return;
			}
		}

		//카테고리
		if(document.getElementById("category").options[document.getElementById("category").selectedIndex].value == -1){
			alert('<%=msgs.getString("ev.hnevent.msg.event.selectCategory")%>');
			document.getElementById("category").focus();
			return;
		}
		//장소
		if(document.getElementById('place').value == ""){
			alert('<%=msgs.getString("ev.hnevent.msg.event.enterPlace")%>');
			return;
		}
		//제목(국문)
		if(document.getElementById("subject").value == ""){
			alert('<%=msgs.getString("ev.hnevent.msg.event.enterSubjectKor")%>');
			document.getElementById("subject").focus();
			return;
		}
		//제목(영문)
		if(document.getElementById("subject_en").value == ""){
			alert('<%=msgs.getString("ev.hnevent.msg.event.enterSubjectEng")%>');
			document.getElementById("subject_en").focus();
			return;
		}
		
		//이메일주소 형식검사(값이 있을때만 검사)
		var email = document.getElementById('email').value;
		if(email != ""){
			if(!emailCheck(email)){
				alert('<%=msgs.getString("ev.hnevent.msg.event.emailCheck")%>');
				document.getElementById('email').focus();
				return;
			}
		}

		//대상그룹
		if(document.getElementById('target').value == ""){
			alert('<%=msgs.getString("ev.hnevent.msg.event.enterTargetGroup")%>');
			return;
		}
		//내용(국문)
		var cnttKor = FCKeditorAPI.GetInstance('content_ko').GetData();
		if (cnttKor == "" || cnttKor == "<br />" || cnttKor == "&nbsp;"){
			alert('<%=msgs.getString("ev.hnevent.msg.event.enterContentKor")%>');
			FCKeditorAPI.GetInstance("content_ko").Focus();
			return false;
		}
		
		//시간:Hour+Minute-->4자리숫자(2012.01.29)
		var startTime = document.getElementById("startHour").options[document.getElementById("startHour").selectedIndex].value 
					  + document.getElementById("startMin").options[document.getElementById("startMin").selectedIndex].value;
		var endTime   = document.getElementById("endHour").options[document.getElementById("endHour").selectedIndex].value 
					  + document.getElementById("endMin").options[document.getElementById("endMin").selectedIndex].value;
		if(startTime > endTime){
			alert('<%=msgs.getString("ev.hnevent.msg.event.checkTime")%>');
			document.getElementById('startHour').focus();
			return false;
		}

		//기간
		delDateMask();
		var startDate = document.getElementById('date1').value;	 //시작일
		var endDate   = document.getElementById('date2').value;  //종료일
		if(startDate > endDate){
			alert('<%=msgs.getString("ev.hnevent.msg.event.checkPeriod")%>');
			addDateMask();
			return;
		}
		
		//시간:Hour+Minute-->4자리숫자(2012.01.29)
		var startEventTime = document.getElementById("startEventHour").options[document.getElementById("startEventHour").selectedIndex].value 
					  + document.getElementById("startEventMin").options[document.getElementById("startEventMin").selectedIndex].value;
		var endEventTime   = document.getElementById("endEventHour").options[document.getElementById("endEventHour").selectedIndex].value 
					  + document.getElementById("endEventMin").options[document.getElementById("endEventMin").selectedIndex].value;
		if(startTime > endTime){
			alert('<%=msgs.getString("ev.hnevent.msg.event.checkTime")%>');
			document.getElementById('starEventtHour').focus();
			return false;
		}

		//기간
		delDateMask();
		var startEventDate = document.getElementById('date3').value;	 //시작일
		var endEventDate   = document.getElementById('date4').value;  //종료일
		if(startDate > endDate){
			alert('<%=msgs.getString("ev.hnevent.msg.event.checkPeriod")%>');
			addDateMask();
			return;
		}

		//byteCheck(제목국문,제목영문,링크,참가비국문,참가비영문,이름,전화번호,이메일) : 2byte여유를 둠.
		var titleKorByteLen = byteLengthCheck(document.getElementById("subject").value);	//298
		var titleEngByteLen = byteLengthCheck(document.getElementById("subject_en").value); //298
		var linkByteLen     = byteLengthCheck(document.getElementById("link").value);		//253
		var feeKorByteLen   = byteLengthCheck(document.getElementById("eventFeeKor").value);//98
		var feeEngByteLen   = byteLengthCheck(document.getElementById("eventFeeEng").value);//98
		var ownNameByteLen  = byteLengthCheck(document.getElementById("name").value);		//28
		var ownPhoneByteLen = byteLengthCheck(document.getElementById("phone").value);		//28
		var ownEmailByteLen = byteLengthCheck(document.getElementById("email").value);		//98
		if(titleKorByteLen > 298){
			alert('<%=msgs.getString("ev.hnevent.msg.event.byteChkTitleKor")%>');
			addDateMask();
			document.getElementById('subject').focus();
			return;
		}
		if(titleEngByteLen > 298){
			alert('<%=msgs.getString("ev.hnevent.msg.event.byteChkTitleEng")%>');
			addDateMask();
			document.getElementById('subject_en').focus();
			return;
		}
		if(linkByteLen > 253){
			alert('<%=msgs.getString("ev.hnevent.msg.event.byteChkLink")%>');
			addDateMask();
			document.getElementById('link').focus();
			return;
		}
		if(feeKorByteLen > 98){
			alert('<%=msgs.getString("ev.hnevent.msg.event.byteChkEventFeeKor")%>');
			addDateMask();
			document.getElementById('eventFeeKor').focus();
			return;
		}
		if(feeEngByteLen > 98){
			alert('<%=msgs.getString("ev.hnevent.msg.event.byteChkEventFeeEng")%>');
			addDateMask();
			document.getElementById('eventFeeEng').focus();
			return;
		}
		if(ownNameByteLen > 28){
			alert('<%=msgs.getString("ev.hnevent.msg.event.byteChkOwnerName")%>');
			addDateMask();
			document.getElementById('name').focus();
			return;
		}
		if(ownPhoneByteLen > 28){
			alert('<%=msgs.getString("ev.hnevent.msg.event.byteChkOwnerPhone")%>');
			addDateMask();
			document.getElementById('phone').focus();
			return;
		}
		if(ownEmailByteLen > 28){
			alert('<%=msgs.getString("ev.hnevent.msg.event.byteChkOwnerEmail")%>');
			addDateMask();
			document.getElementById('email').focus();
			return;
		}

		//추가,수정화면에 대한 구분자(insertEventByUser:add / insertEventMng:mod)
		document.getElementById("msgType").value = "mod";

		//js파일의 저장메서드 호출
		ebEdit.save();
	}

	//Input Field ByteCheck(2012.01.25):영문/특수문자 1byte , 한글 3byte
	function byteLengthCheck(message) {
		var nbytes = 0;

		for (i=0; i<message.length; i++) {
			var ch = message.charAt(i);
			if (escape(ch).length > 4) {
				nbytes += 3;
			} else if (ch != '\r') {
				nbytes++;
			}
		}

		return nbytes;
	}

	//목록버튼클릭시 승인목록으로 이동
	function backToAppList(){
		document.getElementById("eventListFrom").submit();
	}

	//주요이벤트 사용여부 검사(이벤트관리자만 사용:2012.01.16)
	function checkAble(){
		var useYn = '<c:out value="${menuAuth}"/>';
		var chkYn = '<c:out value="${eventMngVO.PRIORTY}"/>'; //Y , N
		
		if(useYn != 'show'){
			<%-- alert('<%=msgs.getString("ev.hnevent.msg.event.regMajorEvent")%>'); --%>
			if(chkYn == 'Y')
				document.getElementById("banner").checked = true;
			if(chkYn == 'N')
				document.getElementById("banner").checked = false;
			return;
		}else{
			if(chkYn == 'N'){
				//현재등록된 주요이벤트 갯수 조회하여 가능여부 판별(2012.01.17)
				$.ajax({ 
				   type: "POST", 
				   url: actPath+"/selectMainEventCnt.hanc", 
				   data: null,
				   dataType:"json",
				   success: function(data){ 
						if(data.msg == 'NoError'){
							if(data.cnt >= 7){
								alert("주요이벤트는 최근30일 이내 7건만 등록 가능합니다.");
								document.getElementById("banner").checked = false;
							}
							if(data.cnt < 7){
								document.getElementById("banner").checked = true;
							}
						}else{
							alert(data.msg);
							document.getElementById("banner").checked = false;
						}	
				   }, 
				   error: function(request, status, error) {
						alert('<%=msgs.getString("ev.hnevent.msg.event.networkError")%>');
						document.getElementById("banner").checked = false;
				   }
				});
			}
		}
	}

	//파일첨부 확장자 체크
	function checkExt(){
		var ext = document.getElementById("attachfile").value;
		var startIdx = ext.lastIndexOf(".")+1;
		ext = ext.substring(startIdx,ext.length);
		ext = ext.toLowerCase();
		
		if(ext == "txt" || ext == "pdf" || ext == "hwp" || ext == "doc" || ext == "docx" || ext == "xls" || ext == "xlsx" || ext == "ppt" || ext == "pptx" || ext == "zip" || ext == "7z" || ext=="jpg" || ext=="jpeg" || ext=="gif" || ext=="bmp" || ext=="png" || ext=="tif") {
			ebEdit.uploadFile();
		} else {
			if(lang_knd == 'ko')
				alert("업로드가 제한된 파일확장자 입니다.\n(가능파일:txt,pdf,hwp,doc,docx,xls,xlsx,ppt,pptx,zip,7z)");
			if(lang_knd == 'en')
				alert("It is the file extension that can not upload.");
			return; 
		}
	}

	//영문제목 한글체크
	function checkHangul(obj){
		var str = obj.value;
		var flag = false;
		for (i = 0; i < str.length; i++) 
		{
		 
			if (!((str.charCodeAt(i) > 0x3130 && str.charCodeAt(i) < 0x318F) || (str.charCodeAt(i) >= 0xAC00 && str.charCodeAt(i) <= 0xD7A3)))  
				flag = true;
			else
				flag = false;
		}

		if(!flag){
			if(lang_knd == 'ko')
				alert("영문제목에 한글을 입력할 수 없습니다.");
			if(lang_knd == 'en')
				alert("You can't enter Korean with English title.");
			document.getElementById("subject_en").value = "";
		}
		event.returnValue = flag;
	}
</script>
</head>
<body style="min-width:1000px;">
	<!-- sub_contents -->
	<div class="sub_contents">
		<!-- detail -->
		<div class="detail">
			<!-- board first -->
			<div class="board first">
				<!-- searchArea-->
				<div class="tsearchArea">
					<!--pageTitle -->
					<h1><%=msgs.getString("ev.hnevent.label.addEvent")%></h1>
					<!--pageTitle// -->
				</div>
				<!-- searchArea//-->
				<!-- EventData 최종저장 -->
				<div style="overflow:hidden; padding:15px 0 0 0; width:1250px;">
					<div class="banner1" style="width:200px; float:left;">
						<form name="setTransfer" id="setTransfer" method="post" action="<%=request.getContextPath()%>/event/insertEvent.hanc" enctype="multipart/form-data">
							<input type="hidden" id="mngMode" name="mngMode" value="<c:out value="${paramMap.mngMode}"/>"/><!--추가or수정-->
							<input type="hidden" id="userType"name="userType" value="<c:out value="${paramMap.userType}"/>"/><!--일반or관리자-->
							<input type="hidden" id="studentYn" name="studentYn" value="<c:out value="${paramMap.studentYn}"/>"/><!--학생여부-->
							<input type="hidden" id="eventSeq"name="eventSeq"value="<c:out value="${eventMngVO.EVENT_SEQ}"/>"/>
							<input type="hidden" id="priorty"name="priorty"value="<c:out value="${eventMngVO.PRIORTY}"/>"/>
							<input type="hidden" id="cateCd"  name="cateCd"  value="<c:out value="${eventMngVO.CATEGORY_SEQ}"/>"/>
							<input type="hidden" id="stdDate" name="stdDate" value="<c:out value="${eventMngVO.START_DATE}"/>"/>
							<input type="hidden" id="endDate" name="endDate" value="<c:out value="${eventMngVO.END_DATE}"/>"/>
							<input type="hidden" id="stdTime" name="stdTime" value="<c:out value="${eventMngVO.START_TIME}"/>"/>
							<input type="hidden" id="endTime" name="endTime" value="<c:out value="${eventMngVO.END_TIME}"/>"/>
							<input type="hidden" id="deptCdKor"  name="deptCdKor"  value="<c:out value="${eventMngVO.DEPT_CODE_KOR}"/>"/>
							<input type="hidden" id="deptCdEng"  name="deptCdEng"  value="<c:out value="${eventMngVO.DEPT_CODE_ENG}"/>"/>
							<input type="hidden" id="writerId" name="writerId" value="<c:out value="${eventMngVO.REG_USER_ID}"/>"/>
							<input type="hidden" id="writerNm" name="writerNm" value="<c:out value="${eventMngVO.REG_USER_NM}"/>"/>
							<input type="hidden" id="placeNo"  name="placeNo"  value="<c:out value="${eventMngVO.PLACE_NO}"/>"/>
							<input type="hidden" id="placeSubNo" name="placeSubNo" value="<c:out value="${eventMngVO.PLACE_SUB_NO}"/>"/>
							<input type="hidden" id="placeSubNm"  name="placeSubNm"  value="<c:out value="${eventMngVO.PLACE_NM}"/>"/><!--장소상세2012.01.28-->
							<input type="hidden" id="placeNameKor"  name="placeNameKor"  value="<c:out value="${eventMngVO.PLACE_BUILDING_KOR}"/>"/>
							<input type="hidden" id="placeNameEng"  name="placeNameEng"  value="<c:out value="${eventMngVO.PLACE_BUILDING_ENG}"/>"/>
							<input type="hidden" id="placeLat"   name="placeLat"   value="<c:out value="${eventMngVO.PLACE_LATITUDE}"/>"/>
							<input type="hidden" id="placeLon"   name="placeLon"   value="<c:out value="${eventMngVO.PLACE_LONGITUDE}"/>"/>
							<input type="hidden" id="eventNmKor" name="eventNmKor" value="<c:out value="${eventMngVO.TITLE_KOR}"/>"/>
							<input type="hidden" id="eventNmEng" name="eventNmEng" value="<c:out value="${eventMngVO.TITLE_ENG}"/>"/>
							<input type="hidden" id="targetLink" name="targetLink" value="<c:out value="${eventMngVO.TARGET_LINK}"/>"/>
							<input type="hidden" id="eventTargetCd" name="eventTargetCd" value="<c:out value="${eventTartgetList.eventTargetCd}"/>"/>
							<input type="hidden" id="eventTargetNm" name="eventTargetNm" value="<c:out value="${eventTartgetList.eventTargetNm}"/>"/>
							<input type="hidden" id="ownerName"  name="ownerName"  value="<c:out value="${eventMngVO.OWNER_USER_ID}"/>"/>
							<input type="hidden" id="ownerPhone" name="ownerPhone" value="<c:out value="${eventMngVO.OWNER_PHONE}"/>"/>
							<input type="hidden" id="ownerEmail" name="ownerEmail" value="<c:out value="${eventMngVO.OWNER_EMAIL}"/>"/>
							<input type="hidden" id="eventCnttKor" name="eventCnttKor" value="<c:out value="${eventMngVO.CONTENTS_KOR}"/>"/>
							<input type="hidden" id="eventCnttEng" name="eventCnttEng" value="<c:out value="${eventMngVO.CONTENTS_ENG}"/>"/>
							<input type="hidden" id="feeKor"   name="feeKor"   value="<c:out value="${eventMngVO.EVENT_FEE_KOR}"/>"/>
							<input type="hidden" id="feeEng"   name="feeEng"   value="<c:out value="${eventMngVO.EVENT_FEE_ENG}"/>"/>
							<input type="hidden" id="attachNo" name="attachNo" value="<c:out value="${eventMngVO.ATTACH_NO}"/>"/>
							<input type="hidden" id="fileName" name="fileName" value="<c:out value=""/>"/>
							<input type="hidden" id="fileMask" name="fileMask" value="<c:out value=""/>"/>
							<input type="hidden" id="fileSize" name="fileSize" value="<c:out value=""/>"/>
							<input type="hidden" id="langKnd" name="langKnd" value="<c:out value="${langKnd}"/>"/>
							<input type="hidden" id="msgYn" name="msgYn" value="<c:out value="${paramMap.msgYn}"/>"/>
							<input type="hidden" id="msgType" name="msgType" value="<c:out value="${paramMap.msgType}"/>"/>
							<input type="hidden" id="movePath" name="movePath" value="<c:out value="${movePath}"/>"/>
							<input type="hidden" id="EventStdDate" name="EventStdDate" value="<c:out value="${eventMngVO.EVENT_START_DATE}"/>"/>
							<input type="hidden" id="EventEndDate" name="EventEndDate" value="<c:out value="${eventMngVO.EVENT_END_DATE}"/>"/>
							<input type="hidden" id="EventStdTime" name="EventStdTime" value="<c:out value="${eventMngVO.EVENT_START_TIME}"/>"/>
							<input type="hidden" id="EventEndTime" name="EventEndTime" value="<c:out value="${eventMngVO.EVENT_END_TIME}"/>"/>
							<input type="hidden" id="DOMAIN_ID"  name="DOMAIN_ID"  value="<c:out value="${eventMngVO.DOMAIN_ID}"/>"/>
							<input type="hidden" id="adminRole"  name="adminRole"  value="<c:out value="${adminRole}"/>"/>
							
							<!-- 이미지국문 -->
							<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
								<tr>
									<th class="L"><%=msgs.getString("ev.hnevent.label.imageKor")%></th>
									<td class="L">
										<c:if test="${eventMngVO.IMAGE_PATH_KOR !=null}">
											<img src="<%=request.getContextPath()%><c:out value='${eventMngVO.IMAGE_PATH_KOR}'/>" alt="이벤트썸네일이미지" />
										</c:if>
									</td>												
								</tr>
								<tr>
									<td class="L">
										<input type="file" title="thumbkor" style="width:145px;" name="thumbKor" onchange="document.getElementById('imgfile').value = this.value;" />
										<input type="text" title="image file" class="txt_145" name="imgfile" id="imgfile" readonly/> <!-- <a class="btn_B"></a> -->
									</td>						
								</tr>
							</table>
							<!-- 이미지국문// -->
							<!-- 이미지영문 -->
							<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
								<tr>
									<th class="L"><%=msgs.getString("ev.hnevent.label.imageEng")%></th>
									<td class="L">
										<c:if test="${eventMngVO.IMAGE_PATH_ENG !=null}">
											<img src="<%=request.getContextPath()%><c:out value='${eventMngVO.IMAGE_PATH_ENG}'/>" alt="이벤트썸네일이미지" />
										</c:if>
									</td>										
								</tr>
								<tr>
									<td class="L">
										<input type="file" title="thumbeng" style="width:145px;" name="thumbEng" onchange="document.getElementById('imgfile2').value = this.value;" />
										<input type="text" title="image file" class="txt_145" name="imgfile2" id="imgfile2" readonly/>
									</td>						
								</tr>
							</table>
							<!-- 이미지영문// -->
						</form>	
						<!-- EventData 최종저장// -->
						<!-- 파일첨부 -->
						<!-- attachFileList -->
						<form name="setFileList" method="post" target="invisible" action="<%=request.getContextPath()%>/event/fileMgr?cmd=delete">
							<input type="hidden" name="vaccum">
							<input type="hidden" name="unDelList">
							<input type="hidden" name="delList">				
							<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
								<tr>
									<th class="L"><%=msgs.getString("ev.hnevent.label.attachFile")%></th>
								</tr>
								<tr>
									<td class="L">
										<div class="sel_145">
											<select name="list" size="5" multiple="multiple" id="list" class="txt_145">
												<option value="-1" style="background-color:#444444;color:white;">Upload List</option>
												<c:if test="${paramMap.mngMode == 'MODIFY'}">
													<c:forEach items="${attachFileList}" var="fList">
														<option value="<c:out value="${fList.FILE_MASK}"/>-<c:out value="${fList.FILE_SIZE}"/>"><c:out value="${fList.FILE_NM}"/></option>
													</c:forEach>
												</c:if>
												<option></option>
												<option></option>
												<option></option>
												<option></option>
												<option></option>
											</select>
										</div>							
									</td>						
								</tr>
							</table>
						</form>
						<!-- attachFileList// -->
						<!-- attachFile -->
						<form name="setUpload" method="post" target="invisible" enctype="multipart/form-data" action="<%=request.getContextPath()%>/event/fileMgr?cmd=upload">
							<input type="hidden" name="mode" value="attach"/>
							<input type="hidden" name="totalsize" value="0"/>				
							<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
								<tr>
									<td class="L">
										<input type="file" title="filename" style="width:145px;" name="filename" onchange="document.getElementById('attachfile').value = this.value;" />
										<input type="text" title="attach file" class="txt_145" name="attachfile" id="attachfile" /> <!-- <a class="btn_B"></a> -->
									</td>
								</tr>
								<tr>
									<td class="L">
										<a href="#" onclick="ebEdit.deleteFile()" class="btn_B"><span><%=msgs.getString("ev.hnevent.label.delete")%></span></a> 
										<a href="#" onclick="checkExt()" class="btn_B"><span><%=msgs.getString("ev.hnevent.label.add")%></span></a>
									</td>						
								</tr>						
							</table>
						</form>
						<!-- attachFile// -->
						<!-- 파일첨부// -->
					</div>
					<div class="form1" style="width:800px; float:right; margin-right:230px; background:#fff;">
						<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
							<caption>게시판</caption>
							<colgroup>
								<col width="15%" />
								<col width="28%" />
								<col width="14%" />
								<col width="*" />
							</colgroup>
							<c:if test="${adminRole == 'Y'}">
								<tr>
									<th class="C" scope="row">
										<%=msgs.getString("ev.hnevent.label.domainNm")%> <em>*</em>
									</th>
									<td class="L" colspan="3">
										<div class="sel_100">
											<select id="domain" name="domain" class="txt_100">
												<c:forEach items="${domainList}" var="domainInfo">
													<option value="<c:out value="${domainInfo.domainId}"/>" <c:if test="${eventMngVO.DOMAIN_ID eq domainInfo.domainId}">selected</c:if>><c:out value="${domainInfo.domainNm}"/></option>
												</c:forEach>
											</select>
										</div>
									</td>		
								</tr>
							</c:if>
							<tr>
								<th class="C" scope="row"><%=msgs.getString("ev.hnevent.label.category")%> <em>*</em></th>
								<td class="L" >
									<div class="sel_100">
										<select name="category" id="category" class="txt_100">
											<option value="-1"></option>
											<c:if test="${menuAuth == 'Y'}">
												<c:forEach items="${cateCodeList}" var="data">
													<option value="<c:out value="${data.CATEGORY_SEQ}"/>" <c:if test="${eventMngVO.CATEGORY_SEQ eq data.CATEGORY_SEQ}">selected</c:if>><c:out value="${data.CATEGORY_NM}"/></option>
												</c:forEach>
											</c:if>
											<c:if test="${menuAuth == 'N'}">
												<c:forEach items="${cateCodeList}" var="data">
													<c:if test="${data.CATEGORY_SEQ != '15'}">
														<option value="<c:out value="${data.CATEGORY_SEQ}"/>" <c:if test="${eventMngVO.CATEGORY_SEQ eq data.CATEGORY_SEQ}">selected</c:if>><c:out value="${data.CATEGORY_NM}"/></option>
													</c:if>
												</c:forEach>
											</c:if>
										</select>
									</div>
								</td>
								<th class="C" scope="row">
									게시기간 <em>*</em>
								</th>
								<td class="L">
									<input type="text" title="date" style="width:70px;" name="date1" id="date1" value="<c:out value="${eventMngVO.START_DATE}"/>" readonly /> 
									<a id = "calendar_switch" href="#btn" style="cursor:pointer;" onclick="javascript:Calendar_Create('date1','<c:out value="${paramMap.LANG_KND}"/>','calendar_switch');">
										<img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_carlendar.gif" alt="기간선택" />
									</a> 
									~ 
									<input type="text" title="date" style="width:70px;" name="date2" id="date2" value="<c:out value="${eventMngVO.END_DATE}"/>" readonly /> 
									<a id = "calendar_switch1" href="#btn" style="cursor:pointer;" onclick="javascript:Calendar_Create('date2','<c:out value="${paramMap.LANG_KND}"/>','calendar_switch1');">
										<img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_carlendar.gif" alt="기간선택" />
									</a>
								</td>
							</tr>
							<tr>
								<th class="C" scope="row">
									<%=msgs.getString("ev.hnevent.label.admin")%>
								</th>
								<td class="L">
									<c:out value="${eventMngVO.REG_USER_NM}"/>
								</td>
								<th class="C" scope="row">
									<%=msgs.getString("ev.hnevent.label.time")%>
								</th>
								<td class="L">
									<div class="sel_50">
										<select name="startHour" id="startHour" class="txt_50">
											<c:forEach items="${hourCodeList}" var="data">
												<option value="<c:out value="${data.CODE}"/>" <c:if test="${startHour eq data.CODE}">selected</c:if>><c:out value="${data.CODE_NAME}"/></option>
											</c:forEach>
										</select>
									</div>
									<div class="sel_50">	
										<select name="startMin" id="startMin" class="txt_50">
											<c:forEach items="${minuteCodeList}" var="data">
												<option value="<c:out value="${data.CODE}"/>" <c:if test="${startMin eq data.CODE}">selected</c:if>><c:out value="${data.CODE_NAME}"/></option>
											</c:forEach>
										</select>
									</div>
									<span class="sel_txt"> ~ </span>  
									<div class="sel_50">
										<select name="endHour" id="endHour" class="txt_50">
											<c:forEach items="${hourCodeList}" var="data">
												<option value="<c:out value="${data.CODE}"/>" <c:if test="${endHour eq data.CODE}">selected</c:if>><c:out value="${data.CODE_NAME}"/></option>
											</c:forEach>
										</select>
									</div>
									<div class="sel_50">
										<select name="endMin" id="endMin" class="txt_50">
											<c:forEach items="${minuteCodeList}" var="data">
												<option value="<c:out value="${data.CODE}"/>" <c:if test="${endMin eq data.CODE}">selected</c:if>><c:out value="${data.CODE_NAME}"/></option>
											</c:forEach>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<th class="C" scope="row">
									<%=msgs.getString("ev.hnevent.label.state")%>
								</th>
								<td class="L">
									<c:out value="${eventMngVO.STATE_NM}"/>&nbsp;
								</td>
								<th class="C" scope="row">
									<%=msgs.getString("ev.hnevent.label.majorEvents")%>
								</th>
								<td class="L">
									<input type="checkbox" name="banner" id="banner" value="" onclick="checkAble()" <c:if test="${eventMngVO.PRIORTY == 'Y'}">checked</c:if> />
								</td>
							</tr>
							<tr>
								<th class="C" scope="row">
									행사기간 <em>*</em>
								</th>
								<td class="L" colspan="3">
									<span class="sel_txt">
										<input type="text" title="date" style="width:70px;" name="date3" id="date3" value="<c:out value="${eventMngVO.EVENT_START_DATE}"/>" readonly /> 
										<a id="calendar_switch2" href="#btn" style="cursor:pointer;" onclick="javascript:Calendar_Create('date3','<c:out value="${paramMap.LANG_KND}"/>','calendar_switch2');">
											<img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_carlendar.gif" alt="기간선택" />
										</a> 
										~
										<input type="text" title="date" style="width:70px;" name="date4" id="date4" value="<c:out value="${eventMngVO.EVENT_END_DATE}"/>" readonly /> 
										<a id='calendar_switch3'  href="#btn" style="cursor:pointer;" onclick="javascript:Calendar_Create('date4','<c:out value="${paramMap.LANG_KND}"/>','calendar_switch3');">
											<img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_carlendar.gif" alt="기간선택" />
										</a>
									</span>
									<div class="sel_70">
										<select name="startEventHour" id="startEventHour" class="txt_70">
											<c:forEach items="${hourCodeList}" var="data">
												<option value="<c:out value="${data.CODE}"/>" <c:if test="${startHour eq data.CODE}">selected</c:if>><c:out value="${data.CODE_NAME}"/></option>
											</c:forEach>
										</select>
									</div>
									<div class="sel_70">
										<select name="startEventMin" id="startEventMin" class="txt_70">
											<c:forEach items="${minuteCodeList}" var="data">
												<option value="<c:out value="${data.CODE}"/>" <c:if test="${startMin eq data.CODE}">selected</c:if>><c:out value="${data.CODE_NAME}"/></option>
											</c:forEach>
										</select>
									</div>
									<span class="sel_txt"> ~ </span>  
									<div class="sel_70">
										<select name="endEventHour" id="endEventHour" class="txt_70">
											<c:forEach items="${hourCodeList}" var="data">
												<option value="<c:out value="${data.CODE}"/>" <c:if test="${endHour eq data.CODE}">selected</c:if>><c:out value="${data.CODE_NAME}"/></option>
											</c:forEach>
										</select>
									</div>
									<div class="sel_70">
										<select name="endEventMin" id="endEventMin" class="txt_70">
											<c:forEach items="${minuteCodeList}" var="data">
												<option value="<c:out value="${data.CODE}"/>" <c:if test="${endMin eq data.CODE}">selected</c:if>><c:out value="${data.CODE_NAME}"/></option>
											</c:forEach>
										</select>
									</div>							
								</td>
							</tr>								
							<tr>
								<th class="C" scope="row">
									<%=msgs.getString("ev.hnevent.label.where")%> <em>*</em>
								</th>
								<td class="L">
									<input type="text" name="place" id="place" class="txt_100" readonly onclick="srchPlace();"
											<c:if test="${paramMap.LANG_KND eq 'ko'}">value="<c:out value="${eventMngVO.PLACE_BUILDING_KOR}"/>"</c:if>
											<c:if test="${paramMap.LANG_KND eq 'en'}">value="<c:out value="${eventMngVO.PLACE_BUILDING_ENG}"/>"</c:if> /> 
									<a href="#linkPlace" style="cursor:pointer;" onclick="javascript:srchPlace();" class="btn_search"><span><%=msgs.getString("ev.hnevent.label.search")%></span></a>
								</td>
								<th class="C" scope="row"><%=msgs.getString("ev.hnevent.label.placeSub")%></th>
								<td class="L" >
									<input type="text" id="placeSub" name="placeSub" class="txt_100" value="<c:out value="${eventMngVO.PLACE_NM}"/>"/>
								</td>						
							</tr>
						</table>
						<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
							<caption>게시판</caption>
							<colgroup>
								<col width="15%" />
								<col width="*" />
							</colgroup>
							<tr>
								<th class="C" scope="row">
									<%=msgs.getString("ev.hnevent.label.titleKor")%> <em>*</em>
								</th>
								<td class="L" class="subject">
									<input type="text" name="subject" id="subject" class="txt_600" value="<c:out value="${eventMngVO.TITLE_KOR}"/>" />
								</td>
							</tr>
							<tr>
								<th class="C" scope="row">
									<%=msgs.getString("ev.hnevent.label.titleEng")%> <em>*</em>
								</th>
								<td class="L">
									<input type="text" name="subject_en" id="subject_en" class="txt_600" onkeyup="checkHangul(this);" value="<c:out value="${eventMngVO.TITLE_ENG}"/>" />
								</td>
							</tr>
							<tr>
								<th class="C" scope="row">
									<%=msgs.getString("ev.hnevent.label.link")%>
								</th>
								<td class="L">
									<c:if test="${!empty eventMngVO.TARGET_LINK}"><input type="text" name="link" id="link" class="txt_600" value="<c:out value="${eventMngVO.TARGET_LINK}"/>"/></c:if>
									<c:if test="${empty eventMngVO.TARGET_LINK}"><input type="text" name="link" id="link" class="txt_600" value="http://" /></c:if>
								</td>
							</tr>
							<tr>
								<th class="C" scope="row">
									<%=msgs.getString("ev.hnevent.label.target")%> <em>*</em>
								</th>
								<td class="L">
									<input type="text" name="target" id="target"  class="txt_200" readonly onclick="srchEvTarget();" value="<c:out value="${eventTartgetList.eventTargetNm}"/>" /> 
									<a href="#linkTarget" style="cursor:pointer;" onclick="javascript:srchEvTarget();" class="btn_B"><span><%=msgs.getString("ev.hnevent.label.add")%></span></a>
								</td> 
							</tr>
							<tr>
								<th class="C" scope="row">
									<%=msgs.getString("ev.hnevent.label.costKor")%>
								</th>
								<td class="L">
									<input type="text" name="eventFeeKor" id="eventFeeKor" class="txt_200" value="<c:out value="${eventMngVO.EVENT_FEE_KOR}"/>" />
								</td>
							</tr>
							<tr>
								<th class="C" scope="row">
									<%=msgs.getString("ev.hnevent.label.costEng")%>
								</th>
								<td class="L">
									<input type="text" name="eventFeeEng" id="eventFeeEng" class="txt_200" value="<c:out value="${eventMngVO.EVENT_FEE_ENG}"/>" />
								</td>
							</tr>
							<tr>
								<th class="C" scope="row"><%=msgs.getString("ev.hnevent.label.contact")%></th>
								<td class="L">
									<%=msgs.getString("ev.hnevent.label.name")%>&nbsp;&nbsp;&nbsp;&nbsp;
									<c:if test="${!empty eventMngVO.OWNER_USER_ID}">
										<input type="text" name="name" id="name" class="txt_100" value="<c:out value="${eventMngVO.OWNER_USER_ID}"/>"/>&nbsp;&nbsp;&nbsp;&nbsp;
									</c:if>
									<c:if test="${empty eventMngVO.OWNER_USER_ID}">
										<input type="text" name="name" id="name" class="txt_100" value="<c:out value="${eventMngVO.REG_USER_NM}"/>"/>&nbsp;&nbsp;&nbsp;&nbsp;
									</c:if> 
									<%=msgs.getString("ev.hnevent.label.phone")%>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="text" name="phone" id="phone" class="txt_100" value="<c:out value="${eventMngVO.OWNER_PHONE}"/>" />&nbsp;&nbsp;&nbsp;&nbsp;
									<%=msgs.getString("ev.hnevent.label.email")%>&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="text" name="email" id="email" class="txt_100" value="<c:out value="${eventMngVO.OWNER_EMAIL}"/>" />&nbsp;&nbsp;&nbsp;&nbsp;
								</td>
							</tr>
							<tr>
								<th class="C" scope="row"><%=msgs.getString("ev.hnevent.label.descriptionKor")%> <em>*</em></th>
								<td>
									<script>
										//국문 FCK-Editor초기화
										var oFCKeditorKor = new FCKeditor("content_ko");
										oFCKeditorKor.BasePath="<%=request.getContextPath()%>/fckeditor/";
										oFCKeditorKor.ToolbarSet = "EventCustom";
										oFCKeditorKor.Value = document.getElementById("eventCnttKor").value;
										oFCKeditorKor.Create();
									</script>
								</td>
							</tr>
							<tr>
								<th class="C" scope="row"><%=msgs.getString("ev.hnevent.label.descriptionEng")%></th>
								<td class="L">
									<script>
										//영문 FCK-Editor초기화
										var oFCKeditorEng = new FCKeditor("content_en");
										oFCKeditorEng.BasePath="<%=request.getContextPath()%>/fckeditor/";
										oFCKeditorEng.ToolbarSet = "EventCustom";
										oFCKeditorEng.Value = document.getElementById("eventCnttEng").value;
										oFCKeditorEng.Create();
									</script>
								</td>
							</tr>
						</table>
						<!-- btnArea-->
						<div class="btnArea">
							<div class="rightArea">
								<a href="#link" onclick="javascript:backToAppList();" class="btn_W"><span><%=msgs.getString("ev.hnevent.label.list")%></span></a>
								<c:if test="${siteName != '/MS010'}"><!--학생이 아님-->
									<c:if test="${paramMap.mngMode == 'WRITE'}">
										<a href="#" onclick="saveEvent()" class="btn_W"><span><%=msgs.getString("ev.hnevent.label.reg")%></span></a>
									</c:if> 
									<c:if test="${paramMap.mngMode == 'MODIFY' && eventMngVO.STATE == '0' && menuAuth == 'Y'}"><!--이벤트관리자만-->
										<a href="#" onclick="saveEvent()" class="btn_W"><span><%=msgs.getString("ev.hnevent.label.approval")%></span></a>
										<a href="#linkDelete" onclick="deleteEvent();" class="btn_W"><span><%=msgs.getString("ev.hnevent.label.delete")%></span></a><!--삭제-->
									</c:if>
								</c:if>
								<c:if test="${siteName == '/MS010'}"><!--학생-->
									<c:if test="${paramMap.mngMode == 'MODIFY' && eventMngVO.STATE == '0'}">
										<a href="#" onclick="saveEvent()" class="btn_W"><span><%=msgs.getString("ev.hnevent.label.save")%></span></a>
										<a href="#linkDelete" onclick="deleteEvent();" class="btn_W"><span><%=msgs.getString("ev.hnevent.label.delete")%></span></a><!--삭제-->
									</c:if> 
								</c:if>				
							</div>
						</div>
						<!-- btnArea//-->
					</div>
				</div>									
			</div>
			<!-- board first// -->						
		</div>
		<!-- detail// -->
	</div>
	<!-- sub_contents// -->		
					
	<!-- back to eventApprovalList -->
	<form action="<%=request.getContextPath()%>/hancer/event/selectConfirmEvent.hanc" id="eventListFrom" name="eventListFrom" method="post">
		<input type="hidden" id="PAGE_NUM"  name="PAGE_NUM"  value="<c:out value="${paramMap.PAGE_NUM}"/>"/>
		<input type="hidden" id="PAGE_SIZE" name="PAGE_SIZE" value="<c:out value="${paramMap.PAGE_SIZE}"/>"/>
		<input type="hidden" id="mngMode"   name="mngMode"   value="<c:out value="${paramMap.mngMode}"/>"/>
		<input type="hidden" id="EVENT_SEQ" name="EVENT_SEQ" value="<c:out value="${paramMap.EVENT_SEQ}"/>"/>
		<input type="hidden" id="TITLE_NM"  name="TITLE_NM"  value="<c:out value="${paramMap.TITLE_NM}"/>"/>
		<input type="hidden" id="REG_FROM"  name="REG_FROM"  value="<c:out value="${paramMap.REG_FROM}"/>"/>
		<input type="hidden" id="REG_TO"    name="REG_TO"    value="<c:out value="${paramMap.REG_TO}"/>"/>
		<input type="hidden" id="CATE_CD"   name="CATE_CD"   value="<c:out value="${paramMap.CATE_CD}"/>"/>
		<input type="hidden" id="STATE"     name="STATE"     value="<c:out value="${paramMap.STATE}"/>"/>
		<input type="hidden" id="REG_USER"  name="REG_USER"  value="<c:out value="${paramMap.REG_USER}"/>"/>
		<input type="hidden" id="DEPT_CODE" name="DEPT_CODE" value="<c:out value="${paramMap.DEPT_CODE}"/>"/>
		<input type="hidden" id="PRIORTY"   name="PRIORTY"   value="<c:out value="${paramMap.PRIORTY}"/>"/>
		<input type="hidden" id="GROUP_CD"  name="GROUP_CD"  value="<c:out value="${paramMap.GROUP_CD}"/>"/>
		<input type="hidden" id="srchGroup" name="srchGroup" value="<c:out value="${paramMap.srchGroup}"/>"/>
	</form> 
	<!-- back to eventApprovalList// -->
	<!-- //iframe Of used by attachFileUpload -->
	<iframe src="<%=request.getContextPath()%>/event/blank.hanc" name="invisible" frameborder="0" width="0" height="0" title="blank"></iframe>
</body>
</html>