
var aRoleUserManager = null;
RoleUserManager = function(evSecurityCode)
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
RoleUserManager.prototype =
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
			{"fieldName":"userId", "validation":""}
			,{"fieldName":"roleId", "validation":""}
			,{"fieldName":"shortPath", "validation":""}
			,{"fieldName":"principalName0", "validation":""}
			,{"fieldName":"mileageTag", "validation":""}
			
		]
		
		$(function() {
			$("#RoleUserManager_propertyTabs").tabs();
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
	getUserChooser : function () {
		var domainId = $('#RoleManager_Master_domainId').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId;
		var extraParam = "&byDomain=Y&existsDomain=Y";
		extraParam += "&roleId=" + $('#RoleUserManager_Master_roleId').val() + "&byRole=Y&existsRole=N&";
//		if( aUserChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/user/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("UserManager_UserChooser").innerHTML = data;
					aUserChooser = new UserChooser( aRoleUserManager.m_evSecurityCode, domainId, extraParam );
				}});
//		}
		return aUserChooser;
	},
	setUserChooserCallback : function (rowArray) {
		var domainId = $('#RoleManager_Master_domainId').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId;
		for(var i=0; i<rowArray.length; i++) {
			param += "&pks=";
			param += rowArray[i].get("principalId") + ":" + document.getElementById("RoleManager_principalId").value;
		}
		//alert("param" + param);
		this.m_ajax.send("POST", this.m_contextPath + "/role/roleUser/addForAjax.admin", param, false, {
				success: function(data){
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
					aRoleUserManager.doRetrieve();
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
		var formElem = document.forms[ "RoleUserManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "RoleUserManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/role/roleUser/listForAjax.admin", param, false, {success: function(data) { aRoleUserManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		this.m_utility.setListData(
			"RoleUserManager",
			new Array('userId', 'roleId'),
			new Array('shortPath', 'principalName0'),
			this.m_contextPath,
			resultObject);
				
		if(resultObject.Data.length != 0) {
			this.doDefaultSelect(); 
		}
		
		if($('#isAdmin').val() == 'true' || $('#RoleManager_Master_domainId').val() != 0){
			 if($('#RoleManager_principalId').val() != 10) $('.RoleManager_EditFormButtons').css('display', 'block');
			 else $('.RoleManager_EditFormButtons').css('display', 'none');
		}else {
			$('.RoleManager_EditFormButtons').css('display', 'none');
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
		var formElem = document.forms[ "RoleUserManager_SearchForm" ];
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
		document.getElementById('RoleUserManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "userId=";
		param += document.getElementById('RoleUserManager[' + this.m_selectRowIndex + '].userId').value;
		param += "&roleId=";
		param += document.getElementById('RoleUserManager[' + this.m_selectRowIndex + '].roleId').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/role/roleUser/detailForAjax.admin", param, false, {success: function(data) { aRoleUserManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("RoleUserManager_ListForm") );
	    document.getElementById('RoleUserManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "userId=";
		param += document.getElementById('RoleUserManager[' + rowSeq + '].userId').value;
		param += "&roleId=";
		param += document.getElementById('RoleUserManager[' + rowSeq + '].roleId').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/role/roleUser/detailForAjax.admin", param, false, {success: function(data) { aRoleUserManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "RoleUserManager", resultObject);
		
	
		
		
		var propertyTabs = $("#RoleUserManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("RoleUserManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "RoleUserManager");
		
		var propertyTabs = $("#RoleUserManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	 
		document.getElementById("RoleUserManager_roleId").value = document.getElementById("RoleUserManager_Master_roleId").value; 
		document.getElementById("RoleUserManager_userId").readOnly = false;
		document.getElementById("RoleUserManager_roleId").readOnly = false;
		document.getElementById("RoleUserManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("RoleUserManager_isCreate").value;
		var form = document.getElementById("RoleUserManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var domainId = $('#RoleManager_Master_domainId').val();
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "&evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId;
		
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/role/roleUser/addForAjax.admin", param, false, {
				success: function(data){
					aRoleUserManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/role/roleUser/updateForAjax.admin", param, false, {
				success: function(data){
					aRoleUserManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("RoleUserManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
	        var domainId = $('#RoleManager_Master_domainId').val();
			var param = "evSecurityCode=" + this.m_evSecurityCode;
			param += "&domainId=" + domainId;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('RoleUserManager[' + rowCntArray[i] + '].userId').value + ":" +
					document.getElementById('RoleUserManager[' + rowCntArray[i] + '].roleId').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/role/roleUser/removeForAjax.admin", param, false, {
				success: function(data){
					aRoleUserManager.initSearch();
					aRoleUserManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	}
	
}

