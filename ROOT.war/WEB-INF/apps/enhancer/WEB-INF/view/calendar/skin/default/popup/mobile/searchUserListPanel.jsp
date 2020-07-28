<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<div id="searchUserList" class="searchUserList">
	<c:if test="${empty results }">
		<div class="" style="color:black;"><util:message key='hn.title.calendar.user.search.empty'/></div>
	</c:if>
	<c:forEach items="${results}" var="searchUser" varStatus="status">
		<div class="searchedUserRow">
			<div title="<c:out value="${searchUser.userName}"/>(<c:out value="${searchUser.userId}"/>)" userId="<c:out value="${searchUser.userId}"/>" userName="<c:out value="${searchUser.userName}"/>" class="searchedUser ellipsis"><c:out value="${searchUser.userName}"/>(<c:out value="${searchUser.userId}"/>)</div>
		</div>
		<br />
	</c:forEach>
</div>