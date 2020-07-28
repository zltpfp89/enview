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
<title>통신사실 확인자료제공 요청 집행사실통지부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0126.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" id="searchArea" data-view-type="mng">
		<form name="searchList" id="searchList" method="post">
			<%-- <input type="hidden" class="w65per" id="rcptNumSc" name="rcptNumSc" /> --%>
			<ul>
			<%-- TODO 페이지별 수정 --%>
				<li><span class="title">연번</span>
					<label for="notcSiNumSc"></label><input type="text" class="w65per" id="notcSiNumSc" name="notcSiNumSc" />
				</li>		   
				<li><span class="title">허가서 번호</span>
					<label for="apprDocNumSc"></label><input type="text" class="w65per" id="apprDocNumSc" name="apprDocNumSc" />
				</li>
				<li><span class="title">통지대상자</span>
					<label for="notcTrgtPersSc"></label><input type="text" class="w65per" id="notcTrgtPersSc" name="notcTrgtPersSc" />
				</li>
				<li><span class="title">사건번호</span>
					<label for="rcptIncNumSc"></label><input type="text" class="w65per" id="rcptIncNumSc" name="rcptIncNumSc" />
				</li>
				<li><span class="title">처리일자</span>
					<label for="sHandDtSc"></label><input type="text" class="w30per calendar datepicker" id="sHandDtSc" name="sHandDtSc" data-type="date" data-optional-value=true title="처리일자시작일"/> ~ <label for="eHandDtSc"></label><input type="text" class="w30per calendar datepicker" id="eHandDtSc" name="eHandDtSc" data-type="date" data-optional-value=true title="처리일자종료일"/>
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
			<!-- 통신사실 확인자료제공 요청 집행사실통지부 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>통신사실 확인자료제공 요청 집행사실통지부 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents">
					<div class="list" id="contentsArea">
			        	<input type="hidden" id="cmctCnfmDelyNotcNum" name="cmctCnfmDelyNotcNum" value="" />
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
				                	<th class="C th_line ">사건번호</th>
				                	<td class="L td_line " colspan="3"><span id="rcptIncNum" name="rcptIncNum"></span></td>
				               
				             	</tr>
				             	 <tr>
				                	<th class="C th_line ">문서번호</th>
				                	<td class="L td_line "><input type="text" id="docNum" name="docNum" maxlength="10"/></td>
				                	<th class="C th_line ">허가서번호</th>
				                	<td class="L td_line "><label for="apprDocNum"></label><input type="text" class="w100per" id="apprDocNum" name="apprDocNum" maxlength="10"/></td> 
				                </tr>
				                <tr>
	                                <th class="C th_line ">통신사실 확인자료 제공 요청 집행기관</th>
	                                <td class="L td_line" colspan="3"><label for="reqExecAgcy"><input type="text" class="w100per" id="reqExecAgcy" name="reqExecAgcy" maxlength="30"></label></td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line">전기통신가입자</th>
	                                <td class="L td_line" colspan="3"><label for="teleSubs"><input type="text" class="w100per" id="teleSubs" name="teleSubs" maxlength="30"></label></td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line">통신사실 확인자료 제공요청의 대상과 종류</th>
	                                <td class="L td_line" colspan="3"><label for="reqTargAndKind"><input type="text" class="w100per" id="reqTargAndKind" name="reqTargAndKind" maxlength="30"></label></td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line">통신사실 확인자료 제공 요청의 범위</th>
	                                <td class="L td_line" colspan="3"><label for="reqScop"><input type="text" class="w100per" id="reqScop" name="reqScop" maxlength="30"></label></td>
	                            </tr>
                           </tbody>
                           <tbody id="afterDiv">
				                <tr>
				                	<th class="C th_line ">연번</th>
				                	<td class="L td_line "><input type="text" id="notcSiNum" name="notcSiNum" maxlength="10"/></td>
				                	<th class="C th_line ">통지대상자</th>
				                	<td class="L td_line ">
				                		<label for="notcTrgtPers"></label><input type="text" class="w100per" id="notcTrgtPers" name="notcTrgtPers" maxlength="30" />	
				                	</td>
				                </tr>
				                <tr>
				                	<th class="C th_line ">집행자관직</th>
				                	<td class="L td_line "><label for="execOffiTitl"></label><input type="text" class="w100per" id="execOffiTitl" name="execOffiTitl" maxlength="30"/></td>
				                	<th class="C th_line ">집행자성명</th>
				                	<td class="L td_line "><label for="execOffiNm"></label><input type="text" class="w100per" id="execOffiNm" name="execOffiNm" maxlength="30"/></td>
				                </tr>
				                
				                 <tr>
				                	<th class="C th_line ">처리일자</th>
				                	<td class="L td_line "><label for="handDt"></label><input type="text" class="w100per calendar datepicker" title="처리일자" id="handDt" name="handDt" data-type="date" data-optional-value=true maxlength="10" readonly/></td>
				                	<th class="C th_line ">처리결과</th>
				                	<td class="L td_line "><label for="handRst"></label><input type="text" class="w100per" id="handRst" name="handRst" maxlength="30"/></td>
				                 <tr>    
				                	<th class="C th_line ">처리결과를 통보받은일자</th>
				                	<td class="L td_line "><label for="notcRecvDt"></label><input type="text" class="w100per calendar datepicker" title="처리결과를 통보받은일자" id="notcRecvDt" name="notcRecvDt" data-type="date" data-optional-value=true maxlength="10" readonly/></td>
				                	<th class="C th_line ">통지일자</th>
				                	<td class="L td_line "><label for="notcDt"></label><input type="text" class="w100per calendar datepicker" title="통지일자" id="notcDt" name="notcDt" data-type="date" data-optional-value=true maxlength="10" readonly/></td>
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
			            	<a href="javascript:insertData();" class="btn_light_blue" data-view-type="inc"><span>저장</span></a>
			            </div>
			        </div>
		        </div>
        	</li>
        </ul>
	</div>
	<!-- contents E -->
</body>
</html>