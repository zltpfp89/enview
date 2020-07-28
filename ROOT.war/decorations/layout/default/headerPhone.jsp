<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../initLayoutDecorators.jsp" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%
	List siteTopMenu = site.getTopMenu( request, rootSite );
	List componentAreas = (List)codes.getCodes("PT", "102", 1, true);
	List quickMenuList = (List)site.getQuickMenuList(request);
	List myMenuList = (List)site.getMyMenuList(request);
	String hasUserPageStr = (String)userInfo.get("hasUserPage");
	boolean hasUserPage = (hasUserPageStr != null && hasUserPageStr.length() > 0) ? true : false;

	String breadcrumbs = includeLinksNavigation( site.getNavigation(request, rootSite), langKnd );
	String currentPath = currentPage.getPath();
	String home = (_cPath.equals("") || _cPath.equals("/")) ? "/" : _cPath;

	List myPageList = (List)site.getMyPageList(request);
	request.setAttribute("myPageList", myPageList);
	request.setAttribute("pageId", currentPage.getId());
	String myPageIds = "";
	List beforeMyPage = new ArrayList();
	List afterMyPage = new ArrayList();
	int ix = 0;
	int tabIndex = 0;
	for(; ix<myPageList.size(); ix++) {
		EnviewMenu menu = (EnviewMenu)myPageList.get(ix);
		myPageIds += menu.getPageId() + ",";
	}
	for(ix=0; ix<myPageList.size(); ix++) {
		EnviewMenu menu = (EnviewMenu)myPageList.get(ix);
		if( menu.getPageId().equals(currentPage.getId()) ) {
			tabIndex = ix++;
			break;
		}
		beforeMyPage.add( menu );
	}
	request.setAttribute("beforeMyPage", beforeMyPage);
	//System.out.println("#### beforeMenu=" + beforeMyPage);
	for(; ix<myPageList.size(); ix++) {
		EnviewMenu menu = (EnviewMenu)myPageList.get(ix);
		afterMyPage.add( menu );
	}
	request.setAttribute("afterMyPage", afterMyPage);
	//System.out.println("#### afterMenu=" + afterMyPage);
	
	int tabordercnt = 0;
	
	//System.out.println("#### langKnd=" + langKnd + ", _preferedLocale=" + _preferedLocale + ", _PageTitle=" + _PageTitle);
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title><%= _PageTitle %></title>

		<meta http-equiv="Content-type" content="text/html; charset=UTF-8"/>
		<meta http-equiv="Content-style-type" content="text/css"/>   
		<meta name="version" content="3.2.2"/>
		<meta name="keywords" content="" />
		<meta name="description" content="<%= _PageTitle %>"/>

		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=themePath%>/css/mystyles.css" />
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=_cPath%>/decorations/layout/css/styles.css"  />
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=_cPath%>/admin/css/styles.css"  />
		
		<script type="text/javascript" src="<%=_cPath%>/javascript/message/mrbun_<%=langKnd%>_mm.js"></script>
		<script type="text/javascript" src="<%=_cPath%>/javascript/message/mrbun_<%=langKnd%>_ev.js"></script>
		<script type="text/javascript" src="<%=_cPath%>/javascript/common_new.js"></script>
		<script type="text/javascript" src="<%=_cPath%>/javascript/portal_new.js"></script>
		<script type="text/javascript" src="<%=_cPath%>/javascript/utility.js"></script>
		<script type="text/javascript" src="<%=_cPath%>/javascript/validator.js"></script>
		
		<script type="text/javascript" src="<%=_cPath%>/face/javascript/portlet.js"></script>
		<script type="text/javascript" src="<%=_cPath%>/face/javascript/menu.js"></script>
		
		<link type="text/css" href="<%=_cPath%>/decorations/layout/css/jquery/base/jquery.ui.all.css" rel="stylesheet" />
		<script type="text/javascript" src="<%=_cPath%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="<%=_cPath%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		<script type="text/javascript" src="<%=_cPath%>/javascript/jquery/ui/i18n/jquery.ui.datepicker-<%=langKnd%>.js"></script>
		
		<script type="text/javascript" src="<%=_cPath%>/javascript/tree/dhtmlxcommon.js"></script>
		<script type="text/javascript" src="<%=_cPath%>/javascript/tree/dhtmlXTree.js"></script>
		<script type="text/javascript" src="<%=_cPath%>/javascript/tree/dhtmlXTreeMenu.js"></script>
		<script type="text/javascript" src="<%=_cPath%>/decorations/layout/scripts/EnviewMenu.js"></script>
		
		<script type="text/javascript">
			function iframe_autoresize(arg) {
				try {
					var ht = arg.contentWindow.document.documentElement.scrollHeight;
					arg.height = 0;
					arg.height = ht;
				} catch(e) {
					
				}
			}
			
			function initEnview() {
				var pageInfo = eval(<%=pageInfo%>);
				var decorations = eval( <%=decorations%> );
				portalPageInitialize("<%=site.getVersion()%>", "<%=editing%>", "<%=userId%>", pageInfo, decorations, "<%=langKnd%>");
<%	if( isMyPage == true ) { %>
				var myPageEditor = portalPage.getMyPageEditor();
				myPageEditor.setPrincipalId("<%=principalId%>");
				myPageEditor.setPages("<%=myPageIds%>");
				$(function() {
					$("#MyPageManager_propertyTabs").tabs();
				});
				var propertyTabs = $("#MyPageManager_propertyTabs").tabs();
				propertyTabs.tabs('select', <%=tabIndex%>);
				//noticeInitialize("<%=currentPage.getId()%>");
				//quickMenuInitialize("Enview.Portal.Quickmenu", 50,300);
<%	} %>
			}
			
			function selectMenu()
			{
				// CASE 1 : 팝업윈도우로 메뉴선택
				//showModalessDialog('<%=request.getContextPath()%>/userMenu/getAccessableMenuList.face',300,400);
				if( aMenuSelector == null ) {
					// CASE 2 : DHTML 윈도우로 메뉴선택
					portalPage.getAjax().send("POST", portalPage.getContextPath() + "/userMenu/getAccessableMenuList.face", "tree=false", false, {
					success: function(data){
						document.getElementById("MenuSelectDialog").innerHTML = data;
						aMenuSelector = new MenuSelector(false);
					}});
					/*
					// CASE 3 : DHTML윈도우의 Tree에서 메뉴선택
					portalPage.getAjax().send("POST", portalPage.getContextPath() + "/userMenu/getAccessableMenuList.face", "tree=true", false, {
					success: function(data){
						document.getElementById("MenuSelectDialog").innerHTML = data;
						aMenuSelector = new MenuSelector(true);
						aMenuSelector.init();
					}});
					*/				
				}
				aMenuSelector.doShow();
			}
			
			function deleteMenu()
			{
				portalPage.getAjax().send("POST", portalPage.getContextPath() + "/userMenu/removeMyMenuForAjax.face", "pageId=" + portalPage.getId(), false, {
				success: function(data){
					location.reload();
				}});
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
			
			function push()
			{
				var param = "title=테스트공지&message=테스트 공지입니다.";
				portalPage.getAjax().send("POST", portalPage.getContextPath() + "/mobile/pushForAJAX.face", param, false, { success: function(data){ alert("success"); }});
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
		<div onclick="javascript:push()" style="height:30px">
			This is AndroidPhone theme header.
		</div>
		<div id="EnviewContentArea">
