<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<script type="text/javascript">
  <!--
  <c:if test="${fuForm.status == 'success'}">
		parent.document.forms["setForm"].cmntImgFileMask.value = '<c:out value="${fuForm.fileMask}"/>'; <%--대표이미지의 서버 디스크상의 실제 파일명을 전달해준다.--%>
		parent.cfOp.baseInfo.setBaseInfoBase(); <%--카페만들기 메쏘드를 호출해준다.--%>
  </c:if>
  <c:if test="${fuForm.status == 'fail'}">
	alert('<c:out value="${fuForm.reason}"/>');
	//parent.cfOp.baseInfo.setBaseInfoBaseHandler();
  </c:if>
  //-->
</script>