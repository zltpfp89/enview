<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<div id="timepicker" class="timepickerPops mobile">
	<c:forEach items="${timeList }" var="time" varStatus="status">
		<label class="times mobile"><c:out value="${time.time2 }"/><input type="hidden" name="times" value="<c:out value="${time.time}"/>"/></label></br>
	</c:forEach>
</div>