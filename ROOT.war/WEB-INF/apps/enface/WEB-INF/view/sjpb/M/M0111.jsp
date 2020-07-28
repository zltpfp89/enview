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
<title>체포구속인명부서식</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0111.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" data-view-type="mng">
		<form name="m0111_searchList" id="m0111_searchList" method="post" onkeydown="if(event.keyCode==13) fn_M0111_pageInit()">
			<ul>
				<li><span class="title">사건번호</span>
					<label for="rcptIncNum"></label><input type="text" class="w65per" />
				</li>		   
				<li><span class="title">수사담당자</span>
					<label for="nmKor"></label><input type="text" class="w65per" id="nmKor" name="nmKor" />
				</li>
			</ul>
			<div class="searchbtn">
				<a href="javascript:fn_M0111_init('m0111_searchList');" class="btn_white"><span>초기화</span></a>
				<a href="javascript:fn_M0111_pageInit();" class="btn_blue"><span>검색</span></a>
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
			<a href="javascript:fn_M0111_newPern();" class="btn_blue" id="btnNewPern" data-view-type="inc"><span>신규</span></a>
			<a href="javascript:fn_M0111_prtPernReport();" class="btn_white" id="btnPrtPern" data-view-type="mng"><span>출력</span></a>
		</div>
	</div>
	<input type="hidden" name="userId" id="userId" value="${userId}"/>
	<div class="tab_mini_wrap m1" id="PernTab">                               	
	   	<ul>
			<!-- 체포구속인명부서식 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>체포구속인명부서식 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
	       			<form id="M0111Pern" name="M0111Pern">
	       				<input type="hidden" name="rcptNum" id="rcptNum"/>
	       				<input type="hidden" name="incSpNum" id="incSpNum"/>
	       				<input type="hidden" name="atdcReqNotcNum" id="atdcReqNotcNum"/>
	       				<input type="hidden" name="regUserId" id="regUserId"/> 				
		       			<table class="list" cellpadding="0" cellspacing="0">
							<colgroup>
								<col width="25%"/>
								<col width="25%"/>
								<col width="50%"/>
							</colgroup>
							<tbody>
								<tr>
									<th class="C" colspan="2">출석요구일시</th>
									<td class="L" id="atdcReqDt" name="atdcReqDt"></td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="2">출석자</th>
									<th class="C">구분</th>
									<td class="L">
										<div class="inputbox w65per"> 
											<p class="txt"></p> 
							            	<select id="atdcPersDiv" name="atdcPersDiv" disabled="disabled">
							            		<option value="">구분을 선택하세요.</option>
							            		<c:forEach items="${persDivList }" var="item">
							            			<option value="${ item.code}">${item.codeName }</option>
							            		</c:forEach>
							            	</select>
						            	</div>
									</td>
								</tr>
								<tr>
									<th class="C">성명</th>
									<td class="L">
										<span id="atdcPersNm" name="atdcPersNm"></span>
										<span id="spDiv" style="display:none;">
											<input type="text" id="spNm" name="spNm" disabled="disabled" readonly/>
											<a href="javascript:fn_M0110_searchIncSp();" class="btn_blue" id="btnSearchInc" style="display:none;"><span>검색</span></a>
										</span>
										<span id="refeDiv" style="display:none;">
											<input type="text" id="refeNm" name="refeNm" disabled="disabled"/>
										</span>
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">사건번호</th>
									<td class="L"><span id="incNum" name="incNum"></span></td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="2">출석요구통지</th>
									<th class="C">통지일</th>
									<td class="L">
										<input type="text" id="atdcReqNotcDt" name="atdcReqNotcDt" disabled="disabled" class="w30per calendar datepicker"/>
									</td>
								</tr>
								<tr>
									<th class="C">방법</th>
									<td class="L">
										<div class="inputbox w65per"> 
											<p class="txt"></p> 
							            	<select id="atdcReqNotcWay" name="atdcReqNotcWay" disabled="disabled">
							            		<option value="">방법을 선택하세요.</option>
							            		<c:forEach items="${reqNotcWayList}" var="item">
							            			<option value="${item.code}">${item.codeName}</option>
							            		</c:forEach>
							            	</select>
						            	</div>
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">결과</th>
									<td class="L">
										<input type="text" id="atdcReqRst" name="atdcReqRst" disabled="disabled"/>
									</td>
								</tr>
								<tr>
									<th class="C" colspan="2">담당자 확인(서명 또는 날인)</th>
									<td class="L">
										<input type="text" id="atdcReqRespMb" name="atdcReqRespMb" disabled="disabled"/>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="btnArea">
						<div class="r_btn" data-view-type="inc">
							<a href="javascript:fn_M0111_insertPern();" class="btn_blue" style="display:none;" id="btnInsertPern"><span>저장</span></a>
							<a href="javascript:fn_M0111_updatePern();" class="btn_blue" style="display:none;" id="btnUpdatePern"><span>수정</span></a>									
						</div>
					</div>
				</div>
			</li>
		</ul>
		
	</div>
</body>
</html>