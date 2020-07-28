if (!window.cafe) window.cafe = new Object();

cafe.ggum = function () {
	this.m_ajax = new enview.util.Ajax();
	this.m_contextPath = ebUtil.getContextPath();
}
cafe.ggum.prototype = {
	m_ajax : null,
	m_contextPath : null,
	m_menu : null,
	m_subMenu : null,
	m_3rdMenu : null,
	m_pageNum : null,
	m_selectedDecoId : null,
	
	m_layMngr: null,
	m_footMngr: null,
	
	m_tplMngr: null,
	
	m_infoMngr: null,
	
	
	m_cnttMngr: null,
	m_bogaMngr: null,	
	
	m_util : null,
	
	m_boardLayCnt : 0,
	
	m_cafeUrl : null,
	m_isModal : false,
	m_isGGumName : '꾸미기',
	
	initGGum : function () {
		if(cfGGum.m_isModal){
			cfGGum.showModalFrame();
			cfGGum.getDragMngr (document.body, "remoteLayerTitle,remoteDummyTop", document.getElementById("remoteLayer")).attach();
			cfGGum.getDNDMngr ("CafeInfoPortlet,CafeMenuPortlet,CafeSrchPortlet,CafeBuga*,wf_HOMEBOARDGROUP*").attach();
			alert(cfGGum.m_isGGumName + '을(를) 끝내시려면 ESC키를 눌러주세요.');
		}else{
			cfGGum.getDragMngr (document.body, "remoteLayerTitle,remoteDummyTop", document.getElementById("remoteLayer")).attach();
			cfGGum.getDNDMngr ("CafeInfoPortlet,CafeMenuPortlet,CafeSrchPortlet,CafeBuga*,wf_HOMEBOARDGROUP*").attach();
		}
	},		
	onClickMenu : function (menu, subMenu, samMenu, pageNum) {
		if (menu == this.m_menu && subMenu == this.m_subMenu && samMenu == this.m_3rdMenu && pageNum == this.m_pageNum ) return;

		this.m_menu    = menu;
		this.m_subMenu = subMenu;
		this.m_3rdMenu = samMenu;
		this.m_pageNum = pageNum;
		var remoteLayer    = document.getElementById("remoteLayer");
		var remoteLayerPos = ebUtil.getAbsPoint (remoteLayer);
		var windowWidth    = window.innerWidth;
		var remainSpace    = windowWidth - remoteLayerPos.m_x - 30; // 30: 스크롤바 넓이 및 여백

		$("#remoteMenu").find("a").attr("class","selected").attr("class","");
		$("#remoteLayerTitle").find("ul[class='remote_mini_menu']").find("a").attr("class","selected").attr("class","");

		if (cfGGum.m_menu == "skin") {
			$(remoteLayer).attr("class","remote_max").css("width","332px");
			if (remainSpace < 332) $(remoteLayer).css("left",(windowWidth - 332 - 30)+"px");
			$("#remoteMenu").find("li[class='rmd1_skin']").find("a").attr("class","selected");
			$("#remoteLayerTitle").find("li[class='btn_remote_mini_Skin']").find("a").attr("class","selected");
			$("#remoteRight").css("display","none");
		} else if (cfGGum.m_menu == "layout") {
			$(remoteLayer).attr("class","remote_max").css("width","796px");
			if (remainSpace < 796) $(remoteLayer).css("left",(windowWidth - 796 - 30)+"px");
			$("#remoteMenu").find("li[class='rmd1_layout']").find("a").attr("class","selected");
			$("#remoteLayerTitle").find("li[class='btn_remote_mini_Layout']").find("a").attr("class","selected");
			$("#remoteRight").css("display","");
		} else if (cfGGum.m_menu == "ggumigi") {
			$("#remoteLayer").attr("class","remote_max").css("width","332px");
			if (remainSpace < 332) $(remoteLayer).css("left",(windowWidth - 332 - 30)+"px");
			$("#remoteMenu").find("li[class='rmd1_design']").find("a").attr("class","selected");
			$("#remoteLayerTitle").find("li[class='btn_remote_mini_Design']").find("a").attr("class","selected");
			$("#remoteRight").css("display","none");
		}
		
		if(cfGGum.m_subMenu == 'skin'){
//			cfGGum.m_3rdMenu = 'list';
			cfGGum.m_pageNum = '1';
		} else if(cfGGum.m_subMenu == 'cafeBg'){
			
		}
		
		var param = "m=uiGGum";
		param += "&cafeUrl="     + cfEach.m_curCafeUrl;
		param += "&cmd="         + "subMenu";
		param += "&ggumMenu="    + this.m_menu;
		param += "&ggumSubMenu=" + this.m_subMenu;
		param += "&ggum3rdMenu=" + this.m_3rdMenu;
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/editor.cafe", param, true, {success: function(htmlData) {
			document.getElementById("remoteSubMenu").innerHTML = htmlData;

			var param = "m=uiGGum";
			param += "&cafeUrl="     + cfEach.m_curCafeUrl;
			param += "&cmd="         + "pane";
			param += "&ggumMenu="    + cfGGum.m_menu;
			param += "&ggumSubMenu=" + cfGGum.m_subMenu;
			param += "&ggum3rdMenu=" + cfGGum.m_3rdMenu;
			param += "&pageNum="	 + cfGGum.m_pageNum;
			
			cfGGum.m_ajax.send("POST", cfGGum.m_contextPath+"/cafe/editor.cafe", param, true, {success: function(htmlData) {
				document.getElementById("remoteControlContent").innerHTML = htmlData;
				
				var param = "m=uiGGum";
				param += "&cafeUrl="     + cfEach.m_curCafeUrl;
				param += "&cmd="         + "foot";
				param += "&ggumMenu="    + cfGGum.m_menu;
				param += "&ggumSubMenu=" + cfGGum.m_subMenu;
				cfGGum.m_ajax.send("POST", cfGGum.m_contextPath+"/cafe/editor.cafe", param, true, {success: function(htmlData) {
					document.getElementById("remoteFooter").innerHTML = htmlData;
					
					//////////////////////////////////////////////////////////////////////////////////////////
					// 메뉴가 선택되면, 꾸미기Handle의 컨텐츠영역이 바뀐다. 컨텐츠영역을 초기화한다.
					//////////////////////////////////////////////////////////////////////////////////////////
					if (cfGGum.m_menu == "layout") {
						cfGGum.getLayMngr().initDecoInfo (cfGGum.m_subMenu, cfGGum.m_3rdMenu);
					}
					//////////////////////////////////////////////////////////////////////////////////////////
					cfGGum.getTplMngr().setDeco(cfGGum.m_subMenu);
					cfGGum.getTplMngr().setPanelType(cfGGum.m_3rdMenu);
					cfGGum.getTplMngr().initContent();
					cfGGum.getTplMngr().attach(cfGGum.m_subMenu, cfGGum.m_3rdMenu);
				}});
			}});
		}});
	},
	
	initFooter : function (){
		cfGGum.getTplMngr().reset(this.m_subMenu);
	},
	
	onChange3rdSelectBox : function (elm) {
		var param = "m=uiGGum";
		param += "&cafeUrl="     + cfEach.m_curCafeUrl;
		param += "&cmd="         + "pane";
		param += "&ggumMenu="    + cfGGum.m_menu;
		param += "&ggumSubMenu=" + cfGGum.m_subMenu;
		param += "&ggum3rdMenu=" + cfGGum.m_3rdMenu;
		param += "&ggum4thMenu=" + ebUtil.getSelectedValue (elm);
		cfGGum.m_ajax.send("POST", cfGGum.m_contextPath+"/cafe/editor.cafe", param, true, {success: function(htmlData) {
			document.getElementById("remoteControlContent").innerHTML = htmlData;
			if(cfGGum.m_subMenu == "cafeBg" ) cfGGum.getTplMngr().onClickSkinCafeBgColor();
			else if(cfGGum.m_subMenu == "board" ) {
				
			}
		}});
	},
	onClickMinMax : function () {
		if ($("#remoteLayer").attr("class") == "remote_min") {
			if (this.m_menu == null) {
				cfGGum.onClickMenu ("skin","skin","list");
			}
			$("#remoteLayer").attr("class","remote_max").css("width","332px");
			if (this.m_menu == "layout") {
				if ($("#wfVisible").attr("class") == "hide") {
					$("#remoteRight").css("display", "none");
					$("#remoteLayer").css("width","332px");
				} else {
					$("#remoteRight").css("display", "");
					$("#remoteLayer").css("width","796px");
				}
			}
		} else {
			$("#remoteLayer").attr("class","remote_min").css("width","222px");
			$("#remoteRight").css("display","none");
		}
	},
	onClickPin : function () {
		var elm = document.getElementById("remoteLayer");
		if (elm.style.position == "absolute") {
			$("#remoteControlLockButton").attr("class","lock");
			elm.style.position = "fixed";
		} else {
			$("#remoteControlLockButton").attr("class","");
			elm.style.position = "absolute";
		}
	},
	onViewFrame : function () {
		var elm = document.getElementById("remoteRight");
		if (elm.style.display == "none") {
			elm.style.display = "";
			$("#wfVisible").attr("class","");
			$("#remoteLayer").css("width","796px");
		} else {
			elm.style.display = "none";
			$("#wfVisible").attr("class","hide");
			$("#remoteLayer").css("width","332px");
		}
	},
	onClickApply : function () {
		//if (!confirm (ebUtil.getMessage("cf.info.ggum.apply"))) return;
		//****************************************************************************************************
		var decoPrefsAll = new Array();
		//****************************************************************************************************
		// cafe.ggum.LayMngr이 가진 deco 정보 (레이아웃, 게시판유형)
		//****************************************************************************************************
//		var decoPrefs = cfGGum.getLayMngr().getDecoPrefValue.getDecoPrefs();
		var decoPrefs = cfGGum.getLayMngr().m_deco.getDecoPrefs();

		var tmpMsg = "***** before decoPrefs *****\n";
		for (var i=0; i<decoPrefs.length; i++)tmpMsg += "clazz=["+decoPrefs[i].clazz+"],value=["+decoPrefs[i].value+"]\n"
//		alert(tmpMsg);

		//----------------------------------------------------------------------------------------------------
		// 좌측메뉴부분 영역들의 순서
		//----------------------------------------------------------------------------------------------------
		var maPanel = document.getElementById("wf_MENUPANEL");
		var menuAreaOrder = "";
		for (var i=0, idx=0; i<maPanel.childNodes.length; i++) {
			if (maPanel.childNodes[i].nodeType == 1 && maPanel.childNodes[i].tagName.toUpperCase() == "DIV") {
				if (idx++ != 0) menuAreaOrder += ";";
				menuAreaOrder += maPanel.childNodes[i].id;
			}
		}
		cfEach.getUtil().setValueOfClass (decoPrefs, "CF1101_menuAreaOrder", menuAreaOrder);
		//----------------------------------------------------------------------------------------------------
		// 부가컨텐츠부분 영역들의 순서
		//----------------------------------------------------------------------------------------------------
		var baPanels = $("div[id^='wf_ACCESSARYPANEL']");
		var bugaAreaOrder = "";
		for (var i=0; i<baPanels.length; i++) {
			if (i != 0) bugaAreaOrder += ";";
			for (var j=0, idx=0; j<baPanels[i].childNodes.length; j++) {
				if (baPanels[i].childNodes[j].nodeType == 1 && baPanels[i].childNodes[j].tagName.toUpperCase() == "DIV") {
					if (idx++ != 0) bugaAreaOrder += ",";
					bugaAreaOrder += baPanels[i].childNodes[j].id;
				}
			}
		}
		cfEach.getUtil().setValueOfClass (decoPrefs, "CF1101_bugaAreaOrder", bugaAreaOrder);
		//----------------------------------------------------------------------------------------------------
		// 게시판유형그룹들의 순서
		//----------------------------------------------------------------------------------------------------
		var brdPanel = document.getElementById("wf_HOMEBOARDPANEL");
		var brdGrpTypeAll = "";
		var brdIdAll = "";
		var brdTypeAll = "";
		for (var i=0, idx=0; i<brdPanel.childNodes.length; i++) {
			if (brdPanel.childNodes[i].nodeType == 1 && brdPanel.childNodes[i].tagName.toUpperCase() == "DIV") {
				if (idx++ != 0) {
					brdGrpTypeAll += "::";
					brdIdAll += "::";
					brdTypeAll += "::";
				}				

				brdGrpTypeAll += brdPanel.childNodes[i].getAttribute ("brdGrpTypes");
				cfEach.getUtil().setValueOfClass (decoPrefs, "CF1102_brdGrpType", brdGrpTypeAll);
				
				brdIdAll      += brdPanel.childNodes[i].getAttribute ("brdIds");
				cfEach.getUtil().setValueOfClass (decoPrefs, "CF1102_brdId", brdIdAll);

				brdTypeAll    += brdPanel.childNodes[i].getAttribute ("brdTypes");
				cfEach.getUtil().setValueOfClass (decoPrefs, "CF1102_brdType", brdTypeAll);
			}
		}
		
		var bgDecoPrefs = cfBg.getDeco().getDecoPrefs();
		
		var tmpMsg = "***** completed decoPrefs *****\n";
		for (var i=0; i<bgDecoPrefs.length; i++)tmpMsg += "clazz=["+bgDecoPrefs[i].clazz+"],value=["+bgDecoPrefs[i].value+"]\n"
//		alert(tmpMsg);
		
		
		var titleDecoPrefs = cfTitle.getDeco().getDecoPrefs();
		var infoDecoPrefs = cfInfo.getDeco().getDecoPrefs();
		var menuDecoPrefs = cfMenu.getDeco().getDecoPrefs();
		var srchDecoPrefs = cfSrch.getDeco().getDecoPrefs();
		var cnttDecoPrefs = cfCntt.getDeco().getDecoPrefs();
		
		if (!confirm (ebUtil.getMessage ("cf.info.ggum.apply"))) return;
		
		decoPrefsAll = decoPrefsAll.concat (decoPrefs);
		decoPrefsAll = decoPrefsAll.concat (bgDecoPrefs);
		decoPrefsAll = decoPrefsAll.concat (titleDecoPrefs);
		decoPrefsAll = decoPrefsAll.concat (infoDecoPrefs);
		decoPrefsAll = decoPrefsAll.concat (menuDecoPrefs);
		decoPrefsAll = decoPrefsAll.concat (srchDecoPrefs);
		decoPrefsAll = decoPrefsAll.concat (cnttDecoPrefs);
		

		//테마
		var themeCss = $("#themeCss").attr("href");
		var theme = themeCss.substring( themeCss.lastIndexOf('/')+1, themeCss.length - 4);
//		alert( theme);
		decoPrefsAll.push( {clazz : "CF0801_theme", value : theme});
		
		var tmpMsg = "***** completed decoPrefs *****\n";
		for (var i=0; i<decoPrefsAll.length; i++)tmpMsg += "clazz=["+decoPrefsAll[i].clazz+"],value=["+decoPrefsAll[i].value+"]\n"
//		alert(tmpMsg);
		
		
		//****************************************************************************************************
		// 모든 영역의 decoPrefs를 모두 모아서 서버로 올려준다.
		//****************************************************************************************************
		var param = "m=setGgumDecoPrefs";
		param += "&cafeUrl=" + cfEach.m_curCafeUrl;
		for (var i=0; i<decoPrefsAll.length; i++) {
			param += "&" + decoPrefsAll[i].clazz + "=" + decoPrefsAll[i].value;
		}
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/editor.cafe", param, true, {success: function(data) {
			alert (ebUtil.getMessage("mm.info.success"));
			cfEach.m_isEdited = false;
			cfEach.go2EachHome();
		}});
		//****************************************************************************************************
	},
	
	onClickCancel : function () {
		cfEach.go2EachHome();
	},
	getDragMngr : function (dragCntr, handleIds, dragElm) {
		return new cafe.ggum.DragMngr (dragCntr, handleIds, dragElm);
	},
	getDNDMngr : function (dragIds) {
		return new cafe.ggum.DNDMngr (dragIds);
	},
	getLayMngr : function () {
		if (this.m_layMngr == null) this.m_layMngr = new cafe.ggum.LayMngr ();
		return this.m_layMngr;
	},
	getFootMngr : function () {
		if (this.m_footMngr == null) this.m_footMngr = new cafe.ggum.FootMngr ();
		return this.m_footMngr;
	},
	getInfoMngr : function () {
		if (this.m_infoMngr == null) this.m_infoMngr = new cafe.ggum.InfoMngr ();
		return this.m_infoMngr;
	},
	getTplMngr : function () {
		if (this.m_tplMngr == null) this.m_tplMngr = new cafe.ggum.TplMngr ();
		return this.m_tplMngr;
	},
	
	showModalFrame : function(){
		var modalFrame = $('<div class="modal-frame" id="modal-frame" name="modal-frame"></div>');
		modalFrame.css('width', $('body').css('width'));
		modalFrame.css('height', $('body').css('height'));
		modalFrame.css('background-color', 'gray');
		modalFrame.css('overflow', 'hidden');
		modalFrame.css('position','absolute');
		modalFrame.css('top', '0');
		modalFrame.css('left', '0');
		modalFrame.css('background-color', 'gray');
		modalFrame.css('opacity', '0.3');
		modalFrame.appendTo('body');
		
		$('body').bind('keyup.edit', function(event){
			var keyCode = event.keyCode;
			if(keyCode == 27){
				location.href = cfGGum.m_contextPath + "/cafe/" + cfGGum.m_cafeUrl;
			}
		});
	}
}

cafe.ggum.DragMngr = function (dragCntr, handleIds, dragElm, xOnly, yOnly, dnCallback, upCallback, mvCallback) {
	//********************************************************************************************************
	// dragCntr : Drag할 객체가 놓여있는 container 객체. 일반적으로 document.body 를 주면된다.
	// handleIds: Drag할 때 마우스로 찝을 대상이 되는 객체의 id.
	//           핸들 객체가 여러개일 때는 각각의 id를 ','로 구분한다.
	//           또한, id가 동일 prefix로 시작하는 것이 여러개일때는 id의 prefix + '*'의 형태로 주어도 인식한다.
	// dragElm  : 핸들을 잡고 옮길 때, 실제로 drag가 되는 객체. 이 인자가 공급이 되지 않으면 핸들 객체가 drag 된다.
	// dnCallback: Drag를 위해 마우스를 click down 했을 때 호출해주어야 할 함수
	// dnCallback: Drag가 끝나서 마우스를 click up 했을 때 호출해주어야 할 함수
	// mvCallback: Drag를 하는 도중에 호출해주어야 할 함수,
	//             특별한 경우가 아니라면 할당을 안하는 것이 좋겠다. Performance가 문제될 수 있으므로
	//********************************************************************************************************
    this.m_dragCntr = dragCntr;
    this.m_handleIds = handleIds.split(",");
	this.m_dragElm = dragElm;
    this.m_dragHeader = null;
    this.m_dragX = 0;
    this.m_dragY = 0;
	this.m_dnCallback = dnCallback,
	this.m_upCallback = upCallback,
	this.m_mvCallback = mvCallback,
	this.m_xOnly = xOnly;
	this.m_yOnly = yOnly;
    
    this.isStartDragging = false;
	
	this.m_debugger = new enview.util.Debugger('DebuggerDisplay');
	//this.m_debugger.hide();
}
cafe.ggum.DragMngr.prototype = {
	m_dragCntr  : null,
    m_handleIds : null, 
	m_dragElm   : null,
    m_dragHeader : null,
    m_dragX : 0,
    m_dragY : 0,
	m_dnCallback : null,
	m_upCallback : null,
	m_mvCallback : null,
	m_xOnly : null,
	m_yOnly : null,
	m_headerZIndex : null,
    isStartDragging : false,
	m_debugger : null,
	
	attach : function () {
	    var thisObj = this;
		if (window.attachEvent) {
			this.m_dragCntr.attachEvent ("onmousedown", function (event) { thisObj.onMouseDown(event); });
			this.m_dragCntr.attachEvent ("onmouseup",   function (event) { thisObj.onMouseUp(event);   });
			this.m_dragCntr.attachEvent ("onmousemove", function (event) { thisObj.onMouseMove(event); });
		} else if (window.addEventListener) {
			this.m_dragCntr.addEventListener ("mousedown", function (event) { thisObj.onMouseDown(event); });
			this.m_dragCntr.addEventListener ("mouseup",   function (event) { thisObj.onMouseUp(event);   });
			this.m_dragCntr.addEventListener ("mousemove", function (event) { thisObj.onMouseMove(event); });
		} else {
			this.m_dragCntr.onmousedown = function (event) { thisObj.onMouseDown(event); };
			this.m_dragCntr.onmouseup   = function (event) { thisObj.onMouseUp(event);   };
			this.m_dragCntr.onmousemove = function (event) { thisObj.onMouseMove(event); };
		}
	    // this.m_dragCntr.onmousedown = function (event) { thisObj.onMouseDown(event); };
	    // this.m_dragCntr.onmouseup   = function (event) { thisObj.onMouseUp  (event); };
	    // this.m_dragCntr.onmousemove = function (event) { thisObj.onMouseMove(event); };
	},
	onMouseDown : function (evt) {
		if (evt == null) evt = event;
		if (evt.button != 0 && evt.button != 1) return;	// left mouse button click

	    var trgtElm = this.getTarget (evt);
		if (trgtElm != null) {
			this.isStartDragging = true;
			if (this.m_dnCallback) this.m_dnCallback(); // Call callback function.
			if (this.m_dragElm) 
				this.m_dragHeader = this.m_dragElm;
			else
				this.m_dragHeader = trgtElm;

			this.m_headerZIndex = this.m_dragHeader.style.zIndex;
			this.m_dragHeader.style.zIndex = "9999";

			var pos = ebUtil.getAbsPoint (this.m_dragHeader);
			this.m_dragX = evt.clientX - pos.m_x;
			this.m_dragY = evt.clientY - pos.m_y;
			//alert("evtX=["+evt.clientX+"],evtY=["+evt.clientY+"],absX=["+pos.m_x+"],absY=["+pos.m_y+"],dragX=["+this.m_dragX+"],dragY=["+this.m_dragY+"]");

			//this.m_debugger.printCoordinate(evt, this.m_dragHeader);
			
		    if (this.m_dragHeader.setCapture) {
		    	this.m_dragHeader.setCapture ();
			} else {
				document.body.addEventListener ("mousemove", this, true);
			}
			this.cancelEvent (evt);
		} else {
			return;
		}
	},
	onMouseMove : function (evt) {
		if (this.isStartDragging == false) return;

		//evt = (evt == null) ? event : evt;
		if (evt == null) evt = event;
		if (this.m_dragHeader) {
			if (this.m_dragHeader.style.display == "none") {
				this.m_dragHeader.style.display = "";
			}
			if (!this.m_xOnly || this.m_xOnly != "true") this.m_dragHeader.style.left = evt.clientX - this.m_dragX + "px";
			if (!this.m_yOnly || this.m_yOnly != "true") this.m_dragHeader.style.top  = evt.clientY - this.m_dragY + "px";
			
			this.m_debugger.printCoordinate(evt, this.m_dragHeader);
			this.cancelEvent(evt);

			if (this.m_mvCallback) this.m_mvCallback(); // Call callback function.
		}
	    // Prevent text being selected when the header is dragged by the mouse
	},
	onMouseUp : function (evt) {
		if (this.isStartDragging == false) return;

		//evt = (evt == null) ? event : evt;
		if (evt == null) evt = event;
		if (evt.button != 0 && evt.button != 1) return;	// left mouse button click

	    if (this.m_dragHeader != null) {
			if (this.m_upCallback) this.m_upCallback(); // Call callback function.

			this.m_dragHeader.style.zIndex   = this.m_headerZIndex;

	        if (this.m_dragHeader.releaseCapture) {
	        	this.m_dragHeader.releaseCapture ();
			} else {
				document.body.removeEventListener ("mousemove", this,true);
				document.body.removeEventListener ("mouseup", this,true);
			}
	        this.m_dragHeader = null;
			this.cancelEvent(evt);
			this.isStartDragging = false;
	    }
	},
	cancelEvent : function (evt) {
		if (document.all) {	// it is IE
			evt.cancelBubble = true;
			evt.returnValue = false;
		} else {
			evt.preventDefault ();
			evt.stopPropagation ();
		}
	},
	getTarget : function (evt) {
		var srcElm = evt.srcElement ? evt.srcElement : evt.target;
		return this.getParentElm (srcElm, 10);
	},
	getParentElm : function (elm, srchLevel)	{
		if (!elm.nodeName) return null;
		
		var findElm = null;
		var compareId = "";
		for (var i=0; i<this.m_handleIds.length; i++) {
			var pos = this.m_handleIds[i].lastIndexOf("*");
			if (pos > -1) {
				compareId = this.m_handleIds[i].substring(0, pos);
				findElm = this.getParentElmInclude (elm, compareId, srchLevel);
			} else {
				compareId = this.m_handleIds[i];
				findElm = this.getParentElmExactly (elm, compareId, srchLevel);
			}		
			if (findElm != null ) return findElm;
		}
		return null;
	},
	getParentElmExactly : function (elm, srchId, srchLevel) {
		var parentElm = elm;
	    for (var idx=0; idx<srchLevel; idx++) {
			if (parentElm == null) return null;
			if (parentElm.id == srchId) return parentElm;
	        parentElm = parentElm.parentNode;
	    }
		return null;
	},
	getParentElmInclude : function (elm, srchId, srchLevel)	{
		var parentElm = elm;
	    for ( var idx=0; idx<srchLevel; idx++) {
			if (parentElm == null) return null;
			if (parentElm.id != null && parentElm.id.indexOf (srchId) > -1) return parentElm;
	        parentElm = parentElm.parentNode;
	    }
		return null;
	},
	// handleEvent는 왜 있지? 쓰는데가 없다.2012.04.24.KWShin.
	handleEvent : function (evt) {
		if (evt.type == "mousemove") {
			this.onMouseMove (evt);
		} else if (evt.type == "mouseup") {
			this.onMouseUp (evt);
		}
	}
};

cafe.ggum.LayMngr = function () {
	this.m_deco	= new cafe.each.Deco(this);
}
cafe.ggum.LayMngr.prototype = {
	
	m_brdGrpSeq : 0,
	m_brdGrpCnt : 0,
	m_brdCnt    : 0,
	m_deco : null,

	initDecoInfo : function (subMenu, samMenu) {
		if (this.m_deco.getDecoPrefsOrg().length == 0) {
			//************************************************************************************************
			// remoteLayer.jsp 실행 시 hidden field 'layoutDecos'에 text 형태로 내려와있던 데이터를
			// m_deco 에 옮겨준다. 여기에는 레이아웃 구성에 관한 해당 카페의 정보가 들어 있다.
			//************************************************************************************************
			var decoPrefs = eval (document.getElementById("layoutDecos").value);
			this.m_deco.setDecoPrefs (decoPrefs);
			
			//var tmpMsg = "***** decoPrefs *****\n";
			//for (var i=0; i<decoPrefs.length; i++)tmpMsg += "clazz=["+decoPrefs[i].clazz+"],value=["+decoPrefs[i].value+"]\n"
			//alert(tmpMsg);
			
			this.m_deco.setDecoPrefsOrg (ebUtil.clone (decoPrefs));
			
			//var decoPrefsOrg = this.m_deco.getDecoPrefsOrg();
			//var tmpMsg = "***** decoPrefsOrg *****\n";
			//for (var i=0; i<decoPrefsOrg.length; i++)tmpMsg += "clazz=["+decoPrefsOrg[i].clazz+"],value=["+decoPrefsOrg[i].value+"]\n"
			//alert(tmpMsg);
			this.initLayoutFrameView ();
			this.initLayoutBoardView ();
		}
		this.selectFrameLay (cfEach.getUtil().getValueOfClass (this.m_deco.getDecoPrefs(), "CF1101_frameType"));
		
		this.m_brdCnt = $('#wf_HOMEBOARDPANEL .wf_board_sub').length;
		if(subMenu == 'board'){
			$('#curBoardCnt').html(this.m_brdCnt);
		}
	},
	initLayoutFrameView : function () {
		//************************************************************************************************
		// 좌측메뉴부분에 들어가는 정보영역,메뉴영역,검색창을 설정된 순서대로 위치시켜준다.
		//************************************************************************************************
		var menuArea = cfEach.getUtil().getValueOfClass (this.m_deco.getDecoPrefs(), "CF1101_menuAreaOrder");
		
		if (menuArea != null && menuArea != "") {
			menuArea = menuArea.split(";");
			var maPanel = document.getElementById("wf_MENUPANEL");
			for (var i=0; i<menuArea.length; i++) {
				if (menuArea[i] != null && menuArea[i] != "") 
					maPanel.appendChild (($(maPanel).find("#"+menuArea[i]).remove())[0]);
			}
		}
		//************************************************************************************************
		// 부가컨텐츠영역에 들어가는 부가컨텐츠들을 설정된 순서대로 위치시켜준다.
		//************************************************************************************************
		var bugaAreas = cfEach.getUtil().getValueOfClass (this.m_deco.getDecoPrefs(), "CF1101_bugaAreaOrder");
		if (bugaAreas != null && bugaAreas != "") {
			bugaAreas = bugaAreas.split(";");
			var bugaBoxes = document.getElementById("ggBUGABOXES");
			for (var i=0; i<bugaAreas.length; i++) {
				var baPanel = document.getElementById("wf_ACCESSARYPANEL"+(i+1));
				$(baPanel).find("div").remove(); // 초기화
				if (bugaAreas[i] != null && bugaAreas[i] != "") {
					var bugaArea = bugaAreas[i].split(",");
					for (var j=0; j<bugaArea.length; j++) {
						if (bugaArea[j] != null && bugaArea[j] != "")
							baPanel.appendChild (($(bugaBoxes).find("#"+bugaArea[j]).clone())[0]);
					}
				}
			}
		}
		//************************************************************************************************
	},
	initLayoutBoardView : function () {
		//************************************************************************************************
		// 게시판그룹유형들을 순서대로 표현해주고, 유형그룹내의 게시판들의 아이디와 게시판 유형을 설정해준다.
		//************************************************************************************************
		var boardPanel = document.getElementById("wf_HOMEBOARDPANEL");
		$(boardPanel).find("div[id^='wf_HOMEBOARDGROUP']").remove(); // 초기화
		this.m_brdGrpSeq = 0; this.m_brdGrpCnt = 0; // 초기화되었으므로 0 으로 맞추어준다.
		
		var brdGrpTypeAll = cfEach.getUtil().getValueOfClass (this.m_deco.getDecoPrefs(), "CF1102_brdGrpType").split("::");
		var brdIdAll      = cfEach.getUtil().getValueOfClass (this.m_deco.getDecoPrefs(), "CF1102_brdId").split("::");
		var brdTypeAll    = cfEach.getUtil().getValueOfClass (this.m_deco.getDecoPrefs(), "CF1102_brdType").split("::");
		
		for (var i=0; i<brdGrpTypeAll.length; i++) {
			
			// 추출된 게시판그룹유형을 게시판영역에 적용해준다.
			var newBG = ($("#wf_HOMEBOARDGROUPS").find(".gg_board_" + brdGrpTypeAll[i]).clone())[0];
			newBG.id = "wf_HOMEBOARDGROUP_" + (++this.m_brdGrpSeq); ++this.m_brdGrpCnt;
			newBG.setAttribute ("brdGrpTypes", brdGrpTypeAll[i]);
			newBG.setAttribute ("brdIds",      brdIdAll[i]);
			newBG.setAttribute ("brdTypes",    brdTypeAll[i]);
			boardPanel.appendChild (newBG);
			
			var brdPoses  = brdGrpTypeAll[i].split("_");
			var brdIds    = brdIdAll[i].split("_");
			var brdTypes  = brdTypeAll[i].split("_");
			for (var j=0; j<brdPoses.length; j++) {
				// brdPoses 코드의 2,3자리 두문자는 게시판위치를 표시하는 SPAN의 CSS class 명 구분에 사용된다.
				var brdSpan = ($("#"+newBG.id).find(".gg_board_title_"+brdPoses[j].substring(1,3)))[0];
				// JSP에 따라내려와 있던 <SELECT>에서 해당게시판이 선택되게 한 후, 해당 게시판명을 알아와서 화면에 뿌린다.
				var brdSelect = document.getElementById("homeBoardPotSel");
				var brdOption = ebUtil.setSelectedAttr (brdSelect, "brdId", brdIds[j]);
				brdSpan.innerHTML = ebUtil.getSelectedText (brdSelect);
				if (brdTypes[j] != "empty") {
					brdSpan.parentNode.parentNode.setAttribute("class",""); // 게시판이 있으므로 class 'wf_board_empty'를 제거한다.
				}
				// 게시판유형 아이콘을 바꾸어준다.
				var selDiv = ($(brdSpan.parentNode).find(".wf_boardIcon"))[0];
				selDiv.setAttribute ("class", selDiv.getAttribute ("class")+" gg_boardIcon_"+brdTypes[j]);
			}
		}
		
		this.m_brdCnt = $('#wf_HOMEBOARDPANEL .wf_board_sub').length;
		$('#curBoardCnt').html(this.m_brdCnt);
		//************************************************************************************************
	},
	selectFrameLay : function (type) {
		//********************************************************************************************************
		// 꾸미기:레이아웃:프레임에서 프레임 구성을 선택했을 때.
		// - 선택된 프레임 템플릿에 외곽선을 그려서 선택됐음을 보여주고, DIV "wireframe"의 CSS를 바꾸어
		//   레이아웃을 바꾼다. 
		//********************************************************************************************************
		$("#ColumnViewContent").find("div").remove(".selected_icon"); // 선택된 Frame 템플릿 외곽선 표시용 DIV 제거.
		var selDiv = document.createElement("div"); // 선택된 Frame 템플릿 외곽선 표시용 DIV 새로 생성.
		var selTpl = null;
		
		var gateElm = ($("#wireframe").find("#wf_ENTRANCEPANEL").detach())[0]; // 대문영역을 표시하는 DIV를 뽑아내서 gateElm에 보관.
		var acs5Elm = ($("#wireframe").find("#wf_ACCESSARYPANEL5").detach())[0]; // 다섯번째 부가컨텐츠 영역을 뽑아내서 acs5Elm에 보관.
		
		if (type.indexOf("ONE") == 0) {
			selTpl = document.getElementById("LayoutIcon_ONE");
			selDiv.id = "LayoutIcon_ONESelected";
			$("#wireframe").attr("class","gg_typeONE fixed2_3"); // 우측 레이아웃 표시를 위해 레이아웃 최상위 DIV의 class 를 바꿈.
			document.getElementById("wfEntrancePanel1").appendChild (gateElm); // 레이아웃에 따라 달라진 대문 위치에 대문영역을 삽입.
			document.getElementById("wfSidePanel1").appendChild (acs5Elm); // 레이아웃에 따라 달라진 위치에 다섯번째 부가컨텐츠 영역을 삽입.
		} else if (type.indexOf("TWO") == 0) {
			
			switch (type.substring(type.length-1)) {
			case "1" :
				selTpl = document.getElementById("LayoutIcon_TWO1");
				selDiv.id = "LayoutIcon_TWO1Selected";
				$("#wireframe").attr("class","gg_typeTWO1 fixed2_1");
				document.getElementById("wfEntrancePanel2").appendChild (gateElm);
				break;
			case "2" :
				selTpl = document.getElementById("LayoutIcon_TWO2");
				selDiv.id = "LayoutIcon_TWO2Selected";
				$("#wireframe").attr("class","gg_typeTWO2 fixed2_2");
				document.getElementById("wfEntrancePanel2").appendChild (gateElm);
				break;
			}
			document.getElementById("wfSidePanel1").appendChild (acs5Elm);
		} else if (type.indexOf("THREE") == 0) {
			switch (type.substring(type.length-1)) {
			case "1" :
				selTpl = document.getElementById("LayoutIcon_THREE1");
				selDiv.id = "LayoutIcon_THREE1Selected";
				$("#wireframe").attr("class","gg_typeTHREE1 fixed3_3");
				document.getElementById("wfEntrancePanel3").appendChild (gateElm);
				break;
			case "2" :
				selTpl = document.getElementById("LayoutIcon_THREE2");
				selDiv.id = "LayoutIcon_THREE2Selected";
				$("#wireframe").attr("class","gg_typeTHREE2 fixed3_1");
				document.getElementById("wfEntrancePanel2").appendChild (gateElm);
				break;
			case "3" :
				selTpl = document.getElementById("LayoutIcon_THREE3");
				selDiv.id = "LayoutIcon_THREE3Selected";
				$("#wireframe").attr("class","gg_typeTHREE3 fixed3_4");
				document.getElementById("wfEntrancePanel3").appendChild (gateElm);
				break;
			case "4" :
				selTpl = document.getElementById("LayoutIcon_THREE4");
				selDiv.id = "LayoutIcon_THREE4Selected";
				$("#wireframe").attr("class","gg_typeTHREE4 fixed3_2");
				document.getElementById("wfEntrancePanel2").appendChild (gateElm);
				break;
			}
			document.getElementById("wfSidePanel2").appendChild (acs5Elm);
		}
		selDiv.setAttribute("class","selected_icon"); // 새로 생성한 선택된 Frame 템플릿 외곽선 표시용 DIV에 class 적용.
		selTpl.appendChild (selDiv); // 선택된 Frame 템플릿에 외곽선 적용.
		
		// 선택된 Layout type을 decoPrefs에 반영해준다.
		cfEach.getUtil().setValueOfClass (this.m_deco.getDecoPrefs(), "CF1101_frameType", type);
	},
	selectBoardLay : function (type) {
		if (this.m_brdCnt + type.split('_').length > 7) {
			alert("게시판을 7개를 초과하여 설정할 수 없습니다.");
			return;
		}
		if (this.m_brdGrpCnt >= 99) {
			alert("꾸미기를 더 이상 진행할 수 없습니다. 꾸미기를 종료한 후 다시 시작하십시오");
			return;
		}
		//********************************************************************************************************
		// 꾸미기:레이아웃:게시판 에서 게시판그룹유형을 선택했을 때.
		// - 선택된 게시판 템플릿에 해당되는 게시판그룹을 숨겨진 DIV에서 복사해와서 레이아웃에 넣어준다. 
		//********************************************************************************************************		
		var newBG = ($("#wf_HOMEBOARDGROUPS").find(".gg_board_" + type).clone())[0];
		newBG.id = "wf_HOMEBOARDGROUP_" + (++this.m_brdGrpSeq); ++this.m_brdGrpCnt;
		document.getElementById("wf_HOMEBOARDPANEL").appendChild (newBG);
		//********************************************************************************************************		
		// 게시판그룹유형의 deco 데이터들을 만들어 newBG에 attribute 들로 매달아 준다.
		//********************************************************************************************************		
		var brdPoses = type.split("_");
		var brdIds = "";
		var brdTypes = "";
		for (var i=0; i<brdPoses.length; i++) {
			if (i != 0) {
				brdIds += "_";
				brdTypes += "_";
			}
			brdIds += "empty";
			brdTypes += "empty";
		}
		newBG.setAttribute ("brdGrpTypes", type);
		newBG.setAttribute ("brdIds", brdIds);
		newBG.setAttribute ("brdTypes", brdTypes);

		this.m_brdCnt = this.m_brdCnt + type.split('_').length;
		$('#curBoardCnt').html(this.m_brdCnt);
		//alert("brdGrpTypes=["+brdGrpTypes+"],brdIds=["+brdIds+"],brdTypes=["+brdTypes+"]");
		//********************************************************************************************************		
	},
	removeBoardGroup : function (elm) {
		var delta = $(elm).parent().parent().attr('brdGrpTypes').split('_').length;
		this.m_brdCnt = this.m_brdCnt - delta;
		--this.m_brdGrpCnt;
		$(elm.parentNode.parentNode).remove();
		$('#curBoardCnt').html(this.m_brdCnt);
		
		if(this.m_brdCnt <= 0) {
			this.selectBoardLay('FLT10');
			alert('게시판 갯수는 0개로 설정할 수 없습니다.\n대신 빈 게시판은 선택할 수 있습니다.');
		}
	},
	openConfBoard : function (elm) {
		//****************************************************************************************************
		// 게시판 설정 화면을 위치에 맞게 띄운다.
		//****************************************************************************************************
		var editDiv = document.getElementById("wfHomeboardEditLayer");
		editDiv.style.display = "";
		var topPos = document.getElementById("wireframe").offsetHeight;
		topPos = Math.floor((topPos - editDiv.offsetHeight) / 2);
		editDiv.style.top = topPos + "px";
		//****************************************************************************************************
		// 기존에 설정된 게시판유형을 선택해준다.
		//****************************************************************************************************
		var elmBG = elm.parentNode.parentNode.parentNode;
		if (elmBG.id == null || elmBG.id == "") {
			elmBG = elm.parentNode.parentNode.parentNode.parentNode; // 게시판이 3개인 그룹은 단계가 하나 더 내려가 있다.
		}
		var brdPoses = elmBG.getAttribute ("brdGrpTypes").split("_");
		var brdIds   = elmBG.getAttribute ("brdIds").split("_");
		var brdTypes = elmBG.getAttribute ("brdTypes").split("_");

		var brdPos = elm.getAttribute ("brdPos");
		for (var i=0; i<brdPoses.length; i++) {
			if (brdPoses[i] == brdPos) {
				// 먼저 설정된 게시판 아이디로 <SELECT>를 선택해주고
				var brdSelect = document.getElementById("homeBoardPotSel");
				ebUtil.setSelectedAttr (brdSelect, "brdId", brdIds[i]);
				this.changeConfBoard (brdSelect);
				// 게시판 유형 아이콘을 선택해준다.
				if (brdTypes[i] != "empty") this.selectConfBoard (brdTypes[i]);
			}
		}
		//****************************************************************************************************
		// initDecoInfo()나 selectBoardLay()에서 설정해준 게시판그룹의 여러가지 값을
		// 게시판이나 유형이 바뀌었을 때 decoPrefs 값에 반영할 때 참조하기 위해 hidden field에 할당해준다.
		//****************************************************************************************************
		document.getElementById("ggBrdGrpId").value = elmBG.id;
		document.getElementById("ggBrdGrpBrdPos").value = brdPos; // 그룹내 위치.
		//****************************************************************************************************
	},
	closeConfBoard : function (isAccept) {

		var brdSelect = document.getElementById("homeBoardPotSel");

		if (isAccept) { // "확인"이 눌렸으면,
			//************************************************************************************************
			// 상단 <SELECT>에서 선택된 게시판의 아이디, 하단 아이콘에서 선택된 게시판의 유형을 알아내서
			// 게시판그룹유형 <DIV>에 attribute 로 설정해준다.
			//************************************************************************************************
			var brdId = ebUtil.getSelectedAttr (brdSelect, "brdId");
			var selDiv = null;
			if (brdId != "empty") selDiv = ($("#homeBoardEditType").find("div[id='selectedBoardType']"))[0];
			var brdType = "empty";
			if (selDiv != null) brdType = selDiv.getAttribute ("brdType");
			
			var brdGrpId = document.getElementById("ggBrdGrpId").value;
			var brdPos   = document.getElementById("ggBrdGrpBrdPos").value;

			var elmBG = document.getElementById (brdGrpId);
			var brdGrpTypes = elmBG.getAttribute ("brdGrpTypes");
			var brdPoses  = brdGrpTypes.split("_");
			var brdIds   = elmBG.getAttribute ("brdIds").split("_");
			var brdTypes = elmBG.getAttribute ("brdTypes").split("_");

			for (var i=0; i<brdPoses.length; i++) {
				if (brdPoses[i] == brdPos) {
					brdIds.splice (i, 1, brdId);
					brdTypes.splice (i, 1, brdType);
					
					//****************************************************************************************
					// 선택된 게시판의 이름과 유형아이콘을 화면에서 바꾸어준다.
					//****************************************************************************************
					// brdGrpType 코드의 2,3자리 두문자는 게시판위치를 표시하는 SPAN의 CSS class 명 구분에 사용된다.				
					var brdSpan = ($("#"+brdGrpId).find(".gg_board_title_"+brdPos.substring(1,3)))[0];
					var selDiv = ($(brdSpan.parentNode).find(".wf_boardIcon"))[0];
					if (brdId == "empty") {
						brdSpan.innerHTML = ebUtil.getMessage("cf.info.ttl.none.board"); // '게시판 없음'
						brdSpan.parentNode.parentNode.setAttribute("class","wf_board_empty");
						//selDiv.setAttribute ("class", selDiv.getAttribute ("class")); // 게시판유형 아이콘을 바꾸어준다.
						selDiv.setAttribute ("class", "wf_boardIcon"); // 게시판유형 아이콘을 바꾸어준다.
					} else {
						brdSpan.innerHTML = ebUtil.getSelectedText (brdSelect);
						brdSpan.parentNode.parentNode.setAttribute("class","");
						//selDiv.setAttribute ("class", selDiv.getAttribute ("class")+" gg_boardIcon_"+brdType); // 게시판유형 아이콘을 바꾸어준다.
						selDiv.setAttribute ("class", "wf_boardIcon gg_boardIcon_"+brdType); // 게시판유형 아이콘을 바꾸어준다.
					}
					//****************************************************************************************
				}
			}
			var brdIdAll = "";
			var brdTypeAll = "";
			for (var i=0; i<brdPoses.length; i++) {
				if (i != 0) {
					brdIdAll += "_";
					brdTypeAll += "_";
				}
				brdIdAll += brdIds[i];
				brdTypeAll += brdTypes[i];
			}
			elmBG.setAttribute ("brdIds", brdIdAll);
			elmBG.setAttribute ("brdTypes", brdTypeAll);
			//************************************************************************************************
		}
		$("#wfHomeboardEditLayer").css("display","none");
	},
	closeConfBoardBackup : function (isAccept) {

		var brdSelect = document.getElementById("homeBoardPotSel");

		if (isAccept && ebUtil.getSelectedValue (brdSelect) != "empty") { // "확인"이 눌렸고, 선택된 게시판이 있을 때만.
			//************************************************************************************************
			// 상단 <SELECT>에서 선택된 게시판의 아이디, 하단 아이콘에서 선택된 게시판의 유형을 알아내서
			// 게시판그룹유형 <DIV>에 attribute 로 설정해준다.
			//************************************************************************************************
			var brdId = ebUtil.getSelectedAttr (brdSelect, "brdId");
			var selDiv = ($("#homeBoardEditType").find("div[id='selectedBoardType']"))[0];
			var brdType = selDiv.getAttribute ("brdType");
			
			var brdGrpId = document.getElementById("ggBrdGrpId").value;
			var brdPos   = document.getElementById("ggBrdGrpBrdPos").value;

			var elmBG = document.getElementById (brdGrpId);
			var brdGrpTypes = elmBG.getAttribute ("brdGrpTypes");
			var brdPoses  = brdGrpTypes.split("_");
			var brdIds   = elmBG.getAttribute ("brdIds").split("_");
			var brdTypes = elmBG.getAttribute ("brdTypes").split("_");

			for (var i=0; i<brdPoses.length; i++) {
				if (brdPoses[i] == brdPos) {
					brdIds.splice (i, 1, brdId);
					brdTypes.splice (i, 1, brdType);
					
					//****************************************************************************************
					// 선택된 게시판의 이름과 유형아이콘을 화면에서 바꾸어준다.
					//****************************************************************************************
					// brdGrpType 코드의 2,3자리 두문자는 게시판위치를 표시하는 SPAN의 CSS class 명 구분에 사용된다.				
					var brdSpan = ($("#"+brdGrpId).find(".gg_board_title_"+brdPos.substring(1,3)))[0];
					brdSpan.innerHTML = ebUtil.getSelectedText (brdSelect);
					if (brdId == "empty") {
						brdSpan.parentNode.parentNode.setAttribute("class","wf_board_empty");
					} else {
						brdSpan.parentNode.parentNode.setAttribute("class","");
					}
					// 게시판유형 아이콘을 바꾸어준다.
					var selDiv = ($(brdSpan.parentNode).find(".wf_boardIcon"))[0];
					selDiv.setAttribute ("class", selDiv.getAttribute ("class")+" gg_boardIcon_"+brdType);
					//****************************************************************************************
				}
			}
			var brdIdAll = "";
			var brdTypeAll = "";
			for (var i=0; i<brdPoses.length; i++) {
				if (i != 0) {
					brdIdAll += "_";
					brdTypeAll += "_";
				}
				brdIdAll += brdIds[i];
				brdTypeAll += brdTypes[i];
			}
			elmBG.setAttribute ("brdIds", brdIdAll);
			elmBG.setAttribute ("brdTypes", brdTypeAll);
			//************************************************************************************************
		}
		$("#wfHomeboardEditLayer").css("display","none");
	},
	changeConfBoard : function (selBox) {
		var val = ebUtil.getSelectedValue (selBox);
		$("#homeBoardEditType").find("ul").remove();
		$("#homeBoardEditType").append(($("#wf_BOARDTYPEGROUPS").find("ul[boardType*='_"+val+"_']").clone())[0]);
	},
	selectConfBoard : function (type) {
		$("#homeBoardEditType").find("div[id='selectedBoardType']").remove(); // 기존에 선택되어있던 타잎의 외곽선 제거.
		var selType = ($("#homeBoardEditType").find("#gg_boardIcon_"+type))[0];
		var selDiv = document.createElement ("div");
		selDiv.id = "selectedBoardType";
		selDiv.setAttribute ("class", "selected_icon");
		selDiv.setAttribute ("brdType", type);
		selType.parentNode.parentNode.appendChild (selDiv);
	}
}

cafe.ggum.DNDMngr = function (dragIds) {
	//********************************************************************************************************
	// dragIds: Drag할 때 마우스로 찝을 대상이 되는 객체의 id.
	//          Drag될 수 있는 객체가 여러개일 때는 각각의 id를 ','로 구분한다.
	//          또한, id가 동일 prefix로 시작하는 것이 여러개일때는 id의 prefix + '*'의 형태로 주어도 인식한다.
	//********************************************************************************************************
    this.m_dragCntr = document.body;
    this.m_dragIds  = dragIds.split(",");
	
    this.m_dragHeader = null;
    this.m_dragX = 0;
    this.m_dragY = 0;
    
    this.isStartDragging = false;
	
	this.m_debugger = new enview.util.Debugger('DebuggerDisplay');
	//this.m_debugger.show();

	this.m_dropAreas = new Array();
}
cafe.ggum.DNDMngr.prototype = {
	m_dragCntr : null,
    m_dragIds : null,
    m_dragHeader : null,
    m_dragShadow : null,
	m_dragX : 0,
    m_dragY : 0,
    isStartDragging : false,
	m_debugger : null,
	
	m_dropAreas : null,
	m_exceptDropArea : null,
	m_currentDropArea : null,
	m_dragObject : null,
    //m_dragIndex : 0,
	
	attach : function () {
	    var thisObj = this;
		
		if (window.attachEvent) {
			this.m_dragCntr.attachEvent ("onmousedown", function (event) { thisObj.onMouseDown(event); });
			this.m_dragCntr.attachEvent ("onmouseup",   function (event) { thisObj.onMouseUp(event);   });
			this.m_dragCntr.attachEvent ("onmousemove", function (event) { thisObj.onMouseMove(event); });
		} else if (window.addEventListener) {
			this.m_dragCntr.addEventListener ("mousedown", function (event) { thisObj.onMouseDown(event); });
			this.m_dragCntr.addEventListener ("mouseup",   function (event) { thisObj.onMouseUp(event);   });
			this.m_dragCntr.addEventListener ("mousemove", function (event) { thisObj.onMouseMove(event); });
		} else {
			this.m_dragCntr.onmousedown = function (event) { thisObj.onMouseDown(event); };
			this.m_dragCntr.onmouseup   = function (event) { thisObj.onMouseUp(event);   };
			this.m_dragCntr.onmousemove = function (event) { thisObj.onMouseMove(event); };
		}

	},
	onMouseDown : function (evt) {

		if (evt == null) evt = event;
		if (evt.button != 0 && evt.button != 1) return false; // left mouse button click

	    var trgtElm = this.getTarget (evt);
		if (trgtElm == null) return;

		this.isStartDragging = true;
		this.m_dragHeader = trgtElm;

		this.setParentDropArea (true);
		this.setDragShadow (true);
		
		this.m_dragHeader.setAttribute("class", this.m_dragHeader.getAttribute("class")+" drag_effect");
		this.m_dragHeader.style.position = "absolute";
		this.m_dragHeader.style.left = this.m_dragShadow.offsetLeft + "px";
		this.m_dragHeader.style.top = this.m_dragShadow.offsetTop + "px";
		this.m_dragX = evt.clientX - this.m_dragHeader.offsetLeft;
		this.m_dragY = evt.clientY - this.m_dragHeader.offsetTop;

		//this.m_debugger.printCoordinate(evt, this.m_dragHeader);
		
	    if (this.m_dragHeader.setCapture) {
	    	this.m_dragHeader.setCapture ();
		} else {
			document.body.addEventListener ("mousemove", this, true);
		}

		this.cancelEvent (evt);
	},
	setParentDropArea : function (isDnD) {
		if (isDnD) { // DnD에 들어가는 상황이면, sibling element 들을 포함하고 있는 부모 객체에 반전 효과를 주고,
			if (this.m_dragHeader.id.indexOf("CafeBuga") == 0) {
				// 부가컨텐츠가 들어갈 수 있는 영역은 'wf_ACCESSARYPANEL'로 시작하는 다수의 div로 존재한다.
				$("#wireframe").find("div[id^='wf_ACCESSARYPANEL']").each(function(i){
					this.setAttribute("class", this.getAttribute("class")+" drop_board_effect");
				});
			} else {
				this.m_dragHeader.parentNode.setAttribute("class", this.m_dragHeader.parentNode.getAttribute("class")+" drop_board_effect");
			}
		} else { // DnD가 끝나는 상황이면, 반전효과를 제거.
			if (this.m_dragHeader.id.indexOf("CafeBuga") == 0) {
				$("#wireframe").find("div[id^='wf_ACCESSARYPANEL']").each(function(i){
					var regex = / drop_board_effect/;
					this.setAttribute("class", this.getAttribute("class").replace (regex, ""));
				});
			} else {
				var regex = / drop_board_effect/;
				this.m_dragHeader.parentNode.setAttribute("class", this.m_dragHeader.parentNode.getAttribute("class").replace (regex, ""));
			}
		}
	},
	setDragShadow : function (isDnD) {
		if (isDnD) {
			// DnD가 되는 객체를 복사해서, DnD되는 객체가 원래 있던 위치에 위치시킴 <-- 이 복사된 그림자가 결국 drop area 가 됨.
			this.m_dragShadow = $(this.m_dragHeader).clone()[0];
			this.m_dragShadow.id = this.m_dragHeader.id+"_shadow";
			this.m_dragShadow.setAttribute("class", this.m_dragShadow.getAttribute("class")+" drag_shadow_effect");
			this.m_dragShadow.innerHTML = "";
			$(this.m_dragHeader).before (this.m_dragShadow);
		} else {
			// DnD가 되는 객체를 그림자 객체로 전환하고(drop이 되었다) DnD가 되는 객체는 제거한다.
			this.m_dragShadow.id = this.m_dragHeader.id;
			this.m_dragShadow.innerHTML = this.m_dragHeader.innerHTML;
			var regex = / drag_shadow_effect/;
			this.m_dragShadow.setAttribute("class", this.m_dragShadow.getAttribute("class").replace (regex, ""));	
			$(this.m_dragHeader).remove();
		}
	},
	onMouseMove : function (evt) {
	    
		if (evt == null) evt = event;
		if (this.isStartDragging == false) return;
		if (this.m_dragHeader == null) return;

	    if (this.m_dragHeader.style.display == "none") {
	        this.m_dragHeader.style.display = "";
	    }
		
		this.moveDragShadow (evt);
	    
		this.m_dragHeader.style.left = evt.clientX - this.m_dragX  + "px";
		this.m_dragHeader.style.top = evt.clientY - this.m_dragY + "px";

		//this.m_debugger.printCoordinate(evt, this.m_dragHeader);

	    this.cancelEvent(evt);
	},
	onMouseUp : function (evt) {
		
		if (this.isStartDragging == false) return;
		if (evt == null) evt = event;
		if (evt.button != 0 && evt.button != 1) return;	// left mouse button click

	    if (this.m_dragHeader != null) {
			
			if (this.m_dragHeader.releaseCapture) {
				this.m_dragHeader.releaseCapture ();
			} else {
				document.body.removeEventListener ("mousemove", this, true);
				document.body.removeEventListener ("mouseup", this, true);
			}
	        
			this.setParentDropArea (false);
			this.setDragShadow (false);
		
			this.m_dragHeader = null;
	        this.m_dragShadow = null;
	    }
		this.isStartDragging = false;
	},
	moveDragShadow : function (evt) {
		
		var isBuga = this.m_dragHeader.id.indexOf("CafeBuga") == 0 ? true : false; 
		
		var parentElm = new Array();
		if (isBuga) parentElm = $("#wireframe").find("div[id^='wf_ACCESSARYPANEL']");
		else        parentElm[parentElm.length] = this.m_dragShadow.parentNode;
		
		var evtX = evt.clientX;
		var evtY = evt.clientY;
		
		for (var j=0; j<parentElm.length; j++) {

			var pos1 = ebUtil.getAbsPoint (parentElm[j]);
			var pos2 = ebUtil.getPoint();
			pos2.m_x = pos1.m_x + parentElm[j].offsetWidth;
			pos2.m_y = pos1.m_y + parentElm[j].offsetHeight;

			// 부가컨텐츠가 아닌 경우 마우스포인터의 위치가 parentElm 범위내에 있거나, 부가컨텐츠의 경우 마우스포인터의 X축의 위치가 parentElm 범위내에 있으면.
			if ((!isBuga && evtX > pos1.m_x && evtX < pos2.m_x && evtY > pos1.m_y && evtY < pos2.m_y) || (isBuga && evtX > pos1.m_x && evtX < pos2.m_x)) {
				
				// 부가컨텐츠 어미영역이 바뀌면 부가컨텐츠영역을 해당 어미쪽으로 옮겨줌.
				if (isBuga) parentElm[j].appendChild (($(this.m_dragShadow).remove())[0]);
				
				var child = parentElm[j].children;
				for (var i=0; i<child.length; i++) {
				
					if (child[i].id == this.m_dragHeader.id || child[i].id == this.m_dragShadow.id)
						continue; // 지금 드래깅하고 있는 element이거나 그림자이면 패스!
					
					var pos3 = ebUtil.getAbsPoint (child[i]);
					if (evtY > pos3.m_y && evtY < (pos3.m_y + child[i].offsetHeight)) {
					
						var middle = pos3.m_y + Math.floor (child[i].offsetHeight / 2);
						
						if (evtY > middle) { // 마우스포인터 위치가 어떤 한 sibling element 의 중간 밑으로 내려갔다
							$(child[i]).after (this.m_dragShadow);
						} else if ( evtY < middle) { // 마우스포인터 위치가 어떤 한 sibling element 의 중간 위로 올라갔다
							$(child[i]).before (this.m_dragShadow);
						}
						return;
					}
				}
			}
		}
	},
	getTarget : function (evt) {
		var srcElm = evt.srcElement ? evt.srcElement : evt.target;
		if (srcElm.tagName.toUpperCase() == "A") return null; // drag될 객체 내에 있더라도 이벤트가 anchor에서 발생하면 DnD를 하지 않는다.
		return this.getParentElm (srcElm, 3);
	},
	getParentElm : function (elm, srchLevel)	{
		if (!elm.nodeName) return null;
		
		var findElm = null;
		var compareId = "";
		for (var i=0; i<this.m_dragIds.length; i++) {
			var pos = this.m_dragIds[i].lastIndexOf("*");
			if (pos > -1) {
				compareId = this.m_dragIds[i].substring(0, pos);
				findElm = this.getParentElmInclude (elm, compareId, srchLevel);
			} else {
				compareId = this.m_dragIds[i];
				findElm = this.getParentElmExactly (elm, compareId, srchLevel);
			}		
			if (findElm != null ) return findElm;
		}
		return null;
	},
	getParentElmExactly : function (elm, srchId, srchLevel) {
		var parentElm = elm;
	    for (var idx=0; idx<srchLevel; idx++) {
			if (parentElm == null) return null;
			if (parentElm.id == srchId) return parentElm;
	        parentElm = parentElm.parentNode;
	    }
		return null;
	},
	getParentElmInclude : function (elm, srchId, srchLevel)	{
		var parentElm = elm;
	    for ( var idx=0; idx<srchLevel; idx++) {
			if (parentElm == null) return null;
			if (parentElm.id != null && parentElm.id.indexOf (srchId) > -1) return parentElm;
	        parentElm = parentElm.parentNode;
	    }
		return null;
	},
	// handleEvent : function ( evt ) {
		// if (evt.type=="mousemove") {
			// this.onMouseMove ( evt );
		// } else if (evt.type=="mouseup") {
			// this.onMouseUp ( evt );
		// }
	// },
	cancelEvent : function (evt) {
		if (document.all) {	// it is IE
			evt.cancelBubble = true;
			evt.returnValue = false;
		} else {
			evt.preventDefault ();
			evt.stopPropagation ();
		}
	}
}

cafe.ggum.FootMngr = function () {
}
cafe.ggum.FootMngr.prototype = {
	
	resetOrg : function () {
		var deco = cfGGum.getLayMngr().m_deco;
		var decoPrefs = deco.getDecoPrefs();
		var decoPrefsOrg = deco.getDecoPrefsOrg();

		//var tmpMsg = "***** Before decoPrefs *****\n";
		//for (var i=0; i<decoPrefs.length; i++)tmpMsg += "clazz=["+decoPrefs[i].clazz+"],value=["+decoPrefs[i].value+"]\n"
		//alert(tmpMsg);

		//var tmpMsg = "***** Before decoPrefsOrg *****\n";
		//for (var i=0; i<decoPrefsOrg.length; i++)tmpMsg += "clazz=["+decoPrefsOrg[i].clazz+"],value=["+decoPrefsOrg[i].value+"]\n"
		//alert(tmpMsg);

		switch (cfGGum.m_menu) {
		case "skin":
			switch (cfGGum.m_subMenu) {
				case "skin":   this.resetSkinSkin();   break;
				case "cafeBg": this.resetSkinCafeBg(); break;
			}
			break;
		case "layout":
			switch (cfGGum.m_subMenu) {
				case "frame":   this.resetLayoutFrame();   break;
				case "board":   this.resetLayoutBoard();   break;
				case "cntt":    this.resetLayoutCntt();    break;
				case "portlet": this.resetLayoutPortlet(); break;
			}
			break;
		case "ggumigi":
			switch (cfGGum.m_subMenu) {
				case "info":  this.resetGGumigiInfo();  break;
				case "menu":  this.resetGGumigiMenu();  break;
				case "srch":  this.resetGGumigiSrch();  break;
				case "board": this.resetGGumigiBoard(); break;
				case "buga":  this.resetGGumigiBuga();  break;
			}
			break;
		}
		//var tmpMsg = "***** After decoPrefs *****\n";
		//for (var i=0; i<decoPrefs.length; i++)tmpMsg += "clazz=["+decoPrefs[i].clazz+"],value=["+decoPrefs[i].value+"]\n"
		//alert(tmpMsg);
	},
	resetSkinSkin : function () {
		cfSkin.getDeco().reset();
	},
	resetSkinCafeBg : function () {
		cfBg.getDeco().reset();
	},
	resetLayoutFrame : function () {
		var deco = cfGGum.getLayMngr().m_deco;
		var decoPrefs = deco.getDecoPrefs();
		var decoPrefsOrg = deco.getDecoPrefsOrg();
		cfEach.getUtil().substitueObjByClass (decoPrefsOrg, "CF1101_frameType", decoPrefs, "CF1101_frameType");
		cfGGum.getLayMngr().initLayoutFrameView (); // 화면 원복해주고,
		cfGGum.getLayMngr().selectFrameLay (cfEach.getUtil().getValueOfClass (decoPrefs, "CF1101_frameType")); // 원복된 frame의 아이콘이 선택되게 해준다.
	},
	resetLayoutBoard : function () {
		var decoPrefs    = cfGGum.getLayMngr().m_deco.getDecoPrefs();
		var decoPrefsOrg = cfGGum.getLayMngr().m_deco.getDecoPrefsOrg();
		for (var i=0; i<decoPrefs.length; i++) {
			if (decoPrefs[i].clazz.indexOf ("CF12") == 0) {
				decoPrefs.splice (i--, 1); // 게시판유형그룹과 관련된 deco 정보 모두 제거. 요소가 하나 빠지므로 index를 하나 줄여주어야 한다.
			}
		}
		for (var i=0; i<decoPrefsOrg.length; i++) {
			if (decoPrefsOrg[i].clazz.indexOf ("CF12") == 0) {
				decoPrefs[decoPrefs.length] = ebUtil.clone(decoPrefsOrg[i]); // 원본에서 게시판유형그룹과 관련된 deco 모두 복사.
			}
		}
		cfGGum.getLayMngr().initLayoutBoardView (); // 화면 원복해준다.
	},
	resetLayoutCntt : function () {
		cfCntt.getDeco().reset();
	},
	resetLayoutPortlet : function () {
		//cfPortlet.getDeco().reset();
	},
	resetGGumigiInfo : function () {
		cfInfo.getDeco().reset();
	},
	resetGGumigiMenu : function () {
		cfMenu.getDeco().reset();
	},
	resetGGumigiSrch : function () {
		//cfSrch.getDeco().reset();
	},
	resetGGumigiBoard : function () {
		//cfBoard.getDeco().reset();
	},
	resetGGumigiBuga : function () {
		//cfBuga.getDeco().reset();
	}
}

/***********************************************************************
 *	2012년 7월 13일
 *	SWKim.
 *	영역별 꾸미기 중 카페메뉴
 ***********************************************************************/
cafe.ggum.TplMngr = function () {
	this.m_contextPath = ebUtil.getContextPath();
	this.m_util = cfEach.getUtil();
	this.m_colorIndex = 1;
}
cafe.ggum.TplMngr.prototype = {
	m_contextPath : null,
	
	m_util: null,
	m_subMenu : null,
	m_curOjb : null,
	m_deco : null,
	m_decoId : null,
	m_decoType: null,
	m_decoPrefs : null,
	
	m_isInfoAttached : false,
	m_isMenuAttached : false,
	m_isBoardAttached : false,
	
	m_color: null,
	m_colorIndex : null,
	
	
	m_boardBrdrKind : null,
	m_boardBrdrDesign : null,
	
	setDeco : function (subMenu) {
		this.m_subMenu = subMenu;
		switch(this.m_subMenu){
			case 'info': {
				this.m_curOjb = cfInfo;
				this.m_deco = cfInfo.getDeco();
				this.m_decoType = 'CF0301';
				this.m_decoPrefs = cfInfo.getDeco().getDecoPrefs();
				break;
			}
			case 'infoTab': {
				this.m_curOjb = cfInfo;
				this.m_deco = cfInfo.getDeco();
				this.m_decoType = 'CF0302';
				this.m_decoPrefs = cfInfo.getDeco().getDecoPrefs();
				break;
			}
			case 'menu': {
				this.m_curOjb = cfMenu;
				this.m_deco = cfMenu.getDeco();
				this.m_decoType = 'CF0401';
				this.m_decoPrefs = cfMenu.getDeco().getDecoPrefs();
				break;		
			}
			case 'menuIcon': {
				this.m_curOjb = cfMenu;
				this.m_deco = cfMenu.getDeco();
				this.m_decoType = 'CF0402';
				this.m_decoPrefs = cfMenu.getDeco().getDecoPrefs();
				break;		
			}
			case 'srch': {
				this.m_curOjb = cfSrch;
				this.m_deco = cfSrch.getDeco();
				this.m_decoType = 'CF0601';
				this.m_decoPrefs = cfSrch.getDeco().getDecoPrefs();
				break;
			}
			case 'board': {
				this.m_curOjb = cfCntt;
				this.m_deco = cfCntt.getDeco();
				this.m_decoType = 'CF0501';
				this.m_decoPrefs = cfCntt.getDeco().getDecoPrefs();
				break;
			}
			case 'buga': {
				this.m_curOjb = cfBuga;
				this.m_deco = cfBuga.getDeco();
				this.m_decoType = 'CF0701';
				this.m_decoPrefs = cfBuga.getDeco().getDecoPrefs();
				break;
			}
			case 'skin': {
				this.m_curOjb = cfSkin;
				this.m_deco = cfSkin.getDeco();
				this.m_decoType = 'CF0801';
				this.m_decoPrefs = cfSkin.getDeco().getDecoPrefs();
				break;
			}
			case 'cafeBg': {
				this.m_curOjb = cfBg;
				this.m_deco = cfBg.getDeco();
				this.m_decoType = 'CF0802';
				this.m_decoPrefs = cfBg.getDeco().getDecoPrefs();
				break;
			}
			default: break;
		}
	},
	
	//각 이벤트를 바인딩 해준다.
	attach : function (decoType) {
		switch(decoType){
			case 'cafeBg' : {
				if(this.m_panelType == 'color') {
					this.onClickSkinCafeBgColor(); 
				}
				else if(this.m_panelType == 'user'){
					this.onClickSkinCafeBgColorPicker();
				}
				break;
			}
			case 'info': this.onClickInfoPicker(); break;
			case 'menu': this.onClickMenuPicker(); break;
			case 'board': this.onClickBoardPicker(); break;
			default: break;
		}
	},
	
	onOverSkin : function(skinId, skinNm, index){
		$('#skinTplImg_' + skinId).attr('src', '../cola/cafe/resource/images/skin/template/tplImg/' + skinNm + '/' + skinNm + index + '.gif');
	},
	
	onOutSkin : function(skinId, skinNm){
		$('#skinTplImg_' + skinId).attr('src', '../cola/cafe/resource/images/skin/template/tplImg/' + skinNm + '/' + skinNm + this.m_colorIndex + '.gif');
	},
	
	onSelectSkin : function(skinId, skinNm, color, index) {
		var cfTplMngr = this;
		var cfUtil = this.m_util;
		var decoType = this.m_decoType;
		var colorIndex = this.m_colorIndex;
		var contextPath = this.m_contextPath;
		
		if(color != undefined) this.m_color = color;
		if(index != undefined) this.m_colorIndex = index;
		
		$('#skinTplImg_' + skinId).attr('src', '../cola/cafe/resource/images/skin/template/tplImg/' + skinNm + '/' + skinNm + this.m_colorIndex + '.gif');
		
		$.ajax({
			type: 'POST',
			url: contextPath + '/cafe/editor.cafe',
			data:
			{
				'm'    : 'getSkinDecoPrefs',
				'skinId'   : skinId,
				'dummy': Math.random()*1000,
				'__ajax_call__'  : true
			},
			dataType: 'html',
			success: function(html, textStatus){
				$('#decoTemplates').html(html);
				var allDecoPrefs = eval("(" + $('#_decoPrefs').val() + ")");
				var infoBox = cfEach.getInfoBox();
				infoBox.m_on = "client";
				infoBox.m_target = "skin";
				infoBox.m_cmd = "skin";
				infoBox.m_isUseTitle = $('#controlUseTitle').attr('checked');
				$.ajax({
					type: 'POST',
					url: contextPath + '/cafe/editor.cafe',
					data:
					{
						'm'    : 'getSkinColorDecoPrefs',
						'skinId'   : skinId,
						'dummy': Math.random()*1000,
						'__ajax_call__'  : true
					},
					dataType: 'html',
					success: function(html, textStatus){
						var skinColor = $('<div id="skinColor"></div>');
						skinColor.html(html);
						var value = skinColor.find('#_decoPrefs').val();
						var skinColorDecos = eval("(" + value + ")");
						var skinColorSet = null;
						
						if(cfGGum.getTplMngr().m_color == null){
							skinColorSet = eval("(" + skinColorDecos[0].value + ")");
						}
						else {
							for(var i = 0; i < skinColorDecos.length; i++){
								var tempSkinColorSet = eval("(" + skinColorDecos[i].value + ")");
								//alert(tempSkinColorSet.baseColor + ', ' +  color + '\n일치여뷰: ' + (tempSkinColorSet.baseColor == color));
								if(tempSkinColorSet.baseColor == cfGGum.getTplMngr().m_color){
									skinColorSet = tempSkinColorSet;
									break;
								}
							}
						}
						if(skinColorSet != null){
							infoBox.m_colorSet = skinColorSet;
							infoBox.m_decoPrefs = allDecoPrefs;
							cfEach.sendCommand(infoBox);
						}
						else {
							alert('해당 컬러셋이 존재하지 않는뎁쇼;');
						}
					},
					error: function(x, e){
						alert(e + '\n2잠시 후에 다시 시도 해주십시오.');
					}
				});
				
				$('#' + this.m_decoType + '_decoId').val(skinId);
				var tplDom = document.getElementById('tplImg_' + skinId);
				if(tplDom == null) return;
				var top = tplDom.offsetTop + 2;
				var left = tplDom.offsetLeft + 2;
				var width = $('#tplImg_' + skinId).css('width').replace('px','')-8;
				var height = $('#tplImg_' + skinId).css('height').replace('px','')-8;
				var tplJobj = $('#' + decoType + '_selectedBox');
				tplJobj.css('display', 'block');
				tplJobj.css('top', top);
				tplJobj.css('left', left);
				tplJobj.css('width', width + 'px');
				tplJobj.css('height', height + 'px');
			},
			error: function(x, e){
				alert(e + '\n잠시 후에 다시 시도 해주십시오.');
			}
		});
	},
	
	onSelectSkinColor : function(color) {
		var cfTplMngr = this;
		var cfUtil = this.m_util;
		var decoType = this.m_decoType;
		
		var infoBox = cfEach.getInfoBox();
		infoBox.m_on = "client";
		infoBox.m_target = "skin";
		infoBox.m_cmd = "skinColor";
		infoBox.m_colorSet = color;
		cfEach.sendCommand(infoBox);
	},
	
	onSelectTheme : function(theme) {
		if( theme==null) {
			var themeCss = $("#themeCss").attr("href");
			theme = themeCss.substring( themeCss.lastIndexOf('/')+1, themeCss.length - 4);
		} else {
			var oldThemeCss = $("#themeCss").attr("href");
			var newThemeCss = oldThemeCss.substring( 0, oldThemeCss.lastIndexOf('/')+1) + theme + ".css";
			$("#themeCss").attr("href", newThemeCss);
		}

		cfGGum.getTplMngr().selectCafeTheme( theme);

		var themeDom = document.getElementById('themeImg_' + theme);
		if(themeDom == null) return;
		var top = themeDom.offsetTop + 2;
		var left = themeDom.offsetLeft + 2;
		var width = $(themeDom).css('width').replace('px','')-8;
		var height = $(themeDom).css('height').replace('px','')-8;
		var tplJobj = $('#CF0801_selectedBox');
		
		tplJobj.css('display', 'block');
		tplJobj.css('top', top);
		tplJobj.css('left', left);
		tplJobj.css('width', width + 'px');
		tplJobj.css('height', height + 'px');
	},
	
	
	onClickSkinCafeBgColor : function () {
		$('#BackgroundColorList a.imgLink').bind('click.cafeBgColor', function(){
			var $this = $(this);
			$('#BackgroundColorList a.imgLink').removeClass('hasBorder');
			$this.addClass('hasBorder');
			cfGGum.getTplMngr().selectCafeBg($this.css('background-color'));
		});
	},
	
	onClickSkinCafeBgColorPicker : function (){
		//카페 바탕색
		$('#CF0802_bgColor').bind('click.colorPicker', function(){
			cfColorPicker.initialize('CF0802_bgColor', cfGGum.getTplMngr().setBgColor);
		});
	},
	
	onClickInfoPicker : function () {
		//카페정보 바탕색
		$('#CF0301_bgColor').bind('click.colorPicker', function(){
			cfColorPicker.initialize('CF0301_bgColor', cfGGum.getTplMngr().setBgColor);
		});
		
		//카페정보 테두리색
		$('#CF0301_brdrColor').bind('click.colorPicker', function(){
			cfColorPicker.initialize('CF0301_brdrColor', cfGGum.getTplMngr().setBrdrColor);
		});
		
		//카페정보 버튼색
		$('#CF0301_btnBgColor').bind('click.colorPicker', function(){
			cfColorPicker.initialize('CF0301_btnBgColor', cfGGum.getTplMngr().setBtnBgColor);
		});
		
		//카페정보 버튼 폰트 색
		$('#CF0301_btnFontColor').bind('click.colorPicker', function(){
			cfColorPicker.initialize('CF0301_btnFontColor', cfGGum.getTplMngr().setBtnFontColor);
		});
		
		//카페정보 기본색
		$('#CF0301_baseFontColor').bind('click.colorPicker', function(){
			cfColorPicker.initialize('CF0301_baseFontColor', cfGGum.getTplMngr().setBaseFontColor);
		});
		
		//카페정보 강조색
		$('#CF0301_valFontColor').bind('click.colorPicker', function(){
			cfColorPicker.initialize('CF0301_valFontColor', cfGGum.getTplMngr().setValFontColor);
		});
	},
	
	onClickMenuPicker : function () {
		//카페메뉴 바탕색
		$('#CF0401_bgColor').bind('click.colorPicker', function(){
			cfColorPicker.initialize('CF0401_bgColor', cfGGum.getTplMngr().setBgColor);
		});

		//카페메뉴 테두리색
		$('#CF0401_brdrColor').bind('click.colorPicker', function(){
			cfColorPicker.initialize('CF0401_brdrColor', cfGGum.getTplMngr().setMenuBrdrColor);
		});
		
		//카페메뉴 메뉴그룹색
		$('#CF0401_menuGrpBgColor').bind('click.colorPicker', function(){
			cfColorPicker.initialize('CF0401_menuGrpBgColor', cfGGum.getTplMngr().setMenuGrpBgColor);
		});
		
		//카페메뉴 구분선 색
		$('#CF0401_sepBrdrColor').bind('click.colorPicker', function(){
			cfColorPicker.initialize('CF0401_sepBrdrColor', cfGGum.getTplMngr().setSepBrdrColor);
		});
		
		//카페메뉴 테두리 디자인
		$('#menuBrdrDesign').bind('click.borderPicker', function(){
			cfBorderPicker.initialize('menuBrdrDesign', 8326, 0, 2, 'menuBrdrDesign', cfGGum.getTplMngr().setMenuBrdrDesign);
		});
		
		//카페메뉴 테두리 스타일
		$('#menuBrdrStyle').bind('click.borderPicker', function(){
			cfBorderPicker.initialize('menuBrdrStyle', 8322, 1, 7, 'menuBrdrStyle', cfGGum.getTplMngr().setMenuBrdrStyle);
		});	
		
		//카페메뉴 구분선
		$('#sepBrdrStyle').bind('click.borderPicker', function(){
			cfBorderPicker.initialize('sepBrdrStyle', 8322, 0, 7, 'sepBrdrStyle', cfGGum.getTplMngr().setSepBrdrStyle);
		});
		
		//카페메뉴 기본색
		$('#CF0401_baseFontColor').bind('click.colorPicker', function(){
			cfColorPicker.initialize('CF0401_baseFontColor', cfGGum.getTplMngr().setBaseFontColor);
		});

		//카페메뉴 강조색
		$('#CF0401_valFontColor').bind('click.colorPicker', function(){
			cfColorPicker.initialize('CF0401_valFontColor', cfGGum.getTplMngr().setValFontColor);
		});
		
		$('#menuIconBg').bind('click.iconPicker', function(){
			cfIconPicker.initialize('CF0402_menuIconSet', 5, 5, 1, cfGGum.getTplMngr().setMenuIconSet);
		});
	},
	
	onClickBoardPicker : function () {
		//게시판 테두리 디자인 색
		$('#CF0501_nmBrdrColor').bind('click.colorPicker', function(){
			cfColorPicker.initialize('CF0501_nmBrdrColor', cfGGum.getTplMngr().setNmBrdrColor);
		});
		
		//게시판 이름색
		$('#CF0501_nmFontColor').bind('click.colorPicker', function(){
			cfColorPicker.initialize('CF0501_nmFontColor', cfGGum.getTplMngr().setNmFontColor);
		});

		//게시판 글제목 색
		$('#CF0501_subjFontColor').bind('click.colorPicker', function(){
			cfColorPicker.initialize('CF0501_subjFontColor', cfGGum.getTplMngr().setSubjFontColor);
		});

		//게시판 댓글색
		$('#CF0501_rplFontColor').bind('click.colorPicker', function(){
			cfColorPicker.initialize('CF0501_rplFontColor', cfGGum.getTplMngr().setRplFontColor);
		});
		
		//게시판 테두리 종류
		$('#boardBrdrKind').bind('click.borderPicker', function(){
			cfBorderPicker.initialize('boardBrdrKind', 8326, 0, 3, 'boardBrdrKind', cfGGum.getTplMngr().setBoardBrdrKind);
		});
	},
	
	setSubMenu : function (subMenu){
		this.m_subMenu = subMenu;
	},
	
	setPanelType : function (samMenu){
		this.m_panelType = samMenu;
	},
	
	initContent : function () {
//		alert( cfGGum.m_menu + '/' + this.m_panelType);
		if(cfGGum.m_menu == "skin"){
			if(this.m_panelType == 'image' ){
				var decoId = $('#' + this.m_decoType + '_decoId').val();
				if(decoId == undefined || decoId == null || decoId == '' || decoId == 'null'){
					decoId = $('#' + this.m_decoType + '_template').val();
					if(decoId == 'color' || decoId == 'custom') {
						return;
					}
				}
				cfGGum.getTplMngr().selectTemplate(decoId, false);
				
			}
			else if (this.m_panelType == 'list'){
				cfGGum.getTplMngr().onSelectTheme();								
			}
			else if (this.m_panelType == 'color'){
				$('#' + this.m_decoType + '_template').val('');
			}
			else if (this.m_panelType == 'user'){
				if(cfBg.getDeco().getDecoPref('CF0802_template').value == 'user'){
					$('#delPhoto').css('display', 'block');
					$('#cafeBackgroundImageThumbnail').css('display', 'block');
					$('#cafeBackgroundImageRepeat').removeAttr('disabled');
					$('#cafeBackgroundImageRepeat').bind('change.cafeBackgroundImageRepeat', function(){
						cfGGum.getTplMngr().changeCafeBgRepeat($(this).val());
					});
					
					cfAlignPicker.setBgImgPos('CF0802_bgImgPos',$('.CF0802_bgImgPos').css('background-position-x'), $('.CF0802_bgImgPos').css('background-position-y'));
					
					$('#CF0802_bgImgPosMask').removeClass("colorSelectDisabled");
					$('#CF0802_bgImgPosMask').addClass("colorSelectEnabled");
					$('#CF0802_bgImgPos').bind('click.alignPicker', function(){
						var posX = $('.CF0802_bgImgPos').css('background-position-x');
						var posY = $('.CF0802_bgImgPos').css('background-position-y');
						cfAlignPicker.initialize('CF0802_bgImgPos', cfGGum.getTplMngr().setBgAlign, posX, posY);
					});
					
					$('#CF0802_bgColorMask').removeClass("colorSelectDisabled");
					$('#CF0802_bgColorMask').addClass("colorSelectEnabled");
					$('#CF0802_bgColor').bind('click.colorPicker', function(){
						cfColorPicker.initialize('CF0802_bgColor', cfGGum.getTplMngr().setBgColor);
					});
					
					$('#CF0802_bgColor').css('background-color', $('body').css('background-color'));
				}
			}
		}
		else if(cfGGum.m_menu == "layout"){
			
		}
		else if(cfGGum.m_menu == "ggumigi"){
			this.initFooterColor();
			if(this.m_panelType == 'image' ){
				var decoId = $('#' + this.m_decoType + '_decoId').val();
				if(decoId == undefined || decoId == null || decoId == '' || decoId == 'null'){
					decoId = $('#' + this.m_decoType + '_template').val();
					if(decoId == 'color' || decoId == 'custom') {
						return;
					}
				}
				cfGGum.getTplMngr().selectTemplate(decoId, false);
			}
			else if (this.m_panelType == 'color'){
				$('#' + this.m_decoType + '_template').val('');
				eval("this." + this.m_subMenu + "ColorRendering()");
			}
		}
	},
	
	rendering : function (){
		var cfTplMngr = this;
		var cfUtil = this.m_util;
		var decoType = this.m_decoType;
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
				$( '#editorArea' ).dialog( "close" );
				$('#decoTemplates').html(html);
				var tplDecoPrefs = eval("(" + $('#' + decoType + '_decoPrefs').val() + ")");
				var decoPrefs = cfTplMngr.m_deco.getDecoPrefs();
				for(var i = 0; i < tplDecoPrefs.length; i++){
					var clazz = tplDecoPrefs[i].clazz;
					//같은 데코타입이 아니면 값을 할당하지 않는다.(다른 영역의 편집내용을 침범할 수 있기 때문에)
					if(clazz.indexOf(decoType) < 0) continue;
					var value = tplDecoPrefs[i].value;
					cfTplMngr.m_deco.setDecoPref(clazz, value, false);
				}
				cfTplMngr.m_deco.rendering();
				cfTplMngr.initFooterColor();
			},
			error: function(x, e){
				alert(e + '\n잠시 후에 다시 시도 해주십시오.');
			}
		});
	},
	
	selectTemplate : function (id, isRendering) {
		var decoId = id;
		if(decoId.indexOf('tplImg_') > -1) decoId = decoId.replace('tplImg_','');
		$('#' + this.m_decoType + '_decoId').val(decoId);
		var tplDom = document.getElementById('tplImg_' + decoId);
		if(tplDom == null) return;
		var top = tplDom.offsetTop + 2;
		var left = tplDom.offsetLeft + 2;
		var width = $('#tplImg_' + decoId).css('width').replace('px','')-8;
		var height = $('#tplImg_' + decoId).css('height').replace('px','')-8;
		var tplJobj = $('#' + this.m_decoType + '_selectedBox');
		tplJobj.css('display', 'block');
		tplJobj.css('top', top);
		tplJobj.css('left', left);
		tplJobj.css('width', width + 'px');
		tplJobj.css('height', height + 'px');
		if(isRendering == undefined || isRendering == true) this.rendering();
	},
	
	selectCafeBg : function (color){
		this.m_deco.setDecoPref('CF0802_bgImage', '{ "background-image": "none" }', false);
		this.m_deco.setDecoPref('CF0802_bgColor', '{ "background-color": "' + color + '" }', false);
		this.m_deco.setDecoPref('CF0802_template', 'color', false);
		this.m_deco.rendering();
	},
	
	selectCafeTheme : function (theme){
	},
	
	
	changeCafeBgRepeat : function (repeat){
		this.m_deco.setDecoPref('CF0802_bgImgRepeat', '{ "background-repeat": "' + repeat + '" }');
	},
	
	uploadSkinBgImage : function (){
		this.delPreviewImage(function(){
			var text = $('#skinBgFile').val();
			if(text != '') {
				var frm = document.skinBgFileForm;
				frm.action = cfGGum.m_contextPath+"/cafe/editor.cafe?m=uploadUserImage&cmntUrl=" + cfEach.m_curCafeUrl;
				frm.target = "skinCafeBgIFrame";
				frm.submit();
			}
		});
	},
	
	previewImage : function(folder){
		var file = folder + '/SKIN_CAFE_BG_IMG_IMSI?' + ( new Date()).getTime();
		$('#delPhoto').css('display', 'block');
		$('#cafeBackgroundImageThumbnail').css('display', 'block');
		$('#cafeBackgroundImageThumbnail').attr('src', cfGGum.m_contextPath + '/cola/cafe/each/' + file);
		
		this.m_deco.setDecoPref('CF0802_bgImage',		'{ "background-image": "none" }');
		this.m_deco.setDecoPref('CF0802_bgImage',		'{ "background-image": "url(' + cfGGum.m_contextPath + '/cola/cafe/each/' + file + ')" }', false);
		this.m_deco.setDecoPref('CF0802_bgImgPos',		'{ "background-position-x": "center", "background-position-y": "0%" }', false);
		this.m_deco.setDecoPref('CF0802_bgImgRepeat',	'{ "background-repeat": "no-repeat" }', false);
		this.m_deco.setDecoPref('CF0802_template', 'user', false);
		this.m_deco.rendering();
		
		//미리보기를 위하여 IMSI 파일을 랜더링한 후, 적용되었을 때 저장될 파일명으로 치환해준다.
		this.m_deco.setDecoPref('CF0802_bgImage',		'{ "background-image": "url(' + cfGGum.m_contextPath + '/cola/cafe/each/' + file + ')" }', false);
		
		$('#cafeBackgroundImageRepeat').removeAttr('disabled');
		$('#cafeBackgroundImageRepeat').bind('change.cafeBackgroundImageRepeat', function(){
			cfGGum.getTplMngr().changeCafeBgRepeat($(this).val());
		});
		
		$('#CF0802_bgImgPosMask').removeClass("colorSelectDisabled");
		$('#CF0802_bgImgPosMask').addClass("colorSelectEnabled");
		$('#CF0802_bgImgPos').bind('click.alignPicker', function(){
			var posX = $('.CF0802_bgImgPos').css('background-position-x');
			var posY = $('.CF0802_bgImgPos').css('background-position-y');
			cfAlignPicker.initialize('CF0802_bgImgPos', cfGGum.getTplMngr().setBgAlign, posX, posY);
		});
		
		$('#CF0802_bgColorMask').removeClass("colorSelectDisabled");
		$('#CF0802_bgColorMask').addClass("colorSelectEnabled");
		$('#CF0802_bgColor').bind('click.colorPicker', function(){
			cfColorPicker.initialize('CF0802_bgColor', cfGGum.getTplMngr().setBgColor);
		});
	},
	
	delPreviewImage : function(extraFunc) {
		var param = "m=deleteUserImage";
		param += "&cmntUrl=" + cfEach.m_curCafeUrl;
		cfGGum.m_ajax.send("POST", cfGGum.m_contextPath+"/cafe/editor.cafe", param, true, {success: function(htmlData) {
			$('#delPhoto').css('display', 'none');
			$('#cafeBackgroundImageThumbnail').css('display', 'none');
			$('#cafeBackgroundImageThumbnail').attr('src', '');
			
			$('.CF0802_bgImage').css('background-image','none');
			$('#cafeBackgroundImageRepeat').attr('disabled', 'disabled');
			$('#cafeBackgroundImageRepeat').unbind('click.cafeBackgroundImageRepeat');
			
			$('#CF0802_bgImgPosMask').removeClass("colorSelectEnabled");
			$('#CF0802_bgImgPosMask').addClass("colorSelectDisabled");
			$('#CF0802_bgImgPos').unbind('click.alignPicker');
			
			$('#CF0802_bgColorMask').removeClass("colorSelectEnabled");
			$('#CF0802_bgColorMask').addClass("colorSelectDisabled");
			$('#CF0802_bgColor').unbind('click.colorPicker');
			
			if(extraFunc) extraFunc();
		}});
	},
	
	infoColorRendering : function () {
		var bgColor = $('#div_cafe_info').css('background-color');
		var bgBrdrColor = $('#div_cafe_info').css('border-top-color');
//		var btnBgColor = $('#div_cafe_info').css('border-top-color');
//		var btnFontColor = $('#div_cafe_info').css('border-top-color');
		
		$('#CF0301_bgColor').css('background-color', bgColor);
		$('#CF0301_brdrColor').css('background-color', bgBrdrColor);
//		$('#CF0301_btnBgColor').css('background-color', btnBgColor);
//		$('#CF0301_btnFontColor').css('background-color', btnFontColor);
	},
	
	//TODO
	menuColorRendering : function () {
		var bgColor = $('.CF0401_bgColor').css('background-color');
		var bgBrdrColor = $('.CF0401_brdrStyle').css('border-top-color');
		var menuGrpBgColor = $('.CF0401_menuGrpBgColor').css('background-color');
		
		$('#CF0401_bgColor').css('background-color', bgColor);
		$('#CF0401_brdrColor').css('background-color', bgBrdrColor);
		$('#CF0401_menuGrpBgColor').css('background-color', menuGrpBgColor);
		
		var width =$('.CF0401_brdrStyle').css('border-top-width').replace('px',''); 
		
		var topStyle = $('.CF0401_brdrStyle').css('border-top-style');
		var rightStyle = $('.CF0401_brdrStyle').css('border-right-style');
		var bottomStyle = $('.CF0401_brdrStyle').css('border-bottom-style');
		var leftStyle = $('.CF0401_brdrStyle').css('border-left-style');
		
		// 테두리 스타일 설정
		var posY = 0;
		
		if(width == 1){
			if(topStyle == 'solid'){
				posY = 1;
			}else if(topStyle == 'dashed'){
				posY = 4;
			}else if(topStyle == 'dotted'){
				posY = 5;
			} 
		}else if(width == 2){
			if(topStyle == 'solid'){
				posY = 2;
			}else if(topStyle == 'dashed'){
				posY = 6;
			} 
		}else if (width == 3){
			if(topStyle == 'solid'){
				posY = 3;
			}else if(topStyle == 'dashed'){
				posY = 7;
			} 
		}
		$('#menuBrdrStyle').css('background-position', '0 ' + -posY * 21 + 'px');
		
		
		var index = 1;
		var brdrStyle = '"border-top-style": "' + topStyle + '", "border-right-style": "' + rightStyle + '", "border-bottom-style": "' + bottomStyle + '", "border-left-style": "' + leftStyle + '"';
		var brdrWidth = '"border-top-width": "' + width + 'px", "border-right-width": "' + width + 'px", "border-bottom-width": "' + width + 'px", "border-left-width": "' + width + 'px"';
		
		//테두리 디자인 설정
		posY = 0;
		if(topStyle == 'none'){
			posY = 0;
		}
		else {
			if(leftStyle == 'none'){
				posY = 2;
			}else posY = 1;
		}
		$('#menuBrdrDesign').css('background-position', '0 ' + -posY * 21 + 'px');
		$('#CF0401_brdrStyle').val(topStyle);
		$('#CF0401_brdrStyle2').val(rightStyle);
		$('#CF0401_brdrWidth').val(width);
		$('#CF0401_brdrColor').css('background-color', $('.CF0401_brdrStyle').css('border-top-color'));
		
		//구분선 스타일 설정
		posY = 0;
		var sepWidth = $('.CF0401_sepBrdrStyle').css('border-top-width').replace('px','');
		var sepStyle = $('.CF0401_sepBrdrStyle').css('border-top-style').replace('px','');
		var sepColor = $('.CF0401_sepBrdrStyle').css('border-top-color');
		
		if(sepWidth == 0 || sepStyle == 'none') {
			posY = 0;
		}
		else if(sepWidth == 1){
			if(sepStyle == 'solid'){
				posY = 1;
			}else if(sepStyle == 'dashed'){
				posY = 4;
			}else if(sepStyle == 'dotted'){
				posY = 5;
			} 
		}else if(sepWidth == 2){
			if(sepStyle == 'solid'){
				posY = 2;
			}else if(sepStyle == 'dotted'){
				posY = 6;
			} 
		}else if (sepWidth == 3){
			if(sepStyle == 'solid'){
				posY = 3;
			}else if(sepStyle == 'dotted'){
				posY = 7;
			} 
		}
		$('#sepBrdrStyle').css('background-position', '0 ' + -posY * 21 + 'px');
		$('#CF0401_sepBrdrColor').css('background-color', sepColor);
	},
	
	//카페 메뉴의 색상 꾸미기를 눌렀을때 랜더링해주는 함수
	boardColorRendering : function () {
		//선택된 테두리 종류에 따라 이미지 포지션 정해주기
		var posY = 0;
		if(this.m_boardBrdrDesign == null){
			this.m_boardBrdrDesign = 'thin';
		}
		
		//brdrWidth를 가지고 테두리 종류를 확인해주고,		
		this.checkBoardBrdrKind();
		
		//확인된 테두리 종류 별로 테두리 종류 이미지 맵의 포지션을 정해줌
		switch(this.m_boardBrdrKind){
			case 'none': posY = 0; break; //선없음
			case 'square': posY = -21; break; //사각형
			case 'top-bottom': posY = -42; break; //위아래
			case 'bottom': posY = -63; break; //아래
		}
		//정해진 포지션을 가지고 css 속성 정의 해줌
		$('#boardBrdrKind').css('background-position', '0 ' + posY + 'px');
		
		
		//brdrWidth와 brdrStyle을 가지고 해당 테두리 종류의 테두리 디자인을 확인한다.
		//확인된 테두리 디자인 별로 이미지 맵의  포지션을 정해준다.
		this.setBoardBrdrDesignImage();
		
		//brdrColor를 가지고 컬러피커의 배경색을 설정해준다.
		var nmBrdrColor = cfCntt.getDeco().getDecoPrefValue2('CF0501_nmBrdrColor');
		$('#CF0501_nmBrdrColor').css('background-color', nmBrdrColor);
	},
	
	setBgAlign : function (posX, posY) {
		var cfTplMngr = cfGGum.getTplMngr();
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_bgImgPos', '{ "background-position-x": "' + posX + '", "background-position-y": "' + posY + '" }');
	},
	
	setBgColor : function (color) { 
		var cfTplMngr = cfGGum.getTplMngr();
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_bgColor', '{ "background-color": "' + color + '" }');
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_template', 'color');
	},
	
	setBrdrColor : function (color) { 
		var cfTplMngr = cfGGum.getTplMngr();
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_brdrColor', '{ "border-color": "' + color + '" }');
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_template', 'color');
	},
	
	setBrdrStyle : function (brdrWidth, brdrStyle) { 
		var cfTplMngr = cfGGum.getTplMngr();
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_brdrStyle', '{ "border": "' + color + '" }');
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_template', 'color');
	},
	
	setBtnBgColor : function (color) { 
		var cfTplMngr = cfGGum.getTplMngr();
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_btnBgColor', '{ "background-color": "' + color + '" }');
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_template', 'color');
	},
	
	setBtnFontColor : function (color) { 
		var cfTplMngr = cfGGum.getTplMngr();
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_btnFontColor', '{ "color": "' + color + '" }');
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_template', 'color');
	},
	
	setBaseFontColor : function (color) {
		var cfTplMngr = cfGGum.getTplMngr();
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_baseFontColor', '{ "color": "' + color + '" }');
		//cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_template', 'color');
	},
	
	setValFontColor : function (color) {
		var cfTplMngr = cfGGum.getTplMngr();
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_valFontColor', '{ "color": "' + color + '" }');
		//cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_template', 'color');
	},
	
	setMenuIconSet : function () {
		var iconId = $('#CF0402_decoId').val();
		var decoType = this.m_decoType;
		var cfTplMngr = cfGGum.getTplMngr();
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_menuIconSet', iconId);
		
		$.ajax({
			type: 'POST',
			url: cfTplMngr.m_contextPath + '/cafe/editor.cafe',
			data:
			{
				'm'    : 'getDecoPrefs',
				'dt'   : 'CF0402',
				'di'   : iconId,
				'dummy': Math.random()*1000,
				'__ajax_call__'  : true
			},
			dataType: 'html',
			success: function(html, textStatus){
				$('#editorArea').dialog( "close" );
				$('#decoTemplates').html(html);
				var tplDecoPrefs = eval("(" + $('#CF0402_decoPrefs').val() + ")");
				for(var i = 0; i < tplDecoPrefs.length; i++){
					var clazz = tplDecoPrefs[i].clazz;
					var value = tplDecoPrefs[i].value;
					cfTplMngr.m_deco.setDecoPref(clazz, value);
					
				}
				cfTplMngr.m_deco.rendering();
				cfTplMngr.initFooterColor();
			},
			error: function(x, e){
				alert(e + '\n잠시 후에 다시 시도 해주십시오.');
			}
		});
	},
	
	setMenuGrpBgColor : function (color) {
		var cfTplMngr = cfGGum.getTplMngr();
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_menuGrpBgColor', '{ "background-color": "' + color + '" }');
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_template', 'color');
	},
	
	setMenuBrdrDesign : function (index, etc) {
		var cfTplMngr = cfGGum.getTplMngr();
		
		var width = $('#CF0401_brdrWidth').val();
		var color = $('#CF0401_brdrColor').css('background-color');

		var topStyle = $('#CF0401_brdrStyle').val();
		
		var style = ''; 
		var style2 = '';
		
		switch(index){
			case '0': style = 'none'; style2 = 'none'; break;
			case '1': style = topStyle; style2 = topStyle; break;
			case '2': style = topStyle; style2 = 'none'; break;
			default: break;
		}
		$('#CF0401_brdrStyle2').val(style2);
		
		var brdrStyle = '"border-top-style": "' + style + '", "border-right-style": "' + style2 + '", "border-bottom-style": "' + style + '", "border-left-style": "' + style2 + '"';
		var brdrWidth = '"border-top-width": "' + width + 'px", "border-right-width": "' + width + 'px", "border-bottom-width": "' + width + 'px", "border-left-width": "' + width + 'px"';
		var design = '{ ' + brdrWidth + ', ' + brdrStyle + ' }';
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_brdrStyle', design);
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_template', 'color');
   	},
	
	setMenuBrdrStyle : function (index, etc) {
		var cfTplMngr = cfGGum.getTplMngr();
		
		var width = 1;
		switch(index){
			case '1': case '4': case '5': width = 1; break; 
			case '2': case '6': width = 2; break;
			case '3': case '7': width = 3; break;
			default: break;
		}
		$('#CF0401_brdrWidth').val(width);
		
		var style = 'solid';
		switch(index){
			case '1': case '2': case '3': style = 'solid'; break; 
			case '4': style = 'dashed'; break;
			case '5': case '6': case '7': style = 'dotted'; break;
			default: break;
		}
		$('#CF0401_brdrStyle').val(style);
		
		var style2 = $('#CF0401_brdrStyle2').val();
		if(style2 != 'none') style2 = style;
		
		var brdrWidth = '"border-top-width": "' + width + 'px", "border-right-width": "' + width + 'px", "border-bottom-width": "' + width + 'px", "border-left-width": "' + width + 'px"';
		var brdrStyle = '"border-top-style": "' + style + '", "border-right-style": "' + style2 + '", "border-bottom-style": "' + style + '", "border-left-style": "' + style2 + '"';
		var design = '{ ' + brdrWidth + ', ' + brdrStyle + ' }';
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_brdrStyle', design);
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_template', 'color');
   	},
   	
   	setMenuBrdrColor : function (color) {
   		var cfTplMngr = cfGGum.getTplMngr();
   		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_brdrColor', ' { "border-color": "' + color + '" }');
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_template', 'color');
   	},
   	
   	setSepBrdrStyle : function(index, etc) {
   		var cfTplMngr = cfGGum.getTplMngr();
		
		var width = 0;
		switch(index){
			case '0': width = 0; break;
			case '1': case '4': case '5': width = 1; break; 
			case '2': case '6': width = 2; break;
			case '3': case '7': width = 3; break;
			default: break;
		}
		$('#CF0401_sepBrdrWidth').val(width);
		
		var style = 'solid';
		switch(index){
			case '0': style = 'none'; break;
			case '1': case '2': case '3': style = 'solid'; break; 
			case '4': style = 'dashed'; break;
			case '5': case '6': case '7': style = 'dotted'; break;
			default: break;
		}
		$('#CF0401_sepBrdrStyle').val(style);
		
		var brdrWidth = '{ "border-top-width": "' + width + 'px" }';
   		var brdrStyle = '{ "border-top-style": "' + style + '" }';
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_sepBrdrWidth', brdrWidth);
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_sepBrdrStyle', brdrStyle);
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_template', 'color');
   	},
   	
   	setSepBrdrColor : function (color) {
   		var cfTplMngr = cfGGum.getTplMngr();
   		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_sepBrdrColor', ' { "border-top-color": "' + color + '" }');
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_template', 'color');
   	},
   	
   	setNmFontColor : function (color) { 
   		var cfTplMngr = cfGGum.getTplMngr();
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_nmFontColor', ' { "color": "' + color + '" }');
//   	cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_template', 'color');
   	},
   	
   	setSubjFontColor : function (color) { 
   		var cfTplMngr = cfGGum.getTplMngr();
   		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_subjFontColor', ' { "color": "' + color + '" }');
//   	cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_template', 'color');
   	},
   	
   	setRplFontColor : function (color) { 
   		var cfTplMngr = cfGGum.getTplMngr();
   		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_rplFontColor', ' { "color": "' + color + '" }');
//   	cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_template', 'color');
   	},
   	
   	setBoardBrdrKind : function (index) {
   		var cfTplMngr = cfGGum.getTplMngr();

   		var style = 'solid';
   		var width  = '0';
		switch(parseInt(index)) {
			case 0: width = '0'; style = 'solid'; break;
			case 1: width = '1px'; style = 'solid'; break;
			case 2: width = '1px 0'; style = 'solid'; break;
			case 3: width = '0 0 1px 0'; style = 'solid';  break;
			default: break;
		}
		
		cfCntt.getDeco().setDecoPref('CF0501_nmBrdrWidth', '{ "border-width": "' + width + '" }', true);
		cfCntt.getDeco().setDecoPref('CF0501_nmBrdrStyle', '{ "border-style": "' + style + '" }', true);
		cfTplMngr.setBoardBrdrDesignImage();
   	},
   	
   	checkBoardBrdrKind : function() {
   		var width = cfCntt.getDeco().getDecoPrefValue2('CF0501_nmBrdrWidth');
		width = width.split(" ");
		var p = parseInt(width[0]);
   		switch(width.length){
	   		case 1: {
	   			if(p == 0){
	   				this.m_boardBrdrKind = 'none';
	   			}else {
	   				this.m_boardBrdrKind = 'square';
	   			}
	   			break;
	   		}
	   		case 2: this.m_boardBrdrKind = 'top-bottom'; break;
	   		case 4: {
	   			if(p != 0) this.m_boardBrdrKind = 'top-bottom';
	   			else this.m_boardBrdrKind = 'bottom';
	   		} break;
	   		default: break;
   		}
   	},
   	
   	setBoardBrdrDesignImage : function () {
   		var cfTplMngr = cfGGum.getTplMngr();
   		var imageJObj = $('#boardBrdrDesign');
		
		this.checkBoardBrdrKind();
		
   		switch(this.m_boardBrdrKind){
			case 'none': {//선없음
				imageJObj.css('background-image', 'url("' + cfTplMngr.m_contextPath + '/cola/cafe/images/editor/boardBrdrKindSmall.gif")'); 
				imageJObj.css('background-position', '0 0');
				$('#CAFEBOARD_linetype2').addClass('boardStylerDimmed');
				$('#CAFEBOARD_linetype2').css('cursor','normal');
				var colorPicker = $('#CAFEBOARD_linecolor div.colorSelectEnabled');
				colorPicker.removeClass('colorSelectEnabled');
				colorPicker.addClass('colorSelectDisabled');
				imageJObj.unbind('click.boardBrdrDesign');
				break;	
			}
			case 'square': {
				imageJObj.css('background-image', 'url("' + cfTplMngr.m_contextPath + '/cola/cafe/images/editor/boardBrdrDesignSmall.gif")');
				imageJObj.css('background-position', '0 0');
				imageJObj.unbind('click.boardBrdrDesign');
				imageJObj.bind('click.boardBrdrDesign', function(){
					cfBorderPicker.initialize('boardBrdrDesign', 8326, 0, 2, 'boardBrdrDesign_01', cfGGum.getTplMngr().setBoardBrdrDesign);
				});
				$('#CAFEBOARD_linetype2').removeClass('boardStylerDimmed');
				var colorPicker = $('#CAFEBOARD_linecolor div.colorSelectDisabled');
				colorPicker.removeClass('colorSelectDisabled');
				colorPicker.addClass('colorSelectEnabled');
				break;	//상하좌우
			}
			case 'top-bottom': { 
				imageJObj.css('background-image', 'url("' + cfTplMngr.m_contextPath + '/cola/cafe/images/editor/boardBrdrDesignSmall.gif")');
				imageJObj.css('background-position', '0 -189px');
				imageJObj.unbind('click.boardBrdrDesign');
				imageJObj.bind('click.boardBrdrDesign', function(){
					cfBorderPicker.initialize('boardBrdrDesign', 8326, 0, 5, 'boardBrdrDesign_02', cfGGum.getTplMngr().setBoardBrdrDesign);
				});
				$('#CAFEBOARD_linetype2').removeClass('boardStylerDimmed');
				var colorPicker = $('#CAFEBOARD_linecolor div.colorSelectDisabled');
				colorPicker.removeClass('colorSelectDisabled');
				colorPicker.addClass('colorSelectEnabled');
				break;	//상하
			}
			case 'bottom': {
				imageJObj.css('background-image', 'url("' + cfTplMngr.m_contextPath + '/cola/cafe/images/editor/boardBrdrDesignSmall.gif")');
				imageJObj.css('background-position', '0 -63px');
				imageJObj.unbind('click.boardBrdrDesign');
				imageJObj.bind('click.boardBrdrDesign', function(){
					cfBorderPicker.initialize('boardBrdrDesign', 8326, 0, 5, 'boardBrdrDesign_03', cfGGum.getTplMngr().setBoardBrdrDesign);
				});
				$('#CAFEBOARD_linetype2').removeClass('boardStylerDimmed');
				var colorPicker = $('#CAFEBOARD_linecolor div.colorSelectDisabled');
				colorPicker.removeClass('colorSelectDisabled');
				colorPicker.addClass('colorSelectEnabled');
				break;
			}
			default: break;
		}
   		this.setBoardBrdrDesign();
   	},
   	
   	setBoardBrdrDesign : function (index){
   		var cfTplMngr = cfGGum.getTplMngr();
   		
   		cfTplMngr.checkBoardBrdrKind();
   		var width = cfCntt.getDeco().getDecoPrefValue2('CF0501_nmBrdrWidth');
   		var style = cfCntt.getDeco().getDecoPrefValue2('CF0501_nmBrdrStyle');
   		var color = '';
   		var designIdx = 0;
   		if(!index){
   			switch(style){
	   			case 'solid':{
	   				if(width == '1px')				designIdx =  0;
	   				if(width == '2px')				designIdx =  1; 
	   				if(width == '3px')				designIdx =  2; 
	   				if(width == '0 0 1px 0')		designIdx =  3;
	   				if(width == '0 0 2px 0')		designIdx =  4;
	   				if(width == '0 0 3px 0')		designIdx =  5;
	   				if(width == '1px 0')			designIdx =  9;
	   				if(width == '2px 0')			designIdx = 10;
	   				if(width == '3px 0')			designIdx = 11;
	   				if(width == '1px 0 2px 0')	designIdx = 12;
	   				if(width == '1px 0 3px 0')	designIdx = 13;
	   				if(width == '3px 0 1px 0')		designIdx = 14;
	   			} break;
	   			case 'dotted':{
	   				if(width == '0 0 1px 0') 		designIdx =  6;
	   				if(width == '0 0 2px 0') 		designIdx =  7;
	   				if(width == '0 0 3px 0') 		designIdx =  8;
	   			} break;
	   			default: break;
   			}
   		}
   		else {
			switch(cfTplMngr.m_boardBrdrKind){
				case 'none': width = '0'; style = 'solid'; designIdx = 0; break;
				case 'square': {
					if(index == 0){
						width = '1px'; style = 'solid'; designIdx = 0; 
					} else if(index == 1){
						width = '2px'; style = 'solid'; designIdx = 1;
					} else if(index == 2){
						width = '3px'; style = 'solid'; designIdx = 2;
					}
					break;
				}
				case 'top-bottom': {
					if(index == 0){
						width = '1px 0'; style = 'solid'; designIdx =  9;
					} else if(index == 1){
						width = '2px 0'; style = 'solid'; designIdx = 10;
					} else if(index == 2){
						width = '3px 0'; style = 'solid'; designIdx = 11;
					} else if(index == 3){
						width = '1px 0 2px 0'; style = 'solid'; designIdx = 12;
					} else if(index == 4){
						width = '1px 0 3px 0'; style = 'solid'; designIdx = 13;
					} else if(index == 5){
						width = '3px 0 1px 0'; style = 'solid'; designIdx = 14;
					}
					break;
				}
				case 'bottom': {
					if(index == 0){
						width = '0 0 1px 0'; style = 'solid';  designIdx = 3;
					} else if(index == 1){
						width = '0 0 2px 0'; style = 'solid';  designIdx = 4;
					} else if(index == 2){
						width = '0 0 3px 0'; style = 'solid';  designIdx = 5;
					} else if(index == 3){
						width = '0 0 1px 0'; style = 'dotted'; designIdx = 6;
					} else if(index == 4){
						width = '0 0 2px 0'; style = 'dotted'; designIdx = 7;
					} else if(index == 5){
						width = '0 0 3px 0'; style = 'dotted'; designIdx = 8;
					}
					break;
				}
			}
   		}
		
		$('#boardBrdrDesign').css('background-position', '0 ' + -designIdx * 21 + 'px');
		var brdrWidth = '{ "border-width": "' + width + '" }';
		var brdrStype = '{ "border-style": "' + style + '" }';
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_nmBrdrWidth', brdrWidth);
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_nmBrdrStyle', brdrStype);
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_template', 'color');
   	},
   	
   	setNmBrdrColor : function (color) {
   		var cfTplMngr = cfGGum.getTplMngr();
   		
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_nmBrdrColor', '{ "border-color":"' + color + '" }');
		$('.CF0501_nmBrdrColor').css('border-color', color);
		cfTplMngr.m_deco.setDecoPref(cfTplMngr.m_decoType + '_template', 'color');
   	},
   	
	initFooterColor : function () {
		var cfTplMngr = cfGGum.getTplMngr();
		
		var bfc = $('.' + this.m_decoType + '_baseFontColor').css('color');
		var vfc =  $('.' + this.m_decoType + '_valFontColor').css('color');
		$('#' + this.m_decoType + '_baseFontColor').css('background-color', bfc);
		$('#' + this.m_decoType + '_valFontColor').css('background-color', vfc);
		
		var icon = this.m_deco.getDecoPref('CF0402_selImg');
		if(icon) {
			var str = icon.value.split("/");
			if(str[str.length-2] == 'none'){
				$('#menuIconBg').css('background-position', '0 -1px');
				$('#CF0402_menuIconSet').css('background-image', 'none');
			}
			else {
				$('#menuIconBg').css('background-position', '0 -22px');
				$('#CF0402_menuIconSet').css(eval("("+ icon.value + ")"));
			}
		}
		var nfc = cfTplMngr.m_deco.getDecoPrefValue(this.m_decoType + '_nmFontColor', 'color');
		var sfc = cfTplMngr.m_deco.getDecoPrefValue(this.m_decoType + '_subjFontColor', 'color');
		var rfc = cfTplMngr.m_deco.getDecoPrefValue(this.m_decoType + '_rplFontColor', 'color');
		
		$('#' + this.m_decoType + '_nmFontColor').css('background-color', nfc);
		$('#' + this.m_decoType + '_subjFontColor').css('background-color', sfc);
		$('#' + this.m_decoType + '_rplFontColor').css('background-color', rfc);
	},
	
	reset : function (decoType) {
		this.m_deco.reset();
		if(this.m_decoType.indexOf('CF05') == -1){
			var bfc = eval("(" + this.m_deco.getOrgDecoPref(this.m_decoType + '_valFontColor').value + ")").color;
			var vfc = eval("(" + this.m_deco.getOrgDecoPref(this.m_decoType + '_baseFontColor').value + ")").color;
			$('#' + this.m_decoType + '_baseFontColor').css('background-color', bfc);
			$('#' + this.m_decoType + '_valFontColor').css('background-color', vfc);
		
			var icon = this.m_deco.getOrgDecoPref('CF0402_selImg');
			if(icon) {
				$('#CF0402_menuIconSet').css(eval("("+ icon.value + ")"));
			}
		}
		else {
   			this.m_deco.reset();
		}
	}
}

var cfGGum = new cafe.ggum();