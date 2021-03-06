<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%
	//System.out.println("zzzzzzzzzzzzz");
%>
<!--div id="PortletSelectorDialog" title="<util:message key='pt.ev.property.portletCategoryTree'/>" style="display:none;"-->
<table width="100%" height="400" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td valign='top'>
			<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
			<tr>
				<td valign="top">
					<form id='PortletSelectorSearchForm' name='PortletSelectorSearchForm' style='display:inline' action="javascript:portalPortletSelector.doPortletSearch('PortletSelectorSearchForm')" onkeydown="if(event.keyCode==13) portalPortletSelector.doPortletSearch('PortletSelectorSearchForm')" method='post'>
						<input type='hidden' name='sortMethod' value='ASC'/>
						<input type='hidden' name='sortColumn' value=''/>
						<input type='hidden' name='pageNo' value='1'/>
						<input type='hidden' name='allowDuplicate' value='true'/> 
						<input type='hidden' name='pageFunction' value='portalPortletSelector.doPortletPage'/>
						<input type='hidden' name='formName' value='PortletSelectorSearchForm'/>
						<table width='100%' border='0' cellspacing='0' cellpadding='0'>
						<tr>
							<td align='right'>
								<select id="portletCategory" name="portletCategory" class='webdropdownlist'>
									<option value=""><util:message key='ev.title.page.portletCategoryTree'/></option> 
									<c:forEach items="${portletCategory}" var="category">
									<option value="<c:out value="${category}"/>"><c:out value="${category}"/></option>
									</c:forEach>
								</select>
								<input type='text' name='title0Cond' size='20' class='portlet-form-field-label' value="*<util:message key='ev.title.page.portletSelectorPortletName'/>*" onfocus="portalPage.getUtility().setFieldFocus(this,'*<util:message key='ev.title.page.portletSelectorPortletName'/>*');" onblur="portalPage.getUtility().setFieldBlur(this,'*<util:message key='ev.title.page.portletSelectorPortletName'/>*');">
								<select name='pageSize'>
									<option value="5">5</option>
									<option value="10" selected>10</option>
									<option value="20" >20</option>
									<option value="50">50</option>
									<option value="100">100</option>
								</select>
								<span class="btn_pack small"><a href="javascript:portalPortletSelector.doPortletSearch('PortletSelectorSearchForm')"><util:message key='ev.title.search'/></a></span>
							</td>
						</tr>
						</table>
					</form>
					<form style='display:inline' name='PortletSelectorListForm' action='' method='post'>
						<div id='PortletSelectorListForm'>
							
						</div>
					</form>
						<div class="webformpanel">
							<input type="text" id="PortletSelectorDialog_selected" class="full_webtextfield" />
						</div>
				</td>
			</tr>
			</table>
		</td>
	</tr>
</table>
<!--/div-->
