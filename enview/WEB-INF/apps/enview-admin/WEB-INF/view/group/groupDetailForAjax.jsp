<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <group>
		<principalId><c:out value="${group.principalId}"/></principalId>	
		<parentId><c:out value="${group.parentId}"/></parentId>	
		<shortPath><![CDATA[  <c:out value="${group.shortPath}"/>  ]]></shortPath>	
		<principalName><![CDATA[  <c:out value="${group.principalName}"/>  ]]></principalName>	
		<theme><![CDATA[  <c:out value="${group.theme}"/>  ]]></theme>	
		<siteName><![CDATA[  <c:out value="${group.siteName}"/>  ]]></siteName>	
		<defaultPage><![CDATA[  <c:out value="${group.defaultPage}"/>  ]]></defaultPage>	
		<subPage><![CDATA[  <c:out value="${group.subPage}"/>  ]]></subPage>	
		<principalType><![CDATA[  <c:out value="${group.principalType}"/>  ]]></principalType>	
		<principalOrder><c:out value="${group.principalOrder}"/></principalOrder>	
		<creationDate><c:out value="${group.creationDateByFormat}"/></creationDate>	
		<modifiedDate><c:out value="${group.modifiedDateByFormat}"/></modifiedDate>	
		<principalInfo01><![CDATA[  <c:out value="${group.principalInfo01}"/>  ]]></principalInfo01>	
		<principalInfo02><![CDATA[  <c:out value="${group.principalInfo02}"/>  ]]></principalInfo02>	
		<principalInfo03><![CDATA[  <c:out value="${group.principalInfo03}"/>  ]]></principalInfo03>	
		<principalDesc><![CDATA[  <c:out value="${group.principalDesc}"/>  ]]></principalDesc>
		
		<gradeId><c:out value="${group.gradeId}"/></gradeId>
		<domain><c:out value="${group.domain}"/></domain>
		<domainId><c:out value="${group.domainId}"/></domainId>
		
	</group>
</js>