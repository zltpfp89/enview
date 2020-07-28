
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/noticeMetadataManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="NoticeMetadataManager_NoticeMetadataTabPage">
				<br style='line-height:5px;'>

					<div id="NoticeMetadataManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="NoticeMetadataManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="NoticeMetadataManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="NoticeMetadataManager_isCreate">
									
									<input type="hidden" id="NoticeMetadataManager_id" name="id">	
									<input type="hidden" id="NoticeMetadataManager_noticeId" name="noticeId">	
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.noticeMetadata.langKnd'/></td>
									
										<td class="webformfield">
											
											<select id="NoticeMetadataManager_langKnd" name="langKnd" class='webdropdownlist'>
												<c:forEach items="${langKndList}" var="langKnd">
												<option value="<c:out value="${langKnd.code}"/>"><c:out value="${langKnd.codeName}"/></option>
												</c:forEach>
											</select>
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.noticeMetadata.title'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="NoticeMetadataManager_title" name="title" value="<c:out value="${aNoticeMetadataVO.title}"/>" maxLength="50" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.noticeMetadata.content'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="NoticeMetadataManager_content" name="content" value="<c:out value="${aNoticeMetadataVO.content}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aNoticeMetadataManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aNoticeMetadataManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End NoticeMetadataManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End NoticeMetadataManager_NoticeMetadataTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="NoticeMetadataManager_NoticeMetadataChooser"></div>

