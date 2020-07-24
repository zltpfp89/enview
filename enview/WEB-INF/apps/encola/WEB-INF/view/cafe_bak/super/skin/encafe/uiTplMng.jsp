<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String evcp = request.getContextPath();
%>
<%--BEGIN::초기 전체 화면--%>
<c:if test="${empty suForm.view || suForm.view == 'init'}">
	<link rel="stylesheet" type="text/css" href="<%=evcp%>/board/css/admin/admin-common.css">
	<style type="text/css">
		.tplmngr_list_pageNavi { height: 20px; line-height: 20px; padding-top: 5px; }
	
		.tplmngr_pref_row { width: 100%; font-size: 12px; font-family: gulim; padding-bottom: 5px; }
		.tplmngr_pref_label { width: 270px; height: 18px; float: left; margin-right: 5px; line-height: 20px; padding: 0; border: 1px solid transparent; text-algin: left; }
		.tplmngr_pref_label2 { height: 18px; float: left; margin-right: 5px; line-height: 20px; padding: 0; border: 1px solid transparent; text-algin: left; }
		.tplmngr_pref_decoId { width: 150px; height: 18px; float: left; margin-right: 5px; line-height: 20px; padding: 0; border: 1px solid black; font-size: 12px; font-family: gulim, dotum; padding-left: 3px; padding-right: 3px; }
		.tplmngr_pref_input { width: 150px; height: 18px; float: left; margin-right: 5px; line-height: 20px; padding: 0; border: 1px solid black; font-size: 12px; font-family: gulim, dotum; padding-left: 3px; padding-right: 3px; }
		.tplmngr_pref_file { width: 86px; height: 20px; float: left; margin-right: 5px; line-height: 20px; padding: 0; border: 1px solid black; font-size: 12px; font-family: gulim, dotum;}
		
		.CF0101_tplImg { width: 500px; height: 90px; border: 1px solid #e9e9e9; display: block; background-repeat: no-repeat; }
		.CF0102_tplImg { width: 96px; height: 88px; border: 1px solid #e9e9e9; display: block; background-repeat: no-repeat; }
		.CF0102_bgImage { width: 140px; height: 110px; border: 1px solid #e9e9e9; display: block; background-repeat: no-repeat; }
		
		.CF0105_tplImg { width: 236px; height: 53px; border: 1px solid #e9e9e9; display: block; background-repeat: no-repeat; }
		.CF0301_tplImg { width: 132px; height: 120px; border: 1px solid #e9e9e9; display: block; background-repeat: no-repeat; }
		.CF0301_myInfoButton { width: 13px; height: 13px; border: 1px solid #e9e9e9; display: block; background-repeat: no-repeat; }
		.CF0401_tplImg { width: 132px; height: 101px; border: 1px solid #e9e9e9; display: block; background-repeat: no-repeat; }
		.CF0402_menuIconImage { width: 11px; height: 11px; border: 1px solid transparent; display: block; background-repeat: no-repeat; }
		.CF0501_tplImg { width: 132px; height: 95px; border: 1px solid #e9e9e9; display: block; background-repeat: no-repeat; }
		.CF0601_tplImg { width: 284px; height: 50px; border: 1px solid #e9e9e9; display: block; background-repeat: no-repeat; }
		.CF0601_srchBtn { width: 37px; height: 21px; border: 1px solid #e9e9e9; display: block; background-repeat: no-repeat; }
		
		
		.fl { float: left; }
		.mt05 { margin-top: 5px; }
		.w30 { width: 30px; }
		.tal { text-align: left; }
		.tac { text-align: center; }
		.tar { text-align: right; }
	</style>
	<script type="text/javascript" src="<%=evcp%>/board/javascript/enboard_util.js"></script>
	<script type="text/javascript" src="<%=evcp%>/cola/cafe/javascript/super/encafe.js"></script>
	<script type="text/javascript">
	  function initSuperMngr() {
		superMngr = new SuperMngr();
		superMngr.getTplMngr().init();
	  }
	  function finishSuperMngr() {
	  }
	  // Attach to the onload event
	  if (window.attachEvent) {
	    window.attachEvent ("onload", initSuperMngr);
		window.attachEvent ("onunload", finishSuperMngr);
	  } else if (window.addEventListener ) {
	    window.addEventListener ("load", initSuperMngr, false);
		window.addEventListener ("unload", finishSuperMngr, false);
	  } else {
	    window.onload = initSuperMngr;
		window.onunload = finishSuperMngr;
	  }
	</script>
	<div id="tplMngr"  class="adgridpanel" style="width:99%; float: left; "></div>
</c:if>
<%--END::초기 전체 화면--%>
<%--BEGIN::템플릿 리스트 화면--%>
<c:if test="${suForm.view == 'list'}">
	<div class="adgridpanel">
		<label>템플릿 종류: </label>
			<select id="decoTypeSelect" onchange="javascript:superMngr.getTplMngr().doChange('decoTypeSelect');">
				<c:forEach items="${decoTypeList }" var="deco">
					<c:if test="${deco.code != 'CF0701' }">
					<option value="<c:out value="${deco.code}"/>" <c:if test="${deco.code == suForm.decoType }">selected="selected"</c:if>><c:out value="${deco.codeName}"/></option>
					</c:if>
				</c:forEach>
			</select>
	</div>
	<div class="adgridpanel">
		<form id="decoInfoListForm" style="display:inline" name="decoInfoListForm" action="" method="post">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<thead>
					<tr><td height="2" colspan="7" class="adgridlimit"></td></tr>
					<tr style="cursor: pointer;">
						<th class="adgridheader" width="30px"></th>
						<th class="adgridheader" width="60px"ch="0"><span>No</span></th>
						<th class="adgridheader" width="80px"ch="0"><span>아이디</span></th>
						<th class="adgridheader" width="100px"ch="0"><span>꾸미기타입</span></th>
						<th class="adgridheader" width="80px"ch="0"><span>사용횟수</span></th>
						<th class="adgridheader" width="140px"ch="0"><span>등록자</span></th>
						<th class="adgridheaderlast" ch="0"><span>등록일시</span></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${decoInfoList}" var="deco" varStatus="status">
						<tr id="tplList<c:out value="${status.index}"/>" style="cursor:pointer" class="decoRow<c:if test="${status.index%2==1}"> adgridline</c:if>"
							ch="<c:out value="${status.index}"/>" onmouseover="ebUtil.activeLine(this,true)" onmouseout="ebUtil.activeLine(this,false)" onclick="superMngr.getTplMngr().doSelect(this)">
							<td align="center" class="adgrid" >
								<input type="checkbox" id="<c:out value="${status.index}"/>_checkRow" class="webcheckbox"/>
								<input type="hidden" id="<c:out value="${status.index}"/>_decoId" value="<c:out value="${deco.decoId}"/>"/>
							</td>
							<td align="center" class="adgrid"><span><c:out value="${deco.rnum}"/></span></td>
							<td align="center" class="adgrid"><span><c:out value="${deco.decoId}"/></span></td>
							<td align="center" class="adgrid"><span><c:out value="${deco.decoType}"/></span></td>
							<td align="center" class="adgrid"><span><c:out value="${deco.useCount}"/></span></td>
							<td align="center" class="adgrid"><span><c:out value="${deco.regUserId}"/></span></td>
							<td align="center" class="adgrid"><span><c:out value="${deco.regDatim}"/></span></td>
						</tr>
					</c:forEach>
					<tr><td height="2" colspan="7" class="adgridlimit"></td></tr>
				</tbody>
			</table>
		</form>
		<form id="superTemplateForm" name="superTemplateForm">
			<input type="hidden" id="superList_totalSize" name="superList_totalSize" value="<c:out value="${suForm.totalSize}"/>"/>
			<input type='hidden' id="pageNo" name='pageNo' value='<c:out value="${suForm.pageNo}"/>'/>
			<input type='hidden' id="pageSize" name='pageSize' value='<c:out value="${suForm.pageSize}"/>'/>
			<input type='hidden' id="pageFunction" name='pageFunction' value='superMngr.getTplMngr().doPage'/>
			<input type='hidden' id="formName" name='formName' value='superTemplateForm'/>
			<div class="tplmngr_list_pageNavi">
				<table style="width:100%;">
					<tr>
						<td align="center">
							<div id="SUPER_PAGE_ITERATOR"></div>
						</td>   
					</tr>
				</table>
			</div>
		</form>
	</div>
	<div class="adgridpanel" style="float: right; border: none;">
	    <span class="btn_pack medium"><a href="javascript:superMngr.getTplMngr().uiCreate()">신규</a></span>
	    <span class="btn_pack medium"><a href="javascript:superMngr.getTplMngr().doDelete()"><util:message key="ev.title.remove"/></a></span>
	</div>
	<div id="tplEditDiv" class="adgridpanel fl mt05"></div>
</c:if>
<%--END::템플릿 리스트 화면--%>
<%--BEGIN::템플릿 세부화면--%>	
<c:if test="${suForm.view == 'pref'}">
	<iframe id="imgIframe" name="imgIframe" frameborder=0 width=0 height=0></iframe>
	<div class="tplmngr_pref_row fl">
		<label class="tplmngr_pref_label fl">템플릿 아이디: </label>
		<input class="tplmngr_pref_decoId w30 tac"" type="text" id="decoId" value="<c:out value="${suForm.decoId}"/>" disabled="disabled"/>
	</div>
	<form id="tplImgForm" name="tplImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">템플릿 이미지: (<span id="tplImgSize"></span>)</label>
			<input class="tplmngr_pref_input fl" type="text" id="<c:out value="${suForm.decoType }"/>_tplImg"/>
			<input class="tplmngr_pref_file fl" type="file" id="<c:out value="${suForm.decoType }"/>_tplImgFile" name="file" onchange="superMngr.getTplMngr().doChangeTplImg(this);"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_tplImg_set" value="_val_"/>
		</div>
	</form>
	<div class="tplmngr_pref_row fl"><img class="<c:out value="${suForm.decoType }"/>_tplImg" id="<c:out value="${suForm.decoType }"/>_tplImg_img"/></div>
	<%-- BEGIN::타이틀 템플릿 --%>
	<c:if test="${suForm.decoType == 'CF0101' }">
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경 템플릿(CF0102): </label><input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0102"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0102_set" value="_val_"/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">카페 이름 템플릿(CF0103):</label><input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0103"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0103_set" value="_val_"/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">카페 주소 템플릿(CF0104):</label><input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0104"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0104_set" value="_val_"/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">카페 메뉴 템플릿(CF0105):</label><input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0105"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0105_set" value="_val_"/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">카페 검색 템플릿(CF0106):</label><input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0106"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0106_set" value="_val_"/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">카페 카운터 템플릿(CF0107):</label><input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0107"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0107_set" value="_val_"/>
		</div>
	</c:if>
	<%-- END::타이틀 템플릿 --%>
	<%-- BEGIN::타이틀 배경 템플릿 --%>
	<c:if test="${suForm.decoType == 'CF0102' }">
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경색(bgColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgColor_set" value='{ "background-color": "_val_" }'/>
		</div>
		<form id="bgImgForm" name="bgImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">배경 이미지(bgImage): (<span id="bgImgSize"></span>)</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgImage"/>
				<input class="tplmngr_pref_file fl" type="file" id="bgImageFile" name="file" onchange="superMngr.getTplMngr().doChangeBgImg(this);"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgImage_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_bgImage" id="<c:out value="${suForm.decoType }"/>_bgImage_img"></div></div>
		</form>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경 이미지 위치(bgImgPos):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgImgPos"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgImgPos_set" value='{ "background-position-x": "_val_", "background-position-y": "_val2_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경 이미지 반복(bgImgRepeat):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgImgRepeat"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgImgRepeat_set" value='{ "background-repeat": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경 테두리 색(brdrColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrColor_set" value='{ "border-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경 테두리 스타일(brdrStyle):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrStyle"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrStyle_set" value='{ "border": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경 테두리 너비(brdrWidth):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrWidth"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrWidth_set" value='{ "border-width": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경색  투명도(trpcValue):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_trpcValue"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_trpcValue_set" value='{ "opacity": "_val_" }'/>
		</div>
	</c:if>
	<%-- END::타이틀 배경 템플릿 --%>
	<%-- BEGIN::타이틀 메뉴 템플릿 --%>
	<c:if test="${suForm.decoType == 'CF0105' }">
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">기본색(baseFontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_baseFontColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_baseFontColor_set" value='{ "color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경색(bgColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgColor_set" value='{ "background-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">테두리 스타일(brdrStyle):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrStyle"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrStyle_set" value='{ "border-style": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">테두리 너비(brdrWidth):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrWidth"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrWidth_set" value='{ "border-width": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">테두리 색(brdrColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrColor_set" value='{ "border-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">화면표시 방식(display):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_display"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_display_set" value='{ "display": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">글꼴(fontNm):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_fontNm"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_fontNm_set" value='{ "font-family": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">위치(position):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_position"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_position_set" value='{ "position": "_val_", "left": "_val2_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">선택 시 색(selFontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_selFontColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_selFontColor_set" value='{ "color": "_val_" }'/>
		</div>
	</c:if>
	<%-- END::타이틀 메뉴 템플릿 --%>
	<%-- BEGIN::정보 영역 템플릿 --%>
	<c:if test="${suForm.decoType == 'CF0301' }">
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">기본색(baseFontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_baseFontColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_baseFontColor_set" value='{ "color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경색(bgColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgColor_set" value='{ "background-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">테두리 색(brdrColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrColor_set" value='{ "border-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">버튼 배경 색(btnBgColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_btnBgColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_btnBgColor_set" value='{ "background-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">버튼 글씨 색(btnFontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_btnFontColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_btnFontColor_set" value='{ "color": "_val_" }'/>
		</div>
		<form id="myInfoBtnImgForm" name="myInfoBtnImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">내정보 보기 버튼(myInfoButton): (<span id="myInfoImgSize"></span>)</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_myInfoButton"/>
				<input class="tplmngr_pref_file fl" type="file" id="myInfoBtnImageFile" name="file"  onchange="superMngr.getTplMngr().doChangeMyInfoBtnImg(this);"/>				
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_myInfoButton_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_myInfoButton" id="<c:out value="${suForm.decoType }"/>_myInfoButton_img"></div></div>
		</form>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">내정보 보기 버튼2(myInfoButton2):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_myInfoButton2"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_myInfoButton2_set" value='{ "display": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">강조색(valFontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_valFontColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_valFontColor_set" value='{ "color": "_val_" }'/>
		</div>
	</c:if>
	<%-- END::정보 영역 템플릿 --%>
	<%-- BEGIN::메뉴 영역 템플릿 --%>
	<c:if test="${suForm.decoType == 'CF0401' }">
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">기본색(baseFontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_baseFontColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_baseFontColor_set" value='{ "color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경색(bgColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgColor_set" value='{ "background-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">테두리 스타일(brdrStyle):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrStyle"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrStyle_set" value='{ "border-style": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">테두리 너비(brddWidth):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrWidth"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrWidth_set" value='{ "border-width": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">테두리 색(brdrColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrColor_set" value='{ "border-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">메뉴 그룹 배경색(menuGrpBgColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuGrpBgColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuGrpBgColor_set" value='{ "background-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">메뉴 아이콘 셋(menuIconSet):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIconSet"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIconSet_set" value='_val_'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">구분선 색(sepBrdrColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_sepBrdrColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_sepBrdrColor_set" value='{ "border-top-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">구분선 스타일(sepBrdrStyle):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_sepBrdrStyle"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_sepBrdrStyle_set" value='{ "border-top-style": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">구분선 너비(sepBrdrWidth):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_sepBrdrWidth"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_sepBrdrWidth_set" value='{ "border-top-width": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">강조색(valFontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_valFontColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_valFontColor_set" value='{ "color": "_val_" }'/>
		</div>
	</c:if>
	<%-- END::메뉴 영역 템플릿 --%>
	<%-- BEGIN::메뉴 아이콘 템플릿 --%>
	<c:if test="${suForm.decoType == 'CF0402' }">
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">아이콘 폴더 이름(tplName):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_tplName"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_tplName_set" value='_val_'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">아이콘 너비 만큼 들여쓰기(txtIndnt):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_txtIndnt"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_txtIndnt_set" value='{ "text-indent": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">아이콘 너비 만큼 왼쪽으로 확장(pddngLft):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_pddngLft"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_pddngLft_set" value='{ "padding-left": "_val_" }'/>
		</div>
		<form id="menuIcon10ImgForm" name="menuIcon10ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">일반 아이콘(menuIcon10):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon10"/>
				<input class="tplmngr_pref_file fl" type="file" id="menuIcon10ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 10);"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon10_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon10_img"></div></div>
		</form>
		<form id="menuIcon11ImgForm" name="menuIcon11ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">익명 아이콘(menuIcon11):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon11"/>
				<input class="tplmngr_pref_file fl" type="file" id="menuIcon11ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 11);"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon11_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon11_img"></div></div>
		</form>
		<form id="menuIcon12ImgForm" name="menuIcon12ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">Q/A 아이콘(menuIcon12):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon12"/>
				<input class="tplmngr_pref_file fl" type="file" id="menuIcon12ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 12);"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon12_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon12_img"></div></div>
		</form>
		<form id="menuIcon13ImgForm" name="menuIcon13ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">사진 아이콘(menuIcon13):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon13"/>
				<input class="tplmngr_pref_file fl" type="file" id="menuIcon13ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 13);"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon13_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon13_img"></div></div>
		</form>
		<form id="menuIcon14ImgForm" name="menuIcon14ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">한줄 아이콘(menuIcon14):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon14"/>
				<input class="tplmngr_pref_file fl" type="file" id="menuIcon14ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 14);"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon14_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon14_img"></div></div>
		</form>
		<form id="menuIcon90ImgForm" name="menuIcon90ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">최신 아이콘(menuIcon90):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon90"/>
				<input class="tplmngr_pref_file fl" type="file" id="menuIcon90ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 90);"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon90_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon90_img"></div></div>
		</form>
		<form id="menuIcon91ImgForm" name="menuIcon91ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">인기 아이콘(menuIcon91):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon91"/>
				<input class="tplmngr_pref_file fl" type="file" id="menuIcon91ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 91);"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon91_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon91_img"></div></div>
		</form>
		<form id="menuIcon92ImgForm" name="menuIcon92ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">이미지 아이콘(menuIcon92):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon92"/>
				<input class="tplmngr_pref_file fl" type="file" id="menuIcon92ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 92);"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon92_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon92_img"></div></div>
		</form>
		<form id="newIconImgForm" name="newIconImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">새글 알림 아이콘(menuIcon92):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_newIcon"/>
				<input class="tplmngr_pref_file fl" type="file" id="newIconImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 'new');"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_newIcon_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_newIcon_img"></div></div>
		</form>
	</c:if>
	<%-- END::메뉴 아이콘 템플릿 --%>
	<%-- BEGIN::컨덴츠 영역 템플릿 --%>
	<c:if test="${suForm.decoType == 'CF0501' }">
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">게시판 제목 테두리 스타일(nmBrdrStyle):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_nmBrdrStyle"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_nmBrdrStyle_set" value='{ "border-style": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">게시판 제목 테두리 너비(nmBrdrWidth):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_nmBrdrWidth"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_nmBrdrWidth_set" value='{ "border-width": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">게시판 제목 테두리 색(nmBrdrColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_nmBrdrColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_nmBrdrColor_set" value='{ "border-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">게시판 제목 글씨 색(nmFontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_nmFontColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_nmFontColor_set" value='{ "color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">댓글 표시색(rplFontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_rplFontColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_rplFontColor_set" value='{ "color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">글 제목 색(subjFontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_subjFontColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_subjFontColor_set" value='{ "color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">글 제목 글꼴(subjFontNm):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_subjFontNm"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_subjFontNm_set" value='{ "font-family": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">글 제목 글 크기(subjFontSize):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_subjFontSize"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_subjFontSize_set" value='{ "font-size": "_val_" }'/>
		</div>
	</c:if>
	<%-- END::컨덴츠 영역 템플릿 --%>
	<%-- BEGIN::검색 영역 템플릿 --%>
	<c:if test="${suForm.decoType == 'CF0601' }">
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경색(bgColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgColor_set" value='{ "background-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">검색 필드 테두리 색(brdrColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrColor_set" value='{ "border-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">검색 필드 테두리 스타일(brdrStyle):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrStyle"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrStyle_set" value='{ "border": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">검색 필드 글씨 색(fontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_fontColor"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_fontColor_set" value='{ "color": "_val_" }'/>
		</div>
		<form id="srchBtnImgForm" name="srchBtnImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">검색 버튼 이미지(srchBtn): (<span id="srchImgSize"></span>)</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_srchBtn"/>
				<input class="tplmngr_pref_file fl" type="file" id="srchBtnImageFile" name="file"  onchange="superMngr.getTplMngr().doChangeSrchBtnImg(this);"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_srchBtn_set" value='{ "background-image": "_val_" }'/>				
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_srchBtn" id="<c:out value="${suForm.decoType }"/>_srchBtn_img"></div></div>
		</form>
	</c:if>
	<%-- END::검색 영역 템플릿 --%>
	<%-- BEGIN::부가 영역 템플릿 --%>
	<c:if test="${suForm.decoType == 'CF0701' }">
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">아직 지원되지 않는 템플릿 입니다.</label>
		</div>
	</c:if>
	<%-- END::부가 영역 템플릿 --%>
	<input type="hidden" id="decoPrefs" value="[
 		<c:forEach items="${decoInfoPrefList}" var="deco" varStatus="status">
	{ clazz: '<c:out value="${deco.decoType}"/>_<c:out value="${deco.name}"/>', value:'<c:out value="${deco.value}"/>'}<c:if test="${!status.last}">,</c:if>
		</c:forEach>
	]"/>
	<div class="adgridpanel" style="float: right; border: none;">
	    <span class="btn_pack medium"><a href="javascript:superMngr.getTplMngr().doGet(superMngr.getTplMngr().m_curDecoType, '<c:out value="${suForm.view}"/>')">새로고침</a></span>
	    <span class="btn_pack medium"><a href="javascript:superMngr.getTplMngr().doSave('<c:out value="${suForm.view}"/>')"><util:message key="ev.title.save"/></a></span>
	</div>
</c:if>	
<%--END::템플릿 세부화면--%>
<%--BEGIN::템플릿 신규화면--%>
<c:if test="${suForm.view == 'new'}">
	<iframe id="imgIframe" name="imgIframe" frameborder=0 width=0 height=0></iframe>
	<div class="tplmngr_pref_row fl">
		<label class="tplmngr_pref_label fl">템플릿 아이디: </label>
		<input class="tplmngr_pref_decoId w30 tac"" type="text" id="decoId" value="<c:out value="${suForm.decoId}"/>" disabled="disabled"/>
	</div>
	<form id="tplImgForm" name="tplImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">템플릿 이미지: (<span id="tplImgSize"></span>)</label>
			<input class="tplmngr_pref_input fl" type="text" id="<c:out value="${suForm.decoType }"/>_tplImg"/>
			<input class="tplmngr_pref_file fl" type="file" id="<c:out value="${suForm.decoType }"/>_tplImgFile" name="file" onchange="superMngr.getTplMngr().doChangeTplImg(this);"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_tplImg_set" value="_val_"/>
		</div>
	</form>
	<div class="tplmngr_pref_row fl"><img class="<c:out value="${suForm.decoType }"/>_tplImg" id="<c:out value="${suForm.decoType }"/>_tplImg_img"/></div>
	<%-- BEGIN::타이틀 템플릿 --%>
	<c:if test="${suForm.decoType == 'CF0101' }">
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경 템플릿(CF0102): </label><input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0102"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0102_set" value="_val_"/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">카페 이름 템플릿(CF0103):</label><input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0103"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0103_set" value="_val_"/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">카페 주소 템플릿(CF0104):</label><input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0104"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0104_set" value="_val_"/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">카페 메뉴 템플릿(CF0105):</label><input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0105"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0105_set" value="_val_"/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">카페 검색 템플릿(CF0106):</label><input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0106"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0106_set" value="_val_"/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">카페 카운터 템플릿(CF0107):</label><input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0107"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0107_set" value="_val_"/>
		</div>
	</c:if>
	<%-- END::타이틀 템플릿 --%>
	<%-- BEGIN::타이틀 배경 템플릿 --%>
	<c:if test="${suForm.decoType == 'CF0102' }">
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경색(bgColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgColor" value="white"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgColor_set" value='{ "background-color": "_val_" }'/>
		</div>
		<form id="bgImgForm" name="bgImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">배경 이미지(bgImage): (<span id="bgImgSize"></span>)</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgImage"/>
				<input class="tplmngr_pref_file fl" type="file" id="bgImageFile" name="file" onchange="superMngr.getTplMngr().doChangeBgImg(this);"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgImage_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_bgImage" id="<c:out value="${suForm.decoType }"/>_bgImage_img"></div></div>
		</form>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경 이미지 위치(bgImgPos):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgImgPos" value="left,top"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgImgPos_set" value='{ "background-position-x": "_val_", "background-position-y": "_val2_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경 이미지 반복(bgImgRepeat):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgImgRepeat"  value="no-repeat"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgImgRepeat_set" value='{ "background-repeat": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경 테두리 색(brdrColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrColor"  value="black"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrColor_set" value='{ "border-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경 테두리 스타일(brdrStyle):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrStyle" value="1px solid"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrStyle_set" value='{ "border": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경색  투명도(trpcValue):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_trpcValue" value="1.0"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_trpcValue_set" value='{ "opacity": "_val_" }'/>
		</div>
	</c:if>
	<%-- END::타이틀 배경 템플릿 --%>
	<%-- BEGIN::타이틀 메뉴 템플릿 --%>
	<c:if test="${suForm.decoType == 'CF0105' }">
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">기본색(baseFontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_baseFontColor" value="blue"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_baseFontColor_set" value='{ "color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경색(bgColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgColor" value="orange"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgColor_set" value='{ "background-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">테두리 스타일(brdrStyle):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrStyle" value="solid"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrStyle_set" value='{ "border-style": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">테두리 너비(brdrWidth):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrWidth" value="1px"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrWidth_set" value='{ "border-width": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">테두리 색(brdrColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrColor" value="black"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrColor_set" value='{ "border-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">화면표시 방식(display):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_display" value="block"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_display_set" value='{ "display": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">글꼴(fontNm):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_fontNm" value="gulim"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_fontNm_set" value='{ "font-family": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">위치(position):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_position" value="absolute,0px"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_position_set" value='{ "position": "_val_", "left": "_val2_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">선택 시 색(selFontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_selFontColor" value="red"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_selFontColor_set" value='{ "color": "_val_" }'/>
		</div>
	</c:if>
	<%-- END::타이틀 메뉴 템플릿 --%>
	<%-- BEGIN::정보 영역 템플릿 --%>
	<c:if test="${suForm.decoType == 'CF0301' }">
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">기본색(baseFontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_baseFontColor" value="blue"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_baseFontColor_set" value='{ "color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경색(bgColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgColor" value="white"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgColor_set" value='{ "background-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">테두리 색(brdrColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrColor" value="black"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrColor_set" value='{ "border-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">버튼 배경 색(btnBgColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_btnBgColor" value="white"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_btnBgColor_set" value='{ "background-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">버튼 글씨 색(btnFontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_btnFontColor" value="pink"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_btnFontColor_set" value='{ "color": "_val_" }'/>
		</div>
		<form id="myInfoBtnImgForm" name="myInfoBtnImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">내정보 보기 버튼(myInfoButton): (<span id="myInfoImgSize"></span>)</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_myInfoButton"/>
				<input class="tplmngr_pref_file fl" type="file" id="myInfoBtnImageFile" name="file"  onchange="superMngr.getTplMngr().doChangeMyInfoBtnImg(this);"/>				
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_myInfoButton_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_myInfoButton" id="<c:out value="${suForm.decoType }"/>_myInfoButton_img"></div></div>
		</form>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">내정보 보기 버튼2(myInfoButton2):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_myInfoButton2" value="none"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_myInfoButton2_set" value='{ "display": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">강조색(valFontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_valFontColor" value="red"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_valFontColor_set" value='{ "color": "_val_" }'/>
		</div>
	</c:if>
	<%-- END::정보 영역 템플릿 --%>
	<%-- BEGIN::메뉴 영역 템플릿 --%>
	<c:if test="${suForm.decoType == 'CF0401' }">
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">기본색(baseFontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_baseFontColor" value="blue"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_baseFontColor_set" value='{ "color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경색(bgColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgColor" value="white"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgColor_set" value='{ "background-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">테두리 스타일(brdrStyle):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrStyle" value="solid"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrStyle_set" value='{ "border-style": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">테두리 너비(brdrWidth):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrWidth" value="1px 1px 1px 1px"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrWidth_set" value='{ "border-width": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">테두리 색(brdrColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrColor" value="black"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrColor_set" value='{ "border-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">메뉴 그룹 배경색(menuGrpBgColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuGrpBgColor" value="white"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuGrpBgColor_set" value='{ "background-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">메뉴 아이콘 셋(menuIconSet):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIconSet" value="62"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIconSet_set" value='_val_'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">구분선 색(sepBrdrColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_sepBrdrColor" value="green"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_sepBrdrColor_set" value='{ "border-top-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">구분선 스타일(sepBrdrStyle):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_sepBrdrStyle" value="solid"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_sepBrdrStyle_set" value='{ "border-top": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">구분선 너비(sepBrdrWidth):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_sepBrdrWidth" value="1px"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_sepBrdrWidth_set" value='{ "border-top-width": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">강조색(valFontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_valFontColor" value="red"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_valFontColor_set" value='{ "color": "_val_" }'/>
		</div>
	</c:if>
	<%-- END::메뉴 영역 템플릿 --%>
	<%-- BEGIN::메뉴 아이콘 템플릿 --%>
	<c:if test="${suForm.decoType == 'CF0402' }">
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">아이콘 폴더 이름(tplName):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_tplName"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_tplName_set" value='_val_'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">아이콘 너비 만큼 들여쓰기(txtIndnt):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_txtIndnt" value="13px"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_txtIndnt_set" value='{ "text-indent": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">아이콘 너비 만큼 왼쪽으로 확장(pddngLft):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_pddngLft" value="15px"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_pddngLft_set" value='{ "padding-left": "_val_" }'/>
		</div>
		<form id="menuIcon10ImgForm" name="menuIcon10ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">일반 아이콘(menuIcon10):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon10"/>
				<input class="tplmngr_pref_file fl" type="file" id="menuIcon10ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 10);"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon10_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon10_img"></div></div>
		</form>
		<form id="menuIcon11ImgForm" name="menuIcon11ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">익명 아이콘(menuIcon11):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon11"/>
				<input class="tplmngr_pref_file fl" type="file" id="menuIcon11ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 11);"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon11_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon11_img"></div></div>
		</form>
		<form id="menuIcon12ImgForm" name="menuIcon12ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">Q/A 아이콘(menuIcon12):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon12"/>
				<input class="tplmngr_pref_file fl" type="file" id="menuIcon12ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 12);"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon12_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon12_img"></div></div>
		</form>
		<form id="menuIcon13ImgForm" name="menuIcon13ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">사진 아이콘(menuIcon13):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon13"/>
				<input class="tplmngr_pref_file fl" type="file" id="menuIcon13ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 13);"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon13_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon13_img"></div></div>
		</form>
		<form id="menuIcon14ImgForm" name="menuIcon14ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">한줄 아이콘(menuIcon14):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon14"/>
				<input class="tplmngr_pref_file fl" type="file" id="menuIcon14ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 14);"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon14_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon14_img"></div></div>
		</form>
		<form id="menuIcon90ImgForm" name="menuIcon90ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">최신 아이콘(menuIcon90):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon90"/>
				<input class="tplmngr_pref_file fl" type="file" id="menuIcon90ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 90);"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon90_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon90_img"></div></div>
		</form>
		<form id="menuIcon91ImgForm" name="menuIcon91ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">인기 아이콘(menuIcon91):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon91"/>
				<input class="tplmngr_pref_file fl" type="file" id="menuIcon91ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 91);"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon91_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon91_img"></div></div>
		</form>
		<form id="menuIcon92ImgForm" name="menuIcon92ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">이미지 아이콘(menuIcon92):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon92"/>
				<input class="tplmngr_pref_file fl" type="file" id="menuIcon92ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 92);"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon92_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon92_img"></div></div>
		</form>
		<form id="newIconImgForm" name="newIconImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">새글 알림 아이콘(menuIcon10):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_newIcon"/>
				<input class="tplmngr_pref_file fl" type="file" id="newIconImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 'new');"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_newIcon_set" value='{ "background-image": "_val_" }'/>
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon10_img"></div></div>
		</form>
	</c:if>
	<%-- END::메뉴 아이콘 템플릿 --%>
	<%-- BEGIN::컨덴츠 영역 템플릿 --%>
	<c:if test="${suForm.decoType == 'CF0501' }">
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">게시판 제목 테두리 스타일(nmBrdrStyle):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_nmBrdrStyle" value="solid"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_nmBrdrStyle_set" value='{ "border-style": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">게시판 제목 테두리 너비(nmBrdrWidth):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_nmBrdrWidth" value="0px 0px 1px 0px"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_nmBrdrWidth_set" value='{ "border-width": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">게시판 제목 테두리 색(nmBrdrColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_nmBrdrColor" value="blue"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_nmBrdrColor_set" value='{ "border-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">게시판 제목 글씨 색(nmFontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_nmFontColor" value="blue"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_nmFontColor_set" value='{ "color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">댓글 표시색(rplFontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_rplFontColor" value="orange"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_rplFontColor_set" value='{ "color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">글 제목 색(subjFontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_subjFontColor" value="black"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_subjFontColor_set" value='{ "color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">글 제목 글꼴(subjFontNm):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_subjFontNm" value="gulim"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_subjFontNm_set" value='{ "font-family": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">글 제목 글 크기(subjFontSize):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_subjFontSize" value="12px"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_subjFontSize_set" value='{ "font-size": "_val_" }'/>
		</div>
	</c:if>
	<%-- END::컨덴츠 영역 템플릿 --%>
	<%-- BEGIN::검색 영역 템플릿 --%>
	<c:if test="${suForm.decoType == 'CF0601' }">
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">배경색(bgColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgColor"/ value="white">
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgColor_set" value='{ "background-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">검색 필드 테두리 색(brdrColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrColor" value="black"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrColor_set" value='{ "border-color": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">검색 필드 테두리 스타일(brdrStyle):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrStyle" value="1px solid"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrStyle_set" value='{ "border": "_val_" }'/>
		</div>
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">검색 필드 글씨 색(fontColor):</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_fontColor" value="black"/>
			<input type="hidden" id="<c:out value="${suForm.decoType }"/>_fontColor_set" value='{ "color": "_val_" }'/>
		</div>
		<form id="srchBtnImgForm" name="srchBtnImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
			<div class="tplmngr_pref_row fl">
				<label class="tplmngr_pref_label fl">검색 버튼 이미지(srchBtn): (<span id="srchImgSize"></span>)</label><input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_srchBtn"/>
				<input class="tplmngr_pref_file fl" type="file" id="srchBtnImageFile" name="file"  onchange="superMngr.getTplMngr().doChangeSrchBtnImg(this);"/>
				<input type="hidden" id="<c:out value="${suForm.decoType }"/>_srchBtn_set" value='{ "background-image": "_val_" }'/>				
			</div>
			<div class="tplmngr_pref_row fl"><div class="<c:out value="${suForm.decoType }"/>_srchBtn" id="<c:out value="${suForm.decoType }"/>_srchBtn_img"></div></div>
		</form>
	</c:if>
	<%-- END::검색 영역 템플릿 --%>
	<%-- BEGIN::부가 영역 템플릿 --%>
	<c:if test="${suForm.decoType == 'CF0701' }">
		<div class="tplmngr_pref_row fl">
			<label class="tplmngr_pref_label fl">아직 지원되지 않는 템플릿 입니다.</label>
		</div>
	</c:if>
	<%-- END::부가 영역 템플릿 --%>
	<div class="adgridpanel" style="float: right; border: none;">
	    <span class="btn_pack medium"><a href="javascript:superMngr.getTplMngr().doCreate()"><util:message key="ev.title.save"/></a></span>
	</div>
</c:if>
<%--END::템플릿 신규화면--%>	