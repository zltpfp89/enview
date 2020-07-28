<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<html lang="ko-KR">
	<head>
		<title>수사정보포털시스템</title>
		<meta http-equiv="Content-type" content="text/html" />  
		<meta http-equiv="Content-style-type" content="text/css" />
		<meta name="version" content="3.2.5" />
		<meta name="keywords" content="" />
		<meta name="description" content="" />
	
		<link rel="stylesheet" href="${pageContext.request.contextPath}/sjpb/css/login.css" type="text/css">
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/common_new.js"></script>
		<script type="text/javascript">
			<!-- iframe 포틀릿의 세션이 끊겼을 때 메인 화면이 로그인 화면으로 팅기게 해주는 로직 :: BEGIN  -->
			var iframes = window.parent.document.getElementsByTagName('iframe');
			if(iframes.length > 0) window.parent.location.href = "${pageContext.request.contextPath}/user/login.face";
			<!-- iframe 포틀릿의 세션이 끊겼을 때 메인 화면이 로그인 화면으로 팅기게 해주는 로직 :: END  -->
			<!-- 팝업창의 세션일 끊겼을 때 메인 화면이 로그인 화면으로 팅기게 해주는 로직 :: BEGIN  -->
			if(window.opener){
				window.opener.location.href = "${pageContext.request.contextPath}/user/login.face";
				self.close();
			}
			<!-- 팝업창의 세션일 끊겼을 때 메인 화면이 로그인 화면으로 팅기게 해주는 로직 :: END  -->
			
			function goJoinPage(){
				location.href="../user/ajaxJoin.face";
			}
		
			function goHelpPage(){
				location.href="../user/help.face";
			}
		
			function getMovieName(movieName) {
				if (navigator.appName.indexOf("Microsoft") != -1) {
					return document[movieName];
					//return window[movieName];
				}
				else {
					return document[movieName];
				}
			}
		
			function enterLogin(event){
				if(event.keyCode == 13){
					enviewLogin();
				}
			}
			
			function enviewLogin() {
				var form = document.getElementById("LoginForm");
				var id = form["userId"].value;
				var pass = form["password"].value;
				var isSaveLoginID = form["saveLoginID"].checked;
				
				var langKnd = form["langKnd"].value;
				if( id == null || id.length == 0 ) {
					alert( "사용자 ID를 입력하시기 바랍니다." );
					form["userId"].focus();
					return false;
				}
				else if( pass == null || pass.length == 0 ) {
					alert( "비밀번호를 입력하시기 바랍니다." );
					form["password"].focus();
					return false;
				}
				//alert("form.action=" + form.action + ", id=" + id + ", pass=" + pass + ", isSaveLoginID=" + isSaveLoginID);
				//form["password"].value = pass;
				try {
					var decodedPass = document["top_left_bg"].epPassEncode(pass);
					//alert("babo=["+babo+"]");
				} catch (e) {
					//alert("error=["+e+"]");
				}
				
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
				form["username"].value = id;
				form.action += "?langKnd=" + langKnd
				form.submit();
				return false;
			}
		
			function invokeNextProcess() {
		
			}
		
			function iframe_autoresize(arg) {
				try {
					var ht = arg.contentWindow.document.documentElement.scrollHeight;
					arg.height = 0;
					arg.height = ht;
				} catch(e) {
					
				}
			}
			
			function initEnview() {
				var errorMessage = "<c:out value="${errorMessage}"/>";
				if( errorMessage != "null" && errorMessage.length > 0 ) {
					alert( errorMessage );
				}
			
				var form = document.getElementById("LoginForm");
				if( form ) {
					var userinfo = GetCookie('EnviewLoginID');
					if( userinfo ) {
						var userinfoArray = userinfo.split(";");
						//var id = GetCookie('EnviewLoginID');
						//if( id ) {
						if( userinfoArray[0] ) {
							form["userId"].value = userinfoArray[0];
							//form["userId"].value = id;
							form["password"].focus();
						}
						else {
							form["userId"].focus();
						}
						
						if( userinfoArray[1] == "1" ) {
							form["saveLoginID"].checked = true;
						}
						else {
							form["saveLoginID"].checked = false;
						}
						
						form["langKnd"].value = "<c:out value="${langKnd}"/>";
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
			
		</script>
	</head>
<body>
<div id="login">
    <!-- wrap -->
	<div class="wrap">
		<h1>&nbsp;&nbsp;</h1>
        <!-- login_all -->
    	<div class="login_all">
			<!-- leftArea -->
           <div class="leftArea">
				<img src="/sjpb/images/left_bg_03.gif" alt="수사정보 포털시스템에 방문하신 것을 환영합니다." />
<!--                 <p class="slogan">수사정보 포털시스템<span>에<br/>방문하신 것을 환영합니다.</span></p> -->
            </div>    
     	   <!-- leftArea //-->
     	   <!-- rightArea //-->
			<div class="rightArea">
				<div class="loginArea">
					<h2><img src="/sjpb/images/login_title.png" alt="login" /></h2>
                    <p class="sub_txt">민생사법경찰단 수사정보 포털서비스는<br /> 로그인 후 이용하실 수 있습니다.</p>
	                <form id="LoginForm" name="LoginForm" method="POST" style="display:inline" action="${pageContext.request.contextPath}<c:out value="${loginUrl}"/>" onkeydown="if(event.keyCode==13) enviewLogin()">
	                	<input type="hidden" name="_enpass_login_" value="submit"/>
	                    <input type="hidden" name="username" />
	                    <input type="hidden" name="langKnd" value="ko"/>
	                	<div class="login_input">
		                    <fieldset>
		                        <p class="uchk"><input type="checkbox" id="saveid" name="saveLoginID" /><label for="saveid">아이디저장</label></p>
		                    	<ul>
		                        	<li><input type="text" id="userId" name="userId" placeholder="아이디를 입력해주세요."/><label for="userId"></label></li>
		                        	<li><input type="password" id="password" name="password" autocomplete="off" placeholder="비밀번호"/><label for="password"></label></li>
		                        </ul>
		                        <a href="javascript:void(0);" class="login_btn" onclick="javascript:enviewLogin()"><span>로그인</span></a>
		                    </fieldset>
	                	</div>
	                 </form>
                 </div>
	            <!-- notice -->
	            <div class="notice">
	            	<h4>안내사항</h4>
	                	<ul>
	                		<li>· 계정 신청 및 비밀번호 재발급은 <span>인사담당자에게 문의</span>하시기 바랍니다.</li>
	                        <li>· <span>허용된 IP에서만 로그인이 가능</span>합니다.</span></li>
	                        <li>· 최초 1번<a href ="/upload/Fasoo_LiveUpdate_Agent_for_SJPB_Server_20181204_v2.01.0001.exe" target="drmLiveAgent"><span style="color: #fd1100;font-weight: 600;"> DRM LiveUpdate Agent</span></a>를 설치 하시기 바랍니다.</li>
	                	</ul>
	            </div> 
	            <!-- notice// -->       
			</div>
	        <!-- rightArea //-->
        </div>
		<!-- login_all -->
    </div>
    <!-- wrap //-->
</div>
<!-- footer -->
<div id="footer">
	<ul>
		<li>서울 중구 삼일대로 231 서울시청 남산별관  전화번호 : 02-2133-8812</li>
        <li>Copyright (c) 2018 Special judicial Police Bureau for Public Safety  All Rights Reserved.</li>    
	</ul>
</div>
<!-- footer// -->
</body>
</html>
<iframe id="drmLiveAgent" name="drmLiveAgent" title="drm" height="0" width="0" ></iframe>