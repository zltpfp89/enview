
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/langManager.js"></script>

<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr>
	<td width="100%" valign="top">
		<div style=" " class="webpanel">
			<div id="LangManager_LangTabPage">
				<br style='line-height:5px;'>

					<div id="LangManager_EditFormPanel" class="webformpanel" >  
					<div id="propertyTabs">
						<div id="LangManager_DetailTabPage">
							<div class="webformpanel" style="width:100%;">
								<form id="LangManager_EditForm" style="display:inline" action="" method="post">
									<table cellpadding=0 cellspacing=0 border=0 width='100%'>
									<input type="hidden" id="LangManager_isCreate">
									<input type="hidden" id="LangManager_langUpdId" name="langUpdId">	
									<tr> 
										<td colspan="2" width="100%" class="webformheaderline"></td>    
									</tr>
								
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.lang.langKnd'/></td>
									
										<td class="webformfield">
											
											<select id="LangManager_langKnd" name="langKnd" class='webdropdownlist'>
												<c:forEach items="${langKndList}" var="langKnd">
												<option value="<c:out value="${langKnd.code}"/>"><c:out value="${langKnd.codeName}"/></option>
												</c:forEach>
											</select>
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.lang.langCd'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="LangManager_langCd" name="langCd" value="<c:out value="${aLangVO.langCd}"/>" maxLength="100" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.lang.langDesc'/> *</td>
									
										<td class="webformfield">
											
											<input type="text" id="LangManager_langDesc" name="langDesc" value="<c:out value="${aLangVO.langDesc}"/>" maxLength="100" class="full_webtextfield" />
												
										</td>
										
									</tr>
									
									<tr >
										<td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/admin/images/tb_icon.gif" width="5" height="5" align="absmiddle"> <util:message key='ev.prop.lang.langUpdDate'/></td>
									
										<td class="webformfield"><input type="text" id="LangManager_langUpdDate" name="langUpdDate" value="<c:out value="${aLangVO.langUpdDate}"/>" class="full_webtextfield" /></td>
									</tr>
									
								</table>
								<table style="width:100%;" class="webbuttonpanel">
								<tr>
									<td align="right">  
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_create.gif" hspace="2" style="cursor:hand" onclick="javascript:aLangManager.doCreate()">
										<img src="<%=request.getContextPath()%>/admin/images/button/btn_save.gif" hspace="2" style="cursor:hand" onclick="javascript:aLangManager.doUpdate(true)">
									</td>
								</tr>
								</table>
								</form>
							</div>
						</div> <!--xsl:value-of select="@name"/>Manager_DetailTabPage -->
					
					</div>
					</div> <!-- End LangManager_EditFormPanel -->
				</div> <!-- End webformpanel -->
			</div> <!-- End LangManager_LangTabPage -->
		</div>
	</td>
<tr>
</table>

<div id="LangManager_LangChooser"></div>

