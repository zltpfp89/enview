<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.saltware.enview.Enview"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
  <c:if test="${fuForm.status == 'success'}">
		parent.document.forms["setForm"].cmntImgFileMask.value = '<c:out value="${fuForm.fileMask}"/>'; <%--대표이미지의 서버 디스크상의 실제 파일명을 전달해준다.--%>
		parent.cfHome.setMakeCafe(); <%--카페만들기 메쏘드를 호출해준다.--%>
  </c:if>
  <c:if test="${fuForm.status == 'fail'}">
    <c:if test="${fuForm.reasonCd == 'eb.error.need.login'}">
		alert('<c:out value="${fuForm.reason}"/>');
		parent.location.href = '<%=request.getContextPath() + Enview.getConfiguration().getString("sso.login.page")%>'; <%--로그인화면으로 전환한다.--%>
	</c:if>
	<c:if test="${fuForm.reasonCd != 'eb.error.need.login'}">
		alert('<c:out value="${fuForm.reason}"/>');
		//parent.cfHome.setMakeCafeHandler();
	</c:if>
  </c:if> 
</script>