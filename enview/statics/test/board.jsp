<%@page import="com.saltware.enboard.vo.BoardVO"%>
<%@page import="com.saltware.enboard.security.SecurityMngr"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.saltware.enboard.cache.CacheMngr"%>
<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.saltware.enview.login.LoginConstants" %>
<%@ page import="com.saltware.enview.Enview" %>
<%@ page import="com.saltware.enview.security.UserManager" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<pre>
<%
	CacheMngr cacheMngr = (CacheMngr)Enview.getComponentManager().getComponent( "com.saltware.enboard.cache.CacheMngr" );
	// GUEST
	Map guestMap = cacheMngr.getGuestBoardPmsn();
	out.println("** Guest board list ");
	Iterator it1 = guestMap.keySet().iterator();
	while( it1.hasNext()) {
		out.println( it1.next());
	}
	// LOGIN
	Map loginMap =  cacheMngr.getLoginBoardPmsn();
	out.println("** Login board list ");
	Iterator it2 = loginMap.keySet().iterator();
	while( it2.hasNext()) {
		out.println( it2.next());
	}
	// USER
	Map userMap = (Map)EnviewSSOManager.getUserInfoMap(request).get( SecurityMngr.KEY_BOARD_PMSN_MAP);
	// 아직 정보가 안들어 왔으면 
	if( userMap==null) {
		// 임의의 존재하는게시판의 권한을 끌어 온다. 
		String boardId = "test"; // 반드시 존재하는 게시판이어야한다. 
		BoardVO boardVO = cacheMngr.getBoard(boardId, "ko");
		SecurityMngr.getInst().getCurrentSecPmsn(boardVO, request);
		userMap = (Map)EnviewSSOManager.getUserInfoMap(request).get( SecurityMngr.KEY_BOARD_PMSN_MAP);
	}
	out.println("** User board list ");
	Iterator it3 = userMap.keySet().iterator();
	while( it3.hasNext()) {
		out.println( it3.next());
	}

%>

</pre>