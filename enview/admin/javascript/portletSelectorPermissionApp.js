var portalPortletSelectorPermissionApp = null;
enview.portal.PortletSelectorPermissionApp = function(evSecurityCode)
{
	this.m_checkBox = new enview.util.CheckBoxUtil();
	this.m_ajax = new enview.util.Ajax();
	this.m_ajax.setContextPath( portalPage.getContextPath() );
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = portalPage.getContextPath();
	this.m_evSecurityCode = evSecurityCode;
	
	$("#PortletSelectorPermissionAppDialog").dialog({
			autoOpen: false,
			resizable: true,
			width:600, 
			//height:400,
			modal: true,
			buttons: {
				Cancel: function() {
					$(this).dialog('close');
				},
				"Apply": function() {
					portalPortletSelectorPermissionApp.doApply();
				}
			}
		});
	
}
enview.portal.PortletSelectorPermissionApp.prototype =
{
	m_checkBox: null,
	m_callback: null,
	m_domElement: null,
	m_ajax: null,
	m_tree: null,
	m_object: null,
	m_evSecurityCode : null,
	
	init: function ()
	{
		/*
		this.m_domElement = document.getElementById( 'PortletSelectorPermissionAppDialog' );
		this.m_tree = new dhtmlXTreeObject(document.getElementById('PortletSelectorPermissionAppTreeTabPage'),"100%","100%",0);
		this.m_tree.setImagePath(portalPage.getContextPath() + "/admin/images/tree/");
		this.m_tree.setOnClickHandler( this.onNodeSelect );
		this.m_tree.enableAutoTooltips(true);
		this.m_tree.setXMLAutoLoading(portalPage.getContextPath() + "/portletCategory/retrieveTreeForAjax.admin?evSecurityCode=" + this.m_evSecurityCode);
		this.m_tree.loadXML(portalPage.getContextPath() + "/portletCategory/retrieveTreeForAjax.admin?id=1&evSecurityCode=" + this.m_evSecurityCode);
		*/
		
		portalPortletSelectorPermissionApp.doPortletRetrieve();
	},
	doShow: function (callback)
	{
		this.m_callback = callback;
		//this.m_domElement.style.display = "";
		$('#PortletSelectorPermissionAppDialog').dialog('open');
	},
	
	doHide: function ()
	{
		$('#PortletSelectorPermissionAppDialog').dialog('close');
	},
	
	getDomElement: function ()
	{
		return this.m_domElement;
	},
	
	changeParentId: function (obj)
	{
		var el = document.getElementById("PortletSelectorParentId");
		el.value = obj.options[obj.selectedIndex].value;
	},
	
	onNodeSelect : function (id) {
		var formElem = document.getElementById("PortletSelectorPermissionAppSearchForm");
	    formElem.elements[ "pageNo" ].value = 1;
		
		document.getElementById("PortletSelectorPermissionApp_categoryId").value = id;
		var userData = portalPortletSelectorPermissionApp.m_tree.getItem(id).getAttribute("userData");
		document.getElementById("PortletSelectorPermissionApp_categoryPath").value = userData;
		
		portalPortletSelectorPermissionApp.doPortletRetrieve();
	},
	changeCategory : function( obj ) {
		var sel = obj.options[obj.selectedIndex].value;
		document.getElementById("PortletSelectorPermissionApp_categoryType").value = sel;
		
		if( sel == "portlet") {
			portalPortletSelectorPermissionApp.m_tree.deleteChildItems(0);
			portalPortletSelectorPermissionApp.m_tree.setXMLAutoLoading(portalPage.getContextPath() + "/portletCategory/retrieveTreeForAjax.admin"); 
			portalPortletSelectorPermissionApp.m_tree.loadXML(portalPage.getContextPath() + "/portletCategory/retrieveTreeForAjax.admin?id=1")
		}
		else if( sel == "enview-bbs") {
			portalPortletSelectorPermissionApp.m_tree.deleteChildItems(0);
			portalPortletSelectorPermissionApp.m_tree.setXMLAutoLoading(portalPage.getContextPath() + "/ajaxapi?action=getcompcategorylist&method=getbbscategorylist"); 
			portalPortletSelectorPermissionApp.m_tree.loadXML(portalPage.getContextPath() + "/ajaxapi?action=getcompcategorylist&method=getbbscategorylist&id=0")
		}
		else {
			portalPortletSelectorPermissionApp.m_tree.deleteChildItems(0);
			portalPortletSelectorPermissionApp.m_tree.setXMLAutoLoading(portalPage.getContextPath() + "/ajaxapi?action=files&method=getchildfilelist"); 
			portalPortletSelectorPermissionApp.m_tree.loadXML(portalPage.getContextPath() + "/ajaxapi?action=files&method=getchildfilelist&id=/")
		}
	},
	doPortletRetrieve: function ()
	{
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "PortletSelectorPermissionAppSearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
	    //param += 'portletCategory=rss';
		this.m_ajax.send("POST", this.m_contextPath + "/page/listPortletForAjax.face", param, false, {success: function(data) { portalPortletSelectorPermissionApp.doPortletRetrieveHandler(data); }});
	},
	doPortletRetrieveHandler: function (data)
	{
		var bodyElem = document.getElementById('PortletSelectorPermissionAppListBody');
		//alert("bodyElem=" + bodyElem);
	    var tr_tag = null;
		var div_tag = null;
	    var td_tag = null;
		var chkUtil = new enview.util.CheckBoxUtil();
		var listForm = document.getElementById("PortletSelectorPermissionAppListForm");
		if( listForm != null ) {
			chkUtil.unChkAll( listForm );
		}
		
		for(; bodyElem.hasChildNodes(); )
			bodyElem.removeChild( bodyElem.childNodes[0] );

		var formElem = document.getElementById("PortletSelectorPermissionAppSearchForm");
		var uniqueId = document.getElementById("PortletSelectorPermissionApp_categoryType").value;

		for(i=0; i<data.Data.length; i++) {
			tr_tag = document.createElement('tr');
			tr_tag.id = "PortletSelectorPermissionApp:Portlet[" + i + "]";
			tr_tag.setAttribute("ch", i);
			if( i % 2 == 0 ) {
				tr_tag.setAttribute("class", "even");
				tr_tag.setAttribute("className", "even");
			}
			else {
				tr_tag.setAttribute("class", "odd");
				tr_tag.setAttribute("className", "odd");
			}
			
			td_tag = document.createElement('td');
			td_tag.setAttribute("class", "webgridbody");
			td_tag.setAttribute("className", "webgridbody");
			td_tag.innerHTML = "<input type=\"checkbox\" id=\"PortletSelectorPermissionApp[" + i + "].checkRow\" class=\"webcheckbox\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelectorPermissionApp[" + i + "].checkRow\" class=\"webcheckbox\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelectorPermissionApp[" + i + "].portletId\" value=\"" + data.Data[ i ].id + "\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelectorPermissionApp[" + i + "].portletAppName\" value=\"" + data.Data[ i ].appName + "\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelectorPermissionApp[" + i + "].portletName\" value=\"" + data.Data[ i ].name + "\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelectorPermissionApp[" + i + "].portletTitle\" value=\"" + data.Data[ i ].displayName + "\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelectorPermissionApp[" + i + "].title\" value=\"" + data.Data[ i ].displayName + "\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelectorPermissionApp[" + i + "].uniqueId\" value=\"" + uniqueId + "\"/>";
			td_tag.align = "center";			
			tr_tag.appendChild( td_tag );
			
			td_tag = document.createElement('td');
			td_tag.setAttribute("class", "webgridbody");
			td_tag.setAttribute("className", "webgridbody");
			td_tag.innerHTML += "<img src='" + portalPage.getContextPath() + "/images/portlets/" + data.Data[ i ].icon + "'>";
			td_tag.onclick = new Function( "portalPortletSelectorPermissionApp.doPortletSelect(this)" );
			td_tag.align = "center";			
			tr_tag.appendChild( td_tag );
			
			td_tag = document.createElement('td');
			td_tag.colSpan = "100";
			td_tag.setAttribute("class", "webgridbodylast");
			td_tag.setAttribute("className", "webgridbodylast");
			td_tag.onclick = new Function( "portalPortletSelectorPermissionApp.doPortletSelect(this)" );
			td_tag.align = "left";
			td_tag.innerHTML = "<span style=\"width:100%;\" class=\"webgridrowlabel\" id=\"PortletSelector[" + i + "].name.label\" >" + 
								data.Data[ i ].displayName + 
								"</span>";

			td_tag.setAttribute("style", "cursor: pointer;");
			td_tag.style.cursor = "pointer";
			tr_tag.appendChild( td_tag );

			bodyElem.appendChild( tr_tag );
		}

		if(data.Data.length == 0) {
			//alert("not found");
			tr_tag = document.createElement('tr');
			tr_tag.setAttribute("class", "row-empty");
			tr_tag.setAttribute("className", "row-empty");
			td_tag = document.createElement('td');
			td_tag.colSpan = "100";
			td_tag.innerHTML = "<span>" + portalPage.getMessageResource("ev.info.notFoundData") + "</span>";
			tr_tag.appendChild( td_tag );
			bodyElem.appendChild( tr_tag );
		}
		else {
			tr_tag = document.createElement('tr');
			tr_tag.setAttribute("class", "row-empty");
			tr_tag.setAttribute("className", "row-empty");
			td_tag = document.createElement('td');
			td_tag.colSpan = "100";
			td_tag.innerHTML = "<span>" + portalPage.getMessageResourceByParam('ev.info.resultSize', data.TotalSize) + "<br></span>";
			tr_tag.appendChild( td_tag );
			bodyElem.appendChild( tr_tag );
		}
		
		var formElem = document.forms[ "PortletSelectorPermissionAppSearchForm" ];
		var pageNo = formElem.elements[ "pageNo" ].value;
		var pageSize = formElem.elements[ "pageSize" ].value;
		var pageFunction = formElem.elements[ "pageFunction" ].value;
		var formName = formElem.elements[ "formName" ].value;
		document.getElementById("PORTLETSELECTOR_PAGE_ITERATOR").innerHTML = 
				(new enview.util.PageNavigationUtil()).getPageIteratorHtmlString(pageNo, pageSize, data.TotalSize, formName, pageFunction);
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
		var formElem = document.forms[ "PortletSelectorPermissionAppSearchForm" ];
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
		
	    this.m_checkBox.unChkAll( document.getElementById("PortletSelectorPermissionAppListForm") );
	    document.getElementById('PortletSelectorPermissionApp[' + rowSeq + '].checkRow').checked = true; 
	},
	doApply : function()
	{
		var rowCnts = this.m_checkBox.getCheckedElements( document.getElementById("PortletSelectorPermissionAppListForm") );
		if( rowCnts == "" ) return; 
		
		$('#PortletSelectorPermissionAppDialog').dialog('close');

		var rowCntArray = rowCnts.split(",");
		
		var actionMask = 15; // view authority
		var form = document.getElementById("PortletSelectorPermissionChooser_EditForm");
		for(var j=0; j<form.elements.length; j++) {
			field = form.elements[j];
			//alert(field.type + "," + field.id + "," + field.checked);
			if(field.type == "checkbox" && field.id && field.id.indexOf("PortletSelectorPermission_authority_") > -1 ) {
				if( field.checked == true ) {
					actionMask |= field.value;
				}
			}
		}
		var isAllow = (document.getElementById('PortletSelectorPermission_allow').checked == true) ? "true" : "false";
		
		var result = new Array(rowCntArray.length);
		for(var i=0; i<rowCntArray.length; i++) {
			var rowMap = new Map();
			rowMap.put("title", document.getElementById('PortletSelectorPermissionApp[' + rowCntArray[i] + '].portletTitle').value);
			rowMap.put("path", document.getElementById('PortletSelectorPermissionApp[' + rowCntArray[i] + '].portletAppName').value + "::" + document.getElementById('PortletSelectorPermissionApp[' + rowCntArray[i] + '].portletName').value);
			rowMap.put("actionMask", actionMask);	
			rowMap.put("isAllow", isAllow);	
			rowMap.put("resType", "2");	
			result[i] = rowMap;
		}
		
		this.m_callback(result);
	}
};