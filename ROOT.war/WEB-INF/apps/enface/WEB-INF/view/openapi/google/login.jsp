<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<c:if test="${login}">
이미 구글캘린더 서비스를 이용중입나디.<br>
<button onclick="location.href='${authUri}';">구글 캘린더 서비스 다시 연동</button>
</c:if>
<c:if test="${not login}">
<button onclick="location.href='${authUri}';" style="font-size: 30px">구글 캘린더 서비스 연동</button>
</c:if>


