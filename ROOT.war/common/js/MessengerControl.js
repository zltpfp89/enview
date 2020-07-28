var ezim_url = 'http://127.0.0.1:55530';
var ezim_exe = 'http://10.11.52.62:8080/webmanager/FILE/download/AppFile/EzQMessengerControl.exe';
var ezim_pgname = 'KRC메신저2.0';
var ezim_messengername = 'KRC메신저2.0';
var ezim_messengerdownurl = 'http://10.11.52.62:8080/webmanager/FILE/download/AppFile/KRCMessenger2.0Setup.exe';
var ezim_messengerversion = "8.0";
var ezim_controlversion = 1;

// ---------------------------------------------------------

var ezim_debug = false;
var ezim_check_count = 0;
var ezim_check_timer = null;
var ezim_ret_function;

var ezim_userid = '';
var ezim_password = '';

var ezim_mode = '';

function ezim_init() {
	ezim_check_count = 0;
	ezim_ret_function = null;
	if (ezim_check_timer != null) {
		clearInterval(ezim_check_timer);
	}
	ezim_mode = '';

	RemoveEvent();
	RemoveElement('ezim_fnc_iframe');
	RemoveElement('ezim_fnc_div');
}

function ezim_RunMessenger(id, pwd) {
	ezim_init();

	ezim_mode = 'IMLAUNCH';

	ezim_userid = encodeURI(id);
	ezim_password = encodeURI(pwd);

	ezim_CheckInstall();

	ezim_check_timer = setInterval(function() {
		ezim_CheckInstall();
	}, 3000);
}

function ezim_MsgSendFunc(id) {
	ezim_init();

	ezim_mode = 'IMMSGSEND';

	ezim_userid = id;

	ezim_CheckSendMsg();

}

function ezim_MsgChatFunc(id) {
	ezim_init();

	ezim_mode = 'IMCHATSEND';

	ezim_userid = id;

	ezim_CheckSendMsg();

}

function ezim_MsgInfoFunc(id) {
	ezim_init();

	ezim_mode = 'IMINFOSEND';

	ezim_userid = id;

	ezim_CheckSendMsg();

}

function ezim_MsgClictoCallFunc(id) {
	ezim_init();

	ezim_mode = 'IMCLICTOCALLSEND';

	ezim_userid = id;

	ezim_CheckSendMsg();

}

function ezim_CheckInstall() {
	if (ezim_check_count == 3) {
		ezim_Control.Install();
	} else if (ezim_check_count == 200) {
		clearInterval(ezim_check_timer);
	} else {
		var param = 'command=CheckVersion&PGName=' + encodeURI(ezim_pgname)
				+ '&MessengerName=' + encodeURI(ezim_messengername)
				+ '&controlVer=' + ezim_controlversion + '&imVer='
				+ ezim_messengerversion + '&downurl=' + ezim_messengerdownurl;
		ezim_CallFunction(param, ezim_RetCheckInstall);
	}
	ezim_check_count++;
}

function ezim_CheckSendMsg() {
	if (ezim_check_count == 3) {
		ezim_Control.Install();
	} else if (ezim_check_count == 200) {
		clearInterval(ezim_check_timer);
	} else {
		if (ezim_mode == 'IMLAUNCH') {
			var param = 'command=CheckVersion&PGName=' + encodeURI(ezim_pgname)
					+ '&MessengerName=' + encodeURI(ezim_messengername)
					+ '&controlVer=' + ezim_controlversion + '&imVer='
					+ ezim_messengerversion + '&downurl='
					+ ezim_messengerdownurl;
			ezim_CallFunction(param, ezim_RetCheckInstall);
		} else if (ezim_mode == 'IMMSGSEND') {
			var param = 'command=RunMsgSend&userid=' + ezim_userid + '&imVer='
					+ 'MsgSend';
			ezim_CallFunction(param, ezim_RetCheckInstall);
		} else if (ezim_mode == 'IMCHATSEND') {
			var param = 'command=RunMsgSend&userid=' + ezim_userid + '&imVer='
					+ 'MsgChat';
			ezim_CallFunction(param, ezim_RetCheckInstall);
		} else if (ezim_mode == 'IMINFOSEND') {
			var param = 'command=RunMsgSend&userid=' + ezim_userid + '&imVer='
					+ 'MsgInfo';
			ezim_CallFunction(param, ezim_RetCheckInstall);
		} else if (ezim_mode == 'IMCLICTOCALLSEND') {
			var param = 'command=RunMsgSend&userid=' + ezim_userid + '&imVer='
					+ 'MsgClickToCall';
			ezim_CallFunction(param, ezim_RetCheckInstall);
		}
	}
	ezim_check_count++;
}

function ezim_CallFunction(param, ret_function) {
	var url = ezim_url + '?' + param;

	var fncDiv = document.createElement('div');
	fncDiv.setAttribute("id", "ezim_fnc_div");
	document.body.appendChild(fncDiv);

	var ezim_fnc_iframe = document.createElement('iframe');
	ezim_fnc_iframe.frameborder = "no";
	ezim_fnc_iframe.border = "0px";
	ezim_fnc_iframe.width = "0px";
	ezim_fnc_iframe.height = "0px";
	ezim_fnc_iframe.style.display = "none";

	// ezim_fnc_iframe.width = "50px";
	// ezim_fnc_iframe.height = "50px";
	// ezim_fnc_iframe.style.display = "inline";

	ezim_fnc_iframe.id = "ezim_fnc_iframe";

	if (ezim_debug == true) {
		ezim_fnc_iframe.width = "400px";
		ezim_fnc_iframe.height = "100px";
	}

	ezim_fnc_iframe.src = url;

	if (ezim_ret_function != ret_function) {
		ezim_ret_function = ret_function;
		if (window.attachEvent)
			window.attachEvent("onmessage", ret_function);
		else
			window.addEventListener("message", ret_function, false);
	}
	document.getElementById("ezim_fnc_div").appendChild(ezim_fnc_iframe);

	//alert(url);
}

function ezim_RetCheckInstall(e) {
	try {
		ezim_util.Log("ezim_RetCheckInstall:", e.data);
		var data = eval('(' + e.data + ')');
		if (data != null) {
			if (ezim_controlversion < data.version) {
				if (ezim_check_count < 4) {
					ezim_check_count = 4;
					ezim_Control.Install()
				}
				return;
			}
		}

		clearInterval(ezim_check_timer);
		RemoveEvent();
		if (ezim_mode == 'IMLAUNCH') {
			var param = 'command=RunMessenger&userid=' + ezim_userid
					+ '&password=' + ezim_password + '&controlVer='
					+ ezim_controlversion + '&imVer=' + ezim_messengerversion;
			ezim_CallFunction(param, ezim_RetCheckInstall);
		} else if (ezim_mode == 'IMMSGSEND') {
			var param = 'command=RunMsgSend&userid=' + ezim_userid + '&imVer='
					+ 'MsgSend';
			ezim_CallFunction(param, ezim_RetCheckInstall);
		} else if (ezim_mode == 'IMCHATSEND') {
			var param = 'command=RunMsgSend&userid=' + ezim_userid + '&imVer='
					+ 'MsgChat';
			ezim_CallFunction(param, ezim_RetCheckInstall);
		} else if (ezim_mode == 'IMINFOSEND') {
			var param = 'command=RunMsgSend&userid=' + ezim_userid + '&imVer='
					+ 'MsgInfo';
			ezim_CallFunction(param, ezim_RetCheckInstall);
		} else if (ezim_mode == 'IMCLICTOCALLSEND') {
			var param = 'command=RunMsgSend&userid=' + ezim_userid + '&imVer='
					+ 'MsgClickToCall';
			ezim_CallFunction(param, ezim_RetCheckInstall);
		}
	} catch (e) {
		console.log(e)
		// alert(e);
	}
}

function RemoveElement(id) {
	try {
		var elem = document.getElementById(id);
		if (elem != null) {
			elem.parentElement.removeChild(elem);
		}

		/*
		 * var list = document.getElementById(id); if (list == null) { return; }
		 * for(var i = list.length - 1; 0 <= i; i--) if(list[i] &&
		 * list[i].parentElement) list[i].parentElement.removeChild(list[i]);
		 */
	} catch (e) {
		// alert(e);
		console.log(e)
	}
}

function RemoveEvent() {
	try {
		if (ezim_ret_function == null) {
			return;
		}

		if (ezim_util.browser_check() == "wsf"
				|| (ezim_util.getOSInfo() == "Windows XP" && (ezim_util
						.getInternetExplorerVersion() > 0 && ezim_util
						.getInternetExplorerVersion() < 8.0))) {
		} else {
			if (window.detachEvent)
				window.detachEvent("onmessage", ezim_ret_function);
			else
				window.removeEventListener("message", ezim_ret_function, false);
			ezim_util.Log("RemoveEvent:", ezim_ret_function.name);
		}
	} catch (e) {
		console.log(e)
		// alert(e);
	}
}

var ezim_Control = {
	Install : function() {
		window.open(ezim_exe, '_self');
	}
};

var ezim_util = {
	Log : function(target, msg) {
		if (ezim_debug == true) {
			if (ezim_util.browser_check() == "wsf"
					|| (ezim_util.getOSInfo() == "Windows XP" && (ezim_util
							.getInternetExplorerVersion() > 0 && ezim_util
							.getInternetExplorerVersion() < 8.0))) {
				// alert(target + " : " + msg);
			} else {
				if (window.console)
					console.log(target + " : " + msg);
				// else alert( target +" : " + msg);
			}
		}
	},
	getInternetExplorerVersion : function() {
		var rv = -1;
		if (navigator.appName == 'Microsoft Internet Explorer') {
			var ua = navigator.userAgent;
			var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
			if (re.exec(ua) != null)
				rv = parseFloat(RegExp.$1);
		}
		return rv;
	},
	getOSInfo : function() {
		var ua = navigator.userAgent;
		if (ua.indexOf("NT 6.0") != -1)
			return "Windows Vista/Server 2008";
		else if (ua.indexOf("NT 5.2") != -1)
			return "Windows Server 2003";
		else if (ua.indexOf("NT 5.1") != -1)
			return "Windows XP";
		else if (ua.indexOf("NT 5.0") != -1)
			return "Windows 2000";
		else if (ua.indexOf("NT") != -1)
			return "Windows NT";
		else if (ua.indexOf("9x 4.90") != -1)
			return "Windows Me";
		else if (ua.indexOf("98") != -1)
			return "Windows 98";
		else if (ua.indexOf("95") != -1)
			return "Windows 95";
		else if (ua.indexOf("Win16") != -1)
			return "Windows 3.x";
		else if (ua.indexOf("Windows") != -1)
			return "Windows";
		else if (ua.indexOf("Linux") != -1)
			return "Linux";
		else if (ua.indexOf("Macintosh") != -1)
			return "Macintosh";
		else
			return "";
	},
	browser_check : function() {
		var mAgent = navigator.userAgent;
		var mOS = navigator.platform;
		if ((mOS.indexOf("Win") != -1) || (mOS.indexOf("Win32") != -1)
				|| (mOS.indexOf("Win64") != -1)) {
			if (mAgent.indexOf("MSIE") != -1) {
				return "wie";
			} else if (mAgent.indexOf("Firefox") != -1) {
				return "wff";
			} else if (mAgent.indexOf("Chrome") != -1) {
				return "wchrome";
			} else if (mAgent.indexOf("Safari") != -1) {
				return "wsf";
			} else if (mAgent.indexOf("Opera") != -1) {
				return "wopera";
			} else if (mAgent.indexOf("Mozilla/5.0") != -1) {
				if (navigator.appName == 'Netscape') {
					var ua = navigator.userAgent;
					var re = new RegExp("Trident/.*rv:([0-9]{1,}[\.0-9]{0,})");
					if (re.exec(ua) != null) {
						var rv = -1;
						rv = parseFloat(RegExp.$1);
						if (rv != -1) {
							return "wie";
						}
					}
				}
			}
		}
	},
	CheckVer : function() {
		webblasare = navigator.appVersion;

		if (webblasare.indexOf("WOW64") != -1) {
			if (webblasare.indexOf("Windows NT 5.1") != -1
					|| webblasare.indexOf("Windows NT 5.2") != -1) {
				return 3;
			} else {
				return 2;
			}
		} else if (webblasare.indexOf("Windows NT 6.0") != -1
				|| webblasare.indexOf("Windows NT 6.1") != -1
				|| webblasare.indexOf("Windows NT 6.2") != -1) {
			return 1;
		} else {
			return 0;
		}
	}
};