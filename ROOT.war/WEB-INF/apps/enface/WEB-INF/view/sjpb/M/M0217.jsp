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
<title>사건 송치부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0217.js?r=<%=Math.random()%>"></script>
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
			<a href="javascript:insertDataView();" class="btn_light_blue new2" id="btnNewSeiz" data-view-type="inc"><span>신규</span></a>
		</div>
	</div>
	
	<!-- contents S -->
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 사건송치 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>사건송치 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
					<div class="list">
			        	<input type="hidden" id="trfDocNum" name="trfDocNum" value="" />
			        	<input type="hidden" id="rcptNum" name="rcptNum" value="" /> 	
			        	<input type="hidden" id="incSpNum" name="incSpNum" value="" /> 	
			            
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
				                	<td class="L td_line"><input type="text" id="docNum" name="docNum" class="w100per" maxlength="10"/></td>
				                	<th class="C th_line">수신처</th>
									<td class="L td_line"><input type="text" class="w100per" id="recvNm" name="recvNm" maxlength="10"/></td>
				                </tr>
				                <tr>
				                	<th class="C th_line">사건번호</th>
				                	<td class="L td_line"><span id="rcptIncNum" name="rcptIncNum"></span></td>
				                	<th class="C th_line">접수일</th>
				                	<td class="L td_line"><input type="text" id="revDate" name="revDate" class="w100per calendar datepicker"/></td>							
								</tr>
				                <tr>
	                                <th class="C th_line">피의자 이름</th>
	                                <td class="L td_line">
	                                    <p class="searchinput">
				                			<label for="spNm"></label><input type="text" class="w100per" id="spNm" name="spNm" disabled="disabled" /><a name="spBtn" class="btn_search" id="spBtn" href="javascript:void(0);"><img alt="search" src="/sjpb/images/btn_search.png"></a>	
				                		</p>
	                                </td>
	                                <th class="C th_line">죄명</th>
	                                <td class="L td_line"><span id="criNm" name="criNm"></span></td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line">지문원지작성번호</th>
	                                <td class="L td_line"><input type="text" class="w100per" id="fingerNum" name="fingerNum" maxlength="10"/></td>
	                                <th class="C th_line">구속영장청구번호</th>
	                                <td class="L td_line"><input type="text" class="w100per" id="cmctNum" name="cmctNum" maxlength="10"/></td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line">발각원인</th>
	                                <td class="L td_line">
	                                    <div class="inputbox w100per"> 
											<p class="txt"></p> 
							            	<select id="dvCau" name="dvCau" title="발각원인" >
							            		<option value="">선택</option>
							            		<option value="인지">인지</option>
							            		<option value="고소">고소</option>
							            		<option value="고발">고발</option>
							            		<option value="자수">자수</option>
							            	</select>
						            	</div>
	                                </td>
	                                <th class="C th_line">구속</th>
	                                <td class="L td_line"><input type="text" id="cmctDate" name="cmctDate" class="w100per calendar datepicker"/></td> 
	                            </tr>
	                            <tr>
	                                <th class="C th_line">석방</th>
	                                <td class="L td_line"><input type="text" id="releaseDate" name="releaseDate" class="w100per calendar datepicker"/></td>
	                                <th class="C th_line">의견</th>
	                                <td class="L td_line"><input type="text" class="w100per" id="comnt" name="comnt" maxlength="30"/></td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line">증거품</th>
	                                <td class="L td_line"><input type="text" class="w100per" id="evidItem" name="evidItem" maxlength="100"/></td>
	                                <th class="C th_line">비고</th>
	                                <td class="L td_line"><input type="text" class="w100per" id="comn" name="comn" maxlength="30"/></td>
	                            </tr>
	                             <tr>
	                                <th class="C th_line">수리전산입력</th>
	                                <td class="L td_line" colspan="3"><input type="text" class="w100per" id="procInput" name="procInput" maxlength="100"/></td>
	                                
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