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
	initTopAnchorEvent( topMenu, menuIdArray, "_on.gif", "_off.gif" );
	// Top메뉴 아이템에 마우스 over 이벤트가 발생 했을때 정의를 하여준다.
	initTopNavigationDetail(userId, topMenu, menuIdArray, 0, "_on.gif", "_off.gif", "_on.gif", false, true, true, true);

	
	var subMenu = document.getElementById("submenu");
	initLeftAnchorEvent( subMenu, menuIdArray, "_on.gif", "_off.gif" );
	initLeftNavigationDetail(subMenu, subMenu, menuIdArray, 1, "_on.gif", "_off.gif", "_done.gif", true, false, true, true);
	
}

function initTopAnchorEvent(nav, menuIdArray, onChar, offChar) {
	var allA = nav.getElementsByTagName("a")
	for(var k = 0; k < allA.length; k++) {
		// 모든 메뉴 아이템의 마우스 out이벤트에 대해서 정의를 한다.
		allA.item(k).onmouseout = allA.item(k).onblur = function () {
			
			if( nav.prevMenuItem  ) {
				var menuImg = nav.prevMenuItem.childNodes.item(0);
				menuImg.src = nav.prevMenuImg;
				if (nav.prevMenuItem.submenu && nav.prevMenuIsSubHidden)
					nav.prevMenuItem.submenu.style.display = "none";
				nav.prevMenuItem = null;
			}
			
			isMenuNavigationMouseOver = false;
			// 현재 메뉴아이템에 마우스가 over되어 있는지 파악하고 over 안되어 있는 경우에
			// 현재 페이지의 메뉴 구조에 맞게 active한 메뉴 아이템들에 마우스 over 이벤트를 발생 시킨다.
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
		// 모든 메뉴 아이템의 마우스 out이벤트에 대해서 정의를 한다.
		allA.item(k).onmouseout = allA.item(k).onblur = function () {
			
			if( nav.prevMenuItem  ) {
				var menuImg = nav.prevMenuItem.childNodes.item(0);
				menuImg.src = nav.prevMenuImg;
				if (nav.prevMenuItem.submenu && nav.prevMenuIsSubHidden)
					nav.prevMenuItem.submenu.style.display = "none";
				nav.prevMenuItem = null;
			}
			
			isMenuNavigationMouseOver = false;
			// 현재 메뉴아이템에 마우스가 over되어 있는지 파악하고 over 안되어 있는 경우에
			// 현재 페이지의 메뉴 구조에 맞게 active한 메뉴 아이템들에 마우스 over 이벤트를 발생 시킨다.
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
* Top메뉴 아이템에 마우스 over 이벤트가 발생 했을때 정의를 하여준다.
* isActiveDisplay : 현재 Active한 상태를 보여줄지 여부
* isSubHidden : 하위 메뉴판을 감출지의 여부
* isSubNavigation : 하위 메뉴들에 대해서 이벤트를 부여할 지 여부
* isSubEnableEvent : 현재 메뉴들에 대해서 이벤트를 부여할 지 여부
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
		// 현재 anchor태그와 img태그를 root div요소에 보관한다.
		// 이것은 마우스 out이벤트가 발생 했을 때 사용된다.
		nav.menuAnchorMap.put(navItem.id, navAnchor);
		nav.menuImageMap.put(navItem.id, navImage);
		
		// 메뉴 아이템 선택 시 하위 메뉴를 보여주고자 할 경우에 현재의 함수를 반복한다.
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