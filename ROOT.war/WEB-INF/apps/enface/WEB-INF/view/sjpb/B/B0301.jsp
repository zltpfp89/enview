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
		<title>피의자수정팝업</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/css/popup.css" />
		
		<script type="text/javascript">
			const IS_ALL_UPDATE_YN = "";
		</script>
		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/B/B0101.js?r=<%=Math.random()%>"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/B/B0301.js?r=<%=Math.random()%>"></script>
		<style>
			.searchArea ul li {width: 50% !important;}	
			.ocrt_wrap {padding: 10px !important;}
		</style>
	</head>
	<!-- size:748*670 -->
	<body class="popup">
			<h2><span>피의자 정보 수정</span></h2>
		
			<!-- contents -->
			<form name="contentsFormData" id="contentsFormData">
			<input type="hidden" id="userId" name="userId" value="${userInfo.userId}" />   <!-- 사용자계정 -->
			<input type="hidden" id="userName" name="userName" value="${userInfo.userName}" />  <!-- 사용자이름 -->
			<input type="hidden" id="orgCd" name="orgCd" value="${userInfo.orgCd}" />   <!-- 수사팀코드 -->
			<input type="hidden" id="kindCd" name="kindCd" value="${userInfo.kindCd}" />  <!-- 수사단원구분 01:수사관 02:팀장 03:과장 -->	    
    
    			<div class="tab_mini_wrap m1">
    			
    			 <div class="tab_mini_contents" id="b0301ContentsDiv">
    			 	
    			 	<table class="list" cellpadding="0" cellspacing="0">
                        <colgroup>
                            <col width="15%" />
                            <col width="35%" />
                            <col width="15%" />
                            <col width="35%" />
                        </colgroup>
                        <tbody>
                            <tr>                                                                    
                                <th class="C">상세내용</th>
                                <td class="L" colspan="3">
                                	<textarea id="mfCont" name="mfCont" data-type="required" title="상세내용" cols="" rows=""></textarea>
                                	<span class="remaining">
									    <span class="count">0</span>/<span class="maxcount">2000</span>byte(한글 1000자, 영어2000자)
									</span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
    			 
    			 	<div id="b0301ContentsArea">
    			 		<%-- 그리는영역 --%>
    			 		
    			 		<!-- 그리는 영역 끝 -->
    			 	</div>
					 <div class="btnArea">
				        <div class="r_btn" style="padding-bottom:20px;"><a href="#" class="btn_white" id="cnfmBtn"><span>승인요청</span></a><a href="#" class="btn_blue" id="closBtn"><span>닫 기</span></a></div>
				    </div>
				 </div>
				</div>
			<!-- contents //-->
			</form>
   
    <!-- //pop content-->
    <a href="#"><img class="btn_close" src="${pageContext.request.contextPath}/sjpb/images/popup_close.png" alt="닫기" /></a>
</body>
</html>
