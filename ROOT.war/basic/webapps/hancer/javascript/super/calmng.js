if( ! window.hancer )
    window.hancer = new Object();

if( ! window.hancer.cal )
    window.hancer.cal = new Object();


hancer.cal = function() {
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
}

hancer.cal.prototype = {
	m_domainId : 0,
	m_contextPath : '',
	m_ajax : null,
	
	m_logoutUrl : null,
	
	m_selectedTab : 'detail',
	m_work : null,
	m_checkBox : null,
	
	m_isUserMode : false,
	
	/************************************
	 **** 공통 기능
	 ************************************/
	setUserCalendarMode : function(isUserMode){
		this.m_isUserMode = isUserMode;
		enCalDetail.setUserMode(isUserMode);
	},
	
	logoutUrl : function(logoutUrl){
		if (logoutUrl == undefined) return this.m_logoutUrl;
		else this.m_logoutUrl = logoutUrl;
	},
	
	domain : function(domainId){
		this.m_domainId = domainId;
	},
	
	getDomain : function(){
		return this.m_domainId;
	},
	
	contextPath : function(contextPath){
		if(contextPath){
			this.m_contextPath = contextPath;
		}
		else {
			if(this.m_contextPath == null) this.m_contextPath = '';
		}
		enCalDetail.m_contextPath = this.m_contextPath;
		enCalLang.m_contextPath = this.m_contextPath;
		enCalUser.m_contextPath = this.m_contextPath;
		enCalGroup.m_contextPath = this.m_contextPath;
		enCalUserPublic.m_contextPath = this.m_contextPath;
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
	checkAll : function( name){
		var checked = $("#checkAll." + name).is(':checked');
		alert( 'checked=' + checked);
		/*
		var checkboxs = $('input:checkbox.' + className);
		alert( checkAll.prop('checked'));
		
		if($checkAll.is(':checked')){
			checkboxs.prop('checked', true);
		}else{
			checkboxs.removeAttr('checked');
		}
		*/
	},
	
	getMessage : function() {
		var retMsg = null;
		var arr = arguments;
		if (arr != null && arr.length > 0) {
			if (!portalPage) {
				portalPage = new enview.portal.Page();
			}
			retMsg = portalPage.getMessageResource (arr[0]);
			if(retMsg == null) {
				alert(arr[0]);
				return "";
			}
			for (var i=0; i<arr.length; i++) {
				var pattern = "{" + i + "}";
				retMsg = retMsg.replace(pattern, arr[i+1]);
			}
		}
		return retMsg;
	},
	
	initTabs : function(){
		$("#CalendarManager_propertyTabs").tabs();
		this.checkTabs();
	},
	
	checkTabs : function() {
		if($('input[name="calendarCheck"]').length > 0 ) {
			$('#CalendarManager_propertyTabs').tabs('enable');
		}
		else {
			$('#CalendarManager_propertyTabs').tabs('disable');
			$('#CalendarManager_propertyTabs').tabs('enable', 0);
			if($('input[name=calendarCheck]').length > 0) {
				$('#CalendarManager_propertyTabs').tabs('select', 0);
			}
		}
	},
	
	selectTab : function(tabName){
		if($('input[name=calendarCheck]').length > 0) {
			if(tabName == 'detail'){
				$('#CalendarManager_propertyTabs').tabs('select', 0);
			} else if(tabName == 'lang'){
				$('#CalendarManager_propertyTabs').tabs('select', 1);
			} else if(tabName == 'user'){
				$('#CalendarManager_propertyTabs').tabs('select', 2);
			} else if(tabName == 'group'){
				$('#CalendarManager_propertyTabs').tabs('select', 3);
			}
		}
	}
	
}

hancer.cal.detail = function(parent) {
	this.m_parent = parent;
	this.m_ajax = parent.m_ajax;
	this.m_contextPath = parent.m_contextPath;
	
	if(!enCal.m_isUserMode) {
		this.m_listUrl	 =	"/hancer/calendar/publicCalendarList.hanc",
		this.m_detailUrl =	"/hancer/calendar/detailCalendar.hanc";
		this.m_insertUrl =	"/hancer/calendar/insertCalendar.hanc";
		this.m_updateUrl =	"/hancer/calendar/updateCalendar.hanc";
		this.m_deleteUrl =	"/hancer/calendar/deleteCalendars.hanc";
	} else {
		this.m_listUrl	 =	"/hancer/calendar/publicUserCalendarList.hanc",
		this.m_detailUrl =	"/hancer/calendar/detailUserCalendar.hanc";
		this.m_insertUrl =	"/hancer/calendar/insertUserCalendar.hanc";
		this.m_updateUrl =	"/hancer/calendar/updateUserCalendar.hanc";
		this.m_deleteUrl =	"/hancer/calendar/deleteUserCalendars.hanc";
		this.m_userCalendarListUrl = "/hancer/calendar/userCalendarList.hanc";
	}
	
}
hancer.cal.detail.prototype = {
	m_parent : null,
	m_logoutUrl : null,
	
	m_contextPath : null, 
	
	m_listUrl : null,
	m_detailUrl : null,
	m_insertUrl : null,
	m_updateUrl : null,
	m_deleteUrl : null,
	
	m_userCalendarListUrl : null,
	
	m_selectedCalendarId : -1,
	m_searchDomainId : -1,
	m_selectedDomainId : 0,
	
	m_searchValue : '',
	
	m_currentPage : 1,
	m_prevPage : 1,
	m_nextPage : 2,
	
	m_currentPrevPage : 1,
	m_currentNextPage : 11,
	
	m_lastPage : 1,
	
	setUserMode : function(isUserMode){
		if(!isUserMode) {
			this.m_listUrl	 =	"/hancer/calendar/publicCalendarList.hanc",
			this.m_detailUrl =	"/hancer/calendar/detailCalendar.hanc";
			this.m_insertUrl =	"/hancer/calendar/insertCalendar.hanc";
			this.m_updateUrl =	"/hancer/calendar/updateCalendar.hanc";
			this.m_deleteUrl =	"/hancer/calendar/deleteCalendars.hanc";
		} else {
			this.m_listUrl	 =	"/hancer/calendar/userPublicCalendarList.hanc",
			this.m_detailUrl =	"/hancer/calendar/detailUserCalendar.hanc";
			this.m_insertUrl =	"/hancer/calendar/insertUserCalendar.hanc";
			this.m_updateUrl =	"/hancer/calendar/updateUserCalendar.hanc";
			this.m_deleteUrl =	"/hancer/calendar/deleteUserCalendars.hanc";
			this.m_userCalendarListUrl = "/hancer/calendar/userCalendarList.hanc";
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
		if(this.m_currentPage < 1) this.m_currentPage = 1;
		if(this.m_prevPage < 1) this.m_prevPage = 1;
		this.uiList();
	},
	
	nextPage : function(){
		this.m_currentPage = this.m_nextPage;
		this.m_nextPage = this.m_currentPage + 1;
		if(this.m_currentPage > this.m_lastPage) this.m_currentPage = this.m_lastPage;
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
			$('#searchValue').val(this.searchValue(value));
			$('#searchValue').focus();
		}
	},
	
	//검색 함수
	search : function(){
		if(event && event.keyCode != 13 && event.keyCode != 0) return false;
		this.m_searchValue = $('#searchValue').val();
		this.m_currentPage = 1;
		this.uiList();
	},
	
	uiList : function(){
		var param = "currentPage=" + this.m_currentPage;
		param += "&name=" + encodeURIComponent(this.m_searchValue);
		param += "&searchDomainId=" + enCalDetail.getSelectedSearchDomainId();
		param += "&listCount=" + ($('#calendarListCount').val() ? $('#calendarListCount').val() : 10);
		
		this.m_ajax.send("POST", this.m_contextPath + this.m_listUrl, param, true, {success: function(htmlData) {
			$('#list').html(htmlData);
			enCal.checkTabs();
			if($('input[name=calendarCheck]').length > 0) { enCalDetail.select(0); }
			else { 
				if(!enCal.m_isUserMode) enCalDetail.uiForm();
				else {
					$('#CalendarManager_DetailTabPage').html('');
				}
			}
			$('#searchValue').select();
		}});
	},
	
	//검색 함수
	searchUserCalendar : function(){
		if(event && event.keyCode != 13 && event.keyCode != 0) return false;
		this.m_searchValue = $('#searchValue').val();
		this.m_currentPage = 1;
		this.uiUserCalendarListForm();
	},
	
	uiUserCalendarListForm : function (){
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&searchDomainId=" + enCalDetail.getSelectedSearchDomainId();
		param += '&searchValue=' + enCalDetail.getUserCalendarSearchValue();
		if(enCalDetail.getIsDefault() != '') param += '&isDefault=' + enCalDetail.getIsDefault();
		this.m_ajax.send("POST", this.m_contextPath + this.m_userCalendarListUrl, param, true, {success: function(htmlData) { 
			$('#CalendarManager_UserCalendarChooser').html(htmlData);
			$('#CalendarManager_UserCalendarChooser').dialog({
				"title": "사용자 캘린더 선택",
				"modal": true,
				"width": 520,
				"min-height": 260,
				"buttons": [ 
				             { text: "Apply", click: function() { if($('input[name=userCalendarCheck]:checked').length < 1) { alert('캘린더를 선택하세요.'); } else { enCalDetail.updateUserPublic();  $(this).dialog("destroy"); } } }, 
				             { text: "Cancel", click: function() { $(this).dialog("destroy"); } }
				           ]
			});
		}});
	},
	
	//Calendar 삽입 폼
	uiForm : function(){
		enCal.selectTab('detail');
		enCal.m_work = 'insert';
		var param = "calendarId=-1";
		param += "&domainId=" + enCal.getDomain();
		this.m_ajax.send("POST", this.m_contextPath + this.m_detailUrl, param, true, {success: function(htmlData) { 
			$('#CalendarManager_DetailTabPage').html(htmlData);
			$('#domainId').val(enCal.getDomain());
			$('#name').removeAttr('readonly');
			$('#url').removeAttr('readonly');
			$('#homepage').removeAttr('readonly');
		}});
	},
	
	//Calendar 삭제
	deletes: function(){
		var ids = ''; 
		$('input[name=calendarCheck]').each(function(){
			var $this = $(this);
			if($this.is(':checked')){
				ids += $this.val() + ',';
			}
		});
		if(ids == ''){ 
			alert(enCal.getMessage('hn.info.admin.calendar.select.data')); 
			return;
		}
		if(!confirm(enCal.getMessage('hn.info.confirm.delete'))) return;
		ids = ids.substring(0, ids.length-1);
		var param = "calendarIds=" + ids;
		this.m_ajax.send("POST", this.m_contextPath + this.m_deleteUrl, param, true, {success: function(data) {
			enCalDetail.uiList();
			alert(enCal.getMessage(data.Message));
		}});
	},

	//Calendar 정보 추가/변경
	update : function(){
		var work = '';
		var actionUrl = '';
		var domainId = $('#calendarDomainId');
		var name = $('#name');
		var comments = $('#comments');
		var bgColor = $('#bgColor');
		var isUse = $('input[name="isUse"]:checked');
		var isBilingual = $('input[name=isBilingual]:checked');
		var publicType = $('#calendarPublicType');
		if(enCal.m_work == 'insert') {
			actionUrl = this.m_insertUrl;
		}
		else if(enCal.m_work == 'update') {
			actionUrl = this.m_updateUrl;
		}
		
		if(name.val() == ''){
			alert(enCal.getMessage("hn.info.required.calendar.name"));
			name.select();
			return;
		}
		
		if(!confirm(enCal.getMessage("hn.info.confirm.save"))) return;
		
		var param = "domainId=" + enCalDetail.getSelectedDomainId();
		param += "&calendarId=" + enCalDetail.getSelectedCalendarId();
		param += "&name=" + encodeURIComponent(name.val());
		param += "&comments=" + encodeURIComponent(comments.val());
		param += "&bgColor=" + bgColor.val();
		if(!enCal.m_isUserMode) {
			param += "&isUse=" + isUse.val();
			param += "&isBilingual=" + isBilingual.val();
		} else {
			param += '&isUserPublic=Y';
		}
		param += "&publicType=" + publicType.val();
		this.m_ajax.send("POST", this.m_contextPath + actionUrl, param, true, {success: function(data) {
			enCalDetail.uiList();
			alert(enCal.getMessage(data.Message));
		}});
	},
	
	//Calendar 정보 추가/변경
	updateUserPublic : function(){
		if(!confirm(enCal.getMessage("hn.info.confirm.save"))) return;
		var work = '';
		var param = "calendarId=" + enCalDetail.getSelectedUserCalendarId();
		param += '&isUserPublic=Y';
		this.m_ajax.send("POST", this.m_contextPath + this.m_insertUrl, param, true, {success: function(data) {
			enCalDetail.uiList();
			alert(enCal.getMessage(data.Message));
		}});
	},

	//Calendar 선택
	select : function(listOrder){
		$('input[name=calendarCheck]').removeAttr('checked');
		$('input[name=calendarCheck]').eq(listOrder).prop('checked', true);
		enCal.m_work = 'update';
		if($('#' + $('input[name=calendarCheck]').eq(listOrder).val() + '_publicType').val() == 'P'){
			$('#CalendarManager_propertyTabs').tabs('disable', 3);
			if(enCal.m_selectedTab == 'detail'){
				if(!enCal.m_isUserMode) {
					this.detail();
				}
				else this.detailUserPublic();
			}else if(enCal.m_selectedTab == 'langList'){
				enCalLang.m_currentPage = 1;
				enCalLang.uiList();
			}else if(enCal.m_selectedTab == 'userList'){
				enCalUser.m_currentPage = 1;
				enCalUser.uiList();
			}else if(enCal.m_selectedTab == 'groupList'){
				$('#CalendarManager_propertyTabs').tabs('select', 0);
			}
		}
		else {
			$('#CalendarManager_propertyTabs').tabs('enable', 3);
			if(enCal.m_selectedTab == 'detail'){
				if(!enCal.m_isUserMode) {
					this.detail();
				}
				else this.detailUserPublic();
			}else if(enCal.m_selectedTab == 'langList'){
				enCalLang.m_currentPage = 1;
				enCalLang.uiList();
			}else if(enCal.m_selectedTab == 'userList'){
				enCalUser.m_currentPage = 1;
				enCalUser.uiList();
			}else if(enCal.m_selectedTab == 'groupList'){
				enCalGroup.m_currentPage = 1;
				enCalGroup.uiList();
			}
		}
	},
	
	selectUserCalendar : function(listOrder){
		$('input[name=userCalendarCheck]').removeAttr('checked');
		$('input[name=userCalendarCheck]').eq(listOrder).prop('checked', true);
	},
	
	detail : function(){
		enCal.m_work = 'update';
		enCal.m_selectedTab = 'detail';
		if(this.m_parent.m_work == 'update'){
			var param = "calendarId=" + enCalDetail.getSelectedCalendarId();
			this.m_ajax.send("POST", this.m_contextPath + this.m_detailUrl, param, true, {success: function(htmlData) { 
				$('#CalendarManager_DetailTabPage').html(htmlData);
			}});
		}
	},	
	
	detailUserPublic : function(){
		enCal.m_selectedTab = 'detail';
		if(this.m_parent.m_work == 'update'){
			var param = "calendarId=" + enCalDetail.getSelectedCalendarId();
			this.m_ajax.send("POST", this.m_contextPath + this.m_detailUrl, param, true, {success: function(htmlData) { 
				$('#CalendarManager_DetailTabPage').html(htmlData);
			}});
		}
	},
	
	getSelectedCalendarId : function(){
		this.m_selectedCalendarId = $('.calendarCheck:checked').val();
		return this.m_selectedCalendarId;
	},
	
	getSelectedUserCalendarId : function(){
		this.m_selectedCalendarId = $('.userCalendarCheck:checked').val();
		return this.m_selectedCalendarId;
	},
	
	getSelectedSearchDomainId : function(){
		if($('#UserCalendarManager_domainCond').val()) this.m_searchDomainId = $('#UserCalendarManager_domainCond').val();
		else if($('#CalendarManager_domainCond').val()) this.m_searchDomainId = $('#CalendarManager_domainCond').val();
		else this.m_searchDomainId = enCal.m_domainId;
		return this.m_searchDomainId;
	},
	
	getSelectedDomainId : function(){
		this.m_selectedDomainId = $('#CalendarManager_domainCond').val();
		return this.m_selectedDomainId;
	},
	
	getUserCalendarSearchValue : function(){
		if($('#userCalendarSearchValue').val()) return $('#userCalendarSearchValue').val();
		else return '';
	},
	
	getIsDefault : function(){
		if($('#CalendarManager_isDefaultCond').val()) return $('#CalendarManager_isDefaultCond').val();
		else return '';
	}
}

hancer.cal.lang = function(parent) {
	this.m_parent = parent;
	this.m_ajax = parent.m_ajax;
	this.m_contextPath = parent.m_contextPath;
	
	this.m_listUrl	 =	"/hancer/calendar/langList.hanc",
	this.m_detailUrl =	"/hancer/calendar/detailLang.hanc",
	this.m_insertUrl =	"/hancer/calendar/insertLang.hanc";
	this.m_updateUrl =	"/hancer/calendar/updateLang.hanc";
	this.m_deleteUrl =	"/hancer/calendar/deleteLangs.hanc";
}
hancer.cal.lang.prototype = {
	m_parent : null,
	m_contextPath : null,
	
	m_selectedLangKnd : null,
	
	m_searchValue : '',
	m_listCount : 10,
	
	m_currentPage : 1,
	m_prevPage : 1,
	m_nextPage : 2,
	
	m_currentPrevPage : 1,
	m_currentNextPage : 11,
	
	m_lastPage : 1,
	
	m_listUrl : null,
	m_insertUrl : null,
	m_updateUrl : null,
	m_deleteUrl : null,
	
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
		this.m_searchValue = $('#calendarLangSearchValue').val();
		this.m_currentPage = 1;
		this.uiList();
	},
	
	uiList : function(){
		enCal.m_selectedTab = 'langList';
		var param = "currentPage=" + this.m_currentPage;
		param += "&name=" + encodeURIComponent(this.m_searchValue);
		param += "&listCount=" + ($('#calendarLangListCount').val() ? $('#calendarLangListCount').val() : 10);
		param += "&calendarId=" + enCalDetail.getSelectedCalendarId();
		this.m_ajax.send("POST", this.m_contextPath + this.m_listUrl, param, true, {success: function(htmlData) { 
			$('#CalendarManager_LangListTabPage').html(htmlData);
			enCalLang.select(0);
			$('#langSearchValue').select();
		}});
	},
	
	//CalendarLang 삽입 폼
	uiForm : function(){
		var param = "calendarId=-1";
		param += "&domainId=" + enCal.getDomain();
		this.m_ajax.send("POST", this.m_contextPath + this.m_detailUrl, param, true, {success: function(htmlData) { 
			$('#CalendarManager_LangDetailTabPage').html(htmlData);
			enCal.m_work = 'insert';
			$('#name').removeAttr('readonly');
			$('#comments').removeAttr('readonly');
			$('#detailLangKnd').removeAttr('disabled');
		}});
	},
	
	//CalendarLang 삭제
	deletes: function(){
		var ids = ''; 
		$('input[name=calendarLangCheck]').each(function(){
			var $this = $(this);
			if($this.is(':checked')){
				ids += $this.val() + ',';
			}
		});
		if(ids == ''){ 
			alert(enCal.getMessage('hn.info.admin.calendar.select.data')); 
			return;
		}
		if(!confirm(enCal.getMessage('hn.info.confirm.delete'))) return;
		ids = ids.substring(0, ids.length-1);
		var param = "calendarId=" + enCalDetail.getSelectedCalendarId();
		param += "&langKnds=" + ids;
		this.m_ajax.send("POST", this.m_contextPath + this.m_deleteUrl, param, true, {success: function(data) {
			enCalDetail.uiList();
			alert(enCal.getMessage(data.Message));
		}});
	},

	//Calendar 정보 추가/변경
	update : function(){
		var work = '';
		var actionUrl = '';
		var calendarId = $('#calendarId');
		var name = $('#langName');
		var comments = $('#langComments');
		var langKnd = $('#detailLangKnd');
		
		if(enCal.m_work == 'insert') {
			actionUrl = this.m_insertUrl;
		}
		else if(enCal.m_work == 'update') {
			actionUrl = this.m_updateUrl;
		}
		
		if(name.val() == ''){
			alert(enCal.getMessage('hn.info.admin.calendar.insert.calendarname')); 
			name.select();
			return;
		}
		
		if(!confirm(enCal.getMessage('hn.info.confirm.save'))) return;
		
		var param = "calendarId=" + enCalDetail.getSelectedCalendarId();
		param += "&langKnd=" + langKnd.val();
		param += "&name=" + encodeURIComponent(name.val());
		param += "&comments=" + encodeURIComponent(comments.val());
		this.m_ajax.send("POST", this.m_contextPath + actionUrl, param, true, {success: function(data) {
			enCalDetail.uiList();
			alert(enCal.getMessage(data.Message));
		}});
	},

	//CalendarLang 선택
	select : function(listOrder){
		$('input[name=calendarLangCheck]').removeAttr('checked');
		$('input[name=calendarLangCheck]').eq(listOrder).prop('checked', true);
		
		enCalLang.setSelectedLangKnd($('input[name=calendarLangCheck]').eq(listOrder).val());
		enCal.m_work = 'update';
		this.m_currentPage = 1;
		this.detail();
	},
	
	detail : function(){
		enCalLang.m_selectedTab = 'detail';
		if(this.m_parent.m_work == 'update'){
			var param = "calendarId=" + enCalDetail.getSelectedCalendarId();
			param += "&langKnd=" + enCalLang.getSelectedLangKnd();
			this.m_ajax.send("POST", this.m_contextPath + this.m_detailUrl, param, true, {success: function(htmlData) {
				var propertyTabs = $("#CalendarManager_langPropertyTabs").tabs();
				$('#CalendarManager_LangDetailTabPage').html(htmlData);
			}});
		}
	}, 
	
	getSelectedLangKnd : function(){
		return this.m_selectedLangKnd;
	},
	
	setSelectedLangKnd : function(langKnd){
		this.m_selectedLangKnd = langKnd;
	}
}

hancer.cal.user = function(parent) {
	this.m_parent = parent;
	this.m_ajax = parent.m_ajax;
	this.m_contextPath = parent.m_contextPath;
	
	this.m_listUrl	 =	"/hancer/calendar/userList.hanc",
	this.m_detailUrl =	"/hancer/calendar/detailUser.hanc",
	this.m_insertUrl =	"/hancer/calendar/insertUsers.hanc";
	this.m_updateUrl =	"/hancer/calendar/updateUser.hanc";
	this.m_deleteUrl =	"/hancer/calendar/deleteUsers.hanc";
}
hancer.cal.user.prototype = {
	m_parent : null,
	m_contextPath : null,
	
	m_searchValue : '',
	m_listCount : 10,
	
	m_selectedUserId : null,
	
	m_currentPage : 1,
	m_prevPage : 1,
	m_nextPage : 2,
	
	m_currentPrevPage : 1,
	m_currentNextPage : 11,
	
	m_lastPage : 1,
	
	m_listUrl : null,
	m_insertUrl : null,
	m_updateUrl : null,
	m_deleteUrl : null,
	
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
		this.m_searchValue = $('#userSearchValue').val();
		this.m_currentPage = 1;
		this.uiList();
	},
	
	uiList : function(){
		enCal.m_selectedTab = 'userList';
		var param = "currentPage=" + this.m_currentPage;
		param += "&searchValue=" + this.m_searchValue;
		param += "&listCount=" + ($('#calendarUserListCount').val() ? $('#calendarUserListCount').val() : 10);
		param += "&calendarId=" + enCalDetail.getSelectedCalendarId();
		if(enCal.m_isUserMode) param += "&isUserPublic=Y";
		this.m_ajax.send("POST", this.m_contextPath + this.m_listUrl, param, true, {success: function(htmlData) { 
			$('#CalendarManager_UserListTabPage').html(htmlData);
			if($('input[name=calendarUserCheck]').length > 0 ) enCalUser.select(0);
			$('#userSearchValue').select();
		}});
	},
	
	// UserList
	getUserChooser : function () {
		var domainId = $('#calendarDomainId_' + enCalDetail.getSelectedCalendarId()).val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId + "&byDomain=Y&existsDomain=Y&";
		var extraParam = "&byDomain=Y&existsDomain=Y&";
//		if( enCalUser.m_userChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/user/listForChooser.admin", param, false, {
				success: function(data)
				{
					document.getElementById("UserManager_UserChooser").innerHTML = data;
					aUserChooser = new UserChooser( enCal.m_evSecurityCode, domainId, extraParam );
					
				}});
//		}
		return aUserChooser;
	},
	
	//CalendarUser 삭제
	deletes: function(){
		var ids = ''; 
		$('input[name=calendarUserCheck]').each(function(){
			var $this = $(this);
			if($this.is(':checked')){
				ids += $this.val() + ',';
			}
		});
		if(ids == ''){ 
			alert(enCal.getMessage('hn.info.admin.calendar.select.data')); 
			return;
		}
		if(!confirm(enCal.getMessage('hn.info.confirm.delete'))) return;
		ids = ids.substring(0, ids.length-1);
		var param = "calendarId=" + enCalDetail.getSelectedCalendarId();
		param += "&userIds=" + ids;
		if(enCal.m_isUserMode) param += "&isUserPublic=Y";
		this.m_ajax.send("POST", this.m_contextPath + this.m_deleteUrl, param, true, {success: function(data) {
			enCalUser.uiList();
			alert(enCal.getMessage(data.Message));
		}});
	},

	//Calendar 정보 추가/변경
	insertUser : function(rowArray){
		var userIds = '';
		for(var i=0; i<rowArray.length; i++) {	
			userIds += rowArray[i].get("shortPath") + ',';
		}
		if(userIds != '') userIds = userIds.substring(0, userIds.length-1);
		var param = "calendarId=" + enCalDetail.getSelectedCalendarId();
		param += "&userIds=" + userIds;
		param += "&permissions=R";
		if(enCal.m_isUserMode) param += "&isUserPublic=Y";
		enCalUser.m_ajax.send("POST", enCalUser.m_contextPath + enCalUser.m_insertUrl, param, true, {success: function(data) {
			enCalUser.uiList();
			alert(enCal.getMessage(data.Message));
		}});
	},
	
	//Calendar 정보 추가/변경
	update : function(){
		var work = '';
		var actionUrl = '';
		
		if(enCal.m_work == 'insert') {
			actionUrl = this.m_insertUrl;
		}
		else if(enCal.m_work == 'update') {
			actionUrl = this.m_updateUrl;
		}
		
		if(!confirm(enCal.getMessage('hn.info.confirm.save'))) return;
		
		var param = "calendarId=" + enCalDetail.getSelectedCalendarId();
		param += "&userId=" + enCalUser.getSelectedUserId();
		param += "&permissions=" + enCalUser.getUserPermissions();
		if(enCal.m_isUserMode) param += "&isUserPublic=Y";
		this.m_ajax.send("POST", this.m_contextPath + actionUrl, param, true, {success: function(data) {
			enCalDetail.uiList();
			alert(enCal.getMessage(data.Message));
		}});
	},

	//CalendarLang 선택
	select : function(listOrder){
		$('input[name=calendarUserCheck]').removeAttr('checked');
		$('input[name=calendarUserCheck]').eq(listOrder).prop('checked', true);
		
		var userId = $('input[name=calendarUserCheck]').eq(listOrder).val();
		enCalUser.setSelectedUserId(userId);

		if($('#' + userId + '_isDeletable').val() == 0) {
			$('#deleteButton').css('display', 'none');
		} else {
			$('#deleteButton').css('display', 'inline-block');
		}
		
		enCal.m_work = 'update';
		this.m_currentPage = 1;
		this.detail();
	},
	
	detail : function(){
		enCalUser.m_selectedTab = 'detail';
		if(this.m_parent.m_work == 'update'){
			var param = "calendarId=" + enCalDetail.getSelectedCalendarId();
			param += "&userId=" + enCalUser.getSelectedUserId();
			if(enCal.m_isUserMode) param += "&isUserPublic=Y";
			this.m_ajax.send("POST", this.m_contextPath + this.m_detailUrl, param, true, {success: function(htmlData) {
				var propertyTabs = $("#CalendarManager_UserPropertyTabs").tabs();
				$('#CalendarManager_UserDetailTabPage').html(htmlData);
				enCalUser.initPermissionsCheckboxes();
			}});
		}
	}, 
	
	initPermissionsCheckboxes : function(){
		if($('#permissionsCRUDACheck').is(':checked')){
			$('#permissionsRUCheck').attr('disabled', 'disabled');
			$('#permissionsRUCheck').prop('checked', true);
		} else {
			$('#permissionsRUCheck').removeAttr('disabled');
		}
	},
	
	getUserPermissions : function(){
		if($('#permissionsCRUDACheck').is(':checked')) return $('#permissionsCRUDACheck').val();
		else {
			if($('#permissionsRUCheck').is(':checked'))  return $('#permissionsRUCheck').val();
			else return $('#permissionsRCheck').val();
		}
	},
	
	getSelectedUserId : function(){
		return this.m_selectedUserId;
	},
	
	setSelectedUserId : function(userId){
		this.m_selectedUserId = userId;
	}
	
}


hancer.cal.userPublic = function(parent) {
	this.m_parent = parent;
	this.m_ajax = parent.m_ajax;
	this.m_contextPath = parent.m_contextPath;
	
	this.m_listUrl	 =	"/hancer/calendar/userList.hanc",
	this.m_detailUrl =	"/hancer/calendar/detailUser.hanc",
	this.m_insertUrl =	"/hancer/calendar/insertUsers.hanc";
	this.m_updateUrl =	"/hancer/calendar/updateUser.hanc";
	this.m_deleteUrl =	"/hancer/calendar/deleteUsers.hanc";
}
hancer.cal.userPublic.prototype = {
	m_parent : null,
	m_contextPath : null,
	
	m_searchValue : '',
	m_listCount : 10,
	
	m_selectedUserId : null,
	
	m_currentPage : 1,
	m_prevPage : 1,
	m_nextPage : 2,
	
	m_currentPrevPage : 1,
	m_currentNextPage : 11,
	
	m_lastPage : 1,
	
	m_listUrl : null,
	m_insertUrl : null,
	m_updateUrl : null,
	m_deleteUrl : null,
	
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
		this.m_searchValue = $('#userSearchValue').val();
		this.m_currentPage = 1;
		this.uiList();
	},
	
	uiList : function(){
		enCal.m_selectedTab = 'userList';
		var param = "currentPage=" + this.m_currentPage;
		param += "&searchValue=" + this.m_searchValue;
		param += "&listCount=" + ($('#userListCount').val() ? $('#userListCount').val() : 10);
		param += "&calendarId=" + enCalDetail.getSelectedCalendarId();
		if(enCal.m_isUserMode) param += "&isUserPublic=Y";
		this.m_ajax.send("POST", this.m_contextPath + this.m_listUrl, param, true, {success: function(htmlData) { 
			$('#CalendarManager_UserListTabPage').html(htmlData);
			if($('input[name=calendarUserCheck]').length > 0 ) enCalUser.select(0);
			$('#userSearchValue').select();
		}});
	},
	
	// UserList
	getUserChooser : function () {
		var domainId = $('#calendarDomainId_' + enCalDetail.getSelectedCalendarId()).val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId + "&byDomain=Y&existsDomain=Y&";
		var extraParam = "&byDomain=Y&existsDomain=Y&";
//		if( enCalUser.m_userChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/user/listForChooser.admin", param, false, {
				success: function(data)
				{
					document.getElementById("UserManager_UserChooser").innerHTML = data;
					aUserChooser = new UserChooser( enCal.m_evSecurityCode, domainId, extraParam );
					
				}});
//		}
		return aUserChooser;
	},
	
	//CalendarUser 삭제
	deletes: function(){
		var ids = ''; 
		$('input[name=calendarUserCheck]').each(function(){
			var $this = $(this);
			if($this.is(':checked')){
				ids += $this.val() + ',';
			}
		});
		if(ids == ''){ 
			alert(enCal.getMessage('hn.info.admin.calendar.select.data')); 
			return;
		}
		if(!confirm(enCal.getMessage('hn.info.confirm.delete'))) return;
		ids = ids.substring(0, ids.length-1);
		var param = "calendarId=" + enCalDetail.getSelectedCalendarId();
		param += "&userIds=" + ids;
		if(enCal.m_isUserMode) param += "&isUserPublic=Y";
		this.m_ajax.send("POST", this.m_contextPath + this.m_deleteUrl, param, true, {success: function(data) {
			enCalUser.uiList();
			alert(enCal.getMessage(data.Message));
		}});
	},

	//Calendar 정보 추가/변경
	insertUser : function(rowArray){
		var userIds = '';
		for(var i=0; i<rowArray.length; i++) {	
			userIds += rowArray[i].get("shortPath") + ',';
		}
		if(userIds != '') userIds = userIds.substring(0, userIds.length-1);
		var param = "calendarId=" + enCalDetail.getSelectedCalendarId();
		param += "&userIds=" + userIds;
		param += "&permissions=R";
		if(enCal.m_isUserMode) param += "&isUserPublic=Y";
		enCalUser.m_ajax.send("POST", enCalUser.m_contextPath + enCalUser.m_insertUrl, param, true, {success: function(data) {
			enCalUser.uiList();
			alert(enCal.getMessage(data.Message));
		}});
	},
	
	//Calendar 정보 추가/변경
	update : function(){
		var work = '';
		var actionUrl = '';
		
		if(enCal.m_work == 'insert') {
			actionUrl = this.m_insertUrl;
		}
		else if(enCal.m_work == 'update') {
			actionUrl = this.m_updateUrl;
		}
		
		if(!confirm(enCal.getMessage('hn.info.confirm.save'))) return;
		
		var param = "calendarId=" + enCalDetail.getSelectedCalendarId();
		param += "&userId=" + enCalUser.getSelectedUserId();
		param += "&permissions=" + enCalUser.getUserPermissions();
		if(enCal.m_isUserMode) param += "&isUserPublic=Y";
		this.m_ajax.send("POST", this.m_contextPath + actionUrl, param, true, {success: function(data) {
			enCalDetail.uiList();
			alert(enCal.getMessage(data.Message));
		}});
	},

	//CalendarLang 선택
	select : function(listOrder){
		$('input[name=calendarUserCheck]').removeAttr('checked');
		$('input[name=calendarUserCheck]').eq(listOrder).prop('checked', true);
		
		var userId = $('input[name=calendarUserCheck]').eq(listOrder).val();
		enCalUser.setSelectedUserId(userId);

		if($('#' + userId + '_isDeletable').val() == 0) {
			$('#deleteButton').css('display', 'none');
		} else {
			$('#deleteButton').css('display', 'inline-block');
		}
		
		enCal.m_work = 'update';
		this.m_currentPage = 1;
		this.detail();
	},
	
	detail : function(){
		enCalUser.m_selectedTab = 'detail';
		if(this.m_parent.m_work == 'update'){
			var param = "calendarId=" + enCalDetail.getSelectedCalendarId();
			param += "&userId=" + enCalUser.getSelectedUserId();
			if(enCal.m_isUserMode) param += "&isUserPublic=Y";
			this.m_ajax.send("POST", this.m_contextPath + this.m_detailUrl, param, true, {success: function(htmlData) {
				var propertyTabs = $("#CalendarManager_UserPropertyTabs").tabs();
				$('#CalendarManager_UserDetailTabPage').html(htmlData);
				enCalUser.initPermissionsCheckboxes();
			}});
		}
	}, 
	
	initPermissionsCheckboxes : function(){
		if($('#permissionsCRUDACheck').is(':checked')){
			$('#permissionsRUCheck').attr('disabled', 'disabled');
			$('#permissionsRUCheck').prop('checked', true);
		} else {
			$('#permissionsRUCheck').removeAttr('disabled');
		}
	},
	
	getUserPermissions : function(){
		if($('#permissionsCRUDACheck').is(':checked')) return $('#permissionsCRUDACheck').val();
		else {
			if($('#permissionsRUCheck').is(':checked'))  return $('#permissionsRUCheck').val();
			else return $('#permissionsRCheck').val();
		}
	},
	
	getSelectedUserId : function(){
		return this.m_selectedUserId;
	},
	
	setSelectedUserId : function(userId){
		this.m_selectedUserId = userId;
	}
	
}


hancer.cal.group = function(parent) {
	this.m_parent = parent;
	this.m_ajax = parent.m_ajax;
	this.m_contextPath = parent.m_contextPath;
	
	this.m_listUrl	 =	"/hancer/calendar/groupList.hanc",
	this.m_detailUrl =	"/hancer/calendar/detailGroup.hanc",
	this.m_insertUrl =	"/hancer/calendar/insertGroups.hanc";
	this.m_updateUrl =	"/hancer/calendar/updateGroup.hanc";
	this.m_deleteUrl =	"/hancer/calendar/deleteGroups.hanc";
}
hancer.cal.group.prototype = {
	m_parent : null,
	m_contextPath : null,
	
	m_searchValue : '',
	m_listCount : 10,
	
	m_selectedCalendarId : -1,
	m_selectedGroupId : -1,
	
	m_currentPage : 1,
	m_prevPage : 1,
	m_nextPage : 2,
	
	m_currentPrevPage : 1,
	m_currentNextPage : 11,
	
	m_lastPage : 1,
	
	m_listUrl : null,
	m_insertUrl : null,
	m_updateUrl : null,
	m_deleteUrl : null,
	
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
		this.m_searchValue = $('#groupSearchValue').val();
		this.m_currentPage = 1;
		this.uiList();
	},
	
	uiList : function(){
		enCal.m_selectedTab = 'groupList';
		var param = "currentPage=" + this.m_currentPage;
		param += "&searchValue=" + this.m_searchValue;
		param += "&listCount=" + ($('#groupListCount').val() ? $('#groupListCount').val() : 10);
		param += "&calendarId=" + enCalGroup.getSelectedCalendarId();
		if(enCal.m_isUserMode) param += "&isUserPublic=N";
		
		this.m_ajax.send("POST", this.m_contextPath + this.m_listUrl, param, true, {success: function(htmlData) { 
			$('#CalendarManager_GroupListTabPage').html(htmlData);
			if($('input[name=calendarGroupCheck]').length > 0 ) enCalGroup.select(0);
			else enCalGroup.uiForm();
		}});
	},
	
	uiForm : function(){
		var param = "calendarId=-1&groupId=-1";
		param += "&domainId=" + enCal.getDomain();
		this.m_ajax.send("POST", this.m_contextPath + this.m_detailUrl, param, true, {success: function(htmlData) {
			var propertyTabs = $("#CalendarManager_GroupPropertyTabs").tabs();
			$('#CalendarManager_GroupDetailTabPage').html(htmlData);
			enCal.m_work = 'insert';
			$('#groupId').removeAttr('readonly');
		}});
	},
	
	deletes: function(){
		var ids = ''; 
		$('input[name=calendarGroupCheck]').each(function(){
			var $this = $(this);
			if($this.is(':checked')){
				ids += $this.val() + ',';
			}
		});
		if(ids == ''){ 
			alert(enCal.getMessage('hn.info.admin.calendar.select.data')); 
			return;
		}
		if(!confirm(enCal.getMessage('hn.info.confirm.delete'))) return;
		ids = ids.substring(0, ids.length-1);
		var param = "calendarId=" + enCalGroup.getSelectedCalendarId();
		param += "&groupIds=" + ids;
		if(enCal.m_isUserMode) param += "&isUserPublic=N";
		this.m_ajax.send("POST", this.m_contextPath + this.m_deleteUrl, param, true, {success: function(data) {
			enCalGroup.uiList();
			alert(enCal.getMessage(data.Message));
		}});
	},

	//Calendar 정보 추가/변경
	update : function(){
		var work = '';
		var actionUrl = '';
		
		if(enCal.m_work == 'insert') {
			actionUrl = this.m_insertUrl;
		}
		else if(enCal.m_work == 'update') {
			actionUrl = this.m_updateUrl;
		}
		
		if(!confirm(enCal.getMessage('hn.info.confirm.save'))) return;
		
		var param = "calendarId=" + enCalGroup.getSelectedCalendarId();
		param += "&groupId=" + $('#groupId').val();
		param += "&permissions=" + enCalGroup.getGroupPermissions();
		if(enCal.m_isUserMode) param += "&isUserPublic=N";
		this.m_ajax.send("POST", this.m_contextPath + actionUrl, param, true, {success: function(data) {
			enCalGroup.uiList();
			alert(enCal.getMessage(data.Message));
		}});
	},

	select : function(listOrder){
		$('input[name=calendarGroupCheck]').removeAttr('checked');
		$('input[name=calendarGroupCheck]').eq(listOrder).prop('checked', true);
		
		var groupId = $('input[name=calendarGroupCheck]').eq(listOrder).val();
		enCalGroup.setSelectedGroupId(groupId);

		if($('#' + groupId + '_isDeletable').val() == 0) {
			$('#deleteButton').css('display', 'none');
		} else {
			$('#deleteButton').css('display', 'inline-block');
		}
		
		enCal.m_work = 'update';
		this.m_currentPage = 1;
		this.detail();
	},
	
	detail : function(){
		enCalGroup.m_selectedTab = 'detail';
		if(this.m_parent.m_work == 'update'){
			var param = "calendarId=" + enCalGroup.getSelectedCalendarId();
			param += "&groupId=" + enCalGroup.getSelectedGroupId();
			if(enCal.m_isUserMode) param += "&isUserPublic=N";
			this.m_ajax.send("POST", this.m_contextPath + this.m_detailUrl, param, true, {success: function(htmlData) {
				var propertyTabs = $("#CalendarManager_GroupPropertyTabs").tabs();
				$('#CalendarManager_GroupDetailTabPage').html(htmlData);
				enCalGroup.initPermissionsCheckboxes();
			}});
		}
	}, 
	
	initPermissionsCheckboxes : function(){
		if($('#permissionsCRUDACheck').is(':checked')){
			$('#permissionsRUCheck').attr('disabled', 'disabled');
			$('#permissionsRUCheck').prop('checked', true);
		} else {
			$('#permissionsRUCheck').removeAttr('disabled');
		}
	},
	
	getGroupPermissions : function(){
		if($('#permissionsCRUDACheck').is(':checked')) return $('#permissionsCRUDACheck').val();
		else {
			if($('#permissionsRUCheck').is(':checked'))  return $('#permissionsRUCheck').val();
			else return $('#permissionsRCheck').val();
		}
	},
	
	getSelectedCalendarId : function(){
		this.m_selectedCalendarId = $('.calendarCheck:checked').val();
		return this.m_selectedCalendarId;
	},
	
	getSelectedGroupId : function(){
		return this.m_selectedGroupId;
	},
	
	setSelectedGroupId : function(groupId){
		this.m_selectedGroupId = groupId;
	}
	
}

/************************************
 **** 메인 함수
 ************************************/
$(document).ready(function(){
	enCal.initTabs();
	enCalDetail.uiList();
	
	//html 키 이벤트 핸들러 등록: F2 키를 누르면 검색필드로 focus 이동하여 바로 입력 할 수 있다.
	$('html').keyup(function(){
		if(event.keyCode == 113){ //f2 key
			$('#searchValue').focus();
		}
	});
});

var enCal = new hancer.cal();
var enCalDetail = new hancer.cal.detail(enCal);
var enCalLang = new hancer.cal.lang(enCal);
var enCalUser = new hancer.cal.user(enCal);
var enCalGroup = new hancer.cal.group(enCal);
var enCalUserPublic = new hancer.cal.userPublic(enCal);