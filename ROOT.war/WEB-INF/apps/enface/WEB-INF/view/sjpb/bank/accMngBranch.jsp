<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Iterator" %>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%
	request.setAttribute("cPath", request.getContextPath());
%>

<html>
	<head>
		<title>사건관리</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
		<link rel="stylesheet" type="text/css" href="${cPath}/sjpb/css/sjpb_custom.css" />
		<link rel="stylesheet" type="text/css" href="${cPath}/javascript/jstree/themes/default/style.min.css" />
		<script type="text/javascript" src="${cPath}/sjpb/js/Z/jquery.base64.js"></script>
        <script type="text/javascript" src="${cPath}/fss/js/account/bank/accMngBranch.js?r=<%=Math.random()%>"></script>
        <script type="text/javascript" src="${cPath}/javascript/jstree/jstree.min.js" ></script>
	</head>
	<body class="iframe">
	   	<!-- searchArea -->
 		<div class="searchArea" id="searchArea">
		   	<ul>
	   	  		<li><span class="title">사건번호</span>
				   	<div class="inputbox w65per">
					   	<p class="txt"></p>
					   	<select id="srchCaseNo" name="srchCaseNo">
					   		<c:forEach items="${caseList}" var="cse">
					   			<option value="${cse.rcptNum}">${cse.rcptIncNum}</option>
					   		</c:forEach>
					   	</select>
				   	</div>
			   	</li>
			   	<li></li>
			   	<li></li>
		   	</ul>
			<div class="searchbtn">
				<a href="javascript:search();" class="btn_blue"><span>검색</span></a>
			</div>
	   	</div>
	   	<!-- searchArea //-->
	   	<!-- listArea -->
	   	<div id="sheetBankAccMngBranch" class="listArea area-mousewheel" style="height: 800px; width: 100%">
	   	</div>
	   	<!-- listArea //-->
	   	<!-- btnArea -->
	   	<div class="btnArea">
	   		<div class="r_btn">
		   		<a href="javascript:void(0);" id="exceldownIncPrnBtn" class="btn_white excel"><span>엑셀다운로드</span></a>
	   		</div>
	   	</div>
	   	<!-- btnArea //-->
	</body>
</html>
