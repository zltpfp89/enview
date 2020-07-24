<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %>

<%
	String userId = EnviewSSOManager.getUserId(request, response);
	System.out.println("######################## userId=" + userId);
	String xml = "";
	xml += "<?xml version=\"1.0\" encoding=\"EUC-KR\"?>";
	xml += "<Groupware>";
	xml += "<Item url='한글이 될까'>";
	xml += "40";
	xml += "</Item>";
	xml += "</Groupware>";
	response.setContentType("text/xml");
	response.getWriter().println( xml );
%>
<table>
<tr>
<td> <a href="http://naver.com">네이버</a></td>
</tr>
<tr>
<td> asdasdasdasdasdasdasd</td>
</tr>
<tr>
<td> asdasdasdasdasdasdasd</td>
</tr>
<tr>
<td> asdasdasdasdasdasdasd</td>
</tr>
<tr>
<td> asdasdasdasdasdasdasd</td>
</tr>
<tr>
<td> 한글이 되나</td>
</tr>
<tr>
<td> asdasdasdasdasdasdasd</td>
</tr>
<tr>
<td> asdasdasdasdasdasdasd</td>
</tr>
<tr>
<td> asdasdasdasdasdasdasd</td>
</tr>
</table>