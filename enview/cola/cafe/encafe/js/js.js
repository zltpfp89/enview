$(function(){
  $('.flexslider').flexslider({
	animation: "slide",
	directionNav: false,
	controlNav: false,
	// options
	start:function(slider){
		$(".slide-current-slide").text(slider.currentSlide+1);
		$(".slide-total-slides").text("/"+slider.count)
	},
	before:function(slider){
		$(".slide-current-slide").text(slider.animatingTo+1)
	}
	});
	$('.join > .prev').on('click', function(){
		$('.flexslider').flexslider('prev');
		return false;
	})
	$('.join > .next').on('click', function(){
		$('.flexslider').flexslider('next');
		return false;
	})
	var dd = $(".flexslider > .slides > li").length;
	if( dd == 1 ){
		$(".flexslider_count.join").hide();
	}
});

$(function(){
  $('.flexslider2').flexslider({
	animation: "slide",
	directionNav: false,
	controlNav: false,
	// options
	start:function(slider){
		$(".slide-current-slide2").text(slider.currentSlide+1);
		$(".slide-total-slides2").text("/"+slider.count)
	},
	before:function(slider){
		$(".slide-current-slide2").text(slider.animatingTo+1)
	}
	});
	$('.favo > .prev').on('click', function(){
		$('.flexslider2').flexslider('prev');
		return false;
	})
	$('.favo > .next').on('click', function(){
		$('.flexslider2').flexslider('next');
		return false;
	})
	var dd = $(".flexslider2 > .slides > li").length;
	if( dd == 1 ){
		$(".flexslider_count.favo").hide();
	}
});

$(function(){
  $('.flexslider3').flexslider({
	animation: "slide",
	directionNav: false,
	controlNav: false,
	});
	$('.rank > .prev').on('click', function(){
		$('.flexslider3').flexslider('prev');
		return false;
	})
	$('.rank > .next').on('click', function(){
		$('.flexslider3').flexslider('next');
		return false;
	})
});


$(function(){
	$(".main_cafe_cont").hide();
	$(".main_cafe_cont:first").show();
	$("li.main_cafe_tab").click(function () {
		$("li.main_cafe_tab, li.main_cafe_tab a").removeClass("on");
		$(this).addClass("on");
		$(this).children("a").addClass("on");
		$(".main_cafe_cont").hide()
		var activeTab = $(this).children("a").attr("onclick");
		$("#" + activeTab).show()
	});
});

$(function(){
	$(".main_cafe_basic").hide();
	$(".main_cafe_basic:first").show();
	$("li.main_cafe_tab").click(function () {
		$("li.main_cafe_tab, li.main_cafe_tab a").removeClass("on");
		$(this).addClass("on");
		$(this).children("a").addClass("on");
		$(".main_cafe_basic").hide()
		var activeTab = $(this).children("a").attr("onclick");
		$("#" + activeTab).show()
	});
});


$(function(){
	$(".cafe_side_join_cont").hide();
	$(".cafe_side_join_cont:first").show();
	$("ul.cafe_side_join_tab > li > a").click(function () {
		$("ul.cafe_side_join_tab > li > a, ul.cafe_side_join_tab > li").removeClass("on");
		$(this).addClass("on");
		$(this).parent("li").addClass("on");
		$(".cafe_side_join_cont").hide()
		var activeTab = $(this).attr("onclick");
		$("#" + activeTab).show()
	});
});


$(function(){
	$(".lnb_dep1 > li > a > button").click(function(e){
		// 클릭이벤트가 dom 트리를 타고 위로 올라간다.
		// a 태그에도 클릭 이벤트가 발생하므로 막아준다.
		e.preventDefault();
		e.stopImmediatePropagation();
		 if( $(this).parent().parent().children("ul").is(":visible") == true ){
			$(this).removeClass("on");
			$(this).parent().parent().children("ul").slideUp();
		 }else{
			 $(".lnb_dep1 > li > a > button").removeClass('on');
			$(".lnb_dep2").slideUp();
			$(this).parent().parent().children("ul").slideDown();
			$(this).addClass('on');
		 }
	});
});



$(function(){
	$(".tabcontent").hide();
	$(".tabcontent:first").show();
	$(".cafeadm_tabmenu ul li").click(function () {
		$(".cafeadm_tabmenu ul li").removeClass("on");
		$(this).addClass("on");
		$(".tabcontent").hide()
		var activeTab = $(this).children("a").attr("onclick");
		$("#" + activeTab).show()
	});
});





$(function(){
	$(".cafeadm_menu_contents").hide();
	$(".cafeadm_menu_list_middle li").click(function () {
		$(".cafeadm_menu_list_middle li").removeClass("on");
		$(this).addClass("on");
		$(".cafeadm_menu_contents").hide()
		var activeTab = $(this).attr("onclick");
		$("#" + activeTab).show()
	});
});
