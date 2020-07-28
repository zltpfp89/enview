<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ include file="rsrc_div.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title>:: 경기신용보증재단 ::</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/reference/css/reset.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/reference/css/common.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/reference/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/reference/css/main.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/sjpb/reference/css/sub.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/reference/js/jquery.js" ></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/reference/js/main.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/reference/js/slider.js"></script>
	<!--[if lt IE 9]>
	<script type="text/javascript"  src="${pageContext.request.contextPath}/sjpb/reference/js/html5.js"></script>
	<script type="text/javascript"  src="${pageContext.request.contextPath}/sjpb/reference/js/respond.js"></script>
	<![endif]-->
	<script type="text/javascript">
	//페이징

	function fn_page(page) {
		var start;
		var end;
		var filter;

		$('#paramPage').val(page);
		$('#frm').submit();
	}

	function chglistCount2() {
		document.frm.listCount.value=document.frm.listCount2.value;
	}

	//자원예약 미리보기열기 스크립트
	var previewTrCtrl = null;
	var cmdImageCtrl = null; 
	function ListView() {}
	//ListView.togglePreview = function (previewTrID, previewDivID, previewUrl, cmdImage, openImage, closeImage) {
	ListView.togglePreview = function (previewTrID, previewDivID, previewUrl, cmdImage) {           // 운영자 이름, 운영자 소속 부서, 신청가능일
		//다른 미리보기 창이 열려 있을경우 닫아준다.

		if (previewTrCtrl != null && previewTrCtrl != document.getElementById(previewTrID)) {
			previewTrCtrl.style.display = "none";
		}

		previewTrCtrl = document.getElementById(previewTrID);
		cmdImageCtrl = document.getElementById(cmdImage);

		if (!previewTrCtrl.style.display || previewTrCtrl.style.display == "block") {
			previewTrCtrl.style.display = "none";
			//cmdImageCtrl.src = openImage;
			
			try {
				var objIfrmPreview = eval(previewTrID + '_ifrmPreview');
				if (objIfrmPreview != null) {
					objIfrmPreview.InitMovie();
				}
			} catch (e) { }
		} else {
			
			var objIfrmPreview = document.getElementById(previewTrID + '_ifrmPreview');
			if( objIfrmPreview == null ) {
				objIfrmPreview = document.createElement("IFRAME");
				objIfrmPreview.id = previewTrID +"_ifrmPreview";
				objIfrmPreview.height='620';
				objIfrmPreview.width='1000';
				//objIfrmPreview.width='100%';
				objIfrmPreview.frameBorder='0px';
				objIfrmPreview.scrolling='yes';
				objIfrmPreview.style.margin='0px';
				objIfrmPreview.src = previewUrl;
				document.getElementById(previewDivID).appendChild(objIfrmPreview);
			}
			previewTrCtrl.style.display = "block";
			//cmdImageCtrl.src = closeImage;
		}
	}

	</script>
</head>

<body class="">
<div class="sub_container">
<!-- content start -->
<div id="content">
	<h4>자원현황</h4>
	<div class="board_search">
		<form name="frm" id="frm" action="/rsrc/selectRsStList.face" method="post" >
			<fieldset>
				<legend>게시물 검색</legend>
				<select name=""  >
					<option>전체부서</option>
				</select>
				<select name=""  >
					<option>자원구분</option>
				</select>
				<label for="" >자원구분</label><input type="text" id="" name="" placeholder="자원구분" />
				<a href="#" class="btn_white"><span class="icon_search"></span>검색</a>
			</fieldset>
		
	</div>
	<!-- 목록상단 -->
	<div class="board_top ">
		<div class="board_btn_L board_total">
			총 <strong><c:out value="${page.total}"/></strong> 건 <strong>(<c:out value="${page.currentPage}"/>/<fmt:formatNumber value="${(page.total%page.listCount)/10>=0.5?(page.total/page.listCount)-((page.total%page.listCount)/10)+1:(page.total/page.listCount)-((page.total%page.listCount)/10)+1}" pattern="#,##"/>)</strong>
			<select name="listCount" id="listCount">
				<option value=10 <c:if test="${page.listCount == 10}">selected="selected"</c:if>>10개</option>
				<option value=20 <c:if test="${page.listCount == 20}">selected="selected"</c:if>>20개</option>
				<option value=50 <c:if test="${page.listCount == 50}">selected="selected"</c:if>>50개</option>
			</select>
		</div>		
		<div class="board_btn_R">
			<a href="#" class="btn_white">삭제</a>
			<a href="#" class="btn_black">등록</a>
		</div>
	</div>
	<!-- //목록상단 -->
	<!-- 목록 -->
	<table class="basic_table " summary="자료공유방 번호, 첨부, 제목, 작성자, 작성부서, 작성일, 조회수를 나타냅니다.">
		<caption>자료공유방 목록</caption>
		<colgroup>
			<col width="80" />
			<col width="*" />
			<col width="110" />

		</colgroup>
		<thead>
			<tr>
				<th scope="col"><input type="checkbox" name="" value="" /></th>
				<th scope="col">자원</th>
				<th scope="col">운영자</th>
<!-- 				<th scope="col">위치</th> -->
<!-- 				<th scope="col" class="last">좌석수</th> -->
			</tr>
		</thead>
		<tbody>
	<c:forEach items="${list}" var="list" varStatus="status">
			<tr class="">
				<td class="num"><input type="checkbox" name="" value="" /></td>
				<td class="subject">
					<div class="subject_reserved">
						<div class="thum">
							<img src="${pageContext.request.contextPath}/sjpb/reference/images/img_subject_reserved.gif" alt="" width="98" height="58" />
							<button name="" title="원본보기" >사진 크게보기</button>
						</div>
						<div class="text">
							<strong><c:out value="${list.rsrc_nm}"/></strong><br/>
							신청: <c:out value="${list.rsrc_ddcnt}"/>일전 / 자원사용: <c:out value="${list.ableYN == 'N'?'불가능':'가능'}"/><c:if test="${list.ableYN == 'N' && list.able_rsn !=''}">(<c:out value="${list.able_rsn}"/>)</c:if>
						</div>
						<div class="btn">
							<a href="#" class="btn_green">사용관리</a>
							<!--<a href='javascript:ListView.togglePreview("trID_<c:out value='${list.rsrc_id}'/>","divtrID_<c:out value='${list.rsrc_id}'/>","/rsrc/selectRsStViewWeekList.face?in_rsrc_id=<c:out value='${list.rsrc_id}'/>","imgID_<c:out value='${list.rsrc_id}'/>");' class="btn_darkorange">예약하기</a>-->
							<a href='javascript:ListView.togglePreview("trID_<c:out value='${list.rsrc_id}'/>","divtrID_<c:out value='${list.rsrc_id}'/>","/rsrc/selectRsStViewWeekList.face?in_rsrc_id=<c:out value='${list.rsrc_id}'/>&in_user_id=<c:out value='${in_user_id}'/>&in_user_nm=<c:out value='${in_user_nm}'/>&in_rsrc_nm=<c:out value='${list.rsrc_nm}'/>&in_rsrc_lctn=<c:out value='${list.rsrc_lctn}'/>&in_rsrc_cntns=<c:out value='${list.rsrc_cntns}'/>&in_rsrc_cnt=<c:out value='${list.rsrc_cnt}'/>&in_rsrc_mgt_nm=<c:out value='${list.rsrc_mgt_nm}'/>&in_rsrc_mgt_dept_nm=<c:out value='${list.rsrc_mgt_dept_nm}'/>&in_rsrc_ddcnt=<c:out value='${list.rsrc_ddcnt}'/>","imgID_<c:out value='${list.rsrc_id}'/>");' class="btn_darkorange">예약하기</a>
						</div>
					</div>
				</td>
				<td class=""><c:out value="${list.rsrc_mgt_nm}"/></td>
<%-- 				<td class=""><c:out value="${list.rsrc_lctn}" /></td> --%>
<%-- 				<td class=""><c:out value="${list.rsrc_cnt}" /></td> --%>
			</tr>
			<!-- 미리보기 iframe 들어가야할 곳 -->
			<tr id="trID_<c:out value='${list.rsrc_id}'/>" style="display: none">
				<td colspan="5">
					<div id='divtrID_<c:out value="${list.rsrc_id}"/>'></div>
				</td>
			</tr>
			<!-- 미리보기 iframe 들어가야할 곳 끝-->
	</c:forEach>
		</tbody>
	</table>
	<div class="board_page">
		<a href="#" class="page_prev">이전 페이지</a>&nbsp;이전 일주일
		<a href="#"><strong>11월 12일</strong></a>
		~
		<a href="#"><strong>11월 18일</strong></a>
		다음 일주일&nbsp;<a href="#" class="page_next">다음 페이지</a>
	</div>
	<!-- //목록 -->
	<!-- 목록하단 -->
	<div class="board_bottom">
		<div class="board_btn_L board_total">
			총 <strong><c:out value="${page.total}"/></strong> 건 <strong>(<c:out value="${page.currentPage}"/>/<fmt:formatNumber value="${(page.total%page.listCount)/10>=0.5?(page.total/page.listCount)-((page.total%page.listCount)/10)+1:(page.total/page.listCount)-((page.total%page.listCount)/10)+1}" pattern="#,##"/>)</strong>
			<select name="listCount2" id="listCount2" onchange="javascript:chglistCount2();">
				<option value=10 <c:if test="${page.listCount == 10}">selected="selected"</c:if>>10개</option>
				<option value=20 <c:if test="${page.listCount == 20}">selected="selected"</c:if>>20개</option>
				<option value=50 <c:if test="${page.listCount == 50}">selected="selected"</c:if>>50개</option>
			</select>
		</div>
		<div class="board_btn_R">
			<a href="#" class="btn_white">삭제</a>
			<a href="#" class="btn_black">등록</a>
		</div>
	</div>
		<div class="board_page">
		<c:choose>
			<c:when test="${page.currentPage == 1 }">
				<a href="#allpre" class="page_first">처음</a>
			</c:when>
			<c:otherwise>
				<a href="#allpre" class="page_first" onclick="fn_page(1);">처음</a>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${page.currentBeforePage == 1 }">
				<a href="#pre" class="page_prev">&lt;</a>
			</c:when>
			<c:otherwise>
				<a href="#pre" class="page_prev" onclick="fn_page(${page.currentBeforePage});">&lt;</a>
			</c:otherwise>
		</c:choose>
		<c:if test="${empty list }">
			<a href="#num">1</a>
		</c:if>
		<c:if test="${!empty list  }">
			<c:forEach begin="${page.currentStartPage }" end="${page.currentEndPage }" var="i">
				<c:if test="${page.currentPage != i }"> <!-- 현재 페이지 x -->
					<a href="#num" onclick="fn_page('<c:out value="${i}" escapeXml="true"/>');">${i}</a>
				</c:if>
				<c:if test="${page.currentPage == i }"> <!-- 현재 페이지 o -->
					<a href="#num">${i}</a>
				</c:if>
			</c:forEach>
		</c:if>
		<c:choose>
			<c:when test="${(page.currentNextPage == page.pages && page.pages%page.pageCount != 1) || (page.pages == 1)}">
				<a href="#next" class="page_next">&gt;</a>
			</c:when>
			<c:otherwise>
				<a href="#next" class="page_next" onclick="fn_page(<c:out value="${page.currentNextPage}" escapeXml="true"/>);">&gt;</a>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${page.currentPage == page.pages}">
				<a href="all_ next" class="page_last">마지막</a>
			</c:when>
			<c:otherwise>
				<a href="#all_next" class="page_last" onclick="fn_page(<c:out value="${page.pages}" escapeXml="true"/>);">마지막</a>
			</c:otherwise>

		</c:choose>
	</div>
	<!-- //목하단 -->
</div>
<!-- //content end -->
</div>
<div id="hiddenArea">
	<input type="hidden" id="mode" name="mode" value="<c:out value="${param.mode}" escapeXml="true"/>" />
	<input type="hidden" id="paramPage" name="paramPage" value="<c:out value="${paramPage}" escapeXml="true"/>"/>
</div>
</form>
</body>
</html>
