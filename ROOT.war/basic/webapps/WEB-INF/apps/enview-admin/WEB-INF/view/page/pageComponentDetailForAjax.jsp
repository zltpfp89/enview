<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <pageComponent>

		<pageComponentId><c:out value="${pageComponent.pageComponentId}"/></pageComponentId>	
		<pageId><c:out value="${pageComponent.pageId}"/></pageId>	
		<region><![CDATA[  <c:out value="${pageComponent.region}"/>  ]]></region>	
		<portletName><![CDATA[  <c:out value="${pageComponent.portletName}"/>  ]]></portletName>	
		<parameter><![CDATA[  <c:out value="${pageComponent.parameter}"/>  ]]></parameter>	
		<elementOrder><c:out value="${pageComponent.elementOrder}"/></elementOrder>	
	</pageComponent>
</js>