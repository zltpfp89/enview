<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>enCafe:: enView5 Community</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/cola/cafe/css/home/encafe.css" />
		<c:if test="${empty requestScope.windowId}">
		<%--포틀릿으로서 동작하고 있지 않을 때에는 enView의 Javascript를 포함시켜준다--%>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portlet.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
		<!--script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/messageResource_<c:out value="${secPmsnVO.locale}"/>.js"></script-->
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_ko_mm.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_ko_cf.js"></script>
		<link type="text/css" href="<%=request.getContextPath()%>/decorations/layout/css/jquery/base/jquery.ui.all.css" rel="stylesheet" />

		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/ui/i18n/jquery.ui.datepicker-ko.js"></script>
		</c:if>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_util.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/home/encafe.js"></script>
	</head>
	<body>
		<div id="wrap">
			<div id="header">
				<h1><a href="<%=request.getContextPath()%>/cafe"><img src="<%=request.getContextPath()%>/cola/cafe/images/home/encafe/logo.gif" alt="en카페" /></a></h1>
				<!-- 검색영역 -->
				<fieldset>
					<legend>검색영역</legend>
					<div class="searchArea">
						<form method="post" id="srchCafeForm" name="srchCafeForm" onsubmit="cfHome.searchCafeList(); return false;">
							<div class="searchBg">
								<select id="srchType" name="srchType">
									<option value="nm" <c:if test="${homeForm.srchType == 'nm'}">selected</c:if>><util:message key="cf.title.cafe.name"/><%--카페이름--%></option>
									<option value="tag" <c:if test="${homeForm.srchType == 'tag'}">selected</c:if>><util:message key="cf.title.cafe.tag"/><%--카페태그-%></option>
								</select>
								<input type="text" id="srchKey" name="srchKey" value="<c:out value="${homeForm.srchKey}"/>" />
								<input type="hidden" id="srchSort" name="srchSort" value="<c:out value="${homeForm.srchSort}"/>"/> 
								<input type="hidden" id="pageSize" name="pageSize" value="5"/>
							</div>
							<input type="image" name="btn_search" id="btn_search" src="<%=request.getContextPath()%>/cola/cafe/images/home/encafe/btn_search.gif" onclick="cfHome.searchCafeList()"/>
						</form>
					</div>
				</fieldset>
			</div>
			<!-- gnb -->
			<div id="gnb">
				<ul>
					<li class="first"><a href="javascript:cfHome.initCafeHome('')">카페홈</a></li>
					<li><a href="javascript:cfHome.initCafeHome('mine.all')">내카페</a></li>
					<li><a href="javascript:cfHome.initCafeHome('cate.init')"><util:message key="mm.title.category"/><%--카테고리--%></a></li>
				</ul>
			</div>
			<!-- gnb//-->
			<!-- container -->
			<div id="container">
				<div id="LeftArea">
					<c:if test="${mmbrVO.isLogin}">
						<div id="login_user">
							<p class="user"><strong><c:out value="${mmbrVO.loginInfo.nm_kor }"/>님</strong> 환영합니다.</p>
							<p class="infoarea">
								<span>메일 <a href="#">300</a>통</span>
								<span class="massege">쪽지 <a href="<%=request.getContextPath()%>/note/note.hanc" target="_blank"><span id="newNoteAmount">0</span></a>통</span>
							</p>
							<div class="btn_area">
								<span class="btn_basic"><a href="javascript:cfHome.uiMakeCafe()">카페 만들기</a></span>
								<!-- span class="btn_basic"><a href="javascript:cfHome.initCafeHome('mine.all')">내 카페목록</a></span-->
								<span class="btn_basic"><a class="makeCafeLink" href="<c:out value="${logoutUrl }"/>">로그아웃</a></span>
							</div>
						</div>
					</c:if>
					<c:if test="${!mmbrVO.isLogin}">
						<div id="loginbox">
						<span><a href="<%=request.getContextPath()%>/user/ajaxJoin.face"><strong>회원가입</strong></a></span><span class="find"><a href="<%=request.getContextPath()%>/user/help.face">아이디/비밀번호찾기</a></span>
						<fieldset>
							<legend>로그인영역</legend>
							<p class="uid"><input type="text" id="userid" class="userid" value="아이디" onfocus=""/></p>
							<p class="upw"><input type="password" id="pwd" class="userpw" value="비밀번호"  onfocus="" onkeyup="cfHome.login();"/></p>
							<p class="ubtn"><input type="image" id="btn_login" class="btn_login" src="<%=request.getContextPath()%>/cola/cafe/images/home/encafe/btn_login.gif" onclick="cfHome.login();" /></p>
							<p class="uchk"><input type="checkbox" id="saveid" /><label for="saveid">아이디저장</label></p>
						</fieldset>
						</div>
					</c:if>
					<div id="rankArea" class="hitSearch">
						<h2 id="rankName">인기 랭킹</h2>
						<ul id="rankCnttArea"></ul>
						<div class="tsq_page">
							<a href="javascript:cfHome.prevRankCntt();" title="이전" class="rank_prev"><span><img src="<%=request.getContextPath()%>/cola/cafe/images/home/encafe/rank_prev.gif" alt="이전" /></span></a>
							<a href="javascript:cfHome.nextRankCntt();" title="다음" class="rank_next"><span><img src="<%=request.getContextPath()%>/cola/cafe/images/home/encafe/renk_next.gif" alt="다음" /></span></a>
						</div>
					</div>
					<div id="mineMenuArea" class="hitSearch">
						<ul style="list-style-type: none">
							<li style="padding: 5px 10px 5px 0px; cursor: pointer; width: 100%;"
								onclick="cfHome.initCafeHome('mine.all')">내 카페 목록</li>
							<li style="padding: 5px 10px 5px 0px; cursor: pointer; width: 100%;"
								onclick="cfHome.initCafeHome('mine.favor')">자주가는 카페</li>
							<li style="padding: 5px 10px 5px 0px; cursor: pointer; width: 100%;"
								onclick="cfHome.initCafeHome('mine.wait')">가입 신청한 카페 목록</li>
						</ul>
					</div>
					<div id="cateMenuArea" class="cateMenuArea">
						<ul style="list-style-type: none">
							<li></li>
						</ul>
					</div>
				</div>
				<div id="RightArea">
					<div id="notice">
						<div id="cnttTopArea" class="tab_wrap m1"></div>
						<div id="cntt2ndArea" class="tab_wrap m1" style="display: none;"></div>
	  					<div id="cntt3rdArea" class="tab_wrap m1" style="display: none;"></div>
					</div>
				</div>
			</div>
			<div id="footer">
				<p>COPYRIGHT(C) 2012 SALTWARE.CO.LTD. ALL RIGHT RESERVED.</p>
			</div>
		</div>
		<script type="text/javascript">
			var isLogin = false;
			<c:if test="${mmbrVO.isLogin}">
			isLogin = true;
			</c:if>
			cfHome.initCafeHome('<c:out value="${homeForm.initView}"/>', isLogin);		
		</script>
	</body>
</html>