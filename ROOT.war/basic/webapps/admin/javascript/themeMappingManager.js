
var aThemeMappingManager = null;
ThemeMappingManager = function(evSecurityCode)
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
ThemeMappingManager.prototype =
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
			{"fieldName":"principalId", "validation":"Required"}
			,{"fieldName":"seasonType", "validation":"Required"}
			,{"fieldName":"pageType", "validation":"Required"}
			,{"fieldName":"themeName", "validation":"Required"}
			,{"fieldName":"groupId", "validation":""}
			
		]
		
		$(function() {
			$("#ThemeMappingManager_propertyTabs").tabs();
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
		if( aGroupChooser == null ) {
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
			this.m_ajax.send("POST", this.m_contextPath + "/group/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("GroupManager_GroupChooser").innerHTML = data;
					aGroupChooser = new GroupChooser( aThemeMappingManager.m_evSecurityCode );
				}});
		}
		return aGroupChooser;
	},
	setGroupChooserCallback : function (rowArray) {
		document.getElementById("ThemeMappingManager_principalId").value = rowArray[0].get("principalId");	
		document.getElementById("ThemeMappingManager_groupId").value = rowArray[0].get("groupId");
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
		var formElem = document.forms[ "ThemeMappingManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "ThemeMappingManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/themeMapping/listForAjax.admin", param, false, {success: function(data) { aThemeMappingManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"ThemeMappingManager",
			new Array('principalId', 'seasonType', 'pageType'),
			new Array('groupId', 'seasonType', 'pageType', 'themeName'),
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
		var formElem = document.forms[ "ThemeMappingManager_SearchForm" ];
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
		document.getElementById('ThemeMappingManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "principalId=";
		param += document.getElementById('ThemeMappingManager[' + this.m_selectRowIndex + '].principalId').value;
		param += "&seasonType=";
		param += document.getElementById('ThemeMappingManager[' + this.m_selectRowIndex + '].seasonType').value;
		param += "&pageType=";
		param += document.getElementById('ThemeMappingManager[' + this.m_selectRowIndex + '].pageType').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/themeMapping/detailForAjax.admin", param, false, {success: function(data) { aThemeMappingManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("ThemeMappingManager_ListForm") );
	    document.getElementById('ThemeMappingManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "principalId=";
		param += document.getElementById('ThemeMappingManager[' + rowSeq + '].principalId').value;
		param += "&seasonType=";
		param += document.getElementById('ThemeMappingManager[' + rowSeq + '].seasonType').value;
		param += "&pageType=";
		param += document.getElementById('ThemeMappingManager[' + rowSeq + '].pageType').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/themeMapping/detailForAjax.admin", param, false, {success: function(data) { aThemeMappingManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "ThemeMappingManager", resultObject);
		
		document.getElementById("ThemeMappingManager_groupId").disabled = true;
		document.getElementById("ThemeMappingManager_seasonType").disabled = true;
		document.getElementById("ThemeMappingManager_pageType").disabled = true;
		document.getElementById("ThemeMappingManager_groupId_select").style.display = "none";
		
		var propertyTabs = $("#ThemeMappingManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("ThemeMappingManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "ThemeMappingManager");
		
		var propertyTabs = $("#ThemeMappingManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	
		document.getElementById("ThemeMappingManager_groupId").disabled = false;
		document.getElementById("ThemeMappingManager_seasonType").disabled = false;
		document.getElementById("ThemeMappingManager_pageType").disabled = false;
		document.getElementById("ThemeMappingManager_groupId_select").style.display = "";
		document.getElementById("ThemeMappingManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var param = "";
		var isCreate = document.getElementById("ThemeMappingManager_isCreate").value;
		var form = document.getElementById("ThemeMappingManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/themeMapping/addForAjax.admin", param, false, {
				success: function(data){
					aThemeMappingManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/themeMapping/updateForAjax.admin", param, false, {
				success: function(data){
					aThemeMappingManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("ThemeMappingManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('ThemeMappingManager[' + rowCntArray[i] + '].principalId').value + ":" +
					document.getElementById('ThemeMappingManager[' + rowCntArray[i] + '].seasonType').value + ":" +
					document.getElementById('ThemeMappingManager[' + rowCntArray[i] + '].pageType').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/themeMapping/removeForAjax.admin", param, false, {
				success: function(data){
					aThemeMappingManager.initSearch();
					aThemeMappingManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	}
	
}

