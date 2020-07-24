<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }" var="isSuperAdmin" />
<c:if test="${(userInfo.hasAdminRole || userInfo.hasManagerRole) || userInfo.hasDomainManagerRole}" var="isEditable"/>

<!-- CalendarManager_GroupDetailTabPage -->
<div id="CalendarManager_GroupDetailTabPage" class="board">		
	<form id="calendarForm" name="calendarForm">
		<input	type="hidden" id="calendarId" name="id" value="<c:out value="${calendar.calendarId}"/>" />
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
	 		<caption>게시판</caption>
			<colgroup>
				<col width="140px" />
				<col width="*" />
				<col width="140px" />
				<col width="*" />
			</colgroup>	
			<c:if test="${!isSuperAdmin}"><input type="hidden" id="domainId" value="<c:out value="${domainInfo.domainId}"/>"/></c:if>
			<tr>
				<th class="L">그룹 코드</th>
				<td colspan="3" class="L"><input type="text" id="groupId" name="groupId" readonly="readonly" class="txt_100" value="<c:out value="${calendarGroup.groupId }"/>"/></td>
			</tr>
			<tr>
				<th class="L">권한 </th>
				<td colspan="3" class="L">
					<input style="cursor: pointer;" type="checkbox" id="permissionsCRUDACheck" value="CRUDA" onclick="enCalGroup.initPermissionsCheckboxes();" <c:if test="${calendarGroup.permissions == 'CRUDA'}">checked="checked"</c:if> />
					<label style="cursor: pointer;" for="permissionsCRUDACheck">모든 권한(CRUD)</label>
					
					<input style="cursor: pointer;" type="checkbox" id="permissionsRUCheck" value="RU" onclick="enCalGroup.initPermissionsCheckboxes();" <c:if test="${fn:indexOf(calendarGroup.permissions, 'U') > -1}">checked="checked"</c:if> />
					<label style="cursor: pointer;" for="permissionsRUCheck">일정 변경(Read & Update)</label>
					
					<input style="cursor: pointer;" type="checkbox" id="permissionsRCheck" value="R" checked="checked" disabled="disabled" />
					<label style="cursor: pointer;" for="permissionsRCheck">일정 보기(Read Only)</label>
				</td>
			</tr>
			<tr>
				<th class="L">등록일시 </th>
				<td colspan="3" class="L"><c:out value="${calendarGroup.insDatim}"/></td>
			</tr>
		</table>
		<!-- btnArea-->
		<div class="btnArea">
			<div id="CalendarManager_Child_EditButtons" class="rightArea">
				<a href="javascript:enCalGroup.update()" class="btn_B"><span><util:message key="ev.title.save"/></span></a>
			</div>
		</div>
		<!-- btnArea//-->				
	</form>
</div>
<!-- CalendarManager_GroupDetailTabPage// -->	