<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/cola/cafe/css/styles.css">

  <c:if test="${empty requestScope.windowId}">
	<%--포틀릿으로서 동작하고 있지 않을 때에는 enView의 Javascript를 포함시켜준다--%>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
	<!--script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/messageResource_<c:out value="${secPmsnVO.locale}"/>.js"></script-->
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/messageResource_ko.js"></script>

	<link type="text/css" href="<%=request.getContextPath()%>/decorations/layout/css/jquery/base/jquery.ui.all.css" rel="stylesheet" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
	<!--script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/ui/i18n/jquery.ui.datepicker-<c:out value="${secPmsnVO.locale}"/>.js"></script-->
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/ui/i18n/jquery.ui.datepicker-ko.js"></script>
  </c:if>

	<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_util.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/crossdomain.js"></script>

</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" align="center" border="1" cellspacing="0" cellpadding="0" height="100%">
  <tr>
    <td>
	  <%--Put your code for decorating cafe's header in here!--%>
	</td>
  </tr>
  <tr>
    <td>
