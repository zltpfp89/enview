<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/fileManager.js"></script>

<form id="FileManager_EditForm" style="display:inline" action="" method="post">
	<input type="hidden" id="FileManager_isCreate">
	<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
		<caption>게시판</caption>
		<colgroup>
			<col width="110px" />
			<col width="*" />
		</colgroup>
		<tr>
			<th class="L"><util:message key='ev.title.file.path'/></th>
			<td class="L">
				<input type="text" id="FileManager_filePath" name="filePath" readonly="readonly" value="<c:out value="${aFileVO.filePath}"/>" maxLength="" label="<util:message key='ev.title.file.path'/>" class="txt_600" />
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.title.file.name'/></th>
			<td class="L">
				<input type="text" id="FileManager_fileName" name="fileName" value="<c:out value="${aFileVO.fileName}"/>" maxLength="" label="<util:message key='ev.title.file.name'/>" class="txt_600" />
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.title.file.size'/></th>
			<td class="L">
				<input type="text" id="FileManager_fileSize" name="fileSize"  readonly="readonly" value="<c:out value="${aFileVO.fileSize}"/>" maxLength="" label="<util:message key='ev.title.file.size'/>" class="txt_600" />
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.title.file.modifiedDate'/></th>
			<td class="L"><input type="text" id="FileManager_modifiedDate" name="modifiedDate" value="<c:out value="${aFileVO.modifiedDate}"/>" label="<util:message key='ev.title.file.modifiedDate'/>" class="txt_145" /></td>
		</tr>
		<tr>
		    <th class="L">
				<util:message key='ev.title.file.Preview'/>
			</th>
			<td class="L">
				<center><img id="targetImg"></center>
			</td>
		</tr>
   </table>
</form>
<!-- btnArea-->
<div class="btnArea">
	<div class="rightArea">
		<a href="javascript:aFileManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
	</div>
</div>
<!-- btnArea//-->	

<div id="FileManager_FileChooser"></div>