<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<form id="listForm" name="listForm" method="post" onsubmit="return false;">
	<div class="tsearchArea">
		<p>그룹 권한은 공개 타입이 G인 공개 캘린더에 한해 적용됩니다.</p>
	<fieldset>
		<input type="text" id="groupSearchValue" name="groupSearchValue" class="txt_100" value="<c:out value="${form.searchValue}"/>" onkeydown="javascript:enCalGroup.search();"/>						
		<a href="javascript:enCalGroup.search();" title="검색" class="btn_search"><span>검색</span></a>
		<div class="sel_100">
			<select id="calendarGroupListCount" name="listCount" class="txt_100">
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
		</colgroup>
		<thead>
			<tr>
				<th class="first">
					<input type="checkbox" id="checkAll" name="checkall" onclick="enCal.checkAll('calendarGroupCheck');"/>
				</th>	
				<th class="C"><span class="table_title">No</span></th>				
				<th class="C">
					<span class="table_title">그룹코드</span>
				</th>
				<th class="C">
					<span class="table_title">권한</span>
				</th>						
				<th class="C">
					<span class="table_title">등록일시</span>
				</th>	
			</tr>
		</thead>
		<tbody id="CalendarGroupManager_ListBody">
			<c:if test="${total == 0}">
				<tr>
					<td class="C" colspan="100">지정된 그룹이 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach items="${results}" var="calendarGroup" varStatus="status">
				<tr style="cursor:pointer;"  class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>">
					<td class="C">
						<input type="checkbox" name="calendarGroupCheck" id="calendarGroup<c:out value="${status.count }"/>" value='<c:out value="${calendarGroup.groupId}" />' class="webcheckbox calendarGroupCheck" />							
					</td>
					<td class="C" onclick="enCalGroup.select(<c:out value="${status.index}"/>);">
						<c:out value="${page.currentStartRow + status.index}"/>
					</td>	
					<td class="C" onclick="enCalGroup.select(<c:out value="${status.index}"/>);">
						<div style="width: 99%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
							<c:out value="${calendarGroup.groupId}"/>
						</div>
					</td>
					<td class="C" onclick="enCalGroup.select(<c:out value="${status.index}"/>);">
						<div style="width: 99%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
							<c:out value="${calendarGroup.permissions}"/>
						</div>
					</td>
					<td class="C" onclick="enCalGroup.select(<c:out value="${status.index}"/>);">
						<span style="width: 180px;">&nbsp;
							<c:out value="${calendarGroup.insDatim}" />
							<input type="hidden" id="${calendarGroup.groupId}_isDeletable" value="${calendarGroup.isDeletable }"/>
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
				<img src="<%=request.getContextPath() %>/admin/images/btn_first.gif" title="맨 처음으로" onclick="javascript:enCalGroup.firstPage();"/>
			</a>
			<a href="javascript:void(0);" class="noline">
				<img src="<%=request.getContextPath() %>/admin/images/btn_prev.gif" title="열 페이지 앞으로" onclick="javascript:enCalGroup.prev10Page();"/>
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
				<img src="<%=request.getContextPath() %>/admin/images/btn_next.gif" title="열 페이지 뒤로" onclick="javascript:enCalGroup.next10Page();">
			</a>
			<a href="javascript:void(0);" class="noline">
				<img src="<%=request.getContextPath() %>/admin/images/btn_last.gif" title="맨 마지막으로" onclick="javascript:enCalGroup.lastPage();">
			</a>			
		</div>
		<!-- paging// -->
	</div>
	<!-- tcontrol// -->	
	<!-- btnArea-->
	<div class="btnArea">
		<div class="rightArea">
			<a href="javascript:enCalGroup.uiForm();" class="btn_B"><span><util:message key="ev.title.add"/></span></a>
			<a href="javascript:enCalGroup.deletes();" class="btn_B"><span><util:message key="ev.title.remove"/></span></a>
		</div>
	</div>
	<!-- btnArea//-->
	<div id="CalendarManager_GroupPropertyTabs">
		<ul>
			<li><a href="#CalendarManager_GroupDetailTabPage" onclick="javascript:enCalGroup.detail();"><util:message key="ev.title.detailTab"/></a></li>
		</ul>
		<div id="CalendarManager_GroupDetailTabPage"></div>
	</div>			
</form>
	
<script type="text/javascript">
	enCalGroup.m_currentPage = <c:out value="${page.currentPage}"/>;
	enCalGroup.m_lastPage = <c:out value="${page.pages}"/>;
</script>