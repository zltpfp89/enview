<%@ page contentType="text/json; charset=UTF-8"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%
	//System.out.println("####### portlet=" + request.getAttribute("results"));
%>
{
  "Status": "<util:json value="${inform.resultStatus}"/>",
  "Reason": "<util:json value="${inform.failureReason}"/>",
  "TotalSize": "<util:json value="${inform.totalSize}"/>",
  "ResultSize": "<util:json value="${inform.resultSize}"/>",
  "Data":
  [
<%
	List results = (List)request.getAttribute("results");
	Iterator it = results.iterator();
	for(int i=0; it.hasNext(); i++) {
		Map portlet = (Map)it.next();
		if( i > 0 ) { %>,<% } %>
	{
		"id" : "<%=portlet.get("ID")%>"
		,"name" : "<%=portlet.get("NAME")%>"
		,"applicationId" : "<%=portlet.get("APPLICATION_ID")%>"
		,"categoryId" : "<%=portlet.get("CATEGORY_ID")%>"
		,"appName" : "<%=portlet.get("APP_NAME")%>"
		,"displayName" : "<%=portlet.get("DISPLAY_NAME")%>"
		,"description" : "<%=portlet.get("DESCRIPTION")%>"
		,"path" : "<%=portlet.get("PATH")%>"
		,"title" : "<%=portlet.get("TITLE")%>"
		,"icon" : "<%=portlet.get("ICON")%>"
	}
<%
	}
%>
  ]
}
