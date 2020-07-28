<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--BEGIN::스킨--%>
		<c:if test="${edForm.ggumMenu == 'skin'}">
		  <ul class="remote_menu_dep2 rmd2_skin">
			<li class="rmd2_skin_txt" style="width:37px;<c:if test="${menuUse.skinSkin == 'false'}">display:none;</c:if>">
			  <a class="home_stxt555 <c:if test="${edForm.ggumSubMenu == 'skin'}">selected</c:if>" onclick="cfGGum.onClickMenu('skin','skin','list'); return false;" href="#">스킨</a>
			</li>
			<li class="rmd2_skin_txt">
			  <span class="rmd_bar">|</span>
			</li>
			<li class="rmd2_skin_txt" style="width:37px;<c:if test="${menuUse.skinCafeBg == 'false'}">display:none;</c:if>">
			  <a class="home_stxt555 <c:if test="${edForm.ggumSubMenu == 'cafeBg'}">selected</c:if>" onclick="cfGGum.onClickMenu('skin','cafeBg','image');return false;" href="#">배경</a>
			</li>
			<li class="rmd2_list_one">
			  <c:if test="${edForm.ggumSubMenu == 'cafeBg'}">
			  <div class="skinMenuDimmed" title="스킨에서만 사용가능"></div>
			  </c:if>
			  <a id="RemoteSubMenuSkinOne" title="크게 보기" onclick="cfGGum.onClickMenu('skin', 'skin', 'detail');">한개씩</a>
			</li>
			<li class="rmd2_list_list">
			  <c:if test="${edForm.ggumSubMenu == 'cafeBg'}">
			  <div class="skinMenuDimmed" title="스킨에서만 사용가능"></div>
			  </c:if>
			  <a id="RemoteSubMenuSkinList" class="selected" title="리스트형태로 보기" onclick="cfGGum.onClickMenu('skin', 'skin', 'list');" href="#">리스트</a>
			</li>
		  </ul>
		  <c:if test="${edForm.ggumSubMenu == 'cafeBg'}">
		  <ul class="rmd2_sub_sub remoteControlBg">
			<li class="rmd2_sub_sub_li">
			  <input id="styletypeDesign" class="checkradio_styled" type="radio" onclick="cfGGum.onClickMenu('skin','cafeBg','image');return false;" value="1" name="styletype"
					 <c:if test="${empty edForm.ggum3rdMenu || edForm.ggum3rdMenu == 'image'}">checked="checked"</c:if>>
			  <label for="styletypeDesign" style="cursor: pointer;">디자인</label>
			</li>
			<li class="rmd2_sub_sub_li">
			  <input id="styletypeCustom" class="checkradio_styled" type="radio" onclick="cfGGum.onClickMenu('skin','cafeBg','color');return false;" value="2" name="styletype"
					 <c:if test="${edForm.ggum3rdMenu == 'color'}">checked="checked"</c:if>>
			  <label for="styletypeCustom" style="cursor: pointer;">색상</label>
			</li>
			<li class="rmd2_sub_sub_li">
			  <input id="styletypeUpload" class="checkradio_styled" type="radio" onclick="cfGGum.onClickMenu('skin','cafeBg','user');return false;" value="3" name="styletype"
					 <c:if test="${edForm.ggum3rdMenu == 'user'}">checked="checked"</c:if>>
			  <label for="styletypeUpload" style="cursor: pointer;">직접올리기</label>
			</li>
			<li id="cibColorTypeList" class="cibSelectBox" <c:if test="${edForm.ggum3rdMenu != 'color'}">style="display:none"</c:if>>
			  <select id="cibColorTypeSelectBox" fixedsize="72" onchange="cfGGum.onChange3rdSelectBox(this)">
				<option value="1">편안한색</option>
				<option value="2">선명한색</option>
			  </select>
			</li>
		  </ul>		  
		  </c:if>
		</c:if>
<%--END::스킨--%>
<%--BEGIN::레이아웃--%>
	<c:if test="${edForm.ggumMenu == 'layout'}">
		  <ul id="remoteDesignSubTab" class="remote_menu_dep2 rmd2_design">
		  	<li><span class="rmd_bar">|</span></li>
		  	<c:if test="${menuUse.layoutFrame == 'true'}">
				<li style="width:53px;">
				  <a class="home_stxt555 <c:if test="${edForm.ggumSubMenu == 'frame'}">selected</c:if>" onclick="cfGGum.onClickMenu('layout','frame');return false;" href="#">단 구성</a>
				</li>
				<li><span class="rmd_bar">|</span></li>
			</c:if>
			<c:if test="${menuUse.layoutBoard == 'true'}">
				<li style="width:63px;">
				  <a class="home_stxt555 <c:if test="${edForm.ggumSubMenu == 'board'}">selected</c:if>" onclick="cfGGum.onClickMenu('layout','board');return false;" href="#">홈 게시판</a>
				</li>
				<li><span class="rmd_bar">|</span></li>
			</c:if>
			<c:if test="${menuUse.layoutCntt == 'true'}">
				<li style="width:46px;">
				  <a class="home_stxt555 <c:if test="${edForm.ggumSubMenu == 'cntt'}">selected</c:if>" onclick="cfGGum.onClickMenu('layout','cntt');return false;" href="#">컨텐츠</a>
				</li>
				<li><span class="rmd_bar">|</span></li>
			</c:if>
			<c:if test="${menuUse.layoutPortlet == 'true'}">
				<li style="width:36px;">
				  <a class="home_stxt555 <c:if test="${edForm.ggumSubMenu == 'potlet'}">selected</c:if>" onclick="cfGGum.onClickMenu('layout','portlet');return false;" href="#">위젯</a>
				</li>
				<li><span class="rmd_bar">|</span></li>
			</c:if>
			<li id="rmd_layout_wire">
			  <a id="wfVisible" onclick="cfGGum.onViewFrame();blur();return false;" href="#">와이어프레임</a>
			</li>
		  </ul>
	</c:if>
<%--END::레이아웃--%>
<%--BEGIN::영역별 꾸미기--%>
	<c:if test="${edForm.ggumMenu == 'ggumigi'}">
		  <ul id="remoteDesignSubTab" class="remote_menu_dep2 rmd2_design">
			<li style="width:63px;<c:if test="${menuUse.ggumigiInfo == 'false'}">display:none;</c:if>">
			  <a class="home_stxt555 <c:if test="${edForm.ggumSubMenu == 'info'}">selected</c:if>" onclick="cfGGum.onClickMenu('ggumigi','info','image');return false;" href="#">카페정보</a>
			</li>
			<li>
			  <span class="rmd_bar"<c:if test="${menuUse.ggumigiInfo == 'false' || (menuUse.ggumigiMenu == 'false' && menuUse.ggumigiSrch == 'false' && menuUse.ggumigiBoard == 'false' && menuUse.ggumigiBuga == 'false')}"> style="display:none;"</c:if>>|</span>
			</li>
			<li style="width:63px;<c:if test="${menuUse.ggumigiMenu == 'false'}">display:none;</c:if>">
			  <a class="home_stxt555 <c:if test="${edForm.ggumSubMenu == 'menu'}">selected</c:if>" onclick="cfGGum.onClickMenu('ggumigi','menu','image');return false;" href="#">카페메뉴</a>
			</li>
			<li>
			  <span class="rmd_bar"<c:if test="${menuUse.ggumigiMenu == 'false' || (menuUse.ggumigiSrch == 'false' && menuUse.ggumigiBoard == 'false' && menuUse.ggumigiBuga == 'false')}"> style="display:none;"</c:if>>|</span>
			</li>
			<li style="width:52px;<c:if test="${menuUse.ggumigiSrch == 'false'}">display:none;</c:if>">
			  <a class="home_stxt555 <c:if test="${edForm.ggumSubMenu == 'srch'}">selected</c:if>" onclick="cfGGum.onClickMenu('ggumigi','srch', 'image');return false;" href="#">검색창</a>
			</li>
			<li>
			  <span class="rmd_bar"<c:if test="${menuUse.ggumigiSrch == 'false' || (menuUse.ggumigiBoard == 'false' && menuUse.ggumigiBuga == 'false')}"> style="display:none;"</c:if>>|</span>
			</li>
			<li style="width:52px;<c:if test="${menuUse.ggumigiBoard == 'false'}">display:none;</c:if>">
			  <a class="home_stxt555 <c:if test="${edForm.ggumSubMenu == 'board'}">selected</c:if>" onclick="cfGGum.onClickMenu('ggumigi','board','image');return false;" href="#">게시판</a>
			</li>
			<li>
			  <span class="rmd_bar"<c:if test="${menuUse.ggumigiBoard == 'false' || menuUse.ggumigiBuga == 'false'}"> style="display:none;"</c:if>>|</span>
			</li>
			<li style="width:74px;<c:if test="${menuUse.ggumigiBuga == 'false'}">display:none;</c:if>">
			  <a class="home_stxt555 <c:if test="${edForm.ggumSubMenu == 'buga'}">selected</c:if>" onclick="cfGGum.onClickMenu('ggumigi','buga','image');return false;" href="#">부가컨텐츠</a>
			</li>
		  </ul>
		  <%--BEGIN::영역별꾸미기(카페정보)--%>
		  <c:if test="${edForm.ggumSubMenu == 'info'}">
		  <ul class="rmd2_sub_sub remoteControlBg">
			<li class="rmd2_sub_sub_li">
			  <input id="styletypeDesign" class="checkradio_styled" type="radio" onclick="cfGGum.onClickMenu('ggumigi','info','image');" value="1" name="styletype"
				<c:if test="${empty edForm.ggum3rdMenu || edForm.ggum3rdMenu == 'image'}">checked="checked"</c:if> />
			  <label for="styletypeDesign" style="cursor: pointer;">디자인</label>
			</li>
			<li class="rmd2_sub_sub_li">
			  <input id="styletypeCustom" class="checkradio_styled" type="radio" onclick="cfGGum.onClickMenu('ggumigi','info','color');" value="2" name="styletype"
					 <c:if test="${edForm.ggum3rdMenu == 'color'}">checked="checked"</c:if> />
			  <label for="styletypeCustom" style="cursor: pointer;">색상</label>
			</li>
		  </ul>
		  </c:if>
		  <%--END::영역별꾸미기(카페정보)--%>
		  <%--BEGIN::영역별꾸미기(카페메뉴)--%>
		  <c:if test="${edForm.ggumSubMenu == 'menu'}">
		  <ul class="rmd2_sub_sub remoteControlBg">
			<li class="rmd2_sub_sub_li">
			  <input id="styletypeDesign" class="checkradio_styled" type="radio" onclick="cfGGum.onClickMenu('ggumigi','menu','image');return false;" value="1" name="styletype"
					 <c:if test="${empty edForm.ggum3rdMenu || edForm.ggum3rdMenu == 'image'}">checked="checked"</c:if>>
			  <label for="styletypeDesign" style="cursor: pointer;">디자인</label>
			</li>
			<li class="rmd2_sub_sub_li">
			  <input id="styletypeCustom" class="checkradio_styled" type="radio" onclick="cfGGum.onClickMenu('ggumigi','menu','color');return false;" value="2" name="styletype"
					 <c:if test="${edForm.ggum3rdMenu == 'color'}">checked="checked"</c:if>>
			  <label for="styletypeCustom" style="cursor: pointer;">색상</label>
			</li>
			<!-- li class="rmd2_sub_sub_li">
			  <img id="d2w_d2w_styletypeUpload" class="img_radiobtn" width="13" height="14" tabindex="" src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif">
			  <input id="styletypeUpload" class="checkradio_styled" type="radio" onclick="cfGGum.onClickMenu('ggumigi','menu','user');return false;" value="3" name="styletype"
					 <c:if test="${edForm.ggum3rdMenu == 'user'}">checked="checked"</c:if>>
			  <label for="styletypeUpload" style="cursor: pointer;">직접올리기</label>
			</li-->
		  </ul>
		  </c:if>
		  <%--END::영역별꾸미기(카페메뉴)--%>
		  <%--BEGIN::영역별꾸미기(게시판)--%>
		  <c:if test="${edForm.ggumSubMenu == 'board'}">
		  <ul class="rmd2_sub_sub remoteControlBg">
			<li class="rmd2_sub_sub_li">
			  <input id="styletypeDesign" class="checkradio_styled" type="radio" onclick="cfGGum.onClickMenu('ggumigi','board','image');return false;" value="1" name="styletype"
					 <c:if test="${empty edForm.ggum3rdMenu || edForm.ggum3rdMenu == 'image'}">checked="checked"</c:if>>
			  <label for="styletypeDesign" style="cursor: pointer;">디자인</label>
			</li>
			<li class="rmd2_sub_sub_li">
			  <input id="styletypeCustom" class="checkradio_styled" type="radio" onclick="cfGGum.onClickMenu('ggumigi','board','color');return false;" value="2" name="styletype"
					 <c:if test="${edForm.ggum3rdMenu == 'color'}">checked="checked"</c:if>>
			  <label for="styletypeCustom" style="cursor: pointer;">색상</label>
			</li>
			<li class="cibSelectBoxFix">
			  <span class="home_stxt555 defaultFontSizeLabel">기본폰트</span>
			  <select id="cibFontSizeSelectBox" onchange="cfGGum.onChange3rdSelectBox(this);" fixedsize="62">
				<option value="9">9pt</option>
				<option value="10">10pt</option>
			  </select>
			  <!-- div id="defaultFontSizeTipLayer" class="tip_icon"></div-->
			</li>
		  </ul>		  
		  </c:if>
		  <%--END::영역별꾸미기(게시판)--%>
		  <%--BEGIN::영역별꾸미기(부가컨텐츠)--%>
		  <c:if test="${edForm.ggumSubMenu == 'buga'}">
		  <ul class="rmd2_sub_sub remoteControlBg">
			<li class="rmd2_sub_sub_li">
			  <input id="styletypeDesign" class="checkradio_styled" type="radio" onclick="cfGGum.onClickMenu('ggumigi','buga','image');return false;" value="1" name="styletype"
					 <c:if test="${empty edForm.ggum3rdMenu || edForm.ggum3rdMenu == 'image'}">checked="checked"</c:if>>
			  <label for="styletypeDesign" style="cursor: pointer;">디자인</label>
			</li>
			<li class="rmd2_sub_sub_li">
			  <input id="styletypeCustom" class="checkradio_styled" type="radio" onclick="cfGGum.onClickMenu('ggumigi','buga','color');return false;" value="2" name="styletype"
					 <c:if test="${edForm.ggum3rdMenu == 'color'}">checked="checked"</c:if>>
			  <label for="styletypeCustom" style="cursor: pointer;">색상</label>
			</li>
		  </ul>
		  </c:if>
		  <%--END::영역별꾸미기(부가컨텐츠)--%>
	</c:if>
<%--END::영역별 꾸미기--%>
