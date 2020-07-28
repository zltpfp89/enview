$(function(){
	$('#container.login').css('height', $(window).height() );
}); 

$(window).resize(function() {
	$('#container.login').css('height', $(window).height() );
});

$(function(){
	$('#receive_btn').click(function(){
		$(this).next().toggle();
		
		if( $(this).next().is( ":visible") == true ){
			$(this).children().find("span").attr("class", "icon_slidedown")
		}else{
			$(this).children().find("span").attr("class", "icon_slideup")
		}
		
		try{
			parent.autoresize_iframe_portlets();
		}catch(e){console.log(e)}
	})
});

$(function(){
	
		//$("#nav").toggle();
		var navW = $("#nav").width();

		if( $("#header button.btn_menu").hasClass("open") ){
			$('.btn_menu').click(function(){
				$("#nav").show().animate({right:0});
				$("#header button").removeClass("open").addClass("close");				
			});
			$('.mclose').click(function(){
				$("#nav").animate({right: -navW }).hide();
			});

		}
		else if ( $("#header button.btn_menu").hasClass("close") ) {
			$('.btn_menu').click(function(){
				$("#nav").animate({right: -navW }).hide();
				$("#header button").removeClass("close").addClass("open");
				$(".gnb > li > a").parent().children("ul.depth2").slideUp(0);
			})
		}		



});



$(function(){
	$(".gnb li a").click(function(){
		$(this).parent().children("ul").slideToggle();
		if( $(this).parent().children("ul").is( ":visible") == true ){
		}else {
		}
	})

});


$(function(){
	var subjectW = $(".subject").width();
	var subjectaW = $(".subject > a").width();

	if( subjectW > subjectaW ) {
		$(".subject > .comment").css('left', subjectaW + 10 );
	}else {
		$(".subject > .comment").css('left', subjectW + 10 );
	}

});

$(window).resize(function() {
	var subjectW = $(".subject").width();
	var subjectaW = $(".subject > a").width();
	

	if( subjectW > subjectaW ) {
		$(".subject > .comment ").css('left', subjectaW + 10 );
	}else {
		$(".subject > .comment").css('left', subjectW + 10 );
	}

});


/* 2016.02.04 추가 */
$(function(){
  $('.Chk_wrap  input').click(function(){

	if($(this).is(':checked')){
		$(this).attr("checked", true);
		$(this).parent().removeClass('off').addClass('on');
	}else{
		$(this).attr("checked", false);
		$(this).parent().removeClass('on').addClass('off');
	}
  });
});

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
/* 2016.02.15 
$(function(){
	var layerpopupphotowH = $(".layerpopup_photo_wrap").height();
	var layerpopupphotowW = $(".layerpopup_photo_wrap").width();
	$(".layerpopup_photo img").css("max-height", layerpopupphotowH - 60 );	
	$(".layerpopup_photo img").css("max-width", layerpopupphotowW - 10 );	

});
$(window).resize(function() {
	var layerpopupphotoH = $(".layerpopup_photo_wrap").height();
	var layerpopupphotoW = $(".layerpopup_photo_wrap").width();
	$(".layerpopup_photo img").css("max-height", layerpopupphotowH - 60 );	
	$(".layerpopup_photo img").css("max-width", layerpopupphotowW - 10 );	
});
*/