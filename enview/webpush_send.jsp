<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.saltware.enface.webpush.WebPushSender"%>
<%@page import="com.saltware.enview.Enview"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
try {
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	long time = System.currentTimeMillis();
	WebPushSender.sendPushMessage("stu01", "테스트 푸시 "  + df.format( new Date()));
	out.println( "send push. " + (System.currentTimeMillis() - time ) + "ms ");
} catch(Exception e) {
	e.printStackTrace();
}

%>
