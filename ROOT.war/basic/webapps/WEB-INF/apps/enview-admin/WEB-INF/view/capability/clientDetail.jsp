
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/clientManager.js"></script>

<form id="ClientManager_EditForm" style="display:inline" action="" method="post">
	<input type="hidden" id="ClientManager_isCreate">		
	<input type="hidden" id="ClientManager_clientId" name="clientId">	
	<input type="hidden" id="ClientManager_preferredMimetypeId" name="preferredMimetypeId">	
	<input type="hidden" id="ClientManager_evalOrder" name="evalOrder" value="<c:out value="${aClientVO.evalOrder}"/>"/>	
	<table id="grid-table" cellpadding="0" cellspacing="0" class="table_board">
		<tr>
			<th class="L"><util:message key='ev.prop.batchAction.name'/> <em>*</em></th>
			<td class="L">
				<input type="text" id="ClientManager_name" name="name" value="<c:out value="${aClientVO.name}"/>" maxLength="" label="<util:message key='ev.prop.batchAction.name'/>" class="txt_100" />
			</td>
			<th class="L"><util:message key='ev.prop.client.useTheme'/> <em>*</em></th>
			<td class="L"><input type="checkbox" id="ClientManager_useTheme" name="useTheme" value="" label="<util:message key='ev.prop.client.useTheme'/>" class="full_webtextfield" /></td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.client.menufacturer'/></th>
			<td class="L">
				<input type="text" id="ClientManager_manufacturer" name="manufacturer" value="<c:out value="${aClientVO.manufacturer}"/>" maxLength="" label="<util:message key='ev.prop.client.menufacturer'/>" class="full_webtextfield" />
			</td>
			<th class="L"><util:message key='ev.prop.client.model'/></th>
			<td class="L">
				<input type="text" id="ClientManager_model" name="model" value="<c:out value="${aClientVO.model}"/>" maxLength="" label="<util:message key='ev.prop.client.model'/>" class="full_webtextfield" />
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.client.version'/></th>
			<td class="L">
				<input type="text" id="ClientManager_version" name="version" value="<c:out value="${aClientVO.version}"/>" maxLength="" label="<util:message key='ev.prop.client.version'/>" class="full_webtextfield" />
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.client.userAgentPattern'/> <em>*</em></th>
			<td colspan="3" class="L">
				<input type="text" id="ClientManager_userAgentPattern" name="userAgentPattern" value="<c:out value="${aClientVO.userAgentPattern}"/>" maxLength="" label="<util:message key='ev.prop.client.userAgentPattern'/>" class="full_webtextfield" />
			</td>
		</tr>
	</table>
	<!-- btnArea-->
	<div class="btnArea">
		<div class="rightArea">
			<a href="javascript:aClientManager.doMoveUp()" class="btn_B"><span><util:message key='ev.info.menu.moveUp'/></span></a>
			<a href="javascript:aClientManager.doMoveDown()" class="btn_B"><span><util:message key='ev.info.menu.moveDown'/></span></a>
			<a href="javascript:aClientManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>				
		</div>
	</div>
	<!-- btnArea//-->			
</form>

<div id="ClientManager_ClientChooser"></div>