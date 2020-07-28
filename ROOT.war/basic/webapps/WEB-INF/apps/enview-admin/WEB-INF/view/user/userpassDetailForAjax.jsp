<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <userpass>

		<userId><![CDATA[  <c:out value="${userpass.userId}"/>  ]]></userId>	
		<nmKor><![CDATA[  <c:out value="${userpass.nmKor}"/>  ]]></nmKor>	
		<nmNic><![CDATA[  <c:out value="${userpass.nmNic}"/>  ]]></nmNic>	
		<regNo><![CDATA[  <c:out value="${userpass.regNo}"/>  ]]></regNo>	
		<birthYmd><c:out value="${userpass.birthYmdByFormat}"/></birthYmd>	
		<emailAddr><![CDATA[  <c:out value="${userpass.emailAddr}"/>  ]]></emailAddr>	
		<offcTel><![CDATA[  <c:out value="${userpass.offcTel}"/>  ]]></offcTel>	
		<mileTot><c:out value="${userpass.mileTot}"/></mileTot>	
		<homeTel><![CDATA[  <c:out value="${userpass.homeTel}"/>  ]]></homeTel>	
		<mobileTel><![CDATA[  <c:out value="${userpass.mobileTel}"/>  ]]></mobileTel>	
		<homeZip><![CDATA[  <c:out value="${userpass.homeZip}"/>  ]]></homeZip>	
		<homeAddr1><![CDATA[  <c:out value="${userpass.homeAddr1}"/>  ]]></homeAddr1>	
		<homeAddr2><![CDATA[  <c:out value="${userpass.homeAddr2}"/>  ]]></homeAddr2>	
		<langKnd><![CDATA[  <c:out value="${userpass.langKnd}"/>  ]]></langKnd>	
		<userInfo05><![CDATA[  <c:out value="${userpass.userInfo05}"/>  ]]></userInfo05>	
		<userInfo06><![CDATA[  <c:out value="${userpass.userInfo06}"/>  ]]></userInfo06>	
		<regDatim><c:out value="${userpass.regDatimByFormat}"/></regDatim>	
		<updDatim><c:out value="${userpass.updDatimByFormat}"/></updDatim>	
	</userpass>
</js>

