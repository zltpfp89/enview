<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<!-- sub_contents -->
<div class="sub_contents">
		<!-- board first -->
		<div class="board first">
			<!-- searchArea-->
			<div class="tsearchArea">
				<p style="background: none"></p>
				<fieldset>
					<form id="appList" name="appList" method="post" onsubmit="return false;">
						<div class="sel_100">
							<select name="선택" class="txt_100" id="searchType" name="searchType">
								<c:forEach items="${appSearchType }" var="search" varStatus="status">
									<option class="searchTypes" value="<c:out value="${search.code}"/>" <c:if test="${form.searchType == search.code }">selected="selected"</c:if>><c:out value="${search.codeName}"/></option>
								</c:forEach>
							</select>
						</div> 
						<input type="text" class="txt_100" id="searchValue" name="searchValue" value="<c:out value="${form.searchValue}"/>" onkeyup="javascript:enApp.searchApps();"/>
						<a href="javascript:enApp.searchApps();" class="btn_search"><span><util:message key="hn.admin.label.search"/></span></a>
					</form>			
				</fieldset>
			</div>
			<!-- searchArea//-->
			<form id="UserManager_ListForm" style="display:inline" name="UserManager_ListForm" action="" method="post">
				<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<caption>게시판</caption>
					<colgroup>
						<col width="30px" />
						<col width="30px" />
						<col width="*" />
						<col width="*" />
						<col width="*" />
					</colgroup>	
						<tr>
							<th class="first">
								<input type="checkbox" id="appCheck" name="checkAll" onclick="enManager.checkAll('appCheck','appCheck');"/>
							</th>
							<th class="C"><span class="table_title"><util:message key="hn.admin.label.number"/></span></th>
							<th class="C"><span class="table_title"><util:message key="hn.admin.label.appName"/></span></th>	
							<th class="C"><span class="table_title"><util:message key="hn.admin.label.appVersion"/></span></th>
							<th class="C"><span class="table_title"><util:message key="hn.admin.label.appDescription"/></span></th>	
						</tr>
					</thead>
					<tbody id="UserManager_ListBody">
						<c:if test="${empty appList}">
							<tr><td colspan="5" class="C"><util:message key="ev.info.notFoundData"/></td></tr>
						</c:if>
						<c:forEach items="${appList}" var="app" varStatus="status">
							<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>">
								<td class="C" onclick="enApp.selectApp(<c:out value="${status.count - 1}"/>);">
									<input type="checkbox" id="<c:out value="${app.appId}"/>" name="appCheck" style="cursor:pointer"/>
								</td>
								<td class="C" onclick="enApp.selectApp(<c:out value="${status.count - 1}"/>);"><c:out value="${page.currentStartRow + status.count - 1}"/></td>
								<td class="C" onclick="enApp.selectApp(<c:out value="${status.count - 1}"/>);"><c:out value="${app.appName}"/></td>
								<td class="C" onclick="enApp.selectApp(<c:out value="${status.count - 1}"/>);"><c:out value="${app.version }"/></td>
								<td class="C" onclick="enApp.selectApp(<c:out value="${status.count - 1}"/>);"><c:out value="${app.description }"/></td>
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
						<img src="<%=request.getContextPath() %>/admin/images/btn_first.gif" title="맨 처음으로" onclick="javascript:enApp.firstPage();"/>
					</a>
					<a href="javascript:void(0);" class="noline">
						<img src="<%=request.getContextPath() %>/admin/images/btn_prev.gif" title="열 페이지 앞으로" onclick="javascript:enApp.prevPage();"/>
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
						<img src="<%=request.getContextPath() %>/admin/images/btn_next.gif" title="열 페이지 뒤로" onclick="javascript:enApp.nextPage();">
					</a>
					<a href="javascript:void(0);" class="noline">
						<img src="<%=request.getContextPath() %>/admin/images/btn_last.gif" title="맨 마지막으로" onclick="javascript:enApp.lastPage();">
					</a>
				</div>
				<!-- paging//-->
			</div>
			<!-- tcontrol//-->	
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:enApp.uiInsertForm();" class="btn_W"><span><util:message key="hn.admin.label.add"/></span></a>
					<a href="javascript:enApp.deleteApps();" class="btn_W"><span><util:message key="hn.admin.label.delete"/></span></a>
				</div>
				<input type="hidden" id="currentPage" value="<c:out value="${page.currentPage }"/>">
			</div>
			<!-- btnArea//-->
		</div>
		<!-- board first// -->	

<script type="text/javascriopt">
	enApp.initSeachForm(<c:out value="${form.searchType }"/>, '<c:out value="${form.searchValue }"/>');
	enApp.m_currentPage = <c:out value="${page.currentPage}"/>;
	enApp.m_lastPage = <c:out value="${page.pages}"/>;
</script>