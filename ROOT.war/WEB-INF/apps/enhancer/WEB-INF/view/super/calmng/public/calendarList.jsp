<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<!-- board first -->
<div id="CalendarManager_UserTabPage" class="board first">
	<!-- searchArea-->
	<div class="tsearchArea">
		<p style="background: none"></p>
		<fieldset>
			<form id="CalendarManager_SearchForm" name="CalendarManager_SearchForm" style="display:inline" method="post" onsubmit="return false;">
				<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }">
					<div class="sel_100">
						<select id="CalendarManager_domainCond" name="CalendarManager_domainCond" class='txt_100'>
							<option value="-1">* <util:message key='ev.prop.domain.domain'/> *</option>
							<c:forEach items="${domainList}" var="domain">
								<option value="<c:out value="${domain.domainId}"/>" <c:if test="${form.searchDomainId == domain.domainId}">selected="selected"</c:if>><c:out value="${domain.domainNm}"/></option>
							</c:forEach>
						</select>
					</div>
				</c:if>
				<input type="text" class="txt_100" id="searchValue" name="searchValue" value="<c:out value="${form.name}"/>" onkeydown="javascript:enCalDetail.search();"/>
				<a href="javascript:enCalDetail.search();" class="btn_search"><span><util:message key="ev.title.search"/></span></a>
				<div class="sel_100">
					<select id="calendarListCount" name="listCount" class="txt_100">
						<c:forEach begin="5" end="55" step="10" var="count">
							<c:if test="${count == 5 }">
								<option value="<c:out value="${count}"/>" <c:if test="${form.listCount == count }">selected</c:if>><c:out value="${count}"/></option>
							</c:if>
							<c:if test="${count >= 15 }">
								<option value="<c:out value="${count-5}"/>" <c:if test="${form.listCount == count-5 }">selected</c:if>><c:out value="${count-5}"/></option>
							</c:if>
						</c:forEach>
					</select>
				</div>
			</form>			
		</fieldset>
	</div>
	<!-- searchArea// -->
	<form id="CalendarManager_ListForm" style="display:inline" name="CalendarManager_ListForm" action="" method="post">
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
	 		<caption>게시판</caption>
			<colgroup>
				<col width="30px" />
				<col width="30px" />
				<col width="*" />
				<col width="*" />
				<col width="*" />
				<col width="*" />
				<col width="*" />
				<col width="*" />
			</colgroup>	
			<thead>
				<tr>
					<th class="first">
						<input type="checkbox" id="checkAll" name="checkAll" onclick="enCal.checkAll('calendarCheck');"/>
					</th>
					<th class="C"><span class="table_title">No</span></th>
					<th class="C"><span class="table_title">도메인</span></th>
					<th class="C"><span class="table_title">캘린더명</span></th>
					<th class="C"><span class="table_title">공개 타입</span></th>
					<th class="C"><span class="table_title">사용여부</span></th>
					<th class="C"><span class="table_title">언어이중화</span></th>
					<th class="C"><span class="table_title">생성자</span></th>
				</tr>
			</thead>
			<tbody id="CalendarManager_ListBody">
				<c:forEach items="${results}" var="calendar"  varStatus="status">
					<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>">
						<td align="center" class="webgridbody">
							<input type="checkbox" id="calendar_<c:out value="${calendar.calendarId}"/>" class="webcheckbox calendarCheck" name="calendarCheck" value="<c:out value="${calendar.calendarId}"/>"/>
							<input type="hidden" id="calendarDomainId_<c:out value="${calendar.calendarId}"/>" value="<c:out value="${calendar.domainId}"/>"/>
						</td>
						<td align="center" class="webgridbody" onclick="enCalDetail.select(<c:out value="${status.index}"/>);">
							<span><c:out value="${page.currentStartRow + status.index}"/></span>
						</td>
						<td align="center" class="webgridbody" onclick="enCalDetail.select(<c:out value="${status.index}"/>);">
							<span class="webgridrowlabel">&nbsp;<c:out value="${calendar.domainNm}"/></span>
						</td>
						<td align="center" class="webgridbody" onclick="enCalDetail.select(<c:out value="${status.index}"/>);">
							<span class="webgridrowlabel">&nbsp;<c:out value="${calendar.name}"/></span>
						</td>
						<td align="center" class="webgridbody" onclick="enCalDetail.select(<c:out value="${status.index}"/>);">
							<span class="webgridrowlabel">&nbsp;<c:out value="${calendar.publicType}"/></span>
							<input type="hidden" id="${calendar.calendarId}_publicType" value="<c:out value="${calendar.publicType}"/>"/>
						</td>
						<td align="center" class="webgridbody" onclick="enCalDetail.select(<c:out value="${status.index}"/>);">
							<span class="webgridrowlabel">&nbsp;<util:message key="hn.info.calendar.isUse.${calendar.isUse}"/></span>
						</td>
						<td align="center" class="webgridbody" onclick="enCalDetail.select(<c:out value="${status.index}"/>);">
							<span class="webgridrowlabel">&nbsp;<util:message key="hn.info.calendar.isBilingual.${calendar.isBilingual}"/></span>
						</td>
						<td align="center" class="webgridbody" onclick="enCalDetail.select(<c:out value="${status.index}"/>);">
							<span class="webgridrowlabel">&nbsp;<c:out value="${calendar.ownerId}"/></span>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty results}">
					<tr><td class="C" colspan="8"><util:message key="ev.search.no.result"/></td></tr>
				</c:if>
			</tbody>
		</table>
	</form>
	<!-- tcontrol-->
	<div class="tcontrol">
		<!-- paging -->
		<div id="ClientManager_PAGE_ITERATOR" class="paging">
			<a href="javascript:void(0);" class="noline">
				<img src="<%=request.getContextPath() %>/admin/images/btn_first.gif" title="맨 처음으로" onclick="javascript:enCalDetail.firstPage();"/>
			</a>
			<a href="javascript:void(0);" class="noline">
				<img src="<%=request.getContextPath() %>/admin/images/btn_prev.gif" title="열 페이지 앞으로" onclick="javascript:enCalDetail.prev10Page();"/>
			</a>
			<c:if test="${page.currentStartPage == 1 and page.currentEndPage == 0 }">
				<a href="javascript:void(0);" class="on first">1</a>
			</c:if>
			<c:forEach begin="${page.currentStartPage}" end="${page.currentEndPage}" var="i">
				<c:if test = "${page.currentPage == i }" var="notCurrentPage" >
					<a href="javascript:void(0);" class="on first"><c:out value="${i}"/></a>
				</c:if>
				<c:if test="${not notCurrentPage }">
					<a href="javascript:enApp.goPage(<c:out value="${i}"/>);"><c:out value="${i}"/></a>
				</c:if>
			</c:forEach>
			<a href="javascript:void(0);" class="noline">
				<img src="<%=request.getContextPath() %>/admin/images/btn_next.gif" title="열 페이지 뒤로" onclick="javascript:enCalDetail.next10Page();">
			</a>
			<a href="javascript:void(0);" class="noline">
				<img src="<%=request.getContextPath() %>/admin/images/btn_last.gif" title="맨 마지막으로" onclick="javascript:enCalDetail.lastPage();">
			</a>
		</div>
		<!-- paging//-->
	</div>
	<!-- tcontrol//-->
	<!-- btnArea-->
	<div class="btnArea">
		<div class="rightArea">
			<a href="javascript:enCalDetail.uiForm();" class="btn_W"><span><util:message key="ev.title.add"/></span></a>
			<a href="javascript:enCalDetail.deletes();" class="btn_W"><span><util:message key="ev.title.remove"/></span></a>
		</div>
	</div>
	<!-- btnArea//-->
</div>
<!-- board first// -->

<script type="text/javascriopt">
	enCalDetail.m_currentPage = <c:out value="${page.currentPage}"/>;
	enCalDetail.m_lastPage = <c:out value="${page.pages}"/>;
</script>