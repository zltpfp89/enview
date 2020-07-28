var aUserGroupManager = null;
UserGroupManager = function(evSecurityCode)
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
UserGroupManager.prototype =
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
			{"fieldName":"groupId", "validation":""}
			,{"fieldName":"userId", "validation":""}
			,{"fieldName":"shortPath", "validation":""}
			,{"fieldName":"principalName0", "validation":""}
			,{"fieldName":"mileageTag", "validation":""}
			,{"fieldName":"sortOrder", "validation":"MaxLength,Short", "maxLength":"10"}
			,{"fieldName":"domain", "validation":""}
			,{"fieldName":"empNo", "validation":""}
			,{"fieldName":"orgCd", "validation":""}
		]
		
		$(function() {
			$("#UserGroupManager_propertyTabs").tabs();
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
	getGroupChooser : function () {
		var domainId = $('#UserGroupManager_Master_domainId').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId + "&";
//		if( aGroupChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/group/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("GroupManager_GroupChooser").innerHTML = data;
					aGroupChooser = new GroupChooser( aUserGroupManager.m_evSecurityCode, domainId);
				}});
//		}
		return aGroupChooser;
	},
	setGroupChooserCallback : function (rowArray) {
		var domainId = $('#UserGroupManager_Master_domainId').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		param += "&domainId=" + domainId + "&userId=" + document.getElementById("UserManager_principalId").value;
		for(var i=0; i<rowArray.length; i++) {
			param += "&pks=";
			param += document.getElementById("UserManager_principalId").value + ":" + rowArray[i].get("principalId");
		}
		//alert("param" + param);
		this.m_ajax.send("POST", this.m_contextPath + "/user/userGroup/addForAjax.admin", param, false, {
				success: function(data){
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
					aUserGroupManager.doRetrieve();
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
		var formElem = document.forms[ "UserGroupManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "UserGroupManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/user/userGroup/listForAjax.admin", param, false, {success: function(data) { aUserGroupManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"UserGroupManager",
			new Array('domainId','userId', 'groupId'),
			new Array('domain','shortPath', 'principalName0'),
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
		var formElem = document.forms[ "UserGroupManager_SearchForm" ];
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
		document.getElementById('UserGroupManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "userId=";
		param += document.getElementById('UserGroupManager[' + this.m_selectRowIndex + '].userId').value;
		param += "&groupId=";
		param += document.getElementById('UserGroupManager[' + this.m_selectRowIndex + '].groupId').value;

		
		this.m_ajax.send("POST", this.m_contextPath + "/user/userGroup/detailForAjax.admin", param, false, {success: function(data) { aUserGroupManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("UserGroupManager_ListForm") );
	    document.getElementById('UserGroupManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "userId=";
		param += document.getElementById('UserGroupManager[' + rowSeq + '].userId').value;
		param += "&groupId=";
		param += document.getElementById('UserGroupManager[' + rowSeq + '].groupId').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/user/userGroup/detailForAjax.admin", param, false, {success: function(data) { aUserGroupManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "UserGroupManager", resultObject);
		
	
		
		
		var propertyTabs = $("#UserGroupManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("UserGroupManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "UserGroupManager");
		
		var propertyTabs = $("#UserGroupManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	 
		document.getElementById("UserGroupManager_userId").value = document.getElementById("UserGroupManager_Master_userId").value; 
		document.getElementById("UserGroupManager_userId").readOnly = false;
		document.getElementById("UserGroupManager_groupId").readOnly = false;
		document.getElementById("UserGroupManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("UserGroupManager_isCreate").value;
		var form = document.getElementById("UserGroupManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/user/userGroup/addForAjax.admin", param, false, {
				success: function(data){
					aUserGroupManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/user/userGroup/updateForAjax.admin", param, false, {
				success: function(data){
					aUserGroupManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("UserGroupManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
	        var domainId = $('#UserGroupManager_Master_domainId').val();
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
			param += "&domainId=" + domainId + "&userId=" + document.getElementById("UserManager_principalId").value;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('UserGroupManager[' + rowCntArray[i] + '].userId').value + ":" +
					document.getElementById('UserGroupManager[' + rowCntArray[i] + '].groupId').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/user/userGroup/removeForAjax.admin", param, false, {
				success: function(data){
					aUserGroupManager.initSearch();
					aUserGroupManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	},
	doMoveUp : function () {
		var param = "userId=" + document.getElementById("UserGroupManager_userId").value;
		param += "&groupId=" + document.getElementById("UserGroupManager_groupId").value;
		param += "&toDown=false";
	
		this.m_ajax.send("POST", this.m_contextPath + "/user/userGroup/changeOrderForAjax.admin", param, false, {
			success: function(data){
				aUserGroupManager.doRetrieve();
				enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
			}});
	},
	doMoveDown : function () {
		var param = "userId=" + document.getElementById("UserGroupManager_userId").value;
		param += "&groupId=" + document.getElementById("UserGroupManager_groupId").value;
		param += "&toDown=true";
	
		this.m_ajax.send("POST", this.m_contextPath + "/user/userGroup/changeOrderForAjax.admin", param, false, {
			success: function(data){
				aUserGroupManager.doRetrieve();
				enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
			}});
	},
	doInputNumCheck : function () {
		var objEv = event.srcElement;
		var numPattern = /([^0-9])/;
		var numPattern = objEv.value.match(numPattern);
		if (numPattern != null) {
			alert("숫자만 입력하세요");
			objEv.value = "";
			objEv.focus();
			return false;
		}
	},
/*	doCodeBaseChooser : function () {
		var param = "systemCode=PT";
		param += "&domainId=1";
		param += "&codeId=200";
		param += "&code=0000000000";
		param += "&langKnd=ko";
		param += "&codeIdCond=200";
		param += "&domainIdCond=1";
		param += "&userGroupReq=Yes";
		
		this.m_ajax.send("POST", this.m_contextPath + "/codebase/listForChooser.admin", param, false, {
			success: function(data){
				document.getElementById("CodeBaseManager_CodeBaseChooser").innerHTML = data;
				// aCodeBaseChooser = new aCodeBaseChooser.CodeBaseChooser(aUserGroupManager.m_evSecurityCode, domainId);
				aUserGroupManager.doOrgCdDialLog();
			}
		});
	}, doOrgCdDialLog : function () {
		$("#CodeBaseManager_CodeBaseChooser").dialog({
			autoOpen: true,
			resizable: false,
			modal: true,
			width: 700,
			buttons: {
				"Apply": function() {
				},
				Cancel: function() {
					$(this).dialog('close');
				}
		}
		});
	}*/
}
