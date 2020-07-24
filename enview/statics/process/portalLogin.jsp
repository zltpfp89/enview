<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.saltware.enview.login.LoginConstants" %>
<%@ page import="com.saltware.enview.Enview" %>
<%@ page import="com.saltware.enview.security.UserManager" %>

<%
	String loginUrl = Enview.getConfiguration().getString("sso.login.destination");
	String errorCode = request.getParameter("errorCode");
	String errorMessage = "";
	if( "1".equals(errorCode) ) {
		errorMessage = "유효하지 않은 사용자명입니다.";
	}
	else if( "2".equals(errorCode) ) {
		errorMessage = "유효하지 않은 비밀번호입니다.";
	}
	else if( "3".equals(errorCode) ) {
		errorMessage = "이 사용자 계정은 현재 비활성화되어 있습니다. 관리자에게 문의하시기 바랍니다.";
	}
	System.out.println("### errorCode=" + errorCode + ", errorMessage=" + errorMessage);

%>

<html>
<head>
<title>전북대포털 로그인</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-style-type" content="text/css" />
<meta http=equiv="page-enter" content="blendTrans(duration=0.3)">
<meta http=equiv="page-exit" content="blendTrans(duration=0.3)">
<meta name="version" content="3.21" />
<meta name="keywords" content="" />
<meta name="description" content="" />

<link rel="stylesheet" href="http://portal.jbnu.ac.kr/enview/css/crefun_login.css" />

<script type="text/javascript" src="/enview/javascript/messageResource_ko.js"></script>
<script type="text/javascript" src="/enview/javascript/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/enview/javascript/test.js"></script>
<script type="text/javascript" src="/enview/javascript/common.js"></script>
<script type="text/javascript" src="/enview/javascript/portal.js"></script>
<script type="text/javascript" src="/enview/javascript/utility.js"></script>
<script src="/enview/javascript/swfobject_modified.js" type="text/javascript"></script>
<script language="JavaScript">

function poplogin(){
	TaskFrame.location.href = "http://portal.jbnu.ac.kr/enview/sg/LoginForm_gpki.jsp" ;
}

var ajax = new enview.util.Ajax();
var enviewMessageBox = null;
var login_flag = true;
var processReceieveMailSizeHandler = function() {
	this.populate = function(data) 
	{ 
		var url = ajax.retrieveAttributeValue("Item", "url", data);
		var size = ajax.retrieveElementValue("Item", data);

	}
	this.failure = function(msg)
	{
		alert(msg);
	}
}

var emptyHandler = function() {
	this.populate = function(data) 
	{ 

	}
	this.failure = function(msg)
	{
		alert(msg);
	}
}

function getMovieName(movieName) {
  if (navigator.appName.indexOf("Microsoft") != -1) {
	return window[movieName];
  }
  else {
	return document[movieName];
  }
}

function oa_portal_check() {
	window.open('http://portal.jbnu.ac.kr/enface/registry/agree.reg','agree','left=100, top=20, width=500, height=380, toolbar=no, menubar=no, statusbar=no, scrollbars=no, resizable=no');
	return false;
}

jQuery.noConflict();

function enviewLogin1() {
	if (!login_flag) return false;
	var form = document.getElementById("LoginForm");
	var id = form["username"].value;
	var pass = form["password"].value;
	
	if( id==null || id.length==0 ) {
		alert( "아이디를 입력하세요." );
		form["username"].focus();
		return false;
	}
	else if( pass==null || pass.length==0 ) {
		alert( "패스워드를 입력하세요" );
		form["password"].focus();
		return false;
	}
	
	jQuery.post('/enview/statics/agree.jsp', {
	UID: id,
	UPW: pass
	}, function(data) {
		var rstl = data.replace(/^\s*/,'');
		rstl = rstl.replace(/\s*$/,'');
		if (rstl=='1') {
			enviewLogin();
		} else if (rstl=='0') {
			form["password"].value="";
			window.open('http://portal.jbnu.ac.kr/enface/registry/agree.reg','agree','left=100, top=20, width=500, height=380, toolbar=no, menubar=no, statusbar=no, scrollbars=no, resizable=no');
		} else {
			enviewLogin();
		}
	});
	return false;
}

function enviewLogin() {
	var form = document.getElementById("LoginForm");
	var id = form["username"].value;
	var pass = form["password"].value;
	var isSaveLoginID = form["saveLoginID"].checked;
	
	if( id==null || id.length==0 ) {
		alert( "아이디를 입력하세요." );
		form["username"].focus();
		return false;
	}
	else if( pass==null || pass.length==0 ) {
		alert( "패스워드를 입력하세요" );
		form["password"].focus();
		return false;
	}

	/*
	if ( agreeCheck(id, pass) ) {
		alert("true");
		form["password"].value="";
		window.open('http://oas.chonbuk.ac.kr/oa_portal_check.htm','agree','left=100, top=20, width=420, height=250, toolbar=no, menubar=no, statusbar=no, scrollbars=no, resizable=no');
		return false;
	} else {
		alert("false");
		return false;
	}
	*/
	// alert("1 : "+agree(id,pass));

	//alert("form.action=" + form.action + ", id=" + id + ", pass=" + pass + ", isSaveLoginID=" + isSaveLoginID);
	form["password"].value = pass; //getMovieName("top_left_bg").epPassEncode(pass); 
	
	if( isSaveLoginID == true ) {
		var today = new Date();
		var expires = new Date();
		expires.setTime(today.getTime() + 1000*60*60*24*365);
		SetCookie('EnviewLoginID', id+";1", expires, '/');
	}
	else {
		//DeleteCookie('EnviewLoginID', '/');
		var today = new Date();
		var expires = new Date();
		expires.setTime(today.getTime() + 1000*60*60*24*365);
		SetCookie('EnviewLoginID', ";0", expires, '/');
	}
	   
	//alert("action=" + form.action);
	//form.action = "/enview/login/proxy";
	login_flag = false;
	form.submit();
	return false;
}

function invokeNextProcess() {

	//alert("Successfully Groupware Login !!!");
	//ajax.invokeCommon("/dit/static/xmltest.jsp", new processReceieveMailSizeHandler(), "text/xml" );
	//ajax.invokeCommon("/enview/login/logininfo", new emptyHandler(), "text/xml" );
}

function sugang() {
	var popupOptions = "width=750, height=560, menubar=no, toolbar=no, location=no, scrollbars=yes, status=no, resizable=yes"; 
	window.open("http://all.jbnu.ac.kr/sugang/jbnu_registration.html","registration_login","width=1240, height=870, menubar=no, toolbar=no, location=no, scrollbars=yes, status=no, resizable=yes"); 

}

function minstall() {
	TaskFrame.location.href = "http://all.jbnu.ac.kr/mybsvr/Biin/SetupMyBuilder.exe";

}

function manual() {
	TaskFrame.location.href = "http://portal.jbnu.ac.kr/enview/statics/manual_down.jsp" ;
}
 
function iframe_autoresize(arg) {
	arg.height = 0;
	arg.height = eval(arg.name + ".document.body.scrollHeight");
}

function initEnview() {
	var errorCode = "<%= errorCode %>";
	if( errorCode != "null" && errorCode.length > 0 ) {
		alert("<%= errorMessage %>");
	}			

	var form = document.getElementById("LoginForm");
	if( form ) {
		var userinfo = GetCookie('EnviewLoginID');
		if( userinfo ) {
			var userinfoArray = userinfo.split(";");
			//var id = GetCookie('EnviewLoginID');
			//if( id ) {
			if( userinfoArray[0] ) {
				form["username"].value = userinfoArray[0];
				//form["username"].value = id;
				form["password"].focus();
			}
			else {
				form["username"].focus();
			}
			
			if( userinfoArray[1] == "1" ) {
				form["saveLoginID"].checked = true;
			}
			else {
				form["saveLoginID"].checked = false;
			}
		}
	}
	
}

// Attach to the onload event
if (window.attachEvent)
{
	window.attachEvent ( "onload", initEnview );
}
else if (window.addEventListener )
{
	window.addEventListener ( "load", initEnview, false );
}
else
{
	window.onload = initEnview;
}
function hide_layer()
{
	document.getElementById("username_label").style.visibility='hidden';
	document.getElementById("password_label").style.visibility='hidden';
}
function run_layer()
{
	setTimeout("hide_layer()",4000);
}

</script>
</head>

<body>
<div id="wrap">
    <!-- div id="header">
        <h1>스킵네비게이션</h1>
        <div id="accessibility">
            <ul class="skip">
                <li><a href="#login-form"><img src="http://portal.jbnu.ac.kr/enview/images/idx/btn_skiplogin.gif" alt="로그인바로가기(skip to login)"></a></li>
                <li><a href="#container"><img src="http://portal.jbnu.ac.kr/enview/images/idx/btn_skipcont.gif" alt="본문바로가기(skip to content)"></a></li>
            </ul>
        </div>
    </div -->
	<div id="content">
    	<!-- div id="content_left">
        	<img src="/enview/images/login/left_bg.jpg" width="150" height="585" alt="컨텐츠 왼쪽">
        </div -->
        <div id="content_center">
        	<div id="content_menu">
        	  <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="700" height="320" id="FlashID" accesskey="M" tabindex="1" title="전북대포털 메뉴">
        	    <param name="movie" value="/enview/images/login/M_nav.swf">
        	    <param name="quality" value="high">
        	    <param name="wmode" value="transparent">
        	    <param name="swfversion" value="6.0.65.0">
        	    <!-- This param tag prompts users with Flash Player 6.0 r65 and higher to download the latest version of Flash Player. Delete it if you don't want users to see the prompt. -->
        	    <param name="expressinstall" value="/enview/javascript/expressInstall.swf">
        	    <!-- Next object tag is for non-IE browsers. So hide it from IE using IECC. -->
        	    <!--[if !IE]>-->
        	    <object type="application/x-shockwave-flash" data="/enview/images/login/M_nav.swf" width="700" height="320">
        	      <!--<![endif]-->
        	      <param name="quality" value="high">
        	      <param name="wmode" value="transparent">
        	      <param name="swfversion" value="6.0.65.0">
        	      <param name="expressinstall" value="/enview/javascript/expressInstall.swf">
        	      <!-- The browser displays the following alternative content for users with Flash Player 6.0 and older. -->
        	      <div>
        	        <h4>Content on this page requires a newer version of Adobe Flash Player.</h4>
        	        <p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" width="112" height="33" /></a></p>
      	        </div>
        	      <!--[if !IE]>-->
      	      </object>
        	    <!--<![endif]-->
      	    </object>
        	</div>
            <div id="portal_login">
            	<div id="portal_login_title"><img src="/enview/images/login/sub_title_1.jpg" width="351" height="220"></div>
                <div id="portal_login_window">
                	<img src="/enview/images/login/sub_subtitle_1.gif" width="233" height="30">
                	<h2> 로그인 </h2>
                    <form id="LoginForm" name="LoginForm" method="POST" style="display:inline" action='<%=loginUrl%>'
 onSubmit="javascript:return enviewLogin1();" autocomplete=off>
                    <fieldset id="login_page_1">
                    	<legend>포털로그인</legend>
                        <input type="hidden" name="_enpass_login_" value="submit">
                        <dl id="login_form">
                            <dt><label for="username">아이디</label></dt>
                            
                            <dd class="id"><input name="username" type="text" id="username" maxlength="25" class="input_text" title="대표사번 or 학번" accesskey="L" onFocus="this.className='input_text focus';" onMouseOver="hide_layer();" onBlur="if (this.value.length==0) {this.className='input_text';}else {this.className='input_text focusnot';};" onKeyPress="hide_layer();" onClick="hide_layer();"/><div id="username_label">대표사번 or 학번</div></dd>
                            
                            <dt><label for="password">비밀번호</label> </dt>
                            <dd class="pw"><input name="password" type="password" id="password" maxlength="16" class="input_text" title="비밀번호"  onfocus="this.className='input_text focus';" onMouseOver="hide_layer();" onBlur="if (this.value.length==0) {this.className='input_text';}else {this.className='input_text focusnot';};"/><div id="password_label">비밀번호</div></dd>
						</dl>
                        <p id="keeping">
                            <input name="saveLoginID" type="checkbox" value="" id="saveLoginID" class="input_check" /><label for="saveLoginID">ID저장</label> 
                            <input type="image" src="/enview/images/login/login_btn.gif" alt="로그인" class="button" title="전북대포털 로그인">
                        </p>                    
                   	  <div id="sub_form"><a href="#" onKeyPress="javascript:window.open('http://all.jbnu.ac.kr/PswrdSrch_new.html','pass_find','width=520, height=370, left=396, top=360, menubar=no, toolbar=no, location=no, scrollbars=no, status=yes, resizable=no');" onClick="javascript:window.open('http://all.jbnu.ac.kr/PswrdSrch_new.html','pass_find','width=520, height=370, left=396, top=360, menubar=no, toolbar=no, location=no, scrollbars=no, status=yes, resizable=no');"><img src="/enview/images/login//findpw_btn.gif" alt="비밀번호찾기"></a>
                    <a href="#" onKeyPress="javascript:oa_portal_check();" onClick="javascript:oa_portal_check();"><img src="/enview/images/login/agree_btn.gif" alt="포털사용동의"></a>
                   	  </div>
					</fieldset>
                    </form>
                </div>
            </div>
            <div id="cert_login">
            	<div id="cert_login_title"><img src="/enview/images/login/sub_title_2.jpg" width="351" height="220"></div>
<div id="cert_login_window">
                	<img src="/enview/images/login/sub_subtitle_2.gif" width="218" height="30">
                	<h2> 로그인 </h2> 
                	<div id="cert_login_btn">
                    	<a href="#" onKeyPress="poplogin();" onClick="poplogin();"><img src="/enview/images/login/cert_login_btn.gif" width="170" height="30"></a><br>
                        <a href="#" onKeyPress="javascript:window.open('http://portal.jbnu.ac.kr/enface/registry/regpki.reg','_reg','width=500, height=340');" onClick="javascript:window.open('http://portal.jbnu.ac.kr/enface/registry/regpki.reg','_reg_','width=500, height=340');"><img src="/enview/images/login/cert_regist_btn.gif" width="119" height="14"></a>
  					</div>
                    <div id="cert_sub_form">
                    	<img src="/enview/images/login/cert_div.gif" width="281" height="3"><br>
                        <ul>
                        	<li><a href="#" onKeyPress="javascript:window.open('http://portal.jbnu.ac.kr/enface/popup/authorize.html','','left=100, top=20, width=600, height=500, toolbar=no, menubar=no, statusbar=no, scrollbars=yes, resizable=no');" onClick="javascript:window.open('http://portal.jbnu.ac.kr/enface/popup/authorize.html','','left=100, top=20, width=600, height=500, toolbar=no, menubar=no, statusbar=no, scrollbars=yes, resizable=no');">공인인증서가 무엇인가요?</a> | </li>
                            <li><a href="#" onKeyPress="javascript:window.open('http://portal.jbnu.ac.kr/enface/popup/authprocess.html','toy','left=100, top=20, width=620, height=500, toolbar=no, menubar=no, statusbar=no, scrollbars=yes, resizable=no');" onClick="javascript:window.open('http://portal.jbnu.ac.kr/enface/popup/authprocess.html','toy','left=100, top=20, width=620, height=500, toolbar=no, menubar=no, statusbar=no, scrollbars=yes, resizable=no');">인증서 사용절차</a></li>
                        </ul>
		          </div>
              </div>
           </div>
           <div id="oasis_inner_login">
            	<div id="portal_login_title"><img src="/enview/images/login/sub_title_3.jpg" width="351" height="220"></div>
                <div id="portal_login_window">
                	<img src="/enview/images/login/sub_subtitle_1.gif" width="233" height="30">
                    <h2> OASIS 로그인 </h2>
                    <iframe src="https://all.jbnu.ac.kr/portal_login.html" name="oasis_login" style="border:0px; width:310px; height:80px; overflow:hidden; padding:0px; margin:0px;" frameborder="0" scrolling="no"></iframe>
                    <div id="sub_form"><a href="#" onKeyPress="javascript:window.open('http://all.jbnu.ac.kr/PswrdSrch_new.html','pass_find','width=520, height=370, left=396, top=360, menubar=no, toolbar=no, location=no, scrollbars=no, status=yes, resizable=no');" onClick="javascript:window.open('http://all.jbnu.ac.kr/PswrdSrch_new.html','pass_find','width=520, height=370, left=396, top=360, menubar=no, toolbar=no, location=no, scrollbars=no, status=yes, resizable=no');"><img src="/enview/images/login//findpw_btn.gif" alt="비밀번호찾기"></a>
                    </div>
                </div>
            </div>
          </div>
            <div id="content_bottom"><img src="/enview/images/login/main_bottom.jpg" width="700" height="45"></div>
        </div>
    </div>
    <div id="footer">
    	<div id="footer_link">
        	<ul>
            	<li><a href="#" onClick="sugang();" onKeyPress="sugang();"><!-- a href="#" onClick="alert('지금은 수강신청 기간이 아닙니다.');" --><img src="/enview/images/login/sugang_btn.gif" alt="수강신청 페이지 바로가기"></a></li>
                <li><a href="http://fees.jbnu.ac.kr" target="_blank"><img src="/enview/images/login/regist_btn.gif" alt="등록금 고지서 출력 바로가기"></a></li>
            </ul>
        </div>
    	<div id="footer_content">
            <ul>
                <li><a href="#" onClick="minstall();" onKeyPress="minstall();" title="ActiveX 플러그인 설치">ActiveX 설치</a> | </li>
                <li><a href="#" onClick="manual();" onKeyPress="manual();" title="전북대포털 메뉴얼">포털 메뉴얼</a> | </li>
				<li><a href="http://2005.asw.co.kr/client/index.jsp?cpcode=cbnu&autostart=true" target="_blank" title="원격지원요청-담당자와 통화후 이용">원격지원요청</a> | </li>
                <li>로그인 관련문의 : 270-4586</li>
            </ul>
            <address class="addr_copy">
                Copyright &copy; 2010 <strong>Chonbuk National University</strong>. All rights reserved.
            </address>
      </div>
</div>


<IFRAME name="TaskFrame" id="TaskFrame" style="WIDTH: 0px; HEIGHT: 0px;" src="about:blank" frameBorder=0></IFRAME>
<script type="text/javascript">
swfobject.registerObject("FlashID");
function menugoto(mn) {
	switch(mn) {
		case 1:
			document.getElementById("portal_login").style.display = "block";
			document.getElementById("cert_login").style.display = "none";
			document.getElementById("oasis_inner_login").style.display = "none";
			break;
		case 2:
			document.getElementById("portal_login").style.display = "none";
			document.getElementById("cert_login").style.display = "block";
			document.getElementById("oasis_inner_login").style.display = "none";
			break;
		case 3:
			document.getElementById("portal_login").style.display = "none";
			document.getElementById("cert_login").style.display = "none";
			document.getElementById("oasis_inner_login").style.display = "block";
			//location.href("http://all.jbnu.ac.kr/nslogin.html");
			break;
		case 4:
			location.href("http://all.jbnu.ac.kr");
			break;
		default:
			document.getElementById("portal_login").style.display = "block";
			document.getElementById("cert_login").style.display = "none";
			document.getElementById("oasis_inner_login").style.display = "none";
			break;
	}
}
run_layer();
alert("시스템 장애로 인하여 접속이 불안합니다. \n통합정보시스템 이용은 [전북대 메인홈페이지] -> [오아시스]로 이동하여 로그인하여 이용하시기 바랍니다.");
</script>
</body>
</html>