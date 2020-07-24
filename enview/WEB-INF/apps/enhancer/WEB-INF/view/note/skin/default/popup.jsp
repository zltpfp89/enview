<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title><util:message key="hn.note.label.noteTitle"/></title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/hancer/css/note/default/note.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/hancer/css/note/default/dialog.css" />
	<c:if test="${windowId == null}" var="result">
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/messageResource_<c:out value="${langKnd}"/>.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_util.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${langKnd}"/>_mm.js"></script>
	</c:if>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${langKnd}"/>_hn.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/hancer/javascript/note/default/note.js"></script>
		<script type="text/javascript">
			enNote.loginUserId('<c:out value="${userInfo.userId}"/>');
			enNote.logoutUrl('<c:out value="${logoutUrl}"/>');
			$(document).ready(function(){
				enNote.viewWriteForm('<%=request.getParameter("receiverIds")%>');
			});
		</script>
	</head>
	<body>
		<div id="wrap" class="wrap_pop">
			<div id="contentsLayer" class="contentsLayer_pop"></div>
		</div>
	</body>
</html>