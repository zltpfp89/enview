function fn_searchWord(){
	var frm = document.searchFrom;
	
	if(frm.commonSearchType.value == "commonSearch"){
		if(!isDefined(frm.searchVal.value)){
			alert("검색어를 입력하십시오.");
			frm.searchVal.focus();
			return false;
		}

		fn_searchPostAction(frm.searchVal.value);
	} else {
		var url = "/common/user/userList.common?viewMode=" + frm.commonSearchType.value + "&text=" + encodeURIComponent(frm.searchVal.value)
		var name = "commonMemberSearch";
		var attr = "scrollbars=yes,location=yes,resizable=yes,width=1228,height=768,left=0,top=0";
		window.open(url, name, attr);
	}
}

function fn_searchPostAction(searchWord){
	var wTarget = "searchWindow";
	var wAddr = "http://10.11.3.83/search/search.jsp";
	var wNewWin = window.open("about:blank", wTarget);
	
	var form = document.searchActionForm;
	//form.query.value = encodeURIComponent(frm.searchVal.value);
	form.query.value = searchWord;
	form.b64id.value = fn_base64(document.getElementById("commonUserId").value);
	form.target = wTarget;
	form.action = wAddr;
	form.submit();
}

function fn_popWord(){
	fn_ajax({
		url : getContextPath() + "/search/getSearchPopWord.face"
		, callback : { success : function (data) {fn_popWordSuccess(data);} }
	});
}

function fn_popWordSuccess(data) {
	var doc = document.getElementById("searchPopWords");
	var hStr = "";
	
	if(data.status == "success"){
		if(data.listPopWord.length > 0) {
			/* 
			data.listPopWord[i].contentPopWord			//검색어
			data.listPopWord[i].idPopWord					//순위
			data.listPopWord[i].updownPopWord			//변동 여부(C : 그대로, U : 상승, D : 하락)
			data.listPopWord[i].countPopWord				//변동 카운트
			data.listPopWord[i].querycountPopWord		//검색된 카운트
			 */
			for(var i = 0; i < data.listPopWord.length; i++){
				hStr += "<li><a href=\"javascript: fn_searchPostAction('" + data.listPopWord[i].contentPopWord + "');\" title=\"" + data.listPopWord[i].contentPopWord + "(" + data.listPopWord[i].idPopWord + "위)\">" + data.listPopWord[i].contentPopWord + "</a></li>";
			}
		} else {
			hStr = "<li><a title=\"인기검색어가 없습니다.\">인기검색어가 없습니다.</a></li>";
		}
	} else {
		hStr = "<li><a title=\"" + data.msg + "\">인기검색어 Error</a></li>";
	}
	
	doc.innerHTML = hStr;
	fn_popWordRolling();
}

function fn_autoWordKeyEvent(obj){
	var frm = document.searchFrom;
	
	if(frm.commonSearchType.value == "commonSearch"){
		if(checkCookie( "autoWordOnOffCookie", "on" )){
			if(isDefined(obj.value)){
				fn_ajax({
//					url : getContextPath() + "/search/getSearchAutoWord.face"
					url : getContextPath() + "/search/getSearchAutoWord.face?autoWordKey="+encodeURIComponent(obj.value)+"&__ajax_call__=true"
//					, param : { autoWordKey : obj.value }
					, callback : { success : function (data) {fn_autoWordSuccess(data);} }
				});
			}
			
			fn_autoWordShow(null);
		}
	}
}

function fn_autoWordSuccess(data) {
	//<li><a href="#">이달의 순우리말 농업용어</a></li>
	var doc = document.getElementById("autoWordList");
	var hStr = "";
	
	if(data.status == "success"){
		if(data.responsestatus == "0"){
			//data.result[0]	앞글자부터 일치한 목록
			//data.result[1]	뒷글자부터 일치한 목록
			if(data.result[0].totalcount > 0){
				for(var i = 0; i < data.result[0].items.length; i++){
					hStr += "<li class=\"cursor\" onmousedown=\"javascript: fn_searchPostAction('" + data.result[0].items[i].keyword + "');\"><a href=\"javascript: void(0);\" title=\"" + data.result[0].items[i].keyword + "\">" + data.result[0].items[i].hkeyword + "</a></li>";
				}
			} else {
				hStr = "<li><a href=\"javascript: void(0);\" title=\"" + data.status + "\">해당 단어로 시작하는 검색어가 없습니다.</a></li>";
			}
		}
	} else {
		hStr = "<li><a href=\"javascript: void(0);\" title=\"" + data.status + "\">해당 단어로 시작하는 검색어가 없습니다.</a></li>";
	}
	
	doc.innerHTML = hStr;
}

function fn_autoWordShow(obj){
	var doc = document.getElementById("searchVal");
	
	if(isDefined(obj)) {
		if($(obj).hasClass("off")) setCookieCommon( "autoWordOnOffCookie", "on" );
	}
	
	if(checkCookie( "autoWordOnOffCookie", "on" )){
		if(doc.value.length > 0){
			if( $(".btn_keyword").hasClass("off") ){
				$(".btn_keyword").removeClass("off").addClass("on");
				$(".keyword_result").show();
			}
		} else {
			fn_autoWordHide();
		}
	}
	
	doc.focus();
}

function fn_autoWordHide(){
	if( $(".btn_keyword").hasClass("on") ){
		$(".btn_keyword").removeClass("on").addClass("off");
		$(".keyword_result").hide();
	}
}

function fn_autoWordOff(){
	setCookieCommon( "autoWordOnOffCookie", "off", 30 );
	fn_autoWordHide();
}

var qstAns;

function fn_quiz(){
	fn_ajax({
//		url : getContextPath() + "/securityQuiz/quizJson.common"
		url : getContextPath() + "/securityQuiz/quizJson.common?m=questionPopupCheck"
//		, param : { autoWordKey : obj.value }
		, callback : { success : function (data) { fn_quizSuccess(data); } }
	});
}

function fn_quizSuccess(data){
	if(data.status == "success"){
		if(isDefined(data.quizCheck)){
			if(data.quizCheck){
				var strHtml = "";
				qstAns = data.qstAns;
				document.getElementById("quizQuestion").innerHTML = "";
				document.getElementById("quizExampleList").innerHTML = "";
				
				for(var i = 0; i < data.exampleItems.length; i++){
					strHtml += "<dd><label><input type=\"radio\" name=\"quizExample\" value=\"" + data.exampleItems[i].itemId + "\" />" + data.exampleItems[i].itemCnt + "</lable></dd>";
				}
				
				document.getElementById("quizQstId").value = data.qstId;
				document.getElementById("quizQuestion").innerHTML = data.qstCnt;
				document.getElementById("quizExampleList").innerHTML = strHtml;
				
				fn_showBlockPopup({
					  message : $("#security_quiz_popup")
					, draggable : true 
					, theme : false
					, showOverlay : true
					, top : '15%'
					, left : '20%'	
					, width : '60%'
					, cursor : 'default'
					, textAlign : 'left'
				});
			}
		}
	} else {
		
	}
}

function fn_questionCheck(){
	var frm = document.getElementById("securityQuizForm");
	var val = fn_checked("quizExample", "radio");
	
	
	if(!isDefined(val)){
		alert("보기를 선택하십시오.");
		return false;
	}
	
	if(val != qstAns){
		frm.pass.value = "N";
		alert("정답이 아닙니다.");
	} else {
		frm.pass.value = "Y";
		alert("정답입니다.");
	}
	
	var param = $("#securityQuizForm").serialize();
	
	$.ajax({
		  type : "post"
		, url : getContextPath() + "/securityQuiz/quizJson.common"
		, data : param + "&__ajax_call__=true"
		, dataType : "json"
		, success : function(data){
			if(data.status == "fail"){
				//alert(data.msg);
			}
		  }
		, error : function(x, e, textStatus, errorThrown, XMLHttpRequest){
			alert("에러가 발생했습니다.\n관리자에게 문의하십시오.");
		}
	});
	
	if(frm.pass.value == "Y") fn_hideBlockPopup();
}

function fn_tickerNoticePop(id){
	fn_showDialogPopup({
		showAreaId : id,
		title : "긴급 공지",
		width : 'auto',
		modal : true,
		buttons : [ 
		           		{ 
		           			text : "닫기", 
		           			class : "btn_black", 
		           			click : function() {
		           				$("#"+id).dialog("close"); 
		           			} 
		           		}
		           	]
	});
}
