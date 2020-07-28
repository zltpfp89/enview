<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.saltware.enview.login.LoginConstants" %>
<%@ page import="com.saltware.enview.Enview" %>
<%@ page import="com.saltware.enview.security.UserManager" %>
<%
	String id = "";
	String pass = "";
	String isStudent = null;
	Map userInfoMap = null;
	String next = "";
	
	String errorCode = request.getParameter("epErrCode");
	System.out.println("########## errorCode=" + errorCode);
	if( errorCode != null ) {
		//request.getSession().setAttribute("com.saltware.enview.login.errorcode", errorCode);
		String destination = request.getContextPath() + "/portal/login.psml" + "?errorCode=" + errorCode;
		response.sendRedirect( response.encodeURL(destination) );
	}
	
	String userId = (String)request.getSession().getAttribute(LoginConstants.SSO_LOGIN_ID);
	if( userInfoMap == null ) {
		// �Ʒ� 0630 ��������
		//UserManager um = (UserManager)Enview.getComponentManager().getComponent("com.saltware.enview.security.UserManager");
		//userInfoMap = um.getUserInfomation( userId );
		//request.getSession().setAttribute(LoginConstants.SSO_LOGIN_INFO, userInfoMap);
// �Ʒ� 0630 ����
		  UserManager um = (UserManager)Enview.getComponentManager().getComponent("com.saltware.enview.security.UserManager");
		  userInfoMap = um.getUserInfomation( userId );
		  
		  request.getSession().setAttribute(LoginConstants.SSO_LOGIN_INFO, userInfoMap);

		  if ("Y".equals(userInfoMap.get("ID_YN")) ||"Y".equals(userInfoMap.get("PWD_YN")) ||"Y".equals(userInfoMap.get("E_MAIL_YN")) )
		  // �Ʒ� ��ũ��Ʈ�� �̵���
		  // response.sendRedirect( response.encodeRedirectURL("http://nds.dit.ac.kr/cmn/changeId.jsp?portal_yn=Y") );
			 next = "true" ;
	}
	
	System.out.println("########################### waiting.jsp userInfoMap=" + userInfoMap);
	if( userInfoMap != null ) {
		String email = (String)userInfoMap.get("email_addr");
		id = (String)userInfoMap.get("emp_no");
		String type_cd = (String)userInfoMap.get("type_cd");
		//if( email == null || "DIT".equals(type_cd) == false ) {
		if( "DIT".equals(type_cd) == false ) {
			//id = "xeon";
			//pass = "22";
		}
		else {
			//id = email.substring(0, email.indexOf("@"));
			pass = (String)userInfoMap.get("password");
			List groups = (List)userInfoMap.get("groups");
			
			if( groups != null ) {
				String group = (String)groups.get(0);
				if( group != null && (group.equals("hakboo")||group.equals("hakboo3")||group.equals("sigan")||group.equals("sigan3")||group.equals("oirae")||group.equals("admin"))) {
					isStudent = "true";
				}
			}
		}
	}
%>

<HTML>
<HEAD><TITLE>NeoWebLoader Demo</TITLE>
<script type="text/javascript" src="/enview/javascript/common.js"></script>
<SCRIPT language=javascript>
  //BEGIN: 2008.05.17.KWShin.Saltware
  //set window.name for controlling popup windows.
  window.top.name = "enview";
  //End: 2008.05.17.KWShin.Saltware

function invokeNextProcess() {
	window.location.href = "http://portal.dit.ac.kr/enview/";
}

function init() {
	//alert("id=" + "<%=id%>" + ", pass=" + "<%=pass%>" + ", isStudent=" + "<%=isStudent%>");
	//alert("<%=userInfoMap.get("PWD_YN")%>");


				if("<%=userId %>" == "admin") {
					window.location.href = "http://portal.dit.ac.kr/enview/";

				}else{
					if( "<%=isStudent%>" == "null" ) {
						//alert("this is staff");
						parent.loginGroupware("<%=id%>", "<%=pass%>");
						// �Ʒ����� 0703
						//setTimeout(1000);
						if("<%=next%>" == "true")  {
						parent.location.href = "http://nds.dit.ac.kr/cmn/changeId.jsp?portal_yn=Y";
						}
					}else {
						//alert("this is student");
						// �Ʒ� ���� 0703 window.location.href = "http://portal.dit.ac.kr/enview/"
						if("<%=next%>" == "true") { 
							parent.location.href = "http://nds.dit.ac.kr/cmn/changeId.jsp?portal_yn=Y";
						}else{
							window.location.href = "http://portal.dit.ac.kr/enview/";
						}
					}
				}
}

</SCRIPT>
</HEAD>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="init()">

<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr>
    <td align="center">
      <table width="398" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="/enview/images/img_loading.gif" width="398" height="180"></td>
        </tr>
        <tr> 
          <td><img src="/enview/images/img_loading_bu.gif" width="398" height="43" onclick="javascript:invokeNextProcess()"></td>
        </tr>
        <tr>
          <td height="30">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>

</body>
</HTML>




