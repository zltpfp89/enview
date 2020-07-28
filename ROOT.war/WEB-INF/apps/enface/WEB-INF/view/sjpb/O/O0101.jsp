<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>사건조회이력</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/O/O0101.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
<div class="searchArea">
	<form name="o_searchList" id="o_searchList" method="post" onkeydown="if(event.keyCode==13) fn_o_selectList()">
		<ul id="inchistArea">
			<li><span class="title">조회자 이름</span>
				<input type="text" class="w65per" name="nmKorSc" id="nmKorSc" value="${sc.nmKorSc }"/>
			</li>
			<li><span class="title">조회일자</span>
				<input type="text" class="w65per calendar datepicker" name="inqDtSc" id="inqDtSc" value="${sc.inqDtSc }" readonly/>
			</li>
			<li></li>			
		</ul>
		<div class="searchbtn">
			<a href="javascript:fn_o_selectList();" id="btn_search" class="btn_blue"><span>검색</span></a>
			<a href="javascript:fn_o_init('o_searchList');" class="btn_white"><span>초기화</span></a>
		</div>
	</form>
</div> 

<div id="inqHist" class="listArea mrt15 area-mousewheel" style="height: 700px; width: 100%"></div>

<!-- btnArea -->
<div class="btnArea">
	<div class="r_btn">
		<a href="javascript:void(0);" id="exceldown" class="btn_white excel"><span>엑셀다운로드</span></a>
	</div>
</div>
<!-- //btnArea -->
</body>
</html>