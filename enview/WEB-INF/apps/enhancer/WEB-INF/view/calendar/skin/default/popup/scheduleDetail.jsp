<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<div id="scheduleDetails" class="scheduleEdit scheduleDetails<c:if test="${calendar.bilingual && calendar.isPublic }">Public</c:if>">
	<input type="hidden" id="isJoint" name="isJoint" value="<c:out value="${calendar.isJoint }"/>"/>
	<input type="hidden" id="cmd" name="cmd" value="<c:out value="${form.cmd }"/>"/>
	<div id="scheduleDetailHeader" class="scheduleDetail<c:if test="${calendar.bilingual && calendar.isPublic }">Public</c:if> header">
		<label id="scheduleEditType" class="scheduleEditType"><c:if test="${form.cmd == 'MODIFY' }"><util:message key='hn.title.schedule.modify'/></c:if><c:if test="${form.cmd != 'MODIFY' }"><util:message key='hn.title.schedule.add'/></c:if></label>
		<div id="scheduleDetailClose" class="escapeButton ui-icon ui-icon-closethick"></div>
	</div>
	<div id="scheduleDetailContent1" class="scheduleDetail content">
		<div id="scheduleCalendar" class="scheduleCalendar">
			<input type="hidden" id="prevCalendarId" value="<c:out value="${form.calendarId}"/>"/>
			<select name="calendarId" id="selectedCalendarId" class="selectedCalendar">
				<c:forEach items="${calendarList }" var="calendar" varStatus="status">
					<c:if test="${fn:indexOf(calendar.permissions, 'C') > -1 || fn:indexOf(calendar.permissions, 'U') > -1 }">
						<option value="<c:out value="${calendar.calendarId}"/>" <c:if test="${calendar.calendarId == form.calendarId}">selected="selected"</c:if>><c:out value="${calendar.name}" escapeXml="false"/></option>
					</c:if>
				</c:forEach>
			</select>
		</div>
		<c:if test="${calendar.bilingual && calendar.isPublic }">
			<c:forEach items="${scheduleLangList }" var="lang" varStatus="status">
				<div class="scheduleName" id="scheduleName_${lang.langKnd }"><label class="scheduleNameLabel_${langKnd }" for="name_<c:out value="${lang.langKnd }"/>"><util:message key="hn.info.title.name.title.${lang.langKnd }"/></label><input class="scheduleNameInput_${langKnd }" maxlength="100" id="name_<c:out value="${lang.langKnd }"/>" type="text" langKnd="<c:out value="${lang.langKnd }"/>" name="nameList" value="<c:out value="${lang.name }" escapeXml="false"/>"/></div>
			</c:forEach>
		</c:if>
		<c:if test="${!calendar.bilingual || !calendar.isPublic }">
			<div class="scheduleName" id="scheduleName"><label class="scheduleNameLabel" for="name"><util:message key="hn.info.title.name.title"/></label><input class="scheduleNameInput" maxlength="100" type="text" id="name" name="name" value="<c:out value="${scheduleLang.name }" escapeXml="false"/>"/></div>
		</c:if>
		<div class="scheduleDate">
			<div id="startDates" class="startDates">
				<input type="text" class="date" readonly="readonly" id="start" name="start" value="<c:out value="${schedule.startDate }"/>" <c:if test="${schedule.rrule != null && schedule.startDate != schedule.repeatStartDate }">disabled="disabled"</c:if>/>
				<div class="dateTime ${langKnd }" id="startTime"><c:out value="${schedule.startTime12ap }"/><input type="hidden" name="times" value="<c:out value="${schedule.startTime23 }"/>"/></div>
			</div>
			<label class="dateRange">&nbsp;~&nbsp;</label>
			<div id="endDates" class="endDates">
				<input type="text" class="date" readonly="readonly" id="end" name="end" value="<c:out value="${schedule.endDate }"/>" <c:if test="${schedule.rrule != null && schedule.startDate != schedule.repeatStartDate }">disabled="disabled"</c:if>/>
				<div class="dateTime ${langKnd }" id="endTime"><c:out value="${schedule.endTime12ap }"/><input type="hidden" name="times" value="<c:out value="${schedule.endTime23 }"/>"/></div>
			</div>
		</div>
		<div class="scheduleAllday">
			<input type="checkbox" name="allday" id="allday" <c:if test="${schedule.allday == true }">checked="checked"</c:if>/><label for="allday"><util:message key='hn.title.schedule.allday'/></label>
			<input type="checkbox" name="alarmPatternLabel" id="alarmPattern" <c:if test="${schedule.alarmPattern != null }">checked="checked"</c:if>/><label for="alarmPattern"><util:message key='hn.title.schedule.alarmPattern'/></label>
		</div>
		<div class="scheduleAlarm">
			<input type="radio" name="alarmPattern" id="alarmPattern_b10m"  value="b10m" <c:if test="${schedule.alarmPattern == 'b10m' }">checked="checked"</c:if> /><label class="valLabel" for="alarmPattern_b10m"><util:message key='hn.title.schedule.alarmPattern.b10m'/></label>
			<input type="radio" name="alarmPattern" id="alarmPattern_b20m"  value="b20m" <c:if test="${schedule.alarmPattern == 'b20m' }">checked="checked"</c:if>/><label class="valLabel" for="alarmPattern_b20m"><util:message key='hn.title.schedule.alarmPattern.b20m'/></label>
			<input type="radio" name="alarmPattern" id="alarmPattern_b1h"   value="b1h"  <c:if test="${schedule.alarmPattern == 'b1h'  }">checked="checked"</c:if>/><label class="valLabel" for="alarmPattern_b1h"><util:message key='hn.title.schedule.alarmPattern.b1h'/></label>
			<input type="radio" name="alarmPattern" id="alarmPattern_b12h"  value="b12h" <c:if test="${schedule.alarmPattern == 'b12h' }">checked="checked"</c:if>/><label class="valLabel" for="alarmPattern_b12h"><util:message key='hn.title.schedule.alarmPattern.b12h'/></label>
			<input type="radio" name="alarmPattern" id="alarmPattern_b1d"   value="b1d"  <c:if test="${schedule.alarmPattern == 'b1d'  }">checked="checked"</c:if>/><label class="valLabel" for="alarmPattern_b1d"><util:message key='hn.title.schedule.alarmPattern.b1d'/></label>
		</div>
		<div class="scheduleRrule">
			<input type="checkbox" name="rruleLabel" id="rrule" <c:if test="${schedule.rrule != null && schedule.startDate != schedule.repeatStartDate }">disabled="disabled"</c:if><c:if test="${schedule.rrule != null}">checked="checked"</c:if>/><label for="rrule"><util:message key='hn.title.schedule.rrule'/></label>
			<label class="valLabel"><util:message key='hn.title.schedule.rrule.text'/></label>: <label class="valLabel" id="rruleText"><util:message key='hn.title.schedule.rrule.noRepeat'/></label> 
		</div>
		<div class="scheduleRruleFreq">
			<label class="valLabel"><util:message key='hn.title.schedule.rrule.freq'/>:</label>
			<select id="freq" name="freq">
				<option value="DAILY" <c:if test="${schedule.freq == 'DAILY'}">selected="selected"</c:if>><util:message key='hn.title.schedule.rrule.freq.daily'/></option>
				<option value="WEEKLY" <c:if test="${schedule.freq == 'WEEKLY'}">selected="selected"</c:if>><util:message key='hn.title.schedule.rrule.freq.weekly'/></option>
				<option value="MONTHLY" <c:if test="${schedule.freq == 'MONTHLY'}">selected="selected"</c:if>><util:message key='hn.title.schedule.rrule.freq.monthly'/></option>
				<option value="YEARLY" <c:if test="${schedule.freq == 'YEARLY'}">selected="selected"</c:if>><util:message key='hn.title.schedule.rrule.freq.yearly'/></option>
			</select>
			<label class="valLabel"><util:message key='hn.title.schedule.rrule.interval'/>:</label>
			<input type="hidden" id="orgInterval" value="${schedule.interval}"/>
			<select id="interval" name="interval">
				<c:forEach begin="1" end="30" var="interval">
					<option value="${interval}" <c:if test="${schedule.interval == interval}">selected="selected"</c:if>>${interval}</option>
				</c:forEach>
			</select>
		</div>
		<div class="scheduleRruleByday" id="scheduleRruleByday">
			<label class="valLabel"><util:message key='hn.title.schedule.rrule.byday'/>:</label>
			<input type="checkbox" name="byday" id="su" value="su" <c:if test="${fn:indexOf(schedule.byday, 'su') > -1}">checked="checked"</c:if>/><label class="valLabel" for="su"><util:message key='hn.title.schedule.rrule.byday.su'/></label>
			<input type="checkbox" name="byday" id="mo" value="mo" <c:if test="${fn:indexOf(schedule.byday, 'mo') > -1}">checked="checked"</c:if>/><label class="valLabel" for="mo"><util:message key='hn.title.schedule.rrule.byday.mo'/></label>
			<input type="checkbox" name="byday" id="tu" value="tu" <c:if test="${fn:indexOf(schedule.byday, 'tu') > -1}">checked="checked"</c:if>/><label class="valLabel" for="tu"><util:message key='hn.title.schedule.rrule.byday.tu'/></label>
			<input type="checkbox" name="byday" id="we" value="we" <c:if test="${fn:indexOf(schedule.byday, 'we') > -1}">checked="checked"</c:if>/><label class="valLabel" for="we"><util:message key='hn.title.schedule.rrule.byday.we'/></label>
			<input type="checkbox" name="byday" id="th" value="th" <c:if test="${fn:indexOf(schedule.byday, 'th') > -1}">checked="checked"</c:if>/><label class="valLabel" for="th"><util:message key='hn.title.schedule.rrule.byday.th'/></label>
			<input type="checkbox" name="byday" id="fr" value="fr" <c:if test="${fn:indexOf(schedule.byday, 'fr') > -1}">checked="checked"</c:if>/><label class="valLabel" for="fr"><util:message key='hn.title.schedule.rrule.byday.fr'/></label>
			<input type="checkbox" name="byday" id="sa" value="sa" <c:if test="${fn:indexOf(schedule.byday, 'sa') > -1}">checked="checked"</c:if>/><label class="valLabel" for="sa"><util:message key='hn.title.schedule.rrule.byday.sa'/></label>
		</div>
		<div class="scheduleRruleBymonthday" id="scheduleRruleBymonthday">
			<label class="valLabel"><util:message key='hn.title.schedule.rrule.bymonthday'/>:</label>
			<input type="radio" name="bymonthday" id="bymonthday" value="bymonthday" <c:if test="${schedule.byday == null}">checked="checked"</c:if>/><label class="valLabel" for="bymonthday"><util:message key='hn.title.schedule.rrule.bymonthday'/></label>
			<input type="radio" name="bymonthday" id="byday" value="byday" <c:if test="${schedule.byday != null}">checked="checked"</c:if>/><label class="valLabel" for="byday"><util:message key='hn.title.schedule.rrule.byday'/></label>
		</div>
		<div class="scheduleRruleDate" id="scheduleRruleStartDate">
			<label class="valLabel"><util:message key='hn.title.schedule.startDate'/>:</label>
			<div id="rruleStartDates" class="rruleStartDates">
				<input type="text" class="rruleDate" readonly="readonly" disabled="disabled" id="rruleStart" name="rruleStart" value="<c:if test="${schedule.repeatStart != null }"><c:out value="${schedule.repeatStartDate }"/></c:if>"/>
			</div>
		</div>
		<div class="scheduleRruleDate" id="scheduleRruleEndDate">
		<label class="valLabel"><util:message key='hn.title.schedule.endDate'/>:</label>
			<input type="radio" name="untilType" id="untilType_unlimited" value="unlimited" <c:if test="${schedule.until == null }">checked="checked"</c:if> /><label class="valLabel" for="untilType_unlimited"><util:message key='hn.title.schedule.endDate.unlimited'/></label>
			<input type="radio" name="untilType" id="untilType_limited" value="limited" <c:if test="${schedule.until != null }">checked="checked"</c:if>/><label class="valLabel" for="untilType_limited"><util:message key='hn.title.schedule.endDate.unlimited'/>:</label>
			<div id="rruleEndDates" class="rruleEndDates">
				<input type="text" class="rruleDate" readonly="readonly" id="until" name="until" value="<c:if test="${schedule.until != null }"><c:out value="${schedule.untilDate }"/></c:if>"/>
			</div>
		</div>
	</div>
	<%--
	<c:if test="${(!calendar.bilingual || !calendar.isPublic) && ( schedule.isOwner || fn:indexOf(schedule.calPermissions, 'U') > -1 || fn:indexOf(schedule.permissions, 'U') > -1 || fn:indexOf(schedule.permissions, 'A') > -1 ) }">
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
	<div id="scheduleDetailContent3" class="scheduleDetail content">
		<c:if test="${calendar.bilingual && calendar.isPublic }">
			<c:forEach items="${scheduleLangList }" var="lang" varStatus="status">
				<div class="schedulePlaces">
			<label class="schedulePlaceLabel"><util:message key='hn.title.schedule.place'/></label><input type="text" langKnd="<c:out value="${lang.langKnd }"/>" name="placeList" value="<c:out value="${lang.place }"/>"/>
		</div>
		<div class="scheduleComments">
			<label class="scheduleCommentsLabel"><util:message key='hn.title.schedule.comments'/></label><textarea langKnd="<c:out value="${lang.langKnd }"/>" name="commentsList" cols="58" rows="3"><c:out value="${lang.comments }"/></textarea>
		</div>
			</c:forEach>
		</c:if>
		<c:if test="${ !calendar.bilingual || !calendar.isPublic }">
			<div class="schedulePlaces">
				<label class="schedulePlaceLabel"><util:message key='hn.title.schedule.place'/></label><input type="text"  maxlength="100" id="schedulePlace" name="place" value="<c:out value="${scheduleLang.place }"/>"/>
			</div>
			<div class="scheduleComments">
				<label class="scheduleCommentsLabel"><util:message key='hn.title.schedule.comments'/></label><textarea name="comments" id="scheduleComments"cols="58" rows="3"><c:out value="${scheduleLang.comments }"/></textarea>
			</div>
		</c:if>
	</div>
	<%--
	<c:if test="${( !calendar.bilingual || !calendar.isPublic ) && ( schedule.isOwner || fn:indexOf(schedule.calPermissions, 'U') > -1 || fn:indexOf(schedule.permissions, 'U') > -1 || fn:indexOf(schedule.permissions, 'A') > -1 ) }">
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
	<div id="scheduleDetailFooter" class="scheduleDetail<c:if test="${calendar.bilingual && calendar.isPublic }">Public</c:if> footer">
		<div class="scheduleControl">
			<div class="scheduleControlButton scheduleSave" onclick="enCal.saveSchedule();"><util:message key='hn.title.schedule.save'/></div>
		</div>
	</div>
</div>