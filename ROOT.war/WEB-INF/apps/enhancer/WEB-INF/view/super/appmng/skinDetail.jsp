<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<!-- RssManager_DetailTabPage -->
<div id="RssManager_DetailTabPage" class="board">
	<form id="detailForm" name="detailForm" method="post">
		<input type="hidden" id="skinId" value="<c:out value="${skin.skinId}"/>">
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<tr>
				<th class="L"><util:message key="hn.admin.label.skinName"/></th>
				<td class="L">
					<input class="text_field" id="skinName" type="text" class="txt_200" value="<c:out value="${skin.skinName }"/>">
				</td>
				<th class="L"><util:message key="hn.admin.label.skinPath"/></th>
				<td class="L">
					<input class="text_field" id="skinPath" type="text" class="txt_200" value="<c:out value="${skin.skinPath }"/>">
				</td>
			</tr>
			<tr>
				<th class="L"><util:message key="hn.admin.label.isUserAllowed"/></th>
				<td class="L" colspan="3">
					<input id="isAllowedY" name="isAllowed" type="radio" value="true"><label for="isAllowedY"><util:message key="hn.admin.label.allowed"/></label>&nbsp;&nbsp;
					<input checked="checked" id="isAllowedN" name="isAllowed" type="radio" value="false"><label for="isAllowedN"><util:message key="hn.admin.label.notAllowed"/></label>
				</td>
			</tr>
		</table>
		<!-- btnArea-->
		<div class="btnArea">
			<div id="RssManager_Child_EditButtons" class="rightArea">
				<a href="javascript:enSkin.updateSkin();" class="btn_B"><span><util:message key="hn.admin.label.save"/></span></a>
			</div>
		</div>
		<!-- btnArea//-->
	</form>
</div>
<!-- RssManager_DetailTabPage// -->	

<script type="text/javascript">
	$('input[name=isAllowed]').each(function(){
		var $this = $(this);
		if($this.val() == '<c:out value="${skin.isAllowed}"/>'){
			$this.attr('checked', 'checked');
		}
	});
</script>