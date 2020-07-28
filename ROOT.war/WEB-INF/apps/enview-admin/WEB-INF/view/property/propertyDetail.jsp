
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/propertyManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="PropertyManager_PropertyTabPage">
				<br style='line-height:5px;'>

					<div id="PropertyManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="PropertyManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="PropertyManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="PropertyManager_isCreate">
									
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.property.key'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="PropertyManager_key" name="key" value="<c:out value="${aPropertyVO.key}"/>" maxLength="250" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.property.value'/> *</td>
									
										<td class="webformfield">
											
											<textarea id="PropertyManager_value" name="value" value="<c:out value="${aPropertyVO.value}"/>" cols="80" rows="3" maxLength="1024" class="webtextarea" >	</textarea>
												
										</td>
										
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aPropertyManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aPropertyManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End PropertyManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End PropertyManager_PropertyTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="PropertyManager_PropertyChooser"></div>

