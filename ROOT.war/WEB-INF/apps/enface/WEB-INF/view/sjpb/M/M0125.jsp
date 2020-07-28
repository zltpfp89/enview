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
<title>통신사실 확인자료 회신대장</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0125.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" id="searchArea" data-view-type="mng">
		<form name="searchList" id="searchList" method="post">
			<ul>
			<%-- TODO 페이지별 수정 --%>
				<li><span class="title">연번</span>
					<label for="repyBkSiNumSc"></label><input type="text" class="w65per" id="repyBkSiNumSc" name="repyBkSiNumSc" />
				</li>		
				<li><span class="title">요청일자</span>
					<label for="sReqDtSc"></label><input type="text" class="w30per calendar datepicker" id="sReqDtSc" name="sReqDtSc" data-type="date" data-optional-value=true title="요청일자시작일"/> ~ <label for="eReqDtSc"></label><input type="text" class="w30per calendar datepicker" id="eReqDtSc" name="eReqDtSc" data-type="date" data-optional-value=true title="요청일자종료일"/>
				</li>
				<li><span class="title">요청자</span>
					<label for="regUserNmSc"></label><input type="text" class="w65per" id="regUserNmSc" name="regUserNmSc" />
				</li>
				<li><span class="title">대상자</span>
					<label for="spNmSc"></label><input type="text" class="w65per" id="spNmSc" name="spNmSc" />
				</li>
				<li><span class="title">회신일자</span>
					<label for="sRepyDtSc"></label><input type="text" class="w30per calendar datepicker" id="sRepyDtSc" name="sRepyDtSc" data-type="date" data-optional-value=true title="회신일자시작일"/> ~ <label for="eRepyDtSc"></label><input type="text" class="w30per calendar datepicker" id="eRepyDtSc" name="eRepyDtSc" data-type="date" data-optional-value=true title="회신일자종료일"/>
				</li>
				<%--
				<li><span class="title">등록자</span>
					<label for="regUserNmSc"></label><input type="text" class="w65per" id="regUserNmSc" name="regUserNmSc" />
				</li>
				 --%>
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
		<input type="hidden" id="POLICENAME" name="POLICENAME" value="${userInfo.userId}" />
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
			<!-- 통신사실 확인자료 회신대장 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>통신사실 확인자료 회신대장 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
					<div class="list">
			        	<input type="hidden" id="cmctCnfmRepyBkNum" name="cmctCnfmRepyBkNum" value="" />
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
				                	<td class="L td_line "><span id="repyBkSiNum" name="repyBkSiNum" maxlength="10"></span></td>
				                	<th class="C th_line ">요청일자</th>
				                	<td class="L td_line "><label for="reqDt"></label><input type="text" class="w100per calendar datepicker" title="요청일자" id="reqDt" name="reqDt" data-type="date" data-optional-value=true maxlength="10" readonly/></td>				                
				                </tr>
				                <tr>
				                	<th class="C th_line ">대상자</th>
				                	<td class="L td_line ">
				                		<p class="searchinput">
				                			<label for="spNm"></label><input type="text" class="w100per" id="spNm" name="spNm" disabled="disabled" data-always="y"/><a name="spBtn" class="btn_search" id="spBtn" href="javascript:void(0);"><img alt="search" src="/sjpb/images/btn_search.png"></a>	
				                		</p>
				                	</td>
				                
				                	<th class="C th_line ">회신일자</th>
				                	<td class="L td_line "><label for="repyDt"></label><input type="text" class="w100per calendar datepicker" title="회신일자" id="repyDt" name="repyDt" data-type="date" data-optional-value=true maxlength="10" readonly/></td>
				                </tr>
				                
				                 <tr>
				                	<th class="C th_line ">제공받은자료의범위</th>
				                	<td class="L td_line">
				                        <textarea id="dtaRnge" name="dtaRnge" cols="" rows="" maxlength="30"></textarea>
				                    </td>
				                     
				                	<th class="C th_line ">비고</th>
				                	<td class="L td_line">
				                        <textarea id="repyBkComn" name="repyBkComn" cols="" rows="" maxlength="30"></textarea>
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