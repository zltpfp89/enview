
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/langManager.js"></script>


<table width="100%" height="400px" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td valign='top'>
			<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
			<tr>
				<td valign="top">
					<div class="webpanel">
						<div id="LangChooser_ListTabPage" style="width:100%; height:300px;"> 
							<div class="webformpanel">
								<form id="LangChooser_SearchForm" name="LangChooser_SearchForm" style="display:inline" action="javascript:aLangChooser.doSearch('LangChooser_SearchForm')" method="post">
									<div>
									  <table width="100%">
										<input type='hidden' name='sortMethod' value='ASC'/>                    
										<input type='hidden' name='sortColumn' value=''/>  
										<input type='hidden' name='pageNo' value='1'/>
										<!--input type='hidden' name='pageSize' value='10'/-->
										<input type='hidden' name='pageFunction' value='aLangChooser.doPage'/>
										<input type='hidden' name='formName' value='LangChooser_SearchForm'/>
										
									  <tr>
										<td align="right">
										
											<input type="text" name="langCdCond" size="" class="webtextfield" value="*<util:message key='ev.prop.lang.langCd'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.lang.langCd'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.lang.langCd'/>*');"/> 
														
											<input type="text" name="langDescCond" size="" class="webtextfield" value="*<util:message key='ev.prop.lang.langDesc'/>*" onfocus="whenSrchFocus(this,'*<util:message key='ev.prop.lang.langDesc'/>*');" onblur="whenSrchBlur(this,'*<util:message key='ev.prop.lang.langDesc'/>*');"/> 
														
											<select name='pageSize'>
												<option value="5">5</option>
												<option value="10">10</option>
												<option value="20">20</option>
												<option value="50">50</option>
												<option value="100">100</option>
											</select>
											<input type="image" src="<%=request.getContextPath()%>/admin/images/button/btn_search.gif" hspace="2" align="absmiddle" style="cursor:hand">
										</td>
									  </tr>
									  </table>    
									</div>
								</form>
								<form id="LangChooser_ListForm" style="display:inline" name="ListForm" action="" method="post">
									<div class="webgridpanel" style="overflow:auto; ">
										<table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
											<thead>
												<tr> 
													<td colspan="100" class="webgridheaderline"></td>
												</tr>
												<tr style="cursor: pointer;">
													<th class="webgridheader" align="center" width="30px">
														<input type="checkbox" id="delCheck" class="webcheckbox" onclick="aLangChooser.m_checkBox.chkAll(this)"/>
													</th>
													<th class="webgridheader" align="center" width="30px">No</th>
												
													<th class="webgridheader" ch="0" onclick="aLangChooser.doSort(this, 'LANG_KND');" >
														<span ><util:message key='ev.prop.lang.langKnd'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aLangChooser.doSort(this, 'LANG_CD');" >
														<span ><util:message key='ev.prop.lang.langCd'/></span>
													</th>	
													<th class="webgridheader" ch="0" onclick="aLangChooser.doSort(this, 'LANG_DESC');" >
														<span ><util:message key='ev.prop.lang.langDesc'/></span>
													</th>				
												</tr>
											</thead>
											<tbody id="LangChooser_ListBody"></tbody>
										</table>
										<div id="LangChooser_ListMessage"/>
									</div>
									<table style="width:100%;" class="webbuttonpanel">
										<tr>
											<td align="center">
											<div id="LangChooser_PAGE_ITERATOR" class="webnavigationpanel"></div>
											</td>   
										</tr>
									</table>
								</form>
							</div>
						</div>
					</div>
				</td>
			</tr>
			</table>
		</td>
	</tr>
</table>

