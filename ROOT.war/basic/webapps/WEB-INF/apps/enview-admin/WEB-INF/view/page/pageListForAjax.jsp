<%@ page contentType="text/json; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
{
  "Status": "<util:json value="${inform.resultStatus}"/>",
  "Reason": "<util:json value="${inform.failureReason}"/>",
  "TotalSize": "<util:json value="${inform.totalSize}"/>",
  "ResultSize": "<util:json value="${inform.resultSize}"/>",
  "Data":
  [
<c:forEach items="${results}" var="page" varStatus="status">
	{
"path": "<util:json value="${page.path}"/>"
,"pageId": "<util:json value="${page.pageId}"/>"
,"parentId": "<util:json value="${page.parentId}"/>"
,"systemCode": "<util:json value="${page.systemCode}"/>"
,"depth": "<util:json value="${page.depth}"/>"
,"name": "<util:json value="${page.name}"/>"
,"type": "<util:json value="${page.type}"/>"
,"pageType": "<util:json value="${page.pageType}"/>"
,"title": "<util:json value="${page.title}"/>"
,"shortTitle": "<util:json value="${page.shortTitle}"/>"
,"sortOrder": "<util:json value="${page.sortOrder}"/>"
,"isHidden": "<util:json value="${page.isHidden}"/>"
,"isQuickMenu": "<util:json value="${page.isQuickMenu}"/>"
,"isAllowGuest": "<util:json value="${page.isAllowGuest}"/>"
,"isProtected": "<util:json value="${page.isProtected}"/>"
,"useTheme": "<util:json value="${page.useTheme}"/>"
,"defaultPageName": "<util:json value="${page.defaultPageName}"/>"
,"target": "<util:json value="${page.target}"/>"
,"url": "<util:json value="${page.url}"/>"
,"parameter": "<util:json value="${page.parameter}"/>"
,"skin": "<util:json value="${page.skin}"/>"
,"defaultLayoutDecorator": "<util:json value="${page.defaultLayoutDecorator}"/>"
,"defaultPortletDecorator": "<util:json value="${page.defaultPortletDecorator}"/>"
,"owner": "<util:json value="${page.owner}"/>"
,"masterPagePath": "<util:json value="${page.masterPagePath}"/>"
,"pageInfo01": "<util:json value="${page.pageInfo01}"/>"
,"pageInfo02": "<util:json value="${page.pageInfo02}"/>"
,"pageInfo03": "<util:json value="${page.pageInfo03}"/>"
,"domain": "<util:json value="${page.domain}"/>"
,"domainId": "<util:json value="${page.domainId}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
