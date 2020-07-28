
var aPortletDefinitionManager = null;
PortletDefinitionManager = function(evSecurityCode)
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
PortletDefinitionManager.prototype =
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
			{"fieldName":"expirationCache", "validation":"Required"}
			,{"fieldName":"name", "validation":"Required,MaxLength", "maxLength":"25"}
			,{"fieldName":"className", "validation":"Required,MaxLength", "maxLength":"255"}
			,{"fieldName":"resourceBundle", "validation":"MaxLength", "maxLength":"100"}
			,{"fieldName":"applicationName", "validation":"Required"}
			,{"fieldName":"applicationTitle", "validation":"Required"}
			,{"labelName":"keywords", "fieldName":"keywords", "validation":"Required,MaxLength", "maxLength":"200"}
			,{"labelName":"title", "fieldName":"title1", "validation":"Required,MaxLength", "maxLength":"300"}
			,{"labelName":"icon", "fieldName":"iconName3", "validation":"Required"}
			,{"labelName":"description", "fieldName":"description2", "validation":"Required,MaxLength", "maxLength":"200"}
		]
		
		$(function() {
			$("#PortletDefinitionManager_propertyTabs").tabs();
		});
		
		$.datepicker.setDefaults({
			showMonthAfterYear: true,
			changeMonth: true,
			changeYear: true,
			showButtonPanel: true,
			showAnim : 'slideDown',
			dateFormat : 'yy-mm-dd'
		});
		
		aPortletApplicationManager.doDefaultSelect();
	},
	getPortletCategoryChooser : function () {
		if( aPortletCategoryChooser == null ) {
			aPortletCategoryChooser = new PortletCategoryChooser( aPortletDefinitionManager.m_evSecurityCode );
		}
		return aPortletCategoryChooser;
	},
	setPortletCategoryChooserCallback : function (rowArray) {
		//alert("chooseValue=" + rowArray[0].get("categoryId"));
		if( rowArray[0].get("categoryId") ) {
			aPortletDefinitionManager.doChangeCategory( rowArray[0].get("categoryId") );
		}
	},
	getIconChooser : function () {
		if( aIconChooser == null ) {
			aIconChooser = new IconChooser( aPortletDefinitionManager.m_evSecurityCode );
		}
		return aIconChooser;
	},
	setIconChooserCallback : function (rowArray) {
		document.getElementById("PortletDefinitionManager_iconName3").value = rowArray[0].get("iconName");
	},
	onSelectPropertyTab : function (id) {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		param += "portletName=" + document.getElementById("PortletDefinitionManager_name").value;
		param += "&applicationName=" + document.getElementById("PortletDefinitionManager_applicationName").value;
		switch(id) {
			case 0 : 
				break;
			case 1 :
				if( aPortletParamManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/portletDefinition/portletParam/list.admin", param, false, {
						success: function(data){
							document.getElementById("PortletDefinitionManager_PortletParamTabPage").innerHTML = data;
							aPortletParamManager = new PortletParamManager( aPortletDefinitionManager.m_evSecurityCode );
							aPortletParamManager.init();
							
							document.getElementById("PortletParamManager_applicationName").value = document.getElementById("PortletDefinitionManager_applicationName").value; 
							document.getElementById("PortletParamManager_portletName").value = document.getElementById("PortletDefinitionManager_name").value; 
							aPortletParamManager.doRetrieve();
						}});
				}
				else {
					document.getElementById("PortletParamManager_applicationName").value = document.getElementById("PortletDefinitionManager_applicationName").value; 
					document.getElementById("PortletParamManager_portletName").value = document.getElementById("PortletDefinitionManager_name").value; 
					aPortletParamManager.initSearch();
					aPortletParamManager.doRetrieve();
				}
				break;
			case 2 :
				if( aPortletMetadataManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/portletDefinition/portletMetadata/list.admin", param, false, {
						success: function(data){
							document.getElementById("PortletDefinitionManager_PortletMetadataTabPage").innerHTML = data;
							aPortletMetadataManager = new PortletMetadataManager( aPortletDefinitionManager.m_evSecurityCode );
							aPortletMetadataManager.init();
							
							document.getElementById("PortletMetadataManager_applicationName").value = document.getElementById("PortletDefinitionManager_applicationName").value; 
							document.getElementById("PortletMetadataManager_portletName").value = document.getElementById("PortletDefinitionManager_name").value; 
							aPortletMetadataManager.doRetrieve();
						}});
				}
				else {
					document.getElementById("PortletMetadataManager_applicationName").value = document.getElementById("PortletDefinitionManager_applicationName").value; 
					document.getElementById("PortletMetadataManager_portletName").value = document.getElementById("PortletDefinitionManager_name").value; 
					aPortletMetadataManager.initSearch();
					aPortletMetadataManager.doRetrieve();
				}
				break;
			case 3 :
				if( aPortletTypeManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/portletDefinition/portletType/list.admin", param, false, {
						success: function(data){
							document.getElementById("PortletDefinitionManager_PortletTypeTabPage").innerHTML = data;
							aPortletTypeManager = new PortletTypeManager( aPortletDefinitionManager.m_evSecurityCode );
							aPortletTypeManager.init();
							
							document.getElementById("PortletTypeManager_applicationName").value = document.getElementById("PortletDefinitionManager_applicationName").value; 
							document.getElementById("PortletTypeManager_portletName").value = document.getElementById("PortletDefinitionManager_name").value; 
							aPortletTypeManager.doRetrieve();
						}});
				}
				else {
					document.getElementById("PortletTypeManager_applicationName").value = document.getElementById("PortletDefinitionManager_applicationName").value; 
					document.getElementById("PortletTypeManager_portletName").value = document.getElementById("PortletDefinitionManager_name").value; 
					aPortletTypeManager.initSearch();
					aPortletTypeManager.doRetrieve();
				}
				break;
			case 4 :
				if( aPortletOptionManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/portletDefinition/portletOption/list.admin", param, false, {
						success: function(data){
							document.getElementById("PortletDefinitionManager_PortletOptionTabPage").innerHTML = data;
							aPortletOptionManager = new PortletOptionManager( aPortletDefinitionManager.m_evSecurityCode );
							aPortletOptionManager.init();
							
							document.getElementById("PortletOptionManager_applicationName").value = document.getElementById("PortletDefinitionManager_applicationName").value; 
							document.getElementById("PortletOptionManager_portletName").value = document.getElementById("PortletDefinitionManager_name").value; 
							aPortletOptionManager.doRetrieve();
						}});
				}
				else {
					document.getElementById("PortletOptionManager_applicationName").value = document.getElementById("PortletDefinitionManager_applicationName").value; 
					document.getElementById("PortletOptionManager_portletName").value = document.getElementById("PortletDefinitionManager_name").value; 
					aPortletOptionManager.initSearch();
					aPortletOptionManager.doRetrieve();
				}
				break;
		}
		
		return true; 
	},
	initSearch : function () {
		var formElem = document.forms[ "PortletDefinitionManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		this.m_selectRowIndex = 0;
		//formElem.elements[ "pageSize" ].value = 10;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "PortletDefinitionManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		var allCond = document.getElementById("PortletDefinitionManager_allCond");
		if( allCond.checked == true ) {
			param += "&allCond=true";
		}
		else {
			param += "&allCond=false";
		}
		
		var unServiceableCond = document.getElementById("PortletDefinitionManager_unServiceableCond");
		if( unServiceableCond.checked == true ) {
			param += "&unServiceableCond=true";
		}
		else {
			param += "&unServiceableCond=false";
		}
		
		this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/portletDefinition/listForAjax.admin", param, false, {success: function(data) { aPortletDefinitionManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"PortletDefinitionManager",
			new Array('applicationName0', 'name'),
			new Array('applicationTitle', 'name', 'title1'),
			this.m_contextPath,
			resultObject);
				
		if(resultObject.Data.length != 0) {
			this.doDefaultSelect(); 
		}
		var unServiceableCond = document.getElementById("PortletDefinitionManager_unServiceableCond");
		if( unServiceableCond.checked == true ) {
			document.getElementById("PortletDefinitionManager_Active").style.display = "";
		}
		else {
			document.getElementById("PortletDefinitionManager_Active").style.display = "none";
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
		var formElem = document.forms[ "PortletDefinitionManager_SearchForm" ];
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
		//alert(1);
		document.getElementById('PortletDefinitionManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "name=";
		param += document.getElementById('PortletDefinitionManager[' + this.m_selectRowIndex + '].name').value;
		param += "&applicationName=";
		param += document.getElementById('PortletDefinitionManager[' + this.m_selectRowIndex + '].applicationName0').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/portletDefinition/detailForAjax.admin", param, false, {success: function(data) { aPortletDefinitionManager.doSelectHandler(data); }});
	},
	doSelect : function (obj)
	{
		//alert(2);
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
		
	    this.m_checkBox.unChkAll( document.getElementById("PortletDefinitionManager_ListForm") );
	    document.getElementById('PortletDefinitionManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "name=";
		param += document.getElementById('PortletDefinitionManager[' + rowSeq + '].name').value;
		param += "&applicationName=";
		param += document.getElementById('PortletDefinitionManager[' + rowSeq + '].applicationName0').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/portletDefinition/detailForAjax.admin", param, false, {success: function(data) { aPortletDefinitionManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "PortletDefinitionManager", resultObject);
		//alert("1 id=" + resultObject.applicationName);
		//document.getElementById("PortletDefinitionManager_applicationName").value = resultObject.applicationName;
		document.getElementById("PortletDefinitionManager_name").readOnly = true;
		
		var propertyTabs = $("#PortletDefinitionManager_propertyTabs").tabs();
	 
		propertyTabs.tabs('enable', 0);	 
		propertyTabs.tabs('enable', 1);	 
		propertyTabs.tabs('enable', 2);	 
		propertyTabs.tabs('enable', 3);	 
		propertyTabs.tabs('enable', 4);	 
		propertyTabs.tabs('enable', 5);	 
		propertyTabs.tabs('enable', 6);	 
		propertyTabs.tabs('enable', 7);	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("PortletDefinitionManager_EditFormPanel").style.display = '';
		//document.getElementById("PortletDefinitionManager_ClassName_Select").style.display = "none";
		//alert("2 id=" + resultObject.applicationName);
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "PortletDefinitionManager");
		document.getElementById("PortletDefinitionManager_name").readOnly = false;
		document.getElementById("PortletDefinitionManager_expirationCache").value = "0";
		document.getElementById("PortletDefinitionManager_className").value = "com.saltware.enview.portlet.common.DynamicContentPortlet";
		document.getElementById("PortletDefinitionManager_applicationName").value = document.getElementById("PortletDefinitionManager_Master_applicationName").value;
		document.getElementById("PortletDefinitionManager_applicationTitle").value = document.getElementById("PortletDefinitionManager_Master_applicationTitle").value;
		document.getElementById("PortletDefinitionManager_ClassName_Select").value = "com.saltware.enview.portlet.common.DynamicContentPortlet";
		
		var propertyTabs = $("#PortletDefinitionManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	 
		propertyTabs.tabs('disable', 1);	 
		propertyTabs.tabs('disable', 2);	 
		propertyTabs.tabs('disable', 3);	 
		propertyTabs.tabs('disable', 4);	 
		propertyTabs.tabs('disable', 5);	 
		propertyTabs.tabs('disable', 6);	 
		propertyTabs.tabs('disable', 7);	 
		document.getElementById("PortletDefinitionManager_EditFormPanel").style.display = '';
		//document.getElementById("PortletDefinitionManager_ClassName_Select").style.display = "";
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var param = "";
		var isCreate = document.getElementById("PortletDefinitionManager_isCreate").value;
		var form = document.getElementById("PortletDefinitionManager_EditForm");
		
		//document.getElementById("PortletDefinitionManager_applicationId").value = document.getElementById("PortletDefinitionManager_applicationName").value;
		//alert(document.getElementById("PortletDefinitionManager_applicationId").value);

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";
		//alert("param=" + param);
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/portletDefinition/addForAjax.admin", param, false, {
				success: function(data){
					aPortletDefinitionManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/portletDefinition/updateForAjax.admin", param, false, {
				success: function(data){
					aPortletDefinitionManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PortletDefinitionManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('PortletDefinitionManager[' + rowCntArray[i] + '].applicationName0').value + ":" +
					document.getElementById('PortletDefinitionManager[' + rowCntArray[i] + '].name').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/portletDefinition/removeForAjax.admin", param, false, {
				success: function(data){
					aPortletDefinitionManager.initSearch();
					aPortletDefinitionManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	},
	doActive : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PortletDefinitionManager_ListForm") );
		if( rowCnts == "" ) return;
		
		var rowCntArray = rowCnts.split(",");
		var ret = confirm( portalPage.getMessageResource('ev.info.active') );
	    if( ret == true ) {
	        var formData = "";
			
			var param = "evSecurityCode=" + this.m_evSecurityCode; 
			for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += document.getElementById('PortletDefinitionManager[' + rowCntArray[i] + '].applicationName0').value;
				param += document.getElementById('PortletDefinitionManager[' + rowCntArray[i] + '].name').value;
	        }
			this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/portletDefinition/activeForAjax.admin", param, false, {
				success: function(data){
					aPortletApplicationManager.m_selectRowIndex = 0;
					aPortletApplicationManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.successUpdate') );
				}});
			
		}
	},
	changeSelectItem : function(obj) {
		document.getElementById("PortletDefinitionManager_className").value = obj.options[obj.selectedIndex].value;
	},
	selectKeyword : function(obj) {
		var keywords = document.getElementById("PortletDefinitionManager_keywords").value;
		if( keywords != null && keywords.length > 0 ) {
			keywords += "," + obj.options[obj.selectedIndex].value;
		}
		else {
			keywords = obj.options[obj.selectedIndex].value;
		}
		document.getElementById("PortletDefinitionManager_keywords").value = keywords;
	}
}

aIconChooser = null;
IconChooser = function(evSecurityCode)
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	if( portalPage == null) portalPage = new enview.portal.Page();
	this.m_selectRowIndex = 0;
	this.m_evSecurityCode = evSecurityCode;
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = portalPage.getContextPath();
	this.m_domElement = document.getElementById("PortletDefinitionManager_IconChooser");
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
	
	$("#PortletDefinitionManager_IconChooser").dialog({
		autoOpen: false,
		resizable: false,
		width:540, 
		height:400,
		modal: true,
		buttons: {
			Cancel: function() {
				$(this).dialog('close');
			}
		}
	});
}
IconChooser.prototype =
{
	m_parent : null,
	m_domElement : null,
	m_retrieveHandler : null,
	m_createHandler : null,
	m_applyElementName : null,
	m_evSecurityCode : null,
	
	doShow : function (callback)
	{
		this.m_callback = callback;
		this.doRetrieve();
		$('#PortletDefinitionManager_IconChooser').dialog('open');
	},
	doRetrieve : function () {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "IconChooser_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/portletApplication/portletDefinition/listIconForAjax.admin", param, false, {success: function(data) { aIconChooser.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function(resultObject)
	{
		var divElem = document.getElementById('IconChooser_IconListBody');
		var htmlString = "";

		htmlString += "<div style='padding:4px;'>";
		htmlString += "<table width='100%' height='95%' border='0' cellspacing='0' cellpadding='0'>";  
		for(i=0; i<resultObject.Data.length; i++) {
			
			if( (i % 5) == 0 ) {  
				if( i > 0 ) {
					htmlString += "</tr>";
				}
				else {
					htmlString += "<tr>";
				}
			}

			htmlString += "<td align='center'>";
			htmlString += "<a href=\"javascript:aPortletDefinitionManager.getIconChooser().doApply('" + resultObject.Data[i].iconName + "')\"><img src='" + this.m_contextPath + "/"  +  resultObject.IconPath + "/" + resultObject.Data[i].iconName + "'></a>";
			htmlString += "</td>";
		}
		htmlString += "</table>";
		htmlString += "</div>";
		
		//alert("htmlString=" + htmlString);
		divElem.innerHTML = htmlString;
		
		var formElem = document.forms[ "IconChooser_SearchForm" ];
		var pageNo = formElem.elements[ "pageNo" ].value;
		var pageSize = formElem.elements[ "pageSize" ].value;
		var pageFunction = formElem.elements[ "pageFunction" ].value;
		var formName = formElem.elements[ "formName" ].value;
		document.getElementById("IconChooser_PAGE_ITERATOR").innerHTML = 
				(new enview.util.PageNavigationUtil()).getPageIteratorHtmlString(pageNo, pageSize, resultObject.TotalSize, formName, pageFunction);
	},
	doPage : function (formName, pageNo)
	{
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = pageNo;
		
		this.doRetrieve();
	},
	doSelect : function (obj)
	{

	},
	doApply : function (iconName)
	{
		//alert(iconName);
		$('#PortletDefinitionManager_IconChooser').dialog('close');
		
		var result = new Array(1);
		var rowMap = new Map();
		rowMap.put("iconName", iconName);	
		result[0] = rowMap;
		
		this.m_callback(result);
	}
}
