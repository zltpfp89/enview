AdmPollMngr = function() {
	//var offset = location.href.indexOf (location.host) + location.host.length;
	//this.m_contextPath = location.href.substring (offset, location.href.indexOf('/', offset + 1));
	this.m_contextPath = portalPage.getContextPath();
	this.m_ajax = new enview.util.Ajax();
	this.m_ajax.setContextPath (this.m_contextPath);
	this.m_pageNavi = new enview.util.PageNavigationUtil();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	this.m_cateChooser = new CateChooser(this);
	this.m_boardChooser = new BoardChooser(this);
	
	this.init();
}
AdmPollMngr.prototype = {
	m_isAdm : null,
	m_isMngr : null,
	m_isDomMngr : null,
	m_usrDomId : null,
	m_resDomId : null,
	m_ajax : null,
	m_pageNavi : null,
	m_tree : null,
	m_contextPath : null,
	m_checkBox : null,
	m_msgBox : null,
	m_cateTreeCtxtMenu : null,

	m_cateChooser : null,

	m_boardChooser : null,
	m_passwordGetter : null,
	m_deleteBoardHandler : null,
	m_multiLangMngr : null,

	m_pollMngr : null,
	m_qstnMngr : null,
	m_evalMngr : null,	//평점문항관리
	m_partMngr : null,
	m_rsltMngr : null,
	m_pollJoinUserMngr : null,
	
	//roleChooser : null,
	//groupChooser : null,
	userChooser : null,
	m_selectRowIndex : -1,
	m_dhtmlxContextMenu : null,

	init : function (node) {
		this.m_cateTreeCtxtMenu = treeCtxtMenu = new ContextMenu(this.m_contextPath);
		this.m_dhtmlxContextMenu = new dhtmlXMenuObject();
		this.m_dhtmlxContextMenu.renderAsContextMenu();
		this.m_dhtmlxContextMenu.attachEvent("onClick",this.onDhtmlxContextClick);
		this.m_dhtmlxContextMenu.loadFromHTML("dhtmlx_context_data", true);
		this.m_tree = new dhtmlXTreeObject (document.getElementById('apmCateTree'),"100%","100%",0);
		this.m_tree.setImagePath(this.m_contextPath + "/dhtmlx/imgs/dhxtree_skyblue/");
		this.m_tree.setOnClickHandler (this.onNodeSelect);
		this.m_tree.enableDragAndDrop (true)
		this.m_tree.setDragHandler (this.onNodeDrag);
		this.m_tree.setDropHandler (this.onNodeDrop);
		//this.m_tree.setOnRightClickHandler (this.onContextMenuHandler);
		this.m_tree.enableContextMenu(this.m_dhtmlxContextMenu);
		this.m_tree.attachEvent("onBeforeContextMenu", function (id) {
			aPM.onNodeSelect( id );
			aPM.m_cateTreeCtxtMenu.setItemId( id );
			return true;
		});
		this.m_tree.enableAutoTooltips (true);
		this.m_tree.setXMLAutoLoading (this.m_contextPath+"/board/adCate.brd?m=catebaseTree"); 
		this.m_tree.load (this.m_contextPath+"/board/adCate.brd?m=catebaseTree&id=2&act=root");
		
		$(function() {
			$("#apmPropTabs").tabs();
			$("#cateTabs").tabs();
		});
	},
	
	isAble2Save : function () {
		return (aPM.m_isAdm == 'true' || aPM.m_isMngr == 'true' || (aPM.m_isDomMngr == 'true' && aPM.m_resDomId == aPM.m_usrDomId));
	},
	onContextMenuHandler : function (treeitemId, item) {
		aPM.m_resDomId = aPM.m_tree.getUserData (treeitemId,"domainId");
		aPM.doShowContextMenu( treeitemId, item );
	},
	//onCreateCate : function (treeitemId) {
	onCreateCate : function () {
		treeCtxtMenu.hide();
		aPM.doCreateCate (treeCtxtMenu.getItemId());
	},
	//onRefresh : function (treeItemId) {
	onRefresh : function () {
		treeCtxtMenu.hide();
		aPM.m_tree.refreshItem (treeCtxtMenu.getItemId());
	},
	//onDeleteCate : function (treeItemId) {
	onDeleteCate : function() {
		if( confirm (ebUtil.getMessage("ev.info.remove"))) {
			treeCtxtMenu.hide();
			aPM.doDeleteCate(treeCtxtMenu.getItemId());
		}
		return false;
	},
	//onUpdateCate : function (treeitemId) {
	onUpdateCate : function() {
		treeCtxtMenu.hide();
		aPM.doUpdateCate (treeCtxtMenu.getItemId());
	},
	//onMoveUpCate : function (treeitemId) {
	onMoveUpCate : function() {
		treeCtxtMenu.hide();
		aPM.onNodeDrop (treeCtxtMenu.getItemId(), "U" );
	},
	//onMoveDownCate : function (treeitemId) {
	onMoveDownCate : function() {
		treeCtxtMenu.hide();
		aPM.onNodeDrop (treeCtxtMenu.getItemId(), "D" );
	},
	onNodeDrag : function (dragId, dropId) {
		var dragDomId = aPM.m_tree.getUserData (dragId, "domainId");
		var dropDomId = aPM.m_tree.getUserData (dropId, "domainId");
		if (dragDomId == dropDomId) {
			if (!(aPM.m_isAdm == 'true' || aPM.m_isMngr == 'true') && (dropId == "2" || dragDomId != aPM.m_usrDomId)) return false; // 도메인관리자는 ROOT 노드에 또는 자기 도메인에 속하지 않은 카테고리를 DnD 할 수 없다.
			return true; // 도메인이 같아야 이동할 수 있다.
		} else {
			if ((aPM.m_isAdm == 'true' || aPM.m_isMngr == 'true') && dropId == "2") return true; // 관리자/중간관리자는 ROOT 노드에 DnD 할 수 있다.
			return false; // 도메인이 틀리면 이동할 수 없다.
		}
	},
	onNodeDrop : function (dragId, dropId) {
		aPM.doMoveCate (dragId, dropId);
	},
	onNodeSelect : function (id) {
		$("#cateTabs").tabs('select', 0);

		aPM.m_resDomId = aPM.m_tree.getUserData (id,"domainId");

		var srchForm = document.getElementById("apmSearchForm");
		srchForm.pageNo.value = 1;
		document.getElementById("cate_cateId").disabled = false;
		document.getElementById("cate_cateId").value = id;
		document.getElementById("cate_cateId").disabled = true;
		if (document.getElementById("cate_domainId")) {
			document.getElementById("cate_domainId").disabled = false;
			ebUtil.setSelectedValue (document.getElementById("cate_domainId"), aPM.m_tree.getUserData (id, "domainId"));
			document.getElementById("cate_domainId").disabled = true;
		}
		document.getElementById("cate_cateNm").disabled = false;
		document.getElementById("cate_cateNm").value = aPM.m_tree.getSelectedItemText();
		document.getElementById("cate_cateNm").disabled = true;
		document.getElementById("cate_btnSave").style.display = "none";
		aPM.m_tree.selectItem(id,false,true);
		aPM.doRetrieve();
	},
	onSelectCateTabs : function( id ) {
		if (id == 2) {
			document.getElementById("apmCateLangTab").style.display = "";
			document.getElementById("apmCateLangEditPage").style.display = "none";
			aPM.doRetrieveCateLang();
			if (aPM.isAble2Save() == true) {
				document.getElementById("cateLang_new").style.display = "";
				document.getElementById("cateLang_remove").style.display = "";
			} else {
				document.getElementById("cateLang_new").style.display = "none";
				document.getElementById("cateLang_remove").style.display = "none";
			}
		}
	},
	doShowContextMenu : function( id, item ) {
		/*if (id != "2" && aPM.isAble2Save() == false) return;
		var pos = (new enview.util.Utility()).getAbsolutePosition( item );
		aPM.onNodeSelect( id );
		this.m_cateTreeCtxtMenu.setItemId( id );
		this.m_cateTreeCtxtMenu.show( pos.getX()+45, pos.getY()+20 );*/
	},
	onDhtmlxContextClick : function (menuitemId, type) {
		if (menuitemId == "onRefresh") {
			aPM.onRefresh();
		} else if (menuitemId == "onCreate") {
			aPM.onCreateCate();
		} else if (menuitemId == "onMoveUp") {
			aPM.onMoveUpCate();
		} else if (menuitemId == "onMoveDown") {
			aPM.onMoveDownCate();
		} else if (menuitemId == "onModify") {
			aPM.onUpdateCate();
		} else if (menuitemId == "onDelete") {
			aPM.onDeleteCate();
		}
	},
	doPage : function (formName, pageNo) {
		aPM.m_selectRowIndex = 0;
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = pageNo;
		
		aPM.doRetrieve();
	},
	doRetrieve : function () {
		var param = "m=cateBoard";
		var formElem = document.forms["apmSearchForm"];
		for (var i=0; i<formElem.elements.length; i++) {
			param += "&" + formElem.elements[i].name + "=";
			var tmp = formElem.elements[i].value;
			if (tmp.lastIndexOf("*") > 0) {
				param += "";
			} else {
				param += encodeURIComponent(tmp);
			}
	    }
		param += "&cateId=" + this.m_tree.getSelectedItemId();
		this.m_ajax.send("POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { aPM.doRetrieveHandler(data); }});
	},
	
	doSort : function ( sortColumn) {
		var param = "m=cateBoard";
		var formElem = document.forms["apmSearchForm"];
		var prevSortColumn =  formElem.elements["sortColumn"].value;
		if( sortColumn == prevSortColumn) {
			if( formElem.elements["sortMethod"].value=='ASC') {
				formElem.elements["sortMethod"].value='DESC';
			} else {
				formElem.elements["sortMethod"].value='ASC';
			}
		} else {
			formElem.elements["sortColumn"].value=sortColumn;
			formElem.elements["sortMethod"].value='ASC';
		}
		for (var i=0; i<formElem.elements.length; i++) {
			param += "&" + formElem.elements[i].name + "=";
			var tmp = formElem.elements[i].value;
			if (tmp.lastIndexOf("*") > 0) {
				param += "";
			} else {
				param += encodeURIComponent(tmp);
			}
	    }
		param += "&cateId=" + this.m_tree.getSelectedItemId();
		this.m_ajax.send("POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { aPM.doRetrieveHandler(data); }});
	},
	
	doRetrieveHandler : function (data) {
		var bodyElem = document.getElementById ('apmListBody');
	    var tagTR = null;
	    var tagTD = null;

		this.m_checkBox.unChkAll (document.getElementById ("apmListForm"));
		for (; bodyElem.hasChildNodes(); )
			bodyElem.removeChild (bodyElem.childNodes[0]);

		// 상단 설문 목록을 뿌리는 부분
		for (i=0; i<data.Data.length; i++) {
			tagTR = document.createElement('tr');
			tagTR.id = "pollList"+i;
			tagTR.onmouseover = new Function ("ebUtil.activeLine(this,true)");
			tagTR.onmouseout = new Function ("ebUtil.activeLine(this,false)");
			tagTR.setAttribute ("ch", i);
			tagTR.setAttribute ("style", "cursor:pointer;");
			if (i % 2 == 1) {
				tagTR.setAttribute("class", "adgridline");
				tagTR.setAttribute("className", "adgridline");
			}
			
			tagTD = document.createElement('td');
			tagTD.align = "center";
			tagTD.setAttribute("class", "adgrid");
			tagTD.setAttribute("className", "adgrid");
			if( data.Data[i].boardActive == "N" ) tagTD.style.color = "AAAAAA";
			tagTD.innerHTML = "<input type='checkbox' id='pollList"+i+"_checkRow' class='webcheckbox'/>";
			tagTD.innerHTML += "<input type='hidden' id='pollList"+i+"_boardId' value='" + data.Data[i].boardId + "'/>";
		 	tagTR.appendChild( tagTD );
			
			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "adgrid");
			tagTD.setAttribute("className", "adgrid");
			if( data.Data[i].boardActive == "N" ) tagTD.style.color = "AAAAAA";
			tagTD.align = "left";
			tagTD.onclick = new Function( "aPM.doSelect(this)" );
			tagTD.innerHTML = "<span id='pollList"+i+"_boardId_label'>" + data.Data[i].boardId + "</span>";
			tagTR.appendChild( tagTD );
			
			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "adgrid");
			tagTD.setAttribute("className", "adgrid");
			if( data.Data[i].boardActive == "N" ) tagTD.style.color = "AAAAAA";
			tagTD.align = "left";
			tagTD.onclick = new Function( "aPM.doSelect(this)" );
			tagTD.innerHTML = "<span id='pollList"+i+"_boardNm_label'>" + data.Data[i].boardNm + "</span>";
			tagTR.appendChild( tagTD );

			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "adgrid");
			tagTD.setAttribute("className", "adgrid");
			if( data.Data[i].boardActive == "N" ) tagTD.style.color = "AAAAAA";
			tagTD.align = "left";
			tagTD.onclick = new Function( "aPM.doSelect(this)" );
			tagTD.innerHTML = "<span style='width:100%;' id='pollList"+i+"_boardSkin_label'>" + data.Data[i].boardSkin + "</span>";
			tagTR.appendChild( tagTD );

			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "adgridlast");
			tagTD.setAttribute("className", "adgridlast");
			if( data.Data[i].boardActive == "N" ) tagTD.style.color = "AAAAAA";
			tagTD.align = "center";
			tagTD.onclick = new Function( "aPM.doSelect(this)" );
			tagTD.innerHTML = "<span style='width:100%;' id='pollList"+i+"_boardActive_label'>" + data.Data[i].boardActive + "</span>";
			tagTR.appendChild( tagTD );

			bodyElem.appendChild (tagTR);
		}
		tagTR = document.createElement( 'tr' );
		tagTD = document.createElement( 'td' );
		tagTD.height = "2";
		tagTD.colSpan = "6";
		tagTD.setAttribute("class", "adgridlimit");
		tagTD.setAttribute("className", "adgridlimit");
		tagTR.appendChild( tagTD );
		bodyElem.appendChild (tagTR);
		
		if (data.Data.length == 0) {
			//alert("not found");
			tagTR = document.createElement('tr');
			tagTD = document.createElement('td');
			tagTD.height = "22";
			tagTD.colSpan = "5";
			tagTD.innerHTML = "<span>"+ebUtil.getMessage("ev.info.notFoundData")+"</span>";
			tagTR.appendChild (tagTD);
			bodyElem.appendChild (tagTR);
		} else {
			tagTR = document.createElement ('tr');
			tagTD = document.createElement ('td');
			tagTD.height = "22";
			tagTD.colSpan = "5";
			tagTD.innerHTML = "<span>"+ebUtil.getMessage("ev.info.resultSize", data.TotalSize)+"</span>";   
			tagTR.appendChild (tagTD);
			bodyElem.appendChild (tagTR);
		}
		//document.getElementById("APM_PAGE_ITERATOR").innerHTML = data.PortletIterator;
		var formElem = document.forms[ "apmSearchForm" ];
		var pageNo = formElem.elements[ "pageNo" ].value;
		var pageSize = formElem.elements[ "pageSize" ].value;
		var pageFunction = formElem.elements[ "pageFunction" ].value;
		var formName = formElem.elements[ "formName" ].value;
		
		document.getElementById("APM_PAGE_ITERATOR").innerHTML = this.m_pageNavi.getPageIteratorHtmlString (pageNo, pageSize, data.TotalSize, formName, pageFunction);
		
		if (data.Data.length > 0) {
			this.m_selectRowIndex = 0;
			aPM.doDefaultSelect();
		} else {
			this.m_selectRowIndex = -1;
			var tabId = $("#apmPropTabs").tabs('option', 'selected');
			aPM.doSelectTab (tabId);
		}
	},
	doDefaultSelect : function () {
		if( document.getElementById('pollList'+this.m_selectRowIndex+'_checkRow') ) {
		    document.getElementById('pollList'+this.m_selectRowIndex+'_checkRow').checked = true;
		}
		var tabId = $("#apmPropTabs").tabs('option','selected');
		aPM.doSelectTab (tabId);		
	},
	doSelect : function( obj ) {
		this.m_selectRowIndex = obj.parentNode.getAttribute("ch");
		this.m_checkBox.unChkAll(document.getElementById("apmListForm"));
		document.getElementById('pollList'+this.m_selectRowIndex+'_checkRow').checked = true;

		var tabId = $("#apmPropTabs").tabs('option', 'selected');
		aPM.doSelectTab (tabId);
	},
	doSelectTab : function (tabId) {
		if (this.m_selectRowIndex < 0) {
			switch (tabId) {
				case 0:
					if (this.m_tree.getSelectedItemId() == "2") {
						aPM.getPollMngr().doClear(); // root node에는 아무런 행위를 할 수 없음.
					} else {
						aPM.getPollMngr().doGet();
					}						
					break;
				case 1:	aPM.getQstnMngr().doClear(); break;
				case 2:	aPM.getEvalMngr().doClear(); break;	//평점문항관리
				case 3:	aPM.getPartMngr().doClear(); break;
				case 4:	aPM.getRsltMngr().doClear(); break;
				
			}
			return;
		}
		var boardId = document.getElementById("pollList"+this.m_selectRowIndex+"_boardId").value;
		switch (tabId) {
			case 0:	aPM.getPollMngr().doGet (boardId); break;
			case 1:	aPM.getQstnMngr().doGet (boardId, "listQ"); break;
			case 2:	aPM.getEvalMngr().doGet (boardId); break;	//평점문항관리
			case 3:	aPM.getPartMngr().doGet (boardId); break;
			case 4:	aPM.getRsltMngr().doGet (boardId); break;
		}
	},
	doCreateCate : function (itemId) {
		document.getElementById("cate_act").value = "ins";
		document.getElementById("cate_cateId").value = "입력하지 않음";
		if (document.getElementById("cate_domainId")) {
			if (aPM.m_tree.getSelectedItemId() == "2") {
				document.getElementById("cate_domainId").disabled = false;
				ebUtil.setSelectedValue (document.getElementById("cate_domainId"), "0");
			} else {
				document.getElementById("cate_domainId").disabled = false;
				ebUtil.setSelectedValue (document.getElementById("cate_domainId"), aPM.m_tree.getUserData(itemId, "domainId"));
				document.getElementById("cate_domainId").disabled = true;
			}
		}
		document.getElementById("cate_cateNm").value = "";
		document.getElementById("cate_cateNm").disabled = false;
		document.getElementById("cate_btnSave").style.display = "";
		document.getElementById("cate_cateNm").focus();
	},
	doUpdateCate : function ( itemId ) {
		document.getElementById("cate_act").value = "upd";
		if (document.getElementById("cate_domainId")) document.getElementById("cate_domainId").disabled = true;
		document.getElementById("cate_cateNm").disabled = false;
		document.getElementById("cate_btnSave").style.display = "";
		document.getElementById("cate_cateNm").focus();
	},
	doDeleteCate : function ( itemId ) {
		document.getElementById("cate_act").value = "del";
		aPM.doSaveCate();
	},
	doMoveCate : function( dragId, dropId ) {
		var param = "m=setCatebaseMove";

		param += "&dragId=" + dragId;
		param += "&dropId=" + dropId;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { aPM.doMoveCateHandler( data ); }});
	},
	doMoveCateHandler : function( data ) {
		aPM.getMsgBox().doShow( ebUtil.getMessage("mm.info.move.success"));
		//aPM.m_cateTreeCtxtMenu.hide();
		this.m_tree.refreshItem( data.refreshId );
		this.m_tree.selectItem ( data.refreshId, true, false );
		this.m_tree.openItem   ( data.refreshId );
		//aPM.onNodeSelect( data.refreshId );
	},
	doSaveCate : function() {
		if( !ebUtil.chkValue( document.getElementById("cate_cateNm"), "카테고리 명을", true )) return;
		if (document.getElementById("cate_domainId")) {
			if (!ebUtil.chkSelect (document.getElementById("cate_domainId"), 0, "도메인 아이디를", 'true')) return;
		}
		var param = "m=setCatebase";
		param += "&act=" + document.getElementById("cate_act").value;
		param += "&cateId=" + aPM.m_tree.getSelectedItemId();
		if (document.getElementById("cate_domainId")) param += "&domainId=" + ebUtil.getSelectedValue (document.getElementById("cate_domainId"));
		param += "&cateNm=" + encodeURIComponent( document.getElementById("cate_cateNm").value);
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { aPM.doSaveCateHandler( data ); }});
	},
	doSaveCateHandler : function( data ) {
		var act = document.getElementById("cate_act").value;
		if( act == "ins" ) {
			aPM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.add"));
		} else if( act == "upd" ) {
			aPM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.update"));
		} else {
			aPM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.remove"));
		}
		//aPM.m_cateTreeCtxtMenu.hide();
		var refreshId = data.refreshId;
		this.m_tree.refreshItem( data.refreshId );
		this.m_tree.selectItem ( data.refreshId, true, false );
		this.m_tree.openItem   ( data.refreshId );
		//aPM.onNodeSelect( data.refreshId );
	},
	doRetrieveCateLang : function () {
		var param = "m=catebaseLangList";
		param += "&cateId=" + document.getElementById("cate_cateId").value;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { aPM.doRetrieveCateLangHandler( data ); }});
	},
	doRetrieveCateLangHandler : function( data ) {
		var bodyElem = document.getElementById ('apmCateLangListBody');
	    var tagTR = null;
	    var tagTD = null;

		this.m_checkBox.unChkAll( document.getElementById( "apmCateLangListForm"));
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
			if (aPM.isAble2Save() == true) tagTD.onclick = new Function( "aPM.doSelectCateLang('"+data.Data[i].langKnd+"','"+data.Data[i].cateNm+"')" );
			tagTD.innerHTML = "<span id='cateLangList"+i+".langKnd.label'>" + data.Data[i].langKnd + "</span>";
			tagTR.appendChild( tagTD );
			
			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "adgrid");
			tagTD.setAttribute("className", "adgrid");
			tagTD.align = "left";
			if (aPM.isAble2Save() == true) tagTD.onclick = new Function( "aPM.doSelectCateLang('"+data.Data[i].langKnd+"','"+data.Data[i].cateNm+"')" );
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
	doCreateCateLang : function() {
		document.getElementById("apmCateLangEditPage").style.display = "";
		document.getElementById("cateLang_act").value = "ins"; 
		document.getElementById("cateLang_cateId").value = this.m_tree.getSelectedItemId();
		document.getElementById("cateLang_langKnd").disabled = false;
		document.getElementById("cateLang_langKnd").value = "";
		document.getElementById("cateLang_cateNm").value = "";
		document.getElementById("cateLang_langKnd").focus();
	},
	doSelectCateLang : function( langKnd, cateNm ) {
		document.getElementById("apmCateLangEditPage").style.display = "";
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
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { aPM.doSaveCateLangHandler( data ); }});
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
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { aPM.doSaveCateLangHandler( data ); }});
	},
	doSaveCateLangHandler : function( data ) {
		var act = document.getElementById("cateLang_act").value;
		if( act == "ins" ) {
			aPM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.add"));
		} else if( act == "upd" ) {
			aPM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.update"));
		} else if( act == "del" ) {
			aPM.getMsgBox().doShow( ebUtil.getMessage("ev.info.success.remove"));
		}
		document.getElementById("apmCateLangEditPage").style.display = "none";
		aPM.doRetrieveCateLang();
	},
	getCateChooser : function() {
		return this.m_cateChooser;
	},
	getBoardChooser : function() {
		return this.m_boardChooser;
	},
	getMultiLangMngr : function() {
		if (this.m_multiLangMngr) return this.m_multiLangMngr;
		this.m_multiLangMngr = new MultiLangMngr(this);
		return this.m_multiLangMngr;
	},
	getPollMngr : function() {
		if (this.m_pollMngr) return this.m_pollMngr;
		this.m_pollMngr = new AdmPollMngr.PollMngr(this);
		return this.m_pollMngr;
	},
	getQstnMngr : function() {
		if (this.m_qstnMngr) return this.m_qstnMngr;
		this.m_qstnMngr = new AdmPollMngr.QstnMngr(this);
		return this.m_qstnMngr;
	},
	//평점문항관리
	getEvalMngr : function() {
		if (this.m_evalMngr) return this.m_evalMngr;
		this.m_evalMngr = new AdmPollMngr.EvalMngr(this);
		return this.m_evalMngr;
	},
	getPartMngr : function() {
		if (this.m_partMngr) return this.m_partMngr;
		this.m_partMngr = new AdmPollMngr.PartMngr(this);
		return this.m_partMngr;
	},
	getRsltMngr : function() {
		if (this.m_rsltMngr) return this.m_rsltMngr;
		this.m_rsltMngr = new AdmPollMngr.RsltMngr(this);
		return this.m_rsltMngr;
	},
	/*
	getRoleChooser : function() {
		if (this.roleChooser) return this.roleChooser;
		this.roleChooser = new RoleChooser(this);
		return this.roleChooser;
	},
	*/
	/*
	getGroupChooser : function() {
		if (this.groupChooser) return this.groupChooser;
		this.groupChooser = new GroupChooser(this);
		return this.groupChooser;
	},
	*/
	getUserChooser : function() {
		if (this.userChooser) return this.userChooser;
		this.userChooser = new UserChooser(this);
		return this.userChooser;
	},
	getPollJoinUserMngr : function() {
		if (this.m_pollJoinUserMngr) return this.m_pollJoinUserMngr;
		this.m_pollJoinUserMngr = new PollJoinUserMngr(this);
		return this.m_pollJoinUserMngr;
	},
	getMsgBox : function() {
		if (this.m_msgBox == null) {
			if ( enviewMessageBox == null ) {
				enviewMessageBox = new enview.portal.MessageBox(300, 100, 1000);
			}
			this.m_msgBox = enviewMessageBox;
		}
		return this.m_msgBox
	}
}
AdmPollMngr.PollMngr = function (parent) {
	this.m_elmArea = document.getElementById("apmPollTab");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_checkBox = parent.m_checkBox;
}
AdmPollMngr.PollMngr.prototype = {
	m_elmArea : null,
	m_contextPath : null,
	m_checkBox : null,
	m_curBoardId : null,
	m_curAcco : 0,
	m_curAct : null,

	doGet : function (boardId) {
		if (boardId != null && boardId.length > 0) this.m_curBoardId = boardId;
		else this.m_curBoardId = ""; // 안이러면 string 'null'이 올라가거등...
		
		var param = "m=uiPollPollMng";
		param += "&boardId=" + this.m_curBoardId;
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adPoll.brd", param, true, {success: function(data) { aPM.getPollMngr().doGetHandler(data);}});
	},
	doGetHandler : function (htmlData) {
		document.getElementById("apmPollTab").style.display = "";
		this.m_elmArea.innerHTML = htmlData;
		$("#pollAccordion").accordion({
			autoHeight: false,
			change: function(event,ui) { aPM.getPollMngr().m_curAcco = $("#pollAccordion").accordion("option","active");}
		});
		$("#pollAccordion").accordion("activate", this.m_curAcco);

		var pollCmd = document.getElementById("poll_cmd").value;
		if (pollCmd == "INIT") {
			if (aPM.isAble2Save() == false) {
				document.getElementById("apmPollTab").style.display = "none";
				return;
			}
			document.getElementById("poll_boardNmLangBtn").style.display = "none";
			document.getElementById("poll_boardTtlLangBtn").style.display = "none";
		} else {
			if (aPM.isAble2Save() == false) {
				document.getElementById("poll_boardNmLangBtn").style.display = "none";
				document.getElementById("poll_boardTtlLangBtn").style.display = "none";
				document.getElementById("poll_add").style.display = "none";
				document.getElementById("poll_save").style.display = "none";
				document.getElementById("poll_del").style.display = "none";
			}
		}
	},
	doClear : function() {
		this.m_elmArea.innerHTML = "";
	},
	doPollPreview : function() {
		window.open (this.m_contextPath+"/board/list.brd?boardId="+this.m_curBoardId, "_blank");
	},
	doSave : function (act) {
		this.m_curAct = act;
		if (this.m_curAct == "add") {
			aPM.getPollMngr().doGet();
			return;
		}
		var param = "m=setPollBasic";
		param += "&domainId=" + document.getElementById("cate_domainId").value;
		if (this.m_curAct == "save") {
			var cmd = document.getElementById("poll_cmd").value;
			if (cmd == "INIT") {
				if (!ebUtil.chkValue    (document.getElementById("poll_boardId"), ebUtil.getMessage('eb.info.ttl.o.pollId'), 'true')) return; // 설문 아이디를
				if (!ebUtil.chkTableName(document.getElementById("poll_boardId"), ebUtil.getMessage('eb.info.ttl.p.pollId'), 'true')) return; // 설문 아이디에
			}
			if (!ebUtil.chkValue(document.getElementById("poll_boardNm"),     ebUtil.getMessage('eb.info.ttl.o.pollNm'), 'true')) return; // 설문 명을
			if (!ebUtil.chkCheck(document.getElementsByName("poll_boardActive"), ebUtil.getMessage('eb.info.ttl.o.mileActive'), 'true')) return; // 활성화 여부를
			if (cmd == "INIT") {
				param += "&cmd=" + "NEW";
				if (!confirm (ebUtil.getMessage("eb.info.confirm.create.poll", aPM.m_tree.getSelectedItemText()))) return;
			} else {
				param += "&cmd=" + "UPD";
			}
			param += "&cateId="      + aPM.m_tree.getSelectedItemId();
			param += "&boardId="     + document.getElementById("poll_boardId").value;
			param += "&boardActive=" + ebUtil.getCheckedValue(document.getElementsByName("poll_boardActive"));
			param += "&evalYn=" + ebUtil.getCheckedValue(document.getElementsByName("poll_evalYn"));
			param += "&boardNm="     + document.getElementById("poll_boardNm").value;
			param += "&boardTtl="    + document.getElementById("poll_boardTtl").value;
			param += "&boardSkin="   + document.getElementById("poll_boardSkin").value;
			param += "&pollBgnYmd="  + document.getElementById("poll_pollBgnYmd").value;
			param += "&pollEndYmd="  + document.getElementById("poll_pollEndYmd").value;
		} else if (this.m_curAct == "del") {
			if (document.getElementById("poll_boardId").value.trim() == "") {
				alert (ebUtil.getMessage('eb.info.poll.notSelect')); // '선택된 설문이 없습니다'
				return;
			}		
			param += "&cmd="     + "DEL";
			param += "&boardId=" + document.getElementById("poll_boardId").value;
			if (!confirm(ebUtil.getMessage('eb.info.assert.del'))) return; // '정말정말 삭제하시겠습니까?'
		} else if (this.m_curAct == "dup") {
			if (!ebUtil.chkValue    (document.getElementById("poll_dstBoardId"), ebUtil.getMessage("eb.info.ttl.o.pollId"), "true")) return; // 설문 아이디를
			if (!ebUtil.chkTableName(document.getElementById("poll_dstBoardId"), ebUtil.getMessage('eb.info.ttl.p.pollId'), 'true')) return; // 설문 아이디에
			param += "&cmd=" + "DUP";
			param += "&cateId="     + aPM.m_tree.getSelectedItemId();
			param += "&boardId="    + document.getElementById("poll_boardId").value;
			param += "&dstBoardId=" + document.getElementById("poll_dstBoardId").value;
		}
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adPoll.brd", param, true, {success: function(data) { aPM.getPollMngr().doSaveHandler(data);}});
	},
	doSaveHandler : function (data) {
		if (this.m_curAct == "save") {
			aPM.getMsgBox().doShow (ebUtil.getMessage("mm.info.success"));
		} else if (this.m_curAct == "del") {
			aPM.getMsgBox().doShow (ebUtil.getMessage("ev.info.success.remove"));
		} else if (this.m_curAct == "dup") {
			aPM.getMsgBox().doShow (ebUtil.getMessage("mm.info.success"));
		}
		aPM.doRetrieve();
	},
	doCateBoardMove : function (act) {
		this.m_curAct = act;
		var objTrgtCateId = document.getElementById("poll_trgtCateId");
		var objSelCate    = document.getElementById("poll_selCate");
		if( document.getElementById("poll_boardId").value.length == 0 ) {
			alert( ebUtil.getMessage('eb.info.board.notSelect'));
			objSelCate.focus();
			return;
		}
		var trgtCateDomainId = document.getElementById("poll_trgtCateDomainId").value;
		var selCateDomainId  = aPM.m_tree.getUserData(aPM.m_tree.getSelectedItemId(), "domainId");
		if ("MOVE" == act) {
			if (objTrgtCateId.value.length == 0) {
				alert( ebUtil.getMessage('eb.info.select.move.trgtCate'));
				objSelCate.focus();
				return;
			}
			if (objTrgtCateId.value == aPM.m_tree.getSelectedItemId()) {
				alert (ebUtil.getMessage('eb.info.sameCate'));
				objSelCate.focus();
				return;
			}
			if (selCateDomainId != trgtCateDomainId) {
				alert (ebUtil.getMessage('eb.info.cant.move.board.domain'));
				objSelCate.focus();
				return;
			}
			if(!confirm (ebUtil.getMessage('eb.info.confirm.move'))) return;
			
		} else if ("COPY" == act) {
			if (objTrgtCateId.value.length == 0) {
				alert( ebUtil.getMessage('eb.info.select.copy.trgtCate'));
				objSelCate.focus();
				return;
			}
			if (objTrgtCateId.value == aPM.m_tree.getSelectedItemId()) {
				alert( ebUtil.getMessage('eb.info.sameCate'));
				objSelCate.focus();
				return;
			}
			if (selCateDomainId != trgtCateDomainId) {
				alert (ebUtil.getMessage('eb.info.cant.copy.board.domain'));
				objSelCate.focus();
				return;
			}
			if(!confirm (ebUtil.getMessage('eb.info.confirm.copy'))) return;
			
		} else if ("DELETE" == act) {
			if(!confirm( ebUtil.getMessage('eb.info.confirm.del'))) return;
		}
		var param = "m=setCateBoardMove"
		param += "&act=" + act;
		param += "&cateId=" + aPM.m_tree.getSelectedItemId();
		param += "&trgtCateId=" + objTrgtCateId.value;
		param += "&boardId=" + document.getElementById("poll_boardId").value;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adBoard.brd", param, true, {success: function(data) { aPM.getPollMngr().doCateBoardMoveHandler(data); }});
	},
	doCateBoardMoveHandler : function (data) {
		if (this.m_curAct == "MOVE"  || this.m_curAct == "COPY") {
			aPM.getMsgBox().doShow (ebUtil.getMessage("ev.info.success.update"));
		} else if( act == "DELETE" ) {
			aPM.getMsgBox().doShow (ebUtil.getMessage("ev.info.success.delete"));
		}
		// 현재 카테고리의 설문 목록을 갱신해준다.
		aPM.onNodeSelect (aPM.m_tree.getSelectedItemId());
	}
}
AdmPollMngr.QstnMngr = function (parent) {
	this.m_elmArea = document.getElementById("apmQstnTab");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_checkBox = parent.m_checkBox;
}
AdmPollMngr.QstnMngr.prototype = {
	m_elmArea : null,
	m_contextPath : null,
	m_checkBox : null,
	m_curAcco : 0,
	m_curFlag : "",
	m_curView : "",
	m_curAct : "",
	m_curBoardId : "",
	m_curBltnNo : "",
	m_curPollSeq : "0",

	doGet : function (boardId) {
		// 상단 설문목록에서 최초로 호출될 때만 설문아이디가 넘어온다.
		if (boardId != null && boardId.length > 0) {
			this.m_curBoardId = boardId;
			this.m_curView    = "listQ";
		}
		var param = "m=uiPollQstnMng";
		param += "&view="    + this.m_curView;
		param += "&act="     + this.m_curAct;
		param += "&boardId=" + this.m_curBoardId;
		param += "&bltnNo="  + this.m_curBltnNo;
		param += "&pollSeq=" + this.m_curPollSeq;
		
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adPoll.brd", param, true, {success: function(data) { aPM.getQstnMngr().doGetHandler(data);}});
	},
	doGetHandler : function (htmlData) {
		if (this.m_curView == "listQ") {
			this.m_elmArea.innerHTML = htmlData;
			$("#qstnAccordion").accordion({
				autoHeight: false,
				change: function(event,ui) { aPM.getPollMngr().m_curAcco = $("#qstnAccordion").accordion("option","active");}
			});
			$("#qstnAccordion").accordion("activate", this.m_curAcco);
		} else if (this.m_curView == "editQ") { 
			document.getElementById("qstn_pollQArea").innerHTML = htmlData;
		} else if (this.m_curView == "editA") {
			document.getElementById("qstn_pollAArea").innerHTML = htmlData;
		}	
	},
	doClear : function() {
		this.m_elmArea.innerHTML = "";
	},
	pollRequest : function (flag, view, act, bltnNo, pollSeq) {
		
		if (flag    != null) this.m_curFlag    = flag;
		if (view    != null) this.m_curView    = view;
		if (act     != null) this.m_curAct     = act;
		if (bltnNo  != null) this.m_curBltnNo  = bltnNo;
		if (pollSeq != null) this.m_curPollSeq = pollSeq;
		
		var param = "";

		if (this.m_curFlag == "") {
			if (this.m_curView == "editQ") { // 설문문항목록에서 설문문항 선택시
				aPM.getQstnMngr().doGet();
			} else if (view == "editA") { // 답변항목목록에서 답변항목 선택시 
				aPM.getQstnMngr().doGet();
			}
			return;
			
		} else if (this.m_curFlag == "qList") { // 설문문항내역에서 목록으로
			this.m_curView = "listQ";
			aPM.getQstnMngr().doGet();
			return;
		
		} else if (this.m_curFlag == "qSave") { // 설문문항내역에서 설문문항 저장시
			
			if (!ebUtil.chkValue(document.getElementById("qstn_bltnGq"),   ebUtil.getMessage('eb.info.ttl.o.pollBltnGq'), 'true')) return; // 설문문항 번호를
			if (!ebUtil.chkNum  (document.getElementById("qstn_bltnGq"),   ebUtil.getMessage('eb.info.ttl.p.pollBltnGq'), 'true')) return; // 설문문항 번호에
			if (!ebUtil.chkValue(document.getElementById("qstn_bltnCntt"), ebUtil.getMessage('eb.info.ttl.o.pollBltnCntt'), 'true')) return; // 설문문항을
			
			this.m_curView   = "listQ";
			this.m_curAct    = document.getElementById("qstn_act").value;
			this.m_curBltnNo = document.getElementById("qstn_bltnNo").value;
			
			param += "m=setPollQA"
			param += "&view="     + this.m_curView;
			param += "&act="      + document.getElementById("qstn_act").value;
			param += "&boardId="  + this.m_curBoardId;
			param += "&bltnNo="   + this.m_curBltnNo;
			param += "&bltnGq="   + document.getElementById("qstn_bltnGq").value;
			param += "&bltnCntt=" + document.getElementById("qstn_bltnCntt").value;
			param += "&betPnt="   + document.getElementById("qstn_betPnt").value;	//다중선택
			param += "&fileMask=" + document.getElementById("qstn_fileMask").value;

		} else if (this.m_curFlag == "qDel") { // 설문문항내역에서 설문문항 삭제시
			
			if (document.getElementById("qstn_bltnGq").value.trim() == "") {
				alert (ebUtil.getMessage('eb.info.pollBltn.notSelect')); // '선택된 설문문항이 없습니다'
				return;
			}		
			if (!confirm(ebUtil.getMessage('eb.info.confirm.del'))) return;

			this.m_curView   = "listQ";
			this.m_curAct    = "del";
			this.m_curBltnNo = document.getElementById("qstn_bltnNo").value;
			
			param += "m=setPollQA"
			param += "&view="     + this.m_curView;
			param += "&act="      + this.m_curAct;
			param += "&boardId="  + this.m_curBoardId;
			param += "&bltnNo="   + this.m_curBltnNo;
		
		} else if (this.m_curFlag == "aList") { // 답변항목내역에서 목록으로
			
			this.m_curView = "editQ";
			aPM.getQstnMngr().doGet();
			return;
		
		} else if (this.m_curFlag == "aSave") { // 답변항목내역에서 답변항목 저장시

			if (!ebUtil.chkValue(document.getElementById("answ_pollSeq"),  ebUtil.getMessage('eb.info.ttl.o.pollSeq'), 'true')) return; // 답변항목 번호를
			if (!ebUtil.chkNum  (document.getElementById("answ_pollSeq"),  ebUtil.getMessage('eb.info.ttl.p.pollSeq'), 'true')) return; // 답변항목 번호에
			if (!ebUtil.chkCheck(document.getElementsByName("answ_pollKind"), ebUtil.getMessage('eb.info.ttl.o.pollKind'), 'true')) return; // 답변항목 유형을
			
			var elms = document.getElementsByName("qstn_pollKind");
			var seqs = document.getElementsByName("qstn_pollSequ");
			for (var i=0; i<elms.length; i++) {
				if (elms[i].value == 'B' && ebUtil.getCheckedValue(document.getElementsByName("answ_pollKind")) == 'B' ) {
					// seq가 같으면 수정이므로 허용, 다르면 추가이므로 오류
//					alert( seqs[i].value + '/' +  this.m_curPollSeq);
					if( seqs[i].value != this.m_curPollSeq) {
						alert (ebUtil.getMessage('eb.info.pollPoll.already.desc')); // 이미 서술형 답변항목이 존재합니다.
						return;
					}
				}
			}		
			if (document.getElementById("answ_pollPnt").value.trim() != '') {
				if (!ebUtil.chkNum(document.getElementById("answ_pollPnt"), ebUtil.getMessage('eb.info.ttl.p.pollPnt'), 'true')) return; // 답변항목 배점에
			} else {
				document.getElementById("answ_pollPnt").value = "0"; // 0을 안올리면 Spring에서 int 형 변수에 bind를 안시켜준다.
			}
			if (ebUtil.getCheckedValue(document.getElementsByName("answ_pollKind")) == "A") { // 선택형이면
				if (!ebUtil.chkValue(document.getElementById("answ_pollCntt"), ebUtil.getMessage('eb.info.ttl.o.pollCntt'), 'true')) return; // 답변항목을
			}

			this.m_curView    = "editQ";
			this.m_curAct     = document.getElementById("answ_act").value;
			this.m_curPollSeq = document.getElementById("answ_pollSeq").value;

			param += "m=setPollQA"
			param += "&view="     + this.m_curView;
			param += "&act="      + this.m_curAct;
			param += "&boardId="  + this.m_curBoardId;
			param += "&bltnNo="   + this.m_curBltnNo;
			param += "&pollSeq="  + this.m_curPollSeq;
			param += "&pollKind=" + ebUtil.getCheckedValue(document.getElementsByName("answ_pollKind"));
			param += "&pollPnt="  + document.getElementById("answ_pollPnt").value;
			param += "&pollCntt=" + document.getElementById("answ_pollCntt").value;
			param += "&fileMask="  + document.getElementById("answ_fileMask").value;
		
		} else if (this.m_curFlag == "aDel") { // 답변항목내역에서 답변항목 삭제시
			
			if (document.getElementById("answ_pollSeq").value.trim() == "") {
				alert (ebUtil.getMessage('eb.info.pollPoll.notSelect')); // '선택된 답변항목이 없습니다'
				return;
			}		
			if (!confirm(ebUtil.getMessage('eb.info.confirm.del'))) return;

			this.m_curView = "editQ";
			this.m_curAct  = "del";
			
			param += "m=setPollQA"
			param += "&view="     + this.m_curView;
			param += "&act="      + this.m_curAct;
			param += "&boardId="  + this.m_curBoardId;
			param += "&bltnNo="   + document.getElementById("answ_bltnNo").value;
			param += "&pollSeq="  + document.getElementById("answ_pollSeq").value;
			
			
		
		} else if (this.m_curFlag == 'selKind') { // 답변항목유형을 선택했을 때.<-서술형도 내용이 있으므로 이 로직 안쓴다.2010.05.03.KWShin.
			
			if (document.frmPAE.pollKind[0].checked) { // '선택형'이 선택됐으면
				document.getElementById('pollCnttTr').style.display = ''; 
				document.getElementById('pollCnttTrLine').style.display = ''; 
			} else { // '서술형'이 선택됐으면
				document.getElementById('pollCnttTr').style.display = 'none'; 
				document.getElementById('pollCnttTrLine').style.display = 'none'; 
			}
			return;
		
		} else if (this.m_curFlag == "qDup") { // 설문문항 복사
		
			if(document.getElementById("qstn_dstBoardId").value.length == 0) {
				alert (ebUtil.getMessage('eb.info.select.trgtPoll')); // '대상 설문을 선택하세요'
				document.getElementById("qstn_dupBtn").focus();
				return;
			}
			if (!confirm(ebUtil.getMessage('eb.info.confirm.copy'))) return; // '정말 복사하시겠습니까?'
			
			this.m_curView = "editQ";
			this.m_curAct  = "dup";

			param += "m=setPollQA"
			param += "&view="       + this.m_curView;
			param += "&act="        + this.m_curAct;
			param += "&dstBoardId=" + document.getElementById("qstn_dstBoardId").value;
			var boardId = document.getElementById("qstn_boardId").value;
			var bltnNo  = document.getElementById("qstn_bltnNo").value;
			param += "&boardId="    + boardId;
			param += "&bltnNo="     + bltnNo;

		}
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adPoll.brd", param, true, {success: function(data) { aPM.getQstnMngr().pollRequestHandler(data);}});
	},
	pollRequestHandler : function(data) {
		aPM.getMsgBox().doShow (ebUtil.getMessage("mm.info.success"));
		aPM.getQstnMngr().doGet();
	},
	// 질문 이미지를 업로그 한다
	uploadPollImgQ : function(evt) {
		var setPollForm = document.forms['setPollQ'];
		if (setPollForm) {
			if (setPollForm.pollFile.value.length == 0) {
				alert(ebUtil.getMessage('eb.info.file'));
				setPollForm.pollFile.focus();
				return false;
			}
			setPollForm.submit();
		}
	},
	
	// 답변 이미지를 업로그 한다
	uploadPollImgA : function(evt) {
		var setPollForm = document.forms['setPollA'];
		if (setPollForm) {
			if (setPollForm.pollFile.value.length == 0) {
				alert(ebUtil.getMessage('eb.info.file'));
				setPollForm.pollFile.focus();
				return false;
			}
			setPollForm.submit();
		}
	},
	
	// 질문 이미지 업로드 후속처리를 한다 
	handleUploadPollImgQ : function ( fileMask) {
		document.getElementById("qstn_fileMask").value = fileMask;
		var imgSrc = this.m_contextPath + '/upload/poll/' + this.m_curBoardId + '/' + fileMask;
		document.getElementById("qstn_imgPoll").src = imgSrc;
//		aPM.getQstnMngr().pollRequest('aSave');
	},

	// 답변 이미지 업로드 후속처리를 한다 
	handleUploadPollImgA : function ( fileMask) {
		document.getElementById("answ_fileMask").value = fileMask;
		var imgSrc = this.m_contextPath + '/upload/poll/' + this.m_curBoardId + '/' + fileMask;
		document.getElementById("answ_imgPoll").src = imgSrc;
//		aPM.getQstnMngr().pollRequest('aSave');
	},

	// 질문 이미지를 삭제한다.
	deletePollImgQ : function(evt) {
		document.getElementById("qstn_fileMask").value = '';
		var imgSrc = this.m_contextPath + '/upload/poll/no.gif';
		document.getElementById("qstn_imgPoll").src = imgSrc;
	},
	// 답변 이미지를 삭제한다.
	deletePollImgA : function(evt) {
		document.getElementById("answ_fileMask").value = '';
		var imgSrc = this.m_contextPath + '/upload/poll/no.gif';
		document.getElementById("answ_imgPoll").src = imgSrc;
	}
}
//평점문항관리
AdmPollMngr.EvalMngr = function (parent) {
	this.m_elmArea = document.getElementById("apmEvalTab");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_checkBox = parent.m_checkBox;
}
AdmPollMngr.EvalMngr.prototype = {
	m_elmArea : null,
	m_contextPath : null,
	m_checkBox : null,
	m_curAcco : 0,
	m_curFlag : "",
	m_curView : "",
	m_curAct : "",
	m_curBoardId : "",
	m_curEvalSeq : "",
	
	doGet : function (boardId) {
		// 상단 설문목록에서 최초로 호출될 때만 설문아이디가 넘어온다.
		if (boardId != null && boardId.length > 0) {
			this.m_curBoardId = boardId;
			this.m_curView    = "list";
		}
		var param = "m=uiPollEvalMng";
		param += "&view="    + this.m_curView;
		param += "&act="     + this.m_curAct;
		param += "&boardId=" + this.m_curBoardId;
		param += "&evalSeq=" + this.m_curEvalSeq;
		
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adPoll.brd", param, true, {success: function(data) { aPM.getEvalMngr().doGetHandler(data);}});
	},
	doGetHandler : function (htmlData) {
		if (this.m_curView == "list") {
			this.m_elmArea.innerHTML = htmlData;
			$("#evalAccordion").accordion({
				autoHeight: false,
				change: function(event,ui) { aPM.getEvalMngr().m_curAcco = $("#evalAccordion").accordion("option","active");}
			});
			$("#evalAccordion").accordion("activate", this.m_curAcco);
		} else if (this.m_curView == "edit") { 
			document.getElementById("eval_pollArea").innerHTML = htmlData;
		}
	},
	doClear : function() {
		this.m_elmArea.innerHTML = "";
	},
	pollRequest : function (flag, view, act, evalSeq) {
		
		if (flag    != null) this.m_curFlag    = flag;
		if (view    != null) this.m_curView    = view;
		if (act     != null) this.m_curAct     = act;
		if (evalSeq != null) this.m_curEvalSeq = evalSeq;
		
		var param = "";

		if (this.m_curFlag == "") {
			aPM.getEvalMngr().doGet();
			return;
		} else if (this.m_curFlag == "list") { // 평점목록 조회
			this.m_curView = "list";
			aPM.getEvalMngr().doGet();
			return;
		} else if (this.m_curFlag == "save") { // 평점 저장
			
			if (!ebUtil.chkMinusNum  (document.getElementById("eval_from"),   ebUtil.getMessage('eb.info.ttl.p.pollEvalFrom'), 'true')) return; // 평점(FROM)에
			if (!ebUtil.chkMinusNum  (document.getElementById("eval_to"),   ebUtil.getMessage('eb.info.ttl.p.pollEvalTo'), 'true')) return; // 평점(TO)에
			
			if (Number(document.getElementById("eval_from").value) > Number(document.getElementById("eval_to").value)) {
				alert (ebUtil.getMessage('eb.info.poll.chkEvalRange'));	//'시작평점은 종료평점보다 클 수 없습니다.'
				document.getElementById("eval_from").focus();
				return;
			}
			
			if (!ebUtil.chkValue(document.getElementById("eval_remark"), ebUtil.getMessage('eb.info.ttl.o.pollEvalRemark'), 'true')) return; // 평점내용을
			if (!ebUtil.chkLength (document.getElementById("eval_remark"), ebUtil.getMessage('eb.info.ttl.pollEvalRemark'), 255, "true")) return;	//평점내용
			
			var evalSeq = document.getElementById("eval_seq").value;
			var evalFrom = document.getElementById("eval_from").value;
			var evalTo = document.getElementById("eval_to").value;
			
			if (!aPM.getEvalMngr().doEvalValidate(evalSeq, evalFrom, evalTo)) {
				alert (ebUtil.getMessage('eb.info.poll.dupEval')); // '중복되는 평점구간이 있습니다. 평점구간을 조정하십시오.'
				document.getElementById("eval_from").focus();
				return;
			}
			
			this.m_curView   = "list";
			this.m_curAct    = document.getElementById("eval_act").value;
			
			param += "m=setPollEval"
			param += "&view="     + this.m_curView;
			param += "&act="      + document.getElementById("eval_act").value;
			param += "&boardId="  + this.m_curBoardId;
			param += "&evalSeq="  + evalSeq;
			param += "&evalFrom=" + evalFrom;
			param += "&evalTo="   + evalTo;
			param += "&evalRemark=" + document.getElementById("eval_remark").value;
		} else if (this.m_curFlag == "del") { // 평점 삭제
			
			if (document.getElementById("eval_seq").value.trim() == "") {
				alert (ebUtil.getMessage('eb.info.pollEval.notSelect')); // '선택된 설문 평점이 없습니다'
				return;
			}		
			if (!confirm(ebUtil.getMessage('eb.info.confirm.del'))) return;

			this.m_curView   = "list";
			this.m_curAct    = "del";
			
			param += "m=setPollEval"
			param += "&view="     + this.m_curView;
			param += "&act="      + this.m_curAct;
			param += "&boardId="  + this.m_curBoardId;
			param += "&evalSeq="  + document.getElementById("eval_seq").value;
		
		}
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adPoll.brd", param, true, {success: function(data) { aPM.getEvalMngr().pollRequestHandler(data);}});
	},
	pollRequestHandler : function(data) {
		aPM.getMsgBox().doShow (ebUtil.getMessage("mm.info.success"));
		aPM.getEvalMngr().doGet();
	},
	doEvalValidate : function(evalSeq, evalFrom, evalTo) {	//평점 범위 Validate 체크
		var dupCnt = 0;
		
		$("input[id='list_evalSeq']").each(function() {
			var i = $("input[id='list_evalSeq']").index(this); 
		  
			var list_evalSeq = Number($("input[id='list_evalSeq']").eq(i).val());
			var list_evalFrom = Number($("input[id='list_evalFrom']").eq(i).val());
			var list_evalTo = Number($("input[id='list_evalTo']").eq(i).val());
		  
			if (evalSeq != list_evalSeq) {	//수정인 경우에는 자신과 같은 번호는 체크를 건너 뛴다.
				if ((list_evalFrom <= evalFrom && list_evalTo >= evalFrom) || (list_evalFrom <= evalTo && list_evalTo >= evalTo)) {
					dupCnt++;
				}			  
			}
		});
		
		if (dupCnt > 0) {	//범위가 중복되는 항목이 있을 경우.
			return false;
		} else {
			return true;	
		}
	}
}
AdmPollMngr.PartMngr = function( parent ) {
	this.m_elmArea = document.getElementById("apmPartTab");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_pageNavi = parent.m_pageNavi;
	this.m_checkBox = parent.m_checkBox; 
}
AdmPollMngr.PartMngr.prototype = {
	m_elmArea : null,
	m_contextPath : null,
	m_ajax : null,
	m_pageNavi : null,
	m_checkBox : null,
	m_curBoardId : null,
	m_curAcco : null,
	m_act : null,
	m_pageSize : 5,
	
	doGet : function(boardId) {
		if (boardId != null && boardId.length > 0) this.m_curBoardId = boardId;

		var param = "m=uiPollPartMng";
		param += "&boardId=" + this.m_curBoardId;
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adAuxil.brd", param, true, { success: function(data) { aPM.getPartMngr().doGetHandler(data); }});
	},
	doGetHandler : function (htmlData) {
		this.m_elmArea.innerHTML = htmlData;
		$("#partAccordion").accordion({
			autoHeight: false,
			change: function(event,ui) { 
				aPM.getPartMngr().m_curAcco = $("#partAccordion").accordion("option","active");
				switch (aPM.getPartMngr().m_curAcco) {
					case 1: aPM.getPartMngr().doInitAcco("role");  break;
					case 2: aPM.getPartMngr().doInitAcco("group"); break;
					case 3: aPM.getPartMngr().doInitAcco("user");  break;
				}
			}
		});
		$("#pathAccordion").accordion("activate", this.m_curAcco);
	},
	doClear : function() {
		this.m_elmArea.innerHTML = "";
	},
	doSave : function() {
		var param = "m=setPollPartType";
		param += "&boardId="    + this.m_curBoardId;
		param += "&selGradeId=" + ebUtil.getSelectedValue(document.getElementById("part_authGrade"));
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) { aPM.getPartMngr().doSaveHandler(data); }});
	},
	doSaveHandler : function( data ) {
		aPM.getMsgBox().doShow( ebUtil.getMessage("mm.info.success"));
		aPM.getPartMngr().doGet();		
	},
	doInitAcco : function (act, pageNo) {
		if( act != null && act != "" ) this.m_act = act;
		var param = "m=uiPollPartRGUList";
		param += "&act="        + this.m_act;
		param += "&view="       + "existList";
		param += "&pageNo="     + ((pageNo != null && pageNo != "") ? pageNo : 1);
		param += "&pageSize="   + this.m_pageSize;
		param += "&boardId="    + this.m_curBoardId;
		param += "&selGradeId=" + ebUtil.getSelectedValue(document.getElementById("part_authGrade"));
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) { aPM.getPartMngr().doInitAccoHandler(data); }});
	},
	doInitAccoHandler : function (htmlData) {
		if (this.m_act == "role") {
			document.getElementById("gradeRoleDiv").innerHTML = htmlData;
			var pageNo    = document.gradeRoleMngForm.pageNo.value;
			var totalSize = document.gradeRoleMngForm.totalSize.value;
			document.getElementById("part_role_page_iterator").innerHTML 
			= this.m_pageNavi.getPageIteratorHtmlString (pageNo, this.m_pageSize, totalSize, "gradeRoleMngForm", "aPM.getPartMngr().doRolePage");
		}
		if (this.m_act == "group") {
			document.getElementById("gradeGroupDiv").innerHTML = htmlData;
			var pageNo    = document.gradeGroupMngForm.pageNo.value;
			var totalSize = document.gradeGroupMngForm.totalSize.value;
			document.getElementById("part_group_page_iterator").innerHTML 
			= this.m_pageNavi.getPageIteratorHtmlString (pageNo, this.m_pageSize, totalSize, "gradeGroupMngForm", "aPM.getPartMngr().doGroupPage");
		}
		if (this.m_act == "user") {
			document.getElementById("gradeUserDiv").innerHTML = htmlData;
			var pageNo    = document.gradeUserMngForm.pageNo.value;
			var totalSize = document.gradeUserMngForm.totalSize.value;
			document.getElementById("part_user_page_iterator").innerHTML 
			= this.m_pageNavi.getPageIteratorHtmlString (pageNo, this.m_pageSize, totalSize, "gradeUserMngForm", "aPM.getPartMngr().doUserPage");
		}
	},
	doRolePage : function (formName, pageNo) {
		aPM.getPartMngr().doInitAcco("role", pageNo);
	},
	doGroupPage : function (formName, pageNo) {
		aPM.getPartMngr().doInitAcco("group", pageNo);
	},
	doUserPage : function (formName, pageNo) {
		aPM.getPartMngr().doInitAcco("user", pageNo);
	},
	getRoleChooser : function () {
		var domainId = document.getElementById("cate_domainId").value;
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId + "&";
		
		this.m_ajax.send("POST", this.m_contextPath + "/role/listForChooser.admin", param, false, {
			success: function(data){
				document.getElementById("RoleManager_RoleChooser").innerHTML = data;
				aRoleChooser = new RoleChooser(this.m_evSecurityCode, domainId, true);
			}});
		return aRoleChooser;
	},
	setRoleChooserCallback : function (rowArray) {
		var principalIds = "";
		for(var i=0; i<rowArray.length; i++) {
			principalIds += rowArray[i].get("principalId") + ",";
		}
		if( principalIds != '' ) principalIds = principalIds.substr( 0, principalIds.length - 1 );
		
		aPM.getPartMngr().doAddRGU('role',principalIds);
	},
	getGroupChooser : function () {
		var domainId = document.getElementById("cate_domainId").value;
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId + "&";
		
		this.m_ajax.send("POST", this.m_contextPath + "/group/listForChooser.admin", param, false, {
			success: function(data){
				document.getElementById("GroupManager_GroupChooser").innerHTML = data;
				aGroupChooser = new GroupChooser( this.m_evSecurityCode, domainId, true);
			}});
		
		return aGroupChooser;
	},
	setGroupChooserCallback : function (rowArray) {
		var principalIds = "";
		for(var i=0; i<rowArray.length; i++) {
			principalIds += rowArray[i].get("principalId") + ",";
		}
		if( principalIds != '' ) principalIds = principalIds.substr( 0, principalIds.length - 1 );
		
		aPM.getPartMngr().doAddRGU('group',principalIds);
	},	
	doChooseRGU : function (act) {
		if (act == "role" )	aPM.getRoleChooser().doShow(this.m_curBoardId, ebUtil.getSelectedValue(document.getElementById("part_authGrade")));
		if (act == "group") aPM.getGroupChooser().doShow(this.m_curBoardId, ebUtil.getSelectedValue(document.getElementById("part_authGrade")));
		if (act == "user" )	aPM.getUserChooser().doShow(this.m_curBoardId, ebUtil.getSelectedValue(document.getElementById("part_authGrade")));
	},
	doSelect : function (act, idx) {
		var checkedRow;
		if (act == "role" ) checkedRow = document.getElementById("part_role_checkRow_"+idx );
		if (act == "group") checkedRow = document.getElementById("part_group_checkRow_"+idx);
		if (act == "user" ) checkedRow = document.getElementById("part_user_checkRow_"+idx );
		if (checkedRow.checked) checkedRow.checked = false;
		else                   checkedRow.checked = true;
	},
	doAddRGU : function (act, rguIds) {
		this.m_act = act;
		var param = "m=setPollPartRGUList";
		param += "&act="        + this.m_act;
		param += "&cmd="        + "add";
		param += "&selGradeId=" + ebUtil.getSelectedValue(document.getElementById("part_authGrade"));
		param += "&rguIds="     + rguIds;
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) { aPM.getPartMngr().doSaveRGUHandler(data); }});
	},
	doRemRGU : function (act) {
		this.m_act = act;
		var rguIds = "";
		if (this.m_act == "role" ) {
			if (!ebUtil.chkCheck (document.getElementsByName("part_role_checkRow"), '삭제하고자 하는 역할을', true)) return;
			rguIds = ebUtil.getCheckedValues(document.getElementsByName("part_role_checkRow"));
		}
		if (this.m_act == "group") {
			if (!ebUtil.chkCheck (document.getElementsByName("part_group_checkRow"), '삭제하고자 하는 그룹을', true)) return;
			rguIds = ebUtil.getCheckedValues(document.getElementsByName("part_group_checkRow"));
		}
		if (this.m_act == "user" ) {
			if (!ebUtil.chkCheck (document.getElementsByName("part_user_checkRow"), '삭제하고자 하는 사용자를', true)) return;
			rguIds = ebUtil.getCheckedValues(document.getElementsByName("part_user_checkRow"));
		}
		if (confirm( ebUtil.getMessage("ev.info.remove"))) {
			var param = "m=setPollPartRGUList";
			param += "&act="        + this.m_act;
			param += "&cmd="        + "rem";
			param += "&selGradeId=" + ebUtil.getSelectedValue(document.getElementById("part_authGrade"));
			param += "&rguIds="     + rguIds;
			this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(data) { aPM.getPartMngr().doSaveRGUHandler( data ); }});
		}
	},
	doSaveRGUHandler : function (data) {
		aPM.getMsgBox().doShow (ebUtil.getMessage("mm.info.success"));
		aPM.getPartMngr().doInitAcco();		
	}
}
AdmPollMngr.RsltMngr = function (parent) {
	this.m_elmArea = document.getElementById("apmRsltTab");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_checkBox = parent.m_checkBox;
	this.m_pageNavi = parent.m_pageNavi;
}
AdmPollMngr.RsltMngr.prototype = {
	m_elmArea : null,
	m_contextPath : null,
	m_checkBox : null,
	m_pageNavi : null,
	m_curAcco : 0,
	m_curFlag : "",
	m_curView : "",
	m_curAct : "",
	m_curCmd : "",
	m_curBoardId : "",
	m_curPageNo : 1,
	m_curPageSize : 10,
	m_curTotalSize : 0,

	doGet : function (boardId) {
		// 상단 설문목록에서 최초로 호출될 때만 설문아이디가 넘어온다.
		if (boardId != null && boardId.length > 0) {
			this.m_curBoardId = boardId;
			this.m_curView    = "init";
		}
		
		this.m_curPageNo = 1;
		
		var param = "m=uiPollRsltMng";
		param += "&view="    + this.m_curView;
		param += "&boardId=" + this.m_curBoardId;
		if (this.m_curView == "rsltU") {
			param += "&userId=" + document.apmRsltPageForm.rslt_userId.value;
		}
		
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adPoll.brd", param, true, {success: function(htmlData) { aPM.getRsltMngr().doGetHandler(htmlData);}});
	},
	doGetHandler : function (htmlData) {
		if (this.m_curView == "init") {
			this.m_elmArea.innerHTML = htmlData;
			$("#rsltAccordion").accordion({
				autoHeight: false,
				change: function(event,ui) { aPM.getPollMngr().m_curAcco = $("#rsltAccordion").accordion("option","active");}
			});
			$("#rsltAccordion").accordion("activate", this.m_curAcco);
			aPM.getRsltMngr().pollRequest("","rsltT");
		} else if (this.m_curView == "rsltT") { //종합결과
			document.getElementById("pollTRUArea").innerHTML = htmlData;
			
			this.m_curTotalSize = document.apmRsltPageForm.rslt_totalSize.value;
			var pageNo    = this.m_curPageNo;
			var pageSize  = this.m_curPageSize;
			var totalSize = this.m_curTotalSize;
			
			document.getElementById("rslt_rslt_page_iterator").innerHTML 
			= this.m_pageNavi.getPageIteratorHtmlString (pageNo, pageSize, totalSize, "apmRsltSrchForm", "aPM.getRsltMngr().doRsltPage");
			
		} else if (this.m_curView == 'rsltU') {	//사용자 검색
			document.getElementById("pollURArea").innerHTML = htmlData;
		}	
	},
	doRsltPage : function (formName, pageNo) {
		this.m_curView = "rsltT";
		this.m_curAct  = "page";
		this.m_curPageNo = pageNo;
		aPM.getRsltMngr().doGetRsltList();
	},
	doClear : function() {
		this.m_elmArea.innerHTML = "";
	},
	doGetRsltList : function () {
		var frm;
		if (this.m_curAct == "page") frm = document.apmRsltPageForm;
		
		var param = "m=uiPollRsltMng";
		param += "&view="       + this.m_curView;
		param += "&act="        + this.m_curAct;
		param += "&boardId="    + this.m_curBoardId;
		param += "&pageNo="     + this.m_curPageNo;
		param += "&pageSize="   + this.m_curPageSize;
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adPoll.brd", param, true, {success: function(htmlData) { aPM.getRsltMngr().doGetHandler(htmlData);}});		
	},
	doGetUserList : function () {
		var frm;
		if (this.m_curAct == "srch") {
			frm = document.apmRsltSrchForm;
			this.m_curPageNo = 1;
		}
		if (this.m_curAct == "page") frm = document.apmRsltPageForm;
		if (frm.rslt_srchUserId.value == ebUtil.getMessage('eb.info.ttl.l.id'))   frm.rslt_srchUserId.value = "";
		if (frm.rslt_srchNmKor.value  == ebUtil.getMessage('eb.info.ttl.l.name')) frm.rslt_srchNmKor.value  = "";
		
		var param = "m=uiPollRsltMng";
		param += "&view="       + this.m_curView;
		param += "&act="        + this.m_curAct;
		param += "&boardId="    + this.m_curBoardId;
		param += "&pageNo="     + this.m_curPageNo;
		param += "&pageSize="   + this.m_curPageSize;
		param += "&srchUserId=" + frm.rslt_srchUserId.value;
		param += "&srchNmKor="  + frm.rslt_srchNmKor.value;
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adPoll.brd", param, true, {success: function(htmlData) { aPM.getRsltMngr().doGetUserListHandler(htmlData);}});
	},
	doGetUserListHandler : function (htmlData) {
		document.getElementById("pollTRUArea").innerHTML = htmlData;
		this.m_curTotalSize = document.apmRsltPageForm.rslt_totalSize.value;
		var pageNo    = this.m_curPageNo;
		var pageSize  = this.m_curPageSize;
		var totalSize = this.m_curTotalSize;
		document.getElementById("rslt_user_page_iterator").innerHTML 
		= this.m_pageNavi.getPageIteratorHtmlString (pageNo, pageSize, totalSize, "apmRsltSrchForm", "aPM.getRsltMngr().doPage");
		
		var frm = document.apmRsltSrchForm;
		if (frm.rslt_srchUserId.value == "") frm.rslt_srchUserId.value = ebUtil.getMessage('eb.info.ttl.l.id');
		if (frm.rslt_srchNmKor.value  == "") frm.rslt_srchNmKor.value  = ebUtil.getMessage('eb.info.ttl.l.name');
	},
	doPage : function (formName, pageNo) {
		this.m_curView = "listU";
		this.m_curAct  = "page";
		this.m_curPageNo = pageNo;
		aPM.getRsltMngr().doGetUserList();
	},
	doExelDown : function (cmd) {
		var frm = document.apmRsltSrchForm;
		frm.method ='POST';
		frm.action = this.m_contextPath+"/board/adPoll.brd?m=uiPollRsltMng&view=rsltX&cmd="+cmd+"&boardId="+this.m_curBoardId;
		frm.target = 'download';
		frm.submit();
	},
	pollRequest : function (flag, view, act, bltnNo) {
		
		if (flag    != null) this.m_curFlag    = flag;
		if (view    != null) this.m_curView    = view;
		if (act     != null) this.m_curAct     = act;
		if (bltnNo  != null) this.m_curBltnNo  = bltnNo;
		
		var param = "";

		if (this.m_curFlag == "") {
			if (this.m_curView == "rsltT") { // 종합결과
				aPM.getRsltMngr().doGet();
			} else if (view == 'listU') { // 설문결과조회에서 사용자 검색 시
				aPM.getRsltMngr().doGetUserList();
			} else if (view == 'rsltU') { // 사용자별 응답결과
				document.apmRsltPageForm.rslt_userId.value = bltnNo; // bltnNo에 선택된 사용자의 userId가 넘어옴.
				aPM.getRsltMngr().doGet();
			}
			return;
		}
	},
	pollRequestHandler : function(data) {
		aPM.getMsgBox().doShow (ebUtil.getMessage("pt.ev.admin.successful"));
		aPM.getQstnMngr().doGet();
	}
}
BoardChooser = function (parent) {
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_ajax.setContextPath (this.m_contextPath);
	this.m_pageNavi = parent.m_pageNavi;
	this.m_checkBox = parent.m_checkBox;
	
	$("#apmBoardChooser").dialog({
		autoOpen: false,
		resizable: true,
		width: 1000, 
		modal: true,
		buttons: {
			Cancel: function() {
				$(this).dialog("close");
			}
		}
	});
	this.init();
}
BoardChooser.prototype = {
	m_tree : null,
	m_ajax : null,
	m_pageNavi : null,
	m_checkBox : null,
	m_sourceElement1 : null,
	m_sourceElement2 : null,
	
	init : function() {
		this.m_tree = new dhtmlXTreeObject (document.getElementById('boardChooserCateTree'), "100%", "100%", 0);
		this.m_tree.setImagePath(this.m_contextPath + "/dhtmlx/imgs/dhxtree_skyblue/");
		this.m_tree.setOnClickHandler (this.onNodeSelect);
		this.m_tree.enableAutoTooltips (true);
		this.m_tree.setXMLAutoLoading (this.m_contextPath+"/board/adCate.brd?m=catebaseTree"); 
		this.m_tree.load (this.m_contextPath+"/board/adCate.brd?m=catebaseTree&id=2&act=root");
	},
	doShow : function (source1, source2) {
		this.m_sourceElement1 = document.getElementById (source1);
		this.m_sourceElement2 = document.getElementById (source2);
		aPM.getBoardChooser().doRetrieve();
		$('#apmBoardChooser').dialog('open');
	},
	onNodeSelect : function(id) {
		var srchForm = document.getElementById("boardChooserSearchForm");
		srchForm.pageNo.value = 1;
		aPM.getBoardChooser().doRetrieve();
	},
	doRetrieve : function() {
		if (aPM.getBoardChooser().m_tree.getSelectedItemId().length == 0) return; // 초기화시에 호출되어 선택된 node가 없을 때는 서버로 요청하지 않는다.
		var param = "m=cateBoard";
		var formElem = document.forms["boardChooserSearchForm"];
		for( var i=0; i<formElem.elements.length; i++ ) {
			param += "&" + formElem.elements[i].name + "=";
			var tmp = formElem.elements[i].value;
			if( tmp.lastIndexOf("*") > 0 ) {
				param += "";
			} else {
				param += encodeURIComponent( tmp );
			}
	    }
		param += "&cateId=" + aPM.getBoardChooser().m_tree.getSelectedItemId();
		this.m_ajax.send("POST", this.m_contextPath+"/board/adCate.brd", param, true, {success: function(data) { aPM.getBoardChooser().doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function(data) { 
		var bodyElem = document.getElementById('boardChooserListBody');
	    var tagTR = null;
	    var tagTD = null;

		this.m_checkBox.unChkAll( document.getElementById("boardChooserListForm") );
		for(; bodyElem.hasChildNodes(); )
			bodyElem.removeChild( bodyElem.childNodes[0] );

		for(i=0; i<data.Data.length; i++) {
			tagTR = document.createElement('tr');
			tagTR.id = "boardChooserBoardList"+i;
			tagTR.onmouseover = new Function( "ebUtil.activeLine(this,true)" );
			tagTR.onmouseout = new Function( "ebUtil.activeLine(this,false)" );
			tagTR.setAttribute("ch", i);
			tagTR.setAttribute("style", "cursor:pointer;");
			if (i % 2 == 1) {
				tagTR.setAttribute("class", "adgridline");
				tagTR.setAttribute("className", "adgridline");
			}
			
			tagTD = document.createElement('td');
			tagTD.align = "center";
			tagTD.setAttribute("class", "adgrid");
			tagTD.setAttribute("className", "adgrid");
			tagTD.innerHTML = "<input type='checkbox' id='boardChooser"+i+"_checkRow'/>";
			tagTD.innerHTML += "<input type='hidden' id='boardChooser"+i+"_boardId' value='"+data.Data[i].boardId+"'/>";
			tagTD.innerHTML += "<input type='hidden' id='boardChooser"+i+"_boardNm' value='"+data.Data[i].boardNm+"'/>";
			tagTR.appendChild( tagTD );

			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "adgrid");
			tagTD.setAttribute("className", "adgrid");
			tagTD.align = "left";
			tagTD.onclick = new Function( "aPM.getBoardChooser().doSelect(this)" );
			tagTD.innerHTML = "<span id='boardChooser"+i+"_boardId.label'>"+data.Data[i].boardId+"</span>";
			tagTR.appendChild( tagTD );

			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "adgrid");
			tagTD.setAttribute("className", "adgrid");
			tagTD.align = "left";
			tagTD.onclick = new Function( "aPM.getBoardChooser().doSelect(this)" );
			tagTD.innerHTML = "<span id='boardChooser"+i+"_boardNm.label'>"+data.Data[i].boardNm+"</span>";
			tagTR.appendChild( tagTD );

			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "adgrid");
			tagTD.setAttribute("className", "adgrid");
			tagTD.align = "left";
			tagTD.onclick = new Function( "aPM.getBoardChooser().doSelect(this)" );
			tagTD.innerHTML = "<span id='boardChooser"+i+"_boardTtl.label'>"+data.Data[i].boardTtl+"</span>";
			tagTR.appendChild( tagTD );

			tagTD = document.createElement('td');
			tagTD.setAttribute("class", "adgridlast");
			tagTD.setAttribute("className", "adgridlast");
			tagTD.align = "left";
			tagTD.onclick = new Function( "aPM.getBoardChooser().doSelect(this)" );
			tagTD.innerHTML = "<span style='width:100%;' id='boardChooser"+i+"_boardSkin.label'>"+data.Data[i].boardSkin+"</span>";
			tagTR.appendChild( tagTD );

			bodyElem.appendChild( tagTR );
		}
		tagTR = document.createElement( 'tr' );
		tagTD = document.createElement( 'td' );
		tagTD.height = "2";
		tagTD.colSpan = "5";
		tagTD.setAttribute("class", "adgridlimit");
		tagTD.setAttribute("className", "adgridlimit");
		tagTR.appendChild( tagTD );
		bodyElem.appendChild (tagTR);
		
		if( data.Data.length == 0 ) {
			tagTR = document.createElement('tr');
			tagTD = document.createElement('td');
			tagTD.height = "22";
			tagTD.colSpan = "5";
			tagTD.innerHTML = "<span>"+ebUtil.getMessage("ev.info.notFoundData")+"</span>";
			tagTR.appendChild( tagTD );
			bodyElem.appendChild( tagTR );
		}
		else {
			tagTR = document.createElement('tr');
			tagTD = document.createElement('td');
			tagTD.height = "22";
			tagTD.colSpan = "5";
			tagTD.innerHTML = "<span>"+ebUtil.getMessage("ev.info.resultSize", data.ResultSize)+"</span>";
			tagTR.appendChild( tagTD );
			bodyElem.appendChild( tagTR );
		}
		var formElem = document.forms[ "boardChooserSearchForm" ];
		var pageNo = formElem.elements[ "pageNo" ].value;
		var pageSize = formElem.elements[ "pageSize" ].value;
		var pageFunction = formElem.elements[ "pageFunction" ].value;
		var formName = formElem.elements[ "formName" ].value;
		document.getElementById("boardChooser_PAGE_ITERATOR").innerHTML = this.m_pageNavi.getPageIteratorHtmlString(pageNo, pageSize, data.TotalSize, formName, pageFunction);
	},
	doPage : function (formName, pageNo) {
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = pageNo;
		
		aPM.getBoardChooser().doRetrieve();
	},
	doSelect : function (obj) {
		var rowSeq = obj.parentNode.getAttribute("ch");
	    this.m_checkBox.unChkAll( document.getElementById("boardChooserListForm") );
	    document.getElementById('boardChooser'+rowSeq+'_checkRow').checked = true;
		
		var boardId = document.getElementById('boardChooser'+rowSeq+'_boardId').value;
		var boardNm = document.getElementById('boardChooser'+rowSeq+'_boardNm').value;
		
		this.m_sourceElement1.value = boardId;
		this.m_sourceElement2.value = boardNm;
		$('#apmBoardChooser').dialog("close");
	}
}
CateChooser = function( parent ) {
	this.m_contextPath = parent.m_contextPath;
	this.m_checkBox = parent.m_checkBox;
	
	$("#apmCateChooser").dialog({
		autoOpen: false,
		resizable: true,
		width:300, 
		modal: true,
		buttons: {
			Cancel: function() {
				$(this).dialog('close');
			},
			Select: function() {
				aPM.getCateChooser().doCateSelect();
			}
		}
	});
	this.init();
}
CateChooser.prototype = {
	m_contextPath : null,
	m_checkBox : null,
	m_tree : null,
	m_sourceElement1 :null,
	m_sourceElement2 :null,
	m_sourceElement3 :null,
	
	init : function() {
		this.m_tree = new dhtmlXTreeObject (document.getElementById('cateChooserCateTree'), "100%", "100%", 0);
		this.m_tree.setImagePath(this.m_contextPath + "/dhtmlx/imgs/dhxtree_skyblue/");
		this.m_tree.enableAutoTooltips (true);
		this.m_tree.setXMLAutoLoading (this.m_contextPath+"/board/adCate.brd?m=catebaseTree"); 
		this.m_tree.load (this.m_contextPath+"/board/adCate.brd?m=catebaseTree&id=2&act=root");
	},
	doShow : function (source1, source2, source3) {
		this.m_sourceElement1 = document.getElementById(source1);
		this.m_sourceElement2 = document.getElementById(source2);
		this.m_sourceElement3 = document.getElementById(source3);
		$('#apmCateChooser').dialog('open');
	},
	doCateSelect : function() {
		var id = this.m_tree.getSelectedItemId();
		if (this.m_tree.getLevel(id) == "1") return; // 루트노드 선택불가!
		this.m_sourceElement1.value = aPM.getCateChooser().m_tree.getSelectedItemId();
		this.m_sourceElement2.value = aPM.getCateChooser().m_tree.getSelectedItemText();
		this.m_sourceElement3.value = aPM.getCateChooser().m_tree.getUserData(aPM.getCateChooser().m_tree.getSelectedItemId(), "domainId");
		$('#apmCateChooser').dialog('close');
	}
}
/*
RoleChooser = function (parent) {
	this.m_elmArea = document.getElementById("apmRoleChooser");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_pageNavi = parent.m_pageNavi;
	this.m_checkBox = parent.m_checkBox;
	
	$("#apmRoleChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:600, 
		modal: true,
		buttons: {
			Cancel: function() {
				aPM.getRoleChooser().m_pageNo = 1;
				$(this).dialog('close');
			},
			Apply: function() {
				if( !ebUtil.chkCheck( document.getElementsByName("roleChooser_checkRow"), '추가하고자 하는 역할을', true )) return;
				aPM.getRoleChooser().m_pageNo = 1;
				aPM.getPartMngr().doAddRGU('role',ebUtil.getCheckedValues( document.getElementsByName("roleChooser_checkRow")));
				$(this).dialog('close');
			}
		}
	});
}
RoleChooser.prototype = {
	m_elmArea : null,
	m_checkedRow : null,
	m_contextPath : null,
	m_ajax : null,
	m_pageNavi : null,
	m_checkBox : null,
	m_curBoardId : null,
	m_selGradeId : null,
	m_pageNo : 1,
	m_pageSize : 5,
	m_totalSize : null,
	
	doGet : function() {
		var param = "m=uiPollPartRGUList";
		param += "&cmd="        + "own";
		param += "&act="        + "role";
		param += "&view="       + "chooseList";
		param += "&boardId="    + this.m_curBoardId;
		param += "&selGradeId=" + this.m_selGradeId;
		param += "&pageNo="     + this.m_pageNo;
		param += "&pageSize="   + this.m_pageSize;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { aPM.getRoleChooser().doGetHandler( htmlData ); }});		
	},
	doShow : function( boardId, selGradeId ) {
		this.m_curBoardId = boardId;
		this.m_selGradeId = selGradeId;
		aPM.getRoleChooser().doGet();
		$('#apmRoleChooser').dialog('open');
	},
	doGetHandler : function( htmlData ) {
		this.m_checkedRow = null; // 초기화
		this.m_elmArea.innerHTML = htmlData;
		this.m_totalSize = document.apmRoleChooserForm.totalSize.value;
		document.getElementById("apmRoleChooserPageIterator").innerHTML 
		= this.m_pageNavi.getPageIteratorHtmlString( this.m_pageNo, this.m_pageSize, this.m_totalSize, "apmRoleChooserForm", "aPM.getRoleChooser().doPage");
		
		var frm = document.apmRoleChooserForm;
		if( frm.srchShortPath.value     == "") frm.srchShortPath.value     = ebUtil.getMessage('eb.info.ttl.l.roleId');
		if (frm.srchPrincipalName.value == "") frm.srchPrincipalName.value = ebUtil.getMessage('eb.info.ttl.l.roleNm');

	},
	doPage : function( formName, pageNo ) {
		this.m_pageNo = pageNo;
		aPM.getRoleChooser().doGet();
	},
	doSelect : function( idx ) {
		var checkedRow = document.getElementById( "roleChooser_checkRow_"+idx );
		if(checkedRow.checked) checkedRow.checked = false;
		else                   checkedRow.checked = true;
	},
	doSearch : function() {
		var frm = document.apmRoleChooserForm;
		if (frm.srchShortPath.value     == ebUtil.getMessage('eb.info.ttl.l.roleId')) frm.srchShortPath.value     = "";
		if (frm.srchPrincipalName.value == ebUtil.getMessage('eb.info.ttl.l.roleNm')) frm.srchPrincipalName.value = "";
		var param = "m=uiPollPartRGUList";
		param += "&cmd="        + "own";
		param += "&act="        + "role";
		param += "&view="       + "chooseList";
		param += "&boardId="    + this.m_curBoardId;
		param += "&selGradeId=" + this.m_selGradeId;
		param += "&pageNo="     + 1;
		param += "&pageSize="   + this.m_pageSize;
		param += "&srchShortPath=" + frm.srchShortPath.value;
		param += "&srchPrincipalName=" + frm.srchPrincipalName.value;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { aPM.getRoleChooser().doGetHandler( htmlData ); }});		
	}
}
*/
/*
GroupChooser = function( parent ) {
	this.m_elmArea = document.getElementById("apmGroupChooser");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_pageNavi = parent.m_pageNavi;
	this.m_checkBox = parent.m_checkBox;
	
	$("#apmGroupChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:600, 
		modal: true,
		buttons: {
			Cancel: function() {
				aPM.getGroupChooser().m_pageNo = 1;
				$(this).dialog('close');
			},
			Apply: function() {
				if( !ebUtil.chkCheck( document.getElementsByName("groupChooser_checkRow"), '추가하고자 하는 그룹을', true )) return;
				aPM.getGroupChooser().m_pageNo = 1;
				aPM.getPartMngr().doAddRGU('group',ebUtil.getCheckedValues( document.getElementsByName("groupChooser_checkRow")));
				$(this).dialog('close');
			}
		}
	});
}
GroupChooser.prototype = {
	m_elmArea : null,
	m_checkedRow : null,
	m_ajax : null,
	m_pageNavi : null,
	m_contextPath : null,
	m_checkBox : null,
	m_curBoardId : null,
	m_selGradeId : null,
	m_pageNo : 1,
	m_pageSize : 5,
	m_totalSize : null,
	
	doGet : function() {
		var param = "m=uiPollPartRGUList";
		param += "&cmd="        + "own";
		param += "&act="        + "group";
		param += "&view="       + "chooseList";
		param += "&boardId="    + this.m_curBoardId;
		param += "&selGradeId=" + this.m_selGradeId;
		param += "&pageNo="     + this.m_pageNo;
		param += "&pageSize="   + this.m_pageSize;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { aPM.getGroupChooser().doGetHandler( htmlData ); }});		
	},
	doShow : function( boardId, selGradeId ) {
		this.m_curBoardId = boardId;
		this.m_selGradeId = selGradeId;
		aPM.getGroupChooser().doGet();
		$('#apmGroupChooser').dialog('open');
	},
	doGetHandler : function( htmlData ) {
		this.m_checkedRow = null; // 초기화
		this.m_elmArea.innerHTML = htmlData;
		this.m_totalSize = document.apmGroupChooserForm.totalSize.value;
		document.getElementById("apmGroupChooserPageIterator").innerHTML 
		= this.m_pageNavi.getPageIteratorHtmlString (this.m_pageNo, this.m_pageSize, this.m_totalSize, "apmGroupChooserForm", "aPM.getGroupChooser().doPage");
		
		var frm = document.apmGroupChooserForm;
		if( frm.srchShortPath.value     == "") frm.srchShortPath.value     = ebUtil.getMessage('eb.info.ttl.l.groupId');
		if (frm.srchPrincipalName.value == "") frm.srchPrincipalName.value = ebUtil.getMessage('eb.info.ttl.l.groupNm');

	},
	doPage : function( formName, pageNo ) {
		this.m_pageNo = pageNo;
		aPM.getGroupChooser().doGet();
	},
	doSelect : function( idx ) {
		var checkedRow = document.getElementById( "groupChooser_checkRow_"+idx );
		if(checkedRow.checked) checkedRow.checked = false;
		else                   checkedRow.checked = true;
	},
	doSearch : function() {
		var frm = document.apmGroupChooserForm;
		if (frm.srchShortPath.value     == ebUtil.getMessage('eb.info.ttl.l.groupId')) frm.srchShortPath.value     = "";
		if (frm.srchPrincipalName.value == ebUtil.getMessage('eb.info.ttl.l.groupNm')) frm.srchPrincipalName.value = "";
		var param = "m=uiPollPartRGUList";
		param += "&cmd="        + "own";
		param += "&act="        + "group";
		param += "&view="       + "chooseList";
		param += "&boardId="    + this.m_curBoardId;
		param += "&selGradeId=" + this.m_selGradeId;
		param += "&pageNo="     + 1;
		param += "&pageSize="   + this.m_pageSize;
		param += "&srchShortPath=" + frm.srchShortPath.value;
		param += "&srchPrincipalName=" + frm.srchPrincipalName.value;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { aPM.getGroupChooser().doGetHandler( htmlData ); }});		
	}
}
*/
UserChooser = function( parent ) {
	this.m_elmArea = document.getElementById("apmUserChooser");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_pageNavi = parent.m_pageNavi;
	this.m_checkBox = parent.m_checkBox;
	
	$("#apmUserChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:600, 
		modal: true,
		buttons: {
			Cancel: function() {
				aPM.getUserChooser().m_pageNo = 1;
				$(this).dialog('close');
			},
			Apply: function() {
				if( !ebUtil.chkCheck( document.getElementsByName("userChooser_checkRow"), '추가하고자 하는 사용자를', true )) return;
				aPM.getUserChooser().m_pageNo = 1;
				aPM.getPartMngr().doAddRGU('user',ebUtil.getCheckedValues( document.getElementsByName("userChooser_checkRow")));
				$(this).dialog('close');
			}
		}
	});
}
UserChooser.prototype = {
	m_elmArea : null,
	m_checkedRow : null,
	m_contextPath : null,
	m_ajax : null,
	m_pageNavi : null,
	m_checkBox : null,
	m_curBoardId : null,
	m_selGradeId : null,
	m_pageNo : 1,
	m_pageSize : 5,
	m_totalSize : null,
	
	doGet : function() {
		var param = "m=uiPollPartRGUList";
		param += "&cmd="        + "own";
		param += "&act="        + "user";
		param += "&view="       + "chooseList";
		param += "&boardId="    + this.m_curBoardId;
		param += "&selGradeId=" + this.m_selGradeId;
		param += "&pageNo="     + this.m_pageNo;
		param += "&pageSize="   + this.m_pageSize;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { aPM.getUserChooser().doGetHandler( htmlData ); }});		
	},
	doShow : function( boardId, selGradeId ) {
		this.m_curBoardId = boardId;
		this.m_selGradeId = selGradeId;
		aPM.getUserChooser().doGet();
		$('#apmUserChooser').dialog('open');
	},
	doGetHandler : function( htmlData ) {
		this.m_checkedRow = null; // 초기화
		this.m_elmArea.innerHTML = htmlData;
		this.m_totalSize = document.apmUserChooserForm.totalSize.value;
		document.getElementById("apmUserChooserPageIterator").innerHTML 
		= this.m_pageNavi.getPageIteratorHtmlString( this.m_pageNo, this.m_pageSize, this.m_totalSize, "apmUserChooserForm", "aPM.getUserChooser().doPage");
		
		var frm = document.apmUserChooserForm;
		if( frm.srchUserId.value == "") frm.srchUserId.value = ebUtil.getMessage('eb.info.ttl.l.id');
		if (frm.srchNmKor.value  == "") frm.srchNmKor.value  = ebUtil.getMessage('eb.info.ttl.l.name');

	},
	doPage : function( formName, pageNo ) {
		this.m_pageNo = pageNo;
		aPM.getUserChooser().doGet();
	},
	doSelect : function( idx ) {
		var checkedRow = document.getElementById( "userChooser_checkRow_"+idx );
		if(checkedRow.checked) checkedRow.checked = false;
		else                   checkedRow.checked = true;
	},
	doSearch : function() {
		var frm = document.apmUserChooserForm;
		if (frm.srchUserId.value == ebUtil.getMessage('eb.info.ttl.l.id'))   frm.srchUserId.value = "";
		if (frm.srchNmKor.value  == ebUtil.getMessage('eb.info.ttl.l.name')) frm.srchNmKor.value  = "";
		var param = "m=uiPollPartRGUList";
		param += "&cmd="        + "own";
		param += "&act="        + "user";
		param += "&view="       + "chooseList";
		param += "&boardId="    + this.m_curBoardId;
		param += "&selGradeId=" + this.m_selGradeId;
		param += "&pageNo="     + 1;
		param += "&pageSize="   + this.m_pageSize;
		param += "&srchUserId=" + frm.srchUserId.value;
		param += "&srchNmKor="  + frm.srchNmKor.value;
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adAuxil.brd", param, true, {success: function(htmlData) { aPM.getUserChooser().doGetHandler( htmlData ); }});		
	}
}
PollJoinUserMngr = function( parent ) {
	this.m_elmArea = document.getElementById("apmPollJoinUserMngr");
	this.m_contextPath = parent.m_contextPath;
	this.m_ajax = parent.m_ajax;
	this.m_pageNavi = parent.m_pageNavi;
	
	$("#apmPollJoinUserMngr").dialog({
		autoOpen: false,
		resizable: false,
		width:600, 
		modal: true,
		buttons: {
			Cancel: function() {
				aPM.getUserChooser().m_pageNo = 1;
				$(this).dialog('close');
			}
		}
	});
}
PollJoinUserMngr.prototype = {
	m_elmArea : null,
	m_checkedRow : null,
	m_contextPath : null,
	m_ajax : null,
	m_pageNavi : null,
	m_checkBox : null,
	m_curBoardId : null,
	m_bltnNo : null,
	m_pollSeq : null,
	m_quesCntt : null,
	m_anwsCntt : null,
	m_pageNo : 1,
	m_pageSize : 5,
	m_totalSize : null,
	
	doGet : function() {
		var param = "m=uiPollRsltMng";
		param += "&view="       + "rsltTUP";
		param += "&boardId="    + this.m_curBoardId;
		param += "&bltnNo=" 	+ this.m_bltnNo;
		param += "&pollSeq=" 	+ this.m_pollSeq;
		param += "&pageNo="     + this.m_pageNo;
		param += "&pageSize="   + this.m_pageSize;
		
		this.m_ajax.send( "POST", this.m_contextPath+"/board/adPoll.brd", param, true, {success: function(htmlData) { aPM.getPollJoinUserMngr().doGetHandler( htmlData ); }});		
	},
	doShow : function( boardId, bltnNo, pollSeq, quesCntt, anwsCntt ) {
		this.m_curBoardId = boardId;
		this.m_bltnNo = bltnNo;
		this.m_pollSeq = pollSeq;
		this.m_quesCntt = quesCntt;
		this.m_anwsCntt = anwsCntt;
		
		aPM.getPollJoinUserMngr().doGet();
		$('#apmPollJoinUserMngr').dialog('option', 'title', this.m_quesCntt + " (" + this.m_anwsCntt + ") _ 설문참여자");
		$('#apmPollJoinUserMngr').dialog('open');
	},
	doGetHandler : function( htmlData ) {
		this.m_elmArea.innerHTML = htmlData;
		this.m_totalSize = document.apmPollJoinUserMngrForm.totalSize.value;
		document.getElementById("apmPollJoinUserPageIterator").innerHTML 
		= this.m_pageNavi.getPageIteratorHtmlString( this.m_pageNo, this.m_pageSize, this.m_totalSize, "apmPollJoinUserMngrForm", "aPM.getPollJoinUserMngr().doPage");
	},
	doPage : function( formName, pageNo ) {
		this.m_pageNo = pageNo;
		aPM.getPollJoinUserMngr().doGet();
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
			//$(".ui-dialog-titlebar-close").hide(); 
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

