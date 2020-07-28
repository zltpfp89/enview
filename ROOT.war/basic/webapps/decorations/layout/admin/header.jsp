<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../initLayoutDecorators.jsp" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
//	List topMenuList = site.getTopMenu( request, rootSite );
//	List leftMenuList = site.getSubMenu( request, rootSite , 2);
	// 무조건 관리자 메뉴가 나오도록 설정
	List topMenuList = site.getTopMenu( request, "/admin");
	List leftMenuList = site.getSubMenu( request, "/admin" , 2);
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

		
		<%-- 
		<link rel="stylesheet" type="text/css" media="screen, projection" href="${themePath}/css/styles.css" />
		<link rel="stylesheet" type="text/css" media="screen, projection" href="${cPath}/decorations/layout/css/styles.css"  />
		<link rel="stylesheet" type="text/css" media="screen, projection" href="${cPath}/admin/css/styles.css"  /> 
		--%>
		
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
		
		<!-- admin -->
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/contents.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/jquery-ui.min.css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/admin/js/main.js"></script>		
		<!-- admin// -->
		
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
<body>
	<input type="hidden" id="isAdmin" value="<c:out value="${ user.hasAdminRole || user.hasManagerRole }"/>"/>
	<!-- header -->
	<div class="header">
		<a href="/"><img src="<%=request.getContextPath()%>/admin/images/logo.png" alt="enView" /></a>
		<div class="gnb">
			<ul>
				<c:forEach items="${topMenuList}" var="menu" varStatus="status">
					<li class="<c:if test="${status.index eq 0}">first</c:if> <c:out value="${fn:indexOf(currentPagePath, menu.path ) > -1 ? 'on' : '' }" />" id="menu<c:out value="${menu.pageId}"/>">
						<a href="${cPath }/portal<c:out value="${menu.path}"/>.page" title="<c:out value="${menu.title}"/>" class="click"><c:out value="${menu.title}"/></a>
						<div class="dropmenu">
							<c:if test="${not empty menu.elements}">
								<ul class="submenu">
									<c:forEach items="${menu.elements}" var="subMenu" varStatus="status">
										<c:if test="${subMenu.hidden=='false'}">
											<li class="has-sub">
												<a href="${cPath }/portal<c:out value="${subMenu.path}"/>.page" class="click" target="${subMenu.target}"><c:out value="${subMenu.shortTitle}"/></a>
												<c:if test="${not empty subMenu.elements}">
													<span class="toggle">▼</span>
													<ul class="submenu2">
														<c:forEach items="${subMenu.elements}" var="subMenu2" varStatus="status">
															<c:if test="${subMenu2.hidden=='false'}">
																<li class="has-sub">
																	<a href="${cPath }/portal<c:out value="${subMenu2.path}"/>.page" class="click" target="${subMenu2.target}"><c:out value="${subMenu2.title}"/></a>
																	<c:if test="${not empty subMenu2.elements}">
																		<span class="toggle">▼</span>
																		<ul class="submenu3">
																			<c:forEach items="${subMenu2.elements}" var="subMenu3" varStatus="status">
																				<c:if test="${subMenu3.hidden=='false'}">
																					<a href="${cPath }/portal<c:out value="${subMenu3.path}"/>.page" class="click" target="${subMenu3.target}"><c:out value="${subMenu3.title}"/></a>
																				</c:if>
																			</c:forEach>
																		</ul>
																	</c:if>
																</li>
															</c:if>
														</c:forEach>
													</ul>
												</c:if>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</c:if>
						</div>
					</li>
				</c:forEach>
			</ul>
			<p>
				<span class="name"><%=userId%></span><%=msgs.getString("ev.info.user.Welcome")%>
				<a href="${cPath}<%=site.getLogoutUrl()%>"><span class="logout"><%=msgs.getString("ev.title.logout")%></span></a>
			</p>
		</div>
	</div>
	<!-- header //-->
	<!-- body-->
	<div id="body" >
		<div id="container">
			<!-- leftmenu -->
			<div id="leftmenu" class="open2">
				<div id="systemmenu" class="cssmenu">
					<ul>
						<c:forEach items="${leftMenuList}" var="menu" varStatus="status">
							<c:if test="${menu.hidden=='false'}">
								<li id="submenu<c:out value="${menu.menuId}"/>" class="has-sub <c:out value="${fn:indexOf(currentPagePath, menu.path ) > -1 ? 'open2' : '' }" />"><a href="<c:out value="${menu.fullUrl}"/>" class="click" target="${menu.target}"><c:out value="${menu.shortTitle}"/></a>
									<c:if test="${not empty menu.elements}">
										<ul style="<c:out value="${fn:indexOf(currentPagePath, menu.path ) > -1 ? 'display:block' : '' }" />">
											<%--currentPagePath=(${currentPagePath})<br/> metu.path=( ${menu.path}) --%> 
											<c:forEach items="${menu.elements}" var="subMenu" varStatus="status">
												<c:if test="${subMenu.hidden=='false'}">
													<li id="submenu<c:out value="${subMenu.menuId}"/>" class="${currentPagePath ==  subMenu.path ? 'open3' : '' }"><a href="${cPath }/portal<c:out value="${subMenu.path}"/>.page"  target="${subMenu.target}"><c:out value="${subMenu.shortTitle}"/></a></li>
												</c:if>
											</c:forEach>
										</ul>
									</c:if>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</div>
			<a href="#" class="btn_menu" id="root_left"><img src="<%=request.getContextPath()%>/admin/images/btn_close.png" alt="닫기" /></a> 
			<!-- leftmenu//-->
			<!-- contentsArea-->
			<div class="contentsArea">
				<!-- wrap -->
				<div class="wrap">		
					<!-- contents-->
					<div id="EnviewContentArea" class="contents">
						<!-- titleArea -->
						<div class="titleArea">
							  <span><c:out value="${currentPageTitle}" /></span>
							  <ul class="lnb">
								  <li class="home"><a href="${cPath }" title="Home" target="_self"><img src="<%=request.getContextPath()%>/admin/images/icon_home.gif" alt="home" /></a></li>
									<%-- 
									<c:forEach items="${topMenuList}" var="menu" varStatus="status">
										<li><a href="${cPath }/portal<c:out value="${menu.path }"/>.page"><c:out value="${menu.title}" /></a></li>
									</c:forEach> 
									--%>
								  <li><a href="/portal/${parentPagePath}" target="_self"><c:out value="${parentPageTitle}"/></a></li>
								  <li class="last"><c:out value="${currentPageTitle}" /></li>
							  </ul>
						  </div>
						<!-- titleArea// -->

						
<% } catch(Exception e) { 
	Log log = LogFactory.getLog(getClass());
	log.error( e, e); 
} %>