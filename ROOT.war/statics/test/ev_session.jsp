<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="com.saltware.enview.Enview" %>
<%@ page import="com.saltware.enview.session.SessionManager" %>
<%@ page import="com.saltware.enview.session.SessionUserData" %>
<%@ page import="java.lang.StringBuffer" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Iterator" %>

<%
	StringBuffer buffer = new StringBuffer();
	//buffer.append("<table border='0' style='border:1px solid black;'>");
	buffer.append("<table border='0'>");

	SessionManager sessionManager = (SessionManager)Enview.getComponentManager().getComponent("com.saltware.enview.session.SessionManager");
	Hashtable table = sessionManager.getTotalSession();
	
	Cookie[] cookies = request.getCookies();
	for(int i=0; i<cookies.length; i++) {
		buffer.append("<tr>").append("<td>").append( cookies[i].getName() ).append("</td><td colspan='2'>").append( cookies[i].getValue() ).append("</td></tr>");
	}
		
	buffer.append("<tr>").append("<td>Current Session </td><td colspan='2'>").append( request.getSession(true).getId() ).append("</td></tr>");
	buffer.append("<tr>").append("<td>Total Count </td><td colspan='2'>").append( table.size() ).append("</td></tr>");

	Iterator it = table.keySet().iterator();
	for(; it.hasNext(); ) {
		String sid = (String)it.next();
		SessionUserData userObject = (SessionUserData)table.get(sid);
		Map userInfo = (Map)userObject.getUserData();
		
		buffer.append("<tr>");
		buffer.append("<td>").append( userInfo.get("user_id") ).append("</td>");
		buffer.append("<td>").append( userInfo.get("nm_kor") ).append("</td>");
		buffer.append("<td>").append( sid ).append("</td>");
		buffer.append("</tr>");
		//System.out.println("userInfo=" + userInfo);
	}

	buffer.append("</table>");
%>

<html>
<title>Session Test</title>
<body>
	<%= buffer.toString() %>
</body>
</html>
