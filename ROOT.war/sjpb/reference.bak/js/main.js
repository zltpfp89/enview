$(function(){
	/*
	var sectionw = $(window).width();
	if (sectionw  > 875 && sectionw  < 1280 ){
		$(".protlet").removeClass('portlet-my').removeClass('gs-w');
		$(".gridster").css("width", "815px").css("height", "2980px");

	}else if(sectionw  > 0 && sectionw  < 874){	
		$(".protlet").removeClass('portlet-my').removeClass('gs-w');
		$(".gridster").css("width", "542px").css("height", "4065px");
	} else {		
		$(".protlet").addClass('portlet-my').addClass('gs-w');
		$(".gridster").css("height", "2168px");

	}
	*/
	//$('.depth1_box, .depth2_box, .depth3_box').css('height', $(window).height() )
}); 

$(window).resize(function() {
	/*
	var sectionw = $(window).width();
	if (sectionw  >875 && sectionw  < 1280 ){
		$(".protlet").removeClass('portlet-my').removeClass('gs-w');
		$(".gridster").css("width", "815px").css("height", "2980px");
	}else if(sectionw  > 0 && sectionw  < 874){
		$(".protlet").removeClass('portlet-my').removeClass('gs-w');
		$(".gridster").css("width", "542px").css("height", "4065px");	
	} else {		
		$(".protlet").addClass('portlet-my').addClass('gs-w');
		$(".gridster").css("height", "2168px");
	}
	*/
	//$('.depth1_box, .depth2_box, .depth3_box').css('height', $(window).height() )
});  

/* 검색바 start */
$(function(){
	var popWordFirstChk = false;
	
	$("#search, #sub_search").hide();
	$(".search_open").click(function(){
		$("#search, #sub_search").slideDown('fast');
		if(!popWordFirstChk) {
			fn_popWord();
			popWordFirstChk = true;
		}
	});

	$(".search_close").click(function(){
		$("#search, #sub_search").slideUp('fast');			
	});	
});
/* 검색바 end */



/* 사이드메뉴 start */
$(window).scroll(function() {
	var position = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환합니다.
	if(position>89){
		$("#side_menu").addClass('side_menufixed');
	}else if (position < 89){
		$('#side_menu').removeClass('side_menufixed');
	} 
	else {
	}
});

// 2016.01.21 좌측메뉴 onoff 쿠키저장 Start

$(function(){
	if(checkCookie( "leftMenuOnOffCookie", "on" )){
		$("#side_menu").animate({left:0}, "1");
		$("#side_menu button").attr("class", "sidemenu_open");
	} else {
		$("#side_menu").animate({left:-72}, "1");
		$("#side_menu button").attr("class", "sidemenu_close");
	}
});

function setCookieEkr( id, value, time ){ 
	var todayDate = new Date(); 
	if(!isDefined( time )) time = 30;
	
	todayDate.setDate( todayDate.getDate() + time ); 			//쿠키 폐기시간 (디폴트 한달)
	document.cookie = id + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
}

function getCookie( id ){
	var acookie = document.cookie;
	
	if(acookie.length > 0){
		var startIndex =acookie.indexOf(id);
		
		if(startIndex > -1) {
			endIndex = acookie.indexOf( ";", startIndex );
			if( endIndex == -1) endIndex = acookie.length;

			return unescape( acookie.substring( startIndex, endIndex ) );
		} else {
			return false;
		}
	}  else {
		return false;
	}
}

function checkCookie( id, value ){
	var chk = false;
	var getValue = getCookie( id );
	
	if(getValue != false){
		var cookVal = getValue.substring(getValue.indexOf("=") + 1, getValue.length);

		if(cookVal == value){
			return true;
		}
	}
	
	return chk;
}

//2016.01.21 좌측메뉴 onoff 쿠키저장 End

$(function(){
	$( "#side_menu button" ).click(function(){
		if( $("#side_menu button").hasClass("sidemenu_close") ){
			$("#side_menu").animate({left:0});
			$("#side_menu button").attr("class", "sidemenu_open");
			setCookieEkr("leftMenuOnOffCookie", "on", 30);
		}else if ( $("#side_menu button").hasClass("sidemenu_open") ) {
			$("#side_menu").animate({left:-72});
			$("#side_menu button").attr("class", "sidemenu_close");
			setCookieEkr("leftMenuOnOffCookie", "off", 30);
		}
	})


	/* 2016.01.21 수정 */

	$(".side_menu_inner > ul > li").click(function(){
		$(".side_menu_inner > ul > li").removeClass("on");
		$(this).addClass("on");
		if( $(this).hasClass("on") ){
			var id = $(this).attr("data-li");
			$("#" + id).show();
		}
		/* 2016.01.22 나의메뉴 */
		if ( $(".side_menu_inner > ul > .mymenu").hasClass("on") )
		{
			$("a.edit").show();
		}else {
			$("a.edit").hide();
		}
		/* 2016.01.22 나의메뉴 */
	});
	$(".depth1_box > ul > li").click(function(){
		$(".depth1_box > ul > li").removeClass("on");
		$(this).addClass("on");
		if( $(this).hasClass("on") ){
			var id = $(this).attr("data-li");
			$(".depth2_box, .depth3_box").hide();
			$("#" + id).show();
		}
	});
	$(".depth2_box > ul > li").click(function(){
		$(".depth2_box > ul > li").removeClass("on");
		$(this).addClass("on");
		if( $(this).hasClass("on") ){
			var id = $(this).attr("data-li");
			$(".depth3_box").hide();
			$("#" + id).show();
		}
	});

	$(".side_menu_inner > ul > li").mouseleave(function(){
		$(this).removeClass("on");
		$(".depth1_box, .depth2_box, .depth3_box").hide();
		$("a.edit").hide();
	});

	/* 2016.01.21 수정 */

});
/* 사이드메뉴 end */


/* 서브메뉴 start */
$(function(){
	$( "#snb  ul  li.menu").click(
		function() {
			$("#snb .snb_allmenu").toggle();
	});


	$(".snb_1depth > ul > li").click(function(){
		$(".snb_1depth > ul > li, .snb_1depth > ul > li a").removeClass("on");
		$(this).addClass("on");

	});
	$(".snb_2depth > ul > li").click(function(){
		$(".snb_2depth > ul > li, .snb_2depth > ul > li a").removeClass("on");
		$(this).addClass("on");
	});

});
/* 서브메뉴 end */


/* 자원예약 start */
$(function(){
	$(".basic_table tr td.subject div div .btn_darkorange").click(function(){
		$(this).parent().parent().parent().parent().next("tr.view").slideToggle(0).siblings("tr.view").slideUp(0);

		if( $(".basic_table tr").next("tr.view").is(':visible') == true ){
			$(".basic_table tr td.subject div div .btn_darkorange span").removeClass("icon_slideup").addClass("icon_slidedown");
			$(this).children().attr("class", "icon_slideup");
		}else {
			$(".basic_table tr td.subject div div .btn_darkorange span").removeClass("icon_slideup").addClass("icon_slidedown");

		}
		if(parent.autoresize_iframe_portlets) parent.autoresize_iframe_portlets();
	});
});
/* 자원예약 end */

/* 작성자정보 start */
$(function(){
	$('.name_popup_open a').click(function(){
		$(this).parent().children().show();
	})
	$('.name_popup .name_popup_top a').click(function(){
		$(this).parent().parent().hide();
	})
});
/* 작성자정보 end */



/* 게시물 평점 start */
$(function(){
	$('.board_score > .total').click(function(){
		$(this).next().slideToggle();
		// $(this).addClass('on');
		//		$(this).removeClass('on');
	})
});
/* 게시물 평점 end */


/* 댓글 start */
$(function(){
	$('.rereply_check').click(function(){
		$(this).parent().parent().parent().next().next(".rereply_list").toggle();
		//$(this).addClass("on");
	})
});

$(function(){
	$('.rereply_write').click(function(){
		$(this).parent().parent().parent().next(".rereply_form").toggle();
	})
});
/* 댓글 end */


/* 포틀릿설정 start */
$(function(){
	$('.portlet_open').click(function(){
		$('.portlet_open > ul').toggle();
	})
});
/* 포틀릿설정 end */

/* 메뉴 start */
$(function(){
	$('.menu_open').click(function(){
		$('.menu_open > ul').toggle();
	})
});
/* 메뉴 end */



/* tabmmenu start */
$(function(){
	$(".content_newboard_box").hide();
	$(".content_newboard_box:first").show();

	$("ul.newboard_tab li a").click(function () {
		$("ul.newboard_tab li a").removeClass("on");
		$(this).addClass("on");
		$(".content_newboard_box").hide();
		var activeTab = $(this).attr("onclick");
		// this.onclick 속성 가져오기에 리스트 onclick클릭시 에러발생 dohun  수정
		if("newboard_tab1" == activeTab || "newboard_tab2" == activeTab || "newboard_tab3" == activeTab || "newboard_tab4" == activeTab){
			$("#" + activeTab).fadeIn();
		}else{
			var newboardTab1 = activeTab.indexOf("newboard_tab1"); 
			var newboardTab2 = activeTab.indexOf("newboard_tab2");
			var newboardTab3 = activeTab.indexOf("newboard_tab3");
			var newboardTab4 = activeTab.indexOf("newboard_tab4");
			
			if(newboardTab1 > -1){
				$("#newboard_tab1").fadeIn();	
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}if(newboardTab2 > -1){
				$("#newboard_tab2").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}if(newboardTab3 > -1){
				$("#newboard_tab3").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}if(newboardTab4 > -1){
				$("#newboard_tab4").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}
		}
	});
	
	$(".content_newboardList_box").hide();
	$(".content_newboardList_box:first").show();
	$("ul.newboardList_tab li a").click(function () {
		$("ul.newboardList_tab li a").removeClass("on");
		$(this).addClass("on");
		$(".content_newboardList_box").hide();
		var activeTab = $(this).attr("onclick");
		// this.onclick 속성 가져오기에 리스트 onclick클릭시 에러발생 dohun  수정
		if("newboardList_tab1" == activeTab || "newboardList_tab2" == activeTab || "newboardList_tab3" == activeTab || "newboardList_tab4" == activeTab){
			$("#" + activeTab).fadeIn();
		}else{
			var newboardListTab1 = activeTab.indexOf("newboardList_tab1"); 
			var newboardListTab2 = activeTab.indexOf("newboardList_tab2");
			var newboardListTab3 = activeTab.indexOf("newboardList_tab3");
			var newboardListTab4 = activeTab.indexOf("newboardList_tab4");
			if(newboardListTab1 > -1){
				$("#newboardList_tab1").fadeIn();	
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}
			if(newboardListTab2 > -1){
				$("#newboardList_tab2").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}
			if(newboardListTab3 > -1){
				$("#newboardList_tab3").fadeIn();	
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}
			if(newboardListTab4 > -1){
				$("#newboardList_tab4").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}
		}
	});
	
	$(".content_newboardList2_box").hide();
	$(".content_newboardList2_box:first").show();
	$("ul.newboardList2_tab li a").click(function () {
		$("ul.newboardList2_tab li a").removeClass("on");
		$(this).addClass("on");
		$(".content_newboardList2_box").hide();
		var activeTab = $(this).attr("onclick");
		// this.onclick 속성 가져오기에 리스트 onclick클릭시 에러발생 dohun  수정
		if("newboardList2_tab1" == activeTab || "newboardList2_tab2" == activeTab || "newboardList2_tab3" == activeTab || "newboardList2_tab4" == activeTab){
			$("#" + activeTab).fadeIn();
		}else{
			var newboardListTab1 = activeTab.indexOf("newboardList2_tab1"); 
			var newboardListTab2 = activeTab.indexOf("newboardList2_tab2");
			var newboardListTab3 = activeTab.indexOf("newboardList2_tab3");
			var newboardListTab4 = activeTab.indexOf("newboardList2_tab4");
			if(newboardListTab1 > -1){
				$("#newboardList2_tab1").fadeIn();	
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}
			if(newboardListTab2 > -1){
				$("#newboardList2_tab2").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}
			if(newboardListTab3 > -1){
				$("#newboardList2_tab3").fadeIn();	
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}
			if(newboardListTab4 > -1){
				$("#newboardList2_tab4").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}
		}
	});

	$(".content_mywork_box").hide();
	$(".content_mywork_box:first").show();

	$("ul.mywork_tab li a").click(function () {
		$("ul.mywork_tab li a").removeClass("on");
		$(this).addClass("on");
		$(".content_mywork_box").hide();
		var activeTab = $(this).attr("onclick");
		// this.onclick 속성 가져오기에 리스트 onclick클릭시 에러발생 dohun  수정
		if("mywork_tab1" == activeTab || "mywork_tab2" == activeTab || "mywork_tab3" == activeTab || "mywork_tab4" == activeTab){
			$("#" + activeTab).fadeIn();
		}else{
			var myworkTab1 = activeTab.indexOf("mywork_tab1"); 
			var myworkTab2 = activeTab.indexOf("mywork_tab2");
			var myworkTab3 = activeTab.indexOf("mywork_tab3");
			var myworkTab4 = activeTab.indexOf("mywork_tab4");
			if(myworkTab1 > -1){
				$("#mywork_tab1").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}if(myworkTab2 > -1){
				$("#mywork_tab2").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}if(myworkTab3 > -1){
				$("#mywork_tab3").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}if(myworkTab4 > -1){
				$("#mywork_tab4").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}
		}
	});


	$(".content_workboard_box").hide();
	$(".content_workboard_box:first").show();

	$("ul.workboard_tab li a").click(function () {
		$("ul.workboard_tab li a").removeClass("on");
		$(this).addClass("on");
		$(".content_workboard_box").hide();
		// this.onclick 속성 가져오기에 리스트 onclick클릭시 에러발생 dohun  수정
		var activeTab = $(this).attr("onclick");
		
		if("workboard_tab1" == activeTab || "workboard_tab2" == activeTab || "workboard_tab3" == activeTab || "workboard_tab4" == activeTab){
			$("#" + activeTab).fadeIn();
		}else{
			var workboardTab1 = activeTab.indexOf("workboard_tab1"); 
			var workboardTab2 = activeTab.indexOf("workboard_tab2"); 
			var workboardTab3 = activeTab.indexOf("workboard_tab3"); 
			var workboardTab4 = activeTab.indexOf("workboard_tab4"); 
			if(workboardTab1 > -1){
				$("#workboard_tab1").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}if(workboardTab2 > -1){
				$("#workboard_tab2").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}if(workboardTab3 > -1){
				$("#workboard_tab3").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}
			if(workboardTab4 > -1){
				$("#workboard_tab4").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}
		 }
	});

	$(".content_community_box").hide();
	$(".content_community_box:first").show();

	$("ul.community_tab li a").click(function () {
		$("ul.community_tab li a").removeClass("on");
		$(this).addClass("on");
		$(".content_community_box").hide();
		// this.onclick 속성 가져오기에 리스트 onclick클릭시 에러발생 dohun  수정
		var activeTab = $(this).attr("onclick");
		
		if("community_tab1" == activeTab || "community_tab2" == activeTab || "community_tab3" == activeTab || "community_tab4" == activeTab){
			$("#" + activeTab).fadeIn();
		}else{
			var communityTab1 = activeTab.indexOf("community_tab1"); 
			var communityTab2 = activeTab.indexOf("community_tab2"); 
			var communityTab3 = activeTab.indexOf("community_tab3"); 
			var communityTab4 = activeTab.indexOf("community_tab4"); 
			
			if(communityTab1 > -1){
				$("#community_tab1").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}if(communityTab2 > -1){
				$("#community_tab2").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}if(communityTab3 > -1){
				$("#community_tab3").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}if(communityTab4 > -1){  
				$("#community_tab4").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}
		 }
	});

	$(".content_helpdesk_box").hide();
	$(".content_helpdesk_box:first").show();

	$("ul.helpdesk_tab li a").click(function () {
		$("ul.helpdesk_tab li a").removeClass("on");
		$(this).addClass("on");
		$(".content_helpdesk_box").hide();
		// this.onclick 속성 가져오기에 리스트 onclick클릭시 에러발생 dohun  수정
		var activeTab = $(this).attr("onclick");
		if("helpdesk_tab1" == activeTab || "helpdesk_tab2" == activeTab || "helpdesk_tab3" == activeTab || "helpdesk_tab4" == activeTab){
			$("#" + activeTab).fadeIn();
		}else{
			var helpdeskTab1 = activeTab.indexOf("helpdesk_tab1"); 
			var helpdeskTab2 = activeTab.indexOf("helpdesk_tab2"); 
			var helpdeskTab3 = activeTab.indexOf("helpdesk_tab3"); 
			var helpdeskTab4 = activeTab.indexOf("helpdesk_tab4"); 
			
			if(helpdeskTab1 > -1){
				$("#helpdesk_tab1").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}if(helpdeskTab2 > -1){
				$("#helpdesk_tab2").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}if(helpdeskTab3 > -1){
				$("#helpdesk_tab3").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}if(helpdeskTab4 > -1){
				$("#helpdesk_tab4").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}
		 }
	});
	
	//지식존 추가 dohun
	$(".content_knowledge_box").hide();
	$(".content_knowledge_box:first").show();

	$("ul.knowledge_tab li a").click(function () {
		$("ul.knowledge_tab li a").removeClass("on");
		$(this).addClass("on");
		$(".content_knowledge_box").hide();
		// this.onclick 속성 가져오기에 리스트 onclick클릭시 에러발생 dohun  수정
		var activeTab = $(this).attr("onclick");
		if("knowledge_tab1" == activeTab || "knowledge_tab2" == activeTab || "knowledge_tab3" == activeTab || "knowledge_tab4" == activeTab){
			$("#" + activeTab).fadeIn();
		}else{
			var knowledgeTab1 = activeTab.indexOf("knowledge_tab1"); 
			var knowledgeTab2 = activeTab.indexOf("knowledge_tab2"); 
			var knowledgeTab3 = activeTab.indexOf("knowledge_tab3"); 
			var knowledgeTab4 = activeTab.indexOf("knowledge_tab4");
			
			if(knowledgeTab1 > -1){
				$("#knowledge_tab1").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}if(knowledgeTab2 > -1){
				$("#knowledge_tab2").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}if(knowledgeTab3 > -1){
				$("#knowledge_tab3").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}if(knowledgeTab4 > -1){
				$("#knowledge_tab4").fadeIn();
				$(this).parent().parent().parent().parent().children("a").addClass("on");
			}
		 }
	});	

	$(".content_schedule_box").hide();
	$(".content_schedule_box:first").show();

	$("a.schedule_tab").click(function () {
		$("a.schedule_tab").removeClass("on");
		$(this).addClass("on");
		
		$(".content_schedule_box").hide();
		var activeTab = $(this).attr("tab_name");
		$('#' + activeTab).show();
	});

	$(".content_graph_box").hide();
	$(".content_graph_box:first").show();

	$("ul.graph_tab li a").click(function () {
		$("ul.graph_tab li a").removeClass("on");
		$(this).addClass("on");
		$(".content_graph_box").hide();   
		var activeTab = $(this).attr("onclick");
		$("#" + activeTab).fadeIn();
	});


	$(".content_club_box").hide();
	$(".content_club_box:first").show();

	$("ul.club_tab li a").click(function () {
		$("ul.club_tab li a").removeClass("on");
		$(this).addClass("on");
		$(".content_club_box").hide();
		var activeTab = $(this).attr("onclick");
		// dohun  수정
		var more = $(this).attr("class").indexOf("more"); 
		if(more > -1){
			$("#" + activeTab).fadeIn();	
			$(this).parent().parent().children("a").addClass("on");
		}else{
			$("#" + activeTab).fadeIn();	
			$(this).parent().parent().parent().parent().children("a").addClass("on");
		}
		// //dohun  수정
	});
});
/* tabmenu end */


/* 2016.01.20 슬라이드배너 오류 수정 */

/* 배너 start */
$(function(){
  $('.flexslider').flexslider({
	animation: "slide",
	directionNav: false
  });
});
/* 배너 end */



/* 시스템바로가기 start */
/* 2016.02.26 수정*/
$(function(){
  $('.flexslider2').flexslider({
	animation: "slide",
	directionNav: false,
	controlNav: true,
	// options
	start:function(slider){
		$(".slide-current-slide").text(slider.currentSlide+1);
		$(".slide-total-slides").text("/"+slider.count)
	},
	before:function(slider){
		$(".slide-current-slide").text(slider.animatingTo+1)
	}
  });
});
/* 시스템바로가기 end */

/* 2016.01.20 슬라이드배너 오류 수정 */



/* 긴급공지 start */
$(function(){
  $('.flexslider3').flexslider({
	 /*
	animation: "slide",
	directionNav: true,
	controlNav: false,
	direction:"horizontal",
	slideshowSpeed:"5000",
	animationSpeed:"15000"
	*/
	animation: "slide",
	directionNav: true,
	controlNav: false,
	slideshowSpeed:"5000",
	direction:"vertical"
  });
});
/* 긴급공지 end */


/* 검색어롤링 start */
function fn_popWordRolling(){
	$('.flexslider4').flexslider({
		animation: "slide",
		directionNav: true,
		controlNav: false,
		direction:"vertical"
	});	
}
/* 검색어롤링 end */





/* 임원재실관리 start */
$(function(){
  $('.executive_popup').click(function(){
	$('#content_executive_popup').show();
  });
  $('.popup_close').click(function(){
	$('#content_executive_popup').hide();
  });
});
/* 임원재실관리 end */


/* 직원검색 start */
$(function(){
	$(".select_ul li span").click(function(){
		$(this).parent().children("ul").toggle();
		if( $(this).parent().children("ul").is( ":visible") == true ){
			$(this).text(' - ');
		}else {
			$(this).text(' + ');
		}

	});

	$(".member_check_all, .smember_check_all").click(function() {
		if($(this).is(':checked')){
			$(this).parent().parent().find("input").attr("checked", true);
		}else{
			$(this).parent().parent().find("input").attr("checked", false);
		}
	});

	$(".select_ul li input").click(function() {
		if($(this).is(':checked')){
			$(this).parent().find("input").attr("checked", true);
		}else{
			$(this).parent().find("input").attr("checked", false);
		}
	});
});
/* 직원검색 end */

/* 사이트맵, 트리메뉴 start */
$(function(){
	$(".sitemap_1depth li span, .helper_search_ul li span, .edit_list_1depth span").click(function(){
		$(this).parent().children("ul").toggle();
		if( $(this).parent().children("ul").is( ":visible") == true ){
			$(this).text(' - ');
		}else {
			$(this).text(' + ');
		}
		
		if(parent.autoresize_iframe_portlets){
			parent.autoresize_iframe_portlets();
		}
	})
		//		

});
/* 사이트맵, 트리메뉴 end */





// 테이블스크롤
$(function(){
	var OuterH = $(".table_scroll").height();
	var OuterW = $(".table_scroll").width();
	var InnerH = $(".table_scroll").children().height();

	if( InnerH > OuterH ) {
		$(".table_scroll").css("width", OuterW + 18 );
	}
});

/* 2016.02.23 수정 */
$(function(){
	$(".container_inner > .content_headtext").css("width", $(".container_inner").width() - 2 )

	$(".subject > .text-overflow > .icon").each(function(){

		if( $(this).parent("div").width() > $(this).parent().children("a").width() ) {
			$(this).css('left', $(this).parent().children("a").width() + 3 );
		}else {
			$(this).css('left', $(this).parent("div").width() + 3 );
		}
	});


});

$(window).resize(function() {
	
	$(".container_inner > .content_headtext").css("width", $(".container_inner").width() - 2 )

	$(".subject > .text-overflow > .icon").each(function(){

		if( $(this).parent("div").width() > $(this).parent().children("a").width() ) {
			$(this).css('left', $(this).parent().children("a").width() + 3 );
		}else {
			$(this).css('left', $(this).parent("div").width() + 3 );
		}
	});
});
/* 2016.02.23 수정 */

/* 2016.01.29 검색자동완성 추가*/

$(function(){
  $('.btn_keyword').click(function(){
	$('.keyword_result').toggle();
	if( $(".btn_keyword").hasClass("off") ){
		$(this).removeClass("off").addClass("on");
		setCookieEkr( "autoWordOnOffCookie", "on" )
	}else {
		$(this).removeClass("on").addClass("off");
	}
  });
});

	/* 2016.01.29 검색자동완성 추가*/

/* 2016.01.31 상단추가작업중 */
$(function(){
  $('#header_type2 .gnb .menu li.mymenu > a').click(function(){
	$('.mymenu_wrap').toggle();
	if( $(this).parent().hasClass("off") ){
		$(this).parent().removeClass("off").addClass("on");
		
		if($("#header_type2 .gnb .menu li.system").hasClass("on")){
			$('.systemmenu_wrap').toggle();
			$("#header_type2 .gnb .menu li.system").removeClass("on").addClass("off");
		}
	}else {
		$(this).parent().removeClass("on").addClass("off");
	}
  });
});


$(function(){
  $('#header_type2 .gnb .menu li.system > a').click(function(){
	$('.systemmenu_wrap').toggle();
	if( $(this).parent().hasClass("off") ){
		$(this).parent().removeClass("off").addClass("on");
		
		if($("#header_type2 .gnb .menu li.mymenu").hasClass("on")){
			$('.mymenu_wrap').toggle();
			$("#header_type2 .gnb .menu li.mymenu").removeClass("on").addClass("off");
		}
	}else {
		$(this).parent().removeClass("on").addClass("off");
	}
  });
});

//사이드메뉴 자식있는 메뉴 클릭이벤트
$(function(){
  $('.lnb_wrap .list li > span.lnbbtn').click(function(){
	$(this).parent().children("ul").toggle();

	if( $(this).parent().hasClass("off") ){
		$(this).removeClass("off").addClass("on");
		$(this).parent().removeClass("off").addClass("on");
	}else {
		$(this).removeClass("on").addClass("off");
		$(this).parent().removeClass("on").addClass("off");
	}
  });
});

$(function(){
  $('.lnb_wrap .title .tbtn').click(function(){

	if( $(this).hasClass("open") ){
		$(this).removeClass("open").addClass("close");
		$(".content_wrap").css("margin-left", "-0" );
		$(".lnb_wrap").css("margin-left", "-231px" );
	}else {
		$(this).removeClass("close").addClass("open");
		$(".content_wrap").css("margin-left", "220px" );	
		$(".lnb_wrap").css("margin-left", "-20px" );
	}
  });
});



/* 2016.01.31 상단추가작업중 */



/* 2016.02.03 작업 */
$(function(){
	$('.sitemap_table td .menu').click(function(){
		$(this).parent().children('.depth2').toggle();
		if( $(this).hasClass("open") ){
			$(this).removeClass("open").addClass("close");
		}else {
			$(this).removeClass("close").addClass("open");
		}
	});
	
	$("#sitemap_tab2").hide();

	$("ul.sitemap_tab li a").click(function () {
		$("ul.sitemap_tab li").removeClass("on");
		$(this).parent().addClass("on");
		$("#sitemap_tab1").hide();
		$("#sitemap_tab2").hide();
		var activeTab = $(this).attr("onclick");
		$("#" + activeTab).fadeIn(0);
		
		if(parent.autoresize_iframe_portlets){
			parent.autoresize_iframe_portlets();
		}
	});
});
/* 2016.02.03 작업 */

/* 2016.02.13 작업 */
$(function(){
	$('.share_list ul li:nth-child(n+5)').addClass('hide');
	if( $('.share_list ul li').length <= 4 ){
		$('.share_wrap .btn').hide();
	}else{
		$('.share_wrap .btn').show();
	}
	$('.share_wrap .btn').click(function(){
		if( $(this).html() == 'More' ){
			$(this).html('Close');
			$('.share_list ul li:nth-child(n+5)').removeClass('hide');
		}else{
			$(this).html('More');
			$('.share_list ul li:nth-child(n+5)').addClass('hide');
		}
	});
});
/* 2016.02.13 작업 */

/* 2016.02.19 작업 */
$(function(){
  $('.lnb_wrap .list .depth2 > .menu').click(function(){
	$(this).children("ul").toggle();

	if( $(this).children("ul").is(':visible') == true ){
		$(this).addClass("active");
	}else {
		$(this).removeClass("active");
	}
  });
});
