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
<title>범죄수사자료조회관리대장</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/F/F0101.js?r=<%=Math.random()%>"></script>
</head>
<body class="iframe">
<!-- searchArea -->
<div class="searchArea">
	<form name="f_searchList" id="f_searchList" method="post" onkeydown="if(event.keyCode==13) fn_searchList()">
		<input type="hidden" id="userID" value="${userInfo.userId }"/>
		<input type="hidden" id="userOrgCd" value="${userInfo.orgCd }"/>
		<input type="hidden" id="taskRoleCd" value="${taskRoleCd }"/>
		<input type="hidden" id="userIdNm" name="userIdNm" value="${userInfo.nmKor }" />
		<ul>
			<li><span class="title">담당팀</span> 
			    <div class="inputbox w65per"> 
			    	<p class="txt"></p>   
					<select id="criTmIdSC" name="criTmIdSC">
						<option value="" selected="selected">전체</option>		 							
						<c:forEach items="${criTmList}" var="item">
							<option value="${item.criTmId}">${item.criTmNm}</option> 
						</c:forEach>
					</select> 
				</div>                        
            </li>
            <li><span class="title">조회상태</span>
            	<div class="inputbox w65per"> 
			    	<p class="txt"></p> 
	            	<select id="mngBkStatCd" name="mngBkStatCd">
	            		<option value="">전체</option>
	            		<c:forEach items="${mngBkStatCdList }" var="item">
	            			<c:if test="${mngBkStatCd == item.code}">
	            				<option value="${item.code}" selected="selected">${item.codeName }</option>
	            			</c:if>
	            			<c:if test="${mngBkStatCd != item.code}">
	            				<option value="${item.code}">${item.codeName }</option>
	            			</c:if>
	            		</c:forEach>
	            	</select>
            	</div>
            </li>
			<li><span class="title">담당수사관</span>
            	<label for="respNm"></label><input type="text" name="respNm" value="${sc.respNm }" class="w65per"/>
            </li>
			<li><span class="title">조회수사관</span>
				<label for="inqNm"></label><input type="text" name="inqNm" value="${sc.inqNm }" class="w65per"/>
			</li>
			<li><span class="title">조회일자</span>
				<label for="startDay"></label><input type="text" name="startDay" value="${sc.startDay }" class="w30per calendar datepicker" readonly/>~<label for="endDay"></label><input type="text" name="endDay" value="${sc.endDay }" class="w30per calendar datepicker" readonly/>
			</li>
			<li><span class="title">사건번호</span>
				<label for="rcptIncNum"></label><input type="text" name="rcptIncNum" value="${sc.rcptIncNum }" class="w65per"/>
			</li>
			<li><span class="title">피의자</span>
				<label for="spNm"></label><input type="text" name="spNm" value="${sc.spNm }" class="w65per"/>
			</li>
			<li><span class="title">주민등록번호</span>
				<label for="spIdNum"></label>
				<input type="text" class="w30per" name="spIdNum_1" id="spIdNum_1" value="${sc.spIdNum_1 }"/>-	    
		    	<input type="text" class="w30per" name="spIdNum_2" id="spIdNum_2" value="${sc.spIdNum_2 }"/>
		    	
				<!-- input type="text" name="spIdNum" value="${sc.spIdNum }" class="w65per"/>-->
			</li>
			<li></li>
		</ul>
		<div class="searchbtn">
			<a href="javascript:fn_searchList();"id="btn_search" class="btn_blue"><span>검색</span></a>
			<a href="javascript:fn_f_init('f_searchList');" class="btn_white"><span>초기화</span></a>
		</div>
	</form>
</div>
<!-- //searchArea -->
<!-- listArea -->
<div id="sheet" class="listArea mrt15 area-mousewheel" style="height: 300px; width: 100%">
</div> 
<!-- //listArea -->

<!-- report -->
<form name="reportForm" method="post">
	<input type="hidden" id="reptNm" name="reptNm" value="" />
	<input type="hidden" id="xmlData" name="xmlData" value="" />
</form>
<!-- //report -->

<!-- btnArea -->
<div class="btnArea">
	<div class="r_btn" id="btnAreaRole">
		<a href="javascript:void(0);" id="addMngBtn" style="display:none" class="btn_blue"><span>신규</span></a>
		<a href="javascript:fn_F0101_prnMngReport();" id="F0101prtMngBtn" style="display:none" class="btn_white"><span>회보대장 출력</span></a> 
		<a href="javascript:fn_F0102_prnMngReport();" id="F0102prtMngBtn" style="display:none" class="btn_white"><span>의뢰대장 출력</span></a> 
		<a href="javascript:fn_f_deleteHawr();" id="deleteMngBtn" style="display:none"  class="btn_white"><span>삭제</span></a>
	</div>
</div>

						
<div class="tab_mini_wrap m1" id="mngTab">                               	
   	<ul>
		<!-- 범죄수사 상세탭 -->
       	<li class="m1"><a href="javascript:fn_f_selectIntiIncTab();" class="tabtitle" id="intiIncTab"><span>범죄수사자료 상세</span></a>
       		<!-- tab_contents -->
       		<div class="tab_mini_contents">
				<!-- 수령자 버튼 영역 -->
       			<div id="recvSearchBtnArea"></div>
       			<!-- listArea -->
				<div id="sheetItem" class="listArea mrt15 area-mousewheel" style="height: 300px; width: 100%">
					
				</div> 
				<!-- //listArea -->
				<!-- 승인자 버튼 영역 -->
				<div class="btnArea">
					<div class="r_btn" style="height:25px">
						 
						<span id="confmBtnArea"></span>
					</div>
				</div>
			</div>
			<!-- //tab_contents -->
		</li>
		<!-- //범죄수사 상세탭 -->
		
		<!-- 승인 이력탭 -->
		<li class="m2"><a href="javascript:void(0);" class="tabtitle" id="taskHistTab"><span>승인 이력</span></a>
			<!-- tab_contents -->
       		<div class="tab_mini_contents">
				<!-- listArea -->
				<div id="sheetConfm" class="listArea mrt15 area-mousewheel" style="height: 300px; width: 100%">
				</div> 
				<!-- //listArea -->
			</div>
			<!-- //tab_contents  -->
		</li>
		<!-- //승인 이력탭 -->
	</ul>
</div>
<!-- //contentsArea -->
										
</body>
</html>
