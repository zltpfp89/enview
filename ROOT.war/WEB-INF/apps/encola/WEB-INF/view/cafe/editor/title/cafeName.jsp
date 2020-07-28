<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="previewPanel">
	<div id="previewCafeNm" class="previewCafeNm"><c:out value="${cmntVO.cmntNm }"/></div>
</div>
<br>
<div class="cafeNameEditPanel">
	<div class="editorWideRow">
		<div class="fontName">
			<div class="editorLabel"><util:message key="cf.prop.fontName"/></div>
			<select id="CF0103_fontNm" name="fontNm" class="fontNameSelect">
				<option value="굴림" selected="selected">굴림</option>
				<option value="돋움">돋움</option>
				<option value="바탕">바탕</option>
				<option value="궁서">궁서</option>
				<option value="serif">serif</option>
				<option value="sans-serif">sans-serif</option>
				<option value="cursive">cursive</option>
			</select>
		</div>
		<div class="fontSize">
			<div class="editorLabelCenter"><util:message key="cf.prop.size"/></div>
			<select id="CF0103_fontSize" name="fontSize" class="fontSizeSelect">
				<option value="11px" selected="selected">11px</option>
				<option value="12px">12px</option>
				<option value="13px">13px</option>
				<option value="14px">14px</option>
				<option value="17px">17px</option>
				<option value="20px">20px</option>
				<option value="24px">24px</option>
				<option value="28px">28px</option>
				<option value="35px">35px</option>
				<option value="45px">45px</option>
			</select>
		</div>
		<div class="fontColor">
			<div class="editorLabelCenter2"><util:message key="cf.prop.fontColor"/></div>
			<div id="CF0103_fontColor" class="fontColorPicker" onclick="javascript:cfColorPicker.initialize('CF0103_fontColor', cfTitleEditor.setCafeNmColor);"></div>
		</div>
	</div>
</div>