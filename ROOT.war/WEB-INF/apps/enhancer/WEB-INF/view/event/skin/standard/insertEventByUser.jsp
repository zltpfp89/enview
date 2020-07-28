<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="com.saltware.enhancer.event.service.EventVO" %>
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
  String siteName = (String)userInfoMap.get("site_name");
  String email = (String)userInfoMap.get("email");
  String phone = (String)userInfoMap.get("tel1No");
  MultiResourceBundle msgs = null;
  msgs = EnviewMultiResourceManager.getInstance().getBundle(langKnd);

  String flag = "N";

  //등록,수정후 이벤트조회페이지로 이동
  String movePath = request.getContextPath() + "/portal" + siteName + "/selectMainEventList"; 

   //이벤트시간 분리
  EventVO eventvo = (com.saltware.enhancer.event.service.EventVO)request.getAttribute("eventVO");
  String startTime = (String)eventvo.getSTART_TIME();
  String startHour = (startTime.split(":"))[0];
  String startMin  = (startTime.split(":"))[1];
  String endTime = (String)eventvo.getEND_TIME();
  String endHour = (endTime.split(":"))[0];
  String endMin  = (endTime.split(":"))[1];

  request.setAttribute("menuAuth",flag);
  request.setAttribute("groupTp",siteName);
  request.setAttribute("langKnd",langKnd);
  request.setAttribute("email_addr",email);
  request.setAttribute("mobile_tel",phone);
  request.setAttribute("movePath",movePath);

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
<title>이벤트 등록</title>
<link href="<%=request.getContextPath()%>/hancer/css/event/cssbasic.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/event/objCalendarCtrl.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/event/validUtil.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/event/eventEdit.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/event/jquery.blockUI.js"></script>
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
	var actPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/event";
	var mainForm = document.getElementById("setTransfer");
	var lang_knd = '<c:out value="${paramMap.LANG_KND}"/>';

	//처리중 화면 Block
	function fnBlock() {
		var left = (window.top.document.body.offsetWidth - 200) / 2;
		if(left < 0) left = 0;
		var top  = (window.top.document.body.offsetHeight - 200) / 2;
		if(top < 0) top = 0;
		$.blockUI({ 
			 message: $('<div id="blockBar" style="width:100;display:none; cursor: default"><div id="loding"><dl><dt><img src="'+resPath+'/img/event/icon_loging.gif"></dt><dd>처리중 입니다.</dd></dl></div></div>'),
			 css:{ 
				 width: '100px',
				 height: '55px', 
				 border: 'none',  
				 left:left,
				 top:top
			 },
			 overlayCSS:{ 
		         backgroundColor: '#fff', 
		         opacity: 0.0 
		    } 
		}); 
    }

	//이벤트목록페이지로 이동
	function retriveEvent(knd,val,val2){
		var frm = document.getElementById("eventListFrom");
		switch (knd) {
		case 1://이벤트검색(이벤트명)			
			var eventNm = document.getElementById("event_search").value;
			document.getElementById("SRCH_STR").value = eventNm;
			document.getElementById("SRCH_TYPE").value = "N";
			break;
		case 2://날짜선택
			document.getElementById("SRCH_STD_DATE").value = val;
			document.getElementById("SRCH_END_DATE").value = val;
			document.getElementById("SRCH_TYPE").value = "D";
			break;
		case 3://카테고리별
			document.getElementById("SRCH_CATE").value = val;
			document.getElementById("SRCH_CATE_NM").value = val2;
			document.getElementById("SRCH_TYPE").value = "C";
			break;
		case 4://기관별
			document.getElementById("SRCH_DEPT").value = val;
			document.getElementById("SRCH_TYPE").value = "O";
			break;
		default:
			break;
		}
		frm.submit();
	}
	
	//장소찾기 팝업
	function srchPlace(){
		var sUrl = actPath+"/placePopUp.hanc?lang_knd="+lang_knd;
		var sStatus="toolbar=0,status=0,scrollbars=1,resizable=0,location=0";
		openWinCenter(sUrl,"_blank",450,350,sStatus);
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
	
	//장소찿기팝업 리턴데이터 셋팅(직접입력)
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
		var sUrl = actPath+"/selectGroupList.hanc?target_cd="+sTargetCd;
		var sStatus="toolbar=0,status=0,scrollbars=1,resizable=0,location=0";
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
	function deleteEvent(seq){
		if(confirm('<%=msgs.getString("ev.hnevent.msg.event.delete")%>')){
			$.ajax({ 
			   type: "POST", 
			   url: actPath+"/deleteEvent.hanc", 
			   data: "EVENT_SEQ="+seq,
			   dataType:"json",
			   success: function(data){ 
					var moreEv = data.data;
					var msg = data.msg;
					if(lang_knd == 'ko')
						alert("삭제되었습니다.");
					if(lang_knd == 'en')
						alert("Deleted.");
					
					var frm = document.getElementById("eventListFrom");
					frm.action = actPath+ "/selectMainEventList.hanc"; 
					frm.submit();
			   }, 
			   error: function(request, status, error) {
					alert('<%=msgs.getString("ev.hnevent.msg.event.networkError")%>');
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

		//신분에 따라 승인여부 결정(학생:신청-학생외:승인)
		var groupType = '<c:out value="${groupTp}"/>';
		if(groupType=='/default/stu'){//학생
			document.getElementById("state").value = "0";//신청
			document.getElementById("studentYn").value = "N";//저장 후 alert메세지를 위한 구분자
		}
		if(groupType!='/default/stu'){//학생외 : 세부그룹은 다시 정의해야함
			document.getElementById("state").value = "0";//승인
			document.getElementById("studentYn").value = "N";//저장 후 alert메세지를 위한 구분자
		}

		//추가,수정화면에 대한 구분자(insertEventByUser:add / insertEventMng:mod)
		document.getElementById("msgType").value = "add";

		//화면블록
		fnBlock();

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

	//파일첨부 확장자 체크
	function checkExt(){
		var ext = document.getElementById("attachFile").value;
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
<body>
<div id="content">
	<div id="body">
		<div class="event_Maincontents">
			<!-- Maincontents -->
			<div class="latestEvent_box">
				<!-- 이벤트뷰 -->
				<c:if test="${paramMap.mngMode == 'WRITE'}">
				<h1><%=msgs.getString("ev.hnevent.label.addEvent")%></h1>
				</c:if>
				<c:if test="${paramMap.mngMode == 'MODIFY'}">
				<h1>이벤트 수정</h1>
				</c:if>
				<div class="event_write">
					<fieldset>
						<div class="write_side">
						<!-- EventData 최종저장 -->
						<form name="setTransfer" id="setTransfer" method="post" action="<%=request.getContextPath()%>/event/insertEvent.hanc" enctype="multipart/form-data">
							<input type="hidden" id="mngMode" name="mngMode" value="<c:out value="${paramMap.mngMode}"/>"/><!--추가or수정-->
							<input type="hidden" id="userType"name="userType" value="<c:out value="${paramMap.userType}"/>"/><!--일반or관리자-->
							<input type="hidden" id="studentYn" name="studentYn" value="<c:out value="${paramMap.studentYn}"/>"/><!--학생여부-->
							<input type="hidden" id="eventSeq"name="eventSeq"value="<c:out value="${eventVO.EVENT_SEQ}"/>"/>
							<input type="hidden" id="cateCd"  name="cateCd"  value="<c:out value="${eventVO.CATEGORY_SEQ}"/>"/>
							<input type="hidden" id="stdDate" name="stdDate" value="<c:out value="${eventVO.START_DATE}"/>"/>
							<input type="hidden" id="endDate" name="endDate" value="<c:out value="${eventVO.END_DATE}"/>"/>
							<input type="hidden" id="stdTime" name="stdTime" value="<c:out value="${eventVO.START_TIME}"/>"/>
							<input type="hidden" id="endTime" name="endTime" value="<c:out value="${eventVO.END_TIME}"/>"/>
							<input type="hidden" id="deptCdKor"  name="deptCdKor"  value="<c:out value="${eventVO.DEPT_CODE_KOR}"/>"/>
							<input type="hidden" id="deptCdEng"  name="deptCdEng"  value="<c:out value="${eventVO.DEPT_CODE_ENG}"/>"/>
							<input type="hidden" id="writerId" name="writerId" value="<c:out value="${eventVO.REG_USER_ID}"/>"/>
							<input type="hidden" id="writerNm" name="writerNm" value="<c:out value="${eventVO.REG_USER_NM}"/>"/>
							<input type="hidden" id="placeNo"  name="placeNo"  value="<c:out value="${eventVO.PLACE_NO}"/>"/>
							<input type="hidden" id="placeSubNo" name="placeSubNo" value="<c:out value="${eventVO.PLACE_SUB_NO}"/>"/>
							<input type="hidden" id="placeSubNm"  name="placeSubNm"  value="<c:out value="${eventVO.PLACE_NM}"/>"/><!--장소상세2012.01.28-->
							<input type="hidden" id="placeNameKor"  name="placeNameKor"  value="<c:out value="${eventVO.PLACE_BUILDING_KOR}"/>"/>
							<input type="hidden" id="placeNameEng"  name="placeNameEng"  value="<c:out value="${eventVO.PLACE_BUILDING_ENG}"/>"/>
							<input type="hidden" id="placeLat"   name="placeLat"   value="<c:out value="${eventVO.PLACE_LATITUDE}"/>"/>
							<input type="hidden" id="placeLon"   name="placeLon"   value="<c:out value="${eventVO.PLACE_LONGITUDE}"/>"/>
							<input type="hidden" id="eventNmKor" name="eventNmKor" value="<c:out value="${eventVO.TITLE_KOR}"/>"/>
							<input type="hidden" id="eventNmEng" name="eventNmEng" value="<c:out value="${eventVO.TITLE_ENG}"/>"/>
							<input type="hidden" id="targetLink" name="targetLink" value="<c:out value="${eventVO.TARGET_LINK}"/>"/>
							<input type="hidden" id="eventTargetCd" name="eventTargetCd" value="<c:out value="${eventTartgetList.eventTargetCd}"/>"/>
							<input type="hidden" id="eventTargetNm" name="eventTargetNm" value="<c:out value="${eventTartgetList.eventTargetNm}"/>"/>
							<input type="hidden" id="ownerName"  name="ownerName"  value="<c:out value="${eventVO.OWNER_USER_ID}"/>"/>
							<input type="hidden" id="ownerPhone" name="ownerPhone" value="<c:out value="${eventVO.OWNER_PHONE}"/>"/>
							<input type="hidden" id="ownerEmail" name="ownerEmail" value="<c:out value="${eventVO.OWNER_EMAIL}"/>"/>
							<input type="hidden" id="eventCnttKor" name="eventCnttKor" value="<c:out value="${eventVO.CONTENTS_KOR}"/>"/>
							<input type="hidden" id="eventCnttEng" name="eventCnttEng" value="<c:out value="${eventVO.CONTENTS_ENG}"/>"/>
							<input type="hidden" id="feeKor"   name="feeKor"   value="<c:out value="${eventVO.EVENT_FEE_KOR}"/>"/>
							<input type="hidden" id="feeEng"   name="feeEng"   value="<c:out value="${eventVO.EVENT_FEE_ENG}"/>"/>
							<input type="hidden" id="attachNo" name="attachNo" value="<c:out value="${eventVO.ATTACH_NO}"/>"/>
							<input type="hidden" id="fileName" name="fileName" value="<c:out value=""/>"/>
							<input type="hidden" id="fileMask" name="fileMask" value="<c:out value=""/>"/>
							<input type="hidden" id="fileSize" name="fileSize" value="<c:out value=""/>"/>
							<input type="hidden" id="state" name="state" value=""/>
							<input type="hidden" id="langKnd" name="langKnd" value="<c:out value="${langKnd}"/>"/>
							<input type="hidden" id="msgYn" name="msgYn" value="<c:out value="${paramMap.msgYn}"/>"/>
							<input type="hidden" id="msgType" name="msgType" value="<c:out value="${paramMap.msgType}"/>"/>
							<input type="hidden" id="movePath" name="movePath" value="<c:out value="${movePath}"/>"/><!--등록후조회화면이동2012.01.28-->

							<input type="hidden" id="EventStdDate" name="EventStdDate" value="<c:out value="${eventVO.EVENT_START_DATE}"/>"/>
							<input type="hidden" id="EventEndDate" name="EventEndDate" value="<c:out value="${eventVO.EVENT_END_DATE}"/>"/>
							<input type="hidden" id="EventStdTime" name="EventStdTime" value="<c:out value="${eventVO.EVENT_START_TIME}"/>"/>
							<input type="hidden" id="EventEndTime" name="EventEndTime" value="<c:out value="${eventVO.EVENT_END_TIME}"/>"/>

							<!-- 이미지국문 -->
							<div class="imgbox">
								<h3><%=msgs.getString("ev.hnevent.label.imageKor")%></h3>
								<div class="addimg">
									<c:if test="${eventVO.IMAGE_PATH_KOR !=null}">
										<img src="<%=request.getContextPath()%><c:out value='${eventVO.IMAGE_PATH_KOR}'/>" alt="이벤트썸네일이미지" class="addimg"/>
									</c:if>
								</div>
								<div class="fileinput">
									<input type="file" title="thumb_kor" name="thumbKor" onchange="document.getElementById('imgfile').value = this.value;" />
									<input type="text" title="image file" name="imgfile" id="imgfile" readonly/> <span class="btn"></span>
								</div>
							</div>
							<!-- 이미지영문 -->
							<div class="imgbox_en">
								<h3><%=msgs.getString("ev.hnevent.label.imageEng")%></h3>
								<div class="addimg">
									<c:if test="${eventVO.IMAGE_PATH_ENG !=null}">
										<img src="<%=request.getContextPath()%><c:out value='${eventVO.IMAGE_PATH_ENG}'/>" alt="이벤트썸네일이미지" class="addimg"/>
									</c:if>
								</div>
								<div class="fileinput">
									<input type="file" title="thumb_eng" name="thumbEng" onchange="document.getElementById('imgfile2').value = this.value;" />
									<input type="text" title="image file2" name="imgfile2" id="imgfile2" readonly/> <span class="btn"></span>
								</div>
							</div>
						</form>	
						<!-- EventData 최종저장// -->
							<!-- 파일첨부 -->
							<div class="filebox">
								<h3><%=msgs.getString("ev.hnevent.label.attachFile")%></h3>
								<label for="list"></label>
								<!-- attachFileList -->
								<form name="setFileList" method="post" target="invisible" action="<%=request.getContextPath()%>/event/fileMgr?cmd=delete">
									<select name="list" size="5" multiple="multiple" id="list">
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
									<input type="hidden" name="vaccum">
									<input type="hidden" name="unDelList">
									<input type="hidden" name="delList">
								</form>
								<!-- attachFileList// -->
								<!-- attachFile -->
								<form name="setUpload" method="post" target="invisible" enctype="multipart/form-data" action="<%=request.getContextPath()%>/event/fileMgr?cmd=upload">
									<div class="fileinput">
										<input type="file" title="filename" name="filename" onchange="document.getElementById('attachFile').value = this.value;" />
										<input type="text" title="attach file" name="attachFile" id="attachFile" /> <span class="btn"></span>
									</div>
									<div class="btn">
										<span class="btn_s"><a href="#" onclick="ebEdit.deleteFile()"><%=msgs.getString("ev.hnevent.label.delete")%></a></span> 
										<span class="btn_s"><a href="#" onclick="checkExt()"><%=msgs.getString("ev.hnevent.label.add")%></a></span>
									</div>
									<input type="hidden" name="mode" value="attach"/>
									<input type="hidden" name="totalsize" value="0"/>
								</form>
								<!-- attachFile// -->
							</div>
						</div>
						<div class="write_main">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabletype3 tpo" summary="카테고리,기간,장소,시간 입력 양식입니다.">
								<caption>카테고리,기간,장소,시간 입력 양식</caption>
								<colgroup>
									<col width="20%" />
									<col width="19%" />
									<col width="16%" />
									<col width="*" />
								</colgroup>
								<tr>
									<th scope="row">
										<label for="category">*<%=msgs.getString("ev.hnevent.label.category")%></label>
									</th>
									<td>
										<select name="category" id="category" class="ts_70">
											<option value="-1"></option>
												<c:forEach items="${cateCodeList}" var="data">
												<option value="<c:out value="${data.CATEGORY_SEQ}"/>" <c:if test="${eventVO.CATEGORY_SEQ eq data.CATEGORY_SEQ}">selected</c:if>><c:out value="${data.CATEGORY_NM}"/></option>
												</c:forEach>
										</select>
									</td>
									<th scope="row">
										<!--label for="date1">*<%=msgs.getString("ev.hnevent.label.when")%></label-->
										<label for="date1">*<%=msgs.getString("ev.hnevent.label.dateKor")%></label>
									</th>
									<td>
										<input type="text" title="date" name="date1" id="date1" value="<c:out value="${eventVO.START_DATE}"/>" readonly /> 
										<a id="calendar_switch" href="#btn" style="cursor:pointer;" onclick="javascript:Calendar_Create('date1','<c:out value="${paramMap.LANG_KND}"/>','calendar_switch');">
											<img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_carlendar.gif" alt="기간선택" />
										</a> 
										~ 
										<input type="text" title="date" name="date2" id="date2" value="<c:out value="${eventVO.END_DATE}"/>" readonly /> 
										<a id='calendar_switch1'  href="#btn" style="cursor:pointer;" onclick="javascript:Calendar_Create('date2','<c:out value="${paramMap.LANG_KND}"/>','calendar_switch1');">
											<img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_carlendar.gif" alt="기간선택" />
										</a>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="writer"><%=msgs.getString("ev.hnevent.label.admin")%></label>
									</th>
									<td>
										<c:out value="${eventVO.REG_USER_NM}"/>
									</td>
									<th scope="row">
										<label for="startHour">*<%=msgs.getString("ev.hnevent.label.time")%></label>
									</th>
									<td>
										<select name="startHour" id="startHour">
											<c:forEach items="${hourCodeList}" var="data">
												<option value="<c:out value="${data.CODE}"/>" <c:if test="${startHour eq data.CODE}">selected</c:if>><c:out value="${data.CODE_NAME}"/></option>
											</c:forEach>
										</select>
										<select name="startMin" id="startMin">
											<c:forEach items="${minuteCodeList}" var="data">
												<option value="<c:out value="${data.CODE}"/>" <c:if test="${startMin eq data.CODE}">selected</c:if>><c:out value="${data.CODE_NAME}"/></option>
											</c:forEach>
										</select>
									~ 
										<select name="endHour" id="endHour">
											<c:forEach items="${hourCodeList}" var="data">
												<option value="<c:out value="${data.CODE}"/>" <c:if test="${endHour eq data.CODE}">selected</c:if>><c:out value="${data.CODE_NAME}"/></option>
											</c:forEach>
										</select>
										<select name="endMin" id="endMin">
											<c:forEach items="${minuteCodeList}" var="data">
												<option value="<c:out value="${data.CODE}"/>" <c:if test="${endMin eq data.CODE}">selected</c:if>><c:out value="${data.CODE_NAME}"/></option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="date1">*<%=msgs.getString("ev.hnevent.msg.event.exercisePeriod")%></label>
									</th>
									<td colspan="3">
										<input type="text" title="date" name="date3" id="date3" value="<c:out value="${eventVO.EVENT_START_DATE}"/>" readonly /> 
										<a id="calendar_switch2" href="#btn" style="cursor:pointer;" onclick="javascript:Calendar_Create('date3','<c:out value="${paramMap.LANG_KND}"/>','calendar_switch2');">
											<img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_carlendar.gif" alt="기간선택" />
										</a> 
										~ 
										<input type="text" title="date" name="date4" id="date4" value="<c:out value="${eventVO.EVENT_END_DATE}"/>" readonly /> 
										<a id='calendar_switch3'  href="#btn" style="cursor:pointer;" onclick="javascript:Calendar_Create('date4','<c:out value="${paramMap.LANG_KND}"/>','calendar_switch3');">
											<img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_carlendar.gif" alt="기간선택" />
										</a>
										<select name="startEventHour" id="startEventHour">
											<c:forEach items="${hourCodeList}" var="data">
												<option value="<c:out value="${data.CODE}"/>" <c:if test="${startHour eq data.CODE}">selected</c:if>><c:out value="${data.CODE_NAME}"/></option>
											</c:forEach>
										</select>
										<select name="startEventMin" id="startEventMin">
											<c:forEach items="${minuteCodeList}" var="data">
												<option value="<c:out value="${data.CODE}"/>" <c:if test="${startMin eq data.CODE}">selected</c:if>><c:out value="${data.CODE_NAME}"/></option>
											</c:forEach>
										</select>
									~ 
										<select name="endEventHour" id="endEventHour">
											<c:forEach items="${hourCodeList}" var="data">
												<option value="<c:out value="${data.CODE}"/>" <c:if test="${endHour eq data.CODE}">selected</c:if>><c:out value="${data.CODE_NAME}"/></option>
											</c:forEach>
										</select>
										<select name="endEventMin" id="endEventMin">
											<c:forEach items="${minuteCodeList}" var="data">
												<option value="<c:out value="${data.CODE}"/>" <c:if test="${endMin eq data.CODE}">selected</c:if>><c:out value="${data.CODE_NAME}"/></option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="place">*<%=msgs.getString("ev.hnevent.label.where")%></label>
									</th>
									<td colspan="3">
										<input type="text" title="place" name="place" id="place" class="place" readonly onclick="srchPlace();"
												<c:if test="${paramMap.LANG_KND eq 'ko'}">value="<c:out value="${eventVO.PLACE_BUILDING_KOR}"/>"</c:if>
												<c:if test="${paramMap.LANG_KND eq 'en'}">value="<c:out value="${eventVO.PLACE_BUILDING_ENG}"/>"</c:if> /> 
										<span class="btn_s">
										<a href="#" style="cursor:pointer;" onclick="javascript:srchPlace();"><%=msgs.getString("ev.hnevent.label.search")%></a>
										</span>&nbsp;
										<%=msgs.getString("ev.hnevent.label.placeSub")%>
										<input type="text" id="placeSub" name="placeSub" value="<c:out value="${eventVO.PLACE_NM}"/>"/>
									</td>								
								</tr>
							</table>
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabletype3 detail" summary="이벤트 추가 양식입니다.">
								<caption>이벤트 추가 양식</caption>
								<colgroup>
									<col width="20%" />
									<col width="*" />
								</colgroup>
								<tr>
									<th scope="row">
										<label for="subject">*<%=msgs.getString("ev.hnevent.label.titleKor")%></label>
									</th>
									<td class="subject">
										<input type="text" title="subject" name="subject" id="subject" class="input100" value="<c:out value="${eventVO.TITLE_KOR}"/>" />
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="subject_en">*<%=msgs.getString("ev.hnevent.label.titleEng")%></label>
									</th>
									<td>
										<input type="text" title="subject_en" name="subject_en" id="subject_en" class="input100" onkeyup="checkHangul(this);" value="<c:out value="${eventVO.TITLE_ENG}"/>" />
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="link"><%=msgs.getString("ev.hnevent.label.link")%></label>
									</th>
									<td>
										<c:if test="${!empty eventVO.TARGET_LINK}">
											<input type="text" title="link" name="link" id="link" class="input100" value="<c:out value="${eventVO.TARGET_LINK}"/>" />
										</c:if>
										<c:if test="${empty eventVO.TARGET_LINK}">
											<input type="text" title="link" name="link" id="link" class="input100" value="http://"/>
										</c:if>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="target">*<%=msgs.getString("ev.hnevent.label.target")%></label>
									</th>
									<td>
										<input type="text" title="target" name="target" id="target" value="<c:out value="${eventTartgetList.eventTargetNm}"/>" class="place" readonly onclick="srchEvTarget();"/> 
										<span class="btn_s">
											<a href="#btnPlace" style="cursor:pointer;" onclick="javascript:srchEvTarget();"><%=msgs.getString("ev.hnevent.label.add")%></a>
										</span>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="eventFeeKor"><%=msgs.getString("ev.hnevent.label.costKor")%></label>
									</th>
									<td>
										<input type="text" title="event_fee_kor" name="eventFeeKor" id="eventFeeKor" class="input100" value="<c:out value="${eventVO.EVENT_FEE_KOR}"/>" />
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="eventFeeEng"><%=msgs.getString("ev.hnevent.label.costEng")%></label>
									</th>
									<td>
										<input type="text" title="event_fee_eng" name="eventFeeEng" id="eventFeeEng" class="input100" value="<c:out value="${eventVO.EVENT_FEE_ENG}"/>" />
									</td>
								</tr>
								<tr>
									<th scope="row"><%=msgs.getString("ev.hnevent.label.contact")%></th>
									<td class="charge">
										<label for="name"><%=msgs.getString("ev.hnevent.label.name")%></label> 
										<c:if test="${!empty eventVO.OWNER_USER_ID}">
											<input type="text" title="name" name="name" id="name" value="<c:out value="${eventVO.OWNER_USER_ID}"/>"/>
										</c:if>
										<c:if test="${empty eventVO.OWNER_USER_ID}">
											<input type="text" title="name" name="name" id="name" value="<c:out value="${eventVO.REG_USER_NM}"/>"/>
										</c:if> 
										<label for="phone"><%=msgs.getString("ev.hnevent.label.phone")%></label> 
										<c:if test="${!empty eventVO.OWNER_PHONE}">
											<input type="text" title="phone" name="phone" id="phone" value="<c:out value="${eventVO.OWNER_PHONE}"/>"/>
										</c:if>
										<c:if test="${empty eventVO.OWNER_PHONE}">
											<input type="text" title="phone" name="phone" id="phone" value="<c:out value="${mobile_tel}"/>"/>
										</c:if>
										<label for="email"><%=msgs.getString("ev.hnevent.label.email")%></label> 
										<c:if test="${!empty eventVO.OWNER_EMAIL}">
											<input type="text" title="phone" name="email" id="email" value="<c:out value="${eventVO.OWNER_EMAIL}"/>"/>
										</c:if>
										<c:if test="${empty eventVO.OWNER_EMAIL}">
											<input type="text" title="phone" name="email" id="email" value="<c:out value="${email_addr}"/>"/>
										</c:if>
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="content_ko">*<%=msgs.getString("ev.hnevent.label.descriptionKor")%></label></th>
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
									<th scope="row"><label for="content_en"><%=msgs.getString("ev.hnevent.label.descriptionEng")%></label></th>
									<td>
										<script>
											var oFCKeditorEng = new FCKeditor("content_en");
											oFCKeditorEng.BasePath="<%=request.getContextPath()%>/fckeditor/";
											oFCKeditorEng.ToolbarSet = "EventCustom";
											oFCKeditorEng.Value = document.getElementById("eventCnttEng").value;
											oFCKeditorEng.Create();
										</script>
									</td>
								</tr>
							</table>
							<div class="btn right">
								<c:if test="${paramMap.mngMode == 'WRITE'}">
									<span class="btn_s">
										<a href="#" onclick="saveEvent()">
											<c:if test="${menuAuth!='Y'}"><%=msgs.getString("ev.hnevent.label.apply")%></c:if>
											<c:if test="${menuAuth== 'Y'}"><%=msgs.getString("ev.hnevent.label.reg")%></c:if>
										</a>
									</span>
								</c:if> 
								<c:if test="${paramMap.mngMode == 'MODIFY'}">
									<span class="btn_s">
										<a href="#link" onclick="saveEvent()"><%=msgs.getString("ev.hnevent.label.save")%></a>
									</span> 
								</c:if>								
								<c:if test="${paramMap.mngMode == 'MODIFY' && eventVO.STATE == '0'}"> 
									<span class="btn_s">
										<a href="#link" style="cursor:pointer;" onclick="javascript:deleteEvent('<c:out value="${eventVO.EVENT_SEQ}"/>');"><%=msgs.getString("ev.hnevent.label.delete")%></a>
									</span>
								</c:if>
							</div>
						</div>
					</fieldset>
				</div>
				<!-- 이벤트뷰// -->
			</div>
		</div>
		<!-- //Maincontents -->
		<div class="event_Sidebar">
			<div class="event_Sidebarbox first">
				<div id="eventSearch">
					<fieldset>
						<legend>이벤트검색</legend>
						<div class="searchbg">
							<label for="event_search"></label>
							<input name="event_search" type="text" id="event_search" value="<c:out value='${paramMap.SRCH_STR}'/>" />
							<span class="btn">
								<a href="#link" style="cursor:pointer;" onclick="javascript:retriveEvent(1);"><%=msgs.getString("ev.hnevent.label.eventSearch")%></a>
							</span> 
						</div>
					</fieldset>
				</div>
				<div class="btn_eventadd">
					<span class="btn_event">
						<a href="<%=request.getContextPath()%>/event/insertEventByUser.hanc?mngMode=WRITE"><%=msgs.getString("ev.hnevent.label.addEvent")%></a></span>&nbsp;
					<span class="btn_event">
						<a href="<%=request.getContextPath()%>/portal<c:out value="${paramMap.SITE_NAME}"/>/academicCalendar/myevent.page" target="_parent"><%=msgs.getString("ev.hnevent.label.myevent")%></a>
					</span>
				</div>
			</div>
			<div class="event_Sidebarbox">
				<div id="eventCalendar">
					<iframe src="<%=request.getContextPath()%>/event/selectEventCalendar.hanc" width="210px" height="175px" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" title="calendar"></iframe>
				</div>
			</div>
			<!-- category -->
			<div id="eventCatgory" class="event_Sidebarbox">
				<div class="cate_title">
					<c:if test="${paramMap.LANG_KND == 'ko'}">
						<img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/category_title1.gif" alt="카테고리별" border="0" />
					</c:if>
					<c:if test="${paramMap.LANG_KND == 'en'}">
						<img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/category_title1_en.gif" alt="cagegory" border="0" />
					</c:if>
				</div>
				<ul>
					<c:forEach  items="${cateEventList}" var="data" varStatus="status">
						<li>
							<a href="#link" onclick="retriveEvent(3,'<c:out value="${data.CATEGORY_SEQ}"/>','<c:out value="${data.CATEGORY_NM}"/>')">
								<c:out value="${data.CATEGORY_NM}"/><c:out value="${data.CNT}"/>
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div id="eventOrg" class="event_Sidebarbox">
				<div class="cate_title">
					<c:if test="${paramMap.LANG_KND == 'ko'}">
						<img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/category_title2.gif" alt="기관별" border="0" />
					</c:if>
					<c:if test="${paramMap.LANG_KND == 'en'}">
						<img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/category_title2_en.gif" alt="dept" border="0" />
					</c:if>
				</div>
				<ul>
					<c:forEach  items="${deptEventList}" var="data" varStatus="status">
						<li>
							<a href="#link" onclick="retriveEvent(4,'<c:out value="${data.DEPT_CODE}"/>')">
								<c:out value="${data.DEPT_CODE}"/><c:out value="${data.CNT}"/>
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
			<!-- category// --> 
		</div>
	</div>
	</div>
	<!-- // body -->
	<!-- //content -->
	<!-- move to eventList -->
	<form action="<%=request.getContextPath()%>/event/selectEventList.hanc" id="eventListFrom" name="eventListFrom" method="post">
		<input type="hidden" id="EVENT_SEQ" name="EVENT_SEQ" value="<c:out value='${paramMap.EVENT_SEQ}'/>"/>
		<input type="hidden" id="HIST_BACK_TYPE" name="HIST_BACK_TYPE" value="MAIN"/>
		<input type="hidden" id="SRCH_STR" name="SRCH_STR" value=""/>
		<input type="hidden" id="SRCH_STD_DATE" name="SRCH_STD_DATE" value=""/>
		<input type="hidden" id="SRCH_END_DATE" name="SRCH_END_DATE" value=""/>
		<input type="hidden" id="SRCH_DATE_DIV" name="SRCH_DATE_DIV" value="D"/>
		<input type="hidden" id="SRCH_CATE" name="SRCH_CATE" value=""/>
		<input type="hidden" id="SRCH_CATE_NM" name="SRCH_CATE_NM" value=""/>
		<input type="hidden" id="SRCH_DEPT" name="SRCH_DEPT" value=""/>
		<input type="hidden" id="SRCH_TYPE" name="SRCH_TYPE" value=""/>
	</form> 
	<!-- move to eventList// -->
	<!-- //iframe Of used by attachFileUpload -->
	<iframe src="<%=request.getContextPath()%>/event/blank.hanc" name="invisible" frameborder="0" width="0" height="0" title="blank"></iframe>
</body>
</html>