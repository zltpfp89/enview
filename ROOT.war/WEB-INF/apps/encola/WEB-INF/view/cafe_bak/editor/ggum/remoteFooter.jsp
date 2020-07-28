<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--BEGIN::스킨/스킨--%>
<c:if test="${edForm.ggumMenu == 'skin'}">
	<c:if test="${edForm.ggumSubMenu == 'skin'}">
		  <div id="remoteFooterView" class="remoteZindexL">
			<div class="skinView_footer">
			  <div class="fl">
				<input id="controlUseTitle" class="checkradio_styled" type="checkbox">
				<label class="hand" for="controlUseTitle">기존 타이틀 유지</label>
			  </div>
			</div>
		  </div>
		  <a class="rollback home_stxt" onclick="cfGGum.getFootMngr().resetOrg(); return false;" href="#">원래대로</a>
	</c:if>
<%--END::스킨/스킨--%>
<%--BEGIN::스킨/배경--%>
	<c:if test="${edForm.ggumSubMenu == 'cafeBg'}">
		  <div id="remoteFooterView" class="remoteZindexL"></div>
		  <a class="rollback home_stxt" onclick="cfGGum.getFootMngr().resetOrg(); return false;" href="#">원래대로</a>
	</c:if>
</c:if>
<%--END::스킨/배경--%>
<%--BEGIN::레이아웃/단구성--%>
<c:if test="${edForm.ggumMenu == 'layout'}">
	<c:if test="${edForm.ggumSubMenu == 'frame'}">
	  <a class="rollback home_stxt" onclick="cfGGum.getFootMngr().resetOrg(); return false;" href="#">원래대로</a>
	</c:if>
<%--END::레이아웃/단구성--%>
<%--BEGIN::레이아웃/홈게시판--%>
	<c:if test="${edForm.ggumSubMenu == 'board'}">
		  <div id="remoteFooterView" class="remoteZindexL"></div>
		  <a class="rollback home_stxt" onclick="cfGGum.getFootMngr().resetOrg(); return false;" href="#">원래대로</a>
	</c:if>
<%--END::레이아웃/홈게시판--%>
<%--BEGIN::레이아웃/컨텐츠--%>
	<c:if test="${edForm.ggumSubMenu == 'cntt'}">
		  <div id="remoteFooterView" class="remoteZindexL"></div>
		  <a class="rollback home_stxt" onclick="cfGGum.getFootMngr().resetOrg(); return false;" href="#">원래대로</a>
	</c:if>
<%--END::레이아웃/컨텐츠--%>
<%--BEGIN::레이아웃/위젯--%>
	<c:if test="${edForm.ggumSubMenu == 'portlet'}">
		  <div id="remoteFooterView" class="remoteZindexL">
			<div class="widgetView_footer">
			  <a class="linkWidgetBank home_stxt555" target="_blank" href="http://widgetbank.daum.net"> 위젯 더보기 </a>
			</div>
		  </div>
		  <a class="rollback home_stxt" onclick="cfGGum.getFootMngr().resetOrg(); return false;" href="#">원래대로</a>
	</c:if>
</c:if>
<%--END::레이아웃/위젯--%>
<%--BEGIN::영역별꾸미기/카페정보--%>
<c:if test="${edForm.ggumMenu == 'ggumigi'}">
	<c:if test="${edForm.ggumSubMenu == 'info'}">
		  <div id="remoteFooterView" class="remoteZindexL">
			<ul id="FooterColor">
			  <li>
				<span class="color_label">기본색</span>
				<div id="CAFEINFOBOX_fontColor" class="colorSelectBox_styled" style="background-color: rgb(68, 68, 68);">
				  <div id="CF0301_baseFontColor" class="textColorViewer"></div>
				  <div class="colorSelectEnabled"></div>
				</div>
			  </li>
			  <li>
				<span class="color_label">강조색</span>
				<div id="CAFEINFOBOX_strongColor" class="colorSelectBox_styled" style="background-color: rgb(219, 77, 15);">
				  <div id="CF0301_valFontColor" class="textColorViewer"></div>
				  <div class="colorSelectEnabled"></div>
				</div>
			  </li>
			  <li id="isTabOption1" style="display: none;">
				<span class="color_label">탭이름</span>
				<div id="CAFEINFOBOX_titleFontColor1" class="colorSelectBox_styled" style="background-color: rgb(0, 0, 0);">
				  <div id="d2w_CAFEINFOBOX_titleFontColor1" class="textColorViewer"></div>
				  <div class="colorSelectEnabled"></div>
				</div>
				<span class="colorChipGab"></span>
				<div id="CAFEINFOBOX_titleFontColor2" class="colorSelectBox_styled" style="background-color: rgb(0, 0, 0);">
				  <div id="d2w_CAFEINFOBOX_titleFontColor2" class="textColorViewer"></div>
				  <div class="colorSelectEnabled"></div>
				</div>
			  </li>
			</ul>
		  </div>
		  <a class="rollback home_stxt" onclick="cfGGum.getTplMngr().reset();" href="#">원래대로</a>
	</c:if>
<%--END::영역별꾸미기/카페정보--%>
<%--BEGIN::영역별꾸미기/카페메뉴--%>
	<c:if test="${edForm.ggumSubMenu == 'menu'}">
		  <div id="remoteFooterView" class="remoteZindexL">
			<ul id="FooterColor">
			  <li>
				<span class="color_label">기본색</span>
				<div id="CAFEMENU_fontcolor" class="colorSelectBox_styled" style="background-color: rgb(68, 68, 68);">
				  <div id="CF0401_baseFontColor" class="textColorViewer"></div>
				  <div class="colorSelectEnabled"></div>
				</div>
			  </li>
			  <li>
				<span class="color_label">강조색</span>
				<div id="CAFEMENU_menugroupcolor" class="colorSelectBox_styled" style="background-color: rgb(68, 68, 68);">
				  <div id="CF0401_valFontColor" class="textColorViewer"></div>
				  <div class="colorSelectEnabled"></div>
				</div>
			  </li>
			  <li>
				<span class="color_label">아이콘</span>
				<div id="menuIconBg" class="cafeMenuIcon">
					<div id="CF0402_menuIconSet" class="CF0402_menuIconSet iconPicker"></div>
					<div id="menuIconPicker" class="cafeMenuIconSelector" style="display: none;"></div>
				</div>
			  </li>
			</ul>
			<input type="hidden" id="CF0402_decoId" name="CF0402_decoId" class="CF0402_decoId">
		  </div>
		  <a class="rollback home_stxt" onclick="cfGGum.getTplMngr().reset();" href="#">원래대로</a>
	</c:if>
<%--END::영역별꾸미기/카페메뉴--%>
<%--BEGIN::영역별꾸미기/검색창--%>
	<c:if test="${edForm.ggumSubMenu == 'srch'}">
		  <div id="remoteFooterView" class="remoteZindexL"></div>
		  <a class="rollback home_stxt" onclick="cfGGum.getFootMngr().resetOrg(); return false;" href="#">원래대로</a>
	</c:if>
<%--END::영역별꾸미기/검색창--%>
<%--BEGIN::영역별꾸미기/게시판--%>
	<c:if test="${edForm.ggumSubMenu == 'board'}">
		  <div id="remoteFooterView" class="remoteZindexL">
			<ul id="FooterColor">
			  <li>
				<span class="color_label">게시판 이름</span>
				<div id="CAFEBOARD_titlefontcolor" class="colorSelectBox_styled" style="background-color: rgb(68, 68, 68);">
				  <div id="CF0501_nmFontColor" class="textColorViewer"></div>
				  <div class="colorSelectEnabled"></div>
				</div>
			  </li>
			  <li>
				<span class="color_label">글제목색</span>
				<div id="CAFEBOARD_fontcolor" class="colorSelectBox_styled" style="background-color: rgb(68, 68, 68);">
				  <div id="CF0501_subjFontColor" class="textColorViewer"></div>
				  <div class="colorSelectEnabled"></div>
				</div>
			  </li>
			  <li>
				<span class="color_label">댓글색</span>
				<div id="CAFEBOARD_bordfontcolor" class="colorSelectBox_styled" style="background-color: rgb(248, 87, 30);">
				  <div id="CF0501_rplFontColor" class="textColorViewer"></div>
				  <div class="colorSelectEnabled"></div>
				</div>
			  </li>
			</ul>
		  </div>
		  <a class="rollback home_stxt" onclick="cfGGum.getTplMngr().reset(); return false;" href="#">원래대로</a>
	</c:if>
<%--END::영역별꾸미기/게시판--%>
<%--BEGIN::영역별꾸미기/부가컨텐츠--%>
	<c:if test="${edForm.ggumSubMenu == 'buga'}">
		  <div id="remoteFooterView" class="remoteZindexL">
			<ul id="FooterColor">
			  <li>
				<span class="color_label">기본색</span>
				<div id="ACCESSARY_fontColor" class="colorSelectBox_styled" style="background-color: rgb(68, 68, 68);">
				  <div id="d2w_ACCESSARY_fontColor" class="textColorViewer"></div>
				  <div class="colorSelectEnabled"></div>
				</div>
			  </li>
			  <li>
				<span class="color_label">강조색</span>
				<div id="ACCESSARY_strongColor" class="colorSelectBox_styled" style="background-color: rgb(214, 80, 17);">
				  <div id="d2w_ACCESSARY_strongColor" class="textColorViewer"></div>
				  <div class="colorSelectEnabled"></div>
				</div>
			  </li>
			</ul>
		  </div>
		  <a class="rollback home_stxt" onclick="cfGGum.getFootMngr().resetOrg(); return false;" href="#">원래대로</a>
	</c:if>
</c:if>
<%--END::영역별꾸미기/부가컨텐츠--%>