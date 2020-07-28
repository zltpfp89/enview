var portletManager = null;
enview.portal.PortletManager = function()
{
	
}
enview.portal.PortletManager.prototype =
{
	getPortletInfo: function ()
	{
		var portletInfo = null;
		var param = "path=" + portalPage.getPath();
		portalPage.getAjax().send("POST", portalPage.getContextPath() + "/page/getPortletInfoForAjax.face", param, false, {
			success: function(data){
				portletInfo = data;
			}});
			
		return portletInfo;
	},
	savePortlet : function (param)
	{
		portalPage.getAjax().send("POST", portalPage.getContextPath() + "/page/saveFragmentInfoForAjax.face", param, false, {
			success: function(data){
				alert( portalPage.getMessageResource('ev.info.success.update') );
				portalPage.m_modified = false;
				location.reload(false);
			}});
	},
	getPortletSelector: function ()
	{
		portalPage.getAjax().send("POST", portalPage.getContextPath() + "/common/listForPortletSelector.admin", "", false, {
			success: function(data){
				var dialogTag = document.createElement("div");
				dialogTag.id = "PortletSelectorDialog";
				dialogTag.title = portalPage.getMessageResource("ev.info.portlet.SelectorName");
				document.body.appendChild( dialogTag );
				document.getElementById("PortletSelectorDialog").innerHTML = data;
				portalPortletSelector = new enview.portal.PortletSelector();
				portalPortletSelector.init();
			}});
		
		return portalPortletSelector;
	},
	getLayoutPortletEditor: function ()
	{
		portalPage.getAjax().send("POST", portalPage.getContextPath() + "/common/listForPortletEditor.admin?type=layout", "", false, {
			success: function(data){
				portalLayoutPortletEditor = new enview.portal.LayoutPortletEditor(data);
				portalLayoutPortletEditor.init();
			}});
		return portalLayoutPortletEditor;
	},
	getPortletEditor: function ()
	{
		portalPage.getAjax().send("POST", portalPage.getContextPath() + "/common/listForPortletEditor.admin?type=portlet", "", false, {
			success: function(data){
				portalPortletEditor = new enview.portal.PortletEditor(data);
			}});
		return portalPortletEditor;
	}
}

var portalPortletSelector = null;
enview.portal.PortletSelector = function()
{
	this.m_checkBoxUtil = new enview.util.CheckBoxUtil();
	this.m_ajax = new enview.util.Ajax();
	this.m_ajax.setContextPath( portalPage.getContextPath() );
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = portalPage.getContextPath();
	
	$("#PortletSelectorDialog").dialog({
			autoOpen: true,
			resizable: true,
			width:500, 
			//height:400,
			modal: true,
			buttons: {
				Cancel: function() {
					$(this).dialog('close');
				},
				"Apply": function() {
					//$(this).dialog('close');
					portalPortletSelector.doApply();
				}
			}
		});
	
}
enview.portal.PortletSelector.prototype =
{
	m_checkBoxUtil: null,
	m_domElement: null,
	m_ajax: null,
	m_tree: null,
	m_object: null,
	m_selectRow: -1,
	
	init: function ()
	{
		this.doPortletRetrieve();
	},
	doShow: function (obj, keywords)
	{
		this.m_object = obj;
		//this.m_domElement.style.display = "";
		
		var pos = (new enview.util.Utility()).getAbsolutePosition( obj.getDomElement() );
		var left = pos.getX();
		var top = pos.getY() + 20;
		$('#PortletSelectorDialog').dialog( "option", "position", [left,top] );
		
		$('#PortletSelectorDialog').dialog('open');
	},
	
	doHide: function ()
	{
		$('#PortletSelectorDialog').dialog('close');
	},
	
	getDomElement: function ()
	{
		return this.m_domElement;
	},
	doPortletRetrieve: function ()
	{
		this.m_selectRow = -1;
		document.getElementById('PortletSelectorDialog_selected').value = "";
		
		var param = "";
		var formElem = document.forms[ "PortletSelectorSearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		param += "pagePath=" + portalPage.getPath();
		param += "&returnType=jsp";
		
		this.m_ajax.send("POST", this.m_contextPath + "/common/listPortletForAjax.admin", param, false, {success: function(data) { portalPortletSelector.doPortletRetrieveHandler(data); }});
	},
	doPortletRetrieveHandler: function (data)
	{
		var listForm = document.getElementById("PortletSelectorListForm");
		listForm.innerHTML = data;
		
	},
	doPortletPage: function (formName, pageNo)
	{
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = pageNo;
		
		this.doPortletRetrieve();
	},

	doPortletSearch: function (formName)
	{
		var formElem = document.forms[ formName ];
	    formElem.elements[ "pageNo" ].value = 1;
		
		this.doPortletRetrieve();
	},

	doPortletSort: function (obj, sortColumn)
	{
		var formElem = document.forms[ "PortletSelectorSearchForm" ];
	    formElem.elements[ "sortColumn" ].value = sortColumn;
	    if( obj.ch % 2 == 0 ) {
			formElem.elements[ "sortMethod" ].value = "ASC";
	        obj.ch = 1;
	    }
	    else {
	        formElem.elements[ "sortMethod" ].value = "DESC";
	        obj.ch = 0;
	    }
		
		this.doPortletRetrieve();
	},

	doPortletSelect: function (obj)
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
		document.getElementById('PortletSelectorDialog_selected').value = document.getElementById('PortletSelector[' + rowSeq + '].portletTitle').value;
		this.m_selectRow = rowSeq;
	},
	doApply : function()
	{
		if( this.m_selectRow == -1 ) return;
		
		$('#PortletSelectorDialog').dialog('close');

		var createdObject = null;
		var id = document.getElementById('PortletSelector[' + this.m_selectRow + '].portletId').value;
		var app = document.getElementById('PortletSelector[' + this.m_selectRow + '].portletAppName').value;
		var name = document.getElementById('PortletSelector[' + this.m_selectRow + '].portletName').value;
		var title = document.getElementById('PortletSelector[' + this.m_selectRow + '].portletTitle').value;
		var uniqueId = document.getElementById('PortletSelector[' + this.m_selectRow + '].uniqueId').value;
		var addValue1 = ""; //document.getElementById('PortletSelector[' + this.m_selectRow + '].addValue1').value;
		var addValue2 = ""; //document.getElementById('PortletSelector[' + this.m_selectRow + '].addValue2').value;
		var addValue3 = ""; //document.getElementById('PortletSelector[' + this.m_selectRow + '].addValue3').value;
		
		if( createdObject == null ) {
			//alert("this.m_object.id= " + this.m_object.getId());
			if( this.m_object.getType() == enview.portal.LAYOUT_ID_NAME ) {
				var childObject = this.m_object.getFirstChildObject();
				//alert("FirstChildObject=" + childObject + "," + childObject.getDomElement());
				if( childObject != null ) {
					createdObject = childObject.getParent().insert( childObject, id, app, name, title, uniqueId, addValue1, addValue2, addValue3 );
				}
				else {
					alert("Can't find firstChildObject of layout [" + this.m_object.getId() + "]");
				}
			}
			else {
				createdObject = this.m_object.getParent().insert( this.m_object, id, app, name, title, uniqueId, addValue1, addValue2, addValue3 );
			}
		}
		else {
			//alert("createdObject=" + createdObject.getId());
			createdObject = createdObject.getParent().insert( createdObject, id, app, name, title, uniqueId, addValue1, addValue2, addValue3 );
		}
		
		this.m_selectRow = -1;
		document.getElementById('PortletSelectorDialog_selected').value = "";
	}
};

var portalLayoutPortletEditor = null;
enview.portal.LayoutPortletEditor = function(data)
{
	this.m_ajax = new enview.util.Ajax();
	this.m_fragmentPropDialog = document.createElement("div");
	this.m_fragmentPropDialog.id = "LayoutPortletEditorDialog";
	this.m_fragmentPropDialog.title = portalPage.getMessageResource("ev.info.pageEditing.Layout");
	this.m_fragmentPropDialog.innerHTML = data;
	document.body.appendChild( this.m_fragmentPropDialog );
	
	this.m_isSizeFieldSelect = false;
		
	$("#LayoutPortletEditorDialog").dialog({
			autoOpen: false,
			resizable: true,
			width:350, 
			//height:400,
			modal: true,
			buttons: {
				Cancel: function() {
					$(this).dialog('close');
				},
				/*
				"Remove": function() {
					$(this).dialog('close');
					portalLayoutPortletEditor.remove();
				},
				*/
				"Apply": function() {
					$(this).dialog('close');
					portalLayoutPortletEditor.changeLayout();
				}
			}
		});
}
enview.portal.LayoutPortletEditor.prototype =
{
	m_object : null,
	m_fragmentPropDialog : null,
	m_isChangeLayout : false,
	m_isSizeFieldSelect : false,
	m_attributeMap : null,
	
	init : function()
	{
		//var tmp = "[{k : {\"name\" : \"zzz\", \"attr\" : {\"a\" : 1, \"b\" : 2}}},{k : {\"name\" : \"zzz\", \"attr\" : {\"a\" : 1, \"b\" : 2}}}]";
		//var tmps = eval("(" + tmp + ")");
		//alert(tmps.length);
		
		this.m_attributeMap = new Map();
		this.m_ajax.send("POST", portalPage.getContextPath() + "/page/getLayoutPortletInfoForAjax.face", "", false, {
			success: function(resultObject){
				//alert(resultObject.data.length);
				for(var i=0; i<resultObject.data.length; i++) {
					portalLayoutPortletEditor.m_attributeMap.put(resultObject.data[i].name, resultObject.data[i].attribute);
				}
			}});
	},
	
	show : function(obj)
	{
		//alert("layout type=" + obj.getType());
		this.m_object = obj;
		document.getElementById("LayoutPortletEditor.SELECT_LAYOUT").value = obj.getName();
		//document.getElementById("LayoutPortletEditor.SELECT_ALIGN").value = obj.getAlign();
		document.getElementById("LayoutPortletEditor.SELECT_CONTENTTYPE").value = obj.getContentType();
		document.getElementById("LayoutPortletEditorDialog.Fragment").value = obj.getFragmentId();
		document.getElementById("LayoutPortletEditorDialog.Name").innerHTML = obj.getName();
		if( portalPage.getServletPath() == "/contentonly" ) {
			document.getElementById("LayoutPortletEditor.ACTIONMASK_PANE").style.display = "";
		}
		else {
			document.getElementById("LayoutPortletEditor.ACTIONMASK_PANE").style.display = "none";
		}
		
		var actionMask = obj.getActionMask();
		if( (actionMask & 0x00001000) == 0x00001000 ) {
			document.getElementById("LayoutPortletEditor.ADD_ENABLE").checked = true;
		}
		else {
			document.getElementById("LayoutPortletEditor.ADD_ENABLE").checked = false;
		}
		if( (actionMask & 0x00000100) == 0x00000100 ) {
			document.getElementById("LayoutPortletEditor.EDIT_ENABLE").checked = true;
		}
		else {
			document.getElementById("LayoutPortletEditor.EDIT_ENABLE").checked = false;
		}
		if( (actionMask & 0x00000010) == 0x00000010 ) {
			document.getElementById("LayoutPortletEditor.MOVE_ENABLE").checked = true;
		}
		else {
			document.getElementById("LayoutPortletEditor.MOVE_ENABLE").checked = false;
		}
		if( (actionMask & 0x00000001) == 0x00000001 ) {
			document.getElementById("LayoutPortletEditor.DELETE_ENABLE").checked = true;
		}
		else {
			document.getElementById("LayoutPortletEditor.DELETE_ENABLE").checked = false;
		}

		if(obj.getColumns() != null) {
			var htmlString = "";
			var columns = obj.getColumns();
			if( columns.length == 1 ) {
				htmlString += "<input type='text' maxlength='3' size='3' id='column0' name='column0' used='false' value='100' onselect='javascript:return portalLayoutPortletEditor.onselect(0)' onkeypress='javascript:return portalLayoutPortletEditor.onkeypress(event, this, " + columns.length + ");'>"; 
			}
			else {
				for(var idx=0; idx<columns.length; idx++) {
					htmlString += "<input type='text' maxlength='4' size='3' id='column" + idx + "' name='column" + idx + "' used='false' value='" + columns[idx] + "' onselect='javascript:return portalLayoutPortletEditor.onselect(" + idx + ")' onkeypress='javascript:return portalLayoutPortletEditor.onkeypress(event, this, " + columns.length + ");'>"; 
				}
			}
			document.getElementById("LayoutPortletEditorDialog.ColumnSize").innerHTML = htmlString;
		}
		
		var unitElem = document.getElementById("LayoutPortletEditor.ColumnSizeUnit");
		if( unitElem != null ) {
			unitElem.value = obj.getColumnUnit();
		}
		
		var pos = (new enview.util.Utility()).getAbsolutePosition( obj.getDomElement() );
		var left = pos.getX();
		var top = pos.getY() + 20;
		$('#LayoutPortletEditorDialog').dialog( "option", "position", [left,top] );
		
		$('#LayoutPortletEditorDialog').dialog('open');
	},
	selectLayoutChanage : function()
	{
		this.m_isChangeLayout = true;
		if(this.m_object.getColumns() != null) {
			var formElem = document.forms[ "PortalLayoutFragmentEditForm" ];
			var columns = this.m_object.getColumns();
			for(var idx=0; idx<columns.length; idx++) {
			
				//alert("element=" + formElem.elements);    
				formElem.elements["column" + idx].disabled = "true";
			}
		}
	},
	onselect : function(id)
	{
		//alert(id);
		this.m_isSizeFieldSelect = true;
	},
	onkeypress : function(a_event, elm, columnLength)
	{
		//alert("columnLength=" + columnLength + ", value=" + elm.value);
		var keyCode = 0;
		if (document.all)	// it is IE
		{
			keyCode = event.keyCode;
		}
		else {
			keyCode = a_event.which;
		}
		
		var unitElem = document.getElementById("LayoutPortletEditor.ColumnSizeUnit");
		var unit = unitElem.options[ unitElem.selectedIndex ].value;
//		alert( unit);
		var maxUnit = 100;
		if( unit == 'px' ) {
			maxUnit = enview.portal.LAYOUT_MAX_SIZE;
		}
		
		//alert("keyCode=" + keyCode);
		if(keyCode==8 || (48<=keyCode && keyCode<=57) ) {
			elm.setAttribute("used", true);
			
			var value = keyCode-48;
			if( this.m_isSizeFieldSelect == true ) {
				this.m_isSizeFieldSelect = false;
				elm.value = "";
			}
			else {
				value = elm.value + (keyCode-48);
				if( columnLength > 1 && value > maxUnit ) {
					return false;
				}
			}
			
			//alert("value=" + value);
			var changeElemArray = new Array();
			var i = 0;
			var j = 0;
			var usedValue = 0;
			for( i=0; i<columnLength; i++) {
				var columnElm = document.getElementById( "column" + i );
				//alert("usedValue=" + usedValue + ", value=" + value + ", columnElm.value=" + columnElm.value);
				var used = columnElm.getAttribute("used");
				if( used == "false" ) {
					changeElemArray[j++] = columnElm;
				}
				else if( columnElm == elm ) {
					usedValue += Number( value );
				}
				else {
					usedValue += Number( columnElm.value );
				}
				//alert("usedValue=" + usedValue);
			}
			//alert("usedValue=" + usedValue);
			 
			var asignVal = 0;
			if( changeElemArray.length > 0 ) {
				asignVal = Math.floor( (maxUnit - usedValue) / changeElemArray.length );
			}
			else {
				asignVal = maxUnit - usedValue;
			}
			
			//alert("changeElemArray=" + changeElemArray.length + ", usedValue=" + usedValue + ", asignValue=" + asignVal);
			
			if( unit == '%' && asignVal < 0 ) {
				alert( portalPage.getMessageResource("ev.info.columnSizeOver") );
				return false;
			}
			
			for(i=0; i<changeElemArray.length; i++) {
				changeElemArray[i].value = asignVal;
			}
			
			return true;
		}
		else {
			return false;
		}
	},
	changeLayout : function()
	{
		var name = document.getElementById("LayoutPortletEditor.SELECT_LAYOUT").value;
		var align = ""; //document.getElementById("LayoutPortletEditor.SELECT_ALIGN").value;
		var attribute = this.m_attributeMap.get(name);
		var layoutSize = attribute.sizes;
		var unit = document.getElementById("LayoutPortletEditor.ColumnSizeUnit").value;
		var contentType = document.getElementById("LayoutPortletEditor.SELECT_CONTENTTYPE").value;
		//alert(unit);
		var formElem = document.forms[ "PortalLayoutFragmentEditForm" ];
		if(this.m_isChangeLayout==false && this.m_object.getColumns()!=null) {
			layoutSize = "";
			var columns = this.m_object.getColumns();
			for(var idx=0; idx<columns.length; idx++) {
				//columns[idx] = formElem.elements["column" + idx].value;
				if( idx > 0 ) {
					layoutSize += ",";
				}
				layoutSize += formElem.elements["column" + idx].value + unit;
			}
		}
		//alert(layoutSize);
		
		var actionMask = 0;
		if( document.getElementById("LayoutPortletEditor.ADD_ENABLE").checked == true ) {
			actionMask |= 0x00001000;
		}
		if( document.getElementById("LayoutPortletEditor.EDIT_ENABLE").checked == true ) {
			actionMask |= 0x00000100;
		}
		if( document.getElementById("LayoutPortletEditor.MOVE_ENABLE").checked == true ) {
			actionMask |= 0x00000010;
		}
		if( document.getElementById("LayoutPortletEditor.DELETE_ENABLE").checked == true ) {
			actionMask |= 0x00000001;
		}
		
		//alert( attribute.columns );
		this.m_object.changeLayout(name, layoutSize, align, contentType, actionMask, attribute);
	},
	remove : function()
	{
		this.m_object.remove();
	}
}

var portalPortletEditor = null;
enview.portal.PortletEditor = function(data)
{
	this.m_fragmentPropDialog = document.createElement("div");
	this.m_fragmentPropDialog.id = "PortletEditorDialog";
	this.m_fragmentPropDialog.title = portalPage.getMessageResource("ev.info.page.editPortlet");
	this.m_fragmentPropDialog.innerHTML = data;
	document.body.appendChild( this.m_fragmentPropDialog );
					
	$("#PortletEditorDialog").dialog({
			autoOpen: false,
			resizable: true,
			width:420, 
			//height:400,
			modal: true,
			buttons: {
				Cancel: function() {
					$(this).dialog('close');
				},
				/*
				"Remove": function() {
					$(this).dialog('close');
					portalPortletEditor.remove();
				},
				*/
				"Apply": function() {
					$(this).dialog('close');
					portalPortletEditor.changeDecorator();
				}
			}
		});
}
enview.portal.PortletEditor.prototype =
{
	m_object : null,
	m_fragmentPropDialog : null,
	
	show : function(obj)
	{
		//alert("portlet id=" + obj.m_id);
		//alert("portlet type=" + obj.m_attribute.contentType);
		this.m_object = obj;
		
		var contentType = obj.m_contentType;
		document.getElementById("PortletEditor.SELECT_CONTENT_TYPE").value = contentType;
		//alert(obj.m_preference["TITLE-SHOW"]);
		document.getElementById("PortletEditor.SELECT_SYSTEM_CODE").value = (obj.m_preference["SYSTEM_CODE"] != null) ? obj.m_preference["SYSTEM_CODE"] : "";
		//alert("this.m_fsource=" + this.m_fsource);
		document.getElementById("PortletEditor.AUTO_RESIZE").checked = (obj.m_preference["AUTO-RESIZE"] == "true") ? true : false;
		document.getElementById("PortletEditor.SCROLLING").checked = (obj.m_preference["SCROLLING"] == "yes") ? true : false;
		document.getElementById("PortletEditor.TITLE_SHOW").checked = (obj.m_preference["TITLE-SHOW"] != null && obj.m_preference["TITLE-SHOW"] == "true") ? true : false;
		document.getElementById("PortletEditor.CONTENT_TITLE").value = (obj.m_preference["TITLE"] != null) ? obj.m_preference["TITLE"] : "";
		document.getElementById("PortletEditor.CONTENT_CLASS").value = (obj.m_preference["CLASS"] != null) ? obj.m_preference["CLASS"] : "";
		document.getElementById("PortletEditor.WIDTH").value = (obj.m_preference["WIDTH"] != null) ? obj.m_preference["WIDTH"] : "";
		document.getElementById("PortletEditor.HEIGHT").value = (obj.m_preference["HEIGHT"] != null) ? obj.m_preference["HEIGHT"] : "";
		document.getElementById("PortletEditor.MAX_HEIGHT").value = (obj.m_preference["MAX-HEIGHT"] != null) ? obj.m_preference["MAX-HEIGHT"] : "";
		document.getElementById("PortletEditor.CONTENT_STYLE").value = (obj.m_preference["STYLE"] != null) ? obj.m_preference["STYLE"] : "";
		document.getElementById("PortletEditor.CONTENT_SOURCE").value = (obj.m_preference["SRC"] != null) ? obj.m_preference["SRC"] : "";
		document.getElementById("PortletEditor.MORE_SRC").value = (obj.m_preference["MORE_SRC"] != null) ? obj.m_preference["MORE_SRC"] : "";
		document.getElementById("PortletEditor.MORE_SRC_TARGET").value = (obj.m_preference["MORE_SRC_TARGET"] != null) ? obj.m_preference["MORE_SRC_TARGET"] : "";
		
		if( portalPage.getServletPath() == "/contentonly" ) {
			document.getElementById("PortletEditor.ACTIONMASK_PANE").style.display = "";
		}
		else {
			document.getElementById("PortletEditor.ACTIONMASK_PANE").style.display = "none";
		}
		
		var actionMask = obj.getActionMask();
		if( (actionMask & 0x00001000) == 0x00001000 ) {
			document.getElementById("PortletEditor.ADD_ENABLE").checked = true;
		}
		else {
			document.getElementById("PortletEditor.ADD_ENABLE").checked = false;
		}
		if( (actionMask & 0x00000100) == 0x00000100 ) {
			document.getElementById("PortletEditor.EDIT_ENABLE").checked = true;
		}
		else {
			document.getElementById("PortletEditor.EDIT_ENABLE").checked = false;
		}
		if( (actionMask & 0x00000010) == 0x00000010 ) {
			document.getElementById("PortletEditor.MOVE_ENABLE").checked = true;
		}
		else {
			document.getElementById("PortletEditor.MOVE_ENABLE").checked = false;
		}
		if( (actionMask & 0x00000001) == 0x00000001 ) {
			document.getElementById("PortletEditor.DELETE_ENABLE").checked = true;
		}
		else {
			document.getElementById("PortletEditor.DELETE_ENABLE").checked = false;
		}
		
		document.getElementById("PortletEditorDialog.Fragment").value = obj.getFragmentId();
		document.getElementById("PortletEditorDialog.Name").innerHTML = obj.getName();
		
		var pos = (new enview.util.Utility()).getAbsolutePosition( obj.getDomElement() );
		var left = pos.getX();
		var top = pos.getY() + 20;
		$('#PortletEditorDialog').dialog( "option", "position", [left,top] );
		
		$('#PortletEditorDialog').dialog('open');
	},
	changeDecorator : function()
	{
		this.m_object.m_preference["SYSTEM_CODE"] = document.getElementById("PortletEditor.SELECT_SYSTEM_CODE").value;
		this.m_object.m_preference["AUTO-RESIZE"] = (document.getElementById("PortletEditor.AUTO_RESIZE").checked == true) ? "true" : "false";
		this.m_object.m_preference["SCROLLING"] = (document.getElementById("PortletEditor.SCROLLING").checked == true) ? "true" : "false";
		this.m_object.m_preference["TITLE-SHOW"] = (document.getElementById("PortletEditor.TITLE_SHOW").checked == true) ? "true" : "false";
		this.m_object.m_preference["TITLE"] = document.getElementById("PortletEditor.CONTENT_TITLE").value;
		this.m_object.m_preference["CLASS"] = document.getElementById("PortletEditor.CONTENT_CLASS").value;
		this.m_object.m_preference["WIDTH"] = document.getElementById("PortletEditor.WIDTH").value;
		this.m_object.m_preference["HEIGHT"] = document.getElementById("PortletEditor.HEIGHT").value;
		this.m_object.m_preference["MAX-HEIGHT"] = document.getElementById("PortletEditor.MAX_HEIGHT").value;
		this.m_object.m_preference["STYLE"] = document.getElementById("PortletEditor.CONTENT_STYLE").value;
		this.m_object.m_preference["SRC"] = document.getElementById("PortletEditor.CONTENT_SOURCE").value;
		this.m_object.m_preference["MORE_SRC"] = document.getElementById("PortletEditor.MORE_SRC").value;
		this.m_object.m_preference["MORE_SRC_TARGET"] = document.getElementById("PortletEditor.MORE_SRC_TARGET").value;
		
		var actionMask = 0;
		if( document.getElementById("PortletEditor.ADD_ENABLE").checked == true ) {
			actionMask |= 0x00001000;
		}
		if( document.getElementById("PortletEditor.EDIT_ENABLE").checked == true ) {
			actionMask |= 0x00000100;
		}
		if( document.getElementById("PortletEditor.MOVE_ENABLE").checked == true ) {
			actionMask |= 0x00000010;
		}
		if( document.getElementById("PortletEditor.DELETE_ENABLE").checked == true ) {
			actionMask |= 0x00000001;
		}
		this.m_object.setActionMask( actionMask );
		
		this.m_object.changeDecorator();
	},
	remove : function()
	{
		this.m_object.remove();
	}
}