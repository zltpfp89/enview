/**
 * @author saltware
 */

function isAdd(id){
	var $receiver = $('option', '#receiverList');
	var isAdd = false;
	$receiver.each(function(){
		var $this = $(this);
		var rid = $this.attr('id');
		if(id == rid){
			isAdd = true;
		}
	});
	return isAdd;
}
		
function add(){
	var $selected = $('option:selected','#userList');
	$selected.appendTo('#receiverList');
	$selected.removeAttr('selected');
}

function remove(){
	var $selected = $('option:selected','#receiverList');
	$selected.appendTo('#userList');
	$selected.removeAttr('selected');
}

/* 결과 내 검색 */
function resultSearch(){
	var $userList = $('#userList');
	var $options = $('option', $userList);
	var searchWord = $('#userIdorName').val();
	var $serachOptions = groupOptions.filter(':contains("' + searchWord + '")');
	$options.remove();
	$serachOptions.each(function(){
		var $this = $(this);
		$this.appendTo($userList);
	});
}


/* ok button clicked callback function */
function selectUser(){
	$receiverList = $('option','#receiverList');
	var receiverIds = '';
	var receiverNames = ''
	var receiverList = '';
	var i = 1;
	$receiverList.each(function(){
		var $this = $(this);
		if(i == $receiverList.length){
			receiverIds += $this.attr('id');
			receiverNames += $this.val();
			receiverList += '{' + $this.attr('id') + ':' + $this.val() + '}'; 
		}
		else{
			receiverIds += $this.attr('id') + ",";
			receiverNames += $this.val() + ",";
			receiverList += '{' + $this.attr('id') + ':' + $this.val() + '},'; 
		}
		i++;
	});
	$('#receiverIds', opener.document).val(receiverIds);
	$('#receiverNames', opener.document).val(receiverNames);
	$('#receiverList', opener.document).val(receiverList);
	self.close();
}

/************************************
 **** 검색 함수
 ************************************/
function searchUserEnter(event){
	var key = null;
	if(window.event) key = window.event.keyCode;
	else if(event) key = event.which; 

	if(key != 13 && key != 0 && key != 1) return false;
	searchUser();
}
function searchUser(event){
	var searchGroup = $('#searchGroup').val();
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
	$.ajax({
		type: 'POST',
		url: contextPath + '/note/searchUser.hanc',
		data: {
			'searchGroup' : searchGroup,
			'searchType' : searchType,
			'searchValue' : searchValue
		},
		dataType: 'html',
		success: function(html, textStatus){
			$receiverList = $('option','#receiverList');
			if($receiverList.length > 0){
				$('#searchResult').html(html);
				var $receiver = $('#receiverList');
				var $searchUser = $('option', '#userList');
				$receiverList.each(function(){
					var $this = $(this);
					var optionId = $this.attr('id');
					var optionValue = $this.val();
					var optionText = optionValue + '(' + optionId + ')';
					$('<option/>').attr('id', optionId).text(optionText).attr('value', optionValue).appendTo($receiver);
					$searchUser.each(function(){
						var $user = $(this);
						if(optionId == $user.attr('id')){
							$user.remove();
						}
					});
				});
			}else{
				$('#searchResult').html(html);
			}
			
		},
		error: function(x, e){
			alert('잠시 후에 다시 시도 해주십시오.');
		}
	});
}

/************************************
 **** 메인 함수
 ************************************/
//쪽지 관리 초기화 jquery 함수
$(document).ready(function(){
	//초기에는 받은 쪽지함을 보여준다.
	$.ajax({
		type: 'POST',
		url: contextPath + '/note/searchUser.hanc',
		dataType: 'html',
		success: function(html, textStatus){
			$('#searchResult').html(html);
		},
		error: function(x, e){
			alert('잠시 후에 다시 시도 해주십시오.');
		}
	});
	
	//body의 키 이벤트 핸들러 등록: F2 키를 누르면 검색필드로 focus 이동하여 바로 입력 할 수 있다.
	$('body').keyup(function(){
		var key = null;
		if(window.event) key = window.event.keyCode;
		else if(event) key = event.which;
		if(key == null) return;
		if(key == 113){ //f2 key
			$('#searchValue').focus();
		}
	});
});