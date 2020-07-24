<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<div id="searchUserList" class="searchUserList">
	<c:if test="${empty results }">
		<div class="searchedUserRow noUser"><util:message key='hn.title.calendar.user.search.empty'/></div>
	</c:if>
	<c:forEach items="${results}" var="searchUser" varStatus="status">
		<div class="searchedUserRow">
			<label userId="<c:out value="${searchUser.userId}"/>" userName="<c:out value="${searchUser.userName}"/>" class="searchedUser ellipsis" title="<c:out value="${searchUser.userName}"/>(<c:out value="${searchUser.userId}"/>) [ <c:if test="${searchUser.userOrgName != null && fn:length(searchUser.userOrgName) > 0 && searchUser.userOrgName != 'N/A' }" var="isOrgNameNotNull"><c:out value="${searchUser.userOrgName }"/></c:if><c:if test="${!isOrgNameNotNull}"><util:message key="hn.info.userOrg.not.exist"/></c:if> / <c:if test="${searchUser.userGroupCd != null && fn:length(searchUser.userGroupCd) > 0}" var="isGrpCdNotNull"><util:message key="hn.info.userGrp.${searchUser.userGroupCd}"/></c:if><c:if test="${!isGrpCdNotNull }"><util:message key="hn.info.userGrp.not.exist"/></c:if> ]">
				<c:out value="${searchUser.userName}"/>
				(<c:out value="${searchUser.userId}"/>) 
				[
				<c:if test="${searchUser.userOrgName != null && fn:length(searchUser.userOrgName) > 0 && searchUser.userOrgName != 'N/A' }" var="isOrgNameNotNull">
					<c:out value="${searchUser.userOrgName }"/>
				</c:if>
				<c:if test="${!isOrgNameNotNull}">
					<util:message key="hn.info.userOrg.not.exist"/>
				</c:if> / 
				<c:if test="${searchUser.userGroupCd != null && fn:length(searchUser.userGroupCd) > 0}" var="isGrpCdNotNull">
					<util:message key="hn.info.userGrp.${searchUser.userGroupCd}"/>
				</c:if>
				<c:if test="${!isGrpCdNotNull }">
					<util:message key="hn.info.userGrp.not.exist"/>
				</c:if>
				]
			</label>
		</div>
		<br />
	</c:forEach>
</div>