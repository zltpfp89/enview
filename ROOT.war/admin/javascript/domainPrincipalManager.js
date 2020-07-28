var aDomainPrincipalManager = null;
DomainPrincipalManager = function(evSecurityCode)
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

DomainPrincipalManager.prototype =
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
			 {"fieldName":"domainId", "validation":""}
			,{"fieldName":"principalId", "validation":""}
			,{"fieldName":"principal", "validation":""}
			,{"fieldName":"userName", "validation":""}
			,{"fieldName":"theme", "validation":""}
			,{"fieldName":"defaultPage", "validation":""}
			,{"fieldName":"subPage", "validation":""}
		]
		
		$(function() {
			$("#DomainPrincipalManager_propertyTabs").tabs();
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
	getPageChooser : function () {
		var domainId = $('#DomainPrincipalManager_Master_domainId').val();
		var extraParam = "&showPublic=Y";
//		if( aPageChooser == null ) {
			aPageChooser = new PageChooser( aDomainPrincipalManager.m_evSecurityCode, domainId, extraParam );
//		}
		return aPageChooser;
	},
	
	setDefaultPageChooserCallback : function (rowArray) {
		//document.getElementById("PageManager_defaultPageName").value = rowArray[0].get("pageId");
		document.getElementById("DomainPrincipalManager_defaultPage").value = rowArray[0].get("pagePath");
		//alert(rowArray[0].get("pagePath"));
	},
	
	setSubPageChooserCallback : function (rowArray) {
		//document.getElementById("PageManager_defaultPageName").value = rowArray[0].get("pageId");
		document.getElementById("DomainPrincipalManager_subPage").value = rowArray[0].get("pagePath");
		//alert(rowArray[0].get("pagePath"));
	},
	getPageMultiChooser : function () {
		if( aPageMultiChooser == null ) {
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
			this.m_ajax.send("POST", this.m_contextPath + "/page/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("PageManager_PageMultiChooser").innerHTML = data;
					aPageMultiChooser = new PageMultiChooser();
				}});
		}
		return aPageMultiChooser;
	},
	setDefaultPageMultiChooserCallback : function (rowArray) {
		//document.getElementById("PageManager_defaultPageName").value = rowArray[0].get("pageId");
		document.getElementById("DomainPrincipalManager_defaultPage").value = rowArray[0].get("pagePath");
	},
	
	setSubPageMultiChooserCallback : function (rowArray) {
		//document.getElementById("PageManager_defaultPageName").value = rowArray[0].get("pageId");
		document.getElementById("DomainPrincipalManager_subPage").value = rowArray[0].get("pagePath");
	},
	
	// UserList
	getUserChooser : function () {
		var domainId = $('#DomainPrincipalManager_Master_domainId').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId + "&byDomain=Y&existsDomain=N&";
		var extraParam = "&byDomain=Y&existsDomain=N&";
//		if( aUserChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/user/listForChooser.admin", param, false, {
				success: function(data)
				{
					document.getElementById("UserManager_UserChooser").innerHTML = data;
					aUserChooser = new UserChooser( aDomainPrincipalManager.m_evSecurityCode, domainId, extraParam );
					
				}});
//		}
		return aUserChooser;
	},
	setUserChooserCallback : function (rowArray) 
	{
		var param =  "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + $('#DomainPrincipalManager_Master_domainId').val();
		for(var i=0; i<rowArray.length; i++) {	
			param += "&pks=" + rowArray[i].get("principalId");
		}

		//alert(param);
		this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPrincipal/addsForAjax.admin", param, false, 
				{
			success: function(data){
				enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				aDomainPrincipalManager.doRetrieve();
			}});
	},
	getGroupChooser : function () 
	{
		if( aGroupChooser == null ) 
		{
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
			this.m_ajax.send("POST", this.m_contextPath + "/group/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("GroupManager_GroupChooser").innerHTML = data;
					aGroupChooser = new GroupChooser( aDomainPrincipalManager.m_evSecurityCode );
				}});
		}
		return aGroupChooser;
	},
	setGroupChooserCallback : function (rowArray) 
	{
	   //alert("GroupChooserCallback")
        var param = "evSecurityCode=" + this.m_evSecurityCode;
		
		for(var i=0; i<rowArray.length; i++)
		{	
			param += "&updateDatas=";
			param += selectDomainId + "@"+rowArray[i].get("principalId") + "@" + null + "@" + null;
		}

		this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPrincipal/addsForAjax.admin", param, false, 
				{
			success: function(data){
				enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				aDomainPrincipalManager.doRetrieve();
			}});
	},
	getRoleChooser : function () 
	{
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		if( aRoleChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/role/listForChooser.admin", param, false, {
				success: function(data){
					document.getElementById("RoleManager_RoleChooser").innerHTML = data;
					aRoleChooser = new RoleChooser( aDomainPrincipalManager.m_evSecurityCode );
				}});
		}
		return aRoleChooser;
	},
	setRoleChooserCallback : function (rowArray) 
	{
		alert("GroupChooserCallback");
		
	       var param = "param" + "evSecurityCode=" + this.m_evSecurityCode;
			
			for(var i=0; i<rowArray.length; i++)
			{	
				param += "&updateDatas=";
				param += selectDomainId + "@"+rowArray[i].get("principalId") + "@" + null + "@" + null;
			}

			this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPrincipal/addsForAjax.admin", param, false, 
					{
				success: function(data){
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
					aPrincipalPermissionManager.doRetrieve();
				}});
	},	
	
	
	changePrincipal : function (obj) 
	{
			
		var principalType = obj.options[obj.selectedIndex].value;
		if( principalType == "U" ) 
		{
			document.getElementById("DomainPrincipalManager_UserChooser").style.display = "";
			document.getElementById("DomainPrincipalManager_GroupChooser").style.display = "none";
			document.getElementById("DomainPrincipalManager_RoleChooser").style.display = "none";
		}
		else if( principalType == "G" ) {
			document.getElementById("DomainPrincipalManager_UserChooser").style.display = "none";
			document.getElementById("DomainPrincipalManager_GroupChooser").style.display = "";
			document.getElementById("DomainPrincipalManager_RoleChooser").style.display = "none";
		}
		else if( principalType == "R" ) {
			document.getElementById("DomainPrincipalManager_UserChooser").style.display = "none";
			document.getElementById("DomainPrincipalManager_GroupChooser").style.display = "none";
			document.getElementById("DomainPrincipalManager_RoleChooser").style.display = "";
		}
	},
	
	
	/*
	getDomainPrincipalChooser : function () {
		if( aDomainPrincipalChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPrincipal/listForChooser.admin", "", false, {
				success: function(data){
					//alert(data);
					document.getElementById("DomainPrincipalManager_DomainPrincipalChooser").innerHTML = data;
					aDomainPrincipalChooser = new DomainPrincipalChooser( aDomainPrincipal.m_evSecurityCode );
				}});
		}
		return aDomainPrincipalChooser;
	},
	setDomainPrincipalChooserCallback : function (rowArray) 
	{
		var chooseVal = "";
		for(var i=0; i<rowArray.length; i++) {
		
			chooseVal += rowArray[i].get("domainId") + ":";
			chooseVal += rowArray[i].get("principalId") + ":";
		
		}
		alert("chooseValue=" + chooseVal);
	},
	*/
	onSelectPropertyTab : function (id) 
	{
		var param = "";	
		switch(id) {
			case 0 : 
				break;
		
		}
		
		return true; 
	},
	initSearch : function () {
		var formElem = document.forms[ "DomainPrincipalManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
	},
	doRetrieve : function () 
	{
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "DomainPrincipalManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++)
	    {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPrincipal/listForAjax.admin", param, false, {success: function(data) { aDomainPrincipalManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"DomainPrincipalManager",
			new Array('principalId','userNameId','domainId'),
			new Array('principal','userName'),
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
		var formElem = document.forms[ "DomainPrincipalManager_SearchForm" ];
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
		
		if( document.getElementById('DomainPrincipalManager[' + this.m_selectRowIndex + '].checkRow') ) {
			document.getElementById('DomainPrincipalManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
			
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		
			param += "domainId=";
			param += document.getElementById('DomainPrincipalManager[' + this.m_selectRowIndex + '].domainId').value;
			param += "&principalId=";
			param += document.getElementById('DomainPrincipalManager[' + this.m_selectRowIndex + '].principalId').value;

			this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPrincipal/detailForAjax.admin", param, false, {success: function(data) { aDomainPrincipalManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("DomainPrincipalManager_ListForm") );
	    document.getElementById('DomainPrincipalManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "domainId=";
		param += document.getElementById('DomainPrincipalManager[' + rowSeq + '].domainId').value;
		param += "&principalId=";
		param += document.getElementById('DomainPrincipalManager[' + rowSeq + '].principalId').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPrincipal/detailForAjax.admin", param, false, {success: function(data) { aDomainPrincipalManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "DomainPrincipalManager", resultObject);
			var propertyTabs = $("#DomainPrincipalManager_propertyTabs").tabs();
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("DomainPrincipalManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "DomainPrincipalManager");
		
		var propertyTabs = $("#DomainPrincipalManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	 
		document.getElementById("DomainPrincipalManager_domainId").value = document.getElementById("DomainPrincipalManager_Master_domainId").value; 
		document.getElementById("DomainPrincipalManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("DomainPrincipalManager_isCreate").value;
		var form = document.getElementById("DomainPrincipalManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPrincipal/addForAjax.admin", param, false, {
				success: function(data){
					aDomainPrincipalManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.message.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPrincipal/updateForAjax.admin", param, false, {
				success: function(data){
					aDomainPrincipalManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.message.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("DomainPrincipalManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
			param += "&domainId=" + document.getElementById('DomainPrincipalManager_Master_domainId').value;
	        for(i=0; i<rowCntArray.length; i++)  {
				param += "&pks=" + document.getElementById('DomainPrincipalManager[' + rowCntArray[i] + '].principalId').value;
	        }
			this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPrincipal/removeForAjax.admin", param, false, {
				success: function(data){
					aDomainPrincipalManager.m_selectRowIndex = 0;
					aDomainPrincipalManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
		}
	}
	
}

var aDomainPrincipalChooser = null;
DomainPrincipalChooser = function()
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	if( portalPage == null) portalPage = new enview.portal.Page();
	this.m_selectRowIndex = 0;
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = this.m_utility.getContextPath();
	this.m_domElement = document.getElementById("DomainPrincipalManager_DomainPrincipalChooser");
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
	
	$("#DomainPrincipalManager_DomainPrincipalChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:540, 
		height:400,
		modal: true,
		buttons: {
			"Apply": function() {
				aDomainPrincipalChooser.doApply();
			},
			Cancel: function() {
				$(this).dialog('close');
			}
		}
	});
	
	this.init();
}

DomainPrincipalChooser.prototype =
{
	m_domElement : null,
	m_checkBox : null,
	m_callback : null,
	
	init : function() {
		
	},
	whenSrchFocus : function ( obj, lvS ) {
		if( obj.value == lvS ) obj.value = "";
	},
	whenSrchBlur : function ( obj, lvS ) {
		if( obj.value == "" ) obj.value = lvS;
	},
	
	doShow : function (callback)
	{
		this.m_callback = callback;
		this.doRetrieve();
		$('#DomainPrincipalManager_DomainPrincipalChooser').dialog('open');
	},
	doRetrieve : function () {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "DomainPrincipalChooser_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPrincipal/listForAjax.admin", param, false, {success: function(data) { aDomainPrincipalChooser.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		this.m_utility.setListData(
			"DomainPrincipalChooser",
			new Array('principalId','userNameId', 'domainId'),
			new Array('principal','userName'),
/*			new Array('principalId'),
			new Array('principal'),*/
			this.m_contextPath,
			resultObject);
	},
	doPage : function (formName, pageNo)
	{
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = pageNo;
		
		this.doRetrieve();
	},
	doSearch : function (formName)
	{
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = 1;
		
		this.doRetrieve();
	},
	doSort : function (obj, sortColumn)
	{
		var formElem = document.forms[ "DomainPrincipalChooser_SearchForm" ];
	    formElem.elements[ "sortColumn" ].value = sortColumn;
	    if( obj.ch % 2 == 0 ) {
			formElem.elements[ "sortMethod" ].value = "ASC";
	        obj.ch = 1;
	    }
	    else {
	        formElem.elements[ "sortMethod" ].value = "DESC";
	        obj.ch = 0;
	    }
		
		this.doRetrieve();
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
		
		if( this.m_parent != null ) {
			this.m_checkBox.unChkAll( document.getElementById("DomainPrincipalManager_ListForm") );
			document.getElementById('DomainPrincipalChooser[' + rowSeq + '].checkRow').checked = true;
			this.m_parent.doApply();
			return;
		}
		
		$('#DomainPrincipalManager_DomainPrincipalChooser').dialog('close');
		
		var result = new Array(1);
		var rowMap = new Map();
		
		rowMap.put("domainId", document.getElementById('DomainPrincipalChooser[' + rowSeq + '].domainId').value);	
		rowMap.put("principalId", document.getElementById('DomainPrincipalChooser[' + rowSeq + '].principalId').value);	
		result[0] = rowMap;
		
		this.m_callback(result);
	},
	getSelectedItems : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("DomainPrincipalChooser_ListForm") );
		if( rowCnts == "" ) return;
		
		var rowCntArray = rowCnts.split(",");
		if( rowCntArray.length > 0 ) {
			if( rowCntArray.length > 1 ) {
				alert( portalPage.getMessageResource('ev.info.message.select.onlyone') );
				return;
			}
			
			var result = new Array(rowCntArray.length);
			for(var i=0; i<rowCntArray.length; i++) {
				var rowMap = new Map();
			
				rowMap.put("id", document.getElementById('DomainPrincipalChooser[' + rowCntArray[i] + '].id').value);	
				result[i] = rowMap;
			}
			
			return result;
		}
		
		return null;
	},
	doApply : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("DomainPrincipalChooser_ListForm") );
		if( rowCnts == "" ) return;
		
		var rowCntArray = rowCnts.split(",");
		if( rowCntArray.length > 0 ) {
			if( rowCntArray.length > 1 ) {
				alert( portalPage.getMessageResource('ev.info.message.select.onlyone') );
				return;
			}
			
			$('#DomainPrincipalManager_DomainPrincipalChooser').dialog('close');
			
			var result = new Array(rowCntArray.length);
			for(var i=0; i<rowCntArray.length; i++) {
				var rowMap = new Map();
			
				rowMap.put("domainId", document.getElementById('DomainPrincipalChooser[' + rowCntArray[i] + '].domainId').value);	
				rowMap.put("principalId", document.getElementById('DomainPrincipalChooser[' + rowCntArray[i] + '].principalId').value);	
				result[i] = rowMap;
			}
			
			this.m_callback(result);
		}
	}
	
}

