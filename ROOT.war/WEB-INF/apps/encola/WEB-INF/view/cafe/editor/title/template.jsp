<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="templateDescriptionPanel">
	<p><util:message key="cf.info.makeTitle.easy"/></p>
</div>
<div class="templateImageListPanel">
	<c:forEach items="${ decoInfoList }" var="deco" varStatus="status">
	<div class="templateImageBorder" id="tplImg_<c:out value="${ deco.decoId }"/>" onclick="javascript:cfTplMngr.selectTemplate('CF0101', '<c:out value="${ deco.decoId }"/>');">
		<img class="templateImage" src="<c:out value="${ deco.value }"/>">
	</div>
	<br>
	</c:forEach>
	<div id="CF0101_selectedBox" class="selectedBox templateSelectedBox"></div>
</div>
<div class="templatePagePanel" id="pagePanel">
	<input type="hidden" name="currentPage" id="currentPage" value="<c:out value="${page.currentPage}"/>">
	<div class="pageButton prev"><img src="<%=request.getContextPath()%>/cola/cafe/images/editor/prevPage.jpg" onclick="javascript:cfTitleEditor.showTemplateEditor('CF0101', 525, 490, <c:out value="${page.currentBeforePage}"/>);"></div>
		<c:forEach begin="${page.currentStartPage}" end="${page.currentEndPage}" var="i" varStatus="status">
		<c:if test="${i != page.currentStartPage }"><div class="pipe"> | </div></c:if><div class="page<c:if test="${page.currentPage == i }"> currentPage</c:if>" onclick="javascript:cfTitleEditor.showTemplateEditor('CF0101', 525, 490, <c:out value="${i}"/>);"><c:out value="${i}"/></div>
		</c:forEach>
	<div class="pageButton next"><img src="<%=request.getContextPath()%>/cola/cafe/images/editor/nextPage.jpg" onclick="javascript:cfTitleEditor.showTemplateEditor('CF0101', 525, 490, <c:out value="${page.currentNextPage}"/>);"></div>
</div>
<script type="text/javascript">
	var pageCount = <c:out value="${page.currentEndPage}"/> - <c:out value="${page.currentStartPage}"/> + 1;
	var width = 25 * pageCount + 29;
	$('#pagePanel .page').css('width', width);	
</script>