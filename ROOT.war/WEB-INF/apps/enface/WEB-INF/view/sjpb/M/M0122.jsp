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
<title>통신사실 확인자료제공 요청허가신청부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0122.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" data-view-type="mng">
		<form name="m0122_searchList" id="m0122_searchList" method="post" onkeydown="if(event.keyCode==13) fn_M0122_pageInit()">
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
				<a href="javascript:fn_M_init('m0122_searchList');" class="btn_white reset"><span>초기화</span></a>
				<a href="javascript:fn_M0122_pageInit();" class="btn_light_blue search_01"><span>검색</span></a>
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
			<a href="javascript:fn_M0122_new();" class="btn_light_blue new2" id="btnNewArstWrnt" data-view-type="inc"><span>신규</span></a>
			<a href="javascript:fn_M0122_prnCheckReport();" class="btn_white print" id="btnprtCheck" data-view-type="mng"><span>출력</span></a>
		</div>
	</div>
	<input type="hidden" name="userId" id="userId" value="${userId}"/>
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 통신사실 확인자료제공 요청허가신청부 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>통신사실 확인자료제공 요청허가신청부 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
	       			<form id="M0122" name="M0122">
	       				<input type="hidden" name="rcptNum" id="rcptNum"/>
	       				<input type="hidden" name="incSpNum" id="incSpNum"/>
	       				<input type="hidden" name="cmctCnfmReqApprNum" id="cmctCnfmReqApprNum"/>
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
									<td class="L"><input type="text" id="docNum" name="docNum" maxlength="10"/></td>
									<th class="C">사건번호</th>
									<td class="L">
										<span id="incNum" name="incNum"></span>	
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
									<th class="C" >주거</th>
									<td class="L" id="spAddr" name="spAddr""></td>
								</tr>
								<tr>
									<th class="C" colspan="2">죄명</th>
									<td class="L" colspan="3" id="rltActCriNmCdDesc" name="rltActCriNmCdDesc"></td>
								</tr>
								<tr>
	                                <th class="C th_line" colspan="2">전기통신사업자</th>
	                                <td class="L" colspan="3"><label for="teleOprt"><input type="text" class="w100per" id="teleOprt" name="teleOprt" maxlength="30" /></label></td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line" colspan="2">요청사유</th>
	                                <td class="L" colspan="3"><label for="reqResn"><input type="text" class="w100per" id="reqResn" name="reqResn" maxlength="30" /></label></td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line" colspan="2">해당가입자와의 연관성</th>
	                                <td class="L" colspan="3"><label for="subsConn"><input type="text" class="w100per" id="subsConn" name="subsConn" maxlength="30" /></label></td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line" colspan="2">필요한 자료의 범위</th>
	                                <td class="L" colspan="3"><label for="requMatr"><input type="text" class="w100per" id="requMatr" name="requMatr" maxlength="30" /></label></td>
	                            </tr>
	                            <tr>
	                                <th class="C th_line" colspan="2">재청구의 취지 및 이유</th>
	                                <td class="L" colspan="3"><label for="reClamResn"><input type="text" class="w100per" id="reClamResn" name="reClamResn" maxlength="30" /></label></td>
	                            </tr>
                            </tbody>
                            <tbody id="afterDiv">
                            	<tr>
									<th class="C" colspan="2">진행번호</th>
									<td class="L" colspan="3"><input type="text" id="prgsNum" name="prgsNum" maxlength="10"/></td>
								</tr>
								<tr>
									<th class="C" colspan="2">긴급으로 자료를 제공받은 일시</th>
									<td class="L">
										<input type="text" id="emgyDtaSupyDt" name="emgyDtaSupyDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C">종류</th>
									<td class="L">
										<input type="text" id=cmctCnfmType name="cmctCnfmType" class="w100per" disabled="disabled" maxlength="30"/>	
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">대상</th>
									<td class="L">
										<input type="text" id="cmctCnfmTrgt" name="cmctCnfmTrgt" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C">범위</th>
									<td class="L">
										<input type="text" id="cmctCnfmRnge" name="cmctCnfmRnge" class="w100per" disabled="disabled" maxlength="30"/>	
									</td>
								</tr>
								
								<tr>
									<th class="C line_right" rowspan="5">신청및 발부일시</th>
									<th class="C">구분</th>
									<td class="L">허가</td>
									<td class="L" colspan="2"></td>
								</tr>
								<tr>
									<th class="C">신청</th>
									<td class="L">
										<input type="text" id="reqDt" name="reqDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C">발부</th>
									<td class="L">
										<input type="text" id="isueDt" name="isueDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C">기각</th>
									<td class="L">
										<input type="text" id="rjctDt" name="rjctDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<td class="L" colspan="2"></td>
								</tr>
								<tr>
									<th class="C">재신청</th>
									<td class="L">
										<input type="text" id="reReqDt" name="reReqDt" disabled="disabled" class="w100per calendar datepicker" readonly/>	
									</td>
									<th class="C">재신청발부</th>
									<td class="L">
										<input type="text" id="reReqIsueDt" name="reReqIsueDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C">재신청기각</th>
									<td class="L">
										<input type="text" id="reReqRjctDt" name="reReqRjctDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<td class="L" colspan="2"></td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="2">수령 및 반환</th>
									<th class="C">수령연월일</th>
									<td class="L">
										<input type="text" id="rcptDt" name="rcptDt" disabled="disabled" class="w100per calendar datepicker" readonly />
									</td>
									<th class="C">검찰반환연월일</th>
									<td class="L">
										<input type="text" id="poRetnDt" name="poRetnDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C">수령자의 관직</th>
									<td class="L">
										<input type="text" id="rcptPersTitl" name="rcptPersTitl" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C">수령자의 이름</th>
									<td class="L">
										<input type="text" id="rcptPersNm" name="rcptPersNm" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">비고</th>
									<td class="L" colspan="3">
										<input type="text" id="cmctCnfmComn" name="cmctCnfmComn" class="w100per" disabled="disabled" maxlength="300"/>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="btnArea">
						<div class="r_btn">
							<a href="javascript:requestReport();" class="btn_white print" id="btnReqPrtArstWrnt"><span>신청서 출력</span></a>
							<a href="javascript:fn_M0122_prtReport();" class="btn_white print" id="btnPrtArstWrnt"><span>대장 출력</span></a>
							<a href="javascript:fn_M0122_insert();" class="btn_light_blue save" style="display:none;" id="btnInsert" data-view-type="inc"><span>저장</span></a>
							<a href="javascript:fn_M0122_update();" class="btn_light_blue_line appointed" style="display:none;" id="btnUpdate" data-view-type="inc"><span>수정</span></a>
						</div>
					</div>
				</div>
			</li>
		</ul>
		
	</div>
</body>
</html>