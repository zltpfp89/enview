
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/batchResultManager.js"></script>

<!-- BatchResultManager_EditForm -->
<form id="BatchResultManager_EditForm" style="display:inline" action="" method="post">
	<input type="hidden" id="BatchResultManager_isCreate">
	<input type="hidden" id="BatchResultManager_scheduleId" name="scheduleId">	
	<input type="hidden" id="BatchResultManager_actionId" name="actionId">	
	<input type="hidden" id="BatchResultManager_resultId" name="resultId"/>	
	<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
 		<caption>게시판</caption>
		<colgroup>
			<col width="140px" />
			<col width="*" />
			<col width="140px" />
			<col width="*" />
		</colgroup>
		<tr>
			<th class="L"><util:message key='ev.prop.batchAction.actionName'/></th>
			<td class="L">
				<input type="text" id="BatchResultManager_actionName0" name="actionName0" value="<c:out value="${aBatchResultVO.actionName0}"/>" maxLength="" label="<util:message key='ev.prop.batchAction.actionName'/>" class="txt_200" />
			</td>
			<th class="L"><util:message key='ev.prop.batchResult.status'/></th>
			<td class="L">
				<div class="sel_200">
					<span>
						<select id="BatchResultManager_status" name="status" label="<util:message key='ev.prop.batchResult.status'/>" class='txt_100'>
							<c:forEach items="${statusList}" var="status">
								<option value="<c:out value="${status.code}"/>"><c:out value="${status.codeName}"/></option>
							</c:forEach>
					</select>
					</span>
				</div>
			</td>
		</tr>
		<tr >
			<th class="L"><util:message key='ev.prop.batchResult.parameter'/></th>
			<td colspan="3" class="L">
				<input type="text"id="BatchResultManager_parameter" name="parameter" value="<c:out value="${aBatchResultVO.parameter}"/>" maxLength="250" label="<util:message key='ev.prop.batchResult.parameter'/>" class="txt_200" />
			</td>
		</tr>
		<tr >
			<th class="L"><util:message key='ev.prop.batchResult.errorInfo'/></th>
			<td colspan="3" class="L">
				<textarea id="BatchResultManager_errorInfo" name="errorInfo" value="<c:out value="${aBatchResultVO.errorInfo}"/>" maxLength="" cols="80" rows="3" label="<util:message key='ev.prop.batchResult.errorInfo'/>" class="txt_box" ></textarea>
			</td>
		</tr>
		<tr >
			<th class="L"><util:message key='ev.prop.batchResult.executStart'/></th>
			<td class="L">
				<input type="text" id="BatchResultManager_executStart" name="executStart" value="<c:out value="${aBatchResultVO.executStart}"/>" maxLength="" label="<util:message key='ev.prop.batchResult.executStart'/>" class="txt_145" />
			</td>
			<th class="L"><util:message key='ev.prop.batchResult.executEnd'/></th>
			<td class="L">
				<input type="text" id="BatchResultManager_executEnd" name="executEnd" value="<c:out value="${aBatchResultVO.executEnd}"/>" maxLength="" label="<util:message key='ev.prop.batchResult.executEnd'/>" class="txt_145" />
			</td>
		</tr>
		<tr >
			<th class="L"><util:message key='ev.prop.batchResult.updUserId'/></th>
			<td class="L">
				<input type="text" id="BatchResultManager_updUserId" name="updUserId" value="<c:out value="${aBatchResultVO.updUserId}"/>" maxLength="" label="<util:message key='ev.prop.batchResult.updUserId'/>" class="txt_145" />
			</td>
			<th class="L"><util:message key='ev.prop.batchResult.updDatim'/></th>
			<td class="L"><input type="text" id="BatchResultManager_updDatim" name="updDatim" value="<c:out value="${aBatchResultVO.updDatim}"/>" label="<util:message key='ev.prop.batchResult.updDatim'/>" class="txt_145" /></td>
		</tr>			
	</table>	
</form>
<!-- BatchResultManager_EditForm// -->

<div id="BatchResultManager_BatchResultChooser"></div>
