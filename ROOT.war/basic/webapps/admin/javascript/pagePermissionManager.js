
var aPagePermissionManager = null;
PagePermissionManager = function(evSecurityCode)
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
PagePermissionManager.prototype =
{
	m_ajax : null,
	m_checkBox : null,
	m_validator : null,
	m_utility : null,
	m_contextPath : null,
	m_selectRowIndex : 0,
	m_dataStructure : null,
	m_evSecurityCode : null,
	
	init : function() { 
		
		this.m_dataStructure = [
			{"fieldName":"permissionId", "validation":""}
			,{"fieldName":"principalId", "validation":""}
			,{"fieldName":"title", "validation":""}
			,{"fieldName":"resUrl", "validation":"Required,MaxLength", "maxLength":"250"}
			,{"fieldName":"resType", "validation":""}
			,{"fieldName":"actionMask", "validation":""}
			,{"fieldName":"isAllow", "validation":""}
			,{"fieldName":"creationDate", "validation":""}
			,{"fieldName":"modifiedDate", "validation":""}
			,{"fieldName":"domainId", "validation":""}
			
		]
		
		$(function() {
			$("#PagePermissionManager_propertyTabs").tabs();
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
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		if( aPageChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/page/listForChooser.admin", param, false, {
				success: function(data){
					document.getElementById("PageManager_PageChooser").innerHTML = data;
					aPageChooser = new PageChooser( aPagePermissionManager.m_evSecurityCode );
				}});
		}
		return aPageChooser;
	},
	setPageChooserCallback : function (rowArray) {
		
		if( document.getElementById("PagePermissionManager_resType").value == 0 ) {
			document.getElementById("PagePermissionManager_resUrl").value = rowArray[0].get("pagePath");
		}
		else {
			document.getElementById("PagePermissionManager_resUrl").value = rowArray[0].get("pagePath") + "/*";
		}
		
		document.getElementById("PagePermissionManager_title").value = rowArray[0].get("title");
	},
	getPageMultiChooser : function () {
		var domainId = $('#PagePermissionManager_Master_domainId').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId + "&showPublic=Y";
		var extraParam = "&showPublic=Y";
//		if( aPageMultiChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/page/listForChooser.admin", param, false, {
				success: function(data){
					document.getElementById("PageManager_PageMultiChooser").innerHTML = data;
					aPageMultiChooser = new PageMultiChooser( aPagePermissionManager.m_evSecurityCode , domainId, extraParam );
				}});
//		}
		return aPageMultiChooser;
	},
	setPageMultiChooserCallback : function (isPattern, rowArray) {
		if( isPattern == true ) {
			var param = "evSecurityCode=" + this.m_evSecurityCode;
			param += "&isPage=true";
			param += "&principalId=" + document.getElementById("SecurityPermission_principalId").value;
			param += "&pagePath=" + rowArray[0].get("pagePath");
			param += "&actionMask=" + rowArray[0].get("actionMask");
			param += "&isAllow=" + rowArray[0].get("isAllow");
			param += "&domainId=" + document.getElementById("PagePermissionManager_Master_domainId").value;
			param += "&principalType=" + document.getElementById("PagePermissionManager_Master_principalType").value;
			this.m_ajax.send("POST", this.m_contextPath + "/pagePermission/addByPatternForAjax.admin", param, false, { 
				success: function(data){
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
					aPagePermissionManager.doRetrieve();
				}});
		}
		else {
			var param = "evSecurityCode=" + this.m_evSecurityCode;
			param += "&principalId=" + document.getElementById("SecurityPermission_principalId").value;
			param += "&isPage=true";
			param += "&principalType=" + document.getElementById("PagePermissionManager_Master_principalType").value;
			param += "&domainId=" + document.getElementById("PagePermissionManager_Master_domainId").value;
			param += "&principalType=" + document.getElementById("PagePermissionManager_Master_principalType").value;
			for(var i=0; i<rowArray.length; i++) {
				param += "&updateDatas=";
				param += document.getElementById("SecurityPermission_principalId").value + "@" +
						 rowArray[i].get("shortTitle") + "@" +
						 rowArray[i].get("pagePath") + "@" +
						 "0@" +
						 rowArray[i].get("actionMask") + "@" +
						 rowArray[i].get("isAllow");

			}
			//alert("param=" + param);
			
			this.m_ajax.send("POST", this.m_contextPath + "/pagePermission/addsForAjax.admin", param, false, { 
				success: function(data){
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
					aPagePermissionManager.doRetrieve();
				}});
		}
	},
	/*
	getMultipagePageChooser : function () {
		if( aMultiplePageChooser == null ) {
			aMultiplePageChooser = new MultiplePageChooser( aPagePermissionManager.m_evSecurityCode );
		}
		return aMultiplePageChooser;
	},
	setMultipagePageChooserCallback : function (rowArray) {
		//document.getElementById("PageManager_defaultPageName").value = rowArray[0].get("pageId");
		//document.getElementById("UserManager_defaultPage").value = rowArray[0].get("pagePath");
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		for(var i=0; i<rowArray.length; i++) {
			param += "&updateDatas=";
			param += document.getElementById("SecurityPermission_principalId").value + ":" +
				     encodeURIComponent(rowArray[i].get("title")) + ":" +
				     rowArray[i].get("pagePath") + ":" +
				     rowArray[i].get("resType") + ":" +
				     rowArray[i].get("actionMask") + ":" +
				     rowArray[i].get("isAllow");

		}
		//alert("param=" + param);
		
		this.m_ajax.send("POST", this.m_contextPath + "/pagePermission/addForAjax.admin", param, false, {
				success: function(data){
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
					aPagePermissionManager.doRetrieve();
				}});
		
	},
	*/
	onSelectPropertyTab : function (id) {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		return true; 
	},
	initSearch : function () {
		var formElem = document.forms[ "PagePermissionManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function (managerName, rootId) {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "PagePermissionManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/pagePermission/listForAjax.admin", param, false, {success: function(data) { aPagePermissionManager.doRetrieveHandler(data, managerName, rootId); }});
	},
	doRetrieveHandler : function( resultObject, managerName, rootId ) {
		
		this.m_utility.setListData(
			"PagePermissionManager",
			new Array('permissionId'),
			new Array('permissionId', 'principalId', 'title', 'resUrl'),
			this.m_contextPath,
			resultObject);
				
		if(resultObject.Data.length != 0) {
			this.doDefaultSelect(); 
		}
//		
//		if(managerName){
//			if($('#isAdmin').val() == 'true' || $('#' + managerName + '_Master_domainId').val() != 0){
//				 if($('#' + managerName + '_principalId').val() != rootId) $('.PagePermissionManager_EditFormButtons').css('display', 'inline-block');
//				 else $('.PagePermissionManager_EditFormButtons').css('display', 'none');
//			}else {
//				$('.PagePermissionManager_EditFormButtons').css('display', 'none');
//			}
//		}
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
		var formElem = document.forms[ "PagePermissionManager_SearchForm" ];
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
		document.getElementById('PagePermissionManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "permissionId=";
		param += document.getElementById('PagePermissionManager[' + this.m_selectRowIndex + '].permissionId').value;
		param += "&domainId=" + document.getElementById("PagePermissionManager_Master_domainId").value;
		this.m_ajax.send("POST", this.m_contextPath + "/pagePermission/detailForAjax.admin", param, false, {success: function(data) { aPagePermissionManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("PagePermissionManager_ListForm") );
	    document.getElementById('PagePermissionManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "permissionId=";
		param += document.getElementById('PagePermissionManager[' + rowSeq + '].permissionId').value;
		param += "&domainId=" + document.getElementById("PagePermissionManager_Master_domainId").value;
		this.m_ajax.send("POST", this.m_contextPath + "/pagePermission/detailForAjax.admin", param, false, {success: function(data) { aPagePermissionManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		//this.m_utility.setFormDataFromXML(this.m_dataStructure, "PagePermissionManager", resultObject);
		document.getElementById("PagePermissionManager_permissionId").value = portalPage.getAjax().retrieveElementValue("permissionId", resultObject);
		document.getElementById("PagePermissionManager_principalId").value = portalPage.getAjax().retrieveElementValue("principalId", resultObject);
		document.getElementById("PagePermissionManager_title").value = portalPage.getAjax().retrieveElementValue("title", resultObject);
		document.getElementById("PagePermissionManager_resType").value = portalPage.getAjax().retrieveElementValue("resType", resultObject);
		document.getElementById("PagePermissionManager_isAllow").checked = (portalPage.getAjax().retrieveElementValue("isAllow", resultObject) == "true") ? true : false;
		document.getElementById("PagePermissionManager_resUrl").value = portalPage.getAjax().retrieveElementValue("resUrl", resultObject);
		document.getElementById("PagePermissionManager_creationDate").value = portalPage.getAjax().retrieveElementValue("creationDate", resultObject);
		document.getElementById("PagePermissionManager_modifiedDate").value = portalPage.getAjax().retrieveElementValue("modifiedDate", resultObject);
		
		var actionMask = portalPage.getAjax().retrieveElementValue("actionMask", resultObject);
		var form = document.getElementById("PagePermissionManager_EditForm");
		for(var j=0; j<form.elements.length; j++) {
			field = form.elements[j];
			//alert(field.type + "," + field.id + "," + field.checked);
			if(field.type == "checkbox" && field.id && field.id.indexOf("PagePermissionManager_authority_") > -1 ) {
				var authValue = field.id.substring(32);
				if( (actionMask & authValue) == authValue ) {
					field.checked = true;
				}
				else {
					field.checked = false;
				}
			}
		}
	
		document.getElementById("PagePermissionManager_creationDate").readOnly = true;
		document.getElementById("PagePermissionManager_modifiedDate").readOnly = true;
		
		
		var propertyTabs = $("#PagePermissionManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("PagePermissionManager_isCreate").value = "false";
		document.getElementById("PagePermissionManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "PagePermissionManager");
		document.getElementById("PagePermissionManager_resType").value = 0;
		
		var form = document.getElementById("PagePermissionManager_EditForm");
		for(var j=0; j<form.elements.length; j++) {
			field = form.elements[j];
			if(field.type == "checkbox" && field.id && field.id.indexOf("PagePermissionManager_authority_") > -1 ) {
				field.checked = false;
			}
		}
		
		var propertyTabs = $("#PagePermissionManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);

		document.getElementById("PagePermissionManager_principalId").value = document.getElementById("PagePermissionManager_Master_principalId").value;
		document.getElementById("PagePermissionManager_domainId").value = document.getElementById("PagePermissionManager_Master_domainId").value
		document.getElementById("PagePermissionManager_permissionId").readOnly = false;
		document.getElementById("PagePermissionManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("PagePermissionManager_isCreate").value;
		var form = document.getElementById("PagePermissionManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		//var param = this.m_utility.getFormData(this.m_dataStructure, form);
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&permissionId=" + document.getElementById("PagePermissionManager_permissionId").value;
		param += "&principalId=" + document.getElementById("PagePermissionManager_principalId").value;
		param += "&domainId=" + document.getElementById("PagePermissionManager_Master_domainId").value;
		param += "&principalType=" + document.getElementById("PagePermissionManager_Master_principalType").value;
		var title = document.getElementById("PagePermissionManager_title").value;
		if( title == null || title.length == 0 ) {
			alert( portalPage.getMessageResource('ev.error.selectPage') );
			return;
		}
			
		param += "&title=" + encodeURIComponent(title);
		param += "&resType=" + document.getElementById("PagePermissionManager_resType").value;
		param += "&isAllow=" + ((document.getElementById("PagePermissionManager_isAllow").checked == true) ? "true" : "false");
		param += "&resUrl=" + document.getElementById("PagePermissionManager_resUrl").value;
		param += "&creationDate=" + document.getElementById("PagePermissionManager_creationDate").value;
		param += "&modifiedDate=" + document.getElementById("PagePermissionManager_modifiedDate").value;
		
		var actionMask = 15; // view authority
		var form = document.getElementById("PagePermissionManager_EditForm");
		for(var j=0; j<form.elements.length; j++) {
			field = form.elements[j];
			//alert(field.type + "," + field.id + "," + field.checked);
			if(field.type == "checkbox" && field.id && field.id.indexOf("PagePermissionManager_authority_") > -1 ) {
				if( field.checked == true ) {
					actionMask |= field.value;
				}
			}
		}
		param += "&actionMask=" + actionMask;
		//alert("isCreate=" + isCreate);
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/pagePermission/addForAjax.admin", param, false, {
				success: function(data){
					aPagePermissionManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/pagePermission/updateForAjax.admin", param, false, {
				success: function(data){
					aPagePermissionManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PagePermissionManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
			param += "&principalId=" + document.getElementById("SecurityPermission_principalId").value;
			param += "&domainId=" + document.getElementById("PagePermissionManager_Master_domainId").value;
			param += "&principalType=" + document.getElementById("PagePermissionManager_Master_principalType").value;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('PagePermissionManager[' + rowCntArray[i] + '].permissionId').value + ":" +
					document.getElementById("PagePermissionManager_Master_domainId").value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/pagePermission/removeForAjax.admin", param, false, {
				success: function(data){
					aPagePermissionManager.initSearch();
					aPagePermissionManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	},
	toggleAllPermission : function () {
		
		var isChecked = (document.getElementById("PagePermissionManager_actionMask_check").checked == true) ? true : false;
		var form = document.getElementById("PagePermissionManager_EditForm");
		for(var j=0; j<form.elements.length; j++) {
			field = form.elements[j];
			//alert(field.type + "," + field.id + "," + field.checked);
			if(field.type == "checkbox" && field.id && field.id.indexOf("PagePermissionManager_authority_") > -1 ) {
				if( isChecked == true ) { field.checked = true; }
				else { field.checked = false; }
			}
		}
	}
	
}
/*
var aPagePermissionChooser = null;
PagePermissionChooser = function(callback, parent)
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	if( portalPage == null) portalPage = new enview.portal.Page();
	this.m_selectRowIndex = 0;
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = portalPage.getContextPath();
	this.m_domElement = document.getElementById("PagePermissionManager_PagePermissionChooser");
	this.m_callback = callback;
	this.m_parent = parent;
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
	
	$("#PagePermissionManager_PagePermissionChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:540, 
		height:400,
		modal: true,
		buttons: {
			"Apply": function() {
				aPagePermissionChooser.doApply();
			},
			Cancel: function() {
				$(this).dialog('close');
			}
		}
	});
	
	this.init();
}

PagePermissionChooser.prototype =
{
	m_domElement : null,
	m_checkBox : null,
	m_sourceElement : null,
	m_callback : null,
	m_parent : null,
	
	init : function() {
		
	},
	whenSrchFocus : function ( obj, lvS ) {
		if( obj.value == lvS ) obj.value = "";
	},
	whenSrchBlur : function ( obj, lvS ) {
		if( obj.value == "" ) obj.value = lvS;
	},
	doShow : function (source)
	{
		if( source ) {
			this.m_sourceElement = source;
		}
		
		this.doRetrieve();
		$('#PagePermissionManager_PagePermissionChooser').dialog('open');
	},
	doRetrieve : function () {
		var param = "";
		var formElem = document.forms[ "PagePermissionChooser_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/pagePermission/listForAjax.admin", param, false, {success: function(data) { aPagePermissionChooser.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		this.m_utility.setListData(
			"PagePermissionChooser",
			new Array('permissionId'),
			new Array('permissionId', 'principalId', 'title', 'resUrl'),
			this.m_contextPath,
			resultObject);
	},
	doPage : function (formName, pageNo)
	{
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = pageNo;
		
		this.doRetrieve();
	},
	doSearch : function (formName)
	{
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = 1;
		
		this.doRetrieve();
	},
	doSort : function (obj, sortColumn)
	{
		var formElem = document.forms[ "PagePermissionChooser_SearchForm" ];
	    formElem.elements[ "sortColumn" ].value = sortColumn;
	    if( obj.ch % 2 == 0 ) {
			formElem.elements[ "sortMethod" ].value = "ASC";
	        obj.ch = 1;
	    }
	    else {
	        formElem.elements[ "sortMethod" ].value = "DESC";
	        obj.ch = 0;
	    }
		
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
		
		if( this.m_parent != null ) {
			this.m_checkBox.unChkAll( document.getElementById("PagePermissionManager_ListForm") );
			document.getElementById('PagePermissionChooser[' + rowSeq + '].checkRow').checked = true;
			this.m_parent.doApply();
			return;
		}
		
		$('#PagePermissionManager_PagePermissionChooser').dialog('close');
		
		if( this.m_sourceElement != null ) {
			
			this.m_sourceElement.value = document.getElementById('PagePermissionChooser[' + rowSeq + '].permissionId').value;	
		}
		else {
			var result = new Array(1);
			var rowMap = new Map();
			
			rowMap.put("permissionId", document.getElementById('PagePermissionChooser[' + rowSeq + '].permissionId').value);	
			result[0] = rowMap;
			
			this.m_callback(result);
		}
	},
	getSelectedItems : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PagePermissionChooser_ListForm") );
		if( rowCnts == "" ) return;
		
		var rowCntArray = rowCnts.split(",");
		if( rowCntArray.length > 0 ) {
			if( rowCntArray.length > 1 ) {
				alert( portalPage.getMessageResource('ev.info.select.onlyone') );
				return;
			}
			
			var result = new Array(rowCntArray.length);
			for(var i=0; i<rowCntArray.length; i++) {
				var rowMap = new Map();
			
				rowMap.put("id", document.getElementById('PagePermissionChooser[' + rowCntArray[i] + '].id').value);	
				result[i] = rowMap;
			}
			
			return result;
		}
		
		return null;
	},
	doApply : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PagePermissionChooser_ListForm") );
		if( rowCnts == "" ) return;
		
		var rowCntArray = rowCnts.split(",");
		if( rowCntArray.length > 0 ) {
			if( rowCntArray.length > 1 ) {
				alert( portalPage.getMessageResource('ev.info.select.onlyone') );
				return;
			}
			
			$('#PagePermissionManager_PagePermissionChooser').dialog('close');
			
			if( this.m_sourceElement != null ) {
				
				this.m_sourceElement.value = document.getElementById('PagePermissionChooser[' + rowCntArray[0] + '].permissionId').value;	
			}
			else {
				var result = new Array(rowCntArray.length);
				for(var i=0; i<rowCntArray.length; i++) {
					var rowMap = new Map();
				
					rowMap.put("permissionId", document.getElementById('PagePermissionChooser[' + rowCntArray[i] + '].permissionId').value);	
					result[i] = rowMap;
				}
				
				this.m_callback(result);
			}
		}
	}
}
*/
var aMultiplePageChooser = null;
MultiplePageChooser = function(evSecurityCode)
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	if( portalPage == null) portalPage = new enview.portal.Page();
	this.m_selectRowIndex = 0;
	this.m_evSecurityCode = evSecurityCode;
	this.m_contextPath = portalPage.getContextPath();
	this.m_domElement = document.getElementById("PageManager_MultiplePageChooser");
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
	
	$("#PageManager_MultiplePageChooser").dialog({
		autoOpen: false,
		resizable: false,
		modal: true,
		width: 500,
		buttons: {
			Apply: function() {
				aMultiplePageChooser.doApply();
			},
			Cancel: function() {
				$(this).dialog('close');
			}
		}
	});
	
	this.init();
}

MultiplePageChooser.prototype =
{
	m_domElement : null,
	m_tree : null,
	m_checkBox : null,
	m_sourceElement : null,
	m_callback : null,
	m_evSecurityCode : null,
	
	m_param : '',
	m_domain: null,
	
	init : function(param) {
		if(param) this.m_param = param;
		alert(this.m_param);
		this.m_tree = new dhtmlXTreeObject(document.getElementById('MultiplePageChooser_TreeTabPage'),"100%","100%",0);
		this.m_tree.setImagePath(this.m_contextPath + "/dhtmlx/imgs/dhxtree_skyblue/");
		this.m_tree.setOnClickHandler( this.onNodeSelect );
		this.m_tree.enableAutoTooltips(true);
		this.m_tree.setXMLAutoLoading(this.m_contextPath + "/page/retrieveTreeForAjax.admin?evSecurityCode=" + this.m_evSecurityCode + this.m_param);
		this.m_tree.load(this.m_contextPath + "/page/retrieveTreeForAjax.admin?id=1&evSecurityCode=" + this.m_evSecurityCode + this.m_param);
		this.m_tree.enableCheckBoxes(true);
		//this.m_tree.clearSelection(id);
		//this.m_tree.getAllChecked();
		//this.m_tree.focusItem(id);
	},
	setParam : function(param){
		this.m_param = param;
		this.init();
	},
	setDomainId : function(domainId){
		this.domainId = domainId;
	},
	doShow : function (callback)
	{
		this.m_callback = callback;
		
		$('#PageManager_MultiplePageChooser').dialog('open');
	},
	onNodeSelect : function (id) {
		if( id != 1 ) {
			aMultiplePageChooser.doApply( id );
		}
	},
	doApply : function(id) {
		
		var checkIds = this.m_tree.getAllChecked();
		if( checkIds != null && checkIds.length > 0 ) {
			$('#PageManager_MultiplePageChooser').dialog('close');
			var checkArray = checkIds.split(",");
			
			var actionMask = 15; // view authority
			var form = document.getElementById("PageManager_MultiplePageChooser_EditForm");
			for(var j=0; j<form.elements.length; j++) {
				field = form.elements[j];
				//alert(field.type + "," + field.id + "," + field.checked);
				if(field.type == "checkbox" && field.id && field.id.indexOf("MultiplePageChooser_authority_") > -1 ) {
					if( field.checked == true ) {
						actionMask |= field.value;
					}
				}
			}
				
			var result = new Array(checkArray.length);
			for(var i=0; i< checkArray.length; i++) {
				var rowMap = new Map();
				//var userData = this.m_tree.getItem(checkArray[i]).getAttribute("userData");
				var userData = this.m_tree.getUserData(id, "path");
				rowMap.put("title", this.m_tree.getItemText(checkArray[i]));
				rowMap.put("pageId", checkArray[i]);	
				rowMap.put("pagePath", userData);	
				rowMap.put("resType", "1");
				rowMap.put("isAllow", (document.getElementById("MultiplePageChooser_allow").checked == true ) ? "true" : "false");
				rowMap.put("actionMask", actionMask);
				result[i] = rowMap;
			}
				
			this.m_callback(result);
		}
	}
}
