<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<form id="listForm" name="listForm" method="post" onsubmit="return false;">
	<c:if test="${form.serviceType == 'SERVICE' }">
		<div class="sel_100">
			<select id="entrySearchType" name="entrySearchType" size="1" class="txt_100">
				<c:forEach items="${entrySearchType }" var="searchType" varStatus="status">
					<option value="<c:out value="${searchType.code }"/>" <c:if test="${searchType.code == form.status +1 }">selected="selected"</c:if>><c:out value="${searchType.codeName }"/></option>
				</c:forEach>
			</select>
		</div>
	</c:if>
	<input type="text" id="entrySearchValue" name="entrySearchValue" value="<c:out value="${form.searchValue}"/>" onkeydown="javascript:enEntry.search();"/>						
	<a onclick="javascript:enEntry.search();" title="검색" class="btn_search"><span><util:message key="hn.rss.label.search"/></span></a>
	<div class="sel_100">
		<select id="entryListCount" name="listCount" class="txt_100">
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
	<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
		<caption>게시판</caption>
		<colgroup>
			<col width="30px" />
			<col width="30px" />
			<col width="400px" />
			<col width="120px" />
		</colgroup>	
		<thead>
			<tr>
				<th class="first">
					<input type="checkbox" id="checkAll" name="checkall" onclick="enRss.m_checkBox.chkAll(this);"/>
				</th>	
				<th class="C"><span class="table_title"><util:message key="hn.rss.label.number"/></span></th>				
				<th class="C">
					<span class="table_title"><util:message key="hn.rss.label.entryName"/></span>
				</th>
				<th class="C">
					<span class="table_title"><util:message key="hn.rss.label.entryUrl"/></span>
				</th>						
				<th class="C">
					<span class="table_title"><util:message key="hn.rss.label.regDatim"/></span>
				</th>	
			</tr>
		</thead>
		<tbody id="RssManager_ListBody">
			<c:if test="${total == 0}">
				<tr>
					<td class="C" colspan="100"><util:message key="hn.rss.label.hasNotEntries"/></td>
				</tr>
			</c:if>
			<c:forEach items="${entryList}" var="entry" varStatus="status">
				<tr class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>">
					<td class="C">
						<input type="checkbox" name="entryCheck" id="entryid<c:out value="${status.count }"/>" value='<c:out value="${entry.id}" />' />							
					</td>
					<td class="C" >
						<c:out value="${page.total - (page.currentPage -1 )* page.listCount - status.count + 1}"/>
					</td>	
					<td class="L">
						<div style="width: 99%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
							<span class="webgridrowlabel <c:if test="${entry.status == 0}">closeEntry</c:if>">
								<a href="<c:out value="${entry.url}"/>" target="_blank"><c:out value="${entry.title}"/></a>
							</span>
						</div>
					</td>						
					<td class="L">
						<div style="width: 400px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
							<span class="webgridrowlabel <c:if test="${entry.status == 0}">closeEntry</c:if>">
								<a href="<c:out value="${entry.url}"/>" target="_blank"><c:out value="${entry.url}"/></a>
							</span>
						</div>
					</td>
					<td class="C">
						<span class="webgridrowlabel" style="width: 120px;">&nbsp;
							<c:out value="${entry.updTimeText}" /> 							
						</span>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</form>
<!-- tcontrol-->
<div class="tcontrol">
	<!-- paging -->
	<div id="pagingButtons" class="paging">
		<a href="javascript:void(0);" class="noline">
			<img src="<%=request.getContextPath() %>/admin/images/btn_first.gif" title="맨 처음으로" onclick="javascript:enEntry.firstPage();"/>
		</a>
		<a href="javascript:void(0);" class="noline">
			<img src="<%=request.getContextPath() %>/admin/images/btn_prev.gif" title="열 페이지 앞으로" onclick="javascript:enEntry.prev10Page();"/>
		</a>
		<c:if test="${page.currentStartPage == 1 and page.currentEndPage == 0 }">
			<a href="javascript:void(0);" class="on first">1</a>
		</c:if>
		<c:forEach begin="${page.currentStartPage}" end="${page.currentEndPage}" var="i">
			<c:if test = "${page.currentPage == i }" var="notCurrentPage" >
				<a href="javascript:void(0);" class="on first"><c:out value="${i}"/></a>
			</c:if>
			<c:if test="${not notCurrentPage }">
				<a href="javascript:enEntry.goPage(<c:out value="${i}"/>);"><c:out value="${i}"/></a>
			</c:if>
		</c:forEach>
		<a href="javascript:void(0);" class="noline">
			<img src="<%=request.getContextPath() %>/admin/images/btn_next.gif" title="열 페이지 뒤로" onclick="javascript:enEntry.next10Page();">
		</a>
		<a href="javascript:void(0);" class="noline">
			<img src="<%=request.getContextPath() %>/admin/images/btn_last.gif" title="맨 마지막으로" onclick="javascript:enEntry.lastPage();">
		</a>			
	</div>
	<!-- paging// -->
</div>
<!-- tcontrol// -->
	<c:if test="${form.serviceType == 'SERVICE' }">
		<span style="font-size:12px"><util:message key="hn.rss.label.selectEntryDesc1"/></span>
		<a href="javascript:enEntry.openEntries();" title="<util:message key="hn.rss.label.open"/>" class="btn_B"><span><util:message key="hn.rss.label.open"/></span></a>
		<a href="javascript:enEntry.closeEntries();" title="<util:message key="hn.rss.label.closed"/>" class="btn_B"><span><util:message key="hn.rss.label.closed"/></span></a>
		<span style="font-size:12px">&nbsp;<util:message key="hn.rss.label.selectEntryDesc2"/></span>
	</c:if>

<script type="text/javascript">
	enEntry.m_currentPage = <c:out value="${page.currentPage}"/>;
	enEntry.m_lastPage = <c:out value="${page.pages}"/>;
</script>
