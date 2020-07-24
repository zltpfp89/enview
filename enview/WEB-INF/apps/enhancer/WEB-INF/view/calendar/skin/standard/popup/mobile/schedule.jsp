<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<div id="schedulePops" class="scheduleEdit schedulePops mobile">
	<div class="triangle triangleTop" id="triangleTop">
		<div class="triangle-tp"></div>
		<div class="triangle-tps"></div>
	</div>
	<input type="hidden" id="selectedSchedule" value="<c:out value="${schedule.scheduleId }"/>"/>
	<div id="scheduleDetailHeader" class="schedulePop header mobile">
		<label class="scheduleName ellipsis mobile" id="scheduleName" title="<c:out value="${scheduleLang.name }" escapeXml="false"/>"><c:out value="${scheduleLang.name }" escapeXml="false"/></label><div id="scheduleClose" class="escapeButton ui-icon ui-icon-closethick"></div>
	</div>
	<div id="scheduleDetailContent" class="schedulePop content mobile">
		<div class="scheduleDate mobile"><c:out value="${schedule.schedule }"/></div>
		<c:if test="${fn:length(scheduleLang.place) > 0 && scheduleLang.place != '' }">
			<div class="schedulePlaces mobile">
				<div class="schedulePlaceLabel mobile"><util:message key='hn.title.schedule.place'/></div><div class="schedulePlace mobile"><c:out value="${scheduleLang.place }" escapeXml="false"/></div>
			</div>
		</c:if>
		<%--
		<c:if test="${(schedule.isOwner || schedule.permissions != null) && !empty scheduleUserList }">
			<div class="scheduleUsers">
				<div class="scheduleUserLabel"><util:message key='hn.title.schedule.attends'/></div>
				<div class="scheduleUserList">
					<c:forEach items="${scheduleUserList }" var="user" varStatus="status">
						<div class="scheduleUser"<c:if test="${user.isOwner == 'Y' }"> style="color:#ccc"</c:if>><c:out value="${user.userName}"/>(<c:out value="${user.userId}"/>)<c:if test="${!status.last }">,</c:if></div>
					</c:forEach>
				</div>
			</div>
		</c:if>
		--%>
		<div class="scheduleOwner mobile">
			<div class="scheduleOwnerLabel ellipsis" title="<util:message key='hn.title.schedule.owner' param="${schedule.ownerName}"/>"><util:message key='hn.title.schedule.owner' param="${schedule.ownerName}"/></div>
		</div>
	</div>
	
	<c:if test="${ fn:indexOf(schedule.calPermissions, 'U') > -1 }">
		<div id="scheduleDetailFooter" class="schedulePop footer mobile">
			<input type="hidden" id="detail_scheduleId" name="scheduleId" value="<c:out value="${form.scheduleId }"/>"/>
			<input type="hidden" id="detail_calendarId" name="calendarId" value="<c:out value="${schedule.calendarId }"/>"/>
			<input type="hidden" id="detail_isOwner" name="isOwner" value="<c:out value="${form.isOwner }"/>"/>
			<input type="hidden" id="detail_isDefault" name="isDefault" value="<c:out value="${form.isDefault }"/>"/>
			<input type="hidden" id="detail_isJointSchedule" name="isJointSchedule" value="<c:out value="${form.isJoint }"/>"/>
			<div class="scheduleControl">
				<c:if test="${ fn:indexOf(schedule.calPermissions, 'D') > -1 }">
					<div class="scheduleControlButton scheduleDelete mobile" onclick="enCal.deleteSchedule();"><util:message key='hn.title.schedule.delete'/></div>
				</c:if>
				<div class="scheduleControlButton scheduleModify mobile" onclick="enCal.modifySchedule();"><util:message key='hn.title.schedule.modify'/></div>
			</div>
		</div>
	</c:if>
	<div class="triangle triangleBottom" id="triangleBottom">
		<div class="triangle-bt"></div>
		<div class="triangle-bts"></div>
	</div>
</div>