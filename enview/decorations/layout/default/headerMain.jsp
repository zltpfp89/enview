<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../initLayoutDecorators.jsp" %>
<%@page import="com.saltware.enview.notice.Notice"%>
<%@page import="com.saltware.enview.page.NodeComponent"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	List topMenuList = site.getTopMenu( request, rootSite );
	List leftMenuList = site.getSubMenu( request, rootSite , 2);
	List quickMenuList = site.getQuickMenuList(request);
	List myQuickMenuList = site.getMyQuickMenuList(request);
	
	request.setAttribute("topMenuList", topMenuList);
	request.setAttribute("leftMenuList", leftMenuList);
	request.setAttribute("quickMenuList", quickMenuList);
	request.setAttribute("myQuickMenuList", myQuickMenuList);
	
	
	boolean isLogin = (userId ==  null || userId.equals("guest")) ? false : true;
	request.setAttribute("isLogin", isLogin);
	
	String pageIds = site.getCurrentPageIds(request, 2);
	String breadcrumbs = includeLinksNavigation( site.getNavigation(request, "/demo"), langKnd );
	
	String titleicon = "";
	String subtitle = "";
	if( "/".equals(currentPage.getParent().getName()) ) {
		titleicon = "images/left_top.gif";
		subtitle = currentPage.getShortTitle();
	}
	else {
		titleicon = "images/title_" + currentPage.getName() + "_on.gif";
		subtitle = currentPage.getShortTitle();
	}
	
	String currentPath = currentPage.getPath();
	
	int tabordercnt = 0;    
%>
<html>
  <head>
    <title><c:out value="${PageTitle}"/></title>

    <meta http-equiv="Content-type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="Content-style-type" content="text/css"/>   
    <meta name="version" content="3.2.5"/>
    <meta name="keywords" content="" />
    <meta name="description" content="<c:out value="${PageTitle}"/>"/>

	<link rel="stylesheet" type="text/css" media="screen, projection" href=""${themePath}/css/styles.css" />
	<link rel="stylesheet" type="text/css" media="screen, projection" href="${cPath}/decorations/layout/css/styles.css"  />
	
	<link type="text/css" href="${cPath}/decorations/layout/css/jquery/base/jquery.ui.all.css" rel="stylesheet" />
	<script type="text/javascript" src="${cPath}/javascript/jquery/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="${cPath}/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
	<script type="text/javascript" src="${cPath}/javascript/jquery/ui/i18n/jquery.ui.datepicker-${langKnd}.js"></script>
	
	<script type="text/javascript" src="${cPath}/javascript/message/mrbun_${langKnd}_mm.js"></script>
	<script type="text/javascript" src="${cPath}/javascript/message/mrbun_${langKnd}_ev.js"></script>
	<script type="text/javascript" src="${cPath}/javascript/common_new.js"></script>
	<script type="text/javascript" src="${cPath}/javascript/portal_new.js"></script>
	<script type="text/javascript" src="${cPath}/javascript/utility.js"></script>
	<script type="text/javascript" src="${cPath}/javascript/validator.js"></script>
	<script type="text/javascript" src="${themePath}/script/text_menu.js"></script>
	
	<script type="text/javascript" src="${cPath}/admin/javascript/portlet.js"></script>
	
	<script type="text/javascript" src="${cPath}/javascript/tree/dhtmlxcommon.js"></script>
	<script type="text/javascript" src="${cPath}/javascript/tree/dhtmlXTree.js"></script>
	<script type="text/javascript" src="${cPath}/javascript/tree/dhtmlXTreeMenu.js"></script>

	
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
			location.href = "${request.contextPath}/login/changeuser?username=" + userId;
		}
		
		function initEnview() {
			var errorMessage = "<c:out value="${errorMessage}"/>";
			if( errorMessage != "null" && errorMessage.length > 0 ) {
				alert( errorMessage );
			}
			${initEnviewScript}
		}	
		
		function enviewPageLogin() {
			var form = document.getElementById("PageLoginForm");
			var id = form["userId"].value;
			var pass = form["password"].value;
			var isSaveLoginID = form["saveLoginID"].checked;
			
			if( id==null || id.length==0 ) {
				alert( "사용자 ID를 입력하시기 바랍니다." );
				form["userId"].focus();
				return false;
			}
			else if( pass==null || pass.length==0 ) {
				alert( "비밀번호를 입력하시기 바랍니다." );
				form["password"].focus();
				return false;
			}
			//alert("form.action=" + form.action + ", id=" + id + ", pass=" + pass + ", isSaveLoginID=" + isSaveLoginID);
			form["password"].value = pass; //getMovieName("top_left_bg").epPassEncode(pass); 
			
			if( isSaveLoginID == true ) {
				var today = new Date();
				var expires = new Date();
				expires.setTime(today.getTime() + 1000*60*60*24*365);
				SetCookie('EnviewLoginID', id+";1", expires, '/');
			}
			else {
				//DeleteCookie('EnviewLoginID', '/');
				var today = new Date();
				var expires = new Date();
				expires.setTime(today.getTime() + 1000*60*60*24*365);
				SetCookie('EnviewLoginID', ";0", expires, '/');
			}
			
			form["username"].value = id;
			
			form.submit();
			return false;
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
		
		// Attach to the onload event
		if (window.attachEvent)
		{
		    //window.attachEvent ( "onload", initEnview );
		}
		else if (window.addEventListener )
		{
		    //window.addEventListener ( "load", initEnview, false );
		}
		else
		{
		    //window.onload = initEnview;
		}
	</script>
</head>

<body marginwidth="0" marginheight="0" class="${layoutDecoration.baseCSSClass}">
<div id="EnviewMessageBox" title="Notice" style="left:0px; top:0px; display:none; z-index:999"></div>
	
<div id="quick" align="right" class="webpanel" style="display:none;left:100px;top:100px;"></div>
<div id="Enview.Portal.IconArea" align="right" class="webpanel" style="display:none;"><%=pageActionBar%></div>
<div id="Enview.Portal.ContextMenu" class="contextMenu" style="position:absolute; left:925px; top:198px; z-index:10; visibility:visible; display:none;"></div>
<div id="Enview.Portal.DialogBasePane" class="contextMenu" style="position:absolute; left:925px; top:198px; z-index:10; visibility:visible; display:none;"></div>

<table width="960" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
	<td width="185" background="${themePath}/images/title01_bg.gif"><a href="${cPath}"><img src="${themePath}/images/logo.png" width="180" height="52"></a></td>
    <td ><img src="${themePath}/images/title01.gif" width="760" height="70"></td>
  </tr>
  <tr>
    <td width="185" valign="top" background="${themePath}/images/enview_main_bg_1.gif">
		<table width="185" border="0" cellspacing="0" cellpadding="0">
		  <tr >
			<td width="185" height="2" align="center" valign="middle" background="${themePath}/images/menu_bg_center.jpg"></td>
		  </tr>
		  <tr>
			<td height="120" align="center" valign="middle">
<c:choose>
	<c:when test="${isLogin==true}">
				<!-- 로그인 -->
				<table width="160" border="0" cellspacing="0" cellpadding="3">
				  <tr> 
					<td width="87" rowspan="2" align="center"><img src="${themePath}/images/avatar.gif" width="69" height="65" alt="Avatar" /></td>
					<td width="61" height="33" class="text_white" style="color:#fff"><p ><span class="text_id"><%=userId%></span><br />
					  <%=msgs.getString("ev.info.user.Welcome")%></p></td>
				  </tr>
				  <tr>
					<td width="61" height="25"><a href="${site.logoutUrl}"><img src="${themePath}/images/btn_logout.gif" width="61" height="16" alt="Logout" /></a></td>
				  </tr>
				  <tr>
					<td colspan="2" align="center" height="20"><img src="${themePath}/images/left_bar.gif" width="151" height="1" /></td>
				  </tr>
				</table>
				<!-- /로그인 -->
	</c:when>
	<c:otherwise>
				<!-- 비로그인 -->
				<form id="PageLoginForm" name="PageLoginForm" method="post" style="display:inline" action="${loginUrl}" onkeydown="if(event.keyCode==13) enviewPageLogin();" onsubmit="javascript:return enviewPageLogin();">
				<table width="160" border="0" cellspacing="0" cellpadding="3">
				  <tr> 
					<td width="80" height="23" align="right" style="color:#fff"><util:message key="ev.prop.userpass.userId"/>&nbsp;&nbsp;&nbsp;</td> 
					<td width="90" height="23"> 
					  <input type="hidden" name="_enpass_login_" value="submit">
					  <input type="hidden" name="username" >
					  <input type="text" name="userId" size="10" class="login-input">
					</td>
				  </tr>
				  <tr> 
					<td width="80" height="23"  align="right" style="color:#fff"><util:message key="eb.info.ttl.password"/>&nbsp;&nbsp;&nbsp;</td>
					<td width="90" height="23"> 
					  <input type="password" name="password" size="10" class="login-input">
					</td>
				  </tr>
				  <tr>
					<td width="120" align="center" style="color:#fff"><input type="checkbox" name="saveLoginID" checked value="checkbox" tabindex="3"><util:message key="ev.title.user.SaveID"/></td>
					<td align="center">
						<span class="btn_pack small"><a href="javascript:enviewPageLogin()"><util:message key='ev.title.login'/></a></span>
					</td>
				  </tr>
				  <tr>
					<td colspan="2" align="center" height="20"><img src="${themePath}/images/left_bar.gif" width="151" height="1" /></td>
				  </tr>
				  <tr>
					<td colspan="2" align="center" style="color:#fff">
						<span class="btn_pack small"><a href="<${cPath}/portal/public/user/registeUser.page"><util:message key='ev.title.user.RegistMember'/></a></span>
					</td>
				  </tr>
				</table>
				</form>
				<!-- /비로그인 -->
	</c:otherwise>
</c:choose>	
			</td>
		  </tr>
		  <tr>
			<td height="50" align="center" valign="middle"><img src="${themePath}/images/btn_cafe_go.gif" width="170" height="24" alt="카페 바로가기" /></td>
		  </tr>
		  <tr>
			<td height="240" align="center" valign="top"><img src="${themePath}/images/issue.gif" width="170" height="255" /></td>
		  </tr>
		  <tr>
			<td height="200" align="center"><table width="170" border="0" cellspacing="0" cellpadding="0">
			  <tr>
				<td height="100" align="center" valign="middle"><img src="${themePath}/images/btn_cert.gif" width="168" height="45" alt="인터넷 증명발급 센터" /></td>
			  </tr>
			  <tr>
				<td height="100" align="center" valign="middle"><img src="${themePath}/images/logo.png" width="160" height="35" alt="Home" /></td>
			  </tr>
			</table></td>
		  </tr>
		</table>
	</td>
    <td valign="top"><table width="755" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="755" height="35" >
			<table width="755" border="0" cellspacing="0" cellpadding="0" background="${themePath}/images/menu_bg_center.jpg">
			  <tr>
				<td height="35" align="left" valign="bottom">
				<!-- 메인메뉴 -->
				<c:forEach items="${topMenuList}" var="menu" varStatus="status"><c:if test="${menu.hidden=='false'}">
					<span><a href="<c:out value="${menu.fullUrl}"/>"  target="${menu.target}"><img src="${themePath}/images/menu/<c:out value="${menu.name}"/>.gif" height="26" alt="<c:out value="${menu.shortTitle}"/>" /></a> </span>
				</c:if></c:forEach>
				<!-- /메인메뉴 -->
				</td>
				<td width="185" height="35">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
					  <tr>
						  <td align="right">

							<a href="http://www.saltware.co.kr"><img src="${themePath}/images/btn_home.gif" width="54" align="absmiddle" alt="Enview Home" /></a>
<c:if test="${isLogin==true }">
							<a href="${userDir}"><img src="${themePath}/images/btn_mypage.gif" width="54" align="absmiddle" alt="Mypage" /></a>
</c:if>				  
<c:if test="${hasAdminRole==true }">
							<a href="<${cPath}/portal/admin.page?theme=admin"><img src="${themePath}/images/btn_admin.gif" width="54" align="absmiddle" alt="Admin" /></a>
</c:if>
						  </td>
					  </tr>
					</table>
				</td>
			  </tr>
			</table>
		</td>
      </tr>
      <tr>
        <td width="755" height="250" align="center" valign="top">
			
		