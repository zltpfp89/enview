
var aSecurityPolicyManager = null;
SecurityPolicyManager = function(evSecurityCode)
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
SecurityPolicyManager.prototype =
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
			{"fieldName":"policyId", "validation":""}
			,{"fieldName":"ipaddress1", "validation":"Required"}
			,{"fieldName":"ipaddress2", "validation":"Required"}
			,{"fieldName":"ipaddress3", "validation":"Required"}
			,{"fieldName":"ipaddress4", "validation":"Required"}
			,{"fieldName":"authMethod", "validation":""}
			,{"fieldName":"isAllow", "validation":""}
			,{"fieldName":"isEnabled", "validation":""}
			,{"fieldName":"startDate", "validation":""}
			,{"fieldName":"endDate", "validation":""}
		]
		
		$(function() {
			$("#SecurityPolicyManager_propertyTabs").tabs();
		});
		
		$.datepicker.setDefaults({
			showMonthAfterYear: true,
			changeMonth: true,
			changeYear: true,
			showButtonPanel: true,
			showAnim : 'slideDown',
			dateFormat : 'yy-mm-dd'
		});
		
		
		$('#SecurityPolicyManager_startDate').datepicker();	
		$('#SecurityPolicyManager_endDate').datepicker();	
		
	},
	getPageChooser : function () {
		if( aPageChooser == null ) {
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
			this.m_ajax.send("POST", this.m_contextPath + "/page/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("PageManager_PageChooser").innerHTML = data;
					aPageChooser = new PageChooser( aSecurityPolicyManager.m_evSecurityCode );
				}});
		}
		return aPageChooser;
	},
	setPageChooserCallback : function (rowArray) {
		//document.getElementById("PageManager_defaultPageName").value = rowArray[0].get("pageId");
		document.getElementById("securityPolicyManager_resUrl").value = rowArray[0].get("pagePath");
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
		var formElem = document.forms[ "SecurityPolicyManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "SecurityPolicyManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/securityPolicy/listForAjax.admin", param, false, {success: function(data) { aSecurityPolicyManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"SecurityPolicyManager",
			new Array('policyId'),
			new Array('policyId', 'ipaddress', 'startDate'),
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
		var formElem = document.forms[ "SecurityPolicyManager_SearchForm" ];
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
		if( document.getElementById('SecurityPolicyManager[' + this.m_selectRowIndex + '].checkRow') == null ) {
			this.doCreate();
			return;
		}
		
		document.getElementById('SecurityPolicyManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "policyId=";
		param += document.getElementById('SecurityPolicyManager[' + this.m_selectRowIndex + '].policyId').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/securityPolicy/detailForAjax.admin", param, false, {success: function(data) { aSecurityPolicyManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("SecurityPolicyManager_ListForm") );
	    document.getElementById('SecurityPolicyManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "policyId=";
		param += document.getElementById('SecurityPolicyManager[' + rowSeq + '].policyId').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/securityPolicy/detailForAjax.admin", param, false, {success: function(data) { aSecurityPolicyManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		//this.m_utility.setFormDataFromXML(this.m_dataStructure, "SecurityPolicyManager", resultObject);
		document.getElementById("SecurityPolicyManager_isCreate").value = "false";
		document.getElementById("SecurityPolicyManager_policyId").value = portalPage.getAjax().retrieveElementValue("policyId", resultObject);
		var ipaddress = portalPage.getAjax().retrieveElementValue("ipaddress", resultObject)
		var ipaddrArray = ipaddress.split(".");
		document.getElementById("securityPolicyManager_ipaddress1").value = ipaddrArray[0];
		document.getElementById("securityPolicyManager_ipaddress2").value = ipaddrArray[1];
		document.getElementById("securityPolicyManager_ipaddress3").value = ipaddrArray[2];
		document.getElementById("securityPolicyManager_ipaddress4").value = ipaddrArray[3];
		//document.getElementById("SecurityPolicyManager_resUrl").value = resultObject.resUrl;
		document.getElementById("SecurityPolicyManager_authMethod").value = portalPage.getAjax().retrieveElementValue("authMethod", resultObject);
		document.getElementById("SecurityPolicyManager_isAllow").checked = (portalPage.getAjax().retrieveElementValue("isAllow", resultObject) == "true") ? true : false;
		document.getElementById("SecurityPolicyManager_isEnabled").checked = (portalPage.getAjax().retrieveElementValue("isEnabled", resultObject) == "true") ? true : false;
		var stdv = portalPage.getAjax().retrieveElementValue("startDate", resultObject);
		//alert(stdv);
		var std = new Date( new Number(stdv) );
		//alert(std.getDateString("YYYY-MM-DD"));
		document.getElementById("SecurityPolicyManager_startDate").value =std.getDateString("YYYY-MM-DD"); 
		document.getElementById("SecurityPolicyManager_startHour").value = std.getDateString("hh");
		document.getElementById("SecurityPolicyManager_startMin").value = std.getDateString("mm");
		var eddv = portalPage.getAjax().retrieveElementValue("endDate", resultObject);
		var edd = new Date( new Number(eddv) );
		document.getElementById("SecurityPolicyManager_endDate").value = edd.getDateString("YYYY-MM-DD"); 
		document.getElementById("SecurityPolicyManager_endHour").value = edd.getDateString("hh");
		document.getElementById("SecurityPolicyManager_endMin").value = edd.getDateString("mm");
	
		document.getElementById("SecurityPolicyManager_policyId").readOnly = true;
		
		
		var propertyTabs = $("#SecurityPolicyManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("SecurityPolicyManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		//this.m_utility.initFormData(this.m_dataStructure, "SecurityPolicyManager");
		document.getElementById("SecurityPolicyManager_isCreate").value = "true";
		document.getElementById("securityPolicyManager_ipaddress1").value = "";
		document.getElementById("securityPolicyManager_ipaddress2").value = "";
		document.getElementById("securityPolicyManager_ipaddress3").value = "";
		document.getElementById("securityPolicyManager_ipaddress4").value = "";
		
		document.getElementById("securityPolicyManager_resUrl").value = "";
		//document.getElementById("SecurityPolicyManager_authMethod").value = "";
		document.getElementById("SecurityPolicyManager_isAllow").checked = true;
		document.getElementById("SecurityPolicyManager_isEnabled").checked = true;
		
		var std = new Date();
		//alert(std.getDateString("YYYY-MM-DD"));
		document.getElementById("SecurityPolicyManager_startDate").value =std.getDateString("YYYY-MM-DD"); 
		document.getElementById("SecurityPolicyManager_startHour").value = std.getDateString("hh");
		document.getElementById("SecurityPolicyManager_startMin").value = std.getDateString("mm");
		var edd = new Date();
		document.getElementById("SecurityPolicyManager_endDate").value = edd.getDateString("YYYY-MM-DD"); 
		document.getElementById("SecurityPolicyManager_endHour").value = edd.getDateString("hh");
		document.getElementById("SecurityPolicyManager_endMin").value = edd.getDateString("mm");
		
		var propertyTabs = $("#SecurityPolicyManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	
		document.getElementById("SecurityPolicyManager_policyId").readOnly = true;
		document.getElementById("SecurityPolicyManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var param = "";
		var isCreate = document.getElementById("SecurityPolicyManager_isCreate").value;
		var form = document.getElementById("SecurityPolicyManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		//var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";	
		param = "policyId=" + document.getElementById("SecurityPolicyManager_policyId").value;
		param += "&isAllow=" + ((document.getElementById("SecurityPolicyManager_isAllow").checked == true) ? "true" : "false");
		param += "&isEnabled=" + ((document.getElementById("SecurityPolicyManager_isEnabled").checked == true) ? "true" : "false");
		param += "&authMethod=" + document.getElementById("SecurityPolicyManager_authMethod").value;
		
		/*
		var resUrl = document.getElementById("SecurityPolicyManager_resUrl").value;
		if( resUrl != null && resUrl.length == 0 ) {
			var fieldName = portalPage.getMessageResource('pt.ev.property.resUrl');
			var msg = portalPage.getMessageResourceByParam('ev.error.validation.required', fieldName);
			alert( msg );
			document.getElementById("SecurityPolicyManager_resUrl").focus();
			return;
		}
		param += "&resUrl=" + document.getElementById("SecurityPolicyManager_resUrl").value;
		*/
		param += "&resUrl=/"
				
		param += "&ipaddress=" + 
			document.getElementById("securityPolicyManager_ipaddress1").value + "." +
			document.getElementById("securityPolicyManager_ipaddress2").value + "." +
			document.getElementById("securityPolicyManager_ipaddress3").value + "." +
			document.getElementById("securityPolicyManager_ipaddress4").value;
		
		var stdv = document.getElementById("SecurityPolicyManager_startDate").value;
		var stdvArray = stdv.split("-");
		var std = new Date( stdvArray[0], stdvArray[1]-1, stdvArray[2], document.getElementById("SecurityPolicyManager_startHour").value, document.getElementById("SecurityPolicyManager_startMin").value, 0 );
		
		var eddv = document.getElementById("SecurityPolicyManager_endDate").value;
		var eddvArray = eddv.split("-");
		var edd = new Date( eddvArray[0], eddvArray[1]-1, eddvArray[2], document.getElementById("SecurityPolicyManager_endHour").value, document.getElementById("SecurityPolicyManager_endMin").value, 0 );
		
		if( (edd.getTime()-std.getTime()) < 0 ) {
			alert( portalPage.getMessageResource('pt.ev.error.range.date') );
			return;
		}
		
		param += "&startDate=" + std.getTime();
		param += "&endDate=" + edd.getTime(); 
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/securityPolicy/addForAjax.admin", param, false, {
				success: function(data){
					if( forDetail == null || forDetail == false ) {
						aSecurityPolicyManager.doRetrieve();
					}
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/securityPolicy/updateForAjax.admin", param, false, {
				success: function(data){
					if( forDetail == null || forDetail == false ) {
						aSecurityPolicyManager.doRetrieve();
					}
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("SecurityPolicyManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('SecurityPolicyManager[' + rowCntArray[i] + '].policyId').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/securityPolicy/removeForAjax.admin", param, false, {
				success: function(data){
					aSecurityPolicyManager.initSearch();
					aSecurityPolicyManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	}
	
}
