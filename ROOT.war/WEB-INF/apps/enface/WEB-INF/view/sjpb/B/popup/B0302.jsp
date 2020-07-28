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
		<title>피의자수정 이력 비교</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/css/popup.css" />
		
		<script type="text/javascript">
			const IS_ALL_UPDATE_YN = "";
		</script>
		
		<script type="text/javascript" src="${cPath}/sjpb/js/Z/jquery.base64.js"></script>	
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/B/B0101.js?r=<%=Math.random()%>"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/B/B0302.js?r=<%=Math.random()%>"></script>
        
		<style>
			.searchArea ul li {width: 50% !important;}	
			.ocrt_wrap {padding: 10px !important;}
		</style>
	</head>
	<!-- size:748*670 -->
	<body class="popup">
			<h2><span>피의자수정 이력 비교</span></h2>
		
			<!-- contents -->
			<form name="contentsFormData" id="contentsFormData">
			<input type="hidden" id="userId" name="userId" value="${userInfo.userId}" />   <!-- 사용자계정 -->
			<input type="hidden" id="userName" name="userName" value="${userInfo.userName}" />  <!-- 사용자이름 -->
			<input type="hidden" id="orgCd" name="orgCd" value="${userInfo.orgCd}" />   <!-- 수사팀코드 -->
			<input type="hidden" id="kindCd" name="kindCd" value="${userInfo.kindCd}" />  <!-- 수사단원구분 01:수사관 02:팀장 03:과장 -->
			
			<input type="hidden" id="incMfNum" name="incMfNum" value="${incMfNum}" />	<!-- 사건수정번호 -->	    
    
    			<div class="tab_mini_wrap m1">
    			
    			 <div class="tab_mini_contents" id="b0302ContentsDiv">
    			 	
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
                                	<textarea id="mfCont" name="mfCont" data-type="required" readonly title="상세내용" cols="" rows="">${b0101VO.mfCont}</textarea>
                                </td>
                            </tr>
                        </tbody>
                    </table>    			 	
    			 	<div id="b0302ContentsArea">
    			 		<%-- 그리는영역 --%>
    			 		
    			 		
    			 		<div style="width:49%; float:left;" id="b0302ContentsAreaA">
    			 		
						</div>
						
						<div style="width:49%; float:right;" id="b0302ContentsAreaB">
						
						</div>		
    			 		<!-- 그리는 영역 끝 -->
    			 	</div>
    			 	
					<div class="btnArea" id="apprArea02" style="display: none; float: left;">
	
						<div style="height: 100px">
							<table class="list" name="apprAreaTable" cellpadding="0"
								cellspacing="0" data-cri-dta-num="" data-cri-dta-catg-cd="06">
								<colgroup>
									<col width="10%" />
									<col width="15%" />
									<col width="30%" />
									<col width="15%" />
									<col width="30%" />
								</colgroup>
								<tbody>
									<tr>
										<th class="C line_right" rowspan="2">등록</th>
										<th class="C">등록요청</th>
										<td class="L" colspan="3" id="taskNmTD"></td>
									</tr>
									<tr>
										<th class="C">등록의견</th>
										<td class="L" colspan="3"><label for="txt_05"></label><input
											type="text" class="w100per" id="taskComn" name="taskComn" />
										</td>
									</tr>
								</tbody>
							</table>
						</div>


					<div class="r_btn" id="apprArea_EditButtons" style="padding-bottom:20px;"></div>
				</div>
			</div>
				</div>
			<!-- contents //-->
			</form>
   
    <!-- //pop content-->
    <a href="#"><img class="btn_close" src="${pageContext.request.contextPath}/sjpb/images/popup_close.png" alt="닫기" /></a>
</body>
</html>
