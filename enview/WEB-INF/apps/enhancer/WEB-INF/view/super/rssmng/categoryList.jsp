<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<c:if test="${userInfo.hasAdminRole || userInfo.hasManagerRole }" var="isSuperAdmin" />
<c:if test="${!isSuperAdmin && userInfo.hasDomainManagerRole }" var="isDomainAdmin"/>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<title><util:message key="hn.rss.label.cateTitle"/></title>
		<%-- 
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/hancer/css/rss/rss.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/decorations/layout/css/styles.css"> 
		--%>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/contents.css" />
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
		<script type='text/javascript' src="<%=request.getContextPath()%>/hancer/javascript/super/rss/categorymng.js"></script>
		<script type="text/javascript">
			enRss.logoutUrl('<c:out value="${logoutUrl}"/>');
			enRss.contextPath('<%=request.getContextPath()%>');
			
			$(document).ready(function() {
				$(function() {
					var propertyTabs = $("#RssCateManager_propertyTabs").tabs();
				});	
			});
		</script>
	</head>
	<body style="min-width: 700px">
		<input type="hidden" id="method" name="method" value="list" />
		<!-- RssCateManager_EditFormPanel -->
		<div id="RssCateManager_EditFormPanel" >  
			<div id="RssCateManager_propertyTabs">
				<ul>
					<li><a href="#RssCateManager_DetailTabPage"><util:message key="hn.rss.label.detail"/></a></li>	
				</ul>
				<div id="RssCateManager_DetailTabPage">
					<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
					<colgroup>
					<col width="40px">
					<col width="*">
					<col width="280px">
					<col width="180px">
					</colgroup>
						<thead>
							<tr>
								<th class="C first"><span class="table_title"><util:message key="hn.rss.label.number"/></span></th>
								<th class="C">
									<span class="table_title"><util:message key='ev.prop.domain.domain'/></span>
								</th>	
								<th class="C">
									<span class="table_title"><util:message key="hn.rss.label.cateName"/></span>
								</th>	
								<th class="C">
									<span class="table_title"><util:message key="hn.rss.label.control"/></span>
								</th>	
							</tr>
						</thead>
						<tbody id="RssManager_ListBody">
							<c:forEach var="category" items="${categoryList}"  varStatus="status">
								<tr class="<c:choose><c:when test="${status.index%2 == 0}">even</c:when><c:otherwise>odd</c:otherwise></c:choose>" >
									<td class="C">
										<c:out value="${(page.currentPage - 1) * 10 + status.count}"/>
									</td>
									<td class="L">
										<c:out value="${category.domainNm }"/>
									</td>
									<td class="L">
										<input type="hidden" id="categoryId_<c:out value="${category.id}"/>" name="id" value="<c:out value="${category.id}"/>"/>
										<input type="text" id="categoryName_<c:out value="${category.id}"/>" name="name" value="<c:out value="${category.name}"/>" style="width:250px" <c:if test="${!(isSuperAdmin || (isDomainAdmin && category.domainId != 0)) }">readonly="readonly"</c:if>/>
										<input type="hidden" id="org_categoryName_<c:out value="${category.id}"/>" name="name" value="<c:out value="${category.name}"/>"/>
									</td>				
									<td class="L">
										<c:if test="${isSuperAdmin || (isDomainAdmin && category.domainId != 0) }">
											<a href="javascript:enCate.update(<c:out value="${category.id}"/>)" class="btn_B"><span><util:message key="hn.rss.label.save"/></span></a>
											<a href="javascript:enCate.remove(<c:out value="${category.id}"/>)" class="btn_B"><span><util:message key="hn.rss.label.delete"/></span></a>
										</c:if>
									</td>						
								</tr>
							</c:forEach>
							<tr>
								<td class="C">
									<c:out value="${page.total+1}"/>
								</td>
								<td class="L">
									<c:if test="${isSuperAdmin}">
										<div class="sel_100">
											<select id="domainId" name="domainId" class="txt_100">
												<c:forEach items="${domainList}" var="domain">
													<option value="<c:out value="${domain.domainId }"/>"><c:out value="${domain.domainNm}"/></option>
												</c:forEach>
											</select>
										</div>
									</c:if>
									<c:if test="${!isSuperAdmin}">
										<c:out value="${domainInfo.domainNm }"/>
										<input type="hidden" id="domainId" value="<c:out value="${domainInfo.domainId }"/>"/>
									</c:if>
								</td>
								<td class="L">
									<input type="text" id="categoryName" name="categoryName" style="width:250px"/>
								</td>
								<td class="L">
									<a href="javascript:enCate.insert();" class="btn_B"><span><util:message key="hn.rss.label.add"/></span></a>
								</td>		
							</tr>
						</tbody>
					</table>
					<!-- btnArea-->
					<div class="btnArea">
						<div style="text-align:center;">
							<a href="javascript:self.close()" class="btn_B"><span><util:message key="hn.rss.label.close"/></span></a>
						</div>
					</div>
					<!-- btnArea// -->
				</div>		
			</div>
		</div>
		<!-- RssCateManager_EditFormPanel// -->
	</body>
</html>