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
		<title>데이터이관</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />		
        <script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/X/X0101.js?r=<%=Math.random()%>"></script>	
	</head>
	<body>
		<!-- wrap -->
		<div class="wrap">
				
			<div class="contents">
                   <div id="sub_tab">
                       <div class="ocrt_wrap clearfix">                           
                           <div class="ocrt_01 ocrt_list_tab0 list">
                               <!-- searchArea -->
                               <div class="searchArea">
                                   <ul>
                                       <li><span class="title">기준년도</span>
                                           <div class="inputbox w65per">
                                               <p class="txt"></p>
                                               <select id="baseYearSC" name="baseYearSC">
                                                    <option value="">전체</option>
													<c:forEach var="i" begin="2000" end="2029">
													    <option value="${i}">${i}</option> 
													</c:forEach>
                                               </select>
                                           </div>
                                       </li>
                                       <li><span class="title">단계</span>
                                           <div class="inputbox w65per">
                                               <p class="txt"></p>
                                               <select id="prgsStepSC" name="prgsStepSC">                                                    
													<c:forEach var="j" begin="0" end="2">
													    <option value="${j}">${j}</option> 
													</c:forEach>
                                               </select>
                                           </div>
                                       </li>
                                       <li><span class="title">대상</span>
                                           <div class="inputbox w65per">
                                               <p class="txt"></p>
                                               <select id="trgtDtaSC" name="trgtDtaSC">
												   <option value="I">사건</option>
												   <option value="P">피의자</option>
												   <option value="V">법률위반</option>
												   <option value="D">사건처분결과</option>
												   <option value="J">사건판결결과</option>
												   <option value="M">수사관</option>												   
                                               </select>
                                           </div>
                                       </li>                                       
                                   </ul>
								<div class="searchbtn">
									<a href="#" class="btn_white" id="initBtn"><span>초기화</span></a>
									<a href="#" class="btn_blue" id="srchBtn"><span>검색</span></a>
								</div>
                               </div>
                               <!-- searchArea //-->
                               <!-- listArea -->
                               <div id="sheet" class="listArea" style="height: 800px; width: 100%">
                               </div>
                               <!-- listArea //-->
                               <!-- btnArea -->
                               <div class="btnArea" >
                                   <div class="r_btn">
	                                   <a href="#" class="btn_white" id="addBtn"><span>신규추가</span></a>	                                   
	                                   <a href="#" class="btn_white" id="updBtn"><span>사건수정</span></a>
	                                   <a href="#" class="btn_blue" id="tmpBtn"><span>수작업</span></a>
                                   </div>
                               </div>
                        </div>
                   </div>
			</div>
	
			<!-- contents //-->
		</div> 
		<!-- wrap //-->

		
	</body>
	

</html>
