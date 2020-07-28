<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

  <%--BEGIN::GGum Area--%>
  <%--div id="remoteLayer" class="remote_max" style="width: 796px; position: fixed"--%>
	<div id="remoteLeft">
	  <div id="remoteLayerTitle" style="cursor: move;">
		<ul class="remote_deco_toolbar">
		  <li>
			<a class="btn_foldRemote" title="<util:message key="cf.prop.bigSmall"/>" onclick="cfGGum.onClickMinMax();return false;" href="#"></a>
		  </li>
			<%--
		  <li>
			<a class="btn_foldRemote" title="<util:message key="cf.prop.bigSmall"/>" onclick="cfGGum.onClickMinMax();return false;" href="#"><util:message key="cf.prop.folding"/></a>
		  </li>
		  <li>
			<a id="remoteControlLockButton" class="lock" title="<util:message key="cf.prop.fixLocation"/>" onclick="cfGGum.onClickPin();return false;" href="#"><util:message key="cf.prop.fixLocation"/></a>
		  </li>
		 --%>
		</ul>
		<ul class="remote_data_toolbar">
		  <li>
		  	<!-- 
			<a class="btn_remoteApply" title="<util:message key="cf.title.apply"/>" onclick="cfGGum.onClickApply(); return false;" href="#"><util:message key="cf.title.apply"/></a>
			 -->
			 <input type="button" onclick="cfGGum.onClickApply();" style="padding:5px;width:45px;border-radius:4px" value="<util:message key="cf.title.apply"/>"/>
		  </li>
		  <li>
			 <input type="button" onclick="cfGGum.onClickCancel();" style="padding:5px;width:45px;border-radius:4px" value="<util:message key="ev.title.cancel"/>"/>
		  </li>
		</ul>
		<ul class="remote_mini_menu">
		  <li class="btn_remote_mini_Skin" <c:if test="${menuUse.skin == 'false'}">style="display:none"</c:if>>
			<a class="selected" onclick="cfGGum.onClickMenu('skin','cafeBg','image'); return false;" href="#">
			<span style="position:absolute;top:5px;left:0px;width:45px;text-align: center;color:white">				
			<util:message key="cf.title.skin"/>
			</span>
			</a>
		  </li>
		  <li class="btn_remote_mini_Layout" <c:if test="${menuUse.layout == 'false'}">style="display:none"</c:if>>
			<a onclick="cfGGum.onClickMenu('layout','<c:out value="${menuUse.layoutDefault}"/>'); return false;" href="#">
			<span style="position:absolute;top:5px;left:0px;width:60px;text-align: center;color:white">				
			<util:message key="ev.info.layout"/>
			</span>
			</a>
		  </li>
		  <li class="btn_remote_mini_Design" <c:if test="${menuUse.ggumigi == 'false'}">style="display:none"</c:if>>
			<a onclick="cfGGum.onClickMenu('ggumigi','<c:out value="${menuUse.ggumigiDefault}"/>','image'); return false;" href="#">
			<span style="position:absolute;top:5px;left:5px;width:50px;text-align: center">				
			<util:message key="cf.prop.detail.deco"/>
			</span>
			</a>
		  </li>
		</ul>
	  </div>
	  <div id="remoteControl">
		<div id="remoteMenu">
		  <ul class="remote_menu_dep1">
			<li class="rmd1_skin" <c:if test="${menuUse.skin == 'false'}">style="display:none"</c:if>>
			  <a class="selected" onclick="cfGGum.onClickMenu('skin','cafeBg','image');return false;" href="#" style="text-align: center"><span style="position:absolute;top:10px;left:5px;width:50px;text-align: center"><util:message key="cf.title.skin"/></span></a>
			</li>
			<li class="rmd1_layout" <c:if test="${menuUse.layout == 'false'}">style="display:none"</c:if>>
			  <a onclick="cfGGum.onClickMenu('layout','<c:out value="${menuUse.layoutDefault}"/>'); return false;" href="#"><span style="position:absolute;top:10px;left:5px;width:70px;text-align: center"><util:message key="ev.info.layout"/></span></a>
			</li>
			<li class="rmd1_design" <c:if test="${menuUse.ggumigi == 'false'}">style="display:none"</c:if>>
			  <a onclick="cfGGum.onClickMenu('ggumigi','<c:out value="${menuUse.ggumigiDefault}"/>','image'); return false;" href="#"><util:message key="cf.prop.detail.deco"/></a>
			</li>
		  </ul>
		</div>
		<div id="remoteSubMenu">
          <!--BEGIN::Substitution Area-->
          <!--END::Substitution Area-->
		</div>
		<div id="remoteControlContent" class="remoteControlBg">
          <!--BEGIN::Substitution Area-->
          <!--END::Substitution Area-->
		</div>
		<div id="remoteFooter" class="remoteFooterTypeA">
          <!--BEGIN::Substitution Area-->
          <!--END::Substitution Area-->
		</div>
	  </div>
	</div>
	<div><!-- 각 컨트롤 컨텐츠 들의 선택된 정보를 저장하는 hidden 영역 -->
		<input type="hidden" id="info_3rdMenu" value="image"><input type="hidden" id="info_decoId">
		<input type="hidden" id="menu_3rdMenu" value="image"><input type="hidden" id="menu_decoId">
		<input type="hidden" id="CF0501_3rdMenu" value="image"><input type="hidden" id="CF0501_template"><input type="hidden" id="CF0501_decoId">
		<input type="hidden" id="CF0601_3rdMenu" value="image"><input type="hidden" id="CF0601_template"><input type="hidden" id="CF0601_decoId">
	</div>
	<div id="remoteRight" style="display:none">
	    <input type="hidden" id="layoutDecos" value="[ 
			<c:forEach items="${layoutDecos}" var="decos" varStatus="status">
			  { clazz:'<c:out value="${decos.decoType}"/>_<c:out value="${decos.name}"/>', value:'<c:out value="${decos.value}"/>'}<c:if test="${!status.last}">,</c:if>
			</c:forEach>
		]"/>
		<div id="remoteDummyTop" class="wireframe_top" style="cursor: move;">
		  <a class="wireframe_close imgLink" onclick="cfGGum.onViewFrame(); return false;" href="#"><util:message key="ev.title.close"/></a>
		</div>
		<div id="wireframeBg" class="wireframe_bg">
		  <div id="wireframe"><%--Frame 템플릿이 선택되면 요놈의 class가 바뀐다.--%>
		    <div id="wf_EDITPANEL"></div>
		    <div id="wf_ROOFPANEL">
			  <div id="wf_MINIDAUM"><util:message key="cf.title.menu"/></div>
		    </div>
		    <div id="wf_TITLEPANEL"><util:message key="mm.title.title"/></div>
		    <div id="wfEntrancePanel1" class="nosp"><%-- ONE 형의 경우 wf_ENTRANCEPANEL 이 나타나는 부분--%>
			  <div id="wf_ENTRANCEPANEL"><%--요놈을 짤라내서 초기화시 설정에 따라 해당 위치로 옮겨준다.--%>
				<div id="wf_ENTRANCE" class="wf_component wf_component_entrance">
				  <a class="btn_wf_del imgLink">delete</a>
				  	<util:message key="cf.prop.mainArea"/>
				</div>
			  </div>
			</div>
		    <div id="side1">
			  <div id="wf_MENUPANEL" class="wireframePanel">
				<div id="CafeInfoPortlet" class="wf_component wf_component_l" style="cursor:move;"><util:message key="cf.prop.infoArea"/></div>
		    	<div id="CafeMenuPortlet" class="wf_component wf_component_l" style="cursor:move;"><util:message key="cf.prop.menuArea"/></div>
		    	<div id="CafeSrchPortlet" class="wf_component wf_component_s" style="cursor:move;"><util:message key="cf.prop.searchWindow"/></div>
			    <!--div id="ggChatBox" class="wf_component wf_component_s" style="cursor: move;">
				  <a class="btn_wf_del imgLink">delete</a>
				  채팅창
			    </div-->
			  </div>
			  <div id="wf_ACCESSARYPANEL1" class="wireframePanel" <c:if test="${menuUse.ggumigiBuga == 'false'}">style="display:none"</c:if>></div>
		    </div>
		    <div id="wfEntrancePanel3" class="nosp"></div><%-- THREE 1,3 형의 경우 wf_ENTRANCEPANEL 이 나타나는 부분--%>
		    <div id="wf_centralPanel">
			  <div id="wfEntrancePanel2" class="nosp"></div><%--TWO 1,2/THREE 2,4 형의 경우 wf_ENTRANCEPANEL 이 나타나는 부분--%>
			  <div id="wf_HOMEBOARDPANEL" <c:if test="${menuUse.layoutBoard == 'false'}">style="display:none"</c:if>>
			    <%--게시판그룹영역들이 나타나는 부분--%>
			  </div>
			  <div id="wf_INFOPANEL"></div>
			  <div id="wf_ACCESSARYPANEL2" class="wireframePanel" <c:if test="${menuUse.ggumigiBuga == 'false'}">style="display:none"</c:if>></div>
			  <div id="wf_ACCESSARYPANEL3" class="wireframePanel" <c:if test="${menuUse.ggumigiBuga == 'false'}">style="display:none"</c:if>></div>
			  <div id="wf_ACCESSARYPANEL4" class="wireframePanel" <c:if test="${menuUse.ggumigiBuga == 'false'}">style="display:none"</c:if>></div>
			  <div id="wfSidePanel1"><%--ONE/TWO 1,2 형일때 wf_ACCESSARYPANEL5 이 나타나는 부분.--%>
			    <div id="wf_ACCESSARYPANEL5" class="wireframePanel" <c:if test="${menuUse.ggumigiBuga == 'false'}">style="display:none"</c:if>></div><%--요놈을 짤라내서 초기화시 설정에 따라 해당 위치로 옮겨준다.--%>			
			  </div>
		    </div>
		    <div id="wfSidePanel2"></div><%--THREE 1,2,3,4 형일때 wf_ACCESSARYPANEL5 이 나타나는 부분.--%>
		    <div class="cl"></div>
		    <div id="wfHomeboardEditLayer" style="display:none">
			  <div id="wfHomeboardEditLayerPng">
				<div id="wfHomeboardEditLayerPng">
				  <div class="boardPop_title">
					<h3><util:message key="cf.title.editBoard"/></h3>
					<a class="boardPop_btnClose imgLink" href="#" onclick="cfGGum.getLayMngr().closeConfBoard(false); return false;"><util:message key="ev.title.close"/></a>
				  </div>
				  <div class="homeBoardEditLayer">
					<div id="homeBoardEditList">
					  <select id="homeBoardPotSel" style="width:243px;padding-left:10px" onchange="cfGGum.getLayMngr().changeConfBoard(this)">
						<option style="padding-left:10px" value="empty" brdId="empty"><util:message key="eb.info.board.notSelect"/></option>
						<c:forEach items="${menuList}" var="menu">
						  <c:if test="${menu.menuType == 'M'}">
							<option style="padding-left:10px" value="<c:out value="${menu.cnttType}"/>" brdId="<c:out value="${menu.boardId}"/>"><c:out value="${menu.menuNm}"/></option>
						  </c:if>
						</c:forEach>
					  </select>
					</div>
					<div id="homeBoardEditType">
					  <input id="ggBrdGrpId" type="hidden">
					  <input id="ggBrdGrpBrdPos" type="hidden">
					  <%--boardType 아이콘들이 들어올 부분--%>
					</div>
				  </div>
				  <div class="popup_btnArea">
					<a class="popup_btnConfirm imgLink" onclick="cfGGum.getLayMngr().closeConfBoard(true); return false;" href="#"><util:message key="ev.title.confirm"/></a>
					<a class="popup_btnCancel imgLink" onclick="cfGGum.getLayMngr().closeConfBoard(false); return false;" href="#"><util:message key="ev.title.cancel"/></a>
				  </div>				
				</div>
			  </div>
		    </div>
		  </div>	
		</div>
		<div class="wireframe_bottom"></div>
		<div id="wf_HOMEBOARDGROUPS" style="display:none"><%--원래없는 부분.Javascript의 편의를 위해 HTML 조각을 미리 로딩해 놓기위한 용도.2012.05.10.KWShin.--%>
			    <div class="wf_board gg_board_FLT10" style="cursor: move;">
				  <div class="wf_board_del_bg">
				    <a class="btn_wf_del imgLink" onclick="cfGGum.getLayMngr().removeBoardGroup(this); return false;"><util:message key="cf.title.remove"/></a>
				  </div>
				  <div class="wf_board_empty">
				    <div class="wf_board_sub wf_board_sub_up">
					  <span class="gg_board_title_LT"><util:message key="cf.info.ttl.none.board"/></span>
					  <a id="homeBoardPot_" class="btn_wf_modify imgLink" brdPos="FLT10" onclick="cfGGum.getLayMngr().openConfBoard(this); return false;" href="#"><util:message key="ev.hnevent.common.setting"/></a>
					  <div class="wf_boardIcon"></div>
				    </div>
				  </div>
			    </div>
				<div class="wf_board gg_board_MLT10_MRT10" style="cursor: move;">
				  <div class="wf_board_del_bg">
					<a class="btn_wf_del imgLink" onclick="cfGGum.getLayMngr().removeBoardGroup(this); return false;"><util:message key="cf.title.remove"/></a>
				  </div>
				  <div class="wf_board_empty">
					<div class="wf_board_sub wf_board_sub_up wf_board_sub_hor">
					  <span class="gg_board_title_LT"><util:message key="cf.info.ttl.none.board"/></span>
					  <a id="homeBoardPot_" class="btn_wf_modify imgLink" brdPos="MLT10" onclick="cfGGum.getLayMngr().openConfBoard(this); return false;" href="#"><util:message key="ev.hnevent.common.setting"/></a>
					  <div class="wf_boardIcon"></div>
					</div>
				  </div>
				  <div class="wf_board_empty">
					<div class="wf_board_sub wf_board_sub_up wf_board_sub_hor">
					  <span class="gg_board_title_RT"><util:message key="cf.info.ttl.none.board"/></span>
					  <a id="homeBoardPot_" class="btn_wf_modify imgLink" brdPos="MRT10" onclick="cfGGum.getLayMngr().openConfBoard(this); return false;" href="#"><util:message key="ev.hnevent.common.setting"/></a>
					  <div class="wf_boardIcon"></div>
					</div>
				  </div>
				</div>
				<div class="wf_board gg_board_FLT20" style="cursor: move;">
				  <div class="wf_board_del_bg">
					<a class="btn_wf_del imgLink" onclick="cfGGum.getLayMngr().removeBoardGroup(this); return false;"><util:message key="cf.title.remove"/></a>
				  </div>
				  <div class="wf_board_empty">
					<div class="wf_board_sub wf_board_sub_ver">
					  <span class="gg_board_title_LT"><util:message key="cf.info.ttl.none.board"/></span>
					  <a id="homeBoardPot_" class="btn_wf_modify imgLink" brdPos="FLT20" onclick="cfGGum.getLayMngr().openConfBoard(this); return false;" href="#"><util:message key="ev.hnevent.common.setting"/></a>
					  <div class="wf_boardIcon"></div>
					</div>
				  </div>
				</div>
				<div class="wf_board gg_board_MLT20_MRT20" style="cursor: move;">
				  <div class="wf_board_del_bg">
					<a class="btn_wf_del imgLink" onclick="cfGGum.getLayMngr().removeBoardGroup(this); return false;"><util:message key="cf.title.remove"/></a>
				  </div>
				  <div class="wf_board_empty">
					<div class="wf_board_sub wf_board_sub_ver wf_board_sub_hor">
					  <span class="gg_board_title_LT"><util:message key="cf.info.ttl.none.board"/></span>
					  <a id="homeBoardPot_" class="btn_wf_modify imgLink" brdPos="MLT20" onclick="cfGGum.getLayMngr().openConfBoard(this); return false;" href="#"><util:message key="ev.hnevent.common.setting"/></a>
					  <div class="wf_boardIcon"></div>
					</div>
				  </div>
				  <div class="wf_board_empty">
					<div class="wf_board_sub wf_board_sub_ver wf_board_sub_hor">
					  <span class="gg_board_title_RT"><util:message key="cf.info.ttl.none.board"/></span>
					  <a id="homeBoardPot_" class="btn_wf_modify imgLink" brdPos="MRT20" onclick="cfGGum.getLayMngr().openConfBoard(this); return false;" href="#"><util:message key="ev.hnevent.common.setting"/></a>
					  <div class="wf_boardIcon"></div>
					</div>
				  </div>
				</div>
				<div class="wf_board gg_board_MLT20_MRT10_MRB10" style="cursor: move;">
				  <div class="wf_board_del_bg">
					<a class="btn_wf_del imgLink" onclick="cfGGum.getLayMngr().removeBoardGroup(this); return false;"><util:message key="cf.title.remove"/></a>
				  </div>
				  <div class="wf_board_empty">
					<div class="wf_board_sub wf_board_sub_ver wf_board_sub_hor">
					  <span class="gg_board_title_LT"><util:message key="cf.info.ttl.none.board"/></span>
					  <a id="homeBoardPot_" class="btn_wf_modify imgLink" brdPos="MLT20" onclick="cfGGum.getLayMngr().openConfBoard(this); return false;" href="#"><util:message key="ev.hnevent.common.setting"/></a>
					  <div class="wf_boardIcon"></div>
					</div>
				  </div>
				  <div class="wf_board_sub wf_board_sub_hor">
					<div class="wf_board_empty">
					  <div class="wf_board_sub wf_board_sub_up">
						<span class="gg_board_title_RT"><util:message key="cf.info.ttl.none.board"/></span>
						<a id="homeBoardPot_" class="btn_wf_modify imgLink" brdPos="MRT10" onclick="cfGGum.getLayMngr().openConfBoard(this); return false;" href="#"><util:message key="ev.hnevent.common.setting"/></a>
						<div class="wf_boardIcon"></div>
					  </div>
					</div>
					<div class="wf_board_empty">
					  <div class="wf_board_sub wf_board_sub_down">
						<span class="gg_board_title_RB"><util:message key="cf.info.ttl.none.board"/></span>
						<a id="homeBoardPot_" class="btn_wf_modify imgLink" brdPos="MRB10" onclick="cfGGum.getLayMngr().openConfBoard(this); return false;" href="#"><util:message key="ev.hnevent.common.setting"/></a>
						<div class="wf_boardIcon"></div>
					  </div>
					</div>
				  </div>
				</div>
				<div class="wf_board gg_board_MLT10_MRT20_MLB10" style="cursor: move;">
				  <div class="wf_board_del_bg">
					<a class="btn_wf_del imgLink" onclick="cfGGum.getLayMngr().removeBoardGroup(this); return false;"><util:message key="cf.title.remove"/></a>
				  </div>
				  <div class="wf_board_sub wf_board_sub_hor">
					<div class="wf_board_empty">
					  <div class="wf_board_sub wf_board_sub_up">
						<span class="gg_board_title_LT"><util:message key="cf.info.ttl.none.board"/></span>
						<a id="homeBoardPot_" class="btn_wf_modify imgLink" brdPos="MLT10" onclick="cfGGum.getLayMngr().openConfBoard(this); return false;" href="#"><util:message key="ev.hnevent.common.setting"/></a>
						<div class="wf_boardIcon"></div>
					  </div>
					</div>
					<div class="wf_board_empty">
					  <div class="wf_board_sub wf_board_sub_down">
						<span class="gg_board_title_LB"><util:message key="cf.info.ttl.none.board"/></span>
						<a id="homeBoardPot_" class="btn_wf_modify imgLink" brdPos="MLB10" onclick="cfGGum.getLayMngr().openConfBoard(this); return false;" href="#"><util:message key="ev.hnevent.common.setting"/></a>
						<div class="wf_boardIcon"></div>
					  </div>
					</div>
				  </div>
				  <div class="wf_board_empty">
					<div class="wf_board_sub wf_board_sub_ver wf_board_sub_hor">
					  <span class="gg_board_title_RT"><util:message key="cf.info.ttl.none.board"/></span>
					  <a id="homeBoardPot_" class="btn_wf_modify imgLink" brdPos="MRT20" onclick="cfGGum.getLayMngr().openConfBoard(this); return false;" href="#"><util:message key="ev.hnevent.common.setting"/></a>
					  <div class="wf_boardIcon"></div>
					</div>
				  </div>
				</div>				
		</div>
		<div id="wf_BOARDTYPEGROUPS" style="display:none"><%--원래없는 부분.Javascript의 편의를 위해 HTML 조각을 미리 로딩해 놓기위한 용도.2012.05.10.KWShin.--%>
						<!-- menu.cnttType::legend
						'10'::'일반 게시판'
						'11'::'익명 게시판'
						'12'::'Q/A  게시판'
						'13'::'사진 게시판'
						'14'::'한줄 메모장'
						'90'::'최신글'
						'91'::'인기글'
						'92'::'이미지보기'
						'93'::'동영상보기'
						-->
					  <!--p boardType="_empty_" class="none_type"><util:message key="cf.info.selectBoard"/></p-->
					  <ul boardType="_empty_" class="none_type">
					    <p class="none_type"><util:message key="cf.info.selectBoard"/></p>
					  </ul>
					  <!-- 일반/익명/QnA/최신/인기글 이 선택됐을 때-->
					  <ul boardType="_10_11_12_90_91_" class="homeBoardEditTypeList">
						<li class="first" <c:if test="${menuUse.layoutBoardList == 'false'}">style="display:none"</c:if>>
						  <a class="home_stxt_666" onclick="cfGGum.getLayMngr().selectConfBoard('LIST'); return false;" href="#">
							<div id="gg_boardIcon_LIST" class="wf_boardEditIcon gg_boardIcon_LIST"></div>
								<util:message key="cf.prop. ListType"/>
						  </a>
						  <div id="selectedBoardType" class="selected_icon" brdType="LIST"></div>
						</li>
						<li<c:if test="${menuUse.layoutBoardSum1 == 'false'}"> style="display:none"</c:if>>
						  <a class="home_stxt_666" onclick="cfGGum.getLayMngr().selectConfBoard('SUM1'); return false;" href="#">
							<div id="gg_boardIcon_SUM1" class="wf_boardEditIcon gg_boardIcon_SUM1"></div>
								<util:message key="cf.prop.summary"/>1
						  </a>
						</li>
						<li<c:if test="${menuUse.layoutBoardSum2 == 'false'}"> style="display:none"</c:if>>
						  <a class="home_stxt_666" onclick="cfGGum.getLayMngr().selectConfBoard('SUM2'); return false;" href="#">
							<div id="gg_boardIcon_SUM2" class="wf_boardEditIcon gg_boardIcon_SUM2"></div>
								<util:message key="cf.prop.summary"/>2
						  </a>
						</li>
						<li<c:if test="${menuUse.layoutBoardSum3 == 'false'}"> style="display:none"</c:if>>
						  <a class="home_stxt_666" onclick="cfGGum.getLayMngr().selectConfBoard('SUM3'); return false;" href="#">
							<div id="gg_boardIcon_SUM3" class="wf_boardEditIcon gg_boardIcon_SUM3"></div>
								<util:message key="cf.prop.summary"/>3
						  </a>
						</li>
						<li<c:if test="${menuUse.layoutBoardSum4 == 'false'}"> style="display:none"</c:if>>
						  <a class="home_stxt_666" onclick="cfGGum.getLayMngr().selectConfBoard('SUM4'); return false;" href="#">
							<div id="gg_boardIcon_SUM4" class="wf_boardEditIcon gg_boardIcon_SUM4"></div>
								<util:message key="cf.prop.summary"/>4
						  </a>
						</li>
					  </ul>
					  <!-- 한줄메모장 이 선택됐을 때-->
					  <ul boardType="_14_" class="homeBoardEditTypeList">
						<li class="first">
						  <a class="home_stxt_666" onclick="cfGGum.getLayMngr().selectConfBoard('MEMO'); return false;" href="#">
							<div id="gg_boardIcon_MEMO" class="wf_boardEditIcon gg_boardIcon_MEMO"></div>
								<util:message key="cf.prop.generalType"/>
						  </a>
						  <div id="selectedBoardType" class="selected_icon" brdType="MEMO"></div>
						</li>
					  </ul>
					  <!-- 사진게시판/이미지보기 가 선택됐을 때-->
					  <ul boardType="_13_92_" class="homeBoardEditTypeList">
						<li class="first">
						  <a class="home_stxt_666" onclick="cfGGum.getLayMngr().selectConfBoard('IMG1'); return false;" href="#">
							<div id="gg_boardIcon_IMG1" class="wf_boardEditIcon gg_boardIcon_IMG1"></div>
								<util:message key="cf.prop.thumb"/>
						  </a>
						  <div id="selectedBoardType" class="selected_icon" brdType="IMG1"></div>
						</li>
						<li>
						  <a class="home_stxt_666" onclick="cfGGum.getLayMngr().selectConfBoard('IMG2'); return false;" href="#">
							<div id="gg_boardIcon_IMG2" class="wf_boardEditIcon gg_boardIcon_IMG2"></div>
								<util:message key="cf.prop.album"/>1
						  </a>
						</li>
						<li>
						  <a class="home_stxt_666" onclick="cfGGum.getLayMngr().selectConfBoard('IMG3'); return false;" href="#">
							<div id="gg_boardIcon_IMG3" class="wf_boardEditIcon gg_boardIcon_IMG3"></div>
								<util:message key="cf.prop.album"/>2
						  </a>
						</li>
					  </ul>
					  <!-- 동영상이 선택됐을 때-->
					  <ul boardType="_93_" class="homeBoardEditTypeList">
						<li class="first">
						  <a class="home_stxt_666" onclick="cfGGum.getLayMngr().selectConfBoard('MOV'); return false;" href="#">
							<div id="gg_boardIcon_MOV" class="wf_boardEditIcon gg_boardIcon_MOV"></div>
								<util:message key="cf.prop.thumb"/>
						  </a>
						  <div id="selectedBoardType" class="selected_icon" brdType="MOV"></div>
						</li>
					  </ul>
		</div>
		<div id="ggBUGABOXES" style="display:none">
				<%--부가컨텐츠가 추가되면 새로운 Box <DIV>를 아래 형식에 맞추어 이 부분에 추가하면 됨.2012.05.16.KWShin.--%>
				<div id="CafeBugaMemberPortlet" class="wf_component wf_component_m" style="cursor: move;">
				  <a class="btn_wf_del imgLink">delete</a>
				  	<util:message key="cf.prop.memberNotification"/>
			    </div> 
				<div id="CafeBugaHotPortlet" class="wf_component wf_component_m" style="cursor: move;">
				  <a class="btn_wf_del imgLink">delete</a>
				  	<util:message key="cf.prop.lastWeek"/>
				  <br>
				  	<util:message key="cf.prop.popularWriting"/>
				</div>
		</div>
	</div>
	<script type="text/javascript">
		jQuery(function($){
			$("#remote_mini_menu").tabs();
		});	
	</script>
  <%--/div--%>
  <%--END::GGum Area--%>