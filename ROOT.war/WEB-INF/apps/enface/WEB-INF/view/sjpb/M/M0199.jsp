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
<title>진정사건부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0199.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" data-view-type="mng">
		<form name="m0199_searchList" id="m0199_searchList" method="post" onkeydown="if(event.keyCode==13) fn_M0199_pageInit()">
			<ul>		   
				<li><span class="title">진정인명</span>
					<label for="spNmSc"></label><input type="text" class="w65per" name="spNmSc"/>
				</li>
				<li><span class="title">피진정인명</span>
					<label for="spPtinNmSc"></label><input type="text" class="w65per" name="spPtinNmSc"/>
				</li>
				<li><span class="title">등록일자</span>
					<label for="regStart"></label><input type="text" id="regStart" name="regStart" class="w30per calendar datepicker" readonly/>~
					<label for="regEnd"></label><input type="text" id="regEnd" name="regEnd" class="w30per calendar datepicker" readonly/>
				</li>
			</ul>
			<div class="searchbtn">
				<a href="javascript:fn_M_init('m0199_searchList');" class="btn_white reset"><span>초기화</span></a>
				<a href="javascript:fn_M0199_pageInit();" class="btn_light_blue search_01"><span>검색</span></a>
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
	</form>
	<!-- //report -->
	
	<!-- btnArea -->
	<div class="btnArea">
		<div class="r_btn">
			<a href="javascript:fn_M0199_new();" class="btn_light_blue new2" id="btnNew" data-view-type="inc"><span>신규</span></a>
			<a href="javascript:fn_M0199_prnCheckReport();" class="btn_white print" id="btnPrt" data-view-type="mng"><span>출력</span></a>
		</div>
	</div>
	<input type="hidden" name="userId" id="userId" value="${userId}"/>
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 진정사건부 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>진정사건부 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
	       			<form id="M0199" name="M0199">
	       				<input type="hidden" name="rcptNum" id="rcptNum"/>
	       				<input type="hidden" name="incSpNum" id="incSpNum"/>
	       				<input type="hidden" name="ptinIncBkNum" id="ptinIncBkNum"/>
	       				<input type="hidden" name="regUserId" id="regUserId"/> 				
		       			<table class="list" cellpadding="0" cellspacing="0">
							<colgroup>
								<col width="10%"/>
								<col width="15%"/>
								<col width="30%"/>
								<col width="15%"/>
								<col width="30%"/>
							</colgroup>
							<tbody>
								<tr>
									<th class="C" colspan="2">진행번호</th>
									<td class="L" id="prgsNum" name="prgsNum"></td>
									<td class="L" colspan="2"></td>
								</tr>
								<tr>
									<th class="C" colspan="2">수리</th>
									<td class="L">
										<input type="text" id="rcptDt" name="rcptDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C">주임검사</th>
									<td class="L">
										<input type="text" id="chifPstr" name="chifPstr" class="w100per" disabled="disabled"/>
									</td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="1">진정인</th>
									<th class="C">성명</th>
									<td class="L">
										<input type="text" id="ptinNm" name="ptinNm" class="w100per" disabled="disabled">
									</td>
									<th class="C">주거</th>
									<td class="L">
										<input type="text" id="ptinAddr" name="ptinAddr" class="w100per" disabled="disabled">
									</td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="2">피진정인</th>
									<th class="C">성명</th>
									<td class="L">
										<input type="text" id="spPtinNm" name="spPtinNm" class="w100per" disabled="disabled">
									</td>
									<th class="C">주민등록번호</th>
									<td class="L">
										<input type="text" id="spPtinIdNum_A" name="spPtinIdNum_A" class="w45per" maxlength="6" disabled="disabled">-<input type="text" id="spPtinIdNum_B" name="spPtinIdNum_B" class="w45per" maxlength="7" disabled="disabled">
									</td>
								</tr>
								<tr>
									<th class="C">주거</th>
									<td class="L">
										<input type="text" id="spPtinAddr" name="spPtinAddr" class="w100per" disabled="disabled"/>
									</td>
									<th class="C">직업</th>
									<td class="L">
										<input type="text" id="spPtinJob" name="spPtinJob" class="w100per" disabled="disabled"/>
									</td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="2">진정사건지휘</th>
									<th class="C">연월일</th>
									<td class="L">
										<input type="text" id="incCmdDt" name="incCmdDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C">관서</th>
									<td class="L">
										<input type="text" id="incCmdOfic" name="incCmdOfic" class="w100per" disabled="disabled"/>
									</td>
								</tr>
								<tr>
									<th class="C">보고기한</th>
									<td class="L">
										<input type="text" id="incCmdReptPi" name="incCmdReptPi" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C">보고연월일</th>
									<td class="L">
										<input type="text" id="incCmdReptDt" name="incCmdReptDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="1">종결</th>
									<th class="C">연월일</th>
									<td class="L">
										<input type="text" id="edDt" name="edDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C">주문</th>
									<td class="L">
										<input type="text" id="edSpll" name="edSpll" class="w100per" disabled="disabled"/>
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">진정인결과통지</th>
									<td class="L">
										<input type="text" id="ptinRstNotcDt" name="ptinRstNotcDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<td class="L" colspan="2"></td>
								</tr>
								<tr>
									<th class="C" colspan="2">비고</th>
									<td class="L" colspan="3">
										<textarea id="ptinComn" name="ptinComn" cols="" rows="" disabled="disabled"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="btnArea">
						<div class="r_btn" data-view-type="inc">
							<a href="javascript:fn_M0199_insert();" class="btn_light_blue save" style="display:none;" id="btnInsert"><span>저장</span></a>
							<a href="javascript:fn_M0199_update();" class="btn_light_blue_line appointed" style="display:none;" id="btnUpdate"><span>수정</span></a>									
						</div>
					</div>
				</div>
			</li>
		</ul>
		
	</div>
</body>
</html>