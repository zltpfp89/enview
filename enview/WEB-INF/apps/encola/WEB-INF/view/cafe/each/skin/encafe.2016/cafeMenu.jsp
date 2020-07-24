<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="cafe_menu_wrap" id="cafe_menu_wrap">
	<div class="CF0401_bgColor CF0401_brdrColor CF0401_brdrStyle CF0401_brdrWidth cafe_menu" id="div_cafe_menu">
	<c:forEach items="${ menuList }" var="menu" varStatus="status">
		<c:if test="${ menu.menuType == 'M' }" var="isMenu"/>
		<c:if test="${ menu.menuType == 'S' }" var="isSep"/>
		<c:if test="${ menu.menuType == 'E' }" var="isEmpty"/>
		<c:if test="${ menu.menuType == 'G' }" var="isGrp"/>
		<c:if test="${ menu.menuHideYn == 'Y'}" var="isHide"/>
		<c:if test="${ mmbrVO.isSysop || mmbrVO.isAdmin || isHide == false }">
			<c:if test="${ isGrp }">
				<c:set var="groupId" value="${ menu.menuId }" />
				<div class="CF0401_menuGrpBgColor CF0401_valFontColor cafe_menu_row cafe_menu_group" id="cafe_menu_group_<c:out value="${ menu.menuId }"/>" title="<c:out value="${ menu.menuDesc }"/>">
					<div class="cafe_menu_arrow" id="arrow_<c:out value="${ menu.menuId }"/>" onclick="javascript:cfMenu.showOrHideMenuGroup('<c:out value="${ menu.menuId }"/>')">▲</div>
					<a class="CF0401_valFontColor CF0402_txtIndnt CF0402_pddngLft CF0402_menuIcon<c:out value="${ menu.cnttType }"/> cafe_menu_group_link cafe_menu_cntt" onclick="javascript:cfMenu.showOrHideMenuGroup('<c:out value="${ menu.menuId }"/>')"><c:out value="${ menu.menuNm }"/></a>
					<input id="isShow_<c:out value="${ menu.menuId}"/>" type="hidden" value="true">
					<input id="<c:out value="${ menu.menuId }"/>" type="hidden" name="isGrpFold" value="<c:out value="${menu.groupFoldYn }"/>">
				</div>
			</c:if>
			<c:if test="${ isMenu }">
				<div class="cafe_menu_row cafe_menu_menu cafe_menu_type_<c:out value="${ menu.menuLevel }"/>" parentId="<c:out value="${ menu.parentId }"/>" title="<c:out value="${ menu.menuDesc }"/>">
					<a class="CF0401_baseFontColor CF0402_txtIndnt CF0402_pddngLft CF0402_menuIcon<c:out value="${ menu.cnttType }"/> cafe_menu_link cafe_menu_cntt" id="menu_link_<c:out value="${ menu.menuId }"/>" menuId="<c:out value="${ menu.menuId }"/>" boardId="<c:out value="${ menu.boardId }"/>" onclick="javascript:cfMenu.selectMenu('<c:out value="${ menu.menuId }"/>','<c:out value="${ menu.boardId }"/>')"><c:out value="${ menu.menuNm }"/></a>
					<c:if test="${menu.newBltn}"><img class="cafe_menu_new CF0402_newIcon" src="/enview/cola/cafe/resource/images/menu/static/new_img_blank.gif" alt="new" /></c:if>
				</div>
			</c:if>
			<c:if test="${ isSep }">
				<div class="CF0401_sepBrdrStyle CF0401_sepBrdrWidth CF0401_sepBrdrColor cafe_menu_seperator" id="cafe_menu_sep_<c:out value="${ menu.menuId }"/>"></div>
			</c:if>
			<c:if test="${ isEmpty }">
				<div class="cafe_menu_row cafe_menu_empty" id="cafe_menu_empty_<c:out value="${ menu.menuId }"/>"></div>
			</c:if>
		</c:if>
	</c:forEach>
		<script type="text/javascript">
			var $foldGrp = $('input[name=isGrpFold]');
			$foldGrp.each(function(){
				var $this = $(this);
				if($this.val() == 'Y'){
					cfMenu.showOrHideMenuGroup($this.attr('id'));
				}
			});
					
		</script>
	</div>
	<c:if test="${menuUse.ggumigiMenu == 'true'}">
		<div class="mask_panel mask_dashed cafemenu_mask" id="cafemenu_mask">
			<div class="mask_button">꾸미기</div>
			<div class="mask_layer" id="cafemenu_mask_layer"></div>
		</div>
	</c:if>
	<c:if test="${menuUse.ggumigiMenu == 'false'}">
		<div class="mask_panel cafemenu_mask" id="cafemenu_mask">
			<div class="mask_layer2" id="cafemenu_mask_layer"></div>
		</div>
	</c:if>
</div>
<div class="blank_area"></div>
<input type="hidden" id="menuDecoPrefs" name="menuDecoPrefs" value="[ 
<c:forEach items="${decoPrefs}" var="deco" varStatus="status">
{ clazz:'<c:out value="${deco.decoType}"/>_<c:out value="${deco.name}"/>', value:'<c:out value="${deco.value}"/>'}<c:if test="${!status.last}">,</c:if>
	</c:forEach>
]"/>
<input type="hidden" id="CF0401_template">
<input type="hidden" id="CF0401_decoId">
<script type="text/javascript">
	var infoBox = cfEach.getInfoBox();
	infoBox.m_on = "client";
	infoBox.m_target = "menu";
	infoBox.m_cmd = "deco";
	infoBox.m_decoPrefs = eval("(" + $('#menuDecoPrefs').val() + ")");
	infoBox.m_isOrg = 'true';
	cfEach.sendCommand(infoBox);
	
	var orgDecoId = cfMenu.getDeco().getOrgDecoPrefValue('CF0401_template');
	$('#CF0401_template').val(orgDecoId);
	
	cfMenu.setEditable(<c:out value="${menuUse.ggumigiMenu}"/>);
</script>