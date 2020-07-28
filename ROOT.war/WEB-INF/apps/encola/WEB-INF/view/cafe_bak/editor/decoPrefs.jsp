<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<input type="hidden" id="<c:out value="${ decoType }"/>_decoPrefs" name="<c:out value="${ decoType }"/>_decoPrefs" value="[ 
<c:forEach items="${decoPrefs}" var="deco" varStatus="status">{ clazz: '<c:out value="${deco.decoType}"/>_<c:out value="${deco.name}"/>', value: '<c:out value="${deco.value}"/>' }<c:if test="${!status.last}">,</c:if>
</c:forEach>
]"/>