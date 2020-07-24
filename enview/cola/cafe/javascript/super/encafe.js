SuperMngr = function() {
	//var offset = location.href.indexOf (location.host) + location.host.length;
	//this.m_contextPath = location.href.substring (offset, location.href.indexOf('/', offset + 1));
	this.m_contextPath = portalPage.getContextPath();
	this.m_ajax = new enview.util.Ajax();
	this.m_ajax.setContextPath (this.m_contextPath);
	this.m_pageNavi = new enview.util.PageNavigationUtil();
	this.m_checkBox = new enview.util.CheckBoxUtil();
}
SuperMngr.prototype = {
	m_ajax : null,
	m_pageNavi : null,
	m_tree : null,
	m_contextPath : null,
	m_checkBox : null,
	m_msgBox : null,
	m_closeReasonGetter : null,
	m_cateTreeCtxtMenu : null,
	// m_boardChooser : null,
	// m_cateChooser : null,
	// m_passwordGetter : null,
	// m_deleteBoardHandler : null,
	// m_bltnCateMngr : null,
	// m_multiLangMngr : null,
	// m_actnMngr : null,
	// m_scrnMngr : null,
	// m_authMngr : null,
	// m_bojoMngr : null,
	// m_extnMngr : null,
	// m_bltnMngr : null,
	// m_roleChooser : null,
	// m_groupChooser : null,
	// m_userChooser : null,
	m_basePropMngr : null,
	m_TplMngr : null,
	m_selectRowIndex : -1,

	init : function (node) {
//		this.m_cateTreeCtxtMenu = treeCtxtMenu = new ContextMenu(this.m_contextPath);
		// context menu
		this.m_dhtmlxContextMenu = new dhtmlXMenuObject();
		this.m_dhtmlxContextMenu.renderAsContextMenu();
		this.m_dhtmlxContextMenu.attachEvent("onClick",this.onDhtmlxContextClick);
		this.m_dhtmlxContextMenu.loadFromHTML("dhtmlx_context_data", true);
		

		this.m_tree = new dhtmlXTreeObject (document.getElementById('superCateTree'),"100%","100%",0);
		this.m_tree.setImagePath (this.m_contextPath+"/board/images/tree/");
		this.m_tree.setOnClickHandler (this.onNodeSelect);
		this.m_tree.enableDragAndDrop (true)
		this.m_tree.setDropHandler (this.onNodeDrop);
		this.m_tree.enableContextMenu(this.m_dhtmlxContextMenu);

		this.m_tree.enableAutoTooltips (true);
		
		
		//this.m_tree.setChildCalcMode (true);
		//this.m_tree.enableItemEditor (true);
		//this.m_tree.setOnEditHandler (this.onEditHandler);
		//this.m_tree.enableKeyboardNavigation (true);
		this.m_tree.setXMLAutoLoading (this.m_contextPath+"/board/adCate.brd?m=catebaseTree"); 
		this.m_tree.loadXML (this.m_contextPath+"/board/adCate.brd?m=catebaseTree&id=3&act=root");
		
		$(function() {
			$("#superPropTabs").tabs();
			$("#cateTabs").tabs();
		});
	},
	
	onDhtmlxContextClick : function (menuitemId, type) {
		var itemId = superMngr.m_tree.contextID;
		
		if (menuitemId == "onRefresh") {
			superMngr.onRefresh( itemId)
		} else if (menuitemId == "onCreate") {
			superMngr.onCreateCate( itemId)
		} else if (menuitemId == "onMoveUp") {
			superMngr.onMoveUpCate( itemId);
		} else if (menuitemId == "onMoveDown") {
			superMngr.onMoveDownCate( itemId);
		} else if (menuitemId == "onModify") {
			superMngr.onUpdateCate( itemId);
		} else if (menuitemId == "onDelete") {
			superMngr.onDeleteCate( itemId);
		}
	},

	
	onContextMenuHandler : function (treeitemId, item) {
		superMngr.doShowContextMenu( treeitemId, item );
	},

	onCreateCate : function ( itemId) {
		superMngr.doCreateCate ( itemId);
	},
	onRefresh : function ( itemId) {
		superMngr.m_tree.refreshItem (itemId);
	},
	
	onDeleteCate : function( itemId) {
		if( confirm (ebUtil.getMessage("ev.info.success.delete"))) {
			superMngr.doDeleteCate( itemId);
		}
		return false;
	},
	onUpdateCate : function( itemId) {
		superMngr.doUpdateCate ( itemId);
	},
	
	onMoveUpCate : function( itemId) {
		superMngr.onNodeDrop ( itemId, "U" );
	},

	onMoveDownCate : function( itemId) {
		superMngr.onNodeDrop (itemId, "D" );
	},
	onNodeDrop : function (dragId, dropId) {
		superMngr.doMoveCate (dragId, dropId);
	},
	onNodeSelect : function (id) {
		$("#cateTabs").tabs('select', 0);

		var srchForm = document.getElementById("superSearchForm");
		srchForm.pageNo.value = 1;
		document.getElementById("cate_cateId").disabled = false;
		document.getElementById("cate_cateId").value = id;
		document.getElementById("cate_cateId").disabled = true;
		document.getElementById("cate_cateNm").disabled = false;
		document.getElementById("cate_cateNm").value = superMngr.m_tree.getSelectedItemText();
		document.getElementById("cate_cateNm").disabled = true;
		document.getElementById("cate_btnSave").style.display = "none";
		
		superMngr.doRetrieve("cate");
	},
	doShowContextMenu : function( id, item ) {
		var pos = (new enview.util.Utility()).getAbsolutePosition( item );
		superMngr.onNodeSelect( id );
		this.m_cateTreeCtxtMenu.setItemId( id );
		this.m_cateTreeCtxtMenu.show( pos.getX()+45, pos.getY()+20 );
	},
	doPage : function (formName, pageNo) {
		superMngr.m_selectRowIndex = 0;
		var formElm = document.forms[ formName ];
	    formElm.elements["pageNo"].value = pageNo;
		
		superMngr.doRetrieve();
	},
	doRetrieve : function (cmd, view, pageNo) {
		var formElm = document.forms["superSearchForm"];
		if (cmd != null && cmd != "") formElm.elements["cmd"].value = cmd;
		cmd = formElm.elements["cmd"].value;
		if (view != null && view != "") formElm.elements["view"].value = view;
		view = formElm.elements["view"].value;

		var param = "";
		if (cmd == "cate") {
			
			param = "m=uiCafeList";
			param += "&cateId=" + this.m_tree.getSelectedItemId();
			formElm.elements["pageSize"].value = "10";

		} else if (cmd == "srch") {
			
			param = "m=uiCafeList";
			param += "&srchType=" + document.getElementById("cafe_srchType").value;
			param += "&srchKey=" + document.getElementById("cafe_srchKey").value;
			formElm.elements["pageSize"].value = "10";
		
		} else if (cmd == "func") {

			param = "m=uiCafeList";
			formElm.elements["pageSize"].value = "10";
		
		} else if (cmd == "bltn") {
			
			param = "m=uiBltnList";
			param += "&cmntNm="     + document.getElementById("bltn_srchCmntNm").value;
			param += "&boardNm="    + document.getElementById("bltn_srchBoardNm").value;
			param += "&srchType="   + ebUtil.getCheckedValues (document.getElementsByName("bltn_srchType"));
			param += "&srchKey="    + document.getElementById("bltn_srchKey").value;
			param += "&srchBgnReg=" + document.getElementById("bltn_srchBgnReg").value;
			param += "&srchEndReg=" + document.getElementById("bltn_srchEndReg").value;
			formElm.elements["pageSize"].value = document.getElementById("bltn_pageSize").value;
		
		} else if (cmd == "memo") {
		
			param = "m=uiMemoList";
			param += "&cmntNm="     + document.getElementById("memo_srchCmntNm").value;
			param += "&boardNm="    + document.getElementById("memo_srchBoardNm").value;
			param += "&srchType="   + ebUtil.getCheckedValues (document.getElementsByName("memo_srchType"));
			param += "&srchKey="    + document.getElementById("memo_srchKey").value;
			param += "&srchBgnReg=" + document.getElementById("memo_srchBgnReg").value;
			param += "&srchEndReg=" + document.getElementById("memo_srchEndReg").value;
			formElm.elements["pageSize"].value = document.getElementById("memo_pageSize").value;
		}
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/ad.cafe", ebUtil.completeParam(formElm,param), true, {success: function(htmlData) { superMngr.doRetrieveHandler(htmlData); }});
	},
	doRetrieveHandler : function (htmlData) {
		document.getElementById("superListDiv").innerHTML = htmlData;

		var formElm = document.forms["superSearchForm"];
		var pageNo       = formElm.elements["pageNo"].value;
		var pageSize     = formElm.elements["pageSize"].value;
		var pageFunction = formElm.elements["pageFunction"].value;
		var formName     = formElm.elements["formName"].value;
		
		var cmd = formElm.elements["cmd"].value;
		var totalSize = document.forms["superListForm"].elements["superList_totalSize"].value;
		document.getElementById("SUPER_PAGE_ITERATOR").innerHTML = this.m_pageNavi.getPageIteratorHtmlStringCafe (pageNo, pageSize, totalSize, formName, pageFunction);
		if (totalSize > 0) {
			//if (this.m_selectRowIndex == -1) {
				this.m_selectRowIndex = 0;
			//} else {
			//	if (this.m_selectRowIndex >= totalSize) {
			//		this.m_selectRowIndex = totalSize - 1;
			//	}
			//}				
			superMngr.doDefaultSelect();
		} else {
			this.m_selectRowIndex = -1;
			document.getElementById("superDetailDiv").innerHTML = "";
		}
	},
	doDefaultSelect : function () {
		if( document.getElementById('superList'+this.m_selectRowIndex+'_checkRow') ) {
			document.getElementById('superList'+this.m_selectRowIndex+'_checkRow').checked = true;
		}
		superMngr.getSelectedOne();
	},
	doSelect : function (obj) {
		if (obj.type == "checkbox" && obj.id.indexOf("checkRow") > -1) {
			this.m_selectRowIndex = obj.parentNode.parentNode.getAttribute("ch");
		} else {
			this.m_selectRowIndex = obj.parentNode.getAttribute("ch");
		}
		this.m_checkBox.unChkAll( document.getElementById("superListForm"));
		document.getElementById('superList'+this.m_selectRowIndex+'_checkRow').checked = true;
		superMngr.getSelectedOne();
	},
	getSelectedOne : function () {

		var param = "m=uiCafeDetail"

		var cmd = document.superSearchForm.cmd.value;
		if (cmd == "bltn") {
			param += "&boardId=" + document.getElementById("superList"+this.m_selectRowIndex+"_boardId").value;
			param += "&bltnNo="  + document.getElementById("superList"+this.m_selectRowIndex+"_bltnNo").value;
		} else if (cmd == "memo") {
			param += "&boardId=" + document.getElementById("superList"+this.m_selectRowIndex+"_boardId").value;
			param += "&bltnNo="  + document.getElementById("superList"+this.m_selectRowIndex+"_bltnNo").value;
			param += "&memoSeq=" + document.getElementById("superList"+this.m_selectRowIndex+"_memoSeq").value;
		} else {
			param += "&cmntId=" + document.getElementById("superList"+this.m_selectRowIndex+"_cmntId").value;
		}
		param += "&cmd="    + document.forms["superSearchForm"].elements["cmd"].value;
		param += "&view="   + document.forms["superSearchForm"].elements["view"].value;
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/ad.cafe", param, true, {success: function(htmlData) { superMngr.getSelectedOneHandler(htmlData); }});
	},
	getSelectedOneHandler : function (htmlData) {
		document.getElementById("superDetailDiv").innerHTML = htmlData;
	},
	doShowBulletin : function (elm) {
		var frm = document.goHomeForm;
		frm.boardId.value = elm.getAttribute("boardId");
		frm.bltnNo.value  = elm.getAttribute("bltnNo");
		frm.action = this.m_contextPath+"/cafe/"+elm.getAttribute("cmntUrl");
		frm.submit();
	},
	onSelectLeft : function (flag) {
		var elms = document.getElementsByName("leftSub");
		for (var i=0; i<elms.length; i++) {
			if (elms[i].getAttribute("opt") == flag) {
				elms[i].style.display = "";
			} else {
				elms[i].style.display = "none";
			}
		}
		document.superSearchForm.pageNo.value = "1"; // 좌측메뉴가 눌리므로 페이지를 초기화한다.
		superMngr.doRetrieve(flag);
	},
	searchCafe : function () {
		var elm = document.getElementById("cafe_srchKey");
		if (elm.value == "") {
			alert("검색어를 입력하십시오");
			elm.focus();
			return;
		}
		superMngr.doRetrieve("srch");
	},
	listCafe : function (view) {
		document.superSearchForm.pageNo.value = 1;
		superMngr.doRetrieve("func",view);
	},
	searchBltn : function () {
		var srchType = ebUtil.getCheckedValues(document.getElementsByName("bltn_srchType"));
		var srchKeyElm = document.getElementById("bltn_srchKey");
		if ( !(srchType.isEmpty()) && srchType.indexOf("RegD") == -1 && srchKeyElm.value.isEmpty()) {
			alert("검색어를 입력하십시오");
			srchKeyElm.focus();
			return;
		}
		superMngr.doRetrieve("bltn");
	},
	searchMemo : function () {
		var srchType = ebUtil.getCheckedValues(document.getElementsByName("memo_srchType"));
		var srchKeyElm = document.getElementById("memo_srchKey");
		if ( !(srchType.isEmpty()) && srchType.indexOf("RegD") == -1 && srchKeyElm.value.isEmpty()) {
			alert("검색어를 입력하십시오");
			srchKeyElm.focus();
			return;
		}
		superMngr.doRetrieve("memo");
	},
	process : function (flag, reason, remark) {
		this.m_processFlag = flag;
		if (flag == "cafeHome") {
		
			//window.open (this.m_contextPath+"/cafe/"+document.getElementById("superList"+this.m_selectRowIndex+"_cmntUrl").value, "_blank");
			var frm = document.goHomeForm;
			frm.action = this.m_contextPath+"/cafe/"+document.getElementById("superList"+this.m_selectRowIndex+"_cmntUrl").value;
			frm.submit();
		
		} else if (flag == "cafeJigi") {
		
			var frm = document.goJigiForm;
			frm.cmntUrl.value = document.getElementById("superList"+this.m_selectRowIndex+"_cmntUrl").value;
			frm.action = this.m_contextPath+"/cafe/"+document.getElementById("superList"+this.m_selectRowIndex+"_cmntUrl").value;
			frm.submit();
		
		} else if (flag == "rcmdCafe") {
		
			if (!confirm ("선택된 카페를 추천카페 목록에 추가하시겠습니까?")) return;
			var param = "m=setRcmdCafe";
			param += "&cmd=ins";
			param += "&cmntId=" + document.getElementById("superList"+this.m_selectRowIndex+"_cmntId").value;
			this.m_ajax.send("POST", this.m_contextPath+"/cafe/ad.cafe", param, true, {success: function(data) { superMngr.processHandler(data); }});
		
		} else if (flag == "rcmd-delete") {

			if (!confirm ("선택된 카페를 추천카페 목록에서 제거하시겠습니까?")) return;
			var param = "m=setRcmdCafe";
			param += "&cmd=del";
			param += "&cmntId=" + document.getElementById("superList"+this.m_selectRowIndex+"_cmntId").value;
			this.m_ajax.send("POST", this.m_contextPath+"/cafe/ad.cafe", param, true, {success: function(data) { superMngr.processHandler(data); }});
		
		} else if (flag == "rcmd-reorder") {
		
			if (!confirm ("선택된 카페의 추천목록 순서를 변경하시겠습니까?")) return;
			if (!ebUtil.chkValue(document.getElementById("cafeDetail_favorOrder"), "추천 목록 순서를", "true")) return;
			if (!ebUtil.chkNum(document.getElementById("cafeDetail_favorOrder"), "추천 목록 순서에", "true")) return;
			var param = "m=setRcmdCafe";
			param += "&cmd=upd";
			param += "&cmntId="     + document.getElementById("superList"+this.m_selectRowIndex+"_cmntId").value;
			param += "&favorOrder=" + document.getElementById("cafeDetail_favorOrder").value;
			this.m_ajax.send("POST", this.m_contextPath+"/cafe/ad.cafe", param, true, {success: function(data) { superMngr.processHandler(data); }});
			
		} else if (flag == "permit") {
		
			if (!confirm ("선택된 카페의 개설요청을 승인하시겠습니까?")) return;
			var param = "m=setCafeState";
			param += "&cmd=" + flag;
			param += "&cmntId=" + document.getElementById("superList"+this.m_selectRowIndex+"_cmntId").value;
			this.m_ajax.send("POST", this.m_contextPath+"/cafe/ad.cafe", param, true, {success: function(data) { superMngr.processHandler(data); }});
		
		} else if (flag == "force") {
			
			if (!confirm ("선택된 카페를 강제로 폐쇄하시겠습니까?")) return;
			var param = "m=setCafeState";
			param += "&cmd=" + flag;
			param += "&cmntId=" + document.getElementById("superList"+this.m_selectRowIndex+"_cmntId").value;
			param += "&closeReason=" + reason;
			param += "&closeRemark=" + remark;
			this.m_ajax.send("POST", this.m_contextPath+"/cafe/ad.cafe", param, true, {success: function(data) { superMngr.processHandler(data); }});
		
		} else if (flag == "unclose") {
			
			if (!confirm ("선택된 카페의 폐쇄를 해제하시겠습니까??")) return;
			var param = "m=setCafeState";
			param += "&cmd=" + flag;
			param += "&cmntId=" + document.getElementById("superList"+this.m_selectRowIndex+"_cmntId").value;
			this.m_ajax.send("POST", this.m_contextPath+"/cafe/ad.cafe", param, true, {success: function(data) { superMngr.processHandler(data); }});
		
		} else if (flag == "delete") {
			
			if (!confirm ("경고!. 카페상태와 관계 없이 카페와 연관된 모든 데이터(게시판 데이터 포함)를 삭제합니다. 삭제하시겠습니까?")) return;
			if (!confirm ("정말 정말 삭제하시겠습니까?")) return;
			var param = "m=setDeleteCafe";
			param += "&cmntUrl=" + document.getElementById("superList"+this.m_selectRowIndex+"_cmntUrl").value;
			this.m_ajax.send( "POST", this.m_contextPath+"/cafe/home.cafe", param, true, {success: function(data) { superMngr.processHandler(data); }});
		
		} else if (flag == "delete-bltn") {
			
			if (!confirm ("정말 정말 삭제하시겠습니까?")) return;
			var param = "m=setDeleteBltn";
			param += "&boardId=" + document.getElementById("superList"+this.m_selectRowIndex+"_boardId").value;
			param += "&bltnNo="  + document.getElementById("superList"+this.m_selectRowIndex+"_bltnNo").value;
			this.m_ajax.send( "POST", this.m_contextPath+"/cafe/ad.cafe", param, true, {success: function(data) { superMngr.processHandler(data); }});
		
		} else if (flag == "delete-memo") {
			
			if (!confirm ("정말 정말 삭제하시겠습니까?")) return;
			var param = "m=setDeleteMemo";
			param += "&boardId=" + document.getElementById("superList"+this.m_selectRowIndex+"_boardId").value;
			param += "&bltnNo="  + document.getElementById("superList"+this.m_selectRowIndex+"_bltnNo").value;
			param += "&memoSeq=" + document.getElementById("superList"+this.m_selectRowIndex+"_memoSeq").value;
			this.m_ajax.send( "POST", this.m_contextPath+"/cafe/ad.cafe", param, true, {success: function(data) { superMngr.processHandler(data); }});
		}
	},
	processHandler : function (data) {
		if (this.m_processFlag == "permit") {
			superMngr.getMsgBox().doShow ("개설승인이 정상적으로 처리되었습니다.");
		} else if (this.m_processFlag == "force") {
			superMngr.getMsgBox().doShow ("강제폐쇄가 정상적으로 처리되었습니다.");
		} else if (this.m_processFlag == "unclose") {
			superMngr.getMsgBox().doShow ("폐쇄해제가 정상적으로 처리되었습니다.");
		} else if (this.m_processFlag == "delete") {
			superMngr.getMsgBox().doShow ("카페삭제가 정상적으로 처리되었습니다.");
		} else if (this.m_processFlag == "delete-bltn") {
			superMngr.getMsgBox().doShow ("게시물 삭제가 정상적으로 처리되었습니다.");
		} else if (this.m_processFlag == "delete-memo") {
			superMngr.getMsgBox().doShow ("댓글(메모) 삭제가 정상적으로 처리되었습니다.");
		} else if (this.m_processFlag == "rcmdCafe") {
			superMngr.getMsgBox().doShow ("카페 추천이 정상적으로 처리되었습니다.");
		} else if (this.m_processFlag == "rcmd-delete") {
			superMngr.getMsgBox().doShow ("카페 추천 취소가 정상적으로 처리되었습니다.");
		}
		
		superMngr.doRetrieve(); // 화면데이터 갱신.

	},
	doDeleteCate : function ( itemId ) {
		document.getElementById("cate_act").value = "del";
		superMngr.doSaveCate();
	},
	doMoveCate : function( dragId, dropId ) {
		var param = "m=setCatebaseMove";

		param += "&dragId=" + dragId;
		param += "&dropId=" + dropId;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { superMngr.doMoveCateHandler( data ); }});
	},
	doMoveCateHandler : function( data ) {
		superMngr.getMsgBox().doShow( ebUtil.getMessage("mm.info.move.success"));
		//superMngr.m_cateTreeCtxtMenu.hide();
		this.m_tree.refreshItem( data.refreshId );
		this.m_tree.selectItem ( data.refreshId, true, false );
		this.m_tree.openItem   ( data.refreshId );
		//superMngr.onNodeSelect( data.refreshId );
	},
	onSelectCateTabs : function( id ) {
		if (id == 2) {
			document.getElementById("superCateLangTab").style.display = "";
			document.getElementById("superCateLangEditPage").style.display = "none";
			superMngr.doRetrieveCateLang();
		}
	},
	doRetrieveCateLang : function () {
		var param = "m=catebaseLangList";
		param += "&cateId=" + document.getElementById("cate_cateId").value;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { superMngr.doRetrieveCateLangHandler( data ); }});
	},
	doRetrieveCateLangHandler : function( data ) {
		var bodyElem = document.getElementById ('superCateLangListBody');
	    var tagTR = null;
	    var tagTD = null;

		this.m_checkBox.unChkAll( document.getElementById( "superCateLangListForm"));
		for (; bodyElem.hasChildNodes(); )
			bodyElem.removeChild (bodyElem.childNodes[0]);
		if( data.Data.length > 0 ) {
			document.getElementById("cateLangList_cateId").value = data.Data[0].cateId;
		}
		for( i=0; i<data.Data.length; i++ ) {
			tagTR = document.createElement( 'tr' );
			tagTR.id = "cateLangList"+i;
			tagTR.onmouseover = new Function( "ebUtil.activeLine(this,true)" );
			tagTR.onmouseout = new Function( "ebUtil.activeLine(this,false)" );
			tagTR.setAttribute ("ch", i);
			tagTR.setAttribute ("style", "cursor:pointer;");
			if (i % 2 == 1) {
				tagTR.setAttribute("class", "adgridline");
				tagTR.setAttribute("className", "adgridline");
			}
			
			tagTD = document.createElement( 'td' );
			tagTD.align = "center";
			tagTD.setAttribute( "class", "adgrid" );
			tagTD.setAttribute( "className", "adgrid" );
			tagTD.innerHTML = "<input type='checkbox' id='cateLangList_checkRow' name='cateLangList_checkRow' value='"+data.Data[i].langKnd+"' class='webcheckbox'/>";
		 	tagTR.appendChild( tagTD );
			
			tagTD = document.createElement('td');
			tagTD.setAttribute( "class", "adgrid" );
			tagTD.setAttribute( "className", "adgrid" );
			tagTD.align = "left";
			tagTD.onclick = new Function( "superMngr.doSelectCateLang('"+data.Data[i].langKnd+"','"+data.Data[i].cateNm+"')" );
			tagTD.innerHTML = "<span id='cateLangList"+i+".langKnd.label'>" + data.Data[i].langKnd + "</span>";
			tagTR.appendChild( tagTD );
			
			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "adgrid");
			tagTD.setAttribute("className", "adgrid");
			tagTD.align = "left";
			tagTD.onclick = new Function( "superMngr.doSelectCateLang('"+data.Data[i].langKnd+"','"+data.Data[i].cateNm+"')" );
			tagTD.innerHTML = "<span id='cateLangList"+i+".cateNm.label'>" + data.Data[i].cateNm + "</span>";
			tagTR.appendChild( tagTD );

			bodyElem.appendChild (tagTR);
		}
		tagTR = document.createElement( 'tr' );
		tagTD = document.createElement( 'td' );
		tagTD.height = "2";
		tagTD.colSpan = "3";
		tagTD.setAttribute("class", "adgridlimit");
		tagTD.setAttribute("className", "adgridlimit");
		tagTR.appendChild( tagTD );
		bodyElem.appendChild (tagTR);
	},
	doCreateCate : function (itemId) {
		document.getElementById("cate_act").value = "ins";
		document.getElementById("cate_cateId").value = "입력하지 않음";
		document.getElementById("cate_cateNm").value = "";
		document.getElementById("cate_cateNm").disabled = false;
		document.getElementById("cate_btnSave").style.display = "";
		document.getElementById("cate_cateNm").focus();
	},
	doUpdateCate : function ( itemId ) {
		document.getElementById("cate_act").value = "upd";
		document.getElementById("cate_cateNm").disabled = false;
		document.getElementById("cate_btnSave").style.display = "";
		document.getElementById("cate_cateNm").focus();
	},
	doSaveCate : function() {
		if( !ebUtil.chkValue( document.getElementById("cate_cateNm"), "카테고리 명을", true )) return;
		var param = "m=setCatebase";
		param += "&act=" + document.getElementById("cate_act").value;
		param += "&cateId=" + superMngr.m_tree.getSelectedItemId();
		param += "&cateNm=" + encodeURIComponent( document.getElementById("cate_cateNm").value);
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { superMngr.doSaveCateHandler( data ); }});
	},
	doSaveCateHandler : function( data ) {
		var act = document.getElementById("cate_act").value;
		if( act == "ins" ) {
			superMngr.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.add"));
		} else if( act == "upd" ) {
			superMngr.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.update"));
		} else {
			superMngr.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.delete"));
		}
		//superMngr.m_cateTreeCtxtMenu.hide();
		var refreshId = data.refreshId;
		this.m_tree.refreshItem( data.refreshId );
		this.m_tree.selectItem ( data.refreshId, true, false );
		this.m_tree.openItem   ( data.refreshId );
		//superMngr.onNodeSelect( data.refreshId );
	},
	doCreateCateLang : function() {
		document.getElementById("superCateLangEditPage").style.display = "";
		document.getElementById("cateLang_act").value = "ins"; 
		document.getElementById("cateLang_cateId").value = this.m_tree.getSelectedItemId();
		document.getElementById("cateLang_langKnd").disabled = false;
		document.getElementById("cateLang_langKnd").value = "";
		document.getElementById("cateLang_cateNm").value = "";
		document.getElementById("cateLang_langKnd").focus();
	},
	doSelectCateLang : function( langKnd, cateNm ) {
		document.getElementById("superCateLangEditPage").style.display = "";
		document.getElementById("cateLang_act").value = "upd"; 
		document.getElementById("cateLang_cateId").value = this.m_tree.getSelectedItemId();
		document.getElementById("cateLang_langKnd").value = langKnd;
		document.getElementById("cateLang_langKnd").disabled = true;
		document.getElementById("cateLang_cateNm").value = cateNm;
		document.getElementById("cateLang_cateNm").focus();
	},
	doDeleteCateLang : function() {
		document.getElementById("cateLang_act").value = "del"; 
		if( !ebUtil.chkCheck( document.getElementsByName("cateLangList_checkRow"), '언어를', true )) return;

		var param = "m=setCatebaseLang";
		param += "&act=" + document.getElementById("cateLang_act").value;
		param += "&cateId=" + document.getElementById("cateLangList_cateId").value;
		param += "&langKnd=" + ebUtil.getCheckedValues( document.getElementsByName("cateLangList_checkRow"));
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { superMngr.doSaveCateLangHandler( data ); }});
	},
	doSaveCateLang : function() {
		if( "ins" == document.getElementById("cateLang_act")) {
			if( !ebUtil.chkSelect( document.getElementById("cateLang_langKnd"), 1, "언어를", 'true')) return;
		}
		if( !ebUtil.chkValue( document.getElementById("cateLang_cateNm"), "카테고리 명을", 'true')) return;
		
		var param = "m=setCatebaseLang";
		param += "&act=" + document.getElementById("cateLang_act").value;
		param += "&cateId=" + document.getElementById("cateLang_cateId").value;
		param += "&langKnd=" + ebUtil.getSelectedValue( document.getElementById("cateLang_langKnd"));
		param += "&cateNm=" + encodeURIComponent( document.getElementById("cateLang_cateNm").value);
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { superMngr.doSaveCateLangHandler( data ); }});
	},
	doSaveCateLangHandler : function(data) {
		var act = document.getElementById("cateLang_act").value;
		if( act == "ins" ) {
			superMngr.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.add"));
		} else if( act == "upd" ) {
			superMngr.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.update"));
		} else if( act == "del" ) {
			superMngr.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.delete"));
		}
		document.getElementById("superCateLangEditPage").style.display = "none";
		superMngr.doRetrieveCateLang();
	},
	getBPMngr : function () {
		if (this.m_basePropMngr) return this.m_basePropMngr;
		this.m_basePropMngr = new SuperMngr.BasePropMngr(this);
		return this.m_basePropMngr;
	},
	getTplMngr : function () {
		if (this.m_TplMngr) return this.m_TplMngr;
		this.m_TplMngr = new SuperMngr.TplMngr(this);
		return this.m_TplMngr;
	},
	getMsgBox : function() {
		if (this.m_msgBox == null) {
			if (enviewMessageBox == null) {
				enviewMessageBox = new enview.portal.MessageBox(300, 120, 1000);
			}
			this.m_msgBox = enviewMessageBox;
		}
		return this.m_msgBox
	},
	getCloseReasonGetter : function() {
		if (this.m_closeReasonGetter) return this.m_closeReasonGetter;
		this.m_closeReasonGetter = new SuperMngr.CloseReasonGetter(this);
		return this.m_closeReasonGetter;
	},
	
	autoMakeCafe : function(){
		if(!confirm("부서마당을 생성하시겠습니까?")) return;
		var param = "m=autoMakeCafe";
		param += "&cateId=" + document.getElementById("cateId").value;
		this.m_ajax.send( "POST", this.m_contextPath+"/cafe/home.cafe", param, true, {
			success: function(data) { 
				superMngr.doSaveCateLangHandler( data ); 
			}
		});
	}
}
SuperMngr.CloseReasonGetter = function(parent) {
	this.m_elmArea = document.getElementById("closeReasonGetter");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	
	$("#closeReasonGetter").dialog({
		autoOpen: false,
		resizable: false,
		modal: true,
		buttons: {
			Close: function() {
				$(this).dialog("close");
			},
			Confirm: function() {
				superMngr.getCloseReasonGetter().confirm();
			}
		}
	});
}
SuperMngr.CloseReasonGetter.prototype = {
	m_elmArea : null,
	m_contextPath : null,
	
	doShow : function() {
		superMngr.getCloseReasonGetter().doGet();
		$('#closeReasonGetter').dialog('open');
	},
	doGet : function() {
		var param = "m=uiCloseReasonGetter";
		this.m_ajax.send("POST", this.m_contextPath+"/cafe/ad.cafe", param, true, {success: function(htmlData) { superMngr.getCloseReasonGetter().doGetHandler(htmlData); }});
	},
	doGetHandler : function(htmlData) {
		this.m_elmArea.innerHTML = htmlData;
	},
	confirm : function() {
		if (!ebUtil.chkCheck (document.getElementsByName("closeReasonGetter_closeReason"), "사유코드를", "true")) return;
		if (ebUtil.getCheckedValue (document.getElementsByName("closeReasonGetter_closeReason")) == "90") {
			if (!ebUtil.chkValue (document.getElementById("closeReasonGetter_closeRemark"), "기타 사유를", "true")) return;
			if (!ebUtil.chkLength (document.getElementById("closeReasonGetter_closeRemark"), "기타 사유", 600, "true")) return;
		}
		superMngr.process("force", ebUtil.getCheckedValue(document.getElementsByName("closeReasonGetter_closeReason")), document.getElementById("closeReasonGetter_closeRemark").value);
		$("#closeReasonGetter").dialog("close");
	}
}

SuperMngr.jQueryUtil = function(jQuerySelector){
	if($(jQuerySelector).length > 0) this.m_jQueryObject = $(jQuerySelector);
	else this.m_jQueryObject = null;
}

SuperMngr.jQueryUtil.prototype = {
	
	m_jQueryObject : null,
	
	attr : function(a,b){
		if(this.m_jQueryObject != null){
			if(b != undefined){
				this.m_jQueryObject.attr(a,b);
			}
			else {
				this.m_jQueryObject.attr(a);
			}
		}
	},
	
	css : function(c){
		if(this.m_jQueryObject != null){
			this.m_jQueryObject.css(c);
		}
	}
}


var treeCtxtMenu = null;
ContextMenu = function (contextPath) {
	$("#treeCtxtMenuDiv").dialog({
		autoOpen: false,
		width: "140px",
		resizable: false,
		draggable: false,
		modal: true,
		open: function(event, ui) { 
			$(".ui-dialog-titlebar-close").hide(); 
			//$("#treeCtxtMenuDiv").attr("style", "left:" + left);
			//$("#treeCtxtMenuDiv").attr("style", "top:" + top);
		}
	});
	this.init();
}
ContextMenu.prototype = {
	m_domElement : null,
	m_id : null,
	
	init : function() {
	},
	getItemId : function () {
		return this.m_id;
	},
	setItemId : function (id) {
		this.m_id = id;
	},
	show : function (left, top) {
		//alert(left + "," + top);
		$("#treeCtxtMenuDiv").dialog("option", "position", [left,top]);
		$("#treeCtxtMenuDiv").dialog("open");
	},
	hide : function() {
		$("#treeCtxtMenuDiv").dialog("close");
	},
	onMouseOver : function(obj) {
		obj.setAttribute("class", "contextMenu_itemOver");
		obj.setAttribute("className", "contextMenu_itemOver");
	},
	onMouseOut : function(obj) {
		obj.setAttribute("class", "contextMenu_item");
		obj.setAttribute("className", "contextMenu_item");
	}
}
SuperMngr.BasePropMngr = function (parent) {
	this.m_cafeArea  = document.getElementById("cafePropTab");
	this.m_boardArea = document.getElementById("boardPropTab");
	this.m_mcdArea = document.getElementById("mcdPropTab");
	this.m_mgrdArea = document.getElementById("mgrdPropTab");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_checkBox = parent.m_checkBox;
}
SuperMngr.BasePropMngr.prototype = {
	m_cafeArea : null,
	m_boardArea : null,
	m_mcdArea : null,
	m_mgrdArea : null,
	m_contextPath : null,
	m_checkBox : null,
	m_curView : null,
	m_curAct : null,
	m_selectRowIndex : null,

	init : function() {
		$("#basePropTabs").tabs();
		superMngr.getBPMngr().doGet("cafe");
	},
	doGet : function(view, act) {
		this.m_curView = view;
		this.m_curAct = act;
		var param = "m=uiBaseProp";
		param += "&view=" + this.m_curView;
		if (this.m_curView == "board.edit") {
			param += "&boardId=" + document.getElementById("boardList"+this.m_selectRowIndex+"_boardId").value;
		} else if (this.m_curView == "mcd.edit") {
			param += "&mileCd=" + document.getElementById("mcdList"+this.m_selectRowIndex+"_mileCd").value;
		} else if (this.m_curView == "mgrd.edit") {
			param += "&act=" + this.m_curAct;
			if (act != "ins") {
				param += "&code=" + document.getElementById("mgrdList"+this.m_selectRowIndex+"_code").value;
			}
		}
		this.m_ajax.send ("POST", this.m_contextPath+"/cafe/ad.cafe", param, true, {success: function(data) { superMngr.getBPMngr().doGetHandler(data); }});
	},
	doGetHandler : function (htmlData) {
		if (this.m_curView == "cafe") {
			this.m_cafeArea.innerHTML = htmlData;
		} else if (this.m_curView == "board.list") {
			this.m_boardArea.innerHTML = htmlData;
		} else if (this.m_curView == "mcd.list") {
			this.m_mcdArea.innerHTML = htmlData;
		} else if (this.m_curView == "mgrd.list") {
			this.m_mgrdArea.innerHTML = htmlData;
		} else if (this.m_curView == "board.edit") {
			document.getElementById("boardEditDiv").innerHTML = htmlData;
		} else if (this.m_curView == "mcd.edit") {
			document.getElementById("mcdEditDiv").innerHTML = htmlData;
		} else if (this.m_curView == "mgrd.edit") {
			document.getElementById("mgrdEditDiv").innerHTML = htmlData;
		}
	},
	doSelect : function (flag, obj) {
		this.m_selectRowIndex = obj.parentNode.getAttribute("ch");
		this.m_checkBox.unChkAll (document.getElementById (flag + "ListForm"));
		document.getElementById (flag + "List"+this.m_selectRowIndex+"_checkRow").checked = true;
		if (flag == "mgrd") {
			superMngr.getBPMngr().doGet (flag + ".edit", "upd");
		} else {
			superMngr.getBPMngr().doGet (flag + ".edit");
		}
	},
	doSave : function(view) {
		this.m_curView = view;
		var param = "";
		if (this.m_curView == "cafe") {
			param += "m=setCafeBase";
			param += "&cmntId="     + document.getElementById("base_cmntId").value;
			param += "&cmntState="  + ebUtil.getCheckedValue(document.getElementsByName("base_cmntState"));
			param += "&openYn="     + ebUtil.getCheckedValue(document.getElementsByName("base_openYn"));
			param += "&regType="    + ebUtil.getCheckedValue(document.getElementsByName("base_regType"));
			param += "&mmbrDefGrd=" + ebUtil.getSelectedValue(document.getElementById("base_mmbrDefGrd"));
			//param += "&mmbrGrdIcon=" + ebUtil.getCheckedValue(document.getElementsByName("base_mmbrGrdIcon"));
			param += "&cmntLevel="  + ebUtil.getSelectedValue(document.getElementById("base_cmntLevel"));
			//param += "&somoLimitCnt=" + document.getElementById("base_somoLimitCnt").value;
			param += "&nmType=" + ebUtil.getCheckedValue(document.getElementsByName("base_nmType"));
			//param += "&maxCpct=" + document.getElementById("base_maxCpct").value;
		} else if (this.m_curView == "board") {
			param += "m=setCafeBoardBase";
			param += "&boardId="     + document.getElementById("boardList"+this.m_selectRowIndex+"_boardId").value;
			param += "&replyYn="     + ebUtil.getCheckedValue(document.getElementsByName("board_replyYn"));
			param += "&memoYn="      + ebUtil.getCheckedValue(document.getElementsByName("board_memoYn"));
			param += "&memoReplyYn=" + ebUtil.getCheckedValue(document.getElementsByName("board_memoReplyYn"));
			param += "&memoBadYn="   + ebUtil.getCheckedValue(document.getElementsByName("board_memoBadYn"));
			param += "&srchAtchYn="  + ebUtil.getCheckedValue(document.getElementsByName("board_srchAtchYn"));
			param += "&srchRegYn="   + ebUtil.getCheckedValue(document.getElementsByName("board_srchRegYn"));
			param += "&ttlNoYn="     + ebUtil.getCheckedValue(document.getElementsByName("board_ttlNoYn"));
			param += "&ttlIconYn="   + ebUtil.getCheckedValue(document.getElementsByName("board_ttlIconYn"));
			param += "&ttlNewYn="    + ebUtil.getCheckedValue(document.getElementsByName("board_ttlNewYn"));
			param += "&ttlReplyYn="  + ebUtil.getCheckedValue(document.getElementsByName("board_ttlReplyYn"));
			param += "&ttlMemoYn="   + ebUtil.getCheckedValue(document.getElementsByName("board_ttlMemoYn"));
			param += "&ttlNickYn="   + ebUtil.getCheckedValue(document.getElementsByName("board_ttlNickYn"));
			param += "&ttlRegYn="    + ebUtil.getCheckedValue(document.getElementsByName("board_ttlRegYn"));
			param += "&ttlReadYn="   + ebUtil.getCheckedValue(document.getElementsByName("board_ttlReadYn"));
			param += "&noticeYn="    + ebUtil.getCheckedValue(document.getElementsByName("board_noticeYn"));
			if (!ebUtil.chkValue(document.getElementById("board_boardWidth"),"게시판 전체 너비를", "true")) return;
			if (!ebUtil.chkNum  (document.getElementById("board_boardWidth"),"게시판 전체 너비에", "true")) return;
			param += "&boardWidth="  + document.getElementById("board_boardWidth").value;
			if (!ebUtil.chkValue(document.getElementById("board_subjSize"),"제목 컬럼 너비를", "true")) return;
			if (!ebUtil.chkNum  (document.getElementById("board_subjSize"),"제목 컬럼 너비에", "true")) return;
			param += "&subjSize="    + document.getElementById("board_subjSize").value;
			if (!ebUtil.chkValue(document.getElementById("board_nickSize"),"작성자 컬럼 너비를", "true")) return;
			if (!ebUtil.chkNum  (document.getElementById("board_nickSize"),"작성자 컬럼 너비에", "true")) return;
			param += "&nickSize="    + document.getElementById("board_nickSize").value;
			param += "&boardSkin="   + ebUtil.getSelectedValue(document.getElementById("board_boardSkin"));
			/*
			if (!ebUtil.chkValue(document.getElementById("board_raiseColor"),"인기글 조회건수 색상을", "true")) return;
			param += "&raiseColor="  + document.getElementById("board_raiseColor").value;
			if (!ebUtil.chkValue(document.getElementById("board_raiseCnt"),"인기글 기준 조회건수를", "true")) return;
			if (!ebUtil.chkNum  (document.getElementById("board_raiseCnt"),"인기글 기준 조회건수에", "true")) return;
			param += "&raiseCnt="    + document.getElementById("board_raiseCnt").value;
			if (!ebUtil.chkValue(document.getElementById("board_newTerm"),"최신글 기준 경과시간을", "true")) return;
			if (!ebUtil.chkNum  (document.getElementById("board_newTerm"),"최신글 기준 경과시간에", "true")) return;
			*/
			
			param += "&newTerm="     + document.getElementById("board_newTerm").value;
			if (!ebUtil.chkValue(document.getElementById("board_listSetCnt"),"목록화면 목록수를", "true")) return;
			if (!ebUtil.chkNum  (document.getElementById("board_listSetCnt"),"목록화면 목록수에", "true")) return;
			param += "&listSetCnt="  + document.getElementById("board_listSetCnt").value;
			if (!ebUtil.chkValue(document.getElementById("board_badStdCnt"),"자동악플처리 기준 신고수를", "true")) return;
			if (!ebUtil.chkNum  (document.getElementById("board_badStdCnt"),"자동악플처리 기준 신고수에", "true")) return;
			param += "&badStdCnt="   + document.getElementById("board_badStdCnt").value;
			if (document.getElementById("board_maxFileCnt")) {
				if (!ebUtil.chkValue(document.getElementById("board_maxFileCnt"),"첨부파일 최대 개수를", "true")) return;
				if (!ebUtil.chkNum  (document.getElementById("board_maxFileCnt"),"첨부파일 최대 개수에", "true")) return;
				param += "&maxFileCnt="  + document.getElementById("board_maxFileCnt").value;
			}
			if (document.getElementById("board_maxFileSize")) {
				if (!ebUtil.chkValue(document.getElementById("board_maxFileSize"),"첨부파일 최대 크기를", "true")) return;
				if (!ebUtil.chkNum  (document.getElementById("board_maxFileSize"),"첨부파일 최대 크기에", "true")) return;
				param += "&maxFileSize=" + document.getElementById("board_maxFileSize").value;
			}
		} else if (this.m_curView == "mcd") {
			param += "m=setCafeMileBase";
			param += "&mileCd="     + document.getElementById("mcdList"+this.m_selectRowIndex+"_mileCd").value;
			param += "&mileActive=" + ebUtil.getCheckedValue(document.getElementsByName("mcd_mileActive"));
			param += "&mileIo="     + ebUtil.getCheckedValue(document.getElementsByName("mcd_mileIo"));
			if (ebUtil.getCheckedValue(document.getElementsByName("mcd_mileActive")) == "Y") {
				if (!ebUtil.chkValue(document.getElementById("mcd_milePnt"), "점수를", "true")) return;
			}
			if (!ebUtil.chkNum (document.getElementById("mcd_milePnt"), "점수에", "true")) return;
			param += "&milePnt="    + document.getElementById("mcd_milePnt").value;
			param += "&mileSttg="   + ebUtil.getCheckedValue(document.getElementsByName("mcd_mileSttg"));
			if (ebUtil.getCheckedValue(document.getElementsByName("mcd_mileActive")) == "Y"
			 && ebUtil.getCheckedValue(document.getElementsByName("mcd_mileSttg")) == "Y") {
				if (!ebUtil.chkNum (document.getElementById("mcd_tlimitCnt"), "시간별 횟수 제한에", "true")) return;
				if (!ebUtil.chkNum (document.getElementById("mcd_dlimitCnt"), "일별 횟수 제한에", "true")) return;
				if (!ebUtil.chkNum (document.getElementById("mcd_wlimitCnt"), "주별 횟수 제한에", "true")) return;
				if (!ebUtil.chkNum (document.getElementById("mcd_mlimitCnt"), "월별 횟수 제한에", "true")) return;
				if (!ebUtil.chkNum (document.getElementById("mcd_ylimitCnt"), "년별 횟수 제한에", "true")) return;
				var tCnt = document.getElementById("mcd_tlimitCnt").value;
				var dCnt = document.getElementById("mcd_dlimitCnt").value;
				var wCnt = document.getElementById("mcd_wlimitCnt").value;
				var mCnt = document.getElementById("mcd_mlimitCnt").value;
				var yCnt = document.getElementById("mcd_ylimitCnt").value;
				if ((tCnt == null || tCnt.length == 0 || tCnt == '0') && (dCnt == null || dCnt.length == 0 || dCnt == '0') && (wCnt == null || wCnt.length == 0 || wCnt == '0') 
				 && (mCnt == null || mCnt.length == 0 || mCnt == '0') && (yCnt == null || yCnt.length == 0 || yCnt == '0')) {
					alert("정책을 사용하시려면 하나 이상의 횟수 제한을 입력하십시오");
					return;
				}
				param += "&tlimitCnt="  + tCnt;
				param += "&dlimitCnt="  + dCnt;
				param += "&wlimitCnt="  + wCnt;
				param += "&mlimitCnt="  + mCnt;
				param += "&ylimitCnt="  + yCnt;
			}
			if (!ebUtil.chkValue(document.getElementById("mcd_mileNm"), "마일리지 명을", "true")) return;
			param += "&mileNm="     + document.getElementById("mcd_mileNm").value;
			param += "&mileRem="    + document.getElementById("mcd_mileRem").value;
		} else if (this.m_curView == "mgrd") {
			param += "m=setCafeMGrdBase";
			param += "&act="      + this.m_curAct;
			param += "&code="     + document.getElementById("mgrd_code").value;
			if (!ebUtil.chkValue (document.getElementById("mgrd_codeName"), "등급명을", "true")) return;
			param += "&codeName=" + document.getElementById("mgrd_codeName").value;
		}
		this.m_ajax.send ("POST", this.m_contextPath+"/cafe/ad.cafe", param, true, {success: function(data) { superMngr.getBPMngr().doSaveHandler(data); }});
	},
	doSaveHandler : function(data) {
		superMngr.getMsgBox().doShow(ebUtil.getMessage("ev.info.success.update"));
		if (this.m_curView == "mgrd") {
			superMngr.getBPMngr().doGet("mgrd.list");
		}
	},
	doMGrdDelete : function() {
		this.m_curAct = "del";
		if (confirm( ebUtil.getMessage("ev.info.remove"))) {
			var param = "m=setCafeMGrdBase";
			param += "&act="  + this.m_curAct;
			param += "&code=" + document.getElementById("mgrdList"+this.m_selectRowIndex+"_code").value;
			this.m_ajax.send ("POST", this.m_contextPath+"/cafe/ad.cafe", param, true, {success: function(data) { superMngr.getBPMngr().doMGrdSaveHandler(data); }});
		}
	},
	doMGrdUp : function (idx) {
		this.m_curAct = "up";
		var param = "m=setCafeMGrdBase";
		param += "&act="  + this.m_curAct;
		param += "&code=" + document.getElementById("mgrdList"+idx+"_code").value;
		
		this.m_ajax.send ("POST", this.m_contextPath+"/cafe/ad.cafe", param, true, {success: function(data) { superMngr.getBPMngr().doMGrdSaveHandler(data); }});
	},
	doMGrdDown : function (idx) {
		this.m_curAct = "down";
		var param = "m=setCafeMGrdBase";
		param += "&act="  + this.m_curAct;
		param += "&code=" + document.getElementById("mgrdList"+idx+"_code").value;
		
		this.m_ajax.send ("POST", this.m_contextPath+"/cafe/ad.cafe", param, true, {success: function(data) { superMngr.getBPMngr().doMGrdSaveHandler(data); }});
	},
	doMGrdSaveHandler : function() {
		if (this.m_curAct == "del") {
			superMngr.getMsgBox().doShow (ebUtil.getMessage("ev.info.success.delete"));
		} else if (this.m_curAct == "up" || this.m_curAct == "down") {
			superMngr.getMsgBox().doShow(ebUtil.getMessage("ev.info.success.update"));
		}
		superMngr.getBPMngr().doGet("mgrd.list");
	}
}


SuperMngr.TplMngr = function (parent) {
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_checkBox = parent.m_checkBox;
}
SuperMngr.TplMngr.prototype = {
	m_contextPath : null,
	m_curDecoType : null,
	m_curView : null,
	m_curAct : null,
	m_selectRowIndex : null,
	m_iconKind : null,
	m_tplName : null, 
	
	init : function() {
		superMngr.getTplMngr().doGet("CF0101", "list");
	},
	
	uiCreate : function() {
		this.m_curView = "new";
		var param = "m=uiTplMng";
		param += "&decoType=" + this.m_curDecoType;
		param += "&view=" + this.m_curView;
		this.m_ajax.send ("POST", this.m_contextPath+"/cafe/ad.cafe", param, true, {success: function(data) { superMngr.getTplMngr().uiCreateHandler(data); }});
	},
	uiCreateHandler : function (htmlData) {
		document.getElementById("tplEditDiv").innerHTML = htmlData;
		
		$('#tplImgSize').html($('#' + this.m_curDecoType + '_tplImg_img').css('width') +', ' + $('#' + this.m_curDecoType + '_tplImg_img').css('height'));
		$('#bgImgSize').html($('#' + this.m_curDecoType + '_bgImage_img').css('width') +', ' + $('#' + this.m_curDecoType + '_bgImage_img').css('height'));
		$('#myInfoImgSize').html($('#' + this.m_curDecoType + '_myInfoButton_img').css('width') +', ' + $('#' + this.m_curDecoType + '_myInfoButton_img').css('height'));
		$('#srchImgSize').html($('#' + this.m_curDecoType + '_srchBtn_img').css('width') +', ' + $('#' + this.m_curDecoType + '_srchBtn_img').css('height'));
	},
	doCreate : function(){
		var param = "m=setDecoInfoPrefs";
		param += "&decoType=" + this.m_curDecoType;
		param += "&view=new";
		param += "&act=create";
		param += "&decoId=" + $('#decoId').val();
		
		$('.tplmngr_pref_input').each(function(){
			var $this = $(this);
			var clazz = $this.attr('id');
			var value = '';
			if($('#' + clazz + '_set').val().indexOf(",") > -1){
				var temp = $this.val().split(",");
				value = $('#' + clazz + '_set').val();
				for(var i = 0 ; i < temp.length; i++){
					value = value.replace("_val" + (i == 0 ? '' : i+1) + "_", temp[i]);	
				}
			}else {
				value = $('#' + clazz + '_set').val().replace("_val_", $this.val());	
			}
			param += "&" + clazz + "=" + value;
		});
		this.m_ajax.send ("POST", this.m_contextPath+"/cafe/ad.cafe", param, true, {success: function(data) { superMngr.getTplMngr().doGet(superMngr.getTplMngr().m_curDecoType, "list"); }});
	},
	
	doDelete : function() {
		this.m_curView = "list";
		if(!confirm("정말 삭제하시겠습니까?")) return;
		var param = "m=uiTplMng";
		param += "&decoType=" + this.m_curDecoType;
		param += "&decoId=" + $('#decoId').val();
		param += "&view=" + this.m_curView;
		param += "&act=delete";
		this.m_ajax.send ("POST", this.m_contextPath+"/cafe/ad.cafe", param, true, {success: function(data) { superMngr.getTplMngr().doGetHandler(data); }});
	},
	
	doPage : function (formName, pageNo) {
		superMngr.m_selectRowIndex = 0;
		var formElm = $("#" + formName);
	    formElm.find("#pageNo").val(pageNo);
		
		superMngr.getTplMngr().doGet(this.m_curDecoType, "list");
	},
	
	doGet : function(decoType, view) {
		if(decoType) {
			if(this.m_curDecoType != decoType) {
				this.m_curDecoType = decoType;
				$('#pageNo').val(1);
			}
		}
		if(view) this.m_curView = view;
		var param = "m=uiTplMng";
		param += "&decoType=" + this.m_curDecoType;
		param += "&view=" + this.m_curView;
		param += "&pageNo=" + ($('#pageNo').val() == undefined ? 1 : $('#pageNo').val());
		param += "&decoId=" + ($('#' + this.m_selectRowIndex + '_decoId').val() == undefined ? -1 : $('#' + this.m_selectRowIndex + '_decoId').val());
		this.m_ajax.send ("POST", this.m_contextPath+"/cafe/ad.cafe", param, true, {success: function(data) { superMngr.getTplMngr().doGetHandler(data); }});
	},
	doGetHandler : function (htmlData) {
		if(this.m_curView == "list"){
			document.getElementById("tplMngr").innerHTML = htmlData;
			var formElm = $("#superTemplateForm");
			var pageNo       = formElm.find("#pageNo").val();
			var pageSize     = formElm.find("#pageSize").val();
			var pageFunction = formElm.find("#pageFunction").val();
			var formName     = formElm.find("#formName").val();
			
			var totalSize = formElm.find("#superList_totalSize").val();
			document.getElementById("SUPER_PAGE_ITERATOR").innerHTML = superMngr.m_pageNavi.getPageIteratorHtmlStringCafe (pageNo, pageSize, totalSize, formName, pageFunction);
			
//			alert(pageNo + ', ' + pageSize + ', ' + pageFunction + ', ' + formName + ', ' + totalSize);
			if (totalSize > 0) {
				this.doSelect($('.decoRow')[0]);
				
			} else {
				this.m_selectRowIndex = -1;
			}
		}else if(this.m_curView == "pref"){
			document.getElementById("tplEditDiv").innerHTML = htmlData;
			var decoPrefs = eval("(" + $('#decoPrefs').val() + ")");
			for(var i = 0 ; i < decoPrefs.length; i++){
				$('#' + decoPrefs[i].clazz).val(decoPrefs[i].value);
			}
			
//			$('#' + this.m_curDecoType + '_tplImg_img').attr('src', $('#' + this.m_curDecoType + '_tplImg').val());			
//			$('#' + this.m_curDecoType + '_bgImage_img').css(eval("(" + $('#' + this.m_curDecoType + '_bgImage').val() + ")"));
//			$('#' + this.m_curDecoType + '_myInfoButton_img').css(eval("(" + $('#' + this.m_curDecoType + '_myInfoButton').val() + ")"));
//			$('#' + this.m_curDecoType + '_srchBtn_img').css(eval("(" + $('#' + this.m_curDecoType + '_srchBtn').val() + ")"));
//			$('#' + this.m_curDecoType + '_menuIcon10_img').css(eval("(" + $('#' + this.m_curDecoType + '_menuIcon10').val() + ")"));
//			$('#' + this.m_curDecoType + '_menuIcon11_img').css(eval("(" + $('#' + this.m_curDecoType + '_menuIcon11').val() + ")"));
//			$('#' + this.m_curDecoType + '_menuIcon12_img').css(eval("(" + $('#' + this.m_curDecoType + '_menuIcon12').val() + ")"));
//			$('#' + this.m_curDecoType + '_menuIcon13_img').css(eval("(" + $('#' + this.m_curDecoType + '_menuIcon13').val() + ")"));
//			$('#' + this.m_curDecoType + '_menuIcon14_img').css(eval("(" + $('#' + this.m_curDecoType + '_menuIcon14').val() + ")"));
//			$('#' + this.m_curDecoType + '_menuIcon90_img').css(eval("(" + $('#' + this.m_curDecoType + '_menuIcon90').val() + ")"));
//			$('#' + this.m_curDecoType + '_menuIcon91_img').css(eval("(" + $('#' + this.m_curDecoType + '_menuIcon91').val() + ")"));
//			$('#' + this.m_curDecoType + '_menuIcon92_img').css(eval("(" + $('#' + this.m_curDecoType + '_menuIcon92').val() + ")"));
//			$('#' + this.m_curDecoType + '_newIcon_img').css(eval("(" + $('#' + this.m_curDecoType + '_newIcon').val() + ")"));
			
			new SuperMngr.jQueryUtil('#' + this.m_curDecoType + '_tplImg_img').attr('src', $('#' + this.m_curDecoType + '_tplImg').val());
			new SuperMngr.jQueryUtil('#' + this.m_curDecoType + '_bgImage_img').css(eval("(" + $('#' + this.m_curDecoType + '_bgImage').val() + ")"));
			new SuperMngr.jQueryUtil('#' + this.m_curDecoType + '_myInfoButton_img').css(eval("(" + $('#' + this.m_curDecoType + '_myInfoButton').val() + ")"));
			new SuperMngr.jQueryUtil('#' + this.m_curDecoType + '_srchBtn_img').css(eval("(" + $('#' + this.m_curDecoType + '_srchBtn').val() + ")"));
			new SuperMngr.jQueryUtil('#' + this.m_curDecoType + '_menuIcon10_img').css(eval("(" + $('#' + this.m_curDecoType + '_menuIcon10').val() + ")"));
			new SuperMngr.jQueryUtil('#' + this.m_curDecoType + '_menuIcon11_img').css(eval("(" + $('#' + this.m_curDecoType + '_menuIcon11').val() + ")"));
			new SuperMngr.jQueryUtil('#' + this.m_curDecoType + '_menuIcon12_img').css(eval("(" + $('#' + this.m_curDecoType + '_menuIcon12').val() + ")"));
			new SuperMngr.jQueryUtil('#' + this.m_curDecoType + '_menuIcon13_img').css(eval("(" + $('#' + this.m_curDecoType + '_menuIcon13').val() + ")"));
			new SuperMngr.jQueryUtil('#' + this.m_curDecoType + '_menuIcon14_img').css(eval("(" + $('#' + this.m_curDecoType + '_menuIcon14').val() + ")"));
			new SuperMngr.jQueryUtil('#' + this.m_curDecoType + '_menuIcon90_img').css(eval("(" + $('#' + this.m_curDecoType + '_menuIcon90').val() + ")"));
			new SuperMngr.jQueryUtil('#' + this.m_curDecoType + '_menuIcon91_img').css(eval("(" + $('#' + this.m_curDecoType + '_menuIcon91').val() + ")"));
			new SuperMngr.jQueryUtil('#' + this.m_curDecoType + '_menuIcon92_img').css(eval("(" + $('#' + this.m_curDecoType + '_menuIcon92').val() + ")"));
			new SuperMngr.jQueryUtil('#' + this.m_curDecoType + '_newIcon_img').css(eval("(" + $('#' + this.m_curDecoType + '_newIcon').val() + ")"));			
			
			$('#tplImgSize').html($('#' + this.m_curDecoType + '_tplImg_img').css('width') +', ' + $('#' + this.m_curDecoType + '_tplImg_img').css('height'));
			$('#bgImgSize').html($('#' + this.m_curDecoType + '_bgImage_img').css('width') +', ' + $('#' + this.m_curDecoType + '_bgImage_img').css('height'));
			$('#myInfoImgSize').html($('#' + this.m_curDecoType + '_myInfoButton_img').css('width') +', ' + $('#' + this.m_curDecoType + '_myInfoButton_img').css('height'));
			$('#srchImgSize').html($('#' + this.m_curDecoType + '_srchBtn_img').css('width') +', ' + $('#' + this.m_curDecoType + '_srchBtn_img').css('height'));
			
			$('.tplmngr_pref_input').each(function(){
				var $this = $(this);
				var value = $this.val();
				while(value.indexOf('{') > -1){
					value = value.replace('{','');
				}
				while(value.indexOf('"') > -1){
					value = value.replace('"','');
				}
				while(value.indexOf('}') > -1){
					value = value.replace('}','');
				}
				var returnVal = '';
				if(value.indexOf(",") > -1){
					value = value.split(",");
					for(var i = 0 ; i < value.length ; i++){
						if(value[i].indexOf(":") > -1){
							if(value[i].split(":")[1].indexOf(' ') == 0){
								returnVal += value[i].split(":")[1].substring(1, value[i].split(":")[1].length);
							}
							else returnVal += value[i].split(":")[1];
							if(i < value.length-1){
								returnVal += ',';
							}
						}else {
							returnVal += value[i];
							if(i < value.length-1){
								returnVal += ',';
							}
						}
					}
				}
				else {
					if(value.indexOf(":") > -1){
						returnVal = value.split(":")[1];
					}else{
						returnVal = value;
					}
				}
				if(returnVal.substring(0,1) == ' '){
					returnVal = returnVal.substring(1,returnVal.length);	
				}
				if(returnVal.substring(returnVal.length-1,returnVal.length) == ' '){
					returnVal = returnVal.substring(0,returnVal.length-1);	
				}
				$this.val(returnVal);
			});
		}else {
			alert(htmlData);
		}
	},
	doChange : function (objId) {
		this.doGet($('#' + objId).val(), 'list');
	},
	
	doChangeTplImg : function (obj){
		this.uploadImage('tplImgFile', 'tplImg', document.tplImgForm, superMngr.getTplMngr().doChangeTplImgHandler);
	},
	
	doChangeTplImgHandler : function(fileMask){
		var url = superMngr.m_contextPath + '/' + fileMask;
		$('#' + superMngr.getTplMngr().m_curDecoType + '_tplImg_img').attr('src',  url + '?dummy=' + Math.random());
		$('#' + superMngr.getTplMngr().m_curDecoType + '_tplImg').val(url);
		
	},
	
	doChangeBgImg : function(obj){
		this.uploadImage('bgImageFile', 'bgImage', document.bgImgForm, superMngr.getTplMngr().doChangeBgImgHandler);
	},
	
	doChangeBgImgHandler : function(fileMask){
		var url = 'url(' + superMngr.m_contextPath + '/' + fileMask + ')'; 
		$('#' + superMngr.getTplMngr().m_curDecoType + '_bgImage_img').css('background-image', url);
		$('#' + superMngr.getTplMngr().m_curDecoType + '_bgImage').val(url);
	},
	
	doChangeMyInfoBtnImg : function(obj){
		this.uploadImage('myInfoBtnImageFile', 'myInfoButton', document.myInfoBtnImgForm, superMngr.getTplMngr().doChangeMyInfoBtnImgHandler);
	},
	
	doChangeMyInfoBtnImgHandler : function(fileMask){
		var url = 'url(' + superMngr.m_contextPath + '/' + fileMask + ')'; 
		$('#' + superMngr.getTplMngr().m_curDecoType + '_myInfoButton_img').css('background-image', url);
		$('#' + this.m_curDecoType + '_myInfoButton').val(url);
	},
	
	doChangeSrchBtnImg : function(obj){
		this.uploadImage('srchBtnImageFile', 'srchBtn', document.srchBtnImgForm, superMngr.getTplMngr().doChangeSrchBtnImgHandler);
	},
	
	doChangeSrchBtnImgHandler : function(fileMask){
		var url = 'url(' + superMngr.m_contextPath + '/' + fileMask + ')'; 
		$('#' + superMngr.getTplMngr().m_curDecoType + '_srchBtn_img').css('background-image', url);
		$('#' + this.m_curDecoType + '_srchBtn').val(url);
	},
	
	doChangeMenuIconImg : function(obj, iconKind){
		var tplName = $('#' + this.m_curDecoType + '_tplName').val();
		if(tplName == undefined || tplName == null || tplName == '') {
			alert('메뉴 아이콘 이름을 정해주세요');
			$('#' + this.m_curDecoType + '_tplName').select();
			return;
		}
		else this.m_tplName = tplName;
		var formName = '';
		if(iconKind == 'new'){
			formName = 'document.' + iconKind + 'IconImgForm'
		}
		else formName = 'document.menuIcon' + iconKind + 'ImgForm'
		this.m_iconKind = iconKind;
		this.m_tplName = $('#' + this.m_curDecoType + '_tplName').val();
		this.uploadImage('menuIcon' + iconKind + 'ImageFile', 'menuIcon' + iconKind, eval(formName), superMngr.getTplMngr().doChangeMenuInconImgHandler);
	},
	
	doChangeMenuInconImgHandler : function(fileMask){
		var url = 'url(' + superMngr.m_contextPath + '/' + fileMask + ')'; 
		
		if(this.m_iconKind == 'new'){
			$('#' + superMngr.getTplMngr().m_curDecoType + '_newIcon_img').css('background-image', url);
			$('#' + this.m_curDecoType + '_newIcon').val(url);
		}
		else {
			$('#' + superMngr.getTplMngr().m_curDecoType + '_menuIcon' + this.m_iconKind + '_img').css('background-image', url);
			$('#' + this.m_curDecoType + '_menuIcon' + this.m_iconKind).val(url);
		}
	},
	
	uploadImage : function (fileType, decoName, frm, extraFunc){
		if(extraFunc) this.m_extraFunction = extraFunc;
		var text = $('#' + superMngr.getTplMngr().m_curDecoType + '_' + fileType).val();
		if(text != '') {
			frm.action = superMngr.m_contextPath+"/cafe/ad.cafe?m=uploadImage&decoType=" + superMngr.getTplMngr().m_curDecoType + "&decoName=" + decoName + "&extFolder=" + superMngr.getTplMngr().m_tplName;
			frm.target = "imgIframe";
			frm.submit();
		}
	},
	
   	previewImage : function(fileMask){
   		if(this.m_extraFunction) this.m_extraFunction(fileMask);
	},
	
	doSelect : function (obj) {
		this.m_selectRowIndex = obj.getAttribute("ch");
		this.m_checkBox.unChkAll (document.getElementById ("decoInfoListForm"));
		document.getElementById (this.m_selectRowIndex+"_checkRow").checked = true;
		superMngr.getTplMngr().doGet (this.m_curDecoType, "pref");
	},
	doSave : function() {
		var param = "m=setDecoInfoPrefs";
		param += "&decoType=" + this.m_curDecoType;
		param += "&view=pref";
		param += "&act=save";
		param += "&decoId=" + ($('#' + this.m_selectRowIndex + '_decoId').val() == undefined ? -1 : $('#' + this.m_selectRowIndex + '_decoId').val());
		
		$('.tplmngr_pref_input').each(function(){
			var $this = $(this);
			var clazz = $this.attr('id');
			var value = '';
			
			if($('#' + clazz + '_set').val().indexOf(",") > -1){
				var temp = $this.val().split(",");
				value = $('#' + clazz + '_set').val();
				for(var i = 0 ; i < temp.length; i++){
					value = value.replace("_val" + (i == 0 ? '' : i+1) + "_", temp[i]);	
				}
			}else {
				value = $('#' + clazz + '_set').val().replace("_val_", $this.val());	
			}
			param += "&" + clazz + "=" + value;
		});
		this.m_ajax.send ("POST", this.m_contextPath+"/cafe/ad.cafe", param, true, {success: function(data) { superMngr.getTplMngr().doSaveHandler(data); }});
		
	},
	doSaveHandler : function(data) {
		superMngr.getMsgBox().doShow(ebUtil.getMessage("ev.info.success.update"));
		superMngr.getTplMngr().doGet(this.m_curDecoType, "list");
	}
}
