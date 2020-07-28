
var aPortletApplicationManager = null;
PortletApplicationManager = function(evSecurityCode)
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
PortletApplicationManager.prototype =
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
			{"fieldName":"appName", "validation":""}
			,{"fieldName":"version", "validation":""}
			,{"fieldName":"path", "validation":""}
			,{"fieldName":"running", "validation":""}
			
		]
		
		$(function() {
			$("#PortletApplicationManager_propertyTabs").tabs();
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
		
	},
	initSearch : function () {
		var formElem = document.forms[ "PortletApplicationManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
	},
	doRetrieve : function () {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "PortletApplicationManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/listForAjax.admin", param, false, {success: function(data) { aPortletApplicationManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"PortletApplicationManager",
			new Array('appName', 'appTitle'),
			new Array('title', 'version'),
			this.m_contextPath,
			resultObject);
		
		this.doDefaultSelect(); 		
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
		var formElem = document.forms[ "PortletApplicationManager_SearchForm" ];
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
		this.m_selectRowIndex = 0;
		document.getElementById('PortletApplicationManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		document.getElementById('PortletDefinitionManager_Master_applicationName').value = document.getElementById('PortletApplicationManager[' + this.m_selectRowIndex + '].appName').value;
		document.getElementById('PortletDefinitionManager_Master_applicationTitle').value = document.getElementById('PortletApplicationManager[' + this.m_selectRowIndex + '].appTitle').value;
		aPortletDefinitionManager.doRetrieve(); 
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
		
	    this.m_checkBox.unChkAll( document.getElementById("PortletApplicationManager_ListForm") );
	    document.getElementById('PortletApplicationManager[' + rowSeq + '].checkRow').checked = true;
		document.getElementById('PortletDefinitionManager_Master_applicationName').value = document.getElementById('PortletApplicationManager[' + rowSeq + '].appName').value;
		document.getElementById('PortletDefinitionManager_Master_applicationTitle').value = document.getElementById('PortletApplicationManager[' + rowSeq + '].appTitle').value;
		document.getElementById('PortletDefinitionManager_pageNo').value = 1;
		document.getElementById("PortletDefinitionManager_allCond").checked = false;
		
		aPortletDefinitionManager.m_selectRowIndex = 0;
		aPortletDefinitionManager.doRetrieve(); 
	},
	
	doStart : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PortletApplicationManager_ListForm") );
		if( rowCnts == "" ) return;
		
		var rowCntArray = rowCnts.split(",");
		/*
		if( rowCntArray.length > 1 ) {
			alert( portalPage.getMessageResource('ev.info.choiceOnlyone') );
			return;
		}
		*/
		var formData = "";
		
		var param = "evSecurityCode=" + this.m_evSecurityCode; 
		param += "&appName=" + document.getElementById("PortletApplicationManager[" + rowCntArray[0] + "].appName").value; 
		this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/startForAjax.admin", param, false, {
			success: function(data){
				aPortletApplicationManager.m_selectRowIndex = 0;
				aPortletApplicationManager.doRetrieve();
				enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.successUpdate') );
			}});
	},
	doStop : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PortletApplicationManager_ListForm") );
		if( rowCnts == "" ) return;
		
		var rowCntArray = rowCnts.split(",");
		/*
		if( rowCntArray.length > 1 ) {
			alert( portalPage.getMessageResource('ev.info.choiceOnlyone') );
			return;
		}
		*/
		var ret = confirm( portalPage.getMessageResource('ev.info.stop') );
	    if( ret == true ) {
	        var formData = "";
			
			var param = "evSecurityCode=" + this.m_evSecurityCode; 
			for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += document.getElementById('PortletApplicationManager[' + rowCntArray[i] + '].appName').value;
	        }
			this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/stopForAjax.admin", param, false, {
				success: function(data){
					aPortletApplicationManager.m_selectRowIndex = 0;
					aPortletApplicationManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.successUpdate') );
				}});
			
		}
	},
	doReload : function() {
		var checked = this.m_checkBox.getCheckedElements( document.getElementById("PortletApplicationManager_ListForm") );
		if( checked == "" ) return;
		
		var checkedIds = checked.split(",");
		if( checkedIds.length > 1 ) {
			alert( portalPage.getMessageResource('ev.info.choiceOnlyone') );
			return;
		}
		
		var ret = confirm( portalPage.getMessageResource('ev.info.reload') );
		if( ret == true ) {
			var param = "evSecurityCode=" + this.m_evSecurityCode; 
			for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += document.getElementById('PortletApplicationManager[' + rowCntArray[i] + '].appName').value;
	        }
			this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/reloadForAjax.admin", param, false, {
				success: function(data){
					aPortletApplicationManager.m_selectRowIndex = 0;
					aPortletApplicationManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doWrite : function() {
		var checked = this.m_checkBox.getCheckedElements( document.getElementById("PortletApplicationManager_ListForm") );
		if( checked == "" ) return;
		
		var checkedIds = checked.split(",");
		var id = "";
		if( checkedIds.length > 1 ) {
			alert( portalPage.getMessageResource('ev.info.choiceOnlyone') );
			return;
		}
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&applicationId=" + document.getElementById("PortletApplicationManager[" + checkedIds[0] + "].applicationId").value; 
		param += "&appName=" + document.getElementById("PortletApplicationManager[" + checkedIds[0] + "].appName").value; 
		this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/writeForAjax.admin", param, false, {
			success: function(data){
				aPortletApplicationManager.m_selectRowIndex = 0;
				aPortletApplicationManager.doRetrieve();
				enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
			}});
	}
	
}

