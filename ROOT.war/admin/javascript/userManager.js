
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
	
	init : function(evSecurityCode) { 
		
		this.m_evSecurityCode = evSecurityCode; 
		this.m_dataStructure = [
			{"fieldName":"principalId", "validation":""}
			,{"fieldName":"domainId", "validation":""}
			,{"fieldName":"shortPath", "validation":"Required,MaxLength", "maxLength":"30"}
			,{"fieldName":"principalName", "validation":"Required,MaxLength", "maxLength":"40"}
			,{"fieldName":"theme", "validation":""}
			,{"fieldName":"defaultPage", "validation":""}
			,{"fieldName":"columnValue0", "validation":""}
			,{"fieldName":"isEnabled", "validation":""}
			,{"fieldName":"updateRequired0", "validation":""}
			,{"fieldName":"authFailures0", "validation":""}
			,{"fieldName":"modifiedDate0", "validation":""}
			,{"fieldName":"authMethod", "validation":"Required"}
			,{"fieldName":"principalType", "validation":""}
			,{"fieldName":"principalInfo01", "validation":"MaxLength", "maxLength":"50"}
			,{"fieldName":"principalInfo02", "validation":"MaxLength", "maxLength":"50"}
			,{"fieldName":"principalInfo03", "validation":"MaxLength", "maxLength":"50"}
			,{"fieldName":"creationDate", "validation":""}
			,{"fieldName":"modifiedDate", "validation":""}
			,{"fieldName":"principalDesc", "validation":"MaxLength", "maxLength":"80"}
			
		]
		
		$(function() {
			$("#UserManager_propertyTabs").tabs();
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
		if( aPageChooser == null ) {
			aPageChooser = new PageChooser( aUserManager.m_evSecurityCode );
		}
		return aPageChooser;
	},
	setPageChooserCallback : function (rowArray) {
		//document.getElementById("PageManager_defaultPageName").value = rowArray[0].get("pageId");
		document.getElementById("UserManager_defaultPage").value = rowArray[0].get("pagePath");
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
	setPageMultiChooserCallback : function (rowArray) {
		//document.getElementById("PageManager_defaultPageName").value = rowArray[0].get("pageId");
		document.getElementById("UserManager_defaultPage").value = rowArray[0].get("pagePath");
	},
	getGroupChooser : function () {
		var domainId = $('#UserManager_domainCond').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId + "&";
//		if( aGroupChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/group/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("GroupManager_GroupChooser").innerHTML = data;
					aGroupChooser = new GroupChooser( aUserManager.m_evSecurityCode, domainId, false);	//그룹ID를 한개만 선택할 수 있도록
				}});
//		}
		return aGroupChooser;
	},
	setGroupChooserCallback : function (rowArray) {
		if (rowArray == null) {
			document.getElementById("UserManager_groupIdJoinCond").value = "";
			document.getElementById("UserManager_groupIdJoinCond2").value = "";
		} else {
			document.getElementById("UserManager_groupIdJoinCond").value = rowArray[0].get("principalId");
			document.getElementById("UserManager_groupIdJoinCond2").value = rowArray[0].get("groupId");
		}
		document.getElementById("UserManager_groupIdJoinCond2").focus();
	},
	getRoleChooser : function () {
		var domainId = $('#UserManager_domainCond').val();
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		param += "&domainId=" + domainId + "&";
//		if( aRoleChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/role/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("RoleManager_RoleChooser").innerHTML = data;
					aRoleChooser = new RoleChooser(aUserManager.m_evSecurityCode, domainId, false);	//역할ID를 한개만 선택할 수 있도록
				}});
//		}
		return aRoleChooser;
	},
	setRoleChooserCallback : function (rowArray) {
		if (rowArray == null) {
			document.getElementById("UserManager_roleIdJoinCond").value = "";
			document.getElementById("UserManager_roleIdJoinCond2").value = "";
		} else {
			document.getElementById("UserManager_roleIdJoinCond").value = rowArray[0].get("principalId");
			document.getElementById("UserManager_roleIdJoinCond2").value = rowArray[0].get("roleId");
		}
		document.getElementById("UserManager_roleIdJoinCond2").focus();
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
							
							document.getElementById("UserGroupManager_Master_domainId").value = document.getElementById("UserManager_domainId").value;
							document.getElementById("UserGroupManager_Master_userId").value = document.getElementById("UserManager_principalId").value; 
							aUserGroupManager.doRetrieve();
						}});
				} else {
					document.getElementById("UserGroupManager_Master_domainId").value = document.getElementById("UserManager_domainId").value;
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
							
							document.getElementById("UserRoleManager_Master_domainId").value = document.getElementById("UserManager_domainId").value;
							document.getElementById("UserRoleManager_Master_userId").value = document.getElementById("UserManager_principalId").value; 
							aUserRoleManager.doRetrieve();
						}});
				} else {
					document.getElementById("UserRoleManager_Master_domainId").value = document.getElementById("UserManager_domainId").value;
					document.getElementById("UserRoleManager_Master_userId").value = document.getElementById("UserManager_principalId").value; 
					aUserRoleManager.initSearch();
					aUserRoleManager.doRetrieve();
				}
				break;
//			case 4 :
//				param += "principalId=" + document.getElementById("UserManager_principalId").value;
//				if( aPagePermissionManager == null ) {
//					this.m_ajax.send("POST", this.m_contextPath + "/pagePermission/list.admin", param, false, {
//						success: function(data){
//							document.getElementById("UserManager_PagePermissionTabPage").innerHTML = data;
//							aPagePermissionManager = new PagePermissionManager( aUserManager.m_evSecurityCode );
//							aPagePermissionManager.init();
//							
//							document.getElementById("PagePermissionManager_Master_domainId").value = document.getElementById("UserManager_domainId").value;
//							document.getElementById("PagePermissionManager_Master_principalId").value = document.getElementById("UserManager_principalId").value; 
//							document.getElementById("PagePermissionManager_Master_principalType").value = "U"; 
//							aPagePermissionManager.doRetrieve();
//						}});
//				} else {
//					document.getElementById("PagePermissionManager_Master_domainId").value = document.getElementById("UserManager_domainId").value;
//					document.getElementById("PagePermissionManager_Master_principalId").value = document.getElementById("UserManager_principalId").value;
//					document.getElementById("PagePermissionManager_Master_principalType").value = "U"; 
//					aPagePermissionManager.initSearch();
//					aPagePermissionManager.doRetrieve();
//				}
//				break;
//			case 5 :
//				param += "principalId=" + document.getElementById("UserManager_principalId").value;
//				param += "&domainId=" + document.getElementById("UserManager_domainId").value;
//				if( aPortletPermissionManager == null ) {
//					this.m_ajax.send("POST", this.m_contextPath + "/portletPermission/list.admin", param, false, {
//						success: function(data){
//							document.getElementById("UserManager_PortletPermissionTabPage").innerHTML = data;
//							aPortletPermissionManager = new PortletPermissionManager( aUserManager.m_evSecurityCode );
//							aPortletPermissionManager.init();
//							
//							document.getElementById("PortletPermissionManager_Master_principalId").value = document.getElementById("UserManager_principalId").value; 
//							document.getElementById("PortletPermissionManager_Master_domainId").value = document.getElementById("UserManager_domainId").value;
//							document.getElementById("PortletPermissionManager_Master_principalType").value = "U"; 
//							aPortletPermissionManager.doRetrieve();
//						}});
//				} else {
//					document.getElementById("PortletPermissionManager_Master_principalId").value = document.getElementById("UserManager_principalId").value;
//					document.getElementById("PortletPermissionManager_Master_domainId").value = document.getElementById("UserManager_domainId").value;
//					document.getElementById("PortletPermissionManager_Master_principalType").value = "U";
//					aPortletPermissionManager.initSearch();
//					aPortletPermissionManager.doRetrieve();
//				}
//				break;
//			case 6 :
//				param += "principalId=" + document.getElementById("UserManager_principalId").value;
//				param += "&domainId=" + document.getElementById("UserManager_domainId").value;
//				if( aUrlPermissionManager == null ) {
//					this.m_ajax.send("POST", this.m_contextPath + "/urlPermission/list.admin", param, false, {
//						success: function(data){
//							document.getElementById("UserManager_UrlPermissionTabPage").innerHTML = data;
//							aUrlPermissionManager = new UrlPermissionManager( aUserManager.m_evSecurityCode );
//							aUrlPermissionManager.init();
//							
//							document.getElementById("UrlPermissionManager_Master_principalId").value = document.getElementById("UserManager_principalId").value;
//							document.getElementById("UrlPermissionManager_Master_domainId").value = document.getElementById("UserManager_domainId").value;
//							document.getElementById("UrlPermissionManager_Master_principalType").value = "U"; 
//							aUrlPermissionManager.doRetrieve();
//						}});
//				} else {
//					document.getElementById("UrlPermissionManager_Master_principalId").value = document.getElementById("UserManager_principalId").value;
//					document.getElementById("UrlPermissionManager_Master_domainId").value = document.getElementById("UserManager_domainId").value;
//					document.getElementById("UrlPermissionManager_Master_principalType").value = "U";
//					aUrlPermissionManager.initSearch();
//					aUrlPermissionManager.doRetrieve();
//				}
//				break;
				
				
			/* case 7 : */
			case 4:
				param += "principalId=" + document.getElementById("UserManager_principalId").value;
				param += "&domainId=" + document.getElementById("UserManager_domainId").value;
				if( aTotalPagePermissionManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/user/totalPagePermission/list.admin", param, false, {
						success: function(data){
							document.getElementById("UserManager_TotalPagePermissionTabPage").innerHTML = data;
							aTotalPagePermissionManager = new TotalPagePermissionManager( aUserManager.m_evSecurityCode );
							aTotalPagePermissionManager.init();
							
							document.getElementById("TotalPagePermissionManager_Master_principalId").value = document.getElementById("UserManager_principalId").value; 
							aTotalPagePermissionManager.doRetrieve();
						}});
				} else {
					
					document.getElementById("TotalPagePermissionManager_Master_principalId").value = document.getElementById("UserManager_principalId").value; 
					aTotalPagePermissionManager.initSearch();
					aTotalPagePermissionManager.doRetrieve();
				}
				break;
			
			/* case 8 : */
			case 5:
				param += "principalId=" + document.getElementById("UserManager_principalId").value;
				param += "&domainId=" + document.getElementById("UserManager_domainId").value;
				if( aUserStatisticsManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/userStatistics/list.admin", param, false, {
						success: function(data){
							document.getElementById("UserManager_UserStatisticsTabPage").innerHTML = data;
							aUserStatisticsManager = new UserStatisticsManager( aUserManager.m_evSecurityCode );
							aUserStatisticsManager.init();
							
							document.getElementById("UserStatisticsManager_Master_userId").value = document.getElementById("UserManager_shortPath").value; 
							aUserStatisticsManager.doRetrieve();
						}});
				} else {
					
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
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () 
	{
		this.doCreate();
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		if($('#UserManager_domainCond').val() == 0){
			param += "byDomain=Y" + "&existsDomain=N&";
			$('#createMenu').css('display', 'none');
		}
		else {
			$('#createMenu').css('display', 'inline-block');
		}
		var formElem = document.forms[ "UserManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		    
		this.m_ajax.send("POST", this.m_contextPath + "/user/listForAjax.admin", param, false, {success: function(data) { aUserManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"UserManager",
			new Array('principalId', 'shortPath', 'domainId'),
			new Array('domainNm','principalId', 'shortPath', 'principalName', 'modifiedDate'),
			this.m_contextPath,
			resultObject);
				
		if(resultObject.Data.length != 0) {
			this.doDefaultSelect(); 
		}
		if($('#isAdmin').val() == 'true' && $('#UserManager_domainCond').val() == '0'){
			 $('.UserManager_EditFormButtons').css('display', 'block');
		}
		else $('.UserManager_EditFormButtons').css('display', 'none');
		
		this.checkDomainIdForTabs();
	},
	
	//도메인 아이디를 체크하여 0(소속없음)이 선택되면, 일부 탭을 활성화/비활성화 시킨다.
	checkDomainIdForTabs : function(){
		var propertyTabs = $("#UserManager_propertyTabs").tabs();
		var able = 'enable';
		if($('#UserManager_domainCond').val() == '0'){
			able = 'disable';
		}
		propertyTabs.tabs('enable', 0);	 
		propertyTabs.tabs('enable', 1);	 
		propertyTabs.tabs(able, 2);	 
		propertyTabs.tabs(able, 3);	 
		propertyTabs.tabs(able, 4);	 
		propertyTabs.tabs(able, 5);
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
		if(!document.getElementById('UserManager[' + this.m_selectRowIndex + '].checkRow')) return;
		document.getElementById('UserManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "principalId=";
		param += document.getElementById('UserManager[' + this.m_selectRowIndex + '].principalId').value;
		param += "&domainId=";
		param += document.getElementById('UserManager[' + this.m_selectRowIndex + '].domainId').value;
		this.m_ajax.send("POST", this.m_contextPath + "/user/detailForAjax.admin", param, false, {success: function(data) { aUserManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("UserManager_ListForm") );
	    document.getElementById('UserManager[' + rowSeq + '].checkRow').checked = true;
		
	    var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "principalId=";
		param += document.getElementById('UserManager[' + rowSeq + '].principalId').value;
		param += "&domainId=" + 	document.getElementById('UserManager[' + rowSeq + '].domainId').value;
		this.m_ajax.send("POST", this.m_contextPath + "/user/detailForAjax.admin", param, false, {success: function(data) { aUserManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		//this.m_utility.setFormDataFromXML(this.m_dataStructure, "UserManager", resultObject);
		document.getElementById("UserManager_isCreate").value = "false";
		document.getElementById("UserManager_shortPath").value = portalPage.getAjax().retrieveElementValue("shortPath", resultObject);
		document.getElementById("UserManager_principalId").value = portalPage.getAjax().retrieveElementValue("principalId", resultObject);
		document.getElementById("UserManager_principalName").value = portalPage.getAjax().retrieveElementValue("principalName", resultObject);
		document.getElementById("UserManager_principalType").value = portalPage.getAjax().retrieveElementValue("principalType", resultObject);
		document.getElementById("UserManager_theme").value = portalPage.getAjax().retrieveElementValue("theme", resultObject);
		document.getElementById("UserManager_defaultPage").value = portalPage.getAjax().retrieveElementValue("defaultPage", resultObject);
		document.getElementById("UserManager_principalInfo01").value = portalPage.getAjax().retrieveElementValue("principalInfo01", resultObject);
		document.getElementById("UserManager_principalInfo02").value = portalPage.getAjax().retrieveElementValue("principalInfo02", resultObject);
		document.getElementById("UserManager_principalInfo03").value = portalPage.getAjax().retrieveElementValue("principalInfo03", resultObject);
		document.getElementById("UserManager_principalDesc").value = portalPage.getAjax().retrieveElementValue("principalDesc", resultObject);
		
		document.getElementById("UserManager_columnValue0").value = "";
		document.getElementById("UserManager_columnValueConfirm").value = "";
		
		document.getElementById("UserManager_isEnabled").checked = (portalPage.getAjax().retrieveElementValue("isEnabled", resultObject) == "true") ? true : false;
		document.getElementById("UserManager_updateRequired0").checked = (portalPage.getAjax().retrieveElementValue("updateRequired0", resultObject) == "true") ? true : false;
		document.getElementById("UserManager_authFailures0").value = portalPage.getAjax().retrieveElementValue("authFailures0", resultObject);
		document.getElementById("UserManager_modifiedDate0").value = portalPage.getAjax().retrieveElementValue("modifiedDate0", resultObject);
		document.getElementById("UserManager_authMethod").value = portalPage.getAjax().retrieveElementValue("authMethod", resultObject);
		
		document.getElementById("UserManager_creationDate").value = portalPage.getAjax().retrieveElementValue("creationDate", resultObject);
		document.getElementById("UserManager_modifiedDate").value = portalPage.getAjax().retrieveElementValue("modifiedDate", resultObject);
		
		document.getElementById("UserManager_gradeId").value = (portalPage.getAjax().retrieveElementValue("gradeId", resultObject) == "" ? 50 : portalPage.getAjax().retrieveElementValue("gradeId", resultObject));
		
		document.getElementById("UserManager_domainId").value = portalPage.getAjax().retrieveElementValue("domainId", resultObject);
		
		document.getElementById("SecurityPermission_principalId").value = document.getElementById("UserManager_principalId").value;
	
		document.getElementById("UserManager_shortPath").readOnly = true;
		document.getElementById("UserManager_modifiedDate0").readOnly = true;
		document.getElementById("UserManager_creationDate").readOnly = true;
		document.getElementById("UserManager_modifiedDate").readOnly = true;
		
		
		var propertyTabs = $("#UserManager_propertyTabs").tabs();
		this.checkDomainIdForTabs();
		var propSelectedTabId = propertyTabs.tabs('option', 'active');
		this.onSelectPropertyTab( propSelectedTabId );
		
		document.getElementById("UserManager_EditFormPanel").style.display = '';
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
		param += "&domainId=" + document.getElementById("UserManager_domainCond").value;
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
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("UserManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
	        var domainId = $('#UserManager_domainCond').val();
	        var param = "evSecurityCode=" + this.m_evSecurityCode;
	        param += "&domainId=" + domainId;
	        for(i=0; i<rowCntArray.length; i++) {
				var shortPath = document.getElementById('UserManager[' + rowCntArray[i] + '].shortPath').value;
				if( shortPath == "admin" ) {
					//alert( portalPage.getMessageResource('ev.info.forbiden.deleteAdmin') );
					//continue;
				}
				param += "&pks=";
				param += 
					document.getElementById('UserManager[' + rowCntArray[i] + '].principalId').value + ":" +
					document.getElementById('UserManager[' + rowCntArray[i] + '].shortPath').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/user/removeForAjax.admin", param, false, {
				success: function(data){
					aUserManager.initSearch();
					aUserManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
		}
	},
	doGenerateUserMenu : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("UserManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.generateUserMenu') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
	        var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('UserManager[' + rowCntArray[i] + '].principalId').value + ":" +
					document.getElementById('UserManager[' + rowCntArray[i] + '].shortPath').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/user/generateUserMenuForAjax.admin", param, false, {
				success: function(data){
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
			
		}
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
	},
	doExportExcel : function()
	{
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		if($('#UserManager_domainCond').val() == 0){
			param += "byDomain=Y" + "&existsDomain=N&";
		}
		var formElem = document.forms[ "UserManager_SearchForm" ];
		for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
		}
		
		document.getElementById("exportExcelIF").src = this.m_contextPath + "/user/exportExcelForAjax.admin?" + param; 
	}
}

var aUserChooser = null;
UserChooser = function(evSecurityCode, domainId, extraParam)
{
	this.m_ajax = new enview.util.Ajax();
	this.m_checkBox = new enview.util.CheckBoxUtil();
	this.m_utility = new enview.util.Utility();
	if( portalPage == null) portalPage = new enview.portal.Page();
	this.m_selectRowIndex = 0;
	this.m_contextPath = portalPage.getContextPath();
	this.m_domElement = document.getElementById("UserManager_UserChooser");
	this.m_evSecurityCode = evSecurityCode;
	if(domainId) this.m_domainId = domainId;
	if(extraParam) this.m_extraParam = extraParam;
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
	m_domainId : '',
	m_extraParam : '',
	
	init : function() {
		
	},
	whenSrchFocus : function ( obj, lvS ) {
		if( obj.value == lvS ) obj.value = "";
	},
	whenSrchBlur : function ( obj, lvS ) {
		if( obj.value == "" ) obj.value = lvS;
	},
	
	doShow : function (callback) {
		this.m_callback = callback;
		
		this.doRetrieve();
		$('#UserManager_UserChooser').dialog('open');
	},
	
	doRetrieve : function ()  {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&domainId=" + this.m_domainId + "&";
		param += this.m_extraParam;
		var formElem = document.forms[ "UserChooser_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) 
	    {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		this.m_ajax.send("POST", this.m_contextPath + "/user/listForAjax.admin", param, false, {success: function(data) { aUserChooser.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		this.m_utility.setListData(
			"UserChooser",
			new Array('principalId', 'shortPath', 'principalName'),
			new Array('principalId', 'shortPath', 'principalName', 'modifiedDate'),
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
		
		//if( this.m_parent != null ) {
			this.m_checkBox.unChkAll( document.getElementById("UserChooser_ListForm") );
			document.getElementById('UserChooser[' + rowSeq + '].checkRow').checked = true;
			//this.m_parent.doApply();
			//return;
		//}
		/*
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
		*/
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

