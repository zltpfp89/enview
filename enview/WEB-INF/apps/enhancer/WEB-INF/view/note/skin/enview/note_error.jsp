<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${baseForm.reasonCd == 'cf.error.open.request' }">
	<script type="text/javascript">
		alert('<c:out value="${baseForm.reason}"/>');
		history.go(-1);
	</script>
</c:if>
<c:if test="${baseForm.reasonCd != 'cf.error.open.request' }">
	<c:if test="${baseForm.reasonCd == 'cf.error.not.exist.cmnt' }">
		[cafe]
	</c:if>
</c:if>