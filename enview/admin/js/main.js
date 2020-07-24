
/* leftmenu */
(function($){
$(document).ready(function(){
	$('#systemmenu li.active').addClass('open2').children('ul').show();
	$('#systemmenu li.has-sub>a.click').on('click', function(){
		
	//  $(this).removeAttr('href');
		$('#systemmenu li.has-sub2>a.click').removeAttr('href');
		
		var element = $(this).parent('li');
		if (element.hasClass('open2')) {
			element.removeClass('open2');
			element.find('li').removeClass('open2');
			element.find('ul').slideUp(200);
		}
		else {
			element.addClass('open2');
			element.children('ul').slideDown(200);
			element.siblings('li').children('ul').slideUp(200);
			element.siblings('li').removeClass('open2');
			element.siblings('li').find('li').removeClass('open2');
			element.siblings('li').find('ul').slideUp(200);
		}
	});
});
})(jQuery);

jQuery(function($){
	$("#root_left").click(function(){
		var rootLeftMenuStatus = $("#leftmenu").hasClass("open2");
		if(rootLeftMenuStatus == true) {
			$("#leftmenu").css("left",-220);
			$("#leftmenu").css("width",24);
			$("#root_left").css("left", 0);
			$("#root_left").find("img").attr("src","/admin/images/btn_open.png");
			$(".wrap").css("padding-left",10);
			$("#leftmenu").removeClass("open2");
		} else {
			$("#leftmenu").css("left",0);
			$("#leftmenu").css("width",220);
			$("#root_left").css("left", 220);
			$(".wrap").css("padding-left",230);
			$("#root_left").find("img").attr("src","/admin/images/btn_close.png");
			$("#leftmenu").addClass("open2");
		}
	});
});


//tab
jQuery(function($){
	var tab = $('.tab_wrap');
	tab.removeClass('js_off');
//	tab.css('height', tab.find('>ul>li>div:visible').height()+100);
	function onSelectTab(){
		var t = $(this);
		var myClass = t.parent('li').attr('class');
		t.parents('.tab_wrap:first').attr('class', 'tab_wrap '+myClass);
	//	tab.css('height', t.next('div').height()+100);
		
	}
	tab.find('>ul>li>a').click(onSelectTab).focus(onSelectTab);
});

jQuery(function($){
	var tab = $('.portmini');
	tab.removeClass('js_off');
	tab.css('height', tab.find('>ul>li>ul:visible').height());
	function onSelectTab(){
		var t = $(this);
		var myClass = t.parent('li').attr('class');
		t.parents('.portmini:first').attr('class', 'portmini '+myClass);
		tab.css('height', t.next('ul').height());
	}
	tab.find('>ul>li>a').click(onSelectTab).focus(onSelectTab);
});


jQuery(function($){
	// Frequently Asked Question
//	var article = $('.tab_list>.summary_table>.article');
	var article = $('.summary_table>.article');
	article.addClass('hide');
	article.find('.bottom').hide();
	article.eq(0).removeClass('hide');
	article.eq(0).find('.bottom').show();
	article.eq(0).find('.btn').addClass('open');
	article.eq(0).find('.tbody').addClass('open');
//	$('.tab_list>.summary_table>.article>.title>a').click(function(){
	$('.summary_table>.article>.title>a').click(function(){
		var myArticle = $(this).parents('.article:first');
		if(myArticle.hasClass('hide')){
			article.addClass('hide').removeClass('show');
			article.find('.bottom').slideUp(100);
			article.find('.btn').removeClass('open');
			article.find('.tbody').removeClass('open');
			myArticle.removeClass('hide').addClass('show');
			myArticle.find('.bottom').slideDown(100);
			myArticle.find('.btn').addClass('open');
			myArticle.find('.tbody').addClass('open');
		} else {
			myArticle.removeClass('show').addClass('hide');
			myArticle.find('.bottom').slideUp(100);	
			myArticle.find('.btn').removeClass('open');
			myArticle.find('.tbody').removeClass('open');
		}
		return false;
	});
});

/* allmenu */
/*$(function(){
	$(".gnb ul li, #allmenu").mouseover(function(){
		$("#allmenu").css('display', 'block');			
	});

	$(".gnb ul li, #allmenu").mouseout(function(){
		$("#allmenu").css('display', 'none');			
	});	
});*/

/* allmenu */
$(function(){
	$(".gnb > ul > li").mouseenter(function (e) {
		$(".open").hide();
		$(".dropmenu").hide();
		$(this).children("div").show();
	});
	
	$(".gnb > ul > li").mouseleave(function (e) {
		$(this).children("div").hide();
		$("ul.open").each(function (i) {
			//$(this).prev().html("▼");
			$(this).removeClass("open");
			$(this).hide();
		});
	});	
	
	$(".dropmenu span.toggle").click(function (e) {
		//if ($(this).html() == "▼") {
		//	$(this).html("▲");
		//} else {
		//	$(this).html("▼");
		//}
		$(this).next("ul").toggleClass("open");
		$(this).next("ul").toggle();
	});
});