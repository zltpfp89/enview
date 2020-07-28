<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld"%>
<%@ page import="com.saltware.enview.request.RequestContext"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/decorations/layout/css/jquery/base/jquery.ui.all.css" />
		
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/css/each/encafe.css" />
	<%
		if( request.getAttribute("windownId") == null ) {
	%>
		<%--포틀릿으로서 동작하고 있지 않을 때에는 enView의 Javascript를 포함시켜준다--%>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/crossdomain.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<%=request.getLocale().getLanguage()%>_eb.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<%=request.getLocale().getLanguage()%>_cf.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<%=request.getLocale().getLanguage()%>_mm.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_util.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/calendar/calendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/calendar/ko-kr/generatecalendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_list.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_read.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/fckeditor/fckeditor.js"></script>
	<%
		}
	%>  
	</head>
<body class="CF0802_bgColor">
<div class="title_box">
	<a class="boardName CF0501_nmFontColor CF0501_nmFontNm" href="<%= request.getContextPath()%>/board/list.brd?boardId=<c:out value="${boardVO.boardId}"/>&listOpt=selectMenu"><c:out value="${boardVO.boardNm}"/></a>
	<span class="boardPipe">|</span>
	<span class="boardDesc"><c:out value="${boardVO.boardNm}"/></span>
</div>

<div class="boardList CF0802_extraBrdrColor">
	<table class="listTable CF0802_extraBrdrColor">
		<tr class="listTr2 CF0802_extraBrdrColor">
			<td style="text-align: left;padding: 20px">
				<span style="font-size:14px;font-weight:bold;line-height:auto; color:#000;padding: 10px"> <c:out value="${baseForm.reason}"/> </span>
				<c:if test="${baseForm.reasonCd=='eb.error.invalid.right'}">
				<div style="padding:5px;text-align:left;width:100%" >
					<c:if test="${langKnd=='ko' }">
					다음과 같은 원인일 수 있습니다.
					<li>카페에 가입하지 않았습니다. 
					<li>정상적인 회원이 아닙니다.(탈퇴,활동중지) 
					<li>회원등급이 낮습니다. 
					</c:if>
					<c:if test="${langKnd!='ko' }">
					Possible causes include:
					<li>You have not signed up for a cafe. 
					<li>Not a normal member (unsubscribed, inactivited) 
					<li>Member rating is low.
					</c:if>
				</div>	
				</c:if>
				<!-- 
				<input type="button"  value="<util:message key='ev.title.confirm'/>" onclick='history.back()'/>
				 -->
			</td>
		</tr>
	</table>
</div>
</body>
</html>
