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
<title>구속영장신청부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0103.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" data-view-type="mng">
		<form name="m0103_searchList" id="m0103_searchList" method="post" onkeydown="if(event.keyCode==13) fn_M0103_pageInit()">
			<ul>
				<li><span class="title">사건번호</span>
					<label for="rcptIncNumSc"></label><input type="text" class="w65per" name="rcptIncNumSc"/>
				</li>		   
				<li><span class="title">피의자명</span>
					<label for="spNmSc"></label><input type="text" class="w65per" name="spNmSc"/>
				</li>
				<li><span class="title">등록일자</span>
					<label for="regStart"></label><input type="text" id="regStart" name="regStart" class="w30per calendar datepicker" readonly/>~
					<label for="regEnd"></label><input type="text" id="regEnd" name="regEnd" class="w30per calendar datepicker" readonly/>
				</li>	
			</ul>
			<div class="searchbtn">
				<a href="javascript:fn_M_init('m0103_searchList');" class="btn_white reset"><span>초기화</span></a>
				<a href="javascript:fn_M0103_pageInit();" class="btn_light_blue search_01"><span>검색</span></a>
			</div>
		</form>
   </div>
   <!-- searchArea //-->
	
	<!-- listArea -->
	<div id="listSheet" class="listArea mrt15 area-mousewheel" style="height: 300px; width: 100%"></div>
	<!-- listArea// -->
	
	<!-- report -->
	<form name="reportForm" method="post">
		<input type="hidden" id="reptNm" name="reptNm" value="" />
		<input type="hidden" id="xmlData" name="xmlData" value="" />
		<input type="hidden" id="SEQNUM" name="SEQNUM" value="" />
		<input type="hidden" id="POLICENAME" name="POLICENAME" value="${userId}" />
	</form>
	<!-- //report -->
	
	<!-- btnArea -->
	<div class="btnArea">
		<div class="r_btn">
			<a href="javascript:fn_M0103_newArstWrnt();" class="btn_light_blue new2" id="btnNewArstWrnt" data-view-type="inc"><span>신규</span></a>
			<a href="javascript:fn_M0103_prtCheck();" class="btn_white print" id="btnprtCheck"  data-view-type="mng"><span>대장 출력</span></a>
		</div>
	</div>
	<input type="hidden" name="userId" id="userId" value="${userId}"/>
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 구속영장신청부 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>구속영장신청부 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
	       			<form id="M0103ArstWrnt" name="M0103ArstWrnt">
	       				<input type="hidden" name="rcptNum" id="rcptNum"/>
	       				<input type="hidden" name="incSpNum" id="incSpNum"/>
	       				<input type="hidden" name="arstWrntReqBkNum" id="arstWrntReqBkNum"/>
	       				<input type="hidden" name="regUserId" id="regUserId"/>
	       				
		       			<table class="list" cellpadding="0" cellspacing="0">
							<colgroup>
								<col width="10%"/>
								<col width="10%"/>
								<col width="10%"/>
								<col width="30%"/>
								<col width="10%"/>
								<col width="30%"/>
							</colgroup>
							<tbody>
								<tr>
									<th class="C th_line" colspan="3">문서번호</th>
									<td class="L td_line"><input type="text" id="docNum" name="docNum" maxlength="10"></td>
									<th class="C th_line">사건번호</th>
									<td class="L td_line">
										<span id="incNum" name="incNum"></span>	
									</td>
								</tr>
								<tr>
									<th class="C th_line" colspan="3">주임검사</th>
									<td class="L td_line">
										<input type="text" id="chifPstr" name="chifPstr" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C th_line">신청관서</th>
									<td class="L td_line">
										<input type="text" id="reqOfic" name="reqOfic" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="2">피의자</th>
									<th class="C th_line" colspan="2">성명</th>
									<td class="L td_line">
										<p class="searchinput">
				                			<label for="txt_04"></label><input type="text" class="w100per" id="txt_04" name="spNm" disabled="disabled" data-always="y" readonly/><a name="spBtn" class="btn_search" id="spBtn" href="javascript:void(0);"><img alt="search" src="/sjpb/images/btn_search.png"></a>	
				                		</p>
									</td>
									<th class="C th_line">주민등록번호</th>
									<td class="L td_line" id="spIdNum" name="spIdNum"></td>
								</tr>
								<tr>
									<th class="C th_line" colspan="2">직업</th>
									<td class="L td_line" id="spJob" name="spJob"></td>
									<th class="C th_line" >주거</th>
									<td class="L td_line" id="spAddr" name="spAddr""></td>
								</tr>
								<tr>
									<th class="C th_line" colspan="3">죄명</th>
									<td class="L td_line" colspan="3" id="rltActCriNmCdDesc" name="rltActCriNmCdDesc"></td>
								</tr>
								<tr>
                                <th class="C th_line" colspan="3">변호사</th>
                                <td class="L td_line" colspan="3"><label for="attoNm"><input type="text" class="w100per" id="attoNm" name="attoNm" maxlength="10"></label></td>
                            </tr>
                            <tr>
                                <th class="C th_line" colspan="3">필요적 고려사항</th>
                                <td class="L td_line" colspan="1">
                                    <div class="inputbox w100per">
                                        <p class="txt"></p>
                                        <select id="nessSel" name="nessSel">
                                            <option value="">선택</option>
                                            <option value="범죄의 중대성">범죄의 중대성</option>
                                            <option value="재범의 위험성">재범의 위험성</option>
                                            <option value="피해자·중요 참고인 등에 대한 위해 우려">피해자·중요 참고인 등에 대한 위해 우려</option>
                                            <option value="기타 사유">기타 사유</option>
                                        </select>
                                    </div>
                                </td>
                                <th class="C th_line">구속장소</th>
                                <td class="L td_line"><label for="arstPla"><input type="text" class="w100per" id="arstPla" name="arstPla" maxlength="30"></label></td>
                            </tr>
                            <tr>
                                <th class="C th_line" colspan="3">7일을 넘는 유효기간을 필요로 하는 취지와 사유</th>
                                <td class="L td_line" colspan="3"><label for="overWeekResn"><input type="text" class="w100per" id="overWeekResn" name="overWeekResn" maxlength="100"></label></td>
                            </tr>
                            <tr>
                                <th class="C th_line" colspan="3">둘 이상의 영장을 신청하는 취지와 사유</th>
                                <td class="L td_line" colspan="3"><label for="overTwoPersRes"><input type="text" class="w100per" id="overTwoPersRes" name="overTwoPersRes" maxlength="100"></label></td>
                            </tr>
                            </tbody>
                            <tbody id="afterDiv">
                            	<tr>
                            		<th class="C th_line" colspan="3">진행번호</th>
									<td class="L td_line" colspan="3"><input type="text" id="prgsNum" name="prgsNum" maxlength="10"></td>
                            	</tr>
								<tr>
									<th class="C line_right" rowspan="2">체포</th>
									<th class="C th_line" colspan="2">일시</th>
									<td class="L td_line">
										<input type="text" id="cathDtCal" name="cathDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" min="0" max="24" step="1" id="cathDtHour" name="cathDtHour" class="w15per" disabled="disabled"/>시
										<input type="number" min="0" max="60" step="5" id="cathDtMin" name="cathDtMin" class="w15per" disabled="disabled"/>분										
									</td>
									<td class="L td_line" colspan="2"></td>
								</tr>
								<tr>
									<th class="C th_line" colspan="2">유형</th>
									<td class="L td_line">
										<div class="inputbox w100per"> 
									    	<p class="txt"></p> 
							            	<select id="cathTpCd" name="cathTpCd" disabled="disabled">
							            		<option value="">체포유형을 선택하세요.</option>
							            		<c:forEach items="${cathTpCdList }" var="item">
							            			<option value="${ item.code}">${item.codeName }</option>
							            		</c:forEach>
							            	</select>
						            	</div>
									</td>
									<th class="C th_line">진행번호</th>
									<td class="L td_line">
										<input type="text" name="cathPrgsNum" id="cathPrgsNum" class="w100per" disabled="disabled"  maxlength="10"/>
									</td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="8">영장신청 및 발부</th>
									<th class="C th_line" colspan="2">검사기각</th>
									<td class="L td_line">
										<input type="text" id="wrntPstrRjctDtCal" name="wrntPstrRjctDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<div class="inputbox w15per"> 
									    	<p class="txt"></p> 
							            	<select id="wrntPstrRjctDtHour" name="wrntPstrRjctDtHour" disabled="disabled">
							            		<option value="">시</option>
							            		<c:forEach items="${hourList}" var="item">
							            			<option value="${item.code}">${item.code}</option>
							            		</c:forEach>
							            	</select>
						            	</div>
										<div class="inputbox w15per"> 
									    	<p class="txt"></p> 
							            	<select id="wrntPstrRjctDtMin" name="wrntPstrRjctDtMin" disabled="disabled">
							            		<option value="">분</option>
							            		<c:forEach items="${minList}" var="item">
							            			<option value="${item.code}">${item.code}</option>
							            		</c:forEach>
							            	</select>
						            	</div>
<!-- 										<input type="number" min="0" max="24" step="1" id="wrntPstrRjctDtHour" name="wrntPstrRjctDtHour" class="w15per" disabled="disabled"/>시 -->
<!-- 										<input type="number" min="0" max="60" step="5" id="wrntPstrRjctDtMin" name="wrntPstrRjctDtMin" class="w15per" disabled="disabled"/>분										 -->
									</td>
									<th class="C th_line">판사기각</th>
									<td class="L td_line">
										<input type="text" id="wrntJudgRjctDtCal" name="wrntJudgRjctDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" min="0" max="24" step="1" id="wrntJudgRjctDtHour" name="wrntJudgRjctDtHour" class="w15per" disabled="disabled"/>시
										<input type="number" min="0" max="60" step="5" id="wrntJudgRjctDtMin" name="wrntJudgRjctDtMin" class="w15per" disabled="disabled"/>분
									</td>
								</tr>
								<tr>
									<th class="C th_line" colspan="2">발부</th>
									<td class="L td_line">
										<input type="text" id="wrntIsueDtCal" name="wrntIsueDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" min="0" max="24" step="1" id="wrntIsueDtHour" name="wrntIsueDtHour" class="w15per" disabled="disabled"/>시
										<input type="number" min="0" max="60" step="5" id="wrntIsueDtMin" name="wrntIsueDtMin" class="w15per" disabled="disabled"/>분
									</td>
									<td class="L td_line" colspan="2"></td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="2">재신청</th>
									<th class="C th_line">신청</th>
									<td class="L td_line">
										<input type="text" id="wrntReReqDtCal" name="wrntReReqDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" min="0" max="24" step="1" id="wrntReReqDtHour" name="wrntReReqDtHour" class="w15per" disabled="disabled"/>시
										<input type="number" min="0" max="60" step="5" id="wrntReReqDtMin" name="wrntReReqDtMin" class="w15per" disabled="disabled"/>분
									</td>
									<th class="C th_line">검사기각</th>
									<td class="L td_line">
										<input type="text" id="wrntReReqPstrRjctDtCal" name="wrntReReqPstrRjctDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" min="0" max="24" step="1" id="wrntReReqPstrRjctDtHour" name="wrntReReqPstrRjctDtHour" class="w15per" disabled="disabled"/>시
										<input type="number" min="0" max="60" step="5" id="wrntReReqPstrRjctDtMin" name="wrntReReqPstrRjctDtMin" class="w15per" disabled="disabled"/>분
									</td>
								</tr>
								<tr>
									<th class="C th_line">판사기각</th>
									<td class="L td_line">
										<input type="text" id="wrntReReqJudgRjctDtCal" name="wrntReReqJudgRjctDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" min="0" max="24" step="1" id="wrntReReqJudgRjctDtHour" name="wrntReReqJudgRjctDtHour" class="w15per" disabled="disabled"/>시
										<input type="number" min="0" max="60" step="5" id="wrntReReqJudgRjctDtMin" name="wrntReReqJudgRjctDtMin" class="w15per" disabled="disabled"/>분
									</td>
									<th class="C th_line">발부</th>
									<td class="L td_line">
										<input type="text" id="wrntReReqIsueDtCal" name="wrntReReqIsueDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" min="0" max="24" step="1" id="wrntReReqIsueDtHour" name="wrntReReqIsueDtHour" class="w15per" disabled="disabled"/>시
										<input type="number" min="0" max="60" step="5" id="wrntReReqIsueDtMin" name="wrntReReqIsueDtMin" class="w15per" disabled="disabled">분
									</td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="4">피의자 심문</th>
									<th class="C th_line">신청인</th>
									<td class="L td_line">
										<input type="text" id="spItrgAplt" name="spItrgAplt" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C th_line">일련번호</th>
									<td class="L td_line">
										<input type="text" id="spItrgSiNum" name="spItrgSiNum" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C th_line">검사 또는 판사명</th>
									<td class="L td_line">
										<input type="text" id="spItrgPstrNm" name="spItrgPstrNm" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C th_line">접수일시</th>
									<td class="L td_line">
										<input type="text" id="spItrgRcptDtCal" name="spItrgRcptDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" min="0" max="24" step="1" id="spItrgRcptDtHour" name="spItrgRcptDtHour" class="w15per" disabled="disabled"/>시
										<input type="number" min="0" max="60" step="5" id="spItrgRcptDtMin" name="spItrgRcptDtMin" class="w15per" disabled="disabled"/>분
									</td>
								</tr>
								<tr>
									<th class="C th_line">접수자 관직</th>
									<td class="L td_line">
										<input type="text" id="spItrgApltTitl" name="spItrgApltTitl" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C th_line">접수자 성명</th>
									<td class="L td_line" colspan="2">
										<input type="text" id="spItrgApltNm" name="spItrgApltNm" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C th_line">구인일시</th>
									<td class="L td_line">
										<input type="text" id="spItrgArstDtCal" name="spItrgArstDtCal"class="w50per calendar datepicker" readonly/>
										<input type="number" min="0" max="24" step="1" id="spItrgArstDtHour" name="spItrgArstDtHour" class="w15per" disabled="disabled"/>시
										<input type="number" min="0" max="60" step="5" id="spItrgArstDtMin" name="spItrgArstDtMin" class="w15per" disabled="disabled"/>분
									</td>
									<td class="L td_line" colspan="2"></td>
								</tr>
								<tr>
									<th class="C th_line" colspan="3">유효기간</th>
									<td class="L td_line">
										<input type="text" id="valdPi" name="valdPi" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<td class="L td_line" colspan="2"></td>
								</tr>
								<tr>
									<th class="C line_right">석방</th>
									<th class="C th_line" colspan="2">연 월 일</th>
									<td class="L td_line">
										<input type="text" id="relsDt" name="relsDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C th_line">사유</th>
									<td class="L td_line">
										<input type="text" id="relsRsn" name="relsRsn" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C th_line" colspan="3">반환</th>
									<td class="L td_line">
										<input type="text" id="arstWrntRetn" name="arstWrntRetn" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C th_line">비고</th>
									<td class="L td_line">
										<input type="text" id="arstWrntComn" name="arstWrntComn" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="btnArea">
						<div class="r_btn">
							<a href="javascript:requestReport();" class="btn_white print" id="btnReqPrtArstWrnt"><span>신청서 출력</span></a>
							<a href="javascript:fn_M0103_prnReport();" class="btn_white print" id="btnPrtArstWrnt"><span>대장 출력</span></a>
							<a href="javascript:fn_M0103_insertArstWrnt();" class="btn_light_blue save" style="display:none;" id="btnInsertArstWrnt" data-view-type="inc"><span>저장</span></a>
							<a href="javascript:fn_M0103_updateArstWrnt();" class="btn_light_blue_line appointed" style="display:none;" id="btnUpdateArstWrnt" data-view-type="inc"><span>수정</span></a>					
						</div>
					</div>
				</div>
			</li>
		</ul>
		
	</div>
</body>
</html>