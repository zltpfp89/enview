<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%--BEGIN::프로파일.탭제어--%>
<c:if test="${empty eachForm.view}">
<div class="cntt_extraInfo_wrap CF0501_nmBrdrColor">
	<div class="cntt_extraInfo_title CF0501_nmBrdrColor">
		<span class="CF0501_nmFontColor"><util:message key="cf.title.cafeProfile"/></span>
	</div>
	<div id="cafeProfileTabs" class="cafeProfileTabs">
		<ul class="tabLabels CF0501_nmBrdrColor">
			<li class="tabLabel CF0501_nmBrdrColor"><a onclick="cfCntt.m_profile.selectTab(0)"><util:message key="cf.title.basicInfo"/></a></li>   
			<li class="tabLabel CF0501_nmBrdrColor"><a onclick="cfCntt.m_profile.selectTab(1)"><util:message key="cf.prop.cmntLang.cmntRule"/></a></li>
		    <!--li><a href="#cafeProfileHistTab" onclick="cfCntt.m_profile.selectTab(2)">히스토리</a></li-->
		    <!--li><a href="#cafeProfileRankTab" onclick="cfCntt.m_profile.selectTab(3)">랭킹정보</a></li-->
		    <!--li><a href="#cafeProfileStaffTab" onclick="cfCntt.m_profile.selectTab(2)">운영진</a></li-->
		</ul>
		<div id="cafeProfileTabContents"></div>
	</div><!--div id="cafeProfileTabs"-->
</div>
</c:if>
<%--END::프로파일.탭제어--%>
<%--BEGIN::프로파일.카페기본정보--%>
<c:if test="${eachForm.view == 'base'}">
	<div class="cntt_profile_wrap">
		<div class="myinfo_wrap">
			<fieldset class="myinfo_field">
				<legend><util:message key="cf.title.basicInfo"/></legend>
				<dl class="reg_form">
					<dt>ㆍ <util:message key="cf.title.cafe.name"/><%--카페이름--%></dt>
					<dd><c:out value="${cmntVO.cmntNm}"/></dd>
				</dl>
				<dl class="reg_form">
					<dt>ㆍ <util:message key="cf.title.cafeAddress"/></dt>
					<dd><c:out value="${cafeFullUrl}"/></dd>
				</dl>
				<dl class="reg_form">
					<dt>ㆍ <util:message key="cf.title.sysop"/></dt>
					<dd><c:out value="${cmntVO.makerIdNm}"/></dd>
				</dl>
				<dl class="reg_form">
					<dt>ㆍ <util:message key="cf.title.mmbrCnt"/>/<util:message key="cf.title.openningDate"/></dt>
					<dd><util:message key="cf.title.mmbrCnt"/> <span class="extraBound CF0501_nmFontColor"><c:out value="${cmntVO.mmbrTotCF}"/></span><span class="extraPipe CF0501_nmFontColor">|</span><util:message key="cf.title.openningDate"/> <span class="extraBound CF0501_nmFontColor"><c:out value="${cmntVO.regDatimSPF}"/></span></dd>
				</dl>
				<dl class="reg_form">
					<dt>ㆍ <util:message key="cf.info.todayActivities"/></dt>
					<dd><util:message key="cf.prop.visit"/> <span class="extraBound CF0501_nmFontColor"><c:out value="${opForm.todayVisitCntCF}"/></span><span class="extraPipe CF0501_nmFontColor">|</span><util:message key="cf.prop.new"/> <span class="extraBound CF0501_nmFontColor"><c:out value="${opForm.todayBltnCntCF}"/></span><span class="extraPipe CF0501_nmFontColor">|</span><util:message key="cf.prop.join"/> <span class="extraBound CF0501_nmFontColor"><c:out value="${opForm.todayRegCntCF}"/></span></dd>
				</dl>
				<dl class="reg_form">
					<dt>ㆍ <util:message key="cf.title.rankingDisclosure"/> </dt>
					<dd><c:out value="${cmntVO.imgCmntLevel}" escapeXml="false"/>&nbsp; <span class="extraBound"><c:out value="${cmntVO.cmntLevel}"/></span>&nbsp;<util:message key="cf.prop.step"/><span class="extraBound2">(<c:out value="${cmntVO.mileTot }"/><util:message key="cf.prop.score"/>)</span><span class="extraPipe CF0501_nmFontColor">|</span><c:out value="${cmntVO.openYnNm}"/></dd>
				</dl>
			</fieldset>
			<fieldset class="myinfo_field lineT CF0501_nmBrdrColor">
				<legend> <util:message key="cf.prop.otherInformation"/></legend>
				<dl class="reg_form">
					<dt>ㆍ <util:message key="mm.title.category"/><%--카테고리--%></dt>
					<dd>
						<c:set var="empty1" value="${true}" />
						<c:set var="empty2" value="${true}" />
						<c:if test="${eachForm.cateHier >= '1'}">
							<c:forEach items="${cmntCateList1}" var="cmntCate1">
								<c:if test="${eachForm.cateId1 == cmntCate1.cateId}"><c:out value="${cmntCate1.cateNm}"/><c:set var="empty1" value="${false}" /></c:if>
							</c:forEach>
						</c:if>
						<!--
							<c:if test="${eachForm.cateHier >= '2'}">
								<c:forEach items="${cmntCateList2}" var="cmntCate2">
									<c:if test="${eachForm.cateId2 == cmntCate2.cateId && cmntCate2.cateId != 3}"><c:if test="${!empty1}">&nbsp;<span class="extraArrow">▶</span>&nbsp;</c:if><c:out value="${cmntCate2.cateNm}"/><c:set var="empty2" value="${false}" /></c:if>
								</c:forEach>
							</c:if>
							<c:if test="${eachForm.cateHier >= '3'}">
								<c:forEach items="${cmntCateList3}" var="cmntCate3">
									<c:if test="${eachForm.cateId3 == cmntCate3.cateId}"><c:if test="${!empty2}">&nbsp;<span class="extraArrow">▶</span>&nbsp;</c:if><c:out value="${cmntCate3.cateNm}"/></c:if>
								</c:forEach>
							</c:if>
						 -->
					</dd>
				</dl>
				<dl class="reg_form">
					<dt>ㆍ <util:message key="cf.title.joiningMethod"/></dt>
					<dd><c:out value="${cmntVO.regTypeNm}"/></dd>
				</dl>
				<dl class="reg_form">
					<dt>ㆍ <util:message key="cf.title.memberMethod"/></dt>
					<dd><c:out value="${cmntVO.nmTypeNm}"/></dd>
				</dl>
				<dl class="reg_form">
					<dt>ㆍ <util:message key="cf.title.cafe.tag"/><%--카페태그--%></dt>
					<dd>
						<c:forEach items="${tagList}" var="tag" varStatus="status">
							<c:out value="${tag.tag}"/><c:if test="${!status.last}">,&nbsp;</c:if>
						</c:forEach>
					</dd>
				</dl>
				<dl class="reg_form">
					<dt>ㆍ <util:message key="cf.title.Introduce"/></dt>
					<dd><c:out value="${cmntVO.cmntIntro}"/></dd>
				</dl>
			</fieldset>
		</div>
	</div>
</c:if>
<%--END::프로파일.카페기본정보--%>
<%--BEGIN::프로파일.카페운영회칙--%>
<c:if test="${eachForm.view == 'rule'}">
	<div class="cntt_profile_wrap">
		<div class="myinfo_wrap">
			<fieldset class="myinfo_field">
				<legend><util:message key="cf.title.basicInfo"/></legend>
				<dl>
					<dd>
						<textarea class="cntt_rule CF0501_nmBrdrColor" readonly="readonly"><c:out value="${langVO.cmntRule}"/></textarea>
					</dd>
				</dl>
			</fieldset>
		</div>
	</div>
</c:if>
<%--END::프로파일.카페운영회칙--%>
<%--BEGIN::프로파일.카페히스토리--%>
<c:if test="${eachForm.view == 'hist'}">
</c:if>
<%--END::프로파일.카페히스토리--%>
<%--BEGIN::프로파일.카페랭킹정보--%>
<c:if test="${eachForm.view == 'rank'}">
</c:if>
<%--END::프로파일.카페랭킹정보--%>
<%--BEGIN::프로파일.카페운영진--%>
<c:if test="${eachForm.view == 'staff'}">
</c:if>
<%--END::프로파일.카페운영진--%>
