<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }" var="isSuperAdmin" />
<c:if test="${(userInfo.hasAdminRole || userInfo.hasManagerRole) || userInfo.hasDomainManagerRole}" var="isEditable"/>

<!-- CalendarManager_LangDetailTabPage -->
<div id="CalendarManager_LangDetailTabPage" class="board">
	<form id="calendarForm" name="calendarForm" method="post" action="<%=request.getContextPath()%>/hancer/calendar/detailCalendar.hanc">
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
				<th class="L">언어 <em>*</em></th>
				<td colspan="3" class="L">
					<div class="sel_100">
						<select id="detailLangKnd" name="langKnd" class='txt_100' disabled="disabled">
							<c:forEach items="${langKndList}" var="langKnd">
								<option value="<c:out value="${langKnd.code}"/>" <c:if test="${langKnd.code == calendarLang.langKnd }">selected="selected"</c:if>><c:out value="${langKnd.codeName}"/></option>
							</c:forEach>
						</select>
					</div>
				</td>
			</tr>
			<tr>
				<th class="L">캘린더명 <em>*</em></th>
				<td colspan="3" class="L">
					<input type="text" id="langName" name="name" value="<c:out value="${calendarLang.name}"/>" size="100" class="txt_600" <c:if test="${!isEditable}">readonly="readonly"</c:if>/>
				</td>
			</tr>
			<tr>
				<th class="L">비고 </th>
				<td colspan="3" class="L">
					<input type="text" id="langComments" name="comments" value="<c:out value="${calendarLang.comments}"/>" size="100" class="txt_600" <c:if test="${!isEditable}">readonly="readonly"</c:if>/>
				</td>
			</tr>
		</table>
		<c:if test="${isEditable}">
			<!-- btnArea-->
			<div class="btnArea">
				<div id="RssManager_Child_EditButtons" class="rightArea">
					<a href="javascript:enCalLang.update()" class="btn_B"><span><util:message key="ev.title.save"/></span></a>
				</div>
			</div>
			<!-- btnArea//-->				
		</c:if>
	</form>			
</div>
<!-- CalendarManager_LangDetailTabPage// -->