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
		<link rel="stylesheet" type="text/css" href="${cPath}/fss/css/contents.css" />
		<link rel="stylesheet" type="text/css" href="${cPath}/sjpb/css/sjpb_custom.css" />
		<link rel="stylesheet" type="text/css" href="${cPath}/javascript/jstree/themes/default/style.min.css" />
		<link rel="stylesheet" href="${cPath}/QCELL/css/qcell.css" type="text/css" />
		<script type="text/javascript" src="${cPath}/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="${cPath}/sjpb/js/Z/loading/js/HoldOn.min.js"></script>
		<script type="text/javascript" src="${cPath}/sjpb/js/Z/common.js"></script>	
		<script type="text/javascript" src="${cPath}/javascript/jstree/jstree.min.js" ></script>
		<script type="text/javascript" src="${cPath}/QCELL/qcell.js"></script>
        <script type="text/javascript" src="${cPath}/fss/js/account/stock/depositWithdraw.js?r=<%=Math.random()%>"></script>
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
			   	<li>
	   	  			<span class="title">기간</span>
				   	<input type="text" id="srchCaseNo" name="srchCaseNo" />
			   	</li>
			   	<li>
	   	  			<span class="title">거래구분</span>
				   	<input type="text" id="srchCaseNo" name="srchCaseNo" />
			   	</li>
		   	</ul>
			<div class="searchbtn">
				<a href="javascript:search();" class="btn_blue"><span>검색</span></a>
			</div>
	   	</div>
	   	</form>
	   	<!-- searchArea //-->
	   	<!-- listArea -->
	   	<div id="sheetStockDepositWithdraw" class="listArea area-mousewheel" style="height: 800px; width: 100%">
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
