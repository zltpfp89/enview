<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <themeMapping>

		<principalId><c:out value="${themeMapping.principalId}"/></principalId>	
		<groupId><c:out value="${themeMapping.groupId}"/></groupId>	
		<seasonType><![CDATA[  <c:out value="${themeMapping.seasonType}"/>  ]]></seasonType>	
		<pageType><![CDATA[  <c:out value="${themeMapping.pageType}"/>  ]]></pageType>	
		<themeName><![CDATA[  <c:out value="${themeMapping.themeName}"/>  ]]></themeName>	
	</themeMapping>
</js>

