if( ! window.hancer )
    window.hancer = new Object();

if( ! window.hancer.admin )
    window.hancer.admin = new Object();

if( ! window.hancer.admin.manager )
    window.hancer.admin.manager = new Object();

if( ! window.hancer.admin.app )
    window.hancer.admin.app = new Object();

if( ! window.hancer.admin.skin )
    window.hancer.admin.skin = new Object();

hancer.admin.manager = function() {
	this.m_ajax = new enview.util.Ajax();
}

hancer.admin.manager.prototype = {
	m_contextPath : null,
	m_ajax : null,
	
	m_logoutUrl : null,
	
	m_target : null,
	
	/************************************
	 **** 공통 기능
	 ************************************/
	logoutUrl : function(logoutUrl){
		if (logoutUrl == undefined) return this.m_logoutUrl;
		else this.m_logoutUrl = logoutUrl;
	},
	
	searchType : function(searchType){
		if(searchType == undefined) return this.m_target.m_searchType;
		else {
			if(searchType == null || isNaN(searchType)){
				this.m_target.m_currentPage.m_searchType = 0;
			}
			else this.m_target.m_searchType = searchType;
			return this.m_target.m_searchType;
		}
	},
	
	searchValue : function(searchValue){
		if(searchValue == undefined) return this.m_target.m_searchValue;
		else {
			if(searchValue == null) this.m_target.m_searchValue = '';
			else this.m_target.m_searchValue = searchValue;
			return this.m_target.m_searchValue;
		}
	},
	
	//로그아웃
	logout : function(){
		location.href = this.logoutUrl();
	},

	//홈
	goHome : function(){
		location.href = enManager.m_contextPath;
	},
	
	setTarget : function(obj){
		this.m_target = obj;
	},
	
	getTarget : function() {
		return this.m_target;
	},
	
	//체크박스 모두 선택/해제
	checkAll : function(id, name){
		if(!name) name = id;
		var $checkboxs = $('input[name=' + name + ']');
		if($('#' + id).is(':checked')){
			$checkboxs.prop('checked', true);
		}else{
			$checkboxs.removeAttr('checked');
		}
	},
	
	getSelectedAppId : function(){
		var appId = -1;
		$('input[name=appCheck]').each(function(){
			var $this = $(this);
			if($this.is(':checked')) appId = $this.attr('id');
		}); 
		return appId;
	},
	
	getSelectedSkinId : function(){
		var skinId = -1;
		$('input[name=skinCheck]').each(function(){
			var $this = $(this);
			if($this.is(':checked')) skinId = $this.attr('id');
		}); 
		return skinId;
	},
	
	goPage : function(page) {
		this.m_target.m_currentPage = page;
		this.m_target.uiList();
	},
	
	firstPage : function(){
		this.m_target.m_currentPage = 1;
		this.m_target.uiList();
	},
	
	lastPage :function(){
		this.m_target.m_currentPage = this.m_target.m_currentPage.m_lastPage;
		this.m_target.uiList();
	},
	
	prevPage : function(){
		this.m_target.m_currentPage = this.m_target.m_currentPage.m_prevPage;
		this.m_target.m_currentPage.m_prevPage = this.m_target.m_currentPage - 1;
		if(this.m_target.m_currentPage.m_currentPage < 1) this.m_target.m_currentPage.m_currentPage = 1;
		if(this.m_target.m_currentPage.m_prevPage < 1) this.m_target.m_currentPage.m_prevPage = 1;
		this.m_target.m_currentPage.uiList();
	},
	
	nextPage : function(){
		this.m_target.m_currentPage.m_currentPage = this.m_target.m_currentPage.m_nextPage;
		this.m_target.m_currentPage.m_nextPage = this.m_target.m_currentPage.m_currentPage + 1;
		if(this.m_target.m_currentPage.m_currentPage > this.m_target.m_currentPage.m_lastPage) this.m_target.m_currentPage.m_currentPage = this.m_target.m_currentPage.m_lastPage;
		if(this.m_target.m_currentPage.m_nextPage > this.m_target.m_currentPage.m_lastPage) this.m_target.m_currentPage.m_nextPage = this.m_target.m_currentPage.m_lastPage;
		this.uiList();
	},
	
	prev10Page : function(){
		this.m_target.m_currentPage.m_currentPage = this.m_target.m_currentPage.m_currentPrevPage;
		this.m_target.m_currentPage.m_currentPrevPage = this.m_target.m_currentPage.m_currentPage - 10;
		if(this.m_target.m_currentPage.m_currentPage < 1) this.m_target.m_currentPage.m_currentPage = 1;
		if(this.m_target.m_currentPage.m_currentPrevPage < 1) this.m_target.m_currentPage.m_currentPrevPage = 1;
		this.m_target.m_currentPage.uiList();
	},
	
	next10Page : function(){
		this.m_target.m_currentPage.m_currentPage = this.m_target.m_currentPage.m_currentNextPage;
		this.m_target.m_currentPage.m_currentNextPage = this.m_target.m_currentPage.m_currentPage + 10;
		if(this.m_target.m_currentPage.m_currentPage > this.m_target.m_currentPage.m_lastPage) this.m_target.m_currentPage.m_currentPage = this.m_target.m_currentPage.m_lastPage;
		if(this.m_target.m_currentPage.m_currentNextPage > this.m_target.m_currentPage.m_lastPage) this.m_target.m_currentPage.m_currentNextPage = this.m_target.m_currentPage.m_lastPage;
		this.m_target.m_currentPage.uiList();
	},
	
	reload : function(){
		this.m_target.m_currentPage.m_currentPage = 1;
		this.m_target.m_currentPage.uiList();
	}
	
}

hancer.admin.app = function() {
}
hancer.admin.app.prototype = {
	m_searchType : 0,
	m_searchValue : '',
	
	m_currentPage : 1,
	m_prevPage : 1,
	m_nextPage : 2,
	
	m_lastPage : 1,
	
	m_currentPrevPage : 1,
	m_currentNextPage : 11,
	
	m_work : null,
	
	uiList : function(){
		$('#searchType').val() == undefined ? this.m_searchType = 0 : this.m_searchType = $('#searchType').val();
		$('#searchValue').val() == undefined ? this.m_searchValue = '' : this.m_searchValue = $('#searchValue').val();
		var param = "currentPage=" + this.m_currentPage;
		param += "&searchType=" + this.m_searchType;
		param += "&searchValue=" + this.m_searchValue;
		enManager.m_ajax.send("POST", enManager.m_contextPath + "/hancer/appList.hanc", param, true, {success: function(htmlData) { 
			$('#appList').html(htmlData);
			enApp.selectApp(0);
		}});
	},
	
	goPage : function(page) {
		enManager.setTarget(this);
		enManager.goPage();
	},
	
	firstPage : function(){
		enManager.setTarget(this);
		enManager.firstPage();
	},
	
	lastPage :function(){
		enManager.setTarget(this);
		enManager.lastPage();
	},
	
	prevPage : function(){
		enManager.setTarget(this);
		enManager.prevPage();
	},
	
	nextPage : function(){
		enManager.setTarget(this);
		enManager.nextPage();
	},
	
	prev10Page : function(){
		enManager.setTarget(this);
		enManager.prev10Page();
	},
	
	next10Page : function(){
		enManager.setTarget(this);
		enManager.next10Page();
	},
	
	reload : function(){
		enManager.setTarget(this);
		enManager.reload();
	},
	
	//검색으로 인해 페이지가 재로딩 될 때 검색된 값을 유지하여 각 box에 해당 값을 설정해주는 함수
	initSeachForm : function(type, value){
		if(type == 0) return false;
		else {
			enManager.setTarget(this);
			$('#searchType').val(enManager.searchType(type));
			$('#searchValue').val(enManager.searchValue(value));
			$('#searchValue').focus();
		}
	},
	
	//검색 함수
	searchApps : function(){
		if(event && event.keyCode != 13 && event.keyCode != 0) return false;
		enManager.setTarget(this);
		var searchType = $('#searchType').val();
		var searchValue = $('#searchValue').val();

//		if(searchType == undefined || searchType == null || searchType == 0){
//			alert('검색할 값을 선택해주세요.');
//			$('#searchType').focus();
//			return false;
//		}
//		if(searchValue == undefined || searchValue == null || searchValue == ''){
//			alert('검색할 값을 입력해주세요.');
//			$('#searchValue').select();
//			return false;
//		}
//		if(searchValue.length < 2){
//			alert('검색 할 값은 두글자 이상을 입력해주세요.');
//			$('#searchValue').select();
//			return false;
//		}
		var param = "searchType=" + searchType;
		param += "&searchValue=" + searchValue;
		enManager.m_ajax.send("POST", enManager.m_contextPath + "/hancer/appList.hanc", param, true, {success: function(htmlData) { 
			$('#appList').html(htmlData);
			enApp.selectApp(0);
		}});
	},
	
	/************************************
	 **** App CRUD 기능
	 ************************************/
	//App 삽입 폼
	uiInsertForm : function(){
		var param = "appId=-1";
		enManager.m_ajax.send("POST", enManager.m_contextPath + "/hancer/detailApp.hanc", param, true, {success: function(htmlData) { 
			$('#AppManager_DetailTabPage').html(htmlData);
			enApp.m_work = 'insert';
			$('#appCode').removeAttr('readonly');
		}});
	},

	//App 삭제
	deleteApps: function(){
		var appIds = ''; 
		$('input[name=appCheck]:checked').each(function(){
			var $this = $(this);
			appIds += $this.attr('id') + ',';
		});
		if(appIds == ''){ 
			alert('어플리케이션을 선택하세요.'); 
			return;
		}
		if(!confirm("선택된 어플리케이션들을 삭제하시겠습니까?")) return;
		appIds = appIds.substring(0, appIds.length-1);
		var param = "appIds=" + appIds;
		enManager.m_ajax.send("POST", enManager.m_contextPath + "/hancer/deleteApps.hanc", param, true, {success: function(htmlData) {
			enApp.uiList();
			alert('어플리케이션이 삭제되었습니다.');
		}});
	},

	//App 정보 추가/변경
	updateApp : function(){
		var work = '';
		if(this.m_work == 'insert') work = '추가';
		else if(this.m_work == 'update') work = '변경'; 
		
		var appId = $('#appId');
		var appVersion = $('#appVersion');
		var appLangKnd = $('#appLangKnd');
		var appName = $('#appName');
		var appCode = $('#appCode');
		var appDescription = $('#appDescription');
		var skinId = $('#skinList').val();
		
		if(appVersion.val() == ''){
			alert('어플리케이션 버전을 입력하세요');
			skinName.select();
			return;
		}
		/*
		else if(appLangKnd.val() == ''){
			alert('어플리케이션 명 언어를 선택하세요');
			skinPath.select();
			return false;
		}*/
		else if(appName.val() == ''){
			alert('어플리케이션 이름을 입력하세요');
			appName.select();
			return;
		}
		/*
		else if(appDescription.val() == ''){
			alert('설명을 선택하세요');
			appDescription.select();
			return;
		}
		 */		
		else if(appCode.val() == ''){
			alert('어플리케이션 코드를 입력하세요');
			appCode.select();
			return;
		}
		
		if(!confirm(work + " 하시겠습니까?")) return;
		
		var param = "appId=" + appId.val();
		param += "&version=" + appVersion.val();
		param += "&appLangKnd=" + appLangKnd.val();
		param += "&appName=" + appName.val();
		param += "&description=" + appDescription.val();
		if(this.m_work != 'insert') param += "&skinId=" + skinId;
		if(this.m_work == 'insert') param += "&appCode=" + appCode.val();
		enManager.m_ajax.send("POST", enManager.m_contextPath + "/hancer/" + this.m_work + "App.hanc", param, true, {success: function(htmlData) {
			enApp.uiList();
			alert('어플리케이션이 ' + work +'되었습니다.');
		}});
	},

	//App 선택
	selectApp : function(listOrder){
		$('input[name=appCheck]').removeAttr('checked');
		$('input[name=appCheck]').eq(listOrder).prop('checked', true);
		enApp.m_work = 'update';
		this.detailApp();
		enSkin.uiList();
	},
	
	//App 정보 보기
	detailApp : function(appId) {
		if(this.m_work == 'update'){
			var param = "appId=" + enManager.getSelectedAppId();
			param += "&langKnd=" + ($('#appLangKnd').val() == undefined ? 'ko': $('#appLangKnd').val());
			enManager.m_ajax.send("POST", enManager.m_contextPath + "/hancer/detailApp.hanc", param, true, {success: function(htmlData) { 
				$('#AppManager_DetailTabPage').html(htmlData);
			}});
		}
	}
	
}

if( ! window.hancer.admin.skin )
    window.hancer.admin.skin = new Object();


hancer.admin.skin = function() {
}
hancer.admin.skin.prototype = {
	m_searchType : 0,
	m_searchValue : '',
	
	m_currentPage : 1,
	m_prevPage : 1,
	m_nextPage : 2,
	
	m_lastPage : 1,
	
	m_currentPrevPage : 1,
	m_currentNextPage : 11,
	
	m_work : null,
	
	uiList : function(){
		$('#skinSearchValue').val() == undefined ? this.m_searchValue = '' : this.m_searchValue = $('#skinSearchValue').val();
		var param = "currentPage=" + this.m_currentPage;
		param += "&searchType=" + this.m_searchType;
		param += "&searchValue=" + this.m_searchValue;
		
		
		param += "&appId=" + enManager.getSelectedAppId();
		enManager.m_ajax.send("POST", enManager.m_contextPath + "/hancer/skinList.hanc", param, true, {success: function(htmlData) { 
			$('#AppManager_SkinTabPage').html(htmlData);
			enSkin.selectSkin(0);
		}});
	},
	
	goPage : function(page) {
		enManager.setTarget(this);
		enManager.goPage();
	},
	
	firstPage : function(){
		enManager.setTarget(this);
		enManager.firstPage();
	},
	
	lastPage :function(){
		enManager.setTarget(this);
		enManager.lastPage();
	},
	
	prevPage : function(){
		enManager.setTarget(this);
		enManager.prevPage();
	},
	
	nextPage : function(){
		enManager.setTarget(this);
		enManager.nextPage();
	},
	
	prev10Page : function(){
		enManager.setTarget(this);
		enManager.prev10Page();
	},
	
	next10Page : function(){
		enManager.setTarget(this);
		enManager.next10Page();
	},
	
	reload : function(){
		enManager.setTarget(this);
		enManager.reload();
	},
	
	//검색으로 인해 페이지가 재로딩 될 때 검색된 값을 유지하여 각 box에 해당 값을 설정해주는 함수
	initSeachForm : function(type, value){
		if(type == 0) return false;
		else {
			enManager.setTarget(this);
			$('#skinSearchType').val(enManager.searchType(type));
			$('#skinSearchValue').val(enManager.searchValue(value));
			$('#skinSearchValue').focus();
		}
	},

	//검색 함수
	searchSkins : function(){
		if(event && event.keyCode != 13 && event.keyCode != 0) return;
		enManager.setTarget(this);
		var searchType = $('#skinSearchType').val();
		var searchValue = $('#skinSearchValue').val();

//		if(searchType == undefined || searchType == null || searchType == 0){
//			alert('검색할 값을 선택해주세요.');
//			$('#skinSearchType').focus();
//			return;
//		}
//		if(searchValue == undefined || searchValue == null || searchValue == ''){
//			alert('검색할 값을 입력해주세요.');
//			$('#skinSearchValue').select();
//			return;
//		}
//		if(searchValue.length < 2){
//			alert('검색 할 값은 두글자 이상을 입력해주세요.');
//			$('#skinSearchValue').select();
//			return;
//		}
		var param = "searchType=" + searchType;
		param += "&searchValue=" + searchValue;
		param += "&appId=" + enManager.getSelectedAppId();
		enManager.m_ajax.send("POST", enManager.m_contextPath + "/hancer/skinList.hanc", param, true, {success: function(htmlData) { 
			$('#AppManager_SkinTabPage').html(htmlData);
			enSkin.initSeachForm(searchType, searchValue);
			enSkin.selectSkin(0);
		}});
	},

	/************************************
	 **** CRUD 기능
	 ************************************/
	//skin 삽입 폼
	uiInsertForm : function(){
		var param = "skinId=-1";
		enManager.m_ajax.send("POST", enManager.m_contextPath + "/hancer/detailSkin.hanc", param, true, {success: function(htmlData) { 
			$('#detail').html(htmlData);
			enSkin.m_work = 'insert';
		}});
	},

	//skin 삭제
	deleteSkins: function(){
		var skinIds = ''; 
		var skinCheck = $('input[name=skinCheck]:checked');
		if(skinCheck.length == 0){ 
			alert('스킨을 선택하세요.'); 
			return;
		}
		skinCheck.each(function(index){
			var $this = $(this);
			skinIds += $this.attr('id');
			if(index < skinCheck.length) skinIds += ',';
		});
		if(!confirm("선택된 스킨들을 삭제하시겠습니까?")) return;
		skinIds = skinIds.substring(0, skinIds.length-1);
		var param = "skinIds=" + skinIds;
		enManager.m_ajax.send("POST", enManager.m_contextPath + "/hancer/deleteSkins.hanc", param, true, {success: function(htmlData) {
			enSkin.uiList();
			alert('스킨이 삭제되었습니다.');
		}});
	},

	//skin 정보 추가/변경
	updateSkin : function(){
		var work = '';
		if(this.m_work == 'insert') work = '추가';
		else if(this.m_work == 'update') work = '변경'; 
		
		var skinId = $('#skinId');
		var skinName = $('#skinName');
		var skinPath = $('#skinPath');
		var isAlloweds = document.getElementsByName('isAllowed');
		var isAllowed = 0;
		for(var i = 0; i < isAlloweds.length ; i++){
			if($(isAlloweds[i]).attr('checked')){
				isAllowed = $(isAlloweds[i]).val();
				break;
			}
		}
		
		if(skinName.val() == ''){
			alert('스킨명을 입력하세요');
			skinName.select();
			return false;
		}
		else if(skinPath.val() == ''){
			alert('스킨 경로를 선택하세요');
			skinPath.select();
			return false;
		}
		
		if(!confirm(work + " 하시겠습니까?")) return;
		
		var param = "skinId=" + skinId.val();
		param += "&skinName=" + skinName.val();
		param += "&skinPath=" + skinPath.val();
		param += "&isAllowed=" + isAllowed;
		param += "&appId=" + enManager.getSelectedAppId();
		
		enManager.m_ajax.send("POST", enManager.m_contextPath + "/hancer/" + this.m_work + "Skin.hanc", param, true, {success: function(htmlData) {
			enSkin.uiList();
			alert('스킨이 ' + work +'되었습니다.');
		}});
	},

	//skin 선택
	selectSkin : function(listOrder){
		$('input[name=skinCheck]').removeAttr('checked');
		$('input[name=skinCheck]').eq(listOrder).prop('checked', true);
		this.detailSkin();
	},
	
	//skin 정보 보기
	detailSkin : function() {
		var param = "skinId=" + enManager.getSelectedSkinId();
		param += "&currentPage=" + $('#currentPage').val();
		enManager.m_ajax.send("POST", enManager.m_contextPath + "/hancer/detailSkin.hanc", param, true, {success: function(htmlData) { 
			$('#detail').html(htmlData);
			enSkin.m_work = 'update';
		}});
	}
}
	
	
/************************************
 **** 메인 함수
 ************************************/
//쪽지 관리 초기화 jquery 함수
$(document).ready(function(){
	var propertyTabs = $("#AppManager_propertyTabs").tabs();
	
	//초기에는 스킨 리스트를 보여준다.
	enApp.uiList();
	
	//html 키 이벤트 핸들러 등록: F2 키를 누르면 검색필드로 focus 이동하여 바로 입력 할 수 있다.
	$('html').keyup(function(){
		if(event.keyCode == 113){ //f2 key
			$('#searchValue').focus();
		}
	});
});

var enManager = new hancer.admin.manager();
var enApp = new hancer.admin.app();
var enSkin = new hancer.admin.skin();
