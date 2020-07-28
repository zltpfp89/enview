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
<title>통신제한조치집행위탁허가신청부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0117.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" data-view-type="mng">
		<form name="m0117_searchList" id="m0117_searchList" method="post" onkeydown="if(event.keyCode==13) fn_M0117_pageInit()">
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
				<a href="javascript:fn_M_init('m0117_searchList');" class="btn_white reset"><span>초기화</span></a>
				<a href="javascript:fn_M0117_pageInit();" class="btn_light_blue search_01"><span>검색</span></a>
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
			<a href="javascript:fn_M0117_new();" class="btn_light_blue new2" id="btnNew" data-view-type="inc"><span>신규</span></a>
			<a href="javascript:fn_M0117_prnCheckReport();" class="btn_white print" id="btnPrt" data-view-type="mng"><span>출력</span></a>
		</div>
	</div>
	<input type="hidden" name="userId" id="userId" value="${userId}"/>
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 통신제한조치집행위탁허가신청부 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>통신제한조치집행위탁허가신청부 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
	       			<form id="M0117" name="M0117">
	       				<input type="hidden" name="rcptNum" id="rcptNum"/>
	       				<input type="hidden" name="incSpNum" id="incSpNum"/>
	       				<input type="hidden" name="cmctRstrCnsmApprNum" id="cmctRstrCnsmApprNum"/>
	       				<input type="hidden" name="regUserId" id="regUserId"/> 				
		       			<table class="list" cellpadding="0" cellspacing="0">
							<colgroup>
								<col width="10%" />
								<col width="10%" />
			                    <col width="35%" />
			                    <col width="10%" />
			                    <col width="35%" />
							</colgroup>
							<tbody>
								<tr>
									<th class="C" colspan="2">집행번호</th>
									<td class="L"><input type="text" class="w100per" id="cnsmApprExecNum" name="cnsmApprExecNum" maxlength="10"></td>
									<th class="C">허가서번호</th>
									<td class="L">
										<input type="text" id="apprDocNum" name="apprDocNum" class="w100per" disabled="disabled" maxlength="10"/>
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">성명</th>
									<td class="L">
										<p class="searchinput">
				                			<label for="txt_04"></label><input type="text" class="w100per" id="spNm" name="spNm" disabled="disabled" data-always="y" readonly/><a name="spBtn" class="btn_search" id="spBtn" href="javascript:void(0);"><img alt="search" src="/sjpb/images/btn_search.png"></a>	
				                		</p>
									</td>
									<td class="L" colspan="2"></td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="2">통신제한조치</th>
									<th class="C">목적</th>
									<td class="L">
										<input type="text" id="cmctRstrActnPurp" name="cmctRstrActnPurp" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C">대상</th>
									<td class="L">
										<input type="text" id="cmctRstrActnTrgt" name="cmctRstrActnTrgt" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C">종류</th>
									<td class="L">
										<input type="text" id="cmctRstrActnType" name="cmctRstrActnType" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C">기간</th>
									<td class="L">
										<input type="text" id="cmctRstrActnPi" name="cmctRstrActnPi" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="1">집행위탁</th>
									<th class="C">연월일</th>
									<td class="L">
										<input type="text" id="execCnsmDt" name="execCnsmDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C">관서</th>
									<td class="L">
										<input type="text" id="execCnsmOfic" name="execCnsmOfic" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">집행일시</th>
									<td class="L">
										<input type="text" id="execDt" name="execDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<td class="L" colspan="2"></td>
								</tr>
								<tr>
									<th class="C" colspan="2">비고</th>
									<td class="L" colspan="3">
										<textarea id="cnsmApprExecComn" name="cnsmApprExecComn" cols="" rows="" disabled="disabled" maxlength="300"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="btnArea">
						<div class="r_btn" data-view-type="inc">
							<a href="javascript:fn_M0117_insert();" class="btn_light_blue save" style="display:none;" id="btnInsert"><span>저장</span></a>
							<a href="javascript:fn_M0117_update();" class="btn_light_blue_line appointed" style="display:none;" id="btnUpdate"><span>수정</span></a>									
						</div>
					</div>
				</div>
			</li>
		</ul>
		
	</div>
</body>
</html>