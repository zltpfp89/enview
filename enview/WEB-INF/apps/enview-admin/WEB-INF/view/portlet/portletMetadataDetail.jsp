
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletMetadataManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="PortletMetadataManager_PortletMetadataTabPage">
				<br style='line-height:5px;'>

					<div id="PortletMetadataManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="PortletMetadataManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="PortletMetadataManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="PortletMetadataManager_isCreate">
									
									<input type="hidden" id="PortletMetadataManager_id" name="id">	
									<input type="hidden" id="PortletMetadataManager_objectId" name="objectId">	
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='pt.ev.property.name'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="PortletMetadataManager_name" name="name" value="<c:out value="${aPortletMetadataVO.name}"/>" maxLength="100" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='pt.ev.property.localeString'/></td>
									
										<td class="webformfield">
											
											<select id="PortletMetadataManager_localeString" name="localeString" class='webdropdownlist'>
												<c:forEach items="${localeStringList}" var="localeString">
												<option value="<c:out value="${localeString.code}"/>"><c:out value="${localeString.codeName}"/></option>
												</c:forEach>
											</select>
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='pt.ev.property.columnValue'/> *</td>
									
										<td class="webformfield">
											
											<textarea id="PortletMetadataManager_columnValue" name="columnValue" value="<c:out value="${aPortletMetadataVO.columnValue}"/>" cols="80" rows="3" maxLength="1000" class="webtextarea" >	</textarea>
												
										</td>
										
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aPortletMetadataManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aPortletMetadataManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End PortletMetadataManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End PortletMetadataManager_PortletMetadataTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="PortletMetadataManager_PortletMetadataChooser"></div>

