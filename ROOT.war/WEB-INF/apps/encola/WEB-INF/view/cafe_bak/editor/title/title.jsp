<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	int contextRootIndex = request.getRequestURL().indexOf("/enview");
	String domain = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
	
%>
<html>
	<head>
		<title>타이틀 꾸미기</title>
		
		<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9" />
		<meta name="version" content="3.2.4" />
		<meta name="keywords" content="" />
		
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/decorations/layout/css/jquery/base/jquery.ui.all.css" />
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/css/editor/color_picker.css" />
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/css/editor/border_picker.css" />
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/css/editor/align_picker.css" />
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/css/editor/dialog.css" />
		<link rel="stylesheet" type="text/css" media="screen, projection" href="<%=request.getContextPath()%>/cola/cafe/css/editor/title.css" />
		
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/ui/i18n/jquery.ui.datepicker-<c:out value="${cmntVO.langKnd}"/>.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_ko_mm.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_ko_cf.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
				
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_util.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/each/encafe.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/editor/ggum.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/editor/editor.js"></script>
		<script type="text/javascript">
			var contextPath = '<%=request.getContextPath()%>';
			var cafeUrl = '<c:out value="${form.cafeUrl}"/>';
			cfEach.m_contextPath = contextPath;
			cfEach.m_curCafeUrl = cafeUrl;
			
			cfTitleEditor.m_contextPath = contextPath;
			cfTitleEditor.m_curCafeUrl = cafeUrl;
		</script>	
	</head>
	<body marginwidth="0" marginheight="0" class="CF0802_bgImage CF0802_bgColor CF0802_bgImgPos CF0802_bgImgRepeat">
		<!--
		<div id="edit_menu_bar" class="edit_menu_bar edit_hidden">
			<div id="encafelogo" class="encafelogo">
				<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/adminLogo.gif" onclick="cfInfo.go2Jigi();" alt="카페관리" title="클릭하시면 카페관리화면으로 이동합니다."/>
				<span class="name" onclick="javascript:cfEach.go2EachHome();" title="클릭하시면 꾸미기를 종료합니다"><c:out value="${cmntVO.cmntNm}"/></span>
			</div>
		</div>
		  -->
		<div id="cafe_title_wrap" class="cafe_title_wrap draggable">
			<div class="cafetitle" id="div_cafe_title">
				<div id="titleArea" class="CF0102_bgHeight titleArea">
					<div id="title_background" class="CF0102_bgColor CF0102_brdrColor CF0102_brdrStyle CF0102_brdrWidth CF0102_trpcValue CF0102_bgImage CF0102_bgImgRepeat CF0102_bgImgPos title_background"></div>
					<div id="grid_background" class="gridArea"></div>
					<div class="emptyArea" id="emptyArea"></div>
					<div class="dragArea" id="dragArea"></div>
					<div class="heightResizeBar" id="resizeBar">
						<div class="resizeBar"></div>
						<img class="resizeButton" src="<%=request.getContextPath() %>/cola/cafe/images/editor/title/resizeBtn.gif" width="71" height="18"/>
					</div>
					<div class="CF0103_display CF0103_fontNm CF0103_fontSize CF0103_fontColor CF0103_position title_cafeName" id="title_cafeName"><c:out value="${cmntVO.cmntNm }"/></div>
					<div class="CF0104_display CF0104_fontNm CF0104_fontSize CF0104_fontColor CF0104_position title_cafeUrl" id="title_cafeUrl"><%=domain%>/cafe/<c:out value="${cmntVO.cmntUrl }"/></div>
					<div id="title_cafeMenus" class="CF0105_display CF0105_position CF0105_bgColor CF0105_brdrStyle CF0105_brdrWidth CF0105_brdrColor title_cafeTitleMenus">
						<c:forEach items="${ menuList }" var="menu" varStatus="status">
							<c:if test="${status.count != 2 }">
								<div class="CF0105_fontNm CF0105_baseFontColor title_cafeTitleMenu" id="titmeMenu_<c:out value="${menu.menuId}"/>"><c:out value="${menu.menuNm}"/></div>
							</c:if>
							<c:if test="${status.count == 2 }">
								<div class="CF0105_fontNm CF0105_selFontColor title_cafeTitleMenu" id="titmeMenu_<c:out value="${menu.menuId}"/>"><c:out value="${menu.menuNm}"/></div>
							</c:if>
							<c:if test="${status.count != 4 }">
								<div class="CF0105_baseFontColor title_cafeTitleMenuPipe">|</div>
							</c:if>
						</c:forEach>
					</div>
					<!--div class="CF0106_position title_cafeSearch">
						<input class="CF0106_fieldBgColor CF0106_fieldFontColor CF0106_brdrStyle title_cafeSearchField" type="text" id="titleSearchField">
						<input class="CF0106_btnBgColor CF0106_btnFontColor title_cafeSearchButton" type="button" id="titleSearchButton" value="검색">
					</div-->
					<div class="title_counter"></div>
				</div>
			</div>
		</div>
		<div class="menuArea">
			<div class="leftMenu">
				<div class="menuEditor templateEditor"><div class="menu menuEditorLabel" onclick="javascript:cfTitleEditor.showTemplateEditor('CF0101', 525, 490, 1);">템플릿</div></div>
				<div class="menuEditor cafeBgEditor"><div class="menu menuEditorLabel" onclick="javascript:cfTitleEditor.showTemplateEditor('CF0102', '312', 245, 1);">배경</div></div>
				<div class="menuEditor cafeNameEditor"><div class="menu menuEditorLabel" onclick="javascript:cfTitleEditor.showCafeNameEditor();"><util:message key="cf.title.cafe.name"/><%--카페이름--%></div></div>
				<div class="menuEditor cafeUrlEditor"><div class="menu menuEditorLabel" onclick="javascript:cfTitleEditor.showCafeUrlEditor();">카페주소</div></div>
				<div class="menuEditor cafeTitleMenuEditor"><div class="menu menuEditorLabel" onclick="javascript:cfTitleEditor.showTemplateEditor('CF0105',500, 225, 1);">타이틀 메뉴</div></div>
				<!-- div class="menuEditor cafeSearchEditor"><div class="menu menuEditorLabel" onclick="javascript:cfTitleEditor.showTemplateEditor('CF0106', 260, 410, 1);">검색창</div></div>
				<div class="menuEditor cafeCounterEditor"><div class="menu menuEditorLabel" onclick="javascript:cfTitleEditor.showTemplateEditor('CF0107', 520, 530, 1);">카운터</div></div-->
			</div>
			<div class="rightMenu">
				<div class="menuController bgHeightController">
					<div class="menu menuControlLabel bgHeightLabel">높이</div>
					<div class="heightSetting">
						<input type="text" class="heightFeild" name="CF0102_bgHeight" id="CF0102_bgHeight" value="0" size="3" maxlength="3" onkeyup="javascript:cfTitleEditor.setHeightField(event)">
						<div class="heightInput" onclick="javascript:cfTitleEditor.setHeightFieldForClick()"></div>
					</div>
				</div>
				<div class="menuController gridController">
					<input type="checkbox" name="grid" id="gridCheck" class="gridCheckbox" onclick="javascript:cfTitleEditor.toggleGridArea()" />
					<label for="gridCheck" class="menu menuControlLabel">안내선</label>
				</div>
				<div class="menuController resetController"><div class="menu menuControlLabel resetBtn" onclick="javascript:cfTitleEditor.reset();">원래대로</div></div>
			</div>
		</div>
		
		<div id="bottomButtons" class="bottomButtons">
			<%--<div class="bottomButton previewBtn" onclick="javascript:cfTitleEditor.onClickPreview();"></div>--%>
			<div class="rightBottomButton">
				<div class="bottomButton okBtn" onclick="javascript:cfTitleEditor.onClickApply();"></div>
				<div class="bottomButton cancelBtn" onclick="javascript:cfTitleEditor.onClickCancel();"></div>
			</div>
		</div>
		
		
		<div id="editorArea" class="editorArea"></div>
		<form id="goEditPage" name="goEditPage" method="POST">
			<input type="hidden" id="isEditMode" name="isEditMode" value="true"/>
			<input type="hidden" id="decoId" name="decoId" value="">
		</form>
		<div id="decoTemplates">
		<input type="hidden" id="CF0101_decoPrefs" name="decoPrefs" value="[ 
			<c:forEach items="${decoPrefs}" var="deco" varStatus="status">
			{ clazz:'<c:out value="${deco.decoType}"/>_<c:out value="${deco.name}"/>', value:'<c:out value="${deco.value}"/>'}<c:if test="${!status.last}">,</c:if>
			</c:forEach>
		]"/>
		</div>
		<div id="maskLayer" class="maskLayer">
			<div class="buttonLayer">
				<div id="editBtn" class="editBtn"></div>
				<div id="deleteBtn" class="deleteBtn"></div>
			</div>
		</div>
		<input type="hidden" id="CF0101_template" value="">
		<input type="hidden" id="CF0101_decoId"   value="">
		<input type="hidden" id="CF0102_template" value="">
		<input type="hidden" id="CF0102_decoId"   value="">
		<input type="hidden" id="CF0105_template" value="">
		<input type="hidden" id="CF0105_decoId"   value="">
	</body>
	<script type="text/javascript">
		var infoBox = cfEach.getInfoBox();
	   	infoBox.m_on = "client";
	   	infoBox.m_target = "title";
	   	infoBox.m_cmd = "deco";
	   	infoBox.m_decoPrefs = eval("(" + $('#CF0101_decoPrefs').val() + ")");
	   	infoBox.m_isOrg = 'true';
	   	cfEach.sendCommand(infoBox);
	   	
	   	$('#CF0101_template').val(cfTitle.getDeco().getDecoPrefValue('CF0101_template'));
	   	$('#CF0102_template').val(cfTitle.getDeco().getDecoPrefValue('CF0102_template'));
	   	$('#CF0105_template').val(cfTitle.getDeco().getDecoPrefValue('CF0105_template'));
	   	
   		//타이틀메뉴 너비 지정
		var left = $('#title_cafeMenus').css('border-left-width').replace('px','');
		var right = $('#title_cafeMenus').css('border-right-width').replace('px','');
		var menuWidth = 929 - left - right;
		$('#title_cafeMenus').css('width', menuWidth);
	   	
	   	$(document).ready(function(){
	   	   	$('#resizeBar').draggable({
	   	   		axis: 'y', 
	   	   		containment: ['auto', 117, 'auto', 402],
	   	   		drag: function(event, ui){
	   	   			var height = $('#resizeBar').css('top').replace('px','')-2;
	   	   			cfTitleEditor.changeHeight(height);
	   	   		},
	   	   		stop : function(event, ui){
	   	   			var height = $('#resizeBar').css('top').replace('px','')-2;
	   	   			cfTitleEditor.changeHeight(height);
	   	   		}
	   	   	});
	   		
	   	   	$('#resizeBar').click(function(){
	   	   		$('#resizeBar').draggable();
	   	   	});
	   	   	
	   		cfTitleEditor.initialize('<c:out value="${cmntVO.cmntId}"/>');
	   		
	   		$('body').bind('keyup.maskLayer', function(e){
				if(e.keyCode == 17) {
					$('#maskLayer').css('display','none');
				}
			});
	   	});
	</script>
</html>