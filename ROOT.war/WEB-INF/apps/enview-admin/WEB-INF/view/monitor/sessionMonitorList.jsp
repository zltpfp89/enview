<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.saltware.enview.session.SessionUserData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/face/css/utility.css">

<%
	Map userInfoMap = (Map)request.getAttribute("userInfoMap");
	List alluser = (List)request.getAttribute("results");
%>

<html>
<head>
<title>Session Infomation</title>
<script language="JavaScript">
	function goMain() {
		location.href = "<util:url view='/monitor/monitorMain.face'/>";
	}
	function goPrev() {
		history.back(-1);
	}
	function doSort(obj, sortColumn)
	{
		location.href = "<%=request.getContextPath()%>/monitor/viewSessionInfo.face?sortColumn=" + sortColumn;
	}
</script>
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#E4E4E4">
  <tr>
    <td align="center" height="30px"><h2>서버 현재 사용자정보</h2></td>
  </tr>
  <tr>
    <td align="center" valign="top"> 
		<div class="webformpanel" style="width:100%;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr> 
					<td colspan="6" class="webformheaderline"></td>
				</tr>
				<tr>
				  <td width="15%" class="webformlabel"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;User ID(user_id)</td>
				  <td class="webformfield" >&nbsp;<%= userInfoMap.get("user_id") %></td>
				  <td width="15%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;이름(nm_kor)</td>
				  <td class="webformfield" >&nbsp;<%= userInfoMap.get("nm_kor") %></td>
				  <td width="15%" class="webformlabelmiddle"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;전체 사용자수</td>
				  <td class="webformfield" >&nbsp;<%= alluser.size() %></td>
				</tr>
				<tr>
				  <td width="15%" class="webformlabel"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;Session ID</td>
				  <td class="webformfield" colspan="6">&nbsp;<%= session.getId() %></td>
				</tr>
				<tr>
				  <td width="15%" class="webformlabel"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">&nbsp;Cookies</td>
				  <td class="webformfield" colspan="6">
					<c:forEach items="${cookies}" var="val">
						&nbsp;<c:out value="${val.name}"/>&nbsp;&nbsp;=&nbsp;&nbsp;<c:out value="${val.value}"/> <br>
					</c:forEach>
				  </td>
				</tr>
				
				<tr> 
					<td colspan="6" class="webformfooterline"></td>
				</tr>
			</table>
		</div>
		<div class="webgridpanel">
			<table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
					<thead>
						<tr> 
							<td colspan="7" class="webgridheaderline"></td>
						</tr>
						<tr style="cursor: pointer;">
							<th class="webgridheader" ch="0" onclick="doSort(this, 'USERID');" >
								<span >사용자ID&nbsp;</span>
							</th>
							<th class="webgridheader" ch="0" onclick="doSort(this, 'USERNAME');" >
								<span >사용자이름&nbsp;</span>
							</th>
							<th class="webgridheader" ch="0" onclick="doSort(this, 'USERIP');" >
								<span >접속 IP 주소&nbsp;</span>
							</th>
							<th class="webgridheader" ch="0" onclick="doSort(this, 'USERAGENT');" >
								<span >사용 브라우저&nbsp;</span>
							</th>
							<th class="webgridheaderlast" ch="0" onclick="doSort(this, 'ELAPSEDTIME');" >
								<span >접속시간&nbsp;</span>
							</th>
						</tr>
					</thead>
					<tbody id="SessionManager.UserListBody">
<%
	Iterator it = alluser.iterator();
	for(int i=0; it.hasNext(); i++) {
		Map userInfo = (Map)it.next(); 
		String view = request.getContextPath() + "/sessionMonitor/detail.admin?sid=" + (String)userInfo.get("sid");
		if( i % 2 == 0 ) { %>
				<tr class="even">
<%		} else {%>		
				<tr class="odd">
<%		} %>		
				  <td style="width:120px" class="webgridbody">&nbsp; 
					<a href="<%=view%>"><%= userInfo.get("user_id") %></a>
				  </td>
				  <td style="width:120px" class="webgridbody">&nbsp;<%= userInfo.get("nm_kor") %> </td>
				  <td style="width:120px" class="webgridbody">&nbsp;<%= userInfo.get("remote_address") %> </td>
				  <td style="width:120px" class="webgridbody">&nbsp;<%= userInfo.get("user-agent") %> </td>
				  <td style="width:120px" class="webgridbody">&nbsp;<%= userInfo.get("session_elapsed") %> </td>
				</tr>
<%	} %>
				</tbody>
			</table>
			<!-- table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="right">
						<button name="" type="reset" class="reset" style="vertical-align: top;" onclick="goMain()"><span>메인화면</span></button>
						<button name="" type="reset" class="reset" style="vertical-align: top;" onclick="goPrev()"><span>이전화면</span></button>
					</td>
				</tr>
			</table-->
		</div>
	</td>
  </tr>
</table>
</body>
</html>

