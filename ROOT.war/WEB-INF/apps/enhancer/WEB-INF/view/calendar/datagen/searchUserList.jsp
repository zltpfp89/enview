<%@ page contentType="text/json; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
{
  "Status": "<util:json value="${form.status}"/>",
  "Reason": "<util:json value="${form.reason}"/>",
  "Data":
  [
<c:forEach items="${results}" var="searchUser" varStatus="status">
	{
		"userId": "<util:json value="${searchUser.userId}"/>",
		"userName": "<util:json value="${searchUser.userName}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
  ]
}
