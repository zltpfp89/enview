
var aPortletCategoryManager = null;
PortletCategoryManager = function(evSecurityCode)
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
PortletCategoryManager.prototype =
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
	
	init : function() { 
		this.m_dataStructure = [
			{"fieldName":"path", "validation":"Required,MaxLength", "maxLength":"240"}
			,{"fieldName":"categoryId", "validation":""}
			,{"fieldName":"parentId", "validation":""}
			,{"fieldName":"name", "validation":"Required,MaxLength", "maxLength":"100"}
			,{"fieldName":"title", "validation":"Required,MaxLength", "maxLength":"30"}
			,{"fieldName":"isHidden", "validation":""}
			,{"fieldName":"sortOrder", "validation":""}
			
		]

		this.m_contextMenu = new CategoryMenu(this.m_contextPath);
		
		this.m_tree = new dhtmlXTreeObject(document.getElementById('PortletCategoryManager_TreeTabPage'),"100%","100%",0);
		this.m_tree.setImagePath(this.m_contextPath + "/dhtmlx/imgs/dhxtree_skyblue/");
		this.m_tree.setOnClickHandler( this.onNodeSelect );
		this.m_tree.enableDragAndDrop(true)
		this.m_tree.setDragHandler( this.onDragAndDrop );
		this.m_tree.setOnRightClickHandler( this.onContextMenuHandler );
		this.m_tree.enableAutoTooltips(true);
		//this.m_tree.setChildCalcMode(true);
		//this.m_tree.enableItemEditor(true);
		//this.m_tree.enableKeyboardNavigation(true);
		this.m_tree.setXMLAutoLoading(this.m_contextPath + "/portletCategory/retrieveTreeForAjax.admin?evSecurityCode=" + this.m_evSecurityCode);
		this.m_tree.load(this.m_contextPath + "/portletCategory/retrieveTreeForAjax.admin?id=1&evSecurityCode=" + this.m_evSecurityCode);
		
		$(function() {
			$("#PortletCategoryManager_propertyTabs").tabs();
		});
		
		$.datepicker.setDefaults({
			showMonthAfterYear: true,
			changeMonth: true,
			changeYear: true,
			showButtonPanel: true,
			showAnim : 'slideDown',
			dateFormat : 'yy-mm-dd'
		});
		
		
		
		document.onkeyup = aPortletCategoryManager.onCheckKey;
	},
	getContextMenu : function()
	{
		return this.m_contextMenu;
	},
	onContextMenuHandler : function (treeitemId, item) {
		aPortletCategoryManager.doShowContextMenu( treeitemId, item );
	},
	onSelect : function (treeitemId) {
		aPortletCategoryManager.doSelect( treeitemId );
	},
	onRefresh : function (id) {
		var treeitemId = (id) ? id : aPortletCategoryManager.getContextMenu().getItemId();
		aPortletCategoryManager.getContextMenu().hide();
		if( treeitemId == 1 ) aPortletCategoryManager.m_tree.deleteChildItems( 0 );
		aPortletCategoryManager.m_tree.refreshItem( treeitemId );
	},
	onCheckKey : function (a_event) {
		if( document.all ) {
			if( event.keyCode ) {
				if( event.ctrlKey == true && event.keyCode == 90 ) {
					aPortletCategoryManager.toggleMaximize();
				}
				else if( event.ctrlKey == true && event.keyCode == 38 ) {
					aPortletCategoryManager.doMoveUpNodeTree( aPortletCategoryManager.m_tree.getSelectedItemId() );
				}
				else if( event.ctrlKey == true && event.keyCode == 40 ) {
					aPortletCategoryManager.doMoveDownNodeTree( aPortletCategoryManager.m_tree.getSelectedItemId() );
				}
			}
		}
		else {
			if( a_event.ctrlKey == true && a_event.keyCode == 90 ) {
				aPortletCategoryManager.toggleMaximize();
			}
			else if( a_event.ctrlKey == true && a_event.keyCode == 38 ) {
				aPortletCategoryManager.doMoveUpNodeTree( aPortletCategoryManager.m_tree.getSelectedItemId() );
			}
			else if( a_event.ctrlKey == true && a_event.keyCode == 40 ) {
				aPortletCategoryManager.doMoveDownNodeTree( aPortletCategoryManager.m_tree.getSelectedItemId() );
			}
		}
	},
	onCreate : function () {
		var treeitemId = aPortletCategoryManager.getContextMenu().getItemId();
		aPortletCategoryManager.getContextMenu().hide();
		aPortletCategoryManager.doCreate( treeitemId );
	},
	onDelete : function () {
		var treeitemId = aPortletCategoryManager.getContextMenu().getItemId();
		aPortletCategoryManager.getContextMenu().hide();
		
		if( treeitemId == 1 ) {
			alert( portalPage.getMessageResourceByParam('ev.info.forbiden.updateRoot') );
			return;
		}
		
		return aPortletCategoryManager.doDeleteTree(treeitemId);
	},
	onDragAndDrop : function (subKey, item_id, parent_id, before, item, parent) {
		if( item_id == 1 ) {
			alert( portalPage.getMessageResourceByParam('ev.info.forbiden.updateRoot') );
			return;
		}
		
		if( subKey == 0 ) {	// move
			var msg = portalPage.getMessageResourceByParam('ev.info.tree.node.move', aPortletCategoryManager.m_tree.getItemText(item_id), aPortletCategoryManager.m_tree.getItemText(parent_id));
			var ret = confirm( msg );
			if( ret == true ) {
				aPortletCategoryManager.doMoveParentTree(item_id, parent_id);
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
		var treeitemId = aPortletCategoryManager.getContextMenu().getItemId();
		aPortletCategoryManager.getContextMenu().hide();
		if( treeitemId == 1 ) {
			alert( portalPage.getMessageResourceByParam('ev.info.forbiden.updateRoot') );
			return;
		}
		aPortletCategoryManager.doMoveUpNodeTree( treeitemId );
	},
	onMoveDown : function () {
		var treeitemId = aPortletCategoryManager.getContextMenu().getItemId();
		aPortletCategoryManager.getContextMenu().hide();
		if( treeitemId == 1 ) {
			alert( portalPage.getMessageResourceByParam('ev.info.forbiden.updateRoot') );
			return;
		}
		aPortletCategoryManager.doMoveDownNodeTree( treeitemId );
	},
	onNodeSelect : function (id) {
		aPortletCategoryManager.m_contextMenu.hide();
		aPortletCategoryManager.doSelectTree(id);
	},
	toggleMaximize : function () {
		var left = document.getElementById("PortletCategoryManager_Left");
		var title = document.getElementById("PortletCategoryManager_Left_Title");
		var right = document.getElementById("PortletCategoryManager_Right");
		if( this.m_maximize == false ) {
			aPortletCategoryManager.m_oldTabWidth = right.clientWidth;
			aPortletCategoryManager.m_oldTabHeight = right.clientHeight;
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
		var pos = (new enview.util.Utility()).getAbsolutePosition( item );
		this.onNodeSelect( id );
		
		this.m_contextMenu.setItemId( id );
		this.m_contextMenu.show( pos.getX()+45, pos.getY()+20 );
	},
	onSelectPropertyTab : function (id) {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		switch(id) {
			case 0 : 
				break;
	 
			case 1 :
		
				param += "categoryId=" + document.getElementById("PortletCategoryManager_categoryId").value;
				if( aCategoryMetadataManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/portletCategory/categoryMetadata/list.admin", param, false, {
						success: function(data){
							document.getElementById("PortletCategoryManager_CategoryMetadataTabPage").innerHTML = data;
							aCategoryMetadataManager = new CategoryMetadataManager( aPortletCategoryManager.m_evSecurityCode );
							aCategoryMetadataManager.init();
							
							document.getElementById("CategoryMetadataManager_Master_categoryId").value = document.getElementById("PortletCategoryManager_categoryId").value; 
							aCategoryMetadataManager.doRetrieve();
						}});
				}
				else {
					
					document.getElementById("CategoryMetadataManager_Master_categoryId").value = document.getElementById("PortletCategoryManager_categoryId").value; 
					aCategoryMetadataManager.initSearch();
					aCategoryMetadataManager.doRetrieve();
				}
			
				break;
	 
			case 2 :
		
				param += "categoryId=" + document.getElementById("PortletCategoryManager_categoryId").value;
				if( aPortletDefinitionManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/portletCategory/portletDefinition/list.admin", param, false, {
						success: function(data){
							document.getElementById("PortletCategoryManager_PortletDefinitionTabPage").innerHTML = data;
							aPortletDefinitionManager = new PortletDefinitionManager( aPortletCategoryManager.m_evSecurityCode );
							aPortletDefinitionManager.init();
							
							document.getElementById("PortletDefinitionManager_Master_categoryId").value = document.getElementById("PortletCategoryManager_categoryId").value; 
							aPortletDefinitionManager.doRetrieve();
						}});
				}
				else {
					
					document.getElementById("PortletDefinitionManager_Master_categoryId").value = document.getElementById("PortletCategoryManager_categoryId").value; 
					aPortletDefinitionManager.initSearch();
					aPortletDefinitionManager.doRetrieve();
				}
			
				break;
		
		}
		
		return true; 
	},
	doSelectTree : function (id) {
		
		document.getElementById("PortletCategoryManager_parentId").value = id;
		document.getElementById("PortletDefinitionManager_Master_categoryId").value = id;
		aPortletDefinitionManager.initSearch();
		aPortletDefinitionManager.doRetrieve(); 
		
		this.doSelect( id );
	},
	doMoveParentTree : function ( item_id, parent_id ) {
		aPortletCategoryManager.m_contextMenu.hide();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&id=" + item_id + "&parentId=" + parent_id;
		
		this.m_ajax.send("POST", this.m_contextPath + "/portletCategory/changeParentForAjax.admin", param, false, {
			success: function(data){
				if( aPortletCategoryManager.m_tree.getOpenState(parent_id)==1 || aPortletCategoryManager.m_tree.hasChildren(parent_id)==0) {
					aPortletCategoryManager.m_tree.moveItem(item_id, "item_child", parent_id);
					aPortletCategoryManager.m_tree.openItem( item_id );
				}
				else {
					aPortletCategoryManager.m_tree.deleteItem(item_id, aPortletCategoryManager.m_tree.getParentId(item_id));
					aPortletCategoryManager.m_tree.refreshItem( parent_id );
					aPortletCategoryManager.onNodeSelect( item_id );
				}
			}});
	},
	doMoveUpNodeTree : function ( item_id ) {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&id=" + item_id + "&toDown=false";
		this.m_ajax.send("POST", this.m_contextPath + "/portletCategory/changeOrderForAjax.admin", param, false, { success: function(data){ aPortletCategoryManager.m_tree.moveItem(item_id, "up_strict"); }});
	},
	doMoveDownNodeTree : function ( item_id ) {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&id=" + item_id + "&toDown=true";
		this.m_ajax.send("POST", this.m_contextPath + "/portletCategory/changeOrderForAjax.admin", param, false, { success: function(data){ aPortletCategoryManager.m_tree.moveItem(item_id, "down_strict"); }});
	},
	doDeleteTree : function ()
	{
		var item_id = this.m_tree.getSelectedItemId();
		if( item_id == 0 ) {
			alert( portalPage.getMessageResourceByParam('ev.error.tree.node.system.delete') );
			return;
		}
		//alert("id=" + id);
		var msg = portalPage.getMessageResourceByParam('ev.info.tree.node.remove', aPortletCategoryManager.m_tree.getItemText(item_id));
		var ret = confirm( msg );
		if( ret == false ) {
			return false;
		}
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&pks=" + item_id + "&";
		
		this.m_ajax.send("POST", this.m_contextPath + "/portletCategory/removeForAjax.admin", param, false, {
			success: function(data){
				aPortletCategoryManager.m_contextMenu.hide();
				aPortletCategoryManager.onRefresh( aPortletCategoryManager.m_tree.getParentId(item_id) );
				enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
			}});
	},
	doSelect : function (id)
	{
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "categoryId=" + id;
			
		this.m_ajax.send("POST", this.m_contextPath + "/portletCategory/detailForAjax.admin", param, false, {success: function(data) { aPortletCategoryManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "PortletCategoryManager", resultObject);
		
		document.getElementById("PortletDefinitionManager_categoryId").value = document.getElementById("PortletDefinitionManager_Master_categoryId").value; 
	
		document.getElementById("PortletCategoryManager_categoryId").readOnly = true;
		
		var propertyTabs = $("#PortletCategoryManager_propertyTabs").tabs();
	 
		propertyTabs.tabs('enable', 1);	 
		propertyTabs.tabs('enable', 2);	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
	},
	doCreate : function(treeitemId) 
	{
		this.m_utility.initFormData(this.m_dataStructure, "PortletCategoryManager");
		
		document.getElementById("PortletCategoryManager_categoryId").value = treeitemId; 
		document.getElementById("PortletCategoryManager_path").value = this.m_tree.getItem(treeitemId).getAttribute("userData");
		
		var propertyTabs = $("#PortletCategoryManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	 
		propertyTabs.tabs('disable', 1);	 
		propertyTabs.tabs('disable', 2);	 
		document.getElementById("PortletCategoryManager_parentId").value = document.getElementById("PortletCategoryManager_categoryId").value; 
		document.getElementById("PortletCategoryManager_categoryId").readOnly = true;
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var param = "";
		var isCreate = document.getElementById("PortletCategoryManager_isCreate").value;
		var form = document.getElementById("PortletCategoryManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/portletCategory/addForAjax.admin", param, false, {
				success: function(data){
					aPortletCategoryManager.onRefresh( document.getElementById("PortletCategoryManager_parentId").value );
					aPortletCategoryManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/portletCategory/updateForAjax.admin", param, false, {
				success: function(data){
					aPortletCategoryManager.onRefresh( document.getElementById("PortletCategoryManager_parentId").value );
					aPortletCategoryManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PortletCategoryManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('PortletCategoryManager[' + rowCntArray[i] + '].categoryId').value;
	        }
			var parentId = aPortletCategoryManager.m_tree.getParentId(document.getElementById('PortletCategory[' + rowCntArray[0] + '].categoryId').value);
			
			this.m_ajax.send("POST", this.m_contextPath + "/portletCategory/removeForAjax.admin", param, false, {
				success: function(data){
					aPortletCategoryManager.onRefresh( parentId );
					
					aPortletCategoryManager.m_selectRowIndex = 0;
					aPortletCategoryManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
		}
	}
	
}

CategoryMenu = function(contextPath)
{
	if( portalPage == null) portalPage = new enview.portal.Page();
	
	this.m_domElement = document.createElement('div');
	this.m_domElement.id = "PortletCategoryManager_CategoryMenu";
	this.m_domElement.title = "Category Menu";
	var htmlStr = "";
	htmlStr += "<a onclick='aPortletCategoryManager.onRefresh()' style='border:none; cursor:hand;'><img src='" + contextPath + "/admin/images/Service.gif'>" + portalPage.getMessageResource('ev.info.menu.refresh') + "</a>";
	htmlStr += "<hr>";
	htmlStr += "<a onclick='aPortletCategoryManager.onCreate()' style='border:none; cursor:hand;'><img src='" + contextPath + "/admin/images/ic_make_page.gif'>" + portalPage.getMessageResource('ev.info.menu.addCategory') + "</a>";
	htmlStr += "<hr>";
	htmlStr += "<a onclick='aPortletCategoryManager.onMoveUp()' style='border:none; cursor:hand;'><img src='" + contextPath + "/admin/images/ic_up.gif'>" + portalPage.getMessageResource('ev.info.menu.moveUp') + "</a><br>";
	htmlStr += "<a onclick='aPortletCategoryManager.onMoveDown()' style='border:none; cursor:hand;'><img src='" + contextPath + "/admin/images/ic_down.gif'>" + portalPage.getMessageResource('ev.info.menu.moveDown') + "</a>";
	htmlStr += "<hr>";
	htmlStr += "<a onclick='aPortletCategoryManager.onDelete()' style='border:none; cursor:hand;'><img src='" + contextPath + "/admin/images/ic_del_b.gif'>" + portalPage.getMessageResource('ev.info.menu.delete') + "</a>";
	this.m_domElement.innerHTML = htmlStr;

	document.body.appendChild( this.m_domElement );
		
	$("#PortletCategoryManager_CategoryMenu").dialog({
		autoOpen: false,
		width: "140px",
		resizable: false,
		modal: true,
		open: function(event, ui) { 
			$(".ui-dialog-titlebar-close").hide(); 
			//$("#PageManager_PageMenu").attr("style", "left:" + left);
			//$("#PageManager_PageMenu").attr("style", "top:" + top);
		}
	});
	
	this.init();
}

CategoryMenu.prototype =
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
		
		$('#PortletCategoryManager_CategoryMenu').dialog( "option", "position", [left,top] );
		$('#PortletCategoryManager_CategoryMenu').dialog('open');
	},
	hide : function()
	{
		$('#PortletCategoryManager_CategoryMenu').dialog('close');
	}
}
