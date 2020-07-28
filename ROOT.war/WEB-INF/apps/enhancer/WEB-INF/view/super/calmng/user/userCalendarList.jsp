
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<!-- contents -->
<div class="contents" style="min-height: 200px;">
	<!-- board first -->
	<div class="board first">
		<!-- searchArea-->
		<div class="tsearchArea">
			<p style="background: none; width: 0px;"></p>
			<fieldset>
				<form id="CalendarManager_SearchForm" name="CalendarManager_SearchForm" style="display:inline" method="post" onsubmit="return false;">
						<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }">
							<div class="sel_100">
								<select id="UserCalendarManager_domainCond" name="UserCalendarManager_domainCond" class='txt_100'>
									<option value="-1">* <util:message key='ev.prop.domain.domain'/> *</option>
									<c:forEach items="${domainList}" var="domain">
										<option value="<c:out value="${domain.domainId}"/>" <c:if test="${form.searchDomainId == domain.domainId}">selected="selected"</c:if>><c:out value="${domain.domainNm}"/></option>
									</c:forEach>
								</select>
							</div>
						</c:if>
						<div class="sel_100">
							<select id="CalendarManager_isDefaultCond" name="CalendarManager_isDefaultCond" class='txt_100'>
								<option value="">* 기본 여부 *</option>
								<option value="Y" <c:if test="${form.isDefault == 'Y' }">selected="selected"</c:if>>Y</option>
								<option value="N" <c:if test="${form.isDefault == 'N' }">selected="selected"</c:if>>N</option>
							</select>
						</div>
						
						<input type="text" class="txt_100" id="userCalendarSearchValue" name="searchValue" value="<c:out value="${form.name}"/>" onkeydown="javascript:enCalDetail.searchUserCalendar();"/>
						
						<div class="sel_70">
							<select id="calendarListCount" name="listCount" class='txt_70'>
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
						<a href="javascript:enCalDetail.searchUserCalendar();" class="btn_search"><span><util:message key="ev.title.search"/></span></a>
				</form>
			</fieldset>
		</div>
		<!-- searchArea// -->				
		<form id="listForm" name="listForm" method="post" onsubmit="return false;">	
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>
				<colgroup>
					<col width="30px" />
					<col width="30px" />
					<col width="*" />
					<col width="*" />
					<col width="*" />
					<col width="*" />
				</colgroup>		
				<thead>
					<tr>
						<th class="first">
							<input type="checkbox" id="checkAll" name="checkall" onclick="enCal.m_checkBox.chkAll(this);"/>
						</th>	
						<th class="C"><span class="table_title">No</span></th>		
						<th class="C">
							<span class="table_title">사용자 ID</span>
						</th>
						<th class="C">
							<span class="table_title">사용자명</span>
						</th>
						<th class="C">
							<span class="table_title">캘린더명</span>
						</th>
						<th class="C">
							<span class="table_title">기본 캘린더 여부</span>
						</th>						
					</tr>
				</thead>
				<tbody id="CalendarUserManager_ListBody">
					<c:if test="${empty results}">
					<tr>
						<td class="C" colspan="6">검색결과가 없습니다.</td>
					</tr>
					</c:if>
					<c:forEach items="${results}" var="userCalendar" varStatus="status">
					<tr style="cursor:pointer;"  class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>">
						<td class="C">
							<input type="checkbox" name="userCalendarCheck" id="calendarUser<c:out value="${status.count }"/>" value='<c:out value="${userCalendar.calendarId}" />' class="webcheckbox userCalendarCheck"  onclick="enCalDetail.selectUserCalendar(<c:out value="${status.index}"/>);"/>							
						</td>
						<td class="C" onclick="enCalDetail.selectUserCalendar(<c:out value="${status.index}"/>);">
							<span><c:out value="${page.currentStartRow + status.index}"/></span>
						</td>	
						<td class="C" onclick="enCalDetail.selectUserCalendar(<c:out value="${status.index}"/>);">
							<div style="width: 99%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
								<c:out value="${userCalendar.userId}"/>
							</div>
						</td>
						<td class="C" onclick="enCalDetail.selectUserCalendar(<c:out value="${status.index}"/>);">
							<div style="width: 99%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
								<c:out value="${userCalendar.userName}"/>
							</div>
						</td>
						<td class="C" onclick="enCalDetail.selectUserCalendar(<c:out value="${status.index}"/>);">
							<div style="width: 99%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
								<c:out value="${userCalendar.calendarName}"/>
							</div>
						</td>
						<td class="C" onclick="enCalDetail.selectUserCalendar(<c:out value="${status.index}"/>);">
							<span style="width: 180px;">&nbsp;
								<c:out value="${userCalendar.isDefault}" />
								<input type="hidden" id="${userCalendar.calendarId}_isDefault" value="${userCalendar.isDefault }"/>
							</span>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- tcontrol-->
			<div class="tcontrol">
				<!-- paging -->
				<div id="pagingButtons" class="paging">
					<a href="javascript:void(0);" class="noline">
						<img src="<%=request.getContextPath() %>/admin/images/btn_first.gif" title="맨 처음으로" onclick="javascript:enCalUser.firstPage();"/>
					</a>
					<a href="javascript:void(0);" class="noline">
						<img src="<%=request.getContextPath() %>/admin/images/btn_prev.gif" title="열 페이지 앞으로" onclick="javascript:enCalUser.prev10Page();"/>
					</a>
					<c:if test="${page.currentStartPage == 1 and page.currentEndPage == 0 }">
						<a href="javascript:void(0);" class="on first">1</a>
					</c:if>
					<c:forEach begin="${page.currentStartPage}" end="${page.currentEndPage}" var="i">
						<c:if test = "${page.currentPage == i }" var="notCurrentPage" >
							<a href="javascript:void(0);" class="on first"><c:out value="${i}"/></a>
						</c:if>
						<c:if test="${not notCurrentPage }">
							<a href="javascript:enCalUser.goPage(<c:out value="${i}"/>);"><c:out value="${i}"/></a>
						</c:if>
					</c:forEach>
					<a href="javascript:void(0);" class="noline">
						<img src="<%=request.getContextPath() %>/admin/images/btn_next.gif" title="열 페이지 뒤로" onclick="javascript:enCalUser.next10Page();">
					</a>
					<a href="javascript:void(0);" class="noline">
						<img src="<%=request.getContextPath() %>/admin/images/btn_last.gif" title="맨 마지막으로" onclick="javascript:enCalUser.lastPage();">
					</a>			
				</div>
				<!-- paging// -->
			</div>
			<!-- tcontrol// -->
		</form>
	</div>
	<!-- board first// -->
</div>
<!-- contents// -->