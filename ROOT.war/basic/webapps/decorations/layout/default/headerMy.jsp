<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../initLayoutDecorators.jsp" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%
	List topMenuList = site.getTopMenu( request, rootSite );
	List leftMenuList = site.getSubMenu( request, rootSite , 2);
	List quickMenuList = site.getQuickMenuList(request);
	List myQuickMenuList = site.getMyQuickMenuList(request);
	List myMenuList = (List)site.getMyMenuList(request);
	List myPageList = site.getMyPageList(request);
	
	request.setAttribute("topMenuList", topMenuList);
	request.setAttribute("leftMenuList", leftMenuList);
	request.setAttribute("quickMenuList", quickMenuList);
	request.setAttribute("myQuickMenuList", myQuickMenuList);
	request.setAttribute("myMenuList", myMenuList);
	request.setAttribute("myPageList", myPageList);
	
	String hasUserPageStr = (String)userInfo.get("hasUserPage");
	boolean hasUserPage = (hasUserPageStr != null && hasUserPageStr.length() > 0) ? true : false;

	String breadcrumbs = includeLinksNavigation( site.getNavigation(request, rootSite), langKnd );
	String currentPath = currentPage.getPath();
	String home = (_cPath.equals("") || _cPath.equals("/")) ? "/" : _cPath;

	request.setAttribute("pageId", currentPage.getId());
	request.setAttribute("isMyPage", true);

	int tabordercnt = 0;
	
	//System.out.println("#### langKnd=" + langKnd + ", rootSite=" + rootSite);
%>
<html>
	<head>
		<title>${PageTitle}</title>

		<meta http-equiv="Content-type" content="text/html; charset=UTF-8"/>
		<meta http-equiv="Content-style-type" content="text/css"/>   
		<meta name="version" content="3.2.2"/>
		<meta name="keywords" content="" />
		<meta name="description" content="${PageTitle}"/>

		<link rel="stylesheet" type="text/css" media="screen, projection" href="${themePath}/css/mystyles.css" /> 
		<link rel="stylesheet" type="text/css" media="screen, projection" href="${cPath}/decorations/layout/css/styles.css"  />
		<link rel="stylesheet" type="text/css" media="screen, projection" href="${cPath}/admin/css/styles.css"  />
		
		<script type="text/javascript" src="${cPath}/javascript/message/mrbun_${langKnd}_mm.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/message/mrbun_${langKnd}_ev.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/common_new.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/portal_new.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/utility.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/validator.js"></script>
		
		<!--script type="text/javascript" src="${cPath}/face/javascript/portlet.js"></script-->
		<script type="text/javascript" src="${cPath}/face/javascript/portlet.js"></script>
		<script type="text/javascript" src="${cPath}/face/javascript/menu.js"></script>
		
		<link type="text/css" href="${cPath}/decorations/layout/css/jquery/base/jquery.ui.all.css" rel="stylesheet" />
		<script type="text/javascript" src="${cPath}/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/jquery/ui/i18n/jquery.ui.datepicker-${langKnd}.js"></script>
		
		<script type="text/javascript" src="${cPath}/javascript/tree/dhtmlxcommon.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/tree/dhtmlXTree.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/tree/dhtmlXTreeMenu.js"></script>
		<script type="text/javascript" src="${cPath}/decorations/layout/scripts/EnviewMenu.js"></script>
		
		<style>
			.column-my { width:410px; float: left; border:1px red; min-height:100px }
			.portlet-my { margin:1px; width:99%; float:left;}
			.portlet-header-my-none { margin: 0.3em; padding-bottom: 2px; padding-left: 0.2em; }
			.portlet-header-my { cursor: pointer; margin: 0.3em; padding-bottom: 2px; padding-left: 0.2em; }
			.portlet-header-my .ui-icon {  float: right; }
			.portlet-content-my { padding: 0.4em;overflow:hidden}
			.ui-sortable-placeholder { border: 1px dotted black; visibility: visible !important; !important; }
			.ui-sortable-placeholder * { visibility: hidden; }
		</style>
		
		<script type="text/javascript">
			$(function() {
			   $(".column-my").sortable({
				   update: function(event, ui) {
						var c1 = $(this).attr("id").split("_");
						var layout_id = c1[2];
						var column_index = c1[3];
					   
						var portlets = $(this).children(".portlet-my");
						var portletIds = [];
						for( var i=0;i<portlets.length;i++) {
							portletIds.push( $(portlets[i]).attr("id").split('_')[2]);
						}
						if(portletIds.length > 0){
							var param = 'page_path=<%=site.getPage( request).getPath()%>&fragment_ids=' + portletIds + '&parent_id=' + layout_id + '&layout_column=' + column_index;
							portalPage.getAjax().send("POST", portalPage.getContextPath() + "/page/reorderMyPagePortletForAjax.face", param, false, {
								success: function(data){
									
								}});
						}
				   },
				   opacity: 0.7,
				   connectWith: ".column-my"
			   });
			  
			   $(".portlet-my").addClass( "ui-widget ui-widget-content ui-helper-clearfix ui-corner-all")
							   .find(".portlet-header-my")
							   .addClass("ui-widget-header ui-corner-all")
							   .prepend("<span class='ui-icon ui-icon-close'></span>")
							   .end()
							   .find(".portlet-content-my");
							   
			   $(".portlet-my-none").addClass( "ui-widget ui-widget-content ui-helper-clearfix ui-corner-all")
							   .find(".portlet-header-my-none")
							   .addClass("ui-widget-header ui-corner-all")
							   .end()
							   .find(".portlet-content-my");
			  
			   $(".portlet-header-my .ui-icon-plus").click(function() {
					var more_src = $(this).attr("more_src");
					var more_src_target =  $(this).attr("more_src_target");
					var more_src_width =  $(this).attr("more_src_width");
					var more_src_height =  $(this).attr("more_src_height");
					
					if( more_src!='') {
						if( more_src_target!=null) {
							if( more_src_width=='' || more_src_width=='null') {
								window.open( more_src, more_src_target);
							} else {
								var width = parseInt( more_src_width);
								var height = parseInt( more_src_height);
								var left = (window.screen.width - width) / 2;
								var top = (window.screen.height - height) / 2;
								var option = 'width=' + width + ",height=" + height + ",top=" + top + ",left=" + left + ",toolbar=no,menubar=no";
								//alert( option);
								window.open( more_src, more_src_target, option);
							}
						} else {
							window.open( more_src);
						}
					}
			   });
			   
			   $(".portlet-header-my .ui-icon-close").click(function() {
			   
					if( confirm(portalPage.getMessageResource("ev.info.remove")) ) {
						var portlet = $(this).parents(".portlet-my:first" );
						var column =  portlet.parents(".column-my:first" );
						
						var p1 = portlet.attr("id").split('_');
						if( p1[0] != 'Enview') return;
						if( p1[1] != 'Portlet') return;
						var portletId = p1[2];
						
						var c1 = column.attr("id").split('_');
						if( c1[0] != 'Enview') return;
						if( c1[1] != 'Column') return;
						var columnId = c1[2];
						var columnIndex = c1[3];
						
						var param = 'page_path=<%=site.getPage( request).getPath()%>&fragment_id=' + portletId + '&parent_id=' + columnId + '&layout_column=' + columnIndex;
						portalPage.getAjax().send("POST", portalPage.getContextPath() + "/page/removeMyPagePortletForAjax.face", param, false, {
							success: function(data){
								portlet.remove();	
							}});
					}
			   });
			  
			   $(".column-my").disableSelection();
			});
		
			function iframe_autoresize(arg) {
				try {
					var ht = arg.contentWindow.document.documentElement.scrollHeight;
					arg.height = 0;
					arg.height = ht;
				} catch(e) {
					
				}
			}
			
			function initEnview() {
				${initEnviewScript}

				var myPageEditor = portalPage.getMyPageEditor();
				myPageEditor.setPrincipalId("<%=principalId%>");
			}
			
			function selectMenu()
			{
				// CASE 1 : 팝업윈도우로 메뉴선택
				//showModalessDialog('${cPath}/userMenu/listForChooser.face',300,400);
				if( aMenuChooser == null ) {
					// CASE 2 : DHTML 윈도우로 메뉴선택
					var param = "tree=false&path=/";
					portalPage.getAjax().send("POST", portalPage.getContextPath() + "/userMenu/listForChooser.face", param, false, {
					success: function(data){
						document.getElementById("MenuSelectDialog").innerHTML = data;
						aMenuChooser = new MenuChooser(false);
					}});
					/*
					// CASE 3 : DHTML윈도우의 Tree에서 메뉴선택
					portalPage.getAjax().send("POST", portalPage.getContextPath() + "/userMenu/listForChooser.face", "tree=true", false, {
					success: function(data){
						document.getElementById("MenuSelectDialog").innerHTML = data;
						aMenuChooser = new MenuChooser(true);
						aMenuChooser.init();
					}});
					*/				
				}
				aMenuChooser.doShow();
			}
			
			function changeOrderMenu(toDown, pageId)
			{
				var param = "toDown=" + toDown;
				param += "&menuType=1";
				param += "&pageId=" + pageId;
				portalPage.getAjax().send("POST", portalPage.getContextPath() + "/userMenu/changeMenuOrderForAjax.face", param, false, {
				success: function(data){
					document.getElementById("mymenu").innerHTML = data;
				}});
			}
			
			function changeOrderMyPage(toDown, pageId)
			{
				var param = "toDown=" + toDown;
				param += "&menuType=1";
				param += "&pageId=" + pageId;
				portalPage.getAjax().send("POST", portalPage.getContextPath() + "/userMenu/changeMyPageOrderForAjax.face", param, false, {
				success: function(data){
					document.getElementById("mypage").innerHTML = data;
				}});
			}
			
			function deleteMenu(pageId)
			{
				if( confirm(portalPage.getMessageResource("ev.info.remove")) ) {
					var param = "&menuType=1";
					param += "&pageIds=" + pageId;
					portalPage.getAjax().send("POST", portalPage.getContextPath() + "/userMenu/removeMenuForAjax.face", param, false, {
					success: function(data){
						document.getElementById("mymenu").innerHTML = data;
					}});
				}
			}
			
			function goMenu(url) {
				/*
				var param = "__ajax_call__=true";
				portalPage.getAjax().send("POST", url, param, false, {
					success: function(data){
						//document.getElementById("EnviewContentArea").innerHTML = eval('data');
						//$('#EnviewContentArea').html( data );
						//$('#EnviewContentArea')[0].innerHTML = data;
						//$('#EnviewContentArea').append( $(data) );
					}});
				*/
				location.href = url;
			}
			
			function goMyMenu(url) {
				/*
				var param = "__ajax_call__=true";
				portalPage.getAjax().send("POST", url, param, false, {
					success: function(data){
						//document.getElementById("EnviewContentArea").innerHTML = eval('data');
						//$('#EnviewContentArea').html( data );
						//$('#EnviewContentArea')[0].innerHTML = data;
						//$('#EnviewContentArea').append( $(data) );
					}});
				*/
				location.href = url + "?theme=<%=themeName%>&pageType=my";
			}
			
			function onMouseOverMenu(id) {
				var pan = document.getElementById(id);
				if( pan != null ) {
					pan.style.display = "";
				}
			}
			
			function onMouseOutMenu(id) {
				var pan = document.getElementById(id);
				if( pan != null ) {
					pan.style.display = "none";
				}
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
	<body marginwidth="0" marginheight="0" class="<%=_layoutDecoration.getBaseCSSClass()%>"  style="margin: 0 auto;">
		<div id="Enview.Portal.IconArea" align="right" class="webpanel" style="display:none;"><%=pageActionBar%></div>	
		<div id="MenuSelectDialog" class="webpanel" style="display:none;" title="Select MyMenu"></div>
		<div id="top_layer" style="width: 1024px; margin: 0 auto; height: 20px; padding-top: 5px; padding-bottom: 2px;">
			<div id="top_button" style="float: right;">
				<a href="<%=home%>"><img src="${themePath}/images/my/top_home.gif" align="absmiddle" border="0" /></a>
				<a href="${site.logoutUrl}"><img src="${themePath}/images/my/top_logout.gif" align="absmiddle" border="0" /></a>
			</div>
		</div>
		<div id="img_header" style="width: 1024px; margin: 0 auto;">
			<img src="${themePath}/images/my/header3.png" style="width: 1024px;"/>
		</div>
		<div id="center_layer" style="width: 1024px; margin: 0 auto;">
			<div id="left_layer" style="width: 171px; float: left;">
				<div id="img_title" style="width: 171px;">
					<img src="${themePath}/images/my/title_mypage.jpg"  style="width: 171px"/>
				</div>
				<div class="box-g-t"></div>
				<div class="box-g-m">
					<div id="left_menu" style="width: 171px;">
						<!-- public menu start -->
						<c:if test="${! empty publicMenuList || ! empty leftMenuList}">
							<ul id="submenu" class="submenu" >
							<c:forEach items="${publicMenuList}" var="menu" varStatus="status">
								<li id="menu<c:out value="${menu.pageId}"/>" ><a href="<c:out value="${menu.fullUrl}"/>?theme=<%=themeName%>&pageType=my"><img src="${cPath}/decorations/layout/images/icon_menu01.gif" title="Up" align="absmiddle" border="1">&nbsp;<c:out value="${menu.title}"/></a></li>
								<c:if test="${not empty menu.elements}">
									<ul style="padding-left: 25px;">
										<c:forEach items="${menu.elements}" var="subMenu" varStatus="status">
											<c:if test="${subMenu.hidden==false}">
												<li id="submenu<c:out value="${subMenu.menuId}"/>" class="thirdmenu"><a href="<c:out value="${subMenu.fullUrl}"/>?theme=<%=themeName%>&pageType=my"  target="${subMenu.target}">&nbsp;<c:out value="${subMenu.shortTitle}"/></a></li>
											</c:if>
										</c:forEach>
									</ul>
								</c:if>
							</c:forEach>
						<!-- public menu end -->
						<!-- Left menu  start -->
							<c:forEach items="${leftMenuList}" var="menu" varStatus="status">
								<li id="menu<c:out value="${menu.pageId}"/>" ><a href="<c:out value="${menu.fullUrl}"/>?theme=<%=themeName%>&pageType=my"><img src="${cPath}/decorations/layout/images/icon_menu01.gif" title="Up" align="absmiddle" border="1">&nbsp;<c:out value="${menu.title}"/></a></li>
								<c:if test="${not empty menu.elements}">
									<ul style="padding-left: 25px;">
										<c:forEach items="${menu.elements}" var="subMenu" varStatus="status">
											<c:if test="${subMenu.hidden==false}">
												<li id="submenu<c:out value="${subMenu.menuId}"/>" class="thirdmenu"><a href="<c:out value="${subMenu.fullUrl}"/>?theme=<%=themeName%>&pageType=my"  target="${subMenu.target}">&nbsp;<c:out value="${subMenu.shortTitle}"/></a></li>
											</c:if>
										</c:forEach>
									</ul>
								</c:if>
							</c:forEach>
							</ul>
						</c:if>
						<!--Left menu  end -->
					</div>
					<c:if test="${! empty quickMenuList}">
					<img src="${themePath}/images/leftmenu_line.gif" />
					<ul id="quickmenu">
					<c:forEach items="${quickMenuList}" var="quickMenu" varStatus="status">
						<li id="quickmenu<c:out value="${quickMenu.pageId}"/>" ><a href="<c:out value="${quickMenu.fullUrl}"/>?theme=<%=themeName%>&pageType=my"><img src="${cPath}/decorations/layout/images/icon_menu01.gif" title="Up" align="absmiddle" border="1">&nbsp;<c:out value="${quickMenu.title}"/></a></li>
					</c:forEach>
					</ul>
				</c:if>

				<!--c:if test="${! empty myMenuList}"-->
					<img src="${themePath}/images/leftmenu_line.gif" />
					<div class="menu-title" onmouseover2="onMouseOverMenu('mymenu_title')" onmouseout2="onMouseOutMenu('mymenu_title')">
						마이메뉴&nbsp;&nbsp;
						<span id="mymenu_title" >
							<a onclick="javascript:selectMenu()" ><img src="${cPath}/decorations/layout/images/add.png" align="absmiddle" alt="<%=msgs.getString("ev.title.mypage.add")%>" title="메뉴추가"></a>
						</span>
					</div>
					<ul id="mymenu">
					<c:forEach items="${myMenuList}" var="myMenu" varStatus="status">
						<li id="mymenu<c:out value="${myMenu.pageId}"/>" onmouseover="onMouseOverMenu('mymenuButton<c:out value="${myMenu.pageId}"/>')" onmouseout="onMouseOutMenu('mymenuButton<c:out value="${myMenu.pageId}"/>')">
							<span style="width:100px">
								<a href="javascript:goMyMenu('<c:out value="${myMenu.fullUrl}"/>')" ><img src="${cPath}/decorations/layout/images/icon_menu01.gif" title="Up" align="absmiddle" border="1">&nbsp;<c:out value="${myMenu.title}"/></a>&nbsp;&nbsp;
							</span>
							<span id="mymenuButton<c:out value="${myMenu.pageId}"/>" style="display:none;"> 
								<a href="javascript:changeOrderMenu('false', '<c:out value="${myMenu.pageId}"/>')"><img src="${cPath}/decorations/layout/images/up.png" title="Up" align="absmiddle" border="1"></a>
								<a href="javascript:changeOrderMenu('true', '<c:out value="${myMenu.pageId}"/>')"><img src="${cPath}/decorations/layout/images/down.png" title="Down" align="absmiddle" border="1"></a>
								<a href="javascript:deleteMenu('<c:out value="${myMenu.pageId}"/>')"><img src="${cPath}/decorations/layout/images/icon_del.gif" title="Remove" align="absmiddle" border="1"></a>
							</span>
						</li>
					</c:forEach>
					</ul>
				<!--/c:if-->

				<c:if test="${isMyPage == true}">
					<!--c:if test="${! empty myPageList}"-->
					<img src="${themePath}/images/leftmenu_line.gif" />
					<div class="menu-title" onmouseover2="onMouseOverMenu('mypage_title')" onmouseout2="onMouseOutMenu('mypage_title')">
						마이페이지&nbsp;&nbsp; 
						<span id="mypage_title">
							<a href="javascript:portalPage.getPortletSelector().doShow(null, 'calendar,rss,Memo')"><img src="${cPath}/decorations/layout/images/selectPortlet.png" border="0" align="absmiddle" style="cursor:hand" title="<util:message key='ev.info.icon.addPortlet'/>" /></a>
							<a onclick="portalMyPageEditor.doCreate(this)" ><img src="${cPath}/decorations/layout/images/add.png" align="absmiddle" alt="<util:message key='ev.title.mypage.add'/>" title="<util:message key='ev.title.mypage.add'/>"></a>
							<a onclick="portalMyPageEditor.doSelect(this)" ><img src="${cPath}/decorations/layout/images/config.png" align="absmiddle" alt="<util:message key='ev.title.mypage.edit'/>" title="<util:message key='ev.title.mypage.edit'/>"></a>
							<a href="javascript:portalMyPageEditor.setDefaultPage('${site.logoutUrl}')"><img src="${cPath}/decorations/layout/images/home.gif" align="absmiddle" alt="<util:message key='ev.title.mypage.grouppage'/>" title="<util:message key='ev.title.mypage.grouppage'/>"></a>
						</span>
					</div>
					<ul id="mypage">
						<c:forEach items="${myPageList}" var="myPage" varStatus="status">
						<li id="mymenu<c:out value="${myPage.pageId}"/>" onmouseover="onMouseOverMenu('mymenuButton<c:out value="${myPage.pageId}"/>')" onmouseout="onMouseOutMenu('mymenuButton<c:out value="${myPage.pageId}"/>')">
							<span style="width:100px">
								<a href="javascript:goMyMenu('<c:out value="${myPage.fullUrl}"/>')" ><img src="${cPath}/decorations/layout/images/icon_menu01.gif" title="Up" align="absmiddle" border="1">&nbsp;<c:out value="${myPage.title}"/></a>&nbsp;&nbsp;
							</span>
							<span id="mymenuButton<c:out value="${myPage.pageId}"/>" style="display:none;"> 
								<a href="javascript:changeOrderMyPage('false', '<c:out value="${myPage.pageId}"/>')"><img src="${cPath}/decorations/layout/images/up.png" title="Up" align="absmiddle" border="1"></a>
								<a href="javascript:changeOrderMyPage('true', '<c:out value="${myPage.pageId}"/>')"><img src="${cPath}/decorations/layout/images/down.png" title="Down" align="absmiddle" border="1"></a>
								<a onclick="portalMyPageEditor.doRemove('<c:out value="${myPage.pageId}"/>', '<c:out value="${myPage.path}"/>')" ><img src="${cPath}/decorations/layout/images/icon_del.gif" align="absmiddle" alt="<util:message key='ev.title.mypage.remove'/>" title="<util:message key='ev.title.mypage.remove'/>"></a>
								<a href="javascript:portalMyPageEditor.setDefaultMyPage('${site.logoutUrl}', '<c:out value="${myPage.pageId}"/>', '<c:out value="${myPage.path}"/>')"><img src="${cPath}/decorations/layout/images/home.gif" align="absmiddle" alt="<util:message key='ev.title.mypage.homepage'/>" title="<util:message key='ev.title.mypage.homepage'/>"></a>
							</span>
						</li>
						</c:forEach>
					</ul>
					<!--/c:if-->
				</c:if>
				</div>
				<div class="box-g-b"></div>
					
				<div id="page_compoent" style="width: 171px">
					<div style="padding:0px; border:0 solid black"><c:out value="${region_02}" escapeXml="false"/></div> <br>
					<div style="padding:0px; border:0 solid black"><c:out value="${region_03}" escapeXml="false"/></div> <br>
				</div>
			</div>
			<div id="topmenu_layer" style="width: 848px; height: 27px; padding-top:3px; margin-left: 5px; float: left;">
			<c:if test="${! empty topMenuList}">
				<ul id="topmenu" class="topmenu" >
				<c:forEach items="${topMenuList}" var="menu" varStatus="status">
					<li id="menu<c:out value="${menu.pageId}"/>" ><a href="<c:out value="${menu.fullUrl}"/>?theme=<%=themeName%>&pageType=my"><c:out value="${menu.title}"/></a></li>
				</c:forEach>
				</ul>
			</c:if>
			</div>
			<div id="content_layer" style="width: 848px; margin-left: 5px; float: left;">
				<div id="EnviewContentArea" style="width:98%" valign="top">