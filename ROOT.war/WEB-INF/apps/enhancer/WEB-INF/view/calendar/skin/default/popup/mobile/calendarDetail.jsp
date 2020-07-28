<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<div id="calendarDetails" class="calendarEdit calendarDetails<c:if test="${calendar.isPublic == 'Y' }">Public</c:if>">
	<input type="hidden" id="isJoint" name="isJoint" value="<c:out value="${form.isJoint }"/>"/>
	<input type="hidden" id="cmd" name="cmd" value="<c:out value="${form.cmd }"/>"/>
	<div id="calendarDetailHeader" class="calendarDetail<c:if test="${calendar.isPublic == 'Y' }">Public</c:if> header">
		<label id="calendarEditType" class="calendarEditType"><c:if test="${form.cmd == 'MODIFY' }"><util:message key='hn.title.calendar.modify'/></c:if><c:if test="${form.cmd != 'MODIFY' }"><util:message key='hn.title.calendar.add'/></c:if></label>
		<div id="calendarDetailClose" class="escapeButton ui-icon ui-icon-closethick"></div>
	</div>
	<div id="calendarDetailContent1" class="calendarDetail content">
		<c:if test="${calendar.isPublic == 'Y' }">
			<c:forEach items="${calendarLangList }" var="lang" varStatus="status">
				<div class="calendarName" id="calendarName"><label class="calendarNameLabel_${langKnd}" for="name_<c:out value="${lang.langKnd }"/>"><util:message key="hn.info.title.name.title.${lang.langKnd }"/></label><input type="text" class="calendarNameInput_${langKnd}" maxlength="100" langKnd="<c:out value="${lang.langKnd }"/>" name="nameList" value="<c:out value="${lang.name }"/>"/></div>
			</c:forEach>
		</c:if>
		<c:if test="${calendar.isPublic != 'Y' }">
			<div class="calendarName" id="calendarName"><label class="calendarNameLabel" for="name"><util:message key="hn.info.title.name.title"/></label><input type="text" class="calendarNameInput" maxlength="100" id="name" name="name" value="<c:out value="${calendarLang.name }"/>"/></div>
		</c:if>
	</div>
	<c:if test="${form.cmd != 'MODIFY' || (calendar.isPublic != 'Y' && ( calendar.isOwner || fn:indexOf(calendar.permissions, 'U') > -1 || fn:indexOf(calendar.permissions, 'A') > -1 )) }">
		<div id="calendarDetailContent2" class="calendarDetail contentR">
			<div id="calendarUsers" class="calendarUsers">
				<label class="calendarUserLabel"><util:message key='hn.title.calendar.joint'/></label>
				<div class="searchUser">
					<input type="text" name="searchUser" id="searchUser" /><span id="searchUserButton" class="searchButton ui-icon ui-icon-search"></span>
				</div>
			</div>
			<div id="attends" class="attends">
				<c:forEach items="${calendarUserList }" var="user" varStatus="status">
					<div userId="<c:out value="${user.userId}"/>" userName="<c:out value="${user.userName}"/>" class="calendarUser"<c:if test="${user.userId == calendar.ownerId }"> style="color:#ccc"</c:if>>
						<div class="name" title="<c:out value="${user.userName}"/>(<c:out value="${user.userId}"/>) [ <c:if test="${user.userOrgName != null && fn:length(user.userOrgName) > 0 && user.userOrgName != 'N/A' }" var="isOrgNameNotNull"><c:out value="${user.userOrgName }"/></c:if><c:if test="${!isOrgNameNotNull}"><util:message key="hn.info.userOrg.not.exist"/></c:if> / <c:if test="${user.userGroupCd != null && fn:length(user.userGroupCd) > 0}" var="isGrpCdNotNull"><util:message key="hn.info.userGrp.${user.userGroupCd}"/></c:if><c:if test="${!isGrpCdNotNull }"><util:message key="hn.info.userGrp.not.exist"/></c:if>]">
							<c:out value="${user.userName}"/>
							(<c:out value="${user.userId}"/>) 
							[
							<c:if test="${user.userOrgName != null && fn:length(user.userOrgName) > 0 && user.userOrgName != 'N/A' }" var="isOrgNameNotNull">
								<c:out value="${user.userOrgName }"/>
							</c:if>
							<c:if test="${!isOrgNameNotNull}">
								<util:message key="hn.info.userOrg.not.exist"/>
							</c:if> / 
							<c:if test="${user.userGroupCd != null && fn:length(user.userGroupCd) > 0}" var="isGrpCdNotNull">
								<util:message key="hn.info.userGrp.${user.userGroupCd}"/>
							</c:if>
							<c:if test="${!isGrpCdNotNull }">
								<util:message key="hn.info.userGrp.not.exist"/>
							</c:if>
							]
						</div>
						<c:if test="${user.userId != calendar.ownerId }">
							<select id="<c:out value="${user.userId}"/>_permissions" name="<c:out value="${user.userId}"/>_permissions" onchange="enCal.onchangePermissions('<c:out value="${user.userId}"/>')">
								<%--<option value="CRUDA" <c:if test="${user.permissions == 'CRUDA'}">selected="selected"</c:if>><util:message key='hn.title.calendar.permissions.cruda'/></option> --%>
								<option value="RU" <c:if test="${user.permissions == 'RU'}">selected="selected"</c:if>><util:message key='hn.info.title.calendar.permissions.ru'/></option>
								<option value="R" <c:if test="${user.permissions == 'R'}">selected="selected"</c:if>><util:message key='hn.info.title.calendar.permissions.r'/></option>
							</select>
							<span class="deleteUser ui-icon ui-icon-trash" onclick="enCal.deleteCalendarUser(this)"></span>
						</c:if>
					</div>
				</c:forEach>
			</div>
		</div>
	</c:if>
	<div id="calendarDetailContent3" class="calendarDetail content">
		<c:if test="${form.isPublic == 'Y' }">
			<c:forEach items="${calendarLangList }" var="lang" varStatus="status">
				<div class="calendarComments">
					<label class="calendarCommentsLabel"><util:message key='hn.title.calendar.comments'/></label><textarea langKnd="<c:out value="${lang.langKnd }"/>" name="commentsList" cols="58" rows="3"><c:out value="${lang.comments }"/></textarea>
				</div>
			</c:forEach>
		</c:if>
		<c:if test="${form.isPublic != 'Y' }">
			<div class="calendarComments">
				<label class="calendarCommentsLabel"><util:message key='hn.title.calendar.comments'/></label><textarea name="comments"  id="calendarComments"cols="58" rows="3"><c:out value="${calendarLang.comments }"/></textarea>
			</div>
		</c:if>
	</div>
	<div id="calendarDetailFooter" class="calendarDetail<c:if test="${form.isPublic == 'Y' }">Public</c:if> footer">
		<div class="calendarControl">
			<div class="calendarControlButton calendarSave" onclick="enCal.saveCalendar('<c:out value="${calendar.calendarId}"/>');"><util:message key='hn.title.calendar.save'/></div>
		</div>
	</div>
</div>