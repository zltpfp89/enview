var portalPortletSelectorApp = null;
enview.portal.PortletSelectorApp = function(evSecurityCode)
{
	this.m_checkBoxUtil = new enview.util.CheckBoxUtil();
	this.m_ajax = new enview.util.Ajax();
	this.m_ajax.setContextPath( portalPage.getContextPath() );
	this.m_utility = new enview.util.Utility();
	this.m_contextPath = portalPage.getContextPath();
	this.m_evSecurityCode = evSecurityCode;
	
	$("#PortletSelectorAppDialog").dialog({
			autoOpen: false,
			resizable: true,
			width:500, 
			//height:400,
			modal: true,
			buttons: {
				Cancel: function() {
					$(this).dialog('close');
				},
				"Apply": function() {
					portalPortletSelectorApp.doApply();
				}
			}
		});
	
}
enview.portal.PortletSelectorApp.prototype =
{
	m_checkBoxUtil: null,
	m_callback: null,
	m_domElement: null,
	m_ajax: null,
	m_tree: null,
	m_object: null,
	m_evSecurityCode : null,
	
	init: function ()
	{
		this.m_domElement = document.getElementById( 'PortletSelectorDialog' );
		this.m_tree = new dhtmlXTreeObject(document.getElementById('PortletSelectorAppTreeTabPage'),"100%","100%",0);
		this.m_tree.setImagePath(this.m_contextPath + "/dhtmlx/imgs/dhxtree_skyblue/");
		this.m_tree.setOnClickHandler( this.onNodeSelect );
		this.m_tree.enableAutoTooltips(true);
		this.m_tree.setXMLAutoLoading(portalPage.getContextPath() + "/portletCategory/retrieveTreeForAjax.admin?evSecurityCode=" + this.m_evSecurityCode);
		this.m_tree.load(portalPage.getContextPath() + "/portletCategory/retrieveTreeForAjax.admin?id=1&evSecurityCode=" + this.m_evSecurityCode);
	},
	doShow: function (callback)
	{
		this.m_callback = callback;
		//this.m_domElement.style.display = "";
		$('#PortletSelectorAppDialog').dialog('open');
	},
	
	doHide: function ()
	{
		$('#PortletSelectorAppDialog').dialog('close');
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
		var formElem = document.getElementById("PortletSelectorAppSearchForm");
	    formElem.elements[ "pageNo" ].value = 1;
		
		document.getElementById("PortletSelectorApp_categoryId").value = id;
		
		portalPortletSelectorApp.doPortletRetrieve();
	},
	changeCategory : function( obj ) {
		var sel = obj.options[obj.selectedIndex].value;
		document.getElementById("PortletSelectorApp_categoryType").value = sel;
		
		if( sel == "portlet") {
			portalPortletSelectorApp.m_tree.deleteChildItems(0);
			portalPortletSelectorApp.m_tree.setXMLAutoLoading(portalPage.getContextPath() + "/portletCategory/retrieveTreeForAjax.admin"); 
			portalPortletSelectorApp.m_tree.loadXML(portalPage.getContextPath() + "/portletCategory/retrieveTreeForAjax.admin?id=1")
		}
		else if( sel == "enview-bbs") {
			portalPortletSelectorApp.m_tree.deleteChildItems(0);
			portalPortletSelectorApp.m_tree.setXMLAutoLoading(portalPage.getContextPath() + "/ajaxapi?action=getcompcategorylist&method=getbbscategorylist"); 
			portalPortletSelectorApp.m_tree.loadXML(portalPage.getContextPath() + "/ajaxapi?action=getcompcategorylist&method=getbbscategorylist&id=0")
		}
		else {
			portalPortletSelectorApp.m_tree.deleteChildItems(0);
			portalPortletSelectorApp.m_tree.setXMLAutoLoading(portalPage.getContextPath() + "/ajaxapi?action=files&method=getchildfilelist"); 
			portalPortletSelectorApp.m_tree.loadXML(portalPage.getContextPath() + "/ajaxapi?action=files&method=getchildfilelist&id=/")
		}
	},
	doPortletRetrieve: function ()
	{
		var param = "evSecurityCode=" + this.m_evSecurityCode + "&";
		var formElem = document.forms[ "PortletSelectorAppSearchForm" ];
	    for (var i=0; i < formElem.elements.length; i++) {
			var tmp = formElem.elements[ i ].value;
			if( tmp.indexOf("*") != 0 ) {
				param += formElem.elements[ i ].name + "=" + encodeURIComponent( tmp ) + "&";
			}
	    }
		
		this.m_ajax.send("POST", this.m_contextPath + "/common/listPortletForAjax.admin", param, false, {success: function(data) { portalPortletSelectorApp.doPortletRetrieveHandler(data); }});
	},
	doPortletRetrieveHandler: function (data)
	{
		var bodyElem = document.getElementById('PortletSelectorAppListBody');
		//alert("bodyElem=" + bodyElem);
	    var tr_tag = null;
		var div_tag = null;
	    var td_tag = null;
		var chkUtil = new enview.util.CheckBoxUtil();
		var listForm = document.getElementById("PortletSelectorAppListForm");
		if( listForm != null ) {
			chkUtil.unChkAll( listForm );
		}
		
		for(; bodyElem.hasChildNodes(); )
			bodyElem.removeChild( bodyElem.childNodes[0] );

		var formElem = document.getElementById("PortletSelectorAppSearchForm");
		var uniqueId = document.getElementById("PortletSelectorApp_categoryType").value;

		for(i=0; i<data.Data.length; i++) {
			tr_tag = document.createElement('tr');
			tr_tag.id = "PortletSelectorApp:Portlet[" + i + "]";
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
			td_tag.align = "center";
			td_tag.setAttribute("class", "webgridbody");
			td_tag.setAttribute("className", "webgridbody");
			td_tag.innerHTML = "<input type=\"checkbox\" id=\"PortletSelectorApp[" + i + "].checkRow\" class=\"webcheckbox\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelectorApp[" + i + "].portletId\" value=\"" + data.Data[ i ].id + "\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelectorApp[" + i + "].portletAppName\" value=\"" + data.Data[ i ].appName + "\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelectorApp[" + i + "].portletName\" value=\"" + data.Data[ i ].name + "\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelectorApp[" + i + "].portletTitle\" value=\"" + data.Data[ i ].displayName + "\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelectorApp[" + i + "].title\" value=\"" + data.Data[ i ].description + "\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelectorApp[" + i + "].uniqueId\" value=\"" + uniqueId + "\"/>";
			
			tr_tag.appendChild( td_tag );
			
			td_tag = document.createElement('td');
			td_tag.setAttribute("class", "webgridbody");
			td_tag.setAttribute("className", "webgridbody");
			td_tag.onclick = new Function( "portalPortletSelectorApp.doPortletSelect(this)" );
			td_tag.align = "center";
			td_tag.innerHTML = "<img src='" + portalPage.getContextPath() + "/images/portlets/" + data.Data[ i ].icon + "'>";
			tr_tag.appendChild( td_tag );
			
			td_tag = document.createElement('td');
			td_tag.setAttribute("class", "webgridbodylast");
			td_tag.setAttribute("className", "webgridbodylast");
			td_tag.onclick = new Function( "portalPortletSelectorApp.doPortletSelect(this)" );
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
		
		var formElem = document.forms[ "PortletSelectorAppSearchForm" ];
		var pageNo = formElem.elements[ "pageNo" ].value;
		var pageSize = formElem.elements[ "pageSize" ].value;
		var pageFunction = formElem.elements[ "pageFunction" ].value;
		var formName = formElem.elements[ "formName" ].value;
		document.getElementById("PORTLETSELECTOR_APP_PAGE_ITERATOR").innerHTML = 
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
		var formElem = document.forms[ "PortletSelectorAppSearchForm" ];
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
		
	    this.m_checkBoxUtil.unChkAll( document.getElementById("PortletSelectorAppListForm") );
	    document.getElementById('PortletSelectorApp[' + rowSeq + '].checkRow').checked = true;
	},
	doApply : function()
	{
		var rowCnts = this.m_checkBoxUtil.getCheckedElements( document.getElementById("PortletSelectorAppListForm") );
		if( rowCnts == "" ) return; 
		
		var rowCntArray = rowCnts.split(",");
		if( rowCntArray.length > 0 ) {
			if( rowCntArray.length > 1 ) {
				alert( portalPage.getMessageResource('ev.info.select.onlyone') );
				return;
			}
		
			$('#PortletSelectorAppDialog').dialog('close');

			var result = new Array(1);
			var rowMap = new Map();
			rowMap.put("id", document.getElementById('PortletSelectorApp[' + rowCntArray[0] + '].portletId').value);
			rowMap.put("app", document.getElementById('PortletSelectorApp[' + rowCntArray[0] + '].portletAppName').value);
			rowMap.put("name", document.getElementById('PortletSelectorApp[' + rowCntArray[0] + '].portletName').value);
			rowMap.put("title", document.getElementById('PortletSelectorApp[' + rowCntArray[0] + '].portletTitle').value);
			rowMap.put("uniqueId", document.getElementById('PortletSelectorApp[' + rowCntArray[0] + '].uniqueId').value);
			result[0] = rowMap;
			
			this.m_callback(result);
		}
	}
};