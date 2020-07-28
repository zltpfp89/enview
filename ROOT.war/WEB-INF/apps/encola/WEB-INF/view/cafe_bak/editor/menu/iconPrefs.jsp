<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
	<c:forEach items="${iconTplImgList }" var="iconTplImg">
	<li style="background-image: url(<c:out value="${iconTplImg.value }"/>);"></li>
	</c:forEach>
</ul>
<div class="pager">
	<c:forEach begin="${page.currentStartPage}" end="${page.currentEndPage}" var="i" varStatus="status">
		<c:if test="${page.currentPage == i }"><a class="selected"><c:out value="${i}"/></a></c:if>
		<c:if test="${page.currentPage != i }"><a onclick="javascript:cfTplMngr.showIconSetPage(<c:out value="${i}"/>);" href="#"><c:out value="${i}"/></a></c:if>
	</c:forEach>
</div>