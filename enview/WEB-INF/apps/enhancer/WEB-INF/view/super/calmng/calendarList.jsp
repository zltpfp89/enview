<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
	<tr>
		<td width="100%" valign="top">
			<div style=" " class="webpanel">
				<div id="CalendarManager_UserTabPage">
					<br style='line-height:5px;'>
					<div>
						<form id="CalendarManager_SearchForm" name="CalendarManager_SearchForm" style="display:inline" method="post" onsubmit="return false;">
						  <table width="99%">
							  <tr>
								<td align="right">
									<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }">
										<select id="CalendarManager_domainCond" name="CalendarManager_domainCond" class='webdropdownlist'>
											<option value="-1">* <util:message key='ev.prop.domain.domain'/> *</option>
											<c:forEach items="${domainList}" var="domain">
												<option value="<c:out value="${domain.domainId}"/>" <c:if test="${form.searchDomainId == domain.domainId}">selected="selected"</c:if>><c:out value="${domain.domainNm}"/></option>
											</c:forEach>
										</select>
									</c:if>
									<input type="text" class="webtextfield" id="searchValue" name="searchValue" value="<c:out value="${form.name}"/>" onkeydown="javascript:enCalDetail.search();"/>
									<span class="btn_pack small"><a href="javascript:enCalDetail.search();"><util:message key="ev.title.search"/></a></span>
									<select id="calendarListCount" name="listCount">
										<c:forEach begin="5" end="55" step="10" var="count">
											<c:if test="${count == 5 }">
												<option value="<c:out value="${count}"/>" <c:if test="${form.listCount == count }">selected</c:if>><c:out value="${count}"/></option>
											</c:if>
											<c:if test="${count >= 15 }">
												<option value="<c:out value="${count-5}"/>" <c:if test="${form.listCount == count-5 }">selected</c:if>><c:out value="${count-5}"/></option>
											</c:if>
										</c:forEach>
									</select>
								</td>
							  </tr>
						  </table>    
						</form>
					</div>
					<div class="webgridpanel">
					  <form id="CalendarManager_ListForm" style="display:inline" name="CalendarManager_ListForm" action="" method="post">
					  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
						<thead>
							<tr> 
								<td colspan="100" class="webgridheaderline"></td>
							</tr>
							<tr style="cursor: pointer;">
								<th class="webgridheader" align="center" width="30px">
									<input type="checkbox" id="checkAll" name="checkAll" class="calendarCheck webcheckbox" onclick="enCal.checkAll('calendarCheck');"/>
								</th>
								<th class="webgridheader" align="center" width="30px">No</th>
								<th class="webgridheader"><span >도메인</span></th>
								<th class="webgridheader"><span >캘린더명</span></th>
								<th class="webgridheader"><span >사용여부</span></th>
								<th class="webgridheader"><span >언어이중화</span></th>
								<th class="webgridheader"><span >생성자</span></th>
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
							<tr><td class="C" colspan="7"><util:message key="ev.search.no.result"/></td></tr>
						</c:if>
						</tbody>
					  </table>
					  </form>
					  <div id="CalendarManager_ListMessage">
						<c:out value='${resultMessage}'/>
					  </div>
					</div>
					<div>
						<table style="width:99%;" class="webbuttonpanel">
							<tr>
							    <td align="center">
										<img src="<%=request.getContextPath() %>/hancer/images/rss/button/btn_first.gif" title="맨 처음으로" onclick="javascript:enCalDetail.firstPage();"/>
										<img src="<%=request.getContextPath() %>/hancer/images/rss/button/btn_before.gif" title="열 페이지 앞으로" onclick="javascript:enCalDetail.prev10Page();"/>
										<c:if test="${page.currentStartPage == 1 and page.currentEndPage == 0 }">
											<span class="num currentPage">1</span>
										</c:if>
										<c:forEach begin="${page.currentStartPage}" end="${page.currentEndPage}" var="i">
											<c:if test = "${page.currentPage == i }" var="notCurrentPage" >
												<span><c:out value="${i}"/></span>
											</c:if>
											<c:if test="${not notCurrentPage }">
												<span style="cursor:pointer" onclick="javascript:enCalDetail.goPage(<c:out value="${i}"/>);"><c:out value="${i}"/></span>
											</c:if>
										</c:forEach>
										<img src="<%=request.getContextPath() %>/hancer/images/rss/button/btn_next.gif" title="열 페이지 뒤로" onclick="javascript:enCalDetail.next10Page();">
										<img src="<%=request.getContextPath() %>/hancer/images/rss/button/btn_last.gif" title="맨 마지막으로" onclick="javascript:enCalDetail.lastPage();">
							    </td>    
							</tr>
							<tr>
							    <td align="right">
									<span class="btn_pack small"><a href="javascript:enCalDetail.uiForm();"><util:message key="ev.title.add"/></a></span>
									<span class="btn_pack small"><a href="javascript:enCalDetail.deletes();"><util:message key="ev.title.remove"/></a></span>
							    </td>
							</tr>
						</table>
					</div> <!-- End webformpanel -->
				</div> <!-- End CalendarManager_UserTabPage -->
			</div>
		</td>
	<tr>
</table>
<script type="text/javascriopt">
	enCalDetail.m_currentPage = <c:out value="${page.currentPage}"/>;
	enCalDetail.m_lastPage = <c:out value="${page.pages}"/>;
</script>