<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.saltware.enview.security.*"%>

<%
	String authCode = EnviewAuthorityManager.getInstance().getAuthority(request);
	
	System.out.println("########## authCode=" + authCode + ", userId=" + (String)session.getAttribute("_enpass_id_"));
	System.out.println("########## binaryCode=" + EnviewAuthorityManager.getInstance().getBinaryAuthority(authCode));
	
%>