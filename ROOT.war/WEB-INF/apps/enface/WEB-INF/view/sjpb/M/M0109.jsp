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
<title>압수·수색·검증영장신청부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0109.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" data-view-type="mng">
		<form name="m0109_searchList" id="m0109_searchList" method="post" onkeydown="if(event.keyCode==13) fn_M0109_pageInit()">
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
				<a href="javascript:fn_M_init('m0109_searchList');" class="btn_white reset"><span>초기화</span></a>
				<a href="javascript:fn_M0109_pageInit();" class="btn_light_blue search_01"><span>검색</span></a>
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
			<a href="javascript:fn_M0109_newSeizSech();" class="btn_light_blue new2" id="btnNewSeizSech" data-view-type="inc"><span>신규</span></a>
			<a href="javascript:fn_M0109_prnCheckReport();" class="btn_white print" id="btnPrtSeizSech" data-view-type="mng"><span>출력</span></a>
		</div>
	</div>
	<input type="hidden" name="userId" id="userId" value="${userId}"/>
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 압수·수색·검증영장신청부 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>압수·수색·검증영장신청부 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
	       			<form id="M0109SeizSech" name="M0109SeizSech">
	       				<input type="hidden" name="rcptNum" id="rcptNum"/>
	       				<input type="hidden" name="incSpNum" id="incSpNum"/>
	       				<input type="hidden" name="seizSechWrntReqNum" id="seizSechWrntReqNum"/>
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
									<th class="C" colspan="2">문서번호</th>
									<td class="L" colspan="3">
										<input type="text" id="docNum" name="docNum" class="w100per" maxlength="10" />
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">사건번호</th>
									<td class="L">
										<span id="incNum" name="incNum"></span>
									</td>
									<th class="C">신청연월일</th>
									<td class="L">
										<input type="text" id="reqDt" name="reqDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">신청자 관직</th>
									<td class="L">
										<input type="text" id="reqPersTitl" name="reqPersTitl" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C">신청자 성명</th>
									<td class="L">
										<input type="text" id="reqPersNm" name="reqPersNm" class="w100per" disabled="disabled" maxlength="10" />
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
									<td class="L" id="spIdNum" name="spIdNum"></td>
								</tr>
								<tr>
									<th class="C">직업</th>
									<td class="L" id="spJob" name="spJob"></td>
									<th class="C">주거</th>
									<td class="L"id="spAddr" name="spAddr"></td>
								</tr>
								<tr>
									<th class="C" colspan="2">죄명</th>
									<td class="L" id="rltActCriNmCdDesc" name="rltActCriNmCdDesc"></td>
									<td class="L" colspan="2"></td>
								</tr>
								<tr>
	                                <th class="C" colspan="2">변호인</th>
	                                <td class="L"><label for="attoNm"><input type="text" class="w100per" id="attoNm" name="attoNm"  maxlength="10"/></label></td>
	                                <th class="C">압수할 물건</th>
	                                <td class="L"><label for="seizObj"><input type="text" class="w100per" id="seizObj" name="seizObj" maxlength="30" /></label></td>
	                            </tr>
	                            <tr>
	                                <th class="C" colspan="2">수색 검증할 장소, 신체 또는 물건</th>
	                                <td class="L" colspan="3"><label for="sechPlaBodyObj"><input type="text" class="w100per" id="sechPlaBodyObj" name="sechPlaBodyObj" maxlength="100" /></label></td>
	                            </tr>
	                            <tr>
	                                <th class="C" colspan="2">7일을 넘는 유효기간을 필요로 하는 취지와 사유</th>
	                                <td class="L" colspan="3"><label for="overWeekResn"><input type="text" class="w100per" id="overWeekResn" name="overWeekResn" maxlength="100" /></label></td>
	                            </tr>
	                            <tr>
	                                <th class="C" colspan="2">둘 이상의 영장을 신청하는 취지와 사유</th>
	                                <td class="L" colspan="3"><label for="overTwoPersRes"><input type="text" class="w100per" id="overTwoPersRes" name="overTwoPersRes" maxlength="100" /></label></td>
	                            </tr>
	                            <tr>
	                                <th class="C" colspan="2">일출 전 또는 일몰 후 집행을 필요로 하는 취지와 사유</th>
	                                <td class="L" colspan="3"><label for="midNightExecResn"><input type="text" class="w100per" id="midNightExecResn" name="midNightExecResn" maxlength="100" /></label></td>
	                            </tr>
	                            <tr>
	                                <th class="C" colspan="2">신체검사를 받을 자의 성별, 건강상태</th>
	                                <td class="L" colspan="3"><label for="persGendAndHealth"><input type="text" class="w100per" id="persGendAndHealth" name="persGendAndHealth" maxlength="100" /></label></td>
	                            </tr>
	                        </tbody>
	                        <tbody id="afterDiv">
								<tr>
									<th class="C" colspan="2">진행번호</th>
									<td class="L"><input type="text" class="w100per" id="prgsNum" name="prgsNum" maxlength="10"/></td>
									<td class="L" colspan="2"></td>
								</tr>
								<tr>
									<th class="C" colspan="2">검사기각</th>
									<td class="L">
										<input type="text" id="pstrRjctDt" name="pstrRjctDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C">판사기각</th>
									<td class="L">
										<input type="text" id="judgRjctDt" name="judgRjctDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">발부</th>
									<td class="L">
										<input type="text" id="seizSechIsue" name="seizSechIsue" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C">유효기간</th>
									<td class="L">
										<input type="text" id="valdPi" name="valdPi" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="2">집행</th>
									<th class="C">일시</th>
									<td class="L">
										<input type="text" id="execDt" name="execDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C">장소</th>
									<td class="L">
										<input type="text" id="execPla" name="execPla" class="w100per" disabled="disabled"/>
									</td>
								</tr>
								<tr>
									<th class="C">처리결과</th>
									<td class="L">
										<input type="text" id="execHandRst" name="execHandRst" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<td class="L" colspan="2"></td>
								</tr>
								<tr>
									<th class="C" colspan="2">비고</th>
									<td class="L" colspan="3">
										<input type="text" id="seizSechComn" name="seizSechComn" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="btnArea">
						<div class="r_btn">
							<a href="javascript:requestReport();" class="btn_white print" style="display:none;" id="btnReqPrnReport"><span>신청서 출력</span></a>
							<a href="javascript:fn_M0109_prnReport();" class="btn_white print" style="display:none;" id="btnPrnReport"><span>수사대장 출력</span></a>									
							<a href="javascript:fn_M0109_insertSeizSech();" class="btn_light_blue save" style="display:none;" id="btnInsertSeizSech" data-view-type="inc"><span>저장</span></a>
							<a href="javascript:fn_M0109_updateSeizSech();" class="btn_light_blue_line appointed" style="display:none;" id="btnUpdateSeizSech" data-view-type="inc"><span>수정</span></a>																							
						</div>
					</div>
				</div>
			</li>
		</ul>
		
	</div>
</body>
</html>