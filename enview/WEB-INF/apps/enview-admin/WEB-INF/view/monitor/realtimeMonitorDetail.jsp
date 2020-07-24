
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/realtimeMonitorManager.js"></script>

<div class="webformpanel" style="width:100%;">
	<form id="RealtimeMonitorManager_EditForm" style="display:inline" action="" method="post">
		<table cellpadding=0 cellspacing=0 border=0 width='100%'>
		<input type="hidden" id="RealtimeMonitorManager_isCreate">
		
		<tr> 
			<td colspan="2" width="100%" class="webformheaderline"></td>    
		</tr>
	
		<tr >
			<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.monitor.ipAddress'/></td>
		
			<td class="webformfield">
				
				<input type="text" id="RealtimeMonitorManager_ipAddress" name="ipAddress" value="<c:out value="${aRealtimeMonitorVO.ipAddress}"/>" maxLength="" class="full_webtextfield" />
					
			</td>
			
		</tr>
		
	</table>
	<table style="width:100%;" class="webbuttonpanel">
	<tr>
		<td align="right">  
			<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aRealtimeMonitorManager.doCreate()">
			<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aRealtimeMonitorManager.doUpdate(true)">
		</td>
	</tr>
	</table>
	</form>
</div>

<div id="RealtimeMonitorManager_RealtimeMonitorChooser"></div>

