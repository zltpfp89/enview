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
        <script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/X/X0102.js?r=<%=Math.random()%>"></script>	
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
													<c:forEach var="i" begin="2008" end="2017">
													    <option value="${i}">${i}</option> 
													</c:forEach>
                                               </select>
                                           </div>
                                       </li>
                                      <li><span class="title">사건번호</span>
                                           <label for="incNumSC"></label><input type="text" class="w65per" id="incNumSC" name="incNumSC" />
                                       </li>
                                       <li><span class="title">사건일련번호</span>
                                           <label for="incSiNumSC"></label><input type="text" class="w65per" id="incSiNumSC" name="incSiNumSC" />
                                       </li>
                                                                 
                                   </ul>
								<div class="searchbtn">									
									<a href="#" class="btn_blue" id="srchBtn"><span>검색</span></a>
								</div>
                               </div>
                               <!-- searchArea //-->
                               <!-- listArea -->
                               <div id="sheet" class="listArea" style="height: 200px; width: 100%">
                               </div>
                               <!-- listArea //-->
                               
                               
                               
                               
		                     
				                <div class="list">
								<table class="list" cellpadding="0" cellspacing="0">
									<caption>상세보기</caption>
									<colgroup>
										<col width="15%" />
										<col width="34%" />
										<col width="15%" />
										<col width="36%" />
									</colgroup>								
									<tr>
										<th class="C th_line">사건일련번호</th>
										<td class="L td_line" id="incSiNum"></td>
										<th class="C th_line">기준년도</th>
										<td class="L td_line" id="baseYear"></td>
									</tr>
									<tr>
										<th class="C th_line">접수번호</th>
										<td class="L td_line" id="rcptNum"></td>
										<th class="C th_line">사건번호</th>
										<td class="L td_line" id="incNum"></td>
									</tr>
									<tr>
										<th class="C th_line">사건분야</th>
										<td class="L td_line" id="incFd"></td>									
										<th class="C th_line">사건피의자번호</th>
										<td class="L td_line" id="incSpNum"></td>
									</tr>	
									<tr>		
										<th class="C th_line">고발기관</th>
										<td class="L td_line" id="chaItt"></td>
										<th class="C th_line">수사팀</th>
										<td class="L td_line" id="criTm"></td>										
									</tr>
									<tr>	
										<th class="C th_line">수사담당자</th>
										<td class="L td_line" id="criRespMb"></td>
										<th class="C th_line">피의자</th>
										<td class="L td_line" id="spNm"></td>										
									</tr>
									<tr>
										<th class="C th_line">피의자수</th>
										<td class="L td_line" id="spCnt"></td>
										<th class="C th_line">주민번호</th>
										<td class="L td_line" id="spSsn"></td>										
									</tr>
									<tr>
										<th class="C th_line">업소명</th>
										<td class="L td_line" id="spBsnsNm"></td>
										<th class="C th_line">범죄일시</th>
										<td class="L td_line" id="criDt"></td>										
									</tr>
									<tr>
										<th class="C th_line">주소</th>
										<td class="L td_line" id="spAddr" colspan="3">											
										</td>
									</tr>																
									<tr>
										<th class="C th_line">관련법률및죄명</th>
										<td class="L td_line" id="rltActCriNm"></td>
										<th class="C th_line">위반내용</th>
										<td class="L td_line" id="vioCont"></td>										
									</tr>									
									<tr>
										<th class="C th_line">위반조항</th>
										<td class="L td_line" id="vioCla" colspan="3"></td>
									</tr>							
									<tr>
										<th class="C th_line">범죄장소</th>
										<td class="L td_line" id="criPla"></td>
										<th class="C th_line">발각원인</th>
										<td class="L td_line" id="dvCau"></td>
									</tr>
									<tr>
										<th class="C th_line">수리일자</th>
										<td class="L td_line" id="beDt"></td>
										<th class="C th_line">수사지휘일자</th>
										<td class="L td_line" id="criCmdProDt"></td>
									</tr>
									<tr>
										<th class="C th_line">지휘기관</th>
										<td class="L td_line" id="cmdItt"></td>
										<th class="C th_line">송치의견</th>
										<td class="L td_line" id="trfOp"></td>
									</tr>
									<tr>
										<th class="C th_line">송치일시</th>
										<td class="L td_line" id="trfDt"></td>
										<th class="C th_line">송치기관</th>
										<td class="L td_line" id="trfItt"></td>
									</tr>
									<tr>
										<th class="C th_line">송치결과</th>
										<td class="L td_line" id="trfRst"></td>
										<th class="C th_line">구공판일시</th>
										<td class="L td_line" id="trilDt"></td>												
									</tr>
									<tr>
										<th class="C th_line">검찰처분일시</th>
										<td class="L td_line" id="poDipDt"></td>
										<th class="C th_line">검찰처분결과</th>
										<td class="L td_line" id="poDipRst"></td>
									</tr>
									<tr>
										<th class="C th_line">처분내용</th>
										<td class="L td_line" id="dipCont"></td>
										<th class="C th_line">벌금액</th>
										<td class="L td_line" id="fnAmt"></td>
									</tr>
									<tr>
										<th class="C th_line">형제번호</th>
										<td class="L td_line" id="crlwNum"></td>
										<th class="C th_line">법원번호</th>
										<td class="L td_line" id="cortNum"></td>
									</tr>
									<tr>
										<th class="C th_line">확정일자</th>
										<td class="L td_line" id="fiDt"></td>
										<th class="C th_line">판결내용</th>
										<td class="L td_line" id="jdtCont"></td>
									</tr>
								</table>
							</div>
		                                
		                                
                        </div>
                   </div>
			</div>
	
			<!-- contents //-->
		</div> 
		<!-- wrap //-->

		
	</body>
	

</html>
