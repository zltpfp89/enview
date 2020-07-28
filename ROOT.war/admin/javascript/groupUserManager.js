
var aGroupUserManager = null;
GroupUserManager = function(evSecurityCode)
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
GroupUserManager.prototype =
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
			,{"fieldName":"groupId", "validation":""}
			,{"fieldName":"shortPath", "validation":""}
			,{"fieldName":"principalName0", "validation":""}
			,{"fieldName":"mileageTag", "validation":""}
			,{"fieldName":"sortOrder", "validation":"MaxLength", "maxLength":"10"}
			
		]
		
		$(function() {
			$("#GroupUserManager_propertyTabs").tabs();
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
		var domainId = $('#GroupManager_Master_domainId').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId;
		var extraParam = "&byDomain=Y&existsDomain=Y&";
		extraParam += "&byGroup=Y&existsGroup=N&";
		extraParam += "&groupId=" + $('#GroupUserManager_Master_groupId').val() + "&"; 
//		if( aUserChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/user/listForChooser.admin", param, false, {
				success: function(data){
					document.getElementById("UserManager_UserChooser").innerHTML = data;
					aUserChooser = new UserChooser( aGroupUserManager.m_evSecurityCode, domainId, extraParam );
				}});
//		}
		return aUserChooser;
	},
	setUserChooserCallback : function (rowArray) {
		var domainId = $('#GroupManager_Master_domainId').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId;
		for(var i=0; i<rowArray.length; i++) {
			param += "&pks=";
			param += rowArray[i].get("principalId") + ":" + document.getElementById("GroupManager_principalId").value;
		}
		//alert("param" + param);
		this.m_ajax.send("POST", this.m_contextPath + "/group/groupUser/addForAjax.admin", param, false, {
				success: function(data){
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
					aGroupUserManager.doRetrieve();
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
		var formElem = document.forms[ "GroupUserManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "GroupUserManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/group/groupUser/listForAjax.admin", param, false, {success: function(data) { aGroupUserManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"GroupUserManager",
			new Array('userId', 'groupId'),
			new Array('shortPath', 'principalName0'),
			this.m_contextPath,
			resultObject);
				
		if(resultObject.Data.length != 0) {
			this.doDefaultSelect(); 
		}
		if($('#isAdmin').val() == 'true' || $('#GroupManager_Master_domainId').val() != 0){
			 if($('#GroupManager_principalId').val() != 100) $('.GroupUserManager_EditFormButtons').css('display', 'block');
			 else $('.GroupUserManager_EditFormButtons').css('display', 'none');
		}else {
			$('.GroupUserManager_EditFormButtons').css('display', 'none');
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
		var formElem = document.forms[ "GroupUserManager_SearchForm" ];
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
		document.getElementById('GroupUserManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "userId=";
		param += document.getElementById('GroupUserManager[' + this.m_selectRowIndex + '].userId').value;
		param += "&groupId=";
		param += document.getElementById('GroupUserManager[' + this.m_selectRowIndex + '].groupId').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/group/groupUser/detailForAjax.admin", param, false, {success: function(data) { aGroupUserManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("GroupUserManager_ListForm") );
	    document.getElementById('GroupUserManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "userId=";
		param += document.getElementById('GroupUserManager[' + rowSeq + '].userId').value;
		param += "&groupId=";
		param += document.getElementById('GroupUserManager[' + rowSeq + '].groupId').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/group/groupUser/detailForAjax.admin", param, false, {success: function(data) { aGroupUserManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "GroupUserManager", resultObject);
		
	
		
		
		var propertyTabs = $("#GroupUserManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("GroupUserManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "GroupUserManager");
		
		var propertyTabs = $("#GroupUserManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	 
		document.getElementById("GroupUserManager_groupId").value = document.getElementById("GroupUserManager_Master_groupId").value; 
		document.getElementById("GroupUserManager_userId").readOnly = false;
		document.getElementById("GroupUserManager_groupId").readOnly = false;
		document.getElementById("GroupUserManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("GroupUserManager_isCreate").value;
		var form = document.getElementById("GroupUserManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var domainId = $('#GroupManager_Master_domainId').val();
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId;
		
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/group/groupUser/addForAjax.admin", param, false, {
				success: function(data){
					aGroupUserManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/group/groupUser/updateForAjax.admin", param, false, {
				success: function(data){
					aGroupUserManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("GroupUserManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
	        var domainId = $('#GroupManager_Master_domainId').val();
			var param = "evSecurityCode=" + this.m_evSecurityCode;
			param += "&domainId=" + domainId;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('GroupUserManager[' + rowCntArray[i] + '].userId').value + ":" +
					document.getElementById('GroupUserManager[' + rowCntArray[i] + '].groupId').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/group/groupUser/removeForAjax.admin", param, false, {
				success: function(data){
					aGroupUserManager.initSearch();
					aGroupUserManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	}
	
}

