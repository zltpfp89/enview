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
<title>통신사실 확인자료제공 요청집행대장</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0124.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" id="searchArea" data-view-type="mng">
		<form name="searchList" id="searchList" method="post">
			<ul>
			<%-- TODO 페이지별 수정 --%>
				<li><span class="title">집행번호</span>
					<label for="execNumSc"></label><input type="text" class="w65per" id="execNumSc" name="execNumSc" />
				</li>		   
				<li><span class="title">허가서 번호</span>
					<label for="apprDocNumSc"></label><input type="text" class="w65per" id="apprDocNumSc" name="apprDocNumSc" />
				</li>
				<li><span class="title">성명</span>
					<label for="spNmSc"></label><input type="text" class="w65per" id="spNmSc" name="spNmSc" />
				</li>
				<li><span class="title">대상번호</span>
					<label for="cmctCnfmExecTrgtSc"></label><input type="text" class="w65per" id="cmctCnfmExecTrgtSc" name="cmctCnfmExecTrgtSc" />
				</li>
				<li><span class="title">종류</span>
					<label for="cmctCnfmExecTypeSc"></label><input type="text" class="w65per" id="cmctCnfmExecTypeSc" name="cmctCnfmExecTypeSc" />
				</li>
				<li><span class="title">집행일시</span>
					<label for="sCmctCnfmExecDtSc"></label><input type="text" class="w30per calendar datepicker" id="sCmctCnfmExecDtSc" name="sCmctCnfmExecDtSc" data-type="date" data-optional-value=true title="집행일시시작일"/> ~ <label for="eCmctCnfmExecDtSc"></label><input type="text" class="w30per calendar datepicker" id="eCmctCnfmExecDtSc" name="eCmctCnfmExecDtSc" data-type="date" data-optional-value=true title="집행일시종료일"/>
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
		<input type="hidden" id="SEQNUM" name="SEQNUM" value="" />
		<input type="hidden" id="POLICENAME" name="POLICENAME" value="${userId}" />
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
			<a href="javascript:void(0);" class="btn_white print" id="prnBtn"><span>대장 출력</span></a>
		</div>
	</div>
	
	<!-- contents S -->
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 통신사실 확인자료제공 요청집행대장 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>통신사실 확인자료제공 요청집행대장 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents">
					<div class="list" id="contentsArea">
			        	<input type="hidden" id="cmctCnfmReqExecNum" name="cmctCnfmReqExecNum" value="" />
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
                                <th class="C th_line">문서번호</th>
                                <td class="L td_line"><label for="docNum"><input type="text" class="w100per" id="docNum" name="docNum" maxlength="10" /></label></td>
                                <th class="C th_line">수신처</th>
                                <td class="L td_line"><label for="recvNm"><input type="text" class="w100per" id="recvNm" name="recvNm" maxlength="30" /></label></td>
                            </tr>
				             	 <tr>
				                	  
				                	<th class="C th_line ">성명</th>
				                	<td class="L td_line ">
				                		<p class="searchinput">
				                			<label for="spNm"></label><input type="text" class="w100per" id="spNm" name="spNm" disabled="disabled" data-always="y"/><a name="spBtn" class="btn_search" id="spBtn" href="javascript:void(0);"><img alt="search" src="/sjpb/images/btn_search.png"></a>	
				                		</p>
				                	</td>
				                </tr>
				                <tr>
	                                <th class="C th_line">요청사유</th>
	                                <td class="L" colspan="3"><label for="reqResn"><input type="text" class="w100per" id="reqResn" name="reqResn"  maxlength="30"/></label></td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line">해당가입자와의 연관성</th>
	                                <td class="L" colspan="3"><label for="subsConn"><input type="text" class="w100per" id="subsConn" name="subsConn"  maxlength="30"/></label></td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line">필요한 자료의 범위</th>
	                                <td class="L" colspan="3"><label for="requMatr"><input type="text" class="w100per" id="requMatr" value="requMatr"  maxlength="30"/></label></td>
	
	                            </tr>
                            </tbody>
                            <tbody id="afterDiv">
				                <tr>
				               		<th class="C th_line ">집행번호</th>
				                	<td class="L td_line " ><input type="text" id="execNum" name="execNum" maxlength="10"/></td>
				                	<th class="C th_line ">허가서번호</th>
				                	<td class="L td_line "><label for="apprDocNum"></label><input type="text" class="w100per" id="apprDocNum" name="apprDocNum" maxlength="10"/></td>
				                 </tr>    
				                <tr>
				                	<th class="C th_line ">대상</th>
				                	<td class="L td_line "><label for="cmctCnfmExecTrgt"></label><input type="text" class="w100per" id="cmctCnfmExecTrgt" name="cmctCnfmExecTrgt" maxlength="30"/></td>
				                	<th class="C th_line ">종류</th>
				                	<td class="L td_line "><label for="cmctCnfmExecType"></label><input type="text" class="w100per" id="cmctCnfmExecType" name="cmctCnfmExecType" maxlength="30"/></td>
				                </tr>
				                
				                <tr>
				                	<th class="C th_line ">범위</th>
				                	<td class="L td_line "><label for="cmctCnfmExecRnge"></label><input type="text" class="w100per" id="cmctCnfmExecRnge" name="cmctCnfmExecRnge" maxlength="30"/></td>
				                     
				                	<th class="C th_line ">집행일시</th>
				                	<td class="L td_line "><label for="cmctCnfmExecDt"></label><input type="text" class="w100per calendar datepicker" title="집행일시" id="cmctCnfmExecDt" name="cmctCnfmExecDt" data-type="date" data-optional-value=true maxlength="10" readonly/></td>
				                </tr>
				                
				                <tr>
				                	<th class="C th_line ">비고</th>
				                	<td class="L td_line " colspan="3"><label for="cmctCnfmComn"></label><input type="text" class="w100per" id="cmctCnfmComn" name="cmctCnfmComn" maxlength="300"/></td>
				                </tr>
				                
				             </tbody>
			       		</table>
       				</div>
			        <div class="btnArea">
			        	<div class="r_btn" id="btnAreaDiv">
			        		<%-- 그리는 영역 --%>
			            	<a href="javascript:requestReport();" class="btn_white print"><span>신청서 출력</span></a>
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