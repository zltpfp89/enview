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
		<title>디지털포렌식수사지원</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-style-type" content="text/css" />
		
        <script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/G/G0101.js?r=<%=Math.random()%>"></script>
        
	</head>
	<body class="iframe">
	
		<form name="contentsFormData" id="contentsFormData">
			<input type="hidden" id="userId" name="userId" value="${userInfo.userId}" />   <!-- 사용자계정 -->
			<input type="hidden" id="userName" name="userName" value="${userInfo.userName}" />  <!-- 사용자이름 -->
			<input type="hidden" id="orgCd" name="orgCd" value="${userInfo.orgCd}" />   <!-- 수사팀코드 -->
			<input type="hidden" id="kindCd" name="kindCd" value="${userInfo.kindCd}" />  <!-- 수사단원구분 01:수사관 02:팀장 03:과장 -->	
		</form>	
		
		<div class="sub_listArea" id="searchArea">
             <table class="list" cellpadding="0" cellspacing="0">
                 <caption>게시판쓰기</caption>
                 <colgroup>
                     <col width="30%" />
                     <col width="30%" />
                     <col width="*%" />
                 </colgroup>
                 <tbody>
                     <tr>
                         <th class="R p_search">날짜</th>
                         <th class="L l_pd p_search">
                         	<label for="dateSc"></label><input type="text" class="w100per calendar datepicker" autocomplete="off" id="dateSc" name="dateSc"/>
                         </th>
                         
                         <th class="L l_pd p_search">
                             <div class="l_btn"><a href="javascript:doSearch();" class="btn_light_blue search_01"><span>조회</span></a></div>
                         </th>
                     </tr>
                 </tbody>
             </table>
         </div>
		<div class="calendar_date">
		    <a class="calendar_perv" id="calendar_perv" href="javascript:void(0);" title="이전"><img src="/sjpb/images/calendar_perv.gif" alt="이전 날짜로 이동" /></a><span id="calTitleSpan"></span>         
		    <a class="calendar_next" id="calendar_next" href="javascript:void(0);" title="이전"><img src="/sjpb/images/calendar_next.gif" alt="다음 날짜로 이동" /></a>
		</div>
		
		<div class="popup_listArea" id="listAreaContents">
			<%-- 그리는 영역 --%>
        </div>
		
		<h4>요청정보</h4>
        <div class="list" id="contentsArea">
        	<input type="hidden" id="forsInveReqSiNum" name="forsInveReqSiNum" value="" />
	   		<input type="hidden" id="forsInveReqMb" name="forsInveReqMb" value="" />
	   		
	   		<input type="hidden" id="schdMngSiNum" name="schdMngSiNum" value="" />
	   		
            <table class="list" cellpadding="0" cellspacing="0">
                <caption>요청정보</caption>
                <colgroup>
                    <col width="20%" />
                    <col width="40%" />
                </colgroup>
             <tbody>
             	 <tr>
                     <th class="C th_line ">날짜</th>
                     <td class="L td_line "><span class="title" id="inveDate"></span></td>
               	 </tr>
                 <tr>
                     <th class="C th_line ">상태</th>
                     <td class="L td_line ">
                         <div class="inputbox w50per">
                             <div class="txt"></div>
                             <select name="forsInveReqStatCd">
                                 <option value="01">요청</option>
								 <option value="02">확정</option>
								 <option value="99">지원불가</option>
                             </select>   
                         </div>    
                     </td>
                 </tr>
                 
                 <%-- 일반 요청 화면 시작 data-name = "reqbk" --%>
                 <tr data-name = "reqbk">
                     <th class="C th_line ">요청일</th>
                     <td class="L td_line ">
                         <label for="txt_02"></label><input type="text" class="w20per calendar datepicker" id="txt_02" name="inveReqBeDt" title="요청시작일" data-type="dateFront"/> ~ 
                         <label for="txt_03"></label><input type="text" class="w20per calendar datepicker" id="txt_03" name="inveReqEdDt" title="요청종료일" data-type="dateBack"/>
                     </td>
                 </tr>
                 <tr name="reqMbNmTR1" data-name = "reqbk" data-role = "DGT_FRS_role">
                	 <%-- 일반수사관화면 --%>
                     <th class="C th_line ">요청자 이름</th>
                     <td class="L td_line "><span class="title" id="forcInveReqMbNm_TR1"></span></td>
                </tr>
                 <tr name="reqMbNmTR2" data-name = "reqbk" data-role = "INVIGTOR_role" style="display:none;">
                	 <%-- 포렌식담당자화면 --%>
                     <th class="C th_line ">요청자 이름</th>
                     <td class="L td_line ">
                         <p class="searchinput w60per">
                             <label for="search_01"></label><input type="text" class="w100per" id="search_01" name="forcInveReqMbNm_TR2" data-readonly="y" disabled="true"/><a class="btn_search" href="javascript:setForcInveReqMbNm();"><img src="/sjpb/images/btn_search.png" alt="search" /></a>
                         </p>    
                     </td>
                </tr>
                 <tr data-name = "reqbk">
                     <th class="C th_line ">지역</th>
                     <td class="L td_line "><label for="txt_04"></label><input type="text" class="w40per" id="txt_04" name="dtaCollArea"/></td>
                 </tr>
                 <tr data-name = "reqbk">
                     <th class="C th_line ">사건번호</th>
                     <td class="L td_line "><label for="txt_05"></label><input type="text" class="w40per" id="txt_05" name="incNum" title="사건번호" data-type="required"/></td>
                 </tr>
                 <tr data-name = "reqbk">
                 	<th class="C th_line">비고</th>
                     <td class="L td_line"><textarea  id="reqComn" name="reqComn" cols="" rows=""></textarea></td>
                 </tr>
                 <%-- 일반 요청 화면 끝 --%>
                 
                 
                 
                 
                 <%-- 지원불가 화면 시작 data-name = "offischdmng" --%>
                 <tr data-name = "offischdmng" style="display:none;">
                     <th class="C th_line ">지원불가일</th>
                     <td class="L td_line ">
                         <label for="txt_32"></label><input type="text" class="w20per calendar datepicker" id="txt_32" name="schdBeDt" title="지원불가시작일" data-type="dateFront"/> ~ 
                         <label for="txt_33"></label><input type="text" class="w20per calendar datepicker" id="txt_33" name="schdEdDt" title="지원불가종료일" data-type="dateBack"/>
                     </td>
                 </tr>
                 <tr data-name = "offischdmng" style="display:none;">
                     <th class="C th_line ">사유</th>
                     <td class="L td_line "><label for="txt_35"></label><input type="text" class="w40per" id="txt_35" name="schdRsn"/></td>
                 </tr>
                 <tr data-name = "offischdmng" style="display:none;">
                 	<th class="C th_line">비고</th>
                     <td class="L td_line"><textarea  id="schdComn" name="schdComn" cols="" rows=""></textarea></td>
                 </tr>
                 <%-- 지원불가 화면 끝 --%>
             </tbody>
       		</table>
       	</div>
        <div class="btnArea" data-name = "reqbk">
        	<div class="r_btn" id="reqbkBtnAreaDiv">
        		<%-- 그리는 영역 
            	<a href="#" class="btn_grey"><span>확정</span></a><a href="#" class="btn_blue"><span>수정</span></a><a href="#" class="btn_white"><span>취소</span></a>
            	--%>
            </div>
        </div>
        
        <div class="btnArea" data-name = "offischdmng" style="display:none;">
        	<div class="r_btn" id="offischdmngBtnAreaDiv">
        		<%-- 그리는 영역 
            	<a href="#" class="btn_grey"><span>확정</span></a><a href="#" class="btn_blue"><span>수정</span></a><a href="#" class="btn_white"><span>취소</span></a>
            	--%>
            </div>
        </div>
		
	</body>
</html>
