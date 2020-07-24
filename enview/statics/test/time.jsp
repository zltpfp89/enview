<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<pre>
<%
Calendar cal = Calendar.getInstance();
out.println( cal.getTime());
out.println( cal.getTimeZone());
%>
</pre>