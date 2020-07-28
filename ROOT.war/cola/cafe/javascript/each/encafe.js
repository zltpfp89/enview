if( ! window.cafe )
    window.cafe = new Object();

cafe.each = function() {
	this.m_ajax = new enview.util.Ajax();
	this.m_contextPath = ebUtil.getContextPath();
	
	this.m_edit  = new cafe.each.edit(this);
	this.m_skin  = new cafe.each.skin(this);
	this.m_bg	 = new cafe.each.bg(this);
	this.m_title = new cafe.each.title(this);
	this.m_gate  = new cafe.each.gate(this);
	this.m_info  = new cafe.each.info(this);
	this.m_menu  = new cafe.each.menu(this);
	this.m_cntt  = new cafe.each.cntt(this);
	this.m_srch  = new cafe.each.srch(this);
	this.m_buga  = new cafe.each.buga(this);
	
	this.m_isEditMode = false;
	this.m_isEdited = false;
	
}
cafe.each.prototype = {
	m_ajax  : null,
	m_contextPath : null,
	m_curCafeUrl  : null, // 개별카페홈 페이지의 테마파일에서 최초로 값을 설정해줌.

	m_edit  : null,
	m_skin	: null,
	m_bg	: null,
	m_title : null,
	m_gate  : null,
	m_info  : null,
	m_menu  : null,
	m_cntt  : null,
	m_srch  : null,
	m_buga  : null,
	m_util  : null,
	
	m_isEditMode : false,
	m_isEdited : false,
	m_isMobile : false,
	m_userAgent : null,
	
	m_frameType: null,
	m_layoutType: null,
	
	m_limitIE : "8.0",
	
	sendCommand : function (infoBox) {
		//alert("sendCommand::1,infoBox.m_target=["+infoBox.m_target+"]");
		switch (infoBox.m_target) {
			case "all"	:	{
				this.getSkinMngr().executeCommand(infoBox);
				this.getCafeBgMngr().executeCommand(infoBox);
				this.getTitleMngr().executeCommand(infoBox);
				this.getGateMngr().executeCommand(infoBox);
				this.getInfoMngr().executeCommand(infoBox);
				this.getMenuMngr().executeCommand(infoBox);
				this.getSrchMngr().executeCommand(infoBox);
				this.getCnttMngr().executeCommand(infoBox);
				this.getBugaMngr().executeCommand(infoBox);
				break;
			}
			case "skin": this.getSkinMngr().executeCommand(infoBox); break;
			case "bg": this.getCafeBgMngr().executeCommand(infoBox); break;
			case "title": this.getTitleMngr().executeCommand(infoBox); break;
			case "gate":  this.getGateMngr().executeCommand(infoBox); break;
			case "info":  this.getInfoMngr().executeCommand(infoBox); break;
			case "menu":  this.getMenuMngr().executeCommand(infoBox); break;
			case "cntt":  this.getCnttMngr().executeCommand(infoBox); break;
			case "srch":  this.getSrchMngr().executeCommand(infoBox); break;
			case "buga":  this.getBugaMngr().executeCommand(infoBox); break;
		}
	},
	getAjax : function() {
		return this.m_ajax;
	},
	getCafeUrl : function() {
		return this.m_curCafeUrl;
	},
	getInfoBox : function() {
		return new cafe.each.infoBox();
	},
	getEditMngr  : function() {
		return this.m_edit;
	},
	getSkinMngr  : function() {
		return this.m_skin;
	},
	getCafeBgMngr  : function() {
		return this.m_bg;
	},
	getTitleMngr : function() {
		return this.m_title;
	},
	getGateMngr : function() {
		return this.m_gate;
	},
	getInfoMngr : function() {
		return this.m_info;
	},
	getMenuMngr : function() {
		return this.m_menu;
	},
	getCnttMngr : function() {
		return this.m_cntt;
	},
	getSrchMngr : function() {
		return this.m_srch;
	},
	getBugaMngr : function() {
		return this.m_buga;
	},
	getUtil : function () {
		if (this.m_util == null) this.m_util = new cafe.each.Util ();
		return this.m_util;	
	},
	openRemoteController : function (type, decoType) {
		var decoId = $('#' + decoType + '_template').val();
		if(decoId == undefined || decoId == null || decoId == '' || decoId == 'null'){
			cfGGum.onClickMenu('ggumigi', type, 'image');
		}
		else {
			if(!isNaN(decoId)) {
				cfGGum.onClickMenu('ggumigi', type, 'image');
			}
			else {
				cfGGum.onClickMenu('ggumigi', type, decoId);
			}
		}
		this.m_isEdited = true;
	},
	
	getDecoPref : function (cafeUrl, decoType){
		var param = "m=getDecoPref";
		param += "&cafeUrl=" + cafeUrl;
		param += "&decoType=" + decoType;
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/each.cafe", param, true, {success: function(data) { 
			cfEach.getDecoPrefHandler(data, decoType); 
		}});	
	},
	
	getDecoPrefHandler : function(data, decoType){
		var target = "";
		
		var decoPrefs = eval("(" + data + ")");
		
		switch(decoType){
			case 'CF0101': case 'CF0102': case 'CF0103': case 'CF0104': case 'CF0105': 
			case 'CF0106': case 'CF0107': target = "title"; break;
			case 'CF0201': target = "gate"; break;
			case 'CF0301': case 'CF0302': target = "info"; break;
			case 'CF0401': target = "menu"; break;
			case 'CF0501': target = "cntt"; break;
			default: break;
		}
		$('#' + target + 'DecoPrefs').val(data);
		var cnttInfoBox = cfEach.getInfoBox();
		cnttInfoBox.m_on = "client";
		cnttInfoBox.m_target = target;
		cnttInfoBox.m_cmd = "deco";
		cnttInfoBox.m_decoPrefs = decoPrefs;
		cnttInfoBox.m_isOrg = 'true';
		cfEach.sendCommand(cnttInfoBox);
		
		var orgDecoId = cfCntt.getDeco().getOrgDecoPrefValue('#' + decoType + '_template');
		$('#' + decoType + 'CF0501_template').val(orgDecoId);
	},

	/**
	 * public functions
	 */
	login : function() {
		location.href = this.m_contextPath + "/user/login.face?destination=" + this.m_contextPath + '/cafe/' + this.m_curCafeUrl;
	},
	logout : function() {
		location.href = this.m_contextPath + "/user/logout.face?destination=/cafe";
	},
	go2EachHome	:	function(curCafeUrl) {
		var cafeUrl = this.m_curCafeUrl;
		if(curCafeUrl !== undefined && curCafeUrl !== null && curCafeUrl !== 'null') cafeUrl = curCafeUrl;
		location.href = this.m_contextPath + '/cafe/' + cafeUrl;
	},
	
	isAppliableBrowser : function(){
		if(this.m_isMobile) {
			alert('모바일(스마트폰, 테블릿피시 등)에서는 일부 카페 기능(관리, 꾸미기 기능 등)을 지원하지 않습니다.');
			return false;
		}
		
		  if (navigator.appName != 'Microsoft Internet Explorer') {
			  return true;
		  }
	
		var version = 0;
	    var ua = navigator.userAgent;
	    var re  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
	    if (re.exec(ua) != null) {
	        version = parseFloat( RegExp.$1 );
	    }
	    if( version < parseInt(this.m_limitIE)){
			alert('현재 브라우저로 버전으로는 카페 꾸미기를 이용하실 수 없습니다.\n' +
					'IE ' + this.m_limitIE + ' 이상의 최신 버전에서 다시 시도해주세요.\n' + 
					'(현재 사용중인 브라우져는 IE ' + jQuery.browser.version + '입니다.)');
			return false;
		}
	    return true;
	},
	
	initMaskPanel : function(){
		var infoBox = cfEach.getInfoBox();
		infoBox.m_on = "client";
		infoBox.m_target = "all";
		infoBox.m_cmd = "changeMode";
		cfEach.sendCommand(infoBox);
		/*
		
		var width = parseInt($('#main_navigation').css('width').replace('px',''));
		var height = parseInt($('#main_navigation').css('height').replace('px',''));
		$('#navigation_mask').css('width', width+2);
		$('#navigation_mask').css('height', height);
		$('#navigation_mask_layer').css('width', width);
		$('#navigation_mask_layer').css('height', height);
		$('#navigation_mask').css('top', ebUtil.getAbsTop('main_navigation'));
		$('#navigation_mask').css('left', ebUtil.getAbsLeft('main_navigation')-1);
		$('#navigation_mask').css('display','block');
		*/
	},
	
	initCafeInfo : function(){
		//페이지 타이틀 설정하기
		var cafeName = $('#title_cafeName').html();
		$(document).attr('title', cafeName + ' - ' + $(document).attr('title'));
		//자주가는카페 읽어오기
		var fcDiv = $("#favorCafeDiv");
		var fcLi  = $("#favorCafeList");
		if (fcLi.children().length == 0) {
			var param = "m=myFavorCafeList";
			this.m_ajax.send("POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(htmlData) { 
				fcLi.html(htmlData);
				var link = $("#favorLink");
				fcDiv.css("top",  ebUtil.getAbsTop("favorLink") + link.height()); 
			}});
		}
		
		//개별카페 홈 링크 이벤트 할당
		$('.homeLink').bind('click.homeLink', function(){
			cfEach.go2EachHome();
		});
	},
	
	showFavorCafe : function() {
		var isShow = $("#favorCafeDiv").css('display') == 'block' ? true : false;
		if(isShow) $("#favorCafeDiv").css('display','none');
		else $("#favorCafeDiv").css('display','block');
	},
	
	//네비게이션 함수
	go2Home : function(initView) {
		var frm = document.title_form;
		frm.initView.value = initView;
		frm.submit();
	},
	go2Enview : function() {
		window.location.href = this.m_contextPath + "/portal";
	},
	go2BlogHome : function() {
		alert('준비중입니다.');
	},
	go2Mail : function() {
		alert('준비중입니다');
		/*	메일 서버 주소 입력
		 *  var mailServerUrl = "";
			window.open(mailServerUrl,'mail','width=1000,height=650,menubar=no,scrollbar=no');
		*/
	},
	go2Note : function() {
		window.open(this.m_contextPath + '/note/note.hanc','note','width=1000,height=650,menubar=no,scrollbar=no');
	}
}
cafe.each.infoBox = function() {
	this.m_decoPrefs = new Array();
}

cafe.each.infoBox.prototype = {
	m_on      : "",
	m_target  : "",
	m_cmd     : "",
	m_view    : "",
	m_act     : "",
	m_menuId  : "",
	m_caller  : "",
	m_boardId : "",
	m_bltnNo  : "",
	
	m_cmntUrl : "",
	m_srchType: "",
	m_srchKey : "",
	// 꾸미기 정보를 담는 객체
	m_decoPrefs	: null,
	m_isOrg		: 'false',
	
	//iframe용 변수
	m_frameId : null,
	m_frameType : null,
	
	m_colorSet : null
}
cafe.each.Deco = function(parent){
	this.m_parent = parent;		// 부모 객체 할당
	
	this.m_decoPrefsOrg = new Array();
	this.m_decoPrefs = new Array();
	
};
cafe.each.Deco.prototype = {
	m_parent			:	null,	// 부모 영역
	m_decoPrefsOrg		:	null,	// 각 class 속성들을 가지고 있는 원본 json 객체 배열
	m_decoPrefs			:	null,	// 각 class 속성들을 가지고 있는 클론 json 객체 배열
	
	m_ignoreClass		:	[
	             		 	 'tplImg','template','menuIconSet', 'selImg', 'menuTplImg', 
	             		 	 'tplName', 'frameType', 'skinNm', 'themeNm', 'menuAreaOrder', 
	             		 	 'bugaAreaOrder','brdGrpType', 'brdType', 'brdId', 'cafeUseType',
	             		 	 'baseColor'
	             		 	],
	m_ignoreDecoType	:	[
	             		 	 'CF1101','CF1102' 
	             		 	 ],	             		 	
	m_colorSet			:	null,
	m_colorSetValue		: 	[ //베이스 컬러
	               		  	 'baseColor', 'baseBgColor',
	               		  	 //타이틀 컬러
	               		  	 'ttlFontColor','ttlUrlFontColor','ttlMenuFontColor','ttlMenuBgColor','ttlMenuBrdrColor',
	               		  	 //정보영역컬러
	               		  	 'infoValColor','infoBaseColor','infoBrdrColor',
	               		  	 //메뉴영역 컬러
	               		  	 'menuValColor','menuBaseColor',
	               		  	 //컨텐츠 영역 컬러
	               		  	 'cnttNmFontColor','cnttNmBrdrColor','cnttRplFontColor',
	               		  	 //검색영역 컬러
	               		  	 'srchBrdrColor','srchBgColor','srchFontColor','srchBtnUrl',
	               		  	 //extra 컬러
	               		  	 'extraBrdrColor','extraBgColor','extraColor'
	               		  	],

	getParent			:	function()		{	return this.m_parent;			},
	getDecoPrefsOrg		:	function()		{	return this.m_decoPrefsOrg;		},
	getDecoPrefs		:	function()		{	return this.m_decoPrefs;		},
	
	setParent			:	function(value)	{	this.m_parent = value;			},
	setDecoPrefsOrg		:	function(value)	{	this.m_decoPrefsOrg = value;	},
	setDecoPrefs		:	function(value)	{	this.m_decoPrefs = value;		},
	
	// 값들 초기화 하는 함수
	initialize		:	function()	{
		this.m_decoPrefs = new Array();
	},
	
	// 초기 카페 정보로 복구
	reset			:	function(){
		this.m_decoPrefs = ebUtil.clone (this.m_decoPrefsOrg);
		this.rendering();
	},
	
	// 속성들 가지고 랜더링 하는 부분
	rendering		:	function(index, frameId)	{
		if(index) {
			//숫자가 아니고 클래스명일 때
			if(isNaN(index)){
				for(var i = 0 ; i < this.m_ignoreClass.length ; i++) {
					if(index.indexOf(this.m_ignoreClass[i]) > -1) {
						return;
					}
				}
				for(var i = 0 ; i < this.m_decoPrefs.length ; i++ ){
					if(index == this.m_decoPrefs[i].clazz){
						try {
							if (frameId) $('#'+frameId).contents().find('.' + this.m_decoPrefs[i].clazz).css( eval("( " + this.m_decoPrefs[i].value + ")") );
							else $('.' + this.m_decoPrefs[i].clazz).css( eval("( " + this.m_decoPrefs[i].value + ")") );
						}catch(e){
							alert(e +'\nindex=' + index + ', frameId=' + frameId + '\n' + '$(".' + this.m_decoPrefs[i].clazz + '")=' + $('.' + this.m_decoPrefs[i].clazz) + '\n' + this.m_decoPrefs[i].clazz + ', ' + this.m_decoPrefs[i].value );
						}
						break;
					}
				}
			}
			//숫자일때
			else if(!isNaN(index)){
				if (frameId) {
					$('#'+frameId).contents().find('.' + this.m_decoPrefs[index].clazz).css( eval("( " + this.m_decoPrefs[index].value + ")") );
				}
				else $('.' + this.m_decoPrefs[index].clazz).css( eval("( " + this.m_decoPrefs[index].value + ")") );
			}
		}
		//index 인수를 받지 않았을 때
		else {
			for(var i = 0 ; i < this.m_decoPrefs.length ; i++ ){
				if(this.m_decoPrefs[i].value != undefined && this.m_decoPrefs[i].value != null && this.m_decoPrefs[i].value != '' && this.m_decoPrefs[i].value != 'null'){
					var isContinue = false;
					for(var j = 0 ; j < this.m_ignoreClass.length ; j++) {
						if(this.m_decoPrefs[i].clazz.indexOf(this.m_ignoreClass[j]) > -1)  {
							isContinue = true;
							break;
						}
					}
					if(isContinue){
						continue;
					}
					try{
						if (frameId) $('#'+frameId).contents().find('.' + this.m_decoPrefs[i].clazz).css( eval("( " + this.m_decoPrefs[i].value + ")") );
						else $('.' + this.m_decoPrefs[i].clazz).css( eval("( " + this.m_decoPrefs[i].value + ")") );
					}catch(e){
						alert(e +'\nindex=' + index + ', frameId=' + frameId + '\n' + '$(".' + this.m_decoPrefs[i].clazz + '")=' + $('.' + this.m_decoPrefs[i].clazz) + '\n' + this.m_decoPrefs[i].clazz + ', ' + this.m_decoPrefs[i].value );
					}
				}
			}
		}
	},
	
	// 개별 원본 DecoPref를 가져오는 getter 함수
	getOrgDecoPref		:	function(index)	{
		if(index !== undefined && index !== null && index !== 'null') {
			if(!isNaN(index)){
				return this.m_decoPrefsOrg[index];
			}else{
				for(var i = 0 ; i < this.m_decoPrefsOrg.length ; i++ ){
					if(index == this.m_decoPrefsOrg[i].clazz){
						return this.m_decoPrefsOrg[i];
					}
				}
			}
		}
	},
	
	// 개별 원본 DecoPref를 가져오는 getter 함수
	getOrgDecoPrefValue		:	function(clazz, attr)	{
		if(attr == undefined || attr == null || attr == '' | attr == 'null'){
			try {
				var orgDecoPref = this.getOrgDecoPref(clazz);
				if(orgDecoPref)	return orgDecoPref.value;
			}catch (e) {
				alert(e + '\nclazz=' + clazz + '\nthis.getOrgDecoPref(' + clazz + ')=' + this.getOrgDecoPref(clazz));
				return null;
			}
		}
		else {
			var prefs = eval("( " + this.getOrgDecoPref(clazz).value + ")");
			var value = eval("prefs." + attr);
			return value;
		}
	},
	
	// 개별 DecoPref를 가져오는 getter 함수
	getDecoPref		:	function(index)	{
		if(index !== undefined && index !== null && index !== 'null') {
			if(!isNaN(index)){
				return this.m_decoPrefs[index];
			}else{
				for(var i = 0 ; i < this.m_decoPrefs.length ; i++ ){
					if(index == this.m_decoPrefs[i].clazz){
						return this.m_decoPrefs[i];
					}
				}
			}
		}
	},
	
	// 개별 원본 DecoPref를 가져오는 getter 함수
	getDecoPrefValue		:	function(clazz, attr)	{
		if(attr == undefined || attr == null || attr == '' | attr == 'null'){
			return this.getDecoPref(clazz).value;
		}
		else {
			//alert("clazz=["+clazz+"],attr=["+attr+"]");
			try {
				var prefs = eval("( " + this.getDecoPref(clazz).value + ")");
				var value = eval("prefs." + attr);
				return value;
			} catch(e){
				
			}
		}
	},
	
	// 개별 원본 DecoPref를 가져오는 getter 함수
	getDecoPrefValue2		:	function(clazz, attr)	{
		try {
			var value = this.getDecoPref(clazz).value;
			while(value.indexOf('{') > -1){
				value = value.replace('{','');
			}
			while(value.indexOf('"') > -1){
				value = value.replace('"','');
			}
			while(value.indexOf('}') > -1){
				value = value.replace('}','');
			}
			value = value.split(":")[1];
			if(value.indexOf(' ') == 0){
				value = value.substring(1, value.length);
			}
			if(value.charAt(value.length-1) == ' '){
				value = value.substring(0, value.length-1);
			}
			return value;
		} catch(e){
			alert(e);
		}
	},
	
	// 개별 DecoPref를 찾아서 값을 할당해주는 setter 함숨
	setDecoPref		:	function(index, value, isRendering)	{
		if(index !== undefined && index !== null && index !== 'null'){
			if(!isNaN(index)){
				this.m_decoPrefs[index].value = value;
			}
			else{
				var ok = false;
				for(var i = 0 ; i < this.m_decoPrefs.length ; i++ ){
					if(index == this.m_decoPrefs[i].clazz){
						this.m_decoPrefs[i].value = value;
						ok = true;
						break;
					}
				}
				//---------------------------------- 
				if( !ok) {
					if( index.indexOf("CF08")==0 || index.indexOf("CF11")==0 || index.indexOf("CF01") ==0) {
						this.m_decoPrefs.push( {clazz : index, value : value});
					} else {
//						alert( index + ":" + value);
					}
				}
			}
//			alert( index + ":" + value);
			if(isRendering == undefined || isRendering == true) this.rendering(index);
		}
	},
	
	m_decoType			:	null,
	setDecoType			:	function(decoType) { this.m_decoType = decoType;	},
	renewDecoPrefs		:	function(decoPrefs, colorSet) {
		var newDecoPrefs = new Array();
		var newDecoIndex = 0;
		var dasd= false;
		for(var i = 0 ; i < decoPrefs.length ; i++ ){
			if(decoPrefs[i].value != undefined && decoPrefs[i].value != null && decoPrefs[i].value != '' && decoPrefs[i].value != 'null'){
				var isIgnored = false;
				for(var j = 0 ; j < this.m_ignoreClass.length ; j++) {
					if(decoPrefs[i].clazz.indexOf(this.m_ignoreClass[j]) > -1 || decoPrefs[i].clazz.indexOf(this.m_decoType) < 0)  {
						isIgnored = true;
						break;
					}
				}
				for(var j = 0 ; j < this.m_colorSetValue.length ; j++) {
					if(decoPrefs[i].value.indexOf(this.m_colorSetValue[j]) > -1){
						decoPrefs[i].value = decoPrefs[i].value.replace(this.m_colorSetValue[j], eval('colorSet.' + this.m_colorSetValue[j]));
						break;
					}
				}
				newDecoPrefs[newDecoIndex++] = decoPrefs[i];
				if(!isIgnored){ 
					$('.' + decoPrefs[i].clazz).css( eval("( " + decoPrefs[i].value + ")") );
				}
			}
		}
		this.m_decoPrefs = newDecoPrefs;
	},
	
	changeSkinColor : function(color){
		this.m_colorSet = color;
		//alert('DECO_TYPE: ' + this.m_decoType + ', COLOR: ' + color);
		
	}
};
cafe.each.edit = function (parent) {
	this.m_parent = parent;
	this.m_ajax = parent.m_ajax;
	this.m_contextPath = parent.m_contextPath;
}
cafe.each.edit.prototype = {
	m_parent : null,
	m_ajax : null,
	m_contextPath : null,
	
	m_isHide : false,
	
	isHide	: function() {
		return this.m_isHide;
	},
	go2CafeMng : function(){
		
	},
	go2EachHome : function(){
		
	},
	go2HomeEdit : function(){
		
	},
	go2GateEdit : function(){
		
	},
	go2TitleEdit : function(){
		
	},
	go2Recommanded : function(){
		
	},
	hideAni : function(){
		if(!this.m_isFixed){
			var curScroll = this.getCurScroll();
			this.m_isHide = true;
			$( "#edit_menu_bar" ).animate({
				top: curScroll.Y - $( "#edit_menu_bar" ).css('height').replace('px','')
			}, 300 );
			$( "#edit_menu_bar" ).css('top', '-2000px');
		}
	},
	viewAni : function(){
		if(!this.m_isFixed){
			var curScroll = this.getCurScroll();
			this.m_isHide = false;
			$( "#edit_menu_bar" ).css('top', curScroll.Y - 40 + 'px');
			$( "#edit_menu_bar" ).animate({
				top: curScroll.Y
			}, 300 );
		}
	},
	hide	: function(){
		if(!this.m_isFixed){
			this.m_isHide = true;
			$( "#edit_menu_bar" ).css('top',  '-2000px');
		}
	},
	view : function(){
		if(!this.m_isFixed){
			this.m_isHide = false;
			var edit_menu_bar = document.getElementById('edit_menu_bar');
			if(edit_menu_bar && $( "#edit_menu_bar" ).css('top').replace('px','') != 0){
				$( "#edit_menu_bar" ).css('top', 0);
			}
		}
	},
	getCurScroll : function(){
		var de = document.documentElement;
		var b = document.body;
		var now = {};
	
		now.X = document.all ? (!de.scrollLeft ? b.scrollLeft : de.scrollLeft) : (window.pageXOffset ? window.pageXOffset : window.scrollX);
		now.Y = document.all ? (!de.scrollTop ? b.scrollTop : de.scrollTop) : (window.pageYOffset ? window.pageYOffset : window.scrollY);
	
		return now;
	}
}

cafe.each.skin = function (parent) {
	this.m_parent = parent;
	this.m_ajax = parent.getAjax();
	this.m_contextPath = parent.m_contextPath;
	
	this.m_deco	= new cafe.each.Deco(this);
	this.m_deco.setDecoType("CF0801");
}

cafe.each.skin.prototype = {
	m_parent : null,
	m_ajax : null,
	m_contextPath : null,
	isShow : true,
	m_deco : null,
	
	m_editable : true,
	
	setEditable : function(editable){
		this.m_editable = editable;
	},
	
	isEditable : function(){
		return this.m_editable;
	},

	getDeco	:	function()	{
		return this.m_deco;
	},
	
	executeCommand : function (infoBox) {
		if (infoBox.m_on == "client") {
			// 꾸미기에서  무언가 변화가 있을 때
			if (infoBox.m_cmd == "skin") {
				// 랜더링 하기 전에 인포박스에서 넘어온 deco의 class 정보들을 자기 영역 deco들에게 복사
				cfBg.getDeco().renewDecoPrefs(infoBox.m_decoPrefs, infoBox.m_colorSet);
				if(!infoBox.m_isUseTitle){
					cfTitle.getDeco().renewDecoPrefs(infoBox.m_decoPrefs, infoBox.m_colorSet);	
				}
				cfInfo.getDeco().renewDecoPrefs(infoBox.m_decoPrefs, infoBox.m_colorSet);
				cfMenu.getDeco().renewDecoPrefs(infoBox.m_decoPrefs, infoBox.m_colorSet);
				cfCntt.getDeco().renewDecoPrefs(infoBox.m_decoPrefs, infoBox.m_colorSet);
				cfSrch.getDeco().renewDecoPrefs(infoBox.m_decoPrefs, infoBox.m_colorSet);
				
//				var decos = cfBg.getDeco().getDecoPrefs();
//				var text = '';
//				for(var i = 0 ; i < decos.length; i++){
//					text += '('+ decos[i].clazz + ', ' + decos[i].value + ')';
//				}
//				alert(text);
			} else {
				if (infoBox.m_cmd == "skinColor") {
					var color = infoBox.m_colorSet;
					cfBg.getDeco().changeSkinColor(color);
					if(!infoBox.m_isUseTitle){
						cfTitle.getDeco().changeSkinColor(color);
					}
					cfInfo.getDeco().changeSkinColor(color);
					cfMenu.getDeco().changeSkinColor(color);
					cfCntt.getDeco().changeSkinColor(color);
					cfSrch.getDeco().changeSkinColor(color);
					
//					var decos = cfBg.getDeco().getDecoPrefs();
//					var text = '';
//					for(var i = 0 ; i < decos.length; i++){
//						text += '('+ decos[i].clazz + ', ' + decos[i].value + ')';
//					}
//					alert(text);
				}
			}
		}
	},
	executeCommandHandler : function (htmlData) {
		
	}
}
	
cafe.each.bg = function (parent) {
	this.m_parent = parent;
	this.m_ajax = parent.getAjax();
	this.m_contextPath = parent.m_contextPath;
	
	this.m_deco	= new cafe.each.Deco(this);
	this.m_deco.setDecoType("CF0802");
}
cafe.each.bg.prototype = {
	m_parent : null,
	m_ajax : null,
	m_contextPath : null,
	isShow : true,
	m_deco : null,
	
	m_editable : true,
	
	setEditable : function(editable){
		this.m_editable = editable;
	},
	
	isEditable : function(){
		return this.m_editable;
	},

	getDeco	:	function()	{
		return this.m_deco;
	},
	
	executeCommand : function (infoBox) {
		if (infoBox.m_on == "client") {
			// 꾸미기에서  무언가 변화가 있을 때
			if (infoBox.m_cmd == "deco") {
				// 랜더링 하기 전에 인포박스에서 넘어온 deco의 class 정보들을 자기 영역 deco들에게 복사
				if(infoBox.m_isOrg == 'true'){
					this.m_deco.setDecoPrefsOrg(ebUtil.clone(infoBox.m_decoPrefs));
				}
				this.m_deco.setDecoPrefs(infoBox.m_decoPrefs);
				this.m_deco.rendering();
			}
//			else if (infoBox.m_cmd == "") {
//						
//			}
		}
	},
	executeCommandHandler : function (htmlData) {
		
	}
}


cafe.each.title = function (parent) {
	this.m_parent = parent;
	this.m_ajax = parent.getAjax();
	this.m_contextPath = parent.m_contextPath;
	
	this.m_deco	= new cafe.each.Deco(this);
	this.m_deco.setDecoType("CF01");
}
cafe.each.title.prototype = {
	m_parent : null,
	m_ajax : null,
	m_contextPath : null,
	
	m_deco : null,
	
	m_editable : true,
	
	setEditable : function(editable){
		this.m_editable = editable;
	},
	
	isEditable : function(){
		return this.m_editable;
	},
	
	getDeco	:	function()	{
		return this.m_deco;
	},
	
	selectMenu : function (menuId, boardId) {
		$('.title_cafeTitleMenu').each(function(){
			var $this = $(this);
			if(menuId == $this.attr('id').replace('titmeMenu_','') || boardId == $this.attr('bid')){
				$this.removeClass('CF0105_baseFontColor');
				$this.addClass('CF0105_selFontColor');
				cfTitle.getDeco().rendering('CF0105_selFontColor');
			}else{
				$this.removeClass('CF0105_selFontColor');
				$this.addClass('CF0105_baseFontColor');
				cfTitle.getDeco().rendering('CF0105_baseFontColor');
			}
		});
		cfMenu.selectMenu(menuId, boardId);
	},
	
	search	:	function()	{
		if( event.keyCode == 0 || event.keyCode == 13){
			if($('#titleSearchField').val() != ''){
				var action = '';
				if(event.keyCode == 0) action = 'Button Click';
				else action = 'Enter key';
				alert('Action: ' + action + '\nSearch Words: ' + $('#titleSearchField').val());
			}else {
				alert('Please Insert Words');
				$('#titleSearchField').select();
			}
		}
	},
	go2TitleEdit	:	function(){
		location.href = this.m_contextPath + '/cafe/editor.cafe?cafeUrl=' + this.m_parent.m_curCafeUrl + '&m=title';
	},
	
	executeCommand : function (infoBox) {
		var _this = this;
		if (infoBox.m_on == "client") {
			if (infoBox.m_cmd == "changeMode") {
				$('#cafe_title_wrap').unbind('mouseover.mask');
				$('#cafe_title_wrap').unbind('mouseout.mask');
				$('#cafe_title_wrap').bind('mouseover.mask', function(){
					var width = parseInt($('#cafe_title_wrap').css('width').replace('px',''));
					var height = parseInt($('#cafe_title_wrap').css('height').replace('px',''));
					$('#cafetitle_mask').css('width', width+2);
					$('#cafetitle_mask').css('height', height);
					$('#cafetitle_mask_layer').css('width', width);
					$('#cafetitle_mask_layer').css('height', height);
					$('#cafetitle_mask').css('top', ebUtil.getAbsTop('cafe_title_wrap')-2);
					$('#cafetitle_mask').css('left', ebUtil.getAbsLeft('cafe_title_wrap')-1);
//					$('#cafetitle_mask_layer').css('left', -2);
					$('#cafetitle_mask').css('display','block');
				})
				.bind('mouseout.mask', function(){
					$('#cafetitle_mask').css('display','none');
				});

				$('#cafetitle_mask').unbind('click.mask');
				if(this.m_editable) {
					$('#cafetitle_mask').bind('click.mask', function(){
						_this.go2TitleEdit();
					});
				}
			} 
			
			// 꾸미기에서  무언가 변화가 있을 때
			else if (infoBox.m_cmd == "deco") {
				// 랜더링 하기 전에 인포박스에서 넘어온 deco의 class 정보들을 자기 영역 deco들에게 복사
				if(infoBox.m_isOrg == 'true'){
					this.m_deco.setDecoPrefsOrg(ebUtil.clone(infoBox.m_decoPrefs));
				}
				this.m_deco.setDecoPrefs(infoBox.m_decoPrefs);
				this.m_deco.rendering();
			}
			else if (infoBox.m_cmd == "deco/reset") {
				this.m_deco.reset();
			}
			else if (infoBox.m_cmd == "") {
							
			}
		} else {
			var param = "m=title";
			this.m_ajax.send("POST", this.m_contextPath+"/cafe/each.cafe", param, true, {success: function(htmlData) { cfTitle.executeCommandHandler(htmlData); }});
		}
	},
	executeCommandHandler : function (htmlData) {
		document.getElementById("div_cafe_title").innerHTML = htmlData;
	}
}
cafe.each.gate = function (parent) {
	this.m_parent = parent;
	this.m_ajax = parent.getAjax();
	this.m_contextPath = parent.m_contextPath;
	
	this.m_deco	= new cafe.each.Deco(this);
	this.m_deco.setDecoType("CF02");
}
cafe.each.gate.prototype = {
	m_parent : null,
	m_ajax : null,
	m_contextPath : null,
	ecSessionKeepTimeoutID : null, // Session 유지를 위한 타임아웃ID
	
	smarteditor : null,	//스마트에디터 여부
	m_deco : null,
	
	m_editable : true,
	
	setEditable : function(editable){
		this.m_editable = editable;
	},
	
	isEditable : function(){
		return this.m_editable;
	},
	

	getDeco	:	function()	{
		return this.m_deco;
	},
	
	showNoticeContent : function (showFlag, noticeId) {
		var elm = document.getElementById("noticeContent"+noticeId);
		if (showFlag) {
			elm.style.display = "";
		} else {
			elm.style.display = "none";
		}
	},
	applyGateHtml : function () {
		if (!confirm (ebUtil.getMessage ("cf.info.ggum.gate.apply"))) return;
		var param = "m=setGgumDecoPrefs";
		param += "&cafeUrl=" + cfEach.m_curCafeUrl;
		try {
			if (cfGate.smarteditor) {	//스마트에디터인 경우
				param += "&CF0201_html=" + oEditors.getById["gateHtmlEditor"].getIR();
			} else {
				param += "&CF0201_html=" + FCKeditorAPI.GetInstance('gateHtmlEditor').GetData();	
			}
		} catch (ex) {
			// FCKeditor 를 사용하지 않는 경우에는...
			param += "&CF0201_html=" + document.getElementById('gateHtmlEditor').value;
		}
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/editor.cafe", param, true, {success: function(data) {
			alert (ebUtil.getMessage("ev.info.success.update"));
			//cfEach.m_isEdited = false;
			//cfEach.go2EachHome();
		}});
	},
	executeCommand : function (infoBox) {
		if (infoBox.m_on == "client") {
			if (infoBox.m_cmd == "changeMode") {
				var width = $('#cafe_gate_wrap').css('width');
				var height = $('#div_cafe_gate').css('height');
				$('#cafegate_mask').css('width', width);
				$('#cafegate_mask').css('height', height);
				$('#cafegate_mask_layer').css('width', width);
				$('#cafegate_mask_layer').css('height', height);
				$('#cafegate_mask').css('top', ebUtil.getAbsTop('div_cafe_gate')-1);
				$('#cafegate_mask').css('left', ebUtil.getAbsLeft('div_cafe_gate')-1);
				
				$('#cafe_gate_wrap').unbind('mouseover.mask');
				$('#cafe_gate_wrap').unbind('mouseout.mask');
				$('#cafe_gate_wrap').bind('mouseover.mask', function(){
					$('#cafegate_mask').css('display','block');
				})
				.bind('mouseout.mask', function(){
					$('#cafegate_mask').css('display','none');
				});
				
				$('#cafegate_mask_layer').unbind('click.mask');
				$('#cafegate_mask_layer').bind('click.mask', function(){
					cfEach.openRemoteController('gate', 'CF0201');
				});
			}
			if (infoBox.m_cmd == "changeMode") {
				
				cfGate.ecSessionKeepTimeoutID = setTimeout("cfGate.ecSessionKeepDelay()", 180000);
				cfGate.smarteditor = document.getElementById("smarteditor");
				enLangKnd = document.getElementById('langKnd').value;
				
				if (cfGate.smarteditor) {	//스마트에디터인 경우
					nhn.husky.EZCreator.createInIFrame({
						oAppRef: oEditors,
						elPlaceHolder: "gateHtmlEditor",
						sSkinURI: ebUtil.getContextPath() + "/board/smarteditor/SmartEditor2Skin.html",	
						htParams : {
							bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
							bUseVerticalResizer : false,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
							bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
							//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
							fOnBeforeUnload : function(){
								//alert("완료!");
							}
						}, //boolean
						fOnAppLoad : function(){
						},
						fCreator: "createSEditor2"
					});
				} else {
					// FCKeditor 관련 초기화					
					var ebFCKeditor = new FCKeditor('gateHtmlEditor');
					ebFCKeditor.BasePath = ebUtil.getContextPath() + "/board/fckeditor/"
					ebFCKeditor.Config["CustomConfigurationsPath"] = ebUtil.getContextPath()+'/cola/cafe/javascript/editor/fckconfig_gate.js';
					ebFCKeditor.Height = 500;
					ebFCKeditor.ReplaceTextarea();	
				}
			} 			// 꾸미기에서  무언가 변화가 있을 때
			else if (infoBox.m_cmd == "deco") {
				// 랜더링 하기 전에 인포박스에서 넘어온 deco의 class 정보들을 자기 영역 deco들에게 복사
				if(infoBox.m_isOrg == 'true'){
					this.m_deco.setDecoPrefsOrg(ebUtil.clone(infoBox.m_decoPrefs));
				}
				this.m_deco.setDecoPrefs(infoBox.m_decoPrefs);
				this.m_deco.rendering();
			}
			else if (infoBox.m_cmd == "clearArea") {
				$('#div_cafe_gate').html("");
				$('#div_cafe_gate_blank').remove();
			}
		} else {
			var param = "m=gate";
			this.m_ajax.send("POST", this.m_contextPath+"/cafe/each.cafe", param, true, {success: function(htmlData) { cfGate.executeCommandHandler(htmlData); }});
		}
	},
	executeCommandHandler : function (htmlData) {
		$('#div_cafe_gate').html(htmlData);
	},
	ecSessionKeepDelay : function () {
		// 주기적으로 서버로 요청을 보내서, session-timeout이 짧게 잡혀있는 서버환경에서
		// 게시물을 오래 편집하여도 세션이 끊어지지 않도록 조치하여준다.
		// 2010.03.26.KWShin.
		ebUtil.loadXMLDoc("TEXT", "GET", ebUtil.getContextPath()+"/board/resource/session_keeping.jsp");
		//alert("KEEPING!!");
		clearTimeout (cfGate.ecSessionKeepTimeoutID );
		cfGate.ecSesssionKeepTimoutID = setTimeout("cfGate.ecSessionKeepDelay()", 180000);
	}
}
cafe.each.info = function (parent) {
	this.m_parent = parent;
	this.m_ajax = parent.getAjax();
	this.m_contextPath = parent.m_contextPath;
	
	this.m_deco	= new cafe.each.Deco(this);
	this.m_deco.setDecoType("CF03");
}
cafe.each.info.prototype = {
	m_parent : null,
	m_ajax : null,
	m_contextPath : null,
	
	m_noteAmount : 0,
	m_mailAmount : 0,
	
	m_deco : null,
	
	m_editable : true,
	
	setEditable : function(editable){
		this.m_editable = editable;
	},
	
	isEditable : function(){
		return this.m_editable;
	},
	
	getDeco	:	function()	{
		return this.m_deco;
	},

	newNoteAmount : function () {
		$.ajax({
			type: 'POST',
			url: this.m_contextPath + '/note/newNote.hanc',
			dataType: 'html',
			success: function(html, textStatus){
				$('#newNoteAmount').text(html);
			},
			error: function(e){
				alert('error: ' + e.status + '\n잠시 후에 다시 시도 해주십시오.');
			}
		});
	},
	
	newMailAmount : function () {
//		/*강릉원주대 메일 카운트 */
//		$.ajax({
//			type: 'POST',
//			url: this.m_contextPath + '/gwnu/getUserInfo.gwnu?m=mail',
//			dataType: 'json',
//			success: function(data, textStatus){
//				$('#newMailAmount').text(data.mailCount);
//			},
//			error: function(e){
//				//alert('error: ' + e.status + '\n잠시 후에 다시 시도 해주십시오.');
//			}
//		});
	},
	
	go2Login : function () {
		this.m_parent.login();
	},
	go2Mail : function() {
		alert('준비중입니다');
		/*	메일 서버 API 구현
			window.open(this.m_contextPath + '/note/note.hanc','note');
		*/
	},
	go2Note : function(userIdNm) {
		window.open(this.m_contextPath + '/note/note.hanc','note' + userIdNm);
	},
	go2Jigi : function () {
		if(cfEach.m_isMobile) {
			alert('모바일(스마트폰, 테블릿피시 등)에서는 일부 카페 기능(관리, 꾸미기 기능 등)을 지원하지 않습니다.');
		}
		else {
			var frm = document.goJigiForm;
			frm.action = this.m_contextPath+"/cafe/" + frm.cmntUrl.value;
			frm.submit();
		}
	},
	go2EditPage : function (curCafeUrl) {
		if(cfEach.isAppliableBrowser()){
			var cafeUrl = this.m_parent.m_curCafeUrl;
			if(curCafeUrl !== undefined && curCafeUrl !== null && curCafeUrl !== 'null')  cafeUrl = curCafeUrl;
			var frm = document.getElementById('goEditPage');
			frm.action = this.m_contextPath + '/cafe/' + cafeUrl;
			frm.submit();
		}
	},
	showMyInfo : function (flag) {
		if (flag == "true") {
			this.newNoteAmount();
			this.newMailAmount();
			var elm = $('#div_cafe_info_myInfo');
			if (elm.css('display') == "none"){
				elm.css('display', 'block');
				$('#myinfo_arrow').css('background-image','url(' + this.m_contextPath + '/cola/cafe/images/each/encafe/info/ic_hide.gif)');
				$('#myinfo_arrow2').text('▲');
			}
			else {
				elm.css('display', 'none');
				$('#myinfo_arrow').css('background-image','url(' + this.m_contextPath + '/cola/cafe/images/each/encafe/info/ic_view.gif)');
				$('#myinfo_arrow2').text('▼');
			}
		} else {
			alert("로그인 하셔야 합니다.");
		}
	},
	showProfile : function () {
		var infoBox = cfEach.getInfoBox();
		infoBox.m_target = "cntt";
		infoBox.m_cmd = "showProfile";
		cfEach.sendCommand (infoBox);
	},
	popupLogin : function () { 
		
	},
	regCmntMmbr : function () {
		var infoBox = cfEach.getInfoBox();
		infoBox.m_target = "cntt";
		infoBox.m_cmd = "regCmntMmbr";
		cfEach.sendCommand (infoBox);
	},
	showUpdMyInfo : function () {
		var infoBox = cfEach.getInfoBox();
		infoBox.m_target = "cntt";
		infoBox.m_cmd = "showUpdMyInfo";
		cfEach.sendCommand (infoBox);
	},
	resignCafe : function () {
		if (!confirm ("정말 탈퇴하시겠습니까?")) return;
		var param = "m=setResignCafe";
		param += "&cafeUrl=" + this.m_parent.m_curCafeUrl;
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/each.cafe", param, true, {success: function(data) { cfInfo.resignCafeHandler(data); }});
	},
	resignCafeHandler : function (data) {
		alert("정상적으로 탈퇴 처리 되었습니다.");
		var frm = document.info_form;
		frm.target = "_top";
		frm.action = this.m_contextPath+"/cafe/" + this.m_parent.m_curCafeUrl;
		frm.submit();
	},
	changeMode : function () {
		/*
		$('#edit_menu_bar').css('display','block');
		var infoBox = cfEach.getInfoBox();
		infoBox.m_on = "client";
		infoBox.m_target = "all";
		infoBox.m_cmd = "changeMode";
		cfEach.m_isEditMode = true;
		cfEach.sendCommand(infoBox);
		
		document.getElementById("remoteLayer").innerHTML = "";
		var param = "m=uiGGum";
		param += "&cmd=" + "panel";
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/editor.cafe", param, true, {success: function(htmlData) {
			var remoteLayer = document.getElementById("remoteLayer");
			//var x = document.innerWidth - (222 + 10);
			//alert("document.innerWidth=["+document.innerWidth+"]");
			var x = 800;
			remoteLayer.style.left = x + "px";
			remoteLayer.style.top  = "60px";
			remoteLayer.style.display = "";
			remoteLayer.innerHTML = htmlData;
			
			cfGGum.initGGum();
		}});
		*/
	},
	
	initMaskPanel : function (){
	},
	
	executeCommand : function (infoBox) {
		if (infoBox.m_on == "client") {
			if (infoBox.m_cmd == "changeMode") {
				/*
				$('#cafe_info_wrap').unbind('mouseover.mask');
				$('#cafe_info_wrap').unbind('mouseout.mask');
				$('#cafe_info_wrap').bind('mouseover.mask', function(){
					var width = $('#cafe_info_wrap').css('width');
					var height = $('#cafe_info_wrap').css('height');
					$('#cafeinfo_mask').css('width', width);
					$('#cafeinfo_mask').css('height', height);
					$('#cafeinfo_mask_layer').css('width', width);
					$('#cafeinfo_mask_layer').css('height', height);
					$('#cafeinfo_mask').css('top', ebUtil.getAbsTop('cafe_info_wrap')-2);
					$('#cafeinfo_mask').css('left', ebUtil.getAbsLeft('cafe_info_wrap')-2);
					$('#cafeinfo_mask').css('display','block');
				})
				.bind('mouseout.mask', function(){
					$('#cafeinfo_mask').css('display','none');
				});
				
				$('#cafeinfo_mask').unbind('click.mask');
				if(this.m_editable) {
					$('#cafeinfo_mask').bind('click.mask', function(){
						cfEach.openRemoteController('info', 'CF0301');
					});
				}
				*/
			} 
			// 꾸미기에서  무언가 변화가 있을 때
			else if (infoBox.m_cmd == "deco") {
				// 랜더링 하기 전에 인포박스에서 넘어온 deco의 class 정보들을 자기 영역 deco들에게 복사
				if(infoBox.m_isOrg == 'true'){
					this.m_deco.setDecoPrefsOrg(ebUtil.clone(infoBox.m_decoPrefs));
				}
				this.m_deco.setDecoPrefs(infoBox.m_decoPrefs);
				this.m_deco.rendering();
			}
//			else if (infoBox.m_cmd == "") {
//				
//			}
		} else {
			var param = "m=info";
			this.m_ajax.send("POST", this.m_contextPath+"/cafe/each.cafe", param, true, {success: function(htmlData) { cfInfo.executeCommandHandler(htmlData); }});
		}
	},
	executeCommandHandler : function (htmlData) {
		document.getElementById("div_cafe_info").innerHTML = htmlData;
	}
}
cafe.each.menu = function (parent) {
	this.m_parent = parent;
	this.m_ajax = parent.getAjax();
	this.m_contextPath = parent.m_contextPath;
	
	this.m_deco	= new cafe.each.Deco(this);
	this.m_deco.setDecoType("CF04");
}
cafe.each.menu.prototype = {
	m_parent : null,
	m_ajax : null,
	m_contextPath : null,
	isShow : true,
	m_deco : null,
	
	m_editable : true,
	
	setEditable : function(editable){
		this.m_editable = editable;
	},
	
	isEditable : function(){
		return this.m_editable;
	},

	getDeco	:	function()	{
		return this.m_deco;
	},
	
	selectMenu : function (menuId, boardId) {
		var infoBox = cfEach.getInfoBox();
		infoBox.m_target = "cntt";
		infoBox.m_cmd = "selectMenu";
		infoBox.m_menuId = menuId;
		infoBox.m_boardId = boardId;
		cfEach.sendCommand (infoBox);
		cfCntt.setMenuId(menuId);
		$('.cafe_menu_link').each(function(){
			var $this = $(this);
			//if(boardId == $this.attr('boardId')){
			if(menuId == $this.attr('menuId')){
				$this.addClass('cafe_menu_selected');
			}else{
				$this.removeClass('cafe_menu_selected');
			}
		});
	},
	showOrHideAllCafeMenu : function() {
		if (this.isShow) {
			$('#ul_cafe_menu').children(':not(#li_cafe_menu)').each(function() {
				$this = $(this);
				$this.css('display', 'none');
			});
			$('#arrow_all').text('▼');
			this.isShow = false;
		} else if(!this.isShow) {
			$('#ul_cafe_menu').children(':not(#li_cafe_menu)').each(function() {
				$this = $(this);
				$this.css('display', 'inherit');
			});
			$('#arrow_all').text('▲');
			this.isShow = true;
		}
	},
	showOrHideMenuGroup : function(objId) {
		var isShow = $('#isShow_' + objId).val();
		if (isShow == 'true') {
			$('.cafe_menu_row[parentId=' + objId + ']').each(function() {
				$this = $(this);
				$this.css('display', 'none');
			});
			$('#arrow_' + objId).text('▼');
			$('#isShow_' + objId).val('false');
		} else if(isShow == 'false') {
			$('.cafe_menu_row[parentId=' + objId + ']').each(function() {
				$this = $(this);
				$this.css('display', 'block');
			});
			$('#arrow_' + objId).text('▲');
			$('#isShow_' + objId).val('true');
		}
	},
	executeCommand : function (infoBox) {
		if (infoBox.m_on == "client") {
			if (infoBox.m_cmd == "changeMode") {
				/*
				$('#cafe_menu_wrap').unbind('mouseover.mask');
				$('#cafe_menu_wrap').unbind('mouseout.mask');
				$('#cafe_menu_wrap').bind('mouseover.mask', function(){
					var width = $('#cafe_menu_wrap').css('width');
					var height = $('#cafe_menu_wrap').css('height');
					$('#cafemenu_mask').css('width', width);
					$('#cafemenu_mask').css('height', height);
					$('#cafemenu_mask_layer').css('width', width);
					$('#cafemenu_mask_layer').css('height', height);
					$('#cafemenu_mask').css('top', ebUtil.getAbsTop('cafe_menu_wrap')-2);
					$('#cafemenu_mask').css('left', ebUtil.getAbsLeft('cafe_menu_wrap')-2);
					$('#cafemenu_mask').css('display','block');
				})
				.bind('mouseout.mask', function(){
					$('#cafemenu_mask').css('display','none');
				});
				
				$('#cafemenu_mask').unbind('click.mask');
				if(this.m_editable) {
					$('#cafemenu_mask').bind('click.mask', function(){
						cfEach.openRemoteController('menu', 'CF0401');
					});
				}
				*/
			} 
			// 꾸미기에서  무언가 변화가 있을 때
			else if (infoBox.m_cmd == "deco") {
				// 랜더링 하기 전에 인포박스에서 넘어온 deco의 class 정보들을 자기 영역 deco들에게 복사
				if(infoBox.m_isOrg == 'true'){
					this.m_deco.setDecoPrefsOrg(ebUtil.clone(infoBox.m_decoPrefs));
				}
				this.m_deco.setDecoPrefs(infoBox.m_decoPrefs);
				this.m_deco.rendering();
			}
//			else if (infoBox.m_cmd == "") {
//				
//			}
		} else {
			var param = "m=menu";
			this.m_ajax.send("POST", this.m_contextPath+"/cafe/each.cafe", param, true, {success: function(htmlData) { cfMenu.executeCommandHandler(htmlData); }});
		}
	},
	executeCommandHandler : function (htmlData) {
		document.getElementById("div_cafe_menu").innerHTML = htmlData;
	}
}
cafe.each.cntt = function (parent) {
	this.m_parent = parent;
	this.m_ajax = parent.getAjax();
	this.m_contextPath = parent.m_contextPath;
	this.m_profile = new cafe.each.cntt.profile(this);
	this.m_updMyInfo = new cafe.each.cntt.updMyInfo(this);
	
	this.m_deco	= new cafe.each.Deco(this);
	this.m_deco.setDecoType("CF05");
	this.m_frameIds = new Array();
}
cafe.each.cntt.prototype = {
	m_parent : null,
	m_ajax : null,
	m_contextPath : null,
	m_profile : null,
	m_curInfoBox : null,
	m_deco : null,
	
	m_frameIds : null,
	m_menuId : null,
	
	m_editable : true,
	
	setEditable : function(editable){
		this.m_editable = editable;
	},
	
	isEditable : function(){
		return this.m_editable;
	},

	getDeco	:	function()	{
		return this.m_deco;
	},
	goEachHome : function() {
		var frm = document.cntt_form;
		if( frm !=null) {
			frm.target = "_top";
			frm.action = this.m_contextPath+"/cafe/" + this.m_parent.m_curCafeUrl;
			frm.submit();
		} else {
			window.open( this.m_contextPath+"/cafe/" + this.m_parent.m_curCafeUrl, '_top');
		}
		
	},
	
	setMenuId : function(menuId){
		this.m_menuId = menuId;
	},
	
	initBntlList : function () {
		$('.bltnList').each(function(){
			var boardURL = $(this).val();
			var param = "";
			var id = $(this).parent().attr('id');
			cfCntt.m_ajax.send("POST", boardURL, param, true, {success: function(htmlData) { cfCntt.initBntlListHandler(htmlData, id); }});
		});
	},
	
	initBntlListHandler : function(htmlData, id){
		$('#' + id).html(htmlData);
		this.initDecoPrefs();
	},
	
	initDecoPrefs : function(frameId){
		var cnttInfoBox = cfEach.getInfoBox();
		cnttInfoBox.m_on = "client";
		cnttInfoBox.m_target = "cntt";
		cnttInfoBox.m_cmd = "deco";
		cnttInfoBox.m_decoPrefs = eval("(" + $('#cnttDecoPrefs').val() + ")");
		cnttInfoBox.m_isOrg = 'true';
		
		if(frameId) cnttInfoBox.m_frameId = frameId;
		cfEach.sendCommand(cnttInfoBox);
		
		var orgDecoId = cfCntt.getDeco().getOrgDecoPrefValue('CF0501_template');
		$('#CF0501_template').val(orgDecoId);
	},
	
	initCafeHomeLayout : function(){
		if(cfEach.m_frameType.indexOf('THREE') >= 0){
			switch(cfEach.m_frameType){
				case 'THREE1':
					break;
				case 'THREE2':
					$('#cafe_cntt_wrap').parent().parent().parent().css('margin-left', '7px');
					break;
				case 'THREE3': 
					break;
				case 'THREE4':
					$('#cafe_cntt_wrap').parent().parent().parent().css('margin-left', '7px');
					break;
				default: break;
			}
		}
	},
	
	initBoardLayout : function(){
		if(cfEach.m_frameType.indexOf('THREE') >= 0){
			switch(cfEach.m_frameType){
				case 'THREE1': case 'THREE2':
					$('#cafe_cntt_wrap').parent().parent().parent().css('width','739px');
					$('#cafe_cntt_wrap').parent().parent().parent().parent().children('.column').last().css('display','none');
					break;
				case 'THREE3':
					$('#cafe_cntt_wrap').parent().parent().parent().css('width','739px');
					$('#cafe_cntt_wrap').parent().parent().parent().parent().children('.column').first().css('display','none');
					break;
				case 'THREE4':
					$('#cafe_cntt_wrap').parent().parent().parent().css('margin-left', '0px');
					$('#cafe_cntt_wrap').parent().parent().parent().css('width','739px');
					$('#cafe_cntt_wrap').parent().parent().parent().parent().children('.column').first().css('display','none');
					break;
				default: break;
			}
		}
	},
	
	readBulletin : function (boardId, bltnNo, readable) {
		if(readable == false) {
			alert('작성자가 글읽기를 허용하지 않았습니다.');
			return;
		}
		var infoBox = cfEach.getInfoBox();
		infoBox.m_target  = "cntt";
		if (boardId != null) infoBox.m_boardId = boardId;
		if (bltnNo  != null) infoBox.m_bltnNo  = bltnNo;
		infoBox.m_frameType = cfEach.m_frameType;
		cfEach.sendCommand (infoBox);
	},
	
	saveOnList : function (brdIndex, curBoardId){
		var cmd = "WRITE";
		var userNick = $('#userNick_' + brdIndex).val();
		var bltnSubj = $('#bltnSubj_' + brdIndex).val();
		var bltnCntt = $('#editorCntt_' + brdIndex).val();

		if (document.getElementById("editorCnttMaxBytes_" + brdIndex)) { // 입력제한값이 있으면...
			var maxLen = eval(document.getElementById("editorCnttMaxBytes_" + brdIndex).value);
			if( ebUtil.byteLength(bltnCntt) > maxLen) {
				alert("최대 "+document.getElementById("editorCnttMaxBytes_" + brdIndex).value+" Byte까지 입력하실 수 있습니다.");
				return;
			}
		}
	
		if (bltnCntt == "<br />" || bltnCntt == "&nbsp;") bltnCntt = ""; // 아무것도 입력안해도 FCKeditor가 디폴트로 '<br />' 또는 '&nbsp;'를 넣어준다. 
		
		var param = "boardId=" + curBoardId + "&cmd=" + cmd + "&userNick=" + userNick + "&bltnSubj=" + bltnSubj + "&bltnCntt=" + bltnCntt + "&listOpt=cafeHome";
		this.m_ajax.send("POST", this.m_contextPath+"/board/save.brd", param, true, {success: function(htmlData) {
			document.getElementById('errorMessage').innerHTML = htmlData;
			if($('#reason').attr('id')) {
				var tmp = $('#reason').val();
				var errorMsgs = '';
				if(tmp.indexOf("&lt;br&gt;") > -1){
					errorMsgs = tmp.split("&lt;br&gt;");
				}
				else if(tmp.indexOf("<br>") > -1){
					errorMsgs = tmp.split("<br>");
				}
				var errorMsg = '';
				for(var i = 0 ; i < errorMsgs.length ; i++){
					tmp = errorMsgs[i];
					if(tmp != ''){
						errorMsg  += tmp + '\n';
					}
				}
				alert(errorMsg);
			}
			else cfCntt.saveOnListHandler(htmlData, curBoardId);
		}});
		
	},
	
	saveOnListHandler : function(htmlData, curBoardId){
		var boardURL = this.m_contextPath + "/board/list.brd";
		$('.cntt_MEMO_' + curBoardId).each(function(){
			var param = "boardId=" + curBoardId + "&listOpt=cafeHome";
			var id = $(this).attr('id');
			var brdIndex = id;
			$("." + id + "_boardParam").each(function(){
				param += "&" + $(this).attr('name') + "=" + $(this).val();
			});
			param += "&brdIndex=" + brdIndex;
			cfCntt.m_ajax.send("POST", boardURL, param, true, {success: function(htmlData) { 
				cfCntt.initBntlListHandler(htmlData, id); 
			}});
		});
	},
	
	actionBulletin : function(action, id){
		var boardDom = document.getElementById("cafeBoardFrame").contentWindow.document;
		var submitButton = $("#submit_" + id, boardDom);
		var cancelButton = $("#cancel_" + id, boardDom);
		var control = $("#memo_control_" + id, boardDom);
		var memo_cntt = $("#memo_cntt_" + id, boardDom);

		$('.memo_control', boardDom).css('display', 'block');
		$('.memo_cntt', boardDom).css('display', 'block');
		
		
		switch(action){
			case 'reply-init-memo': submitButton.html("등록");	control.css('display', 'none');
			var replyForm =  $("#memoReplyForm_" + id, boardDom);
			replyForm.find("textarea").focus();
			break;
			case 'modify-init-memo':submitButton.html("수정");	control.css('display', 'none');	memo_cntt.css('display', 'none'); break;
			case 'cancel-memo':		control.css('display', 'block');	memo_cntt.css('display', 'block'); break;
			default: break;
		}
	},
	
	toggleAttach : function(){
		var fileList = $('#cafeBoardFrame').contents().find('#read_attach_fileList');
		
		var toggle = fileList.css('display');
		if(toggle == 'block') {
			fileList.css('display','none');
			cfCntt.autoResize('cafeBoardFrame');
		}
		else if(toggle == 'none') {
			fileList.css('display','block');
			cfCntt.autoResize('cafeBoardFrame');
		}
	},
	
	toggleMemoView : function(){
		var read_memo = $('#cafeBoardFrame').contents().find('#read_memo');
		var toggle = read_memo.css('display');
		if(toggle == 'block') {
			read_memo.css('display','none');
		}
		else if(toggle == 'none') {
			read_memo.css('display','block');
		}
		
		var write_memo = $('#cafeBoardFrame').contents().find('#write_memo');
		var toggle2 = write_memo.css('display');
		if(toggle2 == 'block') {
			write_memo.css('display','none');
		}
		else if(toggle2 == 'none') {
			write_memo.css('display','block');
		}
		cfCntt.autoResize('cafeBoardFrame');
	},
	
	autoResize : function(frameId) {
		if (! document.getElementById (frameId)) {
			return;
		}
		
		try {
				if (document.getElementById(frameId).contentWindow.document.getElementById("smarteditor")) {	//스마트에디터인 경우
					document.getElementById(frameId).height = (450 + 550) + "px";
				} else {
					arg = document.getElementById (frameId);
					var ht = arg.contentWindow.document.documentElement.scrollHeight;
					arg.height = ht;
				}
		} catch(e) {
			arg.height = 600;
		}
			//document.getElementById ("frameId").width  = document.getElementById("frameId").contentWindow.document.body.scrollWidth;
			/*
			var height = 185; // 400;
			//document.getElementById ("frameId").width  = document.getElementById("frameId").contentWindow.document.body.scrollWidth;
			if (document.getElementById(frameId).contentWindow.document.getElementById("smarteditor")) {	//스마트에디터인 경우
				document.getElementById(frameId).height = (height + 50) + "px";
			} else {
				document.getElementById(frameId).height = (height + 10) + "px";	
			}
			cfCntt.initDecoPrefs(frameId);
			*/
		
	},
	
	onfocusBltnSubj : function(){
		var bltnSubj = $('#cafeBoardFrame').contents().find('#bltnSubj');
		var bltnSubjCheck = $('#cafeBoardFrame').contents().find('#bltnSubjCheck');
		
		if(bltnSubjCheck.val() == 'N'){
			bltnSubj.val('');
		}else {
			bltnSubj.css('color','black');
		}
	},
	
	onblurBltnSubj : function(){
		var bltnSubj = $('#cafeBoardFrame').contents().find('#bltnSubj');
		var bltnSubjCheck = $('#cafeBoardFrame').contents().find('#bltnSubjCheck');
		
		if(bltnSubj.val().length > 0) {
			bltnSubj.css('color','black');
			bltnSubjCheck.val('Y');
		}
		else {
			bltnSubj.val('제목을 입력해주세요');
			bltnSubj.css('color','gray');
			bltnSubjCheck.val('N');
		}
	},
	
	onkeydownBltnSubj : function(){
		var bltnSubj = $('#cafeBoardFrame').contents().find('#bltnSubj');
		
		if(bltnSubj.val().length > 0) {
			bltnSubj.css('color','black');
		}
		else {
			bltnSubj.css('color','gray');
		}
	},
	
	checkBltn : function(){
		var bltnSubjCheck = $('#cafeBoardFrame').contents().find('#bltnSubjCheck');
		if(bltnSubjCheck.val() == 'N') {
			alert('제목을 입력해주세요');
			return false;
		}
		else {
			return true;
		}
	},
	
	executeCommand : function (infoBox) {
		this.m_curInfoBox = infoBox;
		if (infoBox.m_on == "client") {
			if (infoBox.m_cmd == "changeMode") {
				/*
				$('#cafe_cntt_wrap').unbind('mouseover.mask');
				$('#cafe_cntt_wrap').unbind('mouseout.mask');
				$('#cafe_cntt_wrap').bind('mouseover.mask', function(){
					var width = $('#cafe_cntt_wrap').css('width');
					var height = $('#cafe_cntt_wrap').css('height');
					$('#cafecntt_mask').css('width', width);
					$('#cafecntt_mask').css('height', height);
					$('#cafecntt_mask_layer').css('width', width);
					$('#cafecntt_mask_layer').css('height', height);
					$('#cafecntt_mask').css('top', ebUtil.getAbsTop('cafe_cntt_wrap')-2);
					$('#cafecntt_mask').css('left', ebUtil.getAbsLeft('cafe_cntt_wrap')-2);
					$('#cafecntt_mask').css('display','block');
				})
				.bind('mouseout.mask', function(){
					$('#cafecntt_mask').css('display','none');
				});
				$('#cafecntt_mask').unbind('click.mask');
				if(this.m_editable) {
					$('#cafecntt_mask').bind('click.mask', function(){
						cfEach.openRemoteController('board');
					});
				}
			*/
			} 
			// 꾸미기에서  무언가 변화가 있을 때
			else if (infoBox.m_cmd == "deco") {
				// 랜더링 하기 전에 인포박스에서 넘어온 deco의 class 정보들을 자기 영역 deco들에게 복사
				if(infoBox.m_isOrg == 'true'){
					this.m_deco.setDecoPrefsOrg(ebUtil.clone(infoBox.m_decoPrefs));
				}
				this.m_deco.setDecoPrefs(infoBox.m_decoPrefs);
				this.m_deco.rendering(null, infoBox.m_frameId);
			}
		} else {
			if (infoBox.m_cmd == "searchCafe"){
				cfCntt.initBoardLayout();
				var param = "m=cntt";
				param += "&caller=" + infoBox.m_caller;
				param += "&cmd=" + infoBox.m_cmd;
				param += "&view=" + infoBox.m_view;
				param += "&act=" + infoBox.m_act;
				param += "&cafeUrl=" + this.m_parent.m_curCafeUrl;
				param += "&bltnNo=" + infoBox.m_bltnNo;
				param += "&srchType=" + infoBox.m_srchType; 
				param += "&srchKey=" + encodeURIComponent(infoBox.m_srchKey);
				this.m_ajax.send("POST", this.m_contextPath+"/cafe/each.cafe", param, true, {success: function(htmlData) { 
					cfCntt.executeCommandHandler(htmlData); 
					cfCntt.initBntlList();
				}});
			} else if(infoBox.m_cmd == "saveOnList") {
				cfCntt.initBoardLayout();
				var param = "m=cntt";
				param += "&caller=" + infoBox.m_caller;
				param += "&cmd=" + infoBox.m_cmd;
				param += "&view=" + infoBox.m_view;
				param += "&act=" + infoBox.m_act;
				param += "&menuId=" + infoBox.m_menuId;
				param += "&cafeUrl=" + this.m_parent.m_curCafeUrl;
				param += "&boardId=" + infoBox.m_boardId;
				param += "&cntt=" + infoBox.m_cntt;
				this.m_ajax.send("POST", this.m_contextPath+"/cafe/each.cafe", param, true, {success: function(htmlData) { 
					cfCntt.executeCommandHandler(htmlData);
					cfCntt.initDecoPrefs();
				}});
			} else {
				cfCntt.initBoardLayout();
				var param = "m=cntt";
				param += "&caller=" + infoBox.m_caller;
				param += "&cmd=" + infoBox.m_cmd;
				param += "&view=" + infoBox.m_view;
				param += "&act=" + infoBox.m_act;
				param += "&menuId=" + infoBox.m_menuId;
				param += "&cafeUrl=" + this.m_parent.m_curCafeUrl;
				param += "&boardId=" + infoBox.m_boardId;
				param += "&bltnNo=" + infoBox.m_bltnNo;
				this.m_ajax.send("POST", this.m_contextPath+"/cafe/each.cafe", param, true, {success: function(htmlData) { 
					cfCntt.executeCommandHandler(htmlData);
					cfCntt.initDecoPrefs();
				}});
			}
		}
	},
	executeCommandHandler : function (htmlData) {
		document.getElementById("cafe_cntt_wrap").innerHTML = htmlData;
	
		if (this.m_curInfoBox.m_cmd == "showProfile") {
			$(function() {
				//$("#cafeProfileTabs").tabs();
			});
			cfCntt.m_profile.m_curTabId = null; // 본판부터 다시 호출될때는 초기화해주어야 한다.
			cfCntt.m_profile.selectTab(0);
		}

		//****************************************************************************************************
		// GATE 영역은 개별카페홈에 접근할 때만 노출되므로, 컨텐츠영역이 갱신되면 무조건 GATE 영역을 제거한다.
		//----------------------------------------------------------------------------------------------------
		var infoBox = cfEach.getInfoBox();
		infoBox.m_target = "gate";
		infoBox.m_on     = "client";
		infoBox.m_cmd    = "clearArea";
		cfEach.sendCommand (infoBox);
		//----------------------------------------------------------------------------------------------------
		// BUGA 영역들은 개별카페홈에 접근할 때만 노출되므로, 컨텐츠영역이 갱신되면 무조건 BUGA 영역들을 제거한다. 
		//----------------------------------------------------------------------------------------------------
		var infoBox = cfEach.getInfoBox();
		infoBox.m_target = "buga";
		infoBox.m_on     = "client";
		infoBox.m_cmd    = "clearArea";
		cfEach.sendCommand (infoBox);
		//----------------------------------------------------------------------------------------------------
		// 또한, CNTT 영역의 너비와 enView Layout 의 float 속성을 상황에 따라 맞추어준다.
		//----------------------------------------------------------------------------------------------------
		var divCntt = document.getElementById("cafe_cntt_wrap");
		// divCntt.style.width = "739px";
		var frameType = divCntt.getAttribute("frameType");
		if (frameType == "THREE2") {
			var parentId = divCntt.parentNode.parentNode.parentNode.parentNode.id;
			$("#"+parentId).css("margin","0px 0px 0px 7px");
		} else if (frameType == "THREE3") {
			var parentId = divCntt.parentNode.parentNode.parentNode.parentNode.id;
			$("#"+parentId).css("float","left");
		}
		//****************************************************************************************************
	},
	
	dupCheckUserNick : function(elm) {
		if (elm.value.length == 0) return;
		if (document.getElementById("userNickRslt").innerHTML != "") return;
		if (!ebUtil.chkValue(document.getElementById("userNick"), "닉네임을", "ture")) return;

		var param = "m=dupCheckUserNick";
		param += "&cafeUrl=" + $('#cafeUrl').val();
		param += "&userId=" + $('#userId').val();
		param += "&userNick=" + $('#userNick').val();
		this.m_ajax.send( "POST", this.m_contextPath+"/cafe/each.cafe", param, true, {success: function(data) { cfCntt.dupCheckUserNickHandler(data); }});
	},
	dupCheckUserNickHandler : function(data) {
		if (data.ReasonCd == "cf.error.already.used.usernick") {
			var htmlStr = ebUtil.getMessage(data.ReasonCd);
			$("#userNickRslt").html(htmlStr);
			$("#userNickRslt").addClass("warning");
			$('#userNickValidted').val(false);
		} else {
			$("#userNickRslt").html(ebUtil.getMessage(data.ReasonCd));
			$("#userNickRslt").removeClass("warning");
			$('#userNickValidted').val(true);
		}
	},
	dupCheckUserNickReset : function() {
		$("#userNickRslt").html("");
		$('#userNickValidted').val(false);
	}
}
cafe.each.cntt.profile = function (parent) {
	this.m_parent = parent;
	this.m_ajax = parent.m_ajax;
	this.m_contextPath = parent.m_contextPath;
}
cafe.each.cntt.profile.prototype = {
	m_parent : null,
	m_ajax : null,
	m_contextPath : null,
	m_curTabId : null,
	
	selectTab : function (tabId) {
		if (this.m_curTabId == tabId ) return;
		this.m_curTabId = tabId;
		
		$('.tabLabel').css('background-color', 'transparent');
		$('.tabLabel').css('border-color', 'transparent');
		$('.tabLabel').removeClass('CF0802_extraBgColor');
		$('.tabLabel').removeClass('CF0501_nmBrdrColor');
		$('.tabLabel').removeClass('selected');
		$('.tabLabel').each(function(index){
			if(index == tabId){
				$(this).addClass('CF0802_extraBgColor');
				$(this).addClass('CF0501_nmBrdrColor');
				$(this).addClass('selected');
			}
		});
		
		var param = "m=cntt";
		param += "&cmd=showProfile";
		param += "&cafeUrl=" + this.m_parent.m_parent.m_curCafeUrl;
		switch (tabId) {
			case 0: param += "&view=base"; break;
			case 1: param += "&view=rule"; break;
			//case 2: param += "&view=hist"; break;
			//case 3: param += "&view=rank"; break;
			case 2: param += "&view=staff"; break;
		}
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/each.cafe", param, true, {success: function(htmlData) { cfCntt.m_profile.selectTabHandler(htmlData); }});
	},
	selectTabHandler : function (htmlData) {
		document.getElementById("cafeProfileTabContents").innerHTML = htmlData;
		cfCntt.initDecoPrefs();
		$('.tabLabel').css('border-bottom-color', 'transparent');
	}
}
cafe.each.cntt.updMyInfo = function (parent) {
	this.m_parent = parent;
	this.m_ajax = parent.m_ajax;
	this.m_contextPath = parent.m_contextPath;
}
cafe.each.cntt.updMyInfo.prototype = {
	m_parent : null,
	m_ajax : null,
	m_contextPath : null,
	
	update : function () {
		if (!ebUtil.chkValue (document.getElementById("userNick"), "닉네임을", "true")) return;
		var param = "m=setMyInfo";
		param += "&cafeUrl="  + this.m_parent.m_parent.m_curCafeUrl;
		param += "&userNick=" + document.getElementById("userNick").value;
		param += "&openId="   + ebUtil.getSelectedValue (document.getElementById("umInfo_openId"));
		param += "&openNm="   + ebUtil.getSelectedValue (document.getElementById("umInfo_openNm"));
		param += "&openSex="  + ebUtil.getSelectedValue (document.getElementById("umInfo_openSex"));
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/each.cafe", param, true, {success: function(data) { cfCntt.m_updMyInfo.updateHandler(data); }});
	},
	updateHandler : function (data) {
		alert (ebUtil.getMessage("ev.info.success.update"));
		this.m_parent.goEachHome();
	},
	cancel : function () {
		this.m_parent.goEachHome();
	}
}

cafe.each.srch = function (parent) {
	this.m_parent = parent;
	this.m_ajax = parent.getAjax();
	this.m_contextPath = parent.m_contextPath;
	
	this.m_deco	= new cafe.each.Deco(this);
	this.m_deco.setDecoType("CF06");
}
cafe.each.srch.prototype = {
	m_parent : null,
	m_ajax : null,
	m_contextPath : null,
	
	m_deco : null,
	
	m_srchType : "Cntt,Atch,Subj,Nick",
	m_srchKey : null,

	m_editable : true,
	
	setEditable : function(editable){
		this.m_editable = editable;
	},
	
	isEditable : function(){
		return this.m_editable;
	},

	getDeco	:	function()	{
		return this.m_deco;
	},
	
	search : function(){
		if( event.keyCode == undefined || event.keyCode == null || event.keyCode == 13){
			this.m_srchType = "Cntt,Atch,Subj,Nick";
			this.m_srchKey = $('#CF0601_srchKey').val();
			
			var infoBox = cfEach.getInfoBox();
			infoBox.m_target = "cntt";
			infoBox.m_cmd = "searchCafe";
			infoBox.m_srchType = this.m_srchType;
			infoBox.m_srchKey = this.m_srchKey;
			cfEach.sendCommand (infoBox);
			$('.cafe_menu_link').each(function(){
				$(this).removeClass('cafe_menu_selected');
			});
		}
	},
	executeCommand : function (infoBox) {
		if (infoBox.m_on == "client") {
			if (infoBox.m_cmd == "changeMode") {
				/*
				 $('#cafe_srch_wrap').unbind('mouseover.mask');
				$('#cafe_srch_wrap').unbind('mouseout.mask');
				$('#cafe_srch_wrap').bind('mouseover.mask', function(){
					var width = parseInt($('#cafe_srch_wrap').css('width').replace('px',''));
					var height = parseInt($('#cafe_srch_wrap').css('height').replace('px',''));
					$('#cafesrch_mask').css('width', width+2);
					$('#cafesrch_mask').css('height', height+2);
					$('#cafesrch_mask_layer').css('width', width);
					$('#cafesrch_mask_layer').css('height', height);
					$('#cafesrch_mask').css('top', ebUtil.getAbsTop('cafe_srch_wrap')-2);
					$('#cafesrch_mask').css('left', ebUtil.getAbsLeft('cafe_srch_wrap')-2);
					$('#cafesrch_mask').css('display','block');
				})
				.bind('mouseout.mask', function(){
					$('#cafesrch_mask').css('display','none');
				});
				
				$('#cafesrch_mask_layer').unbind('click.mask');
				if(this.m_editable) {
					$('#cafesrch_mask_layer').bind('click.mask', function(){
						cfEach.openRemoteController('srch', 'CF0601');
					});
				}
				*/
			} 
			// 꾸미기에서  무언가 변화가 있을 때
			else if (infoBox.m_cmd == "deco") {
				// 랜더링 하기 전에 인포박스에서 넘어온 deco의 class 정보들을 자기 영역 deco들에게 복사
				if(infoBox.m_isOrg == 'true'){
					this.m_deco.setDecoPrefsOrg(ebUtil.clone(infoBox.m_decoPrefs));
				}
				this.m_deco.setDecoPrefs(infoBox.m_decoPrefs);
				this.m_deco.rendering();
			}
//			else if (infoBox.m_cmd == "") {
//				
//			}
		} else {
			var param = "m=srch";
			this.m_ajax.send("POST", this.m_contextPath+"/cafe/each.cafe", param, true, {success: function(htmlData) { cfSrch.executeCommandHandler(htmlData); }});
		}
	},
	executeCommandHandler : function (htmlData) {
		document.getElementById("div_cafe_srch").innerHTML = htmlData;
	}	
}

cafe.each.buga = function (parent) {
	this.m_parent = parent;
	this.m_ajax = parent.getAjax();
	this.m_contextPath = parent.m_contextPath;
	
	this.m_deco	= new cafe.each.Deco(this);
	this.m_deco.setDecoType("CF07");
}
cafe.each.buga.prototype = {
	m_parent : null,
	m_ajax : null,
	m_contextPath : null,
	
	m_deco : null,

	m_editable : true,
	
	setEditable : function(editable){
		this.m_editable = editable;
	},
	
	isEditable : function(){
		return this.m_editable;
	},


	getDeco	:	function()	{
		return this.m_deco;
	},
	executeCommand : function (infoBox) {
		if (infoBox.m_on == "client") {
			if (infoBox.m_cmd == "clearArea") {
				$("div[id^='div_cafe_buga']").html("");
			}
		}
	}
}
cafe.each.Util = function () {}
cafe.each.Util.prototype = {
	//********************************************************************************************************
	// getAttrOfObjectFromOA (ObjectArray)
	// - 여러 속성을 가진 JSon 객체를 요소로 하는 배열에서,
	//   keyNm 속성이 keyVal을 가진 객체의 val2Find 속성의 값을 찾아 리턴한다.
	// 2012.05.14.KWShin.Saltware.
	//********************************************************************************************************
	getAttrOfObjectFromOA : function (objArray, keyNm, keyVal, val2Find) {
		for (var i=0; i<objArray.length; i++) {
			if (eval("objArray[i]."+keyNm) == keyVal) {
				return eval("objArray[i]."+val2Find);
			}
		}
		return null;
	},
	//********************************************************************************************************
	// setAttrOfObjectToOA (ObjectArray)
	// - 여러 속성을 가진 JSon 객체를 요소로 하는 배열에서,
	//   keyNm 속성이 keyVal을 가진 객체의 valNm 속성의 값을 valVal로 치환한다.
	// 2012.05.15.KWShin.Saltware.
	//********************************************************************************************************
	setAttrOfObjectToOA : function (objArray, keyNm, keyVal, valNm, valVal) {
		for (var i=0; i<objArray.length; i++) {
			if (eval("objArray[i]."+keyNm) == keyVal) {
				eval("objArray[i]."+valNm+" = '"+valVal+"'");
				return;
			}
		}
	},
	//********************************************************************************************************
	// remObjByAttrFromOA (ObjectArray)
	// - 여러 속성을 가진 JSon 객체를 요소로 하는 배열에서,
	//   keyNm 속성이 keyVal을 가진 객체를 찾아 제거하고, 제거된 객체를 리턴한다.
	// 2012.05.15.KWShin.Saltware.
	//********************************************************************************************************
	remObjByAttrFromOA : function (objArray, keyNm, keyVal) {
		for (var i=0; i<objArray.length; i++) {
			if (eval("objArray[i]."+keyNm) == keyVal) {
				return (objArray.splice(i,1))[0]; // remove and return;
			}
		}
	},
	//********************************************************************************************************
	// spliceObjByAttrInTwoOA
	// - 여러 속성을 가진 JSon 객체를 요소로 하는 배열 두 개에서,
	//   frOA 에서 frKeyNm 속성이 frKeyVal을 가진 객체를 찾아 복사해서,
	//   toOA 에서 toKeyNm 속성이 toKeyVal을 가진 객체에 치환한다.
	// 2012.05.16.KWShin.Saltware.
	//********************************************************************************************************
	spliceObjByAttrInTwoOA : function (frOA, frKeyNm, frKeyVal, toOA, toKeyNm, toKeyVal) {
		var frObject = null;
		for (var i=0; i<frOA.length; i++) {
			if (eval("frOA[i]."+frKeyNm) == frKeyVal) {
				frObject = ebUtil.clone(frOA[i]);
				break;
			}
		}
		var ok = false;
		if (frObject != null) {
			for (var i=0; i<toOA.length; i++) {
				if (eval("toOA[i]."+toKeyNm) == toKeyVal) {
					toOA.splice (i, 1, frObject);
					ok = true;
					break;
				}
			}
			if(!ok) {
//				alert( JSON.stringify( frObject));
				toOA.push( frObject);
			}
		}
	},
	//********************************************************************************************************
	// cafe.each.Deco.m_decoPrefs 에 할당되는 배열의 요소 객체의 값을 찾아준다.
	//********************************************************************************************************
	getValueOfClass : function (objArray, keyVal) {
		return this.getAttrOfObjectFromOA (objArray, "clazz", keyVal, "value");
	},
	//********************************************************************************************************
	// cafe.each.Deco.m_decoPrefs 에 할당되는 배열의 요소 객체의 값을 치환한다.
	//********************************************************************************************************
	setValueOfClass : function (objArray, keyVal, valVal) {
		this.setAttrOfObjectToOA (objArray, "clazz", keyVal, "value", valVal);
	},
	//********************************************************************************************************
	// cafe.each.Deco.m_decoPrefs 에 할당되는 배열의 요소 객체를 찾아 배열에서 제거한다.
	//********************************************************************************************************
	remObjByClass : function (objArray, keyVal) {
		return this.remObjByAttrFromOA (objArray, "clazz", keyVal);
	},
	//********************************************************************************************************
	// cafe.each.Deco.m_decoPrefs 에 할당되는 배열들 사이에서,
	// frOA의 요소 객체를 복사해서 toOA의 요소 객체에 치환한다.
	//********************************************************************************************************
	substitueObjByClass : function (frOA, frKeyVal, toOA, toKeyVal) {
		this.spliceObjByAttrInTwoOA (frOA, "clazz", frKeyVal, toOA, "clazz", frKeyVal);
	}
}

var cfEach	= new cafe.each();
var cfEdit  = cfEach.getEditMngr  (cfEach);
var cfSkin	= cfEach.getSkinMngr  (cfEach);
var cfBg 	= cfEach.getCafeBgMngr(cfEach);
var cfTitle = cfEach.getTitleMngr (cfEach);
var cfGate  = cfEach.getGateMngr  (cfEach);
var cfInfo  = cfEach.getInfoMngr  (cfEach);
var cfMenu  = cfEach.getMenuMngr  (cfEach);
var cfSrch  = cfEach.getSrchMngr  (cfEach);
var cfCntt  = cfEach.getCnttMngr  (cfEach);
var cfBuga  = cfEach.getBugaMngr  (cfEach);

$(document).ready(function(){
	if(cfEach.m_isEditMode){
		$('#edit_menu_bar').css('display','block');
		$('#cafe_main').css('margin-top', '5px');
		$('body').bind('click.editBar', function(){
			if(cfEdit.isHide()){
				cfEdit.viewAni();
			}else{
				var curScroll = cfEdit.getCurScroll();
				if(curScroll.Y > 40){
					cfEdit.hideAni();
				}
			}
		});
		$('body').unbind('click.editBar');
		
		document.getElementById("remoteLayer").innerHTML = "";
		var param = "m=uiGGum";
		param += "&cmd=" + "panel";
		param += "&cafeUrl=" + cfEach.m_curCafeUrl;
		cfGGum.m_ajax.send("POST", cfGGum.m_contextPath+"/cafe/editor.cafe", param, true, {success: function(htmlData) {
			var remoteLayer = document.getElementById("remoteLayer");
			var x = (window.innerWidth == undefined ? document.body.clientWidth : window.innerWidth) - (222 + 30); // 222: GGum mini의 넓이, 30: 스크롤바 넓이 및 여백
			remoteLayer.style.left = x + "px";
			remoteLayer.style.top  = "60px";
			remoteLayer.style.display = "";
			remoteLayer.innerHTML = htmlData;
			
			cfGGum.initGGum();
			cfEach.initMaskPanel();
			
			var cafeName = $('#title_cafeName').html();
			$(document).attr('title', cafeName + ' - enCafe');
		}});
	}
	else {
		cfEach.initCafeInfo();
	}
});


$(window).resize(function() {
	if(cfEach.m_isEditMode){
		$('#edit_menu_bar').css('display','block');
	}
});


window.onunload = function(){
	if(cfEach.m_isEditMode && cfEach.m_isEdited){
		cfGGum.onClickApply();
	}
};


$(window).scroll(function(){
	var curScroll = cfEdit.getCurScroll();
	if(curScroll.Y == 0){
		cfEdit.view();
	}else if(curScroll.Y > 0){
		cfEdit.hide();
	}
});
