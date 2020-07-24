
var aBatchResultManager = null;
BatchResultManager = function(evSecurityCode)
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
BatchResultManager.prototype =
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
			{"fieldName":"resultId", "validation":""}
			,{"fieldName":"scheduleId", "validation":""}
			,{"fieldName":"actionId", "validation":""}
			,{"fieldName":"actionName0", "validation":""}
			,{"fieldName":"parameter", "validation":"MaxLength", "maxLength":"250"}
			,{"fieldName":"status", "validation":""}
			,{"fieldName":"errorInfo", "validation":""}
			,{"fieldName":"executStart", "validation":""}
			,{"fieldName":"executEnd", "validation":""}
			,{"fieldName":"updUserId", "validation":""}
			,{"fieldName":"updDatim", "validation":""}
			
		]
		
		$(function() {
			$("#BatchResultManager_propertyTabs").tabs();
		});
		
		$.datepicker.setDefaults({
			showMonthAfterYear: true,
			changeMonth: true,
			changeYear: true,
			showButtonPanel: true,
			showAnim : 'slideDown',
			dateFormat : 'yy-mm-dd'
		});
		
		$('#BatchResultManager_executStartCond').datepicker();	
		$('#BatchResultManager_executEndCond').datepicker();	
		
		var now = new Date().format("yyyy-MM-dd");
		
		document.getElementById("BatchResultManager_executStartCond").value = now;
		document.getElementById("BatchResultManager_executEndCond").value = now;
		
		this.doRetrieve();
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
		var formElem = document.forms[ "BatchResultManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "BatchResultManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/batchResult/listForAjax.admin", param, false, {success: function(data) { aBatchResultManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"BatchResultManager",
			new Array('resultId'),
			new Array('resultId', 'actionName0', 'status', 'executStart', 'executEnd', 'updUserId', 'updDatim'),
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
		var formElem = document.forms[ "BatchResultManager_SearchForm" ];
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
		if( document.getElementById('BatchResultManager[' + this.m_selectRowIndex + '].checkRow') ) {
			document.getElementById('BatchResultManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
			
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		
			param += "resultId=";
			param += document.getElementById('BatchResultManager[' + this.m_selectRowIndex + '].resultId').value;
			
			this.m_ajax.send("POST", this.m_contextPath + "/batchResult/detailForAjax.admin", param, false, {success: function(data) { aBatchResultManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("BatchResultManager_ListForm") );
	    document.getElementById('BatchResultManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "resultId=";
		param += document.getElementById('BatchResultManager[' + rowSeq + '].resultId').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/batchResult/detailForAjax.admin", param, false, {success: function(data) { aBatchResultManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "BatchResultManager", resultObject);
		
		document.getElementById("BatchResultManager_resultId").readOnly = true;
		document.getElementById("BatchResultManager_scheduleId").readOnly = true;
		document.getElementById("BatchResultManager_actionId").readOnly = true;
		
		
		var propertyTabs = $("#BatchResultManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("BatchResultManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "BatchResultManager");
		
		var propertyTabs = $("#BatchResultManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	
		document.getElementById("BatchResultManager_resultId").readOnly = true;
		document.getElementById("BatchResultManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("BatchResultManager_isCreate").value;
		var form = document.getElementById("BatchResultManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode;
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/batchResult/addForAjax.admin", param, false, {
				success: function(data){
					if( forDetail == null || forDetail == false ) {
						aBatchResultManager.doRetrieve();
					}
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/batchResult/updateForAjax.admin", param, false, {
				success: function(data){
					if( forDetail == null || forDetail == false ) {
						aBatchResultManager.doRetrieve();
					}
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("BatchResultManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('BatchResultManager[' + rowCntArray[i] + '].resultId').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/batchResult/removeForAjax.admin", param, false, {
				success: function(data){
					aBatchResultManager.m_selectRowIndex = 0;
					aBatchResultManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	}
	
}
