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
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0105.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" data-view-type="mng">
		<form name="m0105_searchList" id="m0105_searchList" method="post" onkeydown="if(event.keyCode==13) fn_M0105_pageInit()">
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
				<a href="javascript:fn_M_init('m0105_searchList');" class="btn_white rest"><span>초기화</span></a>
				<a href="javascript:fn_M0105_pageInit();" class="btn_light_blue search_01""><span>검색</span></a>
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
			<a href="javascript:fn_M0105_newCathArst();" class="btn_light_blue new2" id="btnNewCathArst" data-view-type="inc"><span>신규</span></a>
			<a href="javascript:fn_M0105_prnCheckReport();" class="btn_white print" id="btnPrtCathArst" data-view-type="mng"><span>대장 출력</span></a>
		</div>
	</div>
	<input type="hidden" name="userId" id="userId" value="${userId}"/>
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 체포구속영장집행원부 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>체포구속영장집행원부 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
	       			<form id="M0105CathArst" name="M0105CathArst">
	       				<input type="hidden" name="rcptNum" id="rcptNum"/>
	       				<input type="hidden" name="incSpNum" id="incSpNum"/>
	       				<input type="hidden" name="cathArstWrntExecNum" id="cathArstWrntExecNum"/>
	       				<input type="hidden" name="regUserId" id="regUserId"/>
	       				
		       			<table class="list" cellpadding="0" cellspacing="0">
							<colgroup>
								<col width="15%" />
			                    <col width="35%" />
			                    <col width="15%" />
			                    <col width="35%" />
							</colgroup>
							<tbody>
								<tr>
									<th class="C th_line">진행번호</th>
									<td class="L td_line"><input type="text" id="execNum" name="execNum" class="w100per" maxlength="10"/></td>
									<th class="C th_line">영장번호</th>
									<td class="L td_line"><input type="text"  id="bookNum" name="bookNum" class="w100per" maxlength="10"/></td>
								</tr>
								<tr>
									<th class="C th_line">구분</th>
									<td class="L td_line">
										<div class="inputbox w100per"> 
									    	<p class="txt"></p> 
							            	<select id="divCd" name="divCd" disabled="disabled">
							            		<option value="">구분을 선택하세요.</option>
							            		<c:forEach items="${divCdList }" var="item">
							            			<option value="${ item.code}">${item.codeName }</option>
							            		</c:forEach>
							            	</select>
						            	</div>
									</td>
									<td class="L td_line" colspan="2"></td>
								</tr>
								<tr>
									<th class="C th_line">성명</th>
									<td class="L td_line">
										<p class="searchinput">
				                			<label for="txt_04"></label><input type="text" class="w100per" id="txt_04" name="spNm" disabled="disabled" data-always="y" readonly/><a name="spBtn" class="btn_search" id="spBtn" href="javascript:void(0);"><img alt="search" src="/sjpb/images/btn_search.png"></a>	
				                		</p>
									</td>
									<th class="C th_line">죄명</th>
									<td class="L td_line" id="rltActCriNmCdDesc" name="rltActCriNmCdDesc"></td>
								</tr>
								<tr>
									<th class="C th_line">집행지휘 또는 촉탁연월일</th>
									<td class="L td_line">
										<input type="text" id="execCmdPatmDt" name="execCmdPatmDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C th_line">집행지휘 또는 촉탁관서</th>
									<td class="L td_line">
										<input type="text" id="execCmdPatmOfic" name="execCmdPatmOfic" class="w100per" disabled="disabled" maxlength="30" />
									</td>
								</tr>
								<tr>
									<th class="C th_line">영장유효기간</th>
									<td class="L td_line">
										<input type="text" name="wrntValdPi" id="wrntValdPi" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<td class="L td_line" colspan="2"></td>
								</tr>
								<tr>
									<th class="C th_line">처리집행</th>
									<td class="L td_line">
										<input type="text" id="handExecDtCal" name="handExecDtCal" disabled="disabled" class="w50per calendar datepicker" readonly/>
										<input type="number" id="handExecDtHour" name="handExecDtHour" min="0" max="24" step="1" class="w15per" disabled="disabled"/>시
										<input type="number" id="handExecDtMin" name="handExecDtMin" min="0" max="60" step="5" class="w15per" disabled="disabled"/>분
									</td>
									<th class="C th_line">처리집행불능</th>
									<td class="L td_line">
										<input type="text" id="handExecIncp" name="handExecIncp" class="w80per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C th_line">처리반환일자</th>
									<td class="L td_line">
										<input type="text" name="handExecRetnDt" id="handExecRetnDt" disabled="disabled" class="w80per calendar datepicker" readonly/>
									</td>
									<td class="L td_line" colspan="2"></td>
								</tr>
								<tr>
									<th class="C th_line">비고</th>
									<td class="L td_line" colspan="3">
										<input type="text" id="cathArstWrntComn" name="cathArstWrntComn" class="w80per" disabled="disabled" maxlength="300"/>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="btnArea">
						<div class="r_btn">
						<a href="javascript:fn_M0105_prnReport();" class="btn_white print" style="display:none;" id="btnprnReport"  data-view-type="mng"><span>출력</span></a>
							<a href="javascript:fn_M0105_insertCathArst();" class="btn_light_blue save" style="display:none;" id="btnInsertCathArst"  data-view-type="inc"><span>저장</span></a>
							<a href="javascript:fn_M0105_updateCathArst();" class="btn_light_blue_line appointed" style="display:none;" id="btnUpdateCathArst"  data-view-type="inc"><span>수정</span></a>			
										
						</div>
					</div>
				</div>
			</li>
		</ul>
		
	</div>
</body>
</html>