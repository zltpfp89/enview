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
<title>접견 등 금지결정 처리부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0129.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" data-view-type="mng">
		<form name="m0129_searchList" id="m0129_searchList" method="post" onkeydown="if(event.keyCode==13) fn_M0129_pageInit()">
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
				<a href="javascript:fn_M_init('m0129_searchList');" class="btn_white reset"><span>초기화</span></a>
				<a href="javascript:fn_M0129_pageInit();" class="btn_light_blue search_01"><span>검색</span></a>
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
			<a href="javascript:fn_M0129_new();" class="btn_light_blue new2" id="btnNew" data-view-type="inc"><span>신규</span></a>
			<a href="javascript:fn_M0129_prnCheckReport();" class="btn_white print" id="btnPrt" data-view-type="mng"><span>출력</span></a>
		</div>
	</div>
	<input type="hidden" name="userId" id="userId" value="${userId}"/>
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 접견 등 금지결정 처리부 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>접견 등 금지결정 처리부 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
	       			<form id="M0129" name="M0129">
	       				<input type="hidden" name="rcptNum" id="rcptNum"/>
	       				<input type="hidden" name="incSpNum" id="incSpNum"/>
	       				<input type="hidden" name="rcpnPhbtHandNum" id="rcpnPhbtHandNum"/>
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
									<th class="C">집행번호</th>
									<td class="L"><input type="text" class="w100per" id="prgsNum" name="prgsNum" maxlength="10"></td>
									<td class="L" colspan="3"></td>
								</tr>
								<tr>
									<th class="C">결정일</th>
									<td class="L">
										<input type="text" id="deciDt" name="deciDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C">특별사법경찰관</td>
									<td class="L">
										<input type="text" id="sjpbPolfOffi" name="sjpbPolfOffi" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C">죄명</th>
									<td class="L">
										<input type="text" id="criNm" name="criNm" class="w100per" disabled="disabled" maxlength="150"/>
									</td>
									<th class="C">피의자</th>
									<td class="L">
										<p class="searchinput">
				                			<label for="txt_04"></label><input type="text" class="w100per" id="txt_04" name="spNm" disabled="disabled" data-always="y" readonly/><a name="spBtn" class="btn_search" id="spBtn" href="javascript:void(0);"><img alt="search" src="/sjpb/images/btn_search.png"></a>	
				                		</p>
									</td>
								</tr>
								<tr>
									<th class="C">결정이유</th>
									<td class="L">
										<input type="text" id="deciRsn" name="deciRsn" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C">금지내용</th>
									<td class="L">
										<input type="text" id="phbtCont" name="phbtCont" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C">취소일</th>
									<td class="L">
										<input type="text" id="cnclDt" name="cnclDt" class="w100per calendar datepicker" disabled="disabled" readonly/>
									</td>
									<th class="C">취소사유</td>
									<td class="L">
										<input type="text" id="cnclRsn" name="cnclRsn" class="w100per" disabled="disabled" maxlength="150"/>
									</td>
								</tr>
								<tr>
									<th class="C">비고</th>
									<td class="L" colspan="3">
										<textarea id="rcpnComn" name="rcpnComn" cols="" rows="" disabled="disabled" maxlength="150"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="btnArea">
						<div class="r_btn" data-view-type="inc">
							<a href="javascript:fn_M0129_insert();" class="btn_light_blue save" style="display:none;" id="btnInsert"><span>저장</span></a>
							<a href="javascript:fn_M0129_update();" class="btn_light_blue_line appointed" style="display:none;" id="btnUpdate"><span>수정</span></a>									
						</div>
					</div>
				</div>
			</li>
		</ul>
		
	</div>
</body>
</html>