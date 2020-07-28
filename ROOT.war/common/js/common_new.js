/**
 * Date		:	2014.08.12
 * name		:	Developwon
 * subject 	: 	null, undefined 체크
 * param 	: 	str(변수)
 * return 	:	boolean	
 */
function isDefined(str)	{				
    var isResult = false;
    var str_temp = str + "";
    str_temp = str_temp.replace(" ", "");
    
    if(str_temp != "undefined" && str_temp != "" && str_temp != "null")
    {
        isResult = true;
    }
     
    return isResult;
}

/**
 * Date		:	2015.05.23
 * name		:	Developwon
 * subject 	: 	base64로 인코딩
 * param 	: 	String(인코딩할 문자)
 * return 	:   String
 */
function fn_base64(s) {
	var key = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';
	
	var i = 0, len = s.length,
	c1, c2, c3,
	e1, e2, e3, e4,
	result = [];
	 
	while (i < len) {
		c1 = s.charCodeAt(i++);
		c2 = s.charCodeAt(i++);
		c3 = s.charCodeAt(i++);
		   
		e1 = c1 >> 2;
		e2 = ((c1 & 3) << 4) | (c2 >> 4);
		e3 = ((c2 & 15) << 2) | (c3 >> 6);
		e4 = c3 & 63;
		   
		if (isNaN(c2)) {
			e3 = e4 = 64;
		} else if (isNaN(c3)) {
			e4 = 64;
		}
		   
		result.push(e1, e2, e3, e4);
	}
	 
	return result.map(function (e) { return key.charAt(e); }).join('');
}

/**
 * Date		:	2014.08.19
 * name 	:	Developwon
 * subject	:	공통 팝업(파라미터 및 속성다르게)
 * param 	:	url, param, popName, attr
 */
function cmn_Pop(url, param, popName, attr) {
	var cmn_win = window.open(url + param, popName, attr);
	
	return cmn_win;
}

/**
 * Date		:	2016.02.17
 * name 	:	
 * subject	:	공통 팝업(게시판)
 * param 	:	strURL, strNAME, width, height, strScroll
 */
var newWin;
function cmn_openNewWindow(strURL,strNAME,width,height,strScroll,resizable){
	var swidth  = (screen.width - width) / 2; 
	var sheight = (screen.height - height) / 2;
	newWin = window.open(strURL,strNAME,"width="+width+",height="+height+",left="+swidth+",top="+sheight+",scrollbars="+strScroll+",resizable="+resizable+",location=no");
	newWin.focus();
}

function getContextPath(){
    var oset = location.href.indexOf(location.host) + location.host.length;
    //var ctxPath = location.href.substring(oset, location.href.indexOf('/', oset + 1));
    var ctxPath = location.href.substring(oset, location.href.indexOf('/', oset));
    
    return ctxPath;
}

/**
 * Date		:	2014.09.19
 * name 	:	Developwon
 * subject	:	공통달력
 * param 	:	id
 */
function fn_datepickerCmn(id){
	$.datepicker.regional['ko']={
			dateFormat: 'yy.mm.dd', 
			showOn : 'button',
			buttonImage : getContextPath() + '/common/images/icon_calendar.png',
			buttonImageOnly : true,
			monthNames: ['1월','2월','3월','4월','5월','6월', '7월','8월','9월','10월','11월','12월'],
			monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], 
			dayNames: ['일','월','화','수','목','금','토'],
			dayNamesMin: ['일','월','화','수','목','금','토'],
			changeMonth: true, // 월 변경 가능
			changeYear: true, // 년 변경 가능
			closeText:'닫기',
			currentText:'오늘',
			showButtonPanel: true,
			showMonthAfterYear: true}; //년 뒤에 월 표시
			$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#"+id).datepicker()
}

/**
 * Date		:	2016.01.06
 * name 		:	Developwon
 * subject	:	숫자만 입력
 * param 	:	str_value
 */
function fn_numberFilter(str_value) {
	return str_value.replace(/[^0-9]/gi, "");  
}

/**
 * Date		:	2016.01.06
 * name 		:	Developwon
 * subject	:	체크된 값 추출
 * param 	:	objName, type
 */
function fn_checked(objName, type){
	if(type == "radio"){
		var obj = document.getElementsByName(objName);
		var rtnVal;
		
		for(var i = 0; i < obj.length; i++){
			if(obj[i].checked == true) {
				rtnVal = obj[i].value;
				
				break;
			}
			
		}
		
		return rtnVal;
	}  else if(type.indexOf("all") != -1){
		var gc = document.getElementsByName(objName);
		
		for(var i = 0; i < gc.length; i++){
			if("allTrueCheck" == type){
				gc[i].checked == false ? gc[i].checked = true : gc[i].checked = true; 
			} else if("allFalseCheck" == type) {
				gc[i].checked == true ? gc[i].checked = false : gc[i].checked = false; 
			}
		}
	} else {
		
	}
}

/**
 * Date		:	2016.01.11
 * name 		:	Developwon
 * subject	:	byte용량 계산
 * param 	:	bytes
 */
function byteCalculation(bytes) {
	if(isDefined(bytes)){
		var bytes = parseInt(bytes);
		var s = ['bytes', 'KB', 'MB', 'GB', 'TB', 'PB'];
	    var e = Math.floor(Math.log(bytes)/Math.log(1024));
		   
	    if(e == "-Infinity"){
	    	return "0 "+s[0];
		} else {
			return (bytes/Math.pow(1024, Math.floor(e))).toFixed(2)+" "+s[e];
		} 
	}
}
/**
 * Date		:	2016.01.13
 * subject	:	인쇄기능 공통
 * param 	:	인쇄할 영역 ID
 * jquery.printArea.js 필수
 */
function fn_print(printId, opt) {
	var browser = fn_commonMSieversion();
	
	if (printId == null || printId == undefined) {
		printId = "print";
	}
	
	if (opt == null || opt == undefined) {
		opt = "popup";
	}
	
	var printOpt = {
			mode : opt == "popup" ? "popup" : "iframe"
			, retainAttr : ["id", "class", "style"]
			, popHt : 625
			, popWd : 780
			, popTitle : "솔트웨어" 
			, popClose : true
	};
	// 인쇄시 무시할 내용은 hide 처리후 다시 show
	$(".ignorePrintArea").hide();
	// 인쇄시 숨겨져 있지만 출력해야할 경우 show 후 hide
	$(".printArea").show();
	$("#" + printId).printArea(printOpt);
	$(".printArea").hide();
	$(".ignorePrintArea").show();
}

/**
 * 사용자 정보 레이어팝업
 */
function fn_getUserInfoPopup(userId) {
	if (userId == null || userId == '') {
		alert("잘못된 요청입니다.");
		return;
	}
	
	fn_showDialogPopup({
		url : getContextPath() + "/common/user/userView.common",
		param : {"searchValue":userId},
		title : "직원정보",
		width : 522,
		modal : true,
		buttons : [{ text : "인쇄", class : "btn_black", click : function () {fn_print('userDetail', 'popup')} }]
	});
}
/**
 * 사용자 검색 레이어팝업(확인 버튼에 fn_getChkUserInfo() 함수 구현필요)
 */
function fn_showUserSearch(type) {
	var param = "";
	if (type != null) {
		param = {
			"chkType" : type
		};
	}
	buttons = {};
	if( type=='radio') {
		buttons = [ { text : "확인", class:"btn_black", click: function() { try{fn_getChkUserInfo();}catch(e){} $("#userSearchLayer").dialog("close"); } }];
	} else {
		buttons = [ 
		  		 { text : "추가", class:"btn_black", click: function() { try{fn_getChkUserInfo();}catch(e){console.log(e)}}},
		  		 { text : "닫기", class:"btn_black", click: function() { $("#userSearchLayer").dialog("close");} }
		  		];
	}
	fn_showDialogPopup({
		showAreaId : "userSearchLayer",
		url : getContextPath() + "/common/user/layerPopupList.common",
		param : param,
		title : "직원검색",
		width : 720,
		modal : true,
		buttons : buttons 
	});
}

function fn_showSearch(targetItem, m) {
	var call = "orgtChartView";
	if(m == 'Single' || m == 'single'){
		call += 'Single';
	}
	window.open("/orgtChart.face?m="+call+"&targetItem="+targetItem,"_blank","width=1200, height=900");
}
function fn_showSearchReturn(targetItem, m) {
	var call = "orgtChartView";
	if(m == 'Single' || m == 'single'){
		call += 'Single';
	}
	return window.open("/orgtChart.face?m="+call+"&targetItem="+targetItem,"_blank","width=1200, height=900");
}
function fn_addReporter(deptId) {
	var call = "addReporter";	
	window.open("/orgtChart.face?m="+call+"&deptId="+deptId,"_blank","width=1200, height=900");
}
function fn_addAgent(deptId, pstnCd, reportId) {
	var call = "addAgent";
	window.open("/orgtChart.face?m="+call+"&deptId="+deptId+"&pstnCd="+pstnCd+"&reportId="+reportId,+"_blank","width=1200, height=900");
}
function fn_showLayerPopup(opts) {
	var defaultOpts = {
			showAreaId : "layerPopupDiv"
			, url : ""
			, center : true
			, top : 0
			, left : 0
			, width : '100%'
			, height : '100%'
			, param : {}
			, callback : null
	};
	
	var mergeOpts = $.extend(true, {}, defaultOpts, opts);
	
	if (mergeOpts.url == null || mergeOpts.url == "") {
		alert("잘못된 요청입니다. 옵션의 url을 확인하십시오.");
		return;
	}
	var showObj = $("#" + mergeOpts.showAreaId).attr("id");
	if (showObj == null || showObj == undefined) {
		// 해당 아이디가 없는경우 body 태그 밑에 생성한다.
		var html = "<div id='" + mergeOpts.showAreaId + "'></div>";
		$("body").append(html);
	}
	
	$("#" + mergeOpts.showAreaId).load(mergeOpts.url, mergeOpts.param, function (res, status, xhr) {
		$("#" + mergeOpts.showAreaId + " > div.sub_layer_popup").css({
    		"width" : mergeOpts.width,
    		"height" : mergeOpts.height,
    		"left" : mergeOpts.left,
    		"top"  : mergeOpts.top,
    		"position" : "relative"
    	}).show();
		
		if (mergeOpts.center) {
			// 현제창의 중앙으로 이동시킨다.
			var windowWidth = 0;
			var windowHeight = 0;
			var layerWidth = 0;
			var layerHeight = 0;
			
			var windowWidth = $(window).width();
        	var windowHeight = $(window).height() ;
        	
        	if (mergeOpts.width > 0) {
        		layerWidth = mergeOpts.width
        	} else {
        		layerWidth = $("#" + mergeOpts.showAreaId).width();
        	}
        	
        	if (mergeOpts.height > 0) {
        		layerHeight = mergeOpts.height
        	} else {
        		layerHeight = $("#" + mergeOpts.showAreaId).height();
        	}
        	
        	$("#" + mergeOpts.showAreaId).css({
        		"left" : (windowWidth/2) - (layerWidth/2),
        		"top"  : ((windowHeight/2) - (layerHeight/2)) - 50 < 0 ? 20 : ((windowHeight/2) - (layerHeight/2)) - 50,
        		"position" : "absolute"
        	});
		} else {
			$("#" + mergeOpts.showAreaId).css({
        		"left" : mergeOpts.left,
        		"top"  : mergeOpts.top,
        		"position" : "absolute"
        	});
		}
		
		$("#" + mergeOpts.showAreaId).draggable({ containment: "parent", handle: "div.layer_popup_header", cursor: "move" });
		try {
			// 필요시 콜백처리용
			if (mergeOpts.callback != null) {
				mergeOpts.callback.complete(html, status, xhr);
			}
		} catch (e) {console.log(e)}
		
		try {
			if (parent != null) {
				parent.autoresize_iframe_portlets();
			} else {
				autoresize_iframe_portlets();
			}
		} catch (e) {console.log(e)}
	});
}

function fn_showDialogPopup(opts) {
	var defaultOpts = {
		 title : "",
		 width:"auto",
		 height:"auto",
		 modal : true,
		 showAreaId : "layerPopupDiv",
		 position : {my : "center top+20", at : "center top+20", of : "body"},
		 param : null
	};
	
	var mergeOpts = $.extend(true, {}, defaultOpts, opts);
	
	if (mergeOpts.showAreaId == null || mergeOpts.showAreaId == "") {
		mergeOpts.showAreaId == "layerPopupDiv";
	}
	
	if (mergeOpts.url == null || mergeOpts.url == "") {
		$("#" + mergeOpts.showAreaId).dialog({
			title : mergeOpts.title,
			width:mergeOpts.width,
			height:mergeOpts.height,
			modal : mergeOpts.modal,
			position : mergeOpts.position,
			buttons : mergeOpts.buttons
		});
	} else {
		fn_makeDiv(mergeOpts.showAreaId);
		$("#" + mergeOpts.showAreaId).load( mergeOpts.url, mergeOpts.param, function() {
			// 다이얼로그 오픈시 focus 순서로 인해 자동으로 focus되어 스크롤바가 이동한다.
			// * focus 순서
			// 1.autofocus attribute 가 있는 태그
			// 2.다이얼로그 내용중에 최초 tab 키로 이동 할수 있는 태그
			// 3.다이얼로그 버튼페널중에 최초 tab키로 이동 할 수 있는 태그
			// 4.다이얼로그 닫기 버튼
			// 5.다이얼로그 자체
			$("#" + mergeOpts.showAreaId).prepend("<input type='hidden' autofocus='autofocus'/>");
			$("#" + mergeOpts.showAreaId).dialog({
				title : mergeOpts.title,
				width : mergeOpts.width,
				height : mergeOpts.height,
				modal : mergeOpts.modal,
				position : mergeOpts.position,
				buttons : mergeOpts.buttons,
				autoOpen : false,
				open : function () {
					try {
						if (parent != null) {
							parent.autoresize_iframe_portlets();
						} else {
							autoresize_iframe_portlets();
						}
						$("#" + mergeOpts.showAreaId).scrollTop(0);
					} catch (e) {console.log(e)}
				}
		    });
		    
			$("#" + mergeOpts.showAreaId).dialog("open").on("dialogclose", function (e, ui) {
		    	try {
		    		fn_delDialogContent(mergeOpts.showAreaId);
		    		
		    		if (parent != null) {
						parent.autoresize_iframe_portlets();
					} else {
						autoresize_iframe_portlets();
					}
		    	} catch (e) {console.log(e)}
		    });
	    });
	}
}

/**
 * url 이외에는 기본값으로 셋팅됨</br>
 * SecurityInterceptor에서 세션 체크 후 header로 넘어오는 로그인 페이지 이동 로직 추가</br>
 * 성공시 opts.success에 callback function을 호출
 * 에러시 opts.error에 callback function을 호출
 * @param opts
 */
function fn_ajax(opts) {
	var defaultOpts = {
			type	: "POST"
			, async	: "true"
			, dataType : "json"
			, callback : {success : function (data) {fn_ajaxSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
	};
	
	var mergeOpts = $.extend(true, {}, defaultOpts, opts);

	$.ajax({
		type: mergeOpts.type,
		url: mergeOpts.url,
		data: mergeOpts.param + "&__ajax_call__=true",
		async: mergeOpts.async,
		beforeSend: function () {
			$("#ajaxLoading").show();
		},
		success: function(data, textStatus, jqXHR) {
			// 헤더에 enview.ajax.control 값이 있다면 로그인 페이지로 이동시킨다.
			var redirectUrl = jqXHR.getResponseHeader("enview.ajax.control");
			if( redirectUrl != null && redirectUrl.length>0 ) {
				//alert("redirectUrl=" + redirectUrl);
				window.location.href = redirectUrl;
			} else {
				if (data.status == "ERROR") {
					mergeOpts.callback.error(data);
				} else {
					mergeOpts.callback.success(data);
				}
			}
		}, 
		error: function(jqXHR, textStatus, errorThrows) {
			mergeOpts.callback.error({"status":"ERROR", "msg":"처리중 오류가 발생하였습니다."});
		},
		complete: function(jqXHR, textStatus) {
			$("#ajaxLoading").hide();
		}
	});
}

// 메신저 쪽지
function fn_sendMsg(senderId, userId) {
	if (userId == null || userId == "") {
		alert("잘못된 요청입니다. 파라미터를 확인하십시오.");
		return;
	}
	ezim_MsgSendFunc(senderId + "|" + userId);
}

// 메신저 채팅
function fn_sendChat(senderId, userId) {
	if (userId == null || userId == "") {
		alert("잘못된 요청입니다. 파라미터를 확인하십시오.");
		return;
	}
	ezim_MsgChatFunc(senderId + "|" + userId);
}

// 메신저 통화
function fn_sendCall(from, to) {
	// http://10.240.2.30:5550/c2c.php
	// post
	// from=sip:송신번호@10.240.2.200&to=sip:수신번호@10.240.2.200
	$("#callForm #from").val("sip:" + from + "@10.240.2.200");
	$("#callForm #to").val("sip:" + to + "@10.240.2.200");
	
	$("#callForm").submit();
}

// id에 맞는 div객체를 찾고 없으면 새로 만든다.
function fn_makeDiv( id) {
	var check = $("#" + id).attr("id");
	if( check==null) {
		var html = "<div id='" + id + "'></div>";
		$("body").append(html);
	}
}


/**
* 공통 파일 미리보기 
*/
function fn_previewCommonFile( fileId) {
	fn_previewFile( {"fileId" : fileId});
}

/*
* 게시판 파일 미리보기
*/
function fn_previewBoardFile( boardId, bltnNo, fileSeq) {
	fn_previewFile( {"boardId" : boardId, "bltnNo" :bltnNo, "fileSeq" : fileSeq });
}

/**
* 파일을 미리보기한다. (모바일) 
* fileData : 
*   { "fileId" : <fileId>} 공통파일 
*   { "boardId" : <boardId>, "bltnNo" : <bltnNo>, "fileSeq" : <fileSeq> } 게시판파일 
*/

function fn_previewFile( fileData) {
	$.ajax( {
		url : '/common/file/preview.common',
		type : "post",
		data : fileData,
		success : function( data) {
			if( data.response!=null) {
				if( data.response.status == 0) {
					var resources = data.response.resources
					fn_makeDiv("filePreview");
					$("#filePreview").addClass("layerpopup_bg");
					$("#filePreview").html( '');
					$("#filePreview").show();
					
					$("#filePreview").load( "/common/common/file/preview.jsp", null, function(){
//						initSlideshow( 'http://10.11.52.202:7070/hermes/resource/store/', resources);
						// 망연계서버
						initSlideshow( 'http://211.241.9.169:17070/hermes/resource/store/', resources);
					});
					
					/*
					fn_makeDiv("filePreview");
					$("#filePreview").addClass("layerpopup_bg");
					$("#filePreview").html( '');
					var html = '';
					html += '<div class="layerpopup_photo_wrap">';
					html += '<div class="layerpopup_header">';
					html += '<h2>미리보기</h2>';
					html += '<a href="#" class="close" onclick="$(\'#filePreview\').hide();">닫기</a>';
					html += '</div>';
					html += '<div class="layerpopup_content flexslider layerpopup_photo">';
					html += '<ul class="slides" id="previewFileList">';
					for( var i=0;i<resources.length;i++) {
						html +="<li><img src='http://10.11.52.202:7070/hermes/resource/store/" + resources[i] + "'></li>\n";  
					}
					html += '</ul>';
					html += '<div class="flexslider_count">';
					html += '<span class="slide-current-slide"></span>';
					html += '<span class="slide-total-slides"></span>';
					html += '</div>';
					html += '</div>';
					html += '</div>';
					
					$("#filePreview").html( html);
					$("#filePreview").show();
					  $('.flexslider').flexslider({
							animation: "slide",
							directionNav: true,
							controlNav: false,
							smoothHeight: true,
							// options
							start:function(slider){
								$(".slide-current-slide").text(slider.currentSlide+1);
								$(".slide-total-slides").text("/"+slider.count)
							},
							before:function(slider){
								$(".slide-current-slide").text(slider.animatingTo+1)
							}
					  });
					*/
					
				}  else {
					alert( '첨부파일 변환 오류 입니다.\n해당 파일은 유선 코러스포털에서 확인하시기 바랍니다');
				}
			} else {
//				alert( data.msg);
			}
			
		},
		error : function ( xhr, status, error) {
			alert('데이터 전송오류 ' + status + ", " + error );
		}
	});		
}
// ---------------------------------------------------------------------------------------------------------------
// 파일미리보기에사 사용 
//------------------------------------------------------------------------------------------------------------------
var slideBase = '';
var slideCount = 1;
var slideIndex = 1;
var slideArray =  '';

function initSlideshow( base, array) {
	slideBase = base;
	slideArray = array;
	slideCount = array.length;
	slideIndex = 1;
	$("#slideTotal").text( slideCount);
	$("#slidePage").text( slideIndex);
	$("#slideImg").attr( "src", slideBase + slideArray[0]);
}

function slideshow( slide ) {
	slideIndex += slide;
	if (slideIndex > slideCount){ 
		slideIndex = 1 ;
	} 
	if (slideIndex == 0){
		slideIndex = slideCount ; 
	} 
	$("#slideImg").attr( "src", slideBase + slideArray[slideIndex - 1]);
	$("#slidePage").text( slideIndex);
}
//----------------------------------------------------------------------------

/**
 * Date		:	2016.03.02
 * name 		:	Developwon
 * subject	:	브라우저 체크
 */
function fn_getCommonBrowserCheck(){
    var _ua = navigator.userAgent;
    var rv = -1;
     
    //IE 11,10,9,8
    var trident = _ua.match(/Trident\/(\d.\d)/i);
    if( trident != null )
    {
        if( trident[1] == "7.0" ) return rv = "IE" + 11;
        if( trident[1] == "6.0" ) return rv = "IE" + 10;
        if( trident[1] == "5.0" ) return rv = "IE" + 9;
        if( trident[1] == "4.0" ) return rv = "IE" + 8;
    }
     
    //IE 7...
    if( navigator.appName == 'Microsoft Internet Explorer' ) return rv = "IE" + 7;
     
    /*
    var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
    if(re.exec(_ua) != null) rv = parseFloat(RegExp.$1);
    if( rv == 7 ) return rv = "IE" + 7; 
    */
     
    //other
    var agt = _ua.toLowerCase();
    if (agt.indexOf("chrome") != -1) return 'Chrome';
    if (agt.indexOf("opera") != -1) return 'Opera'; 
    if (agt.indexOf("staroffice") != -1) return 'Star Office'; 
    if (agt.indexOf("webtv") != -1) return 'WebTV'; 
    if (agt.indexOf("beonex") != -1) return 'Beonex'; 
    if (agt.indexOf("chimera") != -1) return 'Chimera'; 
    if (agt.indexOf("netpositive") != -1) return 'NetPositive'; 
    if (agt.indexOf("phoenix") != -1) return 'Phoenix'; 
    if (agt.indexOf("firefox") != -1) return 'Firefox'; 
    if (agt.indexOf("safari") != -1) return 'Safari'; 
    if (agt.indexOf("skipstone") != -1) return 'SkipStone'; 
    if (agt.indexOf("netscape") != -1) return 'Netscape'; 
    if (agt.indexOf("mozilla/5.0") != -1) return 'Mozilla';
}

/**
 * Date		:	2016.03.02
 * name 		:	Developwon
 * subject	:	IE 버젼 체크
 */
function fn_commonMSieversion(){
   var ua = window.navigator.userAgent
   var msie = ua.indexOf ( "MSIE " )

   if ( msie > 0 )      // If Internet Explorer, return version number
      return parseInt (ua.substring (msie+5, ua.indexOf (".", msie )))
   else                 // If another browser, return 0
      return 0
}
