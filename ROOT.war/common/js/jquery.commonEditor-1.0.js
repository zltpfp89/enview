var oEditors = [];

(function (factory) {
    'use strict';
    if (typeof define === 'function' && define.amd) {
        // Register as an anonymous AMD module:
        define(['jquery'], factory);
    } else if (typeof exports === 'object') {
        // Node/CommonJS:
        factory(require('jquery'));
    } else {
        // Browser globals:
        factory(window.jQuery);
    }
}

(function($){
	'use strict';
	$.fn.commonEditor = function (opts) {
		return this.each(function () {
			var $placeHolder = $(this);
			if (opts == undefined) {
				opts = {
					placeHolder : $placeHolder.attr("id")
				};
			}
			
			if (opts != undefined) {
				opts.placeHolder = $placeHolder.attr("id");
			}
			
			var mergeOpts = $.extend(true, {}, $.fn.commonEditor.defaultOpts, opts);
			mergeOpts.skinPath = mergeOpts.cPath + "/board/smarteditor/" + mergeOpts.skin + ".html";
			init(mergeOpts);
		});
	};
	
	// 생성 기본옵션
	$.fn.commonEditor.defaultOpts = {
			cPath : "",													// request.getContextPath()
			placeHolder : "",											// 에디터를 출력할곳, textarea
			width : "100%",												// 에디터 넓이
			height : "400px",											// 에디터 높이
			isUploadPic : false,										// 에디터 사진업로드 여부
			skin : "SmartEditor2NoImageSkin",							// 에디터 스킨파일명 (스킨경로 : cPath + "/board/smarteditor/ + skin + ".html")
			useToolbar : true,											// 툴바 사용여부
			useVerticalResizer : false,									// 에디터 수동높이조절여부
			useModeChanger : true,										// 에디터 모드 변경 가능 여부
			onBeforeUnload : function() {},								// 에디터 로드 전
			onAppLoad : null											// 에디터 로드 후
	};
	
	$.fn.commonEditor.debug = false;
	
	function init(mergeOpts) {
		log("생성옵션 : " + mergeOpts.placeHolder);
		if (!$("#" + mergeOpts.placeHolder).is("textarea")) {
			alert("Place Holder 는 <textarea> 만 지원합니다.");
			return;
		} 
		
		// placeHolder 높이, 넓이 처리
		// 에디터의 넓이와 높이가 된다.
		$("#" + mergeOpts.placeHolder).css("width", mergeOpts.width).css("height", mergeOpts.height);
		
		// 생성
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: mergeOpts.placeHolder,
			sSkinURI: mergeOpts.skinPath,	
			htParams : {
				bUseToolbar : mergeOpts.useToolbar,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : mergeOpts.useVerticalResizer,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : mergeOpts.useModeChanger,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
				fOnBeforeUnload : mergeOpts.onBeforeUnload
			}, //boolean
			fOnAppLoad : function(){
				try {
					parent.autoresize_iframe_portlets();
				} catch (e) {
				}
				//예제 코드
				//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
			},
			fCreator: "createSEditor2"
		});
	};

	$.fn.getEditorHtml = function () {
		return this.each(function () {
			var $placeHolder = $(this);
			if (oEditors.length == 0  || oEditors.getById[$placeHolder.attr("id")] == null) {
				alert("에디터가 생성되지 않았거나 해당 에디터가 없습니다.");
				return;
			}
			log( oEditors.getById[$placeHolder.attr("id")].getIR() );
			$(this).val(oEditors.getById[$placeHolder.attr("id")].getIR());
		});
	};
	
	$.fn.getText = function () {
		
	};
	
	// helper fn for console logging
	function log() {
	    if (!$.fn.commonEditor.debug) {
	        return;
	    }
	    var msg = '[jquery.commonEditor] ' + Array.prototype.join.call(arguments,'');
	    if (window.console && window.console.log) {
	        window.console.log(msg);
	    }
	    else if (window.opera && window.opera.postError) {
	        window.opera.postError(msg);
	    }
	}
}));