
var aBatchActionManager = null;
BatchActionManager = function(evSecurityCode)
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
BatchActionManager.prototype =
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
			{"fieldName":"actionId", "validation":""}
			,{"fieldName":"name", "validation":"Required,MaxLength", "maxLength":"100"}
			,{"fieldName":"actionType", "validation":"Required"}
			,{"fieldName":"program", "validation":"Required,MaxLength", "maxLength":"255"}
			,{"fieldName":"parameter", "validation":"MaxLength", "maxLength":"250"}
			,{"fieldName":"useYn", "validation":""}
			,{"fieldName":"updUserId", "validation":""}
			,{"fieldName":"updDatim", "validation":""}
			
		]
		
		$(function() {
			$("#BatchActionManager_propertyTabs").tabs();
		});
		
	},
	onSelectPropertyTab : function (id) {
		var param = "";	
		switch(id) {
			case 0 : 
				break;
		
		}
		
		return true; 
	},
	initSearch : function () {
		var formElem = document.forms[ "BatchActionManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "BatchActionManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/batchAction/listForAjax.admin", param, false, {success: function(data) { aBatchActionManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"BatchActionManager",
			new Array('actionId'),
			new Array('actionId', 'name', 'updUserId', 'updDatim'),
			this.m_contextPath,
			resultObject);
				
		if(resultObject.Data.length != 0) {
			this.doDefaultSelect(); 
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
		var formElem = document.forms[ "BatchActionManager_SearchForm" ];
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
		if( document.getElementById('BatchActionManager[' + this.m_selectRowIndex + '].checkRow') ) {
			document.getElementById('BatchActionManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
			
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		
			param += "actionId=";
			param += document.getElementById('BatchActionManager[' + this.m_selectRowIndex + '].actionId').value;
			
			this.m_ajax.send("POST", this.m_contextPath + "/batchAction/detailForAjax.admin", param, false, {success: function(data) { aBatchActionManager.doSelectHandler(data); }});
		}
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
		
	    this.m_checkBox.unChkAll( document.getElementById("BatchActionManager_ListForm") );
	    document.getElementById('BatchActionManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "actionId=";
		param += document.getElementById('BatchActionManager[' + rowSeq + '].actionId').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/batchAction/detailForAjax.admin", param, false, {success: function(data) { aBatchActionManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "BatchActionManager", resultObject);
		
	
		document.getElementById("BatchActionManager_actionId").readOnly = true;
		document.getElementById("BatchActionManager_updUserId").readOnly = true;
		document.getElementById("BatchActionManager_updDatim").readOnly = true;
		
		var propertyTabs = $("#BatchActionManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("BatchActionManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "BatchActionManager");
		
		var propertyTabs = $("#BatchActionManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	
		document.getElementById("BatchActionManager_actionId").readOnly = true;
		document.getElementById("BatchActionManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("BatchActionManager_isCreate").value;
		var form = document.getElementById("BatchActionManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/batchAction/addForAjax.admin", param, false, {
				success: function(data){
					aBatchActionManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/batchAction/updateForAjax.admin", param, false, {
				success: function(data){
					aBatchActionManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("BatchActionManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('BatchActionManager[' + rowCntArray[i] + '].actionId').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/batchAction/removeForAjax.admin", param, false, {
				success: function(data){
					aBatchActionManager.m_selectRowIndex = 0;
					aBatchActionManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	}
	
}

var aBatchActionChooser = null;
BatchActionChooser = function(evSecurityCode)
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	if( portalPage == null) portalPage = new enview.portal.Page();
	this.m_selectRowIndex = 0;
	this.m_evSecurityCode = evSecurityCode;
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = portalPage.getContextPath();
	this.m_domElement = document.getElementById("BatchActionManager_BatchActionChooser");
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
	
	$("#BatchActionManager_BatchActionChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:700, 
		height:520,
		modal: true,
		buttons: {
			"Apply": function() {
				aBatchActionChooser.doApply();
			},
			Cancel: function() {
				$(this).dialog('close');
			}
		}
	});
	
	this.init();
}

BatchActionChooser.prototype =
{
	m_domElement : null,
	m_checkBox : null,
	m_sourceElement : null,
	m_callback : null,
	m_parent : null,
	m_evSecurityCode : null,
	
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
		$('#BatchActionManager_BatchActionChooser').dialog('open');
	},
	doRetrieve : function () {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "BatchActionChooser_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/batchAction/listForAjax.admin", param, false, {success: function(data) { aBatchActionChooser.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		this.m_utility.setListData(
			"BatchActionChooser",
			new Array('actionId', 'name'),
			new Array('actionId', 'name', 'updUserId', 'updDatim'),
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
		var formElem = document.forms[ "BatchActionChooser_SearchForm" ];
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
			this.m_checkBox.unChkAll( document.getElementById("BatchActionManager_ListForm") );
			document.getElementById('BatchActionChooser[' + rowSeq + '].checkRow').checked = true;
			this.m_parent.doApply();
			return;
		}
		
		$('#BatchActionManager_BatchActionChooser').dialog('close');
		
		var result = new Array(1);
		var rowMap = new Map();
		
		rowMap.put("actionId", document.getElementById('BatchActionChooser[' + rowSeq + '].actionId').value);	
		rowMap.put("actionName", document.getElementById('BatchActionChooser[' + rowSeq + '].name').value);
		result[0] = rowMap;
		
		this.m_callback(result);
	},
	doApply : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("BatchActionChooser_ListForm") );
		if( rowCnts == "" ) return;
		
		var rowCntArray = rowCnts.split(",");
		if( rowCntArray.length > 0 ) {
			if( rowCntArray.length > 1 ) {
				alert( portalPage.getMessageResource('ev.info.select.onlyone') );
				return;
			}
			
			$('#BatchActionManager_BatchActionChooser').dialog('close');
			
			var result = new Array(rowCntArray.length);
			for(var i=0; i<rowCntArray.length; i++) {
				var rowMap = new Map();
			
				rowMap.put("actionId", document.getElementById('BatchActionChooser[' + rowCntArray[i] + '].actionId').value);	
				rowMap.put("actionName", document.getElementById('BatchActionChooser[' + rowCntArray[i] + '].name').value);
				result[i] = rowMap;
			}
			
			this.m_callback(result);
		}
	}
}

