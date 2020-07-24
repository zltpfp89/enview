
<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<c:choose>
    <c:when test="${id == '100'}">
<tree id="0">
<item id="100" im0="folder.gif" im1="folder.gif" im2="folder.gif" open="1" call="1" select="1"><![CDATA[  /  ]]>
	</c:when>
	<c:otherwise>
<tree id="<c:out value="${id}"/>">
	</c:otherwise>
</c:choose>
<c:forEach items="${results}" var="group" varStatus="status">
	<item child="1" id="<c:out value="${group.principalId}"/>" im0="folder.gif" im1="folder.gif" im2="folder.gif" userData="<c:out value="${group.shortPath}"/>"><![CDATA[   <c:out value="${group.principalName}"/>   ]]>
    </item>
</c:forEach>
<c:if test="${id == '100'}">
</item>
</c:if>
</tree>

