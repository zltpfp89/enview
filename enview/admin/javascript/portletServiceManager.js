
var aPortletServiceManager = null;
PortletServiceManager = function(evSecurityCode)
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
PortletServiceManager.prototype =
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
			{"fieldName":"serviceId", "validation":"Required,MaxLength", "maxLength":"200"}
			,{"fieldName":"serviceName", "validation":"Required,MaxLength", "maxLength":"60"}
			,{"fieldName":"serviceType", "validation":"", "maxLength":"1"}
			,{"fieldName":"dataType", "validation":"", "maxLength":"1"}
			,{"fieldName":"colDel", "validation":"MaxLength", "maxLength":"20"}
			,{"fieldName":"rowDel", "validation":"MaxLength", "maxLength":"20"}
			,{"fieldName":"titleYn", "validation":"", "maxLength":"1"}
			,{"fieldName":"dataUrl", "validation":"MaxLength", "maxLength":"200"}
			,{"fieldName":"jndiName", "validation":"MaxLength", "maxLength":"20"}
			,{"fieldName":"userParam", "validation":"MaxLength", "maxLength":"200"}
			,{"fieldName":"portletParam", "validation":"MaxLength", "maxLength":"200"}
			,{"fieldName":"dbSql", "validation":"MaxLength", "maxLength":"2000"}
			,{"fieldName":"maxCacheTime", "validation":"MaxLength", "maxLength":"20"}
			,{"fieldName":"maxCacheSize", "validation":"MaxLength", "maxLength":"20"}
			
		]
		
		$(function() {
			$("#PortletServiceManager_propertyTabs").tabs();
		});
		
		$.datepicker.setDefaults({
			showMonthAfterYear: true,
			changeMonth: true,
			changeYear: true,
			showButtonPanel: true,
			showAnim : 'slideDown',
			dateFormat : 'yy-mm-dd'
		});
		
		this.doCreate();
		
	},
	/*
	getPortletServiceChooser : function () {
		if( aPortletServiceChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/portletService/listForChooser.admin", "", false, {
				success: function(data){
					//alert(data);
					document.getElementById("PortletServiceManager_PortletServiceChooser").innerHTML = data;
					aPortletServiceChooser = new PortletServiceChooser( aPortletService.m_evSecurityCode );
				}});
		}
		return aPortletServiceChooser;
	},
	setPortletServiceChooserCallback : function (rowArray) {
		var chooseVal = "";
		for(var i=0; i<rowArray.length; i++) {
		
			chooseVal += rowArray[i].get("serviceId") + ":";
		
		}
		alert("chooseValue=" + chooseVal);
	},
	*/
	onSelectPropertyTab : function (id) {
		var param = "";	
		switch(id) {
			case 0 : 
				break;
		
		}
		
		return true; 
	},
	initSearch : function () {
		var formElem = document.forms[ "PortletServiceManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "PortletServiceManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/portletService/listForAjax.admin", param, false, {success: function(data) { aPortletServiceManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"PortletServiceManager",
			new Array('serviceId'),
			new Array('serviceId', 'serviceName'),
			this.m_contextPath,
			resultObject);
				
		if(resultObject.Data.length != 0) {
			this.doDefaultSelect(); 
		}
		else {
			this.doCreate();
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
		var formElem = document.forms[ "PortletServiceManager_SearchForm" ];
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
		if( document.getElementById('PortletServiceManager[' + this.m_selectRowIndex + '].checkRow') ) {
			document.getElementById('PortletServiceManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
			
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		
			param += "serviceId=";
			param += document.getElementById('PortletServiceManager[' + this.m_selectRowIndex + '].serviceId').value;
			
			this.m_ajax.send("POST", this.m_contextPath + "/portletService/detailForAjax.admin", param, false, {success: function(data) { aPortletServiceManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("PortletServiceManager_ListForm") );
	    document.getElementById('PortletServiceManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "serviceId=";
		param += document.getElementById('PortletServiceManager[' + rowSeq + '].serviceId').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/portletService/detailForAjax.admin", param, false, {success: function(data) { aPortletServiceManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "PortletServiceManager", resultObject);
		
		var serviceType = portalPage.getAjax().retrieveElementValue("serviceType", resultObject)
		if( serviceType == "h" ) {
			document.getElementById("portletService_dataUrl").style.display = "";
			document.getElementById("portletService_jndiName").style.display = "none";
			document.getElementById("portletService_dbSql").style.display = "none";
		}
		else {
			document.getElementById("portletService_dataUrl").style.display = "none";
			document.getElementById("portletService_jndiName").style.display = "";
			document.getElementById("portletService_dbSql").style.display = "";
		}
		
		var propertyTabs = $("#PortletServiceManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("PortletServiceManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "PortletServiceManager");
		
		var propertyTabs = $("#PortletServiceManager_propertyTabs").tabs();
		propertyTabs.tabs('select', 0);
		
		document.getElementById("PortletServiceManager_serviceType").value = "d";
		document.getElementById("portletService_dataUrl").style.display = "none";
		document.getElementById("portletService_jndiName").style.display = "";
		document.getElementById("portletService_dbSql").style.display = "";
	
		document.getElementById("PortletServiceManager_serviceId").readOnly = false;
		document.getElementById("PortletServiceManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("PortletServiceManager_isCreate").value;
		var form = document.getElementById("PortletServiceManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/portletService/addForAjax.admin", param, false, {
				success: function(data){
					aPortletServiceManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.message.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/portletService/updateForAjax.admin", param, false, {
				success: function(data){
					aPortletServiceManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.message.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PortletServiceManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('PortletServiceManager[' + rowCntArray[i] + '].serviceId').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/portletService/removeForAjax.admin", param, false, {
				success: function(data){
					aPortletServiceManager.m_selectRowIndex = 0;
					aPortletServiceManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.message.remove') );
				}});
			
		}
	},
	changeServiceType : function (obj) {
		var serviceType = obj.options[obj.selectedIndex].value;
		if( serviceType == "d" ) {
			document.getElementById("portletService_dataUrl").style.display = "none";
			document.getElementById("portletService_jndiName").style.display = "";
			document.getElementById("portletService_dbSql").style.display = "";
		}
		else {
			document.getElementById("portletService_dataUrl").style.display = "";
			document.getElementById("portletService_jndiName").style.display = "none";
			document.getElementById("portletService_dbSql").style.display = "none";
		}
	}
	
}

var aPortletServiceChooser = null;
PortletServiceChooser = function()
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	if( portalPage == null) portalPage = new enview.portal.Page();
	this.m_selectRowIndex = 0;
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = this.m_utility.getContextPath();
	this.m_domElement = document.getElementById("PortletServiceManager_PortletServiceChooser");
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
	
	$("#PortletServiceManager_PortletServiceChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:540, 
		height:400,
		modal: true,
		buttons: {
			"Apply": function() {
				aPortletServiceChooser.doApply();
			},
			Cancel: function() {
				$(this).dialog('close');
			}
		}
	});
	
	this.init();
}

PortletServiceChooser.prototype =
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
		this.m_callback = callback;
		
		this.doRetrieve();
		$('#PortletServiceManager_PortletServiceChooser').dialog('open');
	},
	doRetrieve : function () {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "PortletServiceChooser_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/portletService/listForAjax.admin", param, false, {success: function(data) { aPortletServiceChooser.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		this.m_utility.setListData(
			"PortletServiceChooser",
			new Array('serviceId'),
			new Array('serviceId', 'serviceName'),
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
		var formElem = document.forms[ "PortletServiceChooser_SearchForm" ];
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
			this.m_checkBox.unChkAll( document.getElementById("PortletServiceManager_ListForm") );
			document.getElementById('PortletServiceChooser[' + rowSeq + '].checkRow').checked = true;
			this.m_parent.doApply();
			return;
		}
		
		$('#PortletServiceManager_PortletServiceChooser').dialog('close');
		
		var result = new Array(1);
		var rowMap = new Map();
		
		rowMap.put("serviceId", document.getElementById('PortletServiceChooser[' + rowSeq + '].serviceId').value);	
		result[0] = rowMap;
		
		this.m_callback(result);
	},
	getSelectedItems : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PortletServiceChooser_ListForm") );
		if( rowCnts == "" ) return;
		
		var rowCntArray = rowCnts.split(",");
		if( rowCntArray.length > 0 ) {
			if( rowCntArray.length > 1 ) {
				alert( portalPage.getMessageResource('ev.info.message.select.onlyone') );
				return;
			}
			
			var result = new Array(rowCntArray.length);
			for(var i=0; i<rowCntArray.length; i++) {
				var rowMap = new Map();
			
				rowMap.put("id", document.getElementById('PortletServiceChooser[' + rowCntArray[i] + '].id').value);	
				result[i] = rowMap;
			}
			
			return result;
		}
		
		return null;
	},
	doApply : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PortletServiceChooser_ListForm") );
		if( rowCnts == "" ) return;
		
		var rowCntArray = rowCnts.split(",");
		if( rowCntArray.length > 0 ) {
			if( rowCntArray.length > 1 ) {
				alert( portalPage.getMessageResource('ev.info.message.select.onlyone') );
				return;
			}
			
			$('#PortletServiceManager_PortletServiceChooser').dialog('close');
			
			var result = new Array(rowCntArray.length);
			for(var i=0; i<rowCntArray.length; i++) {
				var rowMap = new Map();
			
				rowMap.put("serviceId", document.getElementById('PortletServiceChooser[' + rowCntArray[i] + '].serviceId').value);	
				result[i] = rowMap;
			}
			
			this.m_callback(result);
		}
	}
}

