<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<c:set var="loginInfo" value="${secPmsnVO.loginInfo}"/>

<div class=adgridpanel>
<form id="badBltnForm" name="badBltnForm" action="" method="post" onsubmit="return false;">
	<input type=hidden name=userNick size=10 value='<c:out value="${loginInfo.nm_kor}" escapeXml="false"/>'>
	<table width=100% border="0" cellspacing="0" cellpadding="0">
		<tr><td height=10 colspan=3></td></tr>
		<tr>
			<td height="25" width="100px" align="center" background="/board/images/board/skin/enboard/bg_t_title2.gif" bgcolor="#FFFFFF" class="table_title_l">신고사유</td>
			<td width="3" background="/board/images/board/skin/enboard/img_t_bar2.gif" ></td>
			<td height="25" colspan="13" class="table_list_l">
				<textarea name=badBltnCntt style="overflow:visible;height:60;width:98%"></textarea>
			</td>
		</tr>			
		<tr><td height=10 colspan=3></td></tr>
		<tr>
		  <td colspan=3 align=right>
		    <input type=button value="신고하기" onClick="ebRead.actionBulletin('bad-bltn','<c:out value="${bltnNo}"/>')"/>&nbsp;&nbsp;
		    <input type=button value="닫기" onClick="ebRead.showBadBltnForm('false');"/>
		  </td>
		</tr>
		<tr><td height=6 colspan=4></td></tr>		
	</table>
</form>
</div>
