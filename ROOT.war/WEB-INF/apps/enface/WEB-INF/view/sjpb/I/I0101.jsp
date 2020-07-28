<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.Iterator"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld"%>

<html>
<head>
<title>통계원표</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-style-type" content="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/I/I0101.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
	<!-- report -->
	<form name="reportForm" method="post">
		<input type="hidden" id="reptNm" name="reptNm" value="" />
		<input type="hidden" id="xmlData" name="xmlData" value="" />
	</form>

	<form name="contentsFormData" id="contentsFormData">
		<input type="hidden" id="userId" name="userId" value="${userInfo.userId}" />
		<!-- 사용자계정 -->
		<input type="hidden" id="userName" name="userName" value="${userInfo.userName}" />
		<!-- 사용자이름 -->
		<input type="hidden" id="orgCd" name="orgCd" value="${userInfo.orgCd}" />
		<!-- 수사팀코드 -->
		<input type="hidden" id="kindCd" name="kindCd" value="${userInfo.kindCd}" />
		<!-- 수사단원구분 01:수사관 02:팀장 03:과장 -->
		<input type="hidden" id="today" name="today" value="${stsGrapFillDtToSC}" />
		<!-- 오늘날짜 -->
		<!-- searchArea -->
		<div class="searchArea">
			<ul>
				<li><span class="title">사건번호</span> <label for="rcptIncNumSC"></label><input type="text" class="w65per" id="rcptIncNumSC" name="rcptIncNumSC" />
				</li>
				<li><span class="title">피의자</span> <label for="spNmSC"></label><input type="text" class="w65per" id="spNmSC" name="spNmSC" /></li>
				<li><span class="title">위법조항</span> <label for="incCriNmSC"></label><input type="text" class="w65per" id="incCriNmSC" name="incCriNmSC" /></li>
				<li><span class="title">작성일자</span> <label for="stsGrapFillDtFromSC"></label>
				<input type="text" class="w30per calendar datepicker" id="stsGrapFillDtFromSC" name="stsGrapFillDtFromSC" value="${stsGrapFillDtFromSC}" /> ~ <labelfor="stsGrapFillDtToSC"></label><input type="text"class="w30per calendar datepicker" id="stsGrapFillDtToSC"name="stsGrapFillDtToSC" value="${stsGrapFillDtToSC}" /></li>
				<li></li>
				<li></li>			
			</ul>
			<div class="searchbtn">
				<a href="#" class="btn_white" id="initBtn"><span>초기화</span></a>
				<a href="#" class="btn_blue" id="srchBtn"><span>검색</span></a>
			</div>
		</div>
		<!-- searchArea //-->
		<!-- listArea -->
		<div id="sheet" class="listArea" style="height: 500px; width: 100%"></div>
		<!-- listArea //-->
		<!-- btnArea -->
		<div class="btnArea">
			<div class="r_btn">
				<a href="#" class="btn_white" id="addBtn"><span>신규</span></a>
				<a href="#" class="btn_white" id="saveBtn"><span>저장</span></a>
				<a href="#" class="btn_white" id="delBtn"><span>삭제</span></a> 
				<a href="#" class="btn_blue" id="prnBtn"><span>출력</span></a>
			</div>
		</div>
		<!-- btnArea //-->
	</form>
</body>
</html>

