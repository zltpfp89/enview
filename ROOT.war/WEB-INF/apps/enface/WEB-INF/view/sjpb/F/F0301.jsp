<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
	<title>범죄수사 경력조회 피의자 추가 팝업</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Content-style-type" content="text/css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/css/popup.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/F/F0301.js?r=<%=Math.random()%>"></script>
	<style>
		.searchArea ul li {width: 50% !important;}	
		.ocrt_wrap {padding: 10px !important;}
	</style>
</head>
<!-- size:748*670 -->
<body class="popup">
    <h2><span>범죄수사경력조회요청</span></h2>
    <div class="contents">
	    <div id="sub_tab">
	        <div class="ocrt_wrap clearfix">
	            <div class="ocrt_01 ocrt_list_tab0 list">	
					<!-- searchArea -->
					<div class="searchArea">
						<form name="f_cridtaSpList" id="f_cridtaSpList" method="post" onkeydown="if(event.keyCode==13) fn_f_selectCridtaSpList()">
							<ul>
								<li><span class="title">사건번호</span><label for="incNum"></label><input type="text" name="incNum" value="${incSpVo.incNum }" class="w100per"></li>
								<li><span class="title">피의자명</span><label for="spNm"></label><input type="text" name="spNm" value="${incSpVo.spNm }" class="w100per"></li>
								<li><span class="title">주민번호</span><label for="spIdNum"></label>
									<input type="text" name="spIdNum_1" value="${fn:split(incSpVo.spIdNum,'-')[0] }" class="w30per">&nbsp;-&nbsp;
									<input type="text" name="spIdNum_2" value="${fn:split(incSpVo.spIdNum,'-')[1] }" class="w30per">
								</li>
								<li></li>
							</ul>
							<div class="btnArea">
								<div class="r_btn">
									<a href="javascript:fn_f_selectCridtaSpList();" id="btn_search" class="btn_blue"><span>검색</span></a>
									<a href="javascript:fn_f_init('f_cridtaSpList');" class="btn_white"><span>초기화</span></a>
								</div>
							</div>
						</form>
					</div>
					<!-- //searchArea -->	
							
					<!-- listArea -->
					<div id="sheetCridtaSpList" class="listArea mrt15 area-mousewheel" style="height:270px; width:100%">
					</div>  
					<!-- //listArea -->
					
					<!-- btnArea -->
					<div class='btnArea pop_back' id="btnArea_pop" style="display:none;">
						<div class='r_btn'>
							<a href='javascript:fn_f_selectSendItemList();' class='btn_white' id='cnfmBtn'><span>추가</span></a>
							<a href='javascript:fn_f_closeCridtaSpList();' class='btn_blue' id='closBtn'><span>닫기</span></a>
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
    <a href="javascript:fn_f_closeCridtaSpList();"><img class="btn_close" src="${pageContext.request.contextPath}/sjpb/images/popup_close.png" alt="닫기"/></a>
</body>
</html>
