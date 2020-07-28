<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title><c:out value="${cmntVO.cmntNm}"/> - <util:message key="cf.title.system"/></title>
	
	
	<link href="<%=request.getContextPath()%>/cola/cafe/css/sysop/encafe.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/board/calendar/css/calendar.css" type="text/css" rel="stylesheet" />
	<link href="<%=request.getContextPath()%>/decorations/layout/css/jquery/base/jquery.ui.all.css" type="text/css" rel="stylesheet" />
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portlet.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${cmntVO.langKnd}"/>_mm.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${cmntVO.langKnd}"/>_ev.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${cmntVO.langKnd}"/>_cf.js"></script>
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/board/calendar/calendar.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/board/calendar/ko-kr/generatecalendar.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_util.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/home/encafe.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/sysop/encafe.js"></script>
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/board/fckeditor/fckeditor.js"></script>
	
	<!--smarteditor js-->
	<script type="text/javascript" src="<%=request.getContextPath()%>/board/smarteditor/js/HuskyEZCreator.js"></script>
</head>
<body>
	<!-- header -->
	<div id="wrap">
		<div id="header">
			<div id="adminLogo">
				<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/adminLogo.gif" onclick="cfOp.goJigi();"/>
				<span class="name" onclick="javascript:cfOp.goEachHome();"><c:out value="${cmntVO.cmntNm}"/></span>
				<span class="btn_hlpe">
					<a href="#">
						<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/btn_help.gif" alt="도움말"/>
					</a>
				</span>
			</div>
		</div>
		<!-- header//-->
		<!-- container -->
		<div id="container">
			<form name="transferForm" id="transferForm" method="post" action="" onsubmit="return false;">
				<input type="hidden" id="m"  name="m" />
				<input type="hidden" id="cmntId" name="cmntId"  value="<c:out value="${cmntVO.cmntId}"/>"/>
				<input type="hidden" id="cmntUrl" name="cmntUrl" value="<c:out value="${cmntVO.cmntUrl}"/>"/>
				<input type="hidden" id="langKnd" name="langKnd" value="<c:out value="${opForm.langKnd}"/>"/>
			</form>
			<!-- menu -->
			<div class="adminMenu">
				<ul class="menu">
					<!--title 변경시 이미지 태그 삭제후 텍스트 입력 -->
					<li class="title"><img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/titile_info.gif" alt="카페정보관리"/>
						<ul class="dept1">
							<li><a href="javascript:cfOp.chgOpArea('baseInfo')">기본정보</a></li>
							<li><a href="javascript:cfOp.chgOpArea('regInfo')">가입정보</a></li>
						</ul>
					</li>
						<li class="title"><img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/titile_menu.gif" alt="메뉴/게시판관리"/>
						<ul class="dept1">
							<li><a href="javascript:cfOp.chgOpArea('menuMng')">메뉴관리</a></li>
							<li><a href="javascript:cfOp.chgOpArea('bltnMng')">게시글관리</a></li>
						</ul>
					</li>
						<li class="title"><img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/titile_member.gif" alt="회원정보관리"/>
						<ul class="dept1">
							<li><a href="javascript:cfOp.chgOpArea('regMmbr')">가입회원</a></li>
							<li><a href="javascript:cfOp.chgOpArea('brdSysop')">게시판지기</a></li>
							<li><a href="javascript:cfOp.chgOpArea('rsgnMmbr')">탈퇴회원</a></li>
							<li><a href="javascript:cfOp.chgOpArea('mmbrGrd')">회원등급</a></li>
						</ul>
					</li>
				</ul>
			</div>
			<!-- menu//-->
			<!-- contents -->
			<div id="opArea" class="contents">
				<div class="main_flash_tot">
					<img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/admin_121226_19.gif" />
				</div>
				<div class="admin_cafeinfo">
					<!-- h3 변경시 이미지 태그 삭제후 텍스트 입력 -->
					<h3><img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/cafebasic.gif" alt="카페 기본 정보" /></h3>
					<ul class="dept1">
						<li>
							<span class="fL">
								<label>카페이름</label>
								<span class="info"><c:out value="${cmntVO.cmntNm}"/></span>
							</span>
							<a href="#"><img class="btn_g" src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/btn_change.gif" alt="변경가능"/></a>
						</li>
						<li>
							<span class="fL">
							<label>카테고리</label>
							<span class="info"><c:out value="${cmntVO.cateIdNm}"/></span>
							</span>
							<a href="#"><img class="btn_g" src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/btn_change.gif" alt="변경가능"/></a>
						</li>
						<li>
							<span class="fL">
							<label>검색어</label>
							<c:forEach items="${tagList}" var="tag" varStatus="status">
								<span class="info"><c:out value="${tag.tag}"/></span>
								<c:if test="${status.last}"><span class="info"></span></c:if>
							</c:forEach>
							</span>
							<a href="#"><img class="btn_g" src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/btn_change.gif" alt="변경가능"/></a>
						</li>
					</ul>
				</div>
			</div>
			<!-- contents//-->
		</div>
		<!-- contanier//-->
	</div>
	<!-- footer -->
	<div id="footer">
		<p>COPYRIGHT(C) 2012 SALTWARE.CO.LTD. ALL RIGHT RESERVED.</p>
	</div>
	<!-- footer//-->
	
	<%--게시판 지기 화면을 띄울 DIV--%>
	<div id="brdUserChooser" title="<util:message key="eb.title.userChooser"/>"></div>
	<%--가입상태 변경 사유 관리 화면을 띄울 DIV--%>
	<div id="stateCodeGetter" title="회원 상태 변경 관리"></div>
</body>
<script type="text/javascript">
	if (!portalPage) portalPage = new enview.portal.Page();
	portalPage.m_contextPath = ebUtil.getContextPath();
</script>
</html>
