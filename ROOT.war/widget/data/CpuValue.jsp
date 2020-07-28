<%@page language="java"%><%@page import="java.util.Calendar" %><%@page import="java.text.SimpleDateFormat" %>
<%@ page session="false" contentType="text/html" %>

<%@ page import="com.saltware.enview.admin.cpuMonitor.service.SystemData" %>
<html><body>
<b><%= java.net.InetAddress.getLocalHost().getHostAddress() %></b>
<%= new java.util.Date() %><br><br>


<%
SystemData a = new SystemData();
Calendar cal = Calendar.getInstance();
SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
String timeLabel = sdf.format(cal.getTime());
String dataParameters = "&label=" +timeLabel+ "&value=" + (100-a.getCpu());

//Now write it to output stream
out.print(dataParameters);

%>