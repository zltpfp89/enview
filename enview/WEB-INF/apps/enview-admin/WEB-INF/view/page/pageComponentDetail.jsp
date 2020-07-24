
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pageComponentManager.js"></script>

<!-- board -->
<div class="board">
	<form id="PageComponentManager_EditForm" style="display:inline" action="" method="post">
		<input type="hidden" id="PageComponentManager_isCreate">
		<input type="hidden" id="PageComponentManager_pageId" name="pageId" />
		<input type="hidden" id="PageComponentManager_pageComponentId" name="pageComponentId" />	
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<caption>게시판</caption>
			<colgroup>
				<col width="120px" />
				<col width="*" />
				<col width="120px" />
				<col width="*" />
			</colgroup>	
			<tr>
				<th class="L"><util:message key='ev.prop.pageComponent.region'/> <em>*</em></th>
				<td class="L">
					<div class="sel_100">
						<select id="PageComponentManager_region" name="region" label="<util:message key='pt.ev.property.region'/>" class='txt_100'>
							<c:forEach items="${regionList}" var="region">
								<option value="<c:out value="${region.code}"/>"><c:out value="${region.codeName}"/></option>
							</c:forEach>
						</select>
					</div>
				</td>
				<th class="L"><util:message key='ev.prop.pageComponent.elementOrder'/></th>
				<td class="L">
					<input type="text" id="PageComponentManager_elementOrder" name="elementOrder" value="<c:out value="${aPageComponentVO.elementOrder}"/>" maxLength="20" label="<util:message key='ev.prop.pageComponent.elementOrder'/>" class="txt_200" />
				</td>
			</tr>
			<tr>
				<th class="L"><util:message key='ev.prop.pageComponent.portletName'/> <em>*</em></th>
				<td colspan="3" class="L">
					<input type="text" id="PageComponentManager_portletName" name="portletName" value="<c:out value="${aPageComponentVO.portletName}"/>" maxLength="50" label="<util:message key='ev.prop.pageComponent.portletName'/>" class="txt_600" style="width:75%;"/>
					<a href="javascript:aPageComponentManager.getPortletChooser().doShow(aPageComponentManager.setPortletChooserCallback)" class="btn_O"><span><util:message key='ev.title.selectPortlet'/></span></a>
				</td>
			</tr>
			<tr>
				<th class="L"><util:message key='ev.prop.pageComponent.parameter'/></th>
				<td colspan="3" class="L">
					<input type="text" id="PageComponentManager_parameter" name="parameter" value="<c:out value="${aPageComponentVO.parameter}"/>" maxLength="120" label="<util:message key='ev.prop.pageComponent.parameter'/>" class="txt_400" />
				</td>
			</tr>	
		</table>
	</form>
	<!-- btnArea-->
	<div class="btnArea">
		<div class="rightArea">
			<a href="javascript:aPageComponentManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
		</div>
	</div>
	<!-- btnArea//-->	
</div>
<!-- board// -->

<div id="PageComponentManager_PageComponentChooser"></div>