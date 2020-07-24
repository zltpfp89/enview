<%@ page contentType="text/json;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
{
  "Status": "<c:out value="${baseForm.status}"/>",
  "Reason": "<c:out value="${baseForm.reason}"/>",
  "ReasonCd": "<c:out value="${baseForm.reasonCd}"/>"
}
