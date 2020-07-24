<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<div class="cafe_info_wrap" id="cafe_info_wrap">
	<div class="CF0301_bgColor CF0301_brdrColor CF0301_brdrWidth cafe_info" id="div_cafe_info">
		<div class="cafeinfo_layer cafeinfo_default">
			<div class="cafeinfo_row_headline">
				<div class="CF0301_baseFontColor cafeinfo_label_headline cafeinfo_icon"><c:out value="${ cmntVO.imgCmntLevel }" escapeXml="false"/><strong><c:out value="${ cmntVO.cmntLevelNm }"/></strong> (<c:out value="${ cmntVO.openYnNm }"/>)
				<c:if test="${cmntVO.cmntState != '11' }"><c:out value="${ cmntVO.cmntStateNm }"/></c:if>
				 </div>
			</div>
			<div class="cafeinfo_row">
		  		<div class="CF0301_baseFontColor cafeinfo_label"><util:message key="cf.title.sysop"/></div>
		  		<div class="cafeinfo_desc "><span class="CF0301_valFontColor" ><c:out value="${cmntVO.makerIdNm}"/></span></div>
			</div>
			<div class="cafeinfo_row">
				<div class="cafeinfo_label "><span class="CF0301_baseFontColor" href="#"><util:message key="cf.title.mmbrCnt"/></span></div>
				<div class="cafeinfo_desc "><span class="CF0301_valFontColor" href="#"><c:out value="${cmntVO.mmbrTotCF}"/></span></div>
			</div>
			<div class="cafeinfo_row">
				<div class="cafeinfo_label "><span class="CF0301_baseFontColor" href="#"><util:message key="cf.title.visitCount"/></span></div>
				<div class="cafeinfo_desc "><span class="CF0301_valFontColor" href="#"><c:out value="${cmntVO.hitTotCF}"/></span></div>
				<div class="cafeinfo_desc "><span class="CF0301_baseFontColor cafeinfo_opacity" onclick="cfInfo.showProfile()"><util:message key="cf.title.profile"/></span></div>
			</div>
		</div>
		<div class="CF0301_baseFontColor CF0301_sepBrdrColor cafeinfo_seperater cafeinfo_opacity"></div>
		<div class="cafeinfo_layer cafeinfo_small_button">
			<div class="cafeinfo_row">
				<div class="CF0301_myInfoButton cafeinfo_myInfoButton cafeinfo_myInfo" id="myinfo_arrow"<c:if test="${ mmbrVO.isMmbr }">onclick="cfInfo.showMyInfo('<c:out value="${ mmbrVO.isLogin }"/>')"</c:if><c:if test="${ !mmbrVO.isMmbr }">onclick="cfInfo.popupLogin()"</c:if> style="background-image: url(/cola/cafe/images/each/encafe/info/ic_view.gif);"></div>
				<div class="CF0301_baseFontColor cafeinfo_label2 cafeinfo_myInfoText cafeinfo_myInfo" <c:if test="${ mmbrVO.isMmbr }">onclick="cfInfo.showMyInfo('<c:out value="${ mmbrVO.isLogin }"/>')"</c:if><c:if test="${ !mmbrVO.isMmbr }">onclick="cfInfo.popupLogin()"</c:if>><util:message key="cf.title.myProfile"/></div>	
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
					<div class="cafeinfo_desc cafeinfo_sub_link"><a class="cafeinfo_opacity CF0301_baseFontColor" onclick="cfInfo.showUpdMyInfo()"><util:message key="eb.info.btn.edit"/></a></div>
					</c:if>
				</div>
				<c:if test="${ !mmbrVO.isPermitMmbr  && mmbrVO.stateFlag != '11'}">
					<div class="cafeinfo_row"><div class="cafeinfo_label_headline">
					<c:if test="${langKnd eq 'ko' }">
						<c:if test="${empty mmbrVO.stateCodeNm}"> 
						현재 '<c:out value="${ mmbrVO.stateFlagNm }"/>'</a> 상태입니다.
						</c:if>
						<c:if test="${not empty mmbrVO.stateCodeNm}"> 
						현재 <a class='cafeinfo_link' href="javascript:alert( $('#stateFlagNm').text());">'<c:out value="${ mmbrVO.stateFlagNm }"/>'</a> 상태입니다.
						<span id="stateFlagNm" style="display:none"> 사유는 [ <c:out value="${mmbrVO.stateCodeNm }" /><c:if test="${! empty   mmbrVO.stateDesc}"> : <c:out value="${mmbrVO.stateDesc}"/></c:if> ]입니다 </span>
						</c:if>
					</c:if>
					<c:if test="${langKnd eq 'en' }">
						<c:if test="${empty mmbrVO.stateCodeNm}"> 
						The current status is '<c:out value="${ mmbrVO.stateFlagNm }"/>'.
						</c:if>
						<c:if test="${not empty mmbrVO.stateCodeNm}"> 
						The current status is  <a class='cafeinfo_link' href="javascript:alert( $('#stateFlagNm').text());">'<c:out value="${ mmbrVO.stateFlagNm }"/>'</a>
						<span id="stateFlagNm" style="display:none"> Reason is [ <c:out value="${mmbrVO.stateCodeNm }" /><c:if test="${! empty   mmbrVO.stateDesc}"> : <c:out value="${mmbrVO.stateDesc}"/></c:if> ] </span>
						</c:if>
					</c:if>
					</div></div>
				</c:if>
				<!--가입승인된 정상회원만-->
				<c:if test="${ mmbrVO.isPermitMmbr }">
					<div class="CF0301_baseFontColor cafeinfo_row"><c:out value="${ mmbrVO.mmbrGrdNm }"/></div>
					<!--
					<div class="cafeinfo_row">
						<div class="cafeinfo_label2 cafeinfo_link"><a class="CF0301_baseFontColor" onclick="cfInfo.go2Mail('<c:out value="${ mmbrVO.userIdNm }"/>');">메일 <span class="CF0301_valFontColor cafeinfo_amount" id="newMailAmount">0</span></a></div>
						<div class="cafeinfo_label2 cafeinfo_link"><a class="CF0301_baseFontColor" onclick="cfInfo.go2Note('<c:out value="${ mmbrVO.userIdNm }"/>');">쪽지 <span class="CF0301_valFontColor cafeinfo_amount" id="newNoteAmount">0</span></a></div>
					</div>
					<div class="cafeinfo_row">
						<div class="cafeinfo_label2 cafeinfo_link"><a class="CF0301_baseFontColor">내가 쓴 글</a></div>
						<div class="cafeinfo_label2 cafeinfo_link"><a class="CF0301_baseFontColor">내 활동 알림</a></div>
					</div-->
					<div class="cafeinfo_row">
						<div class="cafeinfo_label2 cafeinfo_link"><a class="CF0301_baseFontColor" href="javascript:cfInfo.resignCafe()"><util:message key="cf.title.cafeSecession"/></a></div>
					</div>
				</c:if>
			</c:if>
		</div>
		</c:if>
		<div class="cafeinfo_layer cafeinfo_large_button" id="div_cafe_info_myInfo">
			<c:if test="${ !mmbrVO.isMmbr && cmntVO.cmntState == '11' }">
				<div class="cafeinfo_row2">
					<div class="cafeinfo_button"><a class="CF0301_btnFontColor large_button" onclick="cfInfo.regCmntMmbr()"><strong><util:message key="cf.prop.do.joinCafe"/></strong></a></div>
				</div>
			</c:if>
			<!--자진탈퇴이거나 가입신청 취소 상태이면-->
			<c:if test="${ mmbrVO.isMmbr && (mmbrVO.stateFlag == '50' || mmbrVO.stateFlag == '11') && cmntVO.cmntState == '11' }">
				<div class="cafeinfo_row2">
					<div class="cafeinfo_button"><a class="CF0301_btnFontColor large_button" onclick="cfHome.getRegMngr().regCmntMmbr('rereg')"><strong><util:message key="cf.title.rejoin.cafe"/></strong></a></div>
				</div>
			</c:if>
		</div>
		<%--
		mmbrVO.isPermitMmbr=${mmbrVO.isPermitMmbr}<br>
		mmbrVO.isStaff=${mmbrVO.isStaff}<br>
		mmbrVO.isSysop=${mmbrVO.isSysop}<br>
		mmbrVO.isAdmin=${mmbrVO.isAdmin}<br>
		cmntVO.makerId=${cmntVO.makerId}<br>
		mmbrVO.userId=${mmbrVO.userId}<br>
		 --%>     
		<c:if test="${ ( mmbrVO.isPermitMmbr &&  mmbrVO.isStaff ) || mmbrVO.isSysop || mmbrVO.isAdmin || cmntVO.makerId == mmbrVO.userId }">
		<div class="CF0301_baseFontColor CF0301_sepBrdrColor cafeinfo_seperater cafeinfo_opacity"></div>
		<div class="cafeinfo_layer cafeifo_management">
			<div class="cafeinfo_row3">
				<div class="cafeinfo_around" <c:if test="${langKnd eq 'en' }">style="width:150px;"</c:if>>
					<div class="CF0301_baseFontColor cafeinfo_label3 cafeinfo_menu cafeinfo_link" onclick="cfInfo.go2Jigi()"><util:message key="cf.prop.admin"/></div>
					<div class="CF0301_baseFontColor cafeinfo_label3 cafeinfo_pipe cafeinfo_opacity">|</div>
					<div class="CF0301_baseFontColor cafeinfo_label3 cafeinfo_menu cafeinfo_link" id="cafeInfo_editLink" title="<util:message key="cf.title.decoration"/>" onclick="javascript:cfInfo.go2EditPage()"><util:message key="cf.title.decoration"/></div>
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
			<div class="mask_button"><util:message key="cf.title.decoration"/></div>
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
<style type="text/css">	
	<c:forEach items="${decoPrefs}" var="deco" varStatus="status">
		<c:out value="${deco.decoType}"/>_<c:out value="${deco.name}"/> : {'<c:out value="${deco.value}"/>'}''
	</c:forEach>
</style>


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
