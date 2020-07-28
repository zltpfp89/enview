<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>부서별 송치 및 지휘(건/명) 수사현황</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/J/J0104.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
<!-- searchArea -->
<div class="searchArea">
	<form name="j_searchList" id="j_searchList" method="post" onkeydown="if(event.keyCode==13) fn_searchList()">
		<ul>
			<li><span class="title">기간</span>
            	<label for="regStart"></label><input type="text" name="regStart" value="${sc.regStart }" class="w30per calendar datepicker" readonly/>~
            	<label for="regEnd"></label><input type="text" name="regEnd" value="${sc.regEnd }" class="w30per calendar datepicker" readonly/>
            </li>
		</ul>
		<div class="searchbtn">
			<a href="javascript:fn_searchList();"id="btn_search" class="btn_blue"><span>검색</span></a>
			<a href="javascript:fn_M_init('j_searchList');" class="btn_white"><span>초기화</span></a>
		</div>
	</form>
</div>
<!-- listArea -->
<div id="sheet" class="listArea mrt15 area-mousewheel" style="height: 600px; width: 100%">
</div> 
<!-- //listArea -->

<!-- report -->
<form name="reportForm" method="post">
	<input type="hidden" id="reptNm" name="reptNm" value="" />
	<input type="hidden" id="xmlData" name="xmlData" value="" />
</form>
<!-- //report -->
</body>
</html>