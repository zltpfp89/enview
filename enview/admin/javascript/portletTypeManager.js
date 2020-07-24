
var aPortletTypeManager = null;
PortletTypeManager = function(evSecurityCode)
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
PortletTypeManager.prototype =
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
			{"fieldName":"contentType", "validation":"Required"}
			,{"fieldName":"modes", "validation":"Required"}
			
		]
		
		$(function() {
			$("#PortletTypeManager_propertyTabs").tabs();
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
	
	onSelectPropertyTab : function (id) {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		switch(id) {
			case 0 : 
				break;
		
		}
		
		return true; 
	},
	initSearch : function () {
		var formElem = document.forms[ "PortletTypeManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "PortletTypeManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/portletDefinition/portletType/listForAjax.admin", param, false, {success: function(data) { aPortletTypeManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"PortletTypeManager",
			new Array('contentType'),
			new Array('contentType', 'modes'),
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
		var formElem = document.forms[ "PortletTypeManager_SearchForm" ];
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
		document.getElementById('PortletTypeManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		param += "applicationName=" + document.getElementById("PortletTypeManager_applicationName").value;
		param += "&portletName=" + document.getElementById("PortletTypeManager_portletName").value;
		param += "&contentType=";
		param += document.getElementById('PortletTypeManager[' + this.m_selectRowIndex + '].contentType').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/portletDefinition/portletType/detailForAjax.admin", param, false, {success: function(data) { aPortletTypeManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("PortletTypeManager_ListForm") );
	    document.getElementById('PortletTypeManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		param += "applicationName=" + document.getElementById("PortletTypeManager_applicationName").value;
		param += "&portletName=" + document.getElementById("PortletTypeManager_portletName").value;
		param += "&contentType=";
		param += document.getElementById('PortletTypeManager[' + rowSeq + '].contentType').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/portletDefinition/portletType/detailForAjax.admin", param, false, {success: function(data) { aPortletTypeManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "PortletTypeManager", resultObject);
		
		document.getElementById("PortletTypeManager_contentType").readOnly = true;
		
		var propertyTabs = $("#PortletTypeManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("PortletTypeManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "PortletTypeManager");
		document.getElementById("PortletTypeManager_contentType").readOnly = false;
		
		var propertyTabs = $("#PortletTypeManager_propertyTabs").tabs();
		propertyTabs.tabs('select', 0);
	 
		document.getElementById("PortletTypeManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("PortletTypeManager_isCreate").value;
		var form = document.getElementById("PortletTypeManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";
		param += "applicationName=" + document.getElementById("PortletTypeManager_applicationName").value;
		param += "&portletName=" + document.getElementById("PortletTypeManager_portletName").value;
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/portletDefinition/portletType/addForAjax.admin", param, false, {
				success: function(data){
					aPortletTypeManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/portletDefinition/portletType/updateForAjax.admin", param, false, {
				success: function(data){
					aPortletTypeManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PortletTypeManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById("PortletTypeManager_applicationName").value + ":" +
					document.getElementById("PortletTypeManager_portletName").value + ":" +
					document.getElementById('PortletTypeManager[' + rowCntArray[i] + '].contentType').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/portletDefinition/portletType/removeForAjax.admin", param, false, {
				success: function(data){
					aPortletTypeManager.initSearch();
					aPortletTypeManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	}
	
}
