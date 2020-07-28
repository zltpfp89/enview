<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.saltware.enview.Enview"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	<c:if test="${fuForm.status == 'success'}">
		//alert('<c:out value="${fuForm.fileMask}"/>');
		parent.cfGGum.getTplMngr().previewImage('<c:out value="${cmntVO.cmntId}"/>');
	</c:if>
	<c:if test="${fuForm.status == 'fail'}">
		<c:if test="${fuForm.reasonCd == 'eb.error.need.login'}">
			alert('<c:out value="${fuForm.reason}"/>');
		</c:if>
		<c:if test="${fuForm.reasonCd != 'eb.error.need.login'}">
			alert('<c:out value="${fuForm.reason}"/>');
			//parent.cfHome.setMakeCafeHandler();
		</c:if>
	</c:if>
</script>
