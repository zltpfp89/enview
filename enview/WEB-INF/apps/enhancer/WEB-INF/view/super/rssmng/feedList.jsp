<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<!-- board first -->
<div class="board first">
	<!-- searchArea-->
	<div class="tsearchArea">
		<p style="background: none"></p>
		<fieldset>
			<form id="RssManager_SearchForm" name="RssManager_SearchForm" style="display:inline" method="post" onsubmit="return false;">
				<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }">
					<div class="sel_100">
						<select id="RssManager_domainCond" name="RssManager_domainCond" class='txt_100' onchange="javascript:enFeed.setDomain();">
							<option value="-1">* <util:message key='ev.prop.domain.domain'/> *</option>
							<c:forEach items="${domainList}" var="domain">
								<option value="<c:out value="${domain.domainId}"/>" <c:if test="${form.domainId == domain.domainId}">selected="selected"</c:if>><c:out value="${domain.domainNm}"/></option>
							</c:forEach>
						</select>
					</div>
				</c:if>
				<div class="sel_100">
					<select name="선택" class="txt_100" id="searchType" name="searchType">
						<option value="-1">카테고리</option>
						<c:forEach items="${categoryList}" var="category">
							<option value="<c:out value="${category.id}"/>" <c:if test="${form.categoryId == category.id}"> selected</c:if>>
								<c:out value="${category.name}" />
							</option>
						</c:forEach>
					</select>
				</div>	
				<input type="text" class="txt_100" id="searchValue" name="searchValue" value="<c:out value="${form.searchValue}"/>" onkeydown="javascript:enFeed.search();"/>
				<a href="javascript:enFeed.search();" class="btn_search"><span><util:message key="hn.rss.label.search"/></span></a> 
			</form>				
		</fieldset>	
	</div>
	<!-- searchArea//-->
	<form id="RssManager_ListForm" style="display:inline" name="RssManager_ListForm" action="" method="post">
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
						<input type="checkbox" id="checkAll" name="checkAll" onclick="enRss.checkAll('feedCheck');"/>
					</th>
					<th class="C"><span class="table_title"><util:message key="hn.rss.label.number"/></span></th>
					<th class="C"><span class="table_title"><util:message key='ev.prop.domain.domain'/></span></th>
					<th class="C"><span class="table_title"><util:message key="hn.rss.label.category"/></span></th>
					<th class="C"><span class="table_title"><util:message key="hn.rss.label.feedName"/></span></th>
					<th class="C"><span class="table_title"><util:message key="hn.rss.label.feedUrl"/></span></th>
					<c:if test="${form.serviceType == 'REQUESTED' }">
					<th class="C"><span class="table_title"><util:message key="hn.rss.label.orderer"/></span></th>
					<th class="C"><span class="table_title"><util:message key="hn.rss.label.isAllowed"/></span></th>
					</c:if>
					<th class="C"><span class="table_title"><util:message key="hn.rss.label.states"/></span></th>	
				</tr>
			</thead>
			<tbody id="RssManager_ListBody">
				<c:forEach items="${feedList}" var="feed"  varStatus="status">
					<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>">
						<td class="C">
							<input type="checkbox" id="<c:out value="${feed.id}"/>" class="webcheckbox feedCheck" name="feedCheck"/>
						</td>
						<td class="C" onclick="enFeed.select(<c:out value="${status.count - 1}"/>);">
							<c:out value="${page.currentStartRow + status.count - 1}"/>
						</td>
						<td class="C" onclick="enFeed.select(<c:out value="${status.count - 1}"/>);">
							<c:out value="${feed.domainNm}"/>
						</td>
						<td class="C" onclick="enFeed.select(<c:out value="${status.count - 1}"/>);">
							<c:out value="${feed.categoryName}"/>
						</td>
						<td class="C" onclick="enFeed.select(<c:out value="${status.count - 1}"/>);">
							<c:out value="${feed.name}"/>
						</td>
						<td class="L" onclick="enFeed.select(<c:out value="${status.count - 1}"/>);">
							<c:out value="${feed.url}"/>
						</td>
						<c:if test="${form.serviceType == 'REQUESTED' }">
							<td class="C" onclick="enFeed.select(<c:out value="${status.count - 1}"/>);">
								<c:out value="${feed.requestUserName}"/>
							</td>
							<td class="C" onclick="enFeed.select(<c:out value="${status.count - 1}"/>);">
								<c:out value="${feed.allowedText}"/>
							</td>
						</c:if>
						<td class="C" onclick="enFeed.select(<c:out value="${status.count - 1}"/>);">
							<c:out value="${feed.statusText}"/>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty feedList}">
					<tr>
						<td class="C" <c:if test="${form.serviceType == 'REQUESTED' }">colspan="9"</c:if> <c:if test="${form.serviceType == 'SERVICE' }">colspan="7"</c:if>>
							<util:message key="hn.rss.label.hasNotFeed"/>
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	 </form>
	<!-- tcontrol-->
	<div class="tcontrol">
		<!-- paging -->
		<div id="pagingButtons" class="paging">
			<a href="javascript:void(0);" class="noline">
				<img src="<%=request.getContextPath() %>/admin/images/btn_first.gif" title="맨 처음으로" onclick="javascript:enFeed.firstPage();"/>
			</a>
			<a href="javascript:void(0);" class="noline">
				<img src="<%=request.getContextPath() %>/admin/images/btn_prev.gif" title="열 페이지 앞으로" onclick="javascript:enFeed.prev10Page();"/>
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
				<img src="<%=request.getContextPath() %>/admin/images/btn_next.gif" title="열 페이지 뒤로" onclick="javascript:enFeed.next10Page();">
			</a>
			<a href="javascript:void(0);" class="noline">
				<img src="<%=request.getContextPath() %>/admin/images/btn_last.gif" title="맨 마지막으로" onclick="javascript:enFeed.lastPage();">
			</a>				
		</div>
		<!-- paging//-->
	</div>
	<!-- tcontrol//-->
	<!-- btnArea-->
	<c:if test="${form.serviceType == 'SERVICE' }">
	<div class="btnArea">
			<div class="rightArea">
				<a href="javascript:enFeed.uiForm();" class="btn_W"><span><util:message key="hn.rss.label.add"/></span></a>
				<a href="javascript:enFeed.deletes();" class="btn_W"><span><util:message key="hn.rss.label.delete"/></span></a>
			</div>
		</div>
		<!-- btnArea//-->	
	</c:if>
</div>
<!-- board first// -->	

<script type="text/javascriopt">
	enFeed.m_currentPage = <c:out value="${page.currentPage}"/>;
	enFeed.m_lastPage = <c:out value="${page.pages}"/>;
</script>