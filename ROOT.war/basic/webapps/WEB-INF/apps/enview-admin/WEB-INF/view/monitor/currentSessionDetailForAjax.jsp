<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <userpass>

		<userId><![CDATA[  <c:out value="${userpassVO.userId}"/>  ]]></userId>	
		<nmKor><![CDATA[  <c:out value="${userpassVO.nmKor}"/>  ]]></nmKor>	
		<nmNic><![CDATA[  <c:out value="${userpassVO.nmNic}"/>  ]]></nmNic>	
		<regNo><![CDATA[  <c:out value="${userpassVO.regNo}"/>  ]]></regNo>	
		<birthYmd><c:out value="${userpassVO.birthYmd}"/></birthYmd>	
		<emailAddr><![CDATA[  <c:out value="${userpassVO.emailAddr}"/>  ]]></emailAddr>	
		<offcTel><![CDATA[  <c:out value="${userpassVO.offcTel}"/>  ]]></offcTel>	
		<mileTot><c:out value="${userpassVO.mileTot}"/></mileTot>	
		<homeTel><![CDATA[  <c:out value="${userpassVO.homeTel}"/>  ]]></homeTel>	
		<mobileTel><![CDATA[  <c:out value="${userpassVO.mobileTel}"/>  ]]></mobileTel>	
		<homeZip><![CDATA[  <c:out value="${userpassVO.homeZip}"/>  ]]></homeZip>	
		<homeAddr1><![CDATA[  <c:out value="${userpassVO.homeAddr1}"/>  ]]></homeAddr1>	
		<homeAddr2><![CDATA[  <c:out value="${userpassVO.homeAddr2}"/>  ]]></homeAddr2>	
		<langKnd><![CDATA[  <c:out value="${userpassVO.langKnd}"/>  ]]></langKnd>	
		<userInfo05><![CDATA[  <c:out value="${userpassVO.userInfo05}"/>  ]]></userInfo05>	
		<userInfo06><![CDATA[  <c:out value="${userpassVO.userInfo06}"/>  ]]></userInfo06>	
		<regDatim><c:out value="${userpassVO.regDatimByFormat}"/></regDatim>	
		<updDatim><c:out value="${userpassVO.updDatimByFormat}"/></updDatim>	
	</userpass>
</js>