
var aUserpassManager = null;
UserpassManager = function(evSecurityCode)
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
UserpassManager.prototype =
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
			,{"fieldName":"regNo", "validation":"MaxLength", "maxLength":"6"}
			,{"fieldName":"regNo", "validation":"MaxLength", "maxLength":"7"}
			,{"fieldName":"regNo", "validation":"IhIdNum"}
			,{"labelName":"emailAddr", "fieldName":"emailAddr1", "validation":"Required,MaxLength", "maxLength":"20"}
			,{"labelName":"offcTel", "fieldName":"offcTel2", "validation":"Required,MaxLength,Short", "maxLength":"4"}
			,{"labelName":"offcTel", "fieldName":"offcTel3", "validation":"Required,MaxLength,Short", "maxLength":"4"}
			,{"fieldName":"mileTot", "validation":"Short"}
			,{"labelName":"homeTel", "fieldName":"homeTel2", "validation":"MaxLength,Short", "maxLength":"4"}
			,{"labelName":"homeTel", "fieldName":"homeTel3", "validation":"MaxLength,Short", "maxLength":"4"}
			,{"labelName":"mobileTel", "fieldName":"mobileTel2", "validation":"Required,MaxLength,Short", "maxLength":"4"}
			,{"labelName":"mobileTel", "fieldName":"mobileTel3", "validation":"Required,MaxLength,Short", "maxLength":"4"}
			,{"labelName":"homeZip", "fieldName":"homeZip1", "validation":"MaxLength,Short", "maxLength":"3"}
			,{"labelName":"homeZip", "fieldName":"homeZip2", "validation":"MaxLength,Short", "maxLength":"3"}
			,{"fieldName":"homeAddr1", "validation":"MaxLength", "maxLength":"25"}
			,{"fieldName":"homeAddr2", "validation":"MaxLength", "maxLength":"25"}
			,{"fieldName":"userInfo05", "validation":"MaxLength", "maxLength":"25"}
			,{"fieldName":"userInfo06", "validation":"MaxLength", "maxLength":"25"}
			,{"fieldName":"regDatim", "validation":""}
			,{"fieldName":"updDatim", "validation":""}
			
		]
		
		$(function() {
			$("#UserpassManager_propertyTabs").tabs();
		});
		
		$.datepicker.setDefaults({
			showMonthAfterYear: true,
			changeMonth: true,
			changeYear: true,
			showButtonPanel: true,
			showAnim : 'slideDown',
			dateFormat : 'yy-mm-dd'
		});
		
		
		$('#UserpassManager_birthYmd').datepicker();	
		
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
		var formElem = document.forms[ "UserpassManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "UserpassManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/user/userpass/listForAjax.admin", param, false, {success: function(data) { aUserpassManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"UserpassManager",
			new Array('userId'),
			new Array('userId', 'nmKor', 'nmNic', 'regNo1', 'regNo2', 'birthYmd', 'emailAddr', 'offcTel', 'mileTot', 'homeTel', 'mobileTel', 'homeZip', 'homeAddr1', 'homeAddr2', 'langKnd', 'userInfo05', 'userInfo06', 'regDatim', 'updDatim'),
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
		var formElem = document.forms[ "UserpassManager_SearchForm" ];
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
		document.getElementById('UserpassManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "userId=";
		param += document.getElementById('UserpassManager[' + this.m_selectRowIndex + '].userId').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/user/userpass/detailForAjax.admin", param, false, {success: function(data) { aUserpassManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("UserpassManager_ListForm") );
	    document.getElementById('UserpassManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "userId=";
		param += document.getElementById('UserpassManager[' + rowSeq + '].userId').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/user/userpass/detailForAjax.admin", param, false, {success: function(data) { aUserpassManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		//this.m_utility.setFormDataFromXML(this.m_dataStructure, "UserpassManager", resultObject);
		document.getElementById("UserpassManager_isCreate").value = "false";
		document.getElementById("UserpassManager_userId").value = portalPage.getAjax().retrieveElementValue("userId", resultObject);
		document.getElementById("UserpassManager_nmKor").value = portalPage.getAjax().retrieveElementValue("nmKor", resultObject);
		document.getElementById("UserpassManager_nmNic").value = portalPage.getAjax().retrieveElementValue("nmNic", resultObject);
		var regNo = portalPage.getAjax().retrieveElementValue("regNo", resultObject);
		document.getElementById("UserpassManager_regNo1").value = regNo.substring(0, 6);
		document.getElementById("UserpassManager_regNo2").value = regNo.substring(6);
		var birthYmd = portalPage.getAjax().retrieveElementValue("birthYmd", resultObject);
		if( birthYmd != null ) {
			var ymd = birthYmd.substring(0, 10);
			var birthYmdArray = ymd.split("-")
			if( birthYmdArray[0] ) 
				document.getElementById("UserpassManager_birthYear").value = birthYmdArray[0];
			if( birthYmdArray[1] ) 
				document.getElementById("UserpassManager_birthMonth").value = birthYmdArray[1];
			if( birthYmdArray[2] ) 
				document.getElementById("UserpassManager_birthDay").value = birthYmdArray[2];
		}
		var emailAddr = portalPage.getAjax().retrieveElementValue("emailAddr", resultObject);
		var atPos = emailAddr.indexOf("@");
		document.getElementById("UserpassManager_emailAddr1").value = emailAddr.substring(0, atPos);
		document.getElementById("UserpassManager_emailAddr2").value = emailAddr.substring(atPos+1);
		
		var emailSelectIdx = 0;
		for(var i = 0; i < document.getElementById("UserpassManager_emailAddr3").options.length; i++) {
			if(emailAddr.substring(atPos+1) ==  document.getElementById("UserpassManager_emailAddr3").options[i].text){
				emailSelectIdx = 1;
				document.getElementById("UserpassManager_emailAddr3").options[i].selected = true;
				continue;
			}
		}
		
		if (emailSelectIdx == 0) {
			document.getElementById("UserpassManager_emailAddr3").value="99";
		}
		
		var offcTel = portalPage.getAjax().retrieveElementValue("offcTel", resultObject);
		if( offcTel != null ) {
			var offcTelArray = offcTel.split("-")
			if( offcTelArray[0] )
				document.getElementById("UserpassManager_offcTel1").value = offcTelArray[0];
			if( offcTelArray[1] )
				document.getElementById("UserpassManager_offcTel2").value = offcTelArray[1];
			if( offcTelArray[2] )
				document.getElementById("UserpassManager_offcTel3").value = offcTelArray[2];
		}
		else {
			document.getElementById("UserpassManager_offcTel1").value = "";
			document.getElementById("UserpassManager_offcTel2").value = "";
			document.getElementById("UserpassManager_offcTel3").value = "";
		}
		
		document.getElementById("UserpassManager_mileTot").value = portalPage.getAjax().retrieveElementValue("mileTot", resultObject);
		
		var homeTel = portalPage.getAjax().retrieveElementValue("homeTel", resultObject);
		if( homeTel != null ) {
			var homeTelArray = homeTel.split("-")
			if( homeTelArray[0] )
				document.getElementById("UserpassManager_homeTel1").value = homeTelArray[0];
			if( homeTelArray[1] )
				document.getElementById("UserpassManager_homeTel2").value = homeTelArray[1];
			if( homeTelArray[2] )
				document.getElementById("UserpassManager_homeTel3").value = homeTelArray[2];
		}
		else {
			document.getElementById("UserpassManager_homeTel1").value = "";
			document.getElementById("UserpassManager_homeTel2").value = "";
			document.getElementById("UserpassManager_homeTel3").value = "";
		}
		var mobileTel = portalPage.getAjax().retrieveElementValue("mobileTel", resultObject);
		if( mobileTel != null ) {
			var mobileTelArray = mobileTel.split("-")
			if( mobileTelArray[0] ) 
				document.getElementById("UserpassManager_mobileTel1").value = mobileTelArray[0];
			if( mobileTelArray[1] ) 
				document.getElementById("UserpassManager_mobileTel2").value = mobileTelArray[1];
			if( mobileTelArray[2] ) 
				document.getElementById("UserpassManager_mobileTel3").value = mobileTelArray[2];
		}
		else {
			document.getElementById("UserpassManager_mobileTel1").value = "";
			document.getElementById("UserpassManager_mobileTel2").value = "";
			document.getElementById("UserpassManager_mobileTel3").value = "";
		}
		var homeZip = portalPage.getAjax().retrieveElementValue("homeZip", resultObject);
		document.getElementById("UserpassManager_homeZip1").value = homeZip.substring(0, 3);
		document.getElementById("UserpassManager_homeZip2").value = homeZip.substring(3);
		document.getElementById("UserpassManager_homeAddr1").value = portalPage.getAjax().retrieveElementValue("homeAddr1", resultObject);
		document.getElementById("UserpassManager_homeAddr2").value = portalPage.getAjax().retrieveElementValue("homeAddr2", resultObject);
		document.getElementById("UserpassManager_langKnd").value = portalPage.getAjax().retrieveElementValue("langKnd", resultObject);
		document.getElementById("UserpassManager_regDatim").value = portalPage.getAjax().retrieveElementValue("regDatim", resultObject);
		document.getElementById("UserpassManager_updDatim").value = portalPage.getAjax().retrieveElementValue("updDatim", resultObject);
		
		document.getElementById("UserpassManager_userInfo05").value = portalPage.getAjax().retrieveElementValue("userInfo05", resultObject);
		document.getElementById("UserpassManager_userInfo06").value = portalPage.getAjax().retrieveElementValue("userInfo06", resultObject);
	
		document.getElementById("UserpassManager_userId").readOnly = true;
		document.getElementById("UserpassManager_regDatim").readOnly = true;
		document.getElementById("UserpassManager_updDatim").readOnly = true;
		
		
		var propertyTabs = $("#UserpassManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		
		//document.getElementById("UserpassManager_EditFormPanel").style.display = '';
	},
	doCreate : function() 
	{
		this.m_utility.initFormData(this.m_dataStructure, "UserpassManager");
		
		var propertyTabs = $("#UserpassManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	 
		document.getElementById("UserpassManager_userId").value = document.getElementById("UserpassManager_Master_userId").value; 
		document.getElementById("UserpassManager_userId").readOnly = false;
		document.getElementById("UserpassManager_EditFormPanel").style.display = '';
	},
	doUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var isCreate = document.getElementById("UserpassManager_isCreate").value;
		var form = document.getElementById("UserpassManager_EditForm");
		
		document.getElementById("UserpassManager_regNo").value = document.getElementById("UserpassManager_regNo1").value + document.getElementById("UserpassManager_regNo2").value;

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		//var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param = "userId=" + document.getElementById("UserpassManager_userId").value;
		param += "&nmKor=" + document.getElementById("UserpassManager_nmKor").value;
		param += "&nmNic=" + document.getElementById("UserpassManager_nmNic").value;
		param += "&regNo=" + document.getElementById("UserpassManager_regNo1").value + document.getElementById("UserpassManager_regNo2").value;
		param += "&birthYmd=" + document.getElementById("UserpassManager_birthYear").value + "-" +
								document.getElementById("UserpassManager_birthMonth").value + "-" +
								document.getElementById("UserpassManager_birthDay").value;
		param += "&emailAddr=" + document.getElementById("UserpassManager_emailAddr1").value + "@" +
								 document.getElementById("UserpassManager_emailAddr2").value;
		param += "&offcTel=" + document.getElementById("UserpassManager_offcTel1").value + "-" +
								document.getElementById("UserpassManager_offcTel2").value + "-" +
								document.getElementById("UserpassManager_offcTel3").value;
		param += "&mileTot=" + document.getElementById("UserpassManager_mileTot").value;
		param += "&homeTel=" + document.getElementById("UserpassManager_homeTel1").value + "-" +
								document.getElementById("UserpassManager_homeTel2").value + "-" +
								document.getElementById("UserpassManager_homeTel3").value;
		param += "&mobileTel=" + document.getElementById("UserpassManager_mobileTel1").value + "-" +
								document.getElementById("UserpassManager_mobileTel2").value + "-" +
								document.getElementById("UserpassManager_mobileTel3").value;
		param += "&homeZip=" + document.getElementById("UserpassManager_homeZip1").value + document.getElementById("UserpassManager_homeZip2").value;
		param += "&homeAddr1=" + document.getElementById("UserpassManager_homeAddr1").value;
		param += "&homeAddr2=" + document.getElementById("UserpassManager_homeAddr2").value;
		param += "&langKnd=" + document.getElementById("UserpassManager_langKnd").value;
		param += "&regDatim=" + document.getElementById("UserpassManager_regDatim").value;
		param += "&userInfo05=" + document.getElementById("UserpassManager_userInfo05").value;
		param += "&userInfo06=" + document.getElementById("UserpassManager_userInfo06").value;
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/user/userpass/addForAjax.admin", param, false, {
				success: function(data){
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
					param = "userId=" + document.getElementById("UserManager_shortPath").value;
					aUserpassManager.m_ajax.send("POST", aUserpassManager.m_contextPath + "/user/userpass/detailForAjax.admin", param, false, {
					success: function(data){
						aUserpassManager.doSelectHandler( data );
					}});
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/user/userpass/updateForAjax.admin", param, false, {
				success: function(data){
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
					param = "userId=" + document.getElementById("UserManager_shortPath").value;
					aUserpassManager.m_ajax.send("POST", aUserpassManager.m_contextPath + "/user/userpass/detailForAjax.admin", param, false, {
					success: function(data){
						aUserpassManager.doSelectHandler( data );
					}});
				}});
		}
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("UserpassManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('UserpassManager[' + rowCntArray[i] + '].userId').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/user/userpass/removeForAjax.admin", param, false, {
				success: function(data){
					aUserpassManager.m_selectRowIndex = 0;
					aUserpassManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	},
	doEmailChange : function () {
		var emailAddr3 = document.getElementById("UserpassManager_emailAddr3").value;
        if(emailAddr3 == "99") { //직접입력일때
        	document.getElementById("UserpassManager_emailAddr2").value="";
        	document.getElementById("UserpassManager_emailAddr2").readOnly = false;
        } else {
    	   document.getElementById("UserpassManager_emailAddr2").value=document.getElementById("UserpassManager_emailAddr3").options[document.getElementById("UserpassManager_emailAddr3").selectedIndex].text;
    	   document.getElementById("UserpassManager_emailAddr2").readOnly = true;
        }
	}
	
}

