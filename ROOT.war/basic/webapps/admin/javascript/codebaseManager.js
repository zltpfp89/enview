
var aCodebaseManager = null;
CodebaseManager = function(evSecurityCode)
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
CodebaseManager.prototype =
{
	m_ajax : null,
	m_checkBox : null,
	m_validator : null,
	m_utility : null,
	m_contextPath : null,
	m_selectRowIndex : 0,
	m_selectLangKnd : null,
	m_selectDomainId : null,
	m_dataStructure : null,
	m_evSecurityCode : null,
	
	init : function() { 
		
		this.m_dataStructure = [
			{"fieldName":"systemCode", "validation":"Required"}
			,{"fieldName":"codeId", "validation":"Required,MaxLength", "maxLength":"20"}
			,{"fieldName":"code", "validation":"Required,MaxLength", "maxLength":"20"}
			,{"fieldName":"langKnd", "validation":"Required"}
			,{"fieldName":"codeName", "validation":"Required,MaxLength", "maxLength":"20"}
			,{"fieldName":"codeName2", "validation":"MaxLength", "maxLength":"20"}
			,{"fieldName":"codeTag1", "validation":"MaxLength", "maxLength":"10"}
			,{"fieldName":"codeTag2", "validation":"MaxLength", "maxLength":"10"}
			,{"fieldName":"remark", "validation":"MaxLength", "maxLength":"60"}
			,{"fieldName":"domainId", "validation":"Required"}
			
		]
		
		$(function() {
			$("#CodebaseManager_propertyTabs").tabs();
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
		var param = "";	
		switch(id) {
			case 0 : 
				this.doChildRetrieve();
				break;
			case 1 :
				this.doSubRetrieve();
				break;
		}
		
		return true; 
	},
	initSearch : function () {
		var formElem = document.forms[ "CodebaseManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
		
		// 하위코드 1페이지로 설정
		var subForm = document.forms[ "CodebaseManager_Sub_SearchForm" ];
	    subForm.elements[ "pageNo" ].value = 1;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "CodebaseManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
//		alert( "doRetrieve\n" + param);
		this.m_ajax.send("POST", this.m_contextPath + "/codebase/listForAjax.admin", param, false, {success: function(data) { aCodebaseManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"CodebaseManager",
			new Array('systemCode', 'domainId', 'codeId', 'code', 'langKnd'),
			new Array('domainNm', 'systemCode',  'codeId', 'code', 'codeName'),
			this.m_contextPath,
			resultObject);
				
		if(resultObject.Data.length != 0) {
			this.doChildRetrieve(); 
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
		var formElem = document.forms[ "CodebaseManager_SearchForm" ];
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
		document.getElementById('CodebaseManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		document.getElementById("CodebaseManager_Child_systemCode").readOnly = true;
		document.getElementById("CodebaseManager_Child_systemCode").disabled = true;
		document.getElementById("CodebaseManager_Child_domainId").readOnly = true;
		document.getElementById("CodebaseManager_Child_domainId").disabled = true;
		document.getElementById("CodebaseManager_Child_codeId").readOnly = true;
		document.getElementById("CodebaseManager_Child_code").readOnly = true;
		document.getElementById("CodebaseManager_Child_langKnd").readOnly = true;
		document.getElementById("CodebaseManager_Child_langKnd").disabled = true;
		
		document.getElementById("CodebaseManager_Sub_systemCode").readOnly = true;
		document.getElementById("CodebaseManager_Sub_systemCode").disabled = true;
		document.getElementById("CodebaseManager_Sub_domainId").readOnly = true;
		document.getElementById("CodebaseManager_Sub_domainId").disabled = true;
		document.getElementById("CodebaseManager_Sub_codeId").readOnly = true;
		document.getElementById("CodebaseManager_Sub_code").readOnly = true;
		document.getElementById("CodebaseManager_Sub_langKnd").readOnly = true;
		document.getElementById("CodebaseManager_Sub_langKnd").disabled = true;
		
		this.doChildRetrieve();
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
		
	    this.m_checkBox.unChkAll( document.getElementById("CodebaseManager_ListForm") );
	    document.getElementById('CodebaseManager[' + rowSeq + '].checkRow').checked = true;
		
		var propertyTabs = $("#CodebaseManager_propertyTabs").tabs();
		propertyTabs.tabs('enable', 1);
		
		document.getElementById("CodebaseManager_Child_systemCode").readOnly = true;
		document.getElementById("CodebaseManager_Child_systemCode").disabled = true;
		document.getElementById("CodebaseManager_Child_domainId").readOnly = true;
		document.getElementById("CodebaseManager_Child_domainId").disabled = true;
		document.getElementById("CodebaseManager_Child_codeId").readOnly = true;
		document.getElementById("CodebaseManager_Child_code").readOnly = true;
		document.getElementById("CodebaseManager_Child_langKnd").readOnly = true;
		document.getElementById("CodebaseManager_Child_langKnd").disabled = true;
		
		document.getElementById("CodebaseManager_Sub_systemCode").readOnly = true;
		document.getElementById("CodebaseManager_Sub_systemCode").disabled = true;
		document.getElementById("CodebaseManager_Sub_domainId").readOnly = true;
		document.getElementById("CodebaseManager_Sub_domainId").disabled = true;
		document.getElementById("CodebaseManager_Sub_codeId").readOnly = true;
		document.getElementById("CodebaseManager_Sub_code").readOnly = true;
		document.getElementById("CodebaseManager_Sub_langKnd").readOnly = true;
		document.getElementById("CodebaseManager_Sub_langKnd").disabled = true;
		
		// 하위코드 1페이지로 설정
		var subForm = document.forms[ "CodebaseManager_Sub_SearchForm" ];
	    subForm.elements[ "pageNo" ].value = 1;
		
		
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		//alert(propSelectedTabId);
		this.onSelectPropertyTab( propSelectedTabId );
	},
	doCreate : function() 
	{
		var propertyTabs = $("#CodebaseManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
		propertyTabs.tabs('disable', 1);
		
		var bodyElem = document.getElementById('CodebaseManager_Child_ListBody');
		this.m_checkBox.unChkAll( document.getElementById("CodebaseManager_Child_ListForm") );
		for(; bodyElem.hasChildNodes(); )
			bodyElem.removeChild( bodyElem.childNodes[0] );
			
		document.getElementById("CodebaseManager_Child_ListButtons").style.display = '';  
		document.getElementById("CodebaseManager_Child_EditButtons").style.display = '';
		document.getElementById("CodebaseManager_Sub_ListButtons").style.display = '';  
		document.getElementById("CodebaseManager_Sub_EditButtons").style.display = '';

		document.getElementById("CodebaseManager_Child_domainId").value = userDomainId;
		if( isAdmin) {
			document.getElementById("CodebaseManager_Child_domainId").readOnly = false;
			document.getElementById("CodebaseManager_Child_domainId").disabled = false;
			document.getElementById("CodebaseManager_Sub_domainId").readOnly = false;
			document.getElementById("CodebaseManager_Sub_domainId").disabled = false;
		} else {
			document.getElementById("CodebaseManager_Child_domainId").readOnly = true;
			document.getElementById("CodebaseManager_Child_domainId").disabled = true;
			document.getElementById("CodebaseManager_Sub_domainId").readOnly = true;
			document.getElementById("CodebaseManager_Sub_domainId").disabled = true;
		}
		document.getElementById("CodebaseManager_Child_systemCode").value = "PT";
		document.getElementById("CodebaseManager_Child_codeId").value = "";
		document.getElementById("CodebaseManager_Child_code").value = "0000000000";
		document.getElementById("CodebaseManager_Child_langKnd").value = portalPage.getLangKnd();
		document.getElementById("CodebaseManager_Child_codeName").value = "";
		document.getElementById("CodebaseManager_Child_codeName2").value = "";
		document.getElementById("CodebaseManager_Child_codeTag1").value = "";
		document.getElementById("CodebaseManager_Child_codeTag2").value = "";
		document.getElementById("CodebaseManager_Child_remark").value = "";
			
		this.doChildCreate(true);
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("CodebaseManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('CodebaseManager[' + rowCntArray[i] + '].systemCode').value + ":" +
					document.getElementById('CodebaseManager[' + rowCntArray[i] + '].domainId').value + ":" + 
					document.getElementById('CodebaseManager[' + rowCntArray[i] + '].codeId').value + ":" +
					document.getElementById('CodebaseManager[' + rowCntArray[i] + '].code').value + ":" +
					document.getElementById('CodebaseManager[' + rowCntArray[i] + '].langKnd').value; 
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/codebase/removeMasterForAjax.admin", param, false, {
				success: function(data){
					aCodebaseManager.initSearch();
					aCodebaseManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	},
	
	/*************************************************** ChildCodes *********************************************************/
	doChildRetrieve : function () {
		document.getElementById('CodebaseManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		param += "systemCode=";
		param += document.getElementById('CodebaseManager[' + this.m_selectRowIndex + '].systemCode').value;
		param += "&domainId=";
		param += document.getElementById('CodebaseManager[' + this.m_selectRowIndex + '].domainId').value;
		param += "&codeId=";
		param += document.getElementById('CodebaseManager[' + this.m_selectRowIndex + '].codeId').value;
		param += "&code=";
		param += document.getElementById('CodebaseManager[' + this.m_selectRowIndex + '].code').value;
		param += "&langKnd=";
		param += document.getElementById('CodebaseManager[' + this.m_selectRowIndex + '].langKnd').value;

		var formElem = document.forms[ "CodebaseManager_Child_SearchForm" ];
	    
		for(var i=0; i < formElem.elements.length; i++){
			param += '&' + formElem.elements[i].name + '=' + formElem.elements[i].value;
		}
		
//		alert( 'doChildRetrieve\n' + param);
		this.m_ajax.send("POST", this.m_contextPath + "/codebase/listLanguageForAjax.admin", param, false, {success: function(data) { aCodebaseManager.doChildRetrieveHandler(data); }});
	},
	doChildRetrieveHandler : function( resultObject ) {
		
		this.setListData(
			"CodebaseManager",
			"Child",
			new Array('systemCode', 'domainId', 'codeId', 'code', 'langKnd'),
			new Array('domainNm', 'systemCode',  'codeId', 'code', 'codeName'),
			this.m_contextPath,
			resultObject);
				
		// if not editable, hide buttons 
		document.getElementById("CodebaseManager_Child_ListButtons").style.display = resultObject.Editable == 'true' ? 'block' : 'none';  
		document.getElementById("CodebaseManager_Child_EditButtons").style.display = resultObject.Editable == 'true' ? 'block' : 'none';
		document.getElementById("CodebaseManager_Sub_ListButtons").style.display = resultObject.Editable == 'true' ? 'block' : 'none';  
		document.getElementById("CodebaseManager_Sub_EditButtons").style.display = resultObject.Editable == 'true' ? 'block' : 'none';
		
		if(resultObject.Data.length != 0) {
			this.doChildDefaultSelect(); 
		}
	},
	doChildPage : function (formName, pageNo)
	{
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = pageNo;
		
		//this.m_selectRowIndex = 0;
		this.doChildRetrieve();
	},
	doChildSearch : function (formName)
	{
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = 1;
		
		//this.m_selectRowIndex = 0;
		this.doChildRetrieve();
	},
	doChildSort : function (obj, sortColumn)
	{
		var formElem = document.forms[ "CodebaseManager_Child_SearchForm" ];
	    formElem.elements[ "sortColumn" ].value = sortColumn;
	    if( obj.ch % 2 == 0 ) {
			formElem.elements[ "sortMethod" ].value = "ASC";
	        obj.ch = 1;
	    }
	    else {
	        formElem.elements[ "sortMethod" ].value = "DESC";
	        obj.ch = 0;
	    }
		
		//this.m_selectRowIndex = 0;
		this.doChildRetrieve();
	},
	doChildDefaultSelect : function ()
	{
		//alert('CodebaseManager_Child[' + this.m_selectRowIndex + '].checkRow');
		document.getElementById('CodebaseManager_Child[0].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "systemCode=";
		param += document.getElementById('CodebaseManager_Child[0].systemCode').value;
		param += "&domainId=";
		param += document.getElementById('CodebaseManager_Child[0].domainId').value;
		param += "&codeId=";
		param += document.getElementById('CodebaseManager_Child[0].codeId').value;
		param += "&code=";
		param += document.getElementById('CodebaseManager_Child[0].code').value;
		param += "&langKnd=";
		param += document.getElementById('CodebaseManager_Child[0].langKnd').value;
		
//		alert( "doChildDefaultSelect-detailForAjax\n" + param);		
		this.m_ajax.send("POST", this.m_contextPath + "/codebase/detailForAjax.admin", param, false, {success: function(data) { aCodebaseManager.doChildSelectHandler(data); }});
	},
	doChildSelect : function (obj)
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
		
		//this.m_selectChildRowIndex = rowSeq;
		
	    this.m_checkBox.unChkAll( document.getElementById("CodebaseManager_Child_ListForm") );
	    document.getElementById('CodebaseManager_Child[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "systemCode=";
		param += document.getElementById('CodebaseManager_Child[' + rowSeq + '].systemCode').value;
		param += "&domainId=";
		param += document.getElementById('CodebaseManager_Child[' + rowSeq + '].domainId').value;
		param += "&codeId=";
		param += document.getElementById('CodebaseManager_Child[' + rowSeq + '].codeId').value;
		param += "&code=";
		param += document.getElementById('CodebaseManager_Child[' + rowSeq + '].code').value;
		param += "&langKnd=";
		param += document.getElementById('CodebaseManager_Child[' + rowSeq + '].langKnd').value;
			
//		alert( "doChildSelect-detailForAjax\n" + param);		
		this.m_ajax.send("POST", this.m_contextPath + "/codebase/detailForAjax.admin", param, false, {success: function(data) { aCodebaseManager.doChildSelectHandler(data); }});
	},
	doChildSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "CodebaseManager_Child", resultObject);
		
		this.m_selectLangKnd = document.getElementById('CodebaseManager_Child_langKnd').value;
		this.m_selectDomainId = document.getElementById('CodebaseManager_Child_domainId').value;
		
		var propertyTabs = $("#CodebaseManager_propertyTabs").tabs();
		propertyTabs.tabs('enable', 1);
	},
	doChildCreate : function(isMaster) 
	{
		document.getElementById("CodebaseManager_Child_isCreate").value = "true";
		/*
		document.getElementById("CodebaseManager_Child_systemCode").value = "PT";
		document.getElementById("CodebaseManager_Child_codeId").value = "";
		document.getElementById("CodebaseManager_Child_code").value = "0000000000";
		document.getElementById("CodebaseManager_Child_langKnd").value = "$langKnd";
		document.getElementById("CodebaseManager_Child_codeName").value = "";
		document.getElementById("CodebaseManager_Child_codeName2").value = "";
		document.getElementById("CodebaseManager_Child_codeTag1").value = "";
		document.getElementById("CodebaseManager_Child_codeTag2").value = "";
		document.getElementById("CodebaseManager_Child_remark").value = "";
		*/
		if( isMaster ) {
			document.getElementById("CodebaseManager_Child_systemCode").value = "PT";
			if( isAdmin) {
				document.getElementById("CodebaseManager_Child_domainId").readOnly = false;
				document.getElementById("CodebaseManager_Child_domainId").disabled = false;
			} else {
				document.getElementById("CodebaseManager_Child_domainId").readOnly = true;
				document.getElementById("CodebaseManager_Child_domainId").disabled = true;
			}
			document.getElementById("CodebaseManager_Child_codeId").value = "";
			document.getElementById("CodebaseManager_Child_code").value = "0000000000";
			document.getElementById("CodebaseManager_Child_langKnd").value = portalPage.getLangKnd();
			document.getElementById("CodebaseManager_Child_systemCode").readOnly = false;
			document.getElementById("CodebaseManager_Child_systemCode").disabled = false;
			document.getElementById("CodebaseManager_Child_codeId").readOnly = false;
			document.getElementById("CodebaseManager_Child_code").readOnly = true;
			document.getElementById("CodebaseManager_Child_langKnd").readOnly = false;
			document.getElementById("CodebaseManager_Child_langKnd").disabled = false;
		}
		else {
			document.getElementById("CodebaseManager_Child_langKnd").value = "";
			document.getElementById("CodebaseManager_Child_domainId").readOnly = true;
			document.getElementById("CodebaseManager_Child_domainId").disabled = true;
			document.getElementById("CodebaseManager_Child_systemCode").readOnly = true;
			document.getElementById("CodebaseManager_Child_systemCode").disabled = true;
			document.getElementById("CodebaseManager_Child_codeId").readOnly = true;
			document.getElementById("CodebaseManager_Child_code").readOnly = true;
			document.getElementById("CodebaseManager_Child_langKnd").readOnly = false;
			document.getElementById("CodebaseManager_Child_langKnd").disabled = false;
		}
	},
	doChildRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("CodebaseManager_Child_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('CodebaseManager_Child[' + rowCntArray[i] + '].systemCode').value + ":" +
					document.getElementById('CodebaseManager_Child[' + rowCntArray[i] + '].domainId').value + ":" + 
					document.getElementById('CodebaseManager_Child[' + rowCntArray[i] + '].codeId').value + ":" +
					document.getElementById('CodebaseManager_Child[' + rowCntArray[i] + '].code').value + ":" +
					document.getElementById('CodebaseManager_Child[' + rowCntArray[i] + '].langKnd').value; 
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/codebase/removeLanguageForAjax.admin", param, false, {
				success: function(data){
					//aCodebaseManager.m_selectRowIndex = 0;
					aCodebaseManager.doChildRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	},
	doChildUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("CodebaseManager_Child_isCreate").value;
		var form = document.getElementById("CodebaseManager_Child_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode;
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/codebase/addForAjax.admin", param, false, {
				success: function(data){
					if( forDetail == null || forDetail == false ) {
						aCodebaseManager.doChildRetrieve();
					}
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/codebase/updateForAjax.admin", param, false, {
				success: function(data){
					if( forDetail == null || forDetail == false ) {
						aCodebaseManager.doChildRetrieve();
					}
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	/*************************************************** SubCodes *********************************************************/
	doSubRetrieve : function () {

		this.doSubCreate();
		document.getElementById("CodebaseManager_Sub_systemCode").value = document.getElementById("CodebaseManager[" + this.m_selectRowIndex + "].systemCode").value;
		document.getElementById("CodebaseManager_Sub_domainId").value = document.getElementById("CodebaseManager[" + this.m_selectRowIndex + "].domainId").value;
		document.getElementById("CodebaseManager_Sub_codeId").value = document.getElementById("CodebaseManager[" + this.m_selectRowIndex + "].codeId").value;
		document.getElementById("CodebaseManager_Sub_langKnd").value = this.m_selectLangKnd;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "CodebaseManager_Sub_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		param += "systemCode=";
		param += document.getElementById("CodebaseManager[" + this.m_selectRowIndex + "].systemCode").value;
		param += "&domainId=";
		param += document.getElementById("CodebaseManager[" + this.m_selectRowIndex + "].domainId").value;
		param += "&codeId=";
		param += document.getElementById("CodebaseManager[" + this.m_selectRowIndex + "].codeId").value;
		param += "&langKnd=";
		param += this.m_selectLangKnd;
		
		this.m_ajax.send("POST", this.m_contextPath + "/codebase/listsubForAjax.admin", param, false, {success: function(data) { aCodebaseManager.doSubRetrieveHandler(data); }});
	},
	doSubRetrieveHandler : function( resultObject ) {
		
		this.setListData(
			"CodebaseManager",
			"Sub",
			new Array('systemCode', 'domainId', 'codeId', 'code', 'langKnd'),
			new Array('domainNm', 'systemCode',  'codeId', 'code', 'codeName'),
			this.m_contextPath,
			resultObject);
				
		// if not editable, hide buttons 
		document.getElementById("CodebaseManager_Child_ListButtons").style.display = resultObject.Editable == 'true' ? 'block' : 'none';  
		document.getElementById("CodebaseManager_Child_EditButtons").style.display = resultObject.Editable == 'true' ? 'block' : 'none';
		document.getElementById("CodebaseManager_Sub_ListButtons").style.display = resultObject.Editable == 'true' ? 'block' : 'none';  
		document.getElementById("CodebaseManager_Sub_EditButtons").style.display = resultObject.Editable == 'true' ? 'block' : 'none';
		
		if(resultObject.Data.length != 0) {
			this.doSubDefaultSelect(); 
		}
	},
	doSubPage : function (formName, pageNo)
	{
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = pageNo;
		
		//this.m_selectRowIndex = 0;
		this.doSubRetrieve();
	},
	doSubSearch : function (formName)
	{
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = 1;
		
		//this.m_selectRowIndex = 0;
		this.doSubRetrieve();
	},
	doSubSort : function (obj, sortColumn)
	{
		var formElem = document.forms[ "CodebaseManager_Sub_SearchForm" ];
	    formElem.elements[ "sortColumn" ].value = sortColumn;
	    if( obj.ch % 2 == 0 ) {
			formElem.elements[ "sortMethod" ].value = "ASC";
	        obj.ch = 1;
	    }
	    else {
	        formElem.elements[ "sortMethod" ].value = "DESC";
	        obj.ch = 0;
	    }
		
		//this.m_selectRowIndex = 0;
		this.doSubRetrieve();
	},
	doSubDefaultSelect : function ()
	{
		document.getElementById('CodebaseManager_Sub[0].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "systemCode=";
		param += document.getElementById('CodebaseManager_Sub[0].systemCode').value;
		param += "&domainId=";
		param += document.getElementById('CodebaseManager_Sub[0].domainId').value;
		param += "&codeId=";
		param += document.getElementById('CodebaseManager_Sub[0].codeId').value;
		param += "&code=";
		param += document.getElementById('CodebaseManager_Sub[0].code').value;
		param += "&langKnd=";
		param += document.getElementById('CodebaseManager_Sub[0].langKnd').value;
		
//		alert( "doSubDefaultSelect-detailForAjax\n" + param);		
		this.m_ajax.send("POST", this.m_contextPath + "/codebase/detailForAjax.admin", param, false, {success: function(data) { aCodebaseManager.doSubSelectHandler(data); }});
	},
	doSubSelect : function (obj)
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
		
		//this.m_selectRowIndex = rowSeq;
		
	    this.m_checkBox.unChkAll( document.getElementById("CodebaseManager_Sub_ListForm") );
	    document.getElementById('CodebaseManager_Sub[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "systemCode=";
		param += document.getElementById('CodebaseManager_Sub[' + rowSeq + '].systemCode').value;
		param += "&domainId=";
		param += document.getElementById('CodebaseManager_Sub[0].domainId').value;
		param += "&codeId=";
		param += document.getElementById('CodebaseManager_Sub[' + rowSeq + '].codeId').value;
		param += "&code=";
		param += document.getElementById('CodebaseManager_Sub[' + rowSeq + '].code').value;
		param += "&langKnd=";
		param += document.getElementById('CodebaseManager_Sub[' + rowSeq + '].langKnd').value;
		
//		alert( "doSubSelect-detailForAjax\n" + param);		
			
		this.m_ajax.send("POST", this.m_contextPath + "/codebase/detailForAjax.admin", param, false, {success: function(data) { aCodebaseManager.doSubSelectHandler(data); }});
	},
	doSubSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "CodebaseManager_Sub", resultObject);
	},
	doSubCreate : function() 
	{
		document.getElementById("CodebaseManager_Sub_isCreate").value = "true";
		/*
		document.getElementById("CodebaseManager_Sub_systemCode").value = "PT";
		document.getElementById("CodebaseManager_Sub_codeId").value = "";
		document.getElementById("CodebaseManager_Sub_code").value = "0000000000";
		document.getElementById("CodebaseManager_Sub_langKnd").value = "$langKnd";
		document.getElementById("CodebaseManager_Sub_codeName").value = "";
		document.getElementById("CodebaseManager_Sub_codeName2").value = "";
		document.getElementById("CodebaseManager_Sub_codeTag1").value = "";
		document.getElementById("CodebaseManager_Sub_codeTag2").value = "";
		document.getElementById("CodebaseManager_Sub_remark").value = "";
		*/
		document.getElementById("CodebaseManager_Sub_code").value = "";
		document.getElementById("CodebaseManager_Sub_codeName").value = "";
		document.getElementById("CodebaseManager_Sub_codeName2").value = "";
		document.getElementById("CodebaseManager_Sub_codeTag1").value = "";
		document.getElementById("CodebaseManager_Sub_codeTag2").value = "";
		document.getElementById("CodebaseManager_Sub_remark").value = "";
		
		document.getElementById("CodebaseManager_Sub_systemCode").readOnly = true;
		document.getElementById("CodebaseManager_Sub_systemCode").disabled = true;
		document.getElementById("CodebaseManager_Sub_codeId").readOnly = true;
		document.getElementById("CodebaseManager_Sub_code").readOnly = false;
		document.getElementById("CodebaseManager_Sub_langKnd").readOnly = true;
		document.getElementById("CodebaseManager_Sub_langKnd").disabled = true;
	},
	doSubRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("CodebaseManager_Sub_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('CodebaseManager_Sub[' + rowCntArray[i] + '].systemCode').value + ":" +
					document.getElementById('CodebaseManager_Sub[' + rowCntArray[i] + '].domainId').value + ":" + 
					document.getElementById('CodebaseManager_Sub[' + rowCntArray[i] + '].codeId').value + ":" +
					document.getElementById('CodebaseManager_Sub[' + rowCntArray[i] + '].code').value + ":" +
					document.getElementById('CodebaseManager_Sub[' + rowCntArray[i] + '].langKnd').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/codebase/removeForAjax.admin", param, false, {
				success: function(data){
					//aCodebaseManager.m_selectRowIndex = 0;
					aCodebaseManager.doSubRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	},
	doSubUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("CodebaseManager_Sub_isCreate").value;
		var form = document.getElementById("CodebaseManager_Sub_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";
		
//		alert( 'doSubUdate. isCreate=' + isCreate + '\n' + param);
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/codebase/addForAjax.admin", param, false, {
				success: function(data){
					aCodebaseManager.doSubRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/codebase/updateForAjax.admin", param, false, {
				success: function(data){
					aCodebaseManager.doSubRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	setListData : function(name, subName, pkColumns, listColumns, contextPath, resultObject) 
	{
		var searchElem = document.getElementById(name + "_" + subName + "_SearchForm");
		var listElem = document.getElementById(name + "_" + subName + "_ListForm");
		var bodyElem = document.getElementById(name + "_" + subName + "_ListBody");
		var iteratorElem = document.getElementById(name + "_" + subName + "_PAGE_ITERATOR");
		var messageElem = document.getElementById(name + "_" + subName + "_ListMessage");
		var selectFunc = new Function( "a" + name + ".do" + subName + "Select(this)" );
	    var tr_tag = null;
	    var td_tag = null;

		(new enview.util.CheckBoxUtil()).unChkAll( listElem );
		for(; bodyElem.hasChildNodes(); )
			bodyElem.removeChild( bodyElem.childNodes[0] );

		var page_no = searchElem.elements[ "pageNo" ].value;
		var page_size = searchElem.elements[ "pageSize" ].value;
		
		for(var i=0; i<resultObject.Data.length; i++) {
			tr_tag = document.createElement('tr');
			tr_tag.id = name + "_" + subName + "_ListForm:" + name + "[" + i + "]";
			tr_tag.onmouseover = new Function("whenListMouseOver(this)");
			tr_tag.onmouseout = new Function("whenListMouseOut(this)");
			tr_tag.setAttribute("ch", i);
			tr_tag.setAttribute("style", "cursor:pointer;");
			if( i % 2 == 0 ) {
				tr_tag.setAttribute("class", "even");
				tr_tag.setAttribute("className", "even");
			}
			else {
				tr_tag.setAttribute("class", "odd");
				tr_tag.setAttribute("className", "odd");
			}
			
			td_tag = document.createElement('td');
			td_tag.align = "center";
			td_tag.setAttribute("class", "webgridbody");
			td_tag.setAttribute("className", "webgridbody");
			td_tag.innerHTML = "<input type=\"checkbox\" id=\"" + name + "_" + subName + "[" + i + "].checkRow\" class=\"webcheckbox\"/>";
			for(var j=0; j<pkColumns.length; j++) {
				td_tag.innerHTML += "<input type=\"hidden\" id=\"" + name + "_" + subName + "[" + i + "]." + pkColumns[j] + "\" value=\"" + eval("("+"resultObject.Data[ i ]." + pkColumns[j] + ")") + "\"/>";
			}
			tr_tag.appendChild( td_tag );
			
			td_tag = document.createElement('td');
			td_tag.setAttribute("class", "webgridbody");
			td_tag.setAttribute("className", "webgridbody");
			td_tag.innerHTML = "<span>" + (((page_no-1) * page_size) + i + 1) + "</span>";
			tr_tag.appendChild( td_tag );
		
			for(var j=0; j<listColumns.length; j++) {
				td_tag = document.createElement('td');
				td_tag.setAttribute("class", "webgridbody");
				td_tag.setAttribute("className", "webgridbody");
				td_tag.onclick = selectFunc;
				td_tag.align = "left";
				td_tag.innerHTML += "<span class=\"webgridrowlabel\">&nbsp;" + eval("("+"resultObject.Data[ i ]." + listColumns[j] + ")") + "</span>";
				//alert(td_tag.innerHTML);
				tr_tag.appendChild( td_tag );
			}

			bodyElem.appendChild( tr_tag );
		}

		if( messageElem ) {
			if(resultObject.Data.length == 0) {
				messageElem.innerHTML = "" + portalPage.getMessageResource('ev.info.notFoundData') + "";
			}
			else {
				messageElem.innerHTML = "" + portalPage.getMessageResourceByParam('ev.info.resultSize', resultObject.TotalSize) + "";
			}
		}
		if( iteratorElem ) {
			var pageNo = searchElem.elements[ "pageNo" ].value;
			var pageSize = searchElem.elements[ "pageSize" ].value;
			var pageFunction = searchElem.elements[ "pageFunction" ].value;
			var formName = searchElem.elements[ "formName" ].value;
			iteratorElem.innerHTML = 
					(new enview.util.PageNavigationUtil()).getPageIteratorHtmlString(pageNo, pageSize, resultObject.TotalSize, formName, pageFunction, contextPath);
		}
	}
}
