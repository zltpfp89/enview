$(document).ready(function(){
	normaltab();
	promotionOnOff();
	flexslider("flexslider1", true, false, false, false);
	flexslider("flexslider2", true, false, false, false);
	flexslider("flexslider3", true, false, true, false);
});


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


function promotionOnOff(){
	$('.promotion .btn_close').click(function(){
		$('.promotionArea').css('display','none');
		$('.visualArea').css('display','block');
	})
	$('.visualArea .btn_promotion').click(function(){
		$('.visualArea').css('display','none');
		$('.promotionArea').css('display','block');
	})
}

