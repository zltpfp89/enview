
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/pageMetadataManager.js"></script>

<!-- board -->
<div class="board">
	<form id="PageMetadataManager_EditForm" style="display:inline" action="" method="post">
		<input type="hidden" id="PageMetadataManager_isCreate">
		<input type="hidden" id="PageMetadataManager_metadataId" name="metadataId">	
		<input type="hidden" id="PageMetadataManager_pageId" name="pageId">	
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<caption>게시판</caption>
			<colgroup>
				<col width="120px" />
				<col width="*" />
				<col width="120px" />
				<col width="*" />
			</colgroup>
			<tr>
				<th class="C"><util:message key='ev.title.page.metaName'/> <em>*</em></th>
				<td class="L">
					<div class="sel_100">
						<select id="PageMetadataManager_name" name="name" class="txt_100">
							<option value="title" selected>title</option>
							<option value="short-title">short-title</option>
						</select>
					</div>
				</td>
				<th class="C"><util:message key='ev.prop.pageMetadata.locale'/></th>
				<td class="L">
					<div class="sel_100">
						<select id="PageMetadataManager_locale" name="locale" class="txt_100">
							<c:forEach items="${localeList}" var="locale">
								<option value="<c:out value="${locale.code}"/>"><c:out value="${locale.codeName}"/></option>
							</c:forEach>
						</select>
					</div>
				</td>
			</tr>
			<tr >
				<th class="C"><util:message key='ev.prop.pageMetadata.value'/> <em>*</em></th>
				<td colspan="3" class="L">
					<input type="text" id="PageMetadataManager_value" name="value" value="<c:out value="${aPageMetadataVO.value}"/>" maxLength="100" label="<util:message key='ev.prop.pageMetadata.value'/>" class="txt_400" />
				</td>
			</tr>
		</table>
	</form>
		<!-- btnArea-->
		<div class="btnArea">
			<div class="rightArea">
				<a href="javascript:aPageMetadataManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
			</div>
		</div>
		<!-- btnArea//-->
</div>
<!-- board// -->

<div id="PageMetadataManager_PageMetadataChooser"></div>