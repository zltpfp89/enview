
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/themeMappingManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="ThemeMappingManager_ThemeMappingTabPage">
				<br style='line-height:5px;'>

					<div id="ThemeMappingManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="ThemeMappingManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="ThemeMappingManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="ThemeMappingManager_isCreate">
									
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.themeMapping.principalId'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="ThemeMappingManager_principalId" name="principalId" value="<c:out value="${aThemeMappingVO.principalId}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.themeMapping.seasonType'/> *</td>
									
										<td class="webformfield">
											
											<select id="ThemeMappingManager_seasonType" name="seasonType" class='webdropdownlist'>
												<c:forEach items="${seasonTypeList}" var="seasonType">
												<option value="<c:out value="${seasonType.code}"/>"><c:out value="${seasonType.codeName}"/></option>
												</c:forEach>
											</select>
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.themeMapping.pageType'/> *</td>
									
										<td class="webformfield">
											
											<select id="ThemeMappingManager_pageType" name="pageType" class='webdropdownlist'>
												<c:forEach items="${pageTypeList}" var="pageType">
												<option value="<c:out value="${pageType.code}"/>"><c:out value="${pageType.codeName}"/></option>
												</c:forEach>
											</select>
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.themeMapping.themeName'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="ThemeMappingManager_themeName" name="themeName" value="<c:out value="${aThemeMappingVO.themeName}"/>" maxLength="" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aThemeMappingManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aThemeMappingManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End ThemeMappingManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End ThemeMappingManager_ThemeMappingTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="ThemeMappingManager_ThemeMappingChooser"></div>

