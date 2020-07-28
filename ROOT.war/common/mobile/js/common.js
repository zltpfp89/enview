function fn_setImgResize(cnttAreaId) {
	var $area = $("#" + cnttAreaId);
	
	$area.find("img").each(function (index) {
		// 본문영역에 있는 모든 img 태그의 이미지 사이즈 조절
		// 이미지의 원본 사이즈가 현제 본문영역의 크기보다 크다면 조절
		// 작거나 같다면 그대로
		var bodyWidth = $("body").width();
		var imgWidth = $(this).width();
		
		if (imgWidth > bodyWidth) {
			$(this).removeAttr("width");
			$(this).removeAttr("height");
			$(this).attr("width", "100%")
			
			$(this).removeAttr("style");
			$(this).css("width", "100%");
		}
	});
}