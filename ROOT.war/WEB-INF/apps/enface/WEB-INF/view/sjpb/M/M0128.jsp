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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-style-type" content="text/css" />
<title>영상녹화물관리대장</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0128.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" id="searchArea">
		<form name="searchList" id="searchList" method="post" data-view-type="mng">
			<ul>
			<%-- TODO 페이지별 수정 --%>
				<li><span class="title">사건번호</span>
					<label for="rcptIncNumSc"></label><input type="text" class="w65per" id="rcptIncNumSc" name="rcptIncNumSc" />
				</li>		   
			    <li><span class="title">피의자</span>
					<label for="spNmSc"></label><input type="text" class="w65per" id="spNmSc" name="spNmSc" />
				</li>
				<li><span class="title">참고인</span>
					<label for="refcPersSc"></label><input type="text" class="w65per" id="refcPersSc" name="refcPersSc" />
				</li>
				<li><span class="title">인수자</span>
					<label for="acqsPersSc"></label><input type="text" class="w65per" id="acqsPersSc" name="acqsPersSc" />
				</li>
				<li><span class="title">송치일자</span>
					<label for="sTrfDtSc"></label><input type="text" class="w30per calendar datepicker" id="sTrfDtSc" name="sTrfDtSc" data-type="date" data-optional-value=true title="송치일자시작일"/> ~ <label for="eTrfDtSc"></label><input type="text" class="w30per calendar datepicker" id="eTrfDtSc" name="eTrfDtSc" data-type="date" data-optional-value=true title="송치일자종료일"/>
				</li>
				<li><span class="title">등록자</span>
					<label for="regUserNmSc"></label><input type="text" class="w65per" id="regUserNmSc" name="regUserNmSc" />
				</li>
				
			</ul>
			<div class="searchbtn">
				<a href="javascript:initSearchData();" class="btn_white reset"><span>초기화</span></a>
				<a href="javascript:selectList();" class="btn_light_blue search_01"><span>검색</span></a>
			</div>
		</form>
   </div>
   <!-- searchArea //-->
	
	<!-- listArea -->
	<div id="listSheet" class="listArea mrt15 area-mousewheel" style="height: 400px; width: 100%"></div>
	<!-- listArea// -->
	
	<!-- report -->
	<form name="reportForm" method="post">
		<input type="hidden" id="reptNm" name="reptNm" value="" />
		<input type="hidden" id="xmlData" name="xmlData" value="" />
	</form>
	<!-- //report -->
	
	<form name="contentsFormData" id="contentsFormData">
		<input type="hidden" id="userId" name="userId" value="${userInfo.userId}" />   <!-- 사용자계정 -->
		<input type="hidden" id="userName" name="userName" value="${userInfo.userName}" />  <!-- 사용자이름 -->
		<input type="hidden" id="orgCd" name="orgCd" value="${userInfo.orgCd}" />   <!-- 수사팀코드 -->
		<input type="hidden" id="kindCd" name="kindCd" value="${userInfo.kindCd}" />  <!-- 수사단원구분 01:수사관 02:팀장 03:과장 -->	
	</form>	
	
	<!-- btnArea -->
	<div class="btnArea">
		<div class="r_btn">
			<a href="javascript:insertDataView();" class="btn_light_blue new2" id="btnNewSeiz" data-view-type="inc"><span>신규</span></a>
			<a href="javascript:void(0);" class="btn_white print" id="prnBtn" data-view-type="mng"><span>출력</span></a>
		</div>
	</div>
	
	<!-- contents S -->
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 영상녹화물 관리대장 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>영상녹화물 관리대장 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
					<div class="list">
				      	<input type="hidden" id="vislRcdgMngBkNum" name="vislRcdgMngBkNum" value="" />
				      	<input type="hidden" id="rcptNum" name="rcptNum" value="" />
				      	<input type="hidden" id="incSpNum" name="incSpNum" value="" />
			            
			            
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
				                	<th class="C th_line ">접수일자</th>
				                	<%-- <td class="L td_line "><label for="txt_01"></label><input type="text" class="w100per calendar datepicker" title="접수일자" id="txt_01" name="rcptDt"/></td> --%>
				                	<td class="L td_line "><span id="rcptDt" name="rcptDt"></span></td>
				                	<th class="C th_line ">사건번호</th>
				                	<td class="L td_line "><span id="rcptIncNum" name="rcptIncNum"></span></td>
				                </tr>
				                
				                <tr>
				                	<th class="C th_line ">죄명</th>
				                	<td class="L td_line "><span id="rltActCriNmCdDesc" name="rltActCriNmCdDesc"></span></td>
				                     
				                	<th class="C th_line ">피의자</th>
				                	<td class="L td_line ">
				                		<p class="searchinput">
				                			<label for="txt_04"></label><input type="text" class="w100per" id="txt_04" name="spNm" disabled="disabled" data-always="y"/><a name="spBtn" class="btn_search" id="spBtn" href="javascript:void(0);"><img alt="search" src="/sjpb/images/btn_search.png"></a>	
				                		</p>
				                	</td>
				                </tr>
				                
				                <tr>
				                	<th class="C th_line ">참고인</th>
				                	<td class="L td_line "><label for="txt_05"></label><input type="text" class="w100per" id="txt_05" name="refcPers" maxlength="30"/></td>
				                     
				                	<th class="C th_line ">인수자</th>
				                	<td class="L td_line "><label for="txt_06"></label><input type="text" class="w100per" id="txt_06" name="acqsPers" maxlength="30"/></td>
				                </tr>
				                
				                 <tr>
				                	<th class="C th_line ">인계자</th>
				                	<td class="L td_line "><label for="txt_07"></label><input type="text" class="w100per" id="txt_07" name="tranPers" maxlength="30"/></td>
				                     
				                	<th class="C th_line ">송치일자</th>
				                	<td class="L td_line "><label for="txt_08"></label><input type="text" class="w100per calendar datepicker" title="송치일자" id="txt_08" name="trfDt" data-type="date" data-optional-value=true maxlength="10" readonly/></td>
				                </tr>
				                
				                <tr>
				                	<th class="C th_line ">비고</th>
				                	<td class="L td_line " colspan="3">
				                		<textarea id="mngBkComn" name="mngBkComn" cols="" rows="" maxlength="300"></textarea>
				                	</td>
				                </tr>
				                
				             </tbody>
			       		</table>
					</div>
			        <div class="btnArea">
			        	<div class="r_btn" id="btnAreaDiv" data-view-type="inc">
			        		<%-- 그리는 영역 --%>
			            	<a href="javascript:insertData();" class="btn_light_blue save"><span>저장</span></a>
			            </div>
			        </div>
			    </div>
			</li>
		</ul>
	</div>
	
	<!-- contents E -->
</body>
</html>