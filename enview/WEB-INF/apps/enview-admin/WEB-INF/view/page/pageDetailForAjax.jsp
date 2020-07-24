<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <page>

		<path><![CDATA[  <c:out value="${page.path}"/>  ]]></path>	
		<pageId><c:out value="${page.pageId}"/></pageId>	
		<parentId><c:out value="${page.parentId}"/></parentId>	
		<systemCode><![CDATA[  <c:out value="${page.systemCode}"/>  ]]></systemCode>	
		<depth><c:out value="${page.depth}"/></depth>	
		<name><![CDATA[  <c:out value="${page.name}"/>  ]]></name>	
		<type><![CDATA[  <c:out value="${page.type}"/>  ]]></type>	
		<pageType><![CDATA[  <c:out value="${page.pageType}"/>  ]]></pageType>	
		<title><![CDATA[  <c:out value="${page.title}" escapeXml="false"/>  ]]></title>	
		<shortTitle><![CDATA[  <c:out value="${page.shortTitle}"  escapeXml="false"/>  ]]></shortTitle>	
		<sortOrder><c:out value="${page.sortOrder}"/></sortOrder>	
		<isHidden><c:out value="${page.isHidden}"/></isHidden>	
		<isQuickMenu><c:out value="${page.isQuickMenu}"/></isQuickMenu>	
		<isAllowGuest><c:out value="${page.isAllowGuest}"/></isAllowGuest>	
		<isProtected><c:out value="${page.isProtected}"/></isProtected>	
		<useTheme><c:out value="${page.useTheme}"/></useTheme>	
		<useIframe><c:out value="${page.useIframe}"/></useIframe>	
		<defaultPageName><![CDATA[  <c:out value="${page.defaultPageName}"/>  ]]></defaultPageName>	
		<defaultPagePath><![CDATA[  <c:out value="${page.defaultPagePath}"/>  ]]></defaultPagePath>	
		<target><![CDATA[  <c:out value="${page.target}"/>  ]]></target>	
		<url><![CDATA[  <c:out value="${page.url}" escapeXml="false"/>  ]]></url>	
		<parameter><![CDATA[  <c:out value="${page.parameter}"/>  ]]></parameter>	
		<skin><![CDATA[  <c:out value="${page.skin}"/>  ]]></skin>	
		<defaultLayoutDecorator><![CDATA[  <c:out value="${page.defaultLayoutDecorator}"/>  ]]></defaultLayoutDecorator>	
		<defaultPortletDecorator><![CDATA[  <c:out value="${page.defaultPortletDecorator}"/>  ]]></defaultPortletDecorator>	
		<owner><![CDATA[  <c:out value="${page.owner}"/>  ]]></owner>			
	<c:forEach items="${page.ownerInfoList}" var="owner" varStatus="status">
		<ownerInfos principalId="<c:out value="${owner.PRINCIPAL_ID}"/>" userId="<c:out value="${owner.USER_ID}"/>"><![CDATA[  <c:out value="${owner.NM_KOR}"/>  ]]></ownerInfos>
	</c:forEach>
		<masterPagePath><![CDATA[  <c:out value="${page.masterPagePath}"/>  ]]></masterPagePath>	
		<pageInfo01><![CDATA[  <c:out value="${page.pageInfo01}"/>  ]]></pageInfo01>	
		<pageInfo02><![CDATA[  <c:out value="${page.pageInfo02}"/>  ]]></pageInfo02>	
		<pageInfo03><![CDATA[  <c:out value="${page.pageInfo03}"/>  ]]></pageInfo03>
		<domain><![CDATA[  <c:out value="${page.domain}"/>  ]]></domain>
		<domainId><c:out value="${page.domainId}"/></domainId>
		<domainCode><![CDATA[  <c:out value="${page.domainCode}"/>  ]]></domainCode>
	</page>
</js>

