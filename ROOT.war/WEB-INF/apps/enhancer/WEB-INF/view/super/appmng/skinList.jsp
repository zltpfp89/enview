<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<!-- board first -->
<div id="UserManager_UserTabPage" class="board first">
	<!-- searchArea-->
	<div class="tsearchArea">
		<p style="background: none"></p>
		<fieldset>
			<form id="skinList" name="skinList" method="post" onsubmit="return false;">
				<div class="sel_100">
					<select name="선택" class="txt_100" id="skinSearchType" name="skinSearchType">
						<c:forEach items="${skinSearchType }" var="search" varStatus="status">
							<option class="searchTypes" value="<c:out value="${search.code}"/>" <c:if test="${form.searchType == search.code }">selected="selected"</c:if>><c:out value="${search.codeName}"/></option>
						</c:forEach>
					</select>
				</div>
				<input type="text" class="txt_100" id="skinSearchValue" name="skinSearchValue" value="<c:out value="${form.searchValue}"/>" onkeyup="javascript:enSkin.searchSkins();"/>
				<a href="javascript:enSkin.searchSkins();" class="btn_search"><span><util:message key="hn.admin.label.search"/></span></a>				
			</form>
		</fieldset>		
	</div>
	<!-- searchArea// -->
	<form id="UserManager_ListForm" style="display:inline" name="UserManager_ListForm" action="" method="post">
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<caption>게시판</caption>
			<colgroup>
				<col width="30px" />
				<col width="30px" />
				<col width="*" />
				<col width="*" />
				<col width="*" />
	  		<thead>
				<tr>
					<th class="first">
						<input type="checkbox" id="skinCheck" name="checkAll" onclick="enManager.checkAll('skinCheck');"/>
					</th>
					<th class="C"><span class="table_title"><util:message key="hn.admin.label.number"/></span></th>
					<th class="C"><span class="table_title"><util:message key="hn.admin.label.skinName"/></span></th>	
					<th class="C"><span class="table_title"><util:message key="hn.admin.label.skinPath"/></span></th>
					<th class="C"><span class="table_title"><util:message key="hn.admin.label.isAllowed"/></span></th>	
				</tr>
			</thead>
			<tbody id="UserManager_ListBody">
				<c:if test="${empty skinList}">
					<tr><td colspan="5" class="C"><util:message key="ev.info.notFoundData"/></td></tr>
				</c:if>
				<c:forEach items="${skinList}" var="skin" varStatus="status">
					<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>">
						<td class="C">
							<input type="checkbox" id="<c:out value="${skin.skinId}"/>" name="skinCheck" style="cursor:pointer"/>
						</td>
						<td class="C" onclick="enSkin.selectSkin(<c:out value="${status.count - 1}"/>);"><c:out value="${page.currentStartRow + status.count - 1}"/></td>
						<td class="C" onclick="enSkin.selectSkin(<c:out value="${status.count - 1}"/>);"><c:out value="${skin.skinName}"/></td>
						<td class="C" onclick="enSkin.selectSkin(<c:out value="${status.count - 1}"/>);"><c:out value="${skin.skinPath }"/></td>
						<td class="C" onclick="enSkin.selectSkin(<c:out value="${status.count - 1}"/>);">
							<c:if test="${skin.isAllowed == true}"><util:message key="hn.admin.label.allowed"/></c:if>
							<c:if test="${skin.isAllowed == false}"><util:message key="hn.admin.label.notAllowed"/></c:if>
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
				<img src="<%=request.getContextPath() %>/admin/images/btn_first.gif" title="맨 처음으로" onclick="javascript:enSkin.firstPage();"/>
			</a>
			<a href="javascript:void(0);" class="noline">
				<img src="<%=request.getContextPath() %>/admin/images/btn_prev.gif" title="열 페이지 앞으로" onclick="javascript:enSkin.prevPage();"/>
			</a>
			<c:if test="${page.currentStartPage == 1 and page.currentEndPage == 0 }">
				<a href="javascript:void(0);" class="on first">1</a>
			</c:if>
			<c:forEach begin="${page.currentStartPage}" end="${page.currentEndPage}" var="i">
				<c:if test = "${page.currentPage == i }" var="notCurrentPage" >
					<a href="javascript:void(0);" class="on first"><c:out value="${i}"/></a>
				</c:if>
				<c:if test="${not notCurrentPage }">
					<a href="javascript:enSkin.goPage(<c:out value="${i}"/>);"><c:out value="${i}"/></a>
				</c:if>
			</c:forEach>
			<a href="javascript:void(0);" class="noline">
				<img src="<%=request.getContextPath() %>/admin/images/btn_next.gif" title="열 페이지 뒤로" onclick="javascript:enSkin.nextPage();">
			</a>
			<a href="javascript:void(0);" class="noline">
				<img src="<%=request.getContextPath() %>/admin/images/btn_last.gif" title="맨 마지막으로" onclick="javascript:enSkin.lastPage();">
			</a>
		</div>
		<!-- paging//-->
	</div>
	<!-- tcontrol//-->		
	<!-- btnArea-->
	<div class="btnArea">
		<div class="rightArea">
			<a href="javascript:enSkin.uiInsertForm();" class="btn_B"><span><util:message key="hn.admin.label.add"/></span></a>
			<a href="javascript:enSkin.deleteSkins();" class="btn_B"><span><util:message key="hn.admin.label.delete"/></span></a>
		</div>
		<input type="hidden" id="currentPage" value="<c:out value="${page.currentPage }"/>">
	</div>
	<!-- btnArea//-->
</div>
<!-- board first// -->

<div id="detail"></div>
<script type="text/javascriopt">
	enSkin.m_currentPage = <c:out value="${page.currentPage}"/>;
	enSkin.m_lastPage = <c:out value="${page.pages}"/>;
</script>