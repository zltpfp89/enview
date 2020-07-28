
<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
//	System.out.println("########### results=" + request.getAttribute("results"));
%>
<c:choose>
    <c:when test="${id == '1'}">
<tree id="0">
<item id="1" im0="_folder.gif" im1="_folder_open.gif" im2="folder.gif" open="1" call="1" select="1" userData="/"><![CDATA[  /  ]]><userData name="path">/</userData>
	</c:when>
	<c:otherwise>
<tree id="<c:out value="${id}"/>">
	</c:otherwise>
</c:choose>
<c:forEach items="${results}" var="page" varStatus="status">
	<item child="1" id="<c:out value="${page.PAGE_ID}"/>" im0="page.gif" im1="page.gif" im2="page.gif" userData="<c:out value="${page.PATH}"/>"><![CDATA[   <c:out value="${page.SHORT_TITLE}"/>   ]]><userData name="path"><c:out value="${page.PATH}"/></userData></item>
</c:forEach>
<c:if test="${id == '1'}">
</item>
</c:if>
</tree>

