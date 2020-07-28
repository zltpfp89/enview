
var aPageComponentManager = null;
PageComponentManager = function(evSecurityCode)
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
PageComponentManager.prototype =
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
			{"fieldName":"pageComponentId", "validation":""}
			,{"fieldName":"pageId", "validation":""}
			,{"fieldName":"region", "validation":"Required"}
			,{"fieldName":"elementOrder", "validation":"Short"}
			,{"fieldName":"portletName", "validation":"Required,MaxLength", "maxLength":"50"}
			,{"fieldName":"parameter", "validation":"MaxLength", "maxLength":"120"}
			
		]
		
		$(function() {
			$("#PageComponentManager_propertyTabs").tabs();
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
	getPortletChooser : function () {
		if( portalPortletSelectorPermissionApp == null ) {
			portalPortletSelectorPermissionApp = new enview.portal.PortletSelectorPermissionApp( this.m_evSecurityCode );
			portalPortletSelectorPermissionApp.init();
		}
		return portalPortletSelectorPermissionApp;
	},
	
	setPortletChooserCallback : function (rowArray) {
		document.getElementById("PageComponentManager_portletName").value = rowArray[0].get("path");
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
		var formElem = document.forms[ "PageComponentManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "PageComponentManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/page/pageComponent/listForAjax.admin", param, false, {success: function(data) { aPageComponentManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"PageComponentManager",
			new Array('pageComponentId'),
			new Array('region', 'portletName', 'elementOrder'),
			this.m_contextPath,
			resultObject);
				
		if(resultObject.Data.length != 0) {
			this.doDefaultSelect(); 
		}
		
		if($('#isAdmin').val() == 'true' || $('#PageManager_Master_domainId').val() != 0){
			 if($('#PageManager_Master_pageId').val() != 1) {
				 $('.PageComponentManager_EditFormButtons').css('display', 'inline-block');
				 $('.PageManager_EditFormButtons').css('display', 'block');
			 }
			 else {
				 $('.PageComponentManager_EditFormButtons').css('display', 'none');
				 $('.PageManager_EditFormButtons').css('display', 'none');
			 }
		}
		else {
			$('.PageComponentManager_EditFormButtons').css('display', 'none');
			$('.PageManager_EditFormButtons').css('display', 'none');
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
		var formElem = document.forms[ "PageComponentManager_SearchForm" ];
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
		document.getElementById('PageComponentManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "pageComponentId=";
		param += document.getElementById('PageComponentManager[' + this.m_selectRowIndex + '].pageComponentId').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/page/pageComponent/detailForAjax.admin", param, false, {success: function(data) { aPageComponentManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("PageComponentManager_ListForm") );
	    document.getElementById('PageComponentManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "pageComponentId=";
		param += document.getElementById('PageComponentManager[' + rowSeq + '].pageComponentId').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/page/pageComponent/detailForAjax.admin", param, false, {success: function(data) { aPageComponentManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "PageComponentManager", resultObject);
		
	
		document.getElementById("PageComponentManager_pageComponentId").readOnly = true;
		
		
		var propertyTabs = $("#PageComponentManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("PageComponentManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "PageComponentManager");
		
		var propertyTabs = $("#PageComponentManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	 
		document.getElementById("PageComponentManager_pageId").value = document.getElementById("PageComponentManager_Master_pageId").value; 
		document.getElementById("PageComponentManager_pageComponentId").readOnly = true;
		document.getElementById("PageComponentManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var param = "";
		var isCreate = document.getElementById("PageComponentManager_isCreate").value;
		var form = document.getElementById("PageComponentManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/page/pageComponent/addForAjax.admin", param, false, {
				success: function(data){
					aPageComponentManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/page/pageComponent/updateForAjax.admin", param, false, {
				success: function(data){
					aPageComponentManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PageComponentManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&pageId=" + document.getElementById("PageManager_pageId").value;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('PageComponentManager[' + rowCntArray[i] + '].pageComponentId').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/page/pageComponent/removeForAjax.admin", param, false, {
				success: function(data){
					aPageComponentManager.initSearch();
					aPageComponentManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	}
	
}

