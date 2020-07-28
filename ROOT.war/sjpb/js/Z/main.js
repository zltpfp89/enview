//select Box
$(document).ready(function(){
	$('.inputbox').find('select').each(function() {
		var self = $(this),
			parentBox = self.parents('.inputbox'),
			change = function() {
				$(this).prev('.txt').text($(this).find('option:selected').text());
			},
			focusin = function() {
				$(this).parents('.inputbox').addClass('selected');
			},
			focusout = function() {
				$(this).parents('.inputbox').removeClass('selected');
			};

		self.css({

			'height' : parentBox.height() + 'px'
		}).on({
			'change' : change,
			'focusin' : focusin,
			'focusout' : focusout
		});
	}).end().find('.txt').each(function(){
		var self = $(this);
		self.text(self.next('select').find('option:selected').text());
	});
});

//select Box2
$(document).ready(function(){
	$('.inputbox2').find('select').each(function() {
		var self = $(this),
			parentBox = self.parents('.inputbox2'),
			change = function() {
				$(this).prev('.txt').text($(this).find('option:selected').text());
			},
			focusin = function() {
				$(this).parents('.inputbox2').addClass('selected');
			},
			focusout = function() {
				$(this).parents('.inputbox2').removeClass('selected');
			};

		self.css({

			'height' : parentBox.height() + 'px'
		}).on({
			'change' : change,
			'focusin' : focusin,
			'focusout' : focusout
		});
	}).end().find('.txt').each(function(){
		var self = $(this);
		self.text(self.next('select').find('option:selected').text());
	});
});


//gnb 2depth
$(function(){
	$(".gnb div.depth_2").hide();
	$(".gnb .wrap li").hover(function(){
		$(this).children('div.depth_2').css('display','block');
	},
	function(){
		$(this).children('div.depth_2').css('display','none'); 
	})
});

/* leftmenu */
(function($){
$(document).ready(function(){
	$('#systemmenu li.active').addClass('open').children('ul').show();
	$('#systemmenu li.has-sub>a.click').on('click', function(){
		$(this).removeAttr('href');
		var element = $(this).parent('li');
		if (element.hasClass('open')) {
			element.removeClass('open');
			element.find('li').removeClass('open');
			element.find('ul').slideUp(200);
		}
		else {
			element.addClass('open');
			element.children('ul').slideDown(200);
			element.siblings('li').children('ul').slideUp(200);
			element.siblings('li').removeClass('open');
			element.siblings('li').find('li').removeClass('open');
			element.siblings('li').find('ul').slideUp(200);
		}
	});
});
})(jQuery);

jQuery(function($){
	$("#root_left").click(function(){
		var rootLeftMenuStatus = $("#leftmenu").hasClass("open");
		if(rootLeftMenuStatus == true) {
			$("#leftmenu").css("left",-168);
			$("#leftmenu").css("width",24);
			$("#root_left").css("left", 0);
			$("#root_left").find("img").attr("src","/sjpb/images/btn_open.png");
			$(".contentsArea .wrap").css("padding-left",10);
			$("#leftmenu").removeClass("open");
		} else {
			$("#leftmenu").css("left",0);
			$("#leftmenu").css("width",168);
			$("#root_left").css("left", 168);
			$(".contentsArea .wrap").css("padding-left",189);
			$("#root_left").find("img").attr("src","/sjpb/images/btn_close.png");
			$("#leftmenu").addClass("open");
		}
	});
});


//tab
jQuery(function($){
	var tab = $('.tab_wrap');
	tab.removeClass('js_off');
	function onSelectTab(){
		var t = $(this);
		var myClass = t.closest('li').attr('class');
		t.parents('.tab_wrap:first').attr('class', 'tab_wrap '+myClass);
	}
	tab.find('>ul>li>span>a.tabtitle').click(onSelectTab).focus(onSelectTab);
});

//tab
jQuery(function($){
	var tab2 = $('.tab_mini_wrap');
	tab2.removeClass('js_off');
	tab2.css('height', tab2.find('>ul>li>div:visible').height()+60);
	function onSelectTab(){
		var t = $(this);
		var myClass = t.parent('li').attr('class');
		t.parents('.tab_mini_wrap:first').attr('class', 'tab_mini_wrap '+myClass);
		tab2.css('height', tab2.find('>ul>li>div:visible').height()+60);
		
	}
	tab2.find('>ul>li>a').click(onSelectTab).focus(onSelectTab);
});

jQuery(function($){
	var tab2 = $('.tab_small');
	tab2.removeClass('js_off');
	tab2.css('height', tab2.find('>ul>li>div:visible').height()+60);
	function onSelectTab(){
		var t = $(this);
		var myClass = t.parent('li').attr('class');
		t.parents('.tab_small:first').attr('class', 'tab_small '+myClass);
		tab2.css('height', tab2.find('>ul>li>div:visible').height()+60);
		
	}
	tab2.find('>ul>li>a').click(onSelectTab).focus(onSelectTab);
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
	var article = $('.tab_list>.summary_table>.article');
	article.addClass('hide');
	article.find('.bottom').hide();
	article.eq(0).removeClass('hide');
	article.eq(0).find('.bottom').show();
	article.eq(0).find('.btn').addClass('open');
	article.eq(0).find('.tbody').addClass('open');
	$('.tab_list>.summary_table>.article>.title>a').click(function(){
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
$(function(){
	$(".gnb ul li, #allmenu").mouseover(function(){
		$("#allmenu").css('display', 'block');			
	});

	$(".gnb ul li, #allmenu").mouseout(function(){
		$("#allmenu").css('display', 'none');			
	});	
});

/* allmenu */
$(function(){
	$(".treebtnArea .treebtn").click(function(){	
		$(this).next(".tree").slideToggle();	
	});
});



