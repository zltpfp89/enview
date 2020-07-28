<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<js>
    <status><c:out value="${inform.resultStatus}"/></status>
    <reason><c:out value="${inform.failureReason}"/></reason>    
    <userGroup>

		<principalId><c:out value="${userMenu.principalId}"/></principalId>	
		<pageId><c:out value="${userMenu.pageId}"/></pageId>	
		<parentId><c:out value="${userMenu.parentId}"/></parentId>	
		<menuType><c:out value="${userMenu.menuType}"/></menuType>	
		<menuOrder><c:out value="${userMenu.menuOrder}"/></menuOrder>	
	</userGroup>
</js>
