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
<title>긴급체포원부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0106.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" data-view-type="mng">
		<form name="m0106_searchList" id="m0106_searchList" method="post" onkeydown="if(event.keyCode==13) fn_M0106_pageInit()">
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
				<a href="javascript:fn_M_init('m0106_searchList');" class="btn_white reset"><span>초기화</span></a>
				<a href="javascript:fn_M0106_pageInit();" class="btn_light_blue search_01"><span>검색</span></a>
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
			<a href="javascript:fn_M0106_newEmgyCath();" class="btn_light_blue new2" id="btnNewEmgyCath" data-view-type="inc"><span>신규</span></a>
			<a href="javascript:fn_M0106_prnEmgyCathCheckReport();" class="btn_white print"><span>대장 출력</span></a>		
		</div>
	</div>
	<input type="hidden" name="userId" id="userId" value="${userId}"/>
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 긴급체포원부 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>긴급체포원부 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
	       			<form id="M0106EmgyCath" name="M0106EmgyCath">
	       				<input type="hidden" name="rcptNum" id="rcptNum"/>
	       				<input type="hidden" name="incSpNum" id="incSpNum"/>
	       				<input type="hidden" name="sjpbEmgyCathBookNum" id="sjpbEmgyCathBookNum"/>
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
									<th class="C th_line" colspan="2">사건번호</th>
									<td class="L" colspan="3">
										<span name="incNum" id="incNum"></span>
									</td>
								</tr>

								<tr>
									<th class="C line_right" rowspan="2">피의자</th>
									<th class="C">성명</th>
									<td class="L">
										<p class="searchinput">
				                			<label for="txt_04"></label><input type="text" class="w100per" id="txt_04" name="spNm" disabled="disabled" data-always="y" readonly/><a name="spBtn" class="btn_search" id="spBtn" href="javascript:void(0);"><img alt="search" src="/sjpb/images/btn_search.png"></a>	
				                		</p>
									</td>
									<th class="C">주민등록번호</th>
									<td class="L">
										<span id="spIdNum" name="spIdNum"></span>
									</td>
								</tr>
								<tr>
									<th class="C">직업</th>
									<td class="L">
										<span id="spJob" name="spJob"></span>
									</td>
									<th class="C">주거</th>
									<td class="L">
										<span id="spAddr" name="spAddr"></span>
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">죄명</th>
									<td class="L" id="rltActCriNmCdDesc" name="rltActCriNmCdDesc"></td>
									<td class="L td_line" colspan="2"></td>
								</tr>
								<tr>
									<th class="C th_line" colspan="2">변호인</th>
									<td class="L" colspan="3">
										<input type="text" name="attoNm" id="attoNm" maxlength="10"/>
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">긴급체포작성연월일</th>
									<td class="L">
										<input type="text" id="emgyCathDocFillDt" name="emgyCathDocFillDt" disabled="disabled" class="w100per calendar datepicker"/>
									</td>
									<td class="L td_line" colspan="2"></td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="4">긴급체포</th>
									<th class="C">체포한 일시</th>
									<td class="L">
										<input type="text" id="emgyCathDtCal" name="emgyCathDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" id="emgyCathDtHour" name="emgyCathDtHour" min="0" max="24" step="1" disabled="disabled" class="w15per"/>시
										<input type="number" id="emgyCathDtMin" name="emgyCathDtMin" min="0" max="60" step="5" disabled="disabled" class="w15per"/>분
									</td>
									<th class="C">체포한 장소</th>
									<td class="L">
										<input type="text" name="emgyCathPla" id="emgyCathPla" disabled="disabled" class="w100per" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C">체포자의 관직</th>
									<td class="L">
										<input type="text" name="emgyCathPersTitl" id="emgyCathPersTitl" disabled="disabled" class="w100per" maxlength="30"/>
									</td>
									<th class="C">체포자의 성명</th>
									<td class="L">
										<input type="text" name="emgyCathPersNm" id="emgyCathPersNm" disabled="disabled" class="w100per" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C">인치한 일시</th>
									<td class="L">
										<input type="text" id="emgyCathCstdDtCal" name="emgyCathCstdDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" id="emgyCathCstdDtHour" name="emgyCathCstdDtHour" min="0" max="24" step="1" disabled="disabled" class="w15per"/>시
										<input type="number" id="emgyCathCstdDtMin" name="emgyCathCstdDtMin" min="0" max="60" step="5" disabled="disabled" class="w15per"/>분
									</td>
									<th class="C">인치한 장소</th>
									<td class="L">
										<input type="text" name="emgyCathCstdPla" id="emgyCathCstdPla" disabled="disabled" class="w100per" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C">구금한 일시</th>
									<td class="L">
										<input type="text" id="emgyCathDetnDtCal" name="emgyCathDetnDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" id="emgyCathDetnDtHour" name="emgyCathDetnDtHour" min="0" max="24" step="1" disabled="disabled" class="w15per"/>시
										<input type="number" id="emgyCathDetnDtMin" name="emgyCathDetnDtMin" min="0" max="60" step="5" disabled="disabled" class="w15per"/>분
									</td>
									<th class="C">구금한 장소</th>
									<td class="L">
										<input type="text" name="emgyCathDetnPla" id="emgyCathDetnPla" disabled="disabled" class="w100per" maxlength="30"/>
									</td>
								</tr>
								 <tr>
	                                <th class="C th_line" colspan="2">구금 집행자 관직</th>
	                                <td class="L td_line"><label for="dentPersNm"><input type="text" class="w100per" id="dentPersNm" name="dentPersNm" maxlength="30"></label></td>
	                                <th class="C th_line">구금 집행자 성명</th>
	                                <td class="L td_line"><label for="dentPersTitl"><input type="text" class="w100per" id="dentPersTitl" name="dentPersTitl" maxlength="30"></label></td>
	                            </tr>
								<tr>
									<th class="C" colspan="2">석방일시</th>
									<td class="L">
										<input type="text" id="relsDt" name="relsDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C th_line">석방한 장소</th>
                                	<td class="L td_line"><label for="relsPla"><input type="text" class="w100per" id="relsPla" name="relsPla" maxlength="30"></label></td>
									
								</tr>
								<tr>
	                                <th class="C th_line" colspan="2">석방사유</th>
	                                <td class="L td_line" colspan="3">
	                                    <div class="inputbox w30per">
	                                        <p class="txt"></p>
	                                        <select id="relsRsn" name="relsRsn" data-type="select" onchange="changeRsnEtc(this.value);">
	                                            <option value="">선택</option>
	                                            <option value="구속영장청구 불요">구속영장청구 불요</option>
	                                            <option value="추가수사필요">추가수사필요</option>
	                                            <option value="기타">기타</option>
	                                        </select>
	                                    </div>
	                                    <input type="text" class="w50per" id="relsRsnEtc" name="relsRsnEtc" disabled="disabled" maxlength="30"/>
	                                </td>
                            	</tr>
                            	<tr>
	                                <th class="C th_line" colspan="2">석방한 자의 관직</th>
	                                <td class="L td_line"><label for="txt_27"><input type="text" class="w100per" id="relsPersNm" name="relsPersNm" maxlength="30"></label></td>
	                                <th class="C th_line">석방한 자의 성명</th>
	                                <td class="L td_line"><label for="txt_28"><input type="text" class="w100per" id="relsPersTitl" name="relsPersTitl" maxlength="30"></label></td>
                           		</tr>
                          	</tbody>
                          	<tbody id="afterDiv">
								<tr>
									<th class="C th_line" colspan="2">집행번호</th>
									<td class="L" colspan="3"><input type="text" id="execNum" name="execNum" maxlength="10"></td>
								</tr>
								<tr>
									<th class="C" colspan="2">검사지휘승인</th>
									<td class="L">
										<input type="text" id="pstrCmdApprDtCal" name="pstrCmdApprDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" id="pstrCmdApprDtHour" name="pstrCmdApprDtHour" min="0" max="24" step="1" disabled="disabled" class="w15per"/>시
										<input type="number" id="pstrCmdApprDtMin" name="pstrCmdApprDtMin" min="0" max="60" step="5" disabled="disabled" class="w15per"/>분
									</td>
									<th class="C">검사지휘불승인</th>
									<td class="L">
										<input type="text" id="pstrCmdNonApprDtCal" name="pstrCmdNonApprDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" id="pstrCmdNonApprDtHour" name="pstrCmdNonApprDtHour" min="0" max="24" step="1" disabled="disabled" class="w15per"/>시
										<input type="number" id="pstrCmdNonApprDtMin" name="pstrCmdNonApprDtMin" min="0" max="60" step="5" disabled="disabled" class="w15per"/>분
									</td>
								</tr>
								
								
								<tr>
									<th class="C line_right" rowspan="1">구속영장신청</th>
									<th class="C">신청부 번호</th>
									<td class="L">
										<input type="text" id="arstWrntReqBkNum" name="arstWrntReqBkNum" disabled="disabled" class="w100per" maxlength="10"/>
									</td>
									<th class="C">발부연월일</th>
									<td class="L">
										<input type="text" id="arstWrntIsueDt" name="arstWrntIsueDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">비고</th>
									<td class="L" colspan="3">
										<input type="text" id="sjpbEmgyCathBookComn" name="sjpbEmgyCathBookComn" disabled="disabled" class="w100per" maxlength="300"/>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="btnArea">
						<div class="r_btn">
							<a href="javascript:requestReport();" class="btn_white print" id="btnReqPrtEmgyCath"><span>신청서 출력</span></a>
							<a href="javascript:fn_M0106_prnEmgyCathReport();" class="btn_white print" id="btnPrtEmgyCath"><span>대장 출력</span></a>
							<a href="javascript:fn_M0106_insertEmgyCath();" class="btn_light_blue save" style="display:none;" id="btnInsertEmgyCath" data-view-type="inc"><span>저장</span></a>
							<a href="javascript:fn_M0106_updateEmgyCath();" class="btn_light_blue_line appointed" style="display:none;" id="btnUpdateEmgyCath" data-view-type="inc"><span>수정</span></a>			
							
						</div>
					</div>
				</div>
			</li>
		</ul>
		
	</div>
</body>
</html>