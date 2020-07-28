<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${feed.serviceType == 'SERVICE' }" var="isService"/>
<c:if test="${feed.isAllowed == 0 || feed.isAllowed == 2}" var="isEditable"/>
<div id="RssManager_DetailTabPage" style="width:99%;">														
	<div class="webformpanel" style="width:100%;">
		<form id="feedForm" name="feedForm" method="post" action="<%=request.getContextPath()%>/hancer/rss/detailFeed.hanc">
			<input	type="hidden" id="feedId" name="id" value="<c:out value="${feed.id}"/>" />
			<table cellpadding=0 cellspacing=0 border=0 width='100%'>
				<tr> 
					<td colspan="4" width="100%" class="webformheaderline"></td>    
				</tr>
				<tr>
					<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5"> 피드명 </td>
					<td colspan="3" class="webformfield">
						<c:if test="${!isService && isEditable}">
							<input type="text" id="name" name="name" value="<c:out value="${feed.name}"/>" size="100" />
						</c:if>
						<c:if test="${isService || !isEditable}">
							<c:out value="${feed.name}"/>
						</c:if>
					</td>
				</tr>
				<tr>
					<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5"> 카테고리 *</td>
					<td colspan="3" class="webformfield">
						<c:if test="${!isService && isEditable}">
							<select	id="categoryId" name="categoryId" size="1" class='webdropdownlist'>
								<option value="-1">카테고리</option>
								<c:forEach items="${categoryList}" var="category">
									<option value="<c:out value="${category.id}"/>" <c:if test="${feed.categoryId == category.id}"> selected</c:if>>
										<c:out value="${category.name}" />
									</option>
								</c:forEach>
							</select>
						</c:if>
						<c:if test="${isService || !isEditable}">
							<c:forEach items="${categoryList}" var="category">
								<c:if test="${feed.categoryId == category.id}"><c:out value="${category.name}" /></c:if>
							</c:forEach>
						</c:if>
					</td>
				</tr>
				<tr>
					<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5"> 피드주소 *</td>
					<td colspan="3" class="webformfield">
						<c:if test="${!isService && isEditable}">
							<input type="text" id="url" name="url" value="<c:out value="${feed.url}"/>"	size="100" />
						</c:if>
						<c:if test="${isService || !isEditable}">
							<c:out value="${feed.url}"/>
						</c:if>
					</td>
				</tr>
				<tr>
					<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5"> 홈페이지 </td>
					<td colspan="3" class="webformfield">
						<c:if test="${!isService && isEditable}">
							<input type="text" id="homepage" name="homepage" value="<c:out value="${feed.homepage}"/>"	size="100" />
						</c:if>
						<c:if test="${isService || !isEditable}">
							<c:out value="${feed.homepage}"/>
						</c:if>
					</td>
				</tr>
			</table>
			<c:if test="${isEditable }">
			<table style="width:100%;" class="webbuttonpanel">
				<tr>
					<td align="right">  
						<span class="btn_pack small"><a href="javascript:enFeed.update()">저장</a></span>
					</td>
				</tr>
			</table>
			</c:if>
		</form>
	</div>
</div>