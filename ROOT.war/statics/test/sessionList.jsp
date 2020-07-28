<%@page import="com.saltware.enview.Enview"%>
<%@page import="org.springframework.security.core.session.SessionRegistry"%>
<%@page import="com.saltware.enview.util.HttpUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
SessionRegistry sessionRegistry = (SessionRegistry)Enview.getComponentManager().getComponent("sessionRegistry");
out.println( sessionRegistry);



%>
