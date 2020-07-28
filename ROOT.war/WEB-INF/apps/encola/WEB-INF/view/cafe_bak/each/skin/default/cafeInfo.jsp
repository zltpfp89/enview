<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="div_cafe_info" name="div_cafe_info" class="cafe_info CF0301_brdrColor CF0301_bgColor">
	<dl class="CF0301_baseBrdrColor">
		<dd class="cafeinfo_main CF0301_baseFontColor">
			<span class="cafeinfo_top_tit">
				<c:out value="${cmntVO.imgCmntLevel}" escapeXml="false"/><strong><c:out value="${cmntVO.cmntLevelNm}"/></strong> (<c:out value="${cmntVO.openYnNm}"/>)
			</span>
		</dd>
		<dd>
			<span class="cafeinfo_left_tit">
				<label class="CF0301_baseFontColor">카페지기</label>
			</span>
			<span>
				<a class="link CF0301_valFontColor" href="#"><c:out value="${cmntVO.makerIdNm}"/></a>
			</span>
		</dd>
		<dd>
			<span class="cafeinfo_left_tit">
				<a class="link CF0301_baseFontColor"  href="#">회원수</a>
			</span>
			<span>
				<a class="link CF0301_valFontColor" href="#"><c:out value="${cmntVO.mmbrTotCF}"/></a>
			</span>
		</dd>
		<dd>
			<span class="cafeinfo_left_tit">
				<a class="link CF0301_baseFontColor" href="#">방문수</a>
			</span>
			<span>
				<a class="link CF0301_valFontColor" href="#">
					<c:out value="${cmntVO.hitTodayCF}"/>
				</a>
			</span>
			<a class="right_btn link opacity CF0301_baseFontColor" onclick="cfInfo.showProfile()">프로필</a>
		</dd>
	</dl>
	<dl class="CF0301_baseBrdrColor">
		<dd>
			<span class="myinfo_left_tit">
				<a <c:if test="${mmbrVO.isMmbr}">onclick="cfInfo.showMyInfo('<c:out value="${mmbrVO.isLogin}"/>')"</c:if>>
					<img id="btn_triangle" src="<%=request.getContextPath()%>/cola/cafe/images/skin/default/info/bul_triangle_down.gif" class="btn_myinfo"/>
					<span id="btn_my_info" class="link CF0301_baseFontColor">내 정보</span>
				</a>
			</span>
		</dd>
		<dd>
			<div id="div_cafe_info_myInfo" name="cafe_info_myInfo" style="display:none">
				<dl>
					<dd class="myinfo_main CF0301_baseFontColor">
						<span class="myinfo_top_tit">
							<c:out value="${mmbrVO.imgMmbrGrd}" escapeXml="false"/><strong><c:out value="${mmbrVO.userIdNm}"/></strong>
						</span>
						<span>
							<a class="right_btn link opacity CF0301_baseFontColor" >수정</a>
						</span>
					</dd>
					<dd>
						<span class="myinfo_left_tit CF0301_baseFontColor"><c:out value="${mmbrVO.mmbrGrdNm}"/></span>
					</dd>
					<dd>
						<span class="myinfo_left_tit">
							<a class="link">
								<label class="CF0301_baseFontColor">메일</label>
								<label class="CF0301_valFontColor">0</label>
							</a>
						</span>
						<span>
							<a class="link">
								<label class="rightcon CF0301_baseFontColor">쪽지</label>
								<label class="CF0301_valFontColor">0</label>
							</a>
						</span>
					</dd>
					<dd>
						<span class="myinfo_left_tit">
							<a class="link CF0301_baseFontColor">내가 쓴 글</a>
						</span>
						<span>
							<a class="link CF0301_baseFontColor">내 활동 알림</a>
						</span>
					</dd>
				</dl>
			</div>
		</dd>
		<!--
		<dd class="btn_write">
			<c:if test="${mmbrVO.isMmbr}">
			<p class="btn_pd"><a class="btn_big CF0301_baseFontColor" onclick=""><strong>까페 글쓰기</strong></a></p>
			</c:if>
			<c:if test="${!mmbrVO.isMmbr}">
			<p class="btn_pd"><a class="btn_big CF0301_baseFontColor" onclick="cfInfo.regCmntMmbr()"><strong>까페 가입하기</strong></a></p>
			</c:if>
		</dd>
		-->
		<c:if test="${!mmbrVO.isMmbr}">
		<dd class="btn_write">
			<p class="btn_pd"><a class="btn_big CF0301_baseFontColor" onclick="cfInfo.regCmntMmbr()"><strong>까페 가입하기</strong></a></p>
		</dd>
		</c:if>
	</dl>
	<c:if test="${mmbrVO.isSysop}">
	<p class="admin_menu">
		<span class="mngLink CF0301_baseFontColor" onclick="cfInfo.goJigi()">관리</span>
		<span class="opacity">|</span>
		<span id="editLink" title="꾸미기" class="editLink action pageAction CF0301_baseFontColor" style="cursor:pointer; " onclick="changeMode()">꾸미기</span>
	</p>
	</c:if>
	<form name="goJigiForm" method="POST" action="" onsubmit="return false;">
	  <input type="hidden" id="m" name="m" value="goJigi"/>
	  <input type="hidden" id="cmntUrl" name="cmntUrl" value="<c:out value="${cmntVO.cmntUrl}"/>"/>
	</form>
</div>
<div class="blank_area">
</div>
