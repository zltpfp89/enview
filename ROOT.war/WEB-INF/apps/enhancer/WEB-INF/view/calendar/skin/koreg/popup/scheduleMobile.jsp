<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<div id="schedulePops" class="tbl_normal" style="width: 100%; height: 100%;" name="schedulePops">
	<table style="width: 100%; height:100%; padding-top: 10px; padding-bottom: 10px; border-left-color : red;">
		<tr>
			<th scope="row" style="width:4%; border-right-color:white; border-bottom-color:white;"/>
			<td style="border-bottom-color : white; border-top-color : white; ">
				<input type="hidden" id="selectedSchedule" value="<c:out value="${schedule.scheduleId }"/>"/>
				<div id="scheduleDetailHeader" class="" style="width: 99%; margin-bottom: 10px;" >
					<div class="scheduleName" id="scheduleName" style="width: 100%;"><c:out value="${scheduleLang.name }" escapeXml="false"/>&nbsp;&nbsp;</div>
					<div class="scheduleDate" style="width: 100%;"><c:out value="${schedule.schedule }"/></div>
				</div>
			</td>
		</tr>
		<c:if test="${scheduleLang.place != null && fn:length(scheduleLang.place) > 0 }">
			<tr>
				<th scope="row" style=" width:4%; border-right-color:white;" />
				<td style=" border-top-color : white; ">
					<div id="scheduleDetailContent" class="" style="width: 99%; margin-bottom: 10px; ">
						<div class="schedulePlaces">
							<div class="schedulePlaceLabel"><util:message key='hn.title.schedule.place'/></div><div class="schedulePlace"><c:out value="${scheduleLang.place }" escapeXml="false"/></div>
						</div>
					</div>
				</td>
			</tr>
		</c:if>
		<c:if test="${schedule.isOwner || fn:indexOf(schedule.calPermissions, 'U') > -1 || fn:indexOf(schedule.permissions, 'U') > -1 || fn:indexOf(schedule.permissions, 'A') > -1}">
			<tr>
				<th scope="row" style=" width:4%; border-right-color:white;" />
				<td style="border-top-color: white;">
					<div id="scheduleDetailFooter" style="width: 99%; margin-left: 10px;" >
						<input type="hidden" id="detail_scheduleId" name="scheduleId" value="<c:out value="${form.scheduleId }"/>"/>
						<input type="hidden" id="detail_calendarId" name="calendarId" value="<c:out value="${schedule.calendarId }"/>"/>
						<input type="hidden" id="detail_isOwner" name="isOwner" value="<c:out value="${form.isOwner }"/>"/>
						<input type="hidden" id="detail_isDefault" name="isDefault" value="<c:out value="${form.isDefault }"/>"/>
						<input type="hidden" id="detail_isPublic" name="isPublic" value="<c:out value="${form.isPublic }"/>"/>
						<input type="hidden" id="detail_isJointSchedule" name="isJointSchedule" value="<c:out value="${form.isJoint}"/>"/>
					</div>
					<div style="text-align: right;">
						<div class="btn medium white"  onclick="enCal.modifySchedule('<c:out value="${form.scheduleId }"/>','<c:out value="${schedule.calendarId }" />', '<c:out value="${form.isOwner }"/>',' <c:out value="${form.isDefault }"/>','<c:out value="${form.isPublic }"/>','<c:out value="${form.isJoint}"/>');">
							<util:message key='hn.title.schedule.modify'/>
						</div>
						<c:if test="${schedule.isOwner || fn:indexOf(schedule.calPermissions, 'U') > -1 || fn:indexOf(schedule.permissions, 'D') > -1}">
							<div class="btn medium white" onclick="enCal.deleteSchedule();"><util:message key='hn.title.schedule.delete'/></div>
						</c:if>
					</div>	
				</td>
			</tr>
		</c:if>
	</table>
</div>