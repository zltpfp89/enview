<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.saltware.enview.security.UserInfo"%>
<%@page import="com.saltware.enview.Enview"%>
<%@page import="org.apache.commons.logging.LogFactory"%>
<%@page import="org.apache.commons.logging.Log"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.saltware.enview.portlet.service.PortletService"%>
<%@page import="com.saltware.enview.portlet.service.impl.EnviewPortletServiceFactory"%>
<%@page import="com.saltware.enview.om.page.Page"%>
<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.saltware.enview.security.spi.impl.IsMemberOfPrincipalAssociationHandler"%>
<%@page import="com.saltware.enview.security.EnviewMenu"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../initLayoutDecorators.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%
try{
	//모바일 브라우저 문자열 체크
	String browser[] = {"android","blackberry","googlebot-mobile","iemobile","iphone","ipod","opera mobile","palmos","webos"};
	String userAgent = request.getHeader("user-agent");
	String userAgent1 = userAgent.toLowerCase();
	String flag = "";

	for(int i = 0; i < browser.length; i++){
	  if(userAgent1.matches(".*"+browser[i]+".*")){
		flag = "Y";           // 모바일 브라우저
	  }
	}
	if("Y".equals(flag)){         // 모바일 브라우저일때
	// 만약 html을 사용해야한다면
		request.setAttribute("mobileYn", "Y");
	}
	
//	rootSite = "/kbig";
	request.setAttribute("topMenuList", site.getTopMenu( request, rootSite ));
	request.setAttribute("leftMenuList", site.getSubMenu( request, rootSite , 2));
	//request.setAttribute("quickMenuList", site.getQuickMenuList(request));
	//request.setAttribute("myQuickMenuList", site.getMyQuickMenuList(request));

	request.setAttribute("topLeftMenuList", site.getTopMenu( request, "/default/link/top_left" ));
	request.setAttribute("topRightMenuList",  site.getTopMenu( request, "/default/link/top_right" ));
	request.setAttribute("moreSystemMenuList", site.getTopMenu( request, "/default/link/more_system" ));
	
	request.setAttribute("isMyPage", currentPage.getPath().contains("/user/"));
	request.setAttribute("isEditPage", "/contentonly".equals( request.getServletPath()));
	
	// 현재 언어와 동일한 언어로 변경하는 메뉴 숨김 	
	request.setAttribute( "menu2hide1", "lang_" + EnviewSSOManager.getLangKnd(request));
	// 현재 모바일 여부와 동일하게변경하는 메뉴 숨김
	request.setAttribute( "menu2hide2", "mobile_" + ( EnviewSSOManager.isMobile(request) ? "t" : "f"));
	
	
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
	
	//------------------------------------------------------	
	// 게시판 상세페이지인 경우 부모페이지인 목록페이지인것처럼 속인다.
	//------------------------------------------------------	
	String currentPath = currentPage.getPath();
	if( currentPath.endsWith("/detail")) {
		currentPath = currentPath.substring( 0, currentPath.length() - "/detail".length());
	}
	request.setAttribute("currentPath", currentPath);
	//------------------------------------------------------
	
	// kbig 아래에 있는 페이지면 [제목 | KICT 빅데이터 센터] 형태로 제목을 바꾼다. 
	if( currentPath.indexOf("/kbig/") != -1) { 
		pageContext.setAttribute("PageTitle", pageContext.getAttribute("PageTitle") + " | KICT 빅데이터 센터");
	}
	
	UserInfo ui = EnviewSSOManager.getUserInfo(request);
	if( ui != null) {
		if( ui.getHasAdminRole() || ui.getHasDomainManagerRole() || ui.getHasManagerRole() || ui.getHasRole("ROLE_KBIG_MANAGER") || ui.getHasRole("ROLE_KBIG_NNF_MANAGER") || ui.getHasRole("ROLE_KBIG_CONTENTS_MANAGER")) {
			request.setAttribute("hasManagerRole", true);
		}
	}
	try{
		
		request.setAttribute("parentPageTitle",currentPage.getParent().getShortTitle(locale));
		request.setAttribute("parentParentPageTitle",currentPage.getParent().getParent().getShortTitle(locale));
		request.setAttribute("currentPageTitle",currentPage.getShortTitle(locale));
	}catch(Exception e){
		
	}
	
	
%>
<html lang="ko-KR">
	<head>
		<meta charset="UTF-8">
		<title>K-ICT 빅데이터 센터</title>
		<meta http-equiv="Content-type" content="text/html; charset=UTF-8"/>
		<!-- <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9" /> -->
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<meta http-equiv="Content-style-type" content="text/css"/>   
		<meta name="version" content="3.2.5"/>
		<meta name="keywords" content="" />
		<meta name="description" content="${PageTitle}"/>
		<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
		<link rel="shortcut icon" href="https://kbig.kr/kbig/img/favicon_0.ico" type="image/vnd.microsoft.icon" />
		<script type="text/javascript" src="${cPath}/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/jquery/ui/i18n/jquery.ui.datepicker-${langKnd}.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/jquery/jquery.blockUI.js"></script>
		
		<script type="text/javascript" src="${cPath}/javascript/message/mrbun_${langKnd}_mm.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/message/mrbun_${langKnd}_ev.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/message/mrbun_${langKnd}_eb.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/common_new.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/portal_new.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/utility.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/validator.js"></script>
		
		<script type="text/javascript" src="${cPath}/admin/javascript/portlet.js"></script>
		
		<!-- 
		<script type="text/javascript" src="${cPath}/javascript/tree/dhtmlxcommon.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/tree/dhtmlXTree.js"></script>
		 -->
		 
		<link rel="stylesheet" type="text/css" media="screen, projection" href="${cPath}/face/css/utility.css" />
		
		
		<!-- kbig 관련 소스 파일 -->
		<link rel="stylesheet" href="${cPath}/kbig/css/reset.css" />
		<link rel="stylesheet" href="${cPath}/kbig/css/nav.css" />
		<c:choose>
			<c:when test="${requestScope['enview.portal.requestPage'].pageType=='main'}">
				<link rel="stylesheet" href="${cPath}/kbig/css/main.css" />
				<script type="text/javascript" src="/kbig/js/jquery.bxslider.js"></script>
			</c:when>
			<c:otherwise>
				<link rel="stylesheet" href="${cPath}/kbig/css/sub.css" />
				<link rel="stylesheet" href="${cPath}/kbig/css/sub_layout.css" />
			</c:otherwise>
		</c:choose>
		
		
		<%-- <script type="text/javascript" src="${cPath}/kbig/js/jquery-1.9.1.js"></script> --%>
		<script type="text/javascript" src="${cPath}/kbig/js/run.js"></script>
		<script type="text/javascript" src="${cPath}/kbig/js/kbig_common.js"></script>
		
		
		<script>
		  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
	
		  ga('create', 'UA-85177524-1', 'auto');
		  ga('send', 'pageview');
	
		</script>
		<script type="text/javascript">
			function iframe_autoresize(arg) {
				if( arg==null) {
					autoresize_iframe_portlets();
					return;
				}
				try {
					var ht = arg.contentWindow.document.documentElement.scrollHeight;
					arg.height = 0;
					arg.height = ht;
					window.scrollTo(0,0);					
				} catch(e) {
					
				}
			}
			
			function autoresize_iframe_portlets() {
				var iframes = document.getElementsByTagName("iframe");
				for( var i =0; i < iframes.length;i++ ) {
					if( iframes[i].name.indexOf("IframePortlet")==0) {
						iframe_autoresize( iframes[i])
					}
				}
			}			
			
			function getTickerMessage() {
				return tickerMessage;
			}
			
			function changeUser(obj) {
				var userId = obj.options[obj.selectedIndex].value;
				location.href = "${cPath}/login/changeuser?username=" + userId;
			}

			function getCookie(name) { 
				   var cookieName = name + "=";
				   var x = 0;
				   while ( x <= document.cookie.length ) { 
				      var y = (x+cookieName.length); 
				      if ( document.cookie.substring( x, y ) == cookieName) { 
				         if ((lastChrCookie=document.cookie.indexOf(";", y)) == -1) 
				            lastChrCookie = document.cookie.length;
				         return decodeURI(document.cookie.substring(y, lastChrCookie));
				      }
				      x = document.cookie.indexOf(" ", x ) + 1; 
				      if ( x == 0 )
				         break; 
			       } 
				   return "";
			}			
			
			function isMobile(){

				var UserAgent = navigator.userAgent;



				if (UserAgent.match(/iPhone|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null || UserAgent.match(/LG|SAMSUNG|Samsung/) != null)

				{

					return true;

				}else{

					return false;

				}

			}

			function initEnview() {
				<%=initEnviewScript%>
//				initNavigation("<%=userId%>", "<%=pageIds%>");
				//quickMenuInitialize("Enview.Portal.Quickmenu", 1200,300);
				
				<%-- 로그인 시 비밀번호 초기화하도록 modal창 띄우기 --%>
		        var pwdChgReqMsg = "<c:out value="${pwdChgReq}"/>";
		        
		        if( pwdChgReqMsg != "null" && pwdChgReqMsg.length > 0 ) {
		            $.blockUI({ 
		                message:"<iframe src='<%=request.getContextPath()%>/statics/password/passwordChange.jsp' frameborder='0' scrolling='no' style='width:1280px;height:410px;'>"
		               ,css:{width:'1280px', height:'410px', top:($(window).height()-499) /2 + 'px', left:($(window).width()-1280) /2 + 'px'}
		           });
		       }	
				if( '<%=request. getRequestURI()%>' == '/portal/kbig' ||  '<%=request. getRequestURI()%>' == '/portal/') {
					//alert('popup');
					jQuery(function($){


						var agent = navigator.userAgent.toLowerCase();
						if (agent.indexOf("chrome") != -1) {
//						window.open("/popup/popup01.php",'service_pop','resizeable=no, width=500, height=682, menubar=no, status=no, toolbar=no');
						}
						else {
//						window.open("/popup/popup01.php",'service_pop','resizeable=no, width=500, height=682, menubar=no, status=no, toolbar=no');
						}

						var agent = navigator.userAgent.toLowerCase();
						if (agent.indexOf("chrome") != -1) {
//						window.open("/popup/popup_kbig.php",'service_pop','resizeable=no, width=500, height=532, menubar=no, status=no, toolbar=no');
						}
						else {
//						window.open("/popup/popup_kbig.php",'service_pop','resizeable=no, width=500, height=532, menubar=no, status=no, toolbar=no');
						}

			/* 현장기술 자문 서비스 
						if (agent.indexOf("chrome") != -1) {
							window.open("/popup/popup02.php",'pop01','resizeable=no, width=500, height=682, menubar=no, status=no, toolbar=no, top=0, left=0');
						}
						else {
							window.open("/popup/popup02.php",'pop01','resizeable=no, width=500, height=682, menubar=no, status=no, toolbar=no, top=0, left=0');
						}
			*/
						
						var left2,top2;
						//top1=(screen.height-300)/2;
						var agent = navigator.userAgent.toLowerCase();
						
						
						if(isMobile()){
							//모바일일때, 팝업창 띄우는 작업 하지 않음
						}else{
							//PC일때, 팝업창 띄워줌
							/*
							//해당 팝업창의 쿠키 가져와서 값 확인
							var result = getCookie("POP20180329");
							
							if(result == "end"){
							}else{
								if (agent.indexOf("chrome") != -1) {
									window.open("/kbig/contents/popup/popup19.jsp",'POP20180329','top=0,left=0, scrollbars=no, resizeable=no, width=440, height=440, menubar=no, status=no, toolbar=no');
								}
								else {
									window.open("/kbig/contents/popup/popup19.jsp",'POP20180329','top=0,left=0, scrollbars=no, resizeable=no, width=440, height=440, menubar=no, status=no, toolbar=no');
								}
							}
							*/
						}						
						
						/*
						var left3,top3;
						//top1=(screen.height-300)/2;
						var agent = navigator.userAgent.toLowerCase();
						if (agent.indexOf("chrome") != -1) {
							window.open("/kbig/contents/popup/popup18.jsp",'POP20180328','top=0, left=0, scrollbars=no, resizeable=no, width=440, height=440, menubar=no, status=no, toolbar=no');
						}
						else {
							window.open("/kbig/contents/popup/popup18.jsp",'POP20180328','top=0, left=0, scrollbars=no, resizeable=no, width=440, height=440, menubar=no, status=no, toolbar=no');
						}
						*/
			/*
			if($_SERVER['REQUEST_URI'] == '/') {
				require_once($_SERVER['DOCUMENT_ROOT'] . "/popup/open_pop.php");
			}
						$("#menu_social").removeAttr("target");

						$("#menu_social").on("click",function(){
							window.open("/popup/custompopup.php",'menu_social_pop','resizeable=no, width=420, height=337, menubar=no, status=no, toolbar=no');
						});
			*/
			/*
						$("#menu_infra").attr("href", "#none");
						$("#menu_infra").removeAttr("target");

						$("#menu_infra").on("click",function(){
							window.open("/popup/infrapopup.php",'menu_infra_pop','resizeable=no, width=420, height=337, menubar=no, status=no, toolbar=no');
						});
			*/
						$(".menu_infra").attr("href", "#none");
						$(".menu_infra").on("click",function(){
							window.open("/kbig/contents/popup/infrapopup.jsp",'menu_infra_pop','resizeable=no, width=420, height=337, menubar=no, status=no, toolbar=no');
						});
					}(jQuery));

				

				}				        
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

			function fn_childIframeAutoresize(arg,childHeight) 
			{
				/*
				try 
				{
					$(arg).height(childHeight);
					$(arg).css({"height":childHeight});
				} 
				catch(e) 
				{ }
				*/
				autoresize_iframe_portlets();
			}
			
			function fn_scrollTop()
			{ 
				window.scrollTo(0,0);
			}
			
			function fn_dataset_H(size){
				var dd = $("#IframePortlet_8705").height()
				$('#IframePortlet_8705').attr('height', '800px');
			}
			
			function fn_dataset_resize_H(size){
				var dd = $("#IframePortlet_8705").height()
				$('#IframePortlet_8705').attr('height', dd + size);
			}
			
			// 게시판 리사이즈 처리..
			function fn_dataset_resize_Id(id, size){
				$('#'+id).attr('height', size);
			}
		</script>
	</head>
<body>
	<div class="wrap">
		<div class="header">
			<div class="header_inner">
				<h1><a href="${cPath }/portal/kbig" title="K-ICT 빅데이터센터">K-ICT 빅데이터센터</a></h1>
				<button class="btn_menu">메뉴</button>
				<div class="m_gnb">
					<div class="tnb_wrap">
						<ul>
							<!-- 로그아웃 상태 -->
							<c:if test="${_enview_info_.userId eq null}">
							  <li class="btn_login"><a href="${cPath}/portal/kbig/user/login">로그인</a></li>
							  <li class="btn_join"><a href="${cPath}/portal/kbig/user/regist">회원가입</a></li>
							  <li class="btn_sitemap"><a href="${cPath}/portal/kbig/sitemap">사이트맵</a></li>
							  <li class="btn_search"><a href="#">검색</a></li>
							</c:if>
							<!-- 로그인 상태 -->
							<c:if test="${_enview_info_.userId ne null}">
								<li class="btn_logout"><a href="${cPath}/user/logout.face">로그아웃</a></li>
							    <li class="btn_join"><a href="${cPath}/portal/kbig/user/edit">회원정보수정</a></li>
								<li class="btn_mypage"><a href="${cPath}/portal/kbig/my">마이페이지</a></li>
							  	<c:if test="${hasManagerRole}">
								<li class="btn_admin"><a href="${cPath}/portal/admin">관리페이지</a></li>
							  	</c:if>
								<li class="btn_sitemap"><a href="${cPath}/portal/kbig/sitemap">사이트맵</a></li>
								<li class="btn_search"><a href="#">검색</a></li>
							</c:if>
						</ul>
						<form action="/portal/kbig/search" method="post">
						<div class="all_search">
								<label for="all_search" class="label_none">검색</label>
								<input type="text" id="all_search" name="allSearchValue"/>
								<button class="all_search_btn">검색</button>
								<a href="#" class="all_search_close">검색닫기</a>
						</div>
						</form>
					</div> <!-- //tnb_wrap -->
					<div class="gnb_wrap">
						<ul class="gnb">
							<c:set var="subTitleLeftMenu" value=""/>
							<c:forEach items="${topMenuList}" var="menu" varStatus="status">
								<c:if test="${fn:contains( currentPagePath, menu.path)}">
									<c:set var="subTitleLeftMenu" value="${menu.shortTitle}"/>
								</c:if>
								<c:if test="${menu.hidden == false or menu.path == '/kbig/my'}"> 
									<c:if test="${ menu.name != menu2hide1 && menu.name != menu2hide2}">
										<li class="${menu.name} dep_01 ${menu.path == '/kbig/my' ? 'pc_none' : ''}"><a class="dep1_title" href="<c:out value="${menu.fullUrl}"/>" target='<c:out value="${menu.target}"/>'><c:out value="${menu.shortTitle}"/></a>
											<c:if test="${not empty menu.elements}">
												<ul class="dep_02">
													<c:forEach items="${menu.elements}" var="subMenu" varStatus="status">
														<c:if test="${subMenu.hidden=='false'}">
															<li><a class="<c:if test="${not empty subMenu.elements}">dep2_txt dep2_have_top</c:if> ${subMenu.target=='_blank' ? 'open' : '' }" href="<c:out value="${subMenu.fullUrl}"/>"  target="${subMenu.target}"><c:out value="${subMenu.shortTitle}"/> </a>
																<ul class="gnb_3dep">
																	<c:forEach items="${subMenu.elements}" var="subSubMenu" varStatus="status">
																		<c:if test="${subSubMenu.hidden=='false'}">
																			<c:if test="${mobileYn eq 'Y' }">
																				<c:if test="${subSubMenu.deviceType eq 'M' or subSubMenu.deviceType eq null }">
																					<li><a href="<c:out value="${subSubMenu.quick and empty _enview_info_ ? '/portal/kbig/user/login?destination=' : ''}"/><c:out value="${subSubMenu.fullUrl}"/>"  target="${subSubMenu.target}"><c:out value="${subSubMenu.shortTitle}"/></a></li>
																				</c:if>
																			</c:if>
																		</c:if>
																	</c:forEach>
																</ul>
															</li>
														</c:if>
													</c:forEach>
												</ul>
											</c:if>
										</li>
									</c:if>
								</c:if>
							</c:forEach>
							<c:if test="${topMenuList eq '[]'}">
								<li class="dep_01">
									<a href="#" class="dep1_title"></a>
								</li>
							</c:if>
						</ul>
					</div><!-- //gnb_wrap -->
				</div> <!-- //m_gnb -->
			</div> <!-- //header_inner -->
			<div class="gnb_bg">				
				<div class="drop_inner">
					<c:set var="count" value="0"/>
					<c:forEach items="${topMenuList}" var="menu" varStatus="status">
						<c:if test="${menu.hidden=='false'}">
							<c:if test="${!menu.hidden && menu.name != menu2hide1 && menu.name != menu2hide2}">
								<c:set var="count" value="${count +1}"/>
								<ul class="txt_wrap txt_0${count}">
									<span class="tit"><c:out value="${menu.shortTitle}"/></span>
									<span class="con"><c:out value="${menu.title}"/></span>
								</ul>
							</c:if>
						</c:if>
					</c:forEach>
				</div> <!-- //drop_inner -->			
			</div><!--  //gnb_bg -->
		</div> <!-- //header -->
		<c:choose>
		<c:when test="${requestScope['enview.portal.requestPage'].pageType=='main'}">
			<%-- 메인. 모든 영역을 사용한다 --%>
			<div class="sub_container" id="EnviewContentArea">
				<c:if test="${currentPath  eq '/kbig' }">
				<jsp:include page="./main.jsp" />
				</c:if>
		</c:when>
		<c:otherwise>
			<%-- 서브/서브2. 너비의 최대가 1080px로 제한된다. --%>
			<div class="sub_container">
			<c:if test="${requestScope['enview.portal.requestPage'].pageType=='sub'}">
			<div class="lnb">
				<div class="lnb_tit_wrap">
					<p class="lnb_tit">${subTitleLeftMenu}</p>
				</div>
			<div class="lnb_wrap">
				<ul class="lnb_dep1">
					<c:forEach items="${leftMenuList}" var="menu" varStatus="status">
						<c:if test="${menu.hidden=='false'}">
							<c:set var="menuClass" value=""/>
							<c:set var="midPath" value="${menu.path}/"/>
							<c:choose>
							<c:when test="${currentPath eq menu.path or fn:contains( currentPath, midPath)}">
								<c:set var="menuClass" value="on"/>
								<c:set var="menuStyle" value="style='display: block;'"/>
								<c:if test="${not empty menu.elements}">
									<c:set var="menuClass" value="on"/>
									<c:set var="menuStyle" value="style='display: block;'"/>
								</c:if>
							</c:when>
							<c:otherwise>
								<c:if test="${not empty menu.elements}">
								<c:set var="menuClass" value=""/>
								<c:set var="menuStyle" value="style='display: none;'"/>
								</c:if>
							</c:otherwise>
							</c:choose>
							<li><a href="<c:out value="${menu.fullUrl}"/>" class="dep1_title<c:if test="${not empty menu.elements}"> dep2_have</c:if> ${menuClass} ${menu.target=='_blank' ? 'open' : '' }" target="${menu.target}" onclick="javascript:void(0);"> <c:out value="${menu.shortTitle}"/></a>
								<c:if test="${not empty menu.elements}">
									<ul class="lnb_2dep" ${menuStyle }>
									<c:forEach items="${menu.elements}" var="subMenu" varStatus="status">
										<c:if test="${subMenu.hidden=='false'}">
											<li ${fn:contains( currentPagePath, subMenu.path) ? "class='on'" : ""}><a href="<c:out value="${subMenu.quick and empty _enview_info_ ? '/portal/kbig/user/login?destination=' : ''}"/><c:out value="${subMenu.fullUrl}"/>"   target="${subMenu.target}">&nbsp;<c:out value="${subMenu.shortTitle}"/></a></li>
										</c:if>
									</c:forEach>
									</ul>
								</c:if>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</div> <!-- //lnb -->
		</c:if>
		<%-- 서브의 경우 너비를 LNB를 뺀 값으로 설정 --%>
		<div class="${requestScope['enview.portal.requestPage'].pageType=='sub' ? "content" : "content2"}">
			<div class="con_top">
				<h2><c:out value="${currentPageTitle}"/></h2>
				<div class="bread_crumb">
					<ul class="cf">
						<li class="home"><a href="/">HOME</a></li>
						<c:if test="${parentParentPageTitle != 'KBIG' && parentParentPageTitle != '홈'}">
							<li><c:out value="${parentParentPageTitle}"/></li>
						</c:if>
						<c:if test="${parentPageTitle != 'KBIG' && parentPageTitle != '홈'}">
							<li><c:out value="${parentPageTitle}"/></li>
						</c:if>
						<li class="last"><c:out value="${currentPageTitle}"/></li>
					</ul>
				</div> <!-- //bread_crumb -->
			</div> <!-- //con_top -->
			<div class="con_atricle" id="EnviewContentArea">
			<c:if test="${currentPath  eq '/kbig/sitemap' }">
				<jsp:include page="./sitemap.jsp" />
			</c:if>
		</c:otherwise>
		</c:choose>
		</div>
			
<% } catch(Exception e) {
	Log log = LogFactory.getLog(getClass());
	log.error( e, e);
} %>

			
			