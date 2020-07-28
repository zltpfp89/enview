$(document).ready(function(){
	selectBox();
	SearchRankHover();
	lnbmenu();
	calendarlnb();
	portletTabChng();
	refreshTabChng();
	allmenuHover();
	quickserviceOnOff();
	fn_tabAction();
	normaltab();
	tabset();
	closePopup();
	openservicelinkPopup();
	flexslider("flexslider1", true, false, true, true);
	flexslider("flexslider2", true, true, true, false);
	flexslider("flexslider3", true, false, false, false);
});

//셀렉트 박스
function selectBox(){
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
			'width' : parentBox.width() + 30 + 'px',
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
}

function SearchRankHover(){
	$(".search_rank").hover(function(){
		$(this).children('.cont').css('display','block');
	},
	function(){
		$(this).children('.cont').css('display','none');
	})
}

function allmenuHover(){
	var allmenulist = $('.allmenu .wrap > ul > li');
	allmenulist.css('height', allmenulist.parents('.allmenu').height());
	$(".gnb, .allmenu").hover(function(){
		$('.allmenu').css('display','block');
	},
	function(){
		$('.allmenu').css('display','none');
	})
}

function lnbmenu(){
	$('.lnb .depth01 > li.on').children('.depth02').css('display','block');
	$(".lnb .depth01 > li > span > a.btn_arr").click(function(){
		$('.lnb .depth01 > li').removeClass('on');
		$('.depth02').slideUp();
		$(this).parents("li").addClass('on');
		$(this).parents("span").next(".depth02").slideDown();
	})
}

function calendarlnb(){
	$('.calendarlnb .depth01 > li.on').children('.depth02').css('display','block');
	$(".calendarlnb .depth01 > li > span > a.btn_arr").click(function(){
		var a = $(this).parent().parent().hasClass("on");
		if(a){
			$(this).parents("li").removeClass('on');
			$(this).parents("span").next(".depth02").slideUp();
		}else{
			$(this).parents("li").addClass('on');
		$(this).parents("span").next(".depth02").slideDown();
		}
	})
}


function portletTabChng(){
	var tab = $('.tab_normal');
	tab.removeClass('js_off');
	tab.css('height', tab.find('>ul>li>div:visible').height());
	function onSelectTab(){
		var t = $(this);
		var myClass = t.parent('li').attr('class');
		t.parents('.tab_normal:first').attr('class', 'tab_normal '+myClass);
		tab.css('height', t.next('div').height());
	}
	tab.find('>ul>li>a').click(onSelectTab).focus(onSelectTab);
}

function refreshTabChng(){
	var tab = $('.tab_refresh');
	tab.removeClass('js_off');
	tab.css('height', tab.find('>ul>li>div:visible').height());
	function onSelectTab(){
		var t = $(this);
		var myClass = t.parent('span').parent('li').attr('class');
		t.parents('.tab_refresh:first').attr('class', 'tab_refresh '+myClass);
		tab.css('height', t.next('div').height());
	}
	tab.find('>ul>li>span>a').click(onSelectTab).focus(onSelectTab);
}

//flexslider
function flexslider(classNm, arg0, arg1, arg2, arg3, arg4){
	$("." + classNm).flexslider({
		animation : arg0,
		directionNav : arg1,
		controlNav : arg2,
		pausePlay : arg3,
		direction: arg4
	});
}

function quickserviceOnOff(){
	$('.quickservicebtn .btn_close').click(function(){
		$(this).css('display','none');
		$('.quickservicebtn .btn_open').css('display','block');
		$('.quickserviceArea').slideUp();
	})
	$('.quickservicebtn .btn_open').click(function(){
		$(this).css('display','none');
		$('.quickservicebtn .btn_close').css('display','block');
		$('.quickserviceArea').slideDown();
	})
}

function fn_tabAction(){
	
	$(".ocrt_sub_tab").click(function(){
			var f = $(this).siblings();
			var num = $(this).attr("data");
			
			$(f).each(function( index ) {
				var n = $(this).attr("data");
				$(this).removeClass("sub_tab_on");
				$("." + n ).hide();
			});
			
			$(this).addClass("sub_tab_on");
			$("." + num ).show();
		})
		
	}

function normaltab(){
	
	$(".tabtitle").click(function(){
			var f = $(this).siblings();
			var num = $(this).attr("data");
			
			$(f).each(function( index ) {
				var n = $(this).attr("data");
				$(this).removeClass("tab_on");
				$("." + n ).hide();
			});
			
			$(this).addClass("tab_on");
			$("." + num ).show();
		})
		
	}

function tabset(){
	$('.btn_set').click(function(){
		$(this).siblings('.tab_set').css('display','block');
	})
	$('.tab_set .btn_close').click(function(){
		$(this).parents('.tab_set').css('display','none');
	})
}

function closePopup(){
   $('.main_popup a.btn_close, .main_popup a.btn_white').click(function(){
		 $(this).parents('.main_popup').css('display','none');
   })

   $('.main_serviceLink a.btn_close, .main_serviceLink a.btn_white').click(function(){
		 $(this).parents('.main_serviceLink').css('display','none');
   })
}


function openservicelinkPopup(){
	$('#footer .copyright a.btn_green').click(function(){
		$('#popup_servicelink').css('display','block');
	})
}
