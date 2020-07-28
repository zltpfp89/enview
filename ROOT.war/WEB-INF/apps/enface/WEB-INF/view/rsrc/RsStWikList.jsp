<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>:: 경기신용보증재단 ::</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/reference/css/reset.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/reference/css/common.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/reference/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/reference/css/main.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/reference/css/sub.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/reference/css/calendar.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/reference/js/jquery.js" ></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/reference/js/main.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/reference/js/slider.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/reference/js/calendar.js"></script>
	<!--[if lt IE 9]>
	<script type="text/javascript"  src="${pageContext.request.contextPath}/sjpb/reference/js/html5.js"></script>
	<script type="text/javascript"  src="${pageContext.request.contextPath}/sjpb/reference/js/respond.js"></script>
	<![endif]-->
	<script type="text/javascript">
	function prevWeekSearch(prevWeek) //일주일 전 검색
		{
			$('#selectDate').val(prevWeek);
			$('#frm').attr({action:'/rsrc/selectRsStViewWeekList.face'}).submit();
		}

		function nextWeekSearch(nextWeek) //일주일 후 검색
		{
			$('#selectDate').val(nextWeek);
			$('#frm').attr({action:'/rsrc/selectRsStViewWeekList.face'}).submit();
		}

		/*팝업처리*/
		function doSearchLayer(layer_id){

			var url;
			var sTime = $('#selectTime').val();
			/*
			$('#aaa', parent.document).css("top", ($(window).height() - $('#aaa', parent.document).outerHeight())/2 + $(window).scrollTop());
			$('#aaa', parent.document).css("left", ($(window).width() - $('#aaa', parent.document).outerWidth())/2 + $(window).scrollLeft());
			*/
			$(layer_id, parent.document).draggable();
			$(layer_id, parent.document).show(); // layer팝업 show

			switch (layer_id) {
				case "#inssch" :

				/* 자원예약>자원예약 신청/수정/삭제 Layer Popup 항목 setting Start */
				/*└ Label 항목 Setting Start */
				  $('#inssch', parent.document).find('label[id="lbl_rsrc_nm"]').html("${in_rsrc_nm}");						// : 사용장소
				  $('#inssch', parent.document).find('label[id="lbl_in_user_nm"]').html("${in_user_nm}");					// : 신청자
// 				  $('#inssch', parent.document).find('label[id="lbl_rsrc_lctn"]').html("${in_rsrc_lctn}");					// : 자원위치
				  $('#inssch', parent.document).find('label[id="lbl_rsrc_cnts"]').html("${in_rsrc_cntns}");					// : 자원설명
// 				  $('#inssch', parent.document).find('label[id="inp_rsrc_cnt"]').html("${in_rsrc_cnt}");					// : 좌석수
				  $('#inssch', parent.document).find('label[id="lbl_rsrc_mgt_nm"]').html("${in_rsrc_mgt_nm}");				// : 운영자
				  $('#inssch', parent.document).find('label[id="lbl_rsrc_mgt_dept_nm"]').html("${in_rsrc_mgt_dept_nm}");	// : 운영부서
				  $('#inssch', parent.document).find('label[id="lbl_rsrcddcnt"]').html("${in_rsrc_ddcnt}");					// :신청가능일
				/*┌ Label 항목 Setting End */
				//fn:substring(list.YYYYMMDD,6,8)
				// $('#pstn_modify_frm :input[name="pstn_cd"]').val(param.split(':')[0]);
				// 	                        	<option value="${rprt_list.key}" <c:if test="${rprt_list.key eq sMap.rprt_type}"> selected="selected" </c:if>>${rprt_list.value}</option>
				  $('#inssch_frm #opr_strt_dy', parent.document).val("${fn:substring(selectDate,0,4)}"+"." + "${fn:substring(selectDate,4,6)}" + "." + "${fn:substring(selectDate,6,8)}"); // : 예약시작일자
  				  $('#inssch_frm #opr_end_dy', parent.document).val("${fn:substring(selectDate,0,4)}"+"." + "${fn:substring(selectDate,4,6)}" + "." + "${fn:substring(selectDate,6,8)}");  // : 예약종료일자
  				  $('#inssch_frm #opr_strt_tm', parent.document).val(sTime); // : 예약시작시간
  				  $('#inssch_frm #opr_end_tm', parent.document).val(sTime);  // : 예약종료시간
				/*└ Label, Input 항목(Service 입력 Param) Setting Start */
				/*┌ Label, Input 항목(Service 입력 Param) Setting End */
				/* 자원예약>자원예약 신청/수정/삭제 Layer Popup 항목 setting End */

					
					break;
				case 1 : 	

					break;
				case 2 :

					break;
	   			case 3 :

					break;
				case 4 :

					break;	
			}
		}

		// 레이어팝업 위치 조정
		function setPositionPop (name) {
			$('div[name='+name+']').draggable();
			$('div[name='+name+']').show();
			$('div[name='+name+']').css("top", ($(window).height() - $('div[name='+name+']').outerHeight())/2 + $(window).scrollTop());
			$('div[name='+name+']').css("left", ($(window).width() - $('div[name='+name+']').outerWidth())/2 + $(window).scrollLeft());
		}

    	$(document).ready(function(){
    		var btn_id = "";
    		var btn_index = "";
			// 버튼 이벤트
			$('td[id^="btn_inssch"]').bind('click',function(event){
				var selectTimes=["0900","0930","1000","1030","1100","1130","1200","1230","1300","1330","1400","1430","1500","1530","1600","1630","1700","1730","1800","1830"];
				btn_id = this.id;
				btn_index = btn_id.replace("btn_inssch","");
				var index_j = btn_index.split(":");
	
				//alert("id: [" + btn_id + "], index: [" + btn_index + "]");
				//alert(index_j[1]);
				$('#selectTime').val(selectTimes[Number(index_j[1])]);
				doSearchLayer('#inssch'); // 사용신청 팝업
	    	});

			$('td[id^="btn_modsch"]').bind('click',function(event){
				doSearchLayer('#inssch'); // 사용신청 팝업
	    	});

			//자원예약 신청 팝업 화면의 닫기 Button click Enent
			$('#inssch #btn_close,#inssch .popup_close', parent.document).bind('click',function(event){
				$('#inssch', parent.document).hide();
	    	});
			
			//자원예약 신청 팝업 화면의 신청 Button click Enent
			$('#inssch #btn_insert', parent.document).bind('click',function(event){
				alert("신청 버튼이 클릭됨");
	    	});

			//자원예약 신청 팝업 화면의 수정 Button click Enent
			$('#inssch #btn_update', parent.document).bind('click',function(event){
				alert("수정 버튼이 클릭됨");
	    	});

			//자원예약 신청 팝업 화면의 삭제 Button click Enent
			$('#inssch #btn_delete', parent.document).bind('click',function(event){
				alert("삭제 버튼이 클릭됨");
	    	});

		});
	</script>
</head>

<body width="100%">
	<form name="frm" id="frm" method="post" >
			<input name="selectDate" type="hidden" id="selectDate" value="${selectDate}" size="10" maxlength="10" />
			<input name="in_rsrc_id" type="hidden" id="in_rsrc_id" value="${in_rsrc_id}" />
			<input name="in_user_nm" type="hidden" id="in_user_nm" value="${in_user_nm}" />
			<input name="in_rsrc_nm" type="hidden" id="in_rsrc_nm" value="${in_rsrc_nm}" />
<%-- 			<input name="in_rsrc_lctn" type="hidden" id="in_rsrc_lctn" value="${in_rsrc_lctn}" /> --%>
			<input name="in_rsrc_cntns" type="hidden" id="in_rsrc_cntns" value="${in_rsrc_cntns}" />
<%-- 			<input name="in_rsrc_cnt" type="hidden" id="in_rsrc_cnt" value="${in_rsrc_cnt}" /> --%> 
			<input name="in_rsrc_mgt_nm" type="hidden" id="in_rsrc_mgt_nm" value="${in_rsrc_mgt_nm}" />
			<input name="in_rsrc_mgt_dept_nm" type="hidden" id="in_rsrc_mgt_dept_nm" value="${in_rsrc_mgt_dept_nm}" />
			<input name="in_rsrc_ddcnt" type="hidden" id="in_rsrc_ddcnt" value="${in_rsrc_ddcnt}" />
			<!-- selectTime -->
			<input name="selectTime" type="hidden" id="selectTime" />
	<!-- 주간 목록 -->
	<table summary="" class="calendar_table_week">
		<caption></caption>
		<colgroup>
			<col style="width:104px" />
			<col style="width:auto" />
		</colgroup>
		<tbody>
			<tr class="bdb">
				<th rowspan="2" scope="col">날짜/시간</th>
				<th scope="col" colspan="2">9시</th>
				<th scope="col" colspan="2">10시</th>
				<th scope="col" colspan="2">11시</th>
				<th scope="col" colspan="2">12시</th>
				<th scope="col" colspan="2">13시</th>
				<th scope="col" colspan="2">14시</th>
				<th scope="col" colspan="2">15시</th>
				<th scope="col" colspan="2">16시</th>
				<th scope="col" colspan="2">17시</th>
				<th scope="col" colspan="2">18시</th>
			</tr>
			<tr>
				<th scope="col" class="bdrb">00</th>
				<th scope="col" class="bdrb">30</th>
				<th scope="col" class="bdrb">00</th>
				<th scope="col" class="bdrb">30</th>
				<th scope="col" class="bdrb">00</th>
				<th scope="col" class="bdrb">30</th>
				<th scope="col" class="bdrb">00</th>
				<th scope="col" class="bdrb">30</th>
				<th scope="col" class="bdrb">00</th>
				<th scope="col" class="bdrb">30</th>
				<th scope="col" class="bdrb">00</th>
				<th scope="col" class="bdrb">30</th>
				<th scope="col" class="bdrb">00</th>
				<th scope="col" class="bdrb">30</th>
				<th scope="col" class="bdrb">00</th>
				<th scope="col" class="bdrb">30</th>
				<th scope="col" class="bdrb">00</th>
				<th scope="col" class="bdrb">30</th>
				<th scope="col" class="bdrb">00</th>
				<th scope="col" class="bdrb">30</th>
			</tr>
		<c:forEach items="${list}" var="list" varStatus="i">
			<c:set var="loopJ">0</c:set>
			<tr>
		 		<th scope="row"><c:out value="${fn:substring(list.YYYYMMDD,6,8)}"/>(<c:out value="${list.DAY}"/>)</th>
		 <c:forEach items="${list.timeSet}" var="timeSet" varStatus="j">
		  <c:choose>
		   <c:when test="${fn:substring(timeSet,0,2) != 'NO'}">
		   		<!-- <td scope="col" ><div class="confirm2"><a href="#"  id="btn_inssch" name="btn_inssch">신청</a></div> -->
		   		<td scope="col" style="cursor:pointer;" id="btn_inssch<c:out value='${loopI}'/>:<c:out value='${loopJ}'/>" name="btn_inssch<c:out value='${loopI}'/>:<c:out value='${loopJ}'/>">
		   </c:when>
		   <c:otherwise>
		   		<td scope="col"><div class="confirm"><a href="#"  id="btn_modsch<c:out value='${loopI}'/>:<c:out value='${loopJ}'/>" name="btn_modsch<c:out value='${loopI}'/>:<c:out value='${loopJ}'/>">승인</a></div>
		   </c:otherwise>
		  </c:choose>
		  <c:if test="${timeSet == 'EM'}">
				<!-- a href="#" onFocus='this.blur()'></a> -->
		  </c:if>
				</td>
		 	<c:set var="loopJ"><c:out value="${loopJ+1}"/></c:set>
  		 </c:forEach>
  			</tr>
			<c:set var="loopI"><c:out value="${loopI+1}"/></c:set>
  		</c:forEach>
	<!-- end for -->
		</tbody>
	</table>
	<!-- //주간 목록 -->

	<!-- 페이징 -->
	<div class="board_page">
		<a href="javascript:prevWeekSearch('<c:out value="${prevWeek}"/>');" class="page_prev" id="btn_prev_search" name="btn_prev_search">이전 페이지</a>&nbsp;&nbsp;이전 일주일
		<a href="#"><strong><c:out value="${fromDate}"/></strong></a>
		~
		<a href="#"><strong><c:out value="${toDate}"/></strong></a>
		다음 일주일&nbsp;&nbsp;<a href="javascript:prevWeekSearch('<c:out value="${nextWeek}"/>');" class="page_next" id="btn_next_search" name="btn_next_search">다음 페이지</a>
	</div>
	<!-- //페이징 -->

	</div>
	<!-- //content end -->
	</div>
	</div>
	</form>
	</body>
</html>
