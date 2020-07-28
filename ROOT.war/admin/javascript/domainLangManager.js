var aDomainLangManager = null;
DomainLangManager = function(evSecurityCode)
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
DomainLangManager.prototype =
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
			,{"fieldName":"langKnd", "validation":"Required"}
			,{"fieldName":"domainNm", "validation":"Required,MaxLength", "maxLength":"256"}
			,{"fieldName":"domainDesc", "validation":"MaxLength", "maxLength":"1024"}
			
		]
		
		$(function() {
			$("#DomainLangManager_propertyTabs").tabs();
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
	/*
	getDomainLangChooser : function () {
		if( aDomainLangChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/domain/domainLang/listForChooser.admin", "", false, {
				success: function(data){
					//alert(data);
					document.getElementById("DomainLangManager_DomainLangChooser").innerHTML = data;
					aDomainLangChooser = new DomainLangChooser( aDomainLang.m_evSecurityCode );
				}});
		}
		return aDomainLangChooser;
	},
	setDomainLangChooserCallback : function (rowArray) {
		var chooseVal = "";
		for(var i=0; i<rowArray.length; i++) {
		
			chooseVal += rowArray[i].get("domainId") + ":";
		
			chooseVal += rowArray[i].get("langKnd") + ":";
		
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
		var formElem = document.forms[ "DomainLangManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "DomainLangManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/domain/domainLang/listForAjax.admin", param, false, {success: function(data) { aDomainLangManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) 
	{
		this.m_utility.setListData(
			"DomainLangManager",
			new Array('langKnd','domainId'),
			new Array('langKnd', 'domainNm'),
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
		var formElem = document.forms[ "DomainLangManager_SearchForm" ];
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
	doDefaultSelect : function () {
		if( document.getElementById('DomainLangManager[' + this.m_selectRowIndex + '].checkRow') ) {
			document.getElementById('DomainLangManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
			
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		
			param += "domainId=";
			param += document.getElementById('DomainLangManager[' + this.m_selectRowIndex + '].domainId').value;
			param += "&langKnd=";
			param += document.getElementById('DomainLangManager[' + this.m_selectRowIndex + '].langKnd').value;
			
			this.m_ajax.send("POST", this.m_contextPath + "/domain/domainLang/detailForAjax.admin", param, false, {success: function(data) { aDomainLangManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("DomainLangManager_ListForm") );
	    document.getElementById('DomainLangManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "domainId=";
		param += document.getElementById('DomainLangManager[' + rowSeq + '].domainId').value;
		param += "&langKnd=";
		param += document.getElementById('DomainLangManager[' + rowSeq + '].langKnd').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/domain/domainLang/detailForAjax.admin", param, false, {success: function(data) { aDomainLangManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "DomainLangManager", resultObject);
		var propertyTabs = $("#DomainLangManager_propertyTabs").tabs();
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
	
		$('#DomainLangManager_langKnd').attr('disabled', 'disalbled');
		document.getElementById("DomainLangManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "DomainLangManager");
		
		var propertyTabs = $("#DomainLangManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	 
		document.getElementById("DomainLangManager_domainId").value = document.getElementById("DomainLangManager_Master_domainId").value;
		$("#DomainLangManager_langKnd").removeAttr('disabled');
		document.getElementById("DomainLangManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail) {
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("DomainLangManager_isCreate").value;
		var form = document.getElementById("DomainLangManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/domain/domainLang/addForAjax.admin", param, false, {
				success: function(data){
					aDomainLangManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.message.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/domain/domainLang/updateForAjax.admin", param, false, {
				success: function(data){
					aDomainLangManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.message.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("DomainLangManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
		if( ret == true ) {
			var formData = "";
			var rowCntArray = rowCnts.split(",");
			var param = "evSecurityCode=" + this.m_evSecurityCode;
			for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += document.getElementById('DomainLangManager[' + rowCntArray[i] + '].domainId').value + ":";
				param += document.getElementById('DomainLangManager[' + rowCntArray[i] + '].langKnd').value;
			}
			this.m_ajax.send("POST", this.m_contextPath + "/domain/domainLang/removeForAjax.admin", param, false, {
				success: function(data){
					aDomainLangManager.m_selectRowIndex = 0;
					aDomainLangManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.message.remove') );
				}
			});
		}
	}
}

var aDomainLangChooser = null;
DomainLangChooser = function()
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	if( portalPage == null) portalPage = new enview.portal.Page();
	this.m_selectRowIndex = 0;
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = this.m_utility.getContextPath();
	this.m_domElement = document.getElementById("DomainLangManager_DomainLangChooser");
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
	
	$("#DomainLangManager_DomainLangChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:540, 
		height:400,
		modal: true,
		buttons: {
			"Apply": function() {
				aDomainLangChooser.doApply();
			},
			Cancel: function() {
				$(this).dialog('close');
			}
		}
	});
	
	this.init();
}

DomainLangChooser.prototype =
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
		$('#DomainLangManager_DomainLangChooser').dialog('open');
	},
	doRetrieve : function () {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "DomainLangChooser_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/domain/domainLang/listForAjax.admin", param, false, {success: function(data) { aDomainLangChooser.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		this.m_utility.setListData(
			"DomainLangChooser",
			new Array('langKnd','domainId'),
			new Array('langKnd', 'domainNm'),
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
		var formElem = document.forms[ "DomainLangChooser_SearchForm" ];
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
			this.m_checkBox.unChkAll( document.getElementById("DomainLangManager_ListForm") );
			document.getElementById('DomainLangChooser[' + rowSeq + '].checkRow').checked = true;
			this.m_parent.doApply();
			return;
		}
		
		$('#DomainLangManager_DomainLangChooser').dialog('close');
		
		var result = new Array(1);
		var rowMap = new Map();
		
		rowMap.put("domainId", document.getElementById('DomainLangChooser[' + rowSeq + '].domainId').value);	
		rowMap.put("langKnd", document.getElementById('DomainLangChooser[' + rowSeq + '].langKnd').value);	
		result[0] = rowMap;
		
		this.m_callback(result);
	},
	getSelectedItems : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("DomainLangChooser_ListForm") );
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
			
				rowMap.put("id", document.getElementById('DomainLangChooser[' + rowCntArray[i] + '].id').value);	
				result[i] = rowMap;
			}
			
			return result;
		}
		
		return null;
	},
	doApply : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("DomainLangChooser_ListForm") );
		if( rowCnts == "" ) return;
		
		var rowCntArray = rowCnts.split(",");
		if( rowCntArray.length > 0 ) {
			if( rowCntArray.length > 1 ) {
				alert( portalPage.getMessageResource('ev.info.message.select.onlyone') );
				return;
			}
			
			$('#DomainLangManager_DomainLangChooser').dialog('close');
			
			var result = new Array(rowCntArray.length);
			for(var i=0; i<rowCntArray.length; i++) {
				var rowMap = new Map();
			
				rowMap.put("domainId", document.getElementById('DomainLangChooser[' + rowCntArray[i] + '].domainId').value);	
				rowMap.put("langKnd", document.getElementById('DomainLangChooser[' + rowCntArray[i] + '].langKnd').value);	
				result[i] = rowMap;
			}
			
			this.m_callback(result);
		}
	}
}

