<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<% 
	String msg = "";
	
	msg += "user-agent=" + request.getHeader("user-agent") + "<br>";
	msg += "WL-Proxy-Client-IP=" + request.getHeader("WL-Proxy-Client-IP") + "<br>";
	msg += "Proxy-Client-IP=" + request.getHeader("Proxy-Client-IP") + "<br>";
	msg += "X-Forwarded-For=" + request.getHeader("X-Forwarded-For") + "<br>";
	msg += "clientIP=" + request.getRemoteAddr() + "<br>"; 
	
	//msg = request.getHeader();
	
	Enumeration e = request.getHeaderNames();
	while(e.hasMoreElements()) {
		String name = (String)e.nextElement();
		String value = request.getHeader(name);
		
		msg += name + "=" + value + "<br>";
	}
%>

<%= msg %>