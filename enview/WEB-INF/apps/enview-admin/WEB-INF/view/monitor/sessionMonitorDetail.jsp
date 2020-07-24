<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.saltware.enview.security.EnviewSecurityPermission" %>
<%@ page import="com.saltware.enview.security.DefaultSecurityPermission" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/face/css/utility.css">

<%
	Map userInfoMap = (Map)request.getAttribute("userInfoMap");
	String session_elapsed = ""; 
	if( userInfoMap != null ) {
		String sessionCreate = (String)userInfoMap.get("session_create");
		session_elapsed = String.valueOf( (System.currentTimeMillis()-Long.parseLong(sessionCreate))/1000 );
	}
	else {
		//System.out.println("##################### userInfoMap is null");
		userInfoMap = new HashMap();
	}
	
	EnviewSecurityPermission enviewSecurityPermission = (EnviewSecurityPermission)userInfoMap.get("enviewSecurityPermission");
	DefaultSecurityPermission perm = (DefaultSecurityPermission)enviewSecurityPermission.getSecurityPermission("PT");
%>

<html>
<head>
<title>User Infomation</title>
<script language="JavaScript">
	function goMain() {
		location.href = "<util:url view='/monitor/monitorMain.admin'/>";
	}
	function goPrev() {
		history.back(-1);
	}
	
</script>
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#E4E4E4">
  <tr>
    <td align="center" height="30px"><h2>사용자 세션정보</h2></td>
  </tr>
  <tr>
    <td align="center" valign="top"> 
		<div class="webformpanel" style="width:100%;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr> 
					<td colspan="4" class="webformheaderline"></td>
				</tr>
				<tr>
				  <td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;User ID(user_id)</td>
				  <td class="webformfield" width="30%">&nbsp;<%= userInfoMap.get("user_id") %></td>
				  <td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;이름(nm_kor)</td>
				  <td class="webformfield" width="30%">&nbsp;<%= userInfoMap.get("nm_kor") %></td>
				</tr>
				<tr>
				  <td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;Principal ID(principal_id)</td>
				  <td class="webformfield" width="30%">&nbsp;<%= userInfoMap.get("principal_id") %></td>
				  <td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;사용언어(lang_knd)</td>
				  <td class="webformfield" width="30%">&nbsp;<%= userInfoMap.get("lang_knd") %></td>
				</tr>
				<tr>
				  <td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;Group IDs(groups)</td>
				  <td class="webformfield" width="30%">&nbsp;<%= userInfoMap.get("groups") %></td>
				  <td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;Group PrincipalIDs(groupIds)</td>
				  <td class="webformfield" width="30%">&nbsp;<%= userInfoMap.get("groupPrincipalId") %></td>
				</tr>
				<tr>
				  <td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;Role IDs(roles)</td>
				  <td class="webformfield" width="30%">&nbsp;<%= userInfoMap.get("roles") %></td>
				  <td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;Role PrincipalIDs(roleIds)</td>
				  <td class="webformfield" width="30%">&nbsp;<%= userInfoMap.get("roleIdList") %></td>
				</tr>
				<tr>
				  <td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;Session ID</td>
				  <td class="webformfield">&nbsp;<%= session.getId() %></td>
				  <td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;IP Address(remote_address)</td>
				  <td class="webformfield" width="30%">&nbsp;<%= userInfoMap.get("remote_address") %></td>
				</tr>
				<tr>
				  <td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;사용 브라우저 (user-agent)</td>
				  <td class="webformfield" width="30%">&nbsp;<%= userInfoMap.get("user-agent") %></td>
				  <td width="20%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;접속한 시간(session_create)</td>
				  <td class="webformfield" width="30%">&nbsp;<%= session_elapsed %></td>
				</tr>
				<tr>
				  <td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;Cookies</td>
				  <td class="webformfield" colspan="3">
					<c:forEach items="${cookies}" var="val">
						&nbsp;<c:out value="${val.name}"/>&nbsp;&nbsp;=&nbsp;&nbsp;<c:out value="${val.value}"/> <br>
					</c:forEach>
				  </td>
				</tr>
				
				<tr> 
					<td colspan="4" class="webformfooterline"></td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr> 
					<td colspan="4" class="webgridheaderline"></td>
				</tr>
				<tr>
				  <td width="20%" class="webformlabel" colspan="4" ><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;사용자 퍼미션</td>
				</tr>
				<tr>
				  <td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;허용메뉴</td>
				  <td class="webformfield" colspan="3">&nbsp;
<%					Hashtable allowMenuMap = perm.getAllowMenuMap();
					for(Enumeration e=allowMenuMap.keys(); e.hasMoreElements(); ) { %>
						<%=(String)e.nextElement()%>&nbsp;&nbsp;
<%					} %>
				  </td>
				</tr>
				<tr>
				  <td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;비허용 메뉴</td>
				  <td class="webformfield" colspan="3">&nbsp;
<%					Hashtable denyMenuMap = perm.getDenyMenuMap();
					for(Enumeration e=denyMenuMap.keys(); e.hasMoreElements(); ) { %>
						<%=(String)e.nextElement()%>&nbsp;&nbsp;
<%					} %>
				  </td>
				</tr>
				<tr>
				  <td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;메뉴패턴</td>
				  <td class="webformfield" colspan="3">&nbsp;
					<c:forEach items="${perm.menuPatternList}" var="val">
						<c:out value="${val.pattern}"/> &nbsp;&nbsp;
					</c:forEach>
				  </td>
				</tr>
				<tr>
				  <td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;허용 포틀릿</td>
				  <td class="webformfield" colspan="3">&nbsp;
<%					Hashtable allowPortletMap = perm.getAllowPortletMap();
					for(Enumeration e=allowPortletMap.keys(); e.hasMoreElements(); ) { %>
						<%=(String)e.nextElement()%>&nbsp;&nbsp;
<%					} %>
				  </td>
				</tr>
				<tr>
				  <td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;비허용 포틀릿</td>
				  <td class="webformfield" colspan="3">&nbsp;
<%					Hashtable denyPortletMap = perm.getDenyPortletMap();
					for(Enumeration e=denyPortletMap.keys(); e.hasMoreElements(); ) { %>
						<%=(String)e.nextElement()%>&nbsp;&nbsp;
<%					} %>
				  </td>
				</tr>
				<tr>
				  <td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;포틀릿 패턴</td>
				  <td class="webformfield" colspan="3">&nbsp;
					<c:forEach items="${perm.portletPatternList}" var="val">
						<c:out value="${val.pattern}"/> &nbsp;&nbsp;
					</c:forEach>
				  </td>
				</tr>
				<tr>
				  <td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;허용 기타 URL</td>
				  <td class="webformfield" colspan="3">&nbsp;
<%					Hashtable allowExtraUrlMap = perm.getAllowExtraUrlMap();
					for(Enumeration e=allowExtraUrlMap.keys(); e.hasMoreElements(); ) { %>
						<%=(String)e.nextElement()%>&nbsp;&nbsp;
<%					} %>
				  </td>
				</tr>
				<tr>
				  <td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;비허용 기타 URL</td>
				  <td class="webformfield" colspan="3">&nbsp;
<%					Hashtable denyExtraUrlMap = perm.getDenyExtraUrlMap();
					for(Enumeration e=denyExtraUrlMap.keys(); e.hasMoreElements(); ) { %>
						<%=(String)e.nextElement()%>&nbsp;&nbsp;
<%					} %>
				  </td>
				</tr>
				<tr>
				  <td width="20%" class="webformlabel"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;기타 URL 패턴</td>
				  <td class="webformfield" colspan="3">&nbsp;
					<c:forEach items="${perm.extraUrlPatternList}" var="val">
						<c:out value="${val.pattern}"/> &nbsp;&nbsp;
					</c:forEach>
				  </td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="right">
						<span class="btn_pack small"><a href="<util:url view='/monitor/viewSessionInfo.admin'/>">목록으로</a></span>
					</td>
				</tr>
			</table>
		</div>
	</td>
  </tr>
</table>
</body>
</html>
