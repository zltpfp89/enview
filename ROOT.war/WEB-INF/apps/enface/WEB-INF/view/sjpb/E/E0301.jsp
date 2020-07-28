<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<html>
<head>
<title>피의자 추가팝업</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-style-type" content="text/css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/css/popup.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/E/E0301.js?r=<%=Math.random()%>"></script>
<style>
	.searchArea ul li {width: 50% !important;}	
	.ocrt_wrap {padding: 10px !important;}
</style>
</head>
<!-- size:748*670 -->
<body class="popup">
<h2><span>사건추가</span></h2>
   
<div class="contents">
	<div id="sub_tab">
		<div class="ocrt_wrap clearfix">
    
			<div class="ocrt_01 ocrt_list_tab0 list">
    			<!-- searchArea -->
				<div class="searchArea">
		    		<form name="e_searchSpList" id="e_searchSpList" method="post" onkeydown="if(event.keyCode==13) fn_e_searchSpList()">
		    			<input type="hidden" name="userId" value="${userInfo.userId }"/>
				    	<ul>
							<li><span class="title">사건번호</span><label for="rcptIncNum"></label><input type="text" name="rcptIncNum" value="${vo.rcptIncNum }" class="w100per"></li>
							<li><span class="title">성명</span><label for="spNm"></label><input type="text" name="spNm" value="${vo.spNm }" class="w100per"></li>
							<li><span class="title">접수일자</span><label for="regDate"></label><input type="text" name="regStart" value="${regStart }" class="w30per calendar datepicker">~<input type="text" name="regEnd" value="${regEnd }" class="w30per calendar datepicker"></li>
							<li></li>
						</ul>
						<div class="btnArea">
							<div class="r_btn">
								<a href="javascript:fn_e_searchSpList();"id="btn_search" class="btn_blue"><span>검색</span></a>
								<a href="javascript:fn_e_init('e_searchSpList');" class="btn_white"><span>초기화</span></a>
							</div>
						</div>
					</form>
				</div>
		
				<!-- listArea -->
			    <div id="spList" class="listArea mrt15" style="height: 298px; width: 100%">
			    </div>  
			    <!-- //listArea -->
				<!-- btnArea -->
				<div class='btnArea pop_back' id="btnArea_pop" style="display:none;">
					<div class='r_btn'>
						<a href='javascript:fn_e_insertHawrCriData();' class='btn_white' id='cnfmBtn'><span>추가</span></a>
						<a href='javascript:fn_e_closeInsertHawrCriData();' class='btn_blue' id='closBtn'><span>닫기</span></a>
					</div>
				</div>
                 <!-- //btnArea -->                                 
			</div>
		<!--//ocrt_wrap-->
		</div>
	</div>
</div>		
<a href="javascript:fn_e_closeInsertHawrCriData();"><img class="btn_close" src="${pageContext.request.contextPath}/sjpb/images/popup_close.png" alt="닫기" /></a>
</body>
</html>
