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
<title>체포구속인진료부</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0114.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" data-view-type="mng">
		<form name="m0114_searchList" id="m0114_searchList" method="post" onkeydown="if(event.keyCode==13) fn_M0114_pageInit()">
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
				<a href="javascript:fn_M_init('m0114_searchList');" class="btn_white reset"><span>초기화</span></a>
				<a href="javascript:fn_M0114_pageInit();" class="btn_light_blue search_01"><span>검색</span></a>
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
			<a href="javascript:fn_M0114_new();" class="btn_light_blue new2" id="btnNew" data-view-type="inc"><span>신규</span></a>
			<a href="javascript:fn_M0114_prnCheckReport();" class="btn_white print" id="btnPrt" data-view-type="mng"><span>출력</span></a>
		</div>
	</div>
	<input type="hidden" name="userId" id="userId" value="${userId}"/>
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 체포구속인진료부 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>체포구속인진료부 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
	       			<form id="M0114" name="M0114">
	       				<input type="hidden" name="rcptNum" id="rcptNum"/>
	       				<input type="hidden" name="incSpNum" id="incSpNum"/>
	       				<input type="hidden" name="cathArstCsltNum" id="cathArstCsltNum"/>
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
									<th class="C">유치인 성명</th>
									<td class="L">
										<span id="cstdPersNm" name="cstdPersNm"></span>
										<a href="javascript:fn_M0114_searchIncSp();" class="btn_light_blue search_01" id="btnSearchInc" style="display:none;"><span>검색</span></a>
									</td>
									<td class="L" colspan="2"></td>
								</tr>
								<tr>
									<th class="C">진단의사의 성명</th>
									<td class="L">
										<input type="text" id="dgnsDctrNm" name="dgnsDctrNm" class="w100per" disabled="disabled" maxlength="10"/>
									</td>
									<th class="C">진료의 원인</th>
									<td class="L">
										<input type="text" id="csltCau" name="csltCau" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C">진료일시</th>
									<td class="L">
										<input type="text" id="csltDt" name="csltDt" disabled="disabled" class="w100per calendar datepicker" readonly/>
									</td>
									<th class="C">입회관</th>
									<td class="L">
										<input type="text" id="prscOffi" name="prscOffi" class="w100per" disabled="disabled" maxlength="10"/>
									</td>
								</tr>
								<tr>
									<th class="C">진단의 결과</th>
									<td class="L">
										<textarea id="dgnsRst" name="dgnsRst" cols="" rows="" disabled="disabled" maxlength="30"></textarea>
									</td>
									<th class="C">비고</th>
									<td class="L">
										<textarea id="cathArstCsltComn" name="cathArstCsltComn" cols="" rows="" disabled="disabled" maxlength="300"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="btnArea">
						<div class="r_btn" data-view-type="inc">
							<a href="javascript:fn_M0114_insert();" class="btn_light_blue save" style="display:none;" id="btnInsert"><span>저장</span></a>
							<a href="javascript:fn_M0114_update();" class="btn_light_blue_line appointed" style="display:none;" id="btnUpdate"><span>수정</span></a>									
						</div>
					</div>
				</div>
			</li>
		</ul>
		
	</div>
</body>
</html>