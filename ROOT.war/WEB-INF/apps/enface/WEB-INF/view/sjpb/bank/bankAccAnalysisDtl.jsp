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
		<title>은행 계좌상세정보</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
		<link rel="stylesheet" type="text/css" href="${cPath}/sjpb/css/sjpb_custom.css" />
		<link rel="stylesheet" type="text/css" href="${cPath}/javascript/jstree/themes/default/style.min.css" />
		<script type="text/javascript" src="${cPath}/sjpb/js/Z/jquery.base64.js"></script>
        <script type="text/javascript" src="${cPath}/fss/js/account/bank/bankAccAnalysisDtl.js?r=<%=Math.random()%>"></script>
        <script type="text/javascript" src="${cPath}/javascript/jstree/jstree.min.js" ></script>
	</head>
	<body class="iframe">
	   	<!-- searchArea -->
 		<div class="searchArea" id="searchArea">
		   	<ul>
	   	  		<li><span class="title">사건번호</span>
				   	<div class="inputbox w65per">
					   	<p class="txt"></p>
					   	<select id="srchCaseNo" name="srchCaseNo">
					   		<c:forEach items="${caseList}" var="cse">
					   			<option value="${cse.rcptNum}">${cse.rcptIncNum}</option>
					   		</c:forEach>
					   	</select>
				   	</div>
			   	</li>
			   	<li><span class="title">기간</span>
				    <label for="srchStartDate"></label><input type="text" class="w30per calendar datepicker" id="srchStartDate" name="srchStartDate" value="${today}" data-type="date" data-optional-value=true title="시작일" readonly="readonly" />
				     ~ <label for="srchEndDate"></label><input type="text" class="w30per calendar datepicker" id="srchEndDate" name="srchEndDate" value="${today}" data-type="date" data-optional-value=true title="종료일" readonly="readonly" />
			    </li>
			   	<li><span class="title">계좌번호</span>
				   	<input type="text" id="srchAccNo" name="srchAccNo" value="" />
			   	</li>
		   	</ul>
			<div class="searchbtn">
				<a href="javascript:search();" class="btn_blue"><span>검색</span></a>
			</div>
	   	</div>
	   	<!-- searchArea //-->
	   	
	   	<!-- 계좌상세정보 테이블 -->
		<%-- <table class="list" cellpadding="0" cellspacing="0">													
			<caption>게시판쓰기</caption>                                                                                
			<colgroup>                                                                                              
				<col width="10%" />                                                                                 
				<col width="*%" />                                                                                  
				<col width="10%" />                                                                                 
				<col width="*%" />                                                                                  
				<col width="10%" />                                                                                 
				<col width="*%" />                                                                                  
				<col width="10%" />                                                                                 
				<col width="*%" />                                                                                  
			</colgroup>                                                                                             
			<tbody>                                                                                                 
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">기준일자</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">계좌개설일</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">회사전화번호</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">이관계좌지점</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">증권사</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">계좌상태</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">신용게좌구분</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">원장통보지구분</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">지점</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">폐쇄일</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">신용개설일</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">잔고통보지구분</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">계좌번호</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">폐쇄부활일</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">신용해지일</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">내외국인구분</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">위탁자</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">최종거래일</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">은행코드/명</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">여권번호</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">우편번호</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">실명확인구분</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">은행계좌번호</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">거래과세구분</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">주민등록번호</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">실명확인일</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">은행에수금</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">배당과세구분</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">주소</span></th>             
					<td class="L td_line" colspan="3"><span class="table_title">범죄장소</span></td>                                                                          
					
					<th class="C first th_line" scope="col" ><span class="table_title">전입일</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">출금출고정지구분</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">투자자구분</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">총에수금</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">전입계좌번호</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">선물연계계좌번호</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">외국인고유번호</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">집전화번호</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">전입계좌지점</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">증거금징수여부</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">외국인투자구분</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">핸드폰번호</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">이관잃</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">카드발급구분</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">직장명</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">이메일주소</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">이관계좌번호</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">카드발급횟수</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">직장주소</span></th>             
					<td class="L td_line" colspan="3"><span class="table_title">범죄장소</span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">실제계좌번호</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">계좌관리자(번호)</span></th>             
					<td class="L td_line"><span class="table_title">범죄장소</span></td>                                                                                                                  
				</tr>  
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">가상계좌은행명</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">가상계좌번호</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title"></span></th>             
					<td class="L td_line"><span class="table_title"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title"></span></th>             
					<td class="L td_line"><span class="table_title"></span></td>                                                                                                                  
				</tr>                                                                                                                       
			</tbody>                                                                                                                      
		</table> --%>                                                                                                                          
	   	<!-- 계좌상세정보 테이블// -->
	   	
	   	<!-- listArea -->
	   	<div id="sheetBankAccDtl" class="listArea area-mousewheel" style="height: 800px; width: 100%">
	   	</div>
	   	<!-- listArea //-->
	   	<!-- btnArea -->
	   	<div class="btnArea">
	   		<div class="r_btn">
		   		<a href="javascript:void(0);" id="exceldownIncPrnBtn" class="btn_white excel"><span>엑셀다운로드</span></a>
	   		</div>
	   	</div>
	   	<!-- btnArea //-->
	</body>
</html>
