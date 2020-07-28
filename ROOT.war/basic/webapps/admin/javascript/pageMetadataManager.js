
var aPageMetadataManager = null;
PageMetadataManager = function(evSecurityCode)
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
PageMetadataManager.prototype =
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
			{"fieldName":"name", "validation":"Required,MaxLength", "maxLength":"15"}
			,{"fieldName":"metadataId", "validation":""}
			,{"fieldName":"pageId", "validation":""}
			,{"fieldName":"value", "validation":"Required,MaxLength", "maxLength":"100"}
			,{"fieldName":"locale", "validation":""}
			
		]
		
		$(function() {
			$("#PageMetadataManager_propertyTabs").tabs();
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
		var param = "";	
		switch(id) {
			case 0 : 
				break;
		
		}
		
		return true; 
	},
	initSearch : function () {
		var formElem = document.forms[ "PageMetadataManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "PageMetadataManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/page/pageMetadata/listForAjax.admin", param, false, {success: function(data) { aPageMetadataManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"PageMetadataManager",
			new Array('metadataId'),
			new Array('locale', 'name', 'value'),
			this.m_contextPath,
			resultObject);
				
		if(resultObject.Data.length != 0) {
			this.doDefaultSelect(); 
		}
		
		if($('#isAdmin').val() == 'true' || $('#PageManager_Master_domainId').val() != 0){
			 if($('#PageManager_Master_pageId').val() != 1) $('.PageManager_EditFormButtons').css('display', 'block');
			 else $('.PageManager_EditFormButtons').css('display', 'none');
		}
		else $('.PageManager_EditFormButtons').css('display', 'none');
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
		var formElem = document.forms[ "PageMetadataManager_SearchForm" ];
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
		document.getElementById('PageMetadataManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "metadataId=";
		param += document.getElementById('PageMetadataManager[' + this.m_selectRowIndex + '].metadataId').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/page/pageMetadata/detailForAjax.admin", param, false, {success: function(data) { aPageMetadataManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("PageMetadataManager_ListForm") );
	    document.getElementById('PageMetadataManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "metadataId=";
		param += document.getElementById('PageMetadataManager[' + rowSeq + '].metadataId').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/page/pageMetadata/detailForAjax.admin", param, false, {success: function(data) { aPageMetadataManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "PageMetadataManager", resultObject);
		
	
		document.getElementById("PageMetadataManager_metadataId").readOnly = true;
		
		
		var propertyTabs = $("#PageMetadataManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("PageMetadataManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "PageMetadataManager");
		
		var propertyTabs = $("#PageMetadataManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	 
		document.getElementById("PageMetadataManager_pageId").value = document.getElementById("PageMetadataManager_Master_pageId").value; 
		document.getElementById("PageMetadataManager_metadataId").readOnly = true;
		document.getElementById("PageMetadataManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("PageMetadataManager_isCreate").value;
		var form = document.getElementById("PageMetadataManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/page/pageMetadata/addForAjax.admin", param, false, {
				success: function(data){
					aPageMetadataManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/page/pageMetadata/updateForAjax.admin", param, false, {
				success: function(data){
					aPageMetadataManager.doRetrieve();
					aPageManager.onRefresh( document.getElementById("PageManager_parentId").value );
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PageMetadataManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&pageId=" + document.getElementById("PageManager_pageId").value;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('PageMetadataManager[' + rowCntArray[i] + '].metadataId').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/page/pageMetadata/removeForAjax.admin", param, false, {
				success: function(data){
					aPageMetadataManager.initSearch();
					aPageMetadataManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	}
	
}
