<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>수사차량관리</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/K/K0101.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
<!-- searchArea -->
<div class="searchArea">
	<form name="k_searchList" id="k_searchList" method="post" onkeydown="if(event.keyCode==13) fn_searchList()">
		<ul>
			<li><span class="title">년도</span>
            	<label for="itdcYearSC"></label>
            	<div class="inputbox w65per"> 
			    	<p class="txt"></p> 
	            	<select id="itdcYearSC" name="itdcYearSC">
	            		<option value="">선택해주세요.</option>
	            		<c:forEach items="${yearList }" var="item">
	            			<option value="${item}">${item}</option>
	            		</c:forEach>
	            	</select>
            	</div>
            </li>
            <li></li>
            <li></li>
		</ul>
		<div class="searchbtn">
			<a href="javascript:fn_searchList();"id="btn_search" class="btn_blue"><span>검색</span></a>
			<a href="javascript:fn_j_init('k_searchList');" class="btn_white"><span>초기화</span></a>
		</div>
	</form>
</div>
<!-- listArea -->
<div id="sheet" class="listArea mrt15 area-mousewheel" style="height: 300px; width: 100%">
</div> 
<!-- //listArea -->

<!-- btnArea -->
<div class="btnArea">
	<div class="r_btn">
		<a href="javascript:fn_K_new();" class="btn_blue"><span>신규</span></a>
	</div>
</div>
<div class="tab_mini_wrap m1" id="mngTab">                               	
   	<ul>
		<!-- 범죄수사 상세탭 -->
       	<li class="m1"><a href="javascript:fn_f_selectIntiIncTab();" class="tabtitle" id="intiIncTab"><span>차량관리 상세</span></a>
       		<!-- tab_contents -->
       		<div class="tab_mini_contents" id="contentsArea">
       			<input type="hidden" id="regUserId" name="regUserId" value="${userId }"/>
       			<form id="K0101" name="K0101">
       				<input type="hidden" id="vhcMngNum" name="vhcMngNum"/>
       				<table class="list" cellpadding="0" cellspacing="0">
						<colgroup>
							<col width="15%"/>
							<col width="34%"/>
							<col width="15%"/>
							<col width="35%"/>
						</colgroup>
						<tbody>
							<tr>
								<th class="C">년도</th>
								<td class="L">
									<div class="inputbox w65per"> 
								    	<p class="txt"></p> 
						            	<select id="itdcYear" name="itdcYear" data-type="select" title="년도">
						            		<option value="">선택해주세요.</option>
						            		<c:forEach items="${yearList }" var="item">
						            			<option value="${item}">${item}</option>
						            		</c:forEach>
						            	</select>
					            	</div>
								</td>
								<th class="C">구분</th>
								<td class="L">
									<div class="inputbox w65per"> 
								    	<p class="txt"></p> 
						            	<select id="vhcDiv" name="vhcDiv" data-type="select" title="구분">
						            		<option value="">선택해주세요.</option>
						            		<c:forEach items="${vhcDivList }" var="item">
						            			<option value="${item.code}">${item.codeName }</option>
						            		</c:forEach>
						            	</select>
					            	</div>
								</td>
							</tr>
							<tr>
								<th class="C">차종</th>
								<td class="L">
									<div class="inputbox w65per"> 
								    	<p class="txt"></p> 
						            	<select id="vhcKind" name="vhcKind" data-type="select" title="차종">
						            		<option value="">선택해주세요.</option>
						            		<c:forEach items="${vhcKindList }" var="item">
						            			<option value="${item.code}">${item.codeName }</option>
						            		</c:forEach>
						            	</select>
					            	</div>
								</td>
								<th class="C">차형</th>
								<td class="L">
									<div class="inputbox w65per"> 
								    	<p class="txt"></p> 
						            	<select id="vhcSz" name="vhcSz" data-type="select" title="차형">
						            		<option value="">선택해주세요.</option>
						            		<c:forEach items="${vhcSzList }" var="item">
						            			<option value="${item.code}">${item.codeName }</option>
						            		</c:forEach>
						            	</select>
					            	</div>
								</td>
							</tr>
							<tr>
								<th class="C">제조사</th>
								<td class="L">
									<input type="text" id="mnftNm" name="mnftNm" class="w100per" title="제조사" data-type ="required" disabled="disabled"/>
								</td>
								<th class="C">모델명</th>
								<td class="L">
									<input type="text" id="mdlNm" name="mdlNm" class="w100per" title="모델명" data-type ="required" disabled="disabled"/>
								</td>
							</tr>
							<tr>
								<th class="C">차량번호</th>
								<td class="L">
									<input type="text" id="vhcCarNo" name="vhcCarNo" class="w100per" title="차량번호" data-type ="required" disabled="disabled"/>
								</td>
								<th class="C">관리수사팀</th>
								<td class="L">
									<div class="inputbox w65per"> 
								    	<p class="txt"></p> 
						            	<select id="mngTmId" name="mngTmId" title="관리수사팀" data-type ="select">
						            		<option value="">선택해주세요.</option>
						            		<c:forEach items="${criTmIdList }" var="item">
						            			<option value="${item.code}">${item.codeName }</option>
						            		</c:forEach>
						            	</select>
					            	</div>
								</td>
							</tr>
							<tr>
								<th class="C">공영여부</th>
								<td class="L" colspan="3">
									<input type="radio" id="pblcYn_Y" name="pblcYn" value="Y" data-type ="checkbox" title="공영여부"/>
									<label for="pblcYn_2">Y</label>
									<input type="radio" id="pblcYn_N" name="pblcYn" value="N" data-type ="checkbox" title="공영여부"/>
									<label for="pblcYn_1">N</label>
								</td>
							</tr>
							<tr>
								<th class="C">비고</th>
								<td class="L" colspan="3">
									<input type="text" id="comnCont" name="comnCont" class="w100per" disabled="disabled"/>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<div class="btnArea">
					<div class="r_btn">
						<a href="javascript:fn_K_insert();" class="btn_blue" style="display:none;" id="btnInsert"><span>저장</span></a>
						<a href="javascript:fn_K_update();" class="btn_blue" style="display:none;" id="btnUpdate"><span>수정</span></a>									
						<a href="javascript:fn_K_delete();" class="btn_white" style="display:none;" id="btnDelete"><span>삭제</span></a>									
					</div>
				</div>
       		</div>
		</li>
	</ul>
</div>
<!-- report -->
<form name="reportForm" method="post">
	<input type="hidden" id="reptNm" name="reptNm" value="" />
	<input type="hidden" id="xmlData" name="xmlData" value="" />
</form>
<!-- //report -->
</body>
</html>