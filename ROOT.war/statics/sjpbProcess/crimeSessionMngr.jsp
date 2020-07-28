<%@page import="java.util.Map"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%

	String fdcd = request.getParameter("fdcd");
	if(fdcd == null){
		fdcd="NO";
	}
	if(fdcd != null){
		if(session.getAttribute("mySelectFdcd") != null){
			session.removeAttribute("mySelectFdcd");
			session.setAttribute("mySelectFdcd", fdcd);
		}else session.setAttribute("mySelectFdcd", fdcd);
	}

%>
1