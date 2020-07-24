<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String evcp = request.getContextPath();
%>
<%--BEGIN::초기 전체 화면--%>
<c:if test="${empty suForm.view || suForm.view == 'init'}">
	<%-- <link rel="stylesheet" type="text/css" href="<%=evcp%>/board/css/admin/admin-common.css"> --%>
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
	<!-- board first -->
	<div id="ConfigurationManager_ConfigurationTabPage" class="board first">
		<!-- searchArea-->
		<div class="tsearchArea">
			<span class="sel_txt">템플릿 종류: </span> 
			<div class="sel_100">
				<select id="decoTypeSelect" onchange="javascript:superMngr.getTplMngr().doChange('decoTypeSelect');" class="txt_100">
					<c:forEach items="${decoTypeList }" var="deco">
						<c:if test="${deco.code != 'CF0701' }">
							<option value="<c:out value="${deco.code}"/>" <c:if test="${deco.code == suForm.decoType }">selected="selected"</c:if>><c:out value="${deco.codeName}"/></option>
						</c:if>
					</c:forEach>
				</select>
			</div>	
		</div>
		<!-- searchArea// -->
		<form id="decoInfoListForm" style="display:inline" name="decoInfoListForm" action="" method="post">
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
				<caption>게시판</caption>
				<colgroup>
					<col width="30px" />
					<col width="60px" />
					<col width="80px" />
					<col width="100px" />
					<col width="80px" />
					<col width="140px" />
				</colgroup>			
				<thead>
					<tr>
						<th class="first"></th>
						<th class="C" ch="0"><span class="table_title">No</span></th>
						<th class="C" ch="0"><span class="table_title">아이디</span></th>
						<th class="C" ch="0"><span class="table_title">꾸미기타입</span></th>
						<th class="C" ch="0"><span class="table_title">사용횟수</span></th>
						<th class="C" ch="0"><span class="table_title">등록자</span></th>
						<th class="C" ch="0"><span class="table_title">등록일시</span></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${decoInfoList}" var="deco" varStatus="status">
						<tr id="tplList<c:out value="${status.index}"/>" style="cursor:pointer" class="decoRow<c:if test="${status.index%2==1}"> adgridline</c:if>"
							ch="<c:out value="${status.index}"/>" onclick="superMngr.getTplMngr().doSelect(this)">
							<td class="C" >
								<input type="checkbox" id="<c:out value="${status.index}"/>_checkRow"/>
								<input type="hidden" id="<c:out value="${status.index}"/>_decoId" value="<c:out value="${deco.decoId}"/>"/>
							</td>
							<td class="C"><c:out value="${deco.rnum}"/></td>
							<td class="C"><c:out value="${deco.decoId}"/></td>
							<td class="C"><c:out value="${deco.decoType}"/></td>
							<td class="C"><c:out value="${deco.useCount}"/></td>
							<td class="C"><c:out value="${deco.regUserId}"/></td>
							<td class="C"><c:out value="${deco.regDatim}"/></td>
						</tr>
					</c:forEach>
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
				<!-- tcontrol-->
				<div class="tcontrol">
					<!-- paging -->
					<div id="SUPER_PAGE_ITERATOR" class="paging"></div>
					<!-- paging//-->
				</div>
				<!-- tcontrol//-->
			</div>
		</form>	
		<!-- btnArea-->
		<div class="btnArea">
			<div class="rightArea">
				<a href="javascript:superMngr.getTplMngr().uiCreate()" class="btn_W"><span>신규</span></a>
				<a href="javascript:superMngr.getTplMngr().doDelete()" class="btn_W"><span><util:message key="ev.title.remove"/></span></a>
			</div>
		</div>
		<!-- btnArea//-->
	</div>
	<!-- board first// -->
	<div id="tplEditDiv" class="adgridpanel fl mt05"></div>
</c:if>
<%--END::템플릿 리스트 화면--%>
<%--BEGIN::템플릿 세부화면--%>	
<c:if test="${suForm.view == 'pref'}">
	<iframe id="imgIframe" name="imgIframe" frameborder=0 width=0 height=0></iframe>
	
	<!-- board -->
	<div class="board">		
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<caption>게시판</caption>
			<colgroup>
				<col width="25%" />
				<col width="75%" />
			</colgroup>
			<tr>
				<th class="L">템플릿 아이디 : </th>
				<td class="L"><input class="tplmngr_pref_decoId w30 tac" type="text" id="decoId" value="<c:out value="${suForm.decoId}"/>" disabled="disabled"/></td>
			</tr>
			<tr>
				<th class="L">템플릿 이미지 : (<span id="tplImgSize"></span>) </th>
				<td class="L" style="height:170px;">
					<form id="tplImgForm" name="tplImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
						<div class="sel_100" style="padding-bottom:120px;">
							<input class="txt_400" type="text" id="<c:out value="${suForm.decoType }"/>_tplImg"/>
							<input class="txt_400" type="file" id="<c:out value="${suForm.decoType }"/>_tplImgFile" name="file" onchange="superMngr.getTplMngr().doChangeTplImg(this);"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_tplImg_set" value="_val_"/>
							<img class="<c:out value="${suForm.decoType }"/>_tplImg" id="<c:out value="${suForm.decoType }"/>_tplImg_img"/>	
						</div>
					</form>					
				</td>			
			</tr>
			<%-- BEGIN::타이틀 템플릿 --%>
			<c:if test="${suForm.decoType == 'CF0101' }">
				<tr>
					<th class="L">배경 템플릿(CF0102) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0102"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0102_set" value="_val_"/>
					</td>
				</tr>
				<tr>
					<th class="L">카페 이름 템플릿(CF0103) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0103"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0103_set" value="_val_"/>
					</td>
				</tr>	
				<tr>
					<th class="L">카페 주소 템플릿(CF0104) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0104"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0104_set" value="_val_"/>
					</td>
				</tr>	
				<tr>
					<th class="L">카페 메뉴 템플릿(CF0105) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0105"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0105_set" value="_val_"/>
					</td>
				</tr>
				<tr>
					<th class="L">카페 검색 템플릿(CF0106) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0106"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0106_set" value="_val_"/>
					</td>
				</tr>
				<tr>
					<th class="L">카페 카운터 템플릿(CF0107) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0107"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0107_set" value="_val_"/>
					</td>
				</tr>
			</c:if>
			<%-- END::타이틀 템플릿 --%>
			<%-- BEGIN::타이틀 배경 템플릿 --%>
			<c:if test="${suForm.decoType == 'CF0102' }">
				<tr>
					<th class="L">배경색(bgColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgColor_set" value='{ "background-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">배경 이미지(bgImage): (<span id="bgImgSize"></span>) </th>
					<td class="L">
						<form id="bgImgForm" name="bgImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgImage"/>
							<input class="tplmngr_pref_file fl" type="file" id="bgImageFile" name="file" onchange="superMngr.getTplMngr().doChangeBgImg(this);"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgImage_set" value='{ "background-image": "_val_" }'/>							
						</form>
						<div class="<c:out value="${suForm.decoType }"/>_bgImage" id="<c:out value="${suForm.decoType }"/>_bgImage_img"></div>
					</td>
				</tr>					
				<tr>
					<th class="L">배경 이미지 위치(bgImgPos) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgImgPos"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgImgPos_set" value='{ "background-position-x": "_val_", "background-position-y": "_val2_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">배경 이미지 반복(bgImgRepeat) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgImgRepeat"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgImgRepeat_set" value='{ "background-repeat": "_val_" }'/>
					</td>
				</tr>			
				<tr>
					<th class="L">배경 테두리 색(brdrColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrColor_set" value='{ "border-color": "_val_" }'/>
					</td>
				</tr>	
				<tr>
					<th class="L">배경 테두리 스타일(brdrStyle) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrStyle"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrStyle_set" value='{ "border": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">배경 테두리 너비(brdrWidth) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrWidth"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrWidth_set" value='{ "border-width": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">배경색  투명도(trpcValue) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_trpcValue"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_trpcValue_set" value='{ "opacity": "_val_" }'/>
					</td>
				</tr>
			</c:if>
			<%-- END::타이틀 배경 템플릿 --%>
			<%-- BEGIN::타이틀 메뉴 템플릿 --%>
			<c:if test="${suForm.decoType == 'CF0105' }">
				<tr>
					<th class="L">기본색(baseFontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_baseFontColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_baseFontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">배경색(bgColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgColor_set" value='{ "background-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">테두리 스타일(brdrStyle) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrStyle"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrStyle_set" value='{ "border-style": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">테두리 너비(brdrWidth) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrWidth"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrWidth_set" value='{ "border-width": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">테두리 색(brdrColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrColor_set" value='{ "border-color": "_val_" }'/>
					</td>
				</tr>					
				<tr>
					<th class="L">화면표시 방식(display) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_display"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_display_set" value='{ "display": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">글꼴(fontNm) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_fontNm"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_fontNm_set" value='{ "font-family": "_val_" }'/>
					</td>
				</tr>										
				<tr>
					<th class="L">위치(position) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_position"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_position_set" value='{ "position": "_val_", "left": "_val2_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">선택 시 색(selFontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_selFontColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_selFontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>
			</c:if>
			<%-- END::타이틀 메뉴 템플릿 --%>
			<%-- BEGIN::정보 영역 템플릿 --%>
			<c:if test="${suForm.decoType == 'CF0301' }">
				<tr>
					<th class="L">기본색(baseFontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_baseFontColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_baseFontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>	
				<tr>
					<th class="L">배경색(bgColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgColor_set" value='{ "background-color": "_val_" }'/>
					</td>
				</tr>					
				<tr>
					<th class="L">테두리 색(brdrColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrColor_set" value='{ "border-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">버튼 배경 색(btnBgColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_btnBgColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_btnBgColor_set" value='{ "background-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">버튼 글씨 색(btnFontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_btnFontColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_btnFontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">내정보 보기 버튼(myInfoButton) : (<span id="myInfoImgSize"></span>) </th>
					<td class="L">
						<form id="myInfoBtnImgForm" name="myInfoBtnImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_myInfoButton"/>
							<input class="tplmngr_pref_file fl" type="file" id="myInfoBtnImageFile" name="file"  onchange="superMngr.getTplMngr().doChangeMyInfoBtnImg(this);"/>				
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_myInfoButton_set" value='{ "background-image": "_val_" }'/>
						</form>
						<div class="<c:out value="${suForm.decoType }"/>_myInfoButton" id="<c:out value="${suForm.decoType }"/>_myInfoButton_img"></div>
					</td>
				</tr>
				<tr>
					<th class="L">내정보 보기 버튼2(myInfoButton2) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_myInfoButton2"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_myInfoButton2_set" value='{ "display": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">강조색(valFontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_valFontColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_valFontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>
			</c:if>
			<%-- END::정보 영역 템플릿 --%>	
			<%-- BEGIN::메뉴 영역 템플릿 --%>
			<c:if test="${suForm.decoType == 'CF0401' }">
				<tr>
					<th class="L">기본색(baseFontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_baseFontColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_baseFontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">배경색(bgColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgColor_set" value='{ "background-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">테두리 스타일(brdrStyle) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrStyle"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrStyle_set" value='{ "border-style": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">테두리 너비(brddWidth) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrWidth"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrWidth_set" value='{ "border-width": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">테두리 색(brdrColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrColor_set" value='{ "border-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">메뉴 그룹 배경색(menuGrpBgColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuGrpBgColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuGrpBgColor_set" value='{ "background-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">메뉴 아이콘 셋(menuIconSet) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIconSet"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIconSet_set" value='_val_'/>
					</td>
				</tr>
				<tr>
					<th class="L">구분선 색(sepBrdrColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_sepBrdrColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_sepBrdrColor_set" value='{ "border-top-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">구분선 스타일(sepBrdrStyle) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_sepBrdrStyle"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_sepBrdrStyle_set" value='{ "border-top-style": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">구분선 너비(sepBrdrWidth) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_sepBrdrWidth"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_sepBrdrWidth_set" value='{ "border-top-width": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">강조색(valFontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_valFontColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_valFontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>
			</c:if>
			<%-- END::메뉴 영역 템플릿 --%>
			<%-- BEGIN::메뉴 아이콘 템플릿 --%>
			<c:if test="${suForm.decoType == 'CF0402' }">
				<tr>
					<th class="L">아이콘 폴더 이름(tplName) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_tplName"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_tplName_set" value='_val_'/>
					</td>
				</tr>
				<tr>
					<th class="L">아이콘 너비 만큼 들여쓰기(txtIndnt) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_txtIndnt"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_txtIndnt_set" value='{ "text-indent": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">아이콘 너비 만큼 왼쪽으로 확장(pddngLft) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_pddngLft"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_pddngLft_set" value='{ "padding-left": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">일반 아이콘(menuIcon10) : </th>
					<td class="L">
						<form id="menuIcon10ImgForm" name="menuIcon10ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon10"/>
							<input class="tplmngr_pref_file fl" type="file" id="menuIcon10ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 10);"/>
						</form>
					</td>
				</tr>
				<tr>
					<th class="L">익명 아이콘(menuIcon11) : </th>
					<td class="L">
						<form id="menuIcon11ImgForm" name="menuIcon11ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon11"/>
							<input class="tplmngr_pref_file fl" type="file" id="menuIcon11ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 11);"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon11_set" value='{ "background-image": "_val_" }'/>
						</form>
					</td>
				</tr>
				<tr>
					<th class="L">Q/A 아이콘(menuIcon12) : </th>
					<td class="L">
						<form id="menuIcon12ImgForm" name="menuIcon12ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon12"/>
							<input class="tplmngr_pref_file fl" type="file" id="menuIcon12ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 12);"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon12_set" value='{ "background-image": "_val_" }'/>
						</form>
					</td>
				</tr>
				<tr>
					<th class="L">사진 아이콘(menuIcon13) : </th>
					<td class="L">
						<form id="menuIcon13ImgForm" name="menuIcon13ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon13"/>
							<input class="tplmngr_pref_file fl" type="file" id="menuIcon13ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 13);"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon13_set" value='{ "background-image": "_val_" }'/>
						</form>
					</td>
				</tr>
				<tr>
					<th class="L">한줄 아이콘(menuIcon14) : </th>
					<td class="L">
						<form id="menuIcon14ImgForm" name="menuIcon14ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon14"/>
							<input class="tplmngr_pref_file fl" type="file" id="menuIcon14ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 14);"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon14_set" value='{ "background-image": "_val_" }'/>
						</form>
					</td>
				</tr>
				<tr>
					<th class="L">최신 아이콘(menuIcon90) : </th>
					<td class="L">
						<form id="menuIcon90ImgForm" name="menuIcon90ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon90"/>
							<input class="tplmngr_pref_file fl" type="file" id="menuIcon90ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 90);"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon90_set" value='{ "background-image": "_val_" }'/>
						</form>
					</td>
				</tr>
				<tr>
					<th class="L">인기 아이콘(menuIcon91) : </th>
					<td class="L">
						<form id="menuIcon91ImgForm" name="menuIcon91ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon91"/>
							<input class="tplmngr_pref_file fl" type="file" id="menuIcon91ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 91);"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon91_set" value='{ "background-image": "_val_" }'/>
						</form>
					</td>
				</tr>
				<tr>
					<th class="L">이미지 아이콘(menuIcon92) : </th>
					<td class="L">
						<form id="menuIcon92ImgForm" name="menuIcon92ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon92"/>
							<input class="tplmngr_pref_file fl" type="file" id="menuIcon92ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 92);"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon92_set" value='{ "background-image": "_val_" }'/>
						</form>
					</td>
				</tr>
				<tr>
					<th class="L">새글 알림 아이콘(menuIcon92) : </th>
					<td class="L">
						<form id="newIconImgForm" name="newIconImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_newIcon"/>
						<input class="tplmngr_pref_file fl" type="file" id="newIconImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 'new');"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_newIcon_set" value='{ "background-image": "_val_" }'/>
						</form>
					</td>
				</tr>
			</c:if>
			<%-- END::메뉴 아이콘 템플릿 --%>
			<%-- BEGIN::컨덴츠 영역 템플릿 --%>
			<c:if test="${suForm.decoType == 'CF0501' }">
				<tr>
					<th class="L">게시판 제목 테두리 스타일(nmBrdrStyle) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_nmBrdrStyle"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_nmBrdrStyle_set" value='{ "border-style": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">게시판 제목 테두리 너비(nmBrdrWidth) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_nmBrdrWidth"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_nmBrdrWidth_set" value='{ "border-width": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">게시판 제목 테두리 색(nmBrdrColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_nmBrdrColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_nmBrdrColor_set" value='{ "border-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">게시판 제목 글씨 색(nmFontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_nmFontColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_nmFontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">댓글 표시색(rplFontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_rplFontColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_rplFontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">글 제목 색(subjFontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_subjFontColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_subjFontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">글 제목 글꼴(subjFontNm) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_subjFontNm"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_subjFontNm_set" value='{ "font-family": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">글 제목 글 크기(subjFontSize) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_subjFontSize"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_subjFontSize_set" value='{ "font-size": "_val_" }'/>
					</td>
				</tr>
			</c:if>
			<%-- END::컨덴츠 영역 템플릿 --%>
			<%-- BEGIN::검색 영역 템플릿 --%>
			<c:if test="${suForm.decoType == 'CF0601' }">
				<tr>
					<th class="L">배경색(bgColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgColor_set" value='{ "background-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">검색 필드 테두리 색(brdrColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrColor_set" value='{ "border-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">검색 필드 테두리 스타일(brdrStyle) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrStyle"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrStyle_set" value='{ "border": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">검색 필드 글씨 색(fontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_fontColor"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_fontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">검색 버튼 이미지(srchBtn) : (<span id="srchImgSize"></span>) </th>
					<td class="L">
						<form id="srchBtnImgForm" name="srchBtnImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_srchBtn"/>
							<input class="tplmngr_pref_file fl" type="file" id="srchBtnImageFile" name="file"  onchange="superMngr.getTplMngr().doChangeSrchBtnImg(this);"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_srchBtn_set" value='{ "background-image": "_val_" }'/>				
						</form>
					</td>
				</tr>
			</c:if>
			<%-- END::검색 영역 템플릿 --%>
			<%-- BEGIN::부가 영역 템플릿 --%>
			<c:if test="${suForm.decoType == 'CF0701' }">
				<tr>
					<td colspan="2" class="C">아직 지원되지 않는 템플릿 입니다.</td>
				</tr>
			</c:if>
			<%-- END::부가 영역 템플릿 --%>
			<input type="hidden" id="decoPrefs" value="[
		 		<c:forEach items="${decoInfoPrefList}" var="deco" varStatus="status">
			{ clazz: '<c:out value="${deco.decoType}"/>_<c:out value="${deco.name}"/>', value:'<c:out value="${deco.value}"/>'}<c:if test="${!status.last}">,</c:if>
				</c:forEach>
			]"/>
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
					<a href="javascript:superMngr.getTplMngr().doGet(superMngr.getTplMngr().m_curDecoType, '<c:out value="${suForm.view}"/>')" class="btn_W"><span>새로고침</span></a>
			    	<a href="javascript:superMngr.getTplMngr().doSave('<c:out value="${suForm.view}"/>')" class="btn_W"><span><util:message key="ev.title.save"/></span></a>					
				</div>
			</div>
			<!-- btnArea//-->																										
		</table>
	</div>
	<!-- board// -->	
</c:if>
<%--END::템플릿 세부화면--%>
<%--BEGIN::템플릿 신규화면--%>
<c:if test="${suForm.view == 'new'}">
	<iframe id="imgIframe" name="imgIframe" frameborder=0 width=0 height=0></iframe>

	<!-- board -->
	<div class="board">
		<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
			<caption>게시판</caption>
			<colgroup>
				<col width="25%" />
				<col width="75%" />
			</colgroup>
			<tr>
				<th class="L">템플릿 아이디 : </th>
				<td class="L"><input class="tplmngr_pref_decoId w30 tac"" type="text" id="decoId" value="<c:out value="${suForm.decoId}"/>" disabled="disabled"/></td>
			</tr>
			<tr>
				<th class="L">템플릿 이미지 : (<span id="tplImgSize"></span>)</th>
				<td class="L">
					<form id="tplImgForm" name="tplImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
						<input class="tplmngr_pref_input fl" type="text" id="<c:out value="${suForm.decoType }"/>_tplImg"/>
						<input class="tplmngr_pref_file fl" type="file" id="<c:out value="${suForm.decoType }"/>_tplImgFile" name="file" onchange="superMngr.getTplMngr().doChangeTplImg(this);"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_tplImg_set" value="_val_"/>
						<img class="<c:out value="${suForm.decoType }"/>_tplImg" id="<c:out value="${suForm.decoType }"/>_tplImg_img"/>
					</form>	
				</td>
			</tr>
			<%-- BEGIN::타이틀 템플릿 --%>
			<c:if test="${suForm.decoType == 'CF0101' }">
				<tr>
					<th class="L">배경 템플릿(CF0102) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0102"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0102_set" value="_val_"/>
					</td>
				</tr>
				<tr>
					<th class="L">카페 이름 템플릿(CF0103) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0103"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0103_set" value="_val_"/>
					</td>
				</tr>
				<tr>
					<th class="L">카페 주소 템플릿(CF0104) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0104"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0104_set" value="_val_"/>
					</td>
				</tr>
				<tr>
					<th class="L">카페 메뉴 템플릿(CF0105) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0105"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0105_set" value="_val_"/>
					</td>
				</tr>
				<tr>
					<th class="L">카페 검색 템플릿(CF0106) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0106"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0106_set" value="_val_"/>
					</td>
				</tr>
				<tr>
					<th class="L">카페 카운터 템플릿(CF0107) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input w30 tac" id="<c:out value="${suForm.decoType }"/>_CF0107"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_CF0107_set" value="_val_"/>
					</td>
				</tr>
			</c:if>
			<%-- END::타이틀 템플릿 --%>
			<%-- BEGIN::타이틀 배경 템플릿 --%>
			<c:if test="${suForm.decoType == 'CF0102' }">
				<tr>
					<th class="L">배경색(bgColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgColor" value="white"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgColor_set" value='{ "background-color": "_val_" }'/>
					</td>
				</tr>				
				<tr>
					<th class="L">배경 이미지(bgImage) : (<span id="bgImgSize"></span>)</th>
					<td class="L">
						<form id="bgImgForm" name="bgImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgImage"/>
							<input class="tplmngr_pref_file fl" type="file" id="bgImageFile" name="file" onchange="superMngr.getTplMngr().doChangeBgImg(this);"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgImage_set" value='{ "background-image": "_val_" }'/>
						</form>
					</td>
				</tr>
				<tr>
					<th class="L">배경 이미지 위치(bgImgPos) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgImgPos" value="left,top"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgImgPos_set" value='{ "background-position-x": "_val_", "background-position-y": "_val2_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">배경 이미지 반복(bgImgRepeat) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgImgRepeat"  value="no-repeat"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgImgRepeat_set" value='{ "background-repeat": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">배경 테두리 색(brdrColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrColor"  value="black"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrColor_set" value='{ "border-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">배경 테두리 스타일(brdrStyle) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrStyle" value="1px solid"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrStyle_set" value='{ "border": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">배경색  투명도(trpcValue) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_trpcValue" value="1.0"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_trpcValue_set" value='{ "opacity": "_val_" }'/>
					</td>
				</tr>
			</c:if>
			<%-- END::타이틀 배경 템플릿 --%>
			<%-- BEGIN::타이틀 메뉴 템플릿 --%>
			<c:if test="${suForm.decoType == 'CF0105' }">
				<tr>
					<th class="L">기본색(baseFontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_baseFontColor" value="blue"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_baseFontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">배경색(bgColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgColor" value="orange"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgColor_set" value='{ "background-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">테두리 스타일(brdrStyle) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrStyle" value="solid"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrStyle_set" value='{ "border-style": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">테두리 너비(brdrWidth) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrWidth" value="1px"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrWidth_set" value='{ "border-width": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">테두리 색(brdrColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrColor" value="black"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrColor_set" value='{ "border-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">화면표시 방식(display) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_display" value="block"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_display_set" value='{ "display": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">글꼴(fontNm) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_fontNm" value="gulim"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_fontNm_set" value='{ "font-family": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">위치(position) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_position" value="absolute,0px"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_position_set" value='{ "position": "_val_", "left": "_val2_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">선택 시 색(selFontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_selFontColor" value="red"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_selFontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>
			</c:if>
			<%-- END::타이틀 메뉴 템플릿 --%>
			<%-- BEGIN::정보 영역 템플릿 --%>
			<c:if test="${suForm.decoType == 'CF0301' }">
				<tr>
					<th class="L">기본색(baseFontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_baseFontColor" value="blue"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_baseFontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>				
				<tr>
					<th class="L">배경색(bgColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgColor" value="white"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgColor_set" value='{ "background-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">테두리 색(brdrColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrColor" value="black"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrColor_set" value='{ "border-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">버튼 배경 색(btnBgColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_btnBgColor" value="white"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_btnBgColor_set" value='{ "background-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">버튼 글씨 색(btnFontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_btnFontColor" value="pink"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_btnFontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>					
				<tr>
					<th class="L">내정보 보기 버튼(myInfoButton) : (<span id="myInfoImgSize"></span>)</th>
					<td class="L">
						<form id="myInfoBtnImgForm" name="myInfoBtnImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_myInfoButton"/>
							<input class="tplmngr_pref_file fl" type="file" id="myInfoBtnImageFile" name="file"  onchange="superMngr.getTplMngr().doChangeMyInfoBtnImg(this);"/>				
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_myInfoButton_set" value='{ "background-image": "_val_" }'/>
							<div class="<c:out value="${suForm.decoType }"/>_myInfoButton" id="<c:out value="${suForm.decoType }"/>_myInfoButton_img"></div>
						</form>
					</td>
				</tr>
				<tr>
					<th class="L">내정보 보기 버튼2(myInfoButton2) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_myInfoButton2" value="none"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_myInfoButton2_set" value='{ "display": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">강조색(valFontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_valFontColor" value="red"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_valFontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>
			</c:if>
			<%-- END::정보 영역 템플릿 --%>
			<%-- BEGIN::메뉴 영역 템플릿 --%>
			<c:if test="${suForm.decoType == 'CF0401' }">
				<tr>
					<th class="L">기본색(baseFontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_baseFontColor" value="blue"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_baseFontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">배경색(bgColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgColor" value="white"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgColor_set" value='{ "background-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">테두리 스타일(brdrStyle) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrStyle" value="solid"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrStyle_set" value='{ "border-style": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">테두리 너비(brdrWidth) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrWidth" value="1px 1px 1px 1px"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrWidth_set" value='{ "border-width": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">테두리 색(brdrColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrColor" value="black"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrColor_set" value='{ "border-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">메뉴 그룹 배경색(menuGrpBgColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuGrpBgColor" value="white"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuGrpBgColor_set" value='{ "background-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">메뉴 아이콘 셋(menuIconSet) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIconSet" value="62"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIconSet_set" value='_val_'/>
					</td>
				</tr>
				<tr>
					<th class="L">구분선 색(sepBrdrColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_sepBrdrColor" value="green"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_sepBrdrColor_set" value='{ "border-top-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">구분선 스타일(sepBrdrStyle) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_sepBrdrStyle" value="solid"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_sepBrdrStyle_set" value='{ "border-top": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">구분선 너비(sepBrdrWidth) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_sepBrdrWidth" value="1px"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_sepBrdrWidth_set" value='{ "border-top-width": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">강조색(valFontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_valFontColor" value="red"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_valFontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>
			</c:if>
			<%-- END::메뉴 영역 템플릿 --%>
			<%-- BEGIN::메뉴 아이콘 템플릿 --%>
			<c:if test="${suForm.decoType == 'CF0402' }">
				<tr>
					<th class="L">아이콘 폴더 이름(tplName) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_tplName"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_tplName_set" value='_val_'/>
					</td>
				</tr>				
				<tr>
					<th class="L">아이콘 너비 만큼 들여쓰기(txtIndnt) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_txtIndnt" value="13px"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_txtIndnt_set" value='{ "text-indent": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">아이콘 너비 만큼 왼쪽으로 확장(pddngLft) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_pddngLft" value="15px"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_pddngLft_set" value='{ "padding-left": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">일반 아이콘(menuIcon10) : </th>
					<td class="L">
						<form id="menuIcon10ImgForm" name="menuIcon10ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon10"/>
							<input class="tplmngr_pref_file fl" type="file" id="menuIcon10ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 10);"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon10_set" value='{ "background-image": "_val_" }'/>
							<div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon10_img"></div>
						</form>
					</td>
				</tr>
				<tr>
					<th class="L">익명 아이콘(menuIcon11) : </th>
					<td class="L">
						<form id="menuIcon11ImgForm" name="menuIcon11ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon11"/>
							<input class="tplmngr_pref_file fl" type="file" id="menuIcon11ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 11);"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon11_set" value='{ "background-image": "_val_" }'/>
							<div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon11_img"></div>
						</form>
					</td>
				</tr>
				<tr>
					<th class="L">Q/A 아이콘(menuIcon12) : </th>
					<td class="L">
						<form id="menuIcon12ImgForm" name="menuIcon12ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon12"/>
							<input class="tplmngr_pref_file fl" type="file" id="menuIcon12ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 12);"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon12_set" value='{ "background-image": "_val_" }'/>
							<div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon12_img"></div>
						</form>
					</td>
				</tr>
				<tr>
					<th class="L">사진 아이콘(menuIcon13) : </th>
					<td class="L">
						<form id="menuIcon13ImgForm" name="menuIcon13ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon13"/>
							<input class="tplmngr_pref_file fl" type="file" id="menuIcon13ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 13);"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon13_set" value='{ "background-image": "_val_" }'/>
							<div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon13_img"></div>
						</form>
					</td>
				</tr>
				<tr>
					<th class="L">한줄 아이콘(menuIcon14) : </th>
					<td class="L">
						<form id="menuIcon14ImgForm" name="menuIcon14ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon14"/>
							<input class="tplmngr_pref_file fl" type="file" id="menuIcon14ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 14);"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon14_set" value='{ "background-image": "_val_" }'/>
							<div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon14_img"></div>
						</form>
					</td>
				</tr>
				<tr>
					<th class="L">최신 아이콘(menuIcon90) : </th>
					<td class="L">
						<form id="menuIcon90ImgForm" name="menuIcon90ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon90"/>
							<input class="tplmngr_pref_file fl" type="file" id="menuIcon90ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 90);"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon90_set" value='{ "background-image": "_val_" }'/>
							<div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon90_img"></div>
						</form>
					</td>
				</tr>
				<tr>
					<th class="L">인기 아이콘(menuIcon91) : </th>
					<td class="L">
						<form id="menuIcon91ImgForm" name="menuIcon91ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon91"/>
							<input class="tplmngr_pref_file fl" type="file" id="menuIcon91ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 91);"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon91_set" value='{ "background-image": "_val_" }'/>
							<div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon91_img"></div>
						</form>
					</td>
				</tr>
				<tr>
					<th class="L">이미지 아이콘(menuIcon92) : </th>
					<td class="L">
						<form id="menuIcon92ImgForm" name="menuIcon92ImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_menuIcon92"/>
							<input class="tplmngr_pref_file fl" type="file" id="menuIcon92ImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 92);"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_menuIcon92_set" value='{ "background-image": "_val_" }'/>
							<div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon92_img"></div>
						</form>
					</td>
				</tr>
				<tr>
					<th class="L">새글 알림 아이콘(menuIcon10) : </th>
					<td class="L">
						<form id="newIconImgForm" name="newIconImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_newIcon"/>
							<input class="tplmngr_pref_file fl" type="file" id="newIconImageFile" name="file" onchange="superMngr.getTplMngr().doChangeMenuIconImg(this, 'new');"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_newIcon_set" value='{ "background-image": "_val_" }'/>
							<div class="<c:out value="${suForm.decoType }"/>_menuIconImage" id="<c:out value="${suForm.decoType }"/>_menuIcon10_img"></div>
						</form>
					</td>
				</tr>
			</c:if>
			<%-- END::메뉴 아이콘 템플릿 --%>
			<%-- BEGIN::컨덴츠 영역 템플릿 --%>
			<c:if test="${suForm.decoType == 'CF0501' }">
				<tr>
					<th class="L">게시판 제목 테두리 스타일(nmBrdrStyle) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_nmBrdrStyle" value="solid"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_nmBrdrStyle_set" value='{ "border-style": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">게시판 제목 테두리 너비(nmBrdrWidth) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_nmBrdrWidth" value="0px 0px 1px 0px"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_nmBrdrWidth_set" value='{ "border-width": "_val_" }'/>
					</td>
				</tr>	
				<tr>
					<th class="L">게시판 제목 테두리 색(nmBrdrColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_nmBrdrColor" value="blue"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_nmBrdrColor_set" value='{ "border-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">게시판 제목 글씨 색(nmFontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_nmFontColor" value="blue"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_nmFontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">댓글 표시색(rplFontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_rplFontColor" value="orange"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_rplFontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">글 제목 색(subjFontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_subjFontColor" value="black"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_subjFontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">글 제목 글꼴(subjFontNm) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_subjFontNm" value="gulim"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_subjFontNm_set" value='{ "font-family": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">글 제목 글 크기(subjFontSize) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_subjFontSize" value="12px"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_subjFontSize_set" value='{ "font-size": "_val_" }'/>
					</td>
				</tr>
			</c:if>
			<%-- END::컨덴츠 영역 템플릿 --%>
			<%-- BEGIN::검색 영역 템플릿 --%>
			<c:if test="${suForm.decoType == 'CF0601' }">
				<tr>
					<th class="L">배경색(bgColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_bgColor"/ value="white">
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_bgColor_set" value='{ "background-color": "_val_" }'/>
					</td>
				</tr>				
				<tr>
					<th class="L">검색 필드 테두리 색(brdrColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrColor" value="black"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrColor_set" value='{ "border-color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">검색 필드 테두리 스타일(brdrStyle) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_brdrStyle" value="1px solid"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_brdrStyle_set" value='{ "border": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">검색 필드 글씨 색(fontColor) : </th>
					<td class="L">
						<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_fontColor" value="black"/>
						<input type="hidden" id="<c:out value="${suForm.decoType }"/>_fontColor_set" value='{ "color": "_val_" }'/>
					</td>
				</tr>
				<tr>
					<th class="L">검색 버튼 이미지(srchBtn) : (<span id="srchImgSize"></span>)</th>
					<td class="L">
						<form id="srchBtnImgForm" name="srchBtnImgForm" action="" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="text" class="tplmngr_pref_input tac" id="<c:out value="${suForm.decoType }"/>_srchBtn"/>
							<input class="tplmngr_pref_file fl" type="file" id="srchBtnImageFile" name="file"  onchange="superMngr.getTplMngr().doChangeSrchBtnImg(this);"/>
							<input type="hidden" id="<c:out value="${suForm.decoType }"/>_srchBtn_set" value='{ "background-image": "_val_" }'/>
							<div class="<c:out value="${suForm.decoType }"/>_srchBtn" id="<c:out value="${suForm.decoType }"/>_srchBtn_img"></div>
						</form>	
					</td>
				</tr>
			</c:if>
			<%-- END::검색 영역 템플릿 --%>
			<%-- BEGIN::부가 영역 템플릿 --%>
			<c:if test="${suForm.decoType == 'CF0701' }">
				<tr>
					<td colspan="2" class="C">아직 지원되지 않는 템플릿 입니다.</td>
				</tr>					
			</c:if>
			<%-- END::부가 영역 템플릿 --%>
			<!-- btnArea-->
			<div class="btnArea">
				<div class="rightArea">
			    	<a href="javascript:superMngr.getTplMngr().doCreate()" class="btn_W"><span><util:message key="ev.title.save"/></span></a>					
				</div>
			</div>
			<!-- btnArea//-->																													
		</table>
	</div>
	<!-- board// -->
</c:if>
<%--END::템플릿 신규화면--%>