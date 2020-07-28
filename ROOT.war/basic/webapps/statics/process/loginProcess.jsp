<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<!--%@ taglib prefix="util" uri="/tld/utility.tld" %-->

<%@ page import="java.net.InetAddress" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%@ page import="org.apache.commons.logging.Log" %>
<%@ page import="org.apache.commons.logging.LogFactory" %>
<%@ page import="org.springframework.validation.BindException" %>
<%@ page import="org.springframework.validation.Errors" %>
<%@ page import="org.springframework.web.servlet.ModelAndView" %>
<%@ page import="org.springframework.web.servlet.mvc.SimpleFormController" %>
<%@ page import="org.springframework.web.servlet.mvc.multiaction.MultiActionController" %>

<%@ page import="com.saltware.enface.user.control.SiteUserManager" %>
<%@ page import="com.saltware.enface.user.dao.UserException" %>
<%@ page import="com.saltware.enface.user.model.UserVo" %>
<%@ page import="com.saltware.enview.Enview" %>
<%@ page import="com.saltware.enview.code.EnviewCodeManager" %>
<%@ page import="com.saltware.enview.codebase.CodeBundle" %>
<%@ page import="com.saltware.enview.login.LoginConstants" %>
<%@ page import="com.saltware.enview.multiresource.EnviewMultiResourceManager" %>
<%@ page import="com.saltware.enview.multiresource.MultiResourceBundle" %>
<%@ page import="com.saltware.enview.session.SessionManager" %>
<%@ page import="com.saltware.enview.util.EnviewLocale" %>
<%@ page import="com.saltware.enview.util.HttpUtil" %>

<%
	SessionManager enviewSessionManager = (SessionManager)Enview.getComponentManager().getComponent("com.saltware.enview.session.SessionManager");
	SiteUserManager siteUserManager = (SiteUserManager)Enview.getComponentManager().getComponent("com.saltware.enface.user.control.UserManager");
	
	//HttpSession session = request.getSession(true);
	
	Map userInfoMap = new HashMap();
	MultiResourceBundle enviewMessages = null;
	String userId = request.getParameter("userId");
	String encorderPassword = request.getParameter("password");
	String langKnd = request.getParameter("langKnd");
	String password = null;
	String destination = null;
	String current = null;
	
	try {
		if (encorderPassword != null) {
			boolean enableInterEncryption = Enview.getConfiguration().getBoolean("sso.interEncryption", true);
			if( enableInterEncryption ) {
				byte[] value = encorderPassword.getBytes();
				for (int i=0; i<value.length; i++) {
					value[i] = (byte)(value[i] + ((i+2) % 7));
				}
				password = new String(value);
			}
			else {
				password = encorderPassword;
			}
		}
		
		System.out.println("##################### userId=" + userId + ", encorderPassword=" + encorderPassword + ", password=" + password + ", langKnd=" + langKnd);
		
		if( langKnd == null ) {
			langKnd = EnviewLocale.getLocale(request, enviewSessionManager);
		}
		enviewMessages = EnviewMultiResourceManager.getInstance().getBundle( langKnd );
	
		userInfoMap.put("remote_address", InetAddress.getByName(request.getRemoteAddr()).getHostAddress());
		userInfoMap.put("user-agent", HttpUtil.getUserAgent(request));
		
		siteUserManager.login(userInfoMap, userId, password);
		
		session.removeAttribute(LoginConstants.ERRORCODE);
		session.setAttribute(LoginConstants.SSO_LOGIN_ID, userId);

		if( langKnd != null ) {
			userInfoMap.put("lang_knd", langKnd);
		}
		
		userInfoMap.put("remote_address", InetAddress.getByName(request.getRemoteAddr()).getHostAddress());
		userInfoMap.put("user-agent", HttpUtil.getUserAgent(request));
		
		userInfoMap.put("extraUserInfo01", "TEST_PART01");
		userInfoMap.put("extraUserInfo02", "TEST_PART02");
		userInfoMap.put("extraUserInfo03", "TEST_PART03");
		System.out.println("##################### before EnviewLoginController sessionId=" + session.getId());
		System.out.println("##################### before EnviewLoginController userInfoMap=" + userInfoMap);
		
		enviewSessionManager.setUserData(request, userInfoMap);
		
		System.out.println("##################### after EnviewLoginController userInfoMap=" + enviewSessionManager.getUserData(session.getId()));

		if (destination == null) {
			if( current != null && current.length() > 0) {
				if( current.indexOf("?") > -1 ) {
					destination = current.substring(0, current.indexOf("?"));
				}
				else {
					destination = current;
				}
			}
			else {
				destination = "/";
				/*
				if( userInfoMap != null ) {
					String defaultPage = (String)userInfoMap.get("default_page");
					if( defaultPage != null ) {
						destination = "/portal" + defaultPage + ".page";
					}
					else {
						destination = "";
					}
				}
				*/
			}
		}
		
		Cookie tmp = new Cookie("EnviewSessionID", session.getId());
		tmp.setPath("/");
		//tmp.setDomain( "." + Enview.getConfiguration().getString("portal.domain", "enview") );
		tmp.setMaxAge( -1 );
		response.addCookie( tmp );
	
		response.sendRedirect("/enview");
	}
	catch(UserException se) 
	{
		String msgKey = se.getMessageKey();
		if( msgKey != null ) {
			String errorMessage = enviewMessages.getString( msgKey );
			request.setAttribute("errorMessage", errorMessage);
			System.out.println("##################### errorMessage=" + errorMessage);
		}
		
		response.sendRedirect("/enview/statics/process/login.jsp");
	}
%> 