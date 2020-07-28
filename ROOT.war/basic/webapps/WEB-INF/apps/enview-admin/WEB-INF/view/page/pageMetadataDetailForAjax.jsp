<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <pageMetadata>

		<metadataId><c:out value="${pageMetadata.metadataId}"/></metadataId>	
		<pageId><c:out value="${pageMetadata.pageId}"/></pageId>	
		<name><![CDATA[  <c:out value="${pageMetadata.name}"/>  ]]></name>	
		<value><![CDATA[  <c:out value="${pageMetadata.value}"/>  ]]></value>	
		<locale><![CDATA[  <c:out value="${pageMetadata.locale}"/>  ]]></locale>	
	</pageMetadata>
</js>