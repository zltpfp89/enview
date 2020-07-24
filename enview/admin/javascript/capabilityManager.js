
var aCapabilityManager = null;
CapabilityManager = function()
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	this.m_validator = new enview.util.Validator();
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = portalPage.getContextPath();
	this.m_selectRowIndex = 0;
	if( portalPage == null) portalPage = new enview.portal.Page();
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
}
CapabilityManager.prototype =
{
	m_ajax : null,
	m_checkBox : null,
	m_validator : null,
	m_utility : null,
	m_contextPath : null,
	m_selectRowIndex : 0,
	m_dataStructure : null,

	
	init : function() { 
		
		this.m_dataStructure = [
			{"fieldName":"capabilityId", "validation":""}
			,{"fieldName":"capability", "validation":""}
			
		]
		
		$(function() {
			$("#CapabilityManager_propertyTabs").tabs();
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
	getCapabilityChooser : function () {
		if( aCapabilityChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/capability/listForChooser.admin", "", false, {
				success: function(data){
					//alert(data);
					document.getElementById("CapabilityManager_CapabilityChooser").innerHTML = data;
					aCapabilityChooser = new CapabilityChooser( aCapabilityManager.setCapabilityChooserCallback );
				}});
		}
		return aCapabilityChooser;
	},
	setCapabilityChooserCallback : function (rowArray) {
		var chooseVal = "";
		for(var i=0; i<rowArray.length; i++) {
		
			chooseVal += rowArray[i].get("capabilityId") + ":";
		
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
		var formElem = document.forms[ "CapabilityManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "";
		var formElem = document.forms[ "CapabilityManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/capability/listForAjax.admin", param, false, {success: function(data) { aCapabilityManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"CapabilityManager",
			new Array('capabilityId'),
			new Array(),
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
		var formElem = document.forms[ "CapabilityManager_SearchForm" ];
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
		document.getElementById('CapabilityManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "";
	
		param += "capabilityId=";
		param += document.getElementById('CapabilityManager[' + this.m_selectRowIndex + '].capabilityId').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/capability/detailForAjax.admin", param, false, {success: function(data) { aCapabilityManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("CapabilityManager_ListForm") );
	    document.getElementById('CapabilityManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "";
	
		param += "capabilityId=";
		param += document.getElementById('CapabilityManager[' + rowSeq + '].capabilityId').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/capability/detailForAjax.admin", param, false, {success: function(data) { aCapabilityManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "CapabilityManager", resultObject);
		
	
		
		
		var propertyTabs = $("#CapabilityManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("CapabilityManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "CapabilityManager");
		
		var propertyTabs = $("#CapabilityManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	
		document.getElementById("CapabilityManager_capabilityId").readOnly = true;
		document.getElementById("CapabilityManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var param = "";
		var isCreate = document.getElementById("CapabilityManager_isCreate").value;
		var form = document.getElementById("CapabilityManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/capability/addForAjax.admin", param, false, {
				success: function(data){
					if( forDetail == null || forDetail == false ) {
						aCapabilityManager.doRetrieve();
					}
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/capability/updateForAjax.admin", param, false, {
				success: function(data){
					if( forDetail == null || forDetail == false ) {
						aCapabilityManager.doRetrieve();
					}
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("CapabilityManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "";
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('CapabilityManager[' + rowCntArray[i] + '].capabilityId').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/capability/removeForAjax.admin", param, false, {
				success: function(data){
					aCapabilityManager.m_selectRowIndex = 0;
					aCapabilityManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	}
	
}

var aCapabilityChooser = null;
CapabilityChooser = function(callback, parent)
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	if( portalPage == null) portalPage = new enview.portal.Page();
	this.m_selectRowIndex = 0;
	this.m_contextPath = portalPage.getContextPath();
	this.m_domElement = document.getElementById("CapabilityManager_CapabilityChooser");
	this.m_callback = callback;
	this.m_parent = parent;
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
	
	$("#CapabilityManager_CapabilityChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:540, 
		height:400,
		modal: true,
		buttons: {
			"Apply": function() {
				aCapabilityChooser.doApply();
			},
			Cancel: function() {
				$(this).dialog('close');
			}
		}
	});
	
	this.init();
}

CapabilityChooser.prototype =
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
		$('#CapabilityManager_CapabilityChooser').dialog('open');
	},
	doRetrieve : function () {
		var param = "";
		var formElem = document.forms[ "CapabilityChooser_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/capability/listForAjax.admin", param, false, {success: function(data) { aCapabilityChooser.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		this.m_utility.setListData(
			"CapabilityChooser",
			new Array('capabilityId'),
			new Array(),
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
		var formElem = document.forms[ "CapabilityChooser_SearchForm" ];
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
			this.m_checkBox.unChkAll( document.getElementById("CapabilityManager_ListForm") );
			document.getElementById('CapabilityChooser[' + rowSeq + '].checkRow').checked = true;
			this.m_parent.doApply();
			return;
		}
		
		$('#CapabilityManager_CapabilityChooser').dialog('close');
		
		if( this.m_sourceElement != null ) {
			
			this.m_sourceElement.value = document.getElementById('CapabilityChooser[' + rowSeq + '].capabilityId').value;	
		}
		else {
			var result = new Array(1);
			var rowMap = new Map();
			
			rowMap.put("capabilityId", document.getElementById('CapabilityChooser[' + rowSeq + '].capabilityId').value);	
			result[0] = rowMap;
			
			this.m_callback(result);
		}
	},
	getSelectedItems : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("CapabilityChooser_ListForm") );
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
			
				rowMap.put("id", document.getElementById('CapabilityChooser[' + rowCntArray[i] + '].id').value);	
				result[i] = rowMap;
			}
			
			return result;
		}
		
		return null;
	},
	doApply : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("CapabilityChooser_ListForm") );
		if( rowCnts == "" ) return;
		
		var rowCntArray = rowCnts.split(",");
		if( rowCntArray.length > 0 ) {
			if( rowCntArray.length > 1 ) {
				alert( portalPage.getMessageResource('ev.info.select.onlyone') );
				return;
			}
			
			$('#CapabilityManager_CapabilityChooser').dialog('close');
			
			if( this.m_sourceElement != null ) {
				
				this.m_sourceElement.value = document.getElementById('CapabilityChooser[' + rowCntArray[0] + '].capabilityId').value;	
			}
			else {
				var result = new Array(rowCntArray.length);
				for(var i=0; i<rowCntArray.length; i++) {
					var rowMap = new Map();
				
					rowMap.put("capabilityId", document.getElementById('CapabilityChooser[' + rowCntArray[i] + '].capabilityId').value);	
					result[i] = rowMap;
				}
				
				this.m_callback(result);
			}
		}
	}
}

