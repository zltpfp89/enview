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
<title>통신제한조치집행사실통지유예승인신청부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0120.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" id="searchArea" data-view-type="mng">
		<form name="searchList" id="searchList" method="post">
			<ul>
			<%-- TODO 페이지별 수정 --%>
				<li><span class="title">연번</span>
					<label for="notcBkSiNumSc"></label><input type="text" class="w65per" id="notcBkSiNumSc" name="notcBkSiNumSc" />
				</li>
				<li><span class="title">허가서번호</span>
					<label for="apprDocNumSc"></label><input type="text" class="w65per" id="apprDocNumSc" name="apprDocNumSc" />
				</li>
				<li><span class="title">통지대상자</span>
					<label for="spNmSc"></label><input type="text" class="w65per" id="spNmSc" name="spNmSc" />
				</li>
				<li><span class="title">집행자성명</span>
					<label for="execMbNmSc"></label><input type="text" class="w65per" id="execMbNmSc" name="execMbNmSc" />
				</li>
				<li><span class="title">사건번호</span>
					<label for="rcptIncNumSc"></label><input type="text" class="w65per" id="rcptIncNumSc" name="rcptIncNumSc" />
				</li>
				<li><span class="title">처리일자</span>
					<label for="sHandDtSc"></label><input type="text" class="w30per calendar datepicker" id=sHandDtSc name="sHandDtSc" data-type="date" data-optional-value=true title="처리일자시작일"/> ~ <label for="eHandDtSc"></label><input type="text" class="w30per calendar datepicker" id="eHandDtSc" name="eHandDtSc" data-type="date" data-optional-value=true title="처리일자종료일"/>
				</li>
				<li><span class="title">통지일자</span>
					<label for="sNotcDtSc"></label><input type="text" class="w30per calendar datepicker" id=sNotcDtSc name="sNotcDtSc" data-type="date" data-optional-value=true title="통지일자시작일"/> ~ <label for="eNotcDtSc"></label><input type="text" class="w30per calendar datepicker" id="eNotcDtSc" name="eNotcDtSc" data-type="date" data-optional-value=true title="통지일자종료일"/>
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
			<!-- 통신제한조치집행사실통지유예승인신청부 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>통신제한조치집행사실통지부 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents">
					<div class="list" id="contentsArea">
			        	<input type="hidden" id="cmctRstrExecFactNum" name="cmctRstrExecFactNum" value="" />
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
				                	<th class="C th_line ">연번</th>
				                	<td class="L td_line " colspan="3"><input type="text" class="w100per" id="notcBkSiNum" name="notcBkSiNum" maxlength="10"/></td>
				                </tr>
				                
				                <tr>
				                	<th class="C th_line ">허가서번호</th>
				                	<td class="L td_line "><label for="apprDocNum"></label><input type="text" class="w100per" id="apprDocNum" name="apprDocNum" maxlength="10"/></td>
				                     
				                	<th class="C th_line ">통지대상자</th>
				                	<td class="L td_line ">
				                		<p class="searchinput">
				                			<label for="spNm"></label><input type="text" class="w100per" id="spNm" name="spNm" disabled="disabled" data-always="y"/><a name="spBtn" class="btn_search" id="spBtn" href="javascript:void(0);"><img alt="search" src="/sjpb/images/btn_search.png"></a>	
				                		</p>
				                	</td>
				                </tr>
				                
				                <tr>
				                	<th class="C th_line ">집행자관직</th>
				                	<td class="L td_line "><label for="execMbTitl"></label><input type="text" class="w100per" id="execMbTitl" name="execMbTitl" maxlength="30"/></td>
				                     
				                	<th class="C th_line ">집행자성명</th>
				                	<td class="L td_line "><label for="execMbNm"></label><input type="text" class="w100per" id="execMbNm" name="execMbNm" maxlength="30"/></td>
				                </tr>
				                
				                <tr>
				                	<th class="C th_line ">사건번호</th>
				                	<td class="L td_line "><span id="rcptIncNum" name="rcptIncNum"></span></td>
				                     
				                	<th class="C th_line ">처리일자</th>
				                	<td class="L td_line "><label for="handDt"></label><input type="text" class="w100per calendar datepicker" title="처리일자" id="handDt" name="handDt" data-type="date" data-optional-value=true maxlength="10" readonly/></td>
				                </tr>
				                
				                <tr>
				                	<th class="C th_line ">처리결과</th>
				                	<td class="L td_line "><label for="handRst"></label><input type="text" class="w100per" id="handRst" name="handRst" maxlength="30"/></td>
				                     
				                	<th class="C th_line ">처리결과를 통보받은일자</th>
				                	<td class="L td_line "><label for="handRstNotcDt"></label><input type="text" class="w100per calendar datepicker" title="처리결과를 통보받은일자" id="handRstNotcDt" name="handRstNotcDt" data-type="date" data-optional-value=true maxlength="10" readonly/></td>
				                </tr>
				                
				                <tr>
				                	<th class="C th_line ">통지일자</th>
				                	<td class="L td_line "><label for="notcDt"></label><input type="text" class="w100per calendar datepicker" title="통지일자" id="notcDt" name="notcDt" data-type="date" data-optional-value=true maxlength="10" readonly/></td>
				                     
				                    <th class="C th_line ">비고</th>
				                	<td class="L td_line "><label for="notcBkComn"></label><input type="text" class="w100per" id="notcBkComn" name="notcBkComn" maxlength="30"/></td>
				                </tr>
				             </tbody>
			       		</table>
       				</div>
			        <div class="btnArea">
			        	<div class="r_btn" id="btnAreaDiv">
			        		<%-- 그리는 영역 --%>
			            	<a href="javascript:insertData();" class="btn_light_blue save" data-view-type="inc"><span>저장</span></a>
			            </div>
			        </div>
		        </div>
			</li>
		</ul>
	</div>
	<!-- contents E -->
</body>
</html>