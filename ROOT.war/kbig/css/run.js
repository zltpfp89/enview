$(window).on('ready load resize',function(){
		
	var winWidth = $(window).width();

	 if (winWidth <= 1179){ // MOBILE
		$('.header').addClass('hd_mobile');
		$('.header').removeClass('hd_pc');
		
	} else if(winWidth  > 1179) { // PC
		$('.header').addClass('hd_pc');
		$('.header').removeClass('hd_mobile');

		$('.gnb .dep_01').removeClass('on')
		$('.gnb .dep_02').hide()
	}
}); 


$(function(){
	/*//GNB PC
	$(document).on('mouseover','.hd_pc .gnb .dep_01',function(){
		$(this).addClass('on').siblings().removeClass('on');
		idx=$('.hd_pc .gnb .dep_01').index(this)
		$('.dep_02').hide(0)
		$('.gnb_bg').fadeIn(0);
		$('.gnb_bg .txt_wrap').eq(idx).fadeIn(0).siblings().hide()
		$('.dep_02',this).fadeIn(0)
	});	
	//GNB PC
	$(document).on('mouseleave','.hd_pc',function(){
		$('.gnb_bg, .dep_02').hide(0)
		$('.gnb .dep_01, .gnb_bg',this).removeClass('on')
	});*/

	//GNB PC
	$(document).on('mouseover','.hd_pc .gnb .dep_01',function(){
		$(this).addClass('on').siblings().removeClass('on');		
		$('.dep_02').fadeIn(0);
		$('.gnb_bg').addClass('on');
	});	
	//GNB PC
	$(document).on('mouseleave','.hd_pc',function(){
		$('.dep_02').hide(0)
		$('.gnb .dep_01, .gnb_bg',this).removeClass('on')
	});
	
	//GNB MOBILE
	$(document).on('click','.hd_mobile .gnb_wrap .dep1_title',function(e){
		e.preventDefault();
		$(this).next('.dep_02').slideToggle(0);//dep2 ul
		$(this).toggleClass('on');
		$(this).parent().siblings().children('.dep1_title').removeClass('on')
		$(this).parent().siblings().children('.dep_02:visible').slideUp(0)
		$(this).parent().siblings().children().children().children('.gnb_3dep').slideUp(0)
		$(this).parent().siblings().children().children().children('.dep2_txt').removeClass('on')
	});
	
	$(document).on('click','.hd_mobile .gnb_wrap .dep2_txt',function(e){
		//ckkim : 3depth 뎁스 contents 가 없을 시 a 태그 href 이동 적용
		if($(this).hasClass("dep2_have_top")){
			e.preventDefault();
		}
		$(this).next('.gnb_3dep').slideToggle(0);
		$(this).toggleClass('on');
		$(this).parent().siblings().children('.dep2_txt').removeClass('on')
		$(this).parent().siblings().children('.gnb_3dep:visible').slideUp(0)
	});
	//GNB MOBILE AND


	$(document).on('click','.btn_menu',function(){
		$(this).toggleClass('on')
		$('.hd_mobile').toggleClass('on')
	});

	
	
	//lnb
	$('.lnb .dep1_title').on('click',function(e){
		//ckkim : 2depth 뎁스 contents 가 없을 시 a 태그 href 이동 적용
		if($(this).hasClass("dep2_have")){
			e.preventDefault();
		}
		$(this).next('.lnb_2dep').slideToggle(0);
		$(this).toggleClass('on');
		$(this).parent().siblings().children().removeClass('on')
		$(this).parent().siblings().children('.lnb_2dep:visible').slideUp(0)
	});
			
	$('.lnb .dep2_txt').on('click',function(){
		$('.lnb .dep2_txt').removeClass('on')
		$(this).addClass('on')
	});

	$('.lnb_dep1 > li.on .lnb_2dep li').on('click',function(){
		$(this).addClass('on');
		$(this).siblings('.lnb_2dep li:visible').removeClass('on');
	});

	//검색창
	$('.btn_search a').on('click',function(e){
		e.preventDefault();
	    $(this).parent().parent().next().addClass('on');
	});
	
	$('.all_search_close').on('click',function(e){
		e.preventDefault();
		$(this).parent().removeClass('on');
	});

	//PDF
	$('.btn_pdf').on('click',function(){
      $(this).next().toggleClass('on');
	  $(this).prev().toggleClass('on');
	});
	$('.pdf_close').on('click',function(){
      $(this).parent().removeClass('on');
	  $(this).parent().prev().prev().removeClass('on');
	});

	//TAB
	$(".tab_wrap > ul li").click(function(){
		var now_tab = $(this).index();
		$(this).parent().find("li").removeClass("on");
		$(this).parent().parent().parent().parent().find(".div_cont").addClass("hidden");
		$(this).parent().find("li").eq(now_tab).addClass("on");
		$(this).parent().parent().parent().parent().find(".div_cont").eq(now_tab).removeClass("hidden");
	});

	//FAQ
	$('.faq_wrap .faq > li > a').on('click',function(e){
		e.preventDefault();
		$(this).parent('li').siblings('li').removeClass('on')
		$(this).parent('li').siblings('li').children('.answer_wrap').slideUp()
		$(this).parent('li').toggleClass('on')
		$(this).next('.answer_wrap').slideToggle(200,function(){
			console.log($(".div_cont.hidden").height());
			parent.fn_childIframeAutoresize(parent.document.getElementById(window.name),parseInt($(".div_cont.faq_content").height())+100);
			parent.fn_scrollTop();
		})
	});



});
