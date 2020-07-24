
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/syncManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="SyncManager_SyncTabPage">
				<br style='line-height:5px;'>

					<div id="SyncManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="SyncManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="SyncManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="SyncManager_isCreate">
									
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.sync.connect'/></td>
									
										<td class="webformfield"><input type="checkbox" id="SyncManager_connect" name="connect" value="" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.sync.address'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="SyncManager_address" name="address" value="<c:out value="${aSyncVO.address}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.sync.sessionCount'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="SyncManager_sessionCount" name="sessionCount" value="<c:out value="${aSyncVO.sessionCount}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.title.sync.target'/></td>
									
										<td class="webformfield"><input type="checkbox" id="SyncManager_target" name="target" value="" class="full_webtextfield" /></td>
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aSyncManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aSyncManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End SyncManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End SyncManager_SyncTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="SyncManager_SyncChooser"></div>

