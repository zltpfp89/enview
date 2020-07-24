<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String domain = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
%>
<div id="cafe_title_wrap" class="cafe_title_wrap">
	<div class="cafetitle" id="div_cafe_title">
		<div id="cafeTItle" class="CF0102_bgHeight titleArea">
			<div id="title_background" class="CF0102_bgColor CF0102_brdrColor CF0102_brdrStyle CF0102_brdrWidth CF0102_trpcValue CF0102_bgImage CF0102_bgImgRepeat CF0102_bgImgPos title_background" onclick="javascript: cfEach.go2EachHome();"></div>
			<div id="title_cafeName" class="CF0103_display CF0103_fontNm CF0103_fontSize CF0103_fontColor CF0103_position title_cafeName homeLink"><c:out value="${cmntVO.cmntNm }"/></div>
			<div class="CF0104_display CF0104_fontNm CF0104_fontSize CF0104_fontColor CF0104_position title_cafeUrl homeLink"><%=domain%>/cafe/<c:out value="${cmntVO.cmntUrl }"/></div>
			<div id="title_cafeMenus" class="CF0105_display CF0105_position CF0105_bgColor CF0105_brdrStyle CF0105_brdrWidth CF0105_brdrColor title_cafeTitleMenus">
				<c:forEach items="${ menuList }" var="menu" varStatus="status">
					<div class="CF0105_fontNm CF0105_baseFontColor title_cafeTitleMenu" id="titmeMenu_<c:out value="${menu.menuId}"/>" bid='<c:out value="${ menu.boardId }"/>' onclick="javascript:cfTitle.selectMenu('<c:out value="${menu.menuId}"/>','<c:out value="${ menu.boardId }"/>');"><c:out value="${menu.menuNm}"/></div>
					<c:if test="${!status.last }">
						<div class="CF0105_baseFontColor title_cafeTitleMenuPipe">|</div>
					</c:if>
				</c:forEach>
			</div>
			<!-- div class="CF0106_position title_cafeSearch">
				<input class="CF0106_fieldBgColor CF0106_fieldFontColor CF0106_brdrStyle title_cafeSearchField" type="text" id="titleSearchField" onkeyup="cfTitle.search();">
				<input class="CF0106_btnBgColor CF0106_btnFontColor title_cafeSearchButton" type="button" id="titleSearchButton" onclick="cfTitle.search();" value="검색">
			</div-->
			<div class="title_counter"></div>
		</div>
		<c:if test="${menuUse.ggumigiTitle == 'true'}">
			<div id="cafetitle_mask" class="mask_panel mask_dashed cafetitle_mask">
				<div class="mask_button">꾸미기</div>
				<div class="mask_layer" id="cafetitle_mask_layer"></div>
			</div>
		</c:if>
		<c:if test="${menuUse.ggumigiTitle == 'false'}">
			<div id="cafetitle_mask" class="mask_panel cafetitle_mask">
				<div class="mask_layer2" id="cafetitle_mask_layer"></div>
			</div>
		</c:if>
	</div>
</div>
<div class="blank_area"></div>
<input type="hidden" id="decoPrefs" name="decoPrefs" value="[ 
<c:forEach items="${decoPrefs}" var="deco" varStatus="status">
{ clazz:'<c:out value="${deco.decoType}"/>_<c:out value="${deco.name}"/>', value:'<c:out value="${deco.value}"/>'}<c:if test="${!status.last}">,</c:if>
	</c:forEach>
]"/>
<input type="hidden" id="bgDecoPrefs" name="bgDecoPrefs" value="[ 
<c:forEach items="${bgDecoPrefs}" var="deco" varStatus="status">
{ clazz:'<c:out value="${deco.decoType}"/>_<c:out value="${deco.name}"/>', value:'<c:out value="${deco.value}"/>'}<c:if test="${!status.last}">,</c:if>
	</c:forEach>
]"/>

<style type="text/css">	
	<c:forEach items="${decoPrefs}" var="deco" varStatus="status">
		<c:out value="${deco.decoType}"/>_<c:out value="${deco.name}"/> : {'<c:out value="${deco.value}"/>'}''
	</c:forEach>
</style>

<style type="text/css">	
	<c:forEach items="${bgDecoPrefs}" var="deco" varStatus="status">
		<c:out value="${deco.decoType}"/>_<c:out value="${deco.name}"/> : {'<c:out value="${deco.value}"/>'}''
	</c:forEach>
</style>

<input type="hidden" id="CF0802_template">
<input type="hidden" id="CF0802_decoId">
<script type="text/javascript">
   	var infoBox = cfEach.getInfoBox();
   	infoBox.m_on = "client";
   	infoBox.m_target = "title";
   	infoBox.m_cmd = "deco";
   	infoBox.m_decoPrefs = eval("(" + $('#decoPrefs').val() + ")");
   	infoBox.m_isOrg = 'true';
   	cfEach.sendCommand(infoBox);
   	
   	var height = $('#cafeTItle').css('height').replace('px','') - $('#title_background').css('border-bottom-width').replace('px','') * 2;
	$('#title_background').css('height', height + 'px');
	
	//타이틀메뉴 너비 지정
	var left = $('#title_cafeMenus').css('border-left-width').replace('px','');
	var right = $('#title_cafeMenus').css('border-right-width').replace('px','');
	var menuWidth = $('#cafe_title_wrap').css('width').replace('px') - left - right;
	$('#title_cafeMenus').css('width', menuWidth);
	
	cfTitle.setEditable(<c:out value="${menuUse.ggumigiTitle}"/>);
	
	$(document).ready(function(){
		var infoBox = cfEach.getInfoBox();
		infoBox.m_on = "client";
		infoBox.m_target = "bg";
		infoBox.m_cmd = "deco";
		infoBox.m_decoPrefs = eval("(" + $('#bgDecoPrefs').val() + ")");
		infoBox.m_isOrg = 'true';
		cfEach.sendCommand(infoBox);
		
		var orgDecoId = cfMenu.getDeco().getOrgDecoPrefValue('CF0802_template');
		$('#CF0802_template').val(orgDecoId);
	});
	
</script>
