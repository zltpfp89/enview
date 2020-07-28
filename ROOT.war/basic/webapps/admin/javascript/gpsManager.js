var aUserManager = null;
UserManager = function(evSecurityCode)
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
UserManager.prototype =
{
	m_ajax : null,
	m_checkBox : null,
	m_validator : null,
	m_utility : null,
	m_contextPath : null,
	m_selectRowIndex : 0,
	m_dataStructure : null,
	m_evSecurityCode : null,
	
	init : function(evSecurityCode)
	{ 
		this.m_evSecurityCode = evSecurityCode; 
		this.m_dataStructure = [
			{"fieldName":"userId", "validation":""}
			,{"fieldName":"latiTude", "validation":""}
			,{"fieldName":"longiTude", "validation":""}
			,{"fieldName":"addRess", "validation":""}
		]
		
	},
	getPageChooser : function () {
		if( aPageChooser == null ) {
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
			this.m_ajax.send("POST", this.m_contextPath + "/page/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("PageManager_PageChooser").innerHTML = data;
					aPageChooser = new PageChooser();
				}});
		}
		return aPageChooser;
	},
	setPageChooserCallback : function (rowArray) {
		//document.getElementById("PageManager_defaultPageName").value = rowArray[0].get("pageId");
		document.getElementById("UserManager_defaultPage").value = rowArray[0].get("pagePath");
	},
	getGroupChooser : function () {
		if( aGroupChooser == null ) {
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
			this.m_ajax.send("POST", this.m_contextPath + "/group/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("GroupManager_GroupChooser").innerHTML = data;
					aGroupChooser = new GroupChooser();
				}});
		}
		return aGroupChooser;
	},
	setGroupChooserCallback : function (rowArray) {
		document.getElementById("UserManager_groupIdJoinCond").value = rowArray[0].get("groupId");
	},
	getRoleChooser : function () {
		if( aRoleChooser == null ) {
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
			this.m_ajax.send("POST", this.m_contextPath + "/role/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("RoleManager_RoleChooser").innerHTML = data;
					aRoleChooser = new RoleChooser();
				}});
		}
		return aRoleChooser;
	},
	setRoleChooserCallback : function (rowArray) {
		document.getElementById("UserManager_roleIdJoinCond").value = rowArray[0].get("roleId");
	},
	onSelectPropertyTab : function (id) {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		switch(id) {
			case 0 : 
				break;
	 
			case 1 :
		
				param += "userId=" + document.getElementById("UserManager_shortPath").value;
				if( aUserpassManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/user/userpass/detail.admin", param, false, {
						success: function(data){
							document.getElementById("UserManager_UserpassTabPage").innerHTML = data;
							aUserpassManager = new UserpassManager( aUserManager.m_evSecurityCode );
							aUserpassManager.init();
						}});
				}
				
				this.m_ajax.send("POST", this.m_contextPath + "/user/userpass/detailForAjax.admin", param, false, {
					success: function(data){
						aUserpassManager.doSelectHandler( data );
					}});
			
				break;
	 
			case 2 :
		
				param += "userId=" + document.getElementById("UserManager_principalId").value;
				if( aUserGroupManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/user/userGroup/list.admin", param, false, {
						success: function(data){
							document.getElementById("UserManager_UserGroupTabPage").innerHTML = data;
							aUserGroupManager = new UserGroupManager( aUserManager.m_evSecurityCode );
							aUserGroupManager.init();
							
							document.getElementById("UserGroupManager_Master_userId").value = document.getElementById("UserManager_principalId").value; 
							aUserGroupManager.doRetrieve();
						}});
				}
				else {
					
					document.getElementById("UserGroupManager_Master_userId").value = document.getElementById("UserManager_principalId").value; 
					aUserGroupManager.initSearch();
					aUserGroupManager.doRetrieve();
				}
			
				break;
	 
			case 3 :
		
				param += "userId=" + document.getElementById("UserManager_principalId").value;
				if( aUserRoleManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/user/userRole/list.admin", param, false, {
						success: function(data){
							document.getElementById("UserManager_UserRoleTabPage").innerHTML = data;
							aUserRoleManager = new UserRoleManager( aUserManager.m_evSecurityCode );
							aUserRoleManager.init();
							
							document.getElementById("UserRoleManager_Master_userId").value = document.getElementById("UserManager_principalId").value; 
							aUserRoleManager.doRetrieve();
						}});
				}
				else {
					
					document.getElementById("UserRoleManager_Master_userId").value = document.getElementById("UserManager_principalId").value; 
					aUserRoleManager.initSearch();
					aUserRoleManager.doRetrieve();
				}
			
				break;
	 
			case 4 :
				param += "principalId=" + document.getElementById("UserManager_principalId").value;
				if( aPagePermissionManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/pagePermission/list.admin", param, false, {
						success: function(data){
							document.getElementById("UserManager_PagePermissionTabPage").innerHTML = data;
							aPagePermissionManager = new PagePermissionManager( aUserManager.m_evSecurityCode );
							aPagePermissionManager.init();
							
							document.getElementById("PagePermissionManager_Master_principalId").value = document.getElementById("UserManager_principalId").value; 
							aPagePermissionManager.doRetrieve();
						}});
				}
				else {
					
					document.getElementById("PagePermissionManager_Master_principalId").value = document.getElementById("UserManager_principalId").value; 
					aPagePermissionManager.initSearch();
					aPagePermissionManager.doRetrieve();
				}
			
				break;
			case 5 :
				param += "principalId=" + document.getElementById("UserManager_principalId").value; 
				if( aPortletPermissionManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/portletPermission/list.admin", param, false, {
						success: function(data){
							document.getElementById("UserManager_PortletPermissionTabPage").innerHTML = data;
							aPortletPermissionManager = new PortletPermissionManager( aUserManager.m_evSecurityCode );
							aPortletPermissionManager.init();
							
							document.getElementById("PortletPermissionManager_Master_principalId").value = document.getElementById("UserManager_principalId").value; 
							aPortletPermissionManager.doRetrieve();
						}});
				}
				else {
					document.getElementById("PortletPermissionManager_Master_principalId").value = document.getElementById("UserManager_principalId").value; 
					aPortletPermissionManager.initSearch();
					aPortletPermissionManager.doRetrieve();
				}
				break;
			case 6 :
		
				param += "principalId=" + document.getElementById("UserManager_principalId").value;
				if( aTotalPagePermissionManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/user/totalPagePermission/list.admin", param, false, {
						success: function(data){
							document.getElementById("UserManager_TotalPagePermissionTabPage").innerHTML = data;
							aTotalPagePermissionManager = new TotalPagePermissionManager( aUserManager.m_evSecurityCode );
							aTotalPagePermissionManager.init();
							
							document.getElementById("TotalPagePermissionManager_Master_principalId").value = document.getElementById("UserManager_principalId").value; 
							aTotalPagePermissionManager.doRetrieve();
						}});
				}
				else {
					
					document.getElementById("TotalPagePermissionManager_Master_principalId").value = document.getElementById("UserManager_principalId").value; 
					aTotalPagePermissionManager.initSearch();
					aTotalPagePermissionManager.doRetrieve();
				}
			
				break;
	 
			case 7 :
		
				param += "principalId=" + document.getElementById("UserManager_principalId").value;
				if( aUserStatisticsManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/userStatistics/list.admin", param, false, {
						success: function(data){
							document.getElementById("UserManager_UserStatisticsTabPage").innerHTML = data;
							aUserStatisticsManager = new UserStatisticsManager( aUserManager.m_evSecurityCode );
							aUserStatisticsManager.init();
							
							document.getElementById("UserStatisticsManager_Master_userId").value = document.getElementById("UserManager_shortPath").value; 
							aUserStatisticsManager.doRetrieve();
						}});
				}
				else {
					
					document.getElementById("UserStatisticsManager_Master_userId").value = document.getElementById("UserManager_shortPath").value; 
					aUserStatisticsManager.initSearch();
					aUserStatisticsManager.doRetrieve();
				}
			
				break;
		
		}
		
		return true; 
	},
	initSearch : function () {
		var formElem = document.forms[ "UserManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},

doRetrieve : function () 
	{
		//this.doCreate();
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "UserManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++)
	     {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
	    
	    //alert(param);
		this.m_ajax.send("POST", this.m_contextPath + "/gpsManager/listForAjax.admin", param, false, {success: function(data) { aUserManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject )
	{
		this.m_utility.setListData(
				"UserManager",
				new Array(),

				new Array('userId','latiTude','longiTude','addRess'),
				this.m_contextPath, resultObject);
		
	if(resultObject.Data.length != 0)
		{
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
	doSearch : function (formName) // 李얘린
	{
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = 1;
		
		this.m_selectRowIndex = 0;
		this.doRetrieve();
		
	},
	doSearchHandler : function (resultObject)
	{
		//alert("寃�깋以�..");
		
	this.m_utility.setListData(
				"UserManager",
				new Array(),

				new Array('userId','latiTude','longiTude','addRess'),
				this.m_contextPath, resultObject);
	},
	
	doSort : function (obj, sortColumn)
	{
		var formElem = document.forms[ "UserManager_SearchForm" ];
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
		document.getElementById('UserManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
	
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		//alert("1 : " + param);
		
		param += "userId=";
		//alert("2 : " + param);
		
		//alert(this.m_selectRowIndex);
		
		param += document.getElementById('UserManager[' + this.m_selectRowIndex + '].userId').value;
		//alert("3 : " + param);
		
		
		this.m_ajax.send("POST", this.m_contextPath + "/gpsManager/detailForAjax.admin", param, false, {success: function(data) { aUserManager.doSelectHandler(data);}});
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
	
    this.m_checkBox.unChkAll( document.getElementById("UserManager_ListForm"));
    document.getElementById('UserManager[' + rowSeq + '].checkRow').checked = true;
    
    var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
	param += "userId="; 
	param += document.getElementById('UserManager[' + rowSeq + '].userId').value;

   this.m_ajax.send("POST", this.m_contextPath + "/gpsManager/detailForAjax.admin", param, false, {success: function(data) { aUserManager.doSelectHandler(data); }});
},
	
doSelectHandler : function(resultObject)
{
	//alert("셀렉트 핸들러"+ portalPage.getAjax().retrieveElementValue("userId", resultObject));
	
	document.getElementById("gps_userId").value = portalPage.getAjax().retrieveElementValue("userId", resultObject);
	
	var latiTude = document.getElementById("gps_latiTude").value = portalPage.getAjax().retrieveElementValue("latiTude", resultObject);
	var longiTude = document.getElementById("gps_longiTude").value = portalPage.getAjax().retrieveElementValue("longiTude", resultObject);
	
	googlemap(latiTude, longiTude);
},
	
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "UserManager");
		
		var propertyTabs = $("#UserManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	 
		propertyTabs.tabs('disable', 1);	 
		propertyTabs.tabs('disable', 2);	 
		propertyTabs.tabs('disable', 3);	 
		propertyTabs.tabs('disable', 4);	 
		propertyTabs.tabs('disable', 5);	 
		propertyTabs.tabs('disable', 6);	 
		propertyTabs.tabs('disable', 7);	 
		propertyTabs.tabs('disable', 8);	
		document.getElementById("UserManager_principalId").readOnly = true;
		document.getElementById("UserManager_shortPath").readOnly = false;
		document.getElementById("UserManager_EditFormPanel").style.display = '';
	},
	
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var isCreate = document.getElementById("UserManager_isCreate").value;
		var form = document.getElementById("UserManager_EditForm");

		//var param = this.m_utility.getFormData(this.m_dataStructure, form);
		
		var password = document.getElementById("UserManager_columnValue0").value;
		var confirmPassword = document.getElementById("UserManager_columnValueConfirm").value;
		if( password != null && password != confirmPassword ) {
			alert( portalPage.getMessageResource('ev.error.password') );
			document.getElementById("UserManager_columnValue0").focus();
			return;
		}
		
		if( isCreate == "true" ) {
			if( password == null || password.length == 0 ) {
				document.getElementById("UserManager_columnValue0").focus();
				var fieldName = document.getElementById("UserManager_columnValue0").getAttribute("label");
				//var fieldName = portalPage.getMessageResource('pt.ev.property.columnValue');
				var msg = portalPage.getMessageResourceByParam('ev.error.validation.required', fieldName);
				alert( msg );
				return;
			}
		}
		
		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		param = "shortPath=" + document.getElementById("UserManager_shortPath").value;
		param += "&principalId=" + document.getElementById("UserManager_principalId").value;
		param += "&principalName=" + document.getElementById("UserManager_principalName").value;
		param += "&principalType=" + document.getElementById("UserManager_principalType").value;
		param += "&theme=" + document.getElementById("UserManager_theme").value;
		param += "&defaultPage=" + document.getElementById("UserManager_defaultPage").value;
		param += "&principalInfo01=" + document.getElementById("UserManager_principalInfo01").value;
		param += "&principalInfo02=" + document.getElementById("UserManager_principalInfo02").value;
		param += "&principalInfo03=" + document.getElementById("UserManager_principalInfo03").value;
		param += "&principalDesc=" + document.getElementById("UserManager_principalDesc").value;
		param += "&columnValue0=" + document.getElementById("UserManager_columnValue0").value;
		param += "&isEnabled=" + ((document.getElementById("UserManager_isEnabled").checked == true) ? "true" : "false");
		param += "&updateRequired0=" + ((document.getElementById("UserManager_updateRequired0").checked == true) ? "true" : "false");
		param += "&authFailures0=" + document.getElementById("UserManager_authFailures0").value;
		param += "&authMethod=" + document.getElementById("UserManager_authMethod").value;
		param += "&gradeId=" + document.getElementById("UserManager_gradeId").value;

alert(param);
		
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/user/addForAjax.admin", param, false, {
				success: function(data){
					aUserManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/user/updateForAjax.admin", param, false, {
				success: function(data){
					aUserManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
doRemove : function () //硫붿꽭吏��꾩넚��蹂댁뿬二쇨린 �꾪븳
{	
	alert("�뚯뒪��");
	var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("UserManager_ListForm") );
		
	if( rowCnts == "" )
	{
		 document.getElementById("gpsrreciveid").value = "";
		 document.getElementById("gpsrrecivedeviceKey").value = "";
		 document.getElementById("gpsrrecivedevicephoneType").value = "";
	}
	
	else
		{
        var formData = "";
        var rowCntArray = rowCnts.split(",");
        var userIdList = "";
        var deviceKeyList = "";
        var phoneTypeList =""
       
        for(i=0; i<rowCntArray.length; i++)
        {     	
        	if(i==0){}
        	else{userIdList += ",";deviceKeyList+= ",";phoneTypeList+= ",";}
        	userIdList += document.getElementById('UserManager[' + rowCntArray[i] + '].userId').value;
        	deviceKeyList += document.getElementById('UserManager[' + rowCntArray[i] + '].latiTude').value;
        	phoneTypeList += document.getElementById('UserManager[' + rowCntArray[i] + '].longiTude').value;
        }   
	        document.getElementById("gpsrreciveid").value = "test";
	        document.getElementById("gpsrrecivedeviceKey").value = deviceKeyList;
	   	    document.getElementById("gpsrrecivedevicephoneType").value = phoneTypeList;
		}
},
all : function () 
{
	var test = document.getElementById("allcheckbox").value;
	alert(test);
},

	doInitializePassword : function (forDetail)
	{
		var ret = confirm( portalPage.getMessageResource('ev.info.init.password') );
	    if( ret == true ) {
	    	var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
			param += "principalId=" + document.getElementById("UserManager_principalId").value;
			param += "&shortPath=" + document.getElementById("UserManager_shortPath").value;

			this.m_ajax.send("POST", this.m_contextPath + "/user/initializePasswordForAjax.admin", param, false, {
				success: function(data){
					if( forDetail == null || forDetail == false ) {
						aUserManager.doRetrieve();
					}
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	}
}

var aUserChooser = null;
UserChooser = function(evSecurityCode)
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	this.m_utility = new enview.util.Utility();
	if( portalPage == null) portalPage = new enview.portal.Page();
	this.m_selectRowIndex = 0;
	this.m_contextPath = portalPage.getContextPath();
	this.m_domElement = document.getElementById("UserManager_UserChooser");
	this.m_evSecurityCode = evSecurityCode;
	enviewMessageBox = new enview.portal.MessageBox(200, 100, 1000); 
	
	$("#UserManager_UserChooser").dialog({
		autoOpen: false,
		resizable: false,
		modal: true,
		width:600, 
		//height:300,
		buttons: {
			"Apply": function() {
				aUserChooser.doApply();
			},
			Cancel: function() {
				$(this).dialog('close');
			}
		}
	});
	
	this.init();
}

UserChooser.prototype =
{
	m_domElement : null,
	m_checkBox : null,
	m_sourceElement : null,
	m_callback : null,
	m_parent : null,
	m_evSecurityCode : null,
	
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
		$('#UserManager_UserChooser').dialog('open');
	},
  doRetrieve : function () 
	{
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "UserChooser_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/gpsManager/listForAjax.admin", param, false, {success: function(data) { aUserChooser.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		this.m_utility.setListData(
			"UserChooser",
			new Array(),

			new Array('userId','deviceKey'),
			this.m_contextPath, resultObject);
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
		var formElem = document.forms[ "UserChooser_SearchForm" ];
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
		
		if( this.m_parent != null ) 
		{
			this.m_checkBox.unChkAll( document.getElementById("UserManager_ListForm") );
			document.getElementById('UserChooser[' + rowSeq + '].checkRow').checked = true;
			this.m_parent.doApply();
			return;
		}
		
		$('#UserManager_UserChooser').dialog('close');
		
		if( this.m_sourceElement != null ) {
			
			this.m_sourceElement.value = document.getElementById('UserChooser[' + rowSeq + '].principalId').value;	
		}
		else {
			var result = new Array(1);
			var rowMap = new Map();
			
			rowMap.put("principalId", document.getElementById('UserChooser[' + rowSeq + '].principalId').value);	
			rowMap.put("shortPath", document.getElementById('UserChooser[' + rowSeq + '].shortPath').value);	
			rowMap.put("principalName", document.getElementById('UserChooser[' + rowSeq + '].principalName').value);
			result[0] = rowMap;
			
			this.m_callback(result);
		}
	},
	getSelectedItems : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("UserChooser_ListForm") );
		if( rowCnts == "" ) return;
		
		var rowCntArray = rowCnts.split(",");
		if( rowCntArray.length > 0 ) {
			if( rowCntArray.length > 1 ) {
				alert( portalPage.getMessageResource('ev.info.select.onlyone') );
				return;
			}
			
			var result = new Array(rowCntArray.length);
			for(var i=0; i<rowCntArray.length; i++) {
				var rowMap = new Map();
			
				rowMap.put("id", document.getElementById('UserChooser[' + rowCntArray[i] + '].id').value);	
				result[i] = rowMap;
			}
			
			return result;
		}
		
		return null;
	},
	doApply : function ()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("UserChooser_ListForm") );
		if( rowCnts == "" ) return;
		
		var rowCntArray = rowCnts.split(",");
		/*
		if( rowCntArray.length > 0 ) {
			if( rowCntArray.length > 1 ) {
				alert( portalPage.getMessageResource('ev.info.select.onlyone') );
				return;
			}
		*/	
			$('#UserManager_UserChooser').dialog('close');
			
			var result = new Array(rowCntArray.length);
			for(var i=0; i<rowCntArray.length; i++) {
				var rowMap = new Map();
			
				rowMap.put("principalId", document.getElementById('UserChooser[' + rowCntArray[i] + '].principalId').value);	
				rowMap.put("shortPath", document.getElementById('UserChooser[' + rowCntArray[i] + '].shortPath').value);	
				rowMap.put("principalName", document.getElementById('UserChooser[' + rowCntArray[i] + '].principalName').value);	
				result[i] = rowMap;
			}
			
			this.m_callback(result);
		/* } */
	}
}

