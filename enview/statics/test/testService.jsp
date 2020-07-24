<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.saltware.enview.security.UserInfo"%>
<%@page import="com.saltware.enview.portlet.service.PortletService"%>
<%@page import="com.saltware.enview.portlet.service.impl.EnviewPortletServiceFactory"%>
<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.saltware.enview.login.LoginConstants" %>
<%@ page import="com.saltware.enview.Enview" %>
<%@ page import="com.saltware.enview.security.UserManager" %>
<%
try {
	UserInfo userInfo = EnviewSSOManager.getUserInfo(request);
	PortletService service = EnviewPortletServiceFactory.getInstance("academic.UserGroupListService");
	Map paramMap = new HashMap();
	paramMap.putAll( userInfo.getUserInfoMap());
	List results = service.queryForList( paramMap);
	if( results.size() > 0) {
		Object[] headers = ((Map)results.get(0)).keySet().toArray();
		out.println("<table>");
		out.println("<tr>");
		for( int col=0; col < headers.length; col++) {
			out.println("<th>" + headers[col] + "</th>");
		}
		out.println("</tr>");
		Map rowMap;
		for( int row = 0; row < results.size(); row++) {
			out.println("<tr>");
			rowMap = (Map)results.get( row);
			for( int col=0; col < headers.length; col++) {
				out.println("<td>" + rowMap.get( headers[col]) + "</td>");
			}
			out.println("</tr>");
		}
		out.println("</table>");
	}
} catch( Exception e) {
	out.println("<pre>");
	e.printStackTrace( new PrintWriter( out));
	out.println("</pre>");
}
%>

