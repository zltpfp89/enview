<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<DIV style="CURSOR: move" id=componentTitleArea>
<DIV class=roundL></DIV>
<DL>
<DT id=componentTitleText class=cafeinfo>제목 </DT>
<DD><A onclick="(new cube.controller.title.EditorLayerController()).onClickCancel(); return false;" href="#">닫기</A> </DD></DL>
<DIV class=roundR></DIV></DIV>
<DIV id=componentEditorArea>
<DIV style="DISPLAY: none" id=disabledComponentLayer></DIV>
<DIV id=componentView>
<DIV style="DISPLAY: none" id=TITLETEMPLATE_area>
<DIV id=templateEditor>
<P>한 번에 쉽고 빠르게 멋진 타이틀을 만들어 보세요 </P>
<UL>
<LI onclick="(new cube.controller.title.TemplateController()).onSelectDesignSet(this, '221');"><IMG src="http://cafeimg.daum-img.net/cf_img4/thumb/title_set/title36.gif" width=500 height=90></LI>
<LI onclick="(new cube.controller.title.TemplateController()).onSelectDesignSet(this, '171');"><IMG src="http://cafeimg.daum-img.net/cf_img4/thumb/title_set/title35.gif" width=500 height=90></LI>
<LI onclick="(new cube.controller.title.TemplateController()).onSelectDesignSet(this, '170');"><IMG src="http://cafeimg.daum-img.net/cf_img4/thumb/title_set/title34.gif" width=500 height=90></LI>
<LI onclick="(new cube.controller.title.TemplateController()).onSelectDesignSet(this, '169');"><IMG src="http://cafeimg.daum-img.net/cf_img4/thumb/title_set/title33.gif" width=500 height=90></LI></UL>
<DIV style="DISPLAY: none" id=selectedLayerBox></DIV>
<DIV id=paging>
<TABLE class=pg_area align=center>
<TBODY>
<TR>
<TD><SPAN class="pg_btn prev_btn">이전</SPAN> <SPAN class=page_selected>1</SPAN> <A onclick="(new cube.controller.title.TemplateController()).onClickPage('', '', '2', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">2</A> <A onclick="(new cube.controller.title.TemplateController()).onClickPage('', '', '3', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">3</A> <A onclick="(new cube.controller.title.TemplateController()).onClickPage('', '', '4', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">4</A> <A onclick="(new cube.controller.title.TemplateController()).onClickPage('', '', '5', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">5</A> <A class="pg_btn next_btn" onclick="(new cube.controller.title.TemplateController()).onClickPage('', '', '6', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">▶</A> </TD></TR></TBODY></TABLE></DIV></DIV></DIV>
<DIV style="DISPLAY: none" id=TITLEBACKGROUND_area>
<DIV id=backgroundEditor>
<DIV style="DISPLAY: none" id=disabledLayer></DIV>
<UL class=backgroundTab>
<LI id=patternTab class=selected><IMG id=d2w_radioType1 class="img_radiobtn rb_checked" tabIndex=0 src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" width=13 height=14><INPUT id=radioType1 class=checkradio_styled onclick="(new cube.controller.title.BackgroundController()).onClickBackgroundTab('pattern');" name=backgroundType value="" CHECKED type=radio><LABEL class=hand>디자인</LABEL> </LI>
<LI id=colorTab><IMG id=d2w_radioType2 class=img_radiobtn tabIndex=0 src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" width=13 height=14><INPUT id=radioType2 class=checkradio_styled onclick="(new cube.controller.title.BackgroundController()).onClickBackgroundTab('color');" name=backgroundType value="" type=radio><LABEL class=hand>색상</LABEL> </LI>
<LI id=userimageTab><IMG id=d2w_radioType3 class=img_radiobtn tabIndex=0 src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" width=13 height=14><INPUT id=radioType3 class=checkradio_styled onclick="(new cube.controller.title.BackgroundController()).onClickBackgroundTab('userimage');" name=backgroundType value="" type=radio><LABEL class=hand>직접올리기</LABEL> </LI></UL>
<DIV id=patternView>
<DIV id=patternListArea>
<DIV class=designListBox>
<UL id=backgroundDesignSetList>
<LI onclick="(new cube.controller.title.BackgroundController()).onSelectDesignSet(this, '');"><IMG alt=배경없음 src="http://i1.daumcdn.net/cafeimg/cf_img4/design/title/title_l_patt.gif" width=96 height=88> </LI>
<LI onclick="(new cube.controller.title.BackgroundController()).onSelectDesignSet(this, '11273');"><IMG alt=108 src="http://cafeimg.daum-img.net/cf_img4/thumb/title_bg/title_bg108.gif" width=96 height=88> </LI>
<LI onclick="(new cube.controller.title.BackgroundController()).onSelectDesignSet(this, '11271');"><IMG alt=107 src="http://cafeimg.daum-img.net/cf_img4/thumb/title_bg/title_bg107.gif" width=96 height=88> </LI>
<LI onclick="(new cube.controller.title.BackgroundController()).onSelectDesignSet(this, '11276');"><IMG alt=110 src="http://cafeimg.daum-img.net/cf_img4/thumb/title_bg/title_bg110.gif" width=96 height=88> </LI>
<LI onclick="(new cube.controller.title.BackgroundController()).onSelectDesignSet(this, '11283');"><IMG alt=112 src="http://cafeimg.daum-img.net/cf_img4/thumb/title_bg/title_bg112.gif" width=96 height=88> </LI>
<LI onclick="(new cube.controller.title.BackgroundController()).onSelectDesignSet(this, '11286');"><IMG alt=115 src="http://cafeimg.daum-img.net/cf_img4/thumb/title_bg/title_bg115.gif" width=96 height=88> </LI></UL></DIV>
<DIV id=paging>
<TABLE class=pg_area align=center>
<TBODY>
<TR>
<TD><SPAN class="pg_btn prev_btn">이전</SPAN> <SPAN class=page_selected>1</SPAN> <A onclick="(new cube.controller.title.BackgroundController()).onClickPage('', '', '2', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">2</A> <A onclick="(new cube.controller.title.BackgroundController()).onClickPage('', '', '3', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">3</A> <A onclick="(new cube.controller.title.BackgroundController()).onClickPage('', '', '4', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">4</A> <A onclick="(new cube.controller.title.BackgroundController()).onClickPage('', '', '5', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">5</A> <A class="pg_btn next_btn" onclick="(new cube.controller.title.BackgroundController()).onClickPage('', '', '6', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">▶</A> </TD></TR></TBODY></TABLE></DIV></DIV>
<DIV style="TOP: 103px; LEFT: 14px" id=selectedBgDesignBox>&nbsp;</DIV></DIV><!-- end 패턴 꾸미기 -->
<DIV style="DISPLAY: none" id=colorView>
<DIV id=previewBox>
<DIV style="BORDER-BOTTOM: #000000 2px solid; FILTER: alpha(opacity=37); BORDER-LEFT: #000000 2px solid; BACKGROUND-COLOR: #faecc5; WIDTH: 136px; HEIGHT: 116px; BORDER-TOP: #000000 2px solid; BORDER-RIGHT: #000000 2px solid; opacity: 0.37; KhtmlOpacity: 0.37; MozOpacity: 0.37" id=previewColorBox></DIV></DIV>
<UL class=control>
<LI class=control><LABEL>바탕색</LABEL> 
<DIV style="BACKGROUND-COLOR: #faecc5" id=titleBgColor class=colorSelectBox_styled>
<DIV id=d2w_titleBgColor class=colorViewer></DIV>
<DIV class=colorSelectEnabled></DIV></DIV></LI>
<LI class=control><LABEL>테두리</LABEL> 
<DIV style="Z-INDEX: 10000; BACKGROUND-POSITION: 0px -42px" id=titleBorderWidth class="border_styler border_styler_LINE_TITLE">
<UL style="DISPLAY: none" id=dw_titleBorderWidth_targetLayer>
<LI style="BACKGROUND-POSITION: 0px 0px">0</LI>
<LI style="BACKGROUND-POSITION: 0px -22px">1</LI>
<LI style="BACKGROUND-POSITION: 0px -44px">2</LI>
<LI style="BACKGROUND-POSITION: 0px -66px">3</LI>
<LI style="BACKGROUND-POSITION: 0px -88px">4</LI>
<LI style="BACKGROUND-POSITION: 0px -110px">5</LI></UL></DIV>
<DIV style="BACKGROUND-COLOR: #000000" id=titleBorderColor class=colorSelectBox_styled>
<DIV id=d2w_titleBorderColor class=colorViewer></DIV>
<DIV class=colorSelectEnabled></DIV></DIV></LI>
<LI class=control><LABEL>투명도</LABEL> 
<DIV class=slider_area><A class=slider_l_btn title=- onclick="(new cube.controller.title.BackgroundController()).onClickTransparent('minus'); return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">-</A> 
<DIV id=transparentSlider>
<DIV style="WIDTH: 60px; BACKGROUND: url(http://i1.daumcdn.net/cafeimg/cf_img4/design/gate/leftzone_bg.gif) repeat-x" class=dhtmlxSlider title=63 _etype="slider">
<DIV style="BACKGROUND: url(http://i1.daumcdn.net/cafeimg/cf_img4/design/gate/leftside_bg.gif) repeat-x" class=leftSide></DIV>
<DIV style="WIDTH: 32px; BACKGROUND: url(http://i1.daumcdn.net/cafeimg/cf_img4/design/gate/leftzone_bg.gif) repeat-x" class=leftZone></DIV>
<DIV style="WIDTH: 25px; LEFT: 33px" class=rightZone></DIV>
<DIV style="BACKGROUND: url(http://i1.daumcdn.net/cafeimg/cf_img4/design/gate/rightside_bg.gif) repeat-x" class=rightSide></DIV>
<DIV style="BACKGROUND: url(http://i1.daumcdn.net/cafeimg/cf_img4/design/gate/selector.gif) no-repeat; LEFT: 32px" class=selector _etype="drag"></DIV></DIV></DIV><A class=slider_r_btn title=+ onclick="(new cube.controller.title.BackgroundController()).onClickTransparent('plus'); return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">+</A> </DIV></LI></UL></DIV><!-- end 색상 꾸미기 -->
<DIV style="DISPLAY: none" id=userimageView>
<DL>
<DT>
<DIV class=priview_img><IMG id=previewUserImage src="http://cfile283.uf.daum.net/P100x100/183CB2374FB1DE51324BB0"> </DIV><A id=btnImageDelete onclick="(new cube.controller.title.BackgroundController()).onClickDeleteImage();">삭제</A> </DT>
<DD>
<UL>
<LI class=control>
<DIV><LABEL class=title_stxt555>이미지</LABEL> 
<OBJECT id=cocapreviewUserImage class=coca_uploader name=cocapreviewUserImage classid=clsid:D27CDB6E-AE6D-11cf-96B8-444553540000 width=60 height=30><PARAM NAME="_cx" VALUE="5080"><PARAM NAME="_cy" VALUE="5080"><PARAM NAME="FlashVars" VALUE="coca_service=CafeWebzineCubeCoca&amp;sid=cafe&amp;service=cafe&amp;sname=cafe&amp;coca_ctx=previewUserImage&amp;jscall_prefix=CocaOption.previewUserImage&amp;coca_skin=http://i1.daumcdn.net/cafeimg/cf_img4/design/common/bt_search.gif&amp;single_selection=true"><PARAM NAME="Movie" VALUE="http://editor.daum.net/coca_service/1.1.13/coca.swf?ver=13"><PARAM NAME="Src" VALUE="http://editor.daum.net/coca_service/1.1.13/coca.swf?ver=13"><PARAM NAME="WMode" VALUE="Transparent"><PARAM NAME="Play" VALUE="-1"><PARAM NAME="Loop" VALUE="-1"><PARAM NAME="Quality" VALUE="High"><PARAM NAME="SAlign" VALUE="LT"><PARAM NAME="Menu" VALUE="0"><PARAM NAME="Base" VALUE=""><PARAM NAME="AllowScriptAccess" VALUE="always"><PARAM NAME="Scale" VALUE="NoScale"><PARAM NAME="DeviceFont" VALUE="0"><PARAM NAME="EmbedMovie" VALUE="0"><PARAM NAME="BGColor" VALUE=""><PARAM NAME="SWRemote" VALUE=""><PARAM NAME="MovieData" VALUE=""><PARAM NAME="SeamlessTabbing" VALUE="1"><PARAM NAME="Profile" VALUE="0"><PARAM NAME="ProfileAddress" VALUE=""><PARAM NAME="ProfilePort" VALUE="0"><PARAM NAME="AllowNetworking" VALUE="all"><PARAM NAME="AllowFullScreen" VALUE="false"><PARAM NAME="AllowFullScreenInteractive" VALUE=""></OBJECT></DIV>
<P class=notice>1MB 이하 / jpg, gif</P>
<P>가로 971px</P></LI>
<LI class=control><LABEL class=title_stxt555>크기</LABEL> <A style="WIDTH: 53px" id=d2w_titleUserRepeat class=img_selectbox tabIndex=0>전체반복</A><SELECT id=titleUserRepeat onchange="(new cube.controller.title.BackgroundController()).onClickUserImageRepeat(this.value);" class=selectbox_styled> <OPTION value=no-repeat>원래크기</OPTION> <OPTION selected value=repeat>전체반복</OPTION></SELECT> </LI>
<LI class=control><LABEL class=title_stxt555>배경</LABEL> 
<DIV style="BACKGROUND-COLOR: #faecc5" id=titleUserColor class=colorSelectBox_styled>
<DIV id=d2w_titleUserColor class=colorViewer></DIV>
<DIV class=colorSelectDisabled></DIV></DIV></LI>
<LI class=control><LABEL class=title_stxt555>위치</LABEL> 
<DIV id=titleUserPosition class=positionSelectBox_styled>
<DIV style="BACKGROUND-POSITION: right bottom" id=d2w_titleUserPosition class=positionSelectBox_viewer></DIV>
<DIV style="DISPLAY: none; BACKGROUND-POSITION: right bottom" id=d2w_titleUserPosition_layer class=layer></DIV>
<DIV style="Z-INDEX: 1; POSITION: absolute; FILTER: alpha(opacity=50); BACKGROUND-COLOR: #ffffff; WIDTH: 19px; HEIGHT: 18px; TOP: 0px; LEFT: 0px; opacity: 0.5; KhtmlOpacity: 0.5; MozOpacity: 0.5" class=__disable_layer></DIV></DIV></LI></UL></DD></DL></DIV><!-- end 사용자 이미지 꾸미기 --></DIV></DIV>
<DIV style="DISPLAY: none" id=TITLEMENUGROUP_area>
<DIV id=menuGroupEditor>
<DIV class=detailDesignArea>
<DIV id=barDesignBox>
<DIV id=previewBarBox class=scroll>
<DIV style="TOP: 25px; LEFT: 20px" id=barPreviewer>
<DIV class=roundL></DIV>
<UL id=previewMenuList>
<LI>
<DIV style="BACKGROUND-IMAGE: none; WIDTH: 93px; HEIGHT: 35px; LEFT: -15px" class=menu_layer>
<DIV style="BACKGROUND-IMAGE: none; WIDTH: 91px; HEIGHT: 33px" class=inner_layer>
<DIV style="BACKGROUND-IMAGE: none; BACKGROUND-COLOR: #fff; WIDTH: 91px; HEIGHT: 33px" class=inner_layer_blind></DIV></DIV>
<DIV style="BACKGROUND-IMAGE: none; WIDTH: 91px; DISPLAY: none" class=layer_btns><A class=btn_s_config onclick="(new cube.controller.title.MenuGroupController()).onClickMenuBtns(0, 'edit');">설정</A><A class=btn_s_remove onclick="(new cube.controller.title.MenuGroupController()).onClickMenuBtns(0, 'delete');">삭제</A></DIV></DIV>
<DIV><A class="menu1 first">최신글 보기</A></DIV></LI>
<LI class=mbar>|</LI>
<LI class=on>
<DIV style="BACKGROUND-IMAGE: none; WIDTH: 93px; HEIGHT: 35px" class=menu_layer>
<DIV style="BACKGROUND-IMAGE: none; WIDTH: 91px; HEIGHT: 33px" class=inner_layer>
<DIV style="BACKGROUND-IMAGE: none; BACKGROUND-COLOR: #fff; WIDTH: 91px; HEIGHT: 33px" class=inner_layer_blind></DIV></DIV>
<DIV style="BACKGROUND-IMAGE: none; WIDTH: 91px; DISPLAY: none" class=layer_btns><A class=btn_s_config onclick="(new cube.controller.title.MenuGroupController()).onClickMenuBtns(1, 'edit');">설정</A><A class=btn_s_remove onclick="(new cube.controller.title.MenuGroupController()).onClickMenuBtns(1, 'delete');">삭제</A></DIV></DIV>
<DIV><A class=menu2>인기글 보기</A></DIV></LI>
<LI class=mbar>|</LI>
<LI>
<DIV style="BACKGROUND-IMAGE: none; WIDTH: 93px; HEIGHT: 35px" class=menu_layer>
<DIV style="BACKGROUND-IMAGE: none; WIDTH: 91px; HEIGHT: 33px" class=inner_layer>
<DIV style="BACKGROUND-IMAGE: none; BACKGROUND-COLOR: #fff; WIDTH: 91px; HEIGHT: 33px" class=inner_layer_blind></DIV></DIV>
<DIV style="BACKGROUND-IMAGE: none; WIDTH: 91px; DISPLAY: none" class=layer_btns><A class=btn_s_config onclick="(new cube.controller.title.MenuGroupController()).onClickMenuBtns(2, 'edit');">설정</A><A class=btn_s_remove onclick="(new cube.controller.title.MenuGroupController()).onClickMenuBtns(2, 'delete');">삭제</A></DIV></DIV>
<DIV><A class=menu3>이미지 보기</A></DIV></LI>
<LI class=mbar>|</LI>
<LI>
<DIV style="BACKGROUND-IMAGE: none; WIDTH: 93px; HEIGHT: 35px" class=menu_layer>
<DIV style="BACKGROUND-IMAGE: none; WIDTH: 91px; HEIGHT: 33px" class=inner_layer>
<DIV style="BACKGROUND-IMAGE: none; BACKGROUND-COLOR: #fff; WIDTH: 91px; HEIGHT: 33px" class=inner_layer_blind></DIV></DIV>
<DIV style="BACKGROUND-IMAGE: none; WIDTH: 91px; DISPLAY: none" class=layer_btns><A class=btn_s_config onclick="(new cube.controller.title.MenuGroupController()).onClickMenuBtns(3, 'edit');">설정</A><A class=btn_s_remove onclick="(new cube.controller.title.MenuGroupController()).onClickMenuBtns(3, 'delete');">삭제</A></DIV></DIV>
<DIV><A class=menu4>동영상 보기</A></DIV></LI>
<LI class=mbar>|</LI>
<LI>
<DIV style="BACKGROUND-IMAGE: none; WIDTH: 117px; HEIGHT: 35px" class=menu_layer>
<DIV style="BACKGROUND-IMAGE: none; WIDTH: 115px; HEIGHT: 33px" class=inner_layer>
<DIV style="BACKGROUND-IMAGE: none; BACKGROUND-COLOR: #fff; WIDTH: 115px; HEIGHT: 33px" class=inner_layer_blind></DIV></DIV>
<DIV style="BACKGROUND-IMAGE: none; WIDTH: 115px; DISPLAY: none" class=layer_btns><A class=btn_s_config onclick="(new cube.controller.title.MenuGroupController()).onClickMenuBtns(4, 'edit');">설정</A><A class=btn_s_remove onclick="(new cube.controller.title.MenuGroupController()).onClickMenuBtns(4, 'delete');">삭제</A></DIV></DIV>
<DIV><A class=menu5>우리들의 이야기</A></DIV></LI></UL>
<DIV class=roundR></DIV></DIV><!-- end barPreviewer --></DIV><!-- end previewBarBox -->
<UL class=bar_control>
<LI><LABEL class=title_txt555>기본색</LABEL> 
<DIV style="BACKGROUND-COLOR: #666666" id=barFontColor class=colorSelectBox_styled>
<DIV id=d2w_barFontColor class=textColorViewer></DIV>
<DIV class=colorSelectEnabled></DIV></DIV></LI>
<LI><LABEL class=title_txt555>선택색</LABEL> 
<DIV style="BACKGROUND-COLOR: #000000" id=barPointColor class=colorSelectBox_styled>
<DIV id=d2w_barPointColor class=textColorViewer></DIV>
<DIV class=colorSelectEnabled></DIV></DIV></LI>
<LI style="DISPLAY: none" id=barColorControl><LABEL class=title_txt555>배경색 </LABEL>
<DIV style="BACKGROUND-IMAGE: url(http://i1.daumcdn.net/cafeimg/cf_img4/design/common/color_chip_clear2.gif); BACKGROUND-COLOR: transparent" id=barBgColor class=colorSelectBox_styled>
<DIV id=d2w_barBgColor class=colorViewer></DIV>
<DIV class=colorSelectEnabled></DIV></DIV></LI>
<LI class=menu_add><A class=btn_addmenu onclick="(new cube.controller.title.MenuGroupController()).onClickAddMenu(); return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">메뉴추가</A> </LI></UL></DIV><!-- end barDesignBox -->
<DIV id=btnDesignBox class=hidden>
<DIV id=previewBtnBox>
<OBJECT id=btnPreviewer name=btnPreviewer classid=clsid:D27CDB6E-AE6D-11cf-96B8-444553540000 width=480 height=110><PARAM NAME="_cx" VALUE="26"><PARAM NAME="_cy" VALUE="26"><PARAM NAME="FlashVars" VALUE="preview=true&amp;background=true&amp;width=480&amp;height=110&amp;clickItemEdit_callback=(new cube.controller.title.MenuGroupController()).onClickMenuBtns&amp;clickItemDelete_callback=(new cube.controller.title.MenuGroupController()).onClickMenuBtns"><PARAM NAME="Movie" VALUE="http://cafeimg.daum-img.net/cf_img4/affogato/btnbargenv3.swf?20091228"><PARAM NAME="Src" VALUE="http://cafeimg.daum-img.net/cf_img4/affogato/btnbargenv3.swf?20091228"><PARAM NAME="WMode" VALUE="Transparent"><PARAM NAME="Play" VALUE="-1"><PARAM NAME="Loop" VALUE="0"><PARAM NAME="Quality" VALUE="High"><PARAM NAME="SAlign" VALUE=""><PARAM NAME="Menu" VALUE="0"><PARAM NAME="Base" VALUE="http://cafeimg.daum-img.net/cf_img4/affogato/"><PARAM NAME="AllowScriptAccess" VALUE="always"><PARAM NAME="Scale" VALUE="ShowAll"><PARAM NAME="DeviceFont" VALUE="0"><PARAM NAME="EmbedMovie" VALUE="0"><PARAM NAME="BGColor" VALUE=""><PARAM NAME="SWRemote" VALUE=""><PARAM NAME="MovieData" VALUE=""><PARAM NAME="SeamlessTabbing" VALUE="1"><PARAM NAME="Profile" VALUE="0"><PARAM NAME="ProfileAddress" VALUE=""><PARAM NAME="ProfilePort" VALUE="0"><PARAM NAME="AllowNetworking" VALUE="all"><PARAM NAME="AllowFullScreen" VALUE="false"><PARAM NAME="AllowFullScreenInteractive" VALUE=""></OBJECT></DIV><!-- end previewBtnBox -->
<UL class=btn_control>
<LI class=control><A style="WIDTH: 131px" id=d2w_btnFontFamily class=img_selectbox tabIndex=0>다음Regular</A><SELECT id=btnFontFamily onchange="(new cube.controller.title.MenuGroupController()).onChangeBtnFontFamily(this.value);" class=selectbox_styled scrollsize="200"> <OPTION value=DaumRegular>다음Regular</OPTION> <OPTION value=RixGoM>RIX 고딕M</OPTION> <OPTION value=RixMjM>RIX 명조M</OPTION> <OPTION value=RixOctloveM>RIX 시월애M</OPTION> <OPTION value=RixMindure>RIX 민들레</OPTION> <OPTION value=SandolKwangsu2M>산돌 광수투M</OPTION> <OPTION value=PumhangZero>품행제로</OPTION> <OPTION value=Sooksook>성적이쑥쑥</OPTION> <OPTION value=MiniSaladBar>미니샐러드바</OPTION> <OPTION value=CoffeeNDonut>커피N도넛</OPTION> <OPTION value=Sandol02M>산돌 02M</OPTION> <OPTION value=RixMGoM>RIX 모던고딕M</OPTION> <OPTION value=RixSMjB>RIX 신문명조B</OPTION> <OPTION value=RixLemonadeM>RIX 레모네이드M</OPTION> <OPTION value=RixFreestyleBPRO>RIX 프리스타일B PRO</OPTION> <OPTION value=RixMelangchollyM>RIX 멜랑촐리M</OPTION> <OPTION value=RixGoMaejumM>RIX 매점갈시간M</OPTION> <OPTION value=RixWansoM>RIX 완전소중M</OPTION> <OPTION value=RixPinkRibbonM>RIX 핑크리본M</OPTION> <OPTION value=RixDearGiraffeM>RIX 기린에게M</OPTION> <OPTION value=RixStarNMeM>RIX 별과나M</OPTION></SELECT> </LI>
<LI class=control><LABEL class=title_txt555>폰트색</LABEL> 
<DIV style="BACKGROUND-COLOR: #000000" id=btnFontColor class=colorSelectBox_styled>
<DIV id=d2w_btnFontColor class=textColorViewer></DIV>
<DIV class=colorSelectEnabled></DIV></DIV></LI>
<LI id=btnColorControl class=control><LABEL class=title_txt555>아이콘색</LABEL> 
<DIV style="BACKGROUND-COLOR: #000000" id=btnIconColor class=colorSelectBox_styled>
<DIV id=d2w_btnIconColor class=colorViewer></DIV>
<DIV class=colorSelectEnabled></DIV></DIV></LI>
<LI class=menu_add><A class=btn_addmenu onclick="(new cube.controller.title.MenuGroupController()).onClickAddMenu(); return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">메뉴추가</A> </LI></UL></DIV><!-- end btnDesignBox -->
<DIV style="DISPLAY: none" id=menuItemBlindLayer></DIV>
<DIV style="DISPLAY: none" id=menuItemConfigLayer>
<DIV style="DISPLAY: none" id=disabledConfigLayer></DIV>
<DL class=config_header>
<DT>상세설정</DT>
<DD><A onclick="(new cube.controller.title.MenuGroupController()).onClickConfigCancel(); return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">X</A></DD></DL>
<UL class=config_control>
<LI class=control><LABEL>메뉴</LABEL> 
<DIV id=menuItemListArea><A style="WIDTH: 154px" id=d2w_menuItemSelector class=img_selectbox tabIndex=0>카페 앨범</A><SELECT id=menuItemSelector onchange="(new cube.controller.title.MenuGroupController()).onSelectMenuItem(this);" class=selectbox_styled scrollsize="112" fixedsize="189">    <OPTION selected value=EEvv>카페 앨범</OPTION> <OPTION value=EEvw>Q&amp;A 게시판</OPTION> <OPTION value=_memo>한 줄 수다</OPTION> <OPTION value=EEvx>RSS 게시판</OPTION>  </SELECT> 
<DIV style="DISPLAY: none" id=hiddenBoardTip class=tip_icon></DIV>
<DIV style="DISPLAY: none" id=noBoardTip class=tip_icon></DIV><SELECT style="DISPLAY: none" id=tempMenuItemSelector> <OPTION selected value=_rec>최신글 보기</OPTION> <OPTION value=_fav>인기글 보기</OPTION> <OPTION value=EEvu>우리들의 이야기</OPTION> <OPTION value=EEvv>카페 앨범</OPTION> <OPTION value=EEvw>Q&amp;A 게시판</OPTION> <OPTION value=_memo>한 줄 수다</OPTION> <OPTION value=EEvx>RSS 게시판</OPTION> <OPTION value=_image>이미지 보기</OPTION> <OPTION value=_movie>동영상 보기</OPTION></SELECT></DIV></LI>
<LI class=control><LABEL>메뉴명</LABEL> <INPUT id=menuItemName class=cube_input maxLength=22>
<DIV id=menuItemName_counter class=counter><STRONG id=menuItemName_cnt>0</STRONG>/10자</DIV> </LI>
<LI class=control>
<DIV style="DISPLAY: none" id=btnIconSelectArea><LABEL>아이콘</LABEL> 
<DIV id=iconSelector>
<DIV id=selectedIconBox>&nbsp;</DIV></DIV></DIV></LI></UL>
<DIV style="DISPLAY: none" id=noticeBoardText>게시판을 선택해 주세요.</DIV>
<DIV class=config_footer><A onclick="(new cube.controller.title.MenuGroupController()).onClickConfigConfirm(); return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#"><IMG class=btn_config_confirm alt=확인 src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" width=38 height=21> </A><A onclick="(new cube.controller.title.MenuGroupController()).onClickConfigCancel(); return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#"><IMG class=btn_config_cancel alt=취소 src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" width=38 height=21> </A></DIV></DIV><!-- end menuItemConfigLayer --></DIV><!-- end detailDesignArea --><A id=btnDesignSelect class=dropdown onclick="(new cube.controller.title.MenuGroupController()).onClickDesignSetArea(this); return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">메뉴 디자인 선택</A> 
<DIV id=menuDesignSetArea>
<UL class=menu_category>
<LI><IMG id=d2w_radioTypeBar class="img_radiobtn rb_checked" tabIndex=0 src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" width=13 height=14><INPUT id=radioTypeBar class=checkradio_styled onclick="(new cube.controller.title.MenuGroupController()).onClickMenuType('BAR');" name=menucategory value=BAR CHECKED type=radio><LABEL class="title_stxt555 hand">바형</LABEL> </LI>
<LI><IMG id=d2w_radioTypeBtn class=img_radiobtn tabIndex=0 src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" width=13 height=14><INPUT id=radioTypeBtn class=checkradio_styled onclick="(new cube.controller.title.MenuGroupController()).onClickMenuType('BTN');" name=menucategory value=BTN type=radio><LABEL class="title_stxt555 hand">버튼형</LABEL> </LI></UL>
<DIV id=menuDesignSetList>
<UL class=BAR>
<LI onclick="(new cube.controller.title.MenuGroupController()).onSelectDesignSet(this, '10405');"><IMG alt=10405 src="http://cafeimg.daum-img.net/cf_img4/thumb/title_bar/b01_5_bar.gif"> </LI>
<LI onclick="(new cube.controller.title.MenuGroupController()).onSelectDesignSet(this, '10404');"><IMG alt=10404 src="http://cafeimg.daum-img.net/cf_img4/thumb/title_bar/b01_4_bar.gif"> </LI>
<LI onclick="(new cube.controller.title.MenuGroupController()).onSelectDesignSet(this, '10394');"><IMG alt=10394 src="http://cafeimg.daum-img.net/cf_img4/thumb/title_bar/b01_3_bar.gif"> </LI>
<LI onclick="(new cube.controller.title.MenuGroupController()).onSelectDesignSet(this, '10384');"><IMG alt=10384 src="http://cafeimg.daum-img.net/cf_img4/thumb/title_bar/b01_2_bar.gif"> </LI>
<LI onclick="(new cube.controller.title.MenuGroupController()).onSelectDesignSet(this, '10333');"><IMG alt=10333 src="http://cafeimg.daum-img.net/cf_img4/thumb/title_bar/b01_1_bar.gif"> </LI>
<LI onclick="(new cube.controller.title.MenuGroupController()).onSelectDesignSet(this, '10432');"><IMG alt=10432 src="http://cafeimg.daum-img.net/cf_img4/thumb/title_bar/b02_5_bar.gif"> </LI>
<LI onclick="(new cube.controller.title.MenuGroupController()).onSelectDesignSet(this, '10431');"><IMG alt=10431 src="http://cafeimg.daum-img.net/cf_img4/thumb/title_bar/b02_4_bar.gif"> </LI>
<LI onclick="(new cube.controller.title.MenuGroupController()).onSelectDesignSet(this, '10430');"><IMG alt=10430 src="http://cafeimg.daum-img.net/cf_img4/thumb/title_bar/b02_3_bar.gif"> </LI>
<LI onclick="(new cube.controller.title.MenuGroupController()).onSelectDesignSet(this, '10429');"><IMG alt=10429 src="http://cafeimg.daum-img.net/cf_img4/thumb/title_bar/b02_2_bar.gif"> </LI>
<LI onclick="(new cube.controller.title.MenuGroupController()).onSelectDesignSet(this, '10428');"><IMG alt=10428 src="http://cafeimg.daum-img.net/cf_img4/thumb/title_bar/b02_1_bar.gif"> </LI></UL>
<DIV style="DISPLAY: none" id=selectedMenuDesign></DIV>
<DIV id=paging>
<TABLE class=pg_area align=center>
<TBODY>
<TR>
<TD><SPAN class="pg_btn prev_btn">이전</SPAN> <SPAN class=page_selected>1</SPAN> <A onclick="(new cube.controller.title.MenuGroupController()).onClickPage('', '', '2', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">2</A> <A onclick="(new cube.controller.title.MenuGroupController()).onClickPage('', '', '3', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">3</A> <A onclick="(new cube.controller.title.MenuGroupController()).onClickPage('', '', '4', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">4</A> <A onclick="(new cube.controller.title.MenuGroupController()).onClickPage('', '', '5', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">5</A> <A class="pg_btn next_btn" onclick="(new cube.controller.title.MenuGroupController()).onClickPage('', '', '6', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">▶</A> </TD></TR></TBODY></TABLE></DIV></DIV></DIV><!-- end menuDesignSetArea --></DIV></DIV>
<DIV style="DISPLAY: none" id=TITLECAFENAME_area>
<DIV id=cafeNameEditor>
<DIV class=previewArea>
<OBJECT style="VISIBILITY: visible" id=namePreviewer name=namePreviewer classid=clsid:D27CDB6E-AE6D-11cf-96B8-444553540000 width=390 height=110><PARAM NAME="_cx" VALUE="10318"><PARAM NAME="_cy" VALUE="2910"><PARAM NAME="FlashVars" VALUE="preview=true&amp;background=true&amp;width=390&amp;height=110&amp;text=%EC%B9%B4%ED%8E%98%EB%A7%8C%EB%93%A4%EA%BA%BC%EC%9E%84&amp;font=RixMjM&amp;size=28&amp;color=#716471&amp;stroke=false&amp;strokeColor=&amp;shadow=false&amp;reflection=false"><PARAM NAME="Movie" VALUE="http://cafeimg.daum-img.net/cf_img4/affogato/typogenv2.swf?20091228"><PARAM NAME="Src" VALUE="http://cafeimg.daum-img.net/cf_img4/affogato/typogenv2.swf?20091228"><PARAM NAME="WMode" VALUE="Transparent"><PARAM NAME="Play" VALUE="0"><PARAM NAME="Loop" VALUE="0"><PARAM NAME="Quality" VALUE="High"><PARAM NAME="SAlign" VALUE="LT"><PARAM NAME="Menu" VALUE="0"><PARAM NAME="Base" VALUE="http://cafeimg.daum-img.net/cf_img4/affogato/"><PARAM NAME="AllowScriptAccess" VALUE="always"><PARAM NAME="Scale" VALUE="NoScale"><PARAM NAME="DeviceFont" VALUE="0"><PARAM NAME="EmbedMovie" VALUE="0"><PARAM NAME="BGColor" VALUE=""><PARAM NAME="SWRemote" VALUE=""><PARAM NAME="MovieData" VALUE=""><PARAM NAME="SeamlessTabbing" VALUE="1"><PARAM NAME="Profile" VALUE="0"><PARAM NAME="ProfileAddress" VALUE=""><PARAM NAME="ProfilePort" VALUE="0"><PARAM NAME="AllowNetworking" VALUE="all"><PARAM NAME="AllowFullScreen" VALUE="false"><PARAM NAME="AllowFullScreenInteractive" VALUE=""></OBJECT></DIV>
<DIV style="DISPLAY: none" id=fontHelpLayer class=font_help_layer></DIV>
<DIV style="DISPLAY: none" id=fontHelp class=font_help>사용중인 폰트가 서비스 종료 되었습니다. 다른 폰트를 선택해 주세요.</DIV>
<DIV id=cafeToolbar>
<DL>
<DD><LABEL class=title_txt555>폰트명</LABEL> <A style="WIDTH: 131px" id=d2w_tcFontFamily class=img_selectbox tabIndex=0>RIX 명조M</A><SELECT id=tcFontFamily onchange="(new cube.controller.title.CafeNameController()).onChangeFontFamily(this.value);" class=selectbox_styled scrollsize="200"> <OPTION value=gulim>굴림</OPTION> <OPTION value=dotum>돋움</OPTION> <OPTION value=batang>바탕</OPTION> <OPTION value=gungsuh>궁서</OPTION> <OPTION value=DaumRegular>다음Regular</OPTION> <OPTION value=RixGoM>RIX 고딕M</OPTION> <OPTION selected value=RixMjM>RIX 명조M</OPTION> <OPTION value=RixOctloveM>RIX 시월애M</OPTION> <OPTION value=RixMindure>RIX 민들레</OPTION> <OPTION value=SandolKwangsu2M>산돌 광수투M</OPTION> <OPTION value=PumhangZero>품행제로</OPTION> <OPTION value=Sooksook>성적이쑥쑥</OPTION> <OPTION value=MiniSaladBar>미니샐러드바</OPTION> <OPTION value=CoffeeNDonut>커피N도넛</OPTION> <OPTION value=Sandol02M>산돌 02M</OPTION> <OPTION value=RixMGoM>RIX 모던고딕M</OPTION> <OPTION value=RixSMjB>RIX 신문명조B</OPTION> <OPTION value=RixLemonadeM>RIX 레모네이드M</OPTION> <OPTION value=RixFreestyleBPRO>RIX 프리스타일B PRO</OPTION> <OPTION value=RixMelangchollyM>RIX 멜랑촐리M</OPTION> <OPTION value=RixGoMaejumM>RIX 매점갈시간M</OPTION> <OPTION value=RixWansoM>RIX 완전소중M</OPTION> <OPTION value=RixPinkRibbonM>RIX 핑크리본M</OPTION> <OPTION value=RixDearGiraffeM>RIX 기린에게M</OPTION> <OPTION value=RixStarNMeM>RIX 별과나M</OPTION></SELECT> </DD>
<DD><LABEL class=title_txt555>크기</LABEL> <A style="WIDTH: 31px" id=d2w_tcFontSize class=img_selectbox tabIndex=0>28px</A><SELECT id=tcFontSize onchange="(new cube.controller.title.CafeNameController()).onChangeFontSize(this.value);" class=selectbox_styled> <OPTION value=11>11px</OPTION> <OPTION value=12>12px</OPTION> <OPTION value=13>13px</OPTION> <OPTION value=14>14px</OPTION> <OPTION value=17>17px</OPTION> <OPTION value=20>20px</OPTION> <OPTION value=24>24px</OPTION> <OPTION selected value=28>28px</OPTION> <OPTION value=35>35px</OPTION> <OPTION value=45>45px</OPTION></SELECT> </DD>
<DD class=last><LABEL class=title_txt555>폰트색</LABEL> 
<DIV style="BACKGROUND-COLOR: #716471" id=tcFontColor class=colorSelectBox_styled>
<DIV id=d2w_tcFontColor class=textColorViewer></DIV>
<DIV class=colorSelectEnabled></DIV></DIV></DD></DL>
<UL id=tcFontEffect>
<LI><LABEL class=title_txt555>효과</LABEL> </LI>
<LI><IMG id=d2w_tcFontBorder class="img_checkbox " tabIndex=0 src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" width=12 height=13><INPUT id=tcFontBorder class=checkradio_styled onclick="(new cube.controller.title.CafeNameController()).onChangeFontBorder(this.checked);" value="" type=checkbox><LABEL class="title_stxt666 hand">테두리</LABEL> 
<DIV style="BACKGROUND-COLOR: #000000" id=tcBorderColor class=colorSelectBox_styled>
<DIV id=d2w_tcBorderColor class=colorViewer></DIV>
<DIV class=colorSelectEnabled></DIV></DIV></LI>
<LI><IMG id=d2w_tcFontShadow class="img_checkbox " tabIndex=0 src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" width=12 height=13><INPUT id=tcFontShadow class=checkradio_styled onclick="(new cube.controller.title.CafeNameController()).onChangeFontShadow(this.checked);" value="" type=checkbox><LABEL class="title_stxt666 hand">그림자</LABEL></LI>
<LI><IMG id=d2w_tcFontReflection class="img_checkbox " tabIndex=0 src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" width=12 height=13><INPUT id=tcFontReflection class=checkradio_styled onclick="(new cube.controller.title.CafeNameController()).onChangeFontReflection(this.checked);" value="" type=checkbox><LABEL class="title_stxt666 hand">반사</LABEL> 
<DIV style="DISPLAY: none" id=nameFontTip class=tip_icon></DIV></LI></UL></DIV><!-- end cafeToolbar --></DIV></DIV>
<DIV style="DISPLAY: none" id=TITLECAFEADDRESS_area>
<DIV id=cafeAddressEditor>
<DIV class=previewArea>
<OBJECT style="VISIBILITY: visible" id=addressPreviewer name=addressPreviewer classid=clsid:D27CDB6E-AE6D-11cf-96B8-444553540000 width=390 height=110><PARAM NAME="_cx" VALUE="10318"><PARAM NAME="_cy" VALUE="2910"><PARAM NAME="FlashVars" VALUE="preview=true&amp;background=true&amp;width=390&amp;height=110&amp;text=cafe.daum.net/encola&amp;font=DaumRegular&amp;size=11&amp;color=#cec3ce&amp;stroke=false&amp;strokeColor=&amp;shadow=false&amp;reflection=false"><PARAM NAME="Movie" VALUE="http://cafeimg.daum-img.net/cf_img4/affogato/typogenv2.swf?20091228"><PARAM NAME="Src" VALUE="http://cafeimg.daum-img.net/cf_img4/affogato/typogenv2.swf?20091228"><PARAM NAME="WMode" VALUE="Transparent"><PARAM NAME="Play" VALUE="0"><PARAM NAME="Loop" VALUE="0"><PARAM NAME="Quality" VALUE="High"><PARAM NAME="SAlign" VALUE="LT"><PARAM NAME="Menu" VALUE="0"><PARAM NAME="Base" VALUE="http://cafeimg.daum-img.net/cf_img4/affogato/"><PARAM NAME="AllowScriptAccess" VALUE="always"><PARAM NAME="Scale" VALUE="NoScale"><PARAM NAME="DeviceFont" VALUE="0"><PARAM NAME="EmbedMovie" VALUE="0"><PARAM NAME="BGColor" VALUE=""><PARAM NAME="SWRemote" VALUE=""><PARAM NAME="MovieData" VALUE=""><PARAM NAME="SeamlessTabbing" VALUE="1"><PARAM NAME="Profile" VALUE="0"><PARAM NAME="ProfileAddress" VALUE=""><PARAM NAME="ProfilePort" VALUE="0"><PARAM NAME="AllowNetworking" VALUE="all"><PARAM NAME="AllowFullScreen" VALUE="false"><PARAM NAME="AllowFullScreenInteractive" VALUE=""></OBJECT></DIV>
<DIV style="DISPLAY: none" id=fontHelpLayer2 class=font_help_layer></DIV>
<DIV style="DISPLAY: none" id=fontHelp2 class=font_help>사용중인 폰트가 서비스 종료 되었습니다. 다른 폰트를 선택해 주세요.</DIV>
<DIV id=cafeToolbar>
<DL>
<DD><LABEL class=title_txt555>폰트명</LABEL> <A style="WIDTH: 131px" id=d2w_taFontFamily class=img_selectbox tabIndex=0>다음Regular</A><SELECT id=taFontFamily onchange="(new cube.controller.title.CafeAddressController()).onChangeFontFamily(this.value);" class=selectbox_styled scrollsize="200"> <OPTION value=gulim>굴림</OPTION> <OPTION value=dotum>돋움</OPTION> <OPTION value=batang>바탕</OPTION> <OPTION value=gungsuh>궁서</OPTION> <OPTION selected value=DaumRegular>다음Regular</OPTION> <OPTION value=RixGoM>RIX 고딕M</OPTION> <OPTION value=RixMjM>RIX 명조M</OPTION> <OPTION value=RixOctloveM>RIX 시월애M</OPTION> <OPTION value=RixMindure>RIX 민들레</OPTION> <OPTION value=SandolKwangsu2M>산돌 광수투M</OPTION> <OPTION value=PumhangZero>품행제로</OPTION> <OPTION value=Sooksook>성적이쑥쑥</OPTION> <OPTION value=MiniSaladBar>미니샐러드바</OPTION> <OPTION value=CoffeeNDonut>커피N도넛</OPTION> <OPTION value=Sandol02M>산돌 02M</OPTION> <OPTION value=RixMGoM>RIX 모던고딕M</OPTION> <OPTION value=RixSMjB>RIX 신문명조B</OPTION> <OPTION value=RixLemonadeM>RIX 레모네이드M</OPTION> <OPTION value=RixFreestyleBPRO>RIX 프리스타일B PRO</OPTION> <OPTION value=RixMelangchollyM>RIX 멜랑촐리M</OPTION> <OPTION value=RixGoMaejumM>RIX 매점갈시간M</OPTION> <OPTION value=RixWansoM>RIX 완전소중M</OPTION> <OPTION value=RixPinkRibbonM>RIX 핑크리본M</OPTION> <OPTION value=RixDearGiraffeM>RIX 기린에게M</OPTION> <OPTION value=RixStarNMeM>RIX 별과나M</OPTION></SELECT> </DD>
<DD><LABEL class=title_txt555>크기</LABEL> <A style="WIDTH: 31px" id=d2w_taFontSize class=img_selectbox tabIndex=0>11px</A><SELECT id=taFontSize onchange="(new cube.controller.title.CafeAddressController()).onChangeFontSize(this.value);" class=selectbox_styled> <OPTION value=10>10px</OPTION> <OPTION selected value=11>11px</OPTION> <OPTION value=12>12px</OPTION> <OPTION value=13>13px</OPTION> <OPTION value=14>14px</OPTION> <OPTION value=17>17px</OPTION> <OPTION value=20>20px</OPTION> <OPTION value=24>24px</OPTION> <OPTION value=28>28px</OPTION> <OPTION value=35>35px</OPTION> <OPTION value=45>45px</OPTION></SELECT> </DD>
<DD class=last><LABEL class=title_txt555>폰트색</LABEL> 
<DIV style="BACKGROUND-COLOR: #cec3ce" id=taFontColor class=colorSelectBox_styled>
<DIV id=d2w_taFontColor class=textColorViewer></DIV>
<DIV class=colorSelectEnabled></DIV></DIV></DD></DL>
<UL id=taFontEffect>
<LI><LABEL class=title_txt555>효과</LABEL> </LI>
<LI><IMG id=d2w_taFontBorder class="img_checkbox " tabIndex=0 src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" width=12 height=13><INPUT id=taFontBorder class=checkradio_styled onclick="(new cube.controller.title.CafeAddressController()).onChangeFontBorder(this.checked);" value="" type=checkbox><LABEL class="title_stxt666 hand">테두리</LABEL> 
<DIV style="BACKGROUND-COLOR: #000000" id=taBorderColor class=colorSelectBox_styled>
<DIV id=d2w_taBorderColor class=colorViewer></DIV>
<DIV class=colorSelectEnabled></DIV></DIV></LI>
<LI><IMG id=d2w_taFontShadow class="img_checkbox " tabIndex=0 src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" width=12 height=13><INPUT id=taFontShadow class=checkradio_styled onclick="(new cube.controller.title.CafeAddressController()).onChangeFontShadow(this.checked);" value="" type=checkbox><LABEL class="title_stxt666 hand">그림자</LABEL></LI>
<LI><IMG id=d2w_taFontReflection class="img_checkbox " tabIndex=0 src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" width=12 height=13><INPUT id=taFontReflection class=checkradio_styled onclick="(new cube.controller.title.CafeAddressController()).onChangeFontReflection(this.checked);" value="" type=checkbox><LABEL class="title_stxt666 hand">반사</LABEL> 
<DIV style="DISPLAY: none" id=addressFontTip class=tip_icon></DIV></LI></UL></DIV><!-- end cafeToolbar --></DIV></DIV>
<DIV style="DISPLAY: none" id=TITLESEARCH_area>
<DIV id=searchEditor>
<UL id=searchDesignSetList>
<LI onclick="(new cube.controller.title.SearchController()).onSelectDesignSet(this, '-133');"><IMG alt=-133 src="http://cafeimg.daum-img.net/cf_img4/thumb/title_search/mig_search.gif" width=250 height=50> </LI>
<LI onclick="(new cube.controller.title.SearchController()).onSelectDesignSet(this, '11600');"><IMG alt=11600 src="http://cafeimg.daum-img.net/cf_img4/thumb/title_search/b14_5_search.gif" width=250 height=50> </LI>
<LI onclick="(new cube.controller.title.SearchController()).onSelectDesignSet(this, '11587');"><IMG alt=11587 src="http://cafeimg.daum-img.net/cf_img4/thumb/title_search/b14_4_search.gif" width=250 height=50> </LI>
<LI onclick="(new cube.controller.title.SearchController()).onSelectDesignSet(this, '11581');"><IMG alt=11581 src="http://cafeimg.daum-img.net/cf_img4/thumb/title_search/b14_3_search.gif" width=250 height=50> </LI>
<LI onclick="(new cube.controller.title.SearchController()).onSelectDesignSet(this, '11572');"><IMG alt=11572 src="http://cafeimg.daum-img.net/cf_img4/thumb/title_search/b14_2_search.gif" width=250 height=50> </LI></UL>
<DIV style="DISPLAY: none" id=selectedSearchBox></DIV>
<DIV id=paging>
<TABLE class=pg_area align=center>
<TBODY>
<TR>
<TD><SPAN class="pg_btn prev_btn">이전</SPAN> <SPAN class=page_selected>1</SPAN> <A onclick="(new cube.controller.title.SearchController()).onClickPage('', '', '2', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">2</A> <A onclick="(new cube.controller.title.SearchController()).onClickPage('', '', '3', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">3</A> <A onclick="(new cube.controller.title.SearchController()).onClickPage('', '', '4', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">4</A> <A onclick="(new cube.controller.title.SearchController()).onClickPage('', '', '5', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">5</A> <A class="pg_btn next_btn" onclick="(new cube.controller.title.SearchController()).onClickPage('', '', '6', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">▶</A> </TD></TR></TBODY></TABLE></DIV></DIV></DIV>
<DIV id=TITLECAFEINFO_area>
<DIV id=cafeInfoBoxEditor>
<DIV class=previewer>
<OBJECT id=counterPreviewer name=counterPreviewer classid=clsid:D27CDB6E-AE6D-11cf-96B8-444553540000 width=360 height=170><PARAM NAME="_cx" VALUE="9525"><PARAM NAME="_cy" VALUE="4497"><PARAM NAME="FlashVars" VALUE="host=cafe456.daum.net&amp;grpid=1NjB9&amp;width=360&amp;height=170&amp;style=B&amp;fontfamily=RixGo&amp;titlecolor=#4f4f4f&amp;numbercolor=#4f4f4f&amp;backgroundcolor=#f8f8f8&amp;backgroundalpha=0&amp;bordertype=0&amp;bordercolor=&amp;cornerradius=16"><PARAM NAME="Movie" VALUE="http://cafeimg.daum-img.net/cf_img4/affogato/countergenv2.swf?20091224"><PARAM NAME="Src" VALUE="http://cafeimg.daum-img.net/cf_img4/affogato/countergenv2.swf?20091224"><PARAM NAME="WMode" VALUE="Transparent"><PARAM NAME="Play" VALUE="0"><PARAM NAME="Loop" VALUE="0"><PARAM NAME="Quality" VALUE="High"><PARAM NAME="SAlign" VALUE="LT"><PARAM NAME="Menu" VALUE="0"><PARAM NAME="Base" VALUE="http://cafeimg.daum-img.net/cf_img4/affogato/"><PARAM NAME="AllowScriptAccess" VALUE="always"><PARAM NAME="Scale" VALUE="NoScale"><PARAM NAME="DeviceFont" VALUE="0"><PARAM NAME="EmbedMovie" VALUE="0"><PARAM NAME="BGColor" VALUE=""><PARAM NAME="SWRemote" VALUE=""><PARAM NAME="MovieData" VALUE=""><PARAM NAME="SeamlessTabbing" VALUE="1"><PARAM NAME="Profile" VALUE="0"><PARAM NAME="ProfileAddress" VALUE=""><PARAM NAME="ProfilePort" VALUE="0"><PARAM NAME="AllowNetworking" VALUE="all"><PARAM NAME="AllowFullScreen" VALUE="false"><PARAM NAME="AllowFullScreenInteractive" VALUE=""></OBJECT></DIV>
<DIV id=cafeInfoControl>
<DL class=top_control>
<DD><A style="WIDTH: 131px" id=d2w_counterFontFamily class=img_selectbox tabIndex=0>RIX 고딕</A><SELECT id=counterFontFamily onchange="(new cube.controller.title.CafeInfoController()).onChangeUserStyle(this.value, 'fontfamily');" class=selectbox_styled scrollsize="200"> <OPTION value=gulim>굴림</OPTION> <OPTION value=dotum>돋움</OPTION> <OPTION value=batang>바탕</OPTION> <OPTION value=gungsuh>궁서</OPTION> <OPTION value=Daum>다음</OPTION> <OPTION selected value=RixGo>RIX 고딕</OPTION> <OPTION value=RixMjM>RIX 명조M</OPTION> <OPTION value=RixOctloveM>RIX 시월애M</OPTION> <OPTION value=RixMindure>RIX 민들레</OPTION> <OPTION value=SandolKwangsu2M>산돌 광수투M</OPTION> <OPTION value=PumhangZero>품행제로</OPTION> <OPTION value=Sooksook>성적이쑥쑥</OPTION> <OPTION value=MiniSaladBar>미니샐러드바</OPTION> <OPTION value=CoffeeNDonut>커피N도넛</OPTION> <OPTION value=Sandol02M>산돌 02M</OPTION> <OPTION value=RixMGo>RIX 모던고딕M</OPTION> <OPTION value=RixSMjB>RIX 신문명조B</OPTION> <OPTION value=RixLemonade>RIX 레모네이드M</OPTION> <OPTION value=RixFreestyleBPRO>RIX 프리스타일B PRO</OPTION> <OPTION value=RixMelangchollyM>RIX 멜랑촐리M</OPTION> <OPTION value=RixGoMaejumM>RIX 매점갈시간M</OPTION> <OPTION value=RixWansoM>RIX 완전소중M</OPTION> <OPTION value=RixPinkRibbonM>RIX 핑크리본M</OPTION> <OPTION value=RixDearGiraffeM>RIX 기린에게M</OPTION> <OPTION value=RixStarNMeM>RIX 별과나M</OPTION></SELECT> </DD>
<DD><LABEL>제목색</LABEL> 
<DIV style="BACKGROUND-COLOR: #4f4f4f" id=counterTitleColor class=colorSelectBox_styled>
<DIV id=d2w_counterTitleColor class=textColorViewer></DIV>
<DIV class=colorSelectEnabled></DIV></DIV></DD>
<DD class=last><LABEL>숫자색</LABEL> 
<DIV style="BACKGROUND-COLOR: #4f4f4f" id=counterNumberColor class=colorSelectBox_styled>
<DIV id=d2w_counterNumberColor class=textColorViewer></DIV>
<DIV class=colorSelectEnabled></DIV></DIV></DD></DL>
<DL class=bot_control>
<DD><LABEL>배경</LABEL> 
<DIV style="BACKGROUND-COLOR: #f8f8f8" id=counterBackgroundColor class=colorSelectBox_styled>
<DIV id=d2w_counterBackgroundColor class=colorViewer></DIV>
<DIV class=colorSelectEnabled></DIV></DIV></DD>
<DD><LABEL>투명도</LABEL> 
<DIV id=alphaSlider>
<DIV style="WIDTH: 50px; BACKGROUND: url(http://i1.daumcdn.net/cafeimg/cf_img4/design/gate/leftzone_bg.gif) repeat-x" class=dhtmlxSlider title=0 _etype="slider">
<DIV style="BACKGROUND: url(http://i1.daumcdn.net/cafeimg/cf_img4/design/gate/leftside_bg.gif) repeat-x" class=leftSide></DIV>
<DIV style="WIDTH: 5px; BACKGROUND: url(http://i1.daumcdn.net/cafeimg/cf_img4/design/gate/leftzone_bg.gif) repeat-x" class=leftZone></DIV>
<DIV style="WIDTH: 43px; LEFT: 6px" class=rightZone></DIV>
<DIV style="BACKGROUND: url(http://i1.daumcdn.net/cafeimg/cf_img4/design/gate/rightside_bg.gif) repeat-x" class=rightSide></DIV>
<DIV style="BACKGROUND: url(http://i1.daumcdn.net/cafeimg/cf_img4/design/gate/selector.gif) no-repeat; LEFT: 5px" class=selector _etype="drag"></DIV></DIV></DIV></DD>
<DD><LABEL>모서리</LABEL> 
<DIV id=cornerSlider>
<DIV style="WIDTH: 50px; BACKGROUND: url(http://i1.daumcdn.net/cafeimg/cf_img4/design/gate/leftzone_bg.gif) repeat-x" class=dhtmlxSlider title=16 _etype="slider">
<DIV style="BACKGROUND: url(http://i1.daumcdn.net/cafeimg/cf_img4/design/gate/leftside_bg.gif) repeat-x" class=leftSide></DIV>
<DIV style="WIDTH: 13px; BACKGROUND: url(http://i1.daumcdn.net/cafeimg/cf_img4/design/gate/leftzone_bg.gif) repeat-x" class=leftZone></DIV>
<DIV style="WIDTH: 34px; LEFT: 14px" class=rightZone></DIV>
<DIV style="BACKGROUND: url(http://i1.daumcdn.net/cafeimg/cf_img4/design/gate/rightside_bg.gif) repeat-x" class=rightSide></DIV>
<DIV style="BACKGROUND: url(http://i1.daumcdn.net/cafeimg/cf_img4/design/gate/selector.gif) no-repeat; LEFT: 13px" class=selector _etype="drag"></DIV></DIV></DIV></DD>
<DD class=last><LABEL id=borderLabel>테두리</LABEL> 
<DIV style="Z-INDEX: 9999; BACKGROUND-POSITION: 0px 0px" id=counterBorderType class="border_styler border_styler_COUNTER">
<UL style="DISPLAY: none" id=dw_counterBorderType_targetLayer>
<LI style="BACKGROUND-POSITION: 0px 0px">0</LI>
<LI style="BACKGROUND-POSITION: 0px -21px">1</LI>
<LI style="BACKGROUND-POSITION: 0px -42px">2</LI>
<LI style="BACKGROUND-POSITION: 0px -63px">3</LI>
<LI style="BACKGROUND-POSITION: 0px -84px">4</LI>
<LI style="BACKGROUND-POSITION: 0px -105px">5</LI></UL></DIV>
<DIV style="BACKGROUND-COLOR: #000000" id=counterBorderColor class=colorSelectBox_styled>
<DIV id=d2w_counterBorderColor class=colorViewer></DIV>
<DIV class=colorSelectDisabled></DIV></DIV></DD></DL></DIV><A id=btnOpenDesign class=dropdown onclick="(new cube.controller.title.CafeInfoController()).onClickDesignSetArea(this); return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">카운터 디자인 선택</A> 
<DIV id=cafeInfoDesignSetArea>
<P class=line></P>
<DIV id=cafeInfoDesignSetList>
<UL>
<LI onclick="(new cube.controller.title.CafeInfoController()).onSelectDesignSet(this, '13032');"><IMG alt=c034 src="http://cafeimg.daum-img.net/cf_img4/thumb/counter/c034_counter.gif" width=179 height=119> </LI>
<LI onclick="(new cube.controller.title.CafeInfoController()).onSelectDesignSet(this, '12690');"><IMG alt="" src="http://cafeimg.daum-img.net/cf_img4/thumb/counter/004_counter.gif" width=179 height=119> </LI>
<LI onclick="(new cube.controller.title.CafeInfoController()).onSelectDesignSet(this, '12689');"><IMG alt="" src="http://cafeimg.daum-img.net/cf_img4/thumb/counter/003_counter.gif" width=179 height=119> </LI>
<LI onclick="(new cube.controller.title.CafeInfoController()).onSelectDesignSet(this, '12688');"><IMG alt="" src="http://cafeimg.daum-img.net/cf_img4/thumb/counter/002_counter.gif" width=179 height=119> </LI></UL>
<DIV style="TOP: -1px; LEFT: 179px" id=selectedCounterDesign></DIV>
<DIV id=paging>
<TABLE class=pg_area align=center>
<TBODY>
<TR>
<TD><SPAN class="pg_btn prev_btn">이전</SPAN> <SPAN class=page_selected>1</SPAN> <A onclick="(new cube.controller.title.CafeInfoController()).onClickPage('', '', '2', '1');return false;" href="http://cafe456.daum.net/_c21_/founder_title_management?grpid=1NjB9#">2</A> <SPAN class="pg_btn next_btn">다음</SPAN> </TD></TR></TBODY></TABLE></DIV></DIV></DIV></DIV></DIV></DIV></DIV>
<DIV id=componentBtnArea>
<DIV class=btnArea>
<DIV class=btnInner><A onfocus=this.blur(); onclick="(new cube.controller.title.EditorLayerController()).onClickConfirm(); return false;" href="#"><IMG class=btnConfirm_s alt=확인 src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" width=46 height=26> </A><A onfocus=this.blur(); onclick="(new cube.controller.title.EditorLayerController()).onClickCancel(); return false;" href="#"><IMG class=btnCancel_s alt=취소 src="http://i1.daumcdn.net/cafeimg/cf_img2/img_blank2.gif" width=46 height=26> </A></DIV></DIV></DIV>
<DIV id=componentFooter>
<DIV class=roundL></DIV>
<DIV class=roundR></DIV>
<DIV class=center></DIV></DIV>