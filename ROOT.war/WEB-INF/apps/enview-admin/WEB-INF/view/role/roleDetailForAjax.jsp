<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <role>

		<principalId><c:out value="${role.principalId}"/></principalId>	
		<parentId><c:out value="${role.parentId}"/></parentId>	
		<shortPath><![CDATA[  <c:out value="${role.shortPath}"/>  ]]></shortPath>	
		<principalName><![CDATA[  <c:out value="${role.principalName}"/>  ]]></principalName>	
		<theme><![CDATA[  <c:out value="${role.theme}"/>  ]]></theme>	
		<defaultPage><![CDATA[  <c:out value="${role.defaultPage}"/>  ]]></defaultPage>	
		<principalType><![CDATA[  <c:out value="${role.principalType}"/>  ]]></principalType>	
		<principalOrder><c:out value="${role.principalOrder}"/></principalOrder>	
		<creationDate><c:out value="${role.creationDateByFormat}"/></creationDate>	
		<modifiedDate><c:out value="${role.modifiedDateByFormat}"/></modifiedDate>	
		<principalInfo01><![CDATA[  <c:out value="${role.principalInfo01}"/>  ]]></principalInfo01>	
		<principalInfo02><![CDATA[  <c:out value="${role.principalInfo02}"/>  ]]></principalInfo02>	
		<principalInfo03><![CDATA[  <c:out value="${role.principalInfo03}"/>  ]]></principalInfo03>	
		<principalDesc><![CDATA[  <c:out value="${role.principalDesc}"/>  ]]></principalDesc>
		<gradeId><c:out value="${role.gradeId}"/></gradeId>	
		<domain><![CDATA[  <c:out value="${role.domain}"/>  ]]></domain>	
		<domainId><c:out value="${role.domainId}"/></domainId>
	</role>
</js>

