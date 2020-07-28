
var aLangManager = null;
LangManager = function(evSecurityCode)
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
LangManager.prototype =
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
		
		this.m_dataStructure = [
		    {"fieldName":"domainId", "validation":"Required"}
			,{"fieldName":"langKnd", "validation":"Required"}
			,{"fieldName":"langCd", "validation":"Required,MaxLength", "maxLength":"100"}
			,{"fieldName":"langDesc", "validation":"Required,MaxLength", "maxLength":"100"}
			,{"fieldName":"langUpdDate", "validation":""}
			,{"fieldName":"langUpdId", "validation":"MaxLength", "maxLength":"20"}
			
		]
		
		$(function() {
			$("#LangManager_propertyTabs").tabs();
		});
		
		$.datepicker.setDefaults({
			showMonthAfterYear: true,
			changeMonth: true,
			changeYear: true,
			showButtonPanel: true,
			showAnim : 'slideDown',
			dateFormat : 'yy-mm-dd'
		});
		
		
		$('#LangManager_langUpdDate').datepicker();	
		
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
		var formElem = document.forms[ "LangManager_SearchForm" ];
		formElem.elements[ "pageNo" ].value = 1;
		//formElem.elements[ "pageSize" ].value = 10;
		this.m_selectRowIndex = 0;
	},
	doRetrieve : function () {
		this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "LangManager_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/lang/listForAjax.admin", param, false, {success: function(data) { aLangManager.doRetrieveHandler(data); }});
	},
	doRetrieveHandler : function( resultObject ) {
		
		this.m_utility.setListData(
			"LangManager",
			new Array('domainId', 'langKnd', 'langCd'),
			new Array('domainNm', 'langKnd', 'langCd', 'langDesc'),
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
		var formElem = document.forms[ "LangManager_SearchForm" ];
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
		document.getElementById('LangManager[' + this.m_selectRowIndex + '].checkRow').checked = true;
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
		
	    this.m_checkBox.unChkAll( document.getElementById("LangManager_ListForm") );
	    document.getElementById('LangManager[' + rowSeq + '].checkRow').checked = true;
		
		this.doChildRetrieve();
	},
	doCreate : function() 
	{
		var bodyElem = document.getElementById('LangManager_Child_ListBody');
		this.m_checkBox.unChkAll( document.getElementById("LangManager_Child_ListForm") );
		for(; bodyElem.hasChildNodes(); )
			bodyElem.removeChild( bodyElem.childNodes[0] );
	
		document.getElementById("LangManager_Child_domainId").disabled = false;
		document.getElementById("LangManager_Child_langCd").readOnly = false;
		document.getElementById("LangManager_Child_langKnd").disabled = false;
		document.getElementById("LangManager_EditFormPanel").style.display = '';
		
		this.doChildCreate(true);
	},
	doRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("LangManager_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('LangManager[' + rowCntArray[i] + '].domainId').value + ":" +
					document.getElementById('LangManager[' + rowCntArray[i] + '].langKnd').value + ":" +
					document.getElementById('LangManager[' + rowCntArray[i] + '].langCd').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/lang/removeMasterForAjax.admin", param, false, {
				success: function(data){
					aLangManager.initSearch()
					aLangManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	},
	doChildRetrieve : function () {
		//this.doCreate();
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "LangManager_Child_SearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		param += "&domainId=";
		param += document.getElementById('LangManager[' + this.m_selectRowIndex + '].domainId').value;
		param += "&langCd=";
		param += document.getElementById('LangManager[' + this.m_selectRowIndex + '].langCd').value;
		
//		alert( 'doChildRetrieve ' + param);
		this.m_ajax.send("POST", this.m_contextPath + "/lang/listLangForAjax.admin", param, false, {success: function(data) { aLangManager.doChildRetrieveHandler(data); }});
		
		document.getElementById("LangManager_Child_domainId").disabled = true;
		document.getElementById("LangManager_Child_langCd").readOnly = true;
		document.getElementById("LangManager_Child_langKnd").disabled = true;
	},
	doChildRetrieveHandler : function( resultObject ) {
		
		this.setListData(
			"LangManager",
			"Child",
			new Array('domainId', 'langKnd', 'langCd'),
			new Array('domainNm', 'langKnd', 'langCd', 'langDesc'),
			this.m_contextPath,
			resultObject);
		// if not editable, hide buttons 
		document.getElementById("LangManager_Child_ListButtons").style.display = resultObject.Editable == 'true' ? 'block' : 'none';  
		document.getElementById("LangManager_Child_EditButtons").style.display = resultObject.Editable == 'true' ? 'block' : 'none';  
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
		var formElem = document.forms[ "LangManager_Child_SearchForm" ];
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
		document.getElementById('LangManager_Child[0].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "domainId=";
		param += document.getElementById('LangManager_Child[0].domainId').value;
		param += "&langKnd=";
		param += document.getElementById('LangManager_Child[0].langKnd').value;
		param += "&langCd=";
		param += document.getElementById('LangManager_Child[0].langCd').value;
		
		this.m_ajax.send("POST", this.m_contextPath + "/lang/detailForAjax.admin", param, false, {success: function(data) { aLangManager.doChildSelectHandler(data); }});
		
		document.getElementById("LangManager_Child_domainId").disabled = true;
		document.getElementById("LangManager_Child_langCd").readOnly = true;
		document.getElementById("LangManager_Child_langKnd").disabled = true;
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
		
	    this.m_checkBox.unChkAll( document.getElementById("LangManager_Child_ListForm") );
	    document.getElementById('LangManager_Child[' + rowSeq + '].checkRow').checked = true;
		
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		param += "domainId=";
		param += document.getElementById('LangManager_Child[' + rowSeq + '].domainId').value;
		param += "&langKnd=";
		param += document.getElementById('LangManager_Child[' + rowSeq + '].langKnd').value;
		param += "&langCd=";
		param += document.getElementById('LangManager_Child[' + rowSeq + '].langCd').value;
			
		this.m_ajax.send("POST", this.m_contextPath + "/lang/detailForAjax.admin", param, false, {success: function(data) { aLangManager.doChildSelectHandler(data); }});
		
		document.getElementById("LangManager_Child_domainId").disabled = true;
		document.getElementById("LangManager_Child_langCd").readOnly = true;
		document.getElementById("LangManager_Child_langKnd").disabled = true;
	},
	doChildSelectHandler : function(resultObject)
	{
		this.m_utility.setFormDataFromXML(this.m_dataStructure, "LangManager_Child", resultObject);
		
		var propertyTabs = $("#LangManager_propertyTabs").tabs();
	
		var propSelectedTabId = propertyTabs.tabs('option', 'selected');
		this.onSelectPropertyTab( propSelectedTabId );
	},
	doChildCreate : function(isMaster) 
	{
		this.m_utility.initFormData(this.m_dataStructure, "LangManager_Child");
		
		var propertyTabs = $("#LangManager_propertyTabs").tabs();
		propertyTabs.tabs('option', 'active', 0);
	
		if( isMaster ) {
			document.getElementById("LangManager_Child_ListButtons").style.display = '';  
			document.getElementById("LangManager_Child_EditButtons").style.display = '';  
			
			document.getElementById("LangManager_Child_domainId").value = userDomainId;
			if( isAdmin=='true') {
				document.getElementById("LangManager_Child_domainId").disabled = false;
			} else {
				document.getElementById("LangManager_Child_domainId").disabled = true;
			}
			document.getElementById("LangManager_Child_langKnd").value = portalPage.getLangKnd();
			document.getElementById("LangManager_Child_langCd").readOnly = false;
			document.getElementById("LangManager_Child_langKnd").readOnly = false;
			document.getElementById("LangManager_Child_langKnd").disabled = false;
			document.getElementById("LangManager_Child_langUpdDate").readOnly = true;
		}
		else {
			document.getElementById("LangManager_Child_domainId").value = document.getElementById("LangManager[" + this.m_selectRowIndex + "].domainId").value;
			document.getElementById("LangManager_Child_langCd").value = document.getElementById("LangManager[" + this.m_selectRowIndex + "].langCd").value;
			document.getElementById("LangManager_Child_langKnd").value = portalPage.getLangKnd();
			document.getElementById("LangManager_Child_domainId").disabled = true;
			document.getElementById("LangManager_Child_langCd").readOnly = true;
			document.getElementById("LangManager_Child_langKnd").readOnly = false;
			document.getElementById("LangManager_Child_langKnd").disabled = false;
			document.getElementById("LangManager_Child_langUpdDate").readOnly = true;
		}
	},
	doChildRemove : function () {
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("LangManager_Child_ListForm") );
		if( rowCnts == "" ) return;

		var ret = confirm( portalPage.getMessageResource('ev.info.remove') );
	    if( ret == true ) {
	        var formData = "";
	        var rowCntArray = rowCnts.split(",");
			
			var param = "evSecurityCode=" + this.m_evSecurityCode;
	        for(i=0; i<rowCntArray.length; i++) {
				param += "&pks=";
				param += 
					document.getElementById('LangManager_Child[' + rowCntArray[i] + '].domainId').value + ":" +
					document.getElementById('LangManager_Child[' + rowCntArray[i] + '].langKnd').value + ":" +
					document.getElementById('LangManager_Child[' + rowCntArray[i] + '].langCd').value;
	        }
			
			this.m_ajax.send("POST", this.m_contextPath + "/lang/removeForAjax.admin", param, false, {
				success: function(data){
					aLangManager.m_selectRowIndex = 0;
					aLangManager.doRetrieve();
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.remove') );
				}});
			
		}
	},
	doChildUpdate : function (forDetail)
	{
		var elm = null;
		var val = null;
		var isCreate = document.getElementById("LangManager_Child_isCreate").value;
		var form = document.getElementById("LangManager_Child_EditForm");

		var isValid = this.m_validator.validate(this.m_dataStructure, form);
		if( isValid == false ) return;
		
		var param = this.m_utility.getFormData(this.m_dataStructure, form);
		param += "evSecurityCode=" + this.m_evSecurityCode + "&";
	
		if( isCreate == "true" ) {
			this.m_ajax.send("POST", this.m_contextPath + "/lang/addForAjax.admin", param, false, {
				success: function(data){
					aLangManager.doChildRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.add') );
				}});
		}
		else {
			this.m_ajax.send("POST", this.m_contextPath + "/lang/updateForAjax.admin", param, false, {
				success: function(data){
					aLangManager.doChildRetrieve();
					
					enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
				}});
		}
		document.getElementById("LangManager_Child_domainId").disabled = true;
		document.getElementById("LangManager_Child_langCd").readOnly = true;
		document.getElementById("LangManager_Child_langKnd").disabled = true;
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
	},
	writeJavascript : function ()
	{
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		this.m_ajax.send("POST", this.m_contextPath + "/lang/writeJavascriptForAjax.admin", param, false, {
			success: function(data) { 
				enviewMessageBox.doShow( portalPage.getMessageResource('ev.info.success.update') );
			}});
	}
}

