if( ! window.hancer )
    window.hancer = new Object();

if( ! window.hancer.note )
    window.hancer.note = new Object();


hancer.note = function() {
	this.m_ajax = new enview.util.Ajax();
	this.initContextPath();
}
hancer.note.prototype = {
	m_contextPath : null,
	m_ajax : null,
	
	m_userId : null,
	m_logoutUrl : null,
	
	m_searchType : 0,
	m_searchValue : '',
	
	m_currentPage : 1,
	m_prevPage : 1,
	m_nextPage : 2,
	
	m_currentPrevPage : 1,
	m_currentNextPage : 11,
	
	m_viewBoxName : null,
	
	m_blockedUserName : null,
	m_blockedUserId : null,
	
	/************************************
	 **** 공통 기능
	 ************************************/
	
	initContextPath : function (){
		this.contextPath();
	},
	
	contextPath : function (contextPath) {
		if(contextPath == undefined){
			if (this.m_contextPath != null) return this.m_contextPath;
			var offset = location.href.indexOf(location.host) + location.host.length;
			var uriStr = location.href.substring(offset);
			var pos = 0;
			if ((pos = uriStr.indexOf("/note")) >= 0) {
				this.m_contextPath = uriStr.substring(0,pos);
			}
		}
		else {
			this.m_contextPath = contextPath;
		}
		return this.m_contextPath;	
		
	},
	
	loginUserId : function(userId){
		if(userId == undefined) return this.m_userId;
		else this.m_userId = userId;
	},
	
	logoutUrl : function(logoutUrl){
		if (logoutUrl == undefined) return this.m_logoutUrl;
		else this.m_logoutUrl = logoutUrl;
	},
	
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
	
	//로그아웃
	logout : function(){
		location.href = this.logoutUrl() + "?destination=/note/note.hanc";
	},

	//홈
	goHome : function(){
		location.href = this.contextPath();
	},

	//체크박스 모두 선택/해제
	checkAllNotes : function(){
		var $checkAll = $('#checkAll');
		var $checkboxs = $('input:checkbox.checkbox');
		
		if($checkAll.is(':checked')){
			$checkboxs.prop('checked', true);
		}else{
			$checkboxs.removeAttr('checked');
		}
	},
	
	viewBox : function(viewBoxName){
		if(viewBoxName != undefined) {
			this.m_viewBoxName = viewBoxName;
			this.pageCalc(1);
		}
		if(this.m_viewBoxName == 'send'){
			this.viewSendBox();
		}else if(this.m_viewBoxName == 'receive'){
			this.viewReceiveBox();
		}else if(this.m_viewBoxName == 'store'){
			this.viewStoreBox();
		}else if(this.m_viewBoxName == 'readCheck'){
			this.viewReadCheckBox();
		}else if(this.m_viewBoxName == 'recyclebin'){
			this.viewRecyclebinBox();
		}else{
			
		}
		$('.workmenu').blur();
		$('.boxmenu').blur();
	},
	
	pageCalc : function(page){
		this.m_currentPage = page;
		this.m_prevPage = this.m_currentPage - 1;
		this.m_nextPage = this.m_currentPage + 1;
		this.m_currentPrevPage = this.m_currentPage - 10;
		this.m_currentNextPage = this.m_currentPage + 10;
		
		
		if(this.m_prevPage < 1) this.m_prevPage = 1;
		if(this.m_nextPage > this.m_lastPage) this.m_nextPage = this.m_lastPage;
		
		if(this.m_currentPrevPage < 1) this.m_currentPrevPage = 1;
		if(this.m_currentNextPage > this.m_lastPage) this.m_currentNextPage = this.m_lastPage;
	},
	
	firstPage : function(){
		this.pageCalc(1);
		this.viewBox();
	},
	
	lastPage :function(){
		this.pageCalc(this.m_lastPage);
		this.viewBox();
	},
	
	prevPage : function(){
		this.pageCalc(this.m_prevPage);
		this.viewBox();
	},
	
	nextPage : function(){
		this.pageCalc(this.m_nextPage);
		this.viewBox();
	},
	
	prev10Page : function(){
		this.pageCalc(this.m_currentPrevPage);
		this.viewBox();
	},
	
	next10Page : function(){
		this.pageCalc(this.m_currentNextPage);
		this.viewBox();
	},
	
	goPage : function(page){
		this.pageCalc(page);
		this.viewBox();
	},
	
	reload : function(){
		this.m_currentPage = 1;
		this.viewBox();
	},
	
	//받는 사람 보이기
	viewReceivers : function(pageNumber){
		var page = (pageNumber == undefined ? 1 : pageNumber);
		var param = "noteId=" + $('#noteId').val();
		param += "&currentPage=" + page;
		this.m_ajax.send("POST", this.m_contextPath + "/note/receiverList.hanc", param, true, {success: function(htmlData) {
			enDialog.setOption({
				code: 'mmbrList',
				title: '받는 사람',
				isShowTitle : true,
				isShowButton : false,
				type: 'confirm',
				modal: true,
				opacity: 0.5,
				closeOnEscape: true,
				contents: htmlData,
				draggable: true,
				width: 350,
				height: 210,
				okCallback: function(){
					enDialog.isClose = true;
					enDialog.close();
				},
				cancelCallback : function(){
					enDialog.isClose = true;
				}
			});
			enDialog.open();
		}});
	},

	//받는 사람 감추기
	hideReceivers : function(){
		$('#receivers').css('display','none');
		$('#hideButton').css('display','none');
		$('#deleRcvr').css('display', 'inline-block');
		$('#viewButton').css('display', 'inline-block');
	},

	//쪽지 수만큼 noteList의 높이 지정 
	autoResizeNoteList : function(noteListLength){
		if(noteListLength < 1) {
			$('#noteList').css('height', 25);
		}else{
			$('#noteList').css('height', noteListLength*30);
		}
	},

	//페이지 수만큼 pagingLayer의 너비 지정 
	autoResizePagingLayer : function(pageLenth){
		if(pageLenth< 1) pageLenth = 1;
		if(pageLenth > 10){
			pageLenth = 10;
		}
		$('#pagingButtons').css('width', pageLenth*22 + 80);
	},

	//본문내용의 길이를 limit 변수만큼 체크(한글은 3바이트 영어는 2바이트  ex: limit==1000 한글 333자, 영어 500자)
	checkLength : function(){
		var contents = $('#contents').html();
		var limit = 1000;
		var length = 0;
		var length2 = 0;
		var temp, temp2;
		var newContents = '';
		for(var i = 0 ; i < contents.length; i++){
			temp = contents.charAt(i);
			if(escape(temp).length > 4) length += 2;
			else length += 1;
		}
		$('#limits').html(length + "/" + limit);
		
		if(length > limit){
			for(var i = 0 ; i < contents.length; i++){
				temp2 = contents.charAt(i);
				newContents += temp2;
				if(escape(temp2).length > 4) length2 += 2;
				else length2 += 1;
				if(length2 >= limit){
					if(escape(temp2).length > 4) length2 -= 2;
					else length2 -=1;
					break;
				}
				
			}
			alert('최대 글자 크기 ' + limit + 'byte를 초과하였습니다.\n초과된 글자는 삭제됩니다.');
			$('#contents').html(newContents);
			$('#limits').html(length2 + "/" + limit);
		}
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

	//사용자 검색(받는사람 추가) 페이지 팝업
	search : function(){
		window.open(this.m_contextPath + '/note/search.hanc', 'searchUser','resize=no, menubar=no, toolbar=no, location=no, status=no, scrollbars=no, width=470, height=350');
	},

	//검색 함수
	searchNotes : function(viewbox){
		var searchType = $('#searchType').val();
		var searchValue = $('#searchValue').val();

		if(searchType == undefined || searchType == null || searchType == 0){
			alert('검색할 값을 선택해주세요.');
			$('#searchType').focus();
			return false;
		}
		if(searchValue == undefined || searchValue == null || searchValue == ''){
			alert('검색할 값을 입력해주세요.');
			$('#searchValue').select();
			return false;
		}
		if(searchValue.length < 2){
			alert('검색 할 값은 두글자 이상을 입력해주세요.');
			$('#searchValue').select();
			return false;
		}
		var param = "searchType=" + searchType;
		param += "&searchValue=" + searchValue;
		this.m_ajax.send("POST", this.m_contextPath + "/note/" + viewbox + "Box.hanc", param, true, {success: function(htmlData) { 
			$('#contentsLayer').html(htmlData);
			if(viewbox = 'receive'){
				enNote.initNewNoteAmount();
			}
		}});
	},

	//해당 DOM 절대 값: LEFT
	getAbsLeft : function(element){ 
		if(typeof element!='object') element=document.getElementById(element); 
		var LEFT=0; 
		while(element){ 
			LEFT+=element.offsetLeft; 
			element=element.offsetParent; 
		} 
		return LEFT; 
	} ,

	///해당 DOM 절대 값: TOP
	getAbsTop : function(element){ 
		if(typeof element!='object') element=document.getElementById(element); 
		var TOP=0; 
		while(element){ 
			TOP+=element.offsetTop; 
			element=element.offsetParent; 
		} 
		return TOP; 
	},
	
	changeLanguage : function(){
		var frm = document.getElementById('langKndForm');
		frm.action = this.contextPath() + '/note/note.hanc';
		frm.submit();
	},
	
	//보낸 사람 팝업 메뉴
	popupMenu : function(noteId, senderName, senderId, isBlocked){
		if(this.m_userId == senderId) {
			alert('자기 자신은 차단 할 수 없습니다.');
			return;
		}
		this.m_blockedUserName = senderName;
		this.m_blockedUserId = senderId;
		$('#popupMenu').css('display','inline-block');
		if(isBlocked == 0){
			$('#unblock').css('display','none');
			$('#block').css('display','inline-block');
		}else{
			$('#block').css('display','none');
			$('#unblock').css('display','inline-block');
		}
		$('#popupMenu').css('position', 'absolute');
		$('#popupMenu').css('left', this.getAbsLeft('send_' + noteId)+ 70);
		$('#popupMenu').css('top',this.getAbsTop('send_' + noteId));
		$('#popupMenu').appendTo($('#send_' + noteId));
	},

	blockUser : function(viewBox, currentPage){
		if(!confirm(this.m_blockedUserName + "(" + this.m_blockedUserId + ")" + "님을 차단하시겠습니까?")) return;
		$('#popupMenu').css('display','none');
		var param = "blockedUserId=" + this.m_blockedUserId;
		this.m_ajax.send("POST", this.m_contextPath + "/note/blockUser.hanc", param, true, {success: function(htmlData) { 
			eval('enNote.view' + viewBox +'Box(' + currentPage + ')');
			alert('해당 사용자가 차단목록에 추가되었습니다.');
		}});
	},

	unblockUser : function(viewBox, currentPage){
		if(!confirm(this.m_blockedUserName + "(" + this.m_blockedUserId + ")" + "님을 차단 해제 하시겠습니까?")) return;
		$('#popupMenu').css('display','none');
		var param = "blockedUserId=" + this.m_blockedUserId;
		this.m_ajax.send("POST", this.m_contextPath + "/note/unblockUser.hanc", param, true, {success: function(htmlData) { 
			eval('enNote.view' + viewBox +'Box(' + currentPage + ')');
			alert('해당 사용자가 차단목록에서 제거 되었습니다.');
		}});
	},
	

	/************************************
	 **** 쪽지 고유 CRUD 기능
	 ************************************/
	//새로 받은 쪽지 수 받아오기
	initNewNoteAmount : function(){
		var param = "";
		this.m_ajax.send("POST", this.m_contextPath + "/note/newNote.hanc", param, true, {success: function(htmlData) { 
			$('#newNote').html(htmlData);
		}});
	},
	
	//쪽지 쓰기 폼
	viewWriteForm : function(receiverIds){
		var param = "";
		param += "receiverIds=" + receiverIds;
		this.m_ajax.send("POST", this.m_contextPath + "/note/writeForm.hanc", param, true, {success: function(htmlData) { 
			$('#contentsLayer').html(htmlData);
			if(receiverIds) {
				$('#isPopup').val("true");
				
			} else {
				$('#writeNote').addClass('selected');
				$('.workmenu').removeClass('selected');
				$('.boxmenu').removeClass('selected');
				$('.workmenu').blur();
				$('.boxmenu').blur();
				$('#isPopup').val("false");
			}
		}});
	},

	//답장 쓰기 폼
	viewReplyForm : function(){
		var param = "&noteId=" + $('#noteId').val();
		this.m_ajax.send("POST", this.m_contextPath + "/note/replyForm.hanc", param, true, {success: function(htmlData) {
			$('#isPopup').val("false");
			$('.workmenu').removeClass('selected');
			$('.boxmenu').removeClass('selected');
			$('#writeNote').addClass('selected');
			$('#contentsLayer').html(htmlData);
		}});
	},

	//쪽지 삭제
	deleteNote: function(noteId, noteType, viewBox){
		var confirmMassage = "삭제하시겠습니까?";
		if(viewBox == 4) confirmMassage = "영구 " + confirmMassage;
		if(!confirm(confirmMassage)) return;
		var param = "noteId=" + noteId;
		param += "&noteType=" + noteType;
		this.m_ajax.send("POST", this.m_contextPath + "/note/deleteNote.hanc", param, true, {success: function(htmlData) { 
			if(noteType == 0){
				enNote.viewBox('send');
			}else if(noteType == 1){
				enNote.viewBox('receive');
			}
			alert('쪽지가 삭제되었습니다.');
		}});
	},

	//쪽지 보관하기
	storeNote : function(noteId, noteType){
		if(!confirm("보관하시겠습니까?")) return;
		var param = "noteId=" + noteId;
		param += "&noteType=" + noteType;
		this.m_ajax.send("POST", this.m_contextPath + "/note/storeNote.hanc", param, true, {success: function(htmlData) { 
			if(noteType == 0){
				enNote.viewBox('send');
			}else if(noteType == 1){
				enNote.viewBox('receive');
			}
			alert('쪽지가 보관되었습니다.');
		}});
	},

	//쪽지 복원하기
	restoreNote : function(noteId, noteType){
		if(!confirm("복구하시겠습니까?")) return;
		var param = "noteId=" + noteId;
		param += "&noteType=" + noteType;
		this.m_ajax.send("POST", this.m_contextPath + "/note/restoreNote.hanc", param, true, {success: function(htmlData) { 
			enNote.viewBox('recyclebin');
			enNote.initNewNoteAmount();
			alert('쪽지가 복구되었습니다.');
		}});
	},

	//보낸 쪽지 보기
	readSendNote : function(noteId) {
		var param = "noteId=" + noteId;
		param += "&viewBox=" + $('#viewBox').val();
		param += "&currentPage=" + $('#currentPage').val();
		this.m_ajax.send("POST", this.m_contextPath + "/note/readSendNote.hanc", param, true, {success: function(htmlData) { 
			$('#contentsLayer').html(htmlData);
		}});
	},

	//받은 쪽지 보기
	readReceiveNote : function(noteId) {
		var param = "noteId=" + noteId;
		param += "&viewBox=" + $('#viewBox').val();
		param += "&currentPage=" + $('#currentPage').val();
		this.m_ajax.send("POST", this.m_contextPath + "/note/readReceiveNote.hanc", param, true, {success: function(htmlData) { 
			$('#contentsLayer').html(htmlData);
			enNote.initNewNoteAmount();
		}});
	},


	//쪽지 보내기(검증 및 submit)
	validationWrite : function(){
		var $title = $('#title');
		var $receiverIds = $('#receiverIds');
		var $contents = $('#contents');
		var $fileIds = $('#fileIds');
		var readChecks = document.getElementsByName('readCheck');
		var readCheck = 0;
		for(var i = 0; i < readChecks.length ; i++){
			if($(readChecks[i]).is(':checked')){
				readCheck = $(readChecks[i]).val();
				break;
			}
		}
		if($receiverIds.val() == '' || $receiverIds.val() == 'undefined'){
			alert('받는 사람을 선택하세요');
			this.search();
			return false;
		}
		else if($title.val() == ''){
			alert('제목을 입력하세요');
			$title.select();
			return false;
		}
		else if($contents.val() == ''){
			alert('내용을 입력하세요');
			$content.select();
			return false;
		}
		
		//파일 매니저에서 업로드 된 파일 ID를 가져오는 부분
		var fileIds = $('#sfileIds', fileManager.document).val();
		$fileIds.val(fileIds);
		
		var param = "title=" + $title.val();
		param += "&receiverIds=" + $receiverIds.val();
		param += "&contents=" + $contents.val();
		param += "&fileIds=" + fileIds;
		param += "&readCheck=" + readCheck;
		this.m_ajax.send("POST", this.m_contextPath + "/note/write.hanc", param, true, {success: function(htmlData) { 
			if($('#isPopup').val() == "true"){
				alert('쪽지가 발송되었습니다.');
				self.close();
			}else {
				enNote.m_viewBoxName = 'send';
				enNote.viewSendBox(1);
				alert('쪽지가 발송되었습니다.');
			}
		}});
	},
	
	/************************************
	 **** ReceiveBox(받은쪽지함) 기능
	 ************************************/
	//받은쪽지함 보기
	viewReceiveBox : function(currentPage){
		$('#receive_searchType').val() == undefined ? this.m_searchType = 0 : this.m_searchType = $('#receive_searchType').val();
		$('#receive_searchValue').val() == undefined ? this.m_searchValue = '' : this.m_searchValue = $('#receive_searchValue').val();
		var page = (currentPage == undefined ? this.m_currentPage: currentPage);
		var param = "currentPage=" + page;
		param += "&searchType=" + this.m_searchType;
		param += "&searchValue=" + this.m_searchValue;
		
		this.m_ajax.send("POST", this.m_contextPath + "/note/receiveBox.hanc", param, true, {success: function(htmlData) { 
			$('#contentsLayer').html(htmlData);
			$('.workmenu').removeClass('selected');
			$('#readNote').addClass('selected');
			$('.boxmenu').removeClass('selected');
			$('#receiveboxmenu').addClass('selected');
		}});
	},

	//받은쪽지함 검색
	searchReceiveNotes : function(event){
		var key = null;
		if(window.event) key = window.event.keyCode;
		else if(event) key = event.which;
		if(key != 13 && key != 0 && key != 1) return false;
		this.searchNotes('receive');
	},

	//받은쪽지 삭제하기
	deleteReceiveNotes : function(){
		var $checkboxs = $('input:checkbox[id!=checkAll]:checked');
		if($checkboxs.length <= 0) { alert("선택된 쪽지가 없습니다."); return; }
		if(!confirm("선택된  " + $checkboxs.length + "개의 쪽지를 삭제하시겠습니까?")) return;
		var noteIds = '';
		$checkboxs.each(function(){
			var $this = $(this);
			noteIds += $this.attr('id') + ",";
		});
		noteIds = noteIds.substring(0, noteIds.length-1);
		var param = "noteIds=" + noteIds;
		this.m_ajax.send("POST", this.m_contextPath + "/note/deleteReceiveNotes.hanc", param, true, {success: function(htmlData) { 
			enNote.viewBox('receive');
			enNote.initNewNoteAmount();
			alert('쪽지가 삭제되었습니다.');
		}});
	},

	//받은 쪽지 보관하기
	storeReceiveNotes : function(){
		var $checkboxs = $('input:checkbox[id!=checkAll]:checked');
		if($checkboxs.length <= 0) { alert("선택된 쪽지가 없습니다."); return; }
		if(!confirm("선택된  " + $checkboxs.length + "개의 쪽지를 보관하시겠습니까?")) return;
		var noteIds = '';
		$checkboxs.each(function(){
			var $this = $(this);
			noteIds += $this.attr('id') + ",";
		});
		noteIds = noteIds.substring(0, noteIds.length-1);
		var param = "noteIds=" + noteIds;
		this.m_ajax.send("POST", this.m_contextPath + "/note/storeReceiveNotes.hanc", param, true, {success: function(htmlData) { 
			enNote.viewBox('receive');
			enNote.initNewNoteAmount();
			alert('쪽지가 보관되었습니다.');
		}});
	},


	/************************************
	 **** SendBox(보낸쪽지) 기능
	 ************************************/
	//보낸쪽지함 보기
	viewSendBox : function(currentPage){
		$('#send_searchType').val() == undefined ? this.m_searchType = 0 : this.m_searchType = $('#send_searchType').val();
		$('#send_searchValue').val() == undefined ? this.m_searchValue = '' : this.m_searchValue = $('#send_searchValue').val();
		var page = (currentPage == undefined ? this.m_currentPage: currentPage);
		var param = "currentPage=" + page;
		param += "&searchType=" + this.m_searchType;
		param += "&searchValue=" + this.m_searchValue;
		this.m_ajax.send("POST", this.m_contextPath + "/note/sendBox.hanc", param, true, {success: function(htmlData) { 
			$('.workmenu').removeClass('selected');
			$('.boxmenu').removeClass('selected');
			$('#sendboxmenu').addClass('selected');
			$('#contentsLayer').html(htmlData);
		}});
	},

	//보낸쪽지함 검색
	searchSendNotes : function(event){
		var key = null;
		if(window.event) key = window.event.keyCode;
		else if(event) key = event.which;
		if(key != 13 && key != 0 && key != 1) return false;
		this.searchNotes('send');
	},

	//보낸쪽지 삭제하기
	deleteSendNotes : function(){
		var $checkboxs = $('input:checkbox[id!=checkAll]:checked');
		if($checkboxs.length <= 0) { alert("선택된 쪽지가 없습니다."); return; }
		if(!confirm("선택된  " + $checkboxs.length + "개의 쪽지를 삭제하시겠습니까?")) return;
		var noteIds = '';
		$checkboxs.each(function(){
			var $this = $(this);
			noteIds += $this.attr('id') + ",";
		});
		noteIds = noteIds.substring(0, noteIds.length-1);
		var param = "noteIds=" + noteIds;
		this.m_ajax.send("POST", this.m_contextPath + "/note/deleteSendNotes.hanc", param, true, {success: function(htmlData) { 
			enNote.viewBox('send');
			alert('쪽지가 삭제되었습니다.');
		}});
	},

	//보낸 쪽지 보관하기
	storeSendNotes : function(){
		var $checkboxs = $('input:checkbox[id!=checkAll]:checked');
		if($checkboxs.length <= 0) { alert("선택된 쪽지가 없습니다."); return; }
		if(!confirm("선택된  " + $checkboxs.length + "개의 쪽지를 보관하시겠습니까?")) return;
		var noteIds = '';
		$checkboxs.each(function(){
			var $this = $(this);
			noteIds += $this.attr('id') + ",";
		});
		noteIds = noteIds.substring(0, noteIds.length-1);
		var param = "noteIds=" + noteIds;
		this.m_ajax.send("POST", this.m_contextPath + "/note/storeSendNotes.hanc", param, true, {success: function(htmlData) { 
			enNote.viewBox('send');
			alert('쪽지가 보관되었습니다.');
		}});
	},
	
	
	/************************************
	 **** StoreBox(영구보관함) 기능
	 ************************************/
	//쪽지보관함 보기
	viewStoreBox : function(currentPage){
		$('#store_searchType').val() == undefined ? this.m_searchType = 0 : this.m_searchType = $('#store_searchType').val();
		$('#store_searchValue').val() == undefined ? this.m_searchValue = '' : this.m_searchValue = $('#store_searchValue').val();
		var page = (currentPage == undefined ? this.m_currentPage: currentPage);
		var param = "currentPage=" + page;
		param += "&searchType=" + this.m_searchType;
		param += "&searchValue=" + this.m_searchValue;
		this.m_ajax.send("POST", this.m_contextPath + "/note/storeBox.hanc", param, true, {success: function(htmlData) { 
			$('.workmenu').removeClass('selected');
			$('.boxmenu').removeClass('selected');
			$('#storeboxmenu').addClass('selected');
			$('#contentsLayer').html(htmlData);
		}});
	},

	//영구보관함 검색
	searchStoreNotes : function(event){
		var key = null;
		if(window.event) key = window.event.keyCode;
		else if(event) key = event.which;
		if(key != 13 && key != 0 && key != 1) return false;
		this.searchNotes('store');
	},

	//보관된 쪽지 삭제하기
	deleteStoreNotes : function(){
		var $checkboxs = $('input:checkbox[id!=checkAll]:checked');
		if($checkboxs.length <= 0) { alert("선택된 쪽지가 없습니다."); return; }
		if(!confirm("선택된  " + $checkboxs.length + "개의 쪽지를 삭제하시겠습니까?")) return;
		var noteIds = '';
		$checkboxs.each(function(){
			var $this = $(this);
			noteIds += $this.attr('id') + ",";
		});
		noteIds = noteIds.substring(0, noteIds.length-1);
		var param = "noteIds=" + noteIds;
		this.m_ajax.send("POST", this.m_contextPath + "/note/deleteStoreNotes.hanc", param, true, {success: function(htmlData) { 
			enNote.viewBox('store');
			alert('쪽지가 삭제되었습니다.');
		}});
	},
	
	
	/************************************
	 **** ReadCheckBox(수신확인함) 기능
	 ************************************/
	//수신확인함 보기
	viewReadCheckBox : function(currentPage){
		$('#readCheck_searchType').val() == undefined ? this.m_searchType = 0 : this.m_searchType = $('#readCheck_searchType').val();
		$('#readCheck_searchValue').val() == undefined ? this.m_searchValue = '' : this.m_searchValue = $('#readCheck_searchValue').val();
		var page = (currentPage == undefined ? this.m_currentPage: currentPage);
		var param = "currentPage=" + page;
		param += "&searchType=" + this.m_searchType;
		param += "&searchValue=" + this.m_searchValue;
		this.m_ajax.send("POST", this.m_contextPath + "/note/readCheckBox.hanc", param, true, {success: function(htmlData) { 
			$('.workmenu').removeClass('selected');
			$('.boxmenu').removeClass('selected');
			$('#readcheckboxmenu').addClass('selected');
			$('#contentsLayer').html(htmlData);
		}});
	},

	//수신확인함 검색
	searchReadCheckNotes : function(event){
		var key = null;
		if(window.event) key = window.event.keyCode;
		else if(event) key = event.which;
		if(key != 13 && key != 0 && key != 1) return false;
		this.searchNotes('readCheck');
	},

	//수신확인 쪽지 삭제하기
	deleteReadCheckNotes : function(){
		var $checkboxs = $('input:checkbox[id!=checkAll]:checked');
		if($checkboxs.length <= 0) { alert("선택된 쪽지가 없습니다."); return; }
		if(!confirm("선택된  " + $checkboxs.length + "개의 수신확인 목록을 삭제하시겠습니까?")) return;
		var noteIdWithReceiverIds = '';
		$checkboxs.each(function(){
			var $this = $(this);
			noteIdWithReceiverIds += $this.attr('id') + ",";
		});
		noteIdWithReceiverIds = noteIdWithReceiverIds.substring(0, noteIdWithReceiverIds.length-1);
		var param = "noteIdWithReceiverIds=" + noteIdWithReceiverIds;
		this.m_ajax.send("POST", this.m_contextPath + "/note/deleteReadCheckNotes.hanc", param, true, {success: function(htmlData) { 
			enNote.viewBox('readCheck');
			alert('수신확인 목록이 삭제되었습니다.');
		}});
	},
	
	
	
	/************************************
	 **** RecyclebinBox(휴지통) 기능
	 ************************************/
	//휴지통 보기
	viewRecyclebinBox : function(currentPage){
		$('#recyclebin_searchType').val() == undefined ? this.m_searchType = 0 : this.m_searchType = $('#recyclebin_searchType').val();
		$('#recyclebin_searchValue').val() == undefined ? this.m_searchValue = '' : this.m_searchValue = $('#recyclebin_searchValue').val();
		var page = (currentPage == undefined ? this.m_currentPage: currentPage);
		var param = "currentPage=" + page;
		param += "&searchType=" + this.m_searchType;
		param += "&searchValue=" + this.m_searchValue;
		this.m_ajax.send("POST", this.m_contextPath + "/note/recyclebinBox.hanc", param, true, {success: function(htmlData) { 
			$('.workmenu').removeClass('selected');
			$('.boxmenu').removeClass('selected');
			$('#recyclebinboxmenu').addClass('selected');
			$('#contentsLayer').html(htmlData);
		}});
	},

	searchRecyclebinNotes : function(event){
		var key = null;
		if(window.event) key = window.event.keyCode;
		else if(event) key = event.which;
		if(key != 13 && key != 0 && key != 1) return false;
		this.searchNotes('recyclebin');
	},

	//삭제된 쪽지 영구 삭제하기
	deleteRecyclebinNotes : function(){
		var $checkboxs = $('input:checkbox[id!=checkAll]:checked');
		if($checkboxs.length <= 0) { alert("선택된 쪽지가 없습니다."); return; }
		if(!confirm("선택된  " + $checkboxs.length + "개의 쪽지를 영구 삭제하시겠습니까?")) return;
		var noteIds = '';
		$checkboxs.each(function(){
			var $this = $(this);
			noteIds += $this.attr('id') + ",";
		});
		noteIds = noteIds.substring(0, noteIds.length-1);
		var param = "noteIds=" + noteIds;
		this.m_ajax.send("POST", this.m_contextPath + "/note/deleteRecyclebinNotes.hanc", param, true, {success: function(htmlData) { 
			enNote.viewBox('recyclebin');
			alert('쪽지가 영구삭제되었습니다.');
		}});
	},

	//삭제된 쪽지 복원하기
	restoreRecyclebinNotes : function(noteId, noteType){
		var $checkboxs = $('input:checkbox[id!=checkAll]:checked');
		if($checkboxs.length <= 0) { alert("선택된 쪽지가 없습니다."); return; }
		if(!confirm("선택된  " + $checkboxs.length + "개의 쪽지를 복원하시겠습니까?")) return;
		var noteIds = '';
		$checkboxs.each(function(){
			var $this = $(this);
			noteIds += $this.attr('id') + ",";
		});
		noteIds = noteIds.substring(0, noteIds.length-1);
		var param = "noteIds=" + noteIds;
		this.m_ajax.send("POST", this.m_contextPath + "/note/restoreRecyclebinNotes.hanc", param, true, {success: function(htmlData) { 
			enNote.viewBox('recyclebin');
			enNote.initNewNoteAmount();
			alert('쪽지가 복원되었습니다.');
		}});
	},
	
	
	
	/************************************
	 **** 환경 설정 기능
	 ************************************/
	//환경설정 페이지 불러오기
	viewUserOptionForm : function(){
		var param = "";
		this.m_ajax.send("POST", this.m_contextPath + "/note/userOption.hanc", param, true, {success: function(htmlData) { 
			$('.workmenu').removeClass('selected');
			$('.boxmenu').removeClass('selected');
			$('.workmenu').blur();
			$('.boxmenu').blur();
			$('#userOption').addClass('selected');
			$('#contentsLayer').html(htmlData);
		}});
	},

	//받은 쪽지함 삭제하기
	emptyReceiveBox : function(){
		if(!confirm("받은쪽지함을 비우시겠습니까?")) return;
		var param = "";
		this.m_ajax.send("POST", this.m_contextPath + "/note/emptyReceiveBox.hanc", param, true, {success: function(htmlData) { 
			enNote.viewUserOptionForm();
			alert('받은쪽지함을 비웠습니다.');
		}});
	},

	//보낸 쪽지함 모두 삭제하기
	emptySendBox : function(){
		if(!confirm("보낸쪽지함을 비우시겠습니까?")) return;
		var param = "";
		this.m_ajax.send("POST", this.m_contextPath + "/note/emptySendBox.hanc", param, true, {success: function(htmlData) { 
			enNote.viewUserOptionForm();
			alert('보낸쪽지함을 비웠습니다.');
		}});
	},

	//수신확인함 모두 삭제하기
	emptyReadCheckBox : function(){
		if(!confirm("수신확인함을 비우시겠습니까?")) return;
		var param = "";
		this.m_ajax.send("POST", this.m_contextPath + "/note/emptyReadCheckBox.hanc", param, true, {success: function(htmlData) { 
			enNote.viewUserOptionForm();
			alert('수신확인함을 비웠습니다.');
		}});
	},

	//휴지통 모두 삭제하기
	emptyRecyclebinBox : function(){
		if(!confirm("휴지통을 비우시겠습니까?")) return;
		var param = "";
		this.m_ajax.send("POST", this.m_contextPath + "/note/emptyRecyclebinBox.hanc", param, true, {success: function(htmlData) { 
			enNote.viewUserOptionForm();
			alert('휴지통을 비웠습니다.');
		}});
	},

	//받은 쪽지함 백업하기
	backupReceiveBox : function(){
		if(!confirm("보낸 쪽지함을 백업하시겠습니까?")) return;
		location.href= this.contextPath() + '/note/backupReceiveBox.hanc';
	},

	//보낸 쪽지함 백업하기
	backupSendBox : function(){
		if(!confirm("보낸 쪽지함을 백업하시겠습니까?")) return;
		location.href= this.contextPath() + '/note/backupSendBox.hanc';
	},

	//영구 보관함 백업하기
	backupStoreBox : function(){
		if(!confirm("영구 보관함을 백업하시겠습니까?")) return;
		location.href= this.contextPath() + '/note/backupStoreBox.hanc';
	},

	//안읽은 쪽지 읽음 표시 하기
	readAllNotes : function(){
		if(!confirm("안읽은 쪽지를 모두 읽음표시 하시겠습니까?")) return;
		var param = "";
		this.m_ajax.send("POST", this.m_contextPath + "/note/readAllNotes.hanc", param, true, {success: function(htmlData) { 
			enNote.viewUserOptionForm();
			alert('앉읽은 쪽지를 모두 읽음표시 하였습니다.');
		}});
	},

	//사용자 보관함 열기
	receiveSetting : function(){
		if(!confirm("수신 설정을 변경하시겠습니까?")) return;
		var isReceiveNote = $('input[name=isReceiveNote]:checked').val();
		var param = "isReceiveNote=" + isReceiveNote;
		this.m_ajax.send("POST", this.m_contextPath + "/note/receiveSetting.hanc", param, true, {success: function(htmlData) { 
			enNote.viewUserOptionForm();
			alert('수신설정을 변경하였습니다.');
		}});
	}
}

hancer.note.Dialog = function () { }
hancer.note.Dialog.prototype = {
		
	code: null,
	
	opt : null,
	code : null,
	
	curX : null,
	curY : null,
	
	dialogPanel : null,
	width : null,
	height: null,
	titlePanelHeight : 27,
	btnPanelHeight: 35,
	
	type: 'dialog',
	
	titlePanel : null,
	title : '타이틀',
	isShowTitle : true,
	
	contentPanel : null,
	contents : null,
	buttonPanel : null,
	okButton : '확인',
	cancelButton : '취소',
	isShowButton : true,
	
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
	
	isClose : true,
	
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
		this.process();
	},
	
	process : function() {
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
   		this.dialogPanel.css('background-color', 'white');
   		this.dialogPanel.appendTo($('body'));
   		
   		if(this.getValue('isShowTitle')){
   			this.titlePanel = $('<div id="dialogTitle" class="dialog-title btnArea" style="padding-top:0px; font-weight:bold;">' + this.getValue('title') + '</div>');
   			
   			var buttonSpan = $('<span class="pageBtn"></span>');
   			var buttonA = $('<a id="titleCloseBtn" class="btn_type01" style="padding-left:0px; width: 44px;" title="close"></a>');
   			buttonA.css('width', '38px');
   			var buttonText = $('<span>닫기</span>');
   			buttonText.css('width', '24px');
   			buttonText.css('padding-left', '4px');
   			buttonText.css('text-indent', '0px');
   			buttonText.appendTo(buttonA);
   			buttonA.appendTo(buttonSpan);
   			buttonSpan.appendTo(this.titlePanel);
   			
	   		this.titlePanel.css('width', this.getValue('width')-4 + 'px');
	   		this.titlePanel.css('height', this.getValue('titlePanelHeight')-2 + 'px');
	   		this.titlePanel.css('margin', '0px auto');
	   		this.titlePanel.css('position', 'relative');
	   		this.titlePanel.css('top', '2px');
	   		this.titlePanel.css('font-size', '13px');
	   		this.titlePanel.css('text-indent', '5px');
	   		this.titlePanel.css('line-height', this.getValue('titlePanelHeight') + 'px');
	   		this.titlePanel.css('background-image', 'url("' + enNote.m_contextPath  + '/hancer/images/note/enview/controlPanel.gif")');
	   		this.titlePanel.appendTo(this.dialogPanel);
   		}
   		
   		this.contentPanel = $('<div id="dialogContents" class="dialog-contents"></div>');
   		this.contentPanel.html(this.getValue('contents'));
   		this.contentPanel.css('width', this.getValue('width'));
   		this.contentPanel.css('height', this.getValue('height'));
   		this.contentPanel.appendTo(this.dialogPanel);
   		var pageCount = $('#pagePanel .page').length;
   		var width = 25 * pageCount + 29;
   		$('#pagePanel').css('width', width);
   		
   		if(this.getValue('isShowButton')) {
	   		if(!this.getValue('buttons')){
	   			if(this.getValue('type') == '' || this.getValue('type') == 'dialog'){
	   				this.buttonPanel = $('<div class="dialog-buttons"><input id="dialogOkBtn" class="bottomBtn" type="button" value="' + this.getValue('okButton') + '"><input id="dialogCancelBtn" class="bottomBtn" type="button" value="' + this.getValue('cancelButton') + '"></div>');
	   			} else if(this.getValue('type') == 'confirm'){
	   				this.buttonPanel = $('<div class="dialog-buttons"><input id="dialogOkBtn" class="bottomBtn" type="button" value="' + this.getValue('okButton') + '"></div>');
	   			}
		   		this.buttonPanel.css('width', this.getValue('width')-13);
		   		this.buttonPanel.css('height', this.getValue('btnPanelHeight'));
		   		this.buttonPanel.appendTo(this.dialogPanel);
	   		} else {
	   			this.buttonPanel = $(this.getValue('buttons'));
	   			this.buttonPanel.appendTo(this.dialogPanel);
	   		}
   		}
   		
   		this.setPosition();
   		this.bind();
   		
   		if(this.getValue('showCallback') != null) {
   			this.showCallback = this.getValue('showCallback');
   			this.showCallback();
   		}
	},
	
	close : function () {
		if(this.isClose){
			this.unbind();
			this.dialogPanel.remove();
			this.modalPanel.remove();
			this.isOpen = false;
			
			if(this.getValue('closeCallback') != null) {
	   			this.closeCallback = this.getValue('closeCallback');
	   			this.closeCallback();
	   		}
		}
	},
	
	reOpenInit : function (){
		this.unbind();
		if(this.dialogPanel != null) this.dialogPanel.remove();
		if(this.modalPanel != null) this.modalPanel.remove();
	},
		
	bind : function () {
		var cfDialog = this;
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

var enNote = new hancer.note();
var enDialog = new hancer.note.Dialog();

/************************************
 **** 메인 함수
 ************************************/
//쪽지 관리 초기화 jquery 함수
$(document).ready(function(){
	
});
