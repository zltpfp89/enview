<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.Cookie" %>

<%
	String buffer = "sessionID=" + session.getId() + "<br>";
	Cookie[] cookies = request.getCookies();
    if( cookies != null ) {
        for(int i=0; i<cookies.length; i++) {
        	buffer += cookies[i].getName() + "=" + cookies[i].getValue() + "<br>";
        }
	}
	
%>

<html>
<title>Session Test</title>
<body>
	<%= buffer %>
</body>
</html>
