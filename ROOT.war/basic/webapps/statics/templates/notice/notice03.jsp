<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.saltware.enview.Enview" %>
<%@ page import="com.saltware.enview.session.SessionManager" %>
<%@ page import="com.saltware.enview.notice.Notice" %>
<%@ page import="com.saltware.enview.notice.NoticeManagement" %>
<%@ page import="com.saltware.enview.notice.Notices" %>
<%@page import="org.apache.commons.logging.LogFactory"%>
<%@page import="org.apache.commons.logging.Log"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String notice_id = null;
	String content = null;
	try {
		notice_id = request.getParameter("notice_id");
		SessionManager sm = (SessionManager)Enview.getComponentManager().getComponent("com.saltware.enview.session.SessionManager");
		NoticeManagement noticeManager = (NoticeManagement)Enview.getComponentManager().getComponent("com.saltware.enview.notice.impl.NoticeManager");
		Notices notices = (Notices)Enview.getComponentManager().getComponent("com.saltware.enview.notice.Notices");
		String langKnd = sm.getUserLangKind(request);
		Notice notice = noticeManager.getNotice( notice_id );
		List attachFileList = null;
		if( notice == null ) {
			notice = noticeManager.getNoticeFormDB( notice_id );
		}
		
		if( notice != null ) {
			content = notice.getContent(new Locale(langKnd));
			attachFileList = notice.getAttachFileList();
			request.setAttribute("content", content);
			request.setAttribute("attachFileList", attachFileList);
			
		}
		
		String userid = (String)session.getAttribute("_enpass_id_");
		
	}
	catch(Exception e) {
		Log log = LogFactory.getLog(getClass());
		log.error( e.getMessage(), e);;
	}
	
%>

<html>
<head>
<title>Enview 알림정보</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<script language="JavaScript">
<!--
	function initTemplate() 
	{
		
	}
	
	function setCookie( name, value, expiredays ){ 
		var todayDate = new Date(); 
		todayDate.setDate( todayDate.getDate() + expiredays ); 
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
	} 

	function closeWin()
	{
		if (document.form1.today.checked == true){
			setCookie("ENVIEW_NOTICE_<%= notice_id %>", "no" , 1); 
		} 
		self.close();
	}

	function go()
	{
		opener.location.href=""
		self.close();
	}	

	if (window.attachEvent)
	{
		window.attachEvent ( "onload", initTemplate );
	}
	else if (window.addEventListener )
	{
		window.addEventListener ( "load", initTemplate, false );
	}
	else
	{
		window.onload = initTemplate;
	}
-->
</script>

</head>
<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0">


<!-- 전체 = 340*327 -->
<table width="350" border="0" cellpadding="0" cellspacing="0" bgcolor="#8e8e8e">
  <tr>
 
    <td valign='top' colspan="3">
      <table width='100%' border='0' cellspacing='0' cellpadding='0' height='250'>
        <tr>
          <td height='62' align='center'><img src="images/notice.gif" ></td>
        </tr>
        <tr>
          <td align='center' valign='top'>
            <table border='0' cellspacing='0' cellpadding='0' height='100%'>
              <tr>
                <td width='40' background="images/s_bg_01.gif" >&nbsp;</td>
                <td width='270' valign='top' bgcolor='#EFEFEF' align='center'>
                  <table width='250' border='0' cellspacing='0' cellpadding='5' style="font-size:12;">
                    <tr> <td id="Portal.Enview.NoticeArea"><c:out value="${content}" escapeXml="false"/></td></tr>
                    <c:if test="${not empty attachFileList}">
                    <tr> <td>
                    <c:forEach items="${attachFileList}" var="attachFile">
                    <a href="/attachFile/fileMngr?cmd=down&systemId=notice&fileId=${attachFile.fileId}&fileSeq=${attachFile.fileSeq}" target="download"><c:out value="${attachFile.fileName}"/> (<c:out value="${attachFile.fileSizeSF}"/>)</a>
                    </c:forEach>
                    </td></tr>
                    </c:if>
                  </table>
                </td>
                <td width='40' background="images/s_bg_02.gif" >&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td valign='top' align='center' height='39'><img src="images/down.gif" height='39'></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr bgcolor="#8e8e8e">
  <form id="form1" name="form1" method="post" action="">
    <td width="22" align="right">
      <label>
        <input type="checkbox" name="today" id="checkbox" />
      </label>	</td>
    <td width="267"><img src="images/label01.gif" width="114" height="27" /></td>
    <td width="51">
		<a href="javascript:closeWin()" onFocus="this.blur()">
			<img src="images/btn_close.gif" border="0" align="absmiddle"/>
		</a>
	</td>
    </form>
    <iframe id="download" name="download" frameborder="0" width="0" height="0" ></iframe>
  </tr>
</table>
</body>
</html>