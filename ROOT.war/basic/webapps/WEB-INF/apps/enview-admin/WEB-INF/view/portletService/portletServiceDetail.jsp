
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/portletServiceManager.js"></script>


<form id="PortletServiceManager_EditForm" style="display:inline" action="" method="post">
	<input type="hidden" id="PortletServiceManager_isCreate">
	<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
		<caption>게시판</caption>
		<colgroup>
			<col width="210px" />
			<col width="*" />
			<col width="210px" />
			<col width="*" />
		</colgroup>			
		<tr>
			<th class="L"><util:message key='ev.prop.portletService.serviceId'/> <em>*</em></th>
			<td colspan="3" class="L">
				<input type="text" id="PortletServiceManager_serviceId" name="serviceId" value="<c:out value="${aPortletServiceVO.serviceId}"/>" maxLength="200" label="<util:message key='ev.prop.portletService.serviceId'/>" class="txt_400" />
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.portletService.serviceName'/> <em>*</em></th>
			<td class="L">
				<input type="text" id="PortletServiceManager_serviceName" name="serviceName" value="<c:out value="${aPortletServiceVO.serviceName}"/>" maxLength="60" label="<util:message key='ev.prop.portletService.serviceName'/>" class="txt_200" />
			</td>
			<th class="L"><util:message key='ev.prop.portletService.dataType'/></td>
			<td class="L">
				<div class="sel_100">
					<select id="PortletServiceManager_dataType" name="dataType" class='txt_100'>
						<option value="t" default>TEXT</option>
						<option value="c" default>CSV</option>
						<option value="j" default>JSON</option>
						<option value="x" default>XML</option>
					</select>
				</div>
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.portletService.colDel'/></th>
			<td class="L">
				<input type="text" id="PortletServiceManager_colDel" name="colDel" value="<c:out value="${aPortletServiceVO.colDel}"/>" maxLength="20" label="<util:message key='ev.prop.portletService.colDel'/>" class="txt_200" />
			</td>
			<th class="L"><util:message key='ev.prop.portletService.rowDel'/></th>
			<td class="L">
				<input type="text" id="PortletServiceManager_rowDel" name="rowDel" value="<c:out value="${aPortletServiceVO.rowDel}"/>" maxLength="20" label="<util:message key='ev.prop.portletService.rowDel'/>" class="txt_200" />
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.portletService.serviceType'/></th>
			<td class="L">
				<div class="sel_100">
					<select id="PortletServiceManager_serviceType" name="serviceType" class='txt_200' onchange="aPortletServiceManager.changeServiceType(this)">
						<option value="d" default>데이터베이스 연결</option>
						<option value="h">HTTP 연결</option>
					</select>
				</div>
			</td>
			<th class="L"><util:message key='ev.prop.portletService.titleYn'/></th>
			<td class="L"><input type="checkbox" id="PortletServiceManager_titleYn" name="titleYn" value="" label="<util:message key='ev.prop.portletService.titleYn'/>" /></td>
		</tr>
		<tr id="portletService_dataUrl" style="display:none">
			<th class="L"><util:message key='ev.prop.portletService.dataUrl'/></th>
			<td class="L">
				<input type="text" id="PortletServiceManager_dataUrl" name="dataUrl" value="<c:out value="${aPortletServiceVO.dataUrl}"/>" maxLength="200" label="<util:message key='ev.prop.portletService.dataUrl'/>" class="txt_400" />
			</td>
		</tr>
		
		<tr id="portletService_jndiName" style="display:none">
			<th class="L"><util:message key='ev.prop.portletService.jndiName'/></th>
			<td colspan="3" class="L">
				<input type="text" id="PortletServiceManager_jndiName" name="jndiName" value="<c:out value="${aPortletServiceVO.jndiName}"/>" maxLength="20" label="<util:message key='ev.prop.portletService.jndiName'/>" class="txt_400" />
			</td>
		</tr>
		<tr id="portletService_dbSql" style="display:none">
			<th class="L"><util:message key='ev.prop.portletService.dbSql'/></th>
			<td colspan="3" class="L">
				<textarea id="PortletServiceManager_dbSql" name="dbSql" value="<c:out value="${aPortletServiceVO.dbSql}"/>" cols="80" rows="3" maxLength="2000" label="<util:message key='ev.prop.portletService.dbSql'/>" class="txt_400" >	</textarea>
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.portletService.userParam'/></th>
			<td colspan="3" class="L">
				<input type="text" id="PortletServiceManager_userParam" name="userParam" value="<c:out value="${aPortletServiceVO.userParam}"/>" maxLength="200" label="<util:message key='ev.prop.portletService.userParam'/>" class="txt_400" />
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.portletService.portletParam'/></th>
			<td colspan="3" class="L">
				<input type="text" id="PortletServiceManager_portletParam" name="portletParam" value="<c:out value="${aPortletServiceVO.portletParam}"/>" maxLength="200" label="<util:message key='ev.prop.portletService.portletParam'/>" class="txt_400" />
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.portletService.maxCacheTime'/></th>
			<td class="L">
				<input type="text" id="PortletServiceManager_maxCacheTime" name="maxCacheTime" value="<c:out value="${aPortletServiceVO.maxCacheTime}"/>" maxLength="20" label="<util:message key='ev.prop.portletService.maxCacheTime'/>" class="txt_200" />
			</td>
			<th class="L"><util:message key='ev.prop.portletService.maxCacheSize'/></th>
			<td class="L">
				<input type="text" id="PortletServiceManager_maxCacheSize" name="maxCacheSize" value="<c:out value="${aPortletServiceVO.maxCacheSize}"/>" maxLength="20" label="<util:message key='ev.prop.portletService.maxCacheSize'/>" class="txt_200" />
			</td>
		</tr>
	</table>		
	<!-- btnArea-->
	<div class="btnArea">
		<div class="rightArea">
			<a href="javascript:aPortletServiceManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
		</div>
	</div>
	<!-- btnArea//-->
</form>

<div id="PortletServiceManager_PortletServiceChooser"></div>