<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="utf-8" %>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>Error report</title>
</head>

<%
	response.setStatus(200);
	String errorMessage = "";
	Integer statusCode = (Integer)request.getAttribute("javax.servlet.error.status_code");
	if( statusCode==404) {
		errorMessage = "페이지를 찾을 수 없습니다.<br> Page not found ";
	} else {
		errorMessage = (String)request.getAttribute("errorMessage");
		if( errorMessage==null) {
			if( exception == null) {
				exception = (Exception)request.getAttribute("exception");
			}

			if( exception == null) {
				exception = (Exception)request.getAttribute("javax.servlet.error.exception");
			}
			
			if( exception !=null) {
				errorMessage = "수행 중 오류가 발생했습니다. 관리자에게 문의 하세요<br> An error occurred during execution. Contact your manager <br> " + exception.getClass().getName() + " : " + exception.getMessage();
			} else {
				errorMessage = "수행 중 알수 없는 오류가 발생했습니다. 관리자에게 문의 하세요<br> An error occurred during execution. Contact your manager ";
			}
		}
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr>
    <td align="center"> 
	  <table width="200px" height="200px" border=0 cellspacing=0 cellpadding=0>
		<tr>
			<td align="center" valign="center">Application Error</td>
		</tr>
		<tr>
			<td>
				<div style="width: 200px; height:200px; border: 1px solid black; padding: 10px;">
					<%=errorMessage%>
				</div>
			</td>
		</tr>
		<tr><td align="center">
			<p><a href="javascript:history.back(-1);">Back</a></p>
		</td></tr>
	  </table>
	</td>
  </tr>
</table>

</body>
</html>