<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<ul class="categoryUl">
	<c:forEach items="${cateList}" var="cate" varStatus="status">
		<c:if test="${cate.cateLevel == '1'}">
			<li id="category_<c:out value="${cate.cateId}"/>" cateId="<c:out value="${cate.cateId}"/>" class="category level1 <c:if test="${status.first }">first</c:if>" onclick="cfHome.toggleCategory('<c:out value="${cate.cateId}"/>'); cfHome.selectCateMenu('<c:out value="${cate.cateId}"/>',<c:out value="${cate.cateLevel}"/>);" isOpen="false">
				<c:out value="${cate.cateNm}"/>
			</li>
		</c:if>
		<c:if test="${cate.cateLevel == '2'}">
			<c:set var="cate3List" value="${cate.childList}"/>
			<li id="category_<c:out value="${cate.cateId}"/>" cateId="<c:out value="${cate.cateId}"/>" class="category level2 <c:if test="${status.last }">last</c:if> parentCategory_<c:out value="${cate.parentCateId}"/>" onclick="cfHome.toggleCategory('<c:out value="${cate.cateId}"/>'); cfHome.selectCateMenu('<c:out value="${cate.cateId}"/>',<c:out value="${cate.cateLevel}"/>)" isOpen="false">
				<c:out value="${cate.cateNm}"/>
			</li>
			<c:if test="${!empty cate3List}">
				<c:forEach items="${cate3List}" var="cate3">
					<li id="category_<c:out value="${cate3.cateId}"/>" cateId="<c:out value="${cate3.cateId}"/>" class="category level3 parentCategory_<c:out value="${cate3.parentCateId}"/>" onclick="cfHome.selectCateMenu('<c:out value="${cate3.cateId}"/>',<c:out value="${cate3.cateLevel}"/>)">
						<c:out value="${cate3.cateNm}"/>
					</li>
				</c:forEach>
			</c:if>
		</c:if>
	</c:forEach>
</ul>