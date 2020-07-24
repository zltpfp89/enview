<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.saltware.enview.request.RequestContext"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<html>
	<head>
		<title><util:message key="cf.title.system"/></title>
		<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
		<meta http-equiv="X-UA-Compatible" content="IE=10" />
		<meta name="version" content="3.2.6" />
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
		<style>
		.cover {
		  position: absolute;
		  height: 100%;
		  width: 100%;
		  z-index: 1; 
		  background-color: none;
		  display: none;
		}
		
		#cover1 {width:183px;}		
		#cover2 {width:739px;}		
		</style>
		
		<%	
			}
		%>
		
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/css/each/<c:out value="${skin}"/>.css" />
		<link id = "themeCss" rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/theme/${cmntVO.theme}.css" />
		<style>
		.cover {
		  position: absolute;
		  height: 100%;
		  width: 100%;
		  z-index: 1; 
		  background-color: none;
		  display: none;
		}
		
		#cover1 {width:183px;}		
		#cover1 {width:739px;}		
		</style>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
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
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_edit.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/home/encafe.js"></script> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/each/encafe.js"></script>
		<%
			if((request.getParameter("isEditMode") == null ? "false" : request.getParameter("isEditMode")).equals("true")){
				request.setAttribute("isEditMode", true);
		%>
		<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/editor/portlet.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/editor/ggum.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/editor/editor.js"></script>
		<!--smarteditor js-->
 		<script type="text/javascript" src="<%=request.getContextPath()%>/board/smarteditor/js/HuskyEZCreator.js"></script>
		<%	
			}
		%>
		<script type="text/javascript">
		
		function iframe_autoresize(arg) {
			try {
				var ht = arg.contentWindow.document.documentElement.scrollHeight;
				arg.height = 0;
				arg.height = ht;
			} catch(e) {
				
			}
		}
		
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
			
			//cfEach.m_skin = '<c:out value="${skin}"/>';
			cfEach.m_curCafeUrl = "${cmntVO.cmntUrl}";
			<c:if test="${ mmbrVO.isLogin && ( mmbrVO.isStaff || mmbrVO.isSysop || mmbrVO.isAdmin)}">
			cfEach.m_isEditMode = <%=request.getParameter("isEditMode") == null ? "false" : request.getParameter("isEditMode")%>;
			cfEach.m_isMobile = <%=request.getAttribute("isMobile")%>;
			
			</c:if>
			<%--END::ENCOLA--%>
			
			$(function(){
				if( cfEach.m_isEditMode) {
					$(".cover").show();
				}
			});

		</script>
	</head>
	<body marginwidth="0" marginheight="0" class="CF0802_bgImage CF0802_bgColor CF0802_bgImgPos CF0802_bgImgRepeat">
		<div id="edit_menu_bar" class="edit_menu_bar">
			<div id="encafelogo" class="encafelogo">
				<a href="${pageContetx.request.contextPath}/cafe/<c:out value="${cmntVO.cmntUrl}"/>">
				<span class="manage" ><util:message key="cf.title.design"/></span>
				<span class="name"><c:out value="${cmntVO.cmntNm}"/></span>
				</a>
			</div>
		</div>
		<div id="cafe_main" class="cafe_main">
			<div id="main_navigation" class="main_navigation">
				<div class="navi_menus">
					<div class="navi_menu" onclick="javascript:cfEach.go2Enview();"><util:message key="eb.title.navi.home"/></div> <%--홈 --%>
					<div class="navi_seperater">|</div>
					<div class="navi_menu" onclick="javascript:cfEach.go2Home('');"><util:message key="cf.prop.cafe.home"/> </div> <%--카페홈 --%>
					<div class="navi_seperater">|</div>
					<div class="navi_menu">
						<div class="navi_menu" id="favorLink" onclick="javascript:cfEach.showFavorCafe()"><util:message key="ev.title.favor.cafe"/></div> <%-- 자주가는 카페 --%>
						<div id="favorCafeDiv" class="favorCafeDiv CF0802_bgColor CF0802_extraBrdrColor">
							<ul class="favorCafeList" id="favorCafeList"></ul>
							<ul class="favorCafeList_sep"></ul>
							<ul class="favorCafeList">
								<li class="favorCafeControl" onclick="javascript:cfEach.go2Home('mine.favor')">- <util:message key="cf.title.viewAll"/> - </li> <%--전체보기 --%>
								<li class="favorCafeControl" onclick="javascript:cfEach.go2Home('mine.favorEdit')">- <util:message key="ev.title.edit"/> - </li> <%-- 편집--%>
							</ul>
							<form id="title_form" name="title_form" style="display:inline" method="post" action="${cPath}/cafe" target="_top">
								<input type="hidden" id="initView" name="initView"/>
							</form>
						</div>
					</div>
					<div class="navi_menu navi_button favor_button" onclick="javascript:cfEach.showFavorCafe()">▼</div>
					<%--
					<div class="navi_seperater">|</div>
					<div class="navi_menu" onclick="javascript:cfEach.go2BlogHome();">블로그</div>
					<div class="navi_seperater">|</div>
					<div class="navi_menu" onclick="javascript:cfEach.go2Mail();">메일</div>
					<div class="navi_seperater">|</div>
					<div class="navi_menu" onclick="javascript:cfEach.go2Note();">쪽지</div>
					<c:if test="${mmbrVO.isLogin }" var="isLogin">
						<div class="navi_menu navi_button" onclick="javascript:cfEach.logout();">로그아웃</div>
					</c:if>
					<c:if test="${isLogin == false }">
						<div class="navi_menu navi_button" onclick="javascript:cfEach.login();">로그인</div>
					</c:if>
					 --%>
				</div>
			</div>
			<div id="navigation_mask" class="mask_panel navigation_mask">
				<div class="mask_layer3" id="navigation_mask_layer"></div>
			</div>				
			<div class="portal-layout">
				<div class="column" style="float:left; width: 100%; min-height:1px; ">
					<jsp:include page="${cPath}/cafe/each.cafe?m=title"/>
					<jsp:include page="${cPath}/cafe/each.cafe?m=gate"/>
					<div class="portal-layout">
						<!-- MENU AREA -->
						<div class="column" style="float:left; width: 183px; min-height:1px; ">
						<div class="cover" id="cover1"></div>
						<c:forEach items="${menuAreaList}" var="menu" varStatus="status">
						<jsp:include page="${cPath}/cafe/each.cafe?m=${menu}"/>
						</c:forEach>
						</div>
						<!-- /MENU AREA -->
						<!-- CONTENT AREA -->
						<div class="column" style="margin-left: 190px;">
						<div class="cover" id="cover2"></div>
						<jsp:include page="${cPath}/cafe/each.cafe?m=cntt"/>
						</div> 
						<!-- /CONTENT AREA -->
						<br style="clear:both;">
					</div> <!--portal-layout-->
				</div> <!-- portal-layout-column -->
			</div> <!--portal-layout-->
				
		</div>
		<div id="remoteLayer" class="remote_min" style="width:222px; position:fixed; display:none">
			<%--VIEW::cafe/editor/ggum/remoteLayer.jsp--%>
		</div>
	</body>
</html>