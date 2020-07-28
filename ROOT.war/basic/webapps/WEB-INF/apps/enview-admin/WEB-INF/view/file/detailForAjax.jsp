<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <file>
		<filePath><![CDATA[  <c:out value="${file.filePath}"/>  ]]></filePath>
		<fileName><![CDATA[  <c:out value="${file.fileName}"/>  ]]></fileName>
		<fileSize><![CDATA[  <c:out value="${file.fileSize}"/>  ]]></fileSize>
		<modifiedDate><![CDATA[  <c:out value="${file.modified}"/>  ]]></modifiedDate>
		<fileExt><![CDATA[  <c:out value="${file.fileExt}"/>  ]]></fileExt>
		<editable><c:out value="${file.editable}"/></editable>
		<isFolder><c:out value="${file.folder}"/></isFolder>
		<isPreviewable><c:out value="${file.isPreviewable}"/></isPreviewable>
	</file>
</js>