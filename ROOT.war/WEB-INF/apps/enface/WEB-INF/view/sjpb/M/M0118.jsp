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
<title>긴급통신제한조치대장서식</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/M/M0118.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
   <!-- searchArea -->
   <div class="searchArea" data-view-type="mng">
		<form name="m0118_searchList" id="m0118_searchList" method="post" onkeydown="if(event.keyCode==13) fn_M0118_pageInit()">
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
				<a href="javascript:fn_M_init('m0118_searchList');" class="btn_white reset"><span>초기화</span></a>
				<a href="javascript:fn_M0118_pageInit();" class="btn_light_blue search_01"><span>검색</span></a>
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
			<a href="javascript:fn_M0118_new();" class="btn_light_blue new2" id="btnNew" data-view-type="inc"><span>신규</span></a>
			<a href="javascript:fn_M0118_prnCheckReport();" class="btn_white print" id="btnPrt" data-view-type="mng"><span>출력</span></a>
		</div>
	</div>
	<input type="hidden" name="userId" id="userId" value="${userId}"/>
	<div class="tab_mini_wrap m1" id="docTab">                               	
	   	<ul>
			<!-- 긴급통신제한조치대장서식 상세탭 -->
	       	<li class="m1"><a href="javascript:void();" class="tabtitle" id="intiIncTab"><span>긴급통신제한조치대장서식 상세</span></a>
	       		<!-- tab_contents -->
	       		<div class="tab_mini_contents" id="contentsArea">
	       			<form id="M0118" name="M0118">
	       				<input type="hidden" name="rcptNum" id="rcptNum"/>
	       				<input type="hidden" name="incSpNum" id="incSpNum"/>
	       				<input type="hidden" name="emgyCmctActnBkNum" id="emgyCmctActnBkNum"/>
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
									<td class="L"><input type="text" class="w100per" id="execNum" name="execNum" maxlength="10"></td>
									<th class="C">사건번호</th>
									<td class="L" id="incNum" name="incNum"></td>
								</tr>
								<tr>
									<th class="C" colspan="2">성명</th>
									<td class="L">
										<p class="searchinput">
				                			<label for="txt_04"></label><input type="text" class="w100per" id="txt_04" name="spNm" disabled="disabled" data-always="y" readonly/><a name="spBtn" class="btn_search" id="spBtn" href="javascript:void(0);"><img alt="search" src="/sjpb/images/btn_search.png"></a>	
				                		</p>
									</td>
									<td class="L" colspan="2"></td>
								</tr>
								<tr>
									<th class="C line_right" rowspan="3">긴급통신제한조치</th>
									<th class="C">대상</th>
									<td class="L">
										<input type="text" id="rstrActnTrgt" name="rstrActnTrgt" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C">종류</th>
									<td class="L">
										<input type="text" id="rstrActnType" name="rstrActnType" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C">방법</th>
									<td class="L">
										<input type="text" id="rstrActnWay" name="rstrActnWay" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<th class="C">기간</th>
									<td class="L">
										<input type="text" id="rstrActnPi" name="rstrActnPi" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
								<tr>
									<th class="C">집행장소</th>
									<td class="L">
										<input type="text" id="rstrActnExecPla" name="rstrActnExecPla" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
									<td class="L" colspan="2"></td>
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
									<th class="C">사후신청 또는 통보서 발송여부</th>
									<td class="L">
										<input type="text" id="notcDocSendYn" name="notcDocSendYn" class="w100per" disabled="disabled" maxlength="30"/>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="btnArea">
						<div class="r_btn" data-view-type="inc">
							<a href="javascript:fn_M0118_insert();" class="btn_light_blue save" style="display:none;" id="btnInsert"><span>저장</span></a>
							<a href="javascript:fn_M0118_update();" class="btn_light_blue_line appointed" style="display:none;" id="btnUpdate"><span>수정</span></a>									
						</div>
					</div>
				</div>
			</li>
		</ul>
		
	</div>
</body>
</html>