<%@page language="java"%><%@page import="java.util.Calendar" %><%@page import="java.text.SimpleDateFormat" %>
<%@ page session="false" contentType="text/html" %>

<%@ page import="com.saltware.enview.admin.realtimeMonitor.service.UseMxBean" %>
<html><body>
<b><%= java.net.InetAddress.getLocalHost().getHostAddress() %></b>
<%= new java.util.Date() %><br><br>

<%
UseMxBean a = new UseMxBean();

Calendar cal = Calendar.getInstance();
SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
String timeLabel = sdf.format(cal.getTime());
String dataParameters = "&label=" + timeLabel + "&value=" + a.getMemory();

//Now write it to output stream
out.print(dataParameters);
%>