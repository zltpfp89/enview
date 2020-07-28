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
<title>범죄수사자료조회관리대장</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/css/contents.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/Z/js/dhtmlx/suite/dhtmlx.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/Z/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/Z/js/main.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/F/F0102.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
	<div class="searchArea">
		<form name="f_searchList" id="f_searchList" method="post" onkeydown="if(event.keyCode==13) fn_searchList()">
			<ul>
				<li><span class="title">수사관</span>
					<label for="nmKor"></label><input type="text" name="nmKor" value="${vo.nmKor }" class="w65per">
				</li>
				<li><span class="title">피의자</span>
					<label for="sp"></label><input type="text" name="sp" value="${vo.sp }" class="w65per">
				</li>
				<li><span class="title">등록일자</span>
					<label for="startDay"></label><input type="text" name="startDay" value="${vo.startDay }" class="w30per calendar datepicker"> ~ <label for="endDay"></label><input type="text" name="endDay" value="${vo.endDay }" class="w30per calendar datepicker">
				</li>
			</ul><br>
			<div class="searchbtn">
				<div class="r_btn">
					<a href="javascript:fn_searchList();"id="btn_search" class="btn_blue"><span>검색</span></a>
					<a href="javascript:fn_f_init('f_searchList');" class="btn_white"><span>초기화</span></a>
				</div>
			</div>
		</form>
	</div>
	<!-- listArea -->
	<div id="sheet" class="listArea mrt15" style="height: 580px; width: 100%">
	
	</div> 
	<!-- listArea //-->
	<!-- btnArea -->
	<div class="btnArea">
		<div class="r_btn">
			<a href="javascript:fn_btnInsert();" class="btn_blue"><span>신규</span></a>
			<a href="javascript:fn_deleteCriData();" class="btn_white"><span>삭제</span></a>
		</div>
		<div class="l_btn">
			<a href="javascript:exportLOC();" class="btn_blue"><span>출력</span></a>
		</div>
	</div>
	<!-- btnArea //-->
	
	<form name="f_insertdata" id="f_insertdata" method="post" onkeydown="if(event.keyCode==13) fn_insertcriData('1')">
		<input type="hidden" name="regUserId" value="${userInfo.userId }">  <!-- 사용자계정 -->
 		<input type="hidden" name="respIo" value="${respIo }"> <%-- 담당수사관 아이디 --%>
		<table class="list" cellpadding="0" cellspacing="0">
			<colgroup>
				<col width="15%" />
				<col width="35%" />
			</colgroup>
			<tbody>
				<tr>
					<th class="C">수사관</th>
					<td class="L">
						<label for="nmKor"></label><input type="text" name="nmKor" id="nmKor" class="w80per">
						<div class="list_box">
						<a href="javascript:fn_searchNmKor();"id="btn_search" class="btn_gray"><span>검색</span></a>
						</div>
					</td>
				</tr>
				<tr>
					<th class="C">피의자</th>
					<td class="L"><label for="sp"></label><input type="text" name="sp" id="sp" class="w100per"></td>
				</tr>
				<tr>
					<th class="C">비고</th>
					<td class="L"><textarea name="mngBkComn" id="mngBkComn"></textarea></td>
				</tr>
			</tbody>
		</table>
		<div class="btnArea">
			<div class="r_btn">
				<a href="javascript:fn_insertcriData('1');" id="btn_insertcriData" class="btn_blue"><span>등록</span></a>
			</div>
		</div>
	</form>
</body>
</html>
