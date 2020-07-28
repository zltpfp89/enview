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
<title>체포영장신청부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0104.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" data-view-type="mng">
		<form name="m0104_searchList" id="m0104_searchList" method="post" onkeydown="if(event.keyCode==13) fn_M0104_pageInit()">
			<ul>
				<li><span class="title">사건번호</span>
					<label for="rcptIncNumSc"></label><input type="text" class="w65per" name="rcptIncNumSc"/>
				</li>		   
				<li><span class="title">피의자명</span>
					<label for="spNmSc"></label><input type="text" class="w65per" id="spNmSc" name="spNmSc" />
				</li>
				<li><span class="title">등록일자</span>
					<label for="regStart"></label><input type="text" id="regStart" name="regStart" class="w30per calendar datepicker" readonly/>~
					<label for="regEnd"></label><input type="text" id="regEnd" name="regEnd" class="w30per calendar datepicker" readonly/>
				</li>
			</ul>
			<div class="searchbtn">
				<a href="javascript:fn_M_init('m0104_searchList');" class="btn_white reset"><span>초기화</span></a>
				<a href="javascript:fn_M0104_pageInit();" class="btn_light_blue search_01"><span>검색</span></a>
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
			<a href="javascript:fn_M0104_newCathWrnt();" class="btn_light_blue new2" id="btnNewCathWrnt"  data-view-type="inc"><span>신규</span></a>
			<a href="javascript:fn_M0104_prnCheckReport();" class="btn_white print" id="btnprnCheck"  data-view-type="mng"><span>대장 출력</span></a>
		</div>
	</div>
	<input type="hidden" name="userId" id="userId" value="${userId}"/>
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 체포영장신청부 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>체포영장신청부 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
	       			<form id="M0104CathWrnt" name="M0104CathWrnt">
	       				<input type="hidden" name="rcptNum" id="rcptNum"/>
	       				<input type="hidden" name="incSpNum" id="incSpNum"/>
	       				<input type="hidden" name="cathWrntReqBkNum" id="cathWrntReqBkNum"/>
	       				<input type="hidden" name="regUserId" id="regUserId"/>
		       			<table class="list" cellpadding="0" cellspacing="0">
							<colgroup>
								<col width="10%"/>
								<col width="10%"/>
								<col width="35%"/>
								<col width="10%"/>
								<col width="35%"/>
							</colgroup>
							<tbody>
								<tr>
									<th class="C th_line" colspan="2">문서번호</th>
									<td class="L td_line" ><input type="text" class="w100per" id="docNum" name="docNum"  maxlength="10"/></td>
									<th class="C th_line">사건번호</th>
									<td class="L td_line">
										<span id="incNum" name="incNum"></span>
									</td>
								</tr>
								<tr>
									<th class="C th_line" colspan="2">신청일자</th>
									<td class=" td_lineL">
										<input type="text" id="reqDtCal" name="reqDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" id="reqDtHour" name="reqDtHour" min="0" max="24" step="1" maxlength="2" class="w15per" disabled="disabled"/>시
										<input type="number" id="reqDtMin" name="reqDtMin" min="0" max="60" step="5" maxlength="2" class="w15per" disabled="disabled"/>분
									</td>
									<td class="L td_line" colspan="2"></td>
								</tr>
								<tr>
									<th class="C th_line" colspan="2">신청자 관직</th>
									<td class="L td_line">
										<input type="text" id="apltTitl" name="apltTitl" class="w100per" disabled="disabled"  maxlength="30"/>
									</td>
									<th class="C th_line">신청자 성명</th>
									<td class="L td_line">
										<input type="text" id="apltNm" name="apltNm" class="w100per" disabled="disabled" maxlength="30" />
									</td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="2">피의자</th>
									<th class="C th_line">성명</th>
									<td class="L td_line">
										<p class="searchinput">
				                			<label for="txt_04"></label><input type="text" class="w100per" id="txt_04" name="spNm" disabled="disabled" data-always="y" readonly/><a name="spBtn" class="btn_search" id="spBtn" href="javascript:void(0);"><img alt="search" src="/sjpb/images/btn_search.png"></a>	
				                		</p>
									</td>
									<th class="C th_line" >주민등록번호</th>
									<td class="L td_line" id="spIdNum" name="spIdNum"></td>
								</tr>
								<tr>
									<th class="C th_line">직업</th>
									<td class="L td_line" id="spJob" name="spJob"></td>
									<th class="C th_line">주거</th>
									<td class="L td_line" id="spAddr" name="spAddr"></td>
								</tr>
								<tr>
									<th class="C th_line" colspan="2">죄명</th>
									<td class="L td_line" id="rltActCriNmCdDesc" name="rltActCriNmCdDesc"></td>
									<td class="L td_line" colspan="2"></td>
								</tr>
								<tr>
                                <th class="C th_line" colspan="2">변호인</th>
                                <td class="L td_line" colspan="3"><label for="attoNm"><input type="text" class="w100per" id="attoNm" name="attoNm" maxlength="10" /></label></td>
                            </tr>
                            <tr>
                                <th class="C th_line" colspan="2">7일을 넘는 유효기간을 필요로 하는 취지와 사유</th>
                                <td class="L td_line" colspan="3"><label for="overWeekResn"><input type="text" class="w100per" id="overWeekResn" name="overWeekResn" maxlength="100" /></label></td>
                            </tr>
                            <tr>
                                <th class="C th_line" colspan="2">둘 이상의 영장을 신청하는 취지와 사유</th>
                                <td class="L td_line" colspan="3"><label for="overTwoPersRes"><input type="text" class="w100per" id="overTwoPersRes" name="overTwoPersRes"  maxlength="100"/></label></td>
                            </tr>
                            </tbody>
                            <tbody id="afterDiv">
								<tr>
									<th class="C th_line" colspan="2">진행번호</th>
									<td class="L td_line" colspan="3"><input type="text" class="w100per" id="prgsNum" name="prgsNum" maxlength="10"/></td>
								</tr>
								<tr>
									<th class="C th_line" colspan="2">검사기각</th>
									<td class="L td_line">
										<input type="text" id="cathWrntPstrRjctDtCal" name="cathWrntPstrRjctDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" id="cathWrntPstrRjctDtHour" min="0" max="24" step="1"  name="cathWrntPstrRjctDtHour" class="w15per" disabled="disabled"/>시
										<input type="number" id="cathWrntPstrRjctDtMin" name="cathWrntPstrRjctDtMin" min="0" max="60" step="5" class="w15per" disabled="disabled"/>분										
									</td>
									<th class="C th_line">판사기각</th>
									<td class="L td_line">
										<input type="text" id="cathWrntJudgRjctDtCal" name="cathWrntJudgRjctDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" id="cathWrntJudgRjctDtHour" min="0" max="24" step="1"  name="cathWrntJudgRjctDtHour" class="w15per" disabled="disabled"/>시
										<input type="number" id="cathWrntJudgRjctDtMin" name="cathWrntJudgRjctDtMin" min="0" max="60" step="5" class="w15per" disabled="disabled"/>분										
									</td>
								</tr>
								<tr>
									<th class="C th_line" colspan="2">발부</th>
									<td class="L td_line">
										<input type="text" id="cathWrntIsueDtCal" name="cathWrntIsueDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" id="cathWrntIsueDtHour" min="0" max="24" step="1" class="w15per" name="cathWrntIsueDtHour" disabled="disabled"/>시
										<input type="number" id="cathWrntIsueDtMin" name="cathWrntIsueDtMin" min="0" max="60" step="5" class="w15per" disabled="disabled"/>분										
									</td>
									<td class="L td_line" colspan="2"></td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="2">재신청</th>
									<th class="C th_line">신청</th>
									<td class="L td_line">
										<input type="text" id="cathWrntReReqDtCal" name="cathWrntReReqDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" id="cathWrntReReqDtHour" min="0" max="24" step="1" class="w15per" name="cathWrntReReqDtHour" disabled="disabled"/>시
										<input type="number" id="cathWrntReReqDtMin" name="cathWrntReReqDtMin" min="0" max="60" step="5" class="w15per" disabled="disabled"/>분
									</td>
									<th class="C th_line">검사기각</th>
									<td class="L td_line">
										<input type="text" id="cathWrntReReqPstrRjctDtCal" name="cathWrntReReqPstrRjctDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" id="cathWrntReReqPstrRjctDtHour" name="cathWrntReReqPstrRjctDtHour" min="0" max="24" step="1" class="w15per" disabled="disabled"/>시
										<input type="number" id="cathWrntReReqPstrRjctDtMin" name="cathWrntReReqPstrRjctDtMin" min="0" max="60" step="5" class="w15per" disabled="disabled"/>분
									</td>
								</tr>
								<tr>
									<th class="C th_line">판사기각</th>
									<td class="L td_line">
										<input type="text" id="cathWrntReReqJudgRjctDtCal" name="cathWrntReReqJudgRjctDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" id="cathWrntReReqJudgRjctDtHour" name="cathWrntReReqJudgRjctDtHour" min="0" max="24" step="1" class="w15per"  disabled="disabled"/>시
										<input type="number" id="cathWrntReReqJudgRjctDtMin" name="cathWrntReReqJudgRjctDtMin" min="0" max="60" step="5" class="w15per" disabled="disabled"/>분
									</td>
									<th class="C th_line">발부</th>
									<td class="L td_line">
										<input type="text" id="cathWrntReReqIsueDtCal" name="cathWrntReReqIsueDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" id="cathWrntReReqIsueDtHour" name="cathWrntReReqIsueDtHour" min="0" max="24" step="1" class="w15per"  disabled="disabled"/>시
										<input type="number" id="cathWrntReReqIsueDtMin" name="cathWrntReReqIsueDtMin" min="0" max="60" step="5" class="w15per" disabled="disabled">분
									</td>
								</tr>
								<tr>
									<th class="C th_line" colspan="2">유효기간</th>
									<td class="L td_line">
										<input type="text" id="valdPi" name="valdPi" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<td class="L td_line" colspan="2"></td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="2">집행</th>
									<th class="C th_line">일시</th>
									<td class="L td_line">
										<input type="text" id="execDtCal" name="execDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" id="execDtHour" name="execDtHour" min="0" max="24" step="1" class="w15per" disabled="disabled"/>시
										<input type="number" id="execDtMin" name="execDtMin" min="0" max="60" step="5" class="w15per" disabled="disabled" />분
									</td>
									<th class="C th_line">장소</th>
									<td class="L td_line">
										<input type="text" id="execPla" name="execPla" disabled="disabled" class="w100per" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C th_line">처리결과</th>
									<td class="L td_line">
										<input type="text" id="execHandRst" name="execHandRst" disabled="disabled" class="w100per" maxlength="30"/>
									</td>
									<td class="L td_line" colspan="2"></td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="1">구속영장신청</th>
									<th class="C th_line">신청부번호</th>
									<td class="L td_line">
										<input type="text" id="arstWrntReqBkNum" name="arstWrntReqBkNum" disabled="disabled" class="w100per" maxlength="10"/>
									</td>
									<th class="C th_line">발부연월일</th>
									<td class="L td_line" colspan="2">
										<input type="text" id="arstWrntReqIsueDt" name="arstWrntReqIsueDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="1">석방</th>
									<th class="C th_line">연 월 일</th>
									<td class="L td_line">
										<input type="text" id="relsDt" name="relsDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C th_line">사유</th>
									<td class="L td_line">
										<input type="text" id="relsRsn" name="relsRsn" class="w100per" disabled="disabled" class="w80per" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C th_line" colspan="2">반환</th>
									<td class="L td_line">
										<input type="text" id="cathWrntRetn" name="cathWrntRetn" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C th_line">비고</th>
									<td class="L td_line">
										<input type="text" id="cathWrntComn" name="cathWrntComn" disabled="disabled" class="w100per" maxlength="300"/>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="btnArea">
						<div class="r_btn">
							<a href="javascript:requestReport();" class="btn_white print" style="display:none;" id="btnReqPrtCathWrnt"><span>신청서 출력</span></a>
							<a href="javascript:fn_M0104_prnReport();" class="btn_white print" style="display:none;" id="btnPrtCathWrnt"><span>대장 출력</span></a>
							<a href="javascript:fn_M0104_insertCathWrnt();" class="btn_light_blue save" style="display:none;" id="btnInsertCathWrnt" data-view-type="inc"><span>저장</span></a>
							<a href="javascript:fn_M0104_updateCathWrnt();" class="btn_light_blue_line appointed" style="display:none;" id="btnUpdateCathWrnt" data-view-type="inc"><span>수정</span></a>
							
						</div>
					</div>
				</div>
			</li>
		</ul>
		
	</div>
</body>
</html>