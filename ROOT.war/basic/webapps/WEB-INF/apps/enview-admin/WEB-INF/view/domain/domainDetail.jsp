
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="L" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/domainManager.js"></script>

<form id="DomainManager_EditForm" style="display:inline" action="" method="post">
	<input type="hidden" id="DomainManager_isCreate">
	<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
		<caption>게시판</caption>
		<colgroup>
			<col width="140px" />
			<col width="*" />
			<col width="140px" />
			<col width="*" />
		</colgroup>
		<tr>
			<th class="L"><util:message key='mm.prop.domain.domainId'/></th>
			<td class="L">
				<input type="text" id="DomainManager_domainId" name="domainId" value="<c:out value="${aDomainVO.domainId}"/>" readonly="readonly" maxLength="" label="<util:message key='mm.prop.domain.domainId'/>" class="txt_145" />
			</td>
			<th class="L"><util:message key='mm.prop.domain.domainCode'/> <em>*</em></th>
		   	<td class="L">
				<input type="text" id="DomainManager_domainCode" name="domainCode" value="<c:out value="${aDomainVO.domainCode}"/>" maxLength="" label="<util:message key='mm.prop.domain.domainCode'/>" class="txt_145" />
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='mm.prop.domain.domain'/> <em>*</em></th>
			<td class="L" colspan="3">
				<input type="text" id="DomainManager_domain" name="domain" value="<c:out value="${aDomainVO.domain}"/>" maxLength="" label="<util:message key='mm.prop.domain.domain'/>" class="txt_400" />
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='mm.prop.domain.domainNm'/> <em>*</em></th>
		   	<td class="L">
				<input type="text" id="DomainManager_domainNm" name="domainNm" value="<c:out value="${aDomainVO.domainNm}"/>" maxLength="" label="<util:message key='mm.prop.domain.domainNm'/>" class="txt_145" />
			</td>
			
			<th class="L"><util:message key='mm.prop.domain.pagePath'/> </th>
		   	<td class="L">
				<input type="text"  id="DomainManager_pagePath" name="pagePath" value="<c:out value="${aDomainVO.pagePath}"/>" readonly="readonly" maxLength="" label="<util:message key='mm.prop.domain.pagePath'/>" class="txt_145" />
			</td>
		</tr>
		<tr>
		    <th class="L"><util:message key='mm.prop.domain.useYn'/></th>
			<td class="L">
				<div class="sel_100">
					<select id="DomainManager_useYn" name="useYn" class="txt_100">
						<option value="Y">Y</option>
					  	<option value="N">N</option>
					</select>
			    </div>
			</td>
			<th class="L"><util:message key='mm.prop.domain.loginPage'/></th>
			<td class="L">
				<input type="text"  id="DomainManager_loginPage" name="loginPage" value="<c:out value="${aDomainVO.loginPage}"/>"  maxLength="" label="<util:message key='mm.prop.domain.loginPage'/>" class="txt_145" />
			</td>
		</tr>
		<tr>	
			<th class="L"><util:message key='mm.prop.domain.updUserId'/></th>
			<td class="L">
				<input type="text" id="DomainManager_updUserId" name="updUserId" value="<c:out value="${aDomainVO.updUserId}"/>" maxLength="" label="<util:message key='mm.prop.domain.updUserId'/>" readonly="true" class="txt_145" />
			</td>
			<th class="L"><util:message key='mm.prop.domain.updDatim'/></th>
			<td class="L"><input type="text" id="DomainManager_updDatim" name="updDatim" value="<c:out value="${aDomainVO.updDatimByFormat}"/>" label="<util:message key='mm.prop.domain.updDatim'/>" readonly="true" class="txt_145" /></td>
		</tr>			
	</table>			
</form>
<!-- btnArea-->
<div class="btnArea">
	<div class="rightArea">
		<a href="javascript:aDomainManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
	</div>
</div>
<!-- btnArea//-->	

<div id="DomainManager_DomainChooser"></div>