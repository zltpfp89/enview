/***************************/
//@Author: Adrian "yEnS" Mato Gondelle & Ivan Guardado Castro
//@website: www.yensdesign.com
//@email: yensamg@gmail.com
//@license: Feel free to use it, but keep this credits please!					
/***************************/

$(document).ready(function(){
	$(".tabm > li").click(function(e){
		switch(e.target.id){
			case "tab1":
				//change status & style menu
				$("#tab1").addClass("on");
				$("#tab2").removeClass("on");
				$("#tab3").removeClass("on");
				//display selected division, hide others
				$("div.list1").css("display", "block");
				$("div.list2").css("display", "none");
				$("div.list3").css("display", "none");
			break;
			case "tab2":
				//change status & style menu
				$("#tab1").removeClass("on");
				$("#tab2").addClass("on");
				$("#tab3").removeClass("on");
				//display selected division, hide others
				$("div.list2").css("display", "block");
				$("div.list1").css("display", "none");
				$("div.list3").css("display", "none");
			break;
			case "tab3":
				//change status & style menu
				$("#tab1").removeClass("on");
				$("#tab2").removeClass("on");
				$("#tab3").addClass("on");
				//display selected division, hide others
				$("div.list3").css("display", "block");
				$("div.list1").css("display", "none");
				$("div.list2").css("display", "none");
			break;
		}
		//alert(e.target.id);
		return false;
	});
});