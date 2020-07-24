<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<div id="scheduleDetails" class="mobile scheduleEdit scheduleDetails<c:if test="${form.isPublic == 'Y' }">Public</c:if>">
	<input type="hidden" id="isJoint" name="isJoint" value="<c:out value="${form.isJoint }"/>"/>
	<input type="hidden" id="cmd" name="cmd" value="<c:out value="${form.cmd }"/>"/>
	<div id="scheduleDetailHeader" class="mobile scheduleDetail<c:if test="${form.isPublic == 'Y' }">Public</c:if> header">
		<label id="scheduleEditType" class="scheduleEditType"><c:if test="${form.cmd == 'MODIFY' }"><util:message key='hn.title.schedule.modify'/></c:if><c:if test="${form.cmd != 'MODIFY' }"><util:message key='hn.title.schedule.add'/></c:if></label>
		<div id="scheduleDetailClose" class="escapeButton ui-icon ui-icon-closethick"></div>
	</div>
	<div id="scheduleDetailContent1" class="mobile scheduleDetail content">
		<div id="scheduleCalendar" class="mobile scheduleCalendar">
			<input type="hidden" id="prevCalendarId" value="<c:out value="${form.calendarId}"/>"/>
			<select name="calendarId" id="selectedCalendarId" class="selectedCalendar mobile">
				<c:forEach items="${calendarList }" var="calendar" varStatus="status">
					<c:if test="${fn:indexOf(calendar.permissions, 'C') > -1 || fn:indexOf(calendar.permissions, 'U') > -1 }">
						<option value="<c:out value="${calendar.calendarId}"/>" <c:if test="${calendar.calendarId == form.calendarId}">selected="selected"</c:if>><c:out value="${calendar.name}" escapeXml="false"/></option>
					</c:if>
				</c:forEach>
			</select>
		</div>
		<c:if test="${form.isPublic == 'Y' }">
			<c:forEach items="${scheduleLangList }" var="lang" varStatus="status">
				<div class="mobile scheduleName" id="scheduleName_${lang.langKnd }"><label class="mobile scheduleNameLabel_${langKnd }" for="name_<c:out value="${lang.langKnd }"/>"><util:message key="hn.info.title.name.title.${lang.langKnd }"/></label><input class="mobile scheduleNameInput_${langKnd }" maxlength="100" id="name_<c:out value="${lang.langKnd }"/>" type="text" langKnd="<c:out value="${lang.langKnd }"/>" name="nameList" value="<c:out value="${lang.name }" escapeXml="false"/>"/></div>
			</c:forEach>
		</c:if>
		<c:if test="${form.isPublic != 'Y' }">
			<div class="mobile scheduleName" id="scheduleName"><label class="mobile scheduleNameLabel" for="name"><util:message key="hn.info.title.name.title"/></label><input class="mobile scheduleNameInput" maxlength="100" type="text" id="name" name="name" value="<c:out value="${scheduleLang.name }" escapeXml="false"/>"/></div>
		</c:if>
		<div class="mobile scheduleDate">
			<div id="startDates" class="mobile startDates">
				<input type="text" class="mobile date" readonly="readonly" id="start" name="start" value="<c:out value="${schedule.startDate }"/>"/>
				<div class="mobile dateTime ${langKnd }" id="startTime"><c:out value="${schedule.startTime12ap }"/><input type="hidden" name="times" value="<c:out value="${schedule.startTime23 }"/>"/></div>
			</div>
			<label class="mobile dateRange">&nbsp;~&nbsp;</label>
			<div id="endDates" class="mobile endDates">
				<input type="text" class="mobile date" readonly="readonly" id="end" name="end" value="<c:out value="${schedule.endDate }"/>"/>
				<div class="mobile dateTime ${langKnd }" id="endTime"><c:out value="${schedule.endTime12ap }"/><input type="hidden" name="times" value="<c:out value="${schedule.endTime23 }"/>"/></div>
			</div>
		</div>
		<div class="mobile scheduleAllday">
			<input class="mobile" type="checkbox" name="allday" id="allday" <c:if test="${schedule.allday == true }">checked="checked"</c:if>/><label for="allday"><util:message key='hn.title.schedule.allday'/></label>
		</div>
	</div>
	<%--
	<c:if test="${form.isPublic != 'Y' && ( schedule.isOwner || fn:indexOf(schedule.calPermissions, 'U') > -1 || fn:indexOf(schedule.permissions, 'U') > -1 || fn:indexOf(schedule.permissions, 'A') > -1 ) }">
		<div id="scheduleDetailContent2" class="scheduleDetail contentR">
			<div id="scheduleUsers" class="scheduleUsers">
				<label class="scheduleUserLabel"><util:message key='hn.title.schedule.attends'/></label>
				<div class="searchUser">
					<input type="text" name="searchUser" id="searchUser" /><span id="searchUserButton" class="searchButton ui-icon ui-icon-search"></span>
				</div>
			</div>
			<div id="attends" class="attends">
				<c:forEach items="${scheduleUserList }" var="user" varStatus="status">
					<div userId="<c:out value="${user.userId}"/>" userName="<c:out value="${user.userName}" escapeXml="false"/>" class="scheduleUser"<c:if test="${user.isOwner == 'Y' }"> style="color:#ccc"</c:if>>
						<div class="name" title="<c:out value="${user.userName}"/>(<c:out value="${user.userId}"/>)"><c:out value="${user.userName}" escapeXml="false"/>(<c:out value="${user.userId}"/>)</div>
						<c:if test="${user.isOwner != 'Y' }"><span class="deleteUser ui-icon ui-icon-trash" onclick="enCal.deleteUser(this)"></span></c:if>
					</div>
				</c:forEach>
			</div>
		</div>
	</c:if>
	--%>
	<div id="scheduleDetailContent3" class="mobile scheduleDetail content">
		<c:if test="${form.isPublic == 'Y' }">
			<c:forEach items="${scheduleLangList }" var="lang" varStatus="status">
				<div class="mobile schedulePlaces">
					<label class="mobile schedulePlaceLabel"><util:message key='hn.title.schedule.place.${lang.langKnd }'/></label><input class="mobile" type="text" langKnd="<c:out value="${lang.langKnd }"/>" name="placeList" value="<c:out value="${lang.place }"/>"/>
				</div>
				<div class="mobile scheduleComments">
					<label class="mobile scheduleCommentsLabel"><util:message key='hn.title.schedule.comments.${lang.langKnd }'/></label><textarea class="mobile" langKnd="<c:out value="${lang.langKnd }"/>" name="commentsList" cols="68" rows="2"><c:out value="${lang.comments }"/></textarea>
				</div>
			</c:forEach>
		</c:if>
		<c:if test="${form.isPublic != 'Y' }">
			<div class="mobile schedulePlaces">
				<label class="mobile schedulePlaceLabel"><util:message key='hn.title.schedule.place'/></label><input class="mobile" type="text"  maxlength="100" id="schedulePlace" name="place" value="<c:out value="${scheduleLang.place }"/>"/>
			</div>
			<div class="mobile scheduleComments">
				<label class="mobile scheduleCommentsLabel"><util:message key='hn.title.schedule.comments'/></label><textarea class="mobile" name="comments" id="scheduleComments"cols="68" rows="2"><c:out value="${scheduleLang.comments }"/></textarea>
			</div>
		</c:if>
	</div>
	<%--
	<c:if test="${form.isPublic != 'Y' && ( schedule.isOwner || fn:indexOf(schedule.calPermissions, 'U') > -1 || fn:indexOf(schedule.permissions, 'U') > -1 || fn:indexOf(schedule.permissions, 'A') > -1 ) }">
		<div class="scheduleDetail contentR2">
			<div id="scheduleUserPermissions" class="scheduleUserPermissions">
				<label class="scheduleUserPermissionLabel"><util:message key='hn.title.schedule.attends.permission'/></label>
			</div>
			<div id="permissions" class="permissions">
				<div class="permission">
					<input class="permissionCheck" id="permissionU" type="checkbox" name="permissionU" value="U" <c:if test="${fn:indexOf(schedule.permissions, 'U') > -1 }">checked="chekced"</c:if>/><label class="permissionCheckLabel" for="permissionU"><util:message key='hn.title.schedule.attends.permission.u'/></label>
				</div>
				<div class="permission">
					<input class="permissionCheck" id="permissionA" type="checkbox" name="permissionA" value="A" <c:if test="${fn:indexOf(schedule.permissions, 'A') > -1 }">checked="chekced"</c:if><c:if test="${fn:indexOf(schedule.permissions, 'U') > -1 }"> disabled="disabled"</c:if>/><label class="permissionCheckLabel" for="permissionA"><util:message key='hn.title.schedule.attends.permission.a'/></label>
				</div>
				<div class="permission">
					<input class="permissionCheck" id="permissionR" type="checkbox" name="permissionR" value="R" <c:if test="${fn:indexOf(schedule.permissions, 'R') > -1 }">checked="chekced"</c:if><c:if test="${fn:indexOf(schedule.permissions, 'U') > -1 }"> disabled="disabled"</c:if>/><label class="permissionCheckLabel" for="permissionR"><util:message key='hn.title.schedule.attends.permission.r'/></label>
				</div>
			</div>
		</div>
	</c:if>
	--%>
	<div id="scheduleDetailFooter" class="mobile scheduleDetail<c:if test="${form.isPublic == 'Y' }">Public</c:if> footer">
		<div class="mobile scheduleControl">
			<div class="mobile scheduleControlButton scheduleSave" onclick="enCal.saveSchedule();"><util:message key='hn.title.schedule.save'/></div>
		</div>
	</div>
</div>