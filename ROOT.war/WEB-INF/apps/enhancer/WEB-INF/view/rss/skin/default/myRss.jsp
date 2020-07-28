<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title><util:message key="hn.rss.label.rssTitle"/></title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/admin/css/styles.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/hancer/css/rss/default/rss.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/decorations/layout/admin/css/styles.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/decorations/layout/css/styles.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/decorations/layout/css/jquery/base/jquery.ui.all.css" />
		
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
		<script type='text/javascript' src="<%=request.getContextPath()%>/hancer/javascript/rss/default/myRss.js"></script>
		<script type="text/javascript">
			enRss.logoutUrl('<c:out value="${logoutUrl}"/>');
			enRss.contextPath('<%=request.getContextPath()%>');
		</script>
	</head>
	<body>
		<div id="RssManager_feedListTabs">
			<ul>
				<li><a href="#RssManager_myFeedListPage" onclick="javascript:enFeed.selectTab('my');">내 피드</a></li>	
				<li><a href="#RssManager_requestFeedListPage" onclick="javascript:enFeed.selectTab('request');">신청 피드</a></li>
				<li><a href="#RssManager_myEntryListPage" onclick="javascript:enEntry.uiMyEntryList();">뉴스 리스트</a></li>
			</ul>
			<div id="RssManager_myFeedListPage"></div>
			<div id="RssManager_requestFeedListPage"></div>
			<div id="RssManager_myEntryListPage"></div>
		</div>
		<div id="RssManager_propertyTabs">
			<ul>
				<li><a href="#RssManager_DetailTabPage" onclick="javascript:enFeed.detail();">상세보기</a></li>	
			</ul>
			<div id="RssManager_DetailTabPage"></div>
		</div>
	</body>
</html>