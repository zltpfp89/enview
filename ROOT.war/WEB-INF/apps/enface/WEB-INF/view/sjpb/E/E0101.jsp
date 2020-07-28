<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>수기수사자료대장</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-style-type" content="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/E/E0101.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
	<!-- searchArea -->
	<div class="searchArea">
		<form name="e_searchList" id="e_searchList" method="post" onkeydown="if(event.keyCode==13) fn_e_searchList()">
			<input type="hidden" name="userId" value="${userInfo.userId }"/>
			<ul>
				<li><span class="title">성명</span><label for="spNm"></label><input type="text" name="spNm" class="w65per"/></li>
				<li><span class="title">담당특사경</span><label for="nmKor"></label><input type="text" name="nmKor" class="w65per"/></li>
				<li><span class="title">발견여부</span><label for="dvYn"></label> 
					<div class="inputbox w65per">
                    	<p class="txt"></p>
						<select name="dvYn">
							<option value="">전체</option>
							<c:forEach items="${dvFormKndList}" var="dvForm" varStatus="status">
								<option value="${dvForm.code}">${dvForm.codeName}</option>
							</c:forEach>
						</select>
					</div>
				</li>
				<li><span class="title">작성일자</span>
					<label for="startDay"></label><input type="text" name="startDay" class="w30per calendar datepicker"/>
					&nbsp;~&nbsp; 
					<label for="endDay"></label><input type="text" name="endDay" class="w30per calendar datepicker"/>
				</li>
				<li></li>
				<li></li>
			</ul>
			<div class="searchbtn">
				<a href="javascript:fn_e_searchList();"id="btn_search" class="btn_blue"><span>검색</span></a>
				<a href="javascript:fn_e_init('e_searchList');" class="btn_white"><span>초기화</span></a>
			</div>
		</form>
	</div>
	<!-- searchArea// -->
	
	<!-- listArea -->
	<div id="sheet" class="listArea mrt15" style="height: 580px; width: 100%"></div>
	<!-- listArea// -->
	
	<!-- report -->
	<form name="reportForm" method="post">
		<input type="hidden" id="reptNm" name="reptNm" value="" />
		<input type="hidden" id="xmlData" name="xmlData" value="" />
	</form>
	<!-- //report -->
	
	<!-- btnArea -->
	<div class="btnArea">
		<div class="r_btn">
			<a href="javascript:void(0);" id="addBtn" class="btn_blue"><span>신규</span></a>
			<a href="javascript:fn_e_prnHawrReport();" class="btn_white"><span>출력</span></a> 
			<a href="javascript:fn_e_deleteHawr();" id="deleteBtn" class="btn_white" style="display:none;"><span>삭제</span></a>
		</div>
	</div>
	<!-- btnArea// -->
</body>
</html>