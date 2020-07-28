<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="cafe_info_wrap" id="cafe_info_wrap">
	<div class="CF0301_bgColor CF0301_brdrColor CF0301_brdrWidth cafe_info" id="div_cafe_info">
		<div class="cafeinfo_layer cafeinfo_default">
			<div class="cafeinfo_row_headline">
				<div class="CF0301_baseFontColor cafeinfo_label_headline cafeinfo_icon"><c:out value="${ cmntVO.imgCmntLevel }" escapeXml="false"/><strong><c:out value="${ cmntVO.cmntLevelNm }"/></strong> (<c:out value="${ cmntVO.openYnNm }"/>)</div>
			</div>
			<div class="cafeinfo_row">
		  		<div class="CF0301_baseFontColor cafeinfo_label">카페지기</div>
		  		<div class="cafeinfo_desc cafeinfo_link"><a class="CF0301_valFontColor" href="#"><c:out value="${cmntVO.makerIdNm}"/></a></div>
			</div>
			<div class="cafeinfo_row">
				<div class="cafeinfo_label cafeinfo_link"><a class="CF0301_baseFontColor" href="#">회원수</a></div>
				<div class="cafeinfo_desc cafeinfo_link"><a class="CF0301_valFontColor" href="#"><c:out value="${cmntVO.mmbrTotCF}"/></a></div>
			</div>
			<div class="cafeinfo_row">
				<div class="cafeinfo_label cafeinfo_link"><a class="CF0301_baseFontColor" href="#">방문수</a></div>
				<div class="cafeinfo_desc cafeinfo_link"><a class="CF0301_valFontColor" href="#"><c:out value="${cmntVO.hitTodayCF}"/></a></div>
				<div class="cafeinfo_desc cafeinfo_sub_link"><a class="CF0301_baseFontColor cafeinfo_opacity" onclick="cfInfo.showProfile()">프로필</a></div>
			</div>
		</div>
		<div class="CF0301_baseFontColor CF0301_sepBrdrColor cafeinfo_seperater cafeinfo_opacity"></div>
		<div class="cafeinfo_layer cafeinfo_small_button">
			<div class="cafeinfo_row">
				<div class="CF0301_myInfoButton cafeinfo_myInfoButton cafeinfo_myInfo" id="myinfo_arrow"<c:if test="${ mmbrVO.isMmbr }">onclick="cfInfo.showMyInfo('<c:out value="${ mmbrVO.isLogin }"/>')"</c:if><c:if test="${ !mmbrVO.isMmbr }">onclick="cfInfo.popupLogin()"</c:if>></div>
				<div class="CF0301_myInfoButton2 CF0301_baseFontColor cafeinfo_myInfoButton2 cafeinfo_myInfo" id="myinfo_arrow2"<c:if test="${ mmbrVO.isMmbr }">onclick="cfInfo.showMyInfo('<c:out value="${ mmbrVO.isLogin }"/>')"</c:if><c:if test="${ !mmbrVO.isMmbr }">onclick="cfInfo.popupLogin()"</c:if>>▼</div>
				<div class="CF0301_baseFontColor cafeinfo_label2 cafeinfo_myInfoText cafeinfo_myInfo" <c:if test="${ mmbrVO.isMmbr }">onclick="cfInfo.showMyInfo('<c:out value="${ mmbrVO.isLogin }"/>')"</c:if><c:if test="${ !mmbrVO.isMmbr }">onclick="cfInfo.popupLogin()"</c:if>>내정보</div>	
			</div>
		</div>
		<c:if test="${mmbrVO.isLogin }">
		<div class="cafeinfo_layer cafeinfo_detail" id="div_cafe_info_myInfo" >
			<!--가입상태이면-->
			<c:if test="${ mmbrVO.isMmbr }">
				<div class="cafeinfo_row_headline">
					<div class="CF0301_baseFontColor cafeinfo_label_headline cafeinfo_icon_small"><c:out value="${ mmbrVO.imgMmbrGrd }" escapeXml="false"/><strong><c:out value="${ mmbrVO.userIdNm }"/></strong></div>
					<!--가입승인된 정상회원만-->
					<c:if test="${ mmbrVO.isPermitMmbr }">
					<div class="cafeinfo_desc cafeinfo_sub_link"><a class="cafeinfo_opacity CF0301_baseFontColor" onclick="cfInfo.showUpdMyInfo()">수정</a></div>
					</c:if>
				</div>
				<c:if test="${ !mmbrVO.isPermitMmbr  && mmbrVO.stateFlag != '11'}">
					<div class="cafeinfo_row"><div class="cafeinfo_label">현재 '<c:out value="${ mmbrVO.stateFlagNm }"/>' 상태입니다.</div></div>
				</c:if>
				<!--가입승인된 정상회원만-->
				<c:if test="${ mmbrVO.isPermitMmbr }">
					<div class="CF0301_baseFontColor cafeinfo_row"><c:out value="${ mmbrVO.mmbrGrdNm }"/></div>
					<div class="cafeinfo_row">
						<div class="cafeinfo_label2 cafeinfo_link"><a class="CF0301_baseFontColor" onclick="cfInfo.go2Mail('<c:out value="${ mmbrVO.userIdNm }"/>');">메일 <span class="CF0301_valFontColor cafeinfo_amount" id="newMailAmount">0</span></a></div>
						<div class="cafeinfo_label2 cafeinfo_link"><a class="CF0301_baseFontColor" onclick="cfInfo.go2Note('<c:out value="${ mmbrVO.userIdNm }"/>');">쪽지 <span class="CF0301_valFontColor cafeinfo_amount" id="newNoteAmount">0</span></a></div>
					</div>
					<!-- div class="cafeinfo_row">
						<div class="cafeinfo_label2 cafeinfo_link"><a class="CF0301_baseFontColor">내가 쓴 글</a></div>
						<div class="cafeinfo_label2 cafeinfo_link"><a class="CF0301_baseFontColor">내 활동 알림</a></div>
					</div-->
					<div class="cafeinfo_row">
						<div class="cafeinfo_label2 cafeinfo_link"><a class="CF0301_baseFontColor" href="javascript:cfInfo.resignCafe()">카페 탈퇴</a></div>
					</div>
				</c:if>
			</c:if>
		</div>
		</c:if>
		<div class="cafeinfo_layer cafeinfo_large_button" id="div_cafe_info_myInfo">
			<c:if test="${ !mmbrVO.isMmbr }">
				<div class="cafeinfo_row2">
					<div class="cafeinfo_button"><a class="CF0301_btnFontColor large_button" onclick="cfInfo.regCmntMmbr()"><strong>카페 가입하기</strong></a></div>
				</div>
			</c:if>
			<!--자진탈퇴이거나 가입신청 취소 상태이면-->
			<c:if test="${ mmbrVO.isMmbr && (mmbrVO.stateFlag == '50' || mmbrVO.stateFlag == '11') }">
				<div class="cafeinfo_row2">
					<div class="cafeinfo_button"><a class="CF0301_btnFontColor large_button" onclick="cfInfo.regCmntMmbr()"><strong>카페 다시 가입하기</strong></a></div>
				</div>
			</c:if>
		</div>
		<c:if test="${mmbrVO.isStaff || mmbrVO.isSysop || mmbrVO.isAdmin || cmntVO.makerId == mmbrVO.userId }">
		<div class="CF0301_baseFontColor CF0301_sepBrdrColor cafeinfo_seperater cafeinfo_opacity"></div>
		<div class="cafeinfo_layer cafeifo_management">
			<div class="cafeinfo_row3">
				<div class="cafeinfo_around">
					<div class="CF0301_baseFontColor cafeinfo_label3 cafeinfo_menu cafeinfo_link" onclick="cfInfo.go2Jigi()">관리</div>
					<div class="CF0301_baseFontColor cafeinfo_label3 cafeinfo_pipe cafeinfo_opacity">|</div>
					<div class="CF0301_baseFontColor cafeinfo_label3 cafeinfo_menu cafeinfo_link" id="cafeInfo_editLink" title="꾸미기" onclick="javascript:cfInfo.go2EditPage()">꾸미기</div>
				</div>
			</div> 
		</div>
		</c:if>
		<form name="info_form" method="POST"></form>
		<form name="goJigiForm" method="POST" action="" onsubmit="return false;">
			<input type="hidden" id="m" name="m" value="goJigi"/>
			<input type="hidden" id="cmntUrl" name="cmntUrl" value="<c:out value="${ cmntVO.cmntUrl }"/>"/>
		</form>	
		<form id="goEditPage" name="goEditPage" method="POST">
			<input type="hidden" id="isEditMode" name="isEditMode" value="true"/>
		</form>
	</div>
	<c:if test="${menuUse.ggumigiInfo == 'true'}">
		<div class="mask_panel mask_dashed cafeinfo_mask" id="cafeinfo_mask">
			<div class="mask_button">꾸미기</div>
			<div class="mask_layer" id="cafeinfo_mask_layer"></div>
		</div>
	</c:if>
	<c:if test="${menuUse.ggumigiInfo == 'false'}">
		<div class="mask_panel cafeinfo_mask" id="cafeinfo_mask">
			<div class="mask_layer2" id="cafeinfo_mask_layer"></div>
		</div>
	</c:if>
</div>
<div class="blank_area"></div>
<input type="hidden" id="infoDecoPrefs" name="infoDecoPrefs" value="[ 
<c:forEach items="${decoPrefs}" var="deco" varStatus="status">
{ clazz:'<c:out value="${deco.decoType}"/>_<c:out value="${deco.name}"/>', value:'<c:out value="${deco.value}"/>'}<c:if test="${!status.last}">,</c:if>
	</c:forEach>
]"/>
<input type="hidden" id="CF0301_template">
<input type="hidden" id="CF0301_decoId">
<script type="text/javascript">
 	var infoBox = cfEach.getInfoBox();
   	infoBox.m_on = "client";
   	infoBox.m_target = "info";
   	infoBox.m_cmd = "deco";
   	infoBox.m_decoPrefs = eval("(" + $('#infoDecoPrefs').val() + ")");
   	infoBox.m_isOrg = 'true';
   	cfEach.sendCommand(infoBox);
   	
   	var orgDecoId = cfInfo.getDeco().getOrgDecoPrefValue('CF0301_template');
	$('#CF0301_template').val(orgDecoId);
	
	cfInfo.setEditable(<c:out value="${menuUse.ggumigiInfo}"/>);
</script>
