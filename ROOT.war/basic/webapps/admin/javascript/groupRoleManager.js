
var aGroupRoleManager = null;
GroupRoleManager = function(evSecurityCode)
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
GroupRoleManager.prototype =
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
			,{"fieldName":"groupId", "validation":""}
			,{"fieldName":"shortPath", "validation":""}
			,{"fieldName":"principalName0", "validation":""}
			
		]
		
		$(function() {
			$("#GroupRoleManager_propertyTabs").tabs();
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
		var domainId = $('#GroupManager_Master_domainId').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId;
		param += "&byGroup=Y&existsGroup=N";
		param += "&groupId=" + $('#GroupRoleManager_Master_groupId').val();
		//if( aRoleChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/role/listForChooser.admin", param, false, {
				success: function(data){
					document.getElementById("RoleManager_RoleChooser").innerHTML = data;
					param = "&domainId=" + domainId;
					param += "&byGroup=Y&existsGroup=N";
					param += "&groupId=" + $('#GroupRoleManager_Master_groupId').val();
					aRoleChooser = new RoleChooser( aGroupRoleManager.m_evSecurityCode, domainId );
				}});
		//}
		return aRoleChooser;
	},
	setRoleChooserCallback : function (rowArray) {
		var domainId = $('#GroupManager_Master_domainId').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId;
		param += "&groupId=" + document.getElementById("GroupManager_principalId").value;
		for(var i=0; i<rowArray.length; i++) {
			param += "&pks=";
			param += document.getElementById("GroupManager_principalId").value + ":" + rowArray[i].get("principalId");
		}
		this.m_ajax.send("POST", this.m_contextPath + "/group/groupRole/addForAjax.admin", param, false, {
				success: function(data){
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
					aGroupRoleManager.doRetrieve();
				}});
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
		var formElem = document.forms[ "GroupRoleManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + $('#GroupManager_Master_domainId').val() + "&";
		var formElem = document.forms[ "GroupRoleManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/group/groupRole/listForAjax.admin", param, false, {success: function(data) { aGroupRoleManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"GroupRoleManager",
			new Array('groupId', 'roleId'),
			new Array('shortPath', 'principalName0'),
			this.m_contextPath,
			resultObject);
				
		if(resultObject.Data.length != 0) {
			this.doDefaultSelect(); 
		}
		if($('#isAdmin').val() == 'true' || $('#GroupManager_Master_domainId').val() != 0){
			 if($('#GroupManager_principalId').val() != 100) $('.GroupRoleManager_EditFormButtons').css('display', 'block');
			 else $('.GroupRoleManager_EditFormButtons').css('display', 'none');
		}else {
			$('.GroupRoleManager_EditFormButtons').css('display', 'none');
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
		var formElem = document.forms[ "GroupRoleManager_SearchForm" ];
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
		document.getElementById('GroupRoleManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "groupId=";
		param += document.getElementById('GroupRoleManager[' + this.m_selectRowIndex + '].groupId').value;
		param += "&roleId=";
		param += document.getElementById('GroupRoleManager[' + this.m_selectRowIndex + '].roleId').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/group/groupRole/detailForAjax.admin", param, false, {success: function(data) { aGroupRoleManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("GroupRoleManager_ListForm") );
	    document.getElementById('GroupRoleManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "groupId=";
		param += document.getElementById('GroupRoleManager[' + rowSeq + '].groupId').value;
		param += "&roleId=";
		param += document.getElementById('GroupRoleManager[' + rowSeq + '].roleId').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/group/groupRole/detailForAjax.admin", param, false, {success: function(data) { aGroupRoleManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "GroupRoleManager", resultObject);
		
	
		
		
		var propertyTabs = $("#GroupRoleManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("GroupRoleManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "GroupRoleManager");
		
		var propertyTabs = $("#GroupRoleManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	 
		document.getElementById("GroupRoleManager_groupId").value = document.getElementById("GroupRoleManager_Master_groupId").value; 
		document.getElementById("GroupRoleManager_groupId").readOnly = false;
		document.getElementById("GroupRoleManager_roleId").readOnly = false;
		document.getElementById("GroupRoleManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("GroupRoleManager_isCreate").value;
		var form = document.getElementById("GroupRoleManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var domainId = $('#GroupManager_Master_domainId').val();
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId;
		
		if( isCreate == "true" ) {
			param += "&groupId=" + document.getElementById("GroupManager_principalId").value;
			this.m_ajax.send("POST", this.m_contextPath + "/group/groupRole/addForAjax.admin", param, false, {
				success: function(data){
					aGroupRoleManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/group/groupRole/updateForAjax.admin", param, false, {
				success: function(data){
					aGroupRoleManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("GroupRoleManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
	        var domainId = $('#GroupManager_Master_domainId').val();
			var param = "evSecurityCode=" + this.m_evSecurityCode;
			param += "&domainId=" + domainId;
			param += "&groupId=" + document.getElementById("GroupManager_principalId").value;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('GroupRoleManager[' + rowCntArray[i] + '].groupId').value + ":" +
					document.getElementById('GroupRoleManager[' + rowCntArray[i] + '].roleId').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/group/groupRole/removeForAjax.admin", param, false, {
				success: function(data){
					aGroupRoleManager.initSearch();
					aGroupRoleManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	}
	
}
