<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="bgDescriptionPanel">
	<input type="radio" value="design" id="design" class="editorRadio" name="pttrn" onchange="javascript:cfTitleEditor.showTemplateEditor('CF0102', 312, 240);"><label class="editorLabel" for="design"><util:message key="cf.prop.design"/></label>
	<input type="radio" value="color"  id="color"  class="editorRadio" name="pttrn" checked="checked" ><label class="editorLabel" for="color"><util:message key="cf.prop.color"/></label>
	<input type="radio" value="custom" id="custom" class="editorRadio" name="pttrn" onchange="javascript:cfTitleEditor.showBackgroundEditor('Custom', 220);"><label class="editorLabel" for="custom"><util:message key="cf.prop.directUpload"/></label>
</div>
<div class="bgColorPangel">
	<div id="bgPreviewPanel" class="bgPreviewPanel">
		<div id="colorPanel" class="colorPanel"></div>
	</div>
	<div class="bgColorControlPanel">
		<div class="editorRow">
			<div id="bgColor" class="editorLabel"><util:message key="cf.prop.backgroundColor"/></div>
			<div id="bgColorPicker" class="colorPicker" onclick="javascript:cfColorPicker.initialize('bgColorPicker', cfTitleEditor.setBgColor);"></div>
		</div>
		<div class="editorRow">
			<div id="bgBorder" class="editorLabel"><util:message key="cf.prop.border"/></div>
			<div id="titleBgBrdrStyle" class="titleBgbrdrStylePicker" onclick="javascript:cfBorderPicker.initialize('titleBgBrdrStyle', 8322, 0, 5, 'titleBgBrdrStyle', cfTitleEditor.setBgBrdrStyle);"></div>
			<div id="borderColorPicker" class="colorPicker" onclick="javascript:cfColorPicker.initialize('borderColorPicker', cfTitleEditor.setBgBrdrColor);"></div>
		</div>
		<div class="editorRow">
			<div id="editorLabel" class="editorLabel"><util:message key="cf.prop.transparency"/></div>
			<div id="trpcValueControler" class="trpcValueControler">
				<div id="bgTrcpslide_minus" class="sliderBtn bgTrcpslideMinus"></div>
				<div id="bgTrcpslideBar" class="bgTrcpslideBar">
					<div id="bgTrcpslideSelector" class="bgTrcpslideSelector"></div>
				</div>
				<div id="bgTrcpslide_plus" class="sliderBtn bgTrcpslidePlus"></div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	 $('#bgColor').css('float', 'left');
	 $('#bgColor').css('width', '50px');
	 
	 $('#bgBorder').css('float', 'left');
	 $('#bgBorder').css('width', '50px');
	 
	 $('#editorLabel').css('width', '45px');
</script>