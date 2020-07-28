<%@page import="java.util.Enumeration"%>
<%@page import="java.io.ObjectOutputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.Serializable"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.Cookie" %>
<html>
<title>Sessions</title>
<body>
<%
HttpSessionContext context = session.getSessionContext();
out.println( "context=" + context);
Enumeration en = context.getIds();
out.println( "en=" + en);
HttpSession ses = null;
int cnt = 0;
while( en.hasMoreElements()) {
	String id = (String)en.nextElement();
	out.println( "id=" + id);
	if( id!=null) {
		ses = context.getSession(id);
		if( ses != null) {
			out.println( (++cnt) + " : " + ses.getAttribute("_enpass_id_") + "<br>" );
		}
	}
}
%>
</body>
</html>
