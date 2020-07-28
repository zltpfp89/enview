if( ! window.hancer )
    window.hancer = new Object();

if( ! window.hancer.rss )
    window.hancer.rss = new Object();


hancer.rss = function() {
	this.m_ajax = new enview.util.Ajax();
}
hancer.rss.prototype = {
	m_contextPath : '',
	m_ajax : null,
	
	m_logoutUrl : null,
	
	m_selectedTab : 'detail',
	
	/************************************
	 **** 공통 기능
	 ************************************/
	logoutUrl : function(logoutUrl){
		if (logoutUrl == undefined) return this.m_logoutUrl;
		else this.m_logoutUrl = logoutUrl;
	},
	
	contextPath : function(contextPath){
		if(contextPath){
			this.m_contextPath = contextPath;
		}
		else {
			if(this.m_contextPath == null) this.m_contextPath = '';
		}
		enFeed.m_contextPath = this.m_contextPath;
		enEntry.m_contextPath = this.m_contextPath;
		return this.m_contextPath;
	},
	
	domain : function(domainId){
		this.m_domainId = domainId;
	},
	
	getDomain : function(){
		return this.m_domainId;
	},
	
	//로그아웃
	logout : function(){
		location.href = this.logoutUrl();
	},

	//홈
	goHome : function(){
		location.href = this.m_contextPath;
	},

	//체크박스 모두 선택/해제
	checkAll : function(className){
		var $checkAll = $('#checkAll.' + className);
		var $checkboxs = $('input:checkbox.' + className);
		
		if($checkAll.is(':checked')){
			$checkboxs.prop('checked', true);
		}else{
			$checkboxs.removeAttr('checked');
		}
	},
	
	getSeletecFeedId : function(){
		$('.feedCheck').each(function(){
			var $this = $(this);
			if($this.is(':checked')) enFeed.m_selectedFeedId = $this.attr('id');
		});
		return enFeed.m_selectedFeedId;
	}
}

hancer.rss.feed = function(parent) {
	this.m_parent = parent;
	this.m_ajax = parent.m_ajax;
	this.m_contextPath = parent.m_contextPath;
	
	this.m_listUrl	 =	"/hancer/rss/requestFeedList.hanc",
	this.m_detailUrl =	"/hancer/rss/detailRequestFeed.hanc";
	this.m_updateUrl =	"/hancer/rss/updateRequestFeed.hanc";
	this.m_acceptUrl =	"/hancer/rss/acceptFeed.hanc";
	this.m_acceptCancelUrl = "/hancer/rss/acceptCancelFeed.hanc";
	this.m_denyUrl	 =	"/hancer/rss/denyFeed.hanc";
	
	this.m_cateListUrl =	"/hancer/rss/categoryListForAjax.hanc";
}
hancer.rss.feed.prototype = {
	m_parent : null,
	m_logoutUrl : null,
	
	m_contextPath : null, 
	
	m_listUrl : null,
	m_detailUrl : null,
	m_updateUrl : null,
	m_acceptUrl : null,
	m_acceptCancelUrl : null,
	m_denyUrl : null,
	
	m_selectedFeedId : -1,
	
	m_searchType : 0,
	m_searchValue : '',
	
	m_currentPage : 1,
	m_prevPage : 1,
	m_nextPage : 2,
	
	m_currentPrevPage : 1,
	m_currentNextPage : 11,
	
	m_lastPage : 1,
	
	m_domainId : -1,
	
	searchType : function(searchType){
		if(searchType == undefined) return this.m_searchType;
		else {
			if(searchType == null || isNaN(searchType)){
				this.m_searchType = 0;
			}
			else this.m_searchType = searchType;
			return this.m_searchType;
		}
	},
	
	searchValue : function(searchValue){
		if(searchValue == undefined) return this.m_searchValue;
		else {
			if(searchValue == null) this.m_searchValue = '';
			else this.m_searchValue = searchValue;
			return this.m_searchValue;
		}
	},
	
	goPage : function(page) {
		this.m_currentPage = page;
		this.uiList();
	},
	
	firstPage : function(){
		this.m_currentPage = 1;
		this.uiList();
	},
	
	lastPage :function(){
		this.m_currentPage = this.m_lastPage;
		this.uiList();
	},
	
	prevPage : function(){
		this.m_currentPage = this.m_prevPage;
		this.m_prevPage = this.m_currentPage - 1;
		if(this.m_prevPage < 1) this.m_prevPage = 1;
		this.uiList();
	},
	
	nextPage : function(){
		this.m_currentPage = this.m_nextPage;
		this.m_nextPage = this.m_currentPage + 1;
		if(this.m_nextPage > this.m_lastPage) this.m_nextPage = this.m_lastPage;
		this.uiList();
	},
	
	prev10Page : function(){
		this.m_currentPage = this.m_currentPrevPage;
		this.m_currentPrevPage = this.m_currentPage - 10;
		if(this.m_currentPage < 1) this.m_currentPage = 1;
		if(this.m_currentPrevPage < 1) this.m_currentPrevPage = 1;
		this.uiList();
	},
	
	next10Page : function(){
		this.m_currentPage = this.m_currentNextPage;
		this.m_currentNextPage = this.m_currentPage + 10;
		if(this.m_currentPage > this.m_lastPage) this.m_currentPage = this.m_lastPage;
		if(this.m_currentNextPage > this.m_lastPage) this.m_currentNextPage = this.m_lastPage;
		this.uiList();
	},
	
	reload : function(){
		this.m_currentPage = 1;
		this.uiList();
	},
	
	//검색으로 인해 페이지가 재로딩 될 때 검색된 값을 유지하여 각 box에 해당 값을 설정해주는 함수
	initSeachForm : function(type, value){
		if(type == 0) return false;
		else {
			$('#searchType').val(this.searchType(type));
			$('#searchValue').val(this.searchValue(value));
			$('#searchValue').focus();
		}
	},
	
	//검색 함수
	search : function(){
		if(event && event.keyCode != 13 && event.keyCode != 0) return false;
		this.m_searchType = $('#searchType').val();
		this.m_searchValue = $('#searchValue').val();

//		if(this.m_searchType == undefined || this.m_searchType == null || this.m_searchType == 0){
//			alert('검색할 값을 선택해주세요.');
//			$('#searchType').focus();
//			return;
//		}
//		if(this.m_searchValue == undefined || this.m_searchValue == null || this.m_searchValue == ''){
//			alert('검색할 값을 입력해주세요.');
//			$('#searchValue').select();
//			return;
//		}
//		if(this.m_searchValue.length < 2){
//			alert('검색 할 값은 두글자 이상을 입력해주세요.');
//			$('#searchValue').select();
//			return;
//		}
		this.m_currentPage = 1;
		this.uiList();
	},
	
	setDomain : function(){
		this.m_domainId = $('#RssManager_domainCond').val();
	},
	
	uiList : function(){
		var param = "currentPage=" + this.m_currentPage;
		param += "&categoryId=" + this.m_searchType;
		param += "&searchValue=" + this.m_searchValue;
		param += "&domainId=" + this.m_domainId;
		this.m_ajax.send("POST", this.m_contextPath + this.m_listUrl, param, true, {success: function(htmlData) { 
			$('#list').html(htmlData);
			enFeed.select(0);
			$('#searchValue').select();
		}});
	},
	
	//Feed 삭제
	deletes: function(){
		var ids = ''; 
		$('input[name=feedCheck]').each(function(){
			var $this = $(this);
			if($this.is('checked')){
				ids += $this.attr('id') + ',';
			}
		});
		if(ids == ''){ 
			alert('Feed를 선택하세요.'); 
			return;
		}
		if(!confirm("선택된 Feed들을 삭제하시겠습니까?")) return;
		ids = ids.substring(0, ids.length-1);
		var param = "feedIds=" + ids;
		this.m_ajax.send("POST", this.m_contextPath + this.m_deleteUrl, param, true, {success: function(htmlData) {
			enFeed.uiList();
			alert('Feed가 삭제되었습니다.');
		}});
	},

	//Feed 정보 추가/변경
	update : function(){
		var feedId = $('#feedId');
		var categoryId = $('#categoryId');
		if(categoryId.val() == -1){
			alert('카테고리를 선택하세요.');
			categoryId.select();
			return;
		}
		if(!confirm("수정 하시겠습니까?")) return;
		
		
		var pg = $('#permittedList');
		var ids = '';
		
		pg.children().each(function(index){
			var $this = $(this);
			ids += $this.val() + ',';
		});
		ids = ids.substring(0, ids.length-1);
		
		var param = "id=" + feedId.val();
		param += "&categoryId=" + categoryId.val();
		param += "&permittedGroupIds=" + ids;
		this.m_ajax.send("POST", this.m_contextPath + this.m_updateUrl, param, true, {success: function(htmlData) {
			enFeed.uiList();
			alert(htmlData);
		}});
	},
	
	acceptRequest : function(){
		var feedId = $('#feedId');
		if(!confirm("승인 하시겠습니까?")) return;
		
		var param = "id=" + feedId.val();
		this.m_ajax.send("POST", this.m_contextPath + this.m_acceptUrl, param, true, {success: function(htmlData) {
			enFeed.uiList();
			alert(htmlData);
		}});
	},
	
	acceptCancelRequest : function(){
		var feedId = $('#feedId');
		if(!confirm("승인취소 하시겠습니까?")) return;
		
		var param = "id=" + feedId.val();
		this.m_ajax.send("POST", this.m_contextPath + this.m_acceptCancelUrl, param, true, {success: function(htmlData) {
			enFeed.uiList();
			alert(htmlData);
		}});
	},
	
	denyRequest : function(){
		var feedId = $('#feedId');
		if(!confirm("거절 하시겠습니까?")) return;
		
		var param = "id=" + feedId.val();
		this.m_ajax.send("POST", this.m_contextPath + this.m_denyUrl, param, true, {success: function(htmlData) {
			enFeed.uiList();
			alert(htmlData);
		}});
	},

	//Feed 선택
	select : function(listOrder){
		$('input[name=feedCheck]').removeAttr('checked');
		$('input[name=feedCheck]').eq(listOrder).prop('checked', true);
		if(enRss.m_selectedTab == 'detail'){
			this.detail();
		}else if(enRss.m_selectedTab == 'entryList'){
			enEntry.m_currentPage = 1;
			enEntry.uiList();
		}
	},
	
	detail : function(){
		enRss.m_selectedTab = 'detail';
		var param = "id=" + enRss.getSeletecFeedId();
		this.m_ajax.send("POST", this.m_contextPath + this.m_detailUrl, param, true, {success: function(htmlData) { 
			$('#RssManager_DetailTabPage').html(htmlData);
		}});
	},
	
	removeGroup : function (){
		var $selected = $('option:selected','#permittedList');
		$selected.appendTo('#unpardonedList');
		$selected.removeAttr('selected');
		
		var pg = $('#permittedList');
		var ids = '';
		
		pg.children().each(function(index){
			var $this = $(this);
			ids += $this.val() + ',';
		});
		ids = ids.substring(0, ids.length-1);
	},
	
	addGroup : function(){
		var $selected = $('option:selected','#unpardonedList');
		$selected.appendTo('#permittedList');
		$selected.removeAttr('selected');
		
		var ug = $('#unpardonedList');
		var ids = '';
		
		ug.children().each(function(index){
			var $this = $(this);
			ids += $this.val() + ',';
		});
		ids = ids.substring(0, ids.length-1);
	},
	
	initCategoryByDomain : function(){
		var param = "domainId=" + $('#domainId').val();
		this.m_ajax.send("POST", this.m_contextPath + this.m_cateListUrl, param, true, {success: function(htmlData) { 
			$('#categoryId').html(htmlData);
		}});
	}
}

hancer.rss.entry = function(parent) {
	this.m_parent = parent;
	this.m_ajax = parent.m_ajax;
	this.m_listUrl	 =	"/hancer/rss/requestEntryList.hanc";
}
hancer.rss.entry.prototype = {
	m_parent : null,
	m_contextPath : null,
	
	m_searchType : -1,
	m_searchValue : '',
	m_listCount : 10,
	
	m_currentPage : 1,
	m_prevPage : 1,
	m_nextPage : 2,
	
	m_currentPrevPage : 1,
	m_currentNextPage : 11,
	
	m_lastPage : 1,
	
	m_listUrl : null,
	
	goPage : function(page) {
		this.m_currentPage = page;
		this.uiList();
	},
	
	firstPage : function(){
		this.m_currentPage = 1;
		this.uiList();
	},
	
	lastPage :function(){
		this.m_currentPage = this.m_lastPage;
		this.uiList();
	},
	
	prevPage : function(){
		this.m_currentPage = this.m_prevPage;
		this.m_prevPage = this.m_currentPage - 1;
		if(this.m_prevPage < 1) this.m_prevPage = 1;
		this.uiList();
	},
	
	nextPage : function(){
		this.m_currentPage = this.m_nextPage;
		this.m_nextPage = this.m_currentPage + 1;
		if(this.m_nextPage > this.m_lastPage) this.m_nextPage = this.m_lastPage;
		this.uiList();
	},
	
	prev10Page : function(){
		this.m_currentPage = this.m_currentPrevPage;
		this.m_currentPrevPage = this.m_currentPage - 10;
		if(this.m_currentPage < 1) this.m_currentPage = 1;
		if(this.m_currentPrevPage < 1) this.m_currentPrevPage = 1;
		this.uiList();
	},
	
	next10Page : function(){
		this.m_currentPage = this.m_currentNextPage;
		this.m_currentNextPage = this.m_currentPage + 10;
		if(this.m_currentPage > this.m_lastPage) this.m_currentPage = this.m_lastPage;
		if(this.m_currentNextPage > this.m_lastPage) this.m_currentNextPage = this.m_lastPage;
		this.uiList();
	},
	
	reload : function(){
		this.m_currentPage = 1;
		this.uiList();
	},
	
	//검색 함수
	search : function(){
		if(event && event.keyCode != 13 && event.keyCode != 0) return false;
		this.m_searchType = $('#entrySearchType').val();
		this.m_searchValue = $('#entrySearchValue').val();
		this.m_currentPage = 1;
		this.uiList();
	},
	
	uiList : function(){
		enRss.m_selectedTab = 'entryList';
		var param = "currentPage=" + this.m_currentPage;
		param += "&searchValue=" + this.m_searchValue;
		param += "&listCount=" + ($('#entryListCount').val() ? $('#entryListCount').val() : 10);
		param += "&feedId=" + enRss.getSeletecFeedId();
		this.m_ajax.send("POST", this.m_contextPath + this.m_listUrl, param, true, {success: function(htmlData) {
			$('#RssManager_EntryListTabPage').html(htmlData);
		}});
	}
}
	
/************************************
 **** 메인 함수
 ************************************/
//쪽지 관리 초기화 jquery 함수
$(document).ready(function(){
	//초기에는 스킨 리스트를 보여준다.
	enFeed.uiList();
	
	//html 키 이벤트 핸들러 등록: F2 키를 누르면 검색필드로 focus 이동하여 바로 입력 할 수 있다.
	$('html').keyup(function(){
		if(event.keyCode == 113){ //f2 key
			$('#searchValue').focus();
		}
	});
});

var enRss = new hancer.rss();
var enFeed = new hancer.rss.feed(enRss);
var enEntry = new hancer.rss.entry(enRss);
