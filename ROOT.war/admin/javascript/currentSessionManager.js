
var aCurrentSessionManager = null;
CurrentSessionManager = function(evSecurityCode)
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
CurrentSessionManager.prototype =
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
			{"fieldName":"userId", "validation":"Required,MaxLength", "maxLength":"30"}
			,{"fieldName":"nmKor", "validation":"Required,MaxLength", "maxLength":"30"}
			,{"fieldName":"nmNic", "validation":"MaxLength", "maxLength":"30"}
			,{"fieldName":"regNo", "validation":"Required,MaxLength", "maxLength":"13"}
			,{"fieldName":"birthYmd", "validation":"Required"}
			,{"fieldName":"emailAddr", "validation":"Required,MaxLength", "maxLength":"20"}
			,{"fieldName":"offcTel", "validation":"Required,MaxLength", "maxLength":"16"}
			,{"fieldName":"mileTot", "validation":""}
			,{"fieldName":"homeTel", "validation":"Required,MaxLength", "maxLength":"16"}
			,{"fieldName":"mobileTel", "validation":"Required,MaxLength", "maxLength":"16"}
			,{"fieldName":"homeZip", "validation":"Required"}
			,{"fieldName":"homeAddr1", "validation":"Required"}
			,{"fieldName":"homeAddr2", "validation":"Required"}
			,{"fieldName":"langKnd", "validation":""}
			,{"fieldName":"userInfo05", "validation":"MaxLength", "maxLength":"50"}
			,{"fieldName":"userInfo06", "validation":"MaxLength", "maxLength":"50"}
			,{"fieldName":"regDatim", "validation":""}
			,{"fieldName":"updDatim", "validation":""}
			
		]
		
		$(function() {
			$("#CurrentSessionManager_propertyTabs").tabs();
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
		var param = "evSecurityCode=" + this.m_evSecurityCode;
		switch(id) {
			case 0 : 
				break;
	 
			case 1 :
				param += "&domainId=" + $('#CurrentSessionManager_domainCond').val();
				param += "&userId=" + document.getElementById("CurrentSessionManager_userId").value;
				if( aUserStatisticsManager == null ) {
					this.m_ajax.send("POST", this.m_contextPath + "/userStatistics/list.admin", param, false, {
						success: function(data){
							document.getElementById("CurrentSessionManager_UserStatisticsTabPage").innerHTML = data;
							aUserStatisticsManager = new UserStatisticsManager( aCurrentSessionManager.m_evSecurityCode );
							aUserStatisticsManager.init();
							
							document.getElementById("UserStatisticsManager_Master_userId").value = document.getElementById("CurrentSessionManager_userId").value; 
							aUserStatisticsManager.doRetrieve();
						}});
				}
				else {
					
					document.getElementById("UserStatisticsManager_Master_userId").value = document.getElementById("CurrentSessionManager_userId").value; 
					aUserStatisticsManager.initSearch();
					aUserStatisticsManager.doRetrieve();
				}
			
				break;
		
		}
		
		return true; 
	},
	initSearch : function () {
		var formElem = document.forms[ "CurrentSessionManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "CurrentSessionManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/currentSession/listForAjax.admin", param, false, {success: function(data) { aCurrentSessionManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		this.m_utility.setListData2(
			"CurrentSessionManager",
			new Array('domainNm','userId'),
			new Array('domainNm','userId', 'userName', 'userIp', 'userAgent', 'elapsedTime'),
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
		var formElem = document.forms[ "CurrentSessionManager_SearchForm" ];
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
		//document.getElementById('CurrentSessionManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "userId=";
		param += document.getElementById('CurrentSessionManager[' + this.m_selectRowIndex + '].userId').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/currentSession/detailForAjax.admin", param, false, {success: function(data) { aCurrentSessionManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("CurrentSessionManager_ListForm") );
	    //document.getElementById('CurrentSessionManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "userId=";
		param += document.getElementById('CurrentSessionManager[' + rowSeq + '].userId').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/currentSession/detailForAjax.admin", param, false, {success: function(data) { aCurrentSessionManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		//this.m_utility.setFormDataFromXML(this.m_dataStructure, "CurrentSessionManager", resultObject);
		
		document.getElementById("CurrentSessionManager_userId").value = portalPage.getAjax().retrieveElementValue("userId", resultObject);
		document.getElementById("CurrentSessionManager_nmKor").value = portalPage.getAjax().retrieveElementValue("nmKor", resultObject);
		document.getElementById("CurrentSessionManager_nmNic").value = portalPage.getAjax().retrieveElementValue("nmNic", resultObject);
		var regNo = portalPage.getAjax().retrieveElementValue("regNo", resultObject);
		document.getElementById("CurrentSessionManager_regNo1").value = regNo.substring(0, 6);
		document.getElementById("CurrentSessionManager_regNo2").value = regNo.substring(6);
		var birthYmd = portalPage.getAjax().retrieveElementValue("birthYmd", resultObject);
		if( birthYmd != null ) {
			var ymd = birthYmd.substring(0, 10);
			var birthYmdArray = ymd.split("-")
			if( birthYmdArray[0] ) 
				document.getElementById("CurrentSessionManager_birthYear").value = birthYmdArray[0];
			if( birthYmdArray[1] ) 
				document.getElementById("CurrentSessionManager_birthMonth").value = birthYmdArray[1];
			if( birthYmdArray[2] ) 
				document.getElementById("CurrentSessionManager_birthDay").value = birthYmdArray[2];
		}
		var emailAddr = portalPage.getAjax().retrieveElementValue("emailAddr", resultObject);
		var atPos = emailAddr.indexOf("@");
		document.getElementById("CurrentSessionManager_emailAddr1").value = emailAddr.substring(0, atPos);
		document.getElementById("CurrentSessionManager_emailAddr2").value = emailAddr.substring(atPos+1);
		
		var offcTel = portalPage.getAjax().retrieveElementValue("offcTel", resultObject);
		if( offcTel != null ) {
			var offcTelArray = offcTel.split("-")
			if( offcTelArray[0] )
				document.getElementById("CurrentSessionManager_offcTel1").value = offcTelArray[0];
			if( offcTelArray[1] )
				document.getElementById("CurrentSessionManager_offcTel2").value = offcTelArray[1];
			if( offcTelArray[2] )
				document.getElementById("CurrentSessionManager_offcTel3").value = offcTelArray[2];
		}
		else {
			document.getElementById("CurrentSessionManager_offcTel1").value = "";
			document.getElementById("CurrentSessionManager_offcTel2").value = "";
			document.getElementById("CurrentSessionManager_offcTel3").value = "";
		}
		
		document.getElementById("CurrentSessionManager_mileTot").value = portalPage.getAjax().retrieveElementValue("mileTot", resultObject);
		
		var homeTel = portalPage.getAjax().retrieveElementValue("homeTel", resultObject);
		if( homeTel != null ) {
			var homeTelArray = homeTel.split("-")
			if( homeTelArray[0] )
				document.getElementById("CurrentSessionManager_homeTel1").value = homeTelArray[0];
			if( homeTelArray[1] )
				document.getElementById("CurrentSessionManager_homeTel2").value = homeTelArray[1];
			if( homeTelArray[2] )
				document.getElementById("CurrentSessionManager_homeTel3").value = homeTelArray[2];
		}
		else {
			document.getElementById("CurrentSessionManager_homeTel1").value = "";
			document.getElementById("CurrentSessionManager_homeTel2").value = "";
			document.getElementById("CurrentSessionManager_homeTel3").value = "";
		}
		var mobileTel = portalPage.getAjax().retrieveElementValue("mobileTel", resultObject);
		if( mobileTel != null ) {
			var mobileTelArray = mobileTel.split("-")
			if( mobileTelArray[0] ) 
				document.getElementById("CurrentSessionManager_mobileTel1").value = mobileTelArray[0];
			if( mobileTelArray[1] ) 
				document.getElementById("CurrentSessionManager_mobileTel2").value = mobileTelArray[1];
			if( mobileTelArray[2] ) 
				document.getElementById("CurrentSessionManager_mobileTel3").value = mobileTelArray[2];
		}
		else {
			document.getElementById("CurrentSessionManager_mobileTel1").value = "";
			document.getElementById("CurrentSessionManager_mobileTel2").value = "";
			document.getElementById("CurrentSessionManager_mobileTel3").value = "";
		}
		var homeZip = portalPage.getAjax().retrieveElementValue("homeZip", resultObject);
		document.getElementById("CurrentSessionManager_homeZip1").value = homeZip.substring(0, 3);
		document.getElementById("CurrentSessionManager_homeZip2").value = homeZip.substring(3);
		document.getElementById("CurrentSessionManager_homeAddr1").value = portalPage.getAjax().retrieveElementValue("homeAddr1", resultObject);
		document.getElementById("CurrentSessionManager_homeAddr2").value = portalPage.getAjax().retrieveElementValue("homeAddr2", resultObject);
		document.getElementById("CurrentSessionManager_langKnd").value = portalPage.getAjax().retrieveElementValue("langKnd", resultObject);
		document.getElementById("CurrentSessionManager_regDatim").value = portalPage.getAjax().retrieveElementValue("regDatim", resultObject);
		document.getElementById("CurrentSessionManager_updDatim").value = portalPage.getAjax().retrieveElementValue("updDatim", resultObject);
		
		
		var propertyTabs = $("#CurrentSessionManager_propertyTabs").tabs();
	 
		propertyTabs.tabs('enable', 1);	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		if( document.getElementById("CurrentSessionManager_EditFormPanel") != null) {
			document.getElementById("CurrentSessionManager_EditFormPanel").style.display = '';
		}
	},
	doExportExcel : function() {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "CurrentSessionManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		var url = this.m_contextPath + "/currentSession/exportExcelForAjax.admin?" + param; 
		document.getElementById("exportExcelIF").src = url;
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "CurrentSessionManager");
		
		var propertyTabs = $("#CurrentSessionManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	 
		propertyTabs.tabs('disable', 1);	
		document.getElementById("CurrentSessionManager_userId").readOnly = false;
		if( document.getElementById("CurrentSessionManager_EditFormPanel") != null) {
			document.getElementById("CurrentSessionManager_EditFormPanel").style.display = '';
		}
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("CurrentSessionManager_isCreate").value;
		var form = document.getElementById("CurrentSessionManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/currentSession/addForAjax.admin", param, false, {
				success: function(data){
					aCurrentSessionManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/currentSession/updateForAjax.admin", param, false, {
				success: function(data){
					aCurrentSessionManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("CurrentSessionManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('CurrentSessionManager[' + rowCntArray[i] + '].userId').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/currentSession/removeForAjax.admin", param, false, {
				success: function(data){
					aCurrentSessionManager.m_selectRowIndex = 0;
					aCurrentSessionManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
		}
	}
}