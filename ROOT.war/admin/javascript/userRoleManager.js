
var aUserRoleManager = null;
UserRoleManager = function(evSecurityCode)
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
UserRoleManager.prototype =
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
			{"fieldName":"roleId", "validation":""}
			,{"fieldName":"userId", "validation":""}
			,{"fieldName":"shortPath", "validation":""}
			,{"fieldName":"principalName0", "validation":""}
			,{"fieldName":"mileageTag", "validation":""}
			,{"fieldName":"sortOrder", "validation":"MaxLength,Short", "maxLength":"10"}
		]
		
		$(function() {
			$("#UserRoleManager_propertyTabs").tabs();
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
	getRoleChooser : function () {
		var domainId = $('#UserManager_domainId').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId;
//		if( aRoleChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/role/listForChooser.admin", param, false, {
				success: function(data){
					document.getElementById("RoleManager_RoleChooser").innerHTML = data;
					aRoleChooser = new RoleChooser( aUserRoleManager.m_evSecurityCode, domainId );
				}});
//		}
		return aRoleChooser;
	},
	setRoleChooserCallback : function (rowArray) {
		var domainId = $('#UserManager_domainId').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		param += "&domainId=" + domainId + "&userId=" + document.getElementById("UserManager_principalId").value;
		for(var i=0; i<rowArray.length; i++) {
			param += "&pks=";
			param += document.getElementById("UserManager_principalId").value + ":" + rowArray[i].get("principalId");
		}
		//alert("param" + param);
		this.m_ajax.send("POST", this.m_contextPath + "/user/userRole/addForAjax.admin", param, false, {
				success: function(data){
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
					aUserRoleManager.doRetrieve();
				}});
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
		var formElem = document.forms[ "UserRoleManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "UserRoleManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/user/userRole/listForAjax.admin", param, false, {success: function(data) { aUserRoleManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"UserRoleManager",
			new Array('userId', 'roleId'),
			new Array('shortPath', 'principalName0'),
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
		var formElem = document.forms[ "UserRoleManager_SearchForm" ];
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
		document.getElementById('UserRoleManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "userId=";
		param += document.getElementById('UserRoleManager[' + this.m_selectRowIndex + '].userId').value;
		param += "&roleId=";
		param += document.getElementById('UserRoleManager[' + this.m_selectRowIndex + '].roleId').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/user/userRole/detailForAjax.admin", param, false, {success: function(data) { aUserRoleManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("UserRoleManager_ListForm") );
	    document.getElementById('UserRoleManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "userId=";
		param += document.getElementById('UserRoleManager[' + rowSeq + '].userId').value;
		param += "&roleId=";
		param += document.getElementById('UserRoleManager[' + rowSeq + '].roleId').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/user/userRole/detailForAjax.admin", param, false, {success: function(data) { aUserRoleManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "UserRoleManager", resultObject);
		
	
		
		
		var propertyTabs = $("#UserRoleManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("UserRoleManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "UserRoleManager");
		
		var propertyTabs = $("#UserRoleManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	 
		document.getElementById("UserRoleManager_userId").value = document.getElementById("UserRoleManager_Master_userId").value; 
		document.getElementById("UserRoleManager_userId").readOnly = false;
		document.getElementById("UserRoleManager_roleId").readOnly = false;
		document.getElementById("UserRoleManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("UserRoleManager_isCreate").value;
		var form = document.getElementById("UserRoleManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var domainId = $('#UserManager_domainId').val();
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";
		param += "&domainId=" + domainId;
		
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/user/userRole/addForAjax.admin", param, false, {
				success: function(data){
					aUserRoleManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/user/userRole/updateForAjax.admin", param, false, {
				success: function(data){
					aUserRoleManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("UserRoleManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
	        var domainId = $('#UserManager_domainId').val();
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
			param += "&domainId=" + domainId + "&userId=" + document.getElementById("UserManager_principalId").value;
			
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('UserRoleManager[' + rowCntArray[i] + '].userId').value + ":" +
					document.getElementById('UserRoleManager[' + rowCntArray[i] + '].roleId').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/user/userRole/removeForAjax.admin", param, false, {
				success: function(data){
					aUserRoleManager.initSearch();
					aUserRoleManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	}
	
}

