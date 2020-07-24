<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
	<tr> 
		<td width="100%" valign="top">
			<div style=" " class="webpanel">
				<div id="UserManager_UserTabPage">
					<br style='line-height:5px;'>
					<div>
					  <table width="99%">
						  <tr>
							<td align="right">
								<select name="선택" class="select" id="searchType" name="searchType">
									<option value="-1">카테고리</option>
									<c:forEach items="${categoryList}" var="category">
										<option value="<c:out value="${category.id}"/>" <c:if test="${form.categoryId == category.id}"> selected</c:if>>
											<c:out value="${category.name}" />
										</option>
									</c:forEach>
								</select>
								<input type="text" class="webtextfield" id="searchValue" name="searchValue" value="<c:out value="${form.searchValue}"/>" onkeyup="javascript:enFeed.search();"/>
								<span class="btn_pack small"><a href="javascript:enFeed.search();"><util:message key="hn.rss.label.search"/></a></span>
							</td>
						  </tr>
					  </table>    
					</div>
					<div class="webgridpanel">
					  <form id="UserManager_ListForm" style="display:inline" name="UserManager_ListForm" action="" method="post">
					  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
						<thead>
							<tr> 
								<td colspan="100" class="webgridheaderline"></td>
							</tr>
							<tr style="cursor: pointer;">
								<th class="webgridheader" align="center" width="30px">
									<input type="checkbox" id="checkAll" name="checkAll" class="feedCheck webcheckbox" onclick="enRss.checkAll('feedCheck');"/>
								</th>
								<th class="webgridheader" align="center" width="30px"><util:message key="hn.rss.label.number"/></th>
								<th class="webgridheader"><span><util:message key="hn.rss.label.feedName"/></span></th>	
								<th class="webgridheader"><span><util:message key="hn.rss.label.feedUrl"/></span></th>
								<th class="webgridheader"><span><util:message key="hn.rss.label.states"/></span></th>
								<th class="webgridheader"><span><util:message key="hn.rss.label.isSubscribe"/></span></th>		
							</tr>
						</thead>
						<tbody id="UserManager_ListBody">
						<c:forEach items="${feedList}" var="feed"  varStatus="idx">
							<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>">
								<td align="center" class="webgridbody">
									<input type="checkbox" id="<c:out value="${feed.id}"/>" class="webcheckbox feedCheck" name="feedCheck"/>
								</td>
								<td align="center" class="webgridbody" onclick="enFeed.select(<c:out value="${idx.count - 1}"/>);">
									<span><c:out value="${page.currentStartRow + idx.count - 1}"/></span>
								</td>
								<td align="left" class="webgridbody" onclick="enFeed.select(<c:out value="${idx.count - 1}"/>);">
									<span class="webgridrowlabel">&nbsp;<c:out value="${feed.name}"/></span>
								</td>
								<td align="left" class="webgridbody" onclick="enFeed.select(<c:out value="${idx.count - 1}"/>);">
									<span class="webgridrowlabel">&nbsp;<c:out value="${feed.url}"/></span>
								</td>
								<td align="center" class="webgridbody" onclick="enFeed.select(<c:out value="${idx.count - 1}"/>);">
									<span class="webgridrowlabel"><c:out value="${feed.statusText}"/></span>
								</td>
								<td align="center" class="webgridbody" onclick="enFeed.select(<c:out value="${idx.count - 1}"/>);">
									<span class="webgridrowlabel">
										<c:out value="${feed.subscribeText}"/>
									</span>
									<c:if test="${feed.subscribe != 1 }">
										<span class="btn_pack small"><a href="javascript:enFeed.subscribe(<c:out value="${feed.id}"/>);"><util:message key="hn.rss.label.subscribe"/></a></span>
									</c:if>
									<c:if test="${feed.subscribe == 1 }">
										<span class="btn_pack small"><a href="javascript:enFeed.cancelSubscribe(<c:out value="${feed.id}"/>);"><util:message key="hn.rss.label.cancelSubscribe"/></a></span>
									</c:if>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${empty feedList}">
							<tr><td colspan="5"><util:message key="hn.rss.label.hasNotFeed"/></td></tr>
						</c:if>
						</tbody>
					  </table>
					  </form>
					  <div id="UserManager_ListMessage">
						<c:out value='${resultMessage}'/>
					  </div>
					</div>
					<div>
						<table style="width:99%;" class="webbuttonpanel">
						<tr>
						    <td align="center">
								<div id="pagingButtons" class="pagingButtons">
									<img src="<%=request.getContextPath() %>/hancer/images/rss/button/btn_first.gif" title="맨 처음으로" onclick="javascript:enFeed.firstPage();"/>
									<img src="<%=request.getContextPath() %>/hancer/images/rss/button/btn_before.gif" title="열 페이지 앞으로" onclick="javascript:enFeed.prev10Page();"/>
									<c:if test="${page.currentStartPage == 1 and page.currentEndPage == 0 }">
										<div class="num currentPage">1</div>
									</c:if>
									<c:forEach begin="${page.currentStartPage}" end="${page.currentEndPage}" var="i">
										<c:if test = "${page.currentPage == i }" var="notCurrentPage" ><c:out value="${i}"/></c:if>
										<c:if test="${not notCurrentPage }">
											<span style="cursor:pointer" onclick="javascript:enFeed.goPage(<c:out value="${i}"/>);"><c:out value="${i}"/></span>
										</c:if>
									</c:forEach>
									<img src="<%=request.getContextPath() %>/hancer/images/rss/button/btn_next.gif" title="열 페이지 뒤로" onclick="javascript:enFeed.next10Page();">
									<img src="<%=request.getContextPath() %>/hancer/images/rss/button/btn_last.gif" title="맨 마지막으로" onclick="javascript:enFeed.lastPage();">
								</div>
						    </td>    
						</tr>
							<tr>
							    <td align="right">
							    	<c:if test="${form.serviceType == 'SERVICE' }">
										<span class="btn_pack small"><a href="javascript:enFeed.uiForm();"><util:message key="hn.rss.label.add"/></a></span>
										<span class="btn_pack small"><a href="javascript:enFeed.deletes();"><util:message key="hn.rss.label.delete"/></a></span>
									</c:if>
							    </td>
							</tr>
						
						</table>
					</div> <!-- End webformpanel -->
				</div> <!-- End UserManager_UserTabPage -->
			</div>
		</td> 
	<tr>
</table>
<script type="text/javascriopt">
	enFeed.m_currentPage = <c:out value="${page.currentPage}"/>;
	enFeed.m_lastPage = <c:out value="${page.pages}"/>;
</script>