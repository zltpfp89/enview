
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/userMenuManager.js"></script>

<div class="webformpanel" style="width:100%;">
	<form id="UserMenuManager_EditForm" style="display:inline" action="" method="post">
		<table cellpadding=0 cellspacing=0 border=0 width='100%'>
		<input type="hidden" id="UserMenuManager_isCreate">
		
		<input type="hidden" id="UserMenuManager_principalId" name="principalId">	
		<input type="hidden" id="UserMenuManager_pageId" name="pageId">	
		<input type="hidden" id="UserMenuManager_parentId" name="parentId">	
		<input type="hidden" id="UserMenuManager_menuType" name="menuType">	
		<input type="hidden" id="UserMenuManager_menuOrder" name="menuOrder">	
		<tr> 
			<td colspan="2" width="100%" class="webformheaderline"></td>    
		</tr>
	
	</table>
	<table style="width:100%;" class="webbuttonpanel">
	<tr>
		<td align="right">  
			<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aUserMenuManager.doCreate()">
			<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aUserMenuManager.doUpdate(true)">
		</td>
	</tr>
	</table>
	</form>
</div>

<div id="UserMenuManager_UserMenuChooser"></div>

