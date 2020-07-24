
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletParamManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="PortletParamManager_PortletParamTabPage">
				<br style='line-height:5px;'>

					<div id="PortletParamManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="PortletParamManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="PortletParamManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="PortletParamManager_isCreate">
									
									<input type="hidden" id="PortletParamManager_parameterId" name="parameterId">	
									<input type="hidden" id="PortletParamManager_parentId" name="parentId">	
									<input type="hidden" id="PortletParamManager_className" name="className">	
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.portletDefinition.paramName'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="PortletParamManager_name" name="name" value="<c:out value="${aPortletParamVO.name}"/>" maxLength="80" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.portletDefinition.paramValue'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="PortletParamManager_parameterValue" name="parameterValue" value="<c:out value="${aPortletParamVO.parameterValue}"/>" maxLength="100" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aPortletParamManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aPortletParamManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End PortletParamManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End PortletParamManager_PortletParamTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="PortletParamManager_PortletParamChooser"></div>

