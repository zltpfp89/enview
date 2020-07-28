<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="borderPickerPanel" class="borderPickerPanel">
	<div id="borderPicker" class="<c:out value="${form.pattern }"/>" style="z-index: 99999;">
		<c:forEach begin="${form.begin }" end="${form.end }" varStatus="status">
			<div id="brdrStyle<c:out value="${status.index }"/>" class="brdrStyle brdrStyle<c:out value="${form.wh }"/>" style="background-image: url('<%=request.getContextPath()%>/cola/cafe/images/editor/<c:out value="${form.pattern}"/>.gif');"></div>
		</c:forEach>
	</div>
</div>
<script type="text/javascript">
	var width = parseInt('<c:out value="${form.wh }"/>'.substring(0,2));
	var height = '<c:out value="${form.wh }"/>'.substring(2) * <c:out value="${form.end - form.begin + 1 }"/>;
	$('#borderPickerPanel').css('width', width);
	$('#borderPickerPanel').css('height', height);

	var eh = '<c:out value="${form.wh }"/>'.substring(2);
	$('.brdrStyle').each(function(i){
		var $this = $(this);
		var index = $this.attr('id').replace('brdrStyle','');
		var posY = -index * eh + 'px';
		$this.css('background-position', '0px ' + posY);
	});	 
</script>