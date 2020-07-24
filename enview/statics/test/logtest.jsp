<%@page import="com.saltware.enview.admin.attachfile.service.AttachFileService"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.apache.log4j.FileAppender"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="com.saltware.enview.Enview" %>
<%@ page import="java.lang.StringBuffer" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Iterator" %>

<html>
<title>Log Test</title>
<body>
	<pre>
	<%
	String category = "com.saltware.statistics";
	Logger logger = Logger.getLogger( category);
	
	out.println( category + ".logger=" + logger.getName());
	out.println( category + ".logger.appender=" + logger.getAllAppenders().nextElement());

	category = "com.saltware.statistics.impl";
	logger = Logger.getLogger( category);

	out.println( category + ".logger=" + logger.getName());
	out.println( category + ".logger.appender=" + ( logger.getAllAppenders().hasMoreElements() ? logger.getAllAppenders().nextElement() : ""));

	category = "com.saltware.enview";
	logger = Logger.getLogger( category);

	out.println( category + ".logger=" + logger.getName());
	out.println( category + ".logger.appender=" + ( logger.getAllAppenders().hasMoreElements() ? logger.getAllAppenders().nextElement() : ""));

	category = "com.saltware.enview.admin";
	logger = Logger.getLogger( category);

	out.println( category + ".logger=" + logger.getName());
	out.println( category + ".logger.appender=" + ( logger.getAllAppenders().hasMoreElements() ? logger.getAllAppenders().nextElement() : ""));

	
	logger = Logger.getLogger( AttachFileService.class);

	out.println( category + ".logger=" + logger.getName());
	
	while( !logger.getAllAppenders().hasMoreElements()) {
		logger = Logger.getLogger( logger.getParent().getName());
	}
	
	out.println( "==============================================>");
	out.println( category + ".logger=" + logger.getName());
	out.println( category + ".logger.appender=" + ( logger.getAllAppenders().hasMoreElements() ? logger.getAllAppenders().nextElement() : ""));
	
	%>
	</pre>
</body>
</html>
