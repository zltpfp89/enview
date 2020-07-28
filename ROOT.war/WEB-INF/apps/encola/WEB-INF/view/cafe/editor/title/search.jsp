<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="srchTemplateDescriptionPanel">
	<p><util:message key="cf.info.chooseDesign"/></p>
</div>
<div class="srchTemplateImageListPanel">
	<c:forEach items="${ decoInfoList }" var="deco" varStatus="status">
	<div class="srchTemplateImageBorder" id="tplImg_<c:out value="${ deco.decoId }"/>" onclick="javascript:selectTemplate('<c:out value="${ deco.decoId }"/>');">
		<img class="srchTemplateImage" src="<c:out value="${ deco.value }"/>">
	</div>
	</c:forEach>
	<div id="selectedBox" class="srchTemplateSelectedBox"></div>
</div>
<div class="srchTemplatePagePanel" id="pagePanel">
	<input type="hidden" name="currentPage" id="currentPage" value="<c:out value="${page.currentPage}"/>">
	<div class="pageButton prev"><img src="<%=request.getContextPath()%>/cola/cafe/images/editor/prevPage.jpg" onclick="goPage(<c:out value="${page.currentBeforePage}"/>)"></div>
		<c:forEach begin="${page.currentStartPage}" end="${page.currentEndPage}" var="i" varStatus="status">
		<c:if test="${i != page.currentStartPage }"><div class="pipe"> | </div></c:if><div class="page<c:if test="${page.currentPage == i }"> currentPage</c:if>" onclick="javascript:goPage(<c:out value="${i}"/>)"><c:out value="${i}"/></div>
		</c:forEach>
	<div class="pageButton next"><img src="<%=request.getContextPath()%>/cola/cafe/images/editor/nextPage.jpg" onclick="goPage(<c:out value="${page.currentNextPage}"/>)"></div>
</div>
<input type="hidden" name="decoId" id="decoId" value="">
<script type="text/javascript">
	var pageCount = <c:out value="${page.currentEndPage}"/> - <c:out value="${page.currentStartPage}"/> + 1;
	var width = pageCount * 20 + (pageCount-1) * 5 + 24 + 10;
	$('#pagePanel').css('width', width + 'px');
	
	
	function selectTemplate(code){
		var top = document.getElementById('tplImg_' + code).offsetTop;
		var left = document.getElementById('tplImg_' + code).offsetLeft;
		$('#selectedBox').css('display', 'block');
		$('#selectedBox').css('top', top);
		$('#selectedBox').css('left', left);
		var decoId = code;
		$('#decoId').val(decoId);
	}
	
	function goPage(page){
		$.ajax({
			type: 'POST',
			url: contextPath + '/cafe/editor.cafe',
			data:
			{
				'cafeUrl' : '<c:out value="${cmntVO.cmntUrl}"/>',
				'm'    : 'titleDialog',
				'dt'   : 'CF0106',
				'pageNum' : page,
				'dummy': Math.random()*1000,
				'__ajax_call__'  : true
			},
			dataType: 'html',
			success: function(html, textStatus){
				$('#editorArea').html(html);
			},
			error: function(x, e){
				alert('잠시 후에 다시 시도 해주십시오.');
			}
		});
	}
</script>