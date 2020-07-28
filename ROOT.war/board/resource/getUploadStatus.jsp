<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
Uploading
<c:if test="${! empty sessionScope.uploadFileCurrentF}">
<c:out value="${sessionScope.uploadFileCurrentF}"/>
</c:if>
<c:if test="${! empty sessionScope.uploadFileTotalF}">
 / <c:out value="${sessionScope.uploadFileTotalF}"/>
 </c:if> 

