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
	m_work : null,
	
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
		enCate.m_contextPath = this.m_contextPath;
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
	
	popupCategory : function() {
		window.open('/enview/hancer/rss/categoryList.hanc','categories', "width=700px, height=400px, scrollbars=yes, resize=yes" );
	}
}

hancer.rss.category = function(parent) {
	this.m_parent = parent;
	this.m_ajax = parent.m_ajax;
	
	this.m_listUrl		=	"/hancer/rss/categoryList.hanc";
	this.m_insertUrl	=	"/hancer/rss/insertCategory.hanc";
	this.m_updateUrl	=	"/hancer/rss/updateCategory.hanc";
	this.m_deleteUrl	=	"/hancer/rss/deleteCategory.hanc";
}
hancer.rss.category.prototype = {
	m_parent : null,
	m_contextPath : null,
	
	m_listUrl : null,
	m_insertUrl : null,
	m_updateUrl : null,
	m_deleteUrl : null,
	
	reload : function(){
		if(opener) opener.enFeed.uiList();
		location.href = this.m_contextPath + this.m_listUrl;
	},
	
	insert : function() {
		if($('#categoryName').val()=='') {
			alert('카테고리명을 입력하십시오.');
			$('#categoryName').focus();
			return;
		}
		
		if(!confirm('[' + $('#categoryName').val() + '] 카테고리를 추가하시겠습니까?')) return;
		var param = "name=" + $('#categoryName').val();
		param += "&domainId=" + $('#domainId').val();
		this.m_ajax.send("POST", this.m_contextPath + this.m_insertUrl, param, true, {success: function(htmlData) { 
			alert(htmlData);
			enCate.reload();
		}});
	},
	
	update : function(categoryId) {
		if(!confirm('[' + $('#org_categoryName_' + categoryId).val() + '] 카테고리를  [' + $('#categoryName_' + categoryId).val() + ']로 수정하시겠습니까?')) return;
		var param = "id=" + $('#categoryId_' + categoryId).val();
		param += "&name=" + $('#categoryName_' + categoryId).val();
		this.m_ajax.send("POST", this.m_contextPath + this.m_updateUrl, param, true, {success: function(htmlData) { 
			alert(htmlData);
			enCate.reload();
		}});
	},

	remove : function(categoryId) {
		if(!confirm('[' + $('#categoryName_' + categoryId).val() + '] 카테고리를 삭제하시겠습니까?')) return;
		var param = "id=" + $('#categoryId_' + categoryId).val();
		this.m_ajax.send("POST", this.m_contextPath + this.m_deleteUrl, param, true, {success: function(htmlData) { 
			alert(htmlData);
			enCate.reload();
		}});
	}
}
	
/************************************
 **** 메인 함수
 ************************************/
//쪽지 관리 초기화 jquery 함수
$(document).ready(function(){
	//초기에는 스킨 리스트를 보여준다.
	
	//html 키 이벤트 핸들러 등록: F2 키를 누르면 검색필드로 focus 이동하여 바로 입력 할 수 있다.
	$('html').keyup(function(){
		if(event.keyCode == 113){ //f2 key
			$('#categoryName').focus();
		}
	});
	$('#categoryName').keyup(function(){
		if(event.keyCode == 13){ //Enter key
			enCate.insert();
		}
	});
});

var enRss = new hancer.rss();
var enCate = new hancer.rss.category(enRss);
