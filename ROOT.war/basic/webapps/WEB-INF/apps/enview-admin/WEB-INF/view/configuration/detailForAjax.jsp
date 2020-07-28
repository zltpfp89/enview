
<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <configuration>

		<configCd><![CDATA[  <c:out value="${configuration.configCd}"/>  ]]></configCd>	
		<systemCode><![CDATA[  <c:out value="${configuration.systemCode}"/>  ]]></systemCode>	
		<configType><![CDATA[  <c:out value="${configuration.configType}"/>  ]]></configType>	
		<configValue><![CDATA[  <c:out value="${configuration.configValue}"/>  ]]></configValue>	
		<remark><![CDATA[  <c:out value="${configuration.remark}"/>  ]]></remark>	
		<updUserId><![CDATA[  <c:out value="${configuration.updUserId}"/>  ]]></updUserId>	
		<updDatim><c:out value="${configuration.updDatimByFormat}"/></updDatim>	
	</configuration>
</js>

