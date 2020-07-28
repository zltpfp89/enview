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
		<title>디지털포렌식지원업무현황</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
		
        <script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/H/H0101.js?r=<%=Math.random()%>"></script>
        
	</head>
	<body class="iframe">
	
		<!-- report -->
		<form name="reportForm" method="post">
			<input type="hidden" id="reptNm" name="reptNm" value="" />
			<input type="hidden" id="xmlData" name="xmlData" value="" />
		</form>
	
		<form name="contentsFormData" id="contentsFormData">
			<input type="hidden" id="userId" name="userId" value="${userInfo.userId}" />   <!-- 사용자계정 -->
			<input type="hidden" id="userName" name="userName" value="${userInfo.userName}" />  <!-- 사용자이름 -->
			<input type="hidden" id="orgCd" name="orgCd" value="${userInfo.orgCd}" />   <!-- 수사팀코드 -->
			<input type="hidden" id="kindCd" name="kindCd" value="${userInfo.kindCd}" />  <!-- 수사단원구분 01:수사관 02:팀장 03:과장 -->	
		</form>	
		
		<!-- searchArea -->
	   <div class="searchArea">
		   <ul>
		   	   <li><span class="title">발행년도</span>	
            	<div class="inputbox w65per">
            		<p class="txt"></p>		
 					<select id="forsSuppPublYrSc" name="forsSuppPublYrSc"> 
 						<option value="">선택해주세요</option>
 						<c:forEach items="${yearList }" var="item">
 							<c:if test="${year eq item}">
 								<option value="${item}" selected="selected">${item}</option>
 							</c:if>
 							<c:if test="${year != item}">
 								<option value="${item}">${item}</option>
 							</c:if>
 						</c:forEach>
					</select>
 				</div> 
               </li>
			   <li><span class="title">사건번호</span>
				   <label for="incNumSc"></label><input type="text" class="w65per" id="incNumSc" name="incNumSc" />
			   </li>
			   <li><span class="title">수사팀</span>
				   <label for="criTmSc"></label><input type="text" class="w65per" id="criTmSc" name="criTmSc" />
			   </li>
			   <li><span class="title">수집일시</span>
				   <label for="sDateSc"></label><input type="text" class="w30per calendar datepicker" id="sDateSc" name="sDateSc" /> ~ <label for="eDateSc"></label><input type="text" class="w30per calendar datepicker" id="eDateSc" name="eDateSc" />
			   </li>
		   </ul>
		<div class="searchbtn"><a href="javascript:initSearchData();" class="btn_white reset"><span>초기화</span></a><a href="javascript:doSearch();" class="btn_light_blue search_01"><span>검색</span></a></div>
	   </div>
	   <!-- searchArea //-->
	   <!-- listArea -->
	   <div id="sheet" class="listArea area-mousewheel" style="height: 300px; width: 100%">
		
	   </div>
	   
	   <!-- btnArea -->
	   <div class="btnArea">
		   <div class="r_btn"><a href="javascript:void(0);" id="prnBtn" class="btn_white print"><span>출력</span></a><a href="javascript:insertSuppWorkView();" id="insertSuppWorkViewBtn" class="btn_light_blue new2"><span>신규</span></a><a href="javascript:deleteSuppWork();" id="deleteSuppWorkBtn" class="btn_light_blue_line appointed"><span>삭제</span></a></div>
	   </div>
	   <!-- btnArea //-->
	   <!-- btnArea -->
		<div class="btnArea">
			<div class="r_btn">
				<a href="javascript:void(0);" id="exceldown" class="btn_light_green_line excel"><span>엑셀</span></a>
			</div>
		</div>
		<!-- //btnArea -->
	   
        <div class="tab_mini_wrap m1" id="contentsArea">
        	<input type="hidden" id="forsSuppSiNum" name="forsSuppSiNum" value="" />
        	<ul>
	        	<li class="m1"><a href="javascript:void(0);" class="tabtitle" data-always="y"><span>지원정보</span></a>
					   <!-- tab_contents -->
					   <div class="tab_mini_contents" id="tab_mini_m1_contents">
						   <%-- 그리는영역 --%>
					   </div>
					   <!-- tab_contents //-->
				   </li>
			</ul>
        
            <%--
       		
       		<h4>수집 및 분석</h4>
            <table class="list" cellpadding="0" cellspacing="0">
                <caption>요청정보</caption>
                <colgroup>
                    <col width="15%" />
                    <col width="35%" />
                    <col width="15%" />
                    <col width="35%" />
                </colgroup>
             <tbody>
             	 <tr>
                	<th class="C th_line ">문서번호</th>
                	<td class="L td_line "><label for="txt_07"></label><input type="text" class="w80per" id="txt_07" name="docuNum"/></td>
                     
                	<th class="C th_line ">분석관</th>
                	<td class="L td_line "><label for="txt_08"></label><input type="text" class="w80per" id="txt_08" name="anasOffi"/></td>
                </tr>
                
                <tr>
                	<th class="C th_line ">수집일시</th>
                	<td class="L td_line "><label for="txt_09"></label><input type="text" class="w80per calendar datepicker" data-type="date" data-optional-value="true" title="수집일시" id="txt_09" name="collDt"/></td>
                     
                	<th class="C th_line ">분석일시</th>
                	<td class="L td_line "><label for="txt_10"></label><input type="text" class="w80per calendar datepicker" data-type="date" data-optional-value="true" title="분석일시" id="txt_10" name="anasDt"/></td>
                </tr>
                
                <tr>
                	<th class="C th_line ">매체구분</th>
                	<td class="L td_line "><label for="txt_11"></label><input type="text" class="w80per" id="txt_11" name="mediDiv"/></td>
                     
                	<th class="C th_line ">매체종류</th>
                	<td class="L td_line "><label for="txt_12"></label><input type="text" class="w80per" id="txt_12" name="mediType"/></td>
                </tr>
                
                <tr>
                	<th class="C th_line ">전화번호</th>
                	<td class="L td_line "><label for="txt_13"></label><input type="text" class="w80per" id="txt_13" name="phonNum"/></td>
                     
                	<th class="C th_line ">모델정보</th>
                	<td class="L td_line "><label for="txt_14"></label><input type="text" class="w80per" id="txt_14" name="modlInfo"/></td>
                </tr>
             </tbody>
       		</table>
       		
       		<h4>참관실</h4>
            <table class="list" cellpadding="0" cellspacing="0">
                <caption>참관정보</caption>
                <colgroup>
                    <col width="15%" />
                    <col width="35%" />
                    <col width="15%" />
                    <col width="35%" />
                </colgroup>
             <tbody>
             	 <tr>
                	<th class="C th_line ">참관여부</th>
                	<td class="L td_line ">
                		<input name="obsrYn" id="submit_5" type="radio" class="radio_pd radio_first" value="y" title="예" /><label for="submit_5">예</label>
						<input name="obsrYn" id="submit_6" type="radio" class="radio_pd" value="n" title="아니오" /><label for="submit_6">아니오</label>
                	</td>
                     
                	<th class="C th_line ">참관일</th>
                	<td class="L td_line "><label for="txt_15"></label><input type="text" class="w80per calendar datepicker" data-type="date" data-optional-value="true" title="참관일" id="txt_15" name="obsrDt"/></td>
                </tr>
                
                <tr>
                	<th class="C th_line ">참관인</th>
                	<td class="L td_line "><label for="txt_16"></label><input type="text" class="w80per" id="txt_16" name="obsrPern"/></td>
                     
                	<th class="C th_line ">비고</th>
                	<td class="L td_line "><label for="txt_17"></label><input type="text" class="w80per" id="txt_17" name="obsrRmComn"/></td>
                </tr>
                
             </tbody>
       		</table>
       		
       		<h4>디지털송치</h4>
            <table class="list" cellpadding="0" cellspacing="0">
                <caption>디지털송치</caption>
                <colgroup>
                    <col width="15%" />
                    <col width="35%" />
                    <col width="15%" />
                    <col width="35%" />
                </colgroup>
             <tbody>
             	 <tr>
                	<th class="C th_line ">송치일시</th>
                	<td class="L td_line "><label for="txt_18"></label><input type="text" class="w80per calendar datepicker" data-type="date" data-optional-value="true" title="송치일시" id="txt_18" name="digtTrfDt"/></td>
                     
                	<th class="C th_line ">순번</th>
                	<td class="L td_line "><label for="txt_19"></label><input type="text" class="w80per" id="txt_19" name="digtTrfSiNum"/></td>
                </tr>
                
                <tr>
                	<th class="C th_line ">관리번호</th>
                	<td class="L td_line " colspan="3"><label for="txt_20"></label><input type="text" class="w40per" id="txt_20" name="digtTrfMngNum"/></td>
                </tr>
                
             </tbody>
       		</table>
       		
            <table class="list" cellpadding="0" cellspacing="0">
                <caption>디지털송치</caption>
                <colgroup>
                    <col width="15%" />
                    <col width="35%" />
                    <col width="15%" />
                    <col width="35%" />
                </colgroup>
             <tbody>
                <tr>
                	<th class="C th_line ">비고</th>
                	<td class="L td_line " colspan="3">
                		<textarea id="suppWorkComn" name="suppWorkComn" cols="" rows=""></textarea>
                	</td>
                </tr>
                
             </tbody>
       		</table>
       		 --%>
       	</div>
		
	</body>
</html>
