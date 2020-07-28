
//문자열 치환
function str_replace(szFind, szReplace, szAll) {
	var i;
	var length;

	length = szReplace.length - szFind.length;

	for (i=0; i < szAll.length; i++) {
		if (szAll.substr(i,szFind.length) == szFind) {
			if ( i > 0 ) {
				if (szFind == "\n") {
					szAll = szAll.substr(0, i-1) + szReplace + szAll.substr(i+szFind.length,szAll.length - (i+szFind.length));
				} else {
					szAll = szAll.substr(0, i) + szReplace + szAll.substr(i+szFind.length,szAll.length - (i+szFind.length));
				}
			} else { 
				szAll = szReplace + szAll.substr(i+szFind.length,szAll.length - (i+szFind.length));
			}
			i = i + length;
		}
	}
	return szAll;
}

//왼쪽공백제거
function ltrim(str)
{
        var s = new String(str);

        if (s.substr(0,1) == " ")
                return ltrim(s.substr(1));
        else
                return s;
}

//오른쪽공백제거
function rtrim(str)
{
        var s = new String(str);
        if(s.substr(s.length-1,1) == " ")
                return rtrim(s.substring(0, s.length-1));
        else
                return s;
}

//공백제거
function trim(str)
{
        return ltrim(rtrim(str));
}

//전체공백 제거
function allTrim(str){
	return str.replace(/\s*/g,'');
}

//팝업창
function openWin(url,w,h,option){
	var defaultOption = 'width='+w+',height='+h+',resizable=0,scrollbars=0,status=0, menubar=no, toolbar=no';
	
	if(option != null && option != ""){
		defaultOption = 'width='+w+',height='+h+','+option;
	}
	var obj = window.open(url,"",defaultOption);
	return obj;
}

//팝업창 화면 가운데 정렬, Scroll Yes (godbasic, 2010.02.24)
function openWinCenter(url, target, intwidth, intheight, options) {
	var top = 0;
	var left = 0;
	var w_width = intwidth; 	//창 넓이
	var w_height = intheight; 	//창 높이
	var option;
	if(left == 0){
		var x= screen.width/2 - w_width/2; //화면중앙으로위치
		left = x;
	}
	if(top == 0){
		var y= screen.height/2 - w_height/2;
		top = y;
	}
	
	option = "top="+top+",left="+left+",width="+intwidth+",height="+intheight+",resizable=0,scrollbars=1";
	if(options != null && options != ""){
		option = "top="+top+",left="+left+",width="+intwidth+",height="+intheight+","+options;
	}
	
	window.open(url, target, option);
}

//새창
function openSite(url,target){
	window.open(url,target,"resizable=1,scrollbars=1,status=0,menubar=0,toolbar=1");
}

//쿠키셋팅
function setCookie( name, value, expiredays )
{
	var todayDate = new Date();
	todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

//쿠키반환
function getCookie( name )
{
	var nameOfCookie = name + "=";
	var x = 0;
	while ( x <= document.cookie.length )
	{
		var y = (x+nameOfCookie.length);
		if ( document.cookie.substring( x, y ) == nameOfCookie ) {
			if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
				endOfCookie = document.cookie.length;
			return unescape( document.cookie.substring( y, endOfCookie ) );
		}
		x = document.cookie.indexOf( " ", x ) + 1;
		if ( x == 0 )
		break;
	}
	return "";
}

function isNumber(str) 
{
	if(str.search(/\D/) != -1 ) return false;
	return true ; 
} 

/**
* 날짜 체크
*
* @param	date
* @return	boolean
*/
function isDate(date, delimiter)
{
	if (date == null || date == "") {
		return	false;
	}
	
	if (!isNumber(str_replace(delimiter, "", date))) {
		return	false;
	}
	
	var year;
	var month;
	var day;
	
	if(delimiter != null && delimiter != "")
	{
		//alert("1");
		year = eval(date.split(delimiter)[0]);
		month = eval(date.split(delimiter)[1]);
		day = eval(date.split(delimiter)[2]);
	}
	else
	{
		//alert("2");
		year = eval(date.substring(0, 4));
		month = eval(date.substring(4, 6));
		day = eval(date.substring(6, 8));
	}
	
	//alert(year + " " + month + " " + day + " " + delimiter);

	if (month < 1 || month > 12) {
		return	false;
	}

	var totalDays;

	switch (eval(month)){

		case 1 :
			totalDays = 31;
			break;
		case 2 :
			if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0))
				totalDays = 29;
			else
				totalDays = 28;
			break;
		case 3 :
			totalDays = 31;
			break;
		case 4 :
			totalDays = 30;
			break;
		case 5 :
			totalDays = 31;
			break;
		case 6 :
			totalDays = 30;
			break;
		case 7 :
			totalDays = 31;
			break;
		case 8 :
			totalDays = 31;
			break;
		case 9 :
			totalDays = 30;
			break;
		case 10 :
			totalDays = 31;
			break;
		case 11 :
			totalDays = 30;
			break;
		case 12 :
			totalDays = 31;
			break;
	}

	if (day > totalDays) {
		return	false;
	}

	return	true;
}

// ajax result string
function getHttprequestText(URL) { 
	var xmlhttp = null; 
	if(window.XMLHttpRequest) { 
		xmlhttp = new XMLHttpRequest(); 
	} else { 
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); 
	} 
	xmlhttp.open('GET', URL,false); 
	xmlhttp.onreadystatechange = function() { 
		if(xmlhttp.readyState==4 && xmlhttp.status == 200 && xmlhttp.statusText=='OK') { 
			responseText = xmlhttp.responseText; 
		} 
	} 
	xmlhttp.send(''); 

	return responseText = xmlhttp.responseText; 
}

//ajax result xml
function getHttprequestXml(URL) { 
	var xmlhttp = null; 
	if(window.XMLHttpRequest) { 
		xmlhttp = new XMLHttpRequest(); 
	} else { 
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); 
	} 
	xmlhttp.open('GET', URL,false); 
	xmlhttp.onreadystatechange = function() { 
		if(xmlhttp.readyState==4 && xmlhttp.status == 200 && xmlhttp.statusText=='OK') { 
			responseText = xmlhttp.responseText; 
		} 
	} 
	xmlhttp.send(''); 

	return responseXML = xmlhttp.responseXML; 
}


//focus auto move [godbasic, 2010.02.26]
function focusMove(obj, length, nextId){
	if((document.getElementById(objId).value).length == length){
		document.getElementById(nextId).focus();
	}
}

//prototype trim
String.prototype.trim=function(){
	 var str=this.replace(/(\s+$)/g,"");
	 return str;
}

/*
 * 'yyyymmdd' -> 'yyyy-mm-dd'
 * onblur event
 * godbasic, 2010.02.26
 */
function maskOn(objId, flag){
	var len = 0;
	
	if(flag == null) flag = "DAY";
	
	if(flag == "DAY") len = 8;
	else if(flag == "MONTH") len = 6;
	
	var str = (document.getElementById(objId).value).trim();
	if( str != "" && (!isDate(str,"") || str.length != len) ){
		alert("날짜 형식에 맞지 않습니다.");
		document.getElementById(objId).focus();
		return;
	}
	if(flag == "DAY"){
		document.getElementById(objId).value = str.substring(0,4)+"-"+str.substring(4,6)+"-"+str.substring(6,8);
	}else if(flag == "MONTH"){
		document.getElementById(objId).value = str.substring(0,4)+"-"+str.substring(4,6);
	}
}
/*
 * 'yyyy-mm-dd' -> 'yyyymmdd'
 * onfocus event
 * godbasic, 2010.02.26
*/
function maskOff(objId){
	var str = (document.getElementById(objId).value).trim();
	if(str.length == 10){
		document.getElementById(objId).value = str.substring(0,4)+str.substring(5,7)+str.substring(8,10);
	}else if(str.length == 7){
		document.getElementById(objId).value = str.substring(0,4)+str.substring(5,7);		
	}
}

function maskOffRtn(objId){
	var str = (document.getElementById(objId).value).trim();
	if(str.length == 10){
		return str.substring(0,4)+str.substring(5,7)+str.substring(8,10);
	}else if(str.length == 7){
		return str.substring(0,4)+str.substring(5,7);		
	}
}

function calenderMask(str){
	if(str.length == 6){
		return str.substring(0,4) + '-' + str.substring(5,7); 
	}else if(str.length == 6){
		return str.substring(0,4) + '-' + str.substring(5,7) + '-' + str.substring(8,10);
	}
}

/*********************************
 *	폼얻어오기
 *********************************/
function getForm(formNm){
	return eval("document." + formNm);
}

/*********************************
 *	모달리스 창띄우기
 *********************************/
function openModal(url, option, argument){
	return window.showModalDialog(url, argument, option);
}
 
//이미지 크게보기
/*
<a href="javascript:viewLargeImage('largeImageDiv', 'LARGE_IMG', 'IMG_123')"><img id="IMG_123" src="" width="150px" /></a>

<div id="largeImageDiv" style="display:none; position:absolute; left:220px; top:90px; z-index:1;">
	<a href="javascript:" onclick="closeLargeImage('largeImageDiv', 'LARGE_IMG')"><img id="LARGE_IMG" src="" /></a>
</div> 
*/
function viewLargeImage(layerId, desImgId, srcImgId)
{
	var srcImg = document.getElementById(srcImgId);	
	var desLayer = document.getElementById(layerId);
	
	if(srcImg != null)
	{	
		var scrollLeft = (document.documentElement.scrollLeft || document.body.scrollLeft);
		var scrollTop = (document.documentElement.scrollTop || document.body.scrollTop);
		var screenWidth = document.body.clientWidth;
		var screenHeight = document.body.clientHeight;
		var centerX = (screenWidth / 2) + scrollLeft;
		var centerY = (screenHeight / 2) + scrollTop;
		
		var divLeft = 0;;
		var divTop = 0;
		
		var desImg = new Image();		
		desImg.src = srcImg.src;		

		document.getElementById(desImgId).src = desImg.src;
		
		desLayer.style.left = centerX - (desImg.width / 2);
		desLayer.style.top = centerY - (desImg.height / 2);
		desLayer.style.display = "block";
	}	
}

function closeLargeImage(layerId, imgId)
{
	var img = document.getElementById(imgId);
	var desLayer = document.getElementById(layerId);

	img.src = "";
	desLayer.style.display = "none";
}

function autoResizePopup(id, plusX, plusY)
{
	var x = document.getElementById(id).clientWidth + eval(plusX);
	var y = document.getElementById(id).clientHeight + eval(plusY);
	
	window.resizeTo(x, y);
}

//png 파일 투명처리
function setPng24(obj)
{
    obj.width=obj.height=1;
    obj.className=obj.className.replace(/\bpng24\b/i,'');
    obj.style.filter =
    "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+ obj.src +"',sizingMethod='image');"
    obj.src=''; 
    return '';
}

//입력값 Check
function gfn_IsEmpty(obj){
	var nStr = document.getElementById(objId).value;
	if(nStr == null || trim(nStr) == ""){
		return true;
	}
	return false;
}

//날짜 유효성 검사
// if(!fn_ChkDate('시작날짜ID', '종료날짜ID')) return;
function fn_ChkDate(fromDate, toDate){
	if(maskOffRtn(fromDate) > maskOffRtn(toDate)){
		alert("기간 선택이 잘못 되었습니다.");
		return false;
	}
	return true;
}


//============================================================================
//Funciotn Name    :   fnGetIntervalDay(fromtime, totime)
//@ param          :   sFrom Time, To Time
//@ return         :   Interval Day
//설명             :   From, TO 날짜를 입력해 날짜의 Interval Day을 알아본다.
//============================================================================
function fnGetIntervalDay(fromtime, totime)
{
	for ( var i =0; i < 8; i++ )
	{
		if((fromtime.charAt(i) == '.') || (fromtime.charAt(i) ==','))
			return false;
		if((totime.charAt(i) =='.') || (fromtime.charAt(i) == ','))
			return false;
	}

	if ( fromtime.length != 8 || totime.length != 8 )
	{
		return false;
	}

	var year = fromtime.substring(0,4);
	var month = fromtime.substring(4,6);
	var day = fromtime.substring(6,8);
	var year2 = totime.substring(0,4);
	var month2 = totime.substring(4,6);
	var day2 = totime.substring(6,8);

	if(isNaN(year) || isNaN(month) || isNaN(day))
		return false;

	if(isNaN(year2) || isNaN(month2) || isNaN(day2))
		return false;

	if((year <= 0) || (year2 <= 0))
		return false; 

	if((month <= 0  || month > 12) || (month2 <= 0  || month2 > 12))
		return false;

	var strFromYear = fromtime.substring(0,4);
	var strFromMonth = fromtime.substring(4,6);
	var strFromDay = fromtime.substring(6,8);
	var strToYear = totime.substring(0,4);
	var strToMonth = totime.substring(4,6);
	var strToDay = totime.substring(6,8);

	var from_Time = new Date(strFromYear,Number(strFromMonth)-1,strFromDay);
	var to_Time = new Date(strToYear,Number(strToMonth)-1,strToDay);
	var fmillsec = from_Time.getTime();
	var tmillsec = to_Time.getTime();
	var resultday = (tmillsec - fmillsec)/(1000*60*60*24);

//	var absresult = Math.abs(resultday);
	return resultday;
}


// number mask
// EX) OnKeyUp="this.value=number_format(this.value);"
function number_format(num)
{
	num = num.replace(/,/g, "");
	
	var num_str = num.toString();
	var result = "";
	
	for(var i=0; i<num_str.length; i++)
	{
		 var tmp = num_str.length-(i+1);
		
		 if(i%3==0 && i!=0)
		 {
		  result = ',' + result;
		 }
		 result = num_str.charAt(tmp) + result;
	}
	
	return result;

}


function getIEVersion(){
	var TmpIeVersion = navigator.appVersion;
	var IeVersion = null;

	if(TmpIeVersion.indexOf("MSIE 6.0") > -1){
		IeVersion = "IE6";
	}else if(TmpIeVersion.indexOf("MSIE 7.0") > -1){
		IeVersion = "IE7";
	}else if(TmpIeVersion.indexOf("MSIE 8.0") > -1){
		IeVersion = "IE8";
	}else if(TmpIeVersion.indexOf("MSIE 9.0") > -1){
		IeVersion = "IE9";
	}else{
		IeVersion = "ETC";
	}
	
	return IeVersion;
}


function delay(gap){ // millisecs
	var then, now;
	then = new Date().getTime();
	now = then;
	while((now-then) < gap){
		now = new Date().getTime();
	}
}


//*******************************
// *** 셀렉트박스 선택 되었는지 
// ******************************
function isSelect(sel) {
	if(sel.selectedIndex==0){
		return false;
	}else{
		return true;
	}
}

//*******************************
// *** 라디오버튼 체크 되었는지 
// ******************************
function isRadio(sel) {
	var n=0;
	if(sel.length==undefined){
		if(sel.value) n++;
	}else{
		for(i=0; i<sel.length; i++){
			if(sel[i].checked){
				n++;
			}
		}
	}
	if(n==0){
		return false;
	}else{
		return true;
	}
}

//*******************************
// *** 히든폼에 값이 있는지 
// ******************************
function isHidden(sel) {
	if(!sel.value){
		return false;
	}else{
		return true;
	}
}

//*************************** 
// *** 입력이 되었는지 체크 
// ************************** 
function isInput(obj)
{ 

	if(obj.type=="select-one"){
		if(!isSelect(obj))
		return false;
	}else if(obj.type=="radio" || obj.type==undefined){

		if(!isRadio(obj))
		return false;
	}else if(obj.type=="hidden"){
		if(!isHidden(obj))
		return false;
	}else{
		if(obj.value.length==0 || obj.value=="")
		return false;
	}
	return true; 
} 

//******************************************* 
//*** 값이 같은지 체크 (pwd1/pwd2)
//******************************************* 
function isEqual(obj1,obj2) 
{ 
	if(obj1.value != obj2.value) return false;
	return true; 
} 

//************************************ 
//*** 입력된 문자의 길이가 같은지 체크 
//************************************ 
function isChkLen(obj,len)
{ 
	if(obj.value.length != len)  return false;
	return true 
} 

//*********************************** 
// *** 입력된 문자의 길이 범위를 체크
//*********************************** 
function isBtnLen(obj,len1,len2)
{ 
	if(obj.value.length <len1 && obj.value.length > len2) return false;
	return true ;
} 

//*********************************** 
// *** 입력된 문자의 길이 범위를 err체크  
//*********************************** 
function isBtnLens(obj,len1,len2)
{ 
	if(obj.value.length <len1 || obj.value.length > len2) return false;
	return true ;  
	
} 

//*****************************// 
//*** 숫자만 입력 가능 
//*****************************// 
function isNum(obj) 
{
	if(obj.value.search(/\D/) != -1 ) return false;
	return true ; 
} 

//*****************************// 
//***특수문자 제어 기능 (영문과 숫자만)
//*****************************// 
function isOnlyEng(obj) {
	var inText = obj.value; 
	var ret; 
	for (var i = 0; i < inText.length; i++) { 
		ret = inText.charCodeAt(i); 
		if ((ret > 122) || (ret < 48) || (ret > 57 && ret < 65) || (ret > 90 && ret < 97)) { 
			return false; 
		} 
	} 
	return true; 
} 

//**************************************** 
//*** 입력된 문자열이 주민등록번호인지 체크 
//**************************************** 
function isJuminNum(aNum1, aNum2) 
{ 
	var tot=0, result=0, re=0, se_arg=0; 
	var chk_num=""; 
	var aNum = aNum1 + aNum2; 

	if (aNum.length != 13) 
	{ 
		return false; 
	} 
	else 
	{ 
		for (var i=0; i <12; i++) 
		{ 
			if (isNaN(aNum.substr(i, 1))) 
			return false; 
			se_arg = i; 

			//외국인 인 경우 
			if(i==6) { 
				if (aNum.substr(i, 1) == 7 || aNum.substr(i, 1) == 8 ) 
				return true 
			} 

			if (i >= 8) 
			se_arg = i - 8; 
			tot = tot + Number(aNum.substr(i, 1)) * (se_arg + 2) 
		} 

		if (chk_num != "err") 
		{ 
			re = tot % 11; 
			result = 11 - re; 
			if (result >= 10) result = result - 10; 
			if (result != Number(aNum.substr(12, 1))) return false; 
			if ((Number(aNum.substr(6, 1)) < 1) || (Number(aNum.substr(6, 1)) > 4)) return false; 
		} 
	} 
	return true; 
} 


//*****************************// 
//***이메일이 올바른지 체크 ***// 
//*****************************// 
function chkEmail(obj1,obj2){
	if(!chkInput(obj1,"e-mail을 입력하세요.")) return false;
	if(obj2){
		if(!chkInput(obj2,"e-mail을 입력하세요.")) return false; 
		if(!emailCheck(obj1.value+"@"+obj2.value)){ obj1.focus(); return false; }
	}else{
		if(!emailCheck(obj1.value)){ obj1.focus(); return false; }
	}
	return true; 
}

function emailCheck (emailStr) { 
	// Email check 함수 
	var emailPat=/^(.+)@(.+)$/ 
	var specialChars="\\(\\)<>@,;:\\\\\\\"\\.\\[\\]" 
	var validChars="\[^\\s" + specialChars + "\]" 
	var firstChars=validChars 
	var quotedUser="(\"[^\"]*\")" 
	var ipDomainPat=/^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/ 
	var atom="(" + firstChars + validChars + "*" + ")" 
	var word="(" + atom + "|" + quotedUser + ")" 
	var userPat=new RegExp("^" + word + "(\\." + word + ")*$") 
	var domainPat=new RegExp("^" + atom + "(\\." + atom +")*$") 


	var matchArray=emailStr.match(emailPat) 
	if (matchArray==null) { 
		//alert("e-mail 주소가 정확하지 않습니다.\n @ 와 . 을 확인하십시오") 
		return false 
	} 
	var user=matchArray[1] 
	var domain=matchArray[2] 

	if (user.match(userPat)==null) { 
		//alert("메일 아이디가 정확한 것 같지 않습니다.") 
		return false 
	} 

	var IPArray=domain.match(ipDomainPat) 
	if (IPArray!=null) { 
		for (var i=1;i<=4;i++) { 
		if (IPArray[i]>255) { 
		//alert("IP가 정확하지 않습니다.") 
		return false 
	} 
	} 
	return true 
	} 

	var domainArray=domain.match(domainPat) 

	if (domainArray==null) { 
		//alert("도메인 이름이 정확한 것 같지 않습니다.") 
		return false 
	} 
	var atomPat=new RegExp(atom,"g") 
	var domArr=domain.match(atomPat) 
	var len=domArr.length 

	if (domArr[domArr.length-1].length<2 || 
		domArr[domArr.length-1].length>3) { 
		//alert("도메인명의 국가코드는 2자보다 크고 3자보다 작아야 합니다.") 
		return false 
	} 

	if (domArr[domArr.length-1].length==2 && len<3) { 
		var errStr="This address ends in two characters, which is a country" 
		errStr+=" code. Country codes must be preceded by " 
		errStr+="a hostname and category (like com, co, pub, pu, etc.)" 
		alert(errStr) 
		return false 
	} 

	if (domArr[domArr.length-1].length==3 && len<2) { 
		//var errStr="이 주소는 호스트명이 일치하지 않습니다." 
		alert(errStr) 
		return false 
	} 
	return true; 
} 

///////////////////////////////////////////////////////////
// 한글인지 체크
function isHangul (obj)
{
	if (obj.type == object) {
		var str = obj.value;
        var retCode=0;
        for(i=0; i<str.length; i++)
        {
                var code = str.charCodeAt(i)
                var ch = str.substr(i,1).toUpperCase()
                code = parseInt(code)

                if((ch<"0" || ch>"9") && (ch<"A" || ch>"Z") && ((code>255) || (code<0)))
                {
                        return true;
                }
        }
        return false;

	} else {
		return isHangul2(obj);
	}
}

// 한글인지 아닌지 구별
function isHangul2(s) 
{
     var len;
     
     len = s.length;

     for (var i = 0; i < len; i++)  {
         if (s.charCodeAt(i) != 32 && (s.charCodeAt(i) < 44032 || s.charCodeAt(i) > 55203))
             return false;
     }
     return true;
}

///////////////////////////////////////////////////////////
// 공백체크      
function isEmpty( str ) {
   for ( var i = 0 ; i < str.length ; i++ )    {
      if ( str.substring( i, i+1 ) == " " )
         return true;
   }
   return false;
}

///////////////////////////////////////////////////////////
// 폼 항목들 입력값 체크 
function chkInput(obj, msg){
	if(!isInput(obj)){
		alert(msg);
		if(obj.type !="radio" && obj.type != undefined && obj.type != "hidden"){
			obj.value="";
			obj.focus();
		}
		return false;
	}
	return true;
}

///////////////////////////////////////////////////////////
// 폼 항목의 숫자 체크
function chkNum(obj,msg) 
{
	if(!chkInput(obj,msg)) return false;
	if(!isNum(obj)){
		alert(msg);
		obj.value="";
		obj.focus();
		return false;		
	}
	return true;
} 

///////////////////////////////////////////////////////////
// 폼 항목 영문/수자 체크
function chkOnlyEng(obj, msg){
	if(!isInput(obj) || !isOnlyEng(obj)){
		alert(msg);
		obj.value="";
		obj.focus();
		return false;
	}
	return true;
}

function chkBtnLen(obj,len1,len2,msg){
	if(!isBtnLen(obj,len1,len)){
		alert(msg);
		obj.value="";
		obj.focus();
	}
}

///////////////////////////////////////////////////////////
// 포커스이동 
function moveFocus(obj1,obj2,movLen){
	movLen = (!movLen) ? 6 : movLen; //  = 6 //포커스이동   ;
	if(obj1.value.length == movLen ) obj2.focus();
}

// 숫자만 입력하게 한다.
// onkeydown="return onlyNumber();"
function onlyNumber() {
	 if ((window.event.keyCode == 8) || (window.event.keyCode == 9) || (window.event.keyCode == 46)) { //백스페이스키와  tab, del키는 먹게한다.
      //window.event.returnValue=true;
	  return true;
	 } else if ((window.event.keyCode >= 96) && (window.event.keyCode <= 105)) { //숫자패드는 먹게 한다.
	 		//window.event.returnValue=true;
			return true;
   } else if( (window.event.keyCode<48) || (window.event.keyCode>57) ) {
     // window.event.returnValue=false;
	  return false;
  }
}

// 숫자 및 '.' 만 입력
function onlyNumberAndDot() {
	 if ((window.event.keyCode == 8) || (window.event.keyCode == 190) || (window.event.keyCode == 9) || (window.event.keyCode == 46)) { //백스페이스키와  '.', tab, del키는 먹게한다.
      window.event.returnValue=true;
	 } else if (((window.event.keyCode >= 96) && (window.event.keyCode <= 105)) || (window.event.keyCode == 110)) { //숫자패드는 먹게 한다.
	 		window.event.returnValue=true;
   } else if( (window.event.keyCode<48) || (window.event.keyCode>57) ) {
      window.event.returnValue=false;
  }
}

// 이미지 파일 여부
function isImageFile(fn) {
	var ext = fn;
	var startIdx = ext.lastIndexOf(".")+1;
	ext = ext.substring(startIdx,ext.length);
	ext = ext.toLowerCase();
	
	if(ext == "jpg" || ext == "jpeg" || ext == "gif" || ext == "bmp" || ext == "png" || ext == "tif") {
		return true; 
	} else {
		return false; 
	}
}

// 공백이 있는지 체크
function checkSpace( str )
{
	return (str.search(/\s/) != -1);
}

// 특수문자 체크
function Check_nonChar(id_text)
{
		var nonchar = '~`!@#$%^&*()-_=+\|<>?,./;:"\\';
		//var nonchar = '`@#$%&\|<>;".,:';

		var i ; 
		for ( i=0; i < id_text.length; i++ )  {
			if( nonchar.indexOf(id_text.substring(i,i+1)) > 0) {
				break ; 
			}
		}
		if ( i != id_text.length ) {
			return false ; 
		}
		else{
			return true ;
		} 

		return false;
}
//특수문자 체크
function Check_Char(id_text, chkNum)
{

	if(chkNum == null || chkNum == ""){
		chkNum = 1;
	}
	var nonchar = '~`!@#$%^&*()-_=+\|<>?,./;:"';
	//var nonchar = '`@#$%&\|<>;".,:';

	var i ; 
	var cnt = 0;
	for ( i=0; i < id_text.length; i++ )  {
		if( nonchar.indexOf(id_text.substring(i,i+1)) > 0) {
			cnt++;
			
			if(cnt > chkNum){
				break ; 
			}
		}
	}
	if ( cnt > chkNum ) {
		return true ; 
	}
	else{
		return false ;
	} 

	return true;
}

//특수문자 체크
function Check_num(id_text)
{
		var nonchar = ',1234567890';
		//var nonchar = '`@#$%&\|<>;".,:';

		var i ; 
		for ( i=0; i < id_text.length; i++ )  {
			if( nonchar.indexOf(id_text.substring(i,i+1)) > 0) {
				break ; 
			}
		}
		if ( i != id_text.length ) {
			return false ; 
		}
		else{
			return true ;
		} 

		return false;
}

//문자열 개수
function LengthCheck(message) {
	var nbytes = 0;

	for (i=0; i<message.length; i++) {
		var ch = message.charAt(i);
		if (escape(ch).length > 4) {
			nbytes += 2;
		} else if (ch != '\r') {
			nbytes++;
		}
	}

	return nbytes;
}

function strCutByte(message, maximum){
	var inc = 0;
	var nbytes = 0;
	var msg = "";
	var msglen = message.length;
	
	for (i=0; i<msglen; i++) {
		var ch = message.charAt(i);
		if (escape(ch).length > 4) {
			inc = 2;
		} else if (ch != '\r') {
			inc = 1;
		}
		if ((nbytes + inc) > maximum) {
			break;
		}
		nbytes += inc;
		msg += ch;
	}

	return msg;
}

///////////////////////////////////////////////////////////////
/**
 * 입력박스의 입력되는 글자byte수를 체크하고 제한한다.
 * @param item   입력박스 이름
 * @param viewId 현재 입력된 글자수를 보여줄 span태그 아이디
 * ex)
 *         현재 <span id='cmntlen' style=''>0</span>byte
 *         <textarea onKeyUp='inputCheckLen(this, "cmntLen", 100)'></textarea>
 */
function inputCheckLen(item, viewId, limit){
	var len = LengthCheck(item.value);
	if(len>limit){
		alert(limit+'byte를 초과할 수 없습니다.');
		item.value = strCutByte(item.value, limit);
	}
	len = LengthCheck(item.value);
	var obj = document.getElementById(viewId);
	obj.innerHTML = len;
}

//한글 정규식 체크
function isKorean(obj){
	check = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힝]/;
	if(check.test(obj.value)) return false;
	else return true;
}

//날짜 입력시 delimiter 생성
function dateFormat(dateObj, delimiter)
{	
	var date = dateObj.value;
	
	if(date == null || date == "") return;
	
	date = str_replace(delimiter, "", date);

	if(!isNumber(date))
	{
		alert("숫자만 입력가능합니다.");
		return;
	}
	
	//년도입력
	if(date.length == 4)
	{
		dateObj.value = date + "" + delimiter;
		return;
	}
	
	//월입력
	if(date.length == 6)
	{
		dateObj.value = date.substring(0, 4) + "" + delimiter + "" + date.substring(4, 6) + "" + delimiter;
		return;
	}
	
	//날짜검사
	if(date.length >= 8)
	{				
		if(!isDate(date, ""))
		{
			alert("올바른 날짜 형식이 아닙니다.");
			return;
		}
	}
	
}

//한글 제외한 몇 개의 조합인지 체크
function cntMix(str){
	var cnt = 0;
	if(str.containSpecial()) cnt++;
	if(str.containNum()) cnt++;
	if(str.containUpperEng()) cnt++;
	if(str.containLowerEng()) cnt++;
	
	return cnt;
}



/*---------------------------------------------------------------------------------*\
 *  각종 체크 함수들
\*---------------------------------------------------------------------------------*/

//-----------------------------------------------------------------------------
// 정규식에 쓰이는 특수문자를 찾아서 이스케이프 한다.
// @return : String
//-----------------------------------------------------------------------------
String.prototype.meta = function() {
    var str = this;
    var result = ""
    for(var i = 0; i < str.length; i++) {
        if((/([\$\(\)\*\+\.\[\]\?\\\^\{\}\|]{1})/).test(str.charAt(i))) {
            result += str.charAt(i).replace((/([\$\(\)\*\+\.\[\]\?\\\^\{\}\|]{1})/), "\\$1");
        }
        else {
            result += str.charAt(i);
        }
    }
    return result;
}

//-----------------------------------------------------------------------------
// 정규식에 쓰이는 특수문자를 찾아서 이스케이프 한다.
// @return : String
//-----------------------------------------------------------------------------
String.prototype.remove = function(pattern) {
    return (pattern == null) ? this : eval("this.replace(/[" + pattern.meta() + "]/g, \"\")");
}

//-----------------------------------------------------------------------------
// 최소 최대 길이인지 검증
// str.isLength(min [,max])
// @return : boolean
//-----------------------------------------------------------------------------
String.prototype.isLength = function() {
    var min = arguments[0];
    var max = arguments[1] ? arguments[1] : null;
    var success = true;
    if(this.length < min) {
        success = false;
    }
    if(max && this.length > max) {
        success = false;
    }
    return success;
}

//-----------------------------------------------------------------------------
// 최소 최대 바이트인지 검증
// str.isByteLength(min [,max])
// @return : boolean
//-----------------------------------------------------------------------------
String.prototype.isByteLength = function() {
    var min = arguments[0];
    var max = arguments[1] ? arguments[1] : null;
    var success = true;
    if(this.byte() < min) {
        success = false;
    }
    if(max && this.byte() > max) {
        success = false;
    }
    return success;
}

//-----------------------------------------------------------------------------
// 공백이나 널인지 확인
// @return : boolean
//-----------------------------------------------------------------------------
String.prototype.isBlank = function() {
    var str = this.trim();
    for(var i = 0; i < str.length; i++) {
        if ((str.charAt(i) != "\t") && (str.charAt(i) != "\n") && (str.charAt(i)!="\r")) {
            return false;
        }
    }
    return true;
}

//-----------------------------------------------------------------------------
//특수문자 포함 여부 체크 - arguments[0] : 추가 허용할 문자들
//arguments[0] : 허용할 문자셋
//@return : boolean
//-----------------------------------------------------------------------------
String.prototype.containSpecial = function() {
	return (/\W|\s/g).test(this.remove(arguments[0])) ? true : false;
}

//-----------------------------------------------------------------------------
//숫자 포함 여부 체크 - arguments[0] : 추가 허용할 문자들
//@return : boolean
//-----------------------------------------------------------------------------
String.prototype.containNum = function() {
	return (/[0-9]/).test(this.remove(arguments[0])) ? true : false;
}

//-----------------------------------------------------------------------------
//영어 대문자 포함 여부 체크 - arguments[0] : 추가 허용할 문자들
//@return : boolean
//-----------------------------------------------------------------------------
String.prototype.containUpperEng = function() {
	return (/[A-Z]/).test(this.remove(arguments[0])) ? true : false;
}

//-----------------------------------------------------------------------------
//영어 소문자 포함 여부 체크 - arguments[0] : 추가 허용할 문자들
//@return : boolean
//-----------------------------------------------------------------------------
String.prototype.containLowerEng = function() {
	return (/[a-z]/).test(this.remove(arguments[0])) ? true : false;
}

//-----------------------------------------------------------------------------
// 숫자로 구성되어 있는지 학인
// arguments[0] : 허용할 문자셋
// @return : boolean
//-----------------------------------------------------------------------------
String.prototype.isNum = function() {
    return (/^[0-9]+$/).test(this.remove(arguments[0])) ? true : false;
}

//-----------------------------------------------------------------------------
// 영어만 허용 - arguments[0] : 추가 허용할 문자들
// @return : boolean
//-----------------------------------------------------------------------------
String.prototype.isEng = function() {
    return (/^[a-zA-Z]+$/).test(this.remove(arguments[0])) ? true : false;
}

//-----------------------------------------------------------------------------
// 숫자와 영어만 허용 - arguments[0] : 추가 허용할 문자들
// @return : boolean
//-----------------------------------------------------------------------------
String.prototype.isEngNum = function() {
    return (/^[0-9a-zA-Z]+$/).test(this.remove(arguments[0])) ? true : false;
}

//-----------------------------------------------------------------------------
// 숫자와 영어만 허용 - arguments[0] : 추가 허용할 문자들
// @return : boolean
//-----------------------------------------------------------------------------
String.prototype.isNumEng = function() {
    return this.isEngNum(arguments[0]);
}

//-----------------------------------------------------------------------------
//숫자와 영어(소문자)만 허용 - arguments[0] : 추가 허용할 문자들
//@return : boolean
//-----------------------------------------------------------------------------
String.prototype.isLowerEngNum = function() {
 return (/^[0-9a-z]+$/).test(this.remove(arguments[0])) ? true : false;
}

//-----------------------------------------------------------------------------
// 아이디 체크 영어(소문자)와 숫자만 체크 첫글자는 영어로 시작 - arguments[0] : 추가 허용할 문자들
// @return : boolean
//-----------------------------------------------------------------------------
String.prototype.isUserid = function() {
    //return (/^[a-zA-z]{1}[0-9a-zA-Z]+$/).test(this.remove(arguments[0])) ? true : false;
	return (/^[a-z]{1}[0-9a-z]+$/).test(this.remove(arguments[0])) ? true : false;
}

//-----------------------------------------------------------------------------
//비밀번호 사용시 동일한 동일한 문자 4회이상 연속입력 체크
//@return : boolean
//-----------------------------------------------------------------------------
String.prototype.isSerialChar = function() {
	
	var flag = false;
	var intCnt = 0;
	  
	for (var intI = 0; intI < this.length-1;intI++) {
		if (this.substring(intI,intI+1) == this.substring(intI+1,intI+2)) {
			if(++intCnt>=3) {
				flag = true;
				intI = this.length;
			}
		}else{
			intCnt = 0;
		}
	}
	return flag;
}

//-----------------------------------------------------------------------------
// 한글 체크 - arguments[0] : 추가 허용할 문자들
// @return : boolean
//-----------------------------------------------------------------------------
String.prototype.isKor = function() {
    return (/^[가-힣]+$/).test(this.remove(arguments[0])) ? true : false;
}

//-----------------------------------------------------------------------------
//닉네임 체크 - arguments[0] : 추가 허용할 문자들
//@return : boolean
//-----------------------------------------------------------------------------
String.prototype.isNickname = function() {
 return (/^[가-힣0-9a-zA-Z]+$/).test(this.remove(arguments[0])) ? true : false;
}

//-----------------------------------------------------------------------------
// 주민번호 체크 - arguments[0] : 주민번호 구분자
// XXXXXX-XXXXXXX
// @return : boolean
//-----------------------------------------------------------------------------
String.prototype.isJumin = function() {
    var arg = arguments[0] ? arguments[0] : "";
    var jumin = eval("this.match(/[0-9]{2}[01]{1}[0-9]{1}[0123]{1}[0-9]{1}" + arg + "[1234]{1}[0-9]{6}$/)");
    if(jumin == null) {
        return false;
    } else {
        jumin = jumin.toString().num().toString();
    }

    // 생년월일 체크
    var birthYY = (parseInt(jumin.charAt(6)) == (1 ||2)) ? "19" : "20";
    birthYY += jumin.substr(0, 2);
    var birthMM = jumin.substr(2, 2) - 1;
    var birthDD = jumin.substr(4, 2);
    var birthDay = new Date(birthYY, birthMM, birthDD);
    if(birthDay.getYear() % 100 != jumin.substr(0,2) || birthDay.getMonth() != birthMM || birthDay.getDate() != birthDD) {
        return false;
    }      

    var sum = 0;
    var num = [2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5];
    var last = parseInt(jumin.charAt(12));
    for(var i = 0; i < 12; i++) {
        sum += parseInt(jumin.charAt(i)) * num[i];
    }
    return ((11 - sum % 11) % 10 == last) ? true : false;
}

//-----------------------------------------------------------------------------
// 외국인 등록번호 체크 - arguments[0] : 등록번호 구분자
// XXXXXX-XXXXXXX
// @return : boolean
//-----------------------------------------------------------------------------
String.prototype.isForeign = function() {
    var arg = arguments[0] ? arguments[0] : "";
    var jumin = eval("this.match(/[0-9]{2}[01]{1}[0-9]{1}[0123]{1}[0-9]{1}" + arg + "[5678]{1}[0-9]{1}[02468]{1}[0-9]{2}[6789]{1}[0-9]{1}$/)");
    if(jumin == null) {
        return false;
    }
    else {
        jumin = jumin.toString().num().toString();
    }
    // 생년월일 체크
    var birthYY = (parseInt(jumin.charAt(6)) == (5 || 6)) ? "19" : "20";
    birthYY += jumin.substr(0, 2);
    var birthMM = jumin.substr(2, 2) - 1;
    var birthDD = jumin.substr(4, 2);
    var birthDay = new Date(birthYY, birthMM, birthDD);
    if(birthDay.getYear() % 100 != jumin.substr(0,2) || birthDay.getMonth() != birthMM || birthDay.getDate() != birthDD) {
        return false;
    }
    if((parseInt(jumin.charAt(7)) * 10 + parseInt(jumin.charAt(8))) % 2 != 0) {
        return false;
    }
    var sum = 0;
    var num = [2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5];
    var last = parseInt(jumin.charAt(12));
    for(var i = 0; i < 12; i++) {
        sum += parseInt(jumin.charAt(i)) * num[i];
    }
    return (((11 - sum % 11) % 10) + 2 == last) ? true : false;
}  

//-----------------------------------------------------------------------------
// 사업자번호 체크 - arguments[0] : 등록번호 구분자
// XX-XXX-XXXXX
// @return : boolean
//-----------------------------------------------------------------------------
String.prototype.isBiznum = function() {
    var arg = arguments[0] ? arguments[0] : "";
    var biznum = eval("this.match(/[0-9]{3}" + arg + "[0-9]{2}" + arg + "[0-9]{5}$/)");
    if(biznum == null) {
        return false;
    }
    else {
        biznum = biznum.toString().num().toString();
    }

    var sum = parseInt(biznum.charAt(0));
    var num = [0, 3, 7, 1, 3, 7, 1, 3];
    for(var i = 1; i < 8; i++) sum += (parseInt(biznum.charAt(i)) * num[i]) % 10;
    sum += Math.floor(parseInt(parseInt(biznum.charAt(8))) * 5 / 10);
    sum += (parseInt(biznum.charAt(8)) * 5) % 10 + parseInt(biznum.charAt(9));
    return (sum % 10 == 0) ? true : false;
}

//-----------------------------------------------------------------------------
// 법인 등록번호 체크 - arguments[0] : 등록번호 구분자
// XXXXXX-XXXXXXX
// @return : boolean
//-----------------------------------------------------------------------------
String.prototype.isCorpnum = function() {
    var arg = arguments[0] ? arguments[0] : "";
    var corpnum = eval("this.match(/[0-9]{6}" + arg + "[0-9]{7}$/)");
    if(corpnum == null) {
        return false;
    }
    else {
        corpnum = corpnum.toString().num().toString();
    }
    var sum = 0;
    var num = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2]
    var last = parseInt(corpnum.charAt(12));
    for(var i = 0; i < 12; i++) {
        sum += parseInt(corpnum.charAt(i)) * num[i];
    }
    return ((10 - sum % 10) % 10 == last) ? true : false;
}

//-----------------------------------------------------------------------------
// 이메일의 유효성을 체크
// @return : boolean
//-----------------------------------------------------------------------------
String.prototype.isEmail = function() {
    return (/\w+([-+.]\w+)*@\w+([-.]\w+)*\.[a-zA-Z]{2,4}$/).test(this.trim());
}

//-----------------------------------------------------------------------------
// 전화번호 체크 - arguments[0] : 전화번호 구분자
// @return : boolean
//-----------------------------------------------------------------------------
String.prototype.isPhone = function() {
    var arg = arguments[0] ? arguments[0] : "";
    return eval("(/(02|0[3-9]{1}[0-9]{1})" + arg + "[1-9]{1}[0-9]{2,3}" + arg + "[0-9]{4}$/).test(this)");
}

//-----------------------------------------------------------------------------
// 핸드폰번호 체크 - arguments[0] : 핸드폰 구분자
// @return : boolean
//-----------------------------------------------------------------------------
String.prototype.isMobile = function() {
    var arg = arguments[0] ? arguments[0] : "";
    return eval("(/01[016789]" + arg + "[1-9]{1}[0-9]{2,3}" + arg + "[0-9]{4}$/).test(this)");
}

