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
	}
}

hancer.rss.entry = function(parent) {
	this.m_parent = parent;
	this.m_ajax = parent.m_ajax;
	this.m_listUrl	 =	"/rss/serviceList.hanc";
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
		this.m_searchType = $('#entrySearchType').val() - 1;
		this.m_searchValue = $('#entrySearchValue').val();
		this.m_currentPage = 1;
		this.uiList();
	},
	
	uiList : function(){
		var param = "currentPage=" + this.m_currentPage;
		if($('#categoryList').val() > -1) param += "&categoryId=" + $('#categoryList').val();
		param += "&searchValue=" + this.m_searchValue;
		param += "&listCount=" + ($('#entryListCount').val() ? $('#entryListCount').val() : 10);
		this.m_ajax.send("POST", this.m_contextPath + this.m_listUrl, param, true, {success: function(htmlData) {
			$('#RssManager_myEntryListPage').html(htmlData);
		}});
	},
	
	selectCategory : function(){
		var param = "currentPage=" + this.m_currentPage;
		param += "&categoryId=" + $('#categoryList').val();
		param += "&searchValue=" + this.m_searchValue;
		param += "&listCount=" + ($('#entryListCount').val() ? $('#entryListCount').val() : 10);
		this.m_ajax.send("POST", this.m_contextPath + this.m_listUrl, param, true, {success: function(htmlData) {
			$('#RssManager_myEntryListPage').html(htmlData);
		}});
	}
}


/************************************
 **** 메인 함수
 ************************************/
//쪽지 관리 초기화 jquery 함수
$(document).ready(function(){
});

var enRss = new hancer.rss();
var enEntry = new hancer.rss.entry(enRss);
