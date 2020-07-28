<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.saltware.enview.login.LoginConstants" %>
<%@ page import="com.saltware.enview.Enview" %>
<%@ page import="com.saltware.enview.security.UserManager" %>
<%@ page import="com.saltware.enview.code.EnviewCodeManager" %>
<%@ page import="com.saltware.enview.codebase.Codebase" %>
<%@ page import="com.saltware.enview.codebase.CodeBundle" %>
<%@ page import="com.saltware.enview.multiresource.EnviewMultiResourceManager" %>
<%@ page import="com.saltware.enview.multiresource.MultiResourceBundle" %>

<%
	String langKnd = request.getLocale().getLanguage();
	CodeBundle codes = EnviewCodeManager.getInstance().getBundle( request );
	MultiResourceBundle messages = EnviewMultiResourceManager.getInstance().getBundle( request );
	String loginUrl = Enview.getConfiguration().getString("sso.login.destination");
	String destination = request.getParameter("com.saltware.enview.login.destination");
	if( destination != null && destination.length()>0 ) {
		loginUrl += "?com.saltware.enview.login.destination=" + destination;
	}
	System.out.println("### destination=" + destination + ", loginUrl=" + loginUrl);
	String errorCode = request.getParameter("errorCode");
	String errorPage = (String)session.getAttribute("ACCESS_ERROR_PAGE");
	String errorMessage = "";
	if( "1".equals(errorCode) ) {
		errorMessage = messages.getString("ev.error.user.ErrorCode.1"); //"유효하지 않은 사용자명입니다.";
	}
	else if( "2".equals(errorCode) ) {
		errorMessage =  messages.getString("ev.error.user.ErrorCode.2"); //"유효하지 않은 비밀번호입니다.";
	}
	else if( "3".equals(errorCode) ) {
		errorMessage =  messages.getString("ev.error.user.ErrorCode.3"); //"이 사용자 계정은 현재 비활성화되어 있습니다. 관리자에게 문의하시기 바랍니다.";
	}
	else if( errorPage != null ) {
		errorMessage = messages.getString("ev.error.user.ErrorCode.98"); //"이 페이지는 접근할 수 없는 페이지입니다.";
	}
	else if( "99".equals(errorCode) ) {
		errorMessage =  messages.getString("ev.error.user.ErrorCode.99"); //"접근이 차단된 주소입니다. 관리자에게 문의하시기 바랍니다.";
	}
	else if( "100".equals(errorCode) ) {
		errorMessage =  messages.getString("ev.error.user.ErrorCode.100"); //"알수 없는 오류가 발생했습니다. 관리자에게 문의하시기 바랍니다.";
	}
	
	String saveStr = messages.getString("ev.title.user.SaveID");
	String useLangStr = messages.getString("ev.property.langKnd");
	String optionStr = "";
	List codeList = (List)codes.getCodes("PT", "105", 1, true);
	for(Iterator it=codeList.iterator(); it.hasNext(); ) {
		Codebase code = (Codebase)it.next();
		optionStr += "<option value=\"" + code.getCode() + "\">" + code.getCodeName() + "</option>";
	}
	
	System.out.println("### errorCode=" + errorCode + ", errorMessage=" + errorMessage);
%>

<html>
  <head>
    <title></title>
    <meta http-equiv="Content-type" content="text/html" />
    <meta http-equiv="Content-style-type" content="text/css" />
    <meta name="version" content="3.21" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
	
	<link rel="stylesheet" href="<%=request.getContextPath()%>/decorations/layout/css/styles.css" type="text/css">
	
	<script language="JavaScript" src="<%=request.getContextPath()%>/javascript/common.js"></script>
	<script language="JavaScript">
		
		function getMovieName(movieName) {
	      if (navigator.appName.indexOf("Microsoft") != -1) {
	        return window[movieName];
	      }
	      else {
	        return document[movieName];
	      }
	    }

		function enviewLogin() {
			var form = document.getElementById("LoginForm");
			var id = form["username"].value;
			var pass = form["password"].value;
			var isSaveLoginID = form["saveLoginID"].checked;
			
			if( id==null || id.length==0 ) {
				alert( "사용자 ID를 입력하시기 바랍니다." );
				form["username"].focus();
				return false;
			}
			else if( pass==null || pass.length==0 ) {
				alert( "비밀번호를 입력하시기 바랍니다." );
				form["password"].focus();
				return false;
			}
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
			
			//form.action = "<%=loginUrl%>";
			form.submit();
			return false;
		}

		function invokeNextProcess() {

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
					
					form["langKnd"].value = "<%= langKnd %>";
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

  <body marginwidth="0" marginheight="0" class="#PageBaseCSSClass()">
	
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr>
    <td align="center"> 
	  <table width="700" border="0" cellspacing="0" cellpadding="0">
		<tr>
          <td width="8"></td>
          <td >
          <!-- BEGIN : flash module for password encoding -->
	          <div>
	          <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="1" height="1" id="top_left_bg" align="middle">
              <param name="allowScriptAccess" value="always" />
              <param name="movie" value="<%=request.getContextPath()%>/decorations/layout/images/login/top_left_bg.swf" />
              <embed src="<%=request.getContextPath()%>/decorations/layout/images/login/top_left_bg.swf" width="1" height="1" name="top_left_bg" align="middle" allowScriptAccess="always" swLiveConnect="true"  type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
            </object>
            </div>	
	      <!-- END : flash module for password encoding --></td>
          <td width="8"></td>
        </tr>
	  </table>
      <table width="572" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="<%=request.getContextPath()%>/decorations/layout/images/login/form_01.gif" width="571" height="18"></td>
        </tr>
        <tr> 
          <td> 
            <table width="571" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="19"><img src="<%=request.getContextPath()%>/decorations/layout/images/login/form_02.gif" width="19" height="266"></td> 
                <td width="533" valign="bottom" background="<%=request.getContextPath()%>/decorations/layout/images/login/theme_bg_01.gif"> 
				  <form id="LoginForm" name="LoginForm" method="POST" style="display:inline" action='<%=loginUrl%>' onsubmit="javascript:return enviewLogin();">
					<input type="hidden" name="_enpass_login_" value="submit">
                    <table width="280" border="0" cellspacing="0" cellpadding="0">
					  <tr>
						<td colspan="4" align="center" class="msg-alert"><B>

						</B></td>
					  </tr>
                      <tr> 
                        <td width="50" height="23" align="right">&nbsp;</td> 
                        <td width="80" height="23"><img src="<%=request.getContextPath()%>/decorations/layout/images/login/id.gif" width="94" height="15"></td>
                        <td width="90" height="23"> 
                          <input type="text" name="username" size="15" class="login-input" tabindex="1">
                        </td>
						<td width="82px" align="center"><input type="checkbox" name="saveLoginID" checked value="checkbox" tabindex="3"><%=saveStr%></td>
                        <!--td rowspan="2" height="60"><img src="<%=request.getContextPath()%>/decorations/layout/images/login/bu_login_blue.gif" width="73" height="56"></td-->
                      </tr>
                      <tr> 
                        <td width="50" height="23" align="right">&nbsp;</td>
                        <td width="80" height="23"><img src="<%=request.getContextPath()%>/decorations/layout/images/login/password.gif" width="94" height="15"></td>
                        <td width="90" height="23"> 
                          <input type="password" name="password" size="15" class="login-input" tabindex="2">
                        </td>
						<td align="center"><input type="image" src="<%=request.getContextPath()%>/decorations/layout/images/login/btn_login.gif" style="cursor:hand" tabindex="4"/></td>
                      </tr>
					  <tr> 
                        <td width="50" height="23" align="right">&nbsp;</td>
                        <td width="80" height="23">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= useLangStr %></td>
                        <td width="90" height="23"> 
							<select name="langKnd" class='webdropdownlist'>
								<%= optionStr %>
							</select>
                        </td>
						<td align="center"></td>
                      </tr>
					  <tr>
						<td colspan="4">&nbsp;</td>
					  </tr>
                    </table>
                  </form>
                </td>
                <td width="19"><img src="<%=request.getContextPath()%>/decorations/layout/images/login/form_03.gif" width="19" height="266"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td><img src="<%=request.getContextPath()%>/decorations/layout/images/login/form_04.gif" width="571" height="19"></td>
        </tr>
        <tr>
          <td align="center" height="50"><img src="<%=request.getContextPath()%>/decorations/layout/images/login/copyright.gif" width="402" height="38"></td>
        </tr>
      </table>
      <p class="b2c_price">&nbsp;</p>
    </td>
  </tr>
</table>

</body>
</html>