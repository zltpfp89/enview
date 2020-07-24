dhtmlXTreeContextMenu = function (id, title) 
{
	this.m_id = id;
	this.m_domElement = document.createElement("div");
	this.m_domElement.id = "__ContextMenu" + this.m_id;
	this.m_domElement.ch = this;
	this.m_domElement.onmouseover = this.onMouseOver;
	this.m_domElement.onmouseout = this.onMouseOut;
	this.m_domElement.onmouseup = this.onMouseUp;
	//document.onmouseup = this.onMouseUp;
	//this.m_domElement.style.position = "absolute";
	//this.m_domElement.style.zIndex = "998";
	//this.m_domElement.style.left = "0px";
	//this.m_domElement.style.top = "0px";
	//this.m_domElement.style.position = "relative";
	//this.m_domElement.style.width = "100px";
	//this.m_domElement.onclick = this.onHide;
	
	this.m_domElement.setAttribute("class", "contextMenu");
	this.m_domElement.setAttribute("className", "contextMenu");
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
dhtmlXTreeContextMenu.prototype =
{
	m_id : null,
	m_itemId : "0",
	m_domElement : null,
	m_imagePath : "",
	m_children : null,

	getImagePath : function()
	{
		return this.m_imagePath;
	},
	setImagePath : function( path )
	{
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
		var menuItem = new dhtmlXTreeContextMenuItem(this, a_title, a_icon, a_handler);
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
		if( document.getElementById("__ContextMenu" + this.m_id) == null ) {
			document.body.appendChild( this.m_domElement );
		}
		
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
		/*
		if( srcElem.ch != null ) {
			if( srcElem.ch.getEnable() == true ) {
				srcElem.setAttribute("class", "contextMenu_itemOver");
				srcElem.setAttribute("className", "contextMenu_itemOver");
			}
			else {
				srcElem.setAttribute("class", "contextMenu_itemOverDisable");
				srcElem.setAttribute("className", "contextMenu_itemOverDisable");
			}
		}
		*/
	},
	onMouseOut : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		
		if( srcElem.ch != null ) {
			//srcElem.ch.m_domElement.style.display = "none";
		}
		/*
		if( srcElem.ch != null ) {
			if( srcElem.ch.getEnable() == true ) {
				srcElem.setAttribute("class", "contextMenu_item");
				srcElem.setAttribute("className", "contextMenu_item");
			}
			else {
				srcElem.setAttribute("class", "contextMenu_itemDisable");
				srcElem.setAttribute("className", "contextMenu_itemDisable");
			}
		}
		*/
	},
	onMouseUp : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		
		if( srcElem.ch != null ) {
			srcElem.ch.m_domElement.style.display = "none";
		}
	}
}

dhtmlXTreeContextMenuItem = function (a_parent, a_title, a_icon, a_handler) 
{
	this.m_parent = a_parent;
	this.m_name = a_title;
	this.m_handler = a_handler;
	this.m_domElement = document.createElement("div");
	this.m_domElement.ch = this;
	this.m_domElement.onclick = this.onHandler;
	this.m_domElement.onmouseover = this.onMouseOver;
	this.m_domElement.onmouseout = this.onMouseOut;
	this.m_domElement.onmouseup = this.onMouseUp;
	this.m_domElement.setAttribute("class", "contextMenu_item");
	this.m_domElement.setAttribute("className", "contextMenu_item");
	
	if( this.m_parent.getImagePath().lastIndexOf("/") > -1 ) {
		this.m_domElement.innerHTML = "<img src='" + this.m_parent.getImagePath() + a_icon + "' align='absmiddle'>&nbsp;&nbsp;" + a_title;
	}
	else {
		this.m_domElement.innerHTML = "<img src='" + this.m_parent.getImagePath() + "/" + a_icon + "' align='absmiddle'>&nbsp;&nbsp;" + a_title;
	}
}
dhtmlXTreeContextMenuItem.prototype =
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
	onMouseUp : function(a_event)
	{
		var evt = a_event==null ? event : a_event;
		var srcElem = evt.srcElement ? evt.srcElement : evt.target;
		if( srcElem.ch != null ) {
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
