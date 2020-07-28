<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../initLayoutDecorators.jsp" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
//	List topMenuList = site.getTopMenu( request, rootSite );
//	List leftMenuList = site.getSubMenu( request, rootSite , 2);
	// 무조건 관리자 메뉴가 나오도록 설정
	List topMenuList = site.getTopMenu( request, "/demo");
	List leftMenuList = site.getSubMenu( request, "/demo" , 2);
	List quickMenuList = site.getQuickMenuList(request);
	List myQuickMenuList = site.getMyQuickMenuList(request);
	
	request.setAttribute("topMenuList", topMenuList);
	request.setAttribute("leftMenuList", leftMenuList);
	request.setAttribute("quickMenuList", quickMenuList);
	request.setAttribute("myQuickMenuList", myQuickMenuList);
	
	request.setAttribute("isMyPage", currentPage.getPath().contains("/user/"));
	request.setAttribute("isEditPage", "/contentonly".equals( request.getServletPath()));

	
	String theme = request.getParameter("theme");
	if( theme == null || theme.length() == 0 ) theme = "";
	
	String pageIds = site.getCurrentPageIds(request, 2);
	String breadcrumbs = includeLinksNavigation( site.getNavigation(request, "/admin"), langKnd );
	String subtitle = "";

	if( currentPage.getParent() != null ) 
	{
		subtitle = currentPage.getParent().getShortTitle(locale);
	}
	else 
	{
		subtitle = currentPage.getShortTitle(locale);
	}
	int tabordercnt = 0;   
	
	

	
	//System.out.println("#### editing=" + editing + ", noticeList=" + noticeList + ", currentPath=" + currentPath + ", groups=" + groups + ", titleicon=" + titleicon);
	try{
%>
<html>
	<head>
		<title>${PageTitle} </title>	
		<meta http-equiv="Content-type" content="text/html; charset=UTF-8"/>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9" />
		<meta http-equiv="Content-style-type" content="text/css"/>   
		<meta name="version" content="3.2.5"/>
		<meta name="keywords" content="" />
		<meta name="description" content="${PageTitle}"/>

		<link rel="stylesheet" type="text/css" media="screen, projection" href="${themePath}/css/styles.css" />
		<link rel="stylesheet" type="text/css" media="screen, projection" href="${cPath}/decorations/layout/css/styles.css"  />
		<link rel="stylesheet" type="text/css" media="screen, projection" href="${cPath}/admin/css/styles.css"  />
		<link rel="stylesheet" type="text/css" href="${cPath}/decorations/layout/css/jquery/base/jquery.ui.all.css" />
		<link rel="stylesheet" type="text/css" href="${cPath}/dhtmlx/dhtmlx.css" />		
				
		<script type="text/javascript" src="${cPath}/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/jquery/ui/i18n/jquery.ui.datepicker-${langKnd}.js"></script>
		
		<script type="text/javascript" src="${cPath}/javascript/message/mrbun_${langKnd}_mm.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/message/mrbun_${langKnd}_ev.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/message/mrbun_${langKnd}_eb.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/common_new.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/portal_new.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/utility.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/validator.js"></script>
		<script type="text/javascript" src="${themePath}/script/text_menu.js"></script>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/dhtmlx/dhtmlx.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/dhtmlx/thirdparty/excanvas/excanvas.js"></script>
		
		<script type="text/javascript" src="${cPath}/admin/javascript/portlet.js"></script>
		
		<script type="text/javascript">
			function iframe_autoresize(arg) {
				try {
					var ht = arg.contentWindow.document.documentElement.scrollHeight;
					arg.height = 0;
					arg.height = ht;
				} catch(e) {
					
				}
			}
			
			function getTickerMessage() {
				return tickerMessage;
			}
			
			function changeUser(obj) {
				var userId = obj.options[obj.selectedIndex].value;
				location.href = "${cPath}/login/changeuser?username=" + userId;
			}
			
			function initEnview() {
				<%=initEnviewScript%>
				initNavigation("<%=userId%>", "<%=pageIds%>");
				//quickMenuInitialize("Enview.Portal.Quickmenu", 1200,300);
			}	
			
			function getAction()
			{
				return 
			}
			
			function resize()
			{
				var menu = document.getElementById("Enview.LeftMenu");
				menu.style.display = "none";
			}
			
			function print(arg) {
				eval(arg.name).focus();
				eval(arg.name).print();
			}
			
			function checkModified() {
				portalPage.checkModified();
			}
			
			// Attach to the onload event
			if (window.attachEvent)
			{
				//window.attachEvent ( "onload", initEnview );
				window.attachEvent ( "onunload", checkModified );
			}
			else if (window.addEventListener )
			{
				//window.addEventListener ( "load", initEnview, false );
				window.addEventListener ( "unload", checkModified, false );
			}
			else
			{
				//window.onload = initEnview;
				window.onunload = checkModified;
			}
		</script>
	</head>
	<body marginwidth="0" marginheight="0" class="<%=_layoutDecoration.getBaseCSSClass()%>">
		<input type="hidden" id="isAdmin" value="<c:out value="${ user.hasAdminRole || user.hasManagerRole }"/>"/>
		<div id="Enview.Portal.IconArea" align="right" class="webpanel" style="display:none;"><%=pageActionBar%></div>
		<table width="100%" height="70" border="0" cellspacing="0" cellpadding="0" background="${themePath}/images/title01_bg.gif">
			<tr> 
				<td><a href="${cPath}/"><img src="${themePath}/images/logo.png" width="180" height="52"/></a></td>
				<td align="right"><img src="${themePath}/images/title01.gif" height="70"/></td>
			</tr>
		</table>
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" >
			<tr>
				<td id="leftmenu" width="180px" valign="top" class="leftmenu_bg"> 
					<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" background="${themePath}/images/leftmenu_bg_s.jpg">
						<tr>
							<td height="65" background="${themePath}/images/login_bg1.jpg" align="center"> 
								<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
									<tr> 
										<td align="center" height="32"><img src="${themePath}/images/icon_man.png" width="18" height="17" align="absmiddle"/> 
											<font color="#ffffff" style="font-family: Verdana, Geneva, Arial, Helvetica, sans-serif; FONT-SIZE: 8pt; "><b><%=userId%></b> <%=msgs.getString("ev.info.user.Welcome")%></font></td>
									</tr>
									<tr> 
										<td align="center" height="32" style="padding-right: 13px;">
											<span class="btn_pack small"><a href="<%=userDir%>"><%=msgs.getString("ev.title.myPage")%></a></span>
											<!--span class="btn_pack small"><a href="<%=groupDir%>"><%=msgs.getString("ev.title.groupPage")%></a></span-->
											<span class="btn_pack small"><a href="${cPath}<%=site.getLogoutUrl()%>"><%=msgs.getString("ev.title.logout")%></a></span>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>  
							<td id="Enview.LeftMenu" valign="top" width="180" >   
								<!-- left menu start -->
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
									<tr> 
										<td width="180" valign="top" class="leftmenu_bg">
											<table width="180" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="45" class="pageTitle"><%=subtitle%></td>
												</tr>
												<tr>
													<td valign="top" class="leftmenu_bg_s">
														<!-- Left menu  start -->
														<div>
															<ul id="submenu">
															<c:forEach items="${leftMenuList}" var="menu" varStatus="status"><c:if test="${menu.hidden=='false'}">
																<li id="submenu<c:out value="${menu.menuId}"/>" ><a href="<c:out value="${menu.fullUrl}"/>" target="${menu.target}"><img src="${themePath}/images/left_icon.gif" align="absmiddle" title="Up" align="absmiddle" border="1">&nbsp;<c:out value="${menu.shortTitle}"/></a>
																<c:if test="${not empty menu.elements}">
																	<ul>
																	<c:forEach items="${menu.elements}" var="subMenu" varStatus="status"><c:if test="${subMenu.hidden=='false'}">
																		<li id="submenu<c:out value="${subMenu.menuId}"/>" class="thirdmenu"><a href="<c:out value="${subMenu.fullUrl}"/>"  target="${subMenu.target}">&nbsp;<c:out value="${subMenu.shortTitle}"/></a></li>
																	</c:if></c:forEach>
																	</ul>
																</c:if>
																</li>
															</c:if></c:forEach>
															</ul>
														</div>
														<!--Left menu  end -->
													</td>
												</tr>
												<tr>
													<td>
														<!-- Page Componenet Layer
														<div style="padding:1px; border:0 solid black"><c:out value="${region_01}" escapeXml="false"/></div> <br>
														<div style="padding:1px; border:0 solid black"><c:out value="${region_02}" escapeXml="false"/></div> <br>
														<div style="padding:0px; border:0 solid black"><c:out value="${region_03}" escapeXml="false"/></div> <br>
														<div style="padding:1px; border:0 solid black"><c:out value="${region_04}" escapeXml="false"/></div>
														-->
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<!-- leftmenu end -->
					</table>
				</td>
				<td valign="top"> 
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
<!-- top menu start-->  
							<td height="65">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%"  background="${themePath}/images/menu_bg_center.jpg" >
									<tr height="50%" >
										<td align="right" style="FONT-FAMILY: Gulim; FONT-SIZE: 9pt; FONT-COLOR: #999999" width="100%" valign="bottom" colspan="2">
<!--Top menu  start -->
										<div style="width:100%;">
										<ul id="topmenu" class="topmenu" >
											<c:forEach items="${topMenuList}" var="menu" varStatus="status">
												<li id="menu<c:out value="${menu.menuId}"/>"  class="menu${status.index}" ><a href="<c:out value="${menu.fullUrl}"/>" ><c:out value="${menu.shortTitle}"/></a>
												<c:if test="${not empty menu.elements}">
													<ul>
													<c:forEach items="${menu.elements}" var="subMenu" varStatus="status">
														<li id="menu<c:out value="${subMenu.menuId}"/>"><a href="<c:out value="${subMenu.fullUrl}"/>"><c:out value="${subMenu.shortTitle}"/></a></li>
													</c:forEach>
													</ul>
												</c:if>
												</li>
											</c:forEach>
											</ul>
											<span style="position:relative; top:2px">
												<a href="#" title="toggle left menu" onclick="javascript:toggle_leftmenu()">
													&nbsp;
												</a>
												<a href="#" title="about enview..." onclick="javascript:help()">
													<img src="${themePath}/images/question.png" width="25" height="25" align="absmiddle" />
												</a>
											</span>
										</div>
<!--Top menu  end -->
							</td>
						</tr>		 
					</table>
				</td>
			</tr>
			<tr>
				<td id="EnviewContentArea" valign="top">
						
<% } catch(Exception e) { 
	Log log = LogFactory.getLog(getClass());
	log.error( e, e); 
} %>