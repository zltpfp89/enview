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
			//alert("prevWeek: ["+prevWeek+"]");
			$('#selectDate').val(prevWeek);
			//$('#in_rsrc_id').val(126); // 테스트를 위해 in_rsrc_id 값 임시 setting
			//alert("selectDate: ["+document.frm.selectDate.value+"]");
			document.frm.submit();
		}

		function nextWeekSearch(nextWeek) //일주일 후 검색
		{
			//alert("nextWeek: ["+nextWeek+"]");
			$('#selectDate').val(nextWeek);
			//$('in_rsrc_id').val(126); // 테스트를 위해 in_rsrc_id 값 임시 setting
			//alert("selectDate: ["+document.frm.selectDate.value+"]");
			document.frm.submit();
		}
	</script>
</head>

<body class="">
	<c:set var="in_rsrc_id"><c:out value="${in_rsrc_id == null?0:in_rsrc_id}"/></c:set>
	<div class="sub_container">
					
	<!-- content start -->
	<div id="content">
	<h4>자원예약(주간)</h4>

	<!-- 목록상단 -->
	<div class="board_search">
		<script>
			$(function() {
				$( "#search_date_start" ).datepicker({
					dateFormat: 'yy.mm.dd',
					showOn: "both",
					buttonImage: "${cPath }/sjpb/reference/images/icon_calendar.png",
					buttonImageOnly: true,
					buttonText: "일자선택"
				});
			});
		</script>
		<form name="frm" id="frm" action="/rsrc/selectRsRvWikList.face" method="post" >
			<input name="selectDate" type="hidden" id="selectDate" value="${selectDate}" size="10" maxlength="10">
			<input name="in_rsrc_id" type="hidden" id="in_rsrc_id" value="${in_rsrc_id}">
			<fieldset class="fl">
				<legend>게시물 검색</legend>
				<select name=""  >
					<option>전체부서</option>
				</select>
				<select name=""  >
					<option>자원구분</option>
				</select>
				<select name=""  >
					<option>[0-별관]KRC아트홀</option>
				</select>
				<label for="" class="cursor"><input type="text" id="search_date_start" name="" readonly   class="w80" maxlength="" /> </label>
				<a href="#" class="btn_white"><span class="icon_search"></span>검색</a>
			</fieldset>
	</div>

	<div class="board_top">
		<div class="board_btn_R">
			<a href="#" class="btn_white">월간</a>
			<a href="#" class="btn_white">주간</a>
			<a href="#" class="btn_black">일간</a>
		</div>						
	</div>
	<!-- //목록상단 -->
						
	<!-- 주간 목록 -->
	<table summary="" class="calendar_table_week ">
		<caption></caption>
		<colgroup>
			<col style="width:104px" />
			<col style="width:auto" />
		</colgroup>
		<tbody>
			<tr class="bdb">
				<th rowspan="2" scope="col" class="bdrb">날짜/시간</th>
				<th scope="colgroup" colspan="2">9시</th>
				<th scope="colgroup" colspan="2">10시</th>
				<th scope="colgroup" colspan="2">11시</th>
				<th scope="colgroup" colspan="2">12시</th>
				<th scope="colgroup" colspan="2">13시</th>
				<th scope="colgroup" colspan="2">14시</th>
				<th scope="colgroup" colspan="2">15시</th>
				<th scope="colgroup" colspan="2">16시</th>
				<th scope="colgroup" colspan="2">17시</th>
				<th scope="colgroup" colspan="2">18시</th>
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
			<tr>
		 		<th scope="row"><c:out value="${fn:substring(list.YYYYMMDD,6,8)}"/>(<c:out value="${list.DAY}"/>)</th>
		 <c:forEach items="${list.timeSet}" var="timeSet" varStatus="j">
		  <c:choose>
		   <c:when test="${fn:substring(timeSet,0,2) != 'NO'}">
		   		<td scope="col">
		   </c:when>
		   <c:otherwise>
		   		<td scope="col">
		   </c:otherwise>
		  </c:choose>
		  <c:if test="${timeSet == 'EM'}">

		  </c:if>
				</td>
<!--
			<tr>
				<th scope="row">12(목)</th>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
			</tr>
			<tr>
				<th scope="row">13(금)</th>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
			</tr>
			<tr>
				<th scope="row">14(토)</th>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
			</tr>
			<tr>
				<th scope="row">15(일)</th>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"><div class="confirm" >승인</div></td>
				<td scope="col"><div class="confirm" >승인</div></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
			</tr>
			<tr>
				<th scope="row">16(월)</th>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"><div class="confirm2" >신청</div></td>
				<td scope="col"><div class="confirm2" >신청</div></td>
			</tr>
			<tr>
				<th scope="row">17(화)</th>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
			</tr>
			<tr>
				<th scope="row">18(수)</th>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
				<td scope="col"></td>
			</tr>
  -->
  		 </c:forEach>
  			</tr>
  		</c:forEach>
	<!-- end for -->
		</tbody>
	</table>
	<!-- //주간 목록 -->

	<div class="board_bottom">
		<div class="board_btn_R">
			<a href="#" class="btn_white">월간</a>
			<a href="#" class="btn_white">주간</a>
			<a href="#" class="btn_black">일간</a>
		</div>						
	</div>

	<!-- 페이징 -->
	<div class="board_page">
		<a href="javascript:prevWeekSearch('<c:out value="${prevWeek}"/>');" class="page_prev" id="btn_prev_search" name="btn_prev_search">이전 페이지</a>&nbsp;&nbsp;이전 일주일
		<a href="#"><strong><c:out value="${fromDate}"/></strong></a>
		~
		<a href="#"><strong><c:out value="${toDate}"/></strong></a>
		다음 일주일&nbsp;&nbsp;<a href="javascript:prevWeekSearch('<c:out value="${nextWeek}"/>');" class="page_next" id="btn_next_search" name="btn_next_search">다음 페이지</a>
	</div>
	<!-- //페이징 -->

	<!-- 자원예약 안내 -->
	<ul class="guide_list">
		<li>부재등록 및 조회방법 - 해당 날짜와 시간의 네모칸을 선택하여 등록 및 조회를 하시길 바랍니다.</li>
		<li>아이콘을 클릭하면 상세내역을 보실 수 있습니다. <span class="confirm">타인예약중</span> <span class="confirm2">본인예약중</span> <span class="impossible">사용불가</span></li>
	</ul>
	<!-- // 자원예약 안내 -->
	</div>
	<!-- //content end -->
	</div>
	</div>
	</form>
	</body>
</html>
