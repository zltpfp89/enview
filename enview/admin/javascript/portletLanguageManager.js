
var aPortletLanguageManager = null;
PortletLanguageManager = function(evSecurityCode)
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
PortletLanguageManager.prototype =
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
			{"fieldName":"id", "validation":""}
			,{"fieldName":"portletId", "validation":""}
			,{"fieldName":"title", "validation":""}
			,{"fieldName":"shortTitle", "validation":""}
			,{"fieldName":"localeString", "validation":""}
			,{"fieldName":"keywords", "validation":""}
			
		]
		
		$(function() {
			$("#PortletLanguageManager_propertyTabs").tabs();
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
		var formElem = document.forms[ "PortletLanguageManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "PortletLanguageManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/portletCategory/portletDefinition/portletLanguage/listForAjax.admin", param, false, {success: function(data) { aPortletLanguageManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"PortletLanguageManager",
			new Array('id'),
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
		var formElem = document.forms[ "PortletLanguageManager_SearchForm" ];
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
		document.getElementById('PortletLanguageManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "id=";
		param += document.getElementById('PortletLanguageManager[' + this.m_selectRowIndex + '].id').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/portletCategory/portletDefinition/portletLanguage/detailForAjax.admin", param, false, {success: function(data) { aPortletLanguageManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("PortletLanguageManager_ListForm") );
	    document.getElementById('PortletLanguageManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "id=";
		param += document.getElementById('PortletLanguageManager[' + rowSeq + '].id').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/portletCategory/portletDefinition/portletLanguage/detailForAjax.admin", param, false, {success: function(data) { aPortletLanguageManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "PortletLanguageManager", resultObject);
		
	
		document.getElementById("PortletLanguageManager_id").readOnly = true;
		
		
		var propertyTabs = $("#PortletLanguageManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("PortletLanguageManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "PortletLanguageManager");
		
		var propertyTabs = $("#PortletLanguageManager_propertyTabs").tabs();
		propertyTabs.tabs('select', 0);
	 
		document.getElementById("PortletLanguageManager_portletId").value = document.getElementById("PortletLanguageManager_Master_portletId").value; 
		document.getElementById("PortletLanguageManager_id").readOnly = true;
		document.getElementById("PortletLanguageManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var param = "";
		var isCreate = document.getElementById("PortletLanguageManager_isCreate").value;
		var form = document.getElementById("PortletLanguageManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/portletCategory/portletDefinition/portletLanguage/addForAjax.admin", param, false, {
				success: function(data){
					aPortletLanguageManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('pt.ev.message.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/portletCategory/portletDefinition/portletLanguage/updateForAjax.admin", param, false, {
				success: function(data){
					aPortletLanguageManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('pt.ev.message.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PortletLanguageManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('pt.ev.message.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&portletId=" + document.getElementById('PortletLanguageManager_portletId').value;
				param += "&pks=";
				param += 
					document.getElementById('PortletLanguageManager[' + rowCntArray[i] + '].id').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/portletCategory/portletDefinition/portletLanguage/removeForAjax.admin", param, false, {
				success: function(data){
					aPortletLanguageManager.initSearch();
					aPortletLanguageManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('pt.ev.message.success.remove') );
				}});
			
		}
	}
	
}
