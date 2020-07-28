<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Iterator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	request.setAttribute("cPath", request.getContextPath());
%>
<html>
	<head>
		<title>증권원장분석 계좌기본정보</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
		<link rel="stylesheet" type="text/css" href="${cPath}/QCELL/css/qcell.css" />
		<link rel="stylesheet" type="text/css" href="${cPath}/sjpb/css/contents.css" />
		<link rel="stylesheet" type="text/css" href="${cPath}/sjpb/css/board.css" />
		<script type="text/javascript" src="${cPath}/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="${cPath}/sjpb/js/Z/loading/js/HoldOn.min.js"></script>
		<script type="text/javascript" src="${cPath}/sjpb/js/Z/common.js"></script>	
		<script type="text/javascript" src="${cPath}/javascript/jstree/jstree.min.js" ></script>
		<script type="text/javascript" src="${cPath}/QCELL/qcell.js"></script>
        <script type="text/javascript" src="${cPath}/fss/js/account/stock/stockAccAnalysis.js?r=<%=Math.random()%>"></script>
	</head>
	<body class="iframe">
	   	<!-- searchArea -->
	   	<form name="" id="">
 		<div class="searchArea" id="searchArea">
		   	<ul>
	   	  		<li>
	   	  			<span class="title">사건번호</span>
				   	<input type="text" id="srchCaseNo" name="srchCaseNo" />
			   	</li>
			   	<li></li>
			   	<li></li>
		   	</ul>
			<div class="searchbtn">
				<a href="javascript:search();" class="btn_blue"><span>검색</span></a>
			</div>
	   	</div>
	   	</form>
	   	<!-- searchArea //-->
	   	<!-- listArea -->
	   	<div id="sheetStockAcc" class="listArea area-mousewheel" style="height: 700px; width: 100%">
	   	</div>
	   	<!-- listArea //-->
	   	<!-- btnArea -->
	   	<div class="btnArea">
	   		<div class="r_btn">
		   		<a href="javascript:void(0);" id="exceldownBtn" class="btn_white excel"><span>엑셀다운로드</span></a>
	   		</div>
	   	</div>
	   	<!-- btnArea //-->
	</body>
</html>
