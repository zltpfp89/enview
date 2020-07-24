
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/noticeManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="NoticeManager_NoticeTabPage">
				<br style='line-height:5px;'>

					<div id="NoticeManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="NoticeManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="NoticeManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="NoticeManager_isCreate">
									
									<input type="hidden" id="NoticeManager_noticeId" name="noticeId">	
									<input type="hidden" id="NoticeManager_principalId" name="principalId">	
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.notice.title'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="NoticeManager_title" name="title" value="<c:out value="${aNoticeVO.title}"/>" maxLength="25" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.notice.isEmergency'/></td>
									
										<td class="webformfield"><input type="checkbox" id="NoticeManager_isEmergency" name="isEmergency" value="" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.notice.startDate'/></td>
									
										<td class="webformfield"><input type="text" id="NoticeManager_startDate" name="startDate" value="<c:out value="${aNoticeVO.startDate}"/>" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.notice.endDate'/></td>
									
										<td class="webformfield"><input type="text" id="NoticeManager_endDate" name="endDate" value="<c:out value="${aNoticeVO.endDate}"/>" class="full_webtextfield" /></td>
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.notice.template'/></td>
									
										<td class="webformfield">
											
											<textarea id="NoticeManager_template" name="template" value="<c:out value="${aNoticeVO.template}"/>" cols="80" rows="3" maxLength="256" class="webtextarea" >	</textarea>
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.notice.layoutX'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="NoticeManager_layoutX" name="layoutX" value="<c:out value="${aNoticeVO.layoutX}"/>" maxLength="6" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.notice.layoutY'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="NoticeManager_layoutY" name="layoutY" value="<c:out value="${aNoticeVO.layoutY}"/>" maxLength="6" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.notice.layoutWidth'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="NoticeManager_layoutWidth" name="layoutWidth" value="<c:out value="${aNoticeVO.layoutWidth}"/>" maxLength="6" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.notice.layoutHeight'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="NoticeManager_layoutHeight" name="layoutHeight" value="<c:out value="${aNoticeVO.layoutHeight}"/>" maxLength="6" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.notice.groups'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="NoticeManager_groups" name="groups" value="<c:out value="${aNoticeVO.groups}"/>" maxLength="250" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.notice.pagePath'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="NoticeManager_pagePath" name="pagePath" value="<c:out value="${aNoticeVO.pagePath}"/>" maxLength="240" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aNoticeManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aNoticeManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
						<div id="NoticeManager_NoticeMetadataTabPage">
						</div>
							
					</div>
					</div> <!-- End NoticeManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End NoticeManager_NoticeTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="NoticeManager_NoticeChooser"></div>

