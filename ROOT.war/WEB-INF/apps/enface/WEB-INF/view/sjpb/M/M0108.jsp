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
<title>피의자소재발견처리부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0108.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" data-view-type="mng">
		<form name="m0108_searchList" id="m0108_searchList" method="post" onkeydown="if(event.keyCode==13) fn_M0108_pageInit()">
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
				<a href="javascript:fn_M_init('m0108_searchList');" class="btn_white reset"><span>초기화</span></a>
				<a href="javascript:fn_M0108_pageInit();" class="btn_light_blue search_01"><span>검색</span></a>
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
			<a href="javascript:fn_M0108_newSpWhab();" class="btn_light_blue new2" id="btnNewSpWhab" data-view-type="inc"><span>신규</span></a>
			<a href="javascript:fn_M0108_prnCheckReport();" class="btn_white print" id="btnPrtSpWhab" data-view-type="mng"><span>출력</span></a>
		</div>
	</div>
	<input type="hidden" name="userId" id="userId" value="${userId}"/>
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 피의자소재발견처리부 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>피의자소재발견처리부 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
	       			<form id="M0108SpWhab" name="M0108SpWhab">
	       				<input type="hidden" name="rcptNum" id="rcptNum"/>
	       				<input type="hidden" name="incSpNum" id="incSpNum"/>
	       				<input type="hidden" name="spWhabDvHandBkNum" id="spWhabDvHandBkNum"/>
	       				<input type="hidden" name="regUserId" id="regUserId"/> 				
		       			<table class="list" cellpadding="0" cellspacing="0">
							<colgroup>
								<col width="20%" />
			                    <col width="30%" />
			                    <col width="20%" />
			                    <col width="30%" />
							</colgroup>
							<tbody>
								<tr>
									<th class="C">순번</th>
									<td class="L"><input type="text" id="handBkSiNum" name="handBkSiNum" maxlength="10"/></td>
									<td class="L" colspan="2"></td>
								</tr>
								<tr>
									<th class="C">피의자</th>
									<td class="L">
										<p class="searchinput">
				                			<label for="txt_04"></label><input type="text" class="w100per" id="txt_04" name="spNm" disabled="disabled" data-always="y" readonly/><a name="spBtn" class="btn_search" id="spBtn" href="javascript:void(0);"><img alt="search" src="/sjpb/images/btn_search.png"></a>	
				                		</p>
									</td>
									<th class="C">죄명</th>
									<td class="L" id="criNm" name="criNm"></td>
								</tr>
								<tr>
									<th class="C">소재발견일자</th>
									<td class="L">
										<input type="text" id="whabDvDt" name="whabDvDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C">소재발견사유(검거,재기신청)</th>
									<td class="L">
										<input type="text" id="whabDvRsn" name="whabDvRsn" disabled="disabled" class="w100per" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C">소재발견보고일</th>
									<td class="L">
										<input type="text" id="whabDvReptDt" name="whabDvReptDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C">수배해제일자</th>
									<td class="L">
										<input type="text" id="wantRelsDt" name="wantRelsDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
								</tr>
								<tr>
									<th class="C">재기전사건번호</th>
									<td class="L" id="cmbkPreIncNum" name="cmbkPreIncNum"></td>
									<th class="C">담당자</th>
									<td class="L">
										<input type="text" id="respMb" name="respMb" disabled="disabled" class="w100per" maxlength="10"/>
									</td>
								</tr>
								<tr>
									<th class="C">송치일</th>
									<td class="L">
										<input type="text" id="trfDt" name="trfDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C">송치의견</th>
									<td class="L">
										<input type="text" id="trfOp" name="trfOp" disabled="disabled" class="w100per" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C">비고</th>
									<td class="L" colspan="3">
										<input type="text" id="spWhabDvHandBkComn" name="spWhabDvHandBkComn" disabled="disabled" class="w100per" maxlength="30"/>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="btnArea">
						<div class="r_btn">
							<a href="javascript:fn_M0108_prnReport();" class="btn_white print" style="display:none;" id="btnReport" data-view-type="mng"><span>출력</span></a>
							<a href="javascript:fn_M0108_insertSpWhab();" class="btn_light_blue save" style="display:none;" id="btnInsertSpWhab" data-view-type="inc"><span>저장</span></a>
							<a href="javascript:fn_M0108_updateSpWhab();" class="btn_light_blue_line appointed" style="display:none;" id="btnUpdateSpWhab" data-view-type="inc"><span>수정</span></a>									
																
						</div>
					</div>
				</div>
			</li>
		</ul>
		
	</div>
</body>
</html>