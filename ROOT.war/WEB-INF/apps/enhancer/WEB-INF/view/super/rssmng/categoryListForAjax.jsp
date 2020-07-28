<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<option value="-1"><util:message key="hn.rss.label.category"/></option>
<c:forEach items="${categoryList}" var="category">
	<option value="<c:out value="${category.id}"/>">
		<c:out value="${category.name}" />(<c:out value="${category.domainNm }"/>)
	</option>
</c:forEach>