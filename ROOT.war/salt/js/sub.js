$(document).ready(function(){
	selectBox();
	checkList();
	menuList();
	normaltab();
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
			'width' : parentBox.width() + 20 + 'px',
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

function checkList(){
	$('.checkList > ul > li > a').click(function(){
		$(this).next('ul').slideToggle();
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

function menuList(){
	$('.menuList ul li a').click(function(){
		$(this).next('ul').slideToggle();
	})
}

