<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<div id="calendarPopup" class="calendarPopup">
	<c:if test="${form.cmd != 'my' }">
		<ul class=popupMenus>
			<li tabindex="0" class="popupRow" onclick="enCal.renderOnlyThis('<c:out value="${form.calendarId}"/>')"><util:message key='hn.title.calendar.only'/></li>
			<c:if test="${user.isOwner == 'Y' }">
				<li tabindex="0" class="popupRow" onclick="enCal.showCalendarDetail('MODIFY','<c:out value="${user.calendarId}"/>');"><util:message key='hn.title.calendar.modify'/></li>
			</c:if>
			<c:if test="${user != null && fn:indexOf(user.permissions, 'C') > -1 }">
				<li tabindex="0" class="popupRow" onclick="enCal.showScheduleDetailForCalendar('<c:out value="${user.calendarId}"/>');"><util:message key='hn.title.calendar.create.schedule'/></li>
			</c:if>
			<c:if test="${user != null && user.isOwner == 'Y' && form.isDefault != 'Y' && form.isPublic != 'Y' }">
				<li tabindex="0" class="popupRow" onclick="enCal.deleteCalendar('<c:out value="${user.calendarId}"/>');"><util:message key='hn.title.calendar.delete'/></li>
			</c:if>
			<c:if test="${user != null && user.isOwner == 'N' }">
				<li tabindex="0" class="popupRow" onclick="enCal.deleteCalendar('<c:out value="${user.calendarId}"/>');"><util:message key='hn.title.calendar.delete.joint'/></li>
			</c:if>
			<c:if test="${user != null && fn:indexOf(user.permissions, 'R') > -1 }">
				<li tabindex="0" class="popupRow"onclick="enCal.iCalendar('<c:out value="${form.calendarId}"/>', 'export');"><util:message key='hn.title.calendar.ical.export'/></li>
			</c:if>
			<c:if test="${user != null && fn:indexOf(user.permissions, 'C') > -1 }">
				<li tabindex="0" class="popupRow"onclick="enCal.iCalendar('<c:out value="${form.calendarId}"/>', 'import');"><util:message key='hn.title.calendar.ical.import'/></li>
			</c:if>
		</ul>
		<c:if test="${ ( form.isPublic == 'Y' && ((user != null && user.isOwner == 'Y') || fn:indexOf(user.permissions, 'U') > -1) ) || form.isPublic != 'Y' }">
			<div class="colorChooser">
				<div class="colorPalette ui-state-bg-white">
					<div class="color" style="border: 1px solid rgb(172, 114, 94); background-color: rgb(172, 114, 94);"></div>
					<div class="color" style="border: 1px solid rgb(208, 107, 100); background-color: rgb(208, 107, 100);"></div>
					<div class="color" style="border: 1px solid rgb(248, 58, 34); background-color: rgb(248, 58, 34);"></div>
					<div class="color" style="border: 1px solid rgb(250, 87, 60); background-color: rgb(250, 87, 60);"></div>
					<div class="color" style="border: 1px solid rgb(255, 117, 55); background-color: rgb(255, 117, 55);"></div>
					<div class="color" style="border: 1px solid rgb(255, 173, 70); background-color: rgb(255, 173, 70);"></div>

					<div class="color" style="border: 1px solid rgb(66, 214, 146); background-color: rgb(66, 214, 146);"></div>
					<div class="color" style="border: 1px solid rgb(22, 167, 101); background-color: rgb(22, 167, 101);"></div>
					<div class="color" style="border: 1px solid rgb(123, 209, 72); background-color: rgb(123, 209, 72);"></div>
					<div class="color" style="border: 1px solid rgb(179, 220, 108); background-color: rgb(179, 220, 108);"></div>
					<div class="color" style="border: 1px solid rgb(251, 233, 131); background-color: rgb(251, 233, 131);"></div>
					<div class="color" style="border: 1px solid rgb(250, 209, 101); background-color: rgb(250, 209, 101);"></div>

					<div class="color" style="border: 1px solid rgb(146, 225, 192); background-color: rgb(146, 225, 192);"></div>
					<div class="color" style="border: 1px solid rgb(159, 225, 231); background-color: rgb(159, 225, 231);"></div>
					<div class="color" style="border: 1px solid rgb(159, 198, 231); background-color: rgb(159, 198, 231);"></div>
					<div class="color" style="border: 1px solid rgb(73, 134, 231); background-color: rgb(73, 134, 231);"></div>
					<div class="color" style="border: 1px solid rgb(154, 156, 255); background-color: rgb(154, 156, 255);"></div>
					<div class="color" style="border: 1px solid rgb(185, 154, 255); background-color: rgb(185, 154, 255);"></div>

					<div class="color" style="border: 1px solid rgb(194, 194, 194); background-color: rgb(194, 194, 194);"></div>
					<div class="color" style="border: 1px solid rgb(202, 189, 191); background-color: rgb(202, 189, 191);"></div>
					<div class="color" style="border: 1px solid rgb(204, 166, 172); background-color: rgb(204, 166, 172);"></div>
					<div class="color" style="border: 1px solid rgb(246, 145, 178); background-color: rgb(246, 145, 178);"></div>
					<div class="color" style="border: 1px solid rgb(205, 116, 230); background-color: rgb(205, 116, 230);"></div>
					<div class="color" style="border: 1px solid rgb(164, 122, 226); background-color: rgb(164, 122, 226);"></div>
				</div>
			</div>
		</c:if>
	</c:if>
	<c:if test="${form.cmd == 'my' }">
		<input type="hidden" name="cmd" value="ADD"/>
		<ul class=popupMenus>
			<li tabindex="0" class="popupRow" onclick="enCal.showCalendarDetail('ADD');"><util:message key='hn.title.calendar.create.new'/></li>
		</ul>
	</c:if>
</div>