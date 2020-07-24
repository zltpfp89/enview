
var aSyncManager = null;
SyncManager = function(evSecurityCode)
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
SyncManager.prototype =
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
			{"fieldName":"connect", "validation":""}
			,{"fieldName":"address", "validation":""}
			,{"fieldName":"sessionCount", "validation":""}
			//,{"fieldName":"target", "validation":""}
		]
		
		$(function() {
			$("#SyncManager_propertyTabs").tabs();
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
		var formElem = document.forms[ "SyncManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "SyncManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/sync/listForAjax.admin", param, false, {success: function(data) { aSyncManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"SyncManager",
			new Array('address'),
			new Array('connect', 'address', 'sessionCount'),
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
		var formElem = document.forms[ "SyncManager_SearchForm" ];
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
		document.getElementById('SyncManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "address=";
		param += document.getElementById('SyncManager[' + this.m_selectRowIndex + '].address').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/sync/detailForAjax.admin", param, false, {success: function(data) { aSyncManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("SyncManager_ListForm") );
	    document.getElementById('SyncManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "address=";
		param += document.getElementById('SyncManager[' + rowSeq + '].address').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/sync/detailForAjax.admin", param, false, {success: function(data) { aSyncManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "SyncManager", resultObject);
	
		document.getElementById("SyncManager_connect").readOnly = true;
		document.getElementById("SyncManager_address").readOnly = true;
		document.getElementById("SyncManager_sessionCount").readOnly = true;
		
		
		var propertyTabs = $("#SyncManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("SyncManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "SyncManager");
		
		var propertyTabs = $("#SyncManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	
		document.getElementById("SyncManager_address").readOnly = false;
		document.getElementById("SyncManager_EditFormPanel").style.display = '';
	},
	doInvalidateCache : function(obj)
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("SyncManager_ListForm") );
		if( rowCnts == "" ) return;

		var checkedIds = rowCnts.split(",");
		var clusterIps = "";
		for(var idx=0; idx<checkedIds.length; idx++) {
			if( checkedIds[idx] != "" ) {
				clusterIps += document.getElementById("SyncManager[" + checkedIds[idx] + "].address").value + ";";
			}
		}
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&clusterIps=" + clusterIps;
		var actionMask = 0;
		
		if( document.getElementById( "SyncManager_page" ).checked == true ) {
			actionMask |= 1;
		}
		if( document.getElementById( "SyncManager_portlet" ).checked == true ) {
			actionMask |= 2;
		}
		if( document.getElementById( "SyncManager_notice" ).checked == true ) {
			actionMask |= 4;
		}
		//if( document.getElementById( "SyncManager_renderer" ).checked == true ) {
		//	actionMask |= 8;
		//}
		if( document.getElementById( "SyncManager_decorator" ).checked == true ) {
			actionMask |= 16;
		}
		if( document.getElementById( "SyncManager_codebase" ).checked == true ) {
			actionMask |= 32;
		}
		if( document.getElementById( "SyncManager_language" ).checked == true ) {
			actionMask |= 64;
		}
		if( document.getElementById( "SyncManager_accesspolicy" ).checked == true ) {
			actionMask |= 128;
		}
//		if( document.getElementById( "SyncManager_thememapping" ).checked == true ) {
//			actionMask |= 256;
//		}
		if( document.getElementById( "SyncManager_enboard" ).checked == true ) {
			actionMask |= 512;
		}
		if( document.getElementById( "SyncManager_encola" ).checked == true ) {
			actionMask |= 1024;
		}
		if( document.getElementById( "SyncManager_configuration" ).checked == true ) {
			actionMask |= 2048;
		}
		if( document.getElementById( "SyncManager_scheduler" ).checked == true ) {
			actionMask |= 4096;
		}
		if( document.getElementById( "SyncManager_permission" ).checked == true ) {
			actionMask |= 8192;
		}
		if( document.getElementById( "SyncManager_domain" ).checked == true ) {
			actionMask |= 16382;
		}
		if( document.getElementById( "SyncManager_portletService" ).checked == true ) {
			actionMask |= 32764;
		}
		
		param += "&actionMask=" + actionMask;
		
		this.m_ajax.send("POST", this.m_contextPath + "/sync/invalidateForAjax.admin", param, false, {
				success: function(data){
					//aSyncManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
	}
}

