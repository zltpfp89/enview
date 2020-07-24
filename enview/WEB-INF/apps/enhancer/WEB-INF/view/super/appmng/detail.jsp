<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<!-- AppManager_DetailTabPage -->
<div id="AppManager_DetailTabPage" class="board">
	<form id="detailForm" name="detailForm" method="post">
		<input type="hidden" id="appId" value="<c:out value="${app.appId}"/>">
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
	 		<caption>게시판</caption>
			<colgroup>
				<col width="140px" />
				<col width="*" />
				<col width="140px" />
				<col width="*" />
			</colgroup>				
			<tr>
				<th class="L"><util:message key="hn.admin.label.appLangKnd"/></th>
				<td class="L">
					<div class="sel_100">
						<select id="appLangKnd" name="appLangKnd" class="txt_100" onchange="enApp.detailApp(<c:out value="${app.appId}"/>);" disabled="disabled" >
							<c:forEach items="${langKndList }" var="appLangKnd">
								<option value="<c:out value="${appLangKnd.code }"/>" <c:if test="${appLangKnd.code == app.appLangKnd}">selected="selected"</c:if> ><c:out value="${appLangKnd.codeName }"/></option>
							</c:forEach>
						</select>
					</div>
				</td>
				<th class="L"><util:message key="hn.admin.label.appName"/></th>
				<td class="L">
					<input id="appName" type="text" class="txt_200" value="<c:out value="${app.appName }"/>">
				</td>
			</tr>
			<tr>
				<th class="L"><util:message key="hn.admin.label.appVersion"/></th>
				<td class="L">
					<input id="appVersion" type="text" class="txt_200" value="<c:out value="${app.version }"/>">
				</td>
				<th class="L"><util:message key="hn.admin.label.appSkin"/></th>
				<td class="L">
					<c:if test="${empty skinList }">
						<label><util:message key="hn.admin.label.hasNotSkin"/></label>
					</c:if>
					<c:if test="${!empty skinList }">
						<div class="sel_100">
							<select id="skinList" name="skinList" class="txt_100">
								<c:forEach items="${skinList }" var="skin">
									<option value="<c:out value="${skin.skinId }"/>" <c:if test="${skin.isSelected == true}">selected</c:if> ><c:out value="${skin.skinName }"/></option>
								</c:forEach>
							</select>
						</div>
					</c:if>
				</td>
			</tr>
			<tr>
				<th class="L"><util:message key="hn.admin.label.appCode"/></th>
				<td class="L" colspan="3">
					<input id="appCode" name="appCode" class="txt_600" readonly="readonly"  type="text" value="<c:out value="${app.appCode }"/>">
				</td>
			</tr>
			<tr>
				<th class="L"><util:message key="hn.admin.label.appDescription"/></th>
				<td class="L" colspan="3">
					<input id="appDescription" name="appDescription" class="txt_600" type="text" value="<c:out value="${app.description }"/>">
				</td>
			</tr>
		</table>
		<!-- btnArea-->
		<div class="btnArea">
			<div id="AppManager_Child_ListButtons" class="rightArea">
				<a href="javascript:enApp.updateApp();" class="btn_B"><span><util:message key="hn.admin.label.save"/></span></a>
			</div>
		</div>
		<!-- btnArea//-->
	</form>
</div>
<!-- AppManager_DetailTabPage// -->

<script type="text/javascript">
/*
	$('input[name=isAllowed]').each(function(){
		var $this = $(this);
		if($this.val() == '<c:out value="${app.appLangKnd}"/>'){
			$this.attr('checked', 'checked');
		}
	});
*/
</script>