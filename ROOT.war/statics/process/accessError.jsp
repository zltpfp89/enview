<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.saltware.enview.Enview" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Iterator" %>
<%
	String errorPage = (String)session.getAttribute("ACCESS_ERROR_PAGE");
	if( errorPage == null ) errorPage = "";
	session.removeAttribute("ACCESS_ERROR_PAGE");
	
	String loginUrl = Enview.getConfiguration().getString("sso.login.page");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
    <meta http-equiv="Content-type" content="text/html" />  
    <meta http-equiv="Content-style-type" content="text/css" />
    <meta name="version" content="3.23" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
	
    <script type="text/JavaScript">
		function goHome() {
			location.href = "<%= request.getContextPath() %>";
		}
		function goLogin() {
			location.href = "<%=request.getContextPath()%><%=loginUrl%>";
		}
		function goBack() {
			history.back(-1);
		}
	</script>
</head>
<body>
<p><p>
<table width="800" height="600" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td> 
	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
		<tr> 
          <td align="center">
			<div style="border:1px solid black; padding: 10px; width:600px"> 
				<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#E4E4E4" style="padding: 10px;">
					<tr >
						<td rowspan="5">
							<img src="<%=request.getContextPath()%>/images/key.png">
						</td>
					</tr>
					<tr> 
						<td style="font-weight:bold;">
							<strong>회원 전용 페이지 입니다.</strong><br>
							다음과 같은 이유로 <font color="#FF0000">접근이 제한</font> 되었습니다.</br>
							<hr>
						</td>
					</tr>
					<tr>
						<td>
							<ul style="font-size:11px;">
								<li> Login을 하지 않았을 경우 </li>
								<li> 30분 이상 사용을 하지 않아 접속정보가 삭제 되었을 경우 </li>
								<li> 다른곳에서 동일ID로 접속을 하여 접속 정보를 삭제 했을 경우 </li>
								<li> 브라우저의 쿠키값이 리셋 될 경우 </li>
								<li> 권한이 없는 경우 </li>
							</ul>
							<p>
						</td>
					</tr>
					<tr>
						<td>
							<hr>
						</td>
					</tr>
					<tr>
						<td align="center">
							<button name="" type="reset" class="reset" style="vertical-align: top;" onclick="javascript:goHome();"><span>홈으로</span></button>
							<button name="" type="reset" class="reset" style="vertical-align: top;" onclick="javascript:goLogin();"><span>로그인</span></button>
							<button name="" type="reset" class="reset" style="vertical-align: top;" onclick="javascript:goBack();"><span>이전페이지</span></button>
						</td>
					</tr>
				</table>
			</div>
			</form>
		  </td>
		</tr>
	</table>
	</td>
  </tr>
</table>
</body>
</html>