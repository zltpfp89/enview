<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title><c:out value="${lang.rssTitle}"/></title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css" />
		<%-- 
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/hancer/css/super/calmng.css" /> 
		--%>
		<c:if test="${windowId == null}" var="result">
			<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
			<script type='text/javascript' src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
			
			<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${langKnd}"/>_mm.js"></script>
			<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${langKnd}"/>_ev.js"></script>
			<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
			<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
			<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
			<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
		</c:if>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${langKnd}"/>_hn.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userManager.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/hancer/javascript/super/calmng.js"></script>
		
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/javascript/colorpicker/spectrum.css" />
		<script type='text/javascript' src="<%=request.getContextPath()%>/javascript/colorpicker/spectrum.js"></script>
		
		<script type="text/javascript">
			enCal.logoutUrl('<c:out value="${logoutUrl}"/>');
			enCal.contextPath('<%=request.getContextPath()%>');
			enCal.domain(<c:out value="${domainInfo.domainId}"/>);
		</script>
	</head>
	<body>
		<div id="list"></div>
		<div id="CalendarManager_propertyTabs">
			<ul>
				<li><a href="#CalendarManager_DetailTabPage" onclick="javascript:enCalDetail.detail();">상세보기</a></li>
				<li><a href="#CalendarManager_LangListTabPage" onclick="javascript:enCalLang.uiList();">다국어</a></li>	
				<li><a href="#CalendarManager_UserListTabPage" onclick="javascript:enCalUser.uiList();">일정 관리자 목록</a></li>
				<li><a href="#CalendarManager_GroupListTabPage" onclick="javascript:enCalGroup.uiList();">그룹 목록</a></li>
			</ul>
			<div id="CalendarManager_DetailTabPage"></div>
			<div id="CalendarManager_LangListTabPage"></div>
			<div id="CalendarManager_UserListTabPage"></div>
			<div id="CalendarManager_GroupListTabPage"></div>
		</div>
		<div id="UserManager_UserChooser" style="display:none;"></div>
		<div id="CalendarManager_GroupChooser" style="display:none;"></div>
	</body>
</html>