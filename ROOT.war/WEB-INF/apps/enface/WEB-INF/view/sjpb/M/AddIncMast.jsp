<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<html>
<head>
	<title>사건 추가</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Content-style-type" content="text/css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/css/popup.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/AddIncMast.js?r=<%=Math.random()%>"></script>
	<style>
		.searchArea ul li {width: 50% !important;}	
		.ocrt_wrap {padding: 10px !important;}
	</style>
</head>
<!-- size:748*670 -->
<body class="popup">
    <h2><span>사건 추가</span></h2>
    <div class="contents">
	    <div id="sub_tab">
	        <div class="ocrt_wrap clearfix">
	            <div class="ocrt_01 ocrt_list_tab0 list">	
					<!-- searchArea -->
					<div class="searchArea">
						<form name="m_searchIncMastList" id="m_searchIncMastList" method="post" onkeydown="if(event.keyCode==13) fn_m_selectIncMastList()">
							<ul>
								<li><span class="title">사건번호</span><label for="rcptIncNum"></label><input type="text" name="rcptIncNum" value="${vo.rcptIncNum }" class="w30per"></li>
								<li><span class="title">수사담당자</span><label for="nmKor"></label><input type="text" name="nmKor" value="${vo.nmKor }" class="w30per"></li>
							</ul>
							<div class="btnArea">
								<div class="r_btn">
									<a href="javascript:fn_m_selectIncMastList();" id="btn_search" class="btn_blue"><span>검색</span></a>
									<a href="javascript:fn_m_init('m_searchIncMastList');" class="btn_white"><span>초기화</span></a>
								</div>
							</div>
						</form>
					</div>
					<!-- //searchArea -->	
							
					<!-- listArea -->
					<div id="sheetIncMastList" class="listArea mrt15 area-mousewheel" style="height:270px; width:100%">
					</div>  
					<!-- //listArea -->
					
					<!-- btnArea -->
					<div class='btnArea pop_back' id="btnArea_pop" style="display:none;">
						<div class='r_btn'>
							<a href='javascript:fn_m_selectSendItemList();' class='btn_white' id='cnfmBtn'><span>추가</span></a>
							<a href='javascript:fn_m_closeIncMastList();' class='btn_blue' id='closBtn'><span>닫기</span></a>
						</div>
					</div>
					<!-- //btnArea -->
					
				</div>    
			</div>
            <!--//ocrt_wrap-->
		</div>
		<!-- subtabs -->
	</div>
	<!-- contents //-->     
    <a href="javascript:fn_m_closeIncMastList();"><img class="btn_close" src="${pageContext.request.contextPath}/sjpb/images/popup_close.png" alt="닫기"/></a>
</body>
</html>
