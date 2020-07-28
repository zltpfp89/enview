function fn_myMenuList(){
	var type = "footer";
	var obj = document.getElementById("footMyMenuList");
	obj.innerHTML = "";
	
	fn_ajax({
		url : getContextPath() + "/personalMenu/personalMenuJson.face?m=userMyMenu"
		, callback : { success : function (data) { fn_gnbMyMenuSuccess( data, obj, type ); } }
	});
}

function fn_gnbMyMenu(){
	var type = "gnb";
	var obj = document.getElementById("gnbMyMenuList");
	obj.innerHTML = "";
	
	fn_ajax({
		url : getContextPath() + "/personalMenu/personalMenuJson.face?m=userMyMenu"
		, callback : { success : function (data) { fn_gnbMyMenuSuccess( data, obj, type ); } }
	});
}

function fn_gnbMyMenuSuccess(data, obj, type) {
	if(data.status == "success"){
		var htm = "";
		
		if(data.length > 0){
			$(data.list).each(function(index){
				if(type == "gnb"){
					htm += "<li>";
					htm += "<a href=\""
					
					if(this.target == "_self"){
						htm += this.path;
					} else {
						htm += "javascript: fn_menuLink('" + this.url + "', '" + this.target + "', '" + this.pageId + "');"
					}
					
					htm += "\">";
					htm += this.shortTitle;
					htm += "</a>";
					htm += "</li>"; 
				} else if(type == "footer"){
					htm += "<li>";
					htm += "<input type=\"radio\" id=\"chkMyMenuId" + this.pageId + "\" name=\"chkMyMenu\" onclick=\"javascript: fn_selectMyMenu(this.parentNode, '" + this.pageId + "');\" value=\"" + this.pageId + "|" + this.shortTitle + "\" />";
					htm += "<label class=\"cursor\" for=\"chkMyMenuId" + this.pageId + "\" id=\"chkMyMenuA" + this.pageId + "\" onclick=\"javascript: fn_selectMyMenu(this, '" + this.pageId + "');\">" + this.shortTitle  + "</label>";
					htm += "</li>";
					
					fn_initNameChange();
				}
			});
		} else {
			if(type == "gnb"){
				htm = "<li><a>등록된 나의메뉴가 존재하지 않습니다.</a></li>";
			} else if(type == "footer"){
				htm = "<li><label>등록된 나의메뉴가 존재하지 않습니다.</label></li>";
				fn_initNameChange();
			}
		}
		
		obj.innerHTML = htm;
	} else {
		alert(data.msg);
		if(type == "footer") fn_hideBlockPopup();
	}
}

function fn_initNameChange(){
	var nameChange = document.getElementById("myMenuNameChange");
	var selectId = document.getElementById("selectMyMenuId"); 
	
	nameChange.readOnly = true;
	nameChange.value = "";
	selectId.value = "";
}

function fn_isMenu(pageId){
	var node = document.getElementsByName("chkMyMenu");
	var chk = false;
	
	for(var i = 0; i < node.length; i++){
		var arr = node[i].value.split("|");
		
		if(arr[0] == pageId){
			chk = true;
			break;
		}
	}
	
	return chk;
}
/*
function fn_addMyMenu(pageId, shortTitle){
	var area = document.getElementById("footMyMenuList");
	var htm = "";
	
	if(!isDefined(pageId)){
		alert("pageId가 비었습니다.");
		return;
	} else if(!isDefined(shortTitle)){
		alert("shortTitle이 비었습니다.");
		return;
	}
	
	if($("input[name=chkMyMenu]").length == 0){
		area.innerHTML = "";
		fn_initNameChange();
	} else {
		if(fn_isMenu(pageId)){
			alert("이미 등록된 메뉴입니다.");
			return;
		}
	}
	
	htm = "<li>";
	htm += "<label class=\"cursor\">";
	htm += "<input type=\"checkbox\" id=\"chkMyMenuId" + pageId + "\" name=\"chkMyMenu\" value=\"" + pageId + "|" + shortTitle + "\" /> <a href=\"javascript: void(0);\" id=\"chkMyMenuA" + pageId + "\" onclick=\"javascript: fn_selectMyMenu(this, '" + pageId + "', this)\">" + shortTitle + "</a>";
	htm += "</label>";
	htm += "</li>";
	
	area.innerHTML = area.innerHTML + htm;
}
*/
function fn_selectMyMenu(obj, pageId){
	if(!isDefined(pageId)){
		alert("pageId가 비었습니다.");
		return;
	}
	
	document.getElementById("myMenuNameChange").readOnly = false;
	document.getElementById("myMenuNameChange").value = obj.textContent;
	document.getElementById("selectMyMenuId").value = pageId;
}

function fn_changeMyMenu(){
	var txt = document.getElementById("myMenuNameChange");
	var selectId = document.getElementById("selectMyMenuId");
	
	if(!isDefined(selectId.value)){
		alert("선택된 메뉴가 없습니다. 선택 후 적용하십시오.");
		return;
	} else if(!isDefined(txt.value)){
		alert("변경될 이름을 입력하십시오.");
		txt.focus();
		return;
	} 
	
	if($("input[name=chkMyMenu]").length == 0){
		alert("메뉴목록이 존재하지 않습니다.");
		fn_initNameChange();
		return;
	} else {
		if(!fn_isMenu(selectId.value)){
			alert("선택된 메뉴가 존재하지 않습니다.");
			fn_initNameChange();
			return;
		}
	}
	
	document.getElementById("chkMyMenuId" + selectId.value).value = selectId.value + "|" + txt.value;
	document.getElementById("chkMyMenuA" + selectId.value).textContent = txt.value;
}

function fn_deleteMyMenu(){
	var obj = document.getElementsByName("chkMyMenu");
	
	if(obj.length != 0){
		var chk = false;
		
		for(var i = 0; i < obj.length; i++){
			if(obj[i].checked == true){
				if(!chk) chk = true;
				obj[i].parentNode.parentNode.removeChild(obj[i].parentNode);
				i--;
			}
		}
		
		if(!chk){
			alert("삭제할 메뉴를 체크하십시오.");
			return;
		}
		
		if($("input[name=chkMyMenu]").length == 0) {
			document.getElementById("footMyMenuList").innerHTML = "<li><label>등록된 나의메뉴가 존재하지 않습니다.</label></li>";
			fn_initNameChange();
		}
	} else {
		alert("삭제할 메뉴가 존재하지 않습니다.");
	}
}

function fn_upDownMyMenu(type){
	var selectId = document.getElementById("selectMyMenuId");
	
	if($("input[name=chkMyMenu]").length == 0) {
		alert("메뉴목록이 존재하지 않습니다.");
		fn_initNameChange();
		return;
	} else {
		if(!fn_isMenu(selectId.value)){
			alert("선택된 메뉴가 존재하지 않습니다.");
			fn_initNameChange();
			return;
		}
	}
	
	if(type == "up"){
		$("#chkMyMenuId" + selectId.value).parent().after($("#chkMyMenuId" + selectId.value).parent().prev());
	} else {
		$("#chkMyMenuId" + selectId.value).parent().before($("#chkMyMenuId" + selectId.value).parent().next());
	}
}
 
function fn_saveMyMenu(){
	var params = "chkMyMenu=";
	var items = document.getElementsByName("chkMyMenu");
	
	if($("input[name=chkMyMenu]").length > 0){
		
		for (var i = 0; i < items.length; i++) {
			params += encodeURIComponent(items[i].value);
			
			if(i+1 != items.length) {
				params += ",,";
			} else {
				params += "&";
			}
		}
	} else {
		params += " &";
	}
	
	$.ajax({
		type : "post",
		url : "/personalMenu/personalMenuJson.face",
		data : params + "m=userSaveMyMenu&__ajax_call__=true",
		dataType : "json",
		success : function(data){
			alert(data.msg);
			//location.reload(); 
			fn_gnbMyMenu();
			fn_hideBlockPopup();
		}, error : function(x, e, textStatus, errorThrown, XMLHttpRequest){
			alert("에러가 발생했습니다.\n관리자에게 문의하십시오.");
			fn_hideBlockPopup();
			return;
		}
	});
	
	fn_checked("chkMyMenu", "allFalseCheck");
}

function fn_updateMyMenu(obj, id, title){
	if(!isDefined(id)){
		alert("pageId값이 비어있습니다.");
		return;
	} else if(!isDefined(title)){
		alert("shortTitle값이 비어있습니다.");
		return;
	}
	
	fn_ajax({
		url : getContextPath() + "/personalMenu/personalMenuJson.face?m=userUpdateMyMenu&pageId=" + id + "&shortTitle=" + escape(encodeURIComponent(title))
		, callback : { success : function (data) { fn_updateMyMenuSuccess( data, obj ); } }
	});
}

function fn_updateMyMenuSuccess ( data, obj ){
	if(data.status == "success"){
		fn_gnbMyMenu();
		
		if(obj.hasChildNodes()){
			for(var i = 0; i < obj.childNodes.length; i++){
				if(obj.childNodes[i].nodeName == "SPAN") {
					obj.className = "";
					obj.childNodes[i].className = "";
					
					if(data.type == "add"){
						obj.className = "btn_blue"; 
						obj.childNodes[i].className = "icon_star_white";
					} else {
						obj.className = "btn_white";
						obj.childNodes[i].className = "icon_star";
					}
					
					break;
				}
			}
		}
	} else {
		alert(data.msg);
	}
}

function fn_updateStarMyMenu(obj, id, title){
	if(!isDefined(id)){
		alert("pageId값이 비어있습니다.");
		return;
	} else if(!isDefined(title)){
		alert("shortTitle값이 비어있습니다.");
		return;
	}
	
	fn_ajax({
		url : getContextPath() + "/personalMenu/personalMenuJson.face?m=userUpdateMyMenu&pageId=" + id + "&shortTitle=" + escape(encodeURIComponent(title))
		, callback : { success : function (data) { fn_updateStarMyMenuSuccess( data, obj ); } }
	});
}

function fn_updateStarMyMenuSuccess ( data, obj ){
	if(data.status == "success"){
		fn_gnbMyMenu();
		
		if(obj.className.trim() == "on") {
			obj.className = "off"
		} else {
			obj.className = "on"
		}
	} else {
		alert(data.msg);
	}
}

function fn_showBlockPopup(opts){
	var defaultOpts = {
		  message : ""
		, draggable : true 
		, theme : false
		, showOverlay : true
		, left : '35%'
		, top : '40%'
		, width : '30%'
		, cursor : 'default'
		, border : 'none'
		, textAlign : 'left'
	}
	
	var mergeOpts = $.extend(true, {}, defaultOpts, opts);
	
	if(!isDefined(mergeOpts.message)){
		alert("보여줄 영역이 존재하지 않습니다.");
		return;
	}
	
	$.blockUI({
		  message : mergeOpts.message
		, draggable : mergeOpts.draggable
		, theme : mergeOpts.theme
		, showOverlay : mergeOpts.showOverlay
		, css : {
			  border : mergeOpts.border
			, left : mergeOpts.left
			, top : mergeOpts.top
			, width : mergeOpts.width
			, cursor : mergeOpts.cursor
			, textAlign : mergeOpts.textAlign
		}
	});
}

function fn_settingMyMenuPop(id){
	fn_showBlockPopup({
		  message : $("#" + id)
		, draggable : true 
		, theme : false
		, showOverlay : true
		, top : '15%'
		, cursor : 'default'
		, textAlign : 'left'
	});
	
	if($("#header_type2 .gnb .menu li.mymenu").hasClass("on")){
		$('.mymenu_wrap').toggle();
		$("#header_type2 .gnb .menu li.mymenu").removeClass("on").addClass("off");
	}
	
	fn_myMenuList();
}

function fn_hideBlockPopup() {
	$.unblockUI();
}