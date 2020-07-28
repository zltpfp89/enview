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
		<title>수정이력팝업</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/css/popup.css" />
		
        <script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/A/A0201.js?r=<%=Math.random()%>"></script>
		<style>
			.searchArea ul li {width: 50% !important;}	
			.ocrt_wrap {padding: 10px !important;}
		</style>
	</head>
	<!-- size:748*670 -->
	<body class="popup">
	    <h2><span>수정내용입력</span></h2>
        
			<!-- contents -->
			<form name="contentsFormData" id="contentsFormData">
			<input type="hidden" id="userId" name="userId" value="${userInfo.userId}" />   <!-- 사용자계정 -->
			<input type="hidden" id="userName" name="userName" value="${userInfo.userName}" />  <!-- 사용자이름 -->
			<input type="hidden" id="orgCd" name="orgCd" value="${userInfo.orgCd}" />   <!-- 수사팀코드 -->
			<input type="hidden" id="kindCd" name="kindCd" value="${userInfo.kindCd}" />  <!-- 수사단원구분 01:수사관 02:팀장 03:과장 -->	    
    
    			<div class="tab_mini_wrap m1">
    			
    			 <div class="tab_mini_contents" id="a0201ContentsArea">
					   <%-- 그리는영역 --%>
					   <table class="list" cellpadding="0" cellspacing="0">
                        <colgroup>
                            <col width="15%" />
                            <col width="35%" />
                            <col width="15%" />
                            <col width="35%" />
                        </colgroup>
                        <tbody>
                        	<%-- 
                            <tr>                                                                    
                                <th class="C">변경내용</th>
                                <td class="L" colspan="3">
                               		<c:forEach items="${mfKndList}" var="mf" varStatus="status">
                               			<!-- 법률정보는 표시하지 않음 -->
                               			<c:if test="${mf.code != '03'}">
                               				<input type="checkbox" data-type="checkbox" title="변경내용" id="mfCd_${status.index}" name="mfCd" value="${mf.code}" />&nbsp;<label for="mfCd_${status.index}">${mf.codeName}</label>&nbsp;&nbsp;
                               			</c:if>
									</c:forEach>
                                </td>
                            </tr>
                            --%>
                            <tr>                                                                    
                                <th class="C">상세내용</th>
                                <td class="L" colspan="3">
                                	<textarea id="mfCont" name="mfCont" data-type="required" title="상세내용" cols="" rows=""></textarea>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="btnArea">
				        <div class="r_btn"><a href="#" class="btn_white" id="cnfmBtn"><span>확 인</span></a><a href="#" class="btn_blue" id="closBtn"><span>닫 기</span></a></div>
				    </div>    
				   </div>
				</div>
			<!-- contents //-->
			</form>
   
    <!-- //pop content-->
    <a href="#"><img class="btn_close" src="${pageContext.request.contextPath}/sjpb/images/popup_close.png" alt="닫기" /></a>
</body>
</html>
