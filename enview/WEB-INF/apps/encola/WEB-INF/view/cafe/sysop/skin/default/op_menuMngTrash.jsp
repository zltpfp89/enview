<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="cafepanel" style="width:100%;">
  <br style='line-height:5px;'>
  <div class="cafegridpanel">
    <ul><li><util:message key="cf.info.keep.board" param="${opForm.keepDays}"/></li></ul>
	<form id="trash_listForm" name="trash_listForm" style="display:inline" action="" method="post" onsubmit="return false;">
	  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
		<thead>
		  <tr><td colspan="100" height="5"></td></tr>
		  <tr><td colspan="100" height="2" class="cafegridlimit"></td></tr>
		  <tr style="cursor: pointer;">
			<th class="cafegridheader" align="center" width="30px">
			  <input type="checkbox" id="delCheck" onclick="cfOp.m_checkBox.chkAll(this)"/>
			</th>
			<th class="cafegridheader"><span><util:message key="eb.info.ttl.boardNm"/></span></th>
			<th class="cafegridheader"><span><util:message key="eb.title.bltnCnt"/></span></th>
			<th class="cafegridheader"><span><util:message key="ev.title.delete.user"/></span></th>
			<th class="cafegridheader"><span><util:message key="ev.title.delete.user"/></span></th>	
			<th class="cafegridheaderlast"><span><util:message key="ev.title.keep.date"/></span></th>	
		  </tr>
		</thead>
		<tbody id="trash_listBody">
		  <c:forEach items="${delMenuList}" var="delMenu" varStatus="status">
		  <tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:if test="{$status % 2 != 0}">cafegridline</c:if>"
              onmouseover="ebUtil.activeLine(this,true)" onmouseout="ebUtil.activeLine(this,false)">
			<td align="center" class="cafegrid">
			  <input type="checkbox" id="trash_checkRow" name="trash_checkRow" class="cafecheckbox" value="<c:out value="${delMenu.menuId}"/>"/>
			</td>
			<td align="left" class="cafegrid"><span style="margin-left:10px"><c:out value="${delMenu.menuNm}"/></span></td>
			<td align="left" class="cafegrid"><span style="margin-left:10px"><c:out value="${delMenu.bltnCnt}"/></span></td>
			<td align="left" class="cafegrid"><span style="margin-left:10px"><c:out value="${delMenu.delUserId}"/></span></td>
			<td align="left" class="cafegrid"><span style="margin-left:10px"><c:out value="${delMenu.delDatimSF}"/></span></td>
			<td align="left" class="cafegridlast"><span style="margin-left:10px"><c:out value="${delMenu.keepDatimSF}"/></span></td>
		  </tr>
		  </c:forEach>
		  <tr><td colspan="100" height="2" class="cafegridlimit"></td></tr>
		  <tr><td colspan="100" height="5"></td></tr>
		  <tr style="cursor:pointer;">
		    <td colspan="100">
			  <span style="margin-left:30px">선택된 게시판</span>
			  <span style="margin-left:10px">
				<input type="button" value="복구" onclick="cfOp.menuMng.getTrash().doRecover()"/>
			  </span>
			</td>
		  </tr>
		</tbody>
	  </table>
	</form>
  </div>
</div>
