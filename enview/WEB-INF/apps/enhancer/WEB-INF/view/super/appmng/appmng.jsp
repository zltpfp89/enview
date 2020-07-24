<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title><util:message key="hn.admin.label.adminTitle"/></title>
	<c:if test="${windowId == null}" var="result">
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/messageResource_<c:out value="${langKnd}"/>.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
	</c:if>
		<script type='text/javascript' src="<%=request.getContextPath()%>/hancer/javascript/super/appmng.js"></script>
		<script type="text/javascript">
			enManager.logoutUrl('<c:out value="${logoutUrl}"/>');
			enManager.m_contextPath = '<%=request.getContextPath()%>';
		</script>
		<style type="text/css">
			.webformfield input.text_field  { width: 220px; }
			.webformfield input.text_field2  { width: 90%; }
		</style>
	</head>
	<body>
		<div id="appList"></div>
		<div id="AppManager_propertyTabs">
			<ul>
				<li><a href="#AppManager_DetailTabPage" onclick="javascript:enApp.detailApp();">상세보기</a></li>	
				<li><a href="#AppManager_SkinTabPage" onclick="javascript:enSkin.uiList();">스킨 목록</a></li>
			</ul>
			<div id="AppManager_DetailTabPage"></div>
			<div id="AppManager_SkinTabPage"></div>
		</div>
		
	</body>
</html>