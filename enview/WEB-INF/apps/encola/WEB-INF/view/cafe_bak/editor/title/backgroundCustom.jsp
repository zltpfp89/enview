<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="bgDescriptionPanel">
	<input type="radio" value="design" id="design" class="editorRadio" name="pttrn"	onchange="javascript:cfTitleEditor.showTemplateEditor('CF0102', 312, 240);"><label class="editorLabel" for="design">디자인</label>
	<input type="radio" value="color" id="color" class="editorRadio" name="pttrn" onchange="javascript:cfTitleEditor.showBackgroundEditor('Color', 200);"><label class="editorLabel" for="color">색상</label>
	<input type="radio" value="custom" id="custom" class="editorRadio" name="pttrn" checked="checked"><label class="editorLabel" for="custom">직접올리기</label>
</div>
<div class="bgCustomPangel">
	<div id="bgImagePreviewPanel" class="bgImagePreviewPanel">
		<img id="previewUserImage" width="140" height="80" alt="배경썸네일" src="../cola/cafe/each/<c:out value="${cmntVO.cmntId }"/>/TITLE_BG_IMG_IMSI?dummy=<c:out value="${dummy}"/>">
		<a class="imgLink" id="delPhoto" style="display: none;" onclick="cfTitleEditor.delPreviewImage();"><util:message key="ev.title.remove"/></a>
	</div>
	<div class="bgImageControlPanel">
		<div class="bgImageRow">
			<label class="titleBgFileLabel">이미지</label>
			<form class="titleBgFileForm" id="titleBgFileForm" name="titleBgFileForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
				<input class="titleBgFile" type="file" id="titleBgFile" name="file" onchange="cfTitleEditor.uploadTitleBgImage();">
			</form>
			<iframe id="titleBgIFrame" name="titleBgIFrame" frameborder=0 width=0 height=0></iframe>
			<div class="titleBgHelp">1MB 이하 / jpg, gif</div>
			<div class="titleBgHelp">가로 929px</div>
		</div>
		<div class="bgImageRow2">
			<label class="titleBgFileLabel">크기</label>
			<select style="float:right;" id="titleBgImgRepeat" disabled="disabled">
				<option selected="selected" value="no-repeat">원래크기</option>
				<option value="repeat">전체반복</option>
			</select>
		</div>
		<div class="bgImageRow2">
			<label class="titleBgFileLabel">배경</label>
		    <div id="CF0102_bgColor" class="colorPicker" style="margin-left: 24px;"></div>
		</div>
		<div class="bgImageRow2">
			<label class="titleBgFileLabel">위치</label>
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