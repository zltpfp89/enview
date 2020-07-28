<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <codebase>

		<systemCode><![CDATA[  <c:out value="${codebase.systemCode}"/>  ]]></systemCode>	
		<codeId><![CDATA[  <c:out value="${codebase.codeId}"/>  ]]></codeId>	
		<code><![CDATA[  <c:out value="${codebase.code}"/>  ]]></code>	
		<langKnd><![CDATA[  <c:out value="${codebase.langKnd}"/>  ]]></langKnd>	
		<codeName><![CDATA[  <c:out value="${codebase.codeName}"/>  ]]></codeName>	
		<codeName2><![CDATA[  <c:out value="${codebase.codeName2}"/>  ]]></codeName2>	
		<codeTag1><![CDATA[  <c:out value="${codebase.codeTag1}"/>  ]]></codeTag1>	
		<codeTag2><![CDATA[  <c:out value="${codebase.codeTag2}"/>  ]]></codeTag2>	
		<remark><![CDATA[  <c:out value="${codebase.remark}"/>  ]]></remark>	
		<domainId><![CDATA[  <c:out value="${codebase.domainId}"/>  ]]></domainId>	
	</codebase>
</js>
