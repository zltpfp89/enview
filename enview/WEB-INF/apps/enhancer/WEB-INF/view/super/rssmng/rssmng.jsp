<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title><util:message key="hn.rss.label.rssTitle"/></title>
		<%-- 
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/hancer/css/super/rssmng.css" />
		--%>
	<c:if test="${windowId == null}" var="result">
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${langKnd}"/>_mm.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${langKnd}"/>_hn.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
	</c:if>
	<c:if test="${form.serviceType == 'SERVICE'}" var="result">
		<script type='text/javascript' src="<%=request.getContextPath()%>/hancer/javascript/super/rss/rssmng.js"></script>
	</c:if>
	<c:if test="${form.serviceType == 'REQUESTED'}" var="result">
		<script type='text/javascript' src="<%=request.getContextPath()%>/hancer/javascript/super/rss/requestRssmng.js"></script>
	</c:if>
		<script type="text/javascript">
			enRss.logoutUrl('<c:out value="${logoutUrl}"/>');
			enRss.contextPath('<%=request.getContextPath()%>');
			enRss.domain(<c:out value="${domainInfo.domainId}"/>);
			$(document).ready(function() {
				$(function() {
					var propertyTabs = $("#RssManager_propertyTabs").tabs();
				});	
			});
		</script>
	</head>
	<body>
		<div id="list"></div>
		<div id="RssManager_propertyTabs">
			<ul>
				<li><a href="#RssManager_DetailTabPage" onclick="javascript:enFeed.detail();"><util:message key="hn.rss.label.detail"/></a></li>	
				<li><a href="#RssManager_EntryListTabPage" onclick="javascript:enEntry.uiList();"><util:message key="hn.rss.label.entryList"/></a></li>
			</ul>
			<div id="RssManager_DetailTabPage"></div>
			<div id="RssManager_EntryListTabPage"></div>
		</div>
	</body>
</html>