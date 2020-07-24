<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.saltware.enview.request.RequestContext"%>
<html>
	<head>
		<title>로딩중입니다... - enCafe</title>
		<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9" />
		<meta name="version" content="3.2.4" />
		<meta name="keywords" content="" />

		<link type="text/css" href="<%=request.getContextPath()%>/decorations/layout/css/jquery/base/jquery.ui.all.css" rel="stylesheet" />
		<%
			if((request.getParameter("isEditMode") == null ? "false" : request.getParameter("isEditMode")).equals("true")){
		%>
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/css/editor/ggum_home.css" />
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/css/editor/ggum_default.css" />
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/css/editor/ggum_d2w.css" />
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/css/editor/ggum.css" />
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/css/editor/color_picker.css" />
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/css/editor/border_picker.css" />
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/css/editor/icon_picker.css" />
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/css/editor/align_picker.css" />
		
		<%	
			}
		%>
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/css/each/<c:out value="${skin}"/>.css" />

		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/ui/i18n/jquery.ui.datepicker-ko.js"></script>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_ko_mm.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_ko_ev.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_ko_cf.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_util.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/calendar/calendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/calendar/ko-kr/generatecalendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_list.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_read.js"></script>
		<%--
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_edit_cafe.js"></script>
		 --%>
		<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/home/encafe.js"></script> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/each/encafe.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/crossdomain.js"></script>
		<%
			if((request.getParameter("isEditMode") == null ? "false" : request.getParameter("isEditMode")).equals("true")){
		%>
		<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/editor/ggum.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/editor/editor.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/fckeditor/fckeditor.js"></script>
		<%	
			}
		%>
		<script type="text/javascript">
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
			<%--BEGIN::ENCOLA--%>
			<%
				String pagePath = ((RequestContext) request.getAttribute("com.saltware.enview.request.RequestContext")).getPath();
				String cafeUrl = pagePath.substring(pagePath.lastIndexOf("/") + 1, pagePath.lastIndexOf("."));
			%>
			
			//cfEach.m_skin = '<c:out value="${skin}"/>';
			cfEach.m_curCafeUrl = "<%=cafeUrl%>";
			<c:if test="${ mmbrVO.isLogin && ( mmbrVO.isStaff || mmbrVO.isSysop || mmbrVO.isAdmin)}">
			cfEach.m_isEditMode = <%=request.getParameter("isEditMode") == null ? false : request.getParameter("isEditMode")%>;
			cfEach.m_isMobile = <%=request.getAttribute("isMobile")%>;
			</c:if>
			<%--END::ENCOLA--%>
		</script>
	</head>
	<body marginwidth="0" marginheight="0" class="CF0802_bgImage CF0802_bgColor CF0802_bgImgPos CF0802_bgImgRepeat">
		<!--
		<div id="edit_menu_bar" class="edit_menu_bar edit_hidden">
			<div id="encafelogo" class="encafelogo">
				<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/adminLogo.gif" onclick="cfInfo.go2Jigi();" alt="카페관리" title="클릭하시면 카페관리화면으로 이동합니다."/>
				<span class="name" onclick="javascript:cfEach.go2EachHome();" title="클릭하시면 꾸미기를 종료합니다"><c:out value="${cmntVO.cmntNm}"/></span>
			</div>
		</div>
	-->
		<div id="cafe_main" class="cafe_main">
			<div id="main_navigation" class="main_navigation">

				<!--
				<div class="navi_menus">
					<div class="navi_menu" onclick="javascript:cfEach.go2Enview();">enView</div>
					<div class="navi_seperater">|</div>
					<div class="navi_menu" onclick="javascript:cfEach.go2Home('');"><util:message key="cf.title.cafeHome"/></div>
					<div class="navi_seperater">|</div>
					<div class="navi_menu">
						<div class="navi_menu" id="favorLink" onclick="javascript:cfEach.showFavorCafe()"><util:message key="ev.title.favor.cafe"/></div>
						<div id="favorCafeDiv" class="favorCafeDiv CF0802_bgColor CF0802_extraBrdrColor">
							<ul class="favorCafeList" id="favorCafeList"></ul>
							<ul class="favorCafeList_sep"></ul>
							<ul class="favorCafeList">
								<li class="favorCafeControl" onclick="javascript:cfEach.go2Home('mine.favor')">- <util:message key="ev.title.favor.cafe"/></li>
								<li class="favorCafeControl" onclick="javascript:cfEach.go2Home('mine.favorEdit')">- <util:message key="ev.title.edit"/></li>
							</ul>
							<form id="title_form" name="title_form" style="display:inline" method="POST" action="<%=request.getContextPath()%>/cafe" target="_top">
								<input type="hidden" id="initView" name="initView"/>
							</form>
						</div>
					</div>
					<div class="navi_menu navi_button favor_button" onclick="javascript:cfEach.showFavorCafe()">▼</div>
					
						<div class="navi_seperater">|</div>
						<div class="navi_menu" onclick="javascript:cfEach.go2BlogHome();">블로그</div>
						<div class="navi_seperater">|</div>
						<div class="navi_menu" onclick="javascript:cfEach.go2Mail();">메일</div>
						<div class="navi_seperater">|</div>
						<div class="navi_menu" onclick="javascript:cfEach.go2Note();">쪽지</div>

					<c:if test="${mmbrVO.isLogin }" var="isLogin">
						<div class="navi_menu navi_button" onclick="javascript:cfEach.logout();"><util:message key="ev.title.logout"/></div>
					</c:if>
					<c:if test="${isLogin == false }">
						<div class="navi_menu navi_button" onclick="javascript:cfEach.login();"><util:message key="ev.title.login"/></div>
					</c:if>
				-->
			</div>
			<div id="navigation_mask" class="mask_panel navigation_mask">
				<div class="mask_layer3" id="navigation_mask_layer"></div>
			</div>