if ( ! window.enview )
    window.enview = new Object();
	
if ( ! window.enview.portal )
    window.enview.portal = new Object();
	
enview.portal.TabPane = function (tabPaneElt, siteId)
{
	//alert("tabPaneElt=" + tabPaneElt);
    // Reference to the first table element with class="tab"
    this.m_tabPaneElt = tabPaneElt;
    // Array of TabPage objects
    this.m_tabPages = new Array ();
    // Reference to the active TabPage object */
    this.m_activeTabPage = null;
	
	this.m_contextMenu = new enview.portal.ContextMenu("1997", portalPage.getMessageResource("pt.ev.mypage.menu"));
	this.m_contextMenu.setImagePath(portalPage.getContextPath() + "/decorations/layout/images/");
	this.m_contextMenu.addMenuItem(portalPage.getMessageResource("pt.ev.mypage.edit"), "edit.gif", new Function("portalPage.showMyPageEditor('" + siteId + "',  false)"));
	this.m_contextMenu.addMenuItem(portalPage.getMessageResource("pt.ev.mypage.add"), "select.gif", new Function("portalPage.showMyPageEditor('" + siteId + "',  true)") );
	this.m_contextMenu.addMenuItem(portalPage.getMessageResource("pt.ev.mypage.remove"), "icon_del.gif", new Function("portalPage.removeMyPage()"));
	this.m_contextMenu.addSeparator();
	this.m_contextMenu.addMenuItem(portalPage.getMessageResource("pt.ev.mypage.homepage"), "home_small.png", new Function("portalPage.setDefaultMyPage()"));
	this.m_contextMenu.addMenuItem(portalPage.getMessageResource("pt.ev.mypage.grouppage"), "home_small.png", new Function("portalPage.setDefaultGroupPage()"));
}

/** 
 * Clean-up resources (needed otherwise IE will consume more and more memory; FireFox does
 * not have this problem)
 */
enview.portal.TabPane.prototype =
{
	m_tabPaneElt : null,
	m_tabPages : null,
	m_activeTabPage : null,
	m_contextMenu : null,
	
	/**
	 * Add a tab page to the TabPane. This is done by passing a reference
	 * to a table element with class="tab".
	 *
	 * a_tableElt: reference to table element with class="tab"
	 */
	addTabPage : function ( a_tabElt, a_tabMenuElt, a_contentElt, a_executeMethod )
	{
		//alert("a_tabElt=" + a_tabElt + ", a_contentElt=" + a_contentElt);
	    var index = this.m_tabPages.length;
		//var a_tabElt = document.getElementById("a_tabHeaderName");
		//var a_tabMenuElt = document.getElementById("a_tabHeaderMenuName");
		//alert("a_tabHeaderName=" + a_tabHeaderName + ", a_tabElt=" + a_tabElt);
		//alert("a_tabHeaderMenuName=" + a_tabHeaderMenuName + ", a_tabMenuElt=" + a_tabMenuElt);
	    var tabPage = new enview.portal.TabPage( this, index, a_tabElt, a_tabMenuElt, a_contentElt, a_executeMethod );
	    this.m_tabPages [ index ] = tabPage;
		
	    if (index==0)
	    {
	        this.m_activeTabPage = tabPage;
	    }

			//alert(this.m_tabPages.length);
	},

	dispose : function()
	{
		for (var i=0;i<this.m_tabPages.length;i++)
		{
			var tabPage = this.m_tabPages [ i ];
			tabPage.dispose ();
		}
		this.m_tabPaneElt = null;
		this.m_tabPages = null;
		this.m_activeTabPage = null;
	},

	/**
	 * "Paint" the TabPane object. This means that TD elements are added to the first
	 * table element with class="tab"
	 */
	showAll : function ()
	{
	    if (this.m_tabPaneElt==null)
	    {
	        return;
	    }
	    
	    if( this.m_activeTabPage != null )
	    		this.m_activeTabPage.deactivate();

	    this.m_activeTabPage = this.m_tabPages [ 0 ];

	    for (var i=0;i<this.m_tabPages.length;i++)
	    {
	        var tabPage = this.m_tabPages [ i ];
	        tabPage.m_tabElt.style.display = "block";
	    }

	    // Make the TabPane object visible
	    this.m_tabPaneElt.style.display = "block";
	//	this.m_tabPaneElt.style.visibility = "visible";
	    // Activate the active TabPage
	    this.m_activeTabPage.activate();
	},

	showFirst : function ()
	{
	    if (this.m_tabPaneElt==null)
	    {
	        return;
	    }
	    
	    if( this.m_activeTabPage != null )
	    		this.m_activeTabPage.deactivate();
	    
	    for (var i=1;i<this.m_tabPages.length;i++)
	    {
	        var tabPage = this.m_tabPages [ i ];
	        tabPage.m_tabElt.style.display = "none";
	    }
	    
	    this.m_activeTabPage = this.m_tabPages [ 0 ];
	    // Make the TabPane object visible
	    this.m_tabPaneElt.style.display = "block";
	//	this.m_tabPaneElt.style.visibility = "visible";
	    // Activate the active TabPage
	    this.m_activeTabPage.activate();
	},

	hide : function ()
	{
	    if (this.m_tabPaneElt==null)
	    {
	        return;
	    }
	    
	    for (var i=0;i<this.m_tabPages.length;i++)
	    {
	        var tabPage = this.m_tabPages [ i ];
	        tabPage.deactivate();
	    }

	    // Make the TabPane object visible
	    this.m_tabPaneElt.style.display = "none";
		//	this.m_tabPaneElt.style.visibility = "hidden";
	},

	/**
	 * Activate a certain TabPage
	 *
	 * a_index: index of the tab page to activate
	 */
	select : function ( a_index )
	{
		this.m_activeTabPage.deactivate ();
		this.m_activeTabPage = this.m_tabPages [ a_index ];
		//alert("index=" + a_index + ",activeTabPage=" + this.m_activeTabPage);
		this.m_activeTabPage.activate ();
		//alert(a_index);
	}
}

enview.portal.TabPage = function ( a_tabPane, a_index, a_tabElt, a_tabMenuElt, a_contentElt, a_executeMethod )
{
	this.m_tabPane = a_tabPane;
	this.m_index = a_index;

	this.m_tabElt = a_tabElt;
	this.m_tabMenuElt = a_tabMenuElt;
	this.m_ContentElt = a_contentElt;
	this.m_executeMethod = a_executeMethod;
	
	//alert("this.m_tabPane=" + this.m_tabPane +",this.m_index=" + this.m_index + ",this.m_tabElt=" + this.m_tabElt + ",this.m_ContentElt=" + this.m_ContentElt);
	
	if( this.m_ContentElt )
		this.m_ContentElt.style.display = "none";
	
	// Attach event handler to the new TD element
	var thisObj = this;
	//this.m_tabElt.onclick = this.select;
	this.m_tabElt.onclick = function () { thisObj.select (); };
	this.m_tabElt.onmouseover = function () { this.style.cursor = 'pointer'; };
}

enview.portal.TabPage.prototype =
{
	m_tabPane : null,
	m_index : null,
	m_tabElt : null,
	m_tabMenuElt : null,
	m_ContentElt : null,
	m_executeMethod : null,
	
	/**
	 * Clean-up resources (needed otherwise IE will consume more and more memory; FireFox does
	 * not have this problem)
	 */
	dispose : function()
	{
		this.m_index = null;
		this.m_tabElt = null;
		this.m_tabMenuElt = null;
		this.m_ContentElt = null;
	},

	/**
	 * Active this TabPage
	 */
	activate : function ()
	{
		//alert("this.m_tabPane=" + this.m_tabPane +",this.m_index=" + this.m_index + ",this.m_tabElt=" + this.m_tabElt + ",this.m_ContentElt=" + this.m_ContentElt);
		//alert("Activate : ID=" + this.m_tabElt.id + "," + this.m_ContentElt.id );

		//alert("this.m_tabElt.previousSibling=" + this.m_tabElt.previousSibling.innerHTML);
		var childrenCollection = this.m_tabElt.parentNode.childNodes;
		if( document.all ) {
			childrenCollection[0].className = "tabActiveLeft";
			childrenCollection[1].className = "tabActive";
			childrenCollection[2].className = "tabActiveRight";
		}
		else {
			childrenCollection[1].className = "tabActiveLeft";
			childrenCollection[3].className = "tabActive";
			childrenCollection[5].className = "tabActiveRight";
		}
		if( this.m_ContentElt )
			this.m_ContentElt.style.display = "block";
			
		//this.select();

		/*
		<a href="javascript:portalPage.showMyPageEditor('$site.getPage().getId()', false);">
			<img src="#GetPageResource('../../images/edit_mypage.gif')" border="0" align="absmiddle" title="$messages.getString('portal.mypage.edit')"/>
		</a>
		<a href="javascript:portalPage.removeMyPage('$userPageUrl');">
			<img src="#GetPageResource('../../images/remove_mypage.png')" border="0" align="absmiddle" title="$messages.getString('portal.mypage.remove')"/>
		</a>
		*/
		
		this.m_tabMenuElt.style.display = "";
	},

	/**
	 * Deactivate this TabPage
	 */
	deactivate : function ()
	{
		//alert("InActivate : ID=" + this.m_tabElt.id + "," + this.m_ContentElt.id);
		
		var childrenCollection = this.m_tabElt.parentNode.childNodes;
		if( document.all ) {
			childrenCollection[0].className = "tabInactiveLeft";
			childrenCollection[1].className = "tabInactive";
			childrenCollection[2].className = "tabInactiveRight";
		}
		else {
			childrenCollection[1].className = "tabInactiveLeft";
			childrenCollection[3].className = "tabInactive";
			childrenCollection[5].className = "tabInactiveRight";
		}
		
	    if( this.m_ContentElt )
			this.m_ContentElt.style.display = "none";
			
		this.m_tabMenuElt.style.display = "none";
	},
	
	/**
	 * Method called when the user clicks on the TabPage.
	 */
	select : function (a_event)
	{
		//var evt = a_event==null ? event : a_event;
	    // Tell the TabPane that this TabPage needs to be selected
		
		//alert("this.m_index=" + this.m_index + ", this.m_tabPane.m_index=" + this.m_tabPane.m_activeTabPage.m_index);
		if( this.m_index == this.m_tabPane.m_activeTabPage.m_index ) {
			if( this.m_tabPane.m_contextMenu.getDomElement().style.display == "none" ) {
				//if( portalPage != null ) {
				//	portalPage.hidePortalPageDialog();
				//}
				
				var pos = (new enview.util.Utility()).getAbsolutePosition( this.m_tabElt );
				//alert("pos=" + pos.m_x + "," + pos.m_y);
				//this.m_contextMenu.setDisable(4);
				//this.m_contextMenu.setEnable(4);
				//this.m_contextMenu.setItemId( id );
				this.m_tabPane.m_contextMenu.show( pos.getX()-12, pos.getY()+35 );
			}
			else {
				this.m_tabPane.m_contextMenu.hide();
			}
		}
		else {
		    this.m_tabPane.select ( this.m_index );
			if( this.m_executeMethod != null ) {
				this.m_executeMethod();
			}
		}
	}
}

enview.portal.TopMenu = function (a_parentElement, a_submenuarea, a_icon, a_title, a_href) 
{
	this.m_submenuArea = a_submenuarea;
	this.m_domElement = document.createElement("span");
	//this.m_domElement.style.width = "100%";
	this.m_domElement.ch = this;
	this.m_href = a_href;
	
	this.m_menuDomElement = document.createElement("span");
	
	if( a_title != null ) {
		//this.m_domElement.style.position = "absolute";
		this.m_domElement.style.zIndex = "1";
		//this.m_domElement.style.left = "0px";
		//this.m_domElement.style.top = "0px";
		//this.m_domElement.style.position = "relative";
		//this.m_domElement.style.width = "100%";
		this.m_domElement.onclick = this.onClickHandler;
		this.m_domElement.onmouseover = this.onMouseOver;
		this.m_domElement.onmouseout = this.onMouseOut;
		this.m_domElement.innerHTML = a_title;
		//this.m_domElement.innerHTML = "<a href='" + a_href + "'><img src='" + a_icon + "'  hspace='3' align='absmiddle'>&nbsp;&nbsp;" + a_title + "</a>";
		
		//this.m_domElement.setAttribute("class", "contextMenu");
		//this.m_domElement.setAttribute("className", "contextMenu");
		//this.m_domElement.style.display = "none";
		
		//alert("a_submenuarea=" + a_submenuarea);
		
		this.m_menuDomElement.setAttribute("class", "topsubmenu_bg");
		this.m_menuDomElement.setAttribute("className", "topsubmenu_bg");
		this.m_menuDomElement.style.position = "absolute";
		//this.m_menuDomElement.style.width = "100%";
		this.m_menuDomElement.style.height = a_submenuarea.offsetHeight;
		this.m_menuDomElement.onmouseover = this.onMouseOverSub;
		this.m_menuDomElement.onmouseout = this.onMouseOutSub;
		this.m_menuDomElement.style.display = "none";
	}
	else {
		this.m_menuDomElement.setAttribute("class", "topmenu_bg");
		this.m_menuDomElement.setAttribute("className", "topmenu_bg");
		this.m_menuDomElement.style.width = "100%";
		this.m_menuDomElement.style.display = "none";
	}
	
	a_parentElement.appendChild( this.m_domElement );
	this.m_domElement.appendChild( this.m_menuDomElement );
	
	this.m_children = new Array();
}
enview.portal.TopMenu.prototype =
{
	m_parent : null,
	m_submenuArea : null,
	m_menuDomElement : null,
	m_domElement : null,
	m_href : null,
	m_isOpen : false,
	m_children : null,
	m_cssOver : null,
	m_cssOut : null,

	setParent : function( parent )
	{
		this.m_parent = parent;
	},
	getParent : function()
	{
		return this.m_parent;
	},
	getMenuDomElement : function()
	{
		return this.m_menuDomElement;
	},
	getDomElement : function()
	{
		return this.m_domElement;
	},
	addMenu : function ( a_menuarea, a_cssOut, a_cssOver, a_icon, a_title, a_href )
	{
		var menu = new enview.portal.TopMenu(this.m_domElement, a_menuarea, a_icon, a_title, a_href);
		menu.m_cssOver = a_cssOver;
		menu.m_cssOut = a_cssOut;
		menu.m_domElement.setAttribute("class", a_cssOut);
		menu.m_domElement.setAttribute("className", a_cssOut);
		this.m_children.splice(this.m_children.length, 0, menu);
		menu.setParent( this );
		
		return menu;
	},
	addMenuItem : function ( a_cssOut, a_cssOver, a_icon, a_title, a_href, a_target )
	{
		var menuItem = new enview.portal.TopMenuItem(this, a_cssOut, a_cssOver, a_icon, a_title, a_href, a_target);
		this.m_children.splice(this.m_children.length, 0, menuItem);
		
	},
	addSeparator : function()
	{
		var element = document.createElement("hr");
		this.m_domElement.appendChild( element );
	},
	getIsOpen : function()
	{
		return this.m_isOpen;
	},
	getEnable : function()
	{
		return true;
	},
	setEnable : function(id)
	{
		this.m_children[ id ].setEnable();
	},
	setEnableByName : function(name)
	{
		for(var idx=0; idx< this.m_children.length; idx++){
			if(this.m_children[idx].getName() == name) {
				this.m_children[idx].setEnable();
				break;
			}
		}
	},
	setDisable : function(id)
	{
		this.m_children[ id ].setDisable();
	},
	setDisableByName : function(name)
	{
		for(var idx=0; idx< this.m_children.length; idx++){
			if(this.m_children[idx].getName() == name) {
				this.m_children[idx].setDisable();
				break;
			}
		}
	},
	showMenuItem : function()
	{
		this.m_isOpen = true;
		this.m_domElement.style.display = "";
		
		var pos = (new enview.util.Utility()).getAbsolutePosition( this.m_submenuArea );
		this.m_menuDomElement.style.left = pos.getX() + "px";
		this.m_menuDomElement.style.top = (pos.getY()-2) + "px";
		this.m_menuDomElement.style.display = "";
		//for(var idx=0; idx< this.m_children.length; idx++){
		//	this.m_children[idx].m_domElement.style.display = "";
		//}
	},
	hideMenuItem : function()
	{
		this.m_isOpen = false;
		//this.m_domElement.style.display = "none";
		this.m_menuDomElement.style.display = "none";
		//for(var idx=0; idx< this.m_children.length; idx++){
		//	this.m_children[idx].m_domElement.style.display = "none";
		//}
	},
	hideAllMenuItem : function()
	{
		//alert("this.m_children.length=" + this.m_children.length);
		for(var idx=0; idx< this.m_children.length; idx++){
			if( this.m_children[idx].hideMenuItem ) {
				this.m_children[idx].hideMenuItem();
			}
		}
	},
	onMouseOver : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		
		if( srcElem.ch != null ) {
			if( srcElem.ch.getEnable() == true ) {
				srcElem.setAttribute("class", srcElem.ch.m_cssOver);
				srcElem.setAttribute("className", srcElem.ch.m_cssOver);
				srcElem.ch.showMenuItem();
			}
		}
	},
	onMouseOut : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		if( srcElem.ch != null ) {
			if( srcElem.ch.getEnable() == true ) {
				srcElem.setAttribute("class", srcElem.ch.m_cssOut);
				srcElem.setAttribute("className", srcElem.ch.m_cssOut);
				srcElem.ch.hideMenuItem();
			}
		}
	},
	onMouseOverSub : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		if( srcElem.ch != null ) {
			var parent = srcElem.ch.getParent();
			parent.getDomElement().setAttribute("class", parent.m_cssOver);
			parent.getDomElement().setAttribute("className", parent.m_cssOver);
			parent.showMenuItem();
			srcElem.ch.cancelEvent( evt );
		}
	},
	onMouseOutSub : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		if( srcElem.ch != null ) {
			//alert("node=" + srcElem.nodeName);
			var parent = srcElem.ch.getParent();
			parent.getDomElement().setAttribute("class", parent.m_cssOut);
			parent.getDomElement().setAttribute("className", parent.m_cssOut);
			parent.hideMenuItem();
			srcElem.ch.cancelEvent( evt );
		}
	},
	onClickHandler : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		
		if( srcElem.ch != null ) {
			//alert("srcElem.ch=" + srcElem.ch + ", this.m_handler=" + srcElem.ch.getHandler() + ", this.m_enable=" + srcElem.ch.getEnable());
			if( srcElem.ch.getEnable() == true ) {
				location.href = srcElem.ch.m_href;
				//srcElem.ch.getParent().hideAllMenuItem();
				//srcElem.ch.showMenuItem();
			}
			/*
			if( srcElem.ch.getIsOpen() == false ) {
				if( srcElem.ch.getEnable() == true ) {
					location.href = srcElem.ch.m_href;
					//srcElem.ch.getParent().hideAllMenuItem();
					srcElem.ch.showMenuItem();
				}
			}
			else {
				srcElem.ch.hideMenuItem();
			}
			*/
		}
	}
}

enview.portal.TopMenuItem = function (a_parent, a_cssOut, a_cssOver, a_icon, a_title, a_href, a_target) 
{
	this.m_parent = a_parent;
	this.m_name = a_title;
	this.m_href = a_href;
	this.m_target = a_target;
	this.m_domElement = document.createElement("span");
	this.m_domElement.ch = this;
	this.m_domElement.width = "100%";
	this.m_domElement.onclick = this.onClickHandler;
	this.m_domElement.onmouseover = this.onMouseOver;
	this.m_domElement.onmouseout = this.onMouseOut;
	this.m_domElement.setAttribute("class", a_cssOut);
	this.m_domElement.setAttribute("className", a_cssOut);
	if( a_target ) {
		this.m_domElement.innerHTML = a_title;
		//this.m_domElement.innerHTML = "<a href='" + a_href + "'><img src='" + a_icon + "' hspace='3' align='absmiddle'>&nbsp;&nbsp;" + a_title + "</a>";
	}
	else {
		this.m_domElement.innerHTML = a_title;
		//this.m_domElement.innerHTML = "<a href='" + a_href + "' target='" + a_target + "'><img src='" + a_icon + "' hspace='3' align='absmiddle'>&nbsp;&nbsp;" + a_title + "</a>";
	}
	
	this.m_cssOut = a_cssOut;
	this.m_cssOver = a_cssOver;
	
	//this.m_domElement.style.display = "none";
	
	this.m_parent.getMenuDomElement().appendChild( this.m_domElement );
}
enview.portal.TopMenuItem.prototype =
{
	m_parent : null,
	m_name : null,
	m_href : null,
	m_target : null,
	m_domElement : null,
	m_enable : true,
	m_cssOver : null,
	m_cssOut : null,

	getParent : function()
	{
		return this.m_parent;
	},
	getName : function()
	{
		return this.m_name;
	},
	getDomElement : function()
	{
		return this.m_domElement;
	},
	getEnable : function()
	{
		return this.m_enable;
	},
	setEnable : function()
	{
		this.m_enable = true;
		this.m_domElement.setAttribute("class", "leftmenu_item3");
		this.m_domElement.setAttribute("className", "leftmenu_item3");
	},
	setDisable : function()
	{
		this.m_enable = false;
	},
	onMouseOver : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		
		if( srcElem.ch != null ) {
			if( srcElem.ch.getEnable() == true ) {
				srcElem.setAttribute("class", srcElem.ch.m_cssOver);
				srcElem.setAttribute("className", srcElem.ch.m_cssOver);
				//srcElem.ch.cancelEvent( a_event );
			}
		}
	},
	onMouseOut : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		if( srcElem.ch != null ) {
			if( srcElem.ch.getEnable() == true ) {
				srcElem.setAttribute("class", srcElem.ch.m_cssOut);
				srcElem.setAttribute("className", srcElem.ch.m_cssOut);
				//srcElem.ch.cancelEvent( a_event );
			}
		}
	},
	onClickHandler : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		if( srcElem.ch != null ) {
			if( srcElem.ch.getEnable() == true ) {
				location.href = srcElem.ch.m_href;
				srcElem.ch.cancelEvent( evt );
			}
		}
	},
	cancelEvent : function (a_event) {
		//alert("a_event=" + a_event);
		//if (a_event.preventDefault) {
		if (document.all) {	// it is IE
			//alet("a_event=" + a_event + ", a_event.cancelBubble=" + a_event.cancelBubble + ", a_event.returnValue=" + a_event.returnValue);
			a_event.cancelBubble = true;
			a_event.returnValue = false;
		} else {
			a_event.preventDefault ();
			a_event.stopPropagation ();
		}
	}
}

enview.portal.LeftMenu = function (a_parentElement, a_icon, a_title, a_href) 
{
	this.m_menuDomElement = a_parentElement;
	this.m_href = a_href;
	
	if( a_title != null ) {
		this.m_domElement = document.createElement("div");
		this.m_domElement.style.width = "100%";
		this.m_domElement.ch = this;
		//this.m_domElement.style.position = "absolute";
		this.m_domElement.style.zIndex = "1";
		//this.m_domElement.style.left = "0px";
		//this.m_domElement.style.top = "0px";
		//this.m_domElement.style.position = "relative";
		this.m_domElement.style.width = "100%";
		this.m_domElement.onclick = this.onClickHandler;
		this.m_domElement.onmouseover = this.onMouseOver;
		this.m_domElement.onmouseout = this.onMouseOut;
		this.m_domElement.innerHTML = "<img src='" + a_icon + "'  hspace='3' align='absmiddle'>&nbsp;&nbsp;" + a_title;
		//this.m_domElement.innerHTML = "<a href='" + a_href + "'><img src='" + a_icon + "'  hspace='3' align='absmiddle'>&nbsp;&nbsp;" + a_title + "</a>";
		
		//this.m_domElement.setAttribute("class", "contextMenu");
		//this.m_domElement.setAttribute("className", "contextMenu");
		//this.m_domElement.style.display = "none";
		this.m_menuDomElement.appendChild( this.m_domElement );
	
	}
	
	this.m_children = new Array();
}
enview.portal.LeftMenu.prototype =
{
	m_parent : null,
	m_menuDomElement : null,
	m_domElement : null,
	m_href : null,
	m_isOpen : true,
	m_children : null,
	m_cssOver : null,
	m_cssOut : null,

	setParent : function( parent )
	{
		this.m_parent = parent;
	},
	getParent : function()
	{
		return this.m_parent;
	},
	getMenuDomElement : function()
	{
		return this.m_menuDomElement;
	},
	getDomElement : function()
	{
		return this.m_domElement;
	},
	addMenu : function ( a_cssOut, a_cssOver, a_icon, a_title, a_href )
	{
		var menu = new enview.portal.LeftMenu(this.m_menuDomElement, a_icon, a_title, a_href);
		menu.m_cssOver = a_cssOver;
		menu.m_cssOut = a_cssOut;
		menu.m_domElement.setAttribute("class", a_cssOut);
		menu.m_domElement.setAttribute("className", a_cssOut);
		this.m_children.splice(this.m_children.length, 0, menu);
		menu.setParent( this );
		
		return menu;
	},
	addMenuItem : function ( a_cssOut, a_cssOver, a_icon, a_title, a_href, a_target )
	{
		var menuItem = new enview.portal.LeftMenuItem(this, a_cssOut, a_cssOver, a_icon, a_title, a_href, a_target);
		this.m_children.splice(this.m_children.length, 0, menuItem);
		
	},
	addSeparator : function()
	{
		var element = document.createElement("hr");
		this.m_domElement.appendChild( element );
	},
	getIsOpen : function()
	{
		return this.m_isOpen;
	},
	getEnable : function()
	{
		return true;
	},
	setEnable : function(id)
	{
		this.m_children[ id ].setEnable();
	},
	setEnableByName : function(name)
	{
		for(var idx=0; idx< this.m_children.length; idx++){
			if(this.m_children[idx].getName() == name) {
				this.m_children[idx].setEnable();
				break;
			}
		}
	},
	setDisable : function(id)
	{
		this.m_children[ id ].setDisable();
	},
	setDisableByName : function(name)
	{
		for(var idx=0; idx< this.m_children.length; idx++){
			if(this.m_children[idx].getName() == name) {
				this.m_children[idx].setDisable();
				break;
			}
		}
	},
	showMenuItem : function()
	{
		this.m_isOpen = true;
		this.m_domElement.style.display = "";
		for(var idx=0; idx< this.m_children.length; idx++){
			this.m_children[idx].m_domElement.style.display = "";
		}
	},
	hideMenuItem : function()
	{
		this.m_isOpen = false;
		//this.m_domElement.style.display = "none";
		for(var idx=0; idx< this.m_children.length; idx++){
			this.m_children[idx].m_domElement.style.display = "none";
		}
	},
	hideAllMenuItem : function()
	{
		//alert("this.m_children.length=" + this.m_children.length);
		for(var idx=0; idx< this.m_children.length; idx++){
			if( this.m_children[idx].hideMenuItem ) {
				this.m_children[idx].hideMenuItem();
			}
		}
	},
	onMouseOver : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		
		if( srcElem.ch != null ) {
			if( srcElem.ch.getEnable() == true ) {
				srcElem.setAttribute("class", srcElem.ch.m_cssOver);
				srcElem.setAttribute("className", srcElem.ch.m_cssOver);
			}
		}
	},
	onMouseOut : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		if( srcElem.ch != null ) {
			if( srcElem.ch.getEnable() == true ) {
				srcElem.setAttribute("class", srcElem.ch.m_cssOut);
				srcElem.setAttribute("className", srcElem.ch.m_cssOut);
			}
		}
	},
	onClickHandler : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		
		if( srcElem.ch != null ) {
			//alert("srcElem.ch=" + srcElem.ch + ", this.m_handler=" + srcElem.ch.getHandler() + ", this.m_enable=" + srcElem.ch.getEnable());
			if( srcElem.ch.getIsOpen() == false ) {
				if( srcElem.ch.getEnable() == true ) {
					//location.href = srcElem.ch.m_href;
					//srcElem.ch.getParent().hideAllMenuItem();
					srcElem.ch.showMenuItem();
				}
			}
			else {
				srcElem.ch.hideMenuItem();
			}
		}
	}
}

enview.portal.LeftMenuItem = function (a_parent, a_cssOut, a_cssOver, a_icon, a_title, a_href, a_target) 
{
	this.m_parent = a_parent;
	this.m_name = a_title;
	this.m_href = a_href;
	this.m_target = a_target;
	this.m_domElement = document.createElement("div");
	this.m_domElement.ch = this;
	this.m_domElement.width = "100%";
	this.m_domElement.onclick = this.onClickHandler;
	this.m_domElement.onmouseover = this.onMouseOver;
	this.m_domElement.onmouseout = this.onMouseOut;
	this.m_domElement.setAttribute("class", a_cssOut);
	this.m_domElement.setAttribute("className", a_cssOut);
	if( a_target ) {
		this.m_domElement.innerHTML = "<img src='" + a_icon + "' hspace='3' align='absmiddle'>&nbsp;&nbsp;" + a_title;
		//this.m_domElement.innerHTML = "<a href='" + a_href + "'><img src='" + a_icon + "' hspace='3' align='absmiddle'>&nbsp;&nbsp;" + a_title + "</a>";
	}
	else {
		this.m_domElement.innerHTML = "<img src='" + a_icon + "' hspace='3' align='absmiddle'>&nbsp;&nbsp;" + a_title;
		//this.m_domElement.innerHTML = "<a href='" + a_href + "' target='" + a_target + "'><img src='" + a_icon + "' hspace='3' align='absmiddle'>&nbsp;&nbsp;" + a_title + "</a>";
	}
	
	this.m_cssOut = a_cssOut;
	this.m_cssOver = a_cssOver;
	
	//this.m_domElement.style.display = "none";
	
	this.m_parent.getMenuDomElement().appendChild( this.m_domElement );
}
enview.portal.LeftMenuItem.prototype =
{
	m_parent : null,
	m_name : null,
	m_href : null,
	m_target : null,
	m_domElement : null,
	m_enable : true,
	m_cssOver : null,
	m_cssOut : null,

	getParent : function()
	{
		return this.m_parent;
	},
	getName : function()
	{
		return this.m_name;
	},
	getDomElement : function()
	{
		return this.m_domElement;
	},
	getEnable : function()
	{
		return this.m_enable;
	},
	setEnable : function()
	{
		this.m_enable = true;
		this.m_domElement.setAttribute("class", "leftmenu_item3");
		this.m_domElement.setAttribute("className", "leftmenu_item3");
	},
	setDisable : function()
	{
		this.m_enable = false;
	},
	onMouseOver : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		
		if( srcElem.ch != null ) {
			if( srcElem.ch.getEnable() == true ) {
				srcElem.setAttribute("class", srcElem.ch.m_cssOver);
				srcElem.setAttribute("className", srcElem.ch.m_cssOver);
				srcElem.ch.cancelEvent( evt );
			}
		}
	},
	onMouseOut : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		if( srcElem.ch != null ) {
			if( srcElem.ch.getEnable() == true ) {
				srcElem.setAttribute("class", srcElem.ch.m_cssOut);
				srcElem.setAttribute("className", srcElem.ch.m_cssOut);
				srcElem.ch.cancelEvent( evt );
			}
		}
	},
	onClickHandler : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		if( srcElem.ch != null ) {
			if( srcElem.ch.getEnable() == true ) {
				location.href = srcElem.ch.m_href;
			}
		}
	},
	cancelEvent : function (a_event) {
		if (document.all) {	// it is IE
			a_event.cancelBubble = true;
			a_event.returnValue = false;
		} else {
			a_event.preventDefault ();
			a_event.stopPropagation ();
		}
	}
}

enview.portal.ContextMenu = function (id, title) 
{
	this.m_id = id;
	this.m_domElement = document.getElementById("Enview.Portal.ContextMenu"); //document.createElement("div");
	this.m_domElement.id = "__ContextMenu" + this.m_id;
	this.m_domElement.ch = this;
	this.m_domElement.onmouseover = this.onMouseOver;
	this.m_domElement.onmouseout = this.onMouseOut;
	
	this.m_domElement.style.position = "absolute";
	this.m_domElement.style.zIndex = "998";
	this.m_domElement.style.left = "0px";
	this.m_domElement.style.top = "0px";
	this.m_domElement.style.width = "200px";
	this.m_domElement.style.border = "1px solid";
	this.m_domElement.style.backgroundColor = "#ffffff";
	this.m_domElement.style.fontFamily = "arial"; 
	this.m_domElement.style.fontWeight = "bold";
	this.m_domElement.style.fontSize = "8pt";
	this.m_domElement.style.padding = "4px 2px 4px 2px";
	this.m_domElement.style.margin = "0 1 0 1";
	
	//this.m_domElement.setAttribute("class", "contextMenu");
	//this.m_domElement.setAttribute("className", "contextMenu");
	this.m_domElement.style.display = "none";
	
	if( title != null ) {
		var t = document.createElement("div");
		t.setAttribute("class", "contextMenu_title");
		t.setAttribute("className", "contextMenu_title");
		t.ch = this;
		t.onclick = this.onHide;
		t.innerHTML = title;
		this.m_domElement.appendChild( t );
		var element = document.createElement("hr");
		element.ch = this;
		element.onmouseover = this.onMouseOver;
		this.m_domElement.appendChild( element );
	}
	
	this.m_children = new Array();
}
enview.portal.ContextMenu.prototype =
{
	m_id : null,
	m_itemId : "0",
	m_domElement : null,
	m_imagePath : "",
	m_children : null,

	getDomElement : function()
	{
		return this.m_domElement;
	},
	getImagePath : function()
	{
		return this.m_imagePath;
	},
	setImagePath : function( path )
	{
		//alert(this.m_imagePath);
		this.m_imagePath = path;
	},
	setItemId : function( id )
	{
		this.m_itemId = id;
	},
	getItemId : function()
	{
		return this.m_itemId;
	},
	addMenu : function ( a_menu, a_icon, a_title, a_handler )
	{
	
	},
	addMenuItem : function ( a_title, a_icon, a_handler )
	{
		var menuItem = new enview.portal.ContextMenuItem(this, a_title, a_icon, a_handler);
		this.m_children.splice(this.m_children.length, 0, menuItem);
		this.m_domElement.appendChild( menuItem.getDomElement() );
	},
	addSeparator : function()
	{
		var element = document.createElement("hr");
		element.ch = this;
		element.onmouseover = this.onMouseOver;
		//element.setAttribute("class", "contextMenu_separator");
		//element.setAttribute("className", "contextMenu_separator");
		this.m_domElement.appendChild( element );
	},
	setEnable : function(id)
	{
		this.m_children[ id ].setEnable();
	},
	setEnableByName : function(name)
	{
		for(var idx=0; idx< this.m_children.length; idx++){
			if(this.m_children[idx].getName() == name) {
				this.m_children[idx].setEnable();
				break;
			}
		}
	},
	setDisable : function(id)
	{
		this.m_children[ id ].setDisable();
	},
	setDisableByName : function(name)
	{
		for(var idx=0; idx< this.m_children.length; idx++){
			if(this.m_children[idx].getName() == name) {
				this.m_children[idx].setDisable();
				break;
			}
		}
	},
	show : function(x, y)
	{
		//if( document.getElementById("__ContextMenu" + this.m_id) == null ) {
			//document.body.appendChild( this.m_domElement );
		//}
		
		this.m_domElement.style.left = x + "px";
		this.m_domElement.style.top = y + "px";
		this.m_domElement.style.display = "";
	},
	hide : function()
	{
		this.m_domElement.style.display = "none";
	},
	onHide : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		
		if( srcElem.ch != null ) {
			//alert("srcElem.ch=" + srcElem.ch + ", id=" + srcElem.ch.getItemId());
			srcElem.ch.hide();
		}
	},
	onMouseOver : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		
		if( srcElem.ch != null ) {
			//alert("Parent");
			if( srcElem.ch.getParent ) {
				//alert("Parent");
				srcElem.ch.getParent().m_domElement.style.display = "";
			}
			else {
				srcElem.ch.m_domElement.style.display = "";
			}
		}
	},
	onMouseOut : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		
		if( srcElem.ch != null ) {
			srcElem.ch.m_domElement.style.display = "none";
		}
	}
}

enview.portal.ContextMenuItem = function (a_parent, a_title, a_icon, a_handler) 
{
	this.m_parent = a_parent;
	this.m_name = a_title;
	this.m_handler = a_handler;
	this.m_domElement = document.createElement("div");
	this.m_domElement.ch = this;
	this.m_domElement.onclick = this.onHandler;
	this.m_domElement.onmouseover = this.onMouseOver;
	this.m_domElement.onmouseout = this.onMouseOut;
	this.m_domElement.setAttribute("class", "contextMenu_item");
	this.m_domElement.setAttribute("className", "contextMenu_item");
	
	//alert("ContextMenuItem=" + this.m_parent.getImagePath());
	if( this.m_parent.getImagePath().lastIndexOf("/") > -1 ) {
		this.m_domElement.innerHTML = "<img src='" + this.m_parent.getImagePath() + a_icon + "' align='absmiddle'>&nbsp;&nbsp;" + a_title;
	}
	else {
		this.m_domElement.innerHTML = "<img src='" + this.m_parent.getImagePath() + "/" + a_icon + "' align='absmiddle'>&nbsp;&nbsp;" + a_title;
	}
}
enview.portal.ContextMenuItem.prototype =
{
	m_parent : null,
	m_name : null,
	m_domElement : null,
	m_handler : null,
	m_enable : true,

	getParent : function()
	{
		return this.m_parent;
	},
	getName : function()
	{
		return this.m_name;
	},
	getDomElement : function()
	{
		return this.m_domElement;
	},
	getHandler : function()
	{
		return this.m_handler;
	},
	getEnable : function()
	{
		return this.m_enable;
	},
	setEnable : function()
	{
		this.m_enable = true;
		this.m_domElement.setAttribute("class", "contextMenu_item");
		this.m_domElement.setAttribute("className", "contextMenu_item");
	},
	setDisable : function()
	{
		this.m_enable = false;
		this.m_domElement.setAttribute("class", "contextMenu_itemDisable");
		this.m_domElement.setAttribute("className", "contextMenu_itemDisable");
	},
	onMouseOver : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		
		if( srcElem.ch != null ) {
			if( srcElem.ch.getEnable() == true ) {
				srcElem.setAttribute("class", "contextMenu_itemOver");
				srcElem.setAttribute("className", "contextMenu_itemOver");
			}
			else {
				srcElem.setAttribute("class", "contextMenu_itemOverDisable");
				srcElem.setAttribute("className", "contextMenu_itemOverDisable");
			}
			
			//srcElem.ch.cancelEvent( evt );
		}	
	},
	onMouseOut : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		if( srcElem.ch != null ) {
			if( srcElem.ch.getEnable() == true ) {
				srcElem.setAttribute("class", "contextMenu_item");
				srcElem.setAttribute("className", "contextMenu_item");
			}
			else {
				srcElem.setAttribute("class", "contextMenu_itemDisable");
				srcElem.setAttribute("className", "contextMenu_itemDisable");
			}
			
			srcElem.ch.cancelEvent( evt );
		}
	},
	onHandler : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		
		if( srcElem.ch != null ) {
			//alert("srcElem.ch=" + srcElem.ch + ", this.m_handler=" + srcElem.ch.getHandler() + ", this.m_enable=" + srcElem.ch.getEnable());
			if( srcElem.ch.getEnable() == true ) {
				srcElem.ch.getParent().hide();
				srcElem.ch.getHandler()( srcElem.ch.getParent().getItemId() );
			}
		}
	},
	cancelEvent : function (a_event) {
		if (document.all) {	// it is IE
			a_event.cancelBubble = true;
			a_event.returnValue = false;
		} else {
			a_event.preventDefault ();
			a_event.stopPropagation ();
		}
	}
}
