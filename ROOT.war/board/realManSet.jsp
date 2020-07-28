<%@ page contentType="text/html;charset=UTF-8"%>

<%
	session.setAttribute("_realMan_yn_","Y");
	session.setAttribute("_realMan_id_","1111111111111");
	session.setAttribute("_realMan_nm_","신광웅");
	String rtnUrl = request.getQueryString();
	rtnUrl = rtnUrl.substring(rtnUrl.indexOf("rtnUrl=")+7);
%>
<html>
<body>
  <form method="POST" action="<%=rtnUrl%>">
    실명인증 데이터를 세션에 설정하였습니다.
    <input type="submit" value="확인">
  </form>
</body>
</html>

