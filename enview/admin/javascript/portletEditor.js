var portalLayoutPortletEditor = null;
enview.portal.LayoutPortletEditor = function(data)
{
	this.m_ajax = new enview.util.Ajax();
	this.m_fragmentPropDialog = document.createElement("div");
	this.m_fragmentPropDialog.id = "LayoutPortletEditorDialog";
	this.m_fragmentPropDialog.title = portalPage.getMessageResource("ev.info.page.editPortlet");
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
		this.m_ajax.send("POST", portalPage.getContextPath() + "/common/getLayoutPortletInfoForAjax.admin", "", false, {
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
		//alert( unit);
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
			
			if( asignVal < 0 ) {
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
		
		//alert( attribute.displayName );
		this.m_object.changeLayout(name, layoutSize, align, actionMask, attribute);
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
		alert(obj.m_preference["SYSTEM_CODE"]);
		document.getElementById("PortletEditor.SELECT_SYSTEM_CODE").value = (obj.m_preference["SYSTEM_CODE"] != null) ? obj.m_preference["SYSTEM_CODE"] : "";
		//alert("this.m_fsource=" + this.m_fsource);
		document.getElementById("PortletEditor.AUTO_RESIZE").checked = (obj.m_preference["AUTO-RESIZE"] == "true") ? true : false;
		document.getElementById("PortletEditor.SCROLLING").checked = (obj.m_preference["SCROLLING"] == "true") ? true : false;
		document.getElementById("PortletEditor.TITLE_SHOW").checked = (obj.m_preference["TITLE-SHOW"] == null || obj.m_preference["TITLE-SHOW"] == "true") ? true : false;
		document.getElementById("PortletEditor.CONTENT_TITLE").value = (obj.m_preference["TITLE"] != null) ? obj.m_preference["TITLE"] : "";
		document.getElementById("PortletEditor.CONTENT_CLASS").value = (obj.m_preference["CLASS"] != null) ? obj.m_preference["CLASS"] : "";
		document.getElementById("PortletEditor.WIDTH").value = (obj.m_preference["WIDTH"] != null) ? obj.m_preference["WIDTH"] : "";
		document.getElementById("PortletEditor.HEIGHT").value = (obj.m_preference["HEIGHT"] != null) ? obj.m_preference["HEIGHT"] : "";
		document.getElementById("PortletEditor.MAX_HEIGHT").value = (obj.m_preference["MAX-HEIGHT"] != null) ? obj.m_preference["MAX-HEIGHT"] : "";
		document.getElementById("PortletEditor.CONTENT_STYLE").value = (obj.m_preference["STYLE"] != null) ? obj.m_preference["STYLE"] : "";
		document.getElementById("PortletEditor.CONTENT_SOURCE").value = (obj.m_preference["SRC"] != null) ? obj.m_preference["SRC"] : "";
		document.getElementById("PortletEditor.MORE_SOURCE").value = (obj.m_preference["MORE_SOURCE"] != null) ? obj.m_preference["MORE_SOURCE"] : "";
		document.getElementById("PortletEditor.MORE_TARGET").value = (obj.m_preference["MORE_TARGET"] != null) ? obj.m_preference["MORE_TARGET"] : "";
		
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
		/*
		if( (contentType == "iframe" || contentType == "normal") && (portalPage.getServletPath() == "/contentonly" || portalPage.getUserId() == "enview")) {
			document.getElementById("PortletEditor.SELECT_CONTENT_TYPE_PANE").style.display = "";
			document.getElementById("PortletEditor.CONTENT_TITLE_PANE").style.display = "";
			document.getElementById("PortletEditor.CONTENT_SOURCE_PANE").style.display = "";
			document.getElementById("PortletEditor.OPTION_PANE").style.display = "";
			document.getElementById("PortletEditor.CONTENT_EXTRA_PANE").style.display = "";
			document.getElementById("PortletEditor.SIZE_PANE").style.display = "";
			document.getElementById("PortletEditor.CONTENT_STYLE_PANE").style.display = "";
			document.getElementById("PortletEditor.MORE_SOURCE_PANE").style.display = "";
		}
		else if( contentType == "static" && (portalPage.getServletPath() == "/contentonly" || portalPage.getUserId() == "admin")) {
			document.getElementById("PortletEditor.SELECT_CONTENT_TYPE_PANE").style.display = "none";
			document.getElementById("PortletEditor.CONTENT_TITLE_PANE").style.display = "";
			document.getElementById("PortletEditor.CONTENT_SOURCE_PANE").style.display = "";
			document.getElementById("PortletEditor.OPTION_PANE").style.display = "";
			document.getElementById("PortletEditor.CONTENT_EXTRA_PANE").style.display = "none";
			document.getElementById("PortletEditor.SIZE_PANE").style.display = "";
			document.getElementById("PortletEditor.CONTENT_STYLE_PANE").style.display = "";
			document.getElementById("PortletEditor.MORE_SOURCE_PANE").style.display = "none";
		}
		else {
			document.getElementById("PortletEditor.SELECT_CONTENT_TYPE_PANE").style.display = "none";
			document.getElementById("PortletEditor.CONTENT_TITLE_PANE").style.display = "";
			document.getElementById("PortletEditor.CONTENT_SOURCE_PANE").style.display = "none";
			document.getElementById("PortletEditor.OPTION_PANE").style.display = "";
			document.getElementById("PortletEditor.CONTENT_EXTRA_PANE").style.display = "none";
			document.getElementById("PortletEditor.SIZE_PANE").style.display = "";
			document.getElementById("PortletEditor.CONTENT_STYLE_PANE").style.display = "";
			document.getElementById("PortletEditor.MORE_SOURCE_PANE").style.display = "none";
		}
		*/
		document.getElementById("PortletEditorDialog.Fragment").value = obj.getFragmentId();
		document.getElementById("PortletEditorDialog.Name").innerHTML = obj.getName();
		
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
		this.m_object.m_preference["MORE_SOURCE"] = document.getElementById("PortletEditor.MORE_SOURCE").value;
		this.m_object.m_preference["MORE_TARGET"] = document.getElementById("PortletEditor.MORE_TARGET").value;
		
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

var portalMyPageEditor = null;
enview.portal.MyPageEditor = function()
{
	this.m_ajax = new enview.util.Ajax();
	this.m_ajax.setContextPath( portalPage.getContextPath() );
	
	$("#MyPageEditorDialog").dialog({
			autoOpen: false,
			resizable: true,
			width:400, 
			//height:400,
			modal: true,
			buttons: {
				Cancel: function() {
					$(this).dialog('close');
				},
				"Apply": function() {
					$(this).dialog('close');
					portalMyPageEditor.doUpdate();
				}
			}
		});
	
	this.m_addHandler = function()
	{
	  this.populate = function(data) 
	  {
		//alert("PortletChangeLayoutHandler");
		var msg = portalPage.m_ajax.retrieveElementValue("message", data);
		var path = portalPage.m_ajax.retrieveElementValue("id", data);
		//window.status =  msg;
		var serverpath = "";
		if(portalPage.getContextPath().lastIndexOf("/") > -1 ) {
			serverpath = portalPage.getContextPath() + portalPage.getServletPath();
		}
		else {
			serverpath = portalPage.getContextPath() + "/" + portalPage.getServletPath();
		}
		location.href = serverpath + path;
	  }     
	  this.failure = function(msg)
	  {
		alert( msg );
	  }
	};
	
	this.m_updateHandler = function()
	{
	  this.populate = function(data) 
	  {
		//alert("PortletRemoveHandler");
		//location.reload(true);
		var id = portalPage.m_ajax.retrieveElementValue("id", data);
		var msg = portalPage.m_ajax.retrieveElementValue("message", data);
		
		portalPage.setTitle( document.getElementById("MyPageEditorDialog.name").value );
		document.getElementById("Enview.MyPage.TabHeaderTitle:" + id).innerHTML = "<span>" + portalPage.getTitle() + "</span>";
		//window.status =  msg;
	  }     
	  this.failure = function(msg)
	  {
		alert( msg );
	  }
	};

	this.m_removeHandler = function()
	{
	  this.populate = function(data) 
	  {
		var msg = portalPage.m_ajax.retrieveElementValue("message", data);
		//window.status =  msg;
		var path = portalPage.m_ajax.retrieveElementValue("id", data);
		var serverpath = "";
		if(portalPage.getContextPath().lastIndexOf("/") > -1 ) {
			serverpath = portalPage.getContextPath() + portalPage.getServletPath();
		}
		else {
			serverpath = portalPage.getContextPath() + "/" + portalPage.getServletPath();
		}
		location.href = serverpath + path;
	  }     
	  this.failure = function(msg)
	  {
		alert( msg );
	  }
	};
	
	this.m_invokeHandler = function()
	{
	  this.populate = function(data) 
	  {
		var msg = portalPage.m_ajax.retrieveElementValue("message", data);
		//alert(msg);
	  }     
	  this.failure = function(msg)
	  {
		alert( msg );
	  }
	};
}
enview.portal.MyPageEditor.prototype =
{
	m_myPageEditDialog : null,
	m_removeHandler : null,
	m_updateHandler : null,
	m_addHandler : null,
	m_invokeHandler : null,
	m_pageId : null,
	
	init : function()
	{
		
	},
	
	show : function(elm)
	{
		document.getElementById("MyPageEditorDialog.name").focus();
		$('#MyPageEditorDialog').dialog('open');
	},
	doSelect : function(id, elm)
	{
		this.m_pageId = id;
		document.getElementById("MyPageEditorDialog.name").value = portalPage.getTitle();
		document.getElementById("MyPageEditorDialog.SELECT_LAYOUT").style.display = "none";
		document.getElementById("MyPageEditorDialog.isCreate").value = "false";
	},
	doCreate : function(id, elm)
	{
		this.m_pageId = id;
		document.getElementById("MyPageEditorDialog.name").value = "";
		document.getElementById("MyPageEditorDialog.SELECT_LAYOUT").style.display = "";
		document.getElementById("MyPageEditorDialog.isCreate").value = "true";
	},
	doUpdate : function()
	{
		var names = new Array();
	    var values = new Array();
		
		var i = 0;
		var isCreate = document.getElementById("MyPageEditorDialog.isCreate").value; 
	    names[i] = "method";
		if( isCreate == "true" ) {
			values[i++] = "addmypage";
		}
		else {
			values[i++] = "updatemypage";
		}
		
		names[i] = "page_id";
		values[i++] = this.m_pageId;
		names[i] = "path";
		values[i++] = encodeURIComponent( document.getElementById("MyPageEditorDialog.path").value );
		names[i] = "name";

		var pageNameElem = document.getElementById("MyPageEditorDialog.name");
		if( pageNameElem.value==null || pageNameElem.value.trim().length==0 ) {
			pageNameElem.value = "";
			pageNameElem.focus();
			return;
		}
		values[i++] = encodeURIComponent( pageNameElem.value );
		names[i] = "theme";
		values[i++] = document.getElementById("MyPageEditorDialog.SELECT_THEME").value;
		names[i] = "layout";
		values[i++] = encodeURIComponent( document.getElementById("MyPageEditorDialog.SELECT_LAYOUT").value );
		
		this.hide(); 
				
		if( isCreate == "true" ) {
			this.m_ajax.invoke("editpage", names, values, new this.m_addHandler(), "text/xml" );
		}
		else {
			this.m_ajax.invoke("editpage", names, values, new this.m_updateHandler(), "text/xml" );
		}
	},
	doRemove : function(user_id)
	{
		var names = new Array();
	    var values = new Array();
		var ix = 0;
		
	    names[ix] = "method";
		values[ix++] = "removemypage";
		names[ix] = "user_id";
		values[ix++] = user_id;
		names[ix] = "path";
		values[ix++] = document.getElementById("MyPageEditorDialog.path").value;
		
		this.m_ajax.invoke("editpage", names, values, new this.m_removeHandler(), "text/xml" );
	},
	setDefaultMyPage : function(user_id, path) 
	{
		var names = new Array();
		var values = new Array();
		var ix = 0;
		
		names[ix] = "method";
		values[ix++] = "defaultmypage";
		names[ix] = "user_id";
		values[ix++] = user_id;
		names[ix] = "default_page";
		values[ix++] = path;
		
		//alert("userId=" + userId + ", page=" + page);
		this.m_ajax.invoke("editpage", names, values, new this.m_invokeHandler(), "text/xml" );
	},
	setDefaultGroupPage : function(user_id) 
	{
		var names = new Array();
		var values = new Array();
		var ix = 0;
		
		names[ix] = "method";
		values[ix++] = "defaulthomepage";
		names[ix] = "user_id";
		values[ix++] = user_id;
		
		//alert("userId=" + userId + ", page=" + page);
		this.m_ajax.invoke("editpage", names, values, new this.m_invokeHandler(), "text/xml" );
	}
}
