/*
* 각 메뉴 아이템에 마우스 over/off 이벤트를 등록한다.
* 파라미터로 사용자 ID와 현재 페이지의 구조에 맞게 각 depth별로 페이지ID를 넘긴다.
*/
function initNavigation(userId, menuIds) {
	isMenuNavigationMouseOver = false;
	var menuIdArray = menuIds.split(",");

	var topMenu = document.getElementById("topmenu");
	// Top메뉴 아이템에 마우스 out 이벤트가 발생 하면 이전에 보여 주었던 메뉴판은 감추고 
	// 현재 페이지의 active한 메뉴 아이템에 마우스 over이벤트를 발생 시켜서 항상 active한 메뉴를 보여 줄 수 있도록 한다.
	initTopAnchorEvent( topMenu, menuIdArray, "#000000", "#002980" );
	//initTopAnchorEvent( topMenu, menuIdArray, "#000000", "#ADA6BD" );
	// Top메뉴 아이템에 마우스 over 이벤트가 발생 했을때 정의를 하여준다.
	initTopNavigationDetail(userId, topMenu, topMenu, menuIdArray, 0, "#FFFFFF", "#002980", "#FFFFFF", false, true, true, true);

	var subMenu = document.getElementById("submenu");
	initLeftAnchorEvent( subMenu, menuIdArray, "#000000", "#685B8F" );
	initLeftNavigationDetail(subMenu, subMenu, menuIdArray, 1, "#FFFFFF", "#685B8F", "#FFFFFF", false, false, true, true);
}

function initTopAnchorEvent(nav, menuIdArray, onChar, offChar) {
//	var allA = nav.getElementsByTagName("a")
	var allA = nav.getElementsByTagName("li");
	for(var k = 0; k < allA.length; k++) {
		//alert("id=" + allA.item(k).id); 
		// 모든 메뉴 아이템의 마우스 out이벤트에 대해서 정의를 한다.
		allA.item(k).onmouseout = allA.item(k).onblur = function () {
			//alert("initTopAnchorEvent onmouseout");
			if( nav.prevMenuItem  ) {
				var menuImg = nav.prevMenuItem.childNodes.item(0);
				//var menuImg = nav.prevMenuItem.getElementsByTagName("a").item(0);
				//alert(menuImg.style.color);
				menuImg.style.color = offChar;
				if (nav.prevMenuItem.submenu && nav.prevMenuIsSubHidden) {
					alert("initTopAnchorEvent");
					nav.prevMenuItem.submenu.style.display = "none";
				}
				nav.prevMenuItem = null;
			}
			
			isMenuNavigationMouseOver = false;
			// 현재 메뉴아이템에 마우스가 over되어 있는지 파악하고 over 안되어 있는 경우에
			// 현재 페이지의 메뉴 구조에 맞게 active한 메뉴 아이템들에 마우스 over 이벤트를 발생 시킨다.
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
		// 모든 메뉴 아이템의 마우스 out이벤트에 대해서 정의를 한다.
		allA.item(k).onmouseout = allA.item(k).onblur = function () {
			//alert("onmouseout");
			
			event.cancelBubble = true;       //for IE
			if(event.stopPropagation){
			  event.stopPropagation();
			}
			return false;
			/*
			if( nav.prevMenuItem  ) {
				var menuImg = nav.prevMenuItem.childNodes.item(0);
				menuImg.style.color = offChar;
				if (nav.prevMenuItem.submenu && nav.prevMenuIsSubHidden) {
					alert(111);
					nav.prevMenuItem.submenu.style.display = "none";
				}
				nav.prevMenuItem = null;
			}
			
			isMenuNavigationMouseOver = false;
			// 현재 메뉴아이템에 마우스가 over되어 있는지 파악하고 over 안되어 있는 경우에
			// 현재 페이지의 메뉴 구조에 맞게 active한 메뉴 아이템들에 마우스 over 이벤트를 발생 시킨다.
			setTimeout(function () {
				if( isMenuNavigationMouseOver == false ) {
					for(var j=0; j<menuIdArray.length; j++) {
						if (nav.menuAnchorGlobalMap.containsKey("submenu_" + menuIdArray[j])) {
							nav.menuAnchorGlobalMap.get("submenu_" + menuIdArray[j]).onmouseover();
						}
					}
				}
			}, 200);
			*/
		}
	}
}


/*
* Top메뉴 아이템에 마우스 over 이벤트가 발생 했을때 정의를 하여준다.
* isActiveDisplay : 현재 Active한 상태를 보여줄지 여부
* isSubHidden : 하위 메뉴판을 감출지의 여부
* isSubNavigation : 하위 메뉴들에 대해서 이벤트를 부여할 지 여부
* isSubEnableEvent : 현재 메뉴들에 대해서 이벤트를 부여할 지 여부
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
		$(navItem).addClass("menu_hover");
		if (navItem.tagName != "LI")
			continue;

		var navAnchor = navItem.getElementsByTagName("a").item(0);
//		var navImage = navItem.getElementsByTagName("img").item(0);
		// 현재 anchor태그와 img태그를 root div요소에 보관한다.
		// 이것은 마우스 out이벤트가 발생 했을 때 사용된다.
//		nav.menuAnchorMap.put(navItem.id, navAnchor);
		//alert("id=" + navItem.id);
		nav.menuAnchorMap.put(navItem.id, navItem);
//		nav.menuImageMap.put(navItem.id, navImage);
		root.menuAnchorGlobalMap.put(navItem.id, navItem);
		
		// 메뉴 아이템 선택 시 하위 메뉴를 보여주고자 할 경우에 현재의 함수를 반복한다.
		if( isSubNavigation ) {
			navItem.submenu = navItem.getElementsByTagName("ul").item(0);
			initTopNavigationDetail( userId, root, navItem.submenu, menuIdArray, depth+1, "#002980", "BBC5DE", "#002980", true, false, false, true );
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
					if (nav.current.submenu && isSubHidden) {
						//alert("initTopNavigationDetail");
						nav.current.submenu.style.display = "none";
					}
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
* Left메뉴 아이템에 마우스 over 이벤트가 발생 했을때 정의를 하여준다.
* isActiveDisplay : 현재 Active한 상태를 보여줄지 여부
* isSubHidden : 하위 메뉴판을 감출지의 여부
* isSubNavigation : 하위 메뉴들에 대해서 이벤트를 부여할 지 여부
* isSubEnableEvent : 현재 메뉴들에 대해서 이벤트를 부여할 지 여부
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