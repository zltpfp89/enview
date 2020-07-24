<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }" var="isSuperAdmin" />
<c:if test="${(userInfo.hasAdminRole || userInfo.hasManagerRole) || userInfo.hasDomainManagerRole}" var="isEditable"/>

<!-- CalendarManager_UserDetailTabPage -->
<div id="CalendarManager_UserDetailTabPage" class="board">
	<form id="calendarForm" name="calendarForm" method="post">
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
				<th class="L">사용자 ID <em>*</em></th>
				<td colspan="3" class="L"><c:out value="${calendarUser.userId }"/></td>
			</tr>
			<tr>
				<th class="L">사용자명 <em>*</em></th>
				<td colspan="3" class="L"><c:out value="${calendarUser.userName}"/></td>
			</tr>
			<tr>
				<th class="L">소속 </th>
				<td colspan="3" class="L"><c:out value="${calendarUser.userOrgName}"/></td>
			</tr>
			<tr>
				<th class="L">권한 </th>
				<td colspan="3" class="L">
					<input style="cursor: pointer;" type="checkbox" id="permissionsCRUDACheck" value="CRUDA" onclick="enCalUser.initPermissionsCheckboxes();" <c:if test="${calendarUser.permissions == 'CRUDA'}">checked="checked"</c:if> />
					<label style="cursor: pointer;" for="permissionsCRUDACheck">모든 권한(CRUD)</label>
					
					<input style="cursor: pointer;" type="checkbox" id="permissionsRUCheck" value="RU" onclick="enCalUser.initPermissionsCheckboxes();" <c:if test="${fn:indexOf(calendarUser.permissions, 'U') > -1}">checked="checked"</c:if> />
					<label style="cursor: pointer;" for="permissionsRUCheck">일정 변경(Read & Update)</label>
					
					<input style="cursor: pointer;" type="checkbox" id="permissionsRCheck" value="R" checked="checked" disabled="disabled" />
					<label style="cursor: pointer;" for="permissionsRCheck">일정 보기(Read Only)</label>
				</td>
			</tr>
			<tr>
				<th class="L">등록일시 </th>
				<td colspan="3" class="L"><c:out value="${calendarUser.insDatim}"/></td>
			</tr>
		</table>
			<!-- btnArea-->
			<div class="btnArea">
				<div id="RssManager_Child_EditButtons" class="rightArea">
		<c:if test="${calendarUser.deletable}">
					<a href="javascript:enCalUser.update()" class="btn_B"><span><util:message key="ev.title.save"/></span></a>
		</c:if>
		<c:if test="${ not calendarUser.deletable}">
		* 캘린더 생성자의 권한은 변경할 수 없습니다. 
		</c:if>
				</div>
			</div>
			<!-- btnArea//-->
	</form>		
</div>
<!-- CalendarManager_UserDetailTabPage// -->