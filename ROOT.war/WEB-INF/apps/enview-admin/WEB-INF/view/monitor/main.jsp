<%@ page contentType="text/html; charset=UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/face/css/utility.css">

<html>
<title>Monitor Main</title>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#E4E4E4">
  <tr>
    <td align="center" height="30px"><h2>모니터링 메인</h2></td>
  </tr>
  <tr>
    <td align="center"> 
		<div class="webformpanel" style="width:100%;">
			<table width="600px" border="0" cellspacing="0" cellpadding="0" >
				<tr> 
					<td colspan="6" class="webformheaderline"></td>
				</tr>
				<tr>
				  <td class="webformlabel" align="center"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">
					<a href="<util:url view='/monitor/viewSessionInfo.face'/>">전체 접속 사용자 보기</a>
				  </td>
				  <td class="webformlabel" align="center"><img src="<%=request.getContextPath()%>/face/images/util/tb_icon.gif" width="5" height="5" align="absmiddle">
					<a href="<util:url view='/monitor/viewUserInfo.face'/>">현재 접속 사용자 정보 보기</a>
				  </td>
				</tr>
				<tr> 
					<td colspan="6" class="webformfooterline"></td>
				</tr>
			</table>
		</div>
	</td>
  </tr>
</table>
</body>
</html>

