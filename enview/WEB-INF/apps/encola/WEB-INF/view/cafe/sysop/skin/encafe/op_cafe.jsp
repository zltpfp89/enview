<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title><c:out value="${cmntVO.cmntNm}"/> - enCafe</title>
	<link href="<%=request.getContextPath()%>/decorations/layout/css/jquery/base/jquery.ui.all.css" type="text/css" rel="stylesheet" />
	<link href="<%=request.getContextPath()%>/cola/cafe/encafe/css/reset.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/cola/cafe/encafe/css/common.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/cola/cafe/encafe/css/layout.css" rel="stylesheet" type="text/css" />
	<%--
	<link rel="stylesheet" href="${cPath}/snu_cafe/css/reset.css"/>
	<link rel="stylesheet" href="${cPath}/snu_cafe/css/common.css"/>
	<link rel="stylesheet" href="${cPath}/snu_cafe/css/layout.css"/>
	 --%>
	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/javascript/jquery/css/redmond/jquery-ui-1.9.2.custom.min.css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery.flexslider.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${cmntVO.langKnd}"/>_mm.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${cmntVO.langKnd}"/>_ev.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${cmntVO.langKnd}"/>_cf.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${cmntVO.langKnd}"/>_eb.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/board/calendar/calendar.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/board/calendar/ko-kr/generatecalendar.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_util.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/home/encafe.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/sysop/encafe.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/encafe/js/js.js"></script>
	<script type="text/javascript" src="${cPath}/javascript/crossdomain.js"></script>
	<!--fckeditor js-->
	<script type="text/javascript" src="<%=request.getContextPath()%>/board/fckeditor/fckeditor.js"></script>
	
	<!--smarteditor js-->
	<script type="text/javascript" src="<%=request.getContextPath()%>/board/smarteditor/js/HuskyEZCreator.js"></script>
	
	<!--dext5editor js-->
	<%--
	<script type="text/javascript" src="<%=request.getContextPath()%>/dext5editor/js/dext5editor.js"></script>
	 
	<script type="text/javascript" >
	// 에디터 로딩 완료시
	function dext_editor_loaded_event(DEXT5Editor) {
		if($("#close_content").val()){
			DEXT5.setBodyValue($("#close_content").val(), DEXT5Editor.editor.ID);
		}else if($("#ntc_content").val()){
			DEXT5.setBodyValue($("#ntc_content").val(), DEXT5Editor.editor.ID);	
		}
	}
	</script>
	 --%>
</head>
<body>

		<div id="edit_menu_bar" class="edit_menu_bar">
			<div id="encafelogo" class="encafelogo">
				<a href="${pageContetx.request.contextPath}/cafe/<c:out value="${cmntVO.cmntUrl}"/>">
				<span class="manage" ><util:message key="cf.title.manageCafe"/></span>
				<span class="name" title="클릭하시면 카페로 이동합니다."><c:out value="${cmntVO.cmntNm}"/></span>
				</a>
			</div>
		</div>

	<div id="container">
		<form name="transferForm" id="transferForm" method="post" action="" onsubmit="return false;">
			<input type="hidden" id="m"  name="m" />
			<input type="hidden" id="cmntId" name="cmntId"  value="<c:out value="${cmntVO.cmntId}"/>"/>
			<input type="hidden" id="cmntUrl" name="cmntUrl" value="<c:out value="${cmntVO.cmntUrl}"/>"/>
			<input type="hidden" id="langKnd" name="langKnd" value="<c:out value="${opForm.langKnd}"/>"/>
		</form>
		<div class="content">
			<div class="cafe_side_area">					
				<!-- 왼쪽메뉴 start -->
				<div class="content_left">
					<%--
					<h3><util:message key="cf.title.manageCafe"/></h3>
					 --%>
					<div class="lnb">
						<ul class="lnb_dep11">
							<li><a href="#"  class="off"><util:message key="cf.title.manageCafeInfo"/><button><util:message key="cf.title.subMenu"/></button></a>
								<ul class="lnb_dep12">
									<li><a href="javascript:cfOp.chgOpArea('baseInfo')"><util:message key="cf.title.basicInfo"/></a></li>
									<li><a href="javascript:cfOp.chgOpArea('regInfo')"><util:message key="cf.title.joinInfo"/></a></li>
								</ul>
							</li>
							<li><a href="#"><util:message key="cf.title.mng.menuBoard"/><button><util:message key="cf.title.subMenu"/></button></a>
								<ul class="lnb_dep12">
									<li><a href="javascript:cfOp.chgOpArea('menuMng')"><util:message key="cf.title.mng.menu"/></a></li>
									<li><a href="javascript:cfOp.chgOpArea('bltnMng')"><util:message key="cf.title.mng.board"/></a></li>
								</ul>
							</li>
							<li><a href="#"><util:message key="cf.title.mng.memberInfo"/><button><util:message key="cf.title.subMenu"/></button></a>
								<ul class="lnb_dep12">
									<li><a href="javascript:cfOp.chgOpArea('regMmbr')"><util:message key="cf.title.mng.cafeMember"/></a></li>
									<li><a href="javascript:cfOp.chgOpArea('brdSysop')"><util:message key="cf.title.mng.cafeSysop"/></a></li>
									<li><a href="javascript:cfOp.chgOpArea('rsgnMmbr')"><util:message key="cf.title.mng.secessionMember"/></a></li>
									<li><a href="javascript:cfOp.chgOpArea('mmbrGrd')"><util:message key="cf.title.mmbrLevel"/></a></li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
				<!-- //왼쪽메뉴 end -->
			</div>

			
			<div class="cafe_content_area">
				<div id="opArea">
					<ul class="cafeadm_main_state bm30">
						<li class="visit">
							<div class="title"><util:message key="cf.title.today"/> <span><util:message key="cf.title.visitorsCnt"/></span></div>
							<div class="count"><c:out value="${opForm.todayVisitCntCF}"/></div>
						</li>
						<li class="join">
							<div class="title"><util:message key="cf.title.today"/> <span><util:message key="cf.title.newMemberCnt"/></span></span></div>
							<div class="count"><c:out value="${opForm.todayRegCntCF}"/></div>
						</li>
						<li class="post">
							<div class="title"><util:message key="cf.title.today"/> <span><util:message key="cf.title.bltn"/></span></div>
							<div class="count"><c:out value="${opForm.todayBltnCntCF}"/></div>
						</li>
					</ul>

					<!-- //카페기본정보 start -->

					<div class="board_btn_wrap">
						<div class="board_btn_wrap_left">
							<h3 class="cafeadm_title"><util:message key="cf.title.cafe.basicInfo"/></h3>
						</div>
					</div>
					<table class="cafeadm_main_info " summary="<util:message key="cf.title.cafe.name"/><%--카페이름--%>, <util:message key="mm.title.category"/><%--카테고리--%>, 검색어">
						<colgroup>
							<col width="100px" />
							<col width="auto"  />
							<col width="100px" />
						</colgroup>
						<tbody>
							<tr>
								<th><util:message key="cf.title.cafe.name"/><%--카페이름--%></th>
								<td><c:out value="${cmntVO.cmntNm}"/></td>
							</tr>
							<tr>
								<th><util:message key="mm.title.category"/><%--카테고리--%></th>
								<td><c:out value="${cmntVO.cateIdNm}"/></td>
							</tr>
							<tr>
								<th><util:message key="cf.title.cafe.tag"/><%--카페태그--%></th>
								<c:forEach items="${tagList}" var="tag" varStatus="status">
									<td><c:out value="${tag.tag}"/></td>
								</c:forEach>
							</tr>
						</tbody>
					</table>
					<!-- //카페기본정보 end -->

					<!-- //카페관리 end -->
				</div>
			</div>
		</div>
	</div>
	
	<%--게시판 지기 화면을 띄울 DIV--%>
	<div id="brdUserChooser" title="<util:message key="eb.title.userChooser"/>"></div>
	<%--가입상태 변경 사유 관리 화면을 띄울 DIV--%>
	<div id="stateCodeGetter" title="<util:message key="cf.title.change.memberLevel"/>"></div>
</body>
<script type="text/javascript">
	if (!portalPage) portalPage = new enview.portal.Page();
	portalPage.m_contextPath = ebUtil.getContextPath();
</script>
</html>
