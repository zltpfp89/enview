
var aUrlPermissionManager = null;
UrlPermissionManager = function(evSecurityCode)
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
UrlPermissionManager.prototype =
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
			,{"fieldName":"domainId", "validation":""}
			,{"fieldName":"title", "validation":""}
			,{"fieldName":"resUrl", "validation":"Required,MaxLength", "maxLength":"250"}
			,{"fieldName":"resType", "validation":""}
			,{"fieldName":"actionMask", "validation":""}
			,{"fieldName":"isAllow", "validation":""}
			,{"fieldName":"creationDate", "validation":""}
			,{"fieldName":"modifiedDate", "validation":""}
			
		]
		
		$(function() {
			$("#UrlPermissionManager_propertyTabs").tabs();
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
	getUrlChooser : function () {
		if( portalUrlSelectorPermissionApp == null ) {
			portalUrlSelectorPermissionApp = new enview.portal.UrlSelectorPermissionApp( aUrlPermissionManager.m_evSecurityCode );
			portalUrlSelectorPermissionApp.init();
		}
		return portalUrlSelectorPermissionApp;
	},
	setUrlChooserCallback : function (rowArray) {
		document.getElementById("UrlPermissionManager_title").value = rowArray[0].get("title");
		document.getElementById("UrlPermissionManager_resUrl").value = rowArray[0].get("path");
	},
	getMultipleUrlChooser : function () {
		if( portalUrlSelectorPermissionApp == null ) {
			portalUrlSelectorPermissionApp = new enview.portal.UrlSelectorPermissionApp( aUrlPermissionManager.m_evSecurityCode );
			portalUrlSelectorPermissionApp.init();
		}
		return portalUrlSelectorPermissionApp;
	},
	setMultipleUrlChooserCallback : function (rowArray) {
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&principalId=" + document.getElementById("SecurityPermission_principalId");
		param += "&isPage=false";
		param += "&principalType=" + document.getElementById("UrlPermissionManager_Master_principalType").value;
		param += "&domainId=" + document.getElementById("UrlPermissionManager_Master_domainId").value;
		for(var i=0; i<rowArray.length; i++) {
			param += "&updateDatas=";
			param += document.getElementById("SecurityPermission_principalId").value + "@" +
				     encodeURIComponent(rowArray[i].get("title")) + "@" +
				     rowArray[i].get("path") + "@" +
				     rowArray[i].get("resType") + "@" +
				     rowArray[i].get("actionMask") + "@" +
				     rowArray[i].get("isAllow");
		}
		//alert("param=" + param);  
		
		this.m_ajax.send("POST", this.m_contextPath + "/urlPermission/addsForAjax.admin", param, false, {
				success: function(data){
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
					aUrlPermissionManager.doRetrieve();
				}});
	},
	onSelectPropertyTab : function (id) {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		switch(id) {
			case 0 : 
				break;
		
		}
		
		return true; 
	},
	initSearch : function () {
		var formElem = document.forms[ "UrlPermissionManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function (managerName, rootId) {
		//this.doCreate();
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "UrlPermissionManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/urlPermission/listForAjax.admin", param, false, {success: function(data) { aUrlPermissionManager.doRetrieveHandler(data, managerName, rootId); }});
	},
	doRetrieveHandler : function( resultObject, managerName, rootId ) {
		
		this.m_utility.setListData(
			"UrlPermissionManager",
			new Array('permissionId'),
			new Array('permissionId', 'principalId', 'title', 'resUrl'),
			this.m_contextPath,
			resultObject);
				
		if(resultObject.Data.length != 0) {
			this.doDefaultSelect(); 
		}
		
//		if(managerName){
//			if($('#isAdmin').val() == 'true' || $('#' + managerName + '_Master_domainId').val() != 0){
//				 if($('#' + managerName + '_principalId').val() != rootId) $('.UrlPermissionManager_EditFormButtons').css('display', 'block');
//				 else $('.UrlPermissionManager_EditFormButtons').css('display', 'none');
//			}else {
//				$('.UrlPermissionManager_EditFormButtons').css('display', 'none');
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
		var formElem = document.forms[ "UrlPermissionManager_SearchForm" ];
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
		document.getElementById('UrlPermissionManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "permissionId=";
		param += document.getElementById('UrlPermissionManager[' + this.m_selectRowIndex + '].permissionId').value;
		param += "&domainId=" + document.getElementById("UrlPermissionManager_Master_domainId").value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/urlPermission/detailForAjax.admin", param, false, {success: function(data) { aUrlPermissionManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("UrlPermissionManager_ListForm") );
	    document.getElementById('UrlPermissionManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "permissionId=";
		param += document.getElementById('UrlPermissionManager[' + rowSeq + '].permissionId').value;
		param += "&domainId=" + document.getElementById("UrlPermissionManager_Master_domainId").value;
		this.m_ajax.send("POST", this.m_contextPath + "/urlPermission/detailForAjax.admin", param, false, {success: function(data) { aUrlPermissionManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		//this.m_utility.setFormDataFromXML(this.m_dataStructure, "UrlPermissionManager", resultObject);
		document.getElementById("UrlPermissionManager_permissionId").value = portalPage.getAjax().retrieveElementValue("permissionId", resultObject);
		document.getElementById("UrlPermissionManager_principalId").value = portalPage.getAjax().retrieveElementValue("principalId", resultObject);
		document.getElementById("UrlPermissionManager_domainId").value = portalPage.getAjax().retrieveElementValue("domainId", resultObject);
		document.getElementById("UrlPermissionManager_title").value = portalPage.getAjax().retrieveElementValue("title", resultObject);
		document.getElementById("UrlPermissionManager_resType").value = portalPage.getAjax().retrieveElementValue("resType", resultObject);
		document.getElementById("UrlPermissionManager_isAllow").checked = (portalPage.getAjax().retrieveElementValue("isAllow", resultObject) == "true") ? true : false;
		document.getElementById("UrlPermissionManager_resUrl").value = portalPage.getAjax().retrieveElementValue("resUrl", resultObject);
		document.getElementById("UrlPermissionManager_creationDate").value = portalPage.getAjax().retrieveElementValue("creationDate", resultObject);
		document.getElementById("UrlPermissionManager_modifiedDate").value = portalPage.getAjax().retrieveElementValue("modifiedDate", resultObject);
		
		var actionMask = portalPage.getAjax().retrieveElementValue("actionMask", resultObject);
		//alert("actionMask=" + actionMask);
		var form = document.getElementById("UrlPermissionManager_EditForm");
		for(var j=0; j<form.elements.length; j++) {
			field = form.elements[j];
			//alert(field.type + "," + field.id + "," + field.checked);
			if(field.type == "checkbox" && field.id && field.id.indexOf("UrlPermissionManager_authority_") > -1 ) {
				var authValue = field.id.substring(31);
				//alert("authValue=" + authValue);
				if( (actionMask & authValue) == authValue ) {
					field.checked = true;
				}
				else {
					field.checked = false;
				}
			}
		}
	
		document.getElementById("UrlPermissionManager_creationDate").readOnly = true;
		document.getElementById("UrlPermissionManager_modifiedDate").readOnly = true;
		
		
		var propertyTabs = $("#UrlPermissionManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("UrlPermissionManager_isCreate").value = "false";
		document.getElementById("UrlPermissionManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "UrlPermissionManager");
		
		var form = document.getElementById("UrlPermissionManager_EditForm");
		for(var j=0; j<form.elements.length; j++) {
			field = form.elements[j];
			if(field.type == "checkbox" && field.id && field.id.indexOf("UrlPermissionManager_authority_") > -1 ) {
				field.checked = false;
			}
		}
		
		document.getElementById("UrlPermissionManager_resType").value = 4;
		
		var propertyTabs = $("#UrlPermissionManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	 
		document.getElementById("UrlPermissionManager_principalId").value = document.getElementById("UrlPermissionManager_Master_principalId").value;
		document.getElementById("UrlPermissionManager_domainId").value = document.getElementById("UrlPermissionManager_Master_domainId").value;
		document.getElementById("UrlPermissionManager_permissionId").readOnly = false;
		document.getElementById("UrlPermissionManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var param = "";
		var isCreate = document.getElementById("UrlPermissionManager_isCreate").value;
		var form = document.getElementById("UrlPermissionManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		//var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode;
		param += "&permissionId=" + document.getElementById("UrlPermissionManager_permissionId").value;
		param += "&principalId=" + document.getElementById("UrlPermissionManager_principalId").value;
		param += "&domainId=" + document.getElementById("UrlPermissionManager_domainId").value;
		param += "&principalType=" + document.getElementById("UrlPermissionManager_Master_principalType").value;
		var resType = document.getElementById("UrlPermissionManager_resType").value;
//		if( resType == 3 ) {
//			param += "&title=Url Pattern";
//		}
		if( resType == 4 ) {
			param += "&title=External URL";
		}
		else {
			var title = document.getElementById("UrlPermissionManager_title").value;
			if( title == null || title.length == 0 ) {
				alert( portalPage.getMessageResource('ev.error.selectUrl') );
				return;
			}
			param += "&title=" + encodeURIComponent(title);
		}
		param += "&resType=" + document.getElementById("UrlPermissionManager_resType").value;
		param += "&isAllow=" + ((document.getElementById("UrlPermissionManager_isAllow").checked == true) ? "true" : "false");
		param += "&resUrl=" + document.getElementById("UrlPermissionManager_resUrl").value;
		param += "&creationDate=" + document.getElementById("UrlPermissionManager_creationDate").value;
		param += "&modifiedDate=" + document.getElementById("UrlPermissionManager_modifiedDate").value;
		
		var actionMask = 15; // view authority
		var form = document.getElementById("UrlPermissionManager_EditForm");
		for(var j=0; j<form.elements.length; j++) {
			field = form.elements[j];
			//alert(field.type + "," + field.id + "," + field.checked);
			if(field.type == "checkbox" && field.id && field.id.indexOf("UrlPermissionManager_authority_") > -1 ) {
				if( field.checked == true ) {
					actionMask |= field.value;
				}
			}
		}
		param += "&actionMask=" + actionMask;
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/urlPermission/addForAjax.admin", param, false, {
				success: function(data){
					if( forDetail == null || forDetail == false ) {
						aUrlPermissionManager.doRetrieve();
					}
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/urlPermission/updateForAjax.admin", param, false, {
				success: function(data){
					if( forDetail == null || forDetail == false ) {
						aUrlPermissionManager.doRetrieve();
					}
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("UrlPermissionManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
			param += "&principalId=" + document.getElementById("SecurityPermission_principalId").value;
			param += "&domainId=" + document.getElementById("UrlPermissionManager_domainId").value;
			param += "&principalType=" + document.getElementById("UrlPermissionManager_Master_principalType").value;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('UrlPermissionManager[' + rowCntArray[i] + '].permissionId').value + ":" +
					document.getElementById("UrlPermissionManager_domainId").value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/urlPermission/removeForAjax.admin", param, false, {
				success: function(data){
					aUrlPermissionManager.initSearch();
					aUrlPermissionManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	},
	toggleAllPermission : function () {
		
		var isChecked = (document.getElementById("UrlPermissionManager_actionMask_check").checked == true) ? true : false;
		var form = document.getElementById("UrlPermissionManager_EditForm");
		for(var j=0; j<form.elements.length; j++) {
			field = form.elements[j];
			//alert(field.type + "," + field.id + "," + field.checked);
			if(field.type == "checkbox" && field.id && field.id.indexOf("UrlPermissionManager_authority_") > -1 ) {
				if( isChecked == true ) { field.checked = true; }
				else { field.checked = false; }
			}
		}
	}
	
}
/*
var aUrlPermissionChooser = null;
UrlPermissionChooser = function(parent)
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	if( portalPage == null) portalPage = new enview.portal.Page();
	this.m_selectRowIndex = 0;
	this.m_contextPath = portalPage.getContextPath();
	this.m_domElement = document.getElementById("UrlPermissionManager_UrlPermissionChooser");
	this.m_parent = parent;
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
	
	$("#UrlPermissionManager_UrlPermissionChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:540, 
		height:400,
		modal: true,
		buttons: {
			"Apply": function() {
				aUrlPermissionChooser.doApply();
			},
			Cancel: function() {
				$(this).dialog('close');
			}
		}
	});
	
	this.init();
}

UrlPermissionChooser.prototype =
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
	doShow : function (callback)
	{
		this.m_callback = callback;
		
		this.doRetrieve();
		$('#UrlPermissionManager_UrlPermissionChooser').dialog('open');
	},
	doRetrieve : function () {
		var param = "";
		var formElem = document.forms[ "UrlPermissionChooser_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/urlPermission/listForAjax.admin", param, false, {success: function(data) { aUrlPermissionChooser.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		this.m_utility.setListData(
			"UrlPermissionChooser",
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
		var formElem = document.forms[ "UrlPermissionChooser_SearchForm" ];
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
			this.m_checkBox.unChkAll( document.getElementById("UrlPermissionManager_ListForm") );
			document.getElementById('UrlPermissionChooser[' + rowSeq + '].checkRow').checked = true;
			this.m_parent.doApply();
			return;
		}
		
		$('#UrlPermissionManager_UrlPermissionChooser').dialog('close');
		
		if( this.m_sourceElement != null ) {
			
			this.m_sourceElement.value = document.getElementById('UrlPermissionChooser[' + rowSeq + '].permissionId').value;	
		}
		else {
			var result = new Array(1);
			var rowMap = new Map();
			
			rowMap.put("permissionId", document.getElementById('UrlPermissionChooser[' + rowSeq + '].permissionId').value);	
			result[0] = rowMap;
			
			this.m_callback(result);
		}
	},
	getSelectedItems : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("UrlPermissionChooser_ListForm") );
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
			
				rowMap.put("id", document.getElementById('UrlPermissionChooser[' + rowCntArray[i] + '].id').value);	
				result[i] = rowMap;
			}
			
			return result;
		}
		
		return null;
	},
	doApply : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("UrlPermissionChooser_ListForm") );
		if( rowCnts == "" ) return;
		
		var rowCntArray = rowCnts.split(",");
		if( rowCntArray.length > 0 ) {
			if( rowCntArray.length > 1 ) {
				alert( portalPage.getMessageResource('ev.info.select.onlyone') );
				return;
			}
			
			$('#UrlPermissionManager_UrlPermissionChooser').dialog('close');
			
			var result = new Array(rowCntArray.length);
			for(var i=0; i<rowCntArray.length; i++) {
				var rowMap = new Map();
			
				rowMap.put("permissionId", document.getElementById('UrlPermissionChooser[' + rowCntArray[i] + '].permissionId').value);	
				result[i] = rowMap;
			}
			
			this.m_callback(result);
		}
	}
}

*/