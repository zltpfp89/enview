<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>통합피의자조회</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/D/D0101.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
<div class="searchArea">
	<form name="d_searchList" id="d_searchList" method="post" onkeydown="if(event.keyCode==13) fn_d_selectList()">
		<ul>
			<li><span class="title">연도</span>
				<div class="inputbox w65per">
					<p class="txt"></p>
					<select id="yearSC" name="yearSC">
						<option value="">전체</option>
				   		<c:forEach items="${yearScList}" var="year" varStatus="status">
				   			<c:choose>
				   				<c:when test="${year == yearSc && isSetCurYear}">
				   					<option value="${year}" selected="selected">${year} 년</option>
								</c:when>
								<c:otherwise>
									<option value="${year}">${year} 년</option>
								</c:otherwise> 
				   			</c:choose>
						</c:forEach>
				   </select>
			   </div>
			</li>
			<!--  
			<li><span class="title">분야</span> 
				<div class="inputbox w65per"> 
					<p class="txt"></p>   
					<select id="fdCdSC" name="fdCdSC">
						<option value="">전체</option> 							
						<c:forEach items="${fdCdList}" var="item">
							<option value="${item.code}">${item.codeName}</option> 
						</c:forEach>
					</select>
				</div>
			</li>
			
			<li><span class="title">수사팀</span>
				   <div class="inputbox w65per">
					   <p class="txt"></p>
					   <select id="criTmIdSC" name="criTmIdSC">
						   <option value="">전체</option>
							<c:forEach items="${criTmList}" var="criTm" varStatus="status">
								<option value="${criTm.criTmId}">${criTm.criTmNm}</option>
							</c:forEach>
					   </select>
				   </div>
			   </li>
			   -->
			<li>
				<span class="title">사건번호</span>
				<label for="rcptIncNumSC"></label><input type="text" class="w65per" name="rcptIncNumSC" id="rcptIncNumSC" value="${sc.rcptIncNumSC }"/>
			</li>
			<li>
				<span class="title">상태</span>
				<div class="inputbox w65per">
				   <p class="txt"></p>
				   <select id="criStatCdSC" name="criStatCdSC">
					   <option value="">전체</option>
						<c:forEach items="${criStatKndList}" var="criStat" varStatus="status">
							<c:if test="${criStat.code >= '40'}">
								<option value="${criStat.code}">${criStat.codeName}</option>
							</c:if>
						</c:forEach>
				   </select>
				</div>
			</li>
			<li>
				<span class="title">발각형태</span>
			   	<div class="inputbox w65per">
				   <p class="txt"></p>
				   <select id="dvFormSC" name="dvFormSC">
					   <option value="">전체</option>
						<c:forEach items="${dvFormKndList}" var="dvForm" varStatus="status">
							<option value="${dvForm.code}">${dvForm.codeName}</option>
						</c:forEach>
				   </select>
			   </div>
			</li>
			<li>
				<span class="title">송치번호</span>
			   	<label for="trfNumSC"></label><input type="text" class="w65per" name="trfNumSC" id="trfNumSC" value="${sc.trfNumSC }"/>
			</li>
			<li><span class="title">위반법률</span>
				<div class="inputbox w65per"> 
			    	<p class="txt"></p>   
					<select id="rltActCriNmCdSC" name="rltActCriNmCdSC">
						<option value="">전체</option> 							
						<c:forEach items="${rltActCriNmCdList}" var="item">
						<option value="${item.code}">${item.codeName}</option> 
						</c:forEach>
					</select>
				</div>
			</li>
			<li>
				<span class="title">위반내용</span>
			   	<label for="vioContSC"></label><input type="text" class="w65per" name="vioContSC" id="vioContSC" value="${sc.vioContSC }"/>
			</li>
			<li><span class="title">피의자명</span>
			    <input type="text" class="w65per" name="spNm" id="spNm" value="${sc.spNm }"/>
			</li>
			<li><span class="title">피의자구분</span>
				<div class="inputbox w65per"> 
			    	<p class="txt"></p>   
					<select id="indvCorpDiv" name="indvCorpDiv">
						<option value="">전체</option> 							
						<c:forEach items="${indvCorpDivKndList}" var="item">
							<option value="${item.code}">${item.codeName}</option> 
						</c:forEach>
					</select>
				</div>
			 </li> 
			 <li id="indvCorpDiv_1"><span class="title">주민등록번호</span>
		    	<input type="text" class="w30per" name="spIdNum_1_A" id="spIdNum_1_A" value="${sc.spIdNum_1_A }"/>-			    
		    	<input type="text" class="w30per" name="spIdNum_1_B" id="spIdNum_1_B" value="${sc.spIdNum_1_B }"/>	    
			 </li>
			 <li id="indvCorpDiv_2" style="display:none;"><span class="title">법인등록번호</span>
		    	<input type="text" class="w20per" name="spCorpIdNum_2_A" id="spCorpIdNum_2_A" value="${sc.spCorpIdNum_2_A }"/>-
		    	<input type="text" class="w20per" name="spCorpIdNum_2_B" id="spCorpIdNum_2_B" value="${sc.spCorpIdNum_2_B }"/>-
		    	<input type="text" class="w20per" name="spCorpIdNum_2_C" id="spCorpIdNum_2_C" value="${sc.spCorpIdNum_2_C }"/>
			 </li>
			 <li><span class="title">등록일자</span>
				   <label for="sDateSC"></label><input type="text" class="w30per calendar datepicker" id="sDateSC" name="sDateSC" value="" data-type="date" data-optional-value=true title="등록일자시작일"/> ~ <label for="eDateSC"></label><input type="text" class="w30per calendar datepicker" id="eDateSC" name="eDateSC" value="" data-type="date" data-optional-value=true title="등록일자종료일"/>
			</li>
			<li><span class="title">담당수사관</span>
				<label for="nmKorSC"></label><input type="text" class="w65per" id="nmKorSC" name="nmKorSC" />
			</li>
			<!--
			<li><span class="title">유입구분</span>
				<div class="inputbox w65per">
					<p class="txt"></p>
					<select id="infwDivSC" name="infwDivSC">
						<option value="">전체</option>
						<c:forEach items="${infwDivList}" var="infwDivNm" varStatus="status">
							<option value="${infwDivNm.code}">${infwDivNm.codeName}</option>
						</c:forEach>
					</select>
				</div>			   
			</li>
			  -->
		</ul>
		<div class="searchbtn">
			<a href="javascript:void(0);" id="exceldownD0101" class="btn_light_green_line excel"><span>엑셀</span></a>
			<a href="javascript:fn_d_init('d_searchList');" class="btn_white reset"><span>초기화</span></a>
			<a href="javascript:fn_d_selectList();" id="btn_search" class="btn_light_blue search_01"><span>검색</span></a>
			
		</div>
	</form>
</div> 
<div id="mergeSp" class="listArea mrt15 area-mousewheel" style="height: 300px; width: 100%"></div>
	       			
<div class="tab_mini_wrap m1" id="mergeSpTab">                               	
   	<ul>
		<!-- 피의자 정보탭 -->
       	<li class="m1"><a href="javascript:fn_f_selectIntiIncTab();" class="tabtitle" id="intiIncTab"><span>피의자 정보</span></a>
       		<!-- tab_contents -->
       		<div class="tab_mini_contents">
       			<table class="list" cellpadding="0" cellspacing="0" id="spInfoTable">
					<colgroup>
						<col width="10%" />
						<col width="15%" />
						<col width="30%" />
						<col width="15%" />
						<col width="30%" />
					</colgroup>
					<tbody>
						<tr id="personalInfo">
							<th class="C line_right" rowspan="12">피의자 정보</th>
							<th class="C">구분</th>
							<td class="L" id="indvDivDesc"></td>
							<th class="C">내 외국인</th>
							<td class="L" id="homcForcPernDivDesc"></td>
						</tr>
						<tr id="corpInfo">
							<th class="C line_right" rowspan="12">피의자 정보</th>
							<th class="C" >구분</th>
							<td class="L" colspan="3" id="CorpDivDesc"></td>
						</tr>
						<tr>
							<th class="C">성명</th>
							<td class="L" colspan="3" id="spNmInfo"></td>
						</tr>
						<tr id="personalNum">
							<th class="C">주민등록번호</th>
							<td class="L" id="spIdNum"></td>
							<th class="C">성별</th>
							<td class="L" id="gendDivDesc"></td>
						</tr>
						<tr id="corpNum">
							<th class="C">법인번호</th>
							<td class="L" colspan="3" id="CorpNum"></td>
						</tr>
						<tr>
							<th class="C">주소</th>
							<td class="L" colspan="3" id="spAddr"></td>
						</tr>
						<tr>
							<th class="C">연락처</th>
							<td class="L" colspan="3" id="spCnttNum"></td>
						</tr>
						<tr id="vioArea">
							<td class="L" colspan="4" id="lawArea"></td>
						</tr>
					</tbody>
				</table> 
       		</div>
			<!-- //tab_contents -->
		</li>
		<!-- //피의자 상세탭 -->
	</ul>
</div>
</body>
</html>