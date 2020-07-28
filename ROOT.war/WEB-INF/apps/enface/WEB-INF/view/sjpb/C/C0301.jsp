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
		<title>사건추가팝업</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/css/popup.css" />
		
        <script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/C/C0301.js?r=<%=Math.random()%>"></script>
		<style>
			.searchArea ul li {width: 50% !important;}	
			.ocrt_wrap {padding: 10px !important;}
		</style>
	</head>
	<!-- size:748*670 -->
	<body class="popup" onload="selectIncSearchList();">
	    <h2><span>사건추가</span></h2>
        
			<!-- contents -->
			<form name="contentsFormData" id="contentsFormData">
			<input type="hidden" id="userId" name="userId" value="${userInfo.userId}" />   <!-- 사용자계정 -->
			<input type="hidden" id="userName" name="userName" value="${userInfo.userName}" />  <!-- 사용자이름 -->
			<input type="hidden" id="orgCd" name="orgCd" value="${userInfo.orgCd}" />   <!-- 수사팀코드 -->
			<input type="hidden" id="kindCd" name="kindCd" value="${userInfo.kindCd}" />  <!-- 수사단원구분 01:수사관 02:팀장 03:과장 -->	    
    
    			<div class="contents">
                   <div id="sub_tab">
                       <div class="ocrt_wrap clearfix">
                           
                           <div class="ocrt_01 ocrt_list_tab0 list">
                               <!-- searchArea -->
                               <div class="searchArea">
                                   <ul>       
                                       <li><span class="title">접수일자</span>
                                           <label for="beDtFromSC"></label><input type="text" class="w30per calendar datepicker" id="beDtFromSC" name="beDtFromSC" value="${beDtFromSC}"/> ~ <label for="txt_03"></label><input type="text" class="w30per calendar datepicker" id="beDtToSC" name="beDtToSC" value="${beDtToSC}"/>
                                       </li>   
										<li><span class="title">수사팀</span>
                                           <div class="inputbox w65per">
                                               <p class="txt"></p>
												<select id="criTmIdSC" name="criTmIdSC">
                                                  <option value="">전체</option> 							
													<c:forEach items="${criTmList}" var="item">
													    <option value="${item.criTmId}">${item.criTmNm}</option> 
													</c:forEach>
                                               </select>                                              
                                           </div>
                                       </li>                                       
                                   </ul>
								<div class="searchbtn">
									<a href="#" class="btn_white" id="initBtn" ><span>초기화</span></a>
									<a href="#" class="btn_blue" id="sechBtn"><span>검색</span></a>
								</div>
                               </div>
                               <!-- searchArea //-->
                               <!-- listArea -->
                               <div id="sheetP" class="listArea" style="height: 200px; width: 100%">
                               </div>
                               <!-- listArea //-->
							   <div class="btnArea pop_back">
							        <div class="r_btn"><a href="#" class="btn_white" id="cnfmBtn"><span>확 인</span></a><a href="#" class="btn_blue" id="closBtn"><span>닫 기</span></a></div>
							   </div>                         
                              
                           </div>
                                                  
                       </div>
                       <!--//ocrt_wrap-->
                   </div>
				</div>
		
			<!-- contents //-->
			</form>
   
    <!-- //pop content-->
    <a href="#"><img class="btn_close" src="${pageContext.request.contextPath}/sjpb/images/popup_close.png" alt="닫기" /></a>
</body>
</html>
