
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/roleManager.js"></script>

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
	<tr>
		<td valign='top'>
			<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
			<tr>
				<td width="100px" style="width:26%;background:#FFFFFF;" valign="top" class="webpanel">
					<div >
						<div id="RoleChooser_TreeTabPage" class="tree" style="border-right: 0px #ffffff;"></div>
					</div>
				</td>
			</tr>
			</table> 
		</td>
	</tr>
</table>

