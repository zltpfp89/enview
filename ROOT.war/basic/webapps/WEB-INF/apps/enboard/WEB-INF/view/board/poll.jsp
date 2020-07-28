<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="./include/board_header.jsp"/>
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="100%">
<tr>
  <td width=0><jsp:include page="./include/board_left.jsp"/></td>
  <td valign=top>
<%---------------------------------------------------------------------------------------------------------------------%>  
<title>설문</title>
 
<script type="text/javascript">
	<!--
	window.onload = ebList.initList;
	//-->
</script>

<table border=0 cellspacing=0 cellpadding=0 align=center width=100%>
  <tr>
    <td align=center> 
      <jsp:include page='<%="./skin/"+request.getAttribute("boardSkin")+"/poll.jsp"%>'/>
    </td>
  </tr>
</table>  
 
<%---------------------------------------------------------------------------------------------------------------------%>  
  </td>
  <td width=0><jsp:include page="./include/board_right.jsp"/></td>
</tr>
</table>
<jsp:include page="./include/board_footer.jsp"/>
