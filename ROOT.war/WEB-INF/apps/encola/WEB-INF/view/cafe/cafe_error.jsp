<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${baseForm.reasonCd == 'cf.error.closed.cafe' }">
	<script type="text/javascript">
		alert('<c:out value="${baseForm.reason}"/>\n\n'
				+ '강제폐쇄 여부: <c:out value="${cmntCloseVO.forceYnNm}"/>\n'
				+ '사유코드: <c:out value="${cmntCloseVO.closeReasonNm}"/>\n'
				+ '상세사유: <c:out value="${cmntCloseVO.closeRemark}"/>\n'
		);
		history.go(-1);
	</script>
</c:if>
<c:if test="${baseForm.reasonCd != 'cf.error.closed.cafe' }">
	<script type="text/javascript">
		alert('<c:out value="${baseForm.reason}"/>');
		history.go(-1);
	</script>
</c:if>
