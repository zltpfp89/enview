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
	initTopAnchorEvent( topMenu, menuIdArray, "#000000", "#ADA6BD" );
	// Top�޴� �����ۿ� ���콺 over �̺�Ʈ�� �߻� ������ ���Ǹ� �Ͽ��ش�.
	initTopNavigationDetail(userId, topMenu, topMenu, menuIdArray, 0, "#FFFFFF", "#999999", "#FFFFFF", false, true, true, true);

	var subMenu = document.getElementById("submenu");
	initLeftAnchorEvent( subMenu, menuIdArray, "#000000", "#685B8F" );
	initLeftNavigationDetail(subMenu, subMenu, menuIdArray, 1, "#FFFFFF", "#685B8F", "#FFFFFF", false, true, true, true);
}

function initTopAnchorEvent(nav, menuIdArray, onChar, offChar) {
//	var allA = nav.getElementsByTagName("a")
	var allA = nav.getElementsByTagName("li")
	for(var k = 0; k < allA.length; k++) {
		//alert("id=" + allA.item(k).id); 
		// ��� �޴� �������� ���콺 out�̺�Ʈ�� ���ؼ� ���Ǹ� �Ѵ�.
		allA.item(k).onmouseout = allA.item(k).onblur = function () {
			
			if( nav.prevMenuItem  ) {
				var menuImg = nav.prevMenuItem.childNodes.item(0);
				//var menuImg = nav.prevMenuItem.getElementsByTagName("a").item(0);
				//alert(menuImg.style.color);
				menuImg.style.color = offChar;
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
						//alert("menu=" + menuIdArray[j] + ", map=" + nav.menuAnchorGlobalMap.size);
						if (nav.menuAnchorGlobalMap.containsKey("menu_" + menuIdArray[j])) {
							//alert("found " + menuIdArray[j]);
							nav.menuAnchorGlobalMap.get("menu_" + menuIdArray[j]).onmouseover();
						}
					}
				}
			}, 200);
		}
	}
}
function initLeftAnchorEvent(nav, menuIdArray, onChar, offChar) {
	var allA = nav.getElementsByTagName("li")
	for(var k = 0; k < allA.length; k++) {
		// ��� �޴� �������� ���콺 out�̺�Ʈ�� ���ؼ� ���Ǹ� �Ѵ�.
		allA.item(k).onmouseout = allA.item(k).onblur = function () {
			
			if( nav.prevMenuItem  ) {
				var menuImg = nav.prevMenuItem.childNodes.item(0);
				menuImg.style.color = offChar;
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
						if (nav.menuAnchorGlobalMap.containsKey("submenu_" + menuIdArray[j])) {
							nav.menuAnchorGlobalMap.get("submenu_" + menuIdArray[j]).onmouseover();
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
function initTopNavigationDetail(userId, root, nav, menuIdArray, depth, onChar, offChar, activeChar, isActiveDisplay, isSubHidden, isSubNavigation, isSubEnableEvent) {
	if( !nav ) return;
	
	nav.menu = new Array();
	//nav.menuImageMap = new Map();
	//nav.menuAnchorMap = new Map();
	nav.menuImageMap = new Map();
	nav.menuAnchorMap = new Map();
	nav.menuAnchorGlobalMap = new Map();
	nav.current = null;
	nav.menuseq = 0;
	var navLen = nav.childNodes.length;
	var menuId = "menu_" + menuIdArray[depth];
	
	//alert("navLen=" + navLen);
	for (var i = 0; i < navLen; i++) {
		var navItem = nav.childNodes.item(i);
		
		if (navItem.tagName != "LI")
			continue;

		var navAnchor = navItem.getElementsByTagName("a").item(0);
//		var navImage = navItem.getElementsByTagName("img").item(0);
		// ���� anchor�±׿� img�±׸� root div��ҿ� �����Ѵ�.
		// �̰��� ���콺 out�̺�Ʈ�� �߻� ���� �� ���ȴ�.
//		nav.menuAnchorMap.put(navItem.id, navAnchor);
		//alert("id=" + navItem.id);
		nav.menuAnchorMap.put(navItem.id, navItem);
//		nav.menuImageMap.put(navItem.id, navImage);
		root.menuAnchorGlobalMap.put(navItem.id, navItem);
		
		// �޴� ������ ���� �� ���� �޴��� �����ְ��� �� ��쿡 ������ �Լ��� �ݺ��Ѵ�.
		if( isSubNavigation ) {
			navItem.submenu = navItem.getElementsByTagName("ul").item(0);
			initTopNavigationDetail( userId, root, navItem.submenu, menuIdArray, depth+1, "#000000", "#ADA6BD", "#000000", true, false, false, true );
//			navAnchor.submenu = navItem.getElementsByTagName("ul").item(0);
//			initTopNavigationDetail( userId, navAnchor.submenu, menuIdArray, depth+1, onChar, offChar, activeChar, true, false, false, true );
		}
		
//		navAnchor.onmouseover = navAnchor.onfocus = function () {
		navItem.onmouseover = navItem.onfocus = function () {
			if( isSubEnableEvent == true ) {
				if (nav.current) {
					var menuImg = nav.current.childNodes.item(0);
					//alert(menuImg.href);
					menuImg.style.color = offChar;
					if (nav.current.submenu && isSubHidden)
						nav.current.submenu.style.display = "none";
					nav.current = null;
				}
				if (nav.current != this) {
					//alert(this.id);
					root.prevMenuItem = this;
					var menuImg = this.childNodes.item(0);
					//alert(menuImg.href);
					menuImg.style.color = onChar;
					if (this.submenu && isSubHidden) {
						this.submenu.style.display = "block";
//						this.submenu.style.left = "0px";
					}
					nav.current = this;
				}
				isMenuNavigationMouseOver = true;
			}
		}
	}
	if( menuId ) {
		if (nav.menuAnchorMap.containsKey(menuId)) {
			//alert(menuId);
			nav.menuAnchorMap.get(menuId).onmouseover();
		}
			
		//alert("isActiveDisplay=" + isActiveDisplay + ", menuId=" + menuId + ", item=" + nav.menuAnchorMap.containsKey(menuId));
		if (isActiveDisplay && nav.menuAnchorMap.containsKey(menuId)) {
			var navItem = nav.menuAnchorMap.get(menuId);
			//alert("menuId=" + menuId + ", color=" + menuImg.style.color);
			var menuImg = navItem.childNodes.item(0);
			//alert("menuImg=" + menuImg.href); 
			menuImg.style.color = activeChar;
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
	nav.menuAnchorGlobalMap = new Map();
	nav.current = null;
	nav.menuseq = 0;
	var navLen = nav.childNodes.length;
	var menuId = "submenu_" + menuIdArray[depth];
	
	for (var i = 0; i < navLen; i++) {
		var navItem = nav.childNodes.item(i);
		
		if (navItem.tagName != "LI")
			continue;

		var navAnchor = navItem.getElementsByTagName("a").item(0);
		//var navImage = navItem.getElementsByTagName("img").item(0);
		nav.menuAnchorMap.put(navItem.id, navItem);
		//nav.menuImageMap.put(navItem.id, navImage);
		root.menuAnchorGlobalMap.put(navItem.id, navItem);
		//alert("navItem.id=" + navItem.id);
		
		if( isSubNavigation ) {
			navItem.submenu = navItem.getElementsByTagName("ul").item(0);
			initLeftNavigationDetail( root, navItem.submenu, menuIdArray, depth+1, "#FFFFFF", "#685B8F", "#FFFFFF", true, false, false, true );
		}
		
		navItem.onmouseover = navItem.onfocus = function () {
			if( isSubEnableEvent == true ) {
				if (nav.current) {
					/*
					//var menuImg = nav.current.childNodes.item(0);
					//menuImg.src = menuImg.src.replace(onChar, offChar);
					//if (nav.current.submenu && isSubHidden)
					//	nav.current.submenu.style.display = "none";
					nav.current = null;
					*/
					
					var menuImg = nav.current.childNodes.item(0);
					//alert(menuImg.href);
					menuImg.style.color = offChar;
					if (nav.current.submenu && isSubHidden)
						nav.current.submenu.style.display = "none";
					nav.current = null;
				}
				if (nav.current != this) {

					root.prevMenuItem = this;
					var menuImg = this.childNodes.item(0);
					menuImg.style.color = onChar;
					if (this.submenu && isSubHidden) {
						this.submenu.style.display = "block";
					}
					nav.current = this;
					/*
					var menuImg = this.childNodes.item(0);
					root.prevMenuItem = this;
					//root.prevMenuImg = menuImg.src;
					root.prevMenuIsSubHidden = isSubHidden;
					menuImg.style.color = onChar;
					//menuImg.src = menuImg.src.replace(offChar, onChar);
					if (this.submenu && isSubHidden)
						this.submenu.style.display = "block";
					nav.current = this;
					*/
				}
				//alert("onmouseover:nav.current=" + nav.current);
				isMenuNavigationMouseOver = true;
			}
		}
	}
	
	if( menuId ) {
		if (nav.menuAnchorMap.containsKey(menuId)) {
			//alert(nav.menuAnchorMap.get(menuId).id);
			nav.menuAnchorMap.get(menuId).onmouseover();
		}
			
		//alert("isActiveDisplay=" + isActiveDisplay);
		if (isActiveDisplay && nav.menuImageMap.containsKey(menuId)) {
			/*
			//alert("isActiveDisplay=" + isActiveDisplay);
			var menuImg = nav.menuImageMap.get(menuId);
			menuImg.style.color = activeChar;
			//menuImg.src = menuImg.src.replace(onChar, activeChar);
			//alert("imgSrc=" + menuImg.src);
			*/
			var navItem = nav.menuAnchorMap.get(menuId);
			//alert("menuId=" + menuId + ", color=" + menuImg.style.color);
			var menuImg = navItem.childNodes.item(0);
			//alert("menuImg=" + menuImg.href); 
			menuImg.style.color = activeChar;
		}
	}
}