var aGroupManager = null;
GroupManager = function(evSecurityCode) 
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
GroupManager.prototype =
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
			,{"fieldName":"domainId", "validation":""}
			,{"fieldName":"shortPath", "validation":"Required,MaxLength", "maxLength":"30"}
			,{"fieldName":"principalName", "validation":"Required,MaxLength", "maxLength":"40"}
			,{"fieldName":"theme", "validation":""}
			,{"fieldName":"siteName", "validation":""}
			,{"fieldName":"defaultPage", "validation":""}
			,{"fieldName":"subPage", "validation":""}
			,{"fieldName":"principalType", "validation":""}
			,{"fieldName":"principalOrder", "validation":""}
			,{"fieldName":"creationDate", "validation":""}
			,{"fieldName":"modifiedDate", "validation":""}
			,{"fieldName":"principalInfo01", "validation":"MaxLength", "maxLength":"50"}
			,{"fieldName":"principalInfo02", "validation":"MaxLength", "maxLength":"50"}
			,{"fieldName":"principalInfo03", "validation":"MaxLength", "maxLength":"50"}
			,{"fieldName":"principalDesc", "validation":"MaxLength", "maxLength":"80"}
			
		];
				
		this.m_contextMenu = aGroupMenu = new GroupMenu(this.m_contextPath);
		this.m_dhtmlxContextMenu = new dhtmlXMenuObject();
		this.m_dhtmlxContextMenu.renderAsContextMenu();
		this.m_dhtmlxContextMenu.attachEvent("onClick",this.onDhtmlxContextClick);
		this.m_dhtmlxContextMenu.loadFromHTML("dhtmlx_context_data", true);
		this.m_tree = new dhtmlXTreeObject(document.getElementById('GroupManager_TreeTabPage'),"100%","100%",0);
		this.m_tree.setImagePath(this.m_contextPath + "/dhtmlx/imgs/dhxtree_skyblue/");
		this.m_tree.setOnClickHandler( this.onNodeSelect );
		this.m_tree.enableDragAndDrop(false)
		//this.m_tree.setDragHandler( this.onDragAndDrop );
		//this.m_tree.setOnRightClickHandler( this.onContextMenuHandler );
		this.m_tree.enableAutoTooltips(true);
		this.m_tree.enableContextMenu(this.m_dhtmlxContextMenu);
		this.m_tree.attachEvent("onBeforeContextMenu", function (id) {
			aGroupManager.onNodeSelect( id );
			aGroupManager.m_contextMenu.setItemId( id );
			return true;
		});
		//this.m_tree.setChildCalcMode(true);
		//this.m_tree.enableItemEditor(true);
		//this.m_tree.enableKeyboardNavigation(true);
		this.m_tree.setXMLAutoLoading(this.m_contextPath + "/group/retrieveTreeForAjax.admin?evSecurityCode=" + this.m_evSecurityCode);
		this.m_tree.load(this.m_contextPath + "/group/retrieveTreeForAjax.admin?id=100&evSecurityCode=" + this.m_evSecurityCode);
		
		$(function() 
		{
			$("#GroupManager_propertyTabs").tabs();
		});
		
		$.datepicker.setDefaults({
			showMonthAfterYear: true,
			changeMonth: true,
			changeYear: true,
			showButtonPanel: true,
			showAnim : 'slideDown',
			dateFormat : 'yy-mm-dd'
		});

		document.onkeyup = aGroupManager.onCheckKey;
	},
	getPageChooser : function () {
		var domainId = $('#GroupManager_domainId').val();
		var extraParam = "&showPublic="+ $('#showPublic').val();
//		if( aPageChooser == null ) {
			aPageChooser = new PageChooser( aGroupManager.m_evSecurityCode, domainId, extraParam );
//		}
		return aPageChooser;
	},
	setDefaultPageChooserCallback : function (rowArray) {
		//document.getElementById("PageManager_defaultPageName").value = rowArray[0].get("pageId");
		document.getElementById("GroupManager_defaultPage").value = rowArray[0].get("pagePath");
	},
	setSubPageChooserCallback : function (rowArray) {
		//document.getElementById("PageManager_defaultPageName").value = rowArray[0].get("pageId");
		document.getElementById("GroupManager_subPage").value = rowArray[0].get("pagePath");
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
	setDefaultPageMultiChooserCallback : function (rowArray) {
		//document.getElementById("PageManager_defaultPageName").value = rowArray[0].get("pageId");
		document.getElementById("GroupManager_defaultPage").value = rowArray[0].get("pagePath");
	},
	setSubPageMultiChooserCallback : function (rowArray) {
		//document.getElementById("PageManager_defaultPageName").value = rowArray[0].get("pageId");
		document.getElementById("GroupManager_subPage").value = rowArray[0].get("pagePath");
	},
	setSiteChooserCallback : function (rowArray) {
		document.getElementById("GroupManager_siteName").value = rowArray[0].get("pagePath");
	},
	getContextMenu : function()
	{
		return this.m_contextMenu;
	},
	onContextMenuHandler : function (treeitemId, event) 
	{
		aGroupManager.doShowContextMenu( treeitemId, event );
	},
	onSelect : function (treeitemId) 
	{
		
		aGroupManager.doSelect( treeitemId );
	},
	onRefresh : function (id) {
		var treeitemId = (id) ? id : aGroupManager.getContextMenu().getItemId();
		//alert("treeitemId=" + treeitemId);
		aGroupManager.getContextMenu().hide();
		if( treeitemId == 100 ) { aGroupManager.m_tree.deleteChildItems( 0 ); }
		if( treeitemId != null ) {
			aGroupManager.m_tree.refreshItem( treeitemId );
		}
	},
	onCheckKey : function (a_event) {
		if( document.all ) {
			if( event.keyCode ) {
				if( event.ctrlKey == true && event.keyCode == 90 ) {
					aGroupManager.toggleMaximize();
				}
				else if( event.ctrlKey == true && event.keyCode == 38 ) {
					aGroupManager.doMoveUpNodeTree( aGroupManager.m_tree.getSelectedItemId() );
				}
				else if( event.ctrlKey == true && event.keyCode == 40 ) {
					aGroupManager.doMoveDownNodeTree( aGroupManager.m_tree.getSelectedItemId() );
				}
			}
		}
		else {
			if( a_event.ctrlKey == true && a_event.keyCode == 90 ) {
				aGroupManager.toggleMaximize();
			}
			else if( a_event.ctrlKey == true && a_event.keyCode == 38 ) {
				aGroupManager.doMoveUpNodeTree( aGroupManager.m_tree.getSelectedItemId() );
			}
			else if( a_event.ctrlKey == true && a_event.keyCode == 40 ) {
				aGroupManager.doMoveDownNodeTree( aGroupManager.m_tree.getSelectedItemId() );
			}
		}
	},
	onCreate : function () 
	{
		var treeitemId = aGroupManager.getContextMenu().getItemId();		
		if( this.m_tree.getLevel(treeitemId)==1 ) {
			//alert( portalPage.getMessageResourceByParam('ev.error.tree.createGroupRoot') );
			return;
		} 
		aGroupManager.doCreate( treeitemId );
	},
	onDelete : function () {
		var treeitemId = aGroupManager.getContextMenu().getItemId();		
		if( this.m_tree.getLevel(treeitemId)==1) {
			//alert( portalPage.getMessageResourceByParam('ev.error.tree.deleteGroupRoot') );
			return;
		} 
		return aGroupManager.doDeleteTree(treeitemId);
	},
	onDragAndDrop : function (subKey, item_id, parent_id, before, item, parent) 
	{
		if( this.m_tree.getLevel(item_id)==1 ) {
			//alert( portalPage.getMessageResourceByParam('ev.info.forbiden.updateRoot') );
			return;
		}
		
		if( subKey == 0 ) {	// move
			var msg = portalPage.getMessageResourceByParam('ev.info.tree.node.move', aGroupManager.m_tree.getItemText(item_id), aGroupManager.m_tree.getItemText(parent_id));
			var ret = confirm( msg );
			if( ret == true ) {
				aGroupManager.doMoveParentTree(item_id, parent_id);
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
		var treeitemId = aGroupManager.getContextMenu().getItemId();		
		if(this.m_tree.getLevel(treeitemId)==1 || this.m_tree.getLevel(treeitemId)==2) {
			//alert( portalPage.getMessageResourceByParam('ev.error.tree.moveUpGroupRoot') );
			return;
		}
		aGroupManager.doMoveUpNodeTree( treeitemId );
	},
	onMoveDown : function () {
		var treeitemId = aGroupManager.getContextMenu().getItemId();		
		if(this.m_tree.getLevel(treeitemId)==1 || this.m_tree.getLevel(treeitemId)==2) {
			//alert( portalPage.getMessageResourceByParam('ev.error.tree.moveDownGroupRoot') );
			return;
		} 
		aGroupManager.doMoveDownNodeTree( treeitemId );
	},
	onNodeSelect : function (id){
		aGroupManager.makePopupMenuSyle(parent,"#a9a9a9");
		aGroupManager.m_contextMenu.hide();
		aGroupManager.doSelectTree(id);
		
		/* 원본
		aGroupManager.m_contextMenu.hide();
		aGroupManager.doSelectTree(id);*/
	},
	makePopupMenuSyle : function (parentId, color){
		var htmlStr = "";
		var hr =  "<hr>";
		var onRefresh_0 = "<a onclick='aGroupManager.onRefresh()' style='border:none; cursor:hand; color:" + color  + ";'><img src='" + "" + "/admin/images/Service.gif'>" + portalPage.getMessageResource('ev.info.menu.refresh') + "</a>";
		var onCreate_0 = "<a onclick='aGroupManager.onCreate()' style='border:none; cursor:hand; color:" + color  + ";'><img src='" + "" + "/admin/images/ic_make_page.gif'>" + portalPage.getMessageResource('ev.info.menu.addGroup') + "</a>";
		var onMoveUp_0= "<a onclick='aGroupManager.onMoveUp()' style='border:none; cursor:hand;color:" + color  + ";'><img src='" + "" + "/admin/images/ic_up.gif'>" + portalPage.getMessageResource('ev.info.menu.moveUp') + "</a><br>";
		var onMoveDown_0 = "<a onclick='aGroupManager.onMoveDown()' style='border:none; cursor:hand;color:" + color  + ";'><img src='" + "" + "/admin/images/ic_down.gif'>" + portalPage.getMessageResource('ev.info.menu.moveDown') + "</a>";
		var onDelete_0 = "<a onclick='aGroupManager.onDelete()' style='border:none; cursor:hand;color:" + color  + ";'><img src='" + "" + "/admin/images/ic_del_b.gif'>" + portalPage.getMessageResource('ev.info.menu.delete') + "</a>";

		var onRefresh_1 = "<a onclick='aGroupMenu.hide(); aGroupManager.onRefresh()' style='border:none; cursor:hand;'><img src='" + "" + "/admin/images/Service.gif'>" + portalPage.getMessageResource('ev.info.menu.refresh') + "</a>";
		var onCreate_1 = "<a onclick='aGroupMenu.hide(); aGroupManager.onCreate()' style='border:none; cursor:hand;'><img src='" + "" + "/admin/images/ic_make_page.gif'>" + portalPage.getMessageResource('ev.info.menu.addGroup') + "</a>";
		var onMoveUp_1= "<a onclick='aGroupMenu.hide(); aGroupManager.onMoveUp()' style='border:none; cursor:hand;'><img src='" + "" + "/admin/images/ic_up.gif'>" + portalPage.getMessageResource('ev.info.menu.moveUp') + "</a><br>";
		var onMoveDown_1 = "<a onclick='aGroupMenu.hide(); aGroupManager.onMoveDown()' style='border:none; cursor:hand;'><img src='" + "" + "/admin/images/ic_down.gif'>" + portalPage.getMessageResource('ev.info.menu.moveDown') + "</a>";
		var onDelete_1 = "<a onclick='aGroupMenu.hide(); aGroupManager.onDelete()' style='border:none; cursor:hand;'><img src='" + "" + "/admin/images/ic_del_b.gif'>" + portalPage.getMessageResource('ev.info.menu.delete') + "</a>";

		if(parentId==0) {
			htmlStr += onRefresh_1 + hr + onCreate_0 + hr + onMoveUp_0 + onMoveDown_0 + hr +onDelete_0;
		} else if(parentId==100) {
			htmlStr += onRefresh_1 + hr + onCreate_1 + hr + onMoveUp_0 + onMoveDown_0 + hr +onDelete_1;
		}
		else {
			htmlStr += onRefresh_1 + hr + onCreate_1 + hr + onMoveUp_1 + onMoveDown_1 + hr +onDelete_1;
		}	
		$("#GroupManager_GroupMenu").html(htmlStr);
	},	
	toggleMaximize : function () {
		var left = document.getElementById("GroupManager_Left");
		var title = document.getElementById("GroupManager_Left_Title");
		var right = document.getElementById("GroupManager_Right");
		if( this.m_maximize == false ) {
			aGroupManager.m_oldTabWidth = right.clientWidth;
			aGroupManager.m_oldTabHeight = right.clientHeight;
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
	doShowContextMenu : function(id, event) 
	{
		/*var pos = (new enview.util.Utility()).getAbsolutePosition( (event.srcElement||event.target) );
		this.onNodeSelect( id );
		this.m_contextMenu.setItemId( id );
		this.m_contextMenu.show( pos.getX()+45, pos.getY()+20 );*/
	},
	
	onDhtmlxContextClick : function (menuitemId, type) {
		if (menuitemId == "onRefresh") {
			aGroupManager.onRefresh();
		} else if (menuitemId == "onCreate") {
			aGroupManager.onCreate();
		} else if (menuitemId == "onMoveUp") {
			aGroupManager.onMoveUp();
		} else if (menuitemId == "onMoveDown") {
			aGroupManager.onMoveDown();
		} else if (menuitemId == "onDelete") {
			aGroupManager.onDelete();
		}
	},
	
	onSelectPropertyTab : function (id) {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		switch(id) {
			case 0 : {
				if($('#isAdmin').val() == 'true' || $('#GroupManager_Master_domainId').val() != 0){
					 if($('#GroupManager_principalId').val() != 100) {
						 $('.GroupManager_EditFormButtons').css('display', 'block');
						 $('.GroupDetailManager_EditFormButtons').css('display', 'inline-block');
					 }
					 else {
						 $('.GroupManager_EditFormButtons').css('display', 'none');
						 $('.GroupDetailManager_EditFormButtons').css('display', 'none');
					 }
				}else {
					$('.GroupManager_EditFormButtons').css('display', 'none');
					$('.GroupDetailManager_EditFormButtons').css('display', 'none');
				}
			}
				break;
	 
			case 1 :
		
				param += "groupId=" + document.getElementById("GroupManager_principalId").value;
				if( aGroupUserManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/group/groupUser/list.admin", param, false, {
						success: function(data){
							document.getElementById("GroupManager_GroupUserTabPage").innerHTML = data;
							aGroupUserManager = new GroupUserManager( aGroupManager.m_evSecurityCode );
							aGroupUserManager.init();
							
							document.getElementById("GroupUserManager_Master_groupId").value = document.getElementById("GroupManager_principalId").value; 
							aGroupUserManager.doRetrieve();
						}});
				}
				else {
					
					document.getElementById("GroupUserManager_Master_groupId").value = document.getElementById("GroupManager_principalId").value; 
					aGroupUserManager.initSearch();
					aGroupUserManager.doRetrieve();
				}
			
				break;
	 
			case 2 :
		
				param += "groupId=" + document.getElementById("GroupManager_principalId").value;
				if( aGroupRoleManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/group/groupRole/list.admin", param, false, {
						success: function(data){
							document.getElementById("GroupManager_GroupRoleTabPage").innerHTML = data;
							aGroupRoleManager = new GroupRoleManager( aGroupManager.m_evSecurityCode );
							aGroupRoleManager.init();
							
							document.getElementById("GroupRoleManager_Master_groupId").value = document.getElementById("GroupManager_principalId").value; 
							aGroupRoleManager.doRetrieve();
						}});
				}
				else {
					
					document.getElementById("GroupRoleManager_Master_groupId").value = document.getElementById("GroupManager_principalId").value; 
					aGroupRoleManager.initSearch();
					aGroupRoleManager.doRetrieve();
				}
			
				break;
	 
			case 3 :
		
				param += "principalId=" + document.getElementById("GroupManager_principalId").value;
				if( aPagePermissionManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/pagePermission/list.admin", param, false, {
						success: function(data){
							document.getElementById("GroupManager_PagePermissionTabPage").innerHTML = data;
							aPagePermissionManager = new PagePermissionManager( aGroupManager.m_evSecurityCode );
							aPagePermissionManager.init();
							
							document.getElementById("PagePermissionManager_Master_principalId").value = document.getElementById("GroupManager_principalId").value; 
							document.getElementById("PagePermissionManager_Master_principalType").value = "G"; 
							aPagePermissionManager.doRetrieve();
						}});
				}
				else {
					
					document.getElementById("PagePermissionManager_Master_principalId").value = document.getElementById("GroupManager_principalId").value; 
					document.getElementById("PagePermissionManager_Master_principalType").value = "G"; 
					aPagePermissionManager.initSearch();
					aPagePermissionManager.doRetrieve();
				}
			
				break;
			case 4 :
				param += "principalId=" + document.getElementById("GroupManager_principalId").value;
				if( aPortletPermissionManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/portletPermission/list.admin", param, false, {
						success: function(data){
							document.getElementById("GroupManager_PortletPermissionTabPage").innerHTML = data;
							aPortletPermissionManager = new PortletPermissionManager( aGroupManager.m_evSecurityCode );
							aPortletPermissionManager.init();
							
							document.getElementById("PortletPermissionManager_Master_principalId").value = document.getElementById("GroupManager_principalId").value; 
							document.getElementById("PagePermissionManager_Master_principalType").value = "G"; 
							aPortletPermissionManager.doRetrieve();
						}});
				}
				else {
					document.getElementById("PortletPermissionManager_Master_principalId").value = document.getElementById("GroupManager_principalId").value; 
					document.getElementById("PagePermissionManager_Master_principalType").value = "G"; 
					aPortletPermissionManager.initSearch();
					aPortletPermissionManager.doRetrieve();
				}
				break;
		}
		
		return true; 
	},
	doSelectTree : function (id) 
	{
		this.doSelectTreeNode(id);
		
		var formElem = document.forms[ "GroupManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = "1";
		formElem.elements[ "parentId" ].value = id;
		this.m_selectRowIndex = 0;
		
		this.doRetrieve();
	},
	doMoveParentTree : function ( item_id, parent_id ) 
	{
		aGroupManager.m_contextMenu.hide();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&id=" + item_id + "&parentId=" + parent_id;
		
		this.m_ajax.send("POST", this.m_contextPath + "/group/changeParentForAjax.admin", param, false, {
			success: function(data){
				if( aGroupManager.m_tree.getOpenState(parent_id)==1 || aGroupManager.m_tree.hasChildren(parent_id)==0) {
					aGroupManager.m_tree.moveItem(item_id, "item_child", parent_id);
					aGroupManager.m_tree.openItem( item_id );
				}
				else {
					aGroupManager.m_tree.deleteItem(item_id, aGroupManager.m_tree.getParentId(item_id));
					aGroupManager.m_tree.refreshItem( parent_id );
					aGroupManager.onNodeSelect( item_id );
				}
			}});
	},
	doMoveUpNodeTree : function ( item_id ) {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&id=" + item_id + "&toDown=false";
		this.m_ajax.send("POST", this.m_contextPath + "/group/changeOrderForAjax.admin", param, false, { success: function(data){ aGroupManager.m_tree.moveItem(item_id, "up_strict"); }});
	},
	doMoveDownNodeTree : function ( item_id ) {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&id=" + item_id + "&toDown=true";
		this.m_ajax.send("POST", this.m_contextPath + "/group/changeOrderForAjax.admin", param, false, { success: function(data){ aGroupManager.m_tree.moveItem(item_id, "down_strict"); }});
	},
	doDeleteTree : function () {
		var item_id = this.m_tree.getSelectedItemId();
		if( item_id == 0 ) {
				alert( portalPage.getMessageResourceByParam('ev.error.tree.node.system.delete') );
				return;
		}
		var msg = portalPage.getMessageResourceByParam('ev.info.tree.node.remove', aGroupManager.m_tree.getItemText(item_id));
		var ret = confirm( msg );
		if( ret == false ) {
			return false;
		}
	
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&pks=" + item_id + ":" + document.getElementById('GroupManager_shortPath').value + "&domainId=" + document.getElementById('GroupManager_domainId').value + "&";
	    this.m_ajax.send("POST", this.m_contextPath + "/group/removeForAjax.admin", param, false, {
			success: function(data){
				aGroupManager.m_contextMenu.hide();
				aGroupManager.onRefresh( aGroupManager.m_tree.getParentId(item_id) );
				enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove'));
			}});
	},
	initSearch : function () {
		var formElem = document.forms[ "GroupManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () {
		//this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "GroupManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/group/listForAjax.admin", param, false, {success: function(data) { aGroupManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		this.m_utility.setListData(
			"GroupManager",
			new Array('principalId'),
			new Array('principalId', 'shortPath', 'principalName', 'modifiedDate'),
			this.m_contextPath,
			resultObject);
				
		if(resultObject.Data.length != 0) {
			//this.doDefaultSelect(); 
		}
		else {
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&principalId=" + aGroupManager.m_tree.getSelectedItemId();
			this.m_ajax.send("POST", this.m_contextPath + "/group/detailForAjax.admin", param, false, {success: function(data) { aGroupManager.doSelectHandler(data); }});
		}
		
		if($('#isAdmin').val() == 'true' || $('#GroupManager_Master_domainId').val() != 0){
			 if($('#GroupManager_principalId').val() != 100) $('.GroupManager_EditFormButtons').css('display', 'block');
			 else $('.GroupManager_EditFormButtons').css('display', 'none');
		}else {
			$('.GroupManager_EditFormButtons').css('display', 'none');
		}
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
		var formElem = document.forms[ "GroupManager_SearchForm" ];
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
		aGroupManager.m_tree.selectItem(id,false,true);
		var param = "principalId=" + id;
		param += "&evSecurityCode=" + this.m_evSecurityCode;
		this.m_ajax.send("POST", this.m_contextPath + "/group/detailForAjax.admin", param, false, {success: function(data) { aGroupManager.doSelectHandler(data); }});
		
	},
	doDefaultSelect : function ()
	{
		document.getElementById('GroupManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "principalId=";
		param += document.getElementById('GroupManager[' + this.m_selectRowIndex + '].principalId').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/group/detailForAjax.admin", param, false, {success: function(data) { aGroupManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("GroupManager_ListForm") );
	    document.getElementById('GroupManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "principalId=";
		param += document.getElementById('GroupManager[' + rowSeq + '].principalId').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/group/detailForAjax.admin", param, false, {success: function(data) { aGroupManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
	
		var index = 0;
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "GroupManager", resultObject);
		
		document.getElementById("GroupManager_gradeId").value = portalPage.getAjax().retrieveElementValue("gradeId", resultObject);
		document.getElementById("SecurityPermission_principalId").value = document.getElementById("GroupManager_principalId").value;
		$("#domain").text(portalPage.getAjax().retrieveElementValue("domain", resultObject));
		$("#GroupManager_Master_domainId").val(portalPage.getAjax().retrieveElementValue("domainId", resultObject));
		document.getElementById("GroupManager_shortPath").readOnly = true;
		document.getElementById("GroupManager_creationDate").readOnly = true;
		document.getElementById("GroupManager_modifiedDate").readOnly = true;
		
		
		var propertyTabs = $("#GroupManager_propertyTabs").tabs();
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		
		if(document.getElementById("GroupManager_principalId").value == 100){
			if(propSelectedTabId != 0){
				propSelectedTabId = 0;
			}
			propertyTabs.tabs('disable', 1);
			propertyTabs.tabs('disable', 2);
		} else {
			propertyTabs.tabs('enable', 1);
			propertyTabs.tabs('enable', 2);
		}
		propertyTabs.tabs('option', 'active', propSelectedTabId);
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("GroupManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{		
		this.m_utility.initFormData(this.m_dataStructure, "GroupManager");
		var propertyTabs = $("#GroupManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
		propertyTabs.tabs('disable', 1);	 
		propertyTabs.tabs('disable', 2);
		
		document.getElementById("GroupManager_domainId").value = document.getElementById("GroupManager_Master_domainId").value;
		document.getElementById("GroupManager_parentId").value = document.getElementById("GroupManager_Master_parentId").value; 
		document.getElementById("GroupManager_shortPath").readOnly = false;
		document.getElementById("GroupManager_EditFormPanel").style.display = '';
	},

	doUpdate : function (forDetail) {
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("GroupManager_isCreate").value;
		var form = document.getElementById("GroupManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";
		param += "gradeId=" + document.getElementById("GroupManager_gradeId").value;
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/group/addForAjax.admin", param, false, {
				success: function(data){
					aGroupManager.onRefresh( document.getElementById("GroupManager_parentId").value );
					
					aGroupManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/group/updateForAjax.admin", param, false, {
				success: function(data){
					aGroupManager.onRefresh( document.getElementById("GroupManager_parentId").value );
					
					aGroupManager.doRetrieve();
					
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("GroupManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var principalId = null;
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += document.getElementById('GroupManager[' + rowCntArray[i] + '].principalId').value;
				principalId = document.getElementById('GroupManager[' + rowCntArray[i] + '].principalId').value;
	        }
			var parentId = aGroupManager.m_tree.getParentId(principalId);
			
			this.m_ajax.send("POST", this.m_contextPath + "/group/removeForAjax.admin", param, false, {
				success: function(data){
					aGroupManager.onRefresh( parentId );
					
					aGroupManager.initSearch();
					aGroupManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
		}
	}
}

var aGroupMenu = null;
GroupMenu = function(contextPath)
{
	if( portalPage == null) portalPage = new enview.portal.Page();
	
	/*this.m_domElement = document.createElement('div');
	this.m_domElement.id = "GroupManager_GroupMenu";
	this.m_domElement.title = "Group Menu";
	var htmlStr = "";
	htmlStr += "<a onclick='aGroupManager.onRefresh()' style='border:none; cursor:hand;'><img src='" + contextPath + "/admin/images/Service.gif'>" + portalPage.getMessageResource('ev.info.menu.refresh') + "</a>";
	htmlStr += "<hr>";
	htmlStr += "<a onclick='aGroupManager.onCreate()' style='border:none; cursor:hand;'><img src='" + contextPath + "/admin/images/ic_make_page.gif'>" + portalPage.getMessageResource('ev.info.menu.addGroup') + "</a>";
	htmlStr += "<hr>";
	htmlStr += "<a onclick='aGroupManager.onMoveUp()' style='border:none; cursor:hand;'><img src='" + contextPath + "/admin/images/ic_up.gif'>" + portalPage.getMessageResource('ev.info.menu.moveUp') + "</a><br>";
	htmlStr += "<a onclick='aGroupManager.onMoveDown()' style='border:none; cursor:hand;'><img src='" + contextPath + "/admin/images/ic_down.gif'>" + portalPage.getMessageResource('ev.info.menu.moveDown') + "</a>";
	htmlStr += "<hr>";
	htmlStr += "<a onclick='aGroupManager.onDelete()' style='border:none; cursor:hand;'><img src='" + contextPath + "/admin/images/ic_del_b.gif'>" + portalPage.getMessageResource('ev.info.menu.delete') + "</a>";
	this.m_domElement.innerHTML = htmlStr;
	//alert(htmlStr);
	document.body.appendChild( this.m_domElement );*/
		
	$("#GroupManager_GroupMenu").dialog({
		autoOpen: false,
		width: "140px",
		resizable: false,
		draggable: false,
		modal: true,
		open: function(event, ui) { 
			//$(".ui-dialog-titlebar-close").hide(); 
			//$("#GroupManager_GroupMenu").attr("style", "left:" + left);
			//$("#GroupManager_GroupMenu").attr("style", "top:" + top);
		}
	});
	
	this.init();
}

GroupMenu.prototype =
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
		
		$('#GroupManager_GroupMenu').dialog( "option", "position", [left,top] );
		$('#GroupManager_GroupMenu').dialog('open');
	},
	hide : function()
	{
		$('#GroupManager_GroupMenu').dialog('close');
	}
}

var aGroupChooser = null;
GroupChooser = function(evSecurityCode, domainId, multiSelect)
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	if( portalPage == null) portalPage = new enview.portal.Page();
	this.m_selectRowIndex = 0;
	this.m_evSecurityCode = evSecurityCode;
	this.m_domainId = domainId;
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = portalPage.getContextPath();
	this.m_domElement = document.getElementById("GroupManager_GroupChooser");
	this.m_multiSelect = multiSelect;
	
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
	
	$("#GroupManager_GroupChooser").dialog({
		autoOpen: false,
		resizable: true,
		width:300, 
		//height:400,
		modal: true,
		buttons: {
			"Apply": function() {
				aGroupChooser.doApply();
			},
			Cancel: function() {
				$(this).dialog('close');
			}
		}
	});
	
	this.init();
}

GroupChooser.prototype =
{
	m_domElement : null,
	m_tree : null,
	m_checkBox : null,
	m_sourceElement : null,
	m_callback : null,
	m_evSecurityCode : null,
	m_domainId : '',
	m_multiSelect : true,
	
	init : function() {
		this.m_tree = new dhtmlXTreeObject(document.getElementById('GroupChooser_TreeTabPage'),"100%","100%",0);
		this.m_tree.setImagePath(this.m_contextPath + "/dhtmlx/imgs/dhxtree_skyblue/");
		//this.m_tree.setOnClickHandler( this.onNodeSelect );
		this.m_tree.enableAutoTooltips(true);
		this.m_tree.enableCheckBoxes(true);
		this.m_tree.setXMLAutoLoading(this.m_contextPath + "/group/retrieveTreeForAjax.admin?evSecurityCode=" + this.m_evSecurityCode + "&domainId=" + this.m_domainId);
		this.m_tree.load(this.m_contextPath + "/group/retrieveTreeForAjax.admin?id=100&evSecurityCode=" + this.m_evSecurityCode + "&domainId=" + this.m_domainId);
	},
	
	doShow : function (callback) {
		this.m_callback = callback;
		$('#GroupManager_GroupChooser').dialog('open');
	},
	
	onNodeSelect : function (id) {
		aGroupChooser.m_tree.setCheck(id, true);	
	},
	doApply : function(id) {
		var checkIds = this.m_tree.getAllChecked();
		if( checkIds != null && checkIds.length > 0 ) {
			var checkArray = checkIds.split(",");
			var result = new Array(checkArray.length);
			
			if (this.m_multiSelect == false && checkArray.length > 1) {
				alert('그룹을 한 개 이상 선택할 수 없습니다.');
				return;
			}
			
			for(var i=0; i<checkArray.length; i++) {
				var rowMap = new Map();
				
				//var userData = this.m_tree.getItem(checkArray[i]).getAttribute("userData");
				var userData = this.m_tree.getUserData(checkArray[i], "path");
				rowMap.put("principalId", checkArray[i]);	
				rowMap.put("groupId", userData);	
				rowMap.put("title", this.m_tree.getItemText(checkArray[i]));
				
				result[i] = rowMap;
			}
			$('#GroupManager_GroupChooser').dialog('close');
			this.m_callback(result);
		} else {
			$('#GroupManager_GroupChooser').dialog('close');
			this.m_callback(null);
		}
	}
	
	
}

