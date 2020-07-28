<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="bgDescriptionPanel">
	<input type="radio" value="design" id="design" class="editorRadio" name="pttrn" checked="checked"><label class="editorLabel" for="design"><util:message key="cf.prop.design"/></label>
	<input type="radio" value="color"  id="color"  class="editorRadio" name="pttrn" onchange="javascript:cfTitleEditor.showBackgroundEditor('Color', 200);"><label class="editorLabel" for="color"><util:message key="cf.prop.color"/></label>
	<input type="radio" value="custom" id="custom" class="editorRadio" name="pttrn" onchange="javascript:cfTitleEditor.showBackgroundEditor('Custom', 220);"><label class="editorLabel" for="custom"><util:message key="cf.prop.directUpload"/></label>
</div>
<div class="bgImageListPanel">
	<c:forEach items="${ decoInfoList }" var="deco" varStatus="status">
	<div class="bgImageBorder" id="tplImg_<c:out value="${ deco.decoId }"/>" onclick="javascript:cfTplMngr.selectTemplate('CF0102', '<c:out value="${ deco.decoId }"/>');">
		<img class="bgImage" src="<c:out value="${ deco.value }"/>">
	</div>
	</c:forEach>
	<div id="CF0102_selectedBox" class="selectedBox bgSelectedBox"></div>
</div>
<div class="bgPagePanel" id="pagePanel">
	<input type="hidden" name="currentPage" id="currentPage" value="<c:out value="${page.currentPage}"/>">
	<div class="pageButton prev"><img src="<%=request.getContextPath()%>/cola/cafe/images/editor/prevPage.jpg" onclick="cfTitleEditor.showTemplateEditor('CF0102', '312', 245, <c:out value="${page.currentBeforePage}"/>);"></div>
		<c:forEach begin="${page.currentStartPage}" end="${page.currentEndPage}" var="i" varStatus="status">
		<c:if test="${i != page.currentStartPage }"><div class="pipe"> | </div></c:if><div class="page<c:if test="${page.currentPage == i }"> currentPage</c:if>" onclick="cfTitleEditor.showTemplateEditor('CF0102', '312', 245, <c:out value="${i}"/>);"><c:out value="${i}"/></div>
		</c:forEach>
	<div class="pageButton next"><img src="<%=request.getContextPath()%>/cola/cafe/images/editor/nextPage.jpg" onclick="cfTitleEditor.showTemplateEditor('CF0102', '312', 245, <c:out value="${page.currentNextPage}"/>);"></div>
</div>
<input type="hidden" name="decoId" id="decoId" value="">
<script type="text/javascript">
	var pageCount = <c:out value="${page.currentEndPage}"/> - <c:out value="${page.currentStartPage}"/> + 1;
	var width = pageCount * 20 + (pageCount-1) * 5 + 24 + 10;
	$('#pagePanel').css('width', width + 'px');
</script>