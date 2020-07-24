<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="com.saltware.enview.components.dao.ConnectionContextForRdbms"%>
<%@page import="com.saltware.enview.components.dao.ConnectionContext"%>
<%@page import="com.saltware.encola.cafe.dao.HomeDAO"%>
<%@page import="com.saltware.enboard.vo.BoardVO"%>
<%@page import="com.saltware.enview.components.dao.DAOFactory"%>
<%
BoardVO brdVO = (BoardVO)request.getAttribute ("boardVO");
if( brdVO.getBoardId().startsWith("CF")) {
	if( request.getAttribute("theme")==null) {
		ConnectionContext connCtxt = null;
		try {
			connCtxt = new ConnectionContextForRdbms(true);
			HomeDAO  homeDAO  = (HomeDAO)DAOFactory.getInst().getDAO  (HomeDAO.DAO_NAME_PREFIX);
			String theme = homeDAO.getCmntDecoPref(brdVO.getBoardId().substring( 0,19), "CF0801", "theme", connCtxt);
			
			request.setAttribute("theme", theme);
		} finally{
			if( connCtxt!=null) {
				connCtxt.release();
			}
		}
	}
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=8">
  <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/board/css/style.css">
  <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/board/calendar/css/calendar.css">
<%
  if( request.getAttribute("windownId") == null ) {
%>
  <%--포틀릿으로서 동작하고 있지 않을 때에는 enView의 Javascript를 포함시켜준다--%>
  <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/common_new.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/face/javascript/portlet.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/portal_new.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/utility.js"></script>
  <c:if test="${empty secPmsnVO}">
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/message/mrbun_<%=request.getLocale().getLanguage()%>_mm.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/message/mrbun_<%=request.getLocale().getLanguage()%>_eb.js"></script>
  </c:if>
  <c:if test="${!empty secPmsnVO}">
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/message/mrbun_<c:out value="${secPmsnVO.locale}"/>_mm.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/message/mrbun_<c:out value="${secPmsnVO.locale}"/>_eb.js"></script>
  </c:if>
<%
}
%>
  <script type="text/javascript" src="${pageContext.request.contextPath}/board/javascript/enboard_util.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/board/calendar/calendar.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/board/calendar/ko-kr/generatecalendar.js"></script>
  <script type="text/javascript">
    <!--
	function adminEventFree (win) {
		// 관리자/중간관리자가 아니면 바로 return.
		<c:if test="${secPmsnVO.isAdmin != 'true'}">
			return;
		</c:if>
		ebUtil.eventReset (win.document);
		for (var i=0; i<win.frames.length; i++) {
			try {
				adminEventFree (win.frames[i]);
			} catch(e) {}
		}
	}
	ebUtil.eventSet();
	//-->
  </script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
