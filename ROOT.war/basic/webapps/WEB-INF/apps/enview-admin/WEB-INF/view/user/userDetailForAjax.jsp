<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <user>

		<principalId><c:out value="${user.principalId}"/></principalId>	
		<shortPath><![CDATA[  <c:out value="${user.shortPath}"/>  ]]></shortPath>	
		<principalName><![CDATA[  <c:out value="${user.principalName}"/>  ]]></principalName>	
		<theme><![CDATA[  <c:out value="${user.theme}"/>  ]]></theme>	
		<defaultPage><![CDATA[  <c:out value="${user.defaultPage}"/>  ]]></defaultPage>	
		<columnValue0><![CDATA[  <c:out value="${user.columnValue0}"/>  ]]></columnValue0>	
		<isEnabled><c:out value="${user.isEnabled}"/></isEnabled>	
		<updateRequired0><c:out value="${user.updateRequired0}"/></updateRequired0>	
		<authFailures0><c:out value="${user.authFailures0}"/></authFailures0>	
		<modifiedDate0><c:out value="${user.modifiedDate0ByFormat}"/></modifiedDate0>	
		<authMethod><c:out value="${user.authMethod}"/></authMethod>	
		<principalType><![CDATA[  <c:out value="${user.principalType}"/>  ]]></principalType>	
		<principalInfo01><![CDATA[  <c:out value="${user.principalInfo01}"/>  ]]></principalInfo01>	
		<principalInfo02><![CDATA[  <c:out value="${user.principalInfo02}"/>  ]]></principalInfo02>	
		<principalInfo03><![CDATA[  <c:out value="${user.principalInfo03}"/>  ]]></principalInfo03>	
		<creationDate><c:out value="${user.creationDateByFormat}"/></creationDate>	
		<modifiedDate><c:out value="${user.modifiedDateByFormat}"/></modifiedDate>	
		<principalDesc><![CDATA[  <c:out value="${user.principalDesc}"/>  ]]></principalDesc>	
		<gradeId><c:out value="${user.gradeId}"/></gradeId>
		<domainId><c:out value="${user.domainId}"/></domainId>
		<domainNm><c:out value="${user.domainNm}"/></domainNm>
	</user>
</js>
