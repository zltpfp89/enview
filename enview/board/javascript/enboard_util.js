<!--
if (!window.enboard)
    window.enboard = new Object();

String.prototype.trim = function() {
  return this.replace(/(^\s*)|(\s*$)/gi, "");
}

String.prototype.popupView = function() {
    var img_view = this;
    var x = x + 20 ;
    var y = y + 30 ;
    htmlz = "<html><head><title>이미지크게보기</title><style>body{margin:0;cursor:pointer;}</style></head><body scroll=auto onload='width1=document.getElementById(\"Timage\").width;if(width1>1024)width1=1024;height1=document.getElementById(\"Timage\").height;if(height1>768)height1=768;top.window.resizeTo(width1+30,height1+104);' onclick='top.window.close();'><img src='"+img_view+"' title='클릭하시면 닫힙니다.' name='Timage' id='Timage'></body></html>";
    imagez = window.open('', "image", "width="+ 100 +", height="+ 100 +", top=0,left=0,scrollbars=auto,resizable=1,toolbar=0,menubar=0,location=0,directories=0,status=1");
    imagez.document.open();
    imagez.document.write(htmlz);
    imagez.document.close();
}

String.prototype.isEmpty = function() {
	if (this == null || this.length == 0) return true;
	else return false;
}

enboard.util = function() {
	this.Alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
	this.Num   = '0123456789';
	this.NNum  = '123456789';
	this.AlphaNum = this.Alpha + this.Num;
	this.TableName = this.Alpha + this.Num + '_';
	this.NonSpecialName = this.Alpha + this.Num + ' _';
	this.URLString = this.TableName + '-.';
}
enboard.util.prototype = {
	Alpha : null,
	Num   : null,
	NNum  : null,
	AlphaNum : null,
	TableName : null,
	URLString : null,
	mrBun : null,
	mlMngr : null,
	popupDialog : null,
	contextPath : null,

	clone : function(obj) {
		var newObj = (obj instanceof Array) ? [] : {};
		for (i in obj) {
			if (i == 'clone') continue;
			if (obj[i] && typeof obj[i] == "object") {
				newObj[i] = this.clone(obj[i]);
			} else {
				newObj[i] = obj[i];
			}
		}
		return newObj;
	},
	chkSelect : function (obj, initIndex, msg, isSet) {
		var isselect = false;

		for( var i=initIndex; i<obj.options.length; i++ ) {
			if( obj.options[i].selected == true ) {
				isselect = true;
				break;
			}
		}

		if( isselect ) return true;
		else {
			alert(ebUtil.getMessage('mm.info.select', msg));
			if( isSet == 'true' ) obj.focus();
			return false;	
		}
	},
	getSelectedValue : function( obj ) {
		for( var i=0; i<obj.options.length; i++ ) {
			if( obj.options[i].selected == true ) {
				return obj.options[i].value;
			}
		}
	},
	getSelectedAttr : function (obj, attr) {
		for (var i=0; i<obj.options.length; i++) {
			if (obj.options[i].selected == true) {
				return obj.options[i].getAttribute(attr);
			}
		}
	},
	setSelectedAttr : function (obj, attr, val) {
		for (var i=0; i<obj.options.length; i++) {
			if (obj.options[i].getAttribute(attr) == val) {
				obj.options[i].selected = true;
			}
		}
	},
	getSelectedValues : function( obj ) {
		var rtnVal = "";
		for( var i=0; i<obj.options.length; i++ ) {
			if( obj.options[i].selected == true ) {
				if( obj.options[i].value != '' ) {
					rtnVal += obj.options[i].value + ",";
				}
			}
		}
		if( rtnVal != "" ) rtnVal = rtnVal.substr( 0, rtnVal.length - 1 );
		return rtnVal
	},
	setSelectedValue : function( obj, val ) {
		for( var i=0; i<obj.options.length; i++ ) {
			if( obj.options[i].value == val ) {
				obj.options[i].selected = true;
			}
		}
	},
	setSelectedValues : function( obj, val ) {
		var vals = val.split(",");
		for( var i=0; i<obj.options.length; i++ ) {
			for( var j=0; j<vals.length; j++ ) {
				if( obj.options[i].value == vals[j] ) {
					obj.options[i].selected = true;
				}
			}
		}
	},
	getSelectedText : function( obj ) {
		for( var i=0; i<obj.options.length; i++ ) {
			if( obj.options[i].selected == true ) {
				return obj.options[i].text;
			}
		}
	},
	getSelectedTexts : function( obj ) {
		var rtnVal = "";
		for( var i=0; i<obj.options.length; i++ ) {
			if( obj.options[i].selected == true ) {
				rtnVal += obj.options[i].text + ",";
			}
		}
		if( rtnVal != "" ) rtnVal = rtnVal.substr( 0, rtnVal.length - 1 );
		return rtnVal;
	},
	setSelectedText : function( obj, txt ) {
		for( var i=0; i<obj.options.length; i++ ) {
			if( obj.options[i].text == txt ) {
				obj.options[i].selected = true;
			}
		}
	},
	setSelectedTexts : function( obj, txt ) {
		var txts = txt.split(",");
		for( var i=0; i<obj.options.length; i++ ) {
			for( var j=0; j<txts.length; j++ ) {
				if( obj.options[i].text == txts[j] ) {
					obj.options[i].selected = true;
				}
			}
		}
	},
	chkCheck : function( obj, msg, isSet ) {
		var ischeck = false;
		var isArray = true;
		if (""+obj.length == 'undefined') isArray = false;
		
		if (isArray) 
			for (var i=0; i<obj.length; i++) {
				if (obj[i].checked == true) {
					ischeck = true;
					break;
				}
			}
		else 
			if (obj.checked == true) ischeck = true;
		
		if (ischeck) return true;
		else {
			alert(ebUtil.getMessage('mm.info.select', msg));
			if( isSet == 'true' ) {
				if (isArray) obj[0].focus();
				else         obj.focus();
			}
			return false;	
		}
	},
	chkCheckCnt : function( obj, cnt, msg, isSet ) {
		var isArray = true;
		if (""+obj.length == 'undefined') isArray = false;
		var chk =0;
		if (isArray) 
			for (var i=0; i<obj.length; i++) {
				if (obj[i].checked == true) {
					chk++ 
				}
			}
		else 
			if (obj.checked == true) chk++;
		
		if (cnt < 2 && chk > 0) {
			// 무제한(-1) 또는 단일 선택(0,1) 이면 하나라도 선택 되었을때 OK 
			return true;
		} else if( cnt == chk) {
			// 동일한 숫자가 선택 되었으면 OK
			return true;
		} else {
			if( cnt > 1) {
				msg = ebUtil.getMessage('mm.info.select.multi', msg, cnt);
			} else {
				msg = ebUtil.getMessage('mm.info.select', msg);
			}
			alert(msg);
			if( isSet == 'true' ) {
				if (isArray) obj[0].focus();
				else         obj.focus();
			}
			return false;	
		}
	},
	
	getCheckedValue : function( obj ) {
		for( var i=0; i<obj.length; i++ ) {
			if( obj[i].checked == true ) {
				return obj[i].value;
			}
		}
	},
	setCheckedValue : function( obj, val ) {
		for( var i=0; i<obj.length; i++ ) {
			if( obj[i].value == val ) {
				obj[i].checked = true;
			} else {
				obj[i].checked = false;
			}
		}
	},
	getCheckedValues : function( obj ) {
		var rtnVal = "";
		for( var i=0; i<obj.length; i++ ) {
			if( obj[i].checked == true ) {
				rtnVal += obj[i].value + ",";
			}
		}
		if( rtnVal != '' ) rtnVal = rtnVal.substr( 0, rtnVal.length - 1 );
		return rtnVal;
	},
	getNumWithComma : function (numStr) {
		var rtnStr = "";
		for (var i=numStr.length-1,j=1; i>=0; i--,j++) {
			rtnStr = numStr.substr(i,1) + rtnStr;
			if (j % 3 == 0) {
				rtnStr = "," + rtnStr;
			}
		}
		return rtnStr;
	},
	discardNonNum : function (numStr) {
		var rtnStr = "";
		for (i=0; i<numStr.length; i++) {
			if (this.Num.indexOf (numStr.substring (i,i+1)) > -1) {
				rtnStr += numStr.substring (i,i+1);
			}
		}
		return rtnStr;
	},
	chkEmail : function( obj, limitByte, isSet ) {
		if (!chkLength(obj, ebUtil.getMessage('eb.info.ttl.email'), limitByte, isSet)) return false;
		if (val.length > 0) {
			var arrMatch = val.match(/^(\".*\"|[A-Za-z0-9_-]([A-Za-z0-9_-]|[\+\.])*)@(\[\d{1,3}(\.\d{1,3}){3}]|[A-Za-z0-9][A-Za-z0-9_-]*(\.[A-Za-z0-9][A-Za-z0-9_-]*)+)$/);
				if (arrMatch == null) {
					alert( ebUtil.getMessage('eb.info.check.email.addr.format'));
					if( isSet == 'true' ) obj.focus();
					return false;
				}
		}
		return true;
	},
	chkChar : function( obj, msg, isSet ) {
		for( i=0; i<obj.value.length; i++ ) {
			if( ebUtil.Alpha.indexOf( obj.value.substring(i,i+1)) < 0 ) {
				alert(msg+' '+ebUtil.getMessage('mm.info.cant.special'));
				if( isSet == 'true' ) obj.focus();
				return false;
			}
		}
		return true;
	},
	chkCharNum : function( obj, msg, isSet ) {
		for( i=0; i<obj.value.length; i++ ) {
			if( ebUtil.AlphaNum.indexOf(obj.value.substring(i,i+1)) < 0 ) {
				alert(msg+' '+ebUtil.getMessage('mm.info.cant.special'));
				if( isSet == 'true' ) obj.focus();
				return false;
			}
		}
		return true;
	},
	chkTableName : function( obj, msg, isSet ) {
		for( i=0; i<obj.value.length; i++ ) {
			if( ebUtil.TableName.indexOf (obj.value.substring(i,i+1)) < 0) {
				alert( msg+' '+ebUtil.getMessage('mm.info.cant.special'));
				if( isSet == 'true' ) obj.focus();
				return false;
			}
		}
		return true;
	},
	chkURLString : function( obj, msg, isSet ) {
		if (obj.value.charAt(0) == '_') {
			alert( msg+' '+ebUtil.getMessage('mm.info.cant.special'));
			if( isSet == 'true' ) obj.focus();
			return false;
		}
		for( i=0; i<obj.value.length; i++ ) {
			if( ebUtil.URLString.indexOf( obj.value.substring(i,i+1)) < 0 ) {
				alert( msg+' '+ebUtil.getMessage('mm.info.cant.special'));
				if( isSet == 'true' ) obj.focus();
				return false;
			}
		}
		return true;
	},
	chkSpecial : function(obj, msg, isSet) {
		var len = obj.value.length;
		for (i=0; i<len; i++) { 
			if (obj.value.charCodeAt(i) <= 255) {
				if (ebUtil.NonSpecialName.indexOf (obj.value.substring(i,i+1)) < 0) {
					alert (msg+' '+ebUtil.getMessage('mm.info.cant.special'));
					if (isSet == 'true') obj.focus();
					return false;
				}
			}
		}
		return true;
	},
	chkNum : function( obj, msg, isSet ) {
		for( i=0; i<obj.value.length; i++ ) {
			if( ebUtil.Num.indexOf( obj.value.substring(i,i+1)) < 0 ) {
				alert( msg+' '+ebUtil.getMessage('mm.info.only.number'));
				if( isSet == 'true' ) obj.focus();
				return false;
			}
		}
		return true;
	},
	chkNNum : function( obj, msg, isSet ) {
		for( i=0; i<obj.value.length; i++ ) {
			if( ebUtil.NNum.indexOf(obj.value.substring(i,i+1)) < 0 ) {
				alert( msg+' '+ebUtil.getMessage('mm.info.only.nnumber'));
				if( isSet == 'true' ) obj.focus();
				return false;
			}
		}
		return true;
	},
	chkMinusNum : function( obj, msg, isSet ) {	//마이너스, 숫자만 입력 가능하도록...
       var re = /^(-?)[0-9]+$/;

        if(!re.test(obj.value)) {
        	alert( msg+' '+ebUtil.getMessage('mm.info.only.minusNumber'));	//잘못된 숫자가 있습니다. 마이너스, 숫자 이외 문자는 입력할수 없습니다.
			if( isSet == 'true' ) obj.focus();
			return false;
        }
		return true;
	},
	chkKor : function( obj, msg, isSet ) {
		var len = obj.value.length;
		var codeLen = 0;
		for( i=0; i<len; i++ ) 
			(obj.value.charCodeAt(i) > 255) ? codeLen+=2 : codeLen++;
		if (len != codeLen) {
			alert(msg+' '+ebUtil.getMessage('mm.info.cant.hanguel'));
			if( isSet == 'true' ) obj.focus();
			return false;
		}
		return true;
	},
	chkBlank : function( obj, msg, isSet ) {
		if( obj.value.indexOf(' ') >= 0 ) {
			alert(msg+' '+ebUtil.getMessage('mm.info.cant.whitespace'));
			if( isSet == 'true' ) obj.focus();
			return false;
		}
		return true;
	},
	chkLength : function( obj, msg, limitByte, isSet ) {
		var val = obj.value;
		var b = this.byteLength(val )
		if (b > limitByte) {
			alert(msg+' '+ebUtil.getMessage('mm.info.limitByte', limitByte));
			if( isSet == 'true' ) obj.focus();
			return false;
		}
		return true;
	},

	checkLength : function( obj) {
		if( obj.tagName=='FORM') {
			for( var i=0; i < obj.elements.length;i++) {
				var e = obj.elements[i];
				if( e.tagName=='TEXTAREA' || e.type=='text') {
					if( ! this.checkLength1( e)) {
						return false;
					}
				}
			}
			return true;
		} else {
			return this.checkLength1( obj);
		}
	},
	
	checkLength1 : function( obj, maxByte) {
		var val = obj.value;
		
		if( maxByte==null) {
			limitByte = obj.maxLength;
		}
		// 길이가 미지정이면 체크안함
		if( limitByte==null || limitByte <= 0) {
			return true;
		}
		
		var msg = obj.title;
		if( msg==null) {
			msg = obj.title;
		}
		if( msg==null) {
			msg = '';
		}
		
		
		var b = this.byteLength(val );
		if (b > limitByte) {
			alert(msg+' '+ebUtil.getMessage('mm.info.limitByte', limitByte) + '(' + b + ' Bytes)');
			obj.focus();
			return false;
		}
		return true;
	},
	
	
	byteLength : function (str) {
		  // returns the byte length of an utf8 string
		  var s = str.length;
		  for (var i=str.length-1; i>=0; i--) {
		    var code = str.charCodeAt(i);
		    if (code > 0x7f && code <= 0x7ff) s++;
		    else if (code > 0x7ff && code <= 0xffff) s+=2;
		    if (code >= 0xDC00 && code <= 0xDFFF) i--; //trail surrogate
		  }
		  return s;
	},
	
	byteCut : function (str, len) {
		var s = '';
		var l = 0;
		for (var i=0; i <str.length;i++) {
			var code = str.charCodeAt(i);
			if (code <= 0x7f )  {
				l++
			} else if (code <= 0x7ff) {
				l+=2;
			} else if (code > 0x7ff && code <= 0xffff) {
				l+=3;
			}
			if (code >= 0xDC00 && code <= 0xDFFF) i--; //trail surrogate
			if( l < len) {
				s += str.charAt(i);
			} else {
				break;
			}
		}
		return s;
	},
	
	
	chkValue : function( obj, msg, isSet ) {
		if( obj.value.trim() == '' ) {
			alert( ebUtil.getMessage('mm.info.input.param', msg));
			if (isSet == 'true') obj.focus();
			return false;
		}
		return true;
	},
	chkBadCntt : function( obj, msg, badWord, isSet ) {
		if (badWord == 'null' || badWord == '')
			return true;
		var val = obj.value;	
		var bad = badWord.split(";");
		for (var i = 0; i < bad.length; i++) {
			
			if (bad[i].trim().length > 0 && val.indexOf(bad[i]) > -1) {
				alert(msg+ebUtil.getMessage('eb.info.cant.bad', bad[i]));
				return false;
			}
		}
		return true;
	},
	chkJumin : function( obj1, obj2 ) {
		var resiFirst = obj1.value;
		var resiLast  = obj2.value;

		var chk = 0;
		var nYear   = resiFirst.substring(0,2);
		var nMondth = resiFirst.substring(2,4);
		var nDay    = resiFirst.substring(4,6);
		var nSex    = resiLast.charAt(0);

		for( i=0; i<resiFirst.length; i++ ) {
				if( ebUtil.Num.indexOf( resiFirst.substring(i,i+1))<0) {
				alert( ebUtil.getMessage('mm.info.jumin1.cant.char'));
				eval('document.'+objNm1+'.focus();');
				eval('document.'+objNm1+'.select();');
				return false;
			}
		}
		for( i=0; i<resiLast.length; i++ ) {
				if( ebUtil.Num.indexOf( resiLast.substring(i,i+1))<0) {
				alert( ebUtil.getMessage('mm.info.jumin2.cant.char'));
				eval('document.'+objNm2+'.focus();');
				eval('document.'+objNm2+'.select();');
				return false;
			}
		}	
		
		if( resiFirst.length!=6 ||  nMondth<1 || nMondth>12 || nDay<1 || nDay>31) {
			alert(ebUtil.getMessage('mm.info.jumin1.wrong'));
			obj1.focus();
			obj1.select();
			return false;
		}
		
		if( resiLast.length!=7 || (nSex!=1 && nSex!=2 && nSex!=3 && nSex!=4) ) {
			alert( mrBun.getMessage('mm.info.jumin.invalid'));
			obj2.focus();
			obj2.select();
			return false;
		}
		
		var i;
		for (i=0; i<6; i++) {
			chk += ( (i+2) * parseInt( resiFirst.charAt(i) ));
		}
		
		for (i=6; i<12; i++) {
			chk += ( (i%8+2) * parseInt( resiLast.charAt(i-6) ));
		}
		
		chk = 11 - (chk%11);
		chk %= 10;
		
		if (chk != parseInt( resiLast.charAt(6))) {
			alert(ebUtil.getMessage('mm.info.jumin.invalid'));
			obj1.focus();		
			return false;
		}
		return true;
	},
	isAlphaNumCheck : function( obj ) {
		for( var i=0; i<obj.value.length; i++ ) {
			var ch = obj.value.charAt(i);
			if      ((ch >= '0') && (ch <= '9')) {}
			else if ((ch >= 'a') && (ch <= 'z')) {}
			else if ((ch >= 'A') && (ch <= 'Z')) {}
			else {
				alert( ebUtil.getMessage('mm.info.cant.special'));
				obj.focus();
				return false;
			}
		}
		return true;
	},
	isNumCheck : function( obj ) {
		for( var i=0; i<obj.value.length; i++ ) {
			var ch = obj.value.charAt(i);
			if( ch < '0' || ch > '9' ) {
				alert( ebUtil.getMessage('mm.info.only.number'));
				obj.focus();
				return false;
			}
		}
		return true;
	},
	checkCheckboxAll : function (frm, elm) {
		var elms = frm.elements;
		for (var i=0; i<elms.length; i++) {
			if (elms[i].type == "checkbox" && elms[i].name.indexOf (elm.name) == 0) {
				elms[i].checked = elm.checked;
			}
		}
	},
	whenSrchFocus : function (obj, lvS) { // 검색값이 입력되는 필드들에 Focus가 왔을 때 조치.
		if (obj.value == lvS) obj.value = "";
	},
	whenSrchBlur : function (obj, lvS ) { // 설명 : 검색값이 입력되는 필드들에서 Focus가 떠날 때 조치.
		if (obj.value == "") obj.value = lvS;
	},
	activeLine : function (obj, bool) {
		var e = obj.childNodes;
		var len = e.length;
		var selectStyle = "1px slategray solid";
		var normalStyle = "1px #CACACA solid";
		if (len > 0) {
			if (bool) { // OnMouseOver!
				for(var i=0; i < len ; i++) {
					$(e[i]).css("borderTop",selectStyle);    
					$(e[i]).css("borderBottom",selectStyle);
					$(e[i]).css("cursor","default");
				}
				$(e[0]).css("borderLeft",selectStyle);
				$(e[len-1]).css("borderRight",selectStyle);
			} else { // OnMouseOut!
				for(var i=0; i < len; i++) {
					$(e[i]).css("borderTop",normalStyle);    
					$(e[i]).css("borderBottom","");
				}
				$(e[0]).css("borderLeft","");
				$(e[len-1]).css("borderRight","");
			}
		}
		return true;
	},
	selectLine : function (obj, bgCol, bool) {
		var e = obj.childNodes;
		var len = e.length;
		if (len > 0) {
			if (bool) { // OnMouseOver!
				for(var i=0; i<len; i++) {
					$(e[i]).css("backgroundColor",bgCol);    
				}
			} else { // OnMouseOut!
				for(var i=0; i<len; i++) {
					$(e[i]).css("backgroundColor",bgCol);    
				}
			}
		}
		return true;
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// List 화면에서 특정 <tr> 영역을 선택했을 때 해당 <tr>의 색깔을 바꾸어 선택됐음을 표시해준다.
	// 범용 포맷으로 다시 작성한 것. 2008.03.14.KWShin.Saltware.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	selectTr : function (prefix, index) {
		var elmTrIndex = document.getElementById(prefix+"Index");
		var oldTrIndex = elmTrIndex.value;
		var curTrIndex = index;
		
		elmTrIndex.value = curTrIndex;
		
		if (oldTrIndex != null && oldTrIndex != "" ) {
			var oldTr  = document.getElementById(""+prefix+oldTrIndex);
			var oldTds = oldTr.getElementsByTagName("td");
			var oldLen = oldTds.length;
			var colorVal = "";
			if (oldTrIndex % 2 == 1) colorVal = ""; 
			else                     colorVal = "#FCFCFE";
			for (var i=0; i<oldLen; i++)
				oldTds[i].style.backgroundColor = colorVal;
		}

		var curTr  = document.getElementById(""+prefix+curTrIndex);
		var curTds = curTr.getElementsByTagName("td");
		var curLen = curTds.length;
		for (var i=0; i<curLen; i++)
			curTds[i].style.backgroundColor = "#F2E0EB";
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// - Make URL parameter list from the parameterized form.
	// - And, encode the URL.
	// 2007.12.26. KWShin. Saltware.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	completeParam : function(frm, param) {
		
		var qStr = param;
		if (frm != null) {
			for (var i=0; i<frm.elements.length; i++) {
				if (frm.elements[i].type == "radio" || frm.elements[i].type == "checkbox") {
					if (frm.elements[i].checked) qStr += "&" + frm.elements[i].name + "=" + frm.elements[i].value;
				} else if( frm.elements[i].type == "select-one" || frm.elements[i].type == "select-multiple") {
					var selectFirst = true;
					for (var j=0; j<frm.elements[i].length; j++) {
						if (frm.elements[i].options[j].selected) {
							if (selectFirst) {
								selectFirst = false;
								qStr += "&" + frm.elements[i].name + "=" + frm.elements[i].options[j].value;
							} else {
								qStr += "," + frm.elements[i].options[j].value;
							}
						}
					}
				} else { 
					qStr += "&" + frm.elements[i].name + "=" + frm.elements[i].value;
				}
			}
		}
		return encodeURI(qStr); 
	},
	getMessage : function() {
		var retMsg = null;
		var arr = arguments;
		if (arr != null && arr.length > 0) {
			if (!portalPage) {
				portalPage = new enview.portal.Page();
			}
			retMsg = portalPage.getMessageResource (arr[0]);
			if( retMsg ==null) {
				return arr[0];
			}
			for (var i=0; i<arr.length; i++) {
				var pattern = "{" + i + "}";
				retMsg = retMsg.replace(pattern, arr[i+1]);
			}
		}
		return retMsg;
	},
	getContextPath : function () {
		if (this.contextPath != null) return this.contextPath;
		var offset = location.href.indexOf(location.host) + location.host.length;
		var uriStr = location.href.substring(offset);
		var pos = 0;
		if ((pos = uriStr.indexOf("/board")) >= 0) {
			this.contextPath = uriStr.substring(0,pos);
		} else if ((pos = uriStr.indexOf("/cafe")) >= 0) {
			this.contextPath = uriStr.substring(0,pos);
		} else if ((pos = uriStr.indexOf("/enboard")) >= 0) {
			this.contextPath = uriStr.substring(0,pos);
		}
		return this.contextPath;
	},
	getAbsLeft : function (elm) {
		var elem = elm;
		if (typeof elem != 'object') elem = document.getElementById(elem); 
		var LEFT = 0; 
		while (elem) { 
			LEFT += elem.offsetLeft; 
			elem = elem.offsetParent; 
		} 
		return LEFT; 
	}, 
	getAbsTop : function (elm) {
		var elem = elm;
		if (typeof elem != 'object') elem = document.getElementById(elem); 
		var TOP = 0; 
		while (elem){ 
			TOP += elem.offsetTop; 
			elem = elem.offsetParent; 
		} 
		return TOP; 
	},
	imageResize : function (elm,w,h) {
		if (navigator.appName.indexOf("Microsoft") == 0) {
			// IE는 이미지 로딩 속도가 느려서 time delay를 약간 주어야 안정적으로 동작한다.
			setTimeout("ebUtil.imageResizeOnIE('"+elm.id+"',"+w+","+h+")", 1);
			return;
		}
		if (elm.width > w || elm.height > h) {
			var scaleX = w / elm.width;
			var scaleY = h / elm.height;
			var scale = scaleX;
			if (scaleX > scaleY) scale = scaleY;
			
			var x = Math.ceil(elm.width  * scale);
			var y = Math.ceil(elm.height  * scale)
			elm.width  = x; // Math.ceil()의 결과값을 바로 할당하면 에러난다!
			elm.height = y; // Math.ceil()의 결과값을 바로 할당하면 에러난다!
		}
	},
	imageResizeOnIE : function (elmId,w,h) {
		var elm = document.getElementById(elmId);
		try {
			if (elm.width > w || elm.height > h) {
				var scaleX = w / elm.width;
				var scaleY = h / elm.height;
				var scale = scaleX;
				if (scaleX > scaleY) scale = scaleY;
				//alert("width=["+elm.width+"],height=["+elm.height+"],scale=["+scale+"],x=["+Math.ceil(elm.width  * scale)+"],y=["+Math.ceil(elm.height  * scale)+"]");
				var x = Math.ceil(elm.width  * scale);
				var y = Math.ceil(elm.height  * scale)
				elm.width  = x; // Math.ceil()의 결과값을 바로 할당하면 에러난다!
				elm.height = y; // Math.ceil()의 결과값을 바로 할당하면 에러난다!
			}
		} catch (e) {
		}
	},
	// 사용자의 행위를 제한하기 위해 event handler 에 함수들을 등록한다.
	eventSet : function (doc) {
		// Exhibt the stroking the key sequence 'Ctrl+C';
		document.onkeydown = function (evt) {
			evt = (evt) ? evt : ((window.event) ? window.event : null);
			if ((evt.ctrlKey) && (evt.keyCode == 67 )) { 
				alert('복사 단축키는 사용하실 수 없습니다.'); 
			} 
		}; 
		// Exhibit the clicking right button of mouse.
		document.oncontextmenu = function () {
			alert('마우스 오른쪽 버튼 사용을 제한하고 있습니다!'); return false;
		};
		document.onselectstart = function () { 
			return false;
		};
	},
	// 사용자의 행위를 제한하기 위해 event handler 에 등록했던 함수들을 제거한다.
	eventReset : function (doc) {
		doc.oncontextmenu      = null;
		doc.onselectstart      = null;
		doc.ondragstart        = null;
		doc.onkeydown          = null;
		doc.onmousedown        = null;
		doc.body.oncontextmenu = null;
		doc.body.onselectstart = null;
		doc.body.ondragstart   = null;
		doc.body.onkeydown     = null; 
		doc.body.onmousedown   = null;
	},
	///////////////////////////////////////////////////////////////////////////////////////////////////
	// loadXMLDoc
	// - retrieve Document using XMLHttpRequest
	// 2007.12.03. KWShin. Saltware.
	///////////////////////////////////////////////////////////////////////////////////////////////////
	loadXMLDoc : function(xmlOrText, reqMethod, svrUrl, queryStr, async, asyncMethod) {
		
		if (svrUrl == null) {
			alert("Can't request to server. URL of servers is null.");
			return;
		}
		
		// 동작하러 가기전에 화면에 있는 메시지를 먼저 삭제한다.
		try {
			document.getElementById("adminErrMsg").innerHTML = "";
		} catch(e) {}
		
		var xmlDoc;
		var req;
		if( window.XMLHttpRequest ) {
			req = new XMLHttpRequest();
			if( async ) {
				req.onload = asyncMethod;
				req.open( reqMethod, svrUrl, true );
				if (reqMethod == "POST") {
					req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 
					req.send(queryStr);
				} else
					req.send( null );
				return;
			} else { 
				req.open( reqMethod, svrUrl, false );
				if (reqMethod == "POST") {
					req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 
					req.send(queryStr);
				} else
					req.send( null );
			}
		} else if( window.ActiveXObject ) {
			req = new ActiveXObject( "Microsoft.XMLHTTP" );
			if( req ) {
				if( async ) {
					req.onload = asyncMethod;
					req.open( reqMethod, svrUrl, true );
					if (reqMethod == "POST") {
						req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 
						req.send(queryStr);
					} else
						req.send( null );
					return;
				} else {
					req.open( reqMethod, svrUrl, false );
					if (reqMethod == "POST") {
						req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"); 
						req.send(queryStr);
					} else
						req.send( null );
				}
			}
		}
		
		if( req ) {
			if( req.status == 200 ) {
				// enBoard의 로그인 화면은 항상 response header에 다음과 같은 데이터를 내려보내준다.
				// XMLHttpRequest로 요청했는데, session time out 등의 이유로 logout 되버리면
				// 이 때 정상적으로 브라우저 화면을 로그인 화면으로 보내기 위함이다. 08.02.28.KWShin.
				var control = req.getResponseHeader("enboard.ajax.control");
				if (control != null  && control.length > 0) {
					if (control == "NEED_ADMIN_LOGIN" || control == "ALERT_ADMIN_LOGIN") {
						var loginUrl = req.getResponseHeader("enboard.ajax.loginUrl");
						if (loginUrl != null && loginUrl.length > 0) {
							parent.window.location = loginUrl;
						} else {
							parent.window.location = "./";
						}
					} else if (control == "ADMIN_ERROR") {
						document.getElementById("adminErrMsg").innerHTML = req.responseText;
						return "ADMIN_ERROR";
					}
				}
				control = req.getResponseHeader ("enview.ajax.control");
				if (control != null && control.length > 0) {
					//alert("control=" + control);
					window.location.href = control;
				}
				if( xmlOrText == "XML" ) {
					xmlDoc = req.responseXML;
					if( xmlDoc && typeof xmlDoc.childNodes != "undefined" && xmlDoc.childNodes.length == 0 ) {
						xmlDoc = null;
					}
				} else {
					xmlDoc = req.responseText;
				}
			} else {
				alert( "There was a problem retrieving the response :\n" + req.status + "[" + req.statusText + "]" );
			}
		} else {
			alert( "Sorry. This browser isn\'t equipped to read response." );
		}
		
		return xmlDoc;
	},
	getAbsPoint : function (elm) {
		var elem = elm;
		var point = ebUtil.getPoint();
	    while (elem) {
			//alert("type=["+elem.nodeName+"],offsetLeft=["+elem.offsetLeft+"],offsetTop=["+elem.offsetTop+"]");
	        point.m_x += elem.offsetLeft;
	        point.m_y += elem.offsetTop;
	        elem = elem.offsetParent;
	    }
		return point;
	},
	getPoint : function (x,y) {
		return new enboard.util.Point (x,y);
	},
	getMLMngr : function () {
		if (this.mlMngr) return this.mlMngr;
		this.mlMngr = new enboard.util.MultiLangMngr();
		return this.mlMngr;
	},
	getPopupDialog : function () {
		if (this.popupDialog) return this.popupDialog;
		this.popupDialog = new enboard.util.PopupDialog();
		return this.popupDialog;
	}
}
enboard.util.Point = function (x,y) {
	this.m_x = (x) ? x : 0;
	this.m_y = (y) ? y : 0;
}
enboard.util.Point.prototype = {
	m_x : 0,
	m_y : 0,
	
	getX : function() {
		return this.m_x;
	},
	getY : function() {
		return this.m_y;
	}
}
enboard.util.MultiLangMngr = function () {}
enboard.util.MultiLangMngr.prototype = {
	m_caller : null,
	m_elmArea : null,
	m_checkedRow : null,
	m_contextPath : null,
	m_ajax : null,
	m_checkBox : null,
	m_tblNm : null,
	m_pk1 : null,
	m_pk2 : null,
	
	doShow : function (caller, elmArea, tblNm, pk1, pk2) {
		this.m_caller = caller;
		this.m_elmArea = document.getElementById(elmArea);
		this.m_contextPath = this.m_caller.m_contextPath;
		this.m_ajax = this.m_caller.m_ajax;
		this.m_checkBox = this.m_caller.m_checkBox;

		this.m_tblNm = tblNm;
		this.m_pk1 = pk1;
		this.m_pk2 = pk2;
		ebUtil.getMLMngr().doGet();

		$("#"+elmArea).dialog({
			autoOpen: false,
			resizable: false,
			modal: true,
			width : 600,
			buttons: {
				Close: function() {
					ebUtil.getMLMngr().m_caller.doDefaultSelect(); // 화면갱신
					$(this).dialog('close');
				}
			}
		});
		$('#'+elmArea).dialog('open');
	},
	doGet : function() {
		var param = "m=uiMultiLangMng";
		param += "&tblNm=" + this.m_tblNm;
		if (this.m_tblNm == "board" || this.m_tblNm == "poll") {
			param += "&boardId=" + this.m_pk1;
		} else if (this.m_tblNm == "bltnCate") {
			param += "&boardId=" + this.m_pk1;
			param += "&bltnCateId=" + this.m_pk2;
		} else if (this.m_tblNm == "bltnExtnProp") {
			param += "&boardId=" + this.m_pk1;
			param += "&fldNm=" + this.m_pk2;
		}
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adBoard.brd", param, true, {success: function(htmlData) { ebUtil.getMLMngr().doGetHandler(htmlData); }});		
	},
	doGetHandler : function (htmlData) {
		this.m_checkedRow = null; // 초기화
		this.m_elmArea.innerHTML = htmlData;
	},
	doSelect : function (idx) {
		this.m_checkedRow = idx;
		var checkedRow = document.getElementById ("multiLang_checkRow_"+this.m_checkedRow);

		this.m_checkBox.unChkAll (document.getElementById("multiLangListForm"));
		checkedRow.checked = true;
		
		document.getElementById("multiLang_act").value = "upd";
		document.getElementById("multiLang_langKnd").value = checkedRow.value;
		document.getElementById("multiLang_langKnd").disabled = true;
		if (this.m_tblNm == "board" || this.m_tblNm == "poll") {
			document.getElementById("multiLang_title1").value = checkedRow.getAttribute("boardNm");
			document.getElementById("multiLang_title2").value = checkedRow.getAttribute("boardTtl");
		} else if (this.m_tblNm == "bltnCate") {
			document.getElementById("multiLang_title1").value = checkedRow.getAttribute("cateNm");
		} else if (this.m_tblNm == "bltnExtnProp") {
			document.getElementById("multiLang_title1").value = checkedRow.getAttribute("title");
		}
		document.getElementById("multiLangEditDiv").style.display = "";
		document.getElementById("multiLang_title1").focus();
	},
	doCreate : function() {
		document.getElementById("multiLang_act").value = "ins";
		document.getElementById("multiLang_langKnd").value = "";
		document.getElementById("multiLang_langKnd").disabled = false;
		document.getElementById("multiLang_title1").value = "";
		if (this.m_tblNm == "board" || this.m_tblNm == "poll") document.getElementById("multiLang_title2").value = "";
		document.getElementById("multiLangEditDiv").style.display = "";
		document.getElementById("multiLang_langKnd").focus();
	},
	doSave : function() {
		var act = document.getElementById("multiLang_act").value;
		
		if ("ins" == act) {
			
			if (!ebUtil.chkSelect (document.getElementById("multiLang_langKnd"), 0, ebUtil.getMessage('eb.info.o.lang'), 'true')) return; 	// 언어를 
		}
		if (this.m_tblNm == "board") {
			if (!ebUtil.chkValue (document.getElementById("multiLang_title1"), ebUtil.getMessage('eb.info.o.boardNm'), 'true')) return; 			// 게시판 명을
			if (!ebUtil.chkValue (document.getElementById("multiLang_title2"), ebUtil.getMessage('eb.info.o.boardTtl'), 'true')) return; 	// 게시판 타이틀을
		} else if (this.m_tblNm == "poll") {
			if (!ebUtil.chkValue (document.getElementById("multiLang_title1"), ebUtil.getMessage('eb.info.o.surveyNm'), 'true')) return; 	//설문 명을
			if (!ebUtil.chkValue (document.getElementById("multiLang_title2"), ebUtil.getMessage('eb.info.o.surveyExp'), 'true')) return; 	//설문 설명을
		} else if (this.m_tblNm == "bltnCate" ) {
			if (!ebUtil.chkValue (document.getElementById("multiLang_title1"), ebUtil.getMessage('eb.info.o.cateNm'), 'true')) return;	// 카테고리 명을
		} else if (this.m_tblNm == "bltnExtnProp" ) {
			if (!ebUtil.chkValue (document.getElementById("multiLang_title1"), ebUtil.getMessage('eb.info.o.title'), 'true')) return; // 확장필드 타이틀을
		}
		
		var param = "m=setMultiLang";
		param += "&act=" + act;
		param += "&tblNm=" + this.m_tblNm;
		param += "&langKnd=" + ebUtil.getSelectedValue (document.getElementById("multiLang_langKnd"));
		if (this.m_tblNm == "board" || this.m_tblNm == "poll") {
			param += "&boardId=" + this.m_pk1;
			param += "&boardNm=" + document.getElementById("multiLang_title1").value;
			param += "&boardTtl=" + document.getElementById("multiLang_title2").value;
		} else if (this.m_tblNm == "bltnCate") {
			param += "&boardId=" + this.m_pk1;
			param += "&bltnCateId=" + this.m_pk2;
			param += "&bltnCateNm=" + document.getElementById("multiLang_title1").value;
		} else if (this.m_tblNm == "bltnExtnProp") {
			param += "&boardId=" + this.m_pk1;
			param += "&fldNm="   + this.m_pk2;
			param += "&title="   + document.getElementById("multiLang_title1").value;
		}
		this.m_ajax.send ("POST", this.m_contextPath+"/board/adBoard.brd", param, true, {success: function(data) { ebUtil.getMLMngr().doSaveHandler(data); }});		
	},
	doDelete : function() {
		if (!ebUtil.chkCheck (document.getElementsByName("multiLang_checkRow"), '언어를', true)) return;
		if (confirm (ebUtil.getMessage("ev.info.remove"))) {
			document.getElementById("multiLang_act").value = "del";
			var param = "m=setMultiLang";
			param += "&act=" + "del";
			param += "&tblNm=" + this.m_tblNm;
			param += "&langKnd=" + ebUtil.getCheckedValues (document.getElementsByName("multiLang_checkRow"));
			if (this.m_tblNm == "board" || this.m_tblNm == "poll") {
				param += "&boardId=" + this.m_pk1;
			} else if (this.m_tblNm == "bltnCate") {
				param += "&boardId=" + this.m_pk1;
				param += "&bltnCateId=" + this.m_pk2;
			} else if (this.m_tblNm == "bltnExtnProp") {
				param += "&boardId=" + this.m_pk1;
				param += "&fldNm=" + this.m_pk2;
			}
			this.m_ajax.send ("POST", this.m_contextPath+"/board/adBoard.brd", param, true, {success: function(data) { ebUtil.getMLMngr().doSaveHandler(data); }});
		}
	},
	doSaveHandler : function (data) {
		var act = document.getElementById("multiLang_act").value;
		if (act == "ins") {
			ebUtil.getMLMngr().m_caller.getMsgBox().doShow (ebUtil.getMessage("ev.info.success.add"));
		} else if (act == "upd") {
			ebUtil.getMLMngr().m_caller.getMsgBox().doShow (ebUtil.getMessage("ev.info.success.update"));
		} else if (act == "del") {
			ebUtil.getMLMngr().m_caller.getMsgBox().doShow (ebUtil.getMessage("ev.info.success.remove"));
		}
		ebUtil.getMLMngr().doGet();
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////
// Definition of object for creating popup-dialog.
// 2007.12.06. KWShin. Saltware.
///////////////////////////////////////////////////////////////////////////////////////////////////
enboard.util.PopupDialog = function() {}
enboard.util.PopupDialog.prototype = {
	mDiv : null,
	mDivWidth : null,
	mDivHeight : null,
	mVeilDiv : null,
	
	init : function (w,h,bg,zi) {
		if (this.mDiv == null) {
			this.mDiv = document.createElement("div");
			if (bg == null) this.mDiv.style.background = "#EEEEEE";
			else            this.mDiv.style.background = bg;
			this.mDiv.style.border = "1px solid #999999";
			this.mDiv.style.position = "absolute";
			document.body.appendChild (this.mDiv);
		}
		if (w != null) {
			this.mDivWidth = w;
			this.mDiv.style.width = w + "px";
		}
		if (h != null) {
			this.mDivHeight = h;
			this.mDiv.style.height = h + "px";
		}
		if (zi == null) this.mDiv.style.zIndex = "999";
		else            this.mDiv.style.zIndex = zi;
		this.mDiv.style.display = "none";
	},
	showUrl : function (evt, url) {
		this.show (evt, ebUtil.loadXMLDoc("TEXT", "GET", encodeURI(url))); 
	},
	show : function (evt, cntt) {
		evt = (evt) ? evt : ((window.event) ? window.event : null);
		
		if( this.mDiv != null ) {
			this.mDiv.innerHTML = cntt;
			if (this.mDivWidth == null) {
				this.mDivWidth = this.mDiv.style.width;
			}
			if (this.mDivHeight == null) {
				this.mDivHeight = this.mDiv.style.height;
			}
			if (document.body.left == undefined) {
				this.mDiv.style.left = (evt.clientX - 10 + document.body.scrollLeft) + 'px';
				this.mDiv.style.top  = (evt.clientY + 10 +  document.body.scrollTop) + 'px';
			} else {
				this.mDiv.style.left = (evt.clientX - 10 + document.body.left) + 'px';
				this.mDiv.style.top  = (evt.clientY + 10 +  document.body.top) + 'px';
			}
			this.mDiv.style.display = "";
		}
	},
	initModal : function (w,h,bg,zi) {
		if (this.mDiv == null) {
			this.mDiv = document.createElement("div");
			if (bg == null) this.mDiv.style.background = "#EEEEEE";
			else            this.mDiv.style.background = bg;
			this.mDiv.style.border = "1px solid #999999";
			this.mDiv.style.position = "absolute";
			document.body.appendChild (this.mDiv);
		}
		if (w != null) {
			this.mDivWidth = w;
			this.mDiv.style.width = w + "px";
		}
		if (h != null) {
			this.mDivHeight = h;
			this.mDiv.style.height = h + "px";
		}
		if (zi == null) this.mDiv.style.zIndex = "999";
		else            this.mDiv.style.zIndex = zi;
		this.mDiv.style.display = "none";

		if (this.mVeilDiv == null) {
			this.mVeilDiv = document.createElement("div");
			this.mVeilDiv.style.background = "#EEEEEE";
			this.mVeilDiv.style.border = "0";
			this.mVeilDiv.style.position = "absolute";
			this.mVeilDiv.style.top = "0px";
			this.mVeilDiv.style.left = "0px";
			
			this.mVeilDiv.style.width = document.body.scrollWidth + "px";
			this.mVeilDiv.style.height = document.body.scrollHeight + "px";
			
			if (zi == null) this.mVeilDiv.style.zIndex = "998";
			else            this.mVeilDiv.style.zIndex = "" + (Number.valueOf(zi) - 1);
			var isIE = (navigator.appName.indexOf("Microsoft") == 0);
			if (isIE) this.mVeilDiv.style.filter = "alpha(opacity=30)";
			else this.mVeilDiv.style.opacity = "0.3";
			this.mVeilDiv.style.display = "none";

			document.body.appendChild (this.mVeilDiv);
		}
	},
	showUrlModal : function (url) {
		this.showModal (ebUtil.loadXMLDoc("TEXT", "GET", encodeURI(url))); 
	},
	showModal : function (cntt,t,l) {
		if (this.mDiv != null) {			

			this.mDiv.innerHTML = cntt;
			
			if (this.mDivWidth == null) {
				this.mDivWidth = this.mDiv.style.width;
			}
			if (this.mDivHeight == null) {
				this.mDivHeight = this.mDiv.style.height;
			}

			var isIE = (navigator.appName.indexOf("Microsoft") == 0);
			var posX = 0, posY = 0;
			if (isIE) {
				posX = (l == null) ? ((document.body.clientWidth - this.mDivWidth)/2 + document.body.scrollLeft) : l;
				posY = (t == null) ? ((document.body.clientHeight - this.mDivHeight)/2 + document.body.scrollTop) : t;
			} else {
				posX = (l == null) ? ((window.innerWidth - this.mDivWidth)/2 + document.body.scrollLeft) : l;
				posY = (t == null) ? ((window.innerHeight - this.mDivHeight)/2 + document.body.scrollTop) : t;
			}
			this.mDiv.style.left = Math.round(posX) + "px";
			this.mDiv.style.top  = Math.round(posY) + "px";
			this.mDiv.style.display = "";
		}
		
		if (this.mVeilDiv != null) {
			this.mVeilDiv.style.display = "block";
		}
	},
	remove : function() {
		if (this.mDiv != null ) { 
			document.body.removeChild (this.mDiv);
			this.mDiv = null;
		}
		if (this.mVeilDiv != null ) {
			document.body.removeChild (this.mVeilDiv);
			this.mVeilDiv = null;
		}
	}
}

var ebUtil = new enboard.util();
//-->