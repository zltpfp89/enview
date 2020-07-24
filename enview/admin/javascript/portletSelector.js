var portalPortletSelector = null;
enview.portal.PortletSelector = function(evSecurityCode)
{
	this.m_checkBoxUtil = new enview.util.CheckBoxUtil();
	this.m_ajax = new enview.util.Ajax();
	this.m_ajax.setContextPath( portalPage.getContextPath() );
	this.m_evSecurityCode = evSecurityCode;
	
	$("#PortletSelectorDialog").dialog({
			autoOpen: false,
			resizable: true,
			width:500, 
			//height:400,
			modal: false,
			buttons: {
				Cancel: function() {
					$(this).dialog('close');
				},
				"Apply": function() {
					$(this).dialog('close');
					portalPortletSelector.doApply();
				}
			}
		});
	
	this.m_portletInsertHandler = function()
	{
	  this.populate = function(data) 
	  {
		alert("PortletInsertHandler");
	  }     
	  this.failure = function(resultObject)
	  {
	  }
	};
	
	this.m_portletListHandler = function()
	{
	  this.populate = function(data) 
	  {
		portalPortletSelector.doPortletRetrieveHandler(data);
	  }     
	  this.failure = function(resultObject)
	  {
	  }
	};
}
enview.portal.PortletSelector.prototype =
{
	m_checkBoxUtil: null,
	m_allCategoryListHandler: null,
	m_portletInsertHandler: null,
	m_portletListHandler: null,
	m_domElement: null,
	m_ajax: null,
	m_tree: null,
	m_object: null,
	m_evSecurityCode : null,
	
	init: function ()
	{
		this.m_domElement = document.getElementById( 'PortletSelectorDialog' );
		//this.m_domElement.style.display = 'none';
		
		//var e = new enview.util.DragMgr(document.getElementById("PortletSelectorDragArea"), "PortletSelectorDialog");
		var e = new enview.util.DragMgr(this, this.m_domElement, "PortletSelectorDialog");
		e.attach();
		
		this.m_tree = new dhtmlXTreeObject(document.getElementById('PortletSelectorTreeTabPage'),"100%","100%",0);
		this.m_tree.setImagePath(this.m_contextPath + "/dhtmlx/imgs/dhxtree_skyblue/");
		this.m_tree.setOnClickHandler( this.onNodeSelect );
		this.m_tree.enableAutoTooltips(true);
		this.m_tree.setXMLAutoLoading(portalPage.getContextPath() + "/portletCategory/retrieveTreeForAjax.admin?evSecurityCode=" + this.m_evSecurityCode);
		this.m_tree.load(portalPage.getContextPath() + "/portletCategory/retrieveTreeForAjax.admin?id=1&evSecurityCode=" + this.m_evSecurityCode);
	},
	doShow: function (obj)
	{
		this.m_object = obj;
		//this.m_domElement.style.display = "";
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
	
	changeParentId: function (obj)
	{
		var el = document.getElementById("PortletSelectorParentId");
		el.value = obj.options[obj.selectedIndex].value;
	},
	
	onNodeSelect : function (id) {
		var formElem = document.getElementById("PortletSelectorSearchForm");
	    formElem.elements[ "pageNo" ].value = 1;
		
		//alert("id=" + id);
		document.getElementById("Enview.Portal.PortletSelector.categoryId").value = id;
		
		portalPortletSelector.doPortletRetrieve();
	},
	changeCategory : function( obj ) {
		var sel = obj.options[obj.selectedIndex].value;
		document.getElementById("Enview.Portal.PortletSelector.categoryType").value = sel;
		//alert("val=" + sel);
		
		//refreshItem
		//getAllSubItems
		
		
		if( sel == "portlet") {
			portalPortletSelector.m_tree.deleteChildItems(0);
			portalPortletSelector.m_tree.setXMLAutoLoading(portalPage.getContextPath() + "/portletCategory/retrieveTreeForAjax.admin"); 
			portalPortletSelector.m_tree.loadXML(portalPage.getContextPath() + "/portletCategory/retrieveTreeForAjax.admin?id=1")
		}
		else if( sel == "enview-bbs") {
			portalPortletSelector.m_tree.deleteChildItems(0);
			portalPortletSelector.m_tree.setXMLAutoLoading(portalPage.getContextPath() + "/ajaxapi?action=getcompcategorylist&method=getbbscategorylist"); 
			portalPortletSelector.m_tree.loadXML(portalPage.getContextPath() + "/ajaxapi?action=getcompcategorylist&method=getbbscategorylist&id=0")
		}
		else {
			portalPortletSelector.m_tree.deleteChildItems(0);
			portalPortletSelector.m_tree.setXMLAutoLoading(portalPage.getContextPath() + "/ajaxapi?action=files&method=getchildfilelist"); 
			portalPortletSelector.m_tree.loadXML(portalPage.getContextPath() + "/ajaxapi?action=files&method=getchildfilelist&id=/")
		}
	},
	insertPortletToPage: function ()
	{
		//alert("createComponentFormPortlet");
		var formData = "";
	        
		var rowCnts = this.m_checkBoxUtil.getCheckedElements( document.getElementById("PortletSelectorListForm") );
		var rowCntArray = rowCnts.split(",");
		
		var names = new Array();
		var values = new Array();
		names[0] = "method";
		values[0] = "addportlet";
		
		for(i=0, j=1; i<rowCntArray.length-1; i++) {
			names[j] = "PortletSelector[" + i + "].portlet_id";
			values[j++] = document.getElementById('PortletSelector[' + rowCntArray[i] + '].portlet_id').value;
		}
		
		names[j] = "arraySize";
		values[j] = rowCntArray.length;
		
		//alert("formData=" + formData);
		
		this.m_ajax.invoke("updatepage", names, values, new this.m_portletInsertHandler(), "text/json"); 
	},
	doPortletRetrieve: function ()
	{
		var names = new Array();
		var values = new Array();
		
		var formElem = document.forms[ "PortletSelectorSearchForm" ];
	    var formData = "";
	    for (var i=0; i < formElem.elements.length; i++) {
			names[i] = formElem.elements[ i ].name;
			var tmp = formElem.elements[ i ].value;
			if( tmp.lastIndexOf("*") > 0 ) {
				values[i] = "";
			}
			else {
				values[i] = encodeURIComponent( tmp );
			}
	    }
		
		names[i] = "includeSystemCategory";
		values[i] = "false";
		
		this.m_ajax.invoke("getportletlist", names, values, new this.m_portletListHandler(), "text/json"); 
	},
	doPortletRetrieveHandler: function (data)
	{
		var bodyElem = document.getElementById('PortletSelectorListBody');
		//alert("bodyElem=" + bodyElem);
	    var tr_tag = null;
		var div_tag = null;
	    var td_tag = null;
		var chkUtil = new enview.util.CheckBoxUtil();
		var listForm = document.getElementById("PortletSelectorListForm");
		if( listForm != null ) {
			chkUtil.unChkAll( listForm );
		}
		//this.m_checkBoxUtil.unChkAll( document.getElementById("PortletSelectorListForm") );
		for(; bodyElem.hasChildNodes(); )
			bodyElem.removeChild( bodyElem.childNodes[0] );

		var formElem = document.getElementById("PortletSelectorSearchForm");
		//var formElem = document.forms[ "PortletSelectorSearchForm" ];
	    //var page_no = document.getElementById("pageNo").value;
		//var page_size = document.getElementById("pageSize").value;
		/*
		var uniqueId = "";
		var categoryId = document.getElementById("Enview.Portal.PortletSelector.categoryId").value;
		var pos = categoryId.indexOf(".");
		if( pos > -1 ) {
			uniqueId = categoryId.substring( pos+1, categoryId.length );
		}
		*/
		
		var uniqueId = document.getElementById("Enview.Portal.PortletSelector.categoryType").value;

		for(i=0; i<data.Data.length; i++) {
			tr_tag = document.createElement('tr');
			tr_tag.id = "PortletSelector:Portlet[" + i + "]";
			//tr_tag.onmouseover = new Function( "portletSelector.m_checkBoxUtil.rowOver(this)" );
			//tr_tag.onmouseout = new Function( "portletSelector.m_checkBoxUtil.rowOut(this)" );
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
			td_tag.innerHTML = "<input type=\"checkbox\" id=\"PortletSelector[" + i + "].checkRow\" class=\"webcheckbox\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelector[" + i + "].portletId\" value=\"" + data.Data[ i ].portlet_id + "\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelector[" + i + "].portletAppName\" value=\"" + data.Data[ i ].app_name + "\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelector[" + i + "].portletName\" value=\"" + data.Data[ i ].name + "\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelector[" + i + "].portletTitle\" value=\"" + data.Data[ i ].display_name + "\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelector[" + i + "].uniqueId\" value=\"" + uniqueId + "\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelector[" + i + "].addValue1\" value=\"" + data.Data[ i ].addValue1 + "\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelector[" + i + "].addValue2\" value=\"" + data.Data[ i ].addValue2 + "\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelector[" + i + "].addValue3\" value=\"" + data.Data[ i ].addValue3 + "\"/>";
			td_tag.innerHTML += "<input type=\"hidden\" id=\"PortletSelector[" + i + "].title\" value=\"" + data.Data[ i ].desc + "\"/>";
			tr_tag.appendChild( td_tag );
			
			td_tag = document.createElement('td');
			td_tag.setAttribute("class", "webgridbody");
			td_tag.setAttribute("className", "webgridbody");
			td_tag.onclick = new Function( "portalPortletSelector.doPortletSelect(this)" );
			td_tag.align = "center";
			td_tag.innerHTML = "<img src='" + portalPage.getContextPath() + "/images/portlets/" + data.Data[ i ].icon + "'>";
			tr_tag.appendChild( td_tag );
			
			/*
			td_tag = document.createElement('td');
			td_tag.setAttribute("class", "webgridbody");
			td_tag.setAttribute("className", "webgridbody");
			td_tag.align = "left";
			if( data.Data[ i ].addValue1 ) {
				td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"PortletSelector[" + i + "].app_name.label\">" + data.Data[ i ].addValue1 + "</span>";
			}
			else {
				td_tag.innerHTML = "<span class=\"webgridrowlabel\" id=\"PortletSelector[" + i + "].app_name.label\">" + data.Data[ i ].app_name + "</span>";
			}
			tr_tag.appendChild( td_tag );
			*/

			td_tag = document.createElement('td');
			td_tag.setAttribute("class", "webgridbodylast");
			td_tag.setAttribute("className", "webgridbodylast");
			td_tag.onclick = new Function( "portalPortletSelector.doPortletSelect(this)" );
			td_tag.align = "left";
			td_tag.innerHTML = "<span style=\"width:100%;\" class=\"webgridrowlabel\" id=\"PortletSelector[" + i + "].name.label\" dragCopy='true' " + 
								" portletId='" + data.Data[ i ].portlet_id + "'" +
								" portletAppName='" + data.Data[ i ].app_name + "'" +  
								" portletName='" + data.Data[ i ].name + "'" +
								" portletTitle='" + data.Data[ i ].display_name + "'" + 
								" uniqueId='" + uniqueId + "'" +
								" addValue1='" + data.Data[ i ].addValue1 + "'" + 
								" addValue2='" + data.Data[ i ].addValue2 + "'" + 
								" addValue3='" + data.Data[ i ].addValue3 + "'" + 
								" title='" + data.Data[ i ].desc + "'>" + 
								data.Data[ i ].display_name + 
								"</span>";

			td_tag.setAttribute("style", "cursor: pointer;");
			td_tag.style.cursor = "pointer";
			//td_tag.appendChild( div_tag );
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
			td_tag.innerHTML = "<span>" + data.ResultSize + "<br></span>";
			tr_tag.appendChild( td_tag );
			bodyElem.appendChild( tr_tag );
		}
		
		//if(data.Data.length != 0 && data.Data[0].external == "false") {
			var formElem = document.forms[ "PortletSelectorSearchForm" ];
			var pageNo = formElem.elements[ "pageNo" ].value;
			var pageSize = formElem.elements[ "pageSize" ].value;
			var pageFunction = formElem.elements[ "pageFunction" ].value;
			var formName = formElem.elements[ "formName" ].value;
			document.getElementById("PORTLETSELECTOR_PAGE_ITERATOR").innerHTML = 
					(new enview.util.PageNavigationUtil()).getPageIteratorHtmlString(pageNo, pageSize, data.TotalSize, formName, pageFunction);
					
			//document.getElementById("PORTLETSELECTOR_PAGE_ITERATOR").innerHTML = data.PageIterator;	
		//}
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
		
	    this.m_checkBoxUtil.unChkAll( document.getElementById("PortletSelectorListForm") );
	    document.getElementById('PortletSelector[' + rowSeq + '].checkRow').checked = true;
	},
	doApply : function()
	{
		var rowCnts = this.m_checkBoxUtil.getCheckedElements( document.getElementById("PortletSelectorListForm") );
		if( rowCnts == "" ) return; 
		
		var rowCntArray = rowCnts.split(",");
		
		for(i=0, j=1; i<rowCntArray.length; i++) {
			if( rowCntArray[i] ) {
				var id = document.getElementById('PortletSelector[' + rowCntArray[i] + '].portletId').value;
				var app = document.getElementById('PortletSelector[' + rowCntArray[i] + '].portletAppName').value;
				var name = document.getElementById('PortletSelector[' + rowCntArray[i] + '].portletName').value;
				var title = document.getElementById('PortletSelector[' + rowCntArray[i] + '].portletTitle').value;
				var uniqueId = document.getElementById('PortletSelector[' + rowCntArray[i] + '].uniqueId').value;
				var addValue1 = document.getElementById('PortletSelector[' + rowCntArray[i] + '].addValue1').value;
				var addValue2 = document.getElementById('PortletSelector[' + rowCntArray[i] + '].addValue2').value;
				var addValue3 = document.getElementById('PortletSelector[' + rowCntArray[i] + '].addValue3').value;
				
				//alert("this.m_object.id= " + this.m_object.getId());
				if( this.m_object.getType() == enview.portal.LAYOUT_ID_NAME ) {
					var childObject = this.m_object.getFirstChildObject();
					//alert("FirstChildObject=" + childObject + "," + childObject.getDomElement());
					if( childObject != null ) {
						childObject.getParent().insert( childObject, id, app, name, title, uniqueId, addValue1, addValue2, addValue3 );
					}
					else {
						alert("Can't find firstChildObject of layout [" + this.m_object.getId() + "]");
					}
				}
				else {
					this.m_object.getParent().insert( this.m_object, id, app, name, title, uniqueId, addValue1, addValue2, addValue3 );
				}
			}
		}
	}
};