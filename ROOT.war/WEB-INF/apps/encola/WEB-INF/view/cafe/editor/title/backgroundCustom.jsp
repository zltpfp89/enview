<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="bgDescriptionPanel">
	<input type="radio" value="design" id="design" class="editorRadio" name="pttrn"	onchange="javascript:cfTitleEditor.showTemplateEditor('CF0102', 312, 240);"><label class="editorLabel" for="design"><util:message key="cf.prop.design"/></label>
	<input type="radio" value="color" id="color" class="editorRadio" name="pttrn" onchange="javascript:cfTitleEditor.showBackgroundEditor('Color', 200);"><label class="editorLabel" for="color"><util:message key="cf.prop.color"/></label>
	<input type="radio" value="custom" id="custom" class="editorRadio" name="pttrn" checked="checked"><label class="editorLabel" for="custom"><util:message key="cf.prop.directUpload"/></label>
</div>
<div class="bgCustomPangel">
	<div id="bgImagePreviewPanel" class="bgImagePreviewPanel">
		<img id="previewUserImage" width="140" height="80" alt="배경썸네일" src="../cola/cafe/each/<c:out value="${cmntVO.cmntId }"/>/TITLE_BG_IMG_IMSI?dummy=<c:out value="${dummy}"/>">
		<a class="imgLink" id="delPhoto" style="display: none;" onclick="cfTitleEditor.delPreviewImage();"><util:message key="ev.info.menu.delete"/></a>
	</div>
	<div class="bgImageControlPanel">
		<div class="bgImageRow">
			<label class="titleBgFileLabel">이미지</label>
			<form class="titleBgFileForm" id="titleBgFileForm" name="titleBgFileForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
				<input class="titleBgFile" type="file" id="titleBgFile" name="file" onchange="cfTitleEditor.uploadTitleBgImage();">
			</form>
			<iframe id="titleBgIFrame" name="titleBgIFrame" frameborder=0 width=0 height=0></iframe>
			<c:if test="${langKnd eq 'ko' }">
				<div class="titleBgHelp">1MB 이하 / jpg, gif</div>
				<div class="titleBgHelp">가로 929px</div>
   			</c:if>
   			<c:if test="${langKnd eq 'en' }">
   				<div class="titleBgHelp">1MB / jpg, gif</div>
				<div class="titleBgHelp">929px</p>
   			</c:if>
		</div>
		<div class="bgImageRow2">
			<label class="titleBgFileLabel"><util:message key="cf.prop.size"/></label>
			<select style="float:right;" id="titleBgImgRepeat" disabled="disabled">
				<option selected="selected" value="no-repeat"><util:message key="cf.prop.originalSize"/></option>
				<option value="repeat"><util:message key="cf.prop.repeat.all"/></option>
			</select>
		</div>
		<div class="bgImageRow2">
			<label class="titleBgFileLabel"><util:message key="cf.prop.background"/></label>
		    <div id="CF0102_bgColor" class="colorPicker" style="margin-left: 24px;"></div>
		</div>
		<div class="bgImageRow2">
			<label class="titleBgFileLabel"><util:message key="cf.prop.location"/></label>
			<div id="CAFEBACKGROUND_bgImgPos" class="positionPickerPanel" style="margin-left: 24px;">
				<div id="CF0102_bgImgPos" class="positionPicker alignPickerPanel"></div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	var src = $('#previewUserImage').attr('src');
	$('#previewUserImage').attr('src', src + '?dummy=' + Math.random());
</script>