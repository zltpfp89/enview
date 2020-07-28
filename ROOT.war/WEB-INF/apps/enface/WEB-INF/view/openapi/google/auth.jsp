<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<span style="font-size: 30px">

<c:if test="${auth}">
구글계정과 연결되었습니다 
</c:if>
<c:if test="${not empty error}">
구글계정과 연결중 로류가 발생했습니다. <c:out value="${error}"/>  
</c:if>


</span>