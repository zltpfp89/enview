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
<title>긴급통신제한조치통보서발송부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0119.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" id="searchArea" data-view-type="mng">
		<form name="searchList" id="searchList" method="post">
			<ul>
			<%-- TODO 페이지별 수정 --%>
				<li><span class="title">연번</span>
					<label for="emgyCmctSiNumSc"></label><input type="text" class="w65per" id="emgyCmctSiNumSc" name="emgyCmctSiNumSc" />
				</li>
				<li><span class="title">사건번호</span>
					<label for="rcptIncNumSc"></label><input type="text" class="w65per" id="rcptIncNumSc" name="rcptIncNumSc" />
				</li>
				<li><span class="title">대상자</span>
					<label for="spNmSc"></label><input type="text" class="w65per" id="spNmSc" name="spNmSc" />
				</li>
				<%--
				<li><span class="title">기간</span>
					<label for="sRstrActnTrgtPiSc"></label><input type="text" class="w30per calendar datepicker" id=sRstrActnTrgtPiSc name="sRstrActnTrgtPiSc" data-type="date" data-optional-value=true title="기간시작일"/> ~ <label for="eRstrActnTrgtPiSc"></label><input type="text" class="w30per calendar datepicker" id="eRstrActnTrgtPiSc" name="eRstrActnTrgtPiSc" data-type="date" data-optional-value=true title="기간종료일"/>
				</li>
				 --%>
				<li><span class="title">통보서작성자성명</span>
					<label for="notcFillPersNmSc"></label><input type="text" class="w65per" id="notcFillPersNmSc" name="notcFillPersNmSc" />
				</li>
				<li><span class="title">통보서송부일자</span>
					<label for="sNotcSendDtSc"></label><input type="text" class="w30per calendar datepicker" id=sNotcSendDtSc name="sNotcSendDtSc" data-type="date" data-optional-value=true title="통보서송부일자시작일"/> ~ <label for="eNotcSendDtSc"></label><input type="text" class="w30per calendar datepicker" id="eNotcSendDtSc" name="eNotcSendDtSc" data-type="date" data-optional-value=true title="통보서송부일자종료일"/>
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
			<!-- 긴급통신제한조치통보서발송부 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>긴급통신제한조치통보서발송부 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents">
					<div class="list" id="contentsArea">
			        	<input type="hidden" id="emgyCmctNotcSendNum" name="emgyCmctNotcSendNum" value="" />
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
				                	<td class="L td_line "><input type="text" class="w100per" id="emgyCmctSiNum" name="emgyCmctSiNum" maxlength="10"/></td>
				                	
				                	<th class="C th_line ">대상자</th>
				                	<td class="L td_line ">
				                		<p class="searchinput">
				                			<label for="spNm"></label><input type="text" class="w100per" id="spNm" name="spNm" disabled="disabled" data-always="y"/><a name="spBtn" class="btn_search" id="spBtn" href="javascript:void(0);"><img alt="search" src="/sjpb/images/btn_search.png"></a>	
				                		</p>
				                	</td>
				                	
				                </tr>
				                
				                <tr>
				                	<th class="C th_line ">제한조치 시작일자</th>
				                	<td class="L td_line "><label for="rstrActnTrgtPiBeDt"></label><input type="text" class="w100per calendar datepicker" title="제한조치시작일자" id="rstrActnTrgtPiBeDt" name="rstrActnTrgtPiBeDt" data-type="date" data-optional-value=true maxlength="10" readonly/></td>
				                	
				                	<th class="C th_line ">제한조치 종료일자</th>
				                	<td class="L td_line "><label for="rstrActnTrgtPiEdDt"></label><input type="text" class="w100per calendar datepicker" title="제한조치종료일자" id="rstrActnTrgtPiEdDt" name="rstrActnTrgtPiEdDt" data-type="date" data-optional-value=true maxlength="10" readonly/></td>
				                </tr>
				                
				                <tr>
				                	<th class="C th_line ">작성자 직급</th>
				                	<td class="L td_line "><label for="notcFillPersPosi"></label><input type="text" class="w100per" id="notcFillPersPosi" name="notcFillPersPosi" maxlength="30"/></td>
				                     
				                	<th class="C th_line ">작성자 성명</th>
				                	<td class="L td_line "><label for="notcFillPersNm"></label><input type="text" class="w100per" id="notcFillPersNm" name="notcFillPersNm" maxlength="30"/></td>
				                </tr>
				                
				                <tr>
				                	<th class="C th_line ">통보서 송부일자</th>
				                	<td class="L td_line " colspan="3"><label for="notcSendDt"></label><input type="text" class="w100per calendar datepicker" title="통보서 송부일자" id="notcSendDt" name="notcSendDt" data-type="date" data-optional-value=true maxlength="10" readonly/></td>
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