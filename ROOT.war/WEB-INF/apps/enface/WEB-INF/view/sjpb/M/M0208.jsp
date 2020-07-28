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
<title>범죄인지보고서</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0208.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" id="searchArea" data-view-type="mng">
		<form name="searchList" id="searchList" method="post">
			<ul>
			<%-- TODO 페이지별 수정 --%>		   
				<li><span class="title">신청일자</span>
				   <label for="sReqDtSc"></label><input type="text" class="w30per calendar datepicker" id="sReqDtSc" name="sReqDtSc" data-type="date" data-optional-value=true title="신청일자시작일" value=""/> ~ <label for="eDateSc"></label><input type="text" class="w30per calendar datepicker" id="eReqDtSc" name="eReqDtSc" data-type="date" data-optional-value=true title="신청일자종료일" value=""/>
			    </li>
<!-- 			    <li><span class="title">신청자성명</span> -->
<!-- 					<label for="apltNmSc"></label><input type="text" class="w65per" id="apltNmSc" name="apltNmSc" /> -->
<!-- 				</li> -->
				
				<li><span class="title">사건번호</span>
					<label for="rcptIncNumSc"></label><input type="text" class="w65per" id="rcptIncNumSc" name="rcptIncNumSc" />
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
			<a href="javascript:insertDataView();" class="btn_light_blue new" id="btnNewSeiz" data-view-type="inc"><span>신규</span></a>
		</div>
	</div>
	
	<!-- contents S -->
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 범죄인지보고서 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>범죄인지보고서 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
					<div class="list">
			        	<input type="hidden" id="crimRepoNum" name="crimRepoNum" value="" />
			        	<input type="hidden" id="rcptNum" name="rcptNum" value="" /> 	
			            
			            <table class="list" cellpadding="0" cellspacing="0">
			                <caption>요청정보</caption>
			                <colgroup>
								<col width="15%"/>
								<col width="35%"/>
								<col width="15%"/>
								<col width="35%"/>
			                </colgroup>
				             <tbody>
				             	 <tr>
				                	<th class="C th_line">문서번호</th>
				                	<td class="L td_line"><input type="text" id="docNum" name="docNum" class="w100per" maxlength=10"/></td>
				                	<th class="C th_line">사건번호</th>
				                	<td class="L td_line"><span id="rcptIncNum" name="rcptIncNum"></span></td>	
				                </tr>
				                <tr>
				                	<th class="C th_line">혐의</th>
				                	<td class="L td_line"><input type="text" class="w100per" id="susp" name="susp" maxlength="30"/></td>
									<th class="C th_line">수신</th>
									<td class="L td_line"><input type="text" class="w100per" id="recvNm" name="recvNm" maxlength="30"/></td>						
								</tr>
				                <tr>
	                                <th class="C th_line">피의자 인적사항</th>
	                                <td class="L td_line" colspan="3">
	                                    <textarea id="persMatt" name="persMatt" cols="" rows="" style="height:160px;" maxlength="100"></textarea>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line">범죄경력자료</th>
	                                <td class="L td_line" colspan="3">
	                                    <textarea id="crimRecr" name="crimRecr" cols="" rows="" style="height:160px;" maxlength="100"></textarea>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line">범죄사실의 요지</th>
	                                <td class="L td_line" colspan="3">
	                                    <textarea id="crimPoint" name="crimPoint" cols="" rows="" style="height:160px;" maxlength="100"></textarea>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line">죄명 및 적용법조</th>
	                                <td class="L td_line" colspan="3">
	                                    <textarea id="crimNameAndAtto" name="crimNameAndAtto" cols="" rows="" style="height:160px;" maxlength="100"></textarea>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line">수사단서 및 범죄 인지 경위</th>
	                                <td class="L td_line" colspan="3">
	                                    <textarea id="srchAndCrimRecg" name="srchAndCrimRecg" cols="" rows="" style="height:160px;" maxlength="100"></textarea>
	                                </td>
	                            </tr>
				             </tbody>
			       		</table>
       				
	       			</div>
			        <div class="btnArea">
			        	<div class="r_btn" id="btnAreaDiv">
			        		<%-- 그리는 영역 --%>
			        		<a href="javascript:requestReport();" class="btn_white print"><span>신청서 출력</span></a>
			            	<a href="javascript:insertData();" class="btn_light_blue save" id="btnInsert" data-view-type="inc"><span>저장</span></a>
			            </div>
			        </div>
		        </div>
        	</li>
        </ul>
    </div>
	<!-- contents E -->
</body>
</html>