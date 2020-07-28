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
<title>현행범인체포원부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0107.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" data-view-type="mng">	<%-- 2018.11.19 추가 data-view-type--%>
		<form name="m0107_searchList" id="m0107_searchList" method="post" onkeydown="if(event.keyCode==13) fn_M0107_pageInit()">
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
				<a href="javascript:fn_M_init('m0107_searchList');" class="btn_white reset"><span>초기화</span></a>
				<a href="javascript:fn_M0107_pageInit();" class="btn_light_blue search_01"><span>검색</span></a>
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
			<a href="javascript:fn_M0107_newFlgtOfdrCath();" class="btn_light_blue new2" id="btnNewFlgtOfdrCath" data-view-type="inc"><span>신규</span></a>	<%-- 2018.11.19 추가 data-view-type--%>
			<a href="javascript:fn_M0107_prnCheckReport();" class="btn_white print" id="btnPrtFlgtOfdrCath" data-view-type="mng"><span>대장 출력</span></a>	<%-- 2018.11.19 추가 data-view-type--%>
		</div>
	</div>
	<input type="hidden" name="userId" id="userId" value="${userId}"/>
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 현행범인체포원부 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>현행범인체포원부 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
	       			<form id="M0107FlgtOfdrCath" name="M0107FlgtOfdrCath">
	       				<input type="hidden" name="rcptNum" id="rcptNum"/>
	       				<input type="hidden" name="incSpNum" id="incSpNum"/>
	       				<input type="hidden" name="flgtOfdrCathBookNum" id="flgtOfdrCathBookNum"/>
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
	                                <th class="C th_line" colspan="3">작성문서 유형 선택</th>
	                                <td class="L td_line">
	                                    <div class="inputbox w100per">
	                                        <p class="txt"></p>
	                                        <select id="docType" name="docType">
	                                            <option value="">선택</option>
	                                            <option value="현행범인체포서">현행범인체포서</option>
	                                            <option value="현행범인인수서">현행범인인수서</option>
	                                        </select>
	                                    </div>
	                                </td>
									<th class="C">사건번호</th>
									<td class="L">
										<span name="incNum" id="incNum"></span>
									</td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="2">피의자</th>
									<th class="C" colspan="2">성명</th>
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
									<th class="C" colspan="2">직업</th>
									<td class="L">
										<span id="spJob" name="spJob"></span>
									</td>
									<th class="C">주거</th>
									<td class="L">
										<span id="spAddr" name="spAddr"></span>
									</td>
								</tr>
								<tr>
	                                <th class="C th_line" colspan="3">변호인</th>
	                                <td class="L td_line" colspan="3"><label for="attoNm"><input type="text" class="w100per" id="attoNm" name="attoNm" maxlength="10"></label></td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line" colspan="3">범죄사실 및 체포의 사유</th>
	                                <td class="L td_line" colspan="3"><label for="crimAndArrsResn"><input type="text" class="w100per" id="crimAndArrsResn" name="crimAndArrsResn" maxlength="100"></label></td>
	                            </tr>
								<tr>
									<th class="C" colspan="3">죄명</th>
									<td class="L" id="rltActCriNmCdDesc" name="rltActCriNmCdDesc"></td>
									<td class="L td_line" colspan="2"></td>
								</tr>
								<tr>
									<th class="C" colspan="3">현행범인체포서 또는 현행범인인수서 작성일</th>
									<td class="L">
										<input type="text" id="flgtOfdrCathDocFillDt" name="flgtOfdrCathDocFillDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<td class="L td_line" colspan="2"></td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="6">현행범인체포 및 인수</th>
									<th class="C" colspan="2">체포한 일시</th>
									<td class="L">
										<input type="text" id="cathDtCal" name="cathDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" id="cathDtHour" name="cathDtHour" min="0" max="24" step="1" disabled="disabled" class="w15per"/>시
										<input type="number" id="cathDtMin" name="cathDtMin" min="0" max="60" step="5" disabled="disabled" class="w15per"/>분
									</td>
									<th class="C">체포한 장소</th>
									<td class="L">
										<input type="text" name="cathPla" id="cathPla" disabled="disabled" class="w100per" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="2">체포자</th>
									<th class="C">성명</th>
									<td class="L">
										<input type="text" name="cathPersNm" id="cathPersNm" disabled="disabled" class="w100per" maxlength="30"/>
									</td>
									<th class="C">주민등록번호</th>
									<td class="L">
										<input type="text" name="cathPersSsn" id="cathPersSsn" disabled="disabled" class="w100per" maxlength="15"/>
									</td>
								</tr>
								<tr>
									<th class="C">주거</th>
									<td class="L">
										<input type="text" name="cathPersAddr" id="cathPersAddr" disabled="disabled" class="w100per" maxlength="30"/>
									</td>
									<th class="C">관직</th>
									<td class="L">
										<input type="text" name="cathPersTitl" id="cathPersTitl" disabled="disabled" class="w100per" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">인수한 일시</th>
									<td class="L">
										<input type="text" id="acqsDtCal" name="cstdDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" id="acqsDtHour" name="cstdDtHour" min="0" max="24" step="1" disabled="disabled" class="w15per"/>시
										<input type="number" id="acqsDtMin" name="cstdDtMin" min="0" max="60" step="5" disabled="disabled" class="w15per"/>분
									</td>
									<th class="C">인수한 장소</th>
									<td class="L">
										<input type="text" name="acqsPla" id="acqsPla" disabled="disabled"  class="w100per" maxlength="30"/>
									</td>
								</tr>
								
								<tr>
									<th class="C" colspan="2">인치한 일시</th>
									<td class="L">
										<input type="text" id="cstdDtCal" name="cstdDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" id="cstdDtHour" name="cstdDtHour" min="0" max="24" step="1" disabled="disabled" class="w15per"/>시
										<input type="number" id="cstdDtMin" name="cstdDtMin" min="0" max="60" step="5" disabled="disabled" class="w15per"/>분
									</td>
									<th class="C">인치한 장소</th>
									<td class="L">
										<input type="text" name="cstdPla" id="cstdPla" disabled="disabled" class="w100per" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">구금한 일시</th>
									<td class="L">
										<input type="text" id="detnDtCal" name="detnDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" id="detnDtHour" name="detnDtHour" min="0" max="24" step="1" class="w15per" disabled="disabled"/>시
										<input type="number" id="detnDtMin" name="detnDtMin" min="0" max="60" step="5" class="w15per" disabled="disabled"/>분
									</td>
									<th class="C">구금한 장소</th>
									<td class="L">
										<input type="text" name="detnPla" id="detnPla" disabled="disabled" class="w100per" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C" colspan="3">석방일시</th>
									<td class="L">
										<input type="text" id="relsDtCal" name="relsDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" id="relsDtHour" name="relsDtHour" min="0" max="24" step="1" disabled="disabled" class="w15per"/>시
										<input type="number" id="relsDtMin" name="relsDtMin" min="0" max="60" step="5" disabled="disabled" class="w15per"/>분
									</td>
									<th class="C">석방사유</th>
									<td class="L">
										<input type="text" id="relsRsn" name="relsRsn" disabled="disabled" class="w100per" maxlength="30"/>
									</td>
								</tr>
							</tbody>
							<tbody id="afterDiv">
								<tr>
									<th class="C" colspan="3">집행번호</th>
									<td class="L" colspan="3"><input type="text" id="execNum" name="execNum" maxlength="10"/></td>
								<tr>
									<th class="C line_right" rowspan="1">구속영장신청</th>
									<th class="C" colspan="2">신청부 번호</th>
									<td class="L">
										<input type="text" id="arstWrntReqBkNum" name="arstWrntReqBkNum" disabled="disabled" class="w100per" maxlength="10"/>
									</td>
									<th class="C">연월일</th>
									<td class="L">
										<input type="text" id="arstWrntReqIsueDt" name="arstWrntReqIsueDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="1">인수한자</th>
									<th class="C" colspan="2">관직</th>
									<td class="L">
										<input type="text" name="acqsPersTitl" id="acqsPersTitl" disabled="disabled" class="w100per" maxlength="30"/>
									</td>
									<th class="C">성명</th>
									<td class="L">
										<input type="text" name="acqsPersNm" id="acqsPersNm" disabled="disabled" class="w100per" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C" colspan="3">비고</th>
									<td class="L" colspan="3">
										<input type="text" id="flgtOfdrCathBookComn" name="flgtOfdrCathBookComn" disabled="disabled"  class="w100per" maxlength="30"/>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="btnArea">
						<div class="r_btn"> <%-- 2018.11.19 추가 data-view-type--%>
							<a href="javascript:requestReport();" class="btn_white print" style="display:none;" id="btnReqprnReport"><span>신청서 출력</span></a>	
							<a href="javascript:fn_M0107_prnReport();" class="btn_white print" style="display:none;" id="btnprnReport"><span>대장 출력</span></a>	
							<a href="javascript:fn_M0107_insertFlgtOfdrCath();" class="btn_light_blue save" style="display:none;" id="btnInsertFlgtOfdrCath" data-view-type="inc"><span>저장</span></a>
							<a href="javascript:fn_M0107_updateFlgtOfdrCath();" class="btn_light_blue_line appointed" style="display:none;" id="btnUpdateFlgtOfdrCath" data-view-type="inc"><span>수정</span></a>			
									
						</div>
					</div>
				</div>
			</li>
		</ul>
		
	</div>
</body>
</html>