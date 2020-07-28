<%@ page contentType="text/json;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
{
  "Status": "<util:json value="${baseForm.status}"/>",
  "Reason": "<util:json value="${baseForm.reason}"/>",
  "ReasonCd": "<util:json value="${baseForm.reasonCd}"/>"
}
