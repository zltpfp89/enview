
var aPrincipalPermissionManager = null;
PrincipalPermissionManager = function(evSecurityCode)
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
PrincipalPermissionManager.prototype =
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
			{"fieldName":"permissionId", "validation":""}
			,{"fieldName":"principalId", "validation":""}
			,{"fieldName":"title", "validation":""}
			,{"fieldName":"resUrl", "validation":"Required,MaxLength", "maxLength":"250"}
			,{"fieldName":"resType", "validation":""}
			,{"fieldName":"actionMask", "validation":""}
			,{"fieldName":"isAllow", "validation":""}
			,{"fieldName":"creationDate", "validation":""}
			,{"fieldName":"modifiedDate", "validation":""}
		]
		
	},
	getUserChooser : function () {
		var domainId = $('#PageManager_Master_domainId').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId;
		var extraParam = '';
		if(domainId == 0){
			extraParam = "byDomain=Y&existsDomain=Y&"; 
		}
//		if( aUserChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/user/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("UserManager_UserChooser").innerHTML = data;
					aUserChooser = new UserChooser( aPrincipalPermissionManager.m_evSecurityCode, domainId, extraParam);
				}});
//		}
		return aUserChooser;
	},
	setUserChooserCallback : function (rowArray) {
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&isPage=" + document.getElementById("PrincipalPermissionManager_Master_isPage").value;
		param += "&principalType=" + document.getElementById("PrincipalPermissionManager_principalType").value;
		param += "&domainId=" + document.getElementById("PrincipalPermissionManager_domainId").value;
		for(var i=0; i<rowArray.length; i++) {
			param += "&updateDatas=";
			param += rowArray[i].get("principalId") + "@" + 
					 encodeURIComponent(document.getElementById("PrincipalPermissionManager_Master_title").value) + "@" + 
					 document.getElementById("PrincipalPermissionManager_Master_resUrl").value + "@" +
					 document.getElementById("PrincipalPermissionManager_Master_resType").value + "@" +
					 "31@" +
					 "true";
		}
		//alert("param" + param);
		this.m_ajax.send("POST", this.m_contextPath + "/principalPermission/addsForAjax.admin", param, false, {
				success: function(data){
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
					aPrincipalPermissionManager.doRetrieve();
				}});
	},
	getGroupChooser : function () {
		if( aGroupChooser == null ) {
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
			this.m_ajax.send("POST", this.m_contextPath + "/group/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("GroupManager_GroupChooser").innerHTML = data;
					aGroupChooser = new GroupChooser( aPrincipalPermissionManager.m_evSecurityCode );
				}});
		}
		return aGroupChooser;
	},
	setGroupChooserCallback : function (rowArray) {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		param += "&isPage=" + document.getElementById("PrincipalPermissionManager_Master_isPage").value;
		param += "&principalType=" + document.getElementById("PrincipalPermissionManager_principalType").value;
		for(var i=0; i<rowArray.length; i++) {
			param += "&updateDatas=";
			param += rowArray[i].get("principalId") + "@" + 
					 encodeURIComponent(document.getElementById("PrincipalPermissionManager_Master_title").value) + "@" + 
					 document.getElementById("PrincipalPermissionManager_Master_resUrl").value + "@" +
					 document.getElementById("PrincipalPermissionManager_Master_resType").value + "@" +
					 "31@" +
					 "true";
		}
		//alert("param" + param);
		this.m_ajax.send("POST", this.m_contextPath + "/principalPermission/addsForAjax.admin", param, false, {
				success: function(data){
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
					aPrincipalPermissionManager.doRetrieve();
				}});
	},
	getRoleChooser : function () {
		var domainId = $('#PageManager_Master_domainId').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId;
//		if( aRoleChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/role/listForChooser.admin", param, false, {
				success: function(data){
					document.getElementById("RoleManager_RoleChooser").innerHTML = data;
					aRoleChooser = new RoleChooser( aPrincipalPermissionManager.m_evSecurityCode, domainId );
				}});
//		}
		return aRoleChooser;
	},
	setRoleChooserCallback : function (rowArray) {
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&isPage=" + document.getElementById("PrincipalPermissionManager_Master_isPage").value;
		param += "&principalType=" + document.getElementById("PrincipalPermissionManager_principalType").value;
		param += "&domainId=" + document.getElementById("PrincipalPermissionManager_domainId").value;
		
		for(var i=0; i<rowArray.length; i++) {
			param += "&updateDatas=";
			param += rowArray[i].get("principalId") + "@" + 
					 encodeURIComponent(document.getElementById("PrincipalPermissionManager_Master_title").value) + "@" + 
					 document.getElementById("PrincipalPermissionManager_Master_resUrl").value + "@" +
					 document.getElementById("PrincipalPermissionManager_Master_resType").value + "@" +
					 "31@" +
					 "true"; 
		}
		//alert("param" + param);
		this.m_ajax.send("POST", this.m_contextPath + "/principalPermission/addsForAjax.admin", param, false, {
				success: function(data){
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
					aPrincipalPermissionManager.doRetrieve();
				}});
	},
	initSearch : function () {
		var formElem = document.forms[ "PrincipalPermissionManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "PrincipalPermissionManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/principalPermission/listForAjax.admin", param, false, {success: function(data) { aPrincipalPermissionManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"PrincipalPermissionManager",
			new Array('permissionId','principalId'),
			new Array('permissionId', 'shortPath', 'principalName'),
			this.m_contextPath,
			resultObject);
				
		if(resultObject.Data.length != 0) {
			this.doDefaultSelect(); 
		}
		if($('#isAdmin').val() == 'true' || $('#PageManager_Master_domainId').val() != 0){
			 if($('#PageManager_Master_pageId').val() != 1) $('.PrincipalPermissionManager_EditFormButtons').css('display', 'block');
			 else $('.PrincipalPermissionManager_EditFormButtons').css('display', 'none');
		}
		else $('.PrincipalPermissionManager_EditFormButtons').css('display', 'none');
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
		var formElem = document.forms[ "PrincipalPermissionManager_SearchForm" ];
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
		document.getElementById('PrincipalPermissionManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "permissionId=";
		param += document.getElementById('PrincipalPermissionManager[' + this.m_selectRowIndex + '].permissionId').value;
		param += "&domainId=" + document.getElementById('PrincipalPermissionManager_domainId').value;
		this.m_ajax.send("POST", this.m_contextPath + "/principalPermission/detailForAjax.admin", param, false, {success: function(data) { aPrincipalPermissionManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("PrincipalPermissionManager_ListForm") );
	    document.getElementById('PrincipalPermissionManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "permissionId=";
		param += document.getElementById('PrincipalPermissionManager[' + rowSeq + '].permissionId').value;
		param += "&domainId=" + document.getElementById('PrincipalPermissionManager_domainId').value;
		this.m_ajax.send("POST", this.m_contextPath + "/principalPermission/detailForAjax.admin", param, false, {success: function(data) { aPrincipalPermissionManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		document.getElementById("PrincipalPermissionManager_permissionId").value = portalPage.getAjax().retrieveElementValue("permissionId", resultObject);
		document.getElementById("PrincipalPermissionManager_principalId").value = portalPage.getAjax().retrieveElementValue("principalId", resultObject);
		document.getElementById("PrincipalPermissionManager_domainId").value = portalPage.getAjax().retrieveElementValue("domainId", resultObject);
		document.getElementById("PrincipalPermissionManager_title").value = portalPage.getAjax().retrieveElementValue("title", resultObject);
		document.getElementById("PrincipalPermissionManager_resType").value = portalPage.getAjax().retrieveElementValue("resType", resultObject);
		document.getElementById("PrincipalPermissionManager_isAllow").checked = (portalPage.getAjax().retrieveElementValue("isAllow", resultObject) == "true") ? true : false;
		document.getElementById("PrincipalPermissionManager_resUrl").value = portalPage.getAjax().retrieveElementValue("resUrl", resultObject);
		document.getElementById("PrincipalPermissionManager_creationDate").value = portalPage.getAjax().retrieveElementValue("creationDate", resultObject);
		document.getElementById("PrincipalPermissionManager_modifiedDate").value = portalPage.getAjax().retrieveElementValue("modifiedDate", resultObject);
		
		var actionMask = portalPage.getAjax().retrieveElementValue("actionMask", resultObject);
		//alert("actionMask=" + actionMask);
		var form = document.getElementById("PrincipalPermissionManager_EditForm");
		for(var j=0; j<form.elements.length; j++) {
			field = form.elements[j];
			//alert(field.type + "," + field.id + "," + field.checked);
			if(field.type == "checkbox" && field.id && field.id.indexOf("PrincipalPermissionManager_authority_") > -1 ) {
				var authValue = field.id.substring(37);
				//alert("authValue=" + authValue);
				if( (actionMask & authValue) == authValue ) {
					//alert("true");
					field.checked = true;
				}
				else {
					//alert("false");
					field.checked = false;
				}
			}
		}
	
		document.getElementById("PrincipalPermissionManager_creationDate").readOnly = true;
		document.getElementById("PrincipalPermissionManager_modifiedDate").readOnly = true;
		
		document.getElementById("PrincipalPermissionManager_isCreate").value = "false";
		document.getElementById("PrincipalPermissionManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "PrincipalPermissionManager");
		
		var form = document.getElementById("PrincipalPermissionManager_EditForm");
		for(var j=0; j<form.elements.length; j++) {
			field = form.elements[j];
			if(field.type == "checkbox" && field.id && field.id.indexOf("PrincipalPermissionManager_authority_") > -1 ) {
				field.checked = false;
			}
		}
		
		document.getElementById("PrincipalPermissionManager_resType").value = 2;
		
		var propertyTabs = $("#PrincipalPermissionManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	 
		document.getElementById("PrincipalPermissionManager_domainId").value = document.getElementById("PrincipalPermissionManager_Master_domainId").value;
		document.getElementById("PrincipalPermissionManager_Master_resUrl").value = document.getElementById("PageManager_path").value; 
		document.getElementById("PrincipalPermissionManager_permissionId").readOnly = false;
		document.getElementById("PrincipalPermissionManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var param = "";
		var isCreate = document.getElementById("PrincipalPermissionManager_isCreate").value;
		var form = document.getElementById("PrincipalPermissionManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		//var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode;
		param += "&permissionId=" + document.getElementById("PrincipalPermissionManager_permissionId").value;
		param += "&principalId=" + document.getElementById("PrincipalPermissionManager_principalId").value;
		param += "&principalType=" + document.getElementById("PrincipalPermissionManager_principalType").value;
		param += "&domainId=" + document.getElementById("PrincipalPermissionManager_domainId").value;
		var resType = document.getElementById("PrincipalPermissionManager_resType").value;
		if( resType == 3 ) {
			param += "&title=Portlet Pattern";
		}
		else if( resType == 4 ) {
			param += "&title=External URL";
		}
		else {
			var title = document.getElementById("PrincipalPermissionManager_title").value;
			if( title == null || title.length == 0 ) {
				alert( portalPage.getMessageResource('ev.error.selectUserOrRole') );
				return;
			}
			param += "&title=" + encodeURIComponent(title);
		}
		param += "&resType=" + document.getElementById("PrincipalPermissionManager_resType").value;
		param += "&isAllow=" + ((document.getElementById("PrincipalPermissionManager_isAllow").checked == true) ? "true" : "false");
		param += "&resUrl=" + document.getElementById("PrincipalPermissionManager_resUrl").value;
		param += "&creationDate=" + document.getElementById("PrincipalPermissionManager_creationDate").value;
		param += "&modifiedDate=" + document.getElementById("PrincipalPermissionManager_modifiedDate").value;
		
		var actionMask = 15; // view authority
		var form = document.getElementById("PrincipalPermissionManager_EditForm");
		for(var j=0; j<form.elements.length; j++) {
			field = form.elements[j];
			//alert(field.type + "," + field.id + "," + field.checked);
			if(field.type == "checkbox" && field.id && field.id.indexOf("PrincipalPermissionManager_authority_") > -1 ) {
				if( field.checked == true ) {
					actionMask |= field.value;
				}
			}
		}
		param += "&actionMask=" + actionMask;
	
		this.m_ajax.send("POST", this.m_contextPath + "/principalPermission/updateForAjax.admin", param, false, {
			success: function(data){
				if( forDetail == null || forDetail == false ) {
					aPrincipalPermissionManager.doRetrieve();
				}
				enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
			}});
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PrincipalPermissionManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
			param += "&principalType=" + document.getElementById("PrincipalPermissionManager_principalType").value;
			param += "&domainId=" + document.getElementById("PrincipalPermissionManager_domainId").value;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('PrincipalPermissionManager[' + rowCntArray[i] + '].permissionId').value + ":" +
					document.getElementById("PrincipalPermissionManager_domainId").value;
	        }
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&updateDatas=";
		        param += document.getElementById('PrincipalPermissionManager[' + rowCntArray[i] + '].principalId').value + "@1@1@1@0@false";
	        }
	        
	        
			this.m_ajax.send("POST", this.m_contextPath + "/principalPermission/removeForAjax.admin", param, false, {
				success: function(data){
					aPrincipalPermissionManager.initSearch();
					aPrincipalPermissionManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
		}
	},
	toggleAllPermission : function () {
		
		var isChecked = (document.getElementById("PrincipalPermissionManager_actionMask_check").checked == true) ? true : false;
		var form = document.getElementById("PrincipalPermissionManager_EditForm");
		for(var j=0; j<form.elements.length; j++) {
			field = form.elements[j];
			//alert(field.type + "," + field.id + "," + field.checked);
			if(field.type == "checkbox" && field.id && field.id.indexOf("PrincipalPermissionManager_authority_") > -1 ) {
				if( isChecked == true ) { field.checked = true; }
				else { field.checked = false; }
			}
		}
	},
	changePrincipal : function (obj) {
		var principalType = obj.options[obj.selectedIndex].value;
		if( principalType == "U" ) {
			document.getElementById("PrincipalPermissionManager_UserChooser").style.display = "";
			document.getElementById("PrincipalPermissionManager_GroupChooser").style.display = "none";
			document.getElementById("PrincipalPermissionManager_RoleChooser").style.display = "none";
		}
		else if( principalType == "G" ) {
			document.getElementById("PrincipalPermissionManager_UserChooser").style.display = "none";
			document.getElementById("PrincipalPermissionManager_GroupChooser").style.display = "";
			document.getElementById("PrincipalPermissionManager_RoleChooser").style.display = "none";
		}
		else if( principalType == "R" ) {
			document.getElementById("PrincipalPermissionManager_UserChooser").style.display = "none";
			document.getElementById("PrincipalPermissionManager_GroupChooser").style.display = "none";
			document.getElementById("PrincipalPermissionManager_RoleChooser").style.display = "";
		}
		
		this.doRetrieve();
	}
}
