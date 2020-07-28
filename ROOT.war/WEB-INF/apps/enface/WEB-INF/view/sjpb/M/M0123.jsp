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
<title>긴급 통신사실 확인자료제공 요청대장</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0123.js?r=<%=Math.random()%>"></script>
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
				<li><span class="title">사건번호</span>
					<label for="rcptIncNumSc"></label><input type="text" class="w65per" id="rcptIncNumSc" name="rcptIncNumSc" />
				</li>
				<li><span class="title">성명</span>
					<label for="spNmSc"></label><input type="text" class="w65per" id="spNmSc" name="spNmSc" />
				</li>
				<li><span class="title">대상번호</span>
					<label for="emgyCmctReqTrgtSc"></label><input type="text" class="w65per" id="emgyCmctReqTrgtSc" name="emgyCmctReqTrgtSc" />
				</li>
				<li><span class="title">종류</span>
					<label for="emgyCmctReqTypeSc"></label><input type="text" class="w65per" id="emgyCmctReqTypeSc" name="emgyCmctReqTypeSc" />
				</li>
				<li><span class="title">집행일시</span>
					<label for="sExecDtSc"></label><input type="text" class="w30per calendar datepicker" id="sExecDtSc" name="sExecDtSc" data-type="date" data-optional-value=true title="집행일시시작일"/> ~ <label for="eExecDtSc"></label><input type="text" class="w30per calendar datepicker" id="eExecDtSc" name="eExecDtSc" data-type="date" data-optional-value=true title="집행일시종료일"/>
				</li>
				<li><span class="title">발송여부</span>
					<label for="notcDocSendYnDescSc"></label><input type="text" class="w65per" id="notcDocSendYnDescSc" name="notcDocSendYnDescSc" />
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
			<!-- 긴급 통신사실 확인자료제공 요청대장 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>긴급 통신사실 확인자료제공 요청대장 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents">
					<div class="list" id="contentsArea">
			        	<input type="hidden" id="emgyCmctFactCnfmNum" name="emgyCmctFactCnfmNum" value="" />
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
				                	<th class="C th_line ">문서번호</th>
				                	<td class="L td_line " colspan="3"><input type="text" id="docNum" name="docNum" maxlength="10"/></td>
								</tr>
								<tr>
									<th class="C th_line ">수신처</th>
				                	<td class="L td_line "><input type="text" id="recvNm" name="recvNm" maxlength="30"/></td>
									<th class="C th_line ">사건번호</th>
				                	<td class="L td_line "><span id="rcptIncNum" name="rcptIncNum"></span></td>
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
	                                <td class="L" colspan="3"><label for="reqResn"><input type="text" class="w100per" id="reqResn" name="reqResn" maxlength="30" /></label></td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line">해당가입자와의 연관성</th>
	                                <td class="L" colspan="3"><label for="subsConn"><input type="text" class="w100per" id="subsConn" name="subsConn" maxlength="30" /></label></td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line">필요한 자료의 범위</th>
	                                <td class="L" colspan="3"><label for="requMatr"><input type="text" class="w100per" id="requMatr" name="requMatr" maxlength="30" /></label></td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line">미리 허가를 받지 못한 사유</th>
	                                <td class="L" colspan="3"><label for="notGetPermResn"><input type="text" class="w100per" id="notGetPermResn" name="notGetPermResn" maxlength="30" /></label></td>
	                            </tr>
	                         </tbody>
	                         <tbody id="afterDiv">
				                <tr>
				                	<th class="C th_line ">집행번호</th>
				                	<td class="L td_line "><input type="text" id="execNum" name="execNum" maxlength="10"/></td>
				                	<th class="C th_line ">집행일시</th>
				                	<td class="L td_line "><label for="execDt"></label><input type="text" class="w100per calendar datepicker" title="집행일시" id="execDt" name="execDt" data-type="date" data-optional-value=true maxlength="10" readonly/></td>
				                </tr>
				                
				                <tr>
				                	<th class="C th_line ">대상</th>
				                	<td class="L td_line "><label for="emgyCmctReqTrgt"></label><input type="text" class="w100per" id="emgyCmctReqTrgt" name="emgyCmctReqTrgt" maxlength="30"/></td>
				                	<th class="C th_line ">종류</th>
				                	<td class="L td_line "><label for="emgyCmctReqType"></label><input type="text" class="w100per" id="emgyCmctReqType" name="emgyCmctReqType" maxlength="30"/></td>
				                </tr>
				                
				                <tr>
				                	<th class="C th_line ">범위</th>
				                	<td class="L td_line "><label for="emgyCmctReqRnge"></label><input type="text" class="w100per" id="emgyCmctReqRnge" name="emgyCmctReqRnge" maxlength="30"/></td>
				                	<th class="C th_line ">사후 또는 통보서 발송여부</th>
				                	<td class="L">
										<input name="notcDocSendYn" id="notcDocSendYn_1" type="radio" class="radio_pd radio_first" value="Y" title="사후 또는 통보서 발송여부" /><label for="notcDocSendYn_1">발송</label>
										<input name="notcDocSendYn" id="notcDocSendYn_2" type="radio" class="radio_pd" value="N" title="사후 또는 통보서 발송여부" /><label for="notcDocSendYn_2">미발송</label>
									</td>
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