<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ taglib prefix="common" uri="/WEB-INF/tld/common.tld" %>
<!-- 2016.02.11 수정 -->
<%--
		<div id="filePreview" class="layerpopup_bg" >
 --%>		
			<div class="layerpopup_photo_wrap">
				<div class="layerpopup_header">
					<h2>파일보기</h2>
					<a href="#" class="close" onclick="$('#filePreview').hide();">닫기</a>
				</div>

				<div class="layerpopup_content layerpopup_photo">
					<img id="slideImg" />
					<div class="layerpopup_photo_count">
						<span id="slidePage"></span> / <span id="slideTotal"></span>
					</div>
					<button id="slidePrev" onclick="slideshow(-1)">이전</button>
					<button id="slideNext" onclick="slideshow(1)">다음</button>
				</div>
			</div>
<%--		</div>
 --%>
