<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/mediaTypeManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="MediaTypeManager_MediaTypeTabPage">
				<br style='line-height:5px;'>

					<div id="MediaTypeManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="MediaTypeManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="MediaTypeManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="MediaTypeManager_isCreate">
									
									<input type="hidden" id="MediaTypeManager_mediatypeId" name="mediatypeId">	
									<input type="hidden" id="MediaTypeManager_name" name="name">	
									<input type="hidden" id="MediaTypeManager_characterSet" name="characterSet">	
									<input type="hidden" id="MediaTypeManager_title" name="title">	
									<input type="hidden" id="MediaTypeManager_description" name="description">	
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aMediaTypeManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aMediaTypeManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End MediaTypeManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End MediaTypeManager_MediaTypeTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="MediaTypeManager_MediaTypeChooser"></div>

