var aRoleManager = null;
RoleManager = function(evSecurityCode)
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
RoleManager.prototype =
{
	m_ajax : null,
	m_checkBox : null,
	m_validator : null,
	m_utility : null,
	m_contextPath : null,
	m_selectRowIndex : 0,
	m_contextMenu : null,
	m_dataStructure : null,
	m_evSecurityCode : null,
	m_dhtmlxContextMenu : null,

	init : function() {
		this.m_dataStructure = [
			{"fieldName":"principalId", "validation":""}
			,{"fieldName":"parentId", "validation":""}
			,{"fieldName":"shortPath", "validation":"Required,MaxLength", "maxLength":"30"}
			,{"fieldName":"principalName", "validation":"Required,MaxLength", "maxLength":"40"}
			,{"fieldName":"theme", "validation":""}
			,{"fieldName":"defaultPage", "validation":""}
			,{"fieldName":"principalType", "validation":""}
			,{"fieldName":"principalOrder", "validation":""}
			,{"fieldName":"creationDate", "validation":""}
			,{"fieldName":"modifiedDate", "validation":""}
			,{"fieldName":"principalInfo01", "validation":"MaxLength", "maxLength":"50"}
			,{"fieldName":"principalInfo02", "validation":"MaxLength", "maxLength":"50"}
			,{"fieldName":"principalInfo03", "validation":"MaxLength", "maxLength":"50"}
			,{"fieldName":"principalDesc", "validation":"MaxLength", "maxLength":"80"}
			,{"fieldName":"domainId", "validation":""}
		]
		
		this.m_contextMenu = aRoleMenu = new RoleMenu(this.m_contextPath);
		this.m_dhtmlxContextMenu = new dhtmlXMenuObject();
		this.m_dhtmlxContextMenu.renderAsContextMenu();
		this.m_dhtmlxContextMenu.attachEvent("onClick",this.onDhtmlxContextClick);
		this.m_dhtmlxContextMenu.loadFromHTML("dhtmlx_context_data", true);
		this.m_tree = new dhtmlXTreeObject(document.getElementById('RoleManager_TreeTabPage'),"100%","100%",0);
		this.m_tree.setImagePath(this.m_contextPath + "/dhtmlx/imgs/dhxtree_skyblue/");
		this.m_tree.setOnClickHandler( this.onNodeSelect );
		//this.m_tree.enableDragAndDrop(true)
		//this.m_tree.setDragHandler( this.onDragAndDrop );
		//this.m_tree.setOnRightClickHandler( this.onContextMenuHandler );
		this.m_tree.enableAutoTooltips(true);
		this.m_tree.enableContextMenu(this.m_dhtmlxContextMenu);
		this.m_tree.attachEvent("onBeforeContextMenu", function (id) {
			aRoleManager.onNodeSelect( id );
			aRoleManager.m_contextMenu.setItemId( id );
			return true;
		});
		//this.m_tree.setChildCalcMode(true);
		//this.m_tree.enableItemEditor(true);
		//this.m_tree.enableKeyboardNavigation(true);
		this.m_tree.setXMLAutoLoading(this.m_contextPath + "/role/retrieveTreeForAjax.admin?evSecurityCode=" + this.m_evSecurityCode);
		this.m_tree.load(this.m_contextPath + "/role/retrieveTreeForAjax.admin?id=10&evSecurityCode=" + this.m_evSecurityCode);
		
		$(function() {
			$("#RoleManager_propertyTabs").tabs();
		});
		
		$.datepicker.setDefaults({
			showMonthAfterYear: true,
			changeMonth: true,
			changeYear: true,
			showButtonPanel: true,
			showAnim : 'slideDown',
			dateFormat : 'yy-mm-dd'
		});
	},
	getPageChooser : function () {
		if( aPageChooser == null ) {
			aPageChooser = new PageChooser( aRoleManager.m_evSecurityCode );
		}
		return aPageChooser;
	},
	setPageChooserCallback : function (rowArray) {
		//document.getElementById("PageManager_defaultPageName").value = rowArray[0].get("pageId");
		document.getElementById("RoleManager_defaultPage").value = rowArray[0].get("pagePath");
	},
	getPageMultiChooser : function () {
		if( aPageMultiChooser == null ) {
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
			this.m_ajax.send("POST", this.m_contextPath + "/page/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("PageManager_PageMultiChooser").innerHTML = data;
					aPageMultiChooser = new PageMultiChooser();
				}});
		}
		return aPageMultiChooser;
	},
	setPageMultiChooserCallback : function (rowArray) {
		//document.getElementById("PageManager_defaultPageName").value = rowArray[0].get("pageId");
		document.getElementById("RoleManager_defaultPage").value = rowArray[0].get("pagePath");
	},
	getContextMenu : function()
	{
		return this.m_contextMenu;
	},
	onContextMenuHandler : function (treeitemId, item) {
		aRoleManager.doShowContextMenu( treeitemId, item );
	},
	onSelect : function (treeitemId) {
		aRoleManager.doSelect( treeitemId );
	},
	onRefresh : function (id) {
		var treeitemId = (id) ? id : aRoleManager.getContextMenu().getItemId();
		//alert("treeitemId=" + treeitemId);
		aRoleManager.getContextMenu().hide();
		if( treeitemId == 10 ) { aRoleManager.m_tree.deleteChildItems( 0 ); }
		if( treeitemId != null ) {
			aRoleManager.m_tree.refreshItem( treeitemId );
		}
	},
	onCheckKey : function (a_event) {
		if( document.all ) {
			if( event.keyCode ) {
				if( event.ctrlKey == true && event.keyCode == 90 ) {
					aRoleManager.toggleMaximize();
				}
				else if( event.ctrlKey == true && event.keyCode == 38 ) {
					aRoleManager.doMoveUpNodeTree( aRoleManager.m_tree.getSelectedItemId() );
				}
				else if( event.ctrlKey == true && event.keyCode == 40 ) {
					aRoleManager.doMoveDownNodeTree( aRoleManager.m_tree.getSelectedItemId() );
				}
			}
		}
		else {
			if( a_event.ctrlKey == true && a_event.keyCode == 90 ) {
				aRoleManager.toggleMaximize();
			}
			else if( a_event.ctrlKey == true && a_event.keyCode == 38 ) {
				aRoleManager.doMoveUpNodeTree( aRoleManager.m_tree.getSelectedItemId() );
			}
			else if( a_event.ctrlKey == true && a_event.keyCode == 40 ) {
				aRoleManager.doMoveDownNodeTree( aRoleManager.m_tree.getSelectedItemId() );
			}
		}
	},
	onCreate : function () {
		var treeitemId = aRoleManager.getContextMenu().getItemId();
		if(this.m_tree.getLevel(treeitemId)==1) {
			//alert( portalPage.getMessageResourceByParam('ev.error.tree.createRoleRoot') );
			return;
		}
		aRoleManager.doCreate( treeitemId );
	},
	onDelete : function () {
		var treeitemId = aRoleManager.getContextMenu().getItemId();		
		if(this.m_tree.getLevel(treeitemId)==1) {
			//alert( portalPage.getMessageResourceByParam('ev.error.tree.deleteRoleRoot') );
			return;
		}
		return aRoleManager.doDeleteTree(treeitemId);
	},
	onDragAndDrop : function (subKey, item_id, parent_id, before, item, parent) {
		if( this.m_tree.getLevel(item_id)==1) {
			//alert( portalPage.getMessageResourceByParam('ev.info.forbiden.updateRoot') );
			return;
		}
		
		if( subKey == 0 ) {	// move
			var msg = portalPage.getMessageResourceByParam('ev.info.tree.node.move', aRoleManager.m_tree.getItemText(item_id), aRoleManager.m_tree.getItemText(parent_id));
			var ret = confirm( msg );
			if( ret == true ) {
				aRoleManager.doMoveParentTree(item_id, parent_id);
				return false;
			}
			else return false;
		}
		else if( subKey == 1 ) { // shiftKey (move order)
			return false;
		} 
		else if( subKey == 2 ) { // ctrlKey (copy)
			return false;
		}
		else if( subKey == 3 ) { // altKey
			return false;
		}
		else {
			return true;
		}
	},
	onMoveUp : function () {
		var treeitemId = aRoleManager.getContextMenu().getItemId();
		if(this.m_tree.getLevel(treeitemId)==1 || this.m_tree.getLevel(treeitemId)==2) {
			//alert( portalPage.getMessageResourceByParam('ev.error.tree.moveUpRoleRoot') );
			return;
		}
		aRoleManager.doMoveUpNodeTree( treeitemId );
	},
	onMoveDown : function () {
		var treeitemId = aRoleManager.getContextMenu().getItemId();
		if(this.m_tree.getLevel(treeitemId)==1 || this.m_tree.getLevel(treeitemId)==2) {
			//alert( portalPage.getMessageResourceByParam('ev.error.tree.moveDownRoleRoot') );
			return;
		}
		aRoleManager.doMoveDownNodeTree( treeitemId );
	},
	onNodeSelect : function (id) {
		aRoleManager.makePopupMenuSyle(parent,"#a9a9a9");
		aRoleManager.m_contextMenu.hide();
		aRoleManager.doSelectTree(id);
		
		/* 원본
		 * aRoleManager.m_contextMenu.hide();
		   aRoleManager.doSelectTree(id);*/
	},
	makePopupMenuSyle : function (parentId, color){		
		var htmlStr = "";
		var hr =  "<hr>";
		var onRefresh_0 = "<a onclick='aRoleManager.onRefresh()' style='border:none; cursor:hand; color:" + color  + ";'><img src='" + "" + "/admin/images/Service.gif'>" + portalPage.getMessageResource('ev.info.menu.refresh') + "</a>";
		var onCreate_0 = "<a onclick='aRoleManager.onCreate()' style='border:none; cursor:hand; color:" + color  + ";'><img src='" + "" + "/admin/images/ic_make_page.gif'>" + portalPage.getMessageResource('ev.info.menu.addRole') + "</a>";
		var onMoveUp_0 = "<a onclick='aRoleManager.onMoveUp()' style='border:none; cursor:hand; color:" + color  + ";'><img src='" + "" + "/admin/images/ic_up.gif'>" + portalPage.getMessageResource('ev.info.menu.moveUp') + "</a><br>";
		var onMoveDown_0 = "<a onclick='aRoleManager.onMoveDown()' style='border:none; cursor:hand; color:" + color  + ";'><img src='" + "" + "/admin/images/ic_down.gif'>" + portalPage.getMessageResource('ev.info.menu.moveDown') + "</a>";
		var onDelete_0 = "<a onclick='aRoleManager.onDelete()' style='border:none; cursor:hand; color:" + color  + ";'><img src='" + "" + "/admin/images/ic_del_b.gif'>" + portalPage.getMessageResource('ev.info.menu.delete') + "</a>";
		var onRefresh_1 = "<a onclick='aRoleMenu.hide(); aRoleManager.onRefresh()' style='border:none; cursor:hand;'><img src='" + "" + "/admin/images/Service.gif'>" + portalPage.getMessageResource('ev.info.menu.refresh') + "</a>";
		var onCreate_1 = "<a onclick='aRoleMenu.hide(); aRoleManager.onCreate()' style='border:none; cursor:hand;'><img src='" + "" + "/admin/images/ic_make_page.gif'>" + portalPage.getMessageResource('ev.info.menu.addRole') + "</a>";
		var onMoveUp_1 = "<a onclick='aRoleMenu.hide(); aRoleManager.onMoveUp()' style='border:none; cursor:hand;'><img src='" + "" + "/admin/images/ic_up.gif'>" + portalPage.getMessageResource('ev.info.menu.moveUp') + "</a><br>";
		var onMoveDown_1 = "<a onclick='aRoleMenu.hide(); aRoleManager.onMoveDown()' style='border:none; cursor:hand;'><img src='" + "" + "/admin/images/ic_down.gif'>" + portalPage.getMessageResource('ev.info.menu.moveDown') + "</a>";
		var onDelete_1= "<a onclick='aRoleMenu.hide(); aRoleManager.onDelete()' style='border:none; cursor:hand;'><img src='" + "" + "/admin/images/ic_del_b.gif'>" + portalPage.getMessageResource('ev.info.menu.delete') + "</a>";
		
		if(parentId==0) {
			htmlStr += onRefresh_1 + hr + onCreate_0 + hr + onMoveUp_0 + onMoveDown_0 + hr +onDelete_0;
		} else if(parentId==10) {
			htmlStr += onRefresh_1 + hr + onCreate_1 + hr + onMoveUp_0 + onMoveDown_0 + hr +onDelete_1;
		}
		else {
			htmlStr += onRefresh_1 + hr + onCreate_1 + hr + onMoveUp_1 + onMoveDown_1 + hr +onDelete_1;
		}	
		$("#RoleManager_RoleMenu").html(htmlStr);
	},
	toggleMaximize : function () {
		var left = document.getElementById("RoleManager_Left");
		var title = document.getElementById("RoleManager_Left_Title");
		var right = document.getElementById("RoleManager_Right");
		if( this.m_maximize == false ) {
			aRoleManager.m_oldTabWidth = right.clientWidth;
			aRoleManager.m_oldTabHeight = right.clientHeight;
			left.style.width = "0%";
			left.style.display = "none";
			right.style.width = "100%";
			title.style.display = "none";
			this.m_maximize = true;
		}
		else {
			left.style.width = "26%";
			left.style.display = "";
			right.style.width = "74%";
			title.style.display = "";
			this.m_maximize = false;
		}
	},
	doShowContextMenu : function(id, item) {
		/*var pos = (new enview.util.Utility()).getAbsolutePosition( item );
		this.onNodeSelect( id );
		
		this.m_contextMenu.setItemId( id );
		this.m_contextMenu.show( pos.getX()+45, pos.getY()+20 );*/
	},
	onDhtmlxContextClick : function (menuitemId, type) {
		if (menuitemId == "onRefresh") {
			aRoleManager.onRefresh();
		} else if (menuitemId == "onCreate") {
			aRoleManager.onCreate();
		} else if (menuitemId == "onMoveUp") {
			aRoleManager.onMoveUp();
		} else if (menuitemId == "onMoveDown") {
			aRoleManager.onMoveDown();
		} else if (menuitemId == "onDelete") {
			aRoleManager.onDelete();
		}
	},
	onSelectPropertyTab : function (id) {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		switch(id) {
			case 0 : {
				if($('#isAdmin').val() == 'true' || $('#RoleManager_Master_domainId').val() != 0){
					 if($('#RoleManager_principalId').val() != 10) $('.RoleManager_EditFormButtons').css('display', 'block');
					 else $('.RoleManager_EditFormButtons').css('display', 'none');
				}
				else $('.RoleManager_EditFormButtons').css('display', 'none');
			} break;
	 
			case 1 :
		
				param += "roleId=" + document.getElementById("RoleManager_principalId").value;
				if( aRoleUserManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/role/roleUser/list.admin", param, false, {
						success: function(data){
							document.getElementById("RoleManager_RoleUserTabPage").innerHTML = data;
							aRoleUserManager = new RoleUserManager( aRoleManager.m_evSecurityCode );
							aRoleUserManager.init();
							document.getElementById("RoleUserManager_Master_roleId").value = document.getElementById("RoleManager_principalId").value; 
							aRoleUserManager.doRetrieve();
						}});
				}
				else {
					
					document.getElementById("RoleUserManager_Master_roleId").value = document.getElementById("RoleManager_principalId").value; 
					aRoleUserManager.initSearch();
					aRoleUserManager.doRetrieve();
				}
			
				break;
	 
			case 2 :
		
				param += "principalId=" + document.getElementById("RoleManager_principalId").value;
				if( aPagePermissionManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/pagePermission/list.admin", param, false, {
						success: function(data){
							document.getElementById("RoleManager_PagePermissionTabPage").innerHTML = data;
							aPagePermissionManager = new PagePermissionManager( aRoleManager.m_evSecurityCode );
							aPagePermissionManager.init();
					
							document.getElementById("PagePermissionManager_Master_domainId").value = document.getElementById("RoleManager_domainId").value;
							document.getElementById("PagePermissionManager_Master_principalId").value = document.getElementById("RoleManager_principalId").value; 
							document.getElementById("PagePermissionManager_Master_principalType").value = "R";
							aPagePermissionManager.doRetrieve('RoleManager', 10);
						}});
				}
				else {
					document.getElementById("PagePermissionManager_Master_domainId").value = document.getElementById("RoleManager_Master_domainId").value;
					document.getElementById("PagePermissionManager_Master_principalId").value = document.getElementById("RoleManager_principalId").value; 
					document.getElementById("PagePermissionManager_Master_principalType").value = "R";
					aPagePermissionManager.initSearch();
					aPagePermissionManager.doRetrieve('RoleManager', 10);
				}
			
				break;
			case 3 :
				param += "principalId=" + document.getElementById("RoleManager_principalId").value;
				if( aPortletPermissionManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/portletPermission/list.admin", param, false, {
						success: function(data){
							document.getElementById("RoleManager_PortletPermissionTabPage").innerHTML = data;
							aPortletPermissionManager = new PortletPermissionManager( aRoleManager.m_evSecurityCode );
							aPortletPermissionManager.init();
							
							document.getElementById("PortletPermissionManager_Master_principalId").value = document.getElementById("RoleManager_principalId").value;
							document.getElementById("PortletPermissionManager_Master_domainId").value = document.getElementById("RoleManager_Master_domainId").value;
							document.getElementById("PortletPermissionManager_Master_principalType").value = "R";
							aPortletPermissionManager.doRetrieve('RoleManager', 10);
						}});
				}
				else {
					document.getElementById("PortletPermissionManager_Master_principalId").value = document.getElementById("RoleManager_principalId").value; 
					document.getElementById("PortletPermissionManager_Master_domainId").value = document.getElementById("RoleManager_Master_domainId").value;
					document.getElementById("PortletPermissionManager_Master_principalType").value = "R";
					aPortletPermissionManager.initSearch();
					aPortletPermissionManager.doRetrieve('RoleManager', 10);
				}
				break;
			case 4 :
				param += "principalId=" + document.getElementById("RoleManager_principalId").value;
				if( aUrlPermissionManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/urlPermission/list.admin", param, false, {
						success: function(data){
							document.getElementById("RoleManager_UrlPermissionTabPage").innerHTML = data;
							aUrlPermissionManager = new UrlPermissionManager( aRoleManager.m_evSecurityCode );
							aUrlPermissionManager.init();
							
							document.getElementById("UrlPermissionManager_Master_principalId").value = document.getElementById("RoleManager_principalId").value;
							document.getElementById("UrlPermissionManager_Master_domainId").value = document.getElementById("RoleManager_Master_domainId").value;
							document.getElementById("UrlPermissionManager_Master_principalType").value = "R";
							aUrlPermissionManager.doRetrieve('RoleManager', 10);
						}});
				}
				else {
					document.getElementById("UrlPermissionManager_Master_principalId").value = document.getElementById("RoleManager_principalId").value;
					document.getElementById("UrlPermissionManager_Master_domainId").value = document.getElementById("RoleManager_Master_domainId").value;
					document.getElementById("UrlPermissionManager_Master_principalType").value = "R";
					aUrlPermissionManager.initSearch();
					aUrlPermissionManager.doRetrieve('RoleManager', 10);
				}
				break;
		}
		
		return true;  
	},
	doSelectTree : function (id) {
		this.doSelectTreeNode(id);
		
		var formElem = document.forms[ "RoleManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = "1";
		formElem.elements[ "parentId" ].value = id;
		this.m_selectRowIndex = 0;
		
		this.doRetrieve();
	},
	doMoveParentTree : function ( item_id, parent_id ) {
		aRoleManager.m_contextMenu.hide();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&id=" + item_id + "&parentId=" + parent_id;
		
		this.m_ajax.send("POST", this.m_contextPath + "/role/changeParentForAjax.admin", param, false, {
			success: function(data){
				if( aRoleManager.m_tree.getOpenState(parent_id)==1 || aRoleManager.m_tree.hasChildren(parent_id)==0) {
					aRoleManager.m_tree.moveItem(item_id, "item_child", parent_id);
					aRoleManager.m_tree.openItem( item_id );
				}
				else {
					aRoleManager.m_tree.deleteItem(item_id, aRoleManager.m_tree.getParentId(item_id));
					aRoleManager.m_tree.refreshItem( parent_id );
					aRoleManager.onNodeSelect( item_id );
				}
			}});
	},
	doMoveUpNodeTree : function ( item_id ) {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&id=" + item_id + "&toDown=false";
		this.m_ajax.send("POST", this.m_contextPath + "/role/changeOrderForAjax.admin", param, false, { success: function(data){ aRoleManager.m_tree.moveItem(item_id, "up_strict"); }});
	},
	doMoveDownNodeTree : function ( item_id ) {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&id=" + item_id + "&toDown=true";
		this.m_ajax.send("POST", this.m_contextPath + "/role/changeOrderForAjax.admin", param, false, { success: function(data){ aRoleManager.m_tree.moveItem(item_id, "down_strict"); }});
	},
	doDeleteTree : function ()
	{
		var item_id = this.m_tree.getSelectedItemId();
		if( item_id == 0 ) {
			alert( portalPage.getMessageResourceByParam('ev.error.tree.node.system.delete') );
			return;
		}
		var msg = portalPage.getMessageResourceByParam('ev.info.tree.node.remove', aRoleManager.m_tree.getItemText(item_id));
		var ret = confirm( msg );
		if( ret == false ) {
			return false;
		}
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&pks=" + item_id + ":" + document.getElementById('RoleManager_shortPath').value + "&domainId=" + document.getElementById('RoleManager_domainId').value + "&";
		this.m_ajax.send("POST", this.m_contextPath + "/role/removeForAjax.admin", param, false, {
			success: function(data){
				aRoleManager.onRefresh( aRoleManager.m_tree.getParentId(item_id) );
				aRoleManager.doRetrieve();
				enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
			}
		});
	},
	initSearch : function () {
		var formElem = document.forms[ "RoleManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () {
		//this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "RoleManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/role/listForAjax.admin", param, false, {success: function(data) { aRoleManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		this.m_utility.setListData(
			"RoleManager",
			new Array('principalId', 'shortPath'),
			new Array('principalId', 'shortPath', 'principalName', 'modifiedDate'),
			this.m_contextPath,
			resultObject);
				
		if(resultObject.Data.length != 0) {
			//this.doDefaultSelect(); 
		}
		else {
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&principalId=" + aRoleManager.m_tree.getSelectedItemId();
			this.m_ajax.send("POST", this.m_contextPath + "/role/detailForAjax.admin", param, false, {success: function(data) { aRoleManager.doSelectHandler(data); }});
		}
		if($('#isAdmin').val() == 'true' || $('#RoleManager_Master_domainId').val() != 0){
			 if($('#RoleManager_principalId').val() != 10) $('.RoleManager_EditFormButtons').css('display', 'block');
			 else $('.RoleManager_EditFormButtons').css('display', 'none');
		}
		else $('.RoleManager_EditFormButtons').css('display', 'none');
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
		var formElem = document.forms[ "RoleManager_SearchForm" ];
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
	doSelectTreeNode : function (id)
	{
		aRoleManager.m_tree.selectItem(id,false,true);
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		param += "principalId=" + id;
		this.m_ajax.send("POST", this.m_contextPath + "/role/detailForAjax.admin", param, false, {success: function(data) { aRoleManager.doSelectHandler(data); }});
	},
	doDefaultSelect : function ()
	{
		document.getElementById('RoleManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "principalId=";
		param += document.getElementById('RoleManager[' + this.m_selectRowIndex + '].principalId').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/role/detailForAjax.admin", param, false, {success: function(data) { aRoleManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("RoleManager_ListForm") );
	    document.getElementById('RoleManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "principalId=";
		param += document.getElementById('RoleManager[' + rowSeq + '].principalId').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/role/detailForAjax.admin", param, false, {success: function(data) { aRoleManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "RoleManager", resultObject);
		document.getElementById("RoleManager_gradeId").value = portalPage.getAjax().retrieveElementValue("gradeId", resultObject);
		document.getElementById("SecurityPermission_principalId").value = document.getElementById("RoleManager_principalId").value;
		$("#domain").text(portalPage.getAjax().retrieveElementValue("domain", resultObject));
		$("#RoleManager_Master_domainId").val(portalPage.getAjax().retrieveElementValue("domainId", resultObject));
		
	    document.getElementById("RoleManager_shortPath").readOnly = true;
		document.getElementById("RoleManager_creationDate").readOnly = true;
		document.getElementById("RoleManager_modifiedDate").readOnly = true;
		
		
		var propertyTabs = $("#RoleManager_propertyTabs").tabs();
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		
		if(document.getElementById("RoleManager_principalId").value == 10){
			if(propSelectedTabId == 1){
				propSelectedTabId = 0;
			}
			propertyTabs.tabs('disable', 1);
		} else {
			propertyTabs.tabs('enable', 1);	 
		}
		propertyTabs.tabs('enable', 2);	
		propertyTabs.tabs('enable', 3);
		propertyTabs.tabs('enable', 4);
		propertyTabs.tabs('option', 'active', propSelectedTabId);
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("RoleManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "RoleManager");
		var propertyTabs = $("#RoleManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
		propertyTabs.tabs('disable', 1);	 
		propertyTabs.tabs('disable', 2);	 
		propertyTabs.tabs('disable', 3);
		propertyTabs.tabs('disable', 4);
		document.getElementById("RoleManager_domainId").value = document.getElementById("RoleManager_Master_domainId").value;
		document.getElementById("RoleManager_parentId").value = document.getElementById("RoleManager_Master_parentId").value; 
		document.getElementById("RoleManager_shortPath").readOnly = false;
		document.getElementById("RoleManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)	{
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("RoleManager_isCreate").value;
		var form = document.getElementById("RoleManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";
		param += "gradeId=" + document.getElementById("RoleManager_gradeId").value + "&";
		
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/role/addForAjax.admin", param, false, {
				success: function(data)	{
					aRoleManager.onRefresh( document.getElementById("RoleManager_parentId").value );
					aRoleManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/role/updateForAjax.admin", param, false, {
				success: function(data){
					aRoleManager.onRefresh( document.getElementById("RoleManager_parentId").value );
					aRoleManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("RoleManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var principalId = null;
			var param = "evSecurityCode=" + this.m_evSecurityCode;
			param += "&domainId=" + $('#RoleManager_domainId').val();
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += document.getElementById('RoleManager[' + rowCntArray[i] + '].principalId').value + ":" +
						 document.getElementById('RoleManager[' + rowCntArray[i] + '].shortPath').value;
				principalId = document.getElementById('RoleManager[' + rowCntArray[i] + '].principalId').value;
	        }
	        var parentId = aRoleManager.m_tree.getParentId(principalId);
			this.m_ajax.send("POST", this.m_contextPath + "/role/removeForAjax.admin", param, false, {
				success: function(data){
					aRoleManager.onRefresh( parentId );
					aRoleManager.initSearch();
					aRoleManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
		}
	}
	
}
var aRoleMenu = null;
RoleMenu = function(contextPath)
{
	if( portalPage == null) portalPage = new enview.portal.Page();
	
	/*this.m_domElement = document.createElement('div');
	this.m_domElement.id = "RoleManager_RoleMenu";
	this.m_domElement.title = "Role Menu";
	var htmlStr = "";
	htmlStr += "<a onclick='aRoleManager.onRefresh()' style='border:none; cursor:hand;'><img src='" + contextPath + "/admin/images/Service.gif'>" + portalPage.getMessageResource('ev.info.menu.refresh') + "</a>";
	htmlStr += "<hr>";
	htmlStr += "<a onclick='aRoleManager.onCreate()' style='border:none; cursor:hand;'><img src='" + contextPath + "/admin/images/ic_make_page.gif'>" + portalPage.getMessageResource('ev.info.menu.addRole') + "</a>";
	htmlStr += "<hr>";
	htmlStr += "<a onclick='aRoleManager.onMoveUp()' style='border:none; cursor:hand;'><img src='" + contextPath + "/admin/images/ic_up.gif'>" + portalPage.getMessageResource('ev.info.menu.moveUp') + "</a><br>";
	htmlStr += "<a onclick='aRoleManager.onMoveDown()' style='border:none; cursor:hand;'><img src='" + contextPath + "/admin/images/ic_down.gif'>" + portalPage.getMessageResource('ev.info.menu.moveDown') + "</a>";
	htmlStr += "<hr>";
	htmlStr += "<a onclick='aRoleManager.onDelete()' style='border:none; cursor:hand;'><img src='" + contextPath + "/admin/images/ic_del_b.gif'>" + portalPage.getMessageResource('ev.info.menu.delete') + "</a>";
	this.m_domElement.innerHTML = htmlStr;
	//alert(htmlStr);

	document.body.appendChild( this.m_domElement );*/
		
	$("#RoleManager_RoleMenu").dialog({
		autoOpen: false,
		width: "140px",
		resizable: false,
		modal: true,
		open: function(event, ui) { 
			//$(".ui-dialog-titlebar-close").hide(); 
			//$("#RoleManager_RoleMenu").attr("style", "left:" + left);
			//$("#RoleManager_RoleMenu").attr("style", "top:" + top);
		}
	});
	
	this.init();
}

RoleMenu.prototype =
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
		
		$('#RoleManager_RoleMenu').dialog( "option", "position", [left,top] );
		$('#RoleManager_RoleMenu').dialog('open');
	},
	hide : function()
	{
		$('#RoleManager_RoleMenu').dialog('close');
	}
}

var aRoleChooser = null;
RoleChooser = function(evSecurityCode, domainId, multiSelect)
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	if( portalPage == null) portalPage = new enview.portal.Page();
	this.m_selectRowIndex = 0;
	this.m_evSecurityCode = evSecurityCode;
	this.m_domainId = domainId;
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = portalPage.getContextPath();
	this.m_domElement = document.getElementById("RoleManager_RoleChooser");
	this.m_multiSelect = multiSelect;
	
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
	
	$("#RoleManager_RoleChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:300, 
		modal: true,
		buttons: {
			"Apply": function() {
				aRoleChooser.doApply();
			},
			Cancel: function() {
				$(this).dialog('close');
			}
		}
	});
	
	this.init();
}

RoleChooser.prototype =
{
	m_domElement : null,
	m_checkBox : null,
	m_sourceElement : null,
	m_callback : null,
	m_evSecurityCode : null,
	m_multiSelect : true,
	
	m_param: '',
	
	init : function() {
		this.m_tree = new dhtmlXTreeObject(document.getElementById('RoleChooser_TreeTabPage'),"100%","100%",0);
		this.m_tree.setImagePath(this.m_contextPath + "/dhtmlx/imgs/dhxtree_skyblue/");
		//this.m_tree.setOnClickHandler( this.onNodeSelect );
		this.m_tree.enableAutoTooltips(true);
		this.m_tree.enableCheckBoxes(true);
		this.m_tree.setXMLAutoLoading(this.m_contextPath + "/role/retrieveTreeForAjax.admin?evSecurityCode=" + this.m_evSecurityCode + "&domainId=" + this.m_domainId);
		this.m_tree.load(this.m_contextPath + "/role/retrieveTreeForAjax.admin?id=10&evSecurityCode=" + this.m_evSecurityCode + "&domainId=" + this.m_domainId);
	},
	
	doShow : function (callback)
	{
		this.m_callback = callback;
		
		$('#RoleManager_RoleChooser').dialog('open');
	},
	onNodeSelect : function (id) {
		aRoleChooser.m_tree.setCheck(id, true);
	},
	doApply : function(id) {
		var checkIds = this.m_tree.getAllChecked();
		if( checkIds != null && checkIds.length > 0 ) {
			var checkArray = checkIds.split(",");
			var result = new Array(checkArray.length);
			
			if (this.m_multiSelect == false && checkArray.length > 1) {
				alert('역할을 한 개 이상 선택할 수 없습니다.');
				return;
			}
			
			$('#RoleManager_RoleChooser').dialog('close');
			for(var i=0; i<checkArray.length; i++) {
				var rowMap = new Map();
				
				var userData = this.m_tree.getUserData(checkArray[i], "path");
				rowMap.put("principalId", checkArray[i]);	
				rowMap.put("roleId", userData);	
				rowMap.put("title", this.m_tree.getItemText(checkArray[i]));
				result[i] = rowMap;
			}
			
			this.m_callback(result);
		} else {
			$('#RoleManager_RoleChooser').dialog('close');
			this.m_callback(null);
		}
	}
	/*
	doRetrieve : function () {
		//this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "RoleChooser_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		//alert(param);
		
		this.m_ajax.send("POST", this.m_contextPath + "/role/listForAjax.admin", param, false, {success: function(data) { aRoleChooser.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		this.m_utility.setListData(
			"RoleChooser",
			new Array('principalId', 'shortPath', 'principalName'),
			new Array('principalId', 'shortPath', 'principalName'),
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
		var formElem = document.forms[ "RoleChooser_SearchForm" ];
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
		
		this.m_checkBox.unChkAll( document.getElementById("RoleChooser_ListForm") );
		document.getElementById('RoleChooser[' + rowSeq + '].checkRow').checked = true;
	},
	doApply : function(id) {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("RoleChooser_ListForm") );
		if( rowCnts == "" ) return;
		
		var rowCntArray = rowCnts.split(",");
		
		$('#RoleManager_RoleChooser').dialog('close');
		
		var result = new Array(rowCntArray.length);
		for(var i=0; i<rowCntArray.length; i++) {
			var rowMap = new Map();
		
			rowMap.put("principalId", document.getElementById('RoleChooser[' + rowCntArray[i] + '].principalId').value);	
			rowMap.put("shortPath", document.getElementById('RoleChooser[' + rowCntArray[i] + '].shortPath').value);	
			rowMap.put("principalName", document.getElementById('RoleChooser[' + rowCntArray[i] + '].principalName').value);	
			result[i] = rowMap;
		}
		
		this.m_callback(result);
	}
	*/
}

