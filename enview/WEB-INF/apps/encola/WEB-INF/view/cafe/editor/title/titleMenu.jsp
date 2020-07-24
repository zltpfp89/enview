<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="tmTemplateDescriptionPanel">
	<p><util:message key="cf.info.chooseDesign"/></p>
</div>
<div class="tmTemplateImageListPanel">
	<c:forEach items="${ decoInfoList }" var="deco" varStatus="status">
	<div class="tmTemplateImageBorder" id="tplImg_<c:out value="${ deco.decoId }"/>" onclick="javascript:cfTplMngr.selectTemplate('CF0105', '<c:out value="${ deco.decoId }"/>');">
		<img class="tmTemplateImage" src="<c:out value="${ deco.value }"/>">
	</div>
	<c:if test="${status.count % 2 == 0 }"><br></c:if>
	
	</c:forEach>
	<div id="CF0105_selectedBox" class="selectedBox tmTemplateSelectedBox"></div>
</div>
<div class="tmTemplatePagePanel" id="pagePanel">
	<input type="hidden" name="currentPage" id="currentPage" value="<c:out value="${page.currentPage}"/>">
	<div class="pageButton prev"><img src="<%=request.getContextPath()%>/cola/cafe/images/editor/prevPage.jpg" onclick="javascript:cfTitleEditor.showTemplateEditor('CF0105',500, 225, <c:out value="${page.currentBeforePage}"/>);"></div>
		<c:forEach begin="${page.currentStartPage}" end="${page.currentEndPage}" var="i" varStatus="status">
		<c:if test="${i != page.currentStartPage }"><div class="pipe"> | </div></c:if><div class="page<c:if test="${page.currentPage == i }"> currentPage</c:if>" onclick="javascript:cfTitleEditor.showTemplateEditor('CF0105',500, 225, <c:out value="${i}"/>);"><c:out value="${i}"/></div>
		</c:forEach>
	<div class="pageButton next"><img src="<%=request.getContextPath()%>/cola/cafe/images/editor/nextPage.jpg" onclick="javascript:cfTitleEditor.showTemplateEditor('CF0105',500, 225, <c:out value="${page.currentNextPage}"/>);"></div>
</div>
<input type="hidden" name="decoId" id="decoId" value="">
<script type="text/javascript">
	var pageCount = <c:out value="${page.currentEndPage}"/> - <c:out value="${page.currentStartPage}"/> + 1;
	var width = pageCount * 20 + (pageCount-1) * 5 + 24 + 10;
	$('#pagePanel').css('width', width + 'px');
</script>