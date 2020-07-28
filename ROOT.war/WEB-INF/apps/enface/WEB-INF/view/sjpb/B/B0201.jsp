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
		
        <script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/B/B0201.js?r=<%=Math.random()%>"></script>
		<style>
			.searchArea ul li {width: 50% !important;}	
			.ocrt_wrap {padding: 10px !important;}
		</style>
	</head>
	<!-- size:748*670 -->
	<body class="popup">
			<c:choose>
				<c:when test="${param.updateType eq '2'}">
					<h2><span>중지사유입력</span></h2>
				</c:when>
				<c:otherwise>
					<h2><span>수정내용입력</span></h2>
				</c:otherwise>
			</c:choose>
		
			<!-- contents -->
			<form name="contentsFormData" id="contentsFormData">
			<input type="hidden" id="userId" name="userId" value="<c:out value="${userInfo.userId}" escapeXml="false" />" />   <!-- 사용자계정 -->
			<input type="hidden" id="userName" name="userName" value="<c:out value="${userInfo.userName}" escapeXml="false" />" />  <!-- 사용자이름 -->
			<input type="hidden" id="orgCd" name="orgCd" value="<c:out value="${userInfo.orgCd}" escapeXml="false" />" />   <!-- 수사팀코드 -->
			<input type="hidden" id="kindCd" name="kindCd" value="<c:out value="${userInfo.kindCd}" escapeXml="false" />" />  <!-- 수사단원구분 01:수사관 02:팀장 03:과장 -->	    
    		<input type="hidden" id="updateType" name="updateType" value="<c:out value="${userInfo.updateType}" escapeXml="false" />" />  <!-- updateType -->	
    			<div class="tab_mini_wrap m1">
    			
    			 <div class="tab_mini_contents" id="b0201ContentsArea">
					   <%-- 그리는영역 --%>
					   <table class="list" cellpadding="0" cellspacing="0">
                        <colgroup>
                            <col width="15%" />
                            <col width="35%" />
                            <col width="15%" />
                            <col width="35%" />
                        </colgroup>
                        <tbody>
                        
                        	<c:choose>
								<c:when test="${param.updateType eq '2'}">
									<tr>  
										<!-- 수현12224  -->
		                                <th class="C">구분</th>
		                                <td class="L" colspan="3">
		                                	<div class="inputbox w50per">
						   						<p class="txt"></p>
			                                	<select id="suspendSc" data-type="select" name="suspendSc" data-type="required" title="구분" >
											   		<option value="">선택</option>
											   		<c:forEach items="${suspendIncList}" var="suspend">
														<option data-task-num="${suspend.taskNum}" data-cri-stat-cd="${suspend.criStatCd }" data-trst-stat-num="${suspend.trstStatNum}" data-trst-stat-nm="${suspend.trstStatNm}" data-wf-num="${suspend.wfNum}">${suspend.trstStatNm}</option>
													</c:forEach>
											   </select>
											</div>
		                                </td>
		                            </tr>
									<tr>                                                                    
		                                <th class="C">상세내용</th>
		                                <td class="L" colspan="3">
		                                	<textarea id="mfCont" name="mfCont" data-type="required" title="상세내용" cols="" rows=""></textarea>
		                                </td>
		                            </tr>
								</c:when>
								<c:otherwise>
									<tr>                                                                    
		                                <th class="C">변경내용</th>
		                                <td class="L" colspan="3">
		                               		<c:forEach items="${mfKndList}" var="mf" varStatus="status">
		                               			<input type="checkbox" data-type="checkbox" title="변경내용" id="mfCd_${status.index}" name="mfCd" value="${mf.code}" />&nbsp;<label for="mfCd_${status.index}">${mf.codeName}</label>&nbsp;&nbsp;
											</c:forEach>
		                                </td>
		                            </tr>
		                            <tr>                                                                    
		                                <th class="C">상세내용</th>
		                                <td class="L" colspan="3">
		                                	<textarea id="mfCont" name="mfCont" data-type="required" title="상세내용" cols="" rows=""></textarea>
		                                </td>
		                            </tr>
								</c:otherwise>
							</c:choose>
                        
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
