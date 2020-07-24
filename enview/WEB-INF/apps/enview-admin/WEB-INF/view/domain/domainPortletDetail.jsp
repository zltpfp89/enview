
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/domainPortletManager.js"></script>

<div class="webformpanel" style="width:100%;">
	<form id="DomainPortletManager_EditForm" style="display:inline" action="" method="post">
		<table cellpadding=0 cellspacing=0 border=0 width='100%'>
		<input type="hidden" id="DomainPortletManager_isCreate">
		
		<tr> 
			<td colspan="2" width="100%" class="webformheaderline"></td>    
		</tr>
	
		<tr >
			<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='mm.prop.domainPortlet.domainId'/></td>
		
			<td class="webformfield">
				
				<input type="text" readonly="readonly" id="DomainPortletManager_domainId" name="domainId" value="<c:out value="${aDomainPortletVO.domainId}"/>" maxLength="" label="<util:message key='mm.prop.domainPortlet.domainId'/>" class="full_webtextfield" />
					
			</td>
			
		</tr>
		
		<tr >
			<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='mm.prop.domainPortlet.portletNm'/></td>
		
			<td class="webformfield">
				
				<input type="text" readonly="readonly" id="DomainPortletManager_portletNm" name="portletNm" value="<c:out value="${aDomainPortletVO.portletNm}"/>" maxLength="" label="<util:message key='mm.prop.domainPortlet.portletNm'/>" class="full_webtextfield" />
					
			</td>
			
		</tr>
		
	</table>
	<table style="width:100%;" class="webbuttonpanel">
	<tr>
		<td align="right">  
			<span class="btn_pack small"><a href="javascript:aDomainPortletManager.doUpdate()"><util:message key='ev.title.save'/></a></span>
		</td>
	</tr>
	</table>
	</form>
</div>

<div id="DomainPortletManager_DomainPortletChooser"></div>

