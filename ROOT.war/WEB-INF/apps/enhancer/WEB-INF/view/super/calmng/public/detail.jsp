<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }" var="isSuperAdmin" />
<c:if test="${(userInfo.hasAdminRole || userInfo.hasManagerRole) || (userInfo.hasDomainManagerRole && calendar.domainId != 0)}" var="isEditable"/>

<script type="text/javascript">
	$("#colorSet").spectrum({
		preferredFormat: "rgb",
		showPalette: true,
		showPaletteOnly: true,
		hideAfterPaletteSelect:true,
		palette: [["rgb(172, 114, 94)","rgb(208, 107, 100)","rgb(248, 58, 34)","rgb(250, 87, 60)","rgb(255, 117, 55)","rgb(255, 173, 70)"],
				  ["rgb(66, 214, 146)","rgb(22, 167, 101)","rgb(123, 209, 72)","rgb(179, 220, 108)","rgb(251, 233, 131)","rgb(250, 209, 101)"],
				  ["rgb(146, 225, 192)","rgb(159, 225, 231)","rgb(159, 198, 231)","rgb(73, 134, 231)","rgb(154, 156, 255)","rgb(185, 154, 255)"],
				  ["rgb(194, 194, 194)","rgb(202, 189, 191)","rgb(204, 166, 172)","rgb(246, 145, 178)","rgb(205, 116, 230)","rgb(164, 122, 226)"]
				],
		change : function(color) {
			$("#bgColor").val(color.toRgbString());
		}
	});	
</script>

<!-- CalendarManager_DetailTabPage -->
<div id="CalendarManager_DetailTabPage" class="board">
	<form id="calendarForm" name="calendarForm" method="post" action="<%=request.getContextPath()%>/hancer/calendar/detailCalendar.hanc">
		<input	type="hidden" id="calendarId" name="id" value="<c:out value="${calendar.calendarId}"/>" />
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<c:if test="${isSuperAdmin}">
				<tr>
					<th class="L">도메인 </th>
					<td colspan="3" class="L">
						<div class="sel_100">
							<select id="calendarDomainId" name="domainId" class="txt_100">
								<c:forEach items="${domainList}" var="domain">
									<option <c:if test="${calendar.domainId == domain.domainId}">selected="selected"</c:if> value="<c:out value="${domain.domainId}"/>"><c:out value="${domain.domainNm}"/></option>
								</c:forEach>
							</select>
						</div>
					</td>
				</tr>
			</c:if>
			<c:if test="${!isSuperAdmin}"><input type="hidden" id="domainId" value="<c:out value="${domainInfo.domainId}"/>"/></c:if>
			<tr>
				<th class="L">캘린더명 <em>*</em></th>
				<td colspan="3" class="L">
					<input type="text" id="name" name="name" value="<c:out value="${calendar.name}"/>" size="100" class="txt_600" <c:if test="${!isEditable}">readonly="readonly"</c:if>/>
				</td>
			</tr>
			<tr>
				<th class="L">색상 <em>*</em></th>
				<td colspan="3" class="L">
					<input type="text" id="bgColor" name="bgColor" value="<c:out value="${calendar.bgColor}"/>" size="100" class="txt_145" readonly/>
					<input type="text" id="colorSet" name="colorSet" value="<c:out value="${calendar.bgColor}"/>"/>
				</td>
			</tr>
			<tr>
				<th class="L">언어이중화 <em>*</em></th> 
				<td colspan="3" class="L">
					<input type="radio" style="cursor:pointer;" id="isBilingualY" name="isBilingual" value="1"<c:if test="${calendar.bilingual}">checked="checked"</c:if>/>
					<label for="isBilingualY" style="cursor:pointer;"><util:message key="hn.info.calendar.isBilingual.1"/></label>
					<input type="radio" style="cursor:pointer;" id="isBilingualN" name="isBilingual" value="0"<c:if test="${!calendar.bilingual}">checked="checked"</c:if>/>
					<label for="isBilingualN" style="cursor:pointer;"><util:message key="hn.info.calendar.isBilingual.0"/></label>
				</td>
			</tr>
			<tr>
				<th class="L">사용여부 </th>
				<td colspan="3" class="L">
					<input type="radio" style="cursor:pointer;" id="isUseY" name="isUse" value="1"<c:if test="${calendar.use}">checked="checked"</c:if>/>
					<label for="isUseY" style="cursor:pointer;"><util:message key="hn.info.calendar.isUse.1"/></label>
					<input type="radio" style="cursor:pointer;" id="isUseN" name="isUse" value="0"<c:if test="${!calendar.use}">checked="checked"</c:if>/>
					<label for="isUseN" style="cursor:pointer;"><util:message key="hn.info.calendar.isUse.0"/></label>
				</td>
			</tr>
			<tr>
				<th class="L">캘린더 타입 </th>
				<td colspan="3" class="L">
					<div class="sel_100">
						<select id="calendarPublicType" name="publicType" class="txt_100">
							<option <c:if test="${calendar.publicType == 'P'}">selected="selected"</c:if> value="P">전체 공개(P)</option>
							<option <c:if test="${calendar.publicType == 'G'}">selected="selected"</c:if> value="G">부서 공개(G)</option>
						</select>
					</div>
				</td>
			</tr>
			<tr>
				<th class="L">생성자 </th>
				<td colspan="3" class="L"><c:out value="${calendar.ownerId}"/></td>
			</tr>
			<tr>
				<th class="L">비고 </th>
				<td colspan="3" class="L">
					<input type="text" id="comments" name="comments" value="<c:out value="${calendar.comments}"/>" size="100" class="txt_600" <c:if test="${!isEditable}">readonly="readonly"</c:if>/>
				</td>
			</tr>
		</table>
		<c:if test="${isEditable}">
			<!-- btnArea-->
			<div class="btnArea">
				<div id="CalendarManager_Child_EditButtons" class="rightArea">
					<a href="javascript:enCalDetail.update()" class="btn_B"><span><util:message key="ev.title.save"/></span></a>
				</div>
			</div>
			<!-- btnArea//-->
		</c:if>
	</form>			
</div>
<!-- CalendarManager_DetailTabPage// -->