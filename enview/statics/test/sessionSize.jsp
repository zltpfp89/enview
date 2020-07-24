<%@ page contentType="text/html; charset=UTF-8"%>

<%@page import="java.io.ObjectOutputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.util.Enumeration"%>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="javax.servlet.http.Cookie" %>

<html>
<body>
<table width="100%" border="1px">
	<colgroup>
		<col width="5%">
  		<col width="40%">
	  	<col width="55%">
	</colgroup>
	<thead>
		<tr>
			<td style="text-align:center;font-weight:bold">Session Size(Byte)</td>
			<td style="text-align:center;font-weight:bold">Session Name</td>
			<td style="text-align:center;font-weight:bold">Session Value</td>
		</tr>
	</thead>
	<tbody>
<%
	Enumeration en = session.getAttributeNames();
	String name = null;
	Object obj = null;
	ByteArrayOutputStream bastream = null;
	ObjectOutputStream objOut = null;
	
	int objSize = 0;
	int totalSize = 0;
	
	while (en.hasMoreElements()) {
		name = (String)en.nextElement();
		obj = session.getAttribute(name);
		try {
			bastream = new ByteArrayOutputStream();
			objOut = new ObjectOutputStream(bastream);
			
			objOut.writeObject(obj);
			objSize = bastream.size();
		}catch (Exception e) {
			objSize = 0;
		}
%>
		<tr>
			<td style="text-align:right"><%=objSize%></td>
			<td><%=name%></td>
			<td style="word-break: break-all;"><%=session.getValue(name)%></td>
		</tr>
<%
		totalSize += objSize;
	}
%>	
	</tbody>
</table>
<br>
totalSize : <%=totalSize %>Byte
</body>
</html>
