
if (!window.cafe) window.cafe = new Object();
if (!window.cafe.editor) window.cafe.editor = new Object();

function stopEventBroadCasting(e){
	var evnt = e?e:window.event;
	if(evnt.cancelBubble){
		evnt.cancelBubble = true;
	}else if(evnt.stopPropagation){
		evnt.stopPropagation();
	}else{
		
	}
}

cafe.editor.Title = function () {
	this.m_ajax = new enview.util.Ajax();
	this.m_contextPath = ebUtil.getContextPath();
	
	this.m_sortArray = new Array();
}

cafe.editor.Title.prototype = {
	m_ajax : null,
	m_contextPath : null,
	m_curCafeUrl : null,
	m_cmntId : null,
	
	m_util : null,
	
	m_decoPrefs: null,
	
	m_sortArray : null,
	m_selected : null,
	m_zIndex : null,
	
	//초기화 함수
   	initialize : function(cmntId){
   		if(cmntId) this.m_cmntId = cmntId;
   		//리사이즈바 및 배경 높이 설정
   		this.initBgHeight();
   		
   		//안내선 초기화
   		this.initGrid();
   		
//   	cfGGum.getDragMngr (document.getElementById("titleArea"), "title_cafeName", document.getElementById("title_cafeName")).attach();
//   	cfGGum.getDragMngr (document.getElementById("titleArea"), "title_cafeUrl", document.getElementById("title_cafeUrl")).attach();
//   	cfGGum.getDragMngr (document.getElementById("titleArea"), "title_menu", document.getElementById("title_menu")).attach();
   		
   		this.bind();
   		
   		cfTitleEditor.setTitleMenuTop();
   	},
   	
   	//리셋함수
   	reset : function () {
   		cfTitle.getDeco().reset();
   		this.unbind();
   		this.initialize();
   	},
   	
   	initBgHeight : function () {
//   		var height = cfTitle.getDeco().getDecoPrefValue('CF0102_bgHeight', 'height').replace('px','');
   		var height = $('.CF0102_bgHeight').height();
   		//리사이즈 바 위치 설정	
   		this.setResizeBarTop(height);
   		
   		//배경 높이와 안내선 높이 초기화
   		this.changeHeight(parseInt(height));
   	},
   	
   	bind : function () {
   		var cfTitleEditor = this;
   		
   		$('#title_cafeName').draggable({
   			containment: 'parent',
   			stop: function(event){
   				cfTitleEditor.setCafeNamePos();
   			}
   		});
   		
   		$('#title_cafeName').bind('click.title_cafeName', function(e){
   			$(cfTitleEditor.m_selected).css('z-index', cfTitleEditor.m_zIndex);
   			cfTitleEditor.m_selected = this;
   			cfTitleEditor.m_zIndex = $(this).css('z-index');
   			$(this).css('z-index', '220');
   			
   			$('#maskLayer').css('display', 'none');
   			$('#editBtn').unbind('click.editBtn');
   			$('#deleteBtn').unbind('click.deleteBtn');
   			
   			var top = ebUtil.getAbsTop('title_cafeName');
   			var left = ebUtil.getAbsLeft('title_cafeName');
   			var width = $(this).css('width');
   			var height = $(this).css('height');
   			
   			$('#maskLayer').css('width', width);
   			$('#maskLayer').css('height', height);
   			$('#maskLayer').appendTo(this);
   			$('#maskLayer').css('display', 'block');
   			
   			$('#editBtn').bind('click.editBtn', function(e2){
   				cfTitleEditor.showCafeNameEditor();
   				stopEventBroadCasting(e2);
   			});
   			
   			$('#deleteBtn').bind('click.deleteBtn', function(e3){
   				cfTitleEditor.setDisplay('CF0103', 'none');
   				stopEventBroadCasting(e3);
   			});
   			stopEventBroadCasting(e);
   		});
   		
   		
   		$('#title_cafeUrl').draggable({
   			containment: 'parent',
   			stop: function(event){
   				cfTitleEditor.setCafeUrlPos();
   			}
   		});
   		
   		$('#title_cafeUrl').bind('click.title_cafeUrl', function(e){
   			$(cfTitleEditor.m_selected).css('z-index', cfTitleEditor.m_zIndex);
   			cfTitleEditor.m_selected = this;
   			cfTitleEditor.m_zIndex = $(this).css('z-index');
   			$(this).css('z-index', '220');
   			
   			$('#maskLayer').css('display', 'none');
   			$('#editBtn').unbind('click.editBtn');
   			$('#deleteBtn').unbind('click.deleteBtn');
   			
   			var top = ebUtil.getAbsTop('title_cafeUrl');
   			var left = ebUtil.getAbsLeft('title_cafeUrl');
   			var width = $(this).css('width');
   			var height = $(this).css('height');
   			
   			$('#maskLayer').css('width', width);
   			$('#maskLayer').css('height', height);
   			$('#maskLayer').appendTo(this);
   			$('#maskLayer').css('display', 'block');
   			$('#editBtn').bind('click.editBtn', function(e2){
   				cfTitleEditor.showCafeUrlEditor();
   				stopEventBroadCasting(e2);
   			});
   			 
   			$('#deleteBtn').bind('click.deleteBtn', function(e3){
   				cfTitleEditor.setDisplay('CF0104', 'none');
   				stopEventBroadCasting(e3);
   			});
   			stopEventBroadCasting(e);
   		});
   		
   		var titleMenuHeight = parseInt($('#title_cafeMenus').css('height').replace('px',''))
   		var borderWidth = parseInt($('#title_cafeMenus').css('border-top-width').replace('px','')) + parseInt($('#title_cafeMenus').css('border-bottom-width').replace('px',''));
   		var maxTop = 335 + 65 - titleMenuHeight - borderWidth;
   		
   		$('#title_cafeMenus').draggable({
   			axis: 'y',
   			containment: [0,65,0,maxTop],
   			stop: function(event){
   				cfTitleEditor.setTitleMenuTop();
   			}
   		});
   		
   		$('#title_cafeMenus').bind('click.title_menus', function(e){
   			$(cfTitleEditor.m_selected).css('z-index', cfTitleEditor.m_zIndex);
   			cfTitleEditor.m_selected = this;
   			cfTitleEditor.m_zIndex = $(this).css('z-index');
   			$(this).css('z-index', '220');
   			
   			$('#maskLayer').css('display', 'none');
   			$('#editBtn').unbind('click.editBtn');
   			$('#deleteBtn').unbind('click.deleteBtn');
   			
   			var top = ebUtil.getAbsTop('title_menu');
   			var left = ebUtil.getAbsLeft('title_menu');
   			var width = $(this).css('width');
   			var height = $(this).css('height');
   			
   			$('#maskLayer').css('width', width);
   			$('#maskLayer').css('height', height);
   			$('#maskLayer').appendTo(this);
   			$('#maskLayer').css('display', 'block');
   			$('#editBtn').bind('click.editBtn', function(e2){
   				cfTitleEditor.showTemplateEditor('CF0105',500, 225, 1);
   				stopEventBroadCasting(e2);
   			});
   			
   			$('#deleteBtn').bind('click.deleteBtn', function(e3){
   				cfTitleEditor.setDisplay('CF0105', 'none');
   				stopEventBroadCasting(e3);
   			});
   			stopEventBroadCasting(e);
   		});
   	},
   	
   	unbind : function() {
   		$('#title_cafeName').draggable('destroy');
   		$('#title_cafeUrl').draggable('destroy');
   		$('#title_cafeMenus').draggable('destroy');
   		
   		$('#editBtn').unbind('click.editBtn');
		$('#deleteBtn').unbind('click.deleteBtn');
   		$('#title_cafeName').unbind('click.title_cafeName');
   		$('#title_cafeUrl').unbind('click.title_cafeUrl');
   		$('#title_cafeMenus').unbind('click.title_menus');
   	},
   	
   	setDisplay : function (decoType, value) {
   		cfTitle.getDeco().setDecoPref(decoType + '_display', '{ "display": "' + value + '" }');
   		cfTitle.getDeco().rendering(decoType + '_display');
   	},
   	
   	sortLayer : function(target, order) {
   		if(order == 'front'){
   			
   		}else if(order == 'back'){
   			
   		}
   	},
   	
	//리사이즈 바 위치 설정
   	setResizeBarTop : function(height){
   		if(height != undefined && height != null){
   			if(typeof height == 'number') height += 2;
   			else if(typeof height == 'string'){
   				height = parseInt(height.replace('px','')) + 2;
   			}
   			$("#resizeBar").css('top', height);
   		}
   	},
   	
   	//드래그 할 때 위치 변화시켜주는 함수.
	changeHeight : function(height){
		var border = parseInt($('#title_background').css('border-top-width').replace('px',''))*2;
   		var realHeight = height - border;
   		$('#titleArea').css('height', realHeight);
   		$('#title_background').css('height', realHeight);
   		$('#grid_background').css('height', realHeight);
   		$('#emptyArea').css('height', 335 - realHeight - border);
   		
   		if(height.toString().indexOf('px') >= 0) height = height.replace('px', '');
		$("#CF0102_bgHeight").val(height);
		cfTitle.getDeco().setDecoPref('CF0102_bgHeight', '{ "height": "' + height + 'px" }');
   	},
   	
   	//높이 필드 값 설정
   	setHeightField : function(event){
		if(event.keyCode == 13){
			var height = $("#CF0102_bgHeight").val();
			if(height < 50) height = 50;
			else if (335 < height) height = 335; 
			$("#CF0102_bgHeight").val(height);
			this.setResizeBarTop(height);
			this.changeHeight(parseInt(height));
		}
   	},
   	
   	//높이 필드 값 설정
   	setHeightFieldForClick : function(){
		var height = $("#CF0102_bgHeight").val();
		if(height < 50) height = 50;
		else if (335 < height) height = 335; 
		$("#CF0102_bgHeight").val(height);
		this.setResizeBarTop(height);
		this.changeHeight(parseInt(height));
   	},
   	
   	//안내선 초기화
   	initGrid : function(){
			$('#gridCheck').removeAttr('checked');
			$('#grid_background').css('display','none');
   	},
   	
   	toggleGridArea : function(){
   		var checked = $('#gridCheck').attr('checked');
   		if(checked){
   			$('#grid_background').css('height', $('#titleArea').css('height'));
	   		$('#grid_background').css('display','block');
   		}else{
   			$('#grid_background').css('display','none');
   		}
   	},
   	
   	setCafeNamePos : function () {
   		var top = $('#title_cafeName').css('top');
   		var left = $('#title_cafeName').css('left');
   		cfTitle.getDeco().setDecoPref('CF0103_position', '{ "position": "absolute", "top": "' + top + '", "left": "' + left + '" }');   		
   	},
   	
   	setCafeUrlPos : function () {
   		var top = $('#title_cafeUrl').css('top');
   		var left = $('#title_cafeUrl').css('left');
   		cfTitle.getDeco().setDecoPref('CF0104_position', '{ "position": "absolute", "top": "' + top + '", "left": "' + left + '" }');
   	},
   	
   	setTitleMenuTop : function () {
   		var top = $('#title_cafeMenus').css('top');
   		cfTitle.getDeco().setDecoPref('CF0105_position', '{ "position": "absolute", "top": "' + top + '", "left": "0px" }');
   	},
   	
   	//템플릿 랜더링
	CF0101Rendering : function () { 
   		var infoBox = cfEach.getInfoBox();
	   	infoBox.m_on = "client";
	   	infoBox.m_target = "title";
	   	infoBox.m_cmd = "deco";
	   	infoBox.m_decoPrefs = eval("(" + $('#CF0101_decoPrefs').val() + ")");
	   	infoBox.m_isOrg = 'false';
	   	cfEach.sendCommand(infoBox);
   	},
   	
   	//배경 랜더링
	CF0102Rendering : function (panelName) {
		if(panelName == 'Color'){
			cfTitleEditor.setBgByColor();
		}
		else if (panelName == 'Custom'){
			cfTitleEditor.setBgByCustom();
		}
		else {
			var bgDecoPrefs = eval("(" + $('#CF0102_decoPrefs').val() + ")");
			var decoPrefs = cfTitle.getDeco().getDecoPrefs();
			var cfUtil = cfEach.getUtil();
			cfUtil.substitueObjByClass(bgDecoPrefs, 'CF0102_tplImg', decoPrefs, 'CF0102_tplImg');
			cfUtil.substitueObjByClass(bgDecoPrefs, 'CF0102_bgColor', decoPrefs, 'CF0102_bgColor');
			cfUtil.substitueObjByClass(bgDecoPrefs, 'CF0102_bgHeight', decoPrefs, 'CF0102_bgHeight');
			cfUtil.substitueObjByClass(bgDecoPrefs, 'CF0102_bgImage', decoPrefs, 'CF0102_bgImage');
			cfUtil.substitueObjByClass(bgDecoPrefs, 'CF0102_bgImgPos', decoPrefs, 'CF0102_bgImgPos');
			cfUtil.substitueObjByClass(bgDecoPrefs, 'CF0102_bgImgRepeat', decoPrefs, 'CF0102_bgImgRepeat');
			cfUtil.substitueObjByClass(bgDecoPrefs, 'CF0102_brdrColor', decoPrefs, 'CF0102_brdrColor');
			cfUtil.substitueObjByClass(bgDecoPrefs, 'CF0102_brdrStyle', decoPrefs, 'CF0102_brdrStyle');
			cfUtil.substitueObjByClass(bgDecoPrefs, 'CF0102_brdrWidth', decoPrefs, 'CF0102_brdrWidth');
			cfUtil.substitueObjByClass(bgDecoPrefs, 'CF0102_trpcValue', decoPrefs, 'CF0102_trpcValue');
			cfTitle.getDeco().rendering();
		}
   	},
   	
   	//카페이름 랜더링
	CF0103Rendering : function () { 
		cfTitleEditor.setCafeName();
   	},
   	
   	//카페주소 랜더링
	CF0104Rendering : function () { 
		cfTitleEditor.setCafeUrl();
   	},
   	
   	//타이틀메뉴 렌더링
	CF0105Rendering : function () {
		var tmDecoPrefs = eval("(" + $('#CF0105_decoPrefs').val() + ")");
		var decoPrefs = cfTitle.getDeco().getDecoPrefs();
		var cfUtil = cfEach.getUtil();
		cfUtil.substitueObjByClass(tmDecoPrefs, 'CF0105_baseFontColor', decoPrefs, 'CF0105_baseFontColor');
		cfUtil.substitueObjByClass(tmDecoPrefs, 'CF0105_bgColor', decoPrefs, 'CF0105_bgColor');
		cfUtil.substitueObjByClass(tmDecoPrefs, 'CF0105_brdrColor', decoPrefs, 'CF0105_brdrColor');
		cfUtil.substitueObjByClass(tmDecoPrefs, 'CF0105_brdrStyle', decoPrefs, 'CF0105_brdrStyle');
		cfUtil.substitueObjByClass(tmDecoPrefs, 'CF0105_brdrWidth', decoPrefs, 'CF0105_brdrWidth');
		cfUtil.substitueObjByClass(tmDecoPrefs, 'CF0105_fontNm', decoPrefs, 'CF0105_fontNm');
		cfUtil.substitueObjByClass(tmDecoPrefs, 'CF0105_position', decoPrefs, 'CF0105_position');
		cfUtil.substitueObjByClass(tmDecoPrefs, 'CF0105_selFontColor', decoPrefs, 'CF0105_selFontColor');
		cfUtil.substitueObjByClass(tmDecoPrefs, 'CF0105_tplImg', decoPrefs, 'CF0105_tplImg');
		cfTitle.getDeco().rendering();
		
		var titleMenuHeight = parseInt($('#title_cafeMenus').css('height').replace('px',''))
   		var borderWidth = parseInt($('#title_cafeMenus').css('border-top-width').replace('px','')) + parseInt($('#title_cafeMenus').css('border-bottom-width').replace('px',''));
   		var maxTop = 335 + 65 - titleMenuHeight - borderWidth;
   		
		$('#title_cafeMenus').draggable({
   			axis: 'y',
   			containment: [0,65,0,maxTop],
   			stop: function(event){
   				cfTitleEditor.setTitleMenuTop();
   			}
   		});
		cfTitleEditor.setTitleMenuTop();
   	},
   	
   	//검색창 랜더링
	CF0106Rendering : function () { 
   	},
   	
   	//카운터 랜더링
	CF0107Rendering : function () { 
   	},
   	
	showTemplateEditor : function(decoType, width, height, page) {
		var title = '';
		
		switch(decoType){
			case 'CF0101': title = '템플릿';		break;
			case 'CF0102': title = '배경';		break;
			case 'CF0103': title = '카페이름';		break;
			case 'CF0104': title = '카페주소';		break;
			case 'CF0105': title = '타이틀 메뉴';	break;
			default: break;
		}
		$.ajax({
			type: 'POST',
			url: this.m_contextPath + '/cafe/editor.cafe',
			data:
			{
				'cafeUrl' : this.m_curCafeUrl,
				'm'    : 'titleDialog',
				'dt'   : decoType,
				'pageNum' : page,
				'dummy': Math.random()*1000,
				'__ajax_call__'  : true
			},
			dataType: 'html',
			success: function(html, textStatus){
				cfDialog.setOption({
					code : decoType,
					title: title,
					modal: true,
					opacity: 0.5,
					okButton: '확인',
					cancelButton: '취소',
					closeOnEscape: true,
					contents: html,
					draggable: true,
					width: width,
					height: height,
					okCallback: function(){
						cfTitleEditor.onClickOkForTpl(decoType);
						cfTitleEditor.setDisplay(decoType, 'block');
					},
					cancelCallback : function(){
						
					}
				});
				cfDialog.open();
				var decoId = $('#' + decoType + '_decoId').val();
				if(decoId == ''){
					decoId = $('#' + decoType + '_template').val();
				}
				cfTplMngr.selectTemplate(decoType, decoId);
			},
			error: function(x, e){
				alert('잠시 후에 다시 시도 해주십시오.');
			}
		});
	},
	
	onClickOkForTpl : function(decoType) {
		var cfTitleEditor = this;
		$.ajax({
			type: 'POST',
			url: this.m_contextPath + '/cafe/editor.cafe',
			data:
			{
				'm'    : 'getDecoPrefs',
				'dt'   : decoType,
				'di'   : $('#' + decoType + '_decoId').val(),
				'dummy': Math.random()*1000,
				'__ajax_call__'  : true
			},
			dataType: 'html',
			success: function(html, textStatus){
				$('#decoTemplates').html(html);
				eval('cfTitleEditor.' + decoType + 'Rendering()');
				$('#' + decoType + '_template').val($('#' + decoType + '_decoId').val());
			},
			error: function(x, e){
				alert(e + '\n잠시 후에 다시 시도 해주십시오.');
			}
		});
	},
	
	/**
	 * 배경에서 색상 및 직접 올리기
	 */
	showBackgroundEditor : function (panelName, height) {
   		var cfTitleEditor = this;
   		$.ajax({
			type: 'POST',
			url: this.m_contextPath + '/cafe/editor.cafe',
			data:
			{
				'cafeUrl' : this.m_curCafeUrl,
				'm'    : 'titleDialog',
				'dt'   : 'CF0102',
				'pn'   : panelName,
				'dummy': Math.random()*1000,
				'__ajax_call__'  : true
			},
			dataType: 'html',
			success: function(html, textStatus){
				cfDialog.setOption({
					code : 'CF0102',
					title: '배경',
					modal: true,
					opacity: 0.5,
					okButton: '확인',
					cancelButton: '취소',
					closeOnEscape: true,
					contents: html,
					draggable: true,
					width: 312,
					height: height,
					showCallback : function (){
						cfSlider.initialize('bgTrcpslideSelector', cfTitleEditor.setBgOpacity);
					},
					closeCallback : function (){
						
					},
					okCallback: function(){
						cfTitleEditor.CF0102Rendering(panelName);
						cfTitleEditor.setDisplay('CF0102', 'block');
					},
					cancelCallback : function(){
						
					}
				});
				cfDialog.open();
				switch(panelName){
					case 'Color': {
						var bgColor = $('#title_background').css('background-color');
						$('#colorPanel').css('background-color', bgColor);
						$('#CF0102_bgColor').css('background-color', bgColor);
						
						var bgBrdrColor = $('#title_background').css('border-top-color');
						$('#borderColorPicker').css('background-color', bgBrdrColor);
						
						var bgBrdrWidth = $('#title_background').css('border-top-width');
						var bgBrdrStyle = $('#title_background').css('border-top-style');
						$('#colorPanel').css('border', bgBrdrWidth + ' ' + bgBrdrStyle + ' ' + bgBrdrColor);
						
						bgBrdrWidth = parseInt(bgBrdrWidth.replace('px',''));
						$('#titleBgBrdrStyle').css('background-position', '0px ' + -bgBrdrWidth * 21 + 'px');
						
						$('#colorPanel').css('width', 120 - bgBrdrWidth*2);
						$('#colorPanel').css('height', 120 - bgBrdrWidth*2);
						
						var bgOpacity = $('#title_background').css('opacity');
						$('#colorPanel').css('opacity', bgOpacity);
						$('#bgTrcpslideSelector').css('left', 50 - (bgOpacity / 0.02));
						$('#bgTrcpslideSelector').attr('title', (1 - bgOpacity) * 100);
						$('#bgTrcpslideSelector').parent().attr('title', (1 - bgOpacity) * 100);
					}
					case 'Custom': {
						$('#delPhoto').css('display', 'block');
						$('#previewUserImage').css('display', 'block');
						$('#titleBgImgRepeat').removeAttr('disabled');
						$('#titleBgImgRepeat').bind('change.titleBgImageRepeat', function(){
							var repeat = $(this).val();
							if(repeat == 'repeat'){
								$('#CF0102_bgImgPos').css('cursor', 'default');
								$('#CF0102_bgImgPos').unbind('click.alignPicker');
								//cfTitle.getDeco().setDecoPref('CF0102_bgImgPos', '{ "background-position-x": "left", "background-position-y": "top" }');
							}
							else if(repeat == 'no-repeat'){
								$('#CF0102_bgImgPos').css('cursor', 'pointer');
								$('#CF0102_bgImgPos').bind('click.alignPicker', function(){
									cfAlignPicker.initialize('CF0102_bgImgPos', cfTitleEditor.setBgAlign, posX, posY);
								});
							}
							cfTitle.getDeco().setDecoPref('CF0102_bgImgRepeat', '{ "background-repeat": "' + $(this).val() + '" }');
						});
						
						$('#CF0102_bgColor').css('cursor', 'pointer');
						$('#CF0102_bgColor').bind('click.colorPicker', function(){
							cfColorPicker.initialize('CF0102_bgColor', cfTitleEditor.setBgColor);
						});
						
						cfAlignPicker.setBgImgPos('CF0102_bgImgPos',$('.CF0102_bgImgPos').css('background-position-x'), $('.CF0102_bgImgPos').css('background-position-y'));
						$('#CF0102_bgImgPos').css('cursor', 'pointer');
						$('#CF0102_bgImgPos').bind('click.alignPicker', function(){
							var posX = $('.CF0102_bgImgPos').css('background-position-x');
							var posY = $('.CF0102_bgImgPos').css('background-position-y');
							cfAlignPicker.initialize('CF0102_bgImgPos', cfTitleEditor.setBgAlign, posX, posY);
						});
						
						$('#previewUserImage').error(function(){
							$(this).css('display','none');
							$('#delPhoto').css('display', 'none');
							$('#titleBgImgRepeat').attr('disabled', 'disabled');
							$('#titleBgImgRepeat').unbind('change.titleBgImageRepeat');
							$('#CF0102_bgColor').css('cursor', 'default');
							$('#CF0102_bgColor').unbind('click.colorPicker');
							$('#CF0102_bgImgPos').css('cursor', 'default');
							$('#CF0102_bgImgPos').unbind('click.alignPicker');
						});
					}
					default: break;
				}
			},
			error: function(x, e){
				alert('잠시 후에 다시 시도 해주십시오.');
			}
		});
   	},
   	
   	setBgColor : function(bgColor) {
   		$('#colorPanel').css('background-color', bgColor);
   		$('#CF0102_bgColor').css('background-color', bgColor);
   	},
   	
   	setBgBrdrColor : function (brdrColor){
   		$('#colorPanel').css('border-color', brdrColor);
   		$('#borderColorPicker').css('background-color', brdrColor);
   	},
   	
   	setBgBrdrStyle : function (brdrWidth, brdrStyle) {
   		$('#colorPanel').css('width', 120 - brdrWidth*2);
   		$('#colorPanel').css('height', 120 - brdrWidth*2);
   		var brdrColor = $('#borderColorPicker').css('background-color');
   		$('#colorPanel').css('border', brdrWidth + 'px solid ' + brdrColor);
   	},
   	
   	setBgOpacity : function (opacity){
   		$('#colorPanel').css('opacity', opacity);
   	},
   	
   	setBgByColor : function () {
   		var bgColor = $('#colorPanel').css('background-color');
   		var bgBrdrWidth = $('#colorPanel').css('border-top-width');
   		var bgBrdrStyle = $('#colorPanel').css('border-top-style');
   		var bgBrdrColor = $('#colorPanel').css('border-top-color');
   		var bgOpacity = $('#colorPanel').css('opacity');
   		cfTitle.getDeco().setDecoPref('CF0102_bgColor', '{ "background-color": "' + bgColor + '" }');
   		cfTitle.getDeco().setDecoPref('CF0102_brdrColor', '{ "border-color": "' + bgBrdrColor + '" }');
   		cfTitle.getDeco().setDecoPref('CF0102_brdrStyle', '{ "border-style": "' + bgBrdrStyle + '" }');
   		cfTitle.getDeco().setDecoPref('CF0102_brdrWidth', '{ "border-width": "' + bgBrdrWidth + '" }');
   		cfTitle.getDeco().setDecoPref('CF0102_bgImage', '{ "background-image": "none" }');
   		cfTitle.getDeco().setDecoPref('CF0102_trpcValue', '{ "opacity": "' + bgOpacity + '" }');
   		cfTitle.getDeco().rendering();
   		
   		var height = $("#resizeBar").css('top').replace('px','')-2;
   		this.setResizeBarTop(height);
   		this.changeHeight(height);
   	},
   	
   	setBgByCustom : function () {
   		var bgColor = $('#CF0102_bgColor').css('background-color');
   		cfTitle.getDeco().setDecoPref('CF0102_bgImage',		'{ "background-image": "url(' + this.m_contextPath + '/cola/cafe/each/' + this.m_cmntId + '/TITLE_BG_IMG_IMSI?dummy=' + Math.random() + ')" }', false);
   		cfTitle.getDeco().setDecoPref('CF0102_bgColor', '{ "background-color": "' + bgColor + '" }');
		cfTitle.getDeco().setDecoPref('CF0102_template', 'custom', false);
   		cfTitle.getDeco().rendering();
   		//cfTitle.getDeco().setDecoPref('CF0102_bgImage',		'{ "background-image": "url(' + this.m_contextPath + '/cola/cafe/each/' + this.m_cmntId + '/TITLE_BG_IMG)" }', false);
   		
   		var height = $("#resizeBar").css('top').replace('px','')-2;
   		this.setResizeBarTop(height);
   		this.changeHeight(height);
   	},
   	
   	showCafeNameEditor : function () {
   		var cfTitleEditor = this;
   		$.ajax({
			type: 'POST',
			url: this.m_contextPath + '/cafe/editor.cafe',
			data:
			{
				'cafeUrl' : this.m_curCafeUrl,
				'm'    : 'titleDialog',
				'dt'   : 'CF0103',
				'dummy': Math.random()*1000,
				'__ajax_call__'  : true
			},
			dataType: 'html',
			success: function(html, textStatus){
				cfDialog.setOption({
					code : 'CF0103',
					title: '카페이름',
					modal: true,
					opacity: 0.5,
					okButton: '확인',
					cancelButton: '취소',
					closeOnEscape: true,
					contents: html,
					draggable: true,
					width: 373,
					height: 170,
					okCallback: function(){
						cfTitleEditor.CF0103Rendering();
						cfTitleEditor.setDisplay('CF0103', 'block');
					},
					cancelCallback : function(){
						
					}
				});
				cfDialog.open();
				
				var fontNm = $('#title_cafeName').css('font-family');
				$('#CF0103_fontNm option').each(function(){
					var $this = $(this);
					if( $this.val() == fontNm ) {
						$this.attr('selected', 'selected');
						$('#previewCafeNm').css('font-family', fontNm);
					} 
				});
				
				var fontSize = $('#title_cafeName').css('font-size');
				$('#CF0103_fontSize option').each(function(){
					var $this = $(this);
					if( $this.val() == fontSize ) {
						$this.attr('selected', 'selected');
						$('#previewCafeNm').css('font-size', fontSize);
					} 
				});
				
				var fontColor = $('#title_cafeName').css('color');
				$('#CF0103_fontColor').css('background-color', fontColor);
				$('#previewCafeNm').css('color', fontColor);
				
				$('#CF0103_fontNm').change(function(){
					var fontName = $(this).val();
					$('#previewCafeNm').css('font-family', fontName);
				});

				$('#CF0103_fontSize').change(function(){
					var fontSize = $(this).val();
					$('#previewCafeNm').css('font-size', fontSize);
				});
			},
			error: function(x, e){
				alert('잠시 후에 다시 시도 해주십시오.');
			}
		});
   	},
   	
   	setCafeNmColor : function (fontColor) {
   		$('#previewCafeNm').css('color', fontColor);
   		$('#CF0103_fontColor').css('background-color', fontColor);
   	},
   	
   	setCafeName : function () {
   		var fontNm = $('#CF0103_fontNm').val();
   		var fontSize = $('#CF0103_fontSize').val();
   		var fontColor = $('#CF0103_fontColor').css('background-color');
   		
   		cfTitle.getDeco().setDecoPref('CF0103_fontNm', '{ "font-family": "' + fontNm + '" }');
   		cfTitle.getDeco().setDecoPref('CF0103_fontSize', '{ "font-size": "' + fontSize + '" }');
   		cfTitle.getDeco().setDecoPref('CF0103_fontColor', '{ "color": "' + fontColor + '" }');
   		cfTitle.getDeco().rendering();
   	},
   	
   	showCafeUrlEditor : function () {
   		var cfTitleEditor = this;
   		$.ajax({
			type: 'POST',
			url: this.m_contextPath + '/cafe/editor.cafe',
			data:
			{
				'cafeUrl' : this.m_curCafeUrl,
				'm'    : 'titleDialog',
				'dt'   : 'CF0104',
				'dummy': Math.random()*1000,
				'__ajax_call__'  : true
			},
			dataType: 'html',
			success: function(html, textStatus){
				cfDialog.setOption({
					code : 'CF0104',
					title: '카페주소',
					modal: true,
					opacity: 0.5,
					okButton: '확인',
					cancelButton: '취소',
					closeOnEscape: true,
					contents: html,
					draggable: true,
					width: 373,
					height: 170,
					okCallback: function(){
						cfTitleEditor.CF0104Rendering();
						cfTitleEditor.setDisplay('CF0104', 'block');
					},
					cancelCallback : function(){
						
					}
				});
				cfDialog.open();
				
				var fontNm = $('#title_cafeUrl').css('font-family');
				$('#CF0104_fontNm option').each(function(){
					var $this = $(this);
					if( $this.val() == fontNm ) {
						$this.attr('selected', 'selected');
						$('#previewCafeUrl').css('font-family', fontNm);
					} 
				});
				
				var fontSize = $('#title_cafeUrl').css('font-size');
				$('#CF0104_fontSize option').each(function(){
					var $this = $(this);
					if( $this.val() == fontSize ) {
						$this.attr('selected', 'selected');
						$('#previewCafeUrl').css('font-size', fontSize);
					} 
				});
				
				var fontColor = $('#title_cafeUrl').css('color');
				$('#CF0104_fontColor').css('background-color', fontColor);
				$('#previewCafeUrl').css('color', fontColor);
				
				$('#CF0104_fontNm').change(function(){
					var fontName = $(this).val();
					$('#previewCafeUrl').css('font-family', fontName);
				});

				$('#CF0104_fontSize').change(function(){
					var fontSize = $(this).val();
					$('#previewCafeUrl').css('font-size', fontSize);
				});
			},
			error: function(x, e){
				alert('잠시 후에 다시 시도 해주십시오.');
			}
		});
   	},
   	
   	setCafeUrlColor : function (fontColor) {
   		$('#previewCafeUrl').css('color', fontColor);
   		$('#CF0104_fontColor').css('background-color', fontColor);
   	},
   	
   	setCafeUrl : function () {
   		var fontNm = $('#CF0104_fontNm').val();
   		var fontSize = $('#CF0104_fontSize').val();
   		var fontColor = $('#CF0104_fontColor').css('background-color');
   		
   		cfTitle.getDeco().setDecoPref('CF0104_fontNm', '{ "font-family": "' + fontNm + '" }');
   		cfTitle.getDeco().setDecoPref('CF0104_fontSize', '{ "font-size": "' + fontSize + '" }');
   		cfTitle.getDeco().setDecoPref('CF0104_fontColor', '{ "color": "' + fontColor + '" }');
   		cfTitle.getDeco().rendering();
   	},
	
	onClickPreview : function (){

	},
	
   	//적용 버튼을 눌렀을 때, 작업한 내용을 저장하고 홈으로 돌아간다.
	onClickApply : function () {
		if (!confirm (ebUtil.getMessage("cf.info.ggum.apply"))) return;
   		
   		var decoPrefs = cfTitle.m_deco.getDecoPrefs();
   		var param = "m=setGgumDecoPrefs";
   		param += "&cmd=title";
   		param += "&cafeUrl=" + this.m_curCafeUrl;
   		for (var i=0; i<decoPrefs.length; i++) {
   			param += "&" + decoPrefs[i].clazz + "=" + decoPrefs[i].value;
   		}
   		$.ajax({
			type: 'POST',
			url: this.m_contextPath + '/cafe/editor.cafe',
			data: param,
			dataType: 'html',
			success: function(html, textStatus){
	   			if(confirm(ebUtil.getMessage("mm.info.success") + "\n계속 수정하시겠습니까? ")) return;
	   			cfEach.go2EachHome();
			},
			error: function(x, e){
				alert(e + '\n잠시 후에 다시 시도 해주십시오.');
			}
		});
	},

	//현재 작업을 취소하고 카페 꾸미기로 돌아간다.
	onClickCancel : function (){
   		location.href= contextPath + '/cafe/' + this.m_curCafeUrl + '?isEditMode=true';
   	},
   	
   	setSlider : function (objId) {
   		$.ajax({
			type: 'POST',
			url: this.m_contextPath + '/cafe/editor.cafe',
			data:
			{
				'cafeUrl' : this.m_curCafeUrl,
				'm'    : 'slider',
				'dummy': Math.random()*1000,
				'__ajax_call__'  : true
			},
			dataType: 'html',
			success: function(html, textStatus){
				$('#' + objId).html(html);
			},
			error: function(x, e){
				alert('잠시 후에 다시 시도 해주십시오.');
			}
		});
   	},
   	
   	uploadTitleBgImage : function (){
		this.delPreviewImage(function(){
			var text = $('#titleBgFile').val();
			if(text != '') {
				var frm = document.titleBgFileForm;
				frm.action = cfTitle.m_contextPath+"/cafe/editor.cafe?m=uploadUserImage&cmd=title&cmntUrl=" + cfEach.m_curCafeUrl;
				frm.target = "titleBgIFrame";
				frm.submit();
			}
		});
	},
   	
   	previewImage : function(folder){
   		//this.m_cmntId = folder;
		$('#delPhoto').css('display', 'block');
		$('#previewUserImage').css('display', 'block');
		$('#previewUserImage').attr('src', this.m_contextPath + '/cola/cafe/each/' + this.m_cmntId + '/TITLE_BG_IMG_IMSI?dummy=' + Math.random());
		
		cfTitle.getDeco().setDecoPref('CF0102_bgImage',		'{ "background-image": "url(' + this.m_contextPath + '/cola/cafe/each/' + this.m_cmntId + '/TITLE_BG_IMG)" }', false);
		cfTitle.getDeco().setDecoPref('CF0102_bgImgPos',		'{ "background-position-x": "left", "background-position-y": "top" }', false);
		cfTitle.getDeco().setDecoPref('CF0102_bgImgRepeat',	'{ "background-repeat": "no-repeat" }', false);
		cfTitle.getDeco().setDecoPref('CF0102_template', 'custom', false);
		//cfTitle.m_deco.rendering();
		
		//미리보기를 위하여 IMSI 파일을 랜더링한 후, 적용되었을 때 저장될 파일명으로 치환해준다.
		//cfTitle.m_deco.setDecoPref('CF0102_bgImage',		'{ "background-image": "url(' + cfGGum.m_contextPath + '/cola/cafe/each/' + folder + '/TITLE_BG_IMG)" }', false);
		
		$('#titleBgImgRepeat').removeAttr('disabled');
		$('#titleBgImgRepeat').bind('change.titleBgImageRepeat', function(){
			cfTitle.getDeco().setDecoPref('CF0102_bgImgRepeat', '{ "background-repeat": "' + $(this).val() + '" }');
		});
		
		$('#CF0102_bgImgPos').css('cursor', 'pointer');
		$('#CF0102_bgImgPos').bind('click.alignPicker', function(){
			var posX = $('.CF0102_bgImgPos').css('background-position-x');
			var posY = $('.CF0102_bgImgPos').css('background-position-y');
			cfAlignPicker.initialize('CF0102_bgImgPos', cfTitleEditor.setBgAlign, posX, posY);
		});
		
		$('#CF0102_bgColor').css('cursor', 'pointer');
	},
	
	delPreviewImage : function(extraFunc) {
		var param = "m=deleteUserImage";
		param += "&cmd=title";
		param += "&cmntUrl=" + cfEach.m_curCafeUrl;
		cfGGum.m_ajax.send("POST", cfTitle.m_contextPath+"/cafe/editor.cafe", param, true, {success: function(htmlData) {
			$('#delPhoto').css('display', 'none');
			$('#previewUserImage').css('display', 'none');
			$('#previewUserImage').attr('src', '');
			
			$('#titleBgImgRepeat').attr('disabled', 'disabled');
			$('#titleBgImgRepeat').unbind('click.titleBgImageRepeat');
			
			$('#CF0102_bgImgPos').css('cursor', 'default');
			$('#CF0102_bgImgPos').unbind('click.alignPicker');
			
			$('#CF0102_bgColor').css('cursor', 'default');
			$('#CF0102_bgColor').unbind('click.colorPicker');

			if(extraFunc) extraFunc();
		}});
	},
	
	setBgAlign : function (posX, posY) {
		cfTitle.getDeco().setDecoPref('CF0102_bgImgPos', '{ "background-position-x": "' + posX + '", "background-position-y": "' + posY + '" }', false);
	}
}

cfTitleEditor = new cafe.editor.Title();


cafe.editor.TplMngr = function () {
	this.m_ajax = new enview.util.Ajax();
	this.m_contextPath = ebUtil.getContextPath();
}

cafe.editor.TplMngr.prototype = {
	m_ajax : null,
	m_contextPath : null,
		
	selectTemplate: function(decoType, decoId){
		var tplImg = document.getElementById('tplImg_' + decoId);
		if(tplImg == undefined || tplImg == null) return;
		var top = tplImg.offsetTop;
		var left = tplImg.offsetLeft;
		var $tplImg = $('#tplImg_' + decoId);
		var width = $tplImg.css('width').replace('px','')-2;
		var height = $tplImg.css('height').replace('px','')-2;
		$('#' + decoType + '_selectedBox').css('display', 'block');
		$('#' + decoType + '_selectedBox').css('top', top);
		$('#' + decoType + '_selectedBox').css('left', left);
		$('#' + decoType + '_selectedBox').css('width', width + 'px');
		$('#' + decoType + '_selectedBox').css('height', height + 'px');
		$('#' + decoType + '_decoId').val(decoId);
	}
}

cfTplMngr = new cafe.editor.TplMngr();



cafe.editor.ColorPicker = function () {
	this.m_ajax = new enview.util.Ajax();
	this.m_contextPath = ebUtil.getContextPath();
}

cafe.editor.ColorPicker.prototype = {
	m_ajax : null,
	m_contextPath : null,
	
	m_target : null,
	m_curColor : null,
	m_oriColor : null,
	
	setOriColor : function (color) {
		this.m_oriColor = color;
	},
	
	setCurColor : function (color) {
		this.m_curColor = color;
	},	
	
	setColor : function (color) {
		$('#colorInput').val(color);
		$('#colorThumb').css('background-color', color);
		this.m_target.css('background-color', color);
	},
	
	initialize : function (objId, extraFunc) {
		this.m_target = $('#' + objId);
		this.open(extraFunc);
	},
	
	initColor : function () {
		$('#colorInput').val(this.m_oriColor);
		$('#colorThumb').css('background-color', this.m_oriColor);
		this.m_target.css('background-color', this.m_oriColor);
	},
	
	initPosition : function () {
		var id = this.m_target.attr('id');
		$('#colorPicker').css('position', 'relative');
		$('#colorPicker').css('top', '22px');
		$('#colorPicker').css('left', '0px');
	},
	
	open : function (extraFunc) {
		var target = this.m_target;
		var colorPicker = this;
   		$.ajax({
			type: 'POST',
			url: this.m_contextPath + '/cafe/editor.cafe',
			data: {
				'm' : 'colorPicker'
			},
			dataType: 'html',
			success: function(html, textStatus){
				colorPicker.m_oriColor = target.css('background-color');
//				$('#colorPickerPanel').html(html);
				target.html(html);
				colorPicker.bind(extraFunc);
				colorPicker.initColor();
				colorPicker.initPosition();
				$('#colorPickerPanel').css('display','block');
			},
			error: function(x, e){
				alert(e + '\n잠시 후에 다시 시도 해주십시오.');
			}
		});
	},
	
	close : function () {
		$('#colorPicker').css('display','none');
		$('#colorPicker').remove();
	},
	
	bind : function (extraFunc) {
		var colorPicker = this;
		//각 색깔 버튼 onClick 이벤트 바인딩
		$('#colorSwatches div').bind('click.colorSwatches', function(event){
			colorPicker.setCurColor($(this).css('background-color'));
			colorPicker.setColor(colorPicker.m_curColor);
			if(extraFunc) extraFunc(colorPicker.m_curColor);
			stopEventBroadCasting(event);
		});
		
		//입력 버튼 onClick 이벤트 바인딩
		$('#colorInputBtn').bind('click.colorInputBtn', function(event){
			colorPicker.setOriColor($('#colorInput').val());
			extraFunc(colorPicker.m_oriColor);
			colorPicker.unbind();
			colorPicker.close();
			stopEventBroadCasting(event);
		});
		
		//원래대로 버튼
		$('#colorResetBtn').bind('click.colorResetBtn', function(event){
			colorPicker.initColor();
			extraFunc(colorPicker.m_oriColor);
			stopEventBroadCasting(event);
		});
		
		//body에 onClick 이벤트 바인딩 - 마우스 클릭 이벤트를 가지고 클릭된 지점의 위치를 비교하여 colorPicker를 닫는다.
		$('body').bind('click.colorPicker', function(event){
			var x = parseInt(ebUtil.getAbsLeft('colorPicker'));
			var y = parseInt(ebUtil.getAbsTop('colorPicker'));
			if((event.clientX > x + 195 || event.clientX < x) || (event.clientY > y + 130 || event.clientY < y)){
				colorPicker.setOriColor($('#colorInput').val());
				colorPicker.unbind();
				colorPicker.close();
			}
		});
	},
	
	unbind : function () {
		$('#colorResetBtn').unbind('click.colorResetBtn');
		$('#colorInputBtn').unbind('click.colorInputBtn');
		$('#colorSwatches div').unbind('click.colorSwatches');
		$('body').unbind('click.colorPicker');
	}	
}

cfColorPicker = new cafe.editor.ColorPicker();



cafe.editor.BorderPicker = function () {
	this.m_ajax = new enview.util.Ajax();
	this.m_contextPath = ebUtil.getContextPath();
}

cafe.editor.BorderPicker.prototype = {
	m_ajax : null,
	m_contextPath : null,
	
	m_target : null,
	
	m_wh : null,
	m_begin : null,
	m_end	: null,
	
	m_pattern : null,
	m_extraFunc : null,
	
	initialize : function (objId, wh, begin, end, pattern, extraFunc) {
		this.m_target = $('#' + objId);
		this.m_wh = wh;
		this.m_begin = begin;
		this.m_end = end;
		this.m_pattern = pattern;
		this.m_extraFunc = extraFunc;
		this.open();
	},
	
	initBorder : function () {
		
	},
	
	initPosition : function () {
		var id = this.m_target.attr('id');
		$('#borderPickerPanel').css('position', 'relative');
		$('#borderPickerPanel').css('top', '22px');
		$('#borderPickerPanel').css('left', '0px');
	},
	
	open : function () {
		var target = this.m_target;
		var borderPicker = this;
   		$.ajax({
			type: 'POST',
			url: this.m_contextPath + '/cafe/editor.cafe',
			data: {
				'wh' : borderPicker.m_wh,
				'begin' : borderPicker.m_begin,
				'end' : borderPicker.m_end,
				'pattern' : borderPicker.m_pattern,
				'm' : 'borderPicker'
			},
			dataType: 'html',
			success: function(html, textStatus){
//				$('#borderPickerPanel').html(html);
				borderPicker.m_target.html(html);
				borderPicker.bind(borderPicker.m_extraFunc);
				borderPicker.initBorder();
				borderPicker.initPosition();
				$('#borderPickerPanel').css('display','block');
			},
			error: function(x, e){
				alert(e + '\n잠시 후에 다시 시도 해주십시오.');
			}
		});
	},
	
	close : function () {
		var borderPicker = this;
		
		$('#borderPickerPanel').css('display','none');
		$('#borderPickerPanel').remove();
	},
	
	bind : function (extraFunc) {
		var borderPicker = this;

		$('.brdrStyle').bind('mouseover.borderPicker', function(event){
			var y = $(this).css('background-position').split(" ")[1];
			$(this).css('background-position', width + 'px ' + y);
		});
		
		$('.brdrStyle').bind('mouseout.borderPicker', function(event){
			var y = $(this).css('background-position').split(" ")[1];
			$(this).css('background-position', '0px ' + y);
		});
		
		$('.brdrStyle').bind('click.borderPicker' , function(event){
			var index = $(this).attr('id').replace('brdrStyle','');
			borderPicker.m_target.css('background-position', '0px ' + -index * 21 + 'px');
			var brdrWidth = index;
			var brdrStyle = $('.' + borderPicker.m_pattern).css('border-style');
			extraFunc(brdrWidth, brdrStyle);
			borderPicker.unbind();
			borderPicker.close();
			
			stopEventBroadCasting(event);
		});
		
		//body에 onClick 이벤트 바인딩 - 마우스 클릭 이벤트를 가지고 클릭된 지점의 위치를 비교하여 colorPicker를 닫는다.
		$('body').bind('click.borderPicker', function(event){
			var x = parseInt(ebUtil.getAbsLeft('borderPickerPanel'));
			var y = parseInt(ebUtil.getAbsTop('borderPickerPanel'));
			if((event.clientX > x + 195 || event.clientX < x) || (event.clientY > y + 130 || event.clientY < y)){
				borderPicker.unbind();
				borderPicker.close();
			}
		});
	},
	
	unbind : function () {
		$('.brdrStyle').unbind('mouseover.borderPicker');
		$('.brdrStyle').unbind('mouseout.borderPicker');
		$('.brdrStyle').unbind('click.borderPicker');
		$('body').unbind('click.borderPicker');
	}	
}

cfBorderPicker = new cafe.editor.BorderPicker();



cafe.editor.IconPicker = function () {
	this.m_ajax = new enview.util.Ajax();
	this.m_contextPath = ebUtil.getContextPath();
}

cafe.editor.IconPicker.prototype = {
	m_ajax : null,
	m_contextPath : null,
	
	m_target : null,
	m_decoType : null, 
	m_lc : null,
	m_pc : null,
	m_pn : null,
	
	initialize : function (targetId, lc, pc, pn, extraFunc) {
		this.m_target = $('#' + targetId);
		this.m_decoType = targetId.split("_")[0];
		this.m_lc = lc;
		this.m_pc = pc;
		this.m_pn = pn,
		this.open(extraFunc);
	},
	
	initBorder : function () {
		
	},
	
	initPosition : function () {
		var id = this.m_target.attr('id');
		$('#iconPickerPanel').css('position', 'relative');
		$('#iconPickerPanel').css('top', '17px');
		$('#iconPickerPanel').css('left', '-4px');
	},
	
	open : function (extraFunc) {
		var target = this.m_target;
		var iconPicker = this;
   		$.ajax({
			type: 'POST',
			url: this.m_contextPath + '/cafe/editor.cafe',
			data: {
				'lc' : iconPicker.m_lc,
				'pc' : iconPicker.m_pc,
				'pn' : iconPicker.m_pn,
				'm' : 'iconPicker'
			},
			dataType: 'html',
			success: function(html, textStatus){
				target.html(html);
				iconPicker.bind(extraFunc);
				iconPicker.initPosition();
				$('#iconPickerPanel').css('display','block');
				
				var pc = $('.menuIconPage').length;
				$('#menuIconPageList').css('width', (pc*9) + (pc-1)*3 + 'px');
			},
			error: function(x, e){
				alert(e + '\n잠시 후에 다시 시도 해주십시오.');
			}
		});
	},
	
	close : function () {
		$('#iconSelectedBox').css('display', 'none');
		$('#iconPickerPanel').css('display','none');
		$('#iconPickerPanel').remove();
		
		var tDivId = this.m_target.parent().find('.iconPicker').first().attr('id');
		var lc = this.m_lc;
		var pc = this.m_pc;
		this.m_target.parent().bind('click.iconPicker', function(event){
			cfIconPicker.initialize(tDivId, lc, pc, 1, cfGGum.getTplMngr().setMenuIconSet);
		});
	},
	
	bind : function (extraFunc) {
		var iconPicker = this;
		$('.menuIconSet').bind('mouseover.menuIconSet', function(event){
			var id = $(this).attr('id');
			var width =  $(this).css('width').replace('px','') - 4;
			var height =  $(this).css('height').replace('px','') - 4;
			$(this).css('width', width);
			$(this).css('height', height);
			$(this).css('background-position', '-2px -2px');
			$(this).css('border', '2px solid highlight');
		});
		
		$('.menuIconSet').bind('mouseout.menuIconSet', function(event){
			var width =  parseInt($(this).css('width').replace('px','')) + 4;
			var height =  parseInt($(this).css('height').replace('px','')) + 4;
			$(this).css('width', width);
			$(this).css('height', height);
			$(this).css('background-position', '0px 0px');
			$(this).css('border', '0px solid white');
		});
		
		$('.menuIconSet').bind('click.menuIconSet', function(event){
			var id = $(this).attr('id');
			$('#' + iconPicker.m_decoType + '_decoId').val(id);
			extraFunc();
			iconPicker.unbind();
			iconPicker.close();
			stopEventBroadCasting(event);
		});
		
		$('#menuIconPageList').find('.selectable').bind('click.menuIconPage', function(event){
			var targetId = $('#iconPickerPanel').parent().attr('id');
			cfIconPicker.initialize(targetId, 5, 5, parseInt($(this).attr('id').replace('iconPicker_', '')), cfGGum.getTplMngr().setMenuIconSet);
		});
		
		//body에 onClick 이벤트 바인딩 - 마우스 클릭 이벤트를 가지고 클릭된 지점의 위치를 비교하여 colorPicker를 닫는다.
		$('body').bind('click.iconPicker', function(event){
			var x = parseInt(ebUtil.getAbsLeft('iconPickerPanel'));
			var y = parseInt(ebUtil.getAbsTop('iconPickerPanel'));
			if((event.clientX > x + 125 || event.clientX < x) || (event.clientY > y + 150 || event.clientY < y)){
				iconPicker.unbind();
				iconPicker.close();
			}
		});
		this.m_target.parent().unbind('click.iconPicker');
		
	},
	
	unbind : function () {
		$('menuIconSet').unbind('mouseover.menuIconSet');
		$('menuIconSet').unbind('mouseout.menuIconSet');
		$('menuIconSet').unbind('click.menuIconSet');
		$('body').unbind('click.iconPicker');
	}	
}

cfIconPicker = new cafe.editor.IconPicker();


cafe.editor.Dialog = function () {
	
}

cafe.editor.Dialog.prototype = {
	
	opt : null,
	code : null,
	
	curX : null,
	curY : null,
	
	dialogPanel : null,
	width : null,
	height: null,
	titlePanelHeight : 30,
	btnPanelHeight: 32,
	
	titlePanel : null,
	title : '타이틀',
	
	contentPanel : null,
	contents : null,
	buttonPanel : null,
	okButton : '확인',
	cancelButton : '취소',
	
	modalPanel : null,
	modal : null,
	opacity : 0.1,
	closeOnEscape : null,
	draggable: true,
	
	showCallback : null,
	closeCallback : null,
	okCallback: null,
	cancelCallback : null,
	
	isReopen : false,
	isOpen : false,
	
	setOption : function (opt) {
		this.opt = opt;
		
		if(this.code == this.getValue('code')){
			this.isReopen = true;
		}
		else {
			this.code = this.getValue('code');
			this.isReopen = false;
		}
	},
	
	open : function() {
		if(this.isReopen){
			this.reOpenInit();
		}
		else {
			this.curX = null;
			this.curY = null;
		}
		
		if(!this.isOpen){
			this.curX = null;
			this.curY = null;
		}
		this.isOpen = true;
		
		if(this.getValue('modal')){
	   		this.modalPanel = $('<div class="dialog-modal"></div>');
	   		this.modalPanel.css('width', $('html').css('width'));
	   		this.modalPanel.css('height', $('html').css('height'));
	   		this.modalPanel.css('position', 'absolute');
	   		this.modalPanel.css('top', '0px');
	   		this.modalPanel.css('left', '0px');
	   		this.modalPanel.css('z-index', 9000);
	   		this.modalPanel.css('background-color', 'gray');
	   		this.modalPanel.css('opacity', this.getValue('opacity'));
	   		this.modalPanel.appendTo($('body'));
   		}
		
   		this.dialogPanel = $('<div id="cfDialog" class="dialog-panel"></div>');
   		this.dialogPanel.css('width', this.getValue('width'));
   		this.dialogPanel.css('height', 'auto');
   		this.dialogPanel.css('position', 'absolute');
   		this.dialogPanel.css('z-index', 9001);
   		//this.dialogPanel.css('background-color', 'white');
   		this.dialogPanel.appendTo($('body'));
   		
   		this.titlePanel = $('<div id="dialogTitle" class="dialog-title">' + this.getValue('title') + '<input id="titleCloseBtn" class="titleCloseBtn" type="button" value="x"></div>');
   		this.titlePanel.css('width', this.getValue('width'));
   		this.titlePanel.css('height', this.getValue('titlePanelHeight')-2);
   		this.titlePanel.css('margin', '0px auto');
   		this.titlePanel.css('position', 'relative');
   		this.titlePanel.css('top', '0px');
   		this.titlePanel.css('text-indent', '5px');
   		this.titlePanel.css('font-size', '13px');
   		this.titlePanel.css('line-height', '32px');
   		this.titlePanel.css('background-color', '#CCCCCC');
   		this.titlePanel.appendTo(this.dialogPanel);
   		
   		this.contentPanel = $('<div id="dialogContents" class="dialog-contents"></div>');
   		this.contentPanel.html(this.getValue('contents'));
   		this.contentPanel.css('width', this.getValue('width'));
   		this.contentPanel.css('height', this.getValue('height'));
   		this.contentPanel.appendTo(this.dialogPanel);
   		var pageCount = $('#pagePanel .page').length;
   		var width = 25 * pageCount + 30;
   		$('#pagePanel').css('width', width);
   		
   		
   		this.buttonPanel = $('<div class="dialog-buttons"><div class="dialog-buttons-wrap"><div id="dialogOkBtn" class="bottomBtn okBtn" ></div><div id="dialogCancelBtn" class="bottomBtn cancelBtn"></div></div></div>');
   		this.buttonPanel.css('width', this.getValue('width'));
   		this.buttonPanel.css('height', this.getValue('btnPanelHeight'));
   		this.buttonPanel.appendTo(this.dialogPanel);
   		
   		this.setPosition();
   		this.bind();
   		
   		if(this.getValue('showCallback') != null) {
   			this.showCallback = this.getValue('showCallback');
   			this.showCallback();
   		}
	},
	
	close : function () {
		this.unbind();
		this.dialogPanel.remove();
		this.modalPanel.remove();
		this.isOpen = false;
		
		if(this.getValue('closeCallback') != null) {
   			this.closeCallback = this.getValue('closeCallback');
   			this.closeCallback();
   		}
	},
	
	reOpenInit : function (){
		this.unbind();
		this.dialogPanel.remove();
		this.modalPanel.remove();
	},
		
	bind : function () {
		var closeOnEscape = this.getValue('closeOnEscape');
		if(closeOnEscape){
	   		$('html').bind('keyup.dialog', function(event){
	   			if(event.keyCode == 27) {
	   				cfDialog.close();
	   			}
	   		});
		}
		$('#titleCloseBtn').bind('click.titleCloseBtn', function(event){
			cfDialog.close();
		});
		
		$('#dialogOkBtn').bind('click.okCallback', this.getValue('okCallback'));
		$('#dialogOkBtn').bind('click.dialogOkBtn', function(event){
			cfDialog.close();
		});
		$('#dialogCancelBtn').bind('click.cancelCallback', this.getValue('cancelCallback'));
		$('#dialogCancelBtn').bind('click.dialogCancelBtn', function(event){
			cfDialog.close();
		});
		if(this.getValue('draggable')){
			$('#cfDialog').draggable({
				handle: 'div#dialogTitle',
				cursor: 'pointer',
				start: function(){
					cfDialog.dragStart();
				},
				drag: function() {
					//cfDialog.dragging();
				},
				stop: function() {
					cfDialog.dragStop();
				}
			});
		}
   	},
   	
   	unbind : function() {
	   	$('html').unbind('keyup.dialog');
	   	$('#titleCloseBtn').bind('click.titleCloseBtn');
		$('#dialogOkBtn').unbind('click.okCallback');
		$('#dialogOkBtn').unbind('click.dialogOkBtn');
		$('#dialogCancelBtn').unbind('click.cancelCallback');
		$('#dialogCancelBtn').unbind('click.dialogCancelBtn');
		$('#cfDialog').draggable("destroy");
   	},
   	
   	getValue : function(optName){
   		var optObj = eval(this.opt);
   		var optValue = eval('optObj.' + optName);
   		if(optValue != undefined) {
   			return optValue;
   		}
   		else {
   			var optValue2 = eval('this.' + optName);
   			if(optValue2 != undefined) {
   				return optValue2;
   			}
   			else return null;
   		}
   	},
   	
   	setPosition : function () {
   		if(this.curX == null){
			this.curX = ($('html').css('width').replace('px','') - this.getValue('width') )/2;
		}
		if(this.curY == null){
			this.curY = ($('html').css('height').replace('px','') - this.getValue('height') )/2 - 50;
		}
   		this.dialogPanel.css('left', this.curX);
   		this.dialogPanel.css('top', this.curY);
   	},
   	
   	dragStart : function () {
   		this.curX = ebUtil.getAbsLeft('cfDialog');
   		this.curY = ebUtil.getAbsTop('cfDialog');
   	},
   	
   	dragging : function () {
   		this.curX = ebUtil.getAbsLeft('cfDialog');
   		this.curY = ebUtil.getAbsTop('cfDialog');
   	},
   	
   	dragStop : function () {
   		this.curX = ebUtil.getAbsLeft('cfDialog');
   		this.curY = ebUtil.getAbsTop('cfDialog');
   	}
}

cfDialog = new cafe.editor.Dialog();

cafe.editor.Slider = function () {
	
}

cafe.editor.Slider.prototype = {
	m_target : null,
	
	m_opacity : 0,
	
	initialize : function(targetId, callback){
		this.m_target = $('.' + targetId).first();
		this.bind(callback);
	},
	
	bind : function (callback) {
		var target = this.m_target;
		var opacity = this.m_opacity;
		target.draggable({
			axis: 'x',
			containment: 'parent',
			start : function(){
				var left = parseInt(target.css('left').replace('px', ''));
				if(0 <= left && left <= 3) opacity = 1;
				else opacity = 1 - (left * 0.02);
				callback(opacity);
			},
			drag : function(){
				var left = parseInt(target.css('left').replace('px', ''));
				if(0 <= left && left <= 3) opacity = 1;
				else opacity = 1 - (left * 0.02);
				callback(opacity);
			},
			stop : function(){
				var left = parseInt(target.css('left').replace('px', ''));
				if(0 <= left && left <= 3) opacity = 1;
				else opacity = 1 - (left * 0.02);
				callback(opacity);
				$(this).attr('title', left * 2);
				$(this).parent().attr('title', left * 2);
			}
		});
		
		target.parent().bind('click.' + target.parent().attr('id'), function(event){
			var $this = $(this);
			var left = event.x - $this.offset().left;
			if(left >= 50 ) left = 50;
			else if(left <= 0 ) left = 0;
			target.css('left', left);
			callback(1 - (left * 0.02));
			target.attr('title', left * 2);
			$this.parent().attr('title', left * 2);
		});
		
		target.parent().siblings('.sliderBtn').each(function(){
			var ids = $(this).attr('id').split("_");
			var soo = ids[ids.length-1];
			if(soo == 'minus'){
				$(this).bind('click.trpcMinus', function(event){
					var curLeft = parseInt(target.css('left').replace('px','')) - 1;
					if(curLeft< 0) curLeft = 0;
					target.css('left', curLeft);
					target.attr('title', curLeft * 2);
					target.parent().attr('title', curLeft * 2);
				});
			}
			else if(soo == 'plus') {
				$(this).bind('click.trpcPlus', function(event){
					var curLeft = parseInt(target.css('left').replace('px','')) + 1;
					if(curLeft > 50) curLeft = 50;
					target.css('left', curLeft);
					target.attr('title', curLeft * 2);
					target.parent().attr('title', curLeft * 2);
				});
			}
		});
		
	}
}

cfSlider = new cafe.editor.Slider();


cafe.editor.AlignPicker = function () {
	this.m_ajax = new enview.util.Ajax();
	this.m_contextPath = ebUtil.getContextPath();
}

cafe.editor.AlignPicker.prototype = {
	m_ajax : null,
	m_contextPath : null,
	
	m_target : null,
	
	m_posX : '',
	m_posY : '',
	
	m_alignBgPosX : '',
	m_alignBgPosY : '',
	
	m_extraFunc : null,
	
	initialize : function (objId, extraFunc, posX, posY) {
		this.m_target = $('#' + objId);
		this.m_extraFunc = extraFunc;
		this.m_posX = posX;
		this.m_posY = posY;
		this.moveAlignImage();
		this.open();
	},
	
	initPosition : function () {
		var id = this.m_target.attr('id');
		$('#borderPickerPanel').css('position', 'relative');
		$('#borderPickerPanel').css('top', '22px');
		$('#borderPickerPanel').css('left', '0px');
	},
	
	setBgImgPos : function (objId, posX, posY){
		this.m_posX = posX;
		this.m_posY = posY;
		this.moveAlignImage();
		$('#' + objId).css('background-position-x', this.m_alignBgPosX);
		$('#' + objId).css('background-position-y', this.m_alignBgPosY);
	},
	
	moveAlignImage : function(){
		switch(this.m_posX){
			case 'left': this.m_alignBgPosX = "right"; break;
			case 'center': this.m_alignBgPosX = "center"; break;
			case 'right': this.m_alignBgPosX = "left"; break;
			default: break;
		}
		
		switch(this.m_posY){
			case 'top': this.m_alignBgPosY = "bottom"; break;
			case 'center': this.m_alignBgPosY = "center"; break;
			case 'bottom': this.m_alignBgPosY = "top"; break;
			default: break;
		}
		$('#alignPickerPanel').css('background-position-x', this.m_alignBgPosX);
		$('#alignPickerPanel').css('background-position-y', this.m_alignBgPosY);
	},
	
	open : function () {
		var target = this.m_target;
		var alignPicker = this;
   		$.ajax({
			type: 'POST',
			url: this.m_contextPath + '/cafe/editor.cafe',
			data: {
				'm' : 'alignPicker'
			},
			dataType: 'html',
			success: function(html, textStatus){
				alignPicker.m_target.html(html);
				alignPicker.bind(alignPicker.m_extraFunc);
				alignPicker.initPosition();
				alignPicker.moveAlignImage();
				$('#alignPickerPanel').css('display','block');
			},
			error: function(x, e){
				alert(e + '\n잠시 후에 다시 시도 해주십시오.');
			}
		});
	},
	
	close : function () {
		var alignPicker = this;
		
		$('#alignPickerPanel').css('display','none');
		$('#alignPickerPanel').remove();
	},
	
	bind : function (extraFunc) {
		var alignPicker = this;

		$('#alignPickerPanel').bind('mousemove.alignPicker' , function(event){
			var x = parseInt(ebUtil.getAbsLeft('alignPickerPanel'));
			var y = parseInt(ebUtil.getAbsTop('alignPickerPanel'));
			
			var wx = event.clientX - x;
			if(wx < 23){
				alignPicker.m_posX = "left";
			}else if (23 <= wx && wx < 45){
				alignPicker.m_posX = "center";
			}else if(45 <= wx && wx < 67){
				alignPicker.m_posX = "right";
			}
			
			var wy = event.clientY - y;
			if(wy < 14){
				alignPicker.m_posY = "top";
			}else if (14 <= wy && wy < 27){
				alignPicker.m_posY = "center";
			}else if(27 <= wy && wy < 40){
				alignPicker.m_posY = "bottom";
			}
			alignPicker.moveAlignImage();
		});
		
		$('#alignPickerPanel').bind('click.alignPicker' , function(event){
			alignPicker.m_target.css('background-position-x', alignPicker.m_alignBgPosX);
			alignPicker.m_target.css('background-position-y', alignPicker.m_alignBgPosY);
			
			extraFunc(alignPicker.m_posX, alignPicker.m_posY);
			alignPicker.unbind();
			alignPicker.close();
			
			stopEventBroadCasting(event);
		});
		
		//body에 onClick 이벤트 바인딩 - 마우스 클릭 이벤트를 가지고 클릭된 지점의 위치를 비교하여 colorPicker를 닫는다.
		$('body').bind('click.alignPicker', function(event){
			var x = parseInt(ebUtil.getAbsLeft('alignPickerPanel'));
			var y = parseInt(ebUtil.getAbsTop('alignPickerPanel'));
			if((event.clientX > x + 67 || event.clientX < x) || (event.clientY > y + 40 || event.clientY < y)){
				alignPicker.unbind();
				alignPicker.close();
			}
		});
	},
	
	unbind : function () {
		$('#alignPickerPanel').unbind('mouseover.alignPicker');
		$('#alignPickerPanel').unbind('click.alignPicker');
		$('body').unbind('click.alignPicker');
	}	
}

cfAlignPicker = new cafe.editor.AlignPicker();