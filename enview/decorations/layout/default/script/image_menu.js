/*
* �� �޴� �����ۿ� ���콺 over/off �̺�Ʈ�� ����Ѵ�.
* �Ķ���ͷ� ����� ID�� ���� �������� ������ �°� �� depth���� ������ID�� �ѱ��.
*/
function initNavigation(userId, menuIds) {
	isMenuNavigationMouseOver = false;
	var menuIdArray = menuIds.split(",");

	var topMenu = document.getElementById("topmenu");
	// Top�޴� �����ۿ� ���콺 out �̺�Ʈ�� �߻� �ϸ� ������ ���� �־��� �޴����� ���߰� 
	// ���� �������� active�� �޴� �����ۿ� ���콺 over�̺�Ʈ�� �߻� ���Ѽ� �׻� active�� �޴��� ���� �� �� �ֵ��� �Ѵ�.
	initTopAnchorEvent( topMenu, menuIdArray, "_on.gif", "_off.gif" );
	// Top�޴� �����ۿ� ���콺 over �̺�Ʈ�� �߻� ������ ���Ǹ� �Ͽ��ش�.
	initTopNavigationDetail(userId, topMenu, menuIdArray, 0, "_on.gif", "_off.gif", "_on.gif", false, true, true, true);

	
	var subMenu = document.getElementById("submenu");
	initLeftAnchorEvent( subMenu, menuIdArray, "_on.gif", "_off.gif" );
	initLeftNavigationDetail(subMenu, subMenu, menuIdArray, 1, "_on.gif", "_off.gif", "_done.gif", true, false, true, true);
	
}

function initTopAnchorEvent(nav, menuIdArray, onChar, offChar) {
	var allA = nav.getElementsByTagName("a")
	for(var k = 0; k < allA.length; k++) {
		// ��� �޴� �������� ���콺 out�̺�Ʈ�� ���ؼ� ���Ǹ� �Ѵ�.
		allA.item(k).onmouseout = allA.item(k).onblur = function () {
			
			if( nav.prevMenuItem  ) {
				var menuImg = nav.prevMenuItem.childNodes.item(0);
				menuImg.src = nav.prevMenuImg;
				if (nav.prevMenuItem.submenu && nav.prevMenuIsSubHidden)
					nav.prevMenuItem.submenu.style.display = "none";
				nav.prevMenuItem = null;
			}
			
			isMenuNavigationMouseOver = false;
			// ���� �޴������ۿ� ���콺�� over�Ǿ� �ִ��� �ľ��ϰ� over �ȵǾ� �ִ� ��쿡
			// ���� �������� �޴� ������ �°� active�� �޴� �����۵鿡 ���콺 over �̺�Ʈ�� �߻� ��Ų��.
			setTimeout(function () {
				if( isMenuNavigationMouseOver == false ) {
					for(var j=0; j<menuIdArray.length; j++) {
						if (nav.menuAnchorMap.containsKey("menu_" + menuIdArray[j])) {
							nav.menuAnchorMap.get("menu_" + menuIdArray[j]).onmouseover();
						}
					}
				}
			}, 200);
		}
	}
}

function initLeftAnchorEvent(nav, menuIdArray, onChar, offChar) {
	var allA = nav.getElementsByTagName("a")
	for(var k = 0; k < allA.length; k++) {
		// ��� �޴� �������� ���콺 out�̺�Ʈ�� ���ؼ� ���Ǹ� �Ѵ�.
		allA.item(k).onmouseout = allA.item(k).onblur = function () {
			
			if( nav.prevMenuItem  ) {
				var menuImg = nav.prevMenuItem.childNodes.item(0);
				menuImg.src = nav.prevMenuImg;
				if (nav.prevMenuItem.submenu && nav.prevMenuIsSubHidden)
					nav.prevMenuItem.submenu.style.display = "none";
				nav.prevMenuItem = null;
			}
			
			isMenuNavigationMouseOver = false;
			// ���� �޴������ۿ� ���콺�� over�Ǿ� �ִ��� �ľ��ϰ� over �ȵǾ� �ִ� ��쿡
			// ���� �������� �޴� ������ �°� active�� �޴� �����۵鿡 ���콺 over �̺�Ʈ�� �߻� ��Ų��.
			setTimeout(function () {
				if( isMenuNavigationMouseOver == false ) {
					for(var j=0; j<menuIdArray.length; j++) {
						if (nav.menuAnchorMap.containsKey("submenu_" + menuIdArray[j])) {
							nav.menuAnchorMap.get("submenu_" + menuIdArray[j]).onmouseover();
						}
					}
				}
			}, 200);
		}
	}
}

/*
* Top�޴� �����ۿ� ���콺 over �̺�Ʈ�� �߻� ������ ���Ǹ� �Ͽ��ش�.
* isActiveDisplay : ���� Active�� ���¸� �������� ����
* isSubHidden : ���� �޴����� �������� ����
* isSubNavigation : ���� �޴��鿡 ���ؼ� �̺�Ʈ�� �ο��� �� ����
* isSubEnableEvent : ���� �޴��鿡 ���ؼ� �̺�Ʈ�� �ο��� �� ����
*/
function initTopNavigationDetail(userId, nav, menuIdArray, depth, onChar, offChar, activeChar, isActiveDisplay, isSubHidden, isSubNavigation, isSubEnableEvent) {
	if( !nav ) return;
	
	nav.menu = new Array();
	//nav.menuImageMap = new Map();
	//nav.menuAnchorMap = new Map();
	nav.menuImageMap = new Map();
	nav.menuAnchorMap = new Map();
	nav.current = null;
	nav.menuseq = 0;
	var navLen = nav.childNodes.length;
	var menuId = "menu_" + menuIdArray[depth];
	
	for (var i = 0; i < navLen; i++) {
		var navItem = nav.childNodes.item(i);
		
		if (navItem.tagName != "LI")
			continue;

		var navAnchor = navItem.getElementsByTagName("a").item(0);
		var navImage = navItem.getElementsByTagName("img").item(0);
		// ���� anchor�±׿� img�±׸� root div��ҿ� �����Ѵ�.
		// �̰��� ���콺 out�̺�Ʈ�� �߻� ���� �� ���ȴ�.
		nav.menuAnchorMap.put(navItem.id, navAnchor);
		nav.menuImageMap.put(navItem.id, navImage);
		
		// �޴� ������ ���� �� ���� �޴��� �����ְ��� �� ��쿡 ������ �Լ��� �ݺ��Ѵ�.
		if( isSubNavigation ) {
			navAnchor.submenu = navItem.getElementsByTagName("ul").item(0);
			initTopNavigationDetail( userId, navAnchor.submenu, menuIdArray, depth+1, onChar, offChar, activeChar, true, false, false, true );
		}
		
		navAnchor.onmouseover = navAnchor.onfocus = function () {
			if( isSubEnableEvent == true ) {
				if (nav.current) {
					var menuImg = nav.current.childNodes.item(0);
					menuImg.src = menuImg.src.replace(onChar, offChar);
					if (nav.current.submenu && isSubHidden)
						nav.current.submenu.style.display = "none";
					nav.current = null;
				}
				if (nav.current != this) {
					var menuImg = this.childNodes.item(0);
					menuImg.src = menuImg.src.replace(offChar, onChar);
					if (this.submenu && isSubHidden) {
						this.submenu.style.display = "block";
						this.submenu.style.width = "680px";
						if( this.parentNode.className == "menu0" ) this.submenu.style.left = "0px";
						else if( this.parentNode.className == "menu1" ) this.submenu.style.left = "0px";
						else if( this.parentNode.className == "menu2" ) this.submenu.style.left = "0px";
						else if( this.parentNode.className == "menu3" ) this.submenu.style.left = "0px";
						else if( this.parentNode.className == "menu4" ) this.submenu.style.left = "180px";
						else if( userId == "guest" ) {
							this.submenu.style.left = "180px";
							this.submenu.style.width = "360px";
							//this.submenu.style.backgroundImage = "url(../images/NaviBG.gif);";
						}
						else this.submenu.style.left = "0px";
					}
					nav.current = this;
				}
				isMenuNavigationMouseOver = true;
			}
		}
	}
	if( menuId ) {
		if (nav.menuAnchorMap.containsKey(menuId)) 
			nav.menuAnchorMap.get(menuId).onmouseover();
			
		if (isActiveDisplay && nav.menuImageMap.containsKey(menuId)) {
			var menuImg = nav.menuImageMap.get(menuId);
			menuImg.src = menuImg.src.replace(onChar, activeChar);
		}
	}
}

/*
* Left�޴� �����ۿ� ���콺 over �̺�Ʈ�� �߻� ������ ���Ǹ� �Ͽ��ش�.
* isActiveDisplay : ���� Active�� ���¸� �������� ����
* isSubHidden : ���� �޴����� �������� ����
* isSubNavigation : ���� �޴��鿡 ���ؼ� �̺�Ʈ�� �ο��� �� ����
* isSubEnableEvent : ���� �޴��鿡 ���ؼ� �̺�Ʈ�� �ο��� �� ����
*/
function initLeftNavigationDetail(root, nav, menuIdArray, depth, onChar, offChar, activeChar, isActiveDisplay, isSubHidden, isSubNavigation, isSubEnableEvent) {
	if( !nav ) return;
	
	nav.menu = new Array();
	nav.menuImageMap = new Map();
	nav.menuAnchorMap = new Map();
	nav.current = null;
	nav.menuseq = 0;
	var navLen = nav.childNodes.length;
	var menuId = "submenu_" + menuIdArray[depth];
	
	for (var i = 0; i < navLen; i++) {
		var navItem = nav.childNodes.item(i);
		
		if (navItem.tagName != "LI")
			continue;

		var navAnchor = navItem.getElementsByTagName("a").item(0);
		var navImage = navItem.getElementsByTagName("img").item(0);
		nav.menuAnchorMap.put(navItem.id, navAnchor);
		nav.menuImageMap.put(navItem.id, navImage);
		//alert("navItem.id=" + navItem.id);
		
		if( isSubNavigation ) {
			navAnchor.submenu = navItem.getElementsByTagName("ul").item(0);
			initLeftNavigationDetail( root, navAnchor.submenu, menuIdArray, depth+1, "_on.gif", "_off.gif", "_done.gif", true, false, false, true );
		}
		
		navAnchor.onmouseover = navAnchor.onfocus = function () {
			if( isSubEnableEvent == true ) {
				if (nav.current) {
					//var menuImg = nav.current.childNodes.item(0);
					//menuImg.src = menuImg.src.replace(onChar, offChar);
					//if (nav.current.submenu && isSubHidden)
					//	nav.current.submenu.style.display = "none";
					nav.current = null;
				}
				if (nav.current != this) {
					var menuImg = this.childNodes.item(0);
					root.prevMenuItem = this;
					root.prevMenuImg = menuImg.src;
					root.prevMenuIsSubHidden = isSubHidden;
					menuImg.src = menuImg.src.replace(offChar, onChar);
					if (this.submenu && isSubHidden)
						this.submenu.style.display = "block";
					nav.current = this;
				}
				//alert("onmouseover:nav.current=" + nav.current);
				isMenuNavigationMouseOver = true;
			}
		}
	}
	
	if( menuId ) {
		if (nav.menuAnchorMap.containsKey(menuId)) {
			//alert("menuAnchorMap contains");
			nav.menuAnchorMap.get(menuId).onmouseover();
		}
			
		//alert("isActiveDisplay=" + isActiveDisplay);
		if (isActiveDisplay && nav.menuImageMap.containsKey(menuId)) {
			//alert("isActiveDisplay=" + isActiveDisplay);
			var menuImg = nav.menuImageMap.get(menuId);
			menuImg.src = menuImg.src.replace(onChar, activeChar);
			//alert("imgSrc=" + menuImg.src);
		}
	}
}