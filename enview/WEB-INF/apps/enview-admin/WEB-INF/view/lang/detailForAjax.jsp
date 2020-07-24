<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <lang>
		<domainId><![CDATA[  <c:out value="${lang.domainId}"/>  ]]></domainId>	
		<langKnd><![CDATA[  <c:out value="${lang.langKnd}"/>  ]]></langKnd>	
		<langCd><![CDATA[  <c:out value="${lang.langCd}"/>  ]]></langCd>	
		<langDesc><![CDATA[  <c:out value="${lang.langDesc}"/>  ]]></langDesc>	
		<langUpdDate><c:out value="${lang.langUpdDateByFormat}"/></langUpdDate>	
		<langUpdId><![CDATA[  <c:out value="${lang.langUpdId}"/>  ]]></langUpdId>	
	</lang>
</js>
