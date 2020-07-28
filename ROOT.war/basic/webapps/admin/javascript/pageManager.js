var aPageManager = null;
PageManager = function(evSecurityCode)
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	this.m_validator = new enview.util.Validator();
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = portalPage.getContextPath();
	this.m_selectRowIndex = 0;
	this.m_evSecurityCode = evSecurityCode;
	if( portalPage == null) portalPage = new enview.portal.Page();
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 	
}
PageManager.prototype =
{
	m_ajax : null,
	m_checkBox : null,
	m_validator : null,
	m_utility : null,
	m_contextPath : null,
	m_selectRowIndex : 0,
	m_contextMenu : null,
	m_dataStructure : null,
	m_maximize : false,
	m_evSecurityCode : null,
	m_editMode : true,	
	init : function() { 
		this.m_dataStructure = [
			 {"fieldName":"path", "validation":"Required,MaxLength", "maxLength":"240"}
			,{"fieldName":"pageId", "validation":""}
			,{"fieldName":"parentId", "validation":""}
			,{"fieldName":"domainId", "validation":""}
			,{"fieldName":"systemCode", "validation":""}
			,{"fieldName":"depth", "validation":""}
			,{"fieldName":"name", "validation":"Required,MaxLength", "maxLength":"80"}
			,{"fieldName":"type", "validation":"MaxLength", "maxLength":"2"}
			,{"fieldName":"pageType", "validation":""}
			,{"fieldName":"title", "validation":"Required,MaxLength", "maxLength":"300"}
			,{"fieldName":"shortTitle", "validation":"Required,MaxLength", "minLength":"4",  "maxLength":"150"}
			,{"fieldName":"sortOrder", "validation":""}
			,{"fieldName":"isHidden", "validation":""}
			,{"fieldName":"isQuickMenu", "validation":""}
			,{"fieldName":"isAllowGuest", "validation":""}
			,{"fieldName":"isProtected", "validation":""}
			,{"fieldName":"useTheme", "validation":""}
			,{"fieldName":"useIframe", "validation":""}
			,{"fieldName":"defaultPageName", "validation":"MaxLength", "maxLength":"80"}
			,{"fieldName":"defaultPagePath", "validation":""}
			,{"fieldName":"target", "validation":""}
			,{"fieldName":"url", "validation":"MaxLength", "maxLength":"255"}
			,{"fieldName":"parameter", "validation":"MaxLength", "maxLength":"120"}
			,{"fieldName":"skin", "validation":"MaxLength", "maxLength":"80"}
			,{"fieldName":"defaultLayoutDecorator", "validation":""}
			,{"fieldName":"owner", "validation":"MaxLength", "maxLength":"250"}
			,{"fieldName":"masterPagePath", "validation":"MaxLength", "maxLength":"240"}
			,{"fieldName":"pageInfo01", "validation":"MaxLength", "maxLength":"100"}
			,{"fieldName":"pageInfo02", "validation":"MaxLength", "maxLength":"100"}
			,{"fieldName":"pageInfo03", "validation":"MaxLength", "maxLength":"100"}
		]
		
		this.m_contextMenu = aPageMenu = new PageMenu(this.m_contextPath);
		//alert("contextPath=" + this.m_contextPath);
		this.m_dhtmlxContextMenu = new dhtmlXMenuObject();
		this.m_dhtmlxContextMenu.renderAsContextMenu();
		this.m_dhtmlxContextMenu.attachEvent("onClick",this.onDhtmlxContextClick);
		this.m_dhtmlxContextMenu.loadFromHTML("dhtmlx_context_data", true);
		this.m_tree = new dhtmlXTreeObject(document.getElementById('PageManager_TreeTabPage'),"100%","100%",0);
		this.m_tree.setImagePath(this.m_contextPath + "/dhtmlx/imgs/dhxtree_skyblue/");
		//alert(this.m_tree.getImagePath());
		this.m_tree.setOnClickHandler( this.onNodeSelect );
		//this.m_tree.enableDragAndDrop(true)
		//this.m_tree.setDragHandler( this.onDragAndDrop );
		//this.m_tree.setOnRightClickHandler( this.onContextMenuHandler );
		//this.m_tree.enableAutoTooltips(true);
		//this.m_tree.setChildCalcMode(true);
		//this.m_tree.enableItemEditor(true);
		//this.m_tree.enableKeyboardNavigation(true);
		this.m_tree.enableContextMenu(this.m_dhtmlxContextMenu);
		this.m_tree.attachEvent("onBeforeContextMenu", function (id) {
			aPageManager.onNodeSelect( id );
			aPageManager.m_contextMenu.setItemId( id );
			return true;
		});
		this.m_tree.setXMLAutoLoading(this.m_contextPath + "/page/retrieveTreeForAjax.admin?evSecurityCode=" + this.m_evSecurityCode);
		this.m_tree.load(this.m_contextPath + "/page/retrieveTreeForAjax.admin?id=1&evSecurityCode=" + this.m_evSecurityCode);
		
		$.datepicker.setDefaults({
			showMonthAfterYear: true,
			changeMonth: true,
			changeYear: true,
			showButtonPanel: true,
			showAnim : 'slideDown',
			dateFormat : 'yy-mm-dd'
		});
		
		$(function() {
			$("#PageManager_mainTabs").tabs();
			$("#PageManager_propertyTabs").tabs();
		});
		
		var propertyTabs = $("#PageManager_mainTabs").tabs();

		propertyTabs.tabs('option', 'active', 1);
		
		document.onkeyup = aPageManager.onCheckKey;
	},
	
	selectLinkPage : function(popupTitle){
		aPageManager.getPageChooser(null,'Y').doShow(aPageManager.setPageChooserCallback, popupTitle);
	},
	
	getPageChooser : function (hideIfSelfId, showPublic) {
		var domainId = $('#PageManager_Master_domainId').val();
		var extraParam = "";
		if(hideIfSelfId) extraParam += "&hideIfSelfId=" + hideIfSelfId;
		if(showPublic) extraParam += "&showPublic=" + showPublic;
//		if( aPageChooser == null ) {
			aPageChooser = new PageChooser( aPageManager.m_evSecurityCode, domainId, extraParam );
//		}
		return aPageChooser;
	},
	setPageChooserCallback : function (rowArray) {
		document.getElementById("PageManager_defaultPageName").value = rowArray[0].get("pageId");
		document.getElementById("PageManager_defaultPagePath").value = rowArray[0].get("pagePath");
	},
	setPageChooserForMoveCallback : function (rowArray) 
	{
		var itemId = aPageManager.getContextMenu().getItemId();
		var pageId = rowArray[0].get("pageId");
		var pagePath = rowArray[0].get("pagePath");
		var param = "id=" + pageId;
		var myDomainId =  parseInt($("#PageManager_Master_domainId").val());
		var tagetDomainId = 0;
		
		if($("#PageManager_parentId").val() == pageId) {
		  //alert(portalPage.getMessageResource('ev.error.tree.alreadyReg'));
		} else {
		this.m_ajax.send("POST", this.m_contextPath + "/page/domainIdfind.admin", param, false, {success: function(data){
			  tagetDomainId = parseInt(data);
			  if(myDomainId == tagetDomainId){
				  var msg = portalPage.getMessageResourceByParam('ev.info.tree.node.move', aPageManager.m_tree.getItemText(itemId), aPageManager.m_tree.getItemText(pageId));
				  var ret = confirm( msg );
			  if(ret == true){
				  aPageManager.doMoveParentTree(itemId, pageId);
				}
			    } else{
				  alert(portalPage.getMessageResource('ev.info.domain.movePage'));
				}
			}});
		 }
	 },
	setPageChooserForCopyCallback : function (rowArray) {
		var itemId = aPageManager.getContextMenu().getItemId();
		
		var pageId = rowArray[0].get("pageId");
		var pagePath = rowArray[0].get("pagePath");
		
		//alert("copy pageId=" + pageId + ", pagePath=" + pagePath);
		var msg = portalPage.getMessageResourceByParam('ev.info.tree.node.copy', aPageManager.m_tree.getItemText(itemId), aPageManager.m_tree.getItemText(pageId));
		var ret = confirm( msg );
		if( ret == true ) {
			ret = confirm( portalPage.getMessageResource('ev.info.tree.node.copyAll') );
			if( ret == true ) {
				aPageManager.doCopyTree(itemId, pageId, true);
			}
			else {
				aPageManager.doCopyTree(itemId, pageId, false);
			}
		}
	},
	getUserChooser : function () {
		var domainId = $('#PageManager_Master_domainId').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId + "&byDomain=Y&existsDomain=Y&";
		var extraParam = "&byDomain=Y&existsDomain=Y&";
		if( aUserChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/user/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("UserManager_UserChooser").innerHTML = data;
					aUserChooser = new UserChooser( aPageManager.m_evSecurityCode, domainId, extraParam );
				}});
		}
		return aUserChooser;
	},
	setUserChooserCallback : function (rowArray) {
		var chooseVal = "";
		for(var i=0; i<rowArray.length; i++) {
		
			chooseVal += rowArray[i].get("pageId") + ":";
		
			var selectElem = document.getElementById("PageManager_owner_list");
			var newOpt = document.createElement("OPTION");
			newOpt.text = rowArray[i].get("principalName") + 
						 " [" + rowArray[i].get("shortPath") + "]";
			newOpt.name = "";
			newOpt.value = rowArray[i].get("principalId");
			try {
				selectElem.add(newOpt, null); // standards compliant; doesn't work in IE
			}
			catch(ex) {
				selectElem.add(newOpt, selectElem.options.length); // IE only
			}
		}
	
		var owners = "";
		for(var i=0; i<selectElem.options.length; i++) {
			if( i > 0 ) owners += ",";
			owners += selectElem.options[i].value;
		}
		document.getElementById("PageManager_owner").value = owners;
	},
	getPortletChooser : function () {
		if( portalPortletSelectorApp == null ) {
			portalPortletSelectorApp = new enview.portal.PortletSelectorApp( aPageManager.m_evSecurityCode );
			portalPortletSelectorApp.init();
		}
		return portalPortletSelectorApp;
	},
	setPortletChooserCallback : function (rowArray) {
		document.getElementById("PageManager_url").value = rowArray[0].get("app") + "::" + rowArray[0].get("name");
	},
	getExcelFileDialog : function () {
		if( aExcelUploader == null ) {
			aExcelUploader = new ExcelUploader();
		}
		return aExcelUploader;
	},
	getContextMenu : function()
	{
		return this.m_contextMenu;
	},
	onContextMenuHandler : function (treeitemId, item) {	
		aPageManager.doShowContextMenu( treeitemId, item );
	},
	onRefresh : function (id) {
		var treeitemId = (id) ? id : aPageManager.getContextMenu().getItemId();
		//alert("treeitemId=" + treeitemId);
		aPageManager.getContextMenu().hide();
		if( treeitemId == 1 ) { aPageManager.m_tree.deleteChildItems( 0 ); }
		if( treeitemId != null ) {
			aPageManager.m_tree.refreshItem( treeitemId );
		}
	},
	onCheckKey : function (a_event) {
		if( document.all ) {
			if( event.keyCode ) {
				if( event.ctrlKey == true && event.keyCode == 90 ) {
					aPageManager.toggleMaximize();
				}
				else if( event.ctrlKey == true && event.keyCode == 38 ) {
					aPageManager.doMoveUpNodeTree( aPageManager.m_tree.getSelectedItemId() );
				}
				else if( event.ctrlKey == true && event.keyCode == 40 ) {
					aPageManager.doMoveDownNodeTree( aPageManager.m_tree.getSelectedItemId() );
				}
			}
		}
		else {
			if( a_event.ctrlKey == true && a_event.keyCode == 90 ) {
				aPageManager.toggleMaximize();
			}
			else if( a_event.ctrlKey == true && a_event.keyCode == 38 ) {
				aPageManager.doMoveUpNodeTree( aPageManager.m_tree.getSelectedItemId() );
			}
			else if( a_event.ctrlKey == true && a_event.keyCode == 40 ) {
				aPageManager.doMoveDownNodeTree( aPageManager.m_tree.getSelectedItemId() );
			}
		}
	},
	onCreate : function () {		
		var treeitemId = aPageManager.getContextMenu().getItemId();		
		if( this.m_tree.getLevel(treeitemId)==1 ) {
			//alert( portalPage.getMessageResourceByParam('ev.error.tree.createGroupRoot') );
			return;
		} 		
		aPageManager.doCreate( treeitemId );
	},
	onDelete : function () {
		var treeitemId = aPageManager.getContextMenu().getItemId();
		if( this.m_tree.getLevel(treeitemId)==1) {
			//alert( portalPage.getMessageResourceByParam('ev.error.tree.deleteGroupRoot') );
			return;
		} 
		return aPageManager.doDeleteTree(treeitemId);
	},
	onMove : function () 
	{
		var treeitemId = aPageManager.getContextMenu().getItemId();		
		if( this.m_tree.getLevel(treeitemId)==1 || this.m_tree.getLevel(treeitemId)==2) {
			//alert( portalPage.getMessageResourceByParam('ev.error.tree.deleteGroupRoot') );
			return;
		} 
		aPageManager.getPageChooser($('#PageManager_Master_pageId').val()).doShow(aPageManager.setPageChooserForMoveCallback, portalPage.getMessageResource('ev.info.select.movePage'))
	},
	onCopy : function () {
		var treeitemId = aPageManager.getContextMenu().getItemId();
		if( this.m_tree.getLevel(treeitemId)==1) {
			//alert( portalPage.getMessageResourceByParam('ev.error.tree.deleteGroupRoot') );
			return;
		} 
		aPageManager.getPageChooser($('#PageManager_Master_pageId').val()).doShow(aPageManager.setPageChooserForCopyCallback, portalPage.getMessageResource('ev.info.select.copyPage'))
		//return aPageManager.onMove(treeitemId);
	},
	//onDragAndDrop : function (item_id, parent_id, before, item, parent) {
	onDragAndDrop : function (item_id, parent_id, before, item, parent, subKey) {
		//alert("subKey=" + subKey);
		if( item_id == 1 ) {
			alert( portalPage.getMessageResourceByParam('ev.info.forbiden.updateRoot') );
			return;
		}
		
		if( subKey == 0 || subKey == null ) {	// move
			var msg = portalPage.getMessageResourceByParam('ev.info.tree.node.move', aPageManager.m_tree.getItemText(item_id), aPageManager.m_tree.getItemText(parent_id));
			var ret = confirm( msg );
			if( ret == true ) {
				aPageManager.doMoveParentTree(item_id, parent_id);
				return false;
			}
			else return false;
		}
		else if( subKey == 1 ) { // shiftKey (move order)
			return false;
		}
		else if( subKey == 2 ) { // ctrlKey (copy)
			var msg = portalPage.getMessageResourceByParam('ev.info.tree.node.copy', aPageManager.m_tree.getItemText(item_id), aPageManager.m_tree.getItemText(parent_id));
			var ret = confirm( msg );
			if( ret == true ) {
				aPageManager.doCopyParentTree(item_id, parent_id);
				return false;
			}
			else return false;
		}
		else if( subKey == 3 ) { // altKey
			return false;
		}
		else {
			return true;
		}
		
	},
	onMoveUp : function () {
		var treeitemId = aPageManager.getContextMenu().getItemId();
		if(this.m_tree.getLevel(treeitemId)==1 || this.m_tree.getLevel(treeitemId)==2) {
			//alert( portalPage.getMessageResourceByParam('ev.error.tree.moveUpGroupRoot') );
			return;
		}
		aPageManager.doMoveUpNodeTree( treeitemId );
		
	},
	onMoveDown : function () {
		var treeitemId = aPageManager.getContextMenu().getItemId();		
		if(this.m_tree.getLevel(treeitemId)==1 || this.m_tree.getLevel(treeitemId)==2) {
			//alert( portalPage.getMessageResourceByParam('ev.error.tree.moveDownGroupRoot') );
			return;
		} 
		aPageManager.doMoveDownNodeTree( treeitemId );		
	},
	onNodeSelect : function (id) {
		var item_id = aPageManager.m_tree.getSelectedItemId();
		var parent = aPageManager.m_tree.getParentId(item_id);
		aPageManager.makePopupMenuSyle(parent,"#a9a9a9");
		
		aPageManager.m_contextMenu.hide();
		aPageManager.doSelectTree(id);
	},
	makePopupMenuSyle : function (parentId, color){
		var htmlStr = "";
		var hr =  "<hr>";
		var onRefresh_0 = "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageManager.onRefresh()' style='color:" + color  + "';><img src='" + this.m_contextPath + "/admin/images/Service.gif'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.refresh') + "</a></div>";
		var onCreate_0 = "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageManager.onCreate()' style='color:" + color  + "';><img src='" + this.m_contextPath + "/admin/images/ic_make_page.gif'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.addPage') + "</a></div>";
		var onDelete_0 = "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageManager.onDelete()' style='color:" + color  + "';><img src='" + this.m_contextPath + "/admin/images/ic_del_b.gif'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.deletePage') + "</a></div>";
		var onMove_0 = "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageManager.onMove()'  style='color:" + color  + "';><img src='" + this.m_contextPath + "/admin/images/movePage.png'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.movePage') + "</a></div>";
		var onCopy_0 = "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageManager.onCopy()' style='color:" + color  + "';><img src='" + this.m_contextPath + "/admin/images/copyPage.png'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.copyPage') + "</a></div>";
        var onMoveUp_0 = "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageManager.onMoveUp()' style='color:" + color  + "';><img src='" + this.m_contextPath + "/admin/images/ic_up.gif'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.moveUp') + "</a></div>";
        var onMoveDown_0 = "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageManager.onMoveDown()' style='color:" + color  + "';><img src='" + this.m_contextPath + "/admin/images/ic_down.gif'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.moveDown') + "</a></div>";
        var getExcelFileDialog_0 = "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageManager.getExcelFileDialog().doShow()' style='color:" + color  + "';><img src='" + this.m_contextPath + "/admin/images/import.png'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.loadExcel') + "</a></div>";
        var doExportExcel_0 = "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageManager.doExportExcel()' style='color:" + color  + ";><img src='" + this.m_contextPath + "/admin/images/export.png'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.saveExcel') + "</a></div>";
        var onRefresh_1 = "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageMenu.hide(); aPageManager.onRefresh()'><img src='" + this.m_contextPath + "/admin/images/Service.gif'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.refresh') + "</a></div>";
		var onCreate_1 = "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageMenu.hide(); aPageManager.onCreate()' ><img src='" + this.m_contextPath + "/admin/images/ic_make_page.gif'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.addPage') + "</a></div>";
		var onDelete_1 = "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageMenu.hide(); aPageManager.onDelete()' ><img src='" + this.m_contextPath + "/admin/images/ic_del_b.gif'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.deletePage') + "</a></div>";
		var onMove_1 = "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageMenu.hide(); aPageManager.onMove()'><img src='" + this.m_contextPath + "/admin/images/movePage.png'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.movePage') + "</a></div>";
		var onCopy_1 = "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageMenu.hide(); aPageManager.onCopy()'><img src='" + this.m_contextPath + "/admin/images/copyPage.png'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.copyPage') + "</a></div>";
		var onMoveUp_1 = "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageMenu.hide(); aPageManager.onMoveUp()'><img src='" + this.m_contextPath + "/admin/images/ic_up.gif'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.moveUp') + "</a></div>";
		var onMoveDown_1 = "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageMenu.hide(); aPageManager.onMoveDown()' ><img src='" + this.m_contextPath + "/admin/images/ic_down.gif'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.moveDown') + "</a></div>";
		var getExcelFileDialog_1 = "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageMenu.hide(); aPageManager.getExcelFileDialog().doShow()' ><img src='" + this.m_contextPath + "/admin/images/import.png'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.loadExcel') + "</a></div>";
		var doExportExcel_1 = "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageMenu.hide(); aPageManager.doExportExcel()'><img src='" + this.m_contextPath + "/admin/images/export.png'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.saveExcel') + "</a></div>";
		if(parentId==0) {
			htmlStr += onRefresh_1 + onCreate_0 + onDelete_0 + onMove_0 + onCopy_0 + hr + onMoveUp_0 + onMoveDown_0 + hr +getExcelFileDialog_0 + doExportExcel_1;
		} else if(parentId==1) {
			htmlStr += onRefresh_1 + onCreate_1 + onDelete_1 + onMove_0 + onCopy_1 + hr + onMoveUp_0 + onMoveDown_0 + hr +getExcelFileDialog_1 + doExportExcel_1;
		}
		else {
			htmlStr += onRefresh_1 + onCreate_1 + onDelete_1 + onMove_1 + onCopy_1 + hr + onMoveUp_1 + onMoveDown_1 + hr +getExcelFileDialog_1 + doExportExcel_1;
		}	
		$("#PageManager_PageMenu").html(htmlStr);
	},
	toggleMaximize : function () {
		//var leftMenu = document.getElementById("Enview.LeftMenu");
		var leftMenu = document.getElementById("Enview.LeftMenu");
		var left = document.getElementById("PageManager_Left");
		var title = document.getElementById("PageManager_Left_Title");
		var right = document.getElementById("PageManager_Right");
		if( this.m_maximize == false ) {
			//alert("ns6=" + ns6);
			//document.getElementById("PageManager_PreviewPane").style.width=ns6? window.innerWidth-20 : document.body.clientWidth
			//document.getElementById("PageManager_PreviewPane").style.height=ns6? window.innerHeight-20 : document.body.clientHeight
			
			aPageManager.m_oldTabWidth = right.clientWidth;
			aPageManager.m_oldTabHeight = right.clientHeight;
			//leftMenu.style.width = "0";
			left.style.width = "0";
			left.style.display = "none";
			//right.style.width = "100%";
			title.style.display = "none";
			this.m_maximize = true;
		}
		else {
			//leftMenu.style.width = "180px";
			left.style.width = "280px";
			left.style.display = "";
			//right.style.width = "74%";
			title.style.display = "";
			this.m_maximize = false;
		}
	},
	doShowContextMenu : function(id, item) {
		this.onNodeSelect( id );
		var pos = (new enview.util.Utility()).getAbsolutePosition( item );

		this.m_contextMenu.setItemId( id );
		this.m_contextMenu.show( pos.getX()+45, pos.getY()+20 );
	},
	onDhtmlxContextClick : function (menuitemId, type) {
		if (menuitemId == "onRefresh") {
			aPageManager.onRefresh();
		} else if (menuitemId == "onCreate") {
			aPageManager.onCreate();
		} else if (menuitemId == "onMoveUp") {
			aPageManager.onMoveUp();
		} else if (menuitemId == "onMoveDown") {
			aPageManager.onMoveDown();
		} else if (menuitemId == "onDelete") {
			aPageManager.onDelete();
		} else if (menuitemId == "onMove") {
			aPageManager.onMove()
		} else if (menuitemId == "onCopy") {
			aPageManager.onCopy()
		} else if (menuitemId == "onImportExcel") {
			aPageManager.getExcelFileDialog().doShow();
		} else if (menuitemId == "onExportExcel") {
			aPageManager.doExportExcel();
		}
	},
	onSelectPropertyTab : function (id) {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		switch(id) {
			case 0 : {
				if($('#isAdmin').val() == 'true' || $('#PageManager_Master_domainId').val() != 0){
					 if($('#PageManager_Master_pageId').val() != 1) {
						 $('.PageManager_EditFormButtons').css('display', 'block');
						 $('.PageDetailManager_EditFormButtons').css('display', 'inline-block');
					 }
					 else {
						 $('.PageManager_EditFormButtons').css('display', 'none');
						 $('.PageDetailManager_EditFormButtons').css('display', 'none');
					 }
				}else {
					$('.PageManager_EditFormButtons').css('display', 'none');
					$('.PageDetailManager_EditFormButtons').css('display', 'none');
				}
			}
				break;
	 
			case 1 :
		
				param += "pageId=" + document.getElementById("PageManager_pageId").value;
				//alert(aPageMetadataManager);
				if( aPageMetadataManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/page/pageMetadata/list.admin", param, false, {
						success: function(data){
							document.getElementById("PageManager_PageMetadataTabPage").innerHTML = data;
							aPageMetadataManager = new PageMetadataManager( aPageManager.m_evSecurityCode );
							aPageMetadataManager.init();
							
							document.getElementById("PageMetadataManager_Master_pageId").value = document.getElementById("PageManager_Master_pageId").value; 
							aPageMetadataManager.doRetrieve();
						}});
				}
				else {
					
					document.getElementById("PageMetadataManager_Master_pageId").value = document.getElementById("PageManager_Master_pageId").value; 
					aPageMetadataManager.initSearch();
					aPageMetadataManager.doRetrieve();
				}
			
				break;
	 
			case 2 :
		
				param += "pageId=" + document.getElementById("PageManager_pageId").value;
				if( aPageComponentManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/page/pageComponent/list.admin", param, false, {
						success: function(data){
							document.getElementById("PageManager_PageComponentTabPage").innerHTML = data;
							aPageComponentManager = new PageComponentManager( aPageManager.m_evSecurityCode );
							aPageComponentManager.init();
							document.getElementById("PageComponentManager_Master_pageId").value = document.getElementById("PageManager_Master_pageId").value; 
							aPageComponentManager.doRetrieve();
						}});
				}
				else {
					document.getElementById("PageComponentManager_Master_pageId").value = document.getElementById("PageManager_Master_pageId").value; 
					aPageComponentManager.initSearch();
					aPageComponentManager.doRetrieve();
				}
				break;
			case 3 :
				param += "resUrl=" + document.getElementById("PageManager_path").value;
				param += "&principalType=U";
				if( aPrincipalPermissionManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/principalPermission/list.admin", param, false, {
						success: function(data){
							document.getElementById("PageManager_PrincipalPermissionTabPage").innerHTML = data;
							aPrincipalPermissionManager = new PrincipalPermissionManager( aPageManager.m_evSecurityCode );
							aPrincipalPermissionManager.init();
							document.getElementById("PrincipalPermissionManager_Master_domainId").value = document.getElementById("PageManager_domainId").value;
							document.getElementById("PrincipalPermissionManager_Master_title").value = document.getElementById("PageManager_title").value; 
							document.getElementById("PrincipalPermissionManager_Master_resUrl").value = document.getElementById("PageManager_path").value; 
							document.getElementById("PrincipalPermissionManager_Master_resType").value = "0"; 
							document.getElementById("PrincipalPermissionManager_Master_isPage").value = "true"; 
							aPrincipalPermissionManager.doRetrieve();
						}});
				}
				else {
					document.getElementById("PrincipalPermissionManager_Master_domainId").value = document.getElementById("PageManager_domainId").value;
					document.getElementById("PrincipalPermissionManager_Master_resUrl").value = document.getElementById("PageManager_path").value; 
					aPrincipalPermissionManager.initSearch();
					aPrincipalPermissionManager.doRetrieve();
				}
				break;
		}
		return true; 
	},
	doSelectTree : function (id) {
		
		var formElem = document.forms[ "PageManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = "1";
		formElem.elements[ "parentId" ].value = id;
		formElem.elements[ "pageId" ].value = id;
		this.m_selectRowIndex = 0;
		
		this.doSelectTreeNode( id );
		this.doRetrieve();
	},
	doMoveParentTree : function ( item_id, parent_id ) {
		if( parent_id == 0 ) {
			parent_id = 1;
		}
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&id=" + item_id + "&parentId=" + parent_id;
		
		this.m_ajax.send("POST", this.m_contextPath + "/page/changeParentForAjax.admin", param, false, {
			success: function(data){
				var oldParentId = aPageManager.m_tree.getParentId(item_id);
				//alert("oldParentId=" + oldParentId + ", parent_id=" + parent_id);
				aPageManager.m_tree.refreshItem( oldParentId );
				
				aPageManager.m_tree.refreshItem( parent_id );
				aPageManager.m_tree.selectItem ( item_id, true, false );
				aPageManager.m_tree.openItem   ( item_id )
			}});
	},
	doCopyTree : function ( item_id, parent_id, isDeepCopy ) {
		if( parent_id == 0 ) {
			parent_id = 1;
		}
		
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&id=" + item_id;
		//param += "&path=" + this.m_tree.getItem(item_id).getAttribute("userData");
		param += "&path=" + this.m_tree.getUserData(item_id, "path")
		param += "&parentId=" + parent_id;
		//param += "&parentPath=" + this.m_tree.getItem(parent_id).getAttribute("userData");
		param += "&parentPath=" + this.m_tree.getUserData(parent_id, "path")
		if( isDeepCopy == true ) {
			param += "&isDeepCopy=true";
		}
		else {
			param += "&isDeepCopy=false";
		}
		
		this.m_ajax.send("POST", this.m_contextPath + "/page/copyForAjax.admin", param, false, 
				{
			success: function(data){
				aPageManager.onRefresh( aPageManager.m_tree.getParentId(item_id) );
				//var oldParentId = aPageManager.m_tree.getParentId(item_id);
				//alert("oldParentId=" + oldParentId + ", parent_id=" + parent_id);
				//aPageManager.m_tree.refreshItem( oldParentId );
				aPageManager.m_tree.refreshItem( parent_id );
				aPageManager.m_tree.selectItem ( item_id, true, false );
				aPageManager.m_tree.openItem   ( parent_id )
			}});
	},
	doMoveUpNodeTree : function ( item_id )
	{
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&id=" + item_id + "&toDown=false";
		this.m_ajax.send("POST", this.m_contextPath + "/page/changeOrderForAjax.admin", param, false, { success: function(data){ 
			aPageManager.m_tree.moveItem(item_id, "up_strict"); 
            /*var parentId = aPageManager.m_tree.getParentId(item_id);
			aPageManager.m_tree.refreshItem( parentId );
			setTimeout(function() { aPageManager.m_tree.selectItem ( item_id, true, false ); }, 200);
			aPageManager.m_tree.openItem   ( item_id );*/
			
		}});
	},
	doMoveDownNodeTree : function ( item_id ) {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&id=" + item_id + "&toDown=true";
		this.m_ajax.send("POST", this.m_contextPath + "/page/changeOrderForAjax.admin", param, false, { success: function(data){ 
			aPageManager.m_tree.moveItem(item_id, "down_strict"); 
			/*var parentId = aPageManager.m_tree.getParentId(item_id);
			aPageManager.m_tree.refreshItem( parentId );
			setTimeout(function() { aPageManager.m_tree.selectItem ( item_id, true, false ); }, 200);
			aPageManager.m_tree.openItem   ( item_id );*/
		}});
	},
	doDeleteTree : function ()
	{
		var item_id = this.m_tree.getSelectedItemId();
		if( item_id == 0 ) {
			//alert( portalPage.getMessageResourceByParam('ev.error.tree.node.system.delete') );
			return;
		}
		//alert("id=" + id);
		var msg = portalPage.getMessageResourceByParam('ev.info.tree.node.remove', aPageManager.m_tree.getItemText(item_id));
		var ret = confirm( msg );
		if( ret == false ) {
			return false;
		}
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&pks=" + item_id + ":" + document.getElementById('PageManager_path').value + "&";
		
		this.m_ajax.send("POST", this.m_contextPath + "/page/removeForAjax.admin", param, false, {
			success: function(data){
				var parentId = aPageManager.m_tree.getParentId(item_id);
				aPageManager.m_contextMenu.hide();
				aPageManager.onRefresh( parentId );
				aPageManager.m_tree.selectItem(parentId);
				aPageManager.onNodeSelect(parentId);
				enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
			}});
	},
	initSearch : function () {
		var formElem = document.forms[ "PageManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () {
		//this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "PageManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/page/listForAjax.admin", param, false, {success: function(data) { aPageManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		this.m_utility.setListData(
			"PageManager",
			new Array('pageId', 'path'),
			//new Array('path', 'name'),
			new Array('path', 'name', 'shortTitle'),
			this.m_contextPath,
			resultObject);
		
		if($('#isAdmin').val() == 'true' || $('#PageManager_Master_domainId').val() != 0){
			 if($('#PageManager_Master_pageId').val() != 1) {
				 $('.PageDetailManager_EditFormButtons').css('display', 'inline-block');
				 $('.PageManager_EditFormButtons').css('display', 'block');
			 }
			 else {
				 $('.PageDetailManager_EditFormButtons').css('display', 'none');
				 $('.PageManager_EditFormButtons').css('display', 'none');
			 }
		}
		else {
			$('.PageDetailManager_EditFormButtons').css('display', 'none');
			$('.PageManager_EditFormButtons').css('display', 'none');
		}
		
		/*
		if(resultObject.Data.length != 0) {
			this.doDefaultSelect(); 
		}
		else {
			var param = "pageId=" + aPageManager.m_tree.getSelectedItemId();
			this.m_ajax.send("POST", this.m_contextPath + "/page/detailForAjax.admin", param, false, {success: function(data) { aPageManager.doSelectHandler(data); }});
		}
		*/
	},
	doPage : function (formName, pageNo)
	{
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = pageNo;
		
		this.m_selectRowIndex = 0;
		this.doRetrieve();
	},
	doSearch : function (formName)
	{
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = 1;
		
		this.m_selectRowIndex = 0;
		this.doRetrieve();
	},
	doSort : function (obj, sortColumn)
	{
		var formElem = document.forms[ "PageManager_SearchForm" ];
	    formElem.elements[ "sortColumn" ].value = sortColumn;
	    if( obj.ch % 2 == 0 ) {
			formElem.elements[ "sortMethod" ].value = "ASC";
	        obj.ch = 1;
	    }
	    else {
	        formElem.elements[ "sortMethod" ].value = "DESC";
	        obj.ch = 0;
	    }
		
		this.m_selectRowIndex = 0;
		this.doRetrieve();
	},
	doDefaultSelect : function ()
	{
		document.getElementById('PageManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "pageId=";
		param += document.getElementById('PageManager[' + this.m_selectRowIndex + '].pageId').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/page/detailForAjax.admin", param, false, {success: function(data) { aPageManager.doSelectHandler(data); }});
	},
	doSelectTreeNode : function (id)
	{
		aPageManager.m_tree.selectItem(id,false,true);
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		param += "pageId=" + id;
		
		this.m_ajax.send("POST", this.m_contextPath + "/page/detailForAjax.admin", param, false, {success: function(data) { aPageManager.doSelectHandler(data); }});
	},
	doSelect : function (obj)
	{
		var rowSeq = 0;
	    if(obj.nodeName=="SPAN") {
	        rowSeq = obj.parentNode.parentNode.getAttribute("ch");
	    }
	    else if(obj.nodeName=="TD") {
	        rowSeq = obj.parentNode.getAttribute("ch");
	    }
	    else if(obj.nodeName=="TR") {
	        rowSeq = obj.getAttribute("ch");
	    }
		
		this.m_selectRowIndex = rowSeq;
		
	    this.m_checkBox.unChkAll( document.getElementById("PageManager_ListForm") );
	    document.getElementById('PageManager[' + rowSeq + '].checkRow').checked = true;
		
	    var pageId = document.getElementById('PageManager[' + rowSeq + '].pageId').value;
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		param += "pageId=" + pageId;
		this.m_ajax.send("POST", this.m_contextPath + "/page/detailForAjax.admin", param, false, {success: function(data) { aPageManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject) {
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "PageManager", resultObject);
//		alert( portalPage.getAjax().retrieveElementValue("type", resultObject));
		$("#domainCode").text(portalPage.getAjax().retrieveElementValue("domainCode", resultObject));
		$("#PageManager_Master_pageId").val(portalPage.getAjax().retrieveElementValue("pageId", resultObject));
		$("#PageManager_Master_domainId").val(portalPage.getAjax().retrieveElementValue("domainId", resultObject));
		
		selectElem = document.getElementById("PageManager_owner_list");
		for(; selectElem.hasChildNodes(); )
			selectElem.removeChild( selectElem.childNodes[0] );
			
		var ownerInfos = resultObject.getElementsByTagName("ownerInfos");
		if( ownerInfos != null && ownerInfos.length > 0) {
			for (ix=0; ix < ownerInfos.length; ix++)
			{
				var principalId = ownerInfos[ix].attributes.getNamedItem("principalId").value;
				var userId = ownerInfos[ix].attributes.getNamedItem("userId").value;
				var name = "";
				if( ownerInfos[ix].firstChild ) {
					name = ownerInfos[ix].firstChild.nodeValue;
				}

				var newOpt = document.createElement("OPTION");
				newOpt.text = name + " [" + userId + "]";
				newOpt.name = "";
				newOpt.value = principalId;
				try {
					selectElem.add(newOpt, null); // standards compliant; doesn't work in IE
				}
				catch(ex) {
					selectElem.add(newOpt, 1); // IE only
				}
			}
		}
	
		document.getElementById("PageManager_pageId").readOnly = true;
		
		var mainTabs = $("#PageManager_mainTabs").tabs();
		
		var useIframe = document.getElementById("PageManager_useIframe").checked;
		var url = document.getElementById("PageManager_url").value;
		if( url || useIframe) {
			mainTabs.tabs('option', 'active', 1);
			mainTabs.tabs('disable', 0);
		}
		else {
			mainTabs.tabs('enable', 0);
		}
		var mainSelectedTabId = mainTabs.tabs('option', 'selected');
		
		//alert("mainSelectedTabId=" + mainSelectedTabId);
		var propertyTabs = $("#PageManager_propertyTabs").tabs();
		propertyTabs.tabs('enable', 1);	 
		propertyTabs.tabs('enable', 2);
		propertyTabs.tabs('enable', 3);
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		if( mainSelectedTabId == 0 ) {
			this.doPageEdit();
		}
		
		document.getElementById("PageManager_EditFormPanel").style.display = '';
	},
	doCreate : function(treeitemId) {
		this.m_utility.initFormData(this.m_dataStructure, "PageManager");
		selectElem = document.getElementById("PageManager_owner_list");
		for(; selectElem.hasChildNodes(); )
			selectElem.removeChild( selectElem.childNodes[0] );
		
		if( treeitemId == 1 ) {
			document.getElementById("PageManager_path").value = "/";
		}
		else {
			//document.getElementById("PageManager_path").value = this.m_tree.getItem(treeitemId).getAttribute("userData");
			document.getElementById("PageManager_path").value = this.m_tree.getUserData(treeitemId, "path");
		}
		document.getElementById("PageManager_domainId").value = document.getElementById("PageManager_Master_domainId").value;
		document.getElementById("PageManager_systemCode").value = "PT";
		document.getElementById("PageManager_target").value = "_self";
		document.getElementById("PageManager_isHidden").checked = false;
		document.getElementById("PageManager_isQuickMenu").checked = false;
		document.getElementById("PageManager_isProtected").checked = false;
		document.getElementById("PageManager_useTheme").checked = true;
		document.getElementById("PageManager_useIframe").checked = false;
		
		var mainTabs = $("#PageManager_mainTabs").tabs();
		mainTabs.tabs('option', 'active', 1);
		mainTabs.tabs('disable', 0);
		
		var propertyTabs = $("#PageManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	 
		propertyTabs.tabs('disable', 1);	 
		propertyTabs.tabs('disable', 2);
		propertyTabs.tabs('disable', 3);
		document.getElementById("PageManager_parentId").value = document.getElementById("PageManager_Master_parentId").value; 
		document.getElementById("PageManager_pageId").readOnly = true;
		document.getElementById("PageManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var param = "";
		var isCreate = document.getElementById("PageManager_isCreate").value;
		var form = document.getElementById("PageManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		//var param = this.m_utility.getFormData(this.m_dataStructure, form);
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		param += "path=" + document.getElementById("PageManager_path").value;
		param += "&pageId=" + document.getElementById("PageManager_pageId").value;
		param += "&parentId=" + document.getElementById("PageManager_parentId").value;
		param += "&systemCode=" + document.getElementById("PageManager_systemCode").value;
		param += "&depth=" + document.getElementById("PageManager_depth").value;
		param += "&name=" + encodeURIComponent(document.getElementById("PageManager_name").value);
		param += "&type=" + document.getElementById("PageManager_type").value;
		param += "&pageType=" + document.getElementById("PageManager_pageType").value;
		param += "&title=" + encodeURIComponent(document.getElementById("PageManager_title").value);
		param += "&shortTitle=" + encodeURIComponent(document.getElementById("PageManager_shortTitle").value);
		param += "&sortOrder=" + document.getElementById("PageManager_sortOrder").value;
		param += "&isHidden=" + ((document.getElementById("PageManager_isHidden").checked) ? "true" : "false");
		param += "&isQuickMenu=" + ((document.getElementById("PageManager_isQuickMenu").checked) ? "true" : "false");
		param += "&isAllowGuest=" + ((document.getElementById("PageManager_isAllowGuest").checked) ? "true" : "false");
		param += "&isProtected=" + ((document.getElementById("PageManager_isProtected").checked) ? "true" : "false");
		param += "&useTheme=" + ((document.getElementById("PageManager_useTheme").checked) ? "true" : "false");
		param += "&useIframe=" + ((document.getElementById("PageManager_useIframe").checked) ? "true" : "false");
		var defaultPath = document.getElementById("PageManager_defaultPagePath").value;
		if(defaultPath != null && defaultPath.length > 0) {
			param += "&defaultPageName=" +  document.getElementById("PageManager_defaultPageName").value;
		}
		param += "&target=" + document.getElementById("PageManager_target").value;
		param += "&url=" + encodeURIComponent(document.getElementById("PageManager_url").value);
		param += "&parameter=" + encodeURIComponent(document.getElementById("PageManager_parameter").value);
		param += "&skin=" + document.getElementById("PageManager_skin").value;
		param += "&defaultLayoutDecorator=" + document.getElementById("PageManager_defaultLayoutDecorator").value;
		param += "&owner=" + document.getElementById("PageManager_owner").value;
		param += "&masterPagePath=" + document.getElementById("PageManager_masterPagePath").value;
		param += "&pageInfo01=" + document.getElementById("PageManager_pageInfo01").value;
		param += "&pageInfo02=" + document.getElementById("PageManager_pageInfo02").value;
		param += "&pageInfo03=" + document.getElementById("PageManager_pageInfo03").value;
		param += "&domainId=" + document.getElementById("PageManager_domainId").value;
		
		//alert(param);
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/page/addForAjax.admin", param, false, {
				success: function(data){
					aPageManager.onRefresh( document.getElementById("PageManager_parentId").value );
					aPageManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/page/updateForAjax.admin", param, false, {
				success: function(data){
					aPageManager.onRefresh( document.getElementById("PageManager_parentId").value );
					aPageManager.doSelectTree( document.getElementById("PageManager_pageId").value );
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PageManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('PageManager[' + rowCntArray[i] + '].pageId').value + ":" + document.getElementById('PageManager[' + rowCntArray[i] + '].path').value;
	        }
			var parentId = aPageManager.m_tree.getParentId(document.getElementById('PageManager[' + rowCntArray[0] + '].pageId').value);
			
			this.m_ajax.send("POST", this.m_contextPath + "/page/removeForAjax.admin", param, false, {
				success: function(data){
					aPageManager.onRefresh( parentId );
					
					aPageManager.initSearch();
					aPageManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
		}
	},
	doResetDefault : function() {
		document.getElementById("PageManager_defaultPageName").value = "";
		document.getElementById("PageManager_defaultPagePath").value = "";
	},
	doPreview : function() {
		var path = document.getElementById("PageManager_path").value;
		var themeSelect = document.getElementById("PageManager_SelectTheme");
		var theme = themeSelect.options[themeSelect.selectedIndex].value;
		window.open(this.m_contextPath + "/portal" + path + ".page?theme=" + theme, "PreviewWindow");
	},
	doPageEdit : function() {
		
		var mainTabDisabled = $("#PageManager_mainTabs").tabs( "option", "disabled" );
//		alert("mainTabDisabled=" + mainTabDisabled);
		if( mainTabDisabled == true ) return;
		
		
		var url = document.getElementById("PageManager_url").value;
		if (url != null && url.length > 0)
	    {
			var paneLink = document.getElementById("PageManager_PreviewPane");
	        paneLink.src = url;
	    }
	    else 
	    {
			var servletPath = "contentonly";
			var path = document.getElementById("PageManager_path").value;
			
			var url = this.m_contextPath + "/" + servletPath + path + ".page";
			var paneLink = document.getElementById("PageManager_PreviewPane");
	        paneLink.src = url;
			
			var themeSelect = document.getElementById("PageManager_SelectTheme");
			var pageTheme = document.getElementById("PageManager_defaultLayoutDecorator").value;
			if( pageTheme != null && pageTheme.length > 0 ) {
				themeSelect.value = pageTheme;
			}
			else {
				themeSelect.value = "empty";
			}

			//alert("paneLink.contentWindow=" + paneLink.contentWindow);
			//paneLink.contentWindow.portalPage.setEditMode(true);

	    }
	},
	togglePageEdit : function(obj)
	{
		if( aPageManager.m_editMode == false ) {
			obj.src = portalPage.getContextPath() + "/decorations/layout/images/edit.gif";
			obj.title = "Edit Page";
		}
		else {
			obj.src = portalPage.getContextPath() + "/decorations/layout/images/view.gif";
			obj.title = "View Page";
		}
		
		var paneLink = document.getElementById("PageManager_PreviewPane");
		paneLink.contentWindow.portalPage.setEditMode( aPageManager.m_editMode );
		aPageManager.m_editMode = !aPageManager.m_editMode;
	},
	doChangeSystemCode : function(obj)
	{
		/*
		var systemCode = obj.options[obj.selectedIndex].value;
		//alert(systemCode);
		if( systemCode == "CF" || systemCode == "BL" ) {
			document.getElementById("PageManager_skin_select").style.display = "";
		}
		else {
			document.getElementById("PageManager_skin_select").style.display = "none";
		}
		*/
	},
	doChangeTheme : function(obj)
	{
		var theme = obj.options[obj.selectedIndex].value;
		var paneLink = document.getElementById("PageManager_PreviewPane");
		var src = paneLink.src;
		var pos = src.indexOf("?");
		if( pos > -1 ) {
			pos = src.indexOf("theme");
			if( pos > -1 ) {
				paneLink.src = src.substring(0, pos) + "theme=" + theme;
			}
			else {
				paneLink.src = src + "&theme=" + theme;
			}
		}
		else {
			paneLink.src = src + "?theme=" + theme;
		}
	},
	doActivateEditPane : function (link)
	{
		var paneLink = document.getElementById("PageManager_PreviewPane");
	    paneLink.src = link;
	},
	doRemoveOwner : function() {
		var selectElem = document.getElementById("PageManager_owner_list")
		if( selectElem.selectedIndex > -1 ) {
			selectElem.remove( selectElem.selectedIndex );

			var owners = "";
			for(var i=0; i<selectElem.options.length; i++) {
				if( i > 0 ) owners += ",";
				owners += selectElem.options[i].value;
			}
			document.getElementById("PageManager_owner").value = owners;
		}
	},
	doCheckPageName : function(obj)
	{
		for(i=0; i<obj.value.length; i++)
		{
			if( (obj.value.charCodeAt(i) > 0x3130 && obj.value.charCodeAt(i) < 0x318F) || 
				(obj.value.charCodeAt(i) >= 0xAC00 && obj.value.charCodeAt(i) <= 0xD7A3) ) {
				alert("$messages.getString('ev.info.forbiden.hangul')");
				obj.value = "";
				obj.focus();
				return false;
			}
		}
		
		var pos = obj.value.lastIndexOf(".");
		if( pos > -1 ) {
			obj.value = obj.value.substring(0, pos);
		}
		
		return true;
	},
	doExportExcel : function(path) {
		if( !path ) {
			var itemId = this.m_tree.getSelectedItemId();
			//path = this.m_tree.getItem(itemId).getAttribute("userData");
			path = this.m_tree.getUserData(itemId, "path");
		}
		var url = this.m_contextPath + "/page/exportExcelForAjax.admin?path=" + path;
		document.getElementById("exportExcelIF").src = url;
		//window.open(url);
	},
	doResetDefaultPagePath: function() {
		document.getElementById("PageManager_defaultPageName").value = "";
		document.getElementById("PageManager_defaultPagePath").value = "";
	},
	doSavePageEdit : function() {
		var paneLink = document.getElementById("PageManager_PreviewPane");
		if( paneLink ) {
			paneLink.contentWindow.checkModified();
		}
	}
}

var aPageMenu = null;
PageMenu = function(contextPath)
{	
	if( portalPage == null) portalPage = new enview.portal.Page();
	
//  페이지 메뉴 원본
/*	this.m_domElement = document.createElement('div');
	this.m_domElement.id = "PageManager_PageMenu";
	this.m_domElement.title = "Page Menu";
	var htmlStr = "";
	htmlStr += "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageMenu.hide(); aPageManager.onRefresh()'><img src='" + contextPath + "/admin/images/Service.gif'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.refresh') + "</a></div>";
	htmlStr += "<hr>";
	htmlStr += "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageMenu.hide(); aPageManager.onCreate()' ><img src='" + contextPath + "/admin/images/ic_make_page.gif'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.addPage') + "</a></div>";
	htmlStr += "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageMenu.hide(); aPageManager.onDelete()' ><img src='" + contextPath + "/admin/images/ic_del_b.gif'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.deletePage') + "</a></div>";
	htmlStr += "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageMenu.hide(); aPageManager.onMove()' ><img src='" + contextPath + "/admin/images/movePage.png'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.movePage') + "</a></div>";
	htmlStr += "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageMenu.hide(); aPageManager.onCopy()' ><img src='" + contextPath + "/admin/images/copyPage.png'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.copyPage') + "</a></div>";
	htmlStr += "<hr>";
	htmlStr += "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageMenu.hide(); aPageManager.onMoveUp()' ><img src='" + contextPath + "/admin/images/ic_up.gif'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.moveUp') + "</a></div>";
	htmlStr += "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageMenu.hide(); aPageManager.onMoveDown()' ><img src='" + contextPath + "/admin/images/ic_down.gif'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.moveDown') + "</a></div>";
	htmlStr += "<hr>";
	htmlStr += "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageMenu.hide(); aPageManager.getExcelFileDialog().doShow()' ><img src='" + contextPath + "/admin/images/import.png'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.loadExcel') + "</a></div>";
	htmlStr += "<div onmouseover='aPageMenu.onMouseOver(this)' onmouseout='aPageMenu.onMouseOut(this)' style='border:none; cursor:hand;'><a onclick='aPageMenu.hide(); aPageManager.doExportExcel()' ><img src='" + contextPath + "/admin/images/export.png'>&nbsp;" + portalPage.getMessageResource('ev.info.menu.saveExcel') + "</a></div>";
	this.m_domElement.innerHTML = htmlStr;
	//alert(htmlStr);
	document.body.appendChild( this.m_domElement );*/
	
	$("#PageManager_PageMenu").dialog({
		autoOpen: false,
		width: "150px",
		resizable: false,
		draggable: false,
		modal: true,
		open: function(event, ui) { 
			//$(".ui-dialog-titlebar-close").hide(); 
			//$("#PageManager_PageMenu").attr("style", "left:" + left);
			//$("#PageManager_PageMenu").attr("style", "top:" + top);
		}
	});
	
	this.init();
}

PageMenu.prototype =
{
	m_domElement : null,
	m_id : null,
	
	init : function() {
	
	},
	getItemId : function ()
	{
		return this.m_id;
	},
	setItemId : function (id)
	{
		this.m_id = id;
	},
	show : function (left, top)
	{
		//alert(left + "," + top);
		$('#PageManager_PageMenu').dialog( "option", "position", [left,top] );
		$('#PageManager_PageMenu').dialog('open');
	},
	hide : function()
	{
		$('#PageManager_PageMenu').dialog('close');
	},
	onMouseOver : function(obj)
	{
		obj.setAttribute("class", "contextMenu_itemOver");
		obj.setAttribute("className", "contextMenu_itemOver");
	},
	onMouseOut : function(obj)
	{
		obj.setAttribute("class", "contextMenu_item");
		obj.setAttribute("className", "contextMenu_item");
	}
}


var aPageChooser = null;
PageChooser = function(evSecurityCode, domainId, extraParam)
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	if( portalPage == null) portalPage = new enview.portal.Page();
	this.m_selectRowIndex = 0;
	this.m_evSecurityCode = evSecurityCode;
	if(domainId) this.m_domainId = domainId;
	if(extraParam) this.m_extraParam = extraParam;
	this.m_contextPath = portalPage.getContextPath();
	this.m_domElement = document.getElementById("PageManager_PageChooser");
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
	
	$("#PageManager_PageChooser").dialog({
		autoOpen: false,
		resizable: false,
		height : 400,
		modal: true,
		buttons: {
			Cancel: function() {
				$(this).dialog('close');
			}
		}
	});
	
	this.init();
}

PageChooser.prototype =
{
	m_domElement : null,
	m_tree : null,
	m_checkBox : null,
	m_sourceElement : null,
	m_callback : null,
	m_evSecurityCode : null,
	m_domainId : '',
	m_extraParam : '',
	
	init : function() {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&domainId=" + this.m_domainId 
		
		param += this.m_extraParam;
		
		$('#PageChooser_TreeTabPage').html('');
		this.m_tree = new dhtmlXTreeObject(document.getElementById('PageChooser_TreeTabPage'),"100%","100%",0);
		this.m_tree.setImagePath(this.m_contextPath + "/dhtmlx/imgs/dhxtree_skyblue/");
		this.m_tree.setOnClickHandler( this.onNodeSelect );
		this.m_tree.enableAutoTooltips(true);
		this.m_tree.setXMLAutoLoading(this.m_contextPath + "/page/retrieveTreeForAjax.admin?" + param);
		this.m_tree.load(this.m_contextPath + "/page/retrieveTreeForAjax.admin?id=1&" + param);
		
		//this.m_tree.clearSelection(id);
		//this.m_tree.getAllChecked();
		//this.m_tree.focusItem(id);
	},
	doShow : function (callback, title)
	{
		this.m_callback = callback;

		if( title ) {
			$('#ui-dialog-title-PageManager_PageChooser').text( title );
		}
		$('#PageManager_PageChooser').dialog('open');
	},
	onNodeSelect : function (id) {
		if( id != 1 ) {
			aPageChooser.doApply( id );
		}
	},
	doApply : function(id) {
		$('#PageManager_PageChooser').dialog('close');
		var result = new Array(1);
		var rowMap = new Map();
		//var userData = this.m_tree.getItem(id).getAttribute("userData");
		var userData = this.m_tree.getUserData(id, "path");
		rowMap.put("pageId", id);	
		rowMap.put("pagePath", userData);	
		rowMap.put("title", this.m_tree.getItemText(id));		
		result[0] = rowMap;
		this.m_callback(result);
	}
}

var aPageMultiChooser = null;
PageMultiChooser = function(evSecurityCode, domainId, extraParam)
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	if( portalPage == null) portalPage = new enview.portal.Page();
	this.m_selectRowIndex = 0;
	this.m_evSecurityCode = evSecurityCode;
	this.m_domainId = domainId;
	this.m_extraParam = extraParam;
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = portalPage.getContextPath();
	this.m_domElement = document.getElementById("PageManager_PageMultiChooser");
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
	
	$("#PageManager_PageMultiChooser").dialog({
		autoOpen: false,
		resizable: false,
		modal: true,
		width: 800,
		buttons: {
			"Apply": function() {
				aPageMultiChooser.doApply();
			},
			Cancel: function() {
				$(this).dialog('close');
			}
		}
	});
	
	this.init();
}

PageMultiChooser.prototype =
{
	m_domElement : null,
	m_tree : null,
	m_checkBox : null,
	m_sourceElement : null,
	m_callback : null,
	m_evSecurityCode : null,
	
	m_domainId : '',
	m_extraParam : '',
	
	init : function() {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&domainId=" + this.m_domainId + this.m_extraParam;
		this.m_tree = new dhtmlXTreeObject(document.getElementById('PageMultiChooser_TreeTabPage'),"100%","100%",0);
		this.m_tree.setImagePath(this.m_contextPath + "/dhtmlx/imgs/dhxtree_skyblue/");
		this.m_tree.setOnClickHandler( this.onNodeSelect );
		this.m_tree.enableAutoTooltips(true);
		this.m_tree.setXMLAutoLoading(this.m_contextPath + "/page/retrieveTreeForAjax.admin?=" +param);
		this.m_tree.load(this.m_contextPath + "/page/retrieveTreeForAjax.admin?id=1&=" + param);
		
		//this.m_tree.clearSelection(id);
		//this.m_tree.getAllChecked();
		//this.m_tree.focusItem(id);
	},
	setDomainId : function(domainId){
		this.m_domainId = domainId;
	},
	
	doShow : function (callback)
	{
		this.m_callback = callback;
		$('#PageManager_PageMultiChooser').dialog('open');
	},
	onNodeSelect : function (id) {
		aPageMultiChooser.doSelectTree( id );
	},
	doSelectTree : function (id) {
		var formElem = document.forms[ "PageMultiChooser_SearchForm" ];
		formElem.elements[ "pageNo" ].value = "1";
		formElem.elements[ "parentId" ].value = id;
		formElem.elements[ "domainId" ].value = this.m_domainId;
		this.m_selectRowIndex = 0;
		
		//var userData = this.m_tree.getItem(id).getAttribute("userData");
		var userData = this.m_tree.getUserData(id, "path");
		if( userData != "/" ) {
			userData = userData + "/*";
		}
		else {
			userData = userData + "*";
		}
		
		document.getElementById("aPageMultiChooser_path").value = userData;
		
		this.doRetrieve();
	},
	doRetrieve : function () {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var extraParam = "";
		var formElem = document.forms[ "PageMultiChooser_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
	    if(this.m_extraParam) param += this.m_extraParam;
		this.m_ajax.send("POST", this.m_contextPath + "/page/listForAjax.admin", param, false, {success: function(data) { aPageMultiChooser.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		this.m_utility.setListData(
			"PageMultiChooser",
			new Array('pageId', 'path', 'shortTitle'),
			//new Array('path', 'name'),
			new Array('path', 'shortTitle'),
			this.m_contextPath,
			resultObject);
	},
	doPage : function (formName, pageNo)
	{
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = pageNo;
		
		this.m_selectRowIndex = 0;
		this.doRetrieve();
	},
	doSearch : function (formName)
	{
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = 1;
		
		this.m_selectRowIndex = 0;
		this.doRetrieve();
	},
	doSort : function (obj, sortColumn)
	{
		var formElem = document.forms[ "PageMultiChooser_SearchForm" ];
	    formElem.elements[ "sortColumn" ].value = sortColumn;
	    if( obj.ch % 2 == 0 ) {
			formElem.elements[ "sortMethod" ].value = "ASC";
	        obj.ch = 1;
	    }
	    else {
	        formElem.elements[ "sortMethod" ].value = "DESC";
	        obj.ch = 0;
	    }
		
		this.m_selectRowIndex = 0;
		this.doRetrieve();
	},
	doSelect : function (obj)
	{
		var rowSeq = 0;
	    if(obj.nodeName=="SPAN") {
	        rowSeq = obj.parentNode.parentNode.getAttribute("ch");
	    }
	    else if(obj.nodeName=="TD") {
	        rowSeq = obj.parentNode.getAttribute("ch");
	    }
	    else if(obj.nodeName=="TR") {
	        rowSeq = obj.getAttribute("ch");
	    }
		
		this.m_selectRowIndex = rowSeq;
		
	    this.m_checkBox.unChkAll( document.getElementById("PageMultiChooser_ListForm") );
	    document.getElementById('PageMultiChooser[' + rowSeq + '].checkRow').checked = true;
		
		document.getElementById("aPageMultiChooser_path").value = document.getElementById('PageMultiChooser[' + rowSeq + '].path').value;
	},
	doApply : function(id) {
		var actionMask = 15; // view authority
		var form = document.getElementById("PageMultiChooser_EditForm");
		for(var j=0; j<form.elements.length; j++) {
			field = form.elements[j];
			//alert(field.type + "," + field.id + "," + field.checked);
			if(field.type == "checkbox" && field.id && field.id.indexOf("PageMultiChooser_authority_") > -1 ) {
				if( field.checked == true ) {
					actionMask |= field.value;
				}
			}
		}
		
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PageMultiChooser_ListForm") );
		if( rowCnts != "" ) {
	        $('#PageManager_PageMultiChooser').dialog('close');
		
			var rowCntArray = rowCnts.split(",");
			var result = new Array(rowCntArray.length);
	        for(i=0; i<rowCntArray.length; i++) {
				var rowMap = new Map();
				rowMap.put("pageId", document.getElementById('PageMultiChooser[' + rowCntArray[i] + '].pageId').value);
				rowMap.put("pagePath", document.getElementById('PageMultiChooser[' + rowCntArray[i] + '].path').value);
				rowMap.put("shortTitle", document.getElementById('PageMultiChooser[' + rowCntArray[i] + '].shortTitle').value);
				rowMap.put("isAllow", (document.getElementById("PageMultiChooser_allow").checked == true ) ? "true" : "false");
				rowMap.put("actionMask", actionMask);
				result[i] = rowMap;
	        }
			this.m_callback(false, result);
		}
		else {
			var rootPath = document.getElementById("aPageMultiChooser_path").value;
			if( rootPath.lastIndexOf("*") > -1 ) {
				var answer = confirm( portalPage.getMessageResource('ev.info.permission.generateFolder') );
				if( answer == true ) {
					$('#PageManager_PageMultiChooser').dialog('close');
					var result = new Array(1); 
					var rowMap = new Map();
					if( rootPath == "/*" ) {
						rootPath = "/";
					}
					else {
						rootPath = rootPath.substring(0, rootPath.indexOf("/*"));
					}
					rowMap.put("pagePath", rootPath);
					rowMap.put("isAllow", (document.getElementById("PageMultiChooser_allow").checked == true ) ? "true" : "false");
					rowMap.put("actionMask", actionMask);			
					result[0] = rowMap;
					this.m_callback(true, result);
				}
			}
			else {
				$('#PageManager_PageMultiChooser').dialog('close');
				var rowMap = new Map();
				rowMap.put("pageId", "");
				rowMap.put("pagePath", rootPath);
				rowMap.put("shortTitle", "User Defined");
				rowMap.put("isAllow", (document.getElementById("PageMultiChooser_allow").checked == true ) ? "true" : "false");
				rowMap.put("actionMask", actionMask);
				var result = new Array(1); 
				result[0] = rowMap;
				this.m_callback(false, result);
			}
		}
	}
}

var aExcelUploader = null;
ExcelUploader = function()
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	if( portalPage == null) portalPage = new enview.portal.Page();
	this.m_selectRowIndex = 0;
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = portalPage.getContextPath();
	this.m_domElement = document.getElementById("PageManager_ExcelUploader");
	talkMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
	
	$("#PageManager_ExcelUploader").dialog({
		autoOpen: false,
		resizable: false,
		width:400, 
		height:150,
		modal: true,
		buttons: {
			"Apply": function() {
				aExcelUploader.doApply();
			},
			"Cancel": function() {
				$(this).dialog('close');
			}
		}
	});
	
	this.init();
}

ExcelUploader.prototype =
{
	m_domElement : null,
	m_checkBox : null,
	m_callback : null,
	
	init : function() {
		
	},
	whenSrchFocus : function ( obj, lvS ) {
		if( obj.value == lvS ) obj.value = "";
	},
	whenSrchBlur : function ( obj, lvS ) {
		if( obj.value == "" ) obj.value = lvS;
	},
	doShow : function (callback)
	{
		var treeitemId =  aPageManager.getContextMenu().getItemId();
		if( treeitemId == 1 ) {
			//alert( portalPage.getMessageResourceByParam('ev.error.tree.importExcel') );
			return;
		}
		
		this.m_callback = callback;
		$('#PageManager_ExcelUploader').dialog('open');
	},
	doApply : function ()
	{
		var excelFile = document.getElementById("PageManager_excelFile");
		if( excelFile == null || excelFile.length == 0 ) {
			alert( portalPage.getMessageResource('ev.error.selectExcelFile') );
			return;
		}
		$('#PageManager_ExcelUploader').dialog('close');
		
		var itemId = aPageManager.m_tree.getSelectedItemId();
		var frm = document.getElementById("PageManager_excelFileForm");
		frm.action = this.m_contextPath + "/page/importExcelForAjax.admin?pageId=" + itemId;
		frm.target = "importExcelIF";
		frm.submit();
	}
}