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
<title>출석요구통지부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0110.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" data-view-type="mng">
		<form name="m0110_searchList" id="m0110_searchList" method="post" onkeydown="if(event.keyCode==13) fn_M0110_pageInit()">
			<ul>
				<li><span class="title">사건번호</span>
					<label for="rcptIncNumSc"></label><input type="text" class="w65per" name="rcptIncNumSc"/>
				</li>		   
				<li><span class="title">출석자명</span>
					<label for="spNmSc"></label><input type="text" class="w65per" name="spNmSc"/>
				</li>
				<li><span class="title">등록일자</span>
					<label for="regStart"></label><input type="text" id="regStart" name="regStart" class="w30per calendar datepicker" readonly/>~
					<label for="regEnd"></label><input type="text" id="regEnd" name="regEnd" class="w30per calendar datepicker" readonly/>
				</li>
			</ul>
			<div class="searchbtn">
				<a href="javascript:fn_M_init('m0110_searchList');" class="btn_white reset"><span>초기화</span></a>
				<a href="javascript:fn_M0110_pageInit();" class="btn_light_blue search_01"><span>검색</span></a>
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
			<a href="javascript:fn_M0110_newAtdcReq();" class="btn_light_blue new2" id="btnNewAtdcReq" data-view-type="inc"><span>신규</span></a>
			<a href="javascript:fn_M0110_prnCheckReport();" class="btn_white print" id="btnPrtAtdcReq"><span>대장 출력</span></a>
		</div>
	</div>
	<input type="hidden" name="userId" id="userId" value="${userId}"/>
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 출석요구통지부 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>출석요구통지부 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
	       			<form id="M0110AtdcReq" name="M0110AtdcReq">
	       				<input type="hidden" name="rcptNum" id="rcptNum"/>
	       				<input type="hidden" name="incSpNum" id="incSpNum"/>
	       				<input type="hidden" name="atdcReqNotcNum" id="atdcReqNotcNum"/>
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
	                                <th class="C">문서번호</th>
	                                <td class="L" colspan="3"><label for="docNum"><input type="text" class="w100per" id="docNum" name="docNum" maxlength="10" /></label></td>
	                            </tr>
								<tr>
									<th class="C">출석요구일시</th>
									<td class="L">
										<input type="text" id="atdcReqDt" name="atdcReqDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<td class="L" colspan="2"></td>
								</tr>
								<tr>
									<th class="C">출석자구분</th>
									<td class="L">
										<div class="inputbox w100per"> 
											<p class="txt"></p> 
							            	<select id="atdcPersDiv" name="atdcPersDiv" disabled="disabled">
							            		<option value="">구분을 선택하세요.</option>
							            		<c:forEach items="${persDivList }" var="item">
							            			<option value="${ item.code}">${item.codeName }</option>
							            		</c:forEach>
							            	</select>
						            	</div>
									</td>
									<th class="C">출석자성명</th>
									<td class="L">
										<span id="atdcPersNm" name="atdcPersNm"></span>
										<span id="spDiv" style="display:none;">
											<p class="searchinput">
				                				<label for="spNm"></label><input type="text" class="w100per" id="spNm" name="spNm" disabled="disabled" data-always="y" readonly/><a name="spBtn" class="btn_search" id="spBtn" href="javascript:void(0);"><img alt="search" src="/sjpb/images/btn_search.png"></a>	
				                			</p>
										</span>
										<span id="refeDiv" style="display:none;">
											<input type="text" id="refeNm" name="refeNm" class="w100per" disabled="disabled" maxlength="10"/>
										</span>
									</td>
								</tr>
								<tr>
									<th class="C">사건번호</th>
									<td class="L"><span id="incNum" name="incNum"></span></td>
									<td class="L" colspan="2"></td>
								</tr>
								<tr>
                                <th class="C" ><span class="table_title">사건의요지</span></th>
                                <td class="L" colspan="3">
                                    <textarea id="incPoint" name="incPoint" cols="" rows="" style="height:120px;" maxlength="150"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <th class="C"><span class="table_title">구비서류 등</span></th>
                                <td class="L" colspan="3">
                                    <textarea id="reqDocs" name="reqDocs" cols="" rows="" style="height:120px;" maxlength="150"></textarea>
                                </td>
                            </tr>
                            </tbody>
                            <tbody id="afterDiv">
								<tr>
									<th class="C">출석요구통지통지일</th>
									<td class="L">
										<input type="text" id="atdcReqNotcDt" name="atdcReqNotcDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C">출석요구통지방법</th>
									<td class="L">
										<div class="inputbox w100per"> 
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
									<th class="C">결과</th>
									<td class="L">
										<input type="text" id="atdcReqRst" name="atdcReqRst" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C">담당자 확인(서명 또는 날인)</th>
									<td class="L">
										<input type="text" id="atdcReqRespMb" name="atdcReqRespMb" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="btnArea">
						<div class="r_btn">
							<a href="javascript:requestReport();" class="btn_white print" style="display:none;" id="btnReqPrn"><span>신청서 출력</span></a>
							<a href="javascript:fn_M0110_insertAtdcReq();" class="btn_light_blue save" style="display:none;" id="btnInsertAtdcReq" data-view-type="inc"><span>저장</span></a>
							<a href="javascript:fn_M0110_updateAtdcReq();" class="btn_light_blue_line appointed" style="display:none;" id="btnUpdateAtdcReq" data-view-type="inc"><span>수정</span></a>									
						</div>
					</div>
				</div>
			</li>
		</ul>
		
	</div>
</body>
</html>