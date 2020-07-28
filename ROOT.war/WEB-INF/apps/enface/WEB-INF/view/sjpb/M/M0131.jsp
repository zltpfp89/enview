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
<title>지명수배및통보대장</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0131.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" data-view-type="mng">
		<form name="m0131_searchList" id="m0131_searchList" method="post" onkeydown="if(event.keyCode==13) fn_M0131_pageInit()">
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
				<a href="javascript:fn_M_init('m0131_searchList');" class="btn_white reset"><span>초기화</span></a>
				<a href="javascript:fn_M0131_pageInit();" class="btn_light_blue search_01"><span>검색</span></a>
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
			<a href="javascript:fn_M0131_new();" class="btn_light_blue new2" id="btnNew" data-view-type="inc"><span>신규</span></a>
			<a href="javascript:fn_M0131_prnCheckReport();" class="btn_white print" id="btnPrt" data-view-type="mng"><span>출력</span></a>
		</div>
	</div>
	<input type="hidden" name="userId" id="userId" value="${userId}"/>
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 지명수배및통보대장 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>지명수배 및 통보대장 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
	       			<form id="M0131" name="M0131">
	       				<input type="hidden" name="rcptNum" id="rcptNum"/>
	       				<input type="hidden" name="incSpNum" id="incSpNum"/>
	       				<input type="hidden" name="apptWantNotcNum" id="apptWantNotcNum"/>
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
									<th class="C line_right" rowspan="2">사건송치</th>
									<th class="C">청자</th>
									<td class="L"> 
										<input type="text" id="incTrfReq" name="incTrfReq" disabled="disabled" class="w100per" maxlength="30">
									</td>
									<th class="C">일자</th>
									<td class="L">
										<input type="text" id="incTrfDt" name="incTrfDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C">번호</th>
									<td class="L">
										<input type="text" id="incTrfNum" name="incTrfNum" disabled="disabled" class="w100per" maxlength="10"/>
									</td>
									<td class="L" colspan="2"></td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="2">수배번호</th>
									<th class="C">일자</th>
									<td class="L">
										<input type="text" id="wantDt" name="wantDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C">번호</th>
									<td class="L"><input type="text" id="wantNum" name="wantNum" maxlength="10"/></td>
								</tr>
								<tr>
									<th class="C">공조일자</th>
									<td class="L">
										<input type="text" id="wantCoprDt" name="wantCoprDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C">공조번호</th>
									<td class="L">
										<input type="text" id="wantCoprNum" name="wantCoprNum" class="w100per" disabled="disabled" maxlength="10"/>
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
									<th class="C">연령</th>
									<td class="L" id="age" name="age"></td>
								</tr>
								<tr>
									<th class="C">성별</th>
									<td class="L" id="gendDivDesc" name="gendDivDesc"></td>
									<th class="C">주민등록번호</th>
									<td class="L" id="spIdNum" name="spIdNum"></td>
								</tr>
								<tr>
									<th class="C" colspan="2">죄명</th>
									<td class="L">
										<input type="text" id="criNm" name="criNm" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C">공소시효만료일자</th>
									<td class="L">
										<input type="text" id="idctPiDt" name="idctPiDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C line_right">연고지 수사상황</th>
									<th class="C">등록기준지 또는 주소</th>
									<td class="L">
										<input type="text" id="homtAddr" name="homtAddr" disabled="disabled" class="w100per" maxlength="30"/>
									</td>
									<th class="C">회보내용</th>
									<td class="L">
										<input type="text" id="homtBulnCont" name="homtBulnCont" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="2">수배해제</th>
									<th class="C">사유</th>
									<td class="L">
										<input type="text" id="wantRelsRsn" name="wantRelsRsn" disabled="disabled" class="w100per" maxlength="150"/>
									</td>
									<th class="C">일자</th>
									<td class="L">
										<input type="text" id="wantRelsDt" name="wantRelsDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C">번호</th>
									<td class="L">
										<input type="text" id="wantRelsNum" name="wantRelsNum" disabled="disabled" class="w100per" maxlength="10"/>
									</td>
									<td class="L" colspan="2"></td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="btnArea">
						<div class="r_btn" data-view-type="inc">
							<a href="javascript:fn_M0131_insert();" class="btn_light_blue save" style="display:none;" id="btnInsert"><span>저장</span></a>
							<a href="javascript:fn_M0131_update();" class="btn_light_blue_line appointed" style="display:none;" id="btnUpdate"><span>수정</span></a>									
						</div>
					</div>
				</div>
			</li>
		</ul>
		
	</div>
</body>
</html>