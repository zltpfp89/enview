<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<title><util:message key="cf.title.system"/> Cafe</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	
		<link href="<%=request.getContextPath()%>/cola/cafe/encafe/css/reset.css" rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/cola/cafe/encafe/css/common.css" rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/cola/cafe/encafe/css/layout.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="${cPath}/decorations/layout/css/jquery/base/jquery.ui.all.css" />

		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery.flexslider.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/encafe/js/js.js"></script>		
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_ko_mm.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_ko_cf.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_util.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/home/encafe.js"></script>		
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/crossdomain.js"></script>
		
	</head>
	<body>
	<!-- container -->
			<div id="container" >
			<div style="margin:10px auto;text-align: right;width:1280px;">
					<a href="<%=request.getContextPath()%>/"><util:message key="eb.title.navi.home"/></a> <%--홈 --%>
					| <a href="<%=request.getContextPath()%>/cafe"><util:message key="cf.prop.cafe.home"/></a> <%--카페홈 --%>
			</div>
				<div class="content">
					<div class="cafe_side_area">
						<!-- 개인 start -->
						<div class="cafe_side_member">
							<c:if test="${mmbrVO.isLogin}">
								<div class="cafe_side_member_txt">
									<c:if test="${langKnd=='ko'}">
										<p class="user"><strong><c:out value="${mmbrVO.loginInfo.nm_kor }"/>님</strong> 환영합니다.</p>
									</c:if>
									<c:if test="${langKnd=='en'}">
										<p class="user">Welcome <strong><c:out value="${mmbrVO.loginInfo.nm_eng }"/></strong></p>
									</c:if>
								</div>
								
								<div class="cafe_side_member_btn">
									<a href="javascript:cfHome.uiMakeCafe()" class="btn01"><util:message key="cf.title.makeCafe"/></a>
									<a class="makeCafeLink" href="<c:out value="${logoutUrl }"/>" class="btn01"><util:message key = "ev.title.logout"/></a>
								</div>
							</c:if>
							<c:if test="${!mmbrVO.isLogin}">
								<div id="loginbox">
								<fieldset>
									<legend>로그인영역</legend>
									<p class="uid"><input type="text" id="userid" class="userid" value="아이디" onfocus=""/></p>
									<p class="upw"><input type="password" id="pwd" class="userpw" value="비밀번호"  onfocus="" onkeyup="cfHome.login();"/></p>
									<p class="ubtn"><input type="image" id="btn_login" class="btn_login" src="<%=request.getContextPath()%>/cola/cafe/images/home/encafe/btn_login.gif" onclick="cfHome.login();" /></p>
									<p class="uchk"><input type="checkbox" id="saveid" /><label for="saveid">아이디저장</label></p>
								</fieldset>
								<span><a href="<%=request.getContextPath()%>/user/ajaxJoin.face"><strong>회원가입</strong></a></span><span class="find"><a href="<%=request.getContextPath()%>/user/help.face">아이디/비밀번호찾기</a></span>
								
								</div>
							</c:if>
						</div>
						
						<div id="mineArea" >
							<div class="cafe_side_join tm20">
								<h3><util:message key="cf.title.myCafe"/></h3>
								<div class="flexslider">
									<ul class="slides">
										<c:if test="${empty myAllList}">
											<li class="empty"><util:message key="cf.title.no.cafe"/></li>
										</c:if>
										<c:if test="${!empty myAllList}">
													<c:forEach items="${myAllList}" var="cafe" varStatus="status">
														<c:if test="${status.index mod 5 == 0}">
														<li>
															<ul>
														</c:if>
															<li><a onclick="javascript:cfHome.go2Cafe('<c:out value="${cafe.cmntUrl}"/>');" class="text-overflow"><c:out value="${cafe.cmntNm}"/></a></li>
														<c:if test="${status.count mod 5 == 0}">
															</ul>
														</li>
														</c:if>
													</c:forEach>

												</ul>
											</li>
										</c:if>
									</ul>
								</div>
								<div class="flexslider_count latest_page join">
									<button class="btn prev"><util:message key="ev.title.prevPage"/></button>
										<span class="slide-current-slide"></span>
										<span class="slide-total-slides"></span>
									<button class="btn next"><util:message key="ev.title.nextPage"/></button>
								</div>
								<a href="#" onclick="cfHome.initCafeHome('mine.all')" class="more"><util:message key="ev.prop.more"/></a>
							</div>
						</div>
							
						<div id="rankArea" >
						<!-- 카페순위 start -->
						<div class="cafe_side_rank tm20">
							<div class="flexslider3">
							<ul class="slides">
								<li><h3><util:message key="cf.title.rank.hit"/></h3>
									<div>
										<ol id="HitRankCnttArea">
										</ol>
									</div>
								</li>
								<li><h3><util:message key="cf.title.rank.mile"/></h3>
									<div>
										<ol id="MileRankCnttArea">
										</ol>
									</div>
								</li>
								<li><h3><util:message key="cf.title.rank.mmbr"/></h3>
									<div>
										<ol class="MmbrRankCnttArea">
										</ol>
									</div>
								</li>
							</ul>
							</div>
							<div class="latest_page2 rank">
								<%--
								누를때마다 리플레시
								<button onclick="cfHome.RankCafe();" class="btn prev" ><util:message key="ev.title.prevPage"/></button> 
								<button onclick="cfHome.RankCafe();" class="btn next" ><util:message key="ev.title.nextPage"/></button>
								 --%>
								<button class="btn prev" ><util:message key="ev.title.prevPage"/></button> 
								<button class="btn next" ><util:message key="ev.title.nextPage"/></button>
							</div>
						</div>
						</div>
						
						<div id="mineMenuArea">
							<div class="cafe_menu_wrap tm20">
								<div class="lnb">
									<ul class="lnb_dep1">
										<li><a href="#" onclick="cfHome.initCafeHome('mine.all')"><util:message key="cf.title.myCafe"/></a></li>
										<li><a href="#" onclick="cfHome.initCafeHome('mine.favor')"><util:message key="ev.title.favor.cafe"/></a></li>
										<li><a href="#" onclick="cfHome.initCafeHome('mine.wait')"><util:message key="cf.title.cafe.subscribed"/></a></li>
									</ul>
								</div>
							</div>
						</div>
					
						<div id="cateMenuArea">
							<div class="content_left tm20">
							<h3><util:message key="ev.title.category" /></h3>
							<div class="lnb" id="cateMenuList">
							
							</div>
							</div>
							
						</div>
						
						<div id="bannerArea" >
							<%--
							<div class="cafe_side_banner tm20">
								<a class="bn01" href="#"><util:message key="cf.title.guide"/></a>
								<a class="bn02" href="#"><util:message key="cf.title.report"/></a>
							</div>
							 --%>
						</div>
					</div>
					
				<div class="cafe_content_area">
					
					<!-- 카페검색 start -->
					<div class="cafe_search_wrap">
						<form method="post" id="srchCafeForm" name="srchCafeForm" onsubmit="cfHome.searchCafeList(); return false;">
							<fieldset>
								<legend></legend>
								<div class="cafe_search_text">
									<select id="srchType" name="srchType" style="cursor:pointer;">
										<option value="nm" <c:if test="${homeForm.srchType == 'nm'}">selected</c:if>><util:message key="cf.title.cafe.name"/></option>
										<option value="tag" <c:if test="${homeForm.srchType == 'tag'}">selected</c:if>><util:message key="cf.title.cafe.tag"/></option>
									</select>
									<div class="cafe_search_text_input"><input type="text" id="srchKey" name="srchKey" value="<c:out value="${homeForm.srchKey}"/>" /></div>
									<input type="hidden" id="srchSort" name="srchSort" value="<c:out value="${homeForm.srchSort}"/>"/> 
									<input type="hidden" id="pageSize" name="pageSize" value="5"/>
								</div>
								<input type="submit" class="cafe_search_btn" name="btn_search" id="btn_search" value="<util:message key='eb.title.search'/>" onclick="cfHome.searchCafeList()"/>
							</fieldset>
						</form>
					</div>
					<!-- //카페검색 end -->

					<div id="cnttTopArea"></div>
				</div>
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