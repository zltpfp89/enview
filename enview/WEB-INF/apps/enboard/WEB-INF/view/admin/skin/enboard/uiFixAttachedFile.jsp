<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="com.saltware.enview.codebase.Codebase,com.saltware.enboard.vo.CodebaseVO"%>
<%
	String evcp = request.getContextPath();
%>

<!-- board first-->
<div class="board first">
	<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
		<tr>
			<td align="center">
				<font style="color:red"><b><util:message key="eb.info.lateTime"/></b></font>
				<span id="fixButton"><a href="javascript:fixAttachedFile()" class="btn_O"><span><util:message key="eb.title.Attachment.Arrangement"/></span></a></span>
			</td>	
		</tr>
	</table>
</div>
<!-- board first// -->

<link rel="stylesheet" type="text/css" href="<%=evcp%>/board/css/admin/admin-common.css">
<script type="text/javascript" src="<%=evcp%>/board/javascript/enboard_util.js"></script>
<script type="text/javascript">
  
  function fixAttachedFile () {
    
	var m_contextPath = portalPage.getContextPath();
  	var m_ajax = new enview.util.Ajax();
	m_ajax.setContextPath (m_contextPath);

	document.getElementById("fixButton").style.display = "none";
	
	var param = "m=fixAttachedFile";
	m_ajax.send ("POST", m_contextPath+"/board/adBoard.brd", param, true, {success: function(data) {
		if (enviewMessageBox == null)  enviewMessageBox = new enview.portal.MessageBox(300, 100, 1000);
		enviewMessageBox.doShow (ebUtil.getMessage("eb.info.attach.reorg", data.ResultSize));
		document.getElementById("fixButton").style.display = "";
	}});
  }
</script>
