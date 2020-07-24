var aNoticeManager = null;
NoticeManager = function(evSecurityCode)
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
NoticeManager.prototype =
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
			{"fieldName":"title", "validation":"Required,MaxLength", "maxLength":"25"}
			,{"fieldName":"noticeId", "validation":""}
			,{"fieldName":"isEmergency", "validation":""}
			,{"fieldName":"startDate", "validation":"Required"}
			,{"fieldName":"endDate", "validation":"Required"}
			,{"fieldName":"template", "validation":"MaxLength", "maxLength":"256"}
			,{"fieldName":"layoutX", "validation":"Required,MaxLength,Short", "maxLength":"6"}
			,{"fieldName":"layoutY", "validation":"Required,MaxLength,Short", "maxLength":"6"}
			,{"fieldName":"layoutWidth", "validation":"Required,MaxLength,Short", "maxLength":"6"}
			,{"fieldName":"layoutHeight", "validation":"Required,MaxLength,Short", "maxLength":"6"}
			,{"fieldName":"principalId", "validation":"MaxLength", "maxLength":"20"}
			,{"fieldName":"groups", "validation":"MaxLength", "maxLength":"250"}
			,{"fieldName":"pages", "validation":"MaxLength", "maxLength":"240"}
			,{"fieldName":"domainId", "validation":""}
			,{"fieldName":"domainNm", "validation":""}
		]
		
		$(function() {
			$("#NoticeManager_propertyTabs").tabs();
		});
		
		$.datepicker.setDefaults({
			showMonthAfterYear: true,
			changeMonth: true,
			changeYear: true,
			showButtonPanel: true,
			showAnim : 'slideDown',
			dateFormat : 'yy-mm-dd'
		});
		
		$('#NoticeManager_startDate').datepicker();	
		$('#NoticeManager_endDate').datepicker();	
		
		//aNoticeMetadataManager = new NoticeMetadataManager( this.m_evSecurityCode );
		//aNoticeMetadataManager.init();
	},
	getGroupChooser : function () {
		var domainId = $("#NoticeManager_domainId").val();          
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		//if( aGroupChooser == null ) {
			this.m_ajax.send("POST", this.m_contextPath + "/group/listForChooser.admin", param, false, {
				success: function(data){
					//alert(data);
					document.getElementById("GroupManager_GroupChooser").innerHTML = data;
					aGroupChooser = new GroupChooser( aNoticeManager.m_evSecurityCode, domainId);
				}});
		//}
		return aGroupChooser;
	},
	setGroupChooserCallback : function (rowArray) {
		var selectElem = document.getElementById("NoticeManager_groups_list");
		
		for(var i=0; i<rowArray.length; i++) {
			var newOpt = document.createElement("OPTION");
			newOpt.text = rowArray[i].get("title") + "[" + rowArray[i].get("groupId") + "]";
			newOpt.name = "";
			newOpt.value = rowArray[i].get("groupId");
			try {
				selectElem.add(newOpt, null); // standards compliant; doesn't work in IE
			}
			catch(ex) {
				selectElem.add(newOpt, selectElem.options.length); // IE only
			}
		}
	
		var groups = "";
		for(var i=0; i<selectElem.options.length; i++) {
			if( i > 0 ) groups += ",";
			groups += selectElem.options[i].value;
		}
		document.getElementById("NoticeManager_groups").value = groups;
	},
	getPageChooser : function () {
		//if( aPageChooser == null ) {
		var domainId = $("#NoticeManager_domainId").val();	
		aPageChooser = new PageChooser( aNoticeManager.m_evSecurityCode , domainId);
		//}
		return aPageChooser;
	},
	setPageChooserCallback : function (rowArray) {
		//document.getElementById("PageManager_defaultPageName").value = rowArray[0].get("pageId");
		//document.getElementById("UserManager_defaultPage").value = rowArray[0].get("pagePath");
		var selectElem = document.getElementById("NoticeManager_pages_list");
		
		var newOpt = document.createElement("OPTION");
		newOpt.text = rowArray[0].get("title") + "[" + rowArray[0].get("pagePath") + "]";
		newOpt.name = "";
		newOpt.value = rowArray[0].get("pageId");
		try {
			selectElem.add(newOpt, null); // standards compliant; doesn't work in IE
		}
		catch(ex) {
			selectElem.add(newOpt, selectElem.options.length); // IE only
		}
	
		var pages = "";
		for(var i=0; i<selectElem.options.length; i++) {
			if( i > 0 ) pages += ",";
			pages += selectElem.options[i].value;
		}
		document.getElementById("NoticeManager_pages").value = pages;
	},
	onSelectPropertyTab : function (id) {
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		switch(id) {
			case 0 : 
				break;
	 
			case 1 :
		
				param += "noticeId=" + document.getElementById("NoticeManager_noticeId").value;
				if( aNoticeMetadataManager == null ) {
					//alert("aNoticeMatadataManager is null");
					aNoticeMetadataManager = new NoticeMetadataManager( aNoticeManager.m_evSecurityCode );
					aNoticeMetadataManager.init();
					document.getElementById("NoticeMetadataManager_Master_noticeId").value = document.getElementById("NoticeManager_noticeId").value;
					//setTimeout("aNoticeMetadataManager.initSearch();aNoticeMetadataManager.doRetrieve();", 200);
					/*
					this.m_ajax.send("POST", this.m_contextPath + "/notice/noticeMetadata/list.admin", param, false, {
						success: function(data){
							document.getElementById("NoticeManager_NoticeMetadataTabPage").innerHTML = data;
							aNoticeMetadataManager = new NoticeMetadataManager();
							aNoticeMetadataManager.init();
							document.getElementById("NoticeMetadataManager_Master_noticeId").value = document.getElementById("NoticeManager_noticeId").value; 
							setTimeout ("aNoticeMetadataManager.doRetrieve();", 500);
							
						}});
					*/
				}
				else {
					if(document.getElementById("NoticeManager_noticeId").value != ""){
						document.getElementById("NoticeMetadataManager_Master_noticeId").value = document.getElementById("NoticeManager_noticeId").value; 
						aNoticeMetadataManager.initSearch();
						aNoticeMetadataManager.doRetrieve();
						//setTimeout("aNoticeMetadataManager.initSearch();aNoticeMetadataManager.doRetrieve();", 200);
					}
					else{}
				}
			
				break;
		
		}
		
		return true; 
	},
	initSearch : function () {
		var formElem = document.forms[ "NoticeManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "NoticeManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/notice/listForAjax.admin", param, false, {success: function(data) { aNoticeManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"NoticeManager",
			new Array('noticeId'),
			new Array('domainNm', 'title', 'startDate', 'endDate', 'curNoticeYn'),
			this.m_contextPath,
			resultObject);
				
		if(resultObject.Data.length > 0) {
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
		var formElem = document.forms[ "NoticeManager_SearchForm" ];
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
		if(!document.getElementById('NoticeManager[' + this.m_selectRowIndex + '].checkRow')){
			var propertyTabs = $("#NoticeManager_propertyTabs").tabs();
			propertyTabs.tabs('option', 'active', 0);	
			propertyTabs.tabs('disable', 1);
			return;
		}
		document.getElementById('NoticeManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "noticeId=";
		param += document.getElementById('NoticeManager[' + this.m_selectRowIndex + '].noticeId').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/notice/detailForAjax.admin", param, false, {success: function(data) { aNoticeManager.doSelectHandler(data); }});
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
		
	    this.m_checkBox.unChkAll( document.getElementById("NoticeManager_ListForm") );
	    document.getElementById('NoticeManager[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "noticeId=";
		param += document.getElementById('NoticeManager[' + rowSeq + '].noticeId').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/notice/detailForAjax.admin", param, false, {success: function(data) { aNoticeManager.doSelectHandler(data); }});
	},
	doSelectHandler : function(resultObject)
	{
		//this.m_utility.setFormDataFromXML(this.m_dataStructure, "NoticeManager", resultObject);
		document.getElementById("NoticeManager_isCreate").value = "false";
		document.getElementById("NoticeManager_noticeId").value = portalPage.getAjax().retrieveElementValue("noticeId", resultObject);
		document.getElementById("NoticeManager_title").value = portalPage.getAjax().retrieveElementValue("title", resultObject);
		document.getElementById("NoticeManager_layoutX").value = portalPage.getAjax().retrieveElementValue("layoutX", resultObject);
		document.getElementById("NoticeManager_layoutY").value = portalPage.getAjax().retrieveElementValue("layoutY", resultObject);
		document.getElementById("NoticeManager_layoutWidth").value = portalPage.getAjax().retrieveElementValue("layoutWidth", resultObject);
		document.getElementById("NoticeManager_layoutHeight").value = portalPage.getAjax().retrieveElementValue("layoutHeight", resultObject);
		document.getElementById("NoticeManager_domainId").value = portalPage.getAjax().retrieveElementValue("domainId", resultObject);
		document.getElementById("NoticeManager_systemCode").checked = portalPage.getAjax().retrieveElementValue("systemCode", resultObject)=='MY';
		$("#NoticeManager_domainId").prop('disabled', true);
		
		var emergency = portalPage.getAjax().retrieveElementValue("isEmergency", resultObject);
		if( emergency == "true" ) {
			document.getElementById( "NoticeManager_popup" ).checked = true;
			document.getElementById("NoticeManager_templatePane").style.display = ''; 
			document.getElementById("NoticeManager_positionPane").style.display = ''; 
		}
		else {
			document.getElementById( "NoticeManager_ticker" ).checked = true;
			document.getElementById("NoticeManager_templatePane").style.display = 'none'; 
			document.getElementById("NoticeManager_positionPane").style.display = 'none'; 
		}
		//alert("temp=" + this.m_ajax.retrieveElementValue("template", resultObject));
		document.getElementById("NoticeManager_template").value = portalPage.getAjax().retrieveElementValue("template", resultObject);
		
		var stdv = portalPage.getAjax().retrieveElementValue("startDate", resultObject);
		//alert(stdv);
		var std = new Date( new Number(stdv) );
		//alert(std.getDateString("YYYY-MM-DD"));
		document.getElementById("NoticeManager_startDate").value =std.getDateString("YYYY-MM-DD"); 
		document.getElementById("NoticeManager_startHour").value = std.getDateString("hh");
		document.getElementById("NoticeManager_startMin").value = std.getDateString("mm");
		var eddv = portalPage.getAjax().retrieveElementValue("endDate", resultObject);
		//alert(eddv);
		var edd = new Date( new Number(eddv) );
		document.getElementById("NoticeManager_endDate").value = edd.getDateString("YYYY-MM-DD"); 
		document.getElementById("NoticeManager_endHour").value = edd.getDateString("hh");
		document.getElementById("NoticeManager_endMin").value = edd.getDateString("mm");
		
		selectElem = document.getElementById("NoticeManager_groups_list");
		for(; selectElem.hasChildNodes(); )
			selectElem.removeChild( selectElem.childNodes[0] );
			
		var groups = portalPage.getAjax().retrieveElementValue("groups", resultObject);
		document.getElementById("NoticeManager_groups").value = groups;

		var groupData = resultObject.getElementsByTagName("groupData");
		if( groupData != null && groupData.length > 0) {
			for (ix=0; ix < groupData.length; ix++)
			{
				var shortPath = groupData[ix].attributes.getNamedItem("shortPath").value;
				var principalName = "";
				if( groupData[ix].firstChild ) {
					principalName = groupData[ix].firstChild.nodeValue;
				}
				
				var newOpt = document.createElement("OPTION");
				newOpt.text = principalName + "[" + shortPath + "]";
				newOpt.name = "";
				newOpt.value = shortPath;
				try {
					selectElem.add(newOpt, null); // standards compliant; doesn't work in IE
				}
				catch(ex) {
					selectElem.add(newOpt, 1); // IE only
				}
			}
		}
	
		selectElem = document.getElementById("NoticeManager_pages_list");
		for(; selectElem.hasChildNodes(); )
			selectElem.removeChild( selectElem.childNodes[0] );
		
		var pages = portalPage.getAjax().retrieveElementValue("pages", resultObject);
		document.getElementById("NoticeManager_pages").value = pages;
		
		var pageData = resultObject.getElementsByTagName("pageData");
		if( pageData != null && pageData.length > 0) {
			for (ix=0; ix < pageData.length; ix++)
			{
				var pageId = pageData[ix].attributes.getNamedItem("pageId").value;
				var path = pageData[ix].attributes.getNamedItem("path").value;
				var shortTitle = "";
				if( pageData[ix].firstChild ) {
					shortTitle = pageData[ix].firstChild.nodeValue;
				}
				
				var newOpt = document.createElement("OPTION");
				newOpt.text = shortTitle + "[" + path + "]";
				newOpt.name = "";
				newOpt.value = pageId;
				try {
					selectElem.add(newOpt, null); // standards compliant; doesn't work in IE
				}
				catch(ex) {
					selectElem.add(newOpt, 1); // IE only
				}
			}
		}
		
		document.getElementById("NoticeManager_noticeId").readOnly = true;
		
		var propertyTabs = $("#NoticeManager_propertyTabs").tabs();
	 
		propertyTabs.tabs('enable', 1);	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
		document.getElementById("NoticeManager_EditFormPanel").style.display = '';
		document.getElementById("NoticeManager_copy").style.display = '';
	},
	doCreate : function() 
	{
		//this.m_utility.initFormData(this.m_dataStructure, "NoticeManager");
		document.getElementById("NoticeManager_isCreate").value = "true";
		document.getElementById("NoticeManager_noticeId").value = "";
		document.getElementById( "NoticeManager_popup" ).checked = true;
		
		document.getElementById("NoticeManager_title").value = "";
		document.getElementById("NoticeManager_startDate").value = "";
		document.getElementById("NoticeManager_endDate").value = "";
		document.getElementById("NoticeManager_template").value = "";
		
		document.getElementById("NoticeManager_startHour").value = "00";
		document.getElementById("NoticeManager_startMin").value = "00";
		document.getElementById("NoticeManager_endHour").value = "00";
		document.getElementById("NoticeManager_endMin").value = "00";
		
		document.getElementById("NoticeManager_layoutX").value = 0;
		document.getElementById("NoticeManager_layoutY").value = 0;
		document.getElementById("NoticeManager_layoutWidth").value = 345;
		document.getElementById("NoticeManager_layoutHeight").value = 290;

		document.getElementById("NoticeManager_systemCode").checked = false;
		
		var selectElem = document.getElementById("NoticeManager_groups_list");
		for(; selectElem.hasChildNodes(); )
			selectElem.removeChild( selectElem.childNodes[0] );
		document.getElementById("NoticeManager_groups").value = "";
		
		selectElem = document.getElementById("NoticeManager_pages_list");
		for(; selectElem.hasChildNodes(); )
			selectElem.removeChild( selectElem.childNodes[0] );
		document.getElementById("NoticeManager_pages").value = "";
		
		var propertyTabs = $("#NoticeManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);		
		$("#NoticeManager_domainId").prop('disabled', false);
		
		propertyTabs.tabs('disable', 1);	
		document.getElementById("NoticeManager_noticeId").readOnly = true;
		document.getElementById("NoticeManager_EditFormPanel").style.display = '';
		document.getElementById("NoticeManager_copy").style.display = "none";
	},
	doUpdate : function (forDetail)
	{		
		var elm = null;
		var val = null;
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var isCreate = document.getElementById("NoticeManager_isCreate").value;
		var form = document.getElementById("NoticeManager_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		//var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param = "noticeId=" + document.getElementById("NoticeManager_noticeId").value;
		param += "&isEmergency=" + ((document.getElementById("NoticeManager_popup").checked == true) ? "true" : "false");
		param += "&template=" + encodeURIComponent( document.getElementById("NoticeManager_template").value );
		
		var stdv = document.getElementById("NoticeManager_startDate").value;
		var stdvArray = stdv.split("-");
		var std = new Date( stdvArray[0], stdvArray[1]-1, stdvArray[2], document.getElementById("NoticeManager_startHour").value, document.getElementById("NoticeManager_startMin").value, 0 );
		
		var eddv = document.getElementById("NoticeManager_endDate").value;
		var eddvArray = eddv.split("-");
		var edd = new Date( eddvArray[0], eddvArray[1]-1, eddvArray[2], document.getElementById("NoticeManager_endHour").value, document.getElementById("NoticeManager_endMin").value, 0 );
		
		if( (edd.getTime()-std.getTime()) < 0 ) {
			alert( portalPage.getMessageResource('pt.ev.error.range.date') );
			return;
		}
		
		param += "&startDate=" + std.getTime();
		param += "&endDate=" + edd.getTime(); 
		param += "&title=" + encodeURIComponent( document.getElementById("NoticeManager_title").value );
		param += "&layoutX=" + document.getElementById("NoticeManager_layoutX").value;
		param += "&layoutY=" + document.getElementById("NoticeManager_layoutY").value;
		param += "&layoutWidth=" + document.getElementById("NoticeManager_layoutWidth").value;
		param += "&layoutHeight=" + document.getElementById("NoticeManager_layoutHeight").value;
		param += "&domainId=" + $('#NoticeManager_domainId').val();
		param += "&systemCode=" + ( document.getElementById("NoticeManager_systemCode").checked ? 'MY' : '');
		var groups = "";
		var groupList = document.getElementById("NoticeManager_groups_list")
		for(var ix=0; ix<groupList.options.length; ix++) {
			if( ix > 0 ) groups += ",";
			groups += groupList.options[ix].value;
		}
		param += "&groups=" + groups;
		var pages = "";
		var pageList = document.getElementById("NoticeManager_pages_list")
		for(var ix=0; ix<pageList.options.length; ix++) {
			if( ix > 0 ) pages += ",";
			pages += pageList.options[ix].value;
		}
		param += "&pages=" + pages;
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/notice/addForAjax.admin", param, false, {
				success: function(data){
					aNoticeManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/notice/updateForAjax.admin", param, false, {
				success: function(data){
					aNoticeManager.doRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
	},
	doCopy : function ()
	{
		var noticeId = document.getElementById("NoticeManager_noticeId").value;
		
		if (noticeId == '') {
			alert("복사할 공지사항을 선택하십시오.");
			return;
		}
		
		var ret = confirm( portalPage.getMessageResource('eb.info.confirm.copy') );
	    if( ret == true ) {
			var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
			param = "noticeId=" + noticeId;
			
			this.m_selectRowIndex = 0;
			this.m_ajax.send("POST", this.m_contextPath + "/notice/copyForAjax.admin", param, false, {
				success: function(data){
					aNoticeManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});	    	
	    }
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("NoticeManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('NoticeManager[' + rowCntArray[i] + '].noticeId').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/notice/removeForAjax.admin", param, false, {
				success: function(data){
					aNoticeManager.initSearch();
					aNoticeManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			/*
			this.m_ajax.send("POST", this.m_contextPath + "/notice/noticeMetadata/removeForAjax.admin", param, false, {
				success: function(data){
				}});*/
		}
	},
	doDisplayTemplate : function(obj) {
		if( obj.value == "1" ) {
			document.getElementById("NoticeManager_templatePane").style.display = ''; 
			document.getElementById("NoticeManager_positionPane").style.display = ''; 
		}
		else {
			document.getElementById("NoticeManager_templatePane").style.display = 'none'; 
			document.getElementById("NoticeManager_positionPane").style.display = 'none'; 
		}
	},
	doRemoveGroup : function() {
		var selectElem = document.getElementById("NoticeManager_groups_list")
		if( selectElem.selectedIndex > -1 ) {
			selectElem.remove( selectElem.selectedIndex );

			var groups = "";
			for(var i=0; i<selectElem.options.length; i++) {
				if( i > 0 ) groups += ",";
				groups += selectElem.options[i].value;
			}
			document.getElementById("NoticeManager_groups").value = groups;
		}
	},
	doRemovePage : function() {
		var selectElem = document.getElementById("NoticeManager_pages_list")
		if( selectElem.selectedIndex > -1 ) {
			selectElem.remove( selectElem.selectedIndex );

			var pages = "";
			for(var i=0; i<selectElem.options.length; i++) {
				if( i > 0 ) pages += ",";
				pages += selectElem.options[i].value;
			}
			document.getElementById("NoticeManager_pages").value = pages;
		}
	},
	doPreview : function() 
	{
		var noticeId = document.getElementById("NoticeManager_noticeId").value;
		var template = document.getElementById("NoticeManager_template").value;
		var left = document.getElementById("NoticeManager_layoutX").value;
		var top = document.getElementById("NoticeManager_layoutY").value;
		var width = document.getElementById("NoticeManager_layoutWidth").value;
		var height = document.getElementById("NoticeManager_layoutHeight").value;
		var langKnd = document.getElementById("NoticeMetadataManager_langKnd").value;
		
		if( template ) 
		{
		
			invokeEnviewNotice(this.m_contextPath, noticeId, template, left, top, width, height, langKnd);
		}
		else {
			
			var dialogTag = document.createElement("div");
			dialogTag.id = "Enview.Portal.Notice" + noticeId;
			dialogTag.setAttribute("class", "notice-infomation");
			dialogTag.setAttribute("className", "notice-infomation");
			dialogTag.style.zIndex = "10";
			dialogTag.style.left = left + "px";
			dialogTag.style.top = top + "px";
			dialogTag.style.width = width + "px";
			dialogTag.style.height = height + "px";
			dialogTag.style.position = "absolute";
			
			var smarteditor = document.getElementById("smarteditor");
			var dialogHtml = "";
			dialogHtml  ="<table width='100%' border='0' cellpadding='0' cellspacing='0' style='padding:1px; cursor: hand;'><tr><td colspan='2'>";
			
			if( smarteditor) {
				dialogHtml += document.getElementById("NoticeMetadataManager_content").value;
			} else {
				var oEditor = FCKeditorAPI.GetInstance('FckEditContent');
				dialogHtml += oEditor.GetXHTML(false);	
			}			
			//dialogHtml += document.getElementById("NoticeMetadataManager_content").value;
			
			//alert(oEditor.GetXHTML(false));
			dialogHtml +="</td></tr><tr bgcolor='#8e8e8e' ><td align='left'><label>";
			dialogHtml +="<input type='checkbox' id='Enview.Portal.Notice.Checkbox" + noticeId + "'/></label>";
			dialogHtml +="<img src='" + this.m_contextPath + "/statics/templates/notice/ images/label01.gif' align='absmiddle'/></td>";
			dialogHtml +="<td align='right'>";
			dialogHtml +="<a href='javascript:aNoticeManager.closePreviewDialog()' onFocus='this.blur()'>";
			dialogHtml +="<img src='" + this.m_contextPath + "/statics/templates/notice/images/btn_close.gif' border='0' align='absmiddle'/>";
			dialogHtml +="</a></td></tr></table>";

			dialogTag.innerHTML = dialogHtml;
			
			document.body.appendChild( dialogTag );
			this.m_tmpDialog = dialogTag;
		}
	},
	closePreviewDialog : function() {
		document.body.removeChild( this.m_tmpDialog );
		this.m_tmpDialog = null;
	}
	
}

