<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
<style >
.containerTableStyle table {table-layout:auto }
</style>
<%--BEGIN::최초로 호출될 때--%>
<c:if test="${empty aaForm.view}">
<div class="sub_contents">
	<div class="detail">
		<div id="actHistViewTabs" class="board first">
			<ul>
				<li><a href="#userViewTab" onclick="admActHistMngr.onSelectViewTabs(0)">사용자별 현황</a></li>
				<li><a href="#boardViewTab" onclick="admActHistMngr.onSelectViewTabs(1)">게시판별 현황</a></li>
			</ul>
			<div id="userViewTab" class="adgridpanel"></div>
			<div id="boardViewTab"class="adgridpanel"></div>
		</div>
		<div id="ubListDiv"></div>
	</div>
</div>
</c:if>
<%--END::최초로 호출될 때--%>
<%--BEGIN::상단 사용자 목록 또는 게시판 카테고리트리와 게시판목록 영역--%>
<c:if test="${aaForm.view == 'onlyUbSelectBox'}">
	<c:if test="${aaForm.cmd == 'user'}">
	<div class="board">	
	<!-- searchArea-->
	<div class="tsearchArea">
		<p id="GroupManager_ListMessage"></p>
		<fieldset>
			<form name="frmUL" method="post" action="">
				<input type="hidden" id="userTrIndex" />
				<input type="hidden" name="totalSize" value="<c:out value="${aaForm.totalSize}"/>" />
				<input type="hidden" name="pageSize"	value="<c:out value="${aaForm.pageSize}"/>" />
				<input type="hidden" name="pageNo"		value="<c:out value="${aaForm.pageNo}"/>" />
				<input type="hidden" name="totalPage" value="<c:out value="${aaForm.totalPage}"/>" />
				<div class="sel_100">
					<select name="srchOrder" class="txt_100"">
						<c:forEach items="${orderList}" var="order">
							<option value="<c:out value="${order.code}"/>" <c:if test="${order.code == aaForm.srchOrder}">selected</c:if>><c:out value="${order.codeName}"/>
						</c:forEach>
					</select>
				</div>
				<input type="text" name="srchUserId" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'*아이디*');" onblur="ebUtil.whenSrchBlur(this,'*아이디*');"
					<c:if test="${empty aaForm.srchUserId}">value="*아이디*"</c:if><c:if test="${!empty aaForm.srchUserId}">value="<c:out value="${aaForm.srchUserId}"/>"</c:if>>
				<input type="text" name="srchNmKor" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'*이름*');" onblur="ebUtil.whenSrchBlur(this,'*이름*');"
					<c:if test="${empty aaForm.srchNmKor}">value="*이름*"</c:if><c:if test="${!empty aaForm.srchNmKor}">value="<c:out value="${aaForm.srchNmKor}"/>"</c:if>>
				<a href="javascript:admActHistMngr.getUserList('srch')" class="btn_search"><span><util:message key='ev.title.search'/></span></a>
			</form>
		</fieldset>
	</div>
	<!-- searchArea//-->
	<table cellpadding=0 cellspacing=0 border=0 class="table_board">
		<colgroup>
			<col width="10%" />
			<col width="40%" />
			<col width="50%" />
		</colgroup>
		
		<thead>
			<tr>
				<th class="first"><span class="table_title">순번</span></th>
				<th ><span class="table_title">아이디</span></th>
				<th ><span class="table_title">이름</span></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${userList}" var="user" varStatus="status">
			<tr id='userTr<c:out value="${status.index}"/>' onclick="admActHistMngr.getUserBoardList('user','<c:out value="${user.code}"/>','','init')" style="cursor: pointer; " >
				<td class="C"><c:out value="${user.codeId}"/></td>
				<td class="C"><c:out value="${user.code}"/></td>
				<td class="C"><c:out value="${user.codeName}"/></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<!-- tcontrol-->
	<div class="tcontrol">
		<!-- paging -->
		<div class="paging" id="userListPageIterator">				
		</div>
		<!-- paging//-->
	</div>
	<!-- tcontrol//-->
	</div>
	</c:if>
	<c:if test="${aaForm.cmd == 'board' && aaForm.act != 'cateBoard'}"> <%--게시판별 현황--%>
		<div class="sub_contents">
			<div id="brdCateTreeBox" class="tree2" style="border-right: 0px #ffffff;" ></div>
			<div id="childBoardBox" class="detail" style="overflow: hidden;"></div>
		</div>
	</c:if>
</c:if>
<%--END::상단 사용자 목록 또는 게시판 카테고리트리와 게시판목록 영역--%>
<%--BEGIN::상단 좌측에서 선택된 카테고리에 배속된 게시판목록--%>
<c:if test="${aaForm.view == 'onlyUbSelectBox' && aaForm.cmd == 'board' && aaForm.act == 'cateBoard'}">	
	<form name="frmBL" method="post" action=""> 
	<input type="hidden" id="brdTrIndex" />
	<input type="hidden" name="totalSize" value="<c:out value="${aaForm.totalSize}"/>"/>
	<input type="hidden" name="pageSize"	value="<c:out value="${aaForm.pageSize}"/>"/>
	<input type="hidden" name="pageNo"		value="<c:out value="${aaForm.pageNo}"/>"/>
	<input type="hidden" name="totalPage" value="<c:out value="${aaForm.totalPage}"/>"/>
	
	<table cellpadding=0 cellspacing=0 border=0 class="table_board">
		<colgroup>
			<col width="20%" />
			<col width="20%" />
			<col width="20%" />
			<col width="20%" />
			<col width="20%" />
		</colgroup>
		<thead>
			<tr>
				<th class="first"><span class="table_title">아이디</span></th>
				<th><span class="table_title">게시판 명</span></th>
				<th><span class="table_title">Title Text</span></th>
				<th><span class="table_title">적용된 SKIN</span></th>
				<th><span class="table_title">최종수정일</span></th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${empty boardVOs}">
			<tr><td class="C" colspan=5>배속된 게시판이 존재하지 않습니다.</td></tr>
		</c:if>
		<c:if test="${!empty boardVOs}">
		<c:forEach items="${boardVOs}" var="board" varStatus="status">
		<tr id='brdTr<c:out value="${status.index}"/>' class="C" style="cursor: pointer;"
			onclick="admActHistMngr.showBoardAttr('<c:out value="${board.boardId}"/>','<c:out value="${board.boardRid}"/>','<c:out value="${board.mergeType}"/>','<c:out value="${board.owntblYn}"/>','<c:out value="${board.owntblFix}"/>',event);
					 admActHistMngr.getUserBoardList('board','','<c:out value="${board.boardId}"/>','init')"
		>
			<td name=e<c:out value="${status.index}"/> id=e<c:out value="${status.index}"/> class="C"><c:out value="${board.boardId}"/></td>
			<td name=e<c:out value="${status.index}"/> id=e<c:out value="${status.index}"/> class="C"><c:out value="${board.boardNm}"/></td>
			<td name=e<c:out value="${status.index}"/> id=e<c:out value="${status.index}"/> class="C"><c:out value="${board.boardTtl}"/></td>
			<td name=e<c:out value="${status.index}"/> id=e<c:out value="${status.index}"/> class="C"><c:out value="${board.boardSkin}"/></td>
			<td name=e<c:out value="${status.index}"/> id=e<c:out value="${status.index}"/> class="C"><c:out value="${board.updDatimF}"/></td>
		</tr>
		</c:forEach>
		</c:if>
		</tbody>
	</table>
	<!-- tcontrol-->
	<div class="tcontrol">
		<!-- paging -->
		<div class="paging" id="boardListPageIterator">				
		</div>
		<!-- paging//-->
	</div>
	<!-- tcontrol//-->
	</form>
</c:if>
<%--END::상단 좌측에서 선택된 카테고리에 배속된 게시판목록--%>
<%--BEGIN::중간단 USER_BOARD_HIST 목록--%>
<c:if test="${aaForm.view == 'onlyUbList'}">
	<div class="board">
	<c:if test="${aaForm.cmd == 'board'}">
		<!-- searchArea-->
		<div class="tsearchArea">
			<p style="background: none;"></p>
			<fieldset>
				<form name="frmUBL" method="post" action="">
					<input type="hidden" id=ubTrIndex>
					<input type="hidden" name="totalSize" value="<c:out value="${aaForm.totalSize}"/>" />
					<input type="hidden" name="pageSize"	value="<c:out value="${aaForm.pageSize}"/>" />
					<input type="hidden" name="pageNo"		value="<c:out value="${aaForm.pageNo}"/>" />
					<input type="hidden" name="totalPage" value="<c:out value="${aaForm.totalPage}"/>" />
					
					<div class="sel_100">
						<select name="srchOrder" class="txt_100">
							<c:forEach items="${orderList}" var="order">
							<option value="<c:out value="${order.code}"/>" <c:if test="${order.code == aaForm.srchOrder}">selected</c:if>><c:out value="${order.codeName}"/>
							</c:forEach>
						</select>
					</div>
					
					<input type="text" name="srchUserId" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'*아이디*');" onblur="ebUtil.whenSrchBlur(this,'*아이디*');"
						<c:if test="${empty aaForm.srchUserId}">value="*아이디*"</c:if><c:if test="${!empty aaForm.srchUserId}">value="<c:out value="${aaForm.srchUserId}"/>"</c:if>>
					<input type="text" name="srchNmKor" class="txt_100" onfocus="ebUtil.whenSrchFocus(this,'*이름*');" onblur="ebUtil.whenSrchBlur(this,'*이름*');"
						<c:if test="${empty aaForm.srchNmKor}">value="*이름*"</c:if><c:if test="${!empty aaForm.srchNmKor}">value="<c:out value="${aaForm.srchNmKor}"/>"</c:if>> 

					<a href="javascript:admActHistMngr.getUserBoardList('board','',admActHistMngr.m_curBoardId,'srch');" class="btn_search">
						<span><util:message key='ev.title.search'/></span>
					</a>
				</form>
			</fieldset>
		</div>
		<!-- searchArea//-->
	</c:if>
	<c:if test="${aaForm.cmd != 'board'}">
	<form name="frmUBL" method="post" action="">
		<input type="hidden" id=ubTrIndex />
		<input type="hidden" name="totalSize" value="<c:out value="${aaForm.totalSize}"/>" />
		<input type="hidden" name="pageSize"	value="<c:out value="${aaForm.pageSize}"/>" />
		<input type="hidden" name="pageNo"		value="<c:out value="${aaForm.pageNo}"/>" />
		<input type="hidden" name="totalPage" value="<c:out value="${aaForm.totalPage}"/>" />
	</form>
	</c:if>
	<table cellpadding=0 cellspacing=0 border=0 class="table_board">
		<colgroup>
			<col width='8%'/>
			<col width='40%'/>
			<col width='13%'/>
			<col width='13%'/>
			<col width='13%'/>
			<col width='13%'/>		
		</colgroup>
		<thead>
			<tr>
				<th class='first'><span class="table_title">순번</span></th>
				<th>
					<span class="table_title">
					<c:if test="${aaForm.cmd == 'user'}">게시판명</c:if>
					<c:if test="${aaForm.cmd == 'board'}">사용자</c:if>
					</span>
				</th>
				<th><span class="table_title">글쓰기</span></th>
				<th><span class="table_title">답글쓰기</span></th>
				<th><span class="table_title">댓글쓰기</span></th>
				<th><span class="table_title">댓답글쓰기</span></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${ubhList}" var="ubh" varStatus='status'>
			<tr id='ubTr<c:out value="${status.index}"/>' style="cursor: pointer;"
					<c:if test="${aaForm.cmd == 'user'}">
					onclick="admActHistMngr.getActList('user','<c:out value="${ubh.userId}"/>','<c:out value="${ubh.boardId}"/>','init')"
					</c:if>
					<c:if test="${aaForm.cmd == 'board'}">
					onclick="admActHistMngr.getActList('board','<c:out value="${ubh.userId}"/>','<c:out value="${ubh.boardId}"/>','init')"
					</c:if>
			>
				<td class="C"><c:out value="${ubh.rnum}"/></td>
				<td class="C">
					<c:if test="${aaForm.cmd == 'user'}"><c:out value="${ubh.boardNm}"/>(<c:out value="${ubh.boardId}"/>)</c:if>
					<c:if test="${aaForm.cmd == 'board'}"><c:out value="${ubh.nmKor}"/>(<c:out value="${ubh.userId}"/>)</c:if>
				</td>
				<td class="C"><c:out value="${ubh.wrtCnt}"/></td>
				<td class="C"><c:out value="${ubh.replyCnt}"/></td>
				<td class="C"><c:out value="${ubh.memoCnt}"/></td>
				<td class="C"><c:out value="${ubh.memoReplyCnt}"/></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<!-- tcontrol-->
	<div class="tcontrol">
		<!-- paging -->
		<div class="paging" id="ubListPageIterator">				
		</div>
		<!-- paging//-->
	</div>
	<!-- tcontrol//-->
	</div>
	<div id="actListBox"></div>
	<div id="actListDiv"></div>
</c:if>
<%--END::중간단 USER_BOARD_HIST 목록--%>
<%--BEGIN::하단 ACTION_HIST 목록--%>
<c:if test="${aaForm.view == 'onlyActList'}">
<div class="board">
	<table cellpadding=0 cellspacing=0 border=0 class="table_board">
		<colgroup>
			<col width='28%'/>
			<col width='22%'/>
			<col width='22%'/>
			<col width='28%'/>
		</colgroup>
	
		<thead>
			<tr>
				<th class="first"><span class="table_title">사용일시</span></th>
				<th><span class="table_title">사용자 IP</span></th>
				<th><span class="table_title">게시물 번호</span></th>
				<th><span class="table_title">사용 기능</span></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${actList}" var="act" varStatus="status">
			<tr>
				<td class="C"><c:out value="${act.regDatimPF}"/></td>
				<td class="C"><c:out value="${act.userIp}"/></td>
				<td class="C"><c:out value="${act.bltnNo}"/></td>
				<td class="C"><c:out value="${act.actionNm}"/></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<!-- tcontrol-->
	<div class="tcontrol">
		<!-- paging -->
		<div class="paging" id="actListPageIterator">				
		</div>
		<!-- paging//-->
	</div>
	<!-- tcontrol//-->
	<form name="frmActL" method="post" action="">
		<input type="hidden" name="cmd"			 value="<c:out value="${aaForm.cmd}"/>"/>
		<input type="hidden" name="userId"		value="<c:out value="${aaForm.userId}"/>"/>
		<input type="hidden" name="boardId"	 value="<c:out value="${aaForm.boardId}"/>"/>
		<input type="hidden" name="totalSize" value="<c:out value="${aaForm.totalSize}"/>"/>
		<input type="hidden" name="pageSize"	value="<c:out value="${aaForm.pageSize}"/>"/>
		<input type="hidden" name="pageNo"		value="<c:out value="${aaForm.pageNo}"/>"/>
		<input type="hidden" name="totalPage" value="<c:out value="${aaForm.totalPage}"/>"/>
	</form>
</div>
</c:if>
<%--END::하단 ACTION_HIST 목록--%>

<c:if test="${empty aaForm.view}">
<link rel="stylesheet" type="text/css" href="<%=evcp%>/board/css/admin/admin-common.css">
<script type="text/javascript" src="<%=evcp%>/board/javascript/enboard_util.js"></script>
<script type="text/javascript">
AdmActHistMngr = function() {
	this.m_contextPath = portalPage.getContextPath();
	this.m_ajax = new enview.util.Ajax();
	this.m_ajax.setContextPath (this.m_contextPath);
	this.m_pageNavi = new enview.util.PageNavigationUtil();
	
	this.init();
}
AdmActHistMngr.prototype = {
	m_contextPath : null,
	m_ajax        : null,
	m_pageNavi    : null,
	m_tree        : null,
	
	m_curCmd      : null,
	m_curUserId   : null,
	m_curBoardId  : null,
  
	init : function () {
		$("#actHistViewTabs").tabs();
		this.onSelectViewTabs (0);
	},
	onSelectViewTabs : function (tabId) {
		document.getElementById("ubListDiv").innerHTML = "";
		switch (tabId) {
		case 0:
			if (document.getElementById("userViewTab").innerHTML.length > 0) return;
			var param = "m=uiActionHistMng";
			param += "&view=onlyUbSelectBox&cmd=user";
			this.m_ajax.send ("POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { admActHistMngr.onSelectViewTabsHandler(0,htmlData); }});		
			break;
		case 1:
			if (document.getElementById("boardViewTab").innerHTML.length > 0) return;
			var param = "m=uiActionHistMng";
			param += "&view=onlyUbSelectBox&cmd=board";
			this.m_ajax.send ("POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { admActHistMngr.onSelectViewTabsHandler(1,htmlData); }});		
			break;
		}
	},
	onSelectViewTabsHandler : function (tabId,htmlData) {
		document.getElementById("ubListDiv").innerHTML = "";
		switch (tabId) {
		case 0:
			document.getElementById("userViewTab").innerHTML = htmlData;

			var frm = document.frmUL;
			var pageNo    = frm.pageNo.value;
			var pageSize  = frm.pageSize.value;
			var totalSize = frm.totalSize.value;
			document.getElementById("userListPageIterator").innerHTML = admActHistMngr.m_pageNavi.getPageIteratorHtmlString (pageNo, pageSize, totalSize, "frmUL", "admActHistMngr.doUserNext");			
			break;
		case 1:
			document.getElementById("boardViewTab").innerHTML = htmlData;

			admActHistMngr.m_tree = new dhtmlXTreeObject (document.getElementById('brdCateTreeBox'),"100%","100%",0);
			admActHistMngr.m_tree.setImagePath (this.m_contextPath+"/board/images/tree/");
			admActHistMngr.m_tree.setOnClickHandler (this.getBoardList);
			admActHistMngr.m_tree.enableDragAndDrop (false)
			admActHistMngr.m_tree.enableAutoTooltips (true);
			admActHistMngr.m_tree.setXMLAutoLoading (this.m_contextPath+"/board/adCate.brd?m=catebaseTree"); 
			admActHistMngr.m_tree.loadXML (this.m_contextPath+"/board/adCate.brd?m=catebaseTree&id=1&act=root");
			break;
		}
	},
	getUserList : function (act) {
		var frm = document.frmUL;
		if (frm.srchUserId.value == '<util:message key="eb.info.ttl.l.id"/>')   frm.srchUserId.value = "";
		if (frm.srchNmKor.value  == '<util:message key="eb.info.ttl.l.name"/>') frm.srchNmKor.value  = "";

		var param = "m=uiActionHistMng";
		param += "&view=onlyUbSelectBox&cmd=user&act="+act;
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adAuxil.brd", ebUtil.completeParam(frm, param), true, {success: function(htmlData) { admActHistMngr.onSelectViewTabsHandler(0,htmlData); }});		
		
		if (frm.srchUserId.value == "") frm.srchUserId.value = '<util:message key="eb.info.ttl.l.id"/>';
		if (frm.srchNmKor.value  == "") frm.srchNmKor.value  = '<util:message key="eb.info.ttl.l.name"/>';
	},
	doUserNext : function (frmNm, pageNo) {
		var formElm = document.forms[frmNm];
	    formElm.elements["pageNo"].value = pageNo;
		admActHistMngr.getUserList("");
	},
	getBoardList : function ( cateId) {
		document.getElementById("ubListDiv").innerHTML = "";
		var frm = document.frmBL;
		if( cateId !=null && frm !=null) {
			frm.pageNo.value = 1;			
		}
		
		
		var param = "m=uiActionHistMng";
		param += "&view=onlyUbSelectBox&cmd=board&act=cateBoard";
		param += "&cateId=" + admActHistMngr.m_tree.getSelectedItemId();
		admActHistMngr.m_ajax.send("POST", admActHistMngr.m_contextPath+"/board/adAuxil.brd", ebUtil.completeParam(frm, param), true, {success: function(htmlData) {
			document.getElementById("childBoardBox").innerHTML = htmlData;

			var frm = document.frmBL;
			var pageNo    = frm.pageNo.value;
			var pageSize  = frm.pageSize.value;
			var totalSize = frm.totalSize.value;
			document.getElementById("boardListPageIterator").innerHTML = admActHistMngr.m_pageNavi.getPageIteratorHtmlString (pageNo, pageSize, totalSize, "frmBL", "admActHistMngr.doBoardNext");
		}});
	},
	doBoardNext : function (frmNm, pageNo) {
		var formElm = document.forms[frmNm];
	    formElm.elements["pageNo"].value = pageNo;
		admActHistMngr.getBoardList();
	},	
	showBoardAttr : function (boardId, boardRid, mergeType, owntblYn, owntblFix, evt) {
		if (boardId == boardRid && mergeType == 'A' && owntblYn == 'N') return;
		var wid  = 0;
		var cntt = "";
		cntt += "<table width=100% cellpadding=0 cellspacing=0 board=0>";
		cntt += " <tr>";
		cntt += "   <td height=30 align=center valign=middle style='padding:0 10 0 10'>";
		if (boardId != boardRid) {
			wid  += 120;
			//cntt += "▶가상게시판";
			cntt += '<util:message key="eb.title.pseudoBoard"/>';
		}
		if (mergeType == "B") {
			wid  += 100;
			//cntt += "&nbsp;▶통합형";
			cntt += '<util:message key="eb.title.mergeBoard"/>';
		} else if (mergeType == "C") {
			wid  += 160;
			//cntt += "&nbsp;▶최신글형";
			cntt += '<util:message key="eb.title.newestBoard"/>';
		} else if (mergeType == "D") {
			wid  += 130;
			//cntt += "&nbsp;▶인기글형";
			cntt += '<util:message key="eb.title.popularBoard"/>';
		} else if (mergeType == "E") {
			wid  += 130;
			//cntt += "&nbsp;▶이미지형";
			cntt += '<util:message key="eb.title.imageBoard"/>';
		} else if (mergeType == "F") {
			wid  += 130;
			//cntt += "&nbsp;▶동영상형";
			cntt += '<util:message key="eb.title.movieBoard"/>';
		} else if (mergeType == "G") {
			wid  += 160;
			//cntt += "&nbsp;▶나만의 자료실형";
			cntt += '<util:message key="eb.title.myownBoard"/>';
		} else if (mergeType == "H") {
			wid  += 130;
			//cntt += "&nbsp;▶내게 온 글형";
			cntt += '<util:message key="eb.title.tomeBoard"/>';
		}
		if (owntblYn == "Y") {
			wid  += 180;
			//cntt += "&nbsp;▶독립형("+owntblFix+")";
			cntt += '<util:message key="eb.title.soloBoard"/>';
		}

		cntt += "   </td>";
		cntt += " </tr>";
		cntt += "</table>";

		ebUtil.getPopupDialog().init(wid,30);
		ebUtil.getPopupDialog().show(evt, cntt);
	},
	getUserBoardList : function (cmd, userId, boardId, act) {
		
		this.m_curCmd = cmd;
		if (userId != "")  this.m_curUserId  = userId;
		if (boardId != "") this.m_curBoardId = boardId;

		var param = "m=uiActionHistMng";

		if (userId != "" && boardId == "") {
			param += "&view=onlyUbList&cmd=user&userId="+userId;
			if (act != "init") param = ebUtil.completeParam (document.frmUBL, param);
			this.m_ajax.send ("POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { admActHistMngr.getUserBoardListHandler(htmlData); }});
		} else if (userId == "" && boardId != "") {
			if (act == "srch") {
				var frm = document.frmUBL;
				if (frm.srchUserId.value == ebUtil.getMessage('eb.info.ttl.l.id'))    frm.srchUserId.value = "";
				if (frm.srchNmKor.value  == ebUtil.getMessage('eb.info.ttl.l.name'))  frm.srchNmKor.value  = "";

				param += "&view=onlyUbList&cmd=board&boardId="+boardId+"&act="+act;
				this.m_ajax.send ("POST", this.m_contextPath+"/board/adAuxil.brd", ebUtil.completeParam(frm,param), true, {success: function(htmlData) { admActHistMngr.getUserBoardListHandler(htmlData); }});
				
				if (frm.srchUserId.value == "" ) frm.srchUserId.value = ebUtil.getMessage('eb.info.ttl.l.id');
				if (frm.srchNmKor.value  == "" ) frm.srchNmKor.value  = ebUtil.getMessage('eb.info.ttl.l.name');
			} else {
				param += "&view=onlyUbList&cmd=board&boardId="+boardId+"&act="+act;
				if (act != "init") param = ebUtil.completeParam (document.frmUBL, param);
				this.m_ajax.send ("POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { admActHistMngr.getUserBoardListHandler(htmlData); }});
			}
		}
	},
	getUserBoardListHandler : function (htmlData) {
		document.getElementById("ubListDiv").innerHTML = htmlData;

		var frm = document.frmUBL;
		var pageNo    = frm.pageNo.value;
		var pageSize  = frm.pageSize.value;
		var totalSize = frm.totalSize.value;
		document.getElementById("ubListPageIterator").innerHTML = admActHistMngr.m_pageNavi.getPageIteratorHtmlString (pageNo, pageSize, totalSize, "frmUBL", "admActHistMngr.doUserBoardNext");
	},
	doUserBoardNext : function (frmNm, pageNo) {
		var formElm = document.forms[frmNm];
	    formElm.elements["pageNo"].value = pageNo;
		if (this.m_curCmd == "user")  admActHistMngr.getUserBoardList ("user",this.m_curUserId,"","");
		if (this.m_curCmd == "board") admActHistMngr.getUserBoardList ("board","",this.m_curBoardId,"");
	},	
	getActList : function (cmd, userId, boardId, act) {
		var param = "m=uiActionHistMng&view=onlyActList";
		if (act == "init") {
			param += "&cmd="+cmd+"&boardId="+boardId+"&userId="+userId;
		} else {
			param = ebUtil.completeParam (document.frmActL, param);
		}
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { admActHistMngr.getActListHandler(htmlData); }});
	},
	getActListHandler : function (htmlData) {
		document.getElementById("actListDiv").innerHTML = htmlData;

		var frm = document.frmActL;
		var pageNo    = frm.pageNo.value;
		var pageSize  = frm.pageSize.value;
		var totalSize = frm.totalSize.value;
		document.getElementById("actListPageIterator").innerHTML = admActHistMngr.m_pageNavi.getPageIteratorHtmlString (pageNo, pageSize, totalSize, "frmActL", "admActHistMngr.doActNext");
	},
	doActNext : function (frmNm, pageNo) {
		var formElm = document.forms[frmNm];
	    formElm.elements["pageNo"].value = pageNo;
		admActHistMngr.getActList ();
	}
}
function initAdmActHistMngr () {
	admActHistMngr = new AdmActHistMngr();
}
function finishAdmActHistMngr () {}

// Attach to the onload event
if (window.attachEvent) {
    window.attachEvent ("onload", initAdmActHistMngr);
	window.attachEvent ("onunload", finishAdmActHistMngr);
} else if (window.addEventListener ) {
    window.addEventListener ("load", initAdmActHistMngr, false);
	window.addEventListener ("unload", finishAdmActHistMngr, false);
} else {
    window.onload = initAdmActHistMngr;
	window.onunload = finishAdmActHistMngr;
}
</script>
</c:if>