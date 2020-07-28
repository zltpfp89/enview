
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/codebaseManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="CodebaseManager_CodebaseTabPage">
				<br style='line-height:5px;'>

					<div id="CodebaseManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="CodebaseManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="CodebaseManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="CodebaseManager_isCreate">
									
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.codebase.systemCode'/> *</td>
									
										<td class="webformfield">
											
											<select id="CodebaseManager_systemCode" name="systemCode" class='webdropdownlist'>
												<c:forEach items="${systemCodeList}" var="systemCode">
												<option value="<c:out value="${systemCode.code}"/>"><c:out value="${systemCode.codeName}"/></option>
												</c:forEach>
											</select>
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.codebase.codeId'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="CodebaseManager_codeId" name="codeId" value="<c:out value="${aCodebaseVO.codeId}"/>" maxLength="20" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.codebase.code'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="CodebaseManager_code" name="code" value="<c:out value="${aCodebaseVO.code}"/>" maxLength="20" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.codebase.langKnd'/> *</td>
									
										<td class="webformfield">
											
											<select id="CodebaseManager_langKnd" name="langKnd" class='webdropdownlist'>
												<c:forEach items="${langKndList}" var="langKnd">
												<option value="<c:out value="${langKnd.code}"/>"><c:out value="${langKnd.codeName}"/></option>
												</c:forEach>
											</select>
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.codebase.codeName'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="CodebaseManager_codeName" name="codeName" value="<c:out value="${aCodebaseVO.codeName}"/>" maxLength="20" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.codebase.codeName2'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="CodebaseManager_codeName2" name="codeName2" value="<c:out value="${aCodebaseVO.codeName2}"/>" maxLength="20" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.codebase.codeTag1'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="CodebaseManager_codeTag1" name="codeTag1" value="<c:out value="${aCodebaseVO.codeTag1}"/>" maxLength="10" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.codebase.codeTag2'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="CodebaseManager_codeTag2" name="codeTag2" value="<c:out value="${aCodebaseVO.codeTag2}"/>" maxLength="10" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.codebase.remark'/></td>
									
										<td class="webformfield">
											
											<input type="text" id="CodebaseManager_remark" name="remark" value="<c:out value="${aCodebaseVO.remark}"/>" maxLength="60" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aCodebaseManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aCodebaseManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End CodebaseManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End CodebaseManager_CodebaseTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="CodebaseManager_CodebaseChooser"></div>

