<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="java.util.List" %>
<%@ page import="com.saltware.enhancer.admin.event.model.EventMngListVO" %>

<%@ page import="java.util.*" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.saltware.enview.multiresource.MultiResourceBundle"%>
<%@ page import="com.saltware.enview.multiresource.EnviewMultiResourceManager"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %> 
<%
 Map userInfoMap = null;
 userInfoMap = EnviewSSOManager.getUserInfoMap(request);
 String langKnd = (String)userInfoMap.get("lang_knd");
 String siteName = (String)userInfoMap.get("site_name");
 MultiResourceBundle msgs = null;
 msgs = EnviewMultiResourceManager.getInstance().getBundle(langKnd);

 String token = (String)session.getAttribute("gAuthToken");

 String topMenuIdx ="";
 if("/MS010".equals(siteName)){//학생
	if("ko".equals(langKnd)){
		topMenuIdx = "TO040";
	}
	if("en".equals(langKnd)){
		topMenuIdx = "TO030";
	}
 }
 if("/MS020".equals(siteName)){//교수
	if("ko".equals(langKnd)){
		topMenuIdx = "TO050";
	}
	if("en".equals(langKnd)){
		topMenuIdx = "TO050";
	}
 }
 if("/MS030".equals(siteName)){//직원
	if("ko".equals(langKnd)){
		topMenuIdx = "TO040";
	}
	if("en".equals(langKnd)){
		topMenuIdx = "TO050";
	}
 }
 request.setAttribute("topMenuIdx",topMenuIdx);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>행사 이벤트 메인</title>
<link href="<%=request.getContextPath()%>/hancer/css/event/cssbasic.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
	var rootPath = '<c:out value="${pageContext.request.contextPath}"/>';
	var resPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/hancer";
	var actPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/event";
	
	//삭제처리
	function deleteEv(seq){
		if(confirm('<%=msgs.getString("ev.hnevent.msg.event.delete")%>')){
			$.ajax({ 
			   type: "POST", 
			   url: actPath+"deleteEvent.hanc", 
			   data: "EVENT_SEQ="+seq,
			   dataType:"json",
			   success: function(data){ 
					var msg = data.msg;
					if(msg == 'NoError'){
									
						//삭제 후 재조회 
						var frm = document.getElementById("eventListFrom");
						frm.action = actPath+"/myEventList.hanc";
						frm.submit();
					}else{
						alert(msg);
					}
			   }, 
			   error: function(request, status, error) {
					alert('<%=msgs.getString("ev.hnevent.msg.event.networkError")%>');
			   }
			});
		}else{
			return;
		}
	}

	//SNS링크 공유
	function shareSnsLink(type,msg,url){ 
		var sUrl = "";
		var sOption = "";
		var sWidth = 1000;
		var sHdight = 0;
		
		if(type == "twitter"){
			sUrl = "http://twitter.com/home?status=" + encodeURIComponent(msg) + " " + encodeURIComponent(url);   
			sHdight = 320;
		}
		if(type == "facebook"){
			sUrl = "http://www.hancbook.com/sharer.php?u=" + url + "&t=" + encodeURIComponent(msg); 
			sHdight = 570;
		}
		openWinCenter(sUrl, "", sWidth, sHdight);
	}
	
	//구글켈린더에 일정추가
	function addSchedule(seq){
		var url = '';
		var siteUrl = 'http://portal.saltware.co.kr'
		if('<%=token%>'==null || '<%=token%>'=='null' || '<%=token%>'=='' || '<%=token%>'=='undefined')
			url = 'https://www.google.com/accounts/AuthSubRequest?next=' + siteUrl + '/eventselectGoogleAddEvent.hanc?EVENT_SEQ='+seq+'&scope=http://www.google.com/calendar/feeds/&secure=0&session=1';
		if('<%=token%>'!=null && '<%=token%>'!='null' && '<%=token%>'!='' && '<%=token%>'!='undefined')
			url = siteUrl + '/eventselectGoogleAddEvent.hanc?EVENT_SEQ='+seq;
		openWinCenter(url, "", 1000, 800);
	}

	//팝업창 화면 가운데 정렬
	function openWinCenter(url, target, intwidth, intheight, options) {
		var top = 0;
		var left = 0;
		var w_width = intwidth; 	//창 넓이
		var w_height = intheight; 	//창 높이
		var option;
		if(left == 0){
			var x= screen.width/2 - w_width/2; //화면중앙으로위치
			left = x;
		}
		if(top == 0){
			var y= screen.height/2 - w_height/2;
			top = y;
		}
		
		option = "top="+top+",left="+left+",width="+intwidth+",height="+intheight+",resizable=1,scrollbars=0";
		if(options != null && options != ""){
			option = "top="+top+",left="+left+",width="+intwidth+",height="+intheight+","+options;
		}
		
		window.open(url, target, option);
	}

	//I'm Going 취소(화면에서 EVENT_SEQ)를 서버에서 USER_ID를 가지고 삭제처리
	function cancelGoing(eventSeq){
		if(confirm('<%=msgs.getString("ev.hnevent.msg.event.cancelJoin")%>')){
			$.ajax({ 
			   type: "POST", 
			   url: actPath+"/updateParticipation.hanc", 
			   data: "EVENT_SEQ="+eventSeq,
			   dataType:"text",
			   success: function(data){ 
					alert(data);
					var frm = document.getElementById("eventListFrom");
					frm.action = actPath+"/myEventList.hanc";
					frm.submit();	
			   }, 
			   error: function(request, status, error) {
					alert('<%=msgs.getString("ev.hnevent.msg.event.networkError")%>');
			   }
			});
		}else{
			return;
		}
	}
</script>
</head>

<body>
	<div class="body_s"> 
		<div class="body_s_full">
			<h1><%=msgs.getString("ev.hnevent.label.myevent")%></h1>
				<!-- 참가한이벤트리스트 -->
				<div class="event_list2">
					<c:if test="${!empty myEvJoinList}">
						<c:forEach  items="${myEvJoinList}" var="data" varStatus="status">
							<dl>
								<c:if test="${data.IMAGE_PATH == null}">
									<dd class="image"></dd>
								</c:if>
								<c:if test="${data.IMAGE_PATH != null}">
									<dd class="realimage"><img src="<%=request.getContextPath()%><c:out value="${data.IMAGE_PATH}"/>" alt="이벤트썸네일이미지" width="60px" height="50px"/></dd>
								</c:if>
								<dt>
									<a href="<%=request.getContextPath()%>/portal<c:out value="${paramMap.SITE_NAME}"/>/detailEvent?EVENT_SEQ=<c:out value="${data.EVENT_SEQ}"/>&HIST_BACK_TYPE=MAIN" target="_parent">
									[<c:out value="${data.CATEGORY_NM}"/>] <c:out value="${data.TITLE}"/>
									</a>
								</dt>
								<dd class="tpo">
									<c:out value="${data.START_DATE}"/> ~ <c:out value="${data.END_DATE}"/> | 
									<c:out value="${data.START_TIME}"/> ~ <c:out value="${data.END_TIME}"/> | 
									<c:out value="${data.PLACE_BUILDING}"/>
								</dd>
								<dd class="desc">
									<a href="<%=request.getContextPath()%>/portal<c:out value="${paramMap.SITE_NAME}"/>/detailEvent?EVENT_SEQ=<c:out value="${data.EVENT_SEQ}"/>&HIST_BACK_TYPE=MAIN" target="_parent">
									<c:out value="${data.CONTENTS}" escapeXml="false"/>
									</a>
								</dd>
								<dd class="more">
									<a href="javascript:shareSnsLink('twitter','<c:out value="${data.TITLE}"/>','<c:out value="${data.TARGET_LINK}"/>');">
										<img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_twitter3.gif" alt="to Twitter" />
									</a> 
									<a href="javascript:addSchedule('<c:out value="${data.EVENT_SEQ}"/>');">
										<img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_googleplus3.gif" alt="to Google+" />
									</a> 
									<a href="javascript:shareSnsLink('facebook','<c:out value="${data.TITLE}"/>','<c:out value="${data.TARGET_LINK}"/>');">
										<img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/event/btn_facebook3.gif" alt="to Facebook" />
									</a>
									<span class="btn_s"><a href="javascript:cancelGoing('<c:out value="${data.EVENT_SEQ}"/>');">취소</a></span>
								</dd>
							</dl>
						</c:forEach>
					</c:if>
					<c:if test="${empty myEvJoinList}">
						<center><strong><%=msgs.getString("ev.hnevent.msg.event.noEvent")%></strong></center>
					</c:if>
				</div>
				<h2></h2>
		</div>
	</div>
	<!-- move to eventModify -->
	<form action="<%=request.getContextPath()%>/event/insertEventByUser.hanc" id="eventListFrom" name="eventListFrom" method="post">
		<input type="hidden" id="EVENT_SEQ" name="EVENT_SEQ" value=""/>
		<input type="hidden" id="mngMode" name="mngMode" value="MODIFY"/>
		<input type="hidden" id="HIST_BACK_TYPE" name="HIST_BACK_TYPE" value="MAIN"/>
	</form> 
	<!-- //move to eventModify -->
</body>
</html>