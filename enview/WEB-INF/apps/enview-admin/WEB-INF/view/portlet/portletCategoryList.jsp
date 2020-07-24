
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletCategoryManager.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/categoryMetadataManager.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletDefinitionManager.js"></script>
<script type="text/javascript">
function initPortletCategoryManager() {
	if( aPortletDefinitionManager == null ) {
		aPortletDefinitionManager = new PortletDefinitionManager("<c:out value="${evSecurityCode}"/>");
		aPortletDefinitionManager.init();
	}
	if( aPortletCategoryManager == null ) {
		aPortletCategoryManager = new PortletCategoryManager("<c:out value="${evSecurityCode}"/>");
		aPortletCategoryManager.init();
	}
}
function finishPortletCategoryManager() {
	
}
// Attach to the onload event
if (window.attachEvent)
{
    window.attachEvent ( "onload", initPortletCategoryManager );
	window.attachEvent ( "onunload", finishPortletCategoryManager );
}
else if (window.addEventListener )
{
    window.addEventListener ( "load", initPortletCategoryManager, false );
	window.addEventListener ( "unload", finishPortletCategoryManager, false );
}
else
{
    window.onload = initPortletCategoryManager;
	window.onunload = finishPortletCategoryManager;
}
</script>


<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td id="PortletCategoryManager_Left" width="280px" height="1224px" style="background:#FFFFFF;" valign="top" class="webpanel" >
		<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr><td height="28px" id="PortletCategoryManager_Left_Title" align="center" class="webpanel">
				 <b><util:message key='ev.title.portlet.portletCategoryTree'/></b> 
			</tr>
			<tr>
				<td valign="top" >
					<div id="PortletCategoryManager_TreeTabPage" style="overflow:auto; padding:2px;" ></div>
				</td>
			</tr>
			<tr><td> </td></tr>
			<!--tr>
				<td height="100%">
					<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<td valign='top'>
							<div id="PortletCategoryManager_propertyTabs">
								<ul>
									<li><a href="#PortletCategoryManager_DetailTabPage"><util:message key='pt.ev.property.detailTab'/></a></li>   
							
									<li><a href="#PortletCategoryManager_CategoryMetadataTabPage" onclick="aPortletCategoryManager.onSelectPropertyTab(1);"><util:message key='pt.ev.property.portletCategoryMetaTab'/></a></li>   
											
								</ul>
								<div id="PortletCategoryManager_DetailTabPage">
									<%@include file="portletCategoryDetail.jsp"%>
								</div>
							
								<div id="PortletCategoryManager_CategoryMetadataTabPage">
									
								</div>
									
							</div>
						</td>
					</tr>
					</table>
				</td>
			</tr-->
		</table>
	</td>
	<td id="PortletCategoryManager_Right" valign="top">
	
		<%@include file="../portletDefinition/portletDefinitionList.jsp"%>
	  
	</td>
<tr>
</table>

