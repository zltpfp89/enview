<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/cola/cafe/css/skin/default/cafe_title.css" type="text/css" />
<div id="div_cafe_title" name="div_cafe_title">
	<div class="title">
		<div class="title_background" style="background-image: url('<%=request.getContextPath() %>/cola/cafe/images/background/header.jpg');"></div>
		<div class="title_cafeName"></div>
		<div class="title_cafeUrl"></div>
		<div class="title_cafeTitleMenu"  style="background-image: url('<%=request.getContextPath() %>/cola/cafe/images/background/header02.jpg');">
			<a href="#"><img src="<%=request.getContextPath() %>/cola/cafe/images/titlemenu/top_menu01.gif" alt="최신글보기" /></a>
			<a href="#"><img src="<%=request.getContextPath() %>/cola/cafe/images/titlemenu/top_menu02.gif" alt="인기글보기" /></a>
			<a href="#"><img src="<%=request.getContextPath() %>/cola/cafe/images/titlemenu/top_menu03.gif" alt="이미지보기" /></a>
			<a href="#"><img src="<%=request.getContextPath() %>/cola/cafe/images/titlemenu/top_menu04.gif" alt="동영상보기" /></a>
		</div>
		<div class="title_cafeSearch"></div>
		<div class="title_counter"></div>
	</div>
</div>