
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/fileManager.js"></script>

<table width="100%" height="400px" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td valign='top'>
			<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
			<tr>
				<td width="100px" style="width:26%;background:#FFFFFF;" valign="top" class="webpanel">
					<div >
						<div id="FileChooser_TreeTabPage" style="width:100%; height:300px; overflow:auto;"></div>
					</div>
				</td>
			</tr>
			</table>
		</td>
	</tr>
</table>

