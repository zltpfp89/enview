<%@ page contentType="text/json; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
{
  "Status": "<util:json value="${form.status}"/>",
  "Reason": "<util:json value="${form.reason}"/>",
  "Data": "<util:json value="${scheduleId}"/>"
}