<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title><util:message key="hn.rss.label.rssTitle"/></title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/admin/css/styles.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/hancer/css/rss/default/rss.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/decorations/layout/admin/css/styles.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/decorations/layout/css/styles.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/decorations/layout/css/jquery/base/jquery.ui.all.css" />
		
	<c:if test="${windowId == null}" var="result">
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${langKnd}"/>_mm.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${langKnd}"/>_hn.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
	</c:if>
		<script type='text/javascript' src="<%=request.getContextPath()%>/hancer/javascript/rss/default/myRss.js"></script>
		<script type="text/javascript">
			enRss.logoutUrl('<c:out value="${logoutUrl}"/>');
			enRss.contextPath('<%=request.getContextPath()%>');
			enEntry.m_currentPage = <c:out value="${page.currentPage}"/>;
			enEntry.m_lastPage = <c:out value="${page.pages}"/>;
		</script>
	</head>
	<body>
		<div id="RssManager_myEntryListPage">
			<div class="webpanel">
				<div id="RssManager"> 
					<div>
						<table width="99%">
							<tr>
								<td align="right">
									<c:if test="${form.serviceType == 'SERVICE' }">
										<select id="entrySearchType" name="entrySearchType" size="1" class="form_gray">
											<c:forEach items="${searchTypeList }" var="searchType" varStatus="status">
												<option value="<c:out value="${status.count-1 }"/>"<c:if test="${status.count-1 == form.status +1 }"> selected</c:if>><c:out value="${searchType }"/></option>
											</c:forEach>
										</select>
									</c:if>
									<input type="text" id="entrySearchValue" name="entrySearchValue" value="<c:out value="${form.searchValue}"/>" onkeyup="javascript:enEntry.search();"/>						
									<span class="btn_pack small"><a href="javascript:enEntry.search();" title="검색">검색</a></span>
									<select id="entryListCount" name="listCount">
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
					</div>
					<div class="webgridpanel">				
						<table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
							<thead>
								<tr> 
									<td colspan="100" class="webgridheaderline"></td>
								</tr>
								<tr style="cursor:pointer;height:26px;">
									<th class="webgridheader" align="center" width="30px">No</th>				
									<th class="webgridheader">
										<span>뉴스 제목</span>
									</th>
									<th class="webgridheaderlast" width="120px">
										<span>등록일시</span>
									</th>	
								</tr>
							</thead>
							<tbody id="RssManager_ListBody">
								<c:if test="${total == 0}">
								<tr>
									<td class="webgridbody" align="center" colspan="100">현재 추가하신 RSS가 없습니다.</td>
								</tr>
								</c:if>
								<c:forEach items="${entryList}" var="entry" varStatus="status">
								<tr style="height:26px;" class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>">
									<td class="webgridbody" align="center" >
										<span><c:out value="${page.total - (page.currentPage -1 )* page.listCount - status.count + 1}"/></span>
									</td>	
									<td align="left" class="webgridbody">
										<span class="webgridrowlabel <c:if test="${entry.status == 0}">closeEntry</c:if>">
											<a href="<c:out value="${entry.url}"/>" target="_blank"><c:out value="${entry.title}"/></a>
										</span>
									</td>						
									<td align="center" class="webgridbody">
										<span class="webgridrowlabel">&nbsp;
										<c:out value="${entry.updTimeText}" /> 							
										</span>
									</td>
									
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div>
						<table style="width:99%;" class="webbuttonpanel">
							<tr>
								<td align="center">
									<div id="pagingButtons" class="pagingButtons">
										<img src="<%=request.getContextPath() %>/hancer/images/rss/button/btn_first.gif" title="맨 처음으로" onclick="javascript:enEntry.firstPage();"/>
										<img src="<%=request.getContextPath() %>/hancer/images/rss/button/btn_before.gif" title="열 페이지 앞으로" onclick="javascript:enEntry.prev10Page();"/>
										<c:if test="${page.currentStartPage == 1 and page.currentEndPage == 0 }">
											<div class="num currentPage">1</div>
										</c:if>
										<c:forEach begin="${page.currentStartPage}" end="${page.currentEndPage}" var="i">
											<c:if test = "${page.currentPage == i }" var="notCurrentPage" ><c:out value="${i}"/></c:if>
											<c:if test="${not notCurrentPage }">
												<span style="cursor:pointer" onclick="javascript:enEntry.goPage(<c:out value="${i}"/>)"><c:out value="${i}"/></span>
											</c:if>
										</c:forEach>
										<img src="<%=request.getContextPath() %>/hancer/images/rss/button/btn_next.gif" title="열 페이지 뒤로" onclick="javascript:enEntry.next10Page();"/>
										<img src="<%=request.getContextPath() %>/hancer/images/rss/button/btn_last.gif" title="맨 마지막으로" onclick="javascript:enEntry.lastPage();"/>
									</div>
							    </td>    
							</tr>
						</table>					
					</div> <!-- End webformpanel -->
				</div> <!-- End RssManager_LangTabPage -->
			</div>
		</div>
	</body>
</html>