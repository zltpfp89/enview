if( ! window.hancer )
    window.hancer = new Object();

if( ! window.hancer.rss )
    window.hancer.rss = new Object();


hancer.rss = function() {
	this.m_ajax = new enview.util.Ajax();
}
hancer.rss.prototype = {
	m_contextPath : null,
	m_ajax : null,
	
	m_logoutUrl : null,
	
	m_selectedListTab : 'my',
	m_work : 'insert',
	
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
	
	this.m_listUrl	 =	"/rss/myFeedList.hanc",
	this.m_requestListUrl = "/rss/myRequestList.hanc",
	this.m_detailUrl =	"/rss/detailMyFeed.hanc";
	
	this.m_detailRequestUrl =	"/rss/myRequestFeed.hanc";
	this.m_insertUrl =	"/rss/addRequestFeed.hanc";
	this.m_updateUrl =	"/rss/updateRequestFeed.hanc";
	this.m_deleteUrl =	"/rss/deleteFeeds.hanc";
	
	this.m_subsUrl = "/rss/subscribe.hanc";
	this.m_cancelSubsUrl = "/rss/cancelSubscribe.hanc";
}
hancer.rss.feed.prototype = {
	m_parent : null,
	m_logoutUrl : null,
	
	m_contextPath : null, 
	
	m_listUrl : null,
	m_requestListUrl : null,
	m_detailUrl : null,
	
	m_detailRequestUrl : null,
	m_insertUrl : null,
	m_updateUrl : null,
	m_deleteUrl : null,
	
	m_subsUrl : null,
	m_cancelSubsUrl : null,
	
	m_selectedFeedId : -1,
	
	m_searchType : 0,
	m_searchValue : '',
	
	m_currentPage : 1,
	m_prevPage : 1,
	m_nextPage : 2,
	
	m_currentPrevPage : 1,
	m_currentNextPage : 11,
	
	m_lastPage : 1,
	
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
	
	//검색 함수
	search : function(){
		if(event && event.keyCode != 13 && event.keyCode != 0) return false;
		this.m_searchType = $('#searchType').val();
		this.m_searchValue = $('#searchValue').val();

		if(this.m_searchType == undefined || this.m_searchType == null || this.m_searchType == 0){
			alert('검색할 값을 선택해주세요.');
			$('#searchType').focus();
			return;
		}
		if(this.m_searchValue == undefined || this.m_searchValue == null || this.m_searchValue == ''){
			alert('검색할 값을 입력해주세요.');
			$('#searchValue').select();
			return;
		}
		if(this.m_searchValue.length < 2){
			alert('검색 할 값은 두글자 이상을 입력해주세요.');
			$('#searchValue').select();
			return;
		}
		this.m_currentPage = 1;
		this.uiList();
	},
	
	selectTab : function(tabName){
		enRss.m_selectedListTab = tabName;
		this.m_currentPage = 1;
		this.m_searchType = 0;
		this.m_searchValue = '';
		this.uiList();
	},
	
	uiList : function(){
		if(enRss.m_selectedListTab == 'my'){
			this.uiMyList();
		}else if(enRss.m_selectedListTab == 'request'){
			this.uiRequestList();
		}else{
			this.uiMyList();
		}
	},
	
	uiMyList : function(){
		var param = "currentPage=" + this.m_currentPage;
		param += "&categoryId=" + this.m_searchType;
		param += "&searchValue=" + this.m_searchValue;
		this.m_ajax.send("POST", this.m_contextPath + this.m_listUrl, param, true, {success: function(htmlData) {
			$('#RssManager_propertyTabs').css('display', 'block');
			$('#RssManager_requestFeedListPage').html('');
			$('#RssManager_myFeedListPage').html(htmlData);
			enFeed.select(0);
		}});
	},
	
	uiRequestList : function(){
		var param = "currentPage=" + this.m_currentPage;
		param += "&searchType=" + this.m_searchType;
		param += "&searchValue=" + this.m_searchValue;
		this.m_ajax.send("POST", this.m_contextPath + this.m_requestListUrl, param, true, {success: function(htmlData) {
			$('#RssManager_propertyTabs').css('display', 'block');
			$('#RssManager_myFeedListPage').html('');
			$('#RssManager_requestFeedListPage').html(htmlData);
			enFeed.select(0);
		}});
	},
	
	//Feed 삽입 폼
	uiForm : function(){
		var param = "feedId=-1";
		this.m_ajax.send("POST", this.m_contextPath + this.m_detailUrl, param, true, {success: function(htmlData) { 
			$('#RssManager_DetailTabPage').html(htmlData);
			enRss.m_work = 'insert';
		}});
	},
	
	//Feed 삽입 폼
	uiRequestForm : function(){
		var param = "feedId=-1";
		this.m_ajax.send("POST", this.m_contextPath + this.m_detailRequestUrl, param, true, {success: function(htmlData) { 
			$('#RssManager_DetailTabPage').html(htmlData);
			enRss.m_work = 'insert';
		}});
	},

	//Feed 신청 취소
	cancels: function(){
		var ids = ''; 
		$('input[name=feedCheck]:checked').each(function(){
			var $this = $(this);
			ids += $this.attr('id') + ',';
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

	//신청 Feed 정보 추가/변경
	update : function(){
		var work = '';
		var actionUrl = '';

		if( $('#feedId').val()=='-1') {
			enRss.m_work='insert';
		}
		
		if(enRss.m_work == 'insert') {
			work = '피드를 신청';
			actionUrl = this.m_insertUrl;
		}
		else if(enRss.m_work == 'update') {
			work = '피드신청 내용을 변경';
			actionUrl = this.m_updateUrl;
		}
		
		var feedId = $('#feedId');
		var feedName = $('#name');
		var feedUrl = $('#url');
		var categoryId = $('#categoryId');
		if(enRss.m_work == 'update'){
			if(feedName.val() == ''){
				alert('Feed 이름을 입력하세요.');
				feedName.select();
				return;
			}
		}
		if(feedUrl.val() == ''){
			alert('Feed 주소를 입력하세요.');
			feedUrl.select();
			return;
		}
		if(categoryId.val() == -1){
			alert('카테고리를 선택하세요.');
			categoryId.select();
			return;
		}
		
		if(!confirm(work + " 하시겠습니까?")) return;
		
		var param = "id=" + feedId.val();
		if(enRss.m_work == 'update') param += "&name=" + feedName.val();
		param += "&categoryId=" + categoryId.val();
		if(enRss.m_work != 'update') param += "&url=" + feedUrl.val();
		if(enRss.m_work == 'update') param += "&homepage=" + $('#homepage').val();
		this.m_ajax.send("POST", this.m_contextPath + actionUrl, param, true, {success: function(htmlData) {
			if(enRss.m_selectedListTab == 'my'){
				enFeed.uiList();
			}
			else if(enRss.m_selectedListTab == 'request'){
				enFeed.uiRequestList();
			}
			alert(htmlData);
		}});
	},

	//Feed 선택
	select : function(listOrder){
		$('input[name=feedCheck]').removeAttr('checked');
		$('input[name=feedCheck]').eq(listOrder).prop('checked', true);
		enRss.m_work = 'update';
		this.detail();
	},
	
	detail : function(){
		var url = '';
		if(enRss.m_selectedListTab == 'my'){
			url = this.m_detailUrl;
		}
		else if(enRss.m_selectedListTab == 'request'){
			url = this.m_detailRequestUrl;
		}
		if(this.m_parent.m_work == 'update'){
			var param = "id=" + enRss.getSeletecFeedId();
			this.m_ajax.send("POST", this.m_contextPath + url, param, true, {success: function(htmlData) { 
				$('#RssManager_DetailTabPage').html(htmlData);
			}});
		}
	},
	
	subscribe : function(feedId) {
		if(!confirm("구독 하시겠습니까?")) return;
		var param = "id=" + feedId;
		this.m_ajax.send("POST", this.m_contextPath + this.m_subsUrl, param, true, {success: function(htmlData) { 
			enFeed.uiList();
			alert(htmlData);
		}});
	},
	
	cancelSubscribe : function(feedId) {
		if(!confirm("구독을 해제하시겠습니까?")) return;
		var param = "id=" + feedId;
		this.m_ajax.send("POST", this.m_contextPath + this.m_cancelSubsUrl, param, true, {success: function(htmlData) { 
			enFeed.uiList();
			alert(htmlData);
		}});
	}
}


hancer.rss.entry = function(parent) {
	this.m_parent = parent;
	this.m_ajax = parent.m_ajax;
	this.m_listUrl	 =	"/rss/myEntryList.hanc";
}
hancer.rss.entry.prototype = {
	m_parent : null,
	m_contextPath : null,
	
	m_searchType : 0,
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
		this.uiMyEntryList();
	},
	
	firstPage : function(){
		this.m_currentPage = 1;
		this.uiMyEntryList();
	},
	
	lastPage :function(){
		this.m_currentPage = this.m_lastPage;
		this.uiMyEntryList();
	},
	
	prevPage : function(){
		this.m_currentPage = this.m_prevPage;
		this.m_prevPage = this.m_currentPage - 1;
		if(this.m_prevPage < 1) this.m_prevPage = 1;
		this.uiMyEntryList();
	},
	
	nextPage : function(){
		this.m_currentPage = this.m_nextPage;
		this.m_nextPage = this.m_currentPage + 1;
		if(this.m_nextPage > this.m_lastPage) this.m_nextPage = this.m_lastPage;
		this.uiMyEntryList();
	},
	
	prev10Page : function(){
		this.m_currentPage = this.m_currentPrevPage;
		this.m_currentPrevPage = this.m_currentPage - 10;
		if(this.m_currentPage < 1) this.m_currentPage = 1;
		if(this.m_currentPrevPage < 1) this.m_currentPrevPage = 1;
		this.uiMyEntryList();
	},
	
	next10Page : function(){
		this.m_currentPage = this.m_currentNextPage;
		this.m_currentNextPage = this.m_currentPage + 10;
		if(this.m_currentPage > this.m_lastPage) this.m_currentPage = this.m_lastPage;
		if(this.m_currentNextPage > this.m_lastPage) this.m_currentNextPage = this.m_lastPage;
		this.uiMyEntryList();
	},
	
	reload : function(){
		this.m_currentPage = 1;
		this.uiMyEntryList();
	},
	
	//검색 함수
	search : function(){
		if(event && event.keyCode != 13 && event.keyCode != 0) return false;
		this.m_searchType = $('#entryCategoryList').val();
		this.m_searchValue = $('#entrySearchValue').val();
		this.m_currentPage = 1;
		this.uiMyEntryList();
	},
	
	uiMyEntryList : function(){
		enRss.m_selectedListTab = 'entryList';
		var param = "currentPage=" + this.m_currentPage;
		param += "&categoryId=" + this.m_searchType;
		param += "&searchValue=" + this.m_searchValue;
		param += "&listCount=" + ($('#entryListCount').val() ? $('#entryListCount').val() : 10);
		this.m_ajax.send("POST", this.m_contextPath + this.m_listUrl, param, true, {success: function(htmlData) {
			$('#RssManager_propertyTabs').css('display', 'none');
			$('#RssManager_myEntryListPage').html(htmlData);
		}});
	}
}


/************************************
 **** 메인 함수
 ************************************/
//쪽지 관리 초기화 jquery 함수
$(document).ready(function(){
	//탭 구현 후
	$("#RssManager_feedListTabs").tabs();
	$("#RssManager_propertyTabs").tabs();
	
	//피드리스트를 보여준다.
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
