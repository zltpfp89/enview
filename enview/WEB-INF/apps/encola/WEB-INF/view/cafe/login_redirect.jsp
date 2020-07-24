<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.saltware.enview.Enview"%>
<%
	response.sendRedirect( Enview.getConfiguration().getString("sso.login.page"));
%>