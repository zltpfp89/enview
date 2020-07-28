<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/batchActionManager.js"></script>

<!-- BatchActionManager_EditForm -->
<form id="BatchActionManager_EditForm" style="display:inline" action="" method="post">
	<input type="hidden" id="BatchActionManager_isCreate">
	<input type="hidden" id="BatchActionManager_actionId" name="actionId" />
	<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
 		<caption>게시판</caption>
		<colgroup>
			<col width="140px" />
			<col width="*" />
			<col width="140px" />
			<col width="*" />
		</colgroup>
		<tr>
			<th class="L"><util:message key='ev.prop.batchAction.name'/> <em>*</em></th>
			<td class="L">
				<input type="text" id="BatchActionManager_name" name="name" value="<c:out value="${aBatchActionVO.name}"/>" maxLength="100" label="<util:message key='ev.prop.batchAction.name'/>" class="txt_200" />
			</td>
			<th class="L"><util:message key='ev.prop.batchAction.useYn'/></th>
			<td class="L"><input type="checkbox" id="BatchActionManager_useYn" name="useYn" value="" label="<util:message key='ev.prop.batchAction.useYn'/>" class="txt_100" /></td>
		</tr>
		<tr>	
			<th class="L"><util:message key='ev.prop.batchAction.actionName'/> <em>*</em></th>
			<td colspan="3" class="L">
				<div class="sel_200">
					<select id="BatchActionManager_actionType" name="actionType" class='txt_200'>
						<option value="01">Shell Script File</option>
						<option value="02">Quartz Job Class</option>
					</select>
				</div>
				<input type="text" id="BatchActionManager_program" name="program" value="<c:out value="${aBatchActionVO.program}"/>" maxLength="255" label="<util:message key='ev.prop.batchAction.program'/>" class="txt_100" style="width:70%;"/>
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.batchAction.parameter'/></th>
			<td colspan="3" class="L">
				<input type="text" id="BatchActionManager_parameter" name="parameter" value="<c:out value="${aBatchActionVO.parameter}"/>" maxLength="250" label="<util:message key='ev.prop.batchAction.parameter'/>" class="txt_200" />
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.batchAction.updUserId'/></th>
			<td class="L">
				<input type="text" id="BatchActionManager_updUserId" name="updUserId" value="<c:out value="${aBatchActionVO.updUserId}"/>" maxLength="" label="<util:message key='ev.prop.batchAction.updUserId'/>" class="txt_200" />
			</td>
			<th class="L"><util:message key='ev.prop.batchAction.updDatim'/></th>
			<td class="L"><input type="text" id="BatchActionManager_updDatim" name="updDatim" value="<c:out value="${aBatchActionVO.updDatim}"/>" label="<util:message key='ev.prop.batchAction.updDatim'/>" class="txt_200" /></td>
		</tr>								
	</table>
	<!-- btnArea-->
	<div class="btnArea">
		<div class="rightArea">
			<a href="javascript:aBatchActionManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
		</div>
	</div>
	<!-- btnArea//-->			
</form>
<!-- BatchActionManager_EditForm// -->

<div id="BatchActionManager_BatchActionChooser"></div>