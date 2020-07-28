<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.saltware.enview.login.LoginConstants" %>
<%@ page import="com.saltware.enview.Enview" %>
<%@ page import="com.saltware.enview.security.UserManager" %>

<%
	String userId = (String)session.getAttribute("userId");
	System.out.println("### userId=" + userId);
	if( userId == null ) {
		//session.setAttribute("_enpass_id_", userId);
		session.setAttribute("_enpass_id_", "lsanguk");
		
		pageContext.forward("/portal/gjportal/main.page");
		//response.sendRedirect("/enview/portal/gjportal/main.page");
	}
%>

