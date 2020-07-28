<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Iterator" %>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<html>
<head>
	<title>비고 등록</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Content-style-type" content="text/css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/css/popup.css" />
	
       <script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/E/E0302.js?r=<%=Math.random()%>"></script>
	<style>
		.searchArea ul li {width: 50% !important;}	
		.ocrt_wrap {padding: 10px !important;}
	</style>
</head>
<!-- size:748*670 -->
<body class="popup">
<h2><span>비고 등록</span></h2>
   
<div class="contents">
	<div id="sub_tab">
		<div class="ocrt_wrap clearfix">
    
			<div class="ocrt_01 ocrt_list_tab0 list">
    			<form name="e_updateComn" id="e_updateComn" method="post" onkeydown="if(event.keyCode==13) javascript:fn_e_updateComn()">
				   	<textarea name="dtaTabComn" id="dtaTabComn" cols="10" rows="5"><c:if test="${empty dtaTabComn}"></c:if><c:if test="${not empty dtaTabComn}">${dtaTabComn}</c:if></textarea>
				    <!-- btnArea -->
				    <div class="btnArea">
						<div class="r_btn">
							<a href="javascript:fn_e_updateComn();" id="updateComn" class="btn_blue">
								<span id="comn">
									<c:if test="${dtaTabComn != null }">
										수정
									</c:if>
									<c:if test="${dtaTabComn == null }">
										등록
									</c:if>
								</span>
							</a>
							<a href="javascript:fn_e_closeUpdateComn();" class="btn_white"><span>닫기</span></a>
						</div>
					</div>
				    <!-- btnArea// -->
			   	</form>
			   
                                                  
			</div>
		<!--//ocrt_wrap-->
		</div>
	</div>
</div>		
    <a href="javascript:fn_e_closeUpdateComn();"><img class="btn_close" src="${pageContext.request.contextPath}/sjpb/images/popup_close.png" alt="닫기" /></a>
</body>
</html>
