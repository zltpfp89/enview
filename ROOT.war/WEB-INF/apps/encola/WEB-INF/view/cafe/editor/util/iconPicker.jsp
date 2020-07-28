<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="iconPickerPanel" class="iconPickerPanel">
	<ul class="iconSetList">
		<c:forEach items="${iconTplImgList }" var="iconTplImg">
		<li id="<c:out value="${iconTplImg.decoId }"/>" class="menuIconSet" style="background-image: url(<c:out value="${iconTplImg.value }"/>);"></li>
		</c:forEach>
	</ul>
	<ul id="menuIconPageList" class="menuIconPageList">
		<c:forEach begin="${page.currentStartPage}" end="${page.currentEndPage}" var="i" varStatus="status">
		<c:if test="${page.currentPage == i }"><span class="menuIconPage selected"><c:out value="${i}"/></span></c:if>
		<c:if test="${page.currentPage != i }"><a id="iconPicker_<c:out value="${i}"/>" class="menuIconPage selectable" ><c:out value="${i}"/></a></c:if>
		</c:forEach>
	</ul>
</div>