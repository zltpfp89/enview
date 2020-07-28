<%@page import="com.saltware.enview.util.StringUtil"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="com.saltware.encola.cafe.security.SecurityMngr"%>
<%@page import="com.saltware.encola.common.vo.CmntMmbrVO"%>
<%@page import="com.saltware.enview.security.UserInfo"%>
<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@page import="com.saltware.encola.common.vo.CommunityVO"%>
<%@page import="com.saltware.encola.common.cache.CacheMngr"%>
<%@page import="com.saltware.enview.Enview"%>

<%@page import="com.saltware.enview.components.dao.ConnectionContextForRdbms"%>
<%@page import="com.saltware.enview.components.dao.ConnectionContext"%>
<%@page import="com.saltware.encola.cafe.dao.HomeDAO"%>
<%@page import="com.saltware.enboard.vo.BoardVO"%>
<%@page import="com.saltware.enview.components.dao.DAOFactory"%>
<%
BoardVO brdVO = (BoardVO)request.getAttribute ("boardVO");
if( brdVO.getBoardId().startsWith("CF") && brdVO.getBoardId().length() > 19) {
	
	if( request.getAttribute("cafeTheme") == null) {
		
		String cmntId = brdVO.getBoardId().substring( 0,19);
		CacheMngr cacheMngr = (CacheMngr)Enview.getComponentManager().getComponent("com.saltware.encola.common.cache.CacheMngr");
		CommunityVO cmntVO = cacheMngr.getCommunity(cmntId);
//		out.println( cmntVO);
		if( cmntVO!=null) {
			request.setAttribute("cafeTheme", cmntVO.getTheme());
		}
	}
	if( StringUtil.isEmpty((String)request.getAttribute("cafeTheme"))) {
		request.setAttribute("cafeTheme", "basic");
	}
	
//	out.println( "theme=" + request.getAttribute("cafeTheme"));
}
%>
<link id="themeCss" rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/theme/${cafeTheme}.css" />
