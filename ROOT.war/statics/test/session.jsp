<%@page import="java.util.Enumeration"%>
<%@page import="java.io.ObjectOutputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.Serializable"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.Cookie" %>

<%!
 private int serializedSize( Serializable o ) throws IOException {
     ByteArrayOutputStream baos = new ByteArrayOutputStream();
     ObjectOutputStream oos = new ObjectOutputStream( baos );
     oos.writeObject( o );
     oos.close();
     return baos.toByteArray().length;
 }

%>
<html>
<title>Session Attributes</title>
<body>
<h1>Session properties</h1>
session.maxInactiveInterval=<%=session.getMaxInactiveInterval() %>
	
<h1>Session Attributes</h1>
	<table width="100%" border="1" style="table-layout: fixed;word-break:break-all">
	<tr>
	<th width="200px"> Attribute Name </th>
	<th width="200px"> Class name </th>
	<th width="*"> Value </th>
	<th width="100px"> Serialized<br>Size </th>
	</tr>
	<%
	long totalSize = 0;
	Enumeration en = session.getAttributeNames();
	while( en.hasMoreElements()) {
		out.println("<tr>");
		String key = (String)en.nextElement();
		Object value = session.getAttribute(key);
		out.println("<td>" + key + "</td>");
		if( value == null) {
			out.println("<td>-</td>");
			out.println("<td>-</td>");
			out.println("<td>-</td>");
		} else {
			out.println("<td>" + value.getClass().getName() + "</td>");
			out.println("<td>" + value.toString() + "</td>");
			if( value instanceof Serializable) {
				int size = serializedSize((Serializable)value);
				totalSize+= size;
				out.println("<td align='right'>" + size + "</td>");
			} else {
				out.println("<td>-</td>");
			}
		}
		out.println("</tr>");
	}
	%>
	</table>
	Total Size : <%= totalSize%> B, <%= totalSize * 10 / 1024 / 10.0 %> KB
</body>
</html>
