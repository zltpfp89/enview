<%@ page contentType="text/xml;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${acForm.act == 'root'}">
<tree id="0">
	<item id="<c:out value="${prinVO.codeId}"/>" open="1" call="1" select="1" text="<c:out value="${prinVO.codeName}"/>"><userdata name="shortPath"><c:out value="${prinVO.code}"/></userdata>
</c:if>
<c:if test="${acForm.act != 'root'}">
<tree id="<c:out value="${acForm.prinId}"/>">
</c:if>
<c:forEach items="${prinList}" var="prin">
	<c:if test="${prin.codeTag1 > 0}">
	  <c:if test="${empty prin.codeTag2 || prin.codeTag2 == '0'}">
		<item child="1" id="<c:out value="${prin.codeId}"/>" hint="<c:out value="${prin.codeName}"/>" text="<c:out value="${prin.codeName}"/>"><userdata name="shortPath"><c:out value="${prin.code}"/></userdata></item>
	  </c:if>
	  <c:if test="${prin.codeTag2 == '1'}">
		<item child="1" id="<c:out value="${prin.codeId}"/>" hint="<c:out value="${prin.codeName}"/>" text="<c:out value="${prin.codeName}"/>"><userdata name="shortPath"><c:out value="${prin.code}"/></userdata></item>
	  </c:if>
	</c:if>
	<c:if test="${prin.codeTag1 == 0}">
	  <c:if test="${empty prin.codeTag2 || prin.codeTag2 == '0'}">
		<item child="0" id="<c:out value="${prin.codeId}"/>" hint="<c:out value="${prin.codeName}"/>" text="<c:out value="${prin.codeName}"/>"><userdata name="shortPath"><c:out value="${prin.code}"/></userdata></item>
	  </c:if>
	  <c:if test="${prin.codeTag2 == '1'}">
		<item child="0" id="<c:out value="${prin.codeId}"/>" hint="<c:out value="${prin.codeName}"/>" text="<c:out value="${prin.codeName}"/>"><userdata name="shortPath"><c:out value="${prin.code}"/></userdata></item>
	  </c:if>
	</c:if>
</c:forEach>
<c:if test="${acForm.act == 'root'}">
	</item>
</c:if>
</tree>
