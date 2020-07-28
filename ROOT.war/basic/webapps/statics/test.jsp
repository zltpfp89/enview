<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="com.saltware.enview.Enview"%>
<%
	String evcp = Enview.getConfiguration().getString ("portal.contextPath");
%>
<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
<tr>
  <td id="abmLeft" style="width:280px; height:1224px; background:#FFFFFF;" valign="top" class="webpanel"> 
	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
	  <tr>
		<td height="28px" id="abmLeftTitle" align="center" class="adpanel">
		  <div>
		    &nbsp;<b>게시판 카테고리</b>&nbsp;
		  </div>
		</td>
	  </tr>
	</table>
</td>
</tr>
</table>
</html>

