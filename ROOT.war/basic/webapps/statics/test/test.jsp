<%@page import="com.saltware.enview.code.EnviewCodeManager"%>
<%@page import="com.saltware.enview.codebase.CodeBundle"%>
<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.saltware.enview.login.LoginConstants" %>
<%@ page import="com.saltware.enview.Enview" %>
<%@ page import="com.saltware.enview.security.UserManager" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%=Enview.getConfiguration().getString("portal.session.domain", "false")%>
