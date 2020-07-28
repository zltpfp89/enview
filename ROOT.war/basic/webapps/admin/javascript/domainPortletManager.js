var aDomainPortletManager = null;


DomainPortletManager = function(evSecurityCode)
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
DomainPortletManager.prototype =
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
			{"fieldName":"domainId", "validation":""}
			,{"fieldName":"portletNm", "validation":""}
			
		]
		
		$(function() {
			$("#DomainPortletManager_propertyTabs").tabs();
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
	getPortletChooser : function () 
	{
		//alert(selectDomainId);
	
		if( portalPortletSelectorPermissionApp == null ) 
		{
			portalPortletSelectorPermissionApp = new enview.portal.PortletSelectorPermissionApp( aDomainPortletManager.m_evSecurityCode );
			portalPortletSelectorPermissionApp.init();
		}
		return portalPortletSelectorPermissionApp;
	},
	
	setPortletChooserCallback : function (rowArray) 
	{
		alert(rowArray[0].get("title"));
		alert(rowArray[0].get("path"));
		
		//document.getElementById("PortletPermissionManager_title").value = rowArray[0].get("title");
		//document.getElementById("PortletPermissionManager_resUrl").value = rowArray[0].get("path");
	},
	getMultiplePortletChooser : function () {
		if( portalPortletSelectorPermissionApp == null ) {
			portalPortletSelectorPermissionApp = new enview.portal.PortletSelectorPermissionApp( aDomainPortletManager.m_evSecurityCode );
			portalPortletSelectorPermissionApp.init();
		}
		return portalPortletSelectorPermissionApp;
	},
	setMultiplePortletChooserCallback : function (rowArray)
	{
		var param =  "param"+ "evSecurityCode=" + this.m_evSecurityCode;
		//param += "&isPage=false";
		//param += "&principalType=" + document.getElementById("PortletPermissionManager_Master_principalType").value;
		for(var i=0; i<rowArray.length; i++)
		{
			//alert(rowArray[i].get("path"));
			
	    	param += "&updateDatas=";
			param += selectDomainId + "@" +
				     encodeURIComponent(rowArray[i].get("title")) + "@" +
				     rowArray[i].get("path") + "@" +
				     rowArray[i].get("resType") + "@" +
				     rowArray[i].get("actionMask") + "@" +
				     rowArray[i].get("isAllow");
		}

		this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPortlet/addsForAjax.admin", param, false, 
				{
				success: function(data)
				{
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
					aDomainPortletManager.doRetrieve();
				}});
	},
	/*
	getDomainPortletChooser : function () {
		if( aDomainPortletChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPortlet/listForChooser.admin", "", false, {
				success: function(data){
					//alert(data);
					document.getElementById("DomainPortletManager_DomainPortletChooser").innerHTML = data;
					aDomainPortletChooser = new DomainPortletChooser( aDomainPortlet.m_evSecurityCode );
				}});
		}
		return aDomainPortletChooser;
	},
	setDomainPortletChooserCallback : function (rowArray) {
		var chooseVal = "";
		for(var i=0; i<rowArray.length; i++) {
		
			chooseVal += rowArray[i].get("domainId") + ":";
		
			chooseVal += rowArray[i].get("portletNm") + ":";
		
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
		var formElem = document.forms[ "DomainPortletManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "DomainPortletManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPortlet/listForAjax.admin", param, false, {success: function(data) { aDomainPortletManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"DomainPortletManager",
			new Array('portletNm','domainId'),
			new Array('portletNm'),
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
		var formElem = document.forms[ "DomainPortletManager_SearchForm" ];
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
		if( document.getElementById('DomainPortletManager[' + this.m_selectRowIndex + '].checkRow') ) {
			document.getElementById('DomainPortletManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
			
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		
			param += "domainId=";
			param += document.getElementById('DomainPortletManager[' + this.m_selectRowIndex + '].domainId').value;
			param += "&portletNm=";
			param += document.getElementById('DomainPortletManager[' + this.m_selectRowIndex + '].portletNm').value;
			
			this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPortlet/detailForAjax.admin", param, false, {success: function(data) { aDomainPortletManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("DomainPortletManager_ListForm") );
	    document.getElementById('DomainPortletManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "domainId=";
		param += document.getElementById('DomainPortletManager[' + rowSeq + '].domainId').value;
		param += "&portletNm=";
		param += document.getElementById('DomainPortletManager[' + rowSeq + '].portletNm').value;
		
			
		this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPortlet/detailForAjax.admin", param, false, {success: function(data) { aDomainPortletManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "DomainPortletManager", resultObject);		
		var propertyTabs = $("#DomainPortletManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("DomainPortletManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "DomainPortletManager");
		
		var propertyTabs = $("#DomainPortletManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	 
		document.getElementById("DomainPortletManager_domainId").value = document.getElementById("DomainPortletManager_Master_domainId").value; 
		document.getElementById("DomainPortletManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("DomainPortletManager_isCreate").value;
		var form = document.getElementById("DomainPortletManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPortlet/addForAjax.admin", param, false, {
				success: function(data){
					aDomainPortletManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.message.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPortlet/updateForAjax.admin", param, false, {
				success: function(data){
					aDomainPortletManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.message.success.update') );
				}});
		}
	},
	doRemove : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("DomainPortletManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.message.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('DomainPortletManager[' + rowCntArray[i] + '].domainId').value + "@" +
					document.getElementById('DomainPortletManager[' + rowCntArray[i] + '].portletNm').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPortlet/removeForAjax.admin", param, false, {
				success: function(data){
					aDomainPortletManager.m_selectRowIndex = 0;
					aDomainPortletManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.message.success.remove') );
				}});
			
		}
	}
	
}

var aDomainPortletChooser = null;
DomainPortletChooser = function()
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	if( portalPage == null) portalPage = new enview.portal.Page();
	this.m_selectRowIndex = 0;
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = this.m_utility.getContextPath();
	this.m_domElement = document.getElementById("DomainPortletManager_DomainPortletChooser");
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
	
	$("#DomainPortletManager_DomainPortletChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:540, 
		height:400,
		modal: true,
		buttons: {
			"Apply": function() {
				aDomainPortletChooser.doApply();
			},
			Cancel: function() {
				$(this).dialog('close');
			}
		}
	});
	
	this.init();
}

DomainPortletChooser.prototype =
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
		$('#DomainPortletManager_DomainPortletChooser').dialog('open');
	},
	doRetrieve : function () 
	{
		alert("새로고침");
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "DomainPortletChooser_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPortlet/listForAjax.admin", param, false, {success: function(data) { aDomainPortletChooser.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		this.m_utility.setListData(
			"DomainPortletChooser",
			new Array('portletNm','domainId'),
			new Array('portletNm'),
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
		var formElem = document.forms[ "DomainPortletChooser_SearchForm" ];
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
			this.m_checkBox.unChkAll( document.getElementById("DomainPortletManager_ListForm") );
			document.getElementById('DomainPortletChooser[' + rowSeq + '].checkRow').checked = true;
			this.m_parent.doApply();
			return;
		}
		
		$('#DomainPortletManager_DomainPortletChooser').dialog('close');
		
		var result = new Array(1);
		var rowMap = new Map();
		
		rowMap.put("domainId", document.getElementById('DomainPortletChooser[' + rowSeq + '].domainId').value);	
		rowMap.put("portletNm", document.getElementById('DomainPortletChooser[' + rowSeq + '].portletNm').value);	
		
		result[0] = rowMap;
		
		this.m_callback(result);
	},
	getSelectedItems : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("DomainPortletChooser_ListForm") );
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
			
				rowMap.put("id", document.getElementById('DomainPortletChooser[' + rowCntArray[i] + '].id').value);	
				result[i] = rowMap;
			}
			
			return result;
		}
		
		return null;
	},
	doApply : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("DomainPortletChooser_ListForm") );
		if( rowCnts == "" ) return;
		
		var rowCntArray = rowCnts.split(",");
		if( rowCntArray.length > 0 ) {
			if( rowCntArray.length > 1 ) {
				alert( portalPage.getMessageResource('ev.info.message.select.onlyone') );
				return;
			}
			
			$('#DomainPortletManager_DomainPortletChooser').dialog('close');
			
			var result = new Array(rowCntArray.length);
			for(var i=0; i<rowCntArray.length; i++) {
				var rowMap = new Map();
			
				rowMap.put("domainId", document.getElementById('DomainPortletChooser[' + rowCntArray[i] + '].domainId').value);	
				rowMap.put("portletNm", document.getElementById('DomainPortletChooser[' + rowCntArray[i] + '].portletNm').value);	
				result[i] = rowMap;
			}
			
			this.m_callback(result);
		}
	}
}

