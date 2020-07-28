<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<div class="cafe_srch_wrap" id="cafe_srch_wrap">
	<div class="cafe_srch" id="div_cafe_srch">
		<input id="CF0601_srchKey" class="CF0601_bgColor CF0601_brdrColor CF0601_brdrStyle CF0601_fontColor srch_field" type="text" onkeydown="javascript:cfSrch.search();"/>
		<input id="srchBtn" title="<util:message key="eb.title.search"/>" type="button" alt="<util:message key="eb.title.search"/>" value="<util:message key="eb.title.search"/>" class="CF0601_srchBtn srchBtn" onclick="javascript:cfSrch.search();"/>
	</div>
	<c:if test="${menuUse.ggumigiSrch == 'true'}">
		<div class="mask_panel mask_dashed cafesrch_mask" id="cafesrch_mask">
			<div class="mask_button">꾸미기</div>
			<div class="mask_layer" id="cafesrch_mask_layer"></div>
		</div>
	</c:if>
	<c:if test="${menuUse.ggumigiSrch == 'false'}">
		<div class="mask_panel cafesrch_mask" id="cafesrch_mask">
			<div class="mask_layer2" id="cafesrch_mask_layer"></div>
		</div>
	</c:if>
</div>
<div class="blank_area"></div>
<input type="hidden" id="srchDecoPrefs" name="srchDecoPrefs" value="[ 
<c:forEach items="${decoPrefs}" var="deco" varStatus="status">
{ clazz:'<c:out value="${deco.decoType}"/>_<c:out value="${deco.name}"/>', value:'<c:out value="${deco.value}"/>'}<c:if test="${!status.last}">,</c:if>
	</c:forEach>
]"/>

<style type="text/css">	
	<c:forEach items="${decoPrefs}" var="deco" varStatus="status">
		<c:out value="${deco.decoType}"/>_<c:out value="${deco.name}"/> : {'<c:out value="${deco.value}"/>'}''
	</c:forEach>
</style>

<input type="hidden" id="CF0601_template">
<input type="hidden" id="CF0601_decoId">
<script type="text/javascript">
	var infoBox = cfEach.getInfoBox();
	infoBox.m_on = "client";
	infoBox.m_target = "srch";
	infoBox.m_cmd = "deco";
	infoBox.m_decoPrefs = eval("(" + $('#srchDecoPrefs').val() + ")");
	infoBox.m_isOrg = 'true';
	cfEach.sendCommand(infoBox);
	
	var orgDecoId = cfSrch.getDeco().getOrgDecoPrefValue('CF0601_template');
	$('#CF0601_template').val(orgDecoId);
	
	cfSrch.setEditable(<c:out value="${menuUse.ggumigiSrch}"/>);
</script>