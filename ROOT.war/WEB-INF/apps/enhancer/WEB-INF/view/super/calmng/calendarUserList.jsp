<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<form id="listForm" name="listForm" method="post" onsubmit="return false;">
	<div class="tsearchArea">
	<p></p>
	<fieldset>
		<input type="text" id="userSearchValue" name="userSearchValue" class="txt_100" value="<c:out value="${form.searchValue}"/>" onkeydown="javascript:enCalUser.search();"/>						
		<a href="javascript:enCalUser.search();" title="검색" class="btn_search"><span>검색</span></a>
		<div class="sel_100">
			<select id="calendarUserListCount" name="listCount" class="txt_100">
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
		</fieldset>
	</div>
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
					<span class="table_title">소속</span>
				</th>
				<th class="C">
					<span class="table_title">권한</span>
				</th>						
				<th class="C">
					<span class="table_title">등록일시</span>
				</th>	
			</tr>
		</thead>
		<tbody id="CalendarUserManager_ListBody">
			<c:if test="${total == 0}">
				<tr>
					<td class="C" colspan="100">지정된 사용자가 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach items="${results}" var="calendarUser" varStatus="status">
				<tr style="cursor:pointer;"  class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>">
					<td class="C">
						<input type="checkbox" name="calendarUserCheck" id="calendarUser<c:out value="${status.count }"/>" value='<c:out value="${calendarUser.userId}" />' />							
					</td>
					<td class="C" onclick="enCalUser.select(<c:out value="${status.index}"/>);">
						<c:out value="${page.currentStartRow + status.index}"/>
					</td>	
					<td class="C" onclick="enCalUser.select(<c:out value="${status.index}"/>);">
						<div style="width: 99%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
							<c:out value="${calendarUser.userId}"/>
						</div>
					</td>
					<td class="C" onclick="enCalUser.select(<c:out value="${status.index}"/>);">
						<div style="width: 99%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
							<c:out value="${calendarUser.userName}"/>
						</div>
					</td>
					<td class="C" onclick="enCalUser.select(<c:out value="${status.index}"/>);">
						<div style="width: 99%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
							<c:out value="${calendarUser.userOrgName}"/>
						</div>
					</td>
					<td class="C" onclick="enCalUser.select(<c:out value="${status.index}"/>);">
						<div style="width: 99%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
							<c:out value="${calendarUser.permissions}"/>
						</div>
					</td>
					<td class="C" onclick="enCalUser.select(<c:out value="${status.index}"/>);">
						<span style="width: 180px;">&nbsp;
							<c:out value="${calendarUser.insDatim}" />
							<input type="hidden" id="${calendarUser.userId}_isDeletable" value="${calendarUser.isDeletable }"/>
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
	<!-- btnArea-->
	<div class="btnArea">
		<div class="rightArea">
			<a href="javascript:enCalUser.getUserChooser().doShow(enCalUser.insertUser);" class="btn_B"><span><util:message key="ev.title.add"/></span></a>
			<a href="javascript:enCalUser.deletes();" class="btn_B"><span><util:message key="ev.title.remove"/></span></a>
		</div>
	</div>
	<!-- btnArea//-->
	<div id="CalendarManager_UserPropertyTabs">
		<ul>
			<li><a href="#CalendarManager_UserDetailTabPage" onclick="javascript:enCalUser.detail();"><util:message key="ev.title.detailTab"/></a></li>
		</ul>
		<div id="CalendarManager_UserDetailTabPage"></div>
	</div>		
</form>
				
<script type="text/javascript">
	enCalUser.m_currentPage = <c:out value="${page.currentPage}"/>;
	enCalUser.m_lastPage = <c:out value="${page.pages}"/>;
</script>