<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../initLayoutDecorators.jsp" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<html>
  <head>
    <title><%= _PageTitle %></title>

    <meta http-equiv="Content-type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="Content-style-type" content="text/css"/>   
    <meta name="version" content="3.2.2"/>
    <meta name="keywords" content="" />
    <meta name="description" content="${PageTitle}"/>

	<link rel="stylesheet" type="text/css" media="screen, projection" href="${cPath}/decorations/layout/css/styles.css"  />
	<!--link rel="stylesheet" type="text/css" media="screen, projection" href="${themePath}/css/styles.css" /-->
	<link rel="stylesheet" type="text/css" media="screen, projection" href="${cPath}/admin/css/styles.css"  />
	<link rel="stylesheet" type="text/css" media="screen, projection" href="${cPath}/decorations/layout/tile/css/style.css"  />
	
	<script type="text/javascript" src="${cPath}/javascript/message/mrbun_${langKnd}_mm.js"></script>
	<script type="text/javascript" src="${cPath}/javascript/message/mrbun_${langKnd}_ev.js"></script>
	<script type="text/javascript" src="${cPath}/javascript/common_new.js"></script>
	<script type="text/javascript" src="${cPath}/javascript/portal_new.js"></script>
	<script type="text/javascript" src="${cPath}/javascript/utility.js"></script> 
	<script type="text/javascript" src="${cPath}/javascript/validator.js"></script>
	
	<script type="text/javascript" src="${cPath}/admin/javascript/portlet.js"></script>
	
	<link type="text/css" href="${cPath}/decorations/layout/css/jquery/base/jquery.ui.all.css" rel="stylesheet" />
	<script type="text/javascript" src="${cPath}/javascript/jquery/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="${cPath}/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
	<script type="text/javascript" src="${cPath}/javascript/jquery/ui/i18n/jquery.ui.datepicker-${langKnd}.js"></script>

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
		
		function initEnview() {
			<%=initEnviewScript%>
			//tabInitialize();
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
			window.addEventListener ( "unload", checkModified );
		}
		else
		{
		    //window.onload = initEnview;
			window.onunload = checkModified;
		}
	</script>
  </head>
  
  <body marginwidth="0" marginheight="0" class="<%=_layoutDecoration.getBaseCSSClass()%>">
	<div id="DebuggerDisplay" style="width:100%; height:20px; display:none"></div>
	<div id="EnviewMessageBox" style="left:0px; top:0px; display:none"></div>
	<div id="Enview.Portal.IconArea" align="right" class="webpanel" style="display:none;"></div>		<div id="body">
	<!-- body_wrap -->
	<div id="body_wrap">
		<div id="contentsArea">
            <div id="EnviewContentArea" >
	