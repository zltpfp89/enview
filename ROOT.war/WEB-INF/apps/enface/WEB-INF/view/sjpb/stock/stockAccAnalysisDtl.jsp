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
		<title>사건관리</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
		<link rel="stylesheet" type="text/css" href="${cPath}/sjpb/css/sjpb_custom.css" />
		<link rel="stylesheet" type="text/css" href="${cPath}/javascript/jstree/themes/default/style.min.css" />
		<script type="text/javascript" src="${cPath}/sjpb/js/Z/jquery.base64.js"></script>		
        <script type="text/javascript" src="${cPath}/fss/js/account/stock/stockAccAnalysisDtl.js?r=<%=Math.random()%>"></script>
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
				<col width="15%" />                                                                                 
				<col width="*%" />                                                                                  
				<col width="15%" />                                                                                 
				<col width="*%" />                                                                                  
				<col width="15%" />                                                                                 
				<col width="*%" />                                                                                  
				<col width="15%" />                                                                                 
				<col width="*%" />                                                                                  
			</colgroup>                                                                                             
			<tbody>                                                                                                 
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">기준일자</span></th>             
					<td class="L td_line"><span class="table_title" id="tranBaseDate"></span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">은행명</span></th>             
					<td class="L td_line"><span class="table_title" id="membNm"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">구은행명1</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">구은행명2</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">구은행명3</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">구은행명4</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">구은행명5</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">예금종목</span></th>             
					<td class="L td_line"><span class="table_title" id=""></span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">현관리지점</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">계좌번호</span></th>             
					<td class="L td_line"><span class="table_title" id="accNo"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">구계좌번호1</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">구계좌번호2</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">구계좌번호3</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">구계좌번호4</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">구계좌번호5</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">구계좌번호6</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">구계좌번호7</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">구계좌번호8</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">구계좌번호9</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">구계좌번호10</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">계좌주</span></th>             
					<td class="L td_line"><span class="table_title" id="trusterNm"></span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">주민등록번호</span></th>             
					<td class="L td_line"><span class="table_title" id="rgno"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">법인등록번호</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">여권번호</span></th>             
					<td class="L td_line"><span class="table_title" id="passportNo"></span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">고객구분</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">내외국인구분</span></th>             
					<td class="L td_line"><span class="table_title" id="natoforDiv"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">집전화번호</span></th>             
					<td class="L td_line"><span class="table_title" id="homeTelNo"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">휴대전화번호</span></th>             
					<td class="L td_line"><span class="table_title" id="moPhoneNo"></span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">전자우편주소</span></th>             
					<td class="L td_line"><span class="table_title" id="emailAddr"></span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">자택팩스번호</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">자택우편번호</span></th>             
					<td class="L td_line"><span class="table_title" id="postNo"></span></td>                                                                                                                  
					<th class="C first th_line" scope="col" ><span class="table_title">자택주소</span></th>             
					<td class="L td_line"><span class="table_title" id="homeAddr"></span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">직장명</span></th>             
					<td class="L td_line"><span class="table_title" id="workNm"></span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">직장전화번호</span></th>             
					<td class="L td_line"><span class="table_title" id="coTelNo"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">직장주소</span></th>             
					<td class="L td_line"><span class="table_title" id="workAddr"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">법인주소</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">대표자명</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title">대표자 주민번호</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">계좌개설일</span></th>             
					<td class="L td_line"><span class="table_title" id="accOpnDate"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title">계좌상태</span></th>             
					<td class="L td_line"><span class="table_title" id="accState"></span></td>                                                                                                                  
				</tr>                                                                                                                        
				<tr>                                                                                                
					<th class="C first th_line" scope="col" ><span class="table_title">요구문서번호</span></th>             
					<td class="L td_line"><span class="table_title"></span></td>                                                                          
					<th class="C first th_line" scope="col" ><span class="table_title"></span></th>             
					<td class="L td_line"><span class="table_title"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title"></span></th>             
					<td class="L td_line"><span class="table_title"></span></td>  
					<th class="C first th_line" scope="col" ><span class="table_title"></span></th>             
					<td class="L td_line"><span class="table_title"></span></td>                                                                                                                  
				</tr>                                                                                                                        
			</tbody>                                                                                                                      
		</table>  --%>                                                                                                                         
	   	<!-- 계좌상세정보 테이블// -->
	   	
	   	<!-- listArea -->
	   	<div id="sheetStockDealSummary" class="listArea area-mousewheel" style="height: 700px; width: 100%">
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
