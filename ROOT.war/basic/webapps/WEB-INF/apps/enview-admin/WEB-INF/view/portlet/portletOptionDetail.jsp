
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletOptionManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="PortletOptionManager_PortletOptionTabPage">
				<br style='line-height:5px;'>

					<div id="PortletOptionManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="PortletOptionManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="PortletOptionManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="PortletOptionManager_isCreate">
									
									<input type="hidden" id="PortletOptionManager_id" name="id">	
									<input type="hidden" id="PortletOptionManager_portletId" name="portletId">	
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='pt.ev.property.name'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="PortletOptionManager_name" name="name" value="<c:out value="${aPortletOptionVO.name}"/>" maxLength="100" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='pt.ev.property.value'/> *</td>
									
										<td class="webformfield">
											
											<textarea id="PortletOptionManager_value" name="value" value="<c:out value="${aPortletOptionVO.value}"/>" cols="80" rows="3" maxLength="1024" class="webtextarea" >	</textarea>
												
										</td>
										
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aPortletOptionManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aPortletOptionManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End PortletOptionManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End PortletOptionManager_PortletOptionTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="PortletOptionManager_PortletOptionChooser"></div>

