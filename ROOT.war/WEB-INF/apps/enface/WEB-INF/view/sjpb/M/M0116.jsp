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
<title>통신제한조치허가신청부서식</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0116.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" data-view-type="mng">
		<form name="m0116_searchList" id="m0116_searchList" method="post" onkeydown="if(event.keyCode==13) fn_M0116_pageInit()">
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
				<a href="javascript:fn_M_init('m0116_searchList');" class="btn_white reset"><span>초기화</span></a>
				<a href="javascript:fn_M0116_pageInit();" class="btn_light_blue search_01"><span>검색</span></a>
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
			<a href="javascript:fn_M0116_new();" class="btn_light_blue new2" id="btnNew" data-view-type="inc"><span>신규</span></a>
			<a href="javascript:fn_M0116_prnCheckReport();" class="btn_white print" id="btnPrt" data-view-type="mng"><span>출력</span></a>
		</div>
	</div>
	<input type="hidden" name="userId" id="userId" value="${userId}"/>
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 통신제한조치허가신청부서식 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>통신제한조치허가신청부서식 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
	       			<form id="M0116" name="M0116">
	       				<input type="hidden" name="rcptNum" id="rcptNum"/>
	       				<input type="hidden" name="incSpNum" id="incSpNum"/>
	       				<input type="hidden" name="cmctRstrApprReqNum" id="cmctRstrApprReqNum"/>
	       				<input type="hidden" name="regUserId" id="regUserId"/> 				
		       			<table class="list" cellpadding="0" cellspacing="0">
							<colgroup>
								<col width="10%"/>
								<col width="15%"/>
								<col width="40%"/>
								<col width="10%"/>
								<col width="30%"/>
							</colgroup>
							<tbody>
								<tr>
									<th class="C" colspan="2">진행번호</th>
									<td class="L"><input type="text" id="prgsNum" name="prgsNum" class="w100per" maxlength="10"></td>
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
									<th class="C">주거</th>
									<td class="L" id="spAddr" name="spAddr"></td>
									<th class="C">직업</th>
									<td class="L" id="spJob" name="spJob"></td>
								</tr>
								<tr>
									<th class="C" colspan="2">죄명</th>
									<td class="L" colspan="3" id="rltActCriNmCdDesc" name="rltActCriNmCdDesc" ></td>
								</tr>
								<tr>
									<th class="C" colspan="2">종류</th>
									<td class="L">
										<input type="text" id="cmctRstrType" name="cmctRstrType" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C">방법</th>
									<td class="L">
										<input type="text" id="cmctRstrWay" name="cmctRstrWay" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">처분대상</th>
									<td class="L">
										<input type="text" id="dipTrgt" name="dipTrgt" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C">처분범위</th>
									<td class="L">
										<input type="text" id="dipRnge" name="dipRnge" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">긴급통신제한조치일자</th>
									<td class="L">
										<input type="text" id="rstrActnDt" name="rstrActnDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<td class="L" colspan="2"></td>
								</tr>
								<tr>
									<th class="C" colspan="2">허가기간</th>
									<td class="L">
										<input type="text" id="apprPi" name="apprPi" class="w100per" disabled="disabled"/>
									</td>
									<th class="C">집행장소</th>
									<td class="L">
										<input type="text" id="execPla" name="execPla" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">연장기간</th>
									<td class="L" colspan="3">
										<input type="text" id="extsPiBeDt" name="extsPiBeDt" class="w45per calendar datepicker" readonly disabled="disabled"/>~
										<input type="text" id="extsPiEdDt" name="extsPiEdDt" class="w45per calendar datepicker" readonly disabled="disabled"/>
									</td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="10">허가신청 및 발부</th>
									<th class="C line_right">구분</th>
									<th class="C line_right">허가신청</th>
									<th class="C" colspan="2">연장신청</th>
								<tr>
									<th class="C">신청</th>
									<td class="L line_right">
										<input type="text" id="reqApprReqDt" name="reqApprReqDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<td class="L" colspan="2">
										<input type="text" id="reqExtsReqDt" name="reqExtsReqDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C">발부</th>
									<td class="L">
										<input type="text" id="isueApprReqDt" name="isueApprReqDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<td class="L" colspan="2">
										<input type="text" id="isueExtsReqDt" name="isueExtsReqDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C">기각</th>
									<td class="L">
										<input type="text" id="rjctApprReqDt" name="rjctApprReqDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<td class="L" colspan="2">
										<input type="text" id="rjctExtsReqDt" name="rjctExtsReqDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C">재신청</th>
									<td class="L">
										<input type="text" id="reReqApprReqDt" name="reReqApprReqDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<td class="L" colspan="2">
										<input type="text" id="reReqExtsReqDt" name="reReqExtsReqDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C">발부</th>
									<td class="L">
										<input type="text" id="reReqIsueApprReqDt" name="reReqIsueApprReqDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<td class="L" colspan="2">
										<input type="text" id="reReqIsueExtsReqDt" name="reReqIsueExtsReqDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C">기각</th>
									<td class="L">
										<input type="text" id="reReqRjctApprReqDt" name="reReqRjctApprReqDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<td class="L" colspan="2">
										<input type="text" id="reReqRjctExtsReqDt" name="reReqRjctExtsReqDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C">수령연월일</th>
									<td class="L">
										<input type="text" id="apprRcptDt" name="apprRcptDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<td class="L" colspan="2">
										<input type="text" id="extsRcptDt" name="extsRcptDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C">수령자 관직</th>
									<td class="L">
										<input type="text" id="apprRcptPersTitl" name="apprRcptPersTitl" disabled="disabled" class="w100per" maxlength="30" />
									</td>
									<td class="L" colspan="2">
										<input type="text" id="extsRcptPersTitl" name="extsRcptPersTitl" disabled="disabled" class="w100per"  maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C">수령자 성명</th>
									<td class="L">
										<input type="text" id="apprRcptPersNm" name="apprRcptPersNm" disabled="disabled" class="w100per" maxlength="30" />
									</td>
									<td class="L" colspan="2">
										<input type="text" id="extsRcptPersNm" name="extsRcptPersNm" disabled="disabled" class="w100per" maxlength="30" />
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">검찰반환연월일</th>
									<td class="L" colspan="3">
										<input type="text" id="poRetnDt" name="poRetnDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">비고</th>
									<td class="L" colspan="3">
										<textarea id="cmctRstrComn" name="cmctRstrComn" cols="" rows="" disabled="disabled" maxlength="300"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="btnArea">
						<div class="r_btn" data-view-type="inc">
							<a href="javascript:fn_M0116_insert();" class="btn_light_blue save" style="display:none;" id="btnInsert"><span>저장</span></a>
							<a href="javascript:fn_M0116_update();" class="btn_light_blue_line appointed" style="display:none;" id="btnUpdate"><span>수정</span></a>									
						</div>
					</div>
				</div>
			</li>
		</ul>
		
	</div>
</body>
</html>