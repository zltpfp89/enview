<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<html>
	<head>
		<title><util:message key="hn.note.label.user"/> <util:message key="hn.note.label.search"/></title>
		<c:if test="${windowId == null}" var="result">
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${langKnd}"/>_mm.js"></script>
		</c:if>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${langKnd}"/>_hn.js"></script>
		<script type="text/javascript">
			var contextPath = "<%= request.getContextPath()%>";
			var errorMessage = "<c:out value="${errorMessage}"/>";
		</script> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/note/default/search.js"></script>
		
		<link rel="stylesheet" href="<%=request.getContextPath()%>/hancer/css/note/default/search.css" type="text/css">
	</head>
	<body>
		<div class="searchForm">
			<div class="searchButton" onclick="javascript:searchUser();"><util:message key="hn.note.label.search"/></div>
			<input type="text" name="searchValue" id="searchValue" class="inputField searchValue" onkeyup="javascript:searchUserEnter(event);">
			
			<select id="searchType" name="searchType" class="inputField searchType">
				<!-- option class="searchTypes firstOptn" value="0" selected><util:message key="hn.note.label.select"/></option -->
				<option class="searchTypes firstOptn" value="1"><util:message key="hn.note.label.id"/></option>
				<option class="searchTypes" value="2"><util:message key="hn.note.label.name"/></option>
				<!-- option class="searchTypes" value="3"><util:message key="hn.note.label.groupName"/></option -->
			</select>
			
			<select id="searchGroup" name="searchGroup" class="inputField searchType">
				<option class="searchTypes firstOptn" value="0">전체</option>
				<c:forEach items="${groupList}" var="group" varStatus="idx">
					<option class="searchTypes" value="${group.principalId}">${group.principalName}</option>	
				</c:forEach>
			</select>				
		</div>
		<div class="searchResult" id="searchResult"></div>
		<div class="controlLayer">
			<div class="noteButton OKButton" onclick="selectUser()"><util:message key="hn.note.label.ok"/></div>
			<div class="noteButton cancelButton" onclick="javascript:self.close();"><util:message key="hn.note.label.cancel"/></div>
		</div>
	</body>
</html>