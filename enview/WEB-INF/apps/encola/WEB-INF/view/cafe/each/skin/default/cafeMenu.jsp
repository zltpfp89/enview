<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="div_cafe_menu" name="div_cafe_menu" class="cafe_menu CF0401_bgColor CF0401_brdrStyle">
	<ul id="ul_cafe_menu" class="section CF0401_valFontColor">
		<li id="li_cafe_menu" class="topMenuGroup">
			<a id="btn_title_all" class="btn_view_left" onclick="javascript:cfMenu.showOrHideAllCafeMenu()"><span class="btn_view_title">카페 전체 메뉴</span></a>
			<a id="btn_arrow_all" class="btn_view_right" onclick="javascript:cfMenu.showOrHideAllCafeMenu()"><span class="arrow">▼</span></a>
		</li>
	<c:forEach items="${menuList}" var="menu" varStatus="status">
		<c:if test="${menu.menuType == 'S' }" var="isSep"/>
		<c:if test="${menu.menuType == 'G' }" var="isGrp"/>
		<c:if test="${status.first}">
			<div class="sepBrdr CF0401_sepBrdrStyle"></div>
		</c:if>
		<c:if test="${isSep == true }">
		</ul>
		<div class="sepBrdr CF0401_sepBrdrStyle"></div>
		</c:if>
		<c:if test="${isSep == false }">
			<c:if test="${isGrp == true }">
		<ul id="ul_cafe_menu_group_<c:out value="${ menu.menuId}"/>" class="section CF0401_valFontColor">
			<li class="menuGroup CF0401_menuGrpBgColor">
				<input id="isShow_<c:out value="${ menu.menuId}"/>" type="hidden" value="true">
				<a id='menuGrp_<c:out value="${ menu.menuId}"/>' class="btn_view_left" onclick="javascript:cfMenu.showOrHideMenuGroup('<c:out value="${ menu.menuId}"/>')">
					<span class="btn_view_title"><c:out value="${menu.menuNm}"/></span>
				</a>
				<script type="text/javascript">
					var icon = '<c:out value="${menu.boardId}"/>';
					icon = icon.substring(19, icon.length);
					var id = '<c:out value="${ menu.menuId}"/>';
					$('#' + id).addClass(icon);
				</script>
				<a id="btn_arrow_<c:out value="${ menu.menuId}"/>" class="btn_view_right" onclick="javascript:cfMenu.showOrHideMenuGroup('<c:out value="${ menu.menuId}"/>')">
					<span class="arrow">▼</span>
				</a>
			</li>
			</c:if>
			<c:if test="${isGrp == false }">
			<li class="board_link">
				<a id='<c:out value="${ menu.menuId}"/>' href="javascript:cfMenu.selectMenu('<c:out value="${menu.menuId}"/>')">
					<span class="CF0401_baseFontColor"><c:out value="${menu.menuNm}"/></span>
				</a>
				<script type="text/javascript">
					var icon = '<c:out value="${menu.boardId}"/>';
					icon = icon.substring(19, icon.length);
					var id = '<c:out value="${ menu.menuId}"/>';
					$('#' + id).addClass(icon);
				</script>
			</li>
			</c:if>
		</c:if>
		<c:if test="${menu.newBltn}"><img src="/enview/cola/cafe/images/skin/default/menu/bul_new.gif" alt="New" /></c:if>
		<c:if test="${menu.menuKind == 'S'}">
			</ul>
			<ul class="section">
		</c:if>
		<c:if test="${status.last}">
		    </ul>
		</c:if>
	</c:forEach>
</div>
<div id="blank_area" class="blank_area"></div>