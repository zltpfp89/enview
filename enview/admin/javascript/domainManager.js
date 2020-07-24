var aDomainManager = null;
var selectDomainId = null;


DomainManager = function(evSecurityCode)
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
DomainManager.prototype =
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
			,{"fieldName":"domainCode", "validation":"Required,MaxLength"}
			,{"fieldName":"domainNm", "validation":"Required,MaxLength"}
			,{"fieldName":"domain", "validation":"Required,MaxLength"}
			,{"fieldName":"pagePath", "validation":"MaxLength"}
			,{"fieldName":"loginPage", "validation":""}
			,{"fieldName":"useYn", "validation":""}
			,{"fieldName":"updUserId", "validation":""}
			,{"fieldName":"updDatim", "validation":""}
			
		]
		
		$(function() {
			$("#DomainManager_propertyTabs").tabs();
			$("#DomainManager_propertyTabs").tabs('disable', 3);
		});
		
	},
	/*
	getDomainChooser : function () {
		if( aDomainChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/domain/listForChooser.admin", "", false, {
				success: function(data){
					//alert(data);
					document.getElementById("DomainManager_DomainChooser").innerHTML = data;
					aDomainChooser = new DomainChooser( aDomainManager.m_evSecurityCode );
				}});
		}
		return aDomainChooser;
	},
	setDomainChooserCallback : function (rowArray) {
		var chooseVal = "";
		for(var i=0; i<rowArray.length; i++) {
		
			chooseVal += rowArray[i].get("domainId") + ":";
		
		}
		alert("chooseValue=" + chooseVal);
	},
	*/
	onSelectPropertyTab : function (id) {
		var param = "";	
		switch(id) {
			case 0 : 
				break;
	 
			case 1 :
				param += "domainId=" + document.getElementById("DomainManager_domainId").value;
				if( aDomainLangManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/domain/domainLang/list.admin", param, false, {
						success: function(data){
							document.getElementById("DomainManager_DomainLangTabPage").innerHTML = data;
							aDomainLangManager = new DomainLangManager( aDomainManager.m_evSecurityCode );
							aDomainLangManager.init();
							
							document.getElementById("DomainLangManager_Master_domainId").value = document.getElementById("DomainManager_domainId").value; 
							aDomainLangManager.doRetrieve();
						}});
				}
				else {
					/*$("#checkbox_number").val("init");*/
					document.getElementById("DomainLangManager_Master_domainId").value = document.getElementById("DomainManager_domainId").value; 
					aDomainLangManager.initSearch();
					aDomainLangManager.doRetrieve();
				}
			
				break;
	 
			case 2 :
		        var DomainValue = document.getElementById("DomainManager_domainId").value;
				param += "domainId=" + DomainValue;
				
		       		if( aDomainPrincipalManager == null ) {
							this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPrincipal/list.admin", param, false, {
								success: function(data){
									document.getElementById("DomainManager_DomainPrincipalTabPage").innerHTML = data;
									aDomainPrincipalManager = new DomainPrincipalManager( aDomainManager.m_evSecurityCode );
									aDomainPrincipalManager.init();
									
									document.getElementById("DomainPrincipalManager_Master_domainId").value = document.getElementById("DomainManager_domainId").value; 
									aDomainPrincipalManager.doRetrieve();
								}});
						}
						else {
							
							document.getElementById("DomainPrincipalManager_Master_domainId").value = document.getElementById("DomainManager_domainId").value; 
							aDomainPrincipalManager.initSearch();
							aDomainPrincipalManager.doRetrieve();
						}
				break;
	 
			case 3 :
				param += "domainId=" + document.getElementById("DomainManager_domainId").value;
				if( aDomainPortletManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/domain/domainPortlet/list.admin", param, false, {
						success: function(data){
							document.getElementById("DomainManager_DomainPortletTabPage").innerHTML = data;
							aDomainPortletManager = new DomainPortletManager( aDomainManager.m_evSecurityCode );
							aDomainPortletManager.init();
							
							document.getElementById("DomainPortletManager_Master_domainId").value = document.getElementById("DomainManager_domainId").value; 
							aDomainPortletManager.doRetrieve();
						}});
				}
				else {
					
					document.getElementById("DomainPortletManager_Master_domainId").value = document.getElementById("DomainManager_domainId").value; 
					aDomainPortletManager.initSearch();
					aDomainPortletManager.doRetrieve();
				}
			
				break;
		
		}
		
		return true; 
	},
	initSearch : function () {
		var formElem = document.forms[ "DomainManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "DomainManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/domain/listForAjax.admin", param, false, {success: function(data) { aDomainManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		this.m_utility.setListData(
			"DomainManager",
			new Array('domainId'),
			new Array('domainId','domainCode', 'domain', 'pagePath'),
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
		var formElem = document.forms[ "DomainManager_SearchForm" ];
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
		if( document.getElementById('DomainManager[' + this.m_selectRowIndex + '].checkRow') ) {
			document.getElementById('DomainManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
			selectDomainId = document.getElementById('DomainManager[' + this.m_selectRowIndex + '].domainId').value;
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		
			param += "domainId=" + selectDomainId;
			var commonValue = parseInt(selectDomainId);
			
			this.m_ajax.send("POST", this.m_contextPath + "/domain/detailForAjax.admin", param, false, {success: function(data) { aDomainManager.doSelectHandler(data, commonValue); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("DomainManager_ListForm") );
	    document.getElementById('DomainManager[' + rowSeq + '].checkRow').checked = true;
		selectDomainId = document.getElementById('DomainManager[' + rowSeq + '].domainId').value;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		param += "domainId=" + selectDomainId;
		
		if(selectDomainId==0)
			{$("#domainDetailSave").hide(); $("#DomainPrincipalManager_UserChooser").hide(); $("#DomainPrincipalManager_Remove").hide();}
		else
			{$("#domainDetailSave").show(); $("#DomainPrincipalManager_UserChooser").show(); $("#DomainPrincipalManager_Remove").show();}
		
		
		var commonValue = parseInt(selectDomainId);
		var propertyTabs = $("#DomainManager_propertyTabs").tabs();
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.m_ajax.send("POST", this.m_contextPath + "/domain/detailForAjax.admin", param, false, {success: function(data) { aDomainManager.doSelectHandler(data,commonValue); }});
	},
	doSelectHandler : function(resultObject, commonValue)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "DomainManager", resultObject);
		document.getElementById("DomainManager_domainId").readOnly = true;
		
		var domainId = portalPage.getAjax().retrieveElementValue("domainId", resultObject);
		$('#DomainLangManager_Master_domainId').val(domainId);
		$('#DomainLangManager_domainId').val(domainId);
		var propertyTabs = $("#DomainManager_propertyTabs").tabs();
		propertyTabs.tabs('enable', 0);	 
		propertyTabs.tabs('enable', 1);	 
		//propertyTabs.tabs('enable', 3);
		switch (commonValue) 
		{
			case 0:
				propertyTabs.tabs('disable', 2);	 
				break;
			default:
				propertyTabs.tabs('enable', 2);	 
				break;
		}
		
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("DomainManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "DomainManager");
		
		var propertyTabs = $("#DomainManager_propertyTabs").tabs();

		propertyTabs.tabs('enable', 0);	 
		propertyTabs.tabs('disable', 1);	 
		propertyTabs.tabs('disable', 2);	 
		propertyTabs.tabs('option', 'active', 0);
	 
		document.getElementById("DomainManager_useYn").value = "N";
		document.getElementById("DomainManager_EditFormPanel").style.display = '';
		
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("DomainManager_isCreate").value;
		var form = document.getElementById("DomainManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";
		
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/domain/addForAjax.admin", param, false, {
				success: function(data){
					aDomainManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.message.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/domain/updateForAjax.admin", param, false, {
				success: function(data){
					aDomainManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.message.success.update') );
				}});
		}
	},
	doRemove : function () 
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("DomainManager_ListForm") );
		if( rowCnts == "" ) return;
		var ret = confirm( portalPage.getMessageResource('eb.info.confirm.del') );
	    if( ret == true ) {
	      var formData = "";
	      var rowCntArray = rowCnts.split(",");
		  var param = "evSecurityCode=" + this.m_evSecurityCode;
			
	      for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += document.getElementById('DomainManager[' + rowCntArray[i] + '].domainId').value;
	      }
		  this.m_ajax.send("POST", this.m_contextPath + "/domain/removeForAjax.admin", param, false, {
				success: function(data) {
					aDomainManager.m_selectRowIndex = 0;
					aDomainManager.doRetrieve();
					enviewMessageBox.doShow(portalPage.getMessageResource('ev.info.success.remove'));
		  }});
		}
	}
}

var aDomainChooser = null;
DomainChooser = function()
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	if( portalPage == null) portalPage = new enview.portal.Page();
	this.m_selectRowIndex = 0;
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = this.m_utility.getContextPath();
	this.m_domElement = document.getElementById("DomainManager_DomainChooser");
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
	
	$("#DomainManager_DomainChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:540, 
		height:400,
		modal: true,
		buttons: {
			"Apply": function() {
				aDomainChooser.doApply();
			},
			Cancel: function() {
				$(this).dialog('close');
			}
		}
	});
	
	this.init();
}

DomainChooser.prototype =
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
		$('#DomainManager_DomainChooser').dialog('open');
	},
	doRetrieve : function () {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "DomainChooser_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/domain/listForAjax.admin", param, false, {success: function(data) { aDomainChooser.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		this.m_utility.setListData(
			"DomainChooser",
			new Array('domainId'),
			new Array('domainId','domainCode','domain','pagePath'),
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
		var formElem = document.forms[ "DomainChooser_SearchForm" ];
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
			this.m_checkBox.unChkAll( document.getElementById("DomainManager_ListForm") );
			document.getElementById('DomainChooser[' + rowSeq + '].checkRow').checked = true;
			this.m_parent.doApply();
			return;
		}
		
		$('#DomainManager_DomainChooser').dialog('close');
		
		var result = new Array(1);
		var rowMap = new Map();
		
		rowMap.put("domainId", document.getElementById('DomainChooser[' + rowSeq + '].domainId').value);	
		result[0] = rowMap;
		
		this.m_callback(result);
	},
	getSelectedItems : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("DomainChooser_ListForm") );
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
			
				rowMap.put("id", document.getElementById('DomainChooser[' + rowCntArray[i] + '].id').value);	
				result[i] = rowMap;
			}
			
			return result;
		}
		
		return null;
	},
	doApply : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("DomainChooser_ListForm") );
		if( rowCnts == "" ) return;
		
		var rowCntArray = rowCnts.split(",");
		if( rowCntArray.length > 0 ) {
			if( rowCntArray.length > 1 ) {
				alert( portalPage.getMessageResource('ev.info.message.select.onlyone') );
				return;
			}
			
			$('#DomainManager_DomainChooser').dialog('close');
			
			
			var result = new Array(rowCntArray.length);
			for(var i=0; i<rowCntArray.length; i++) {
				var rowMap = new Map();
			
				rowMap.put("domainId", document.getElementById('DomainChooser[' + rowCntArray[i] + '].domainId').value);	
				result[i] = rowMap;
			}
			
			this.m_callback(result);
		}
	}
}

