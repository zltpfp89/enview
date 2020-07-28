<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<div class="cafepanel" style="width:100%;">
  <br style='line-height:5px;'>
  <div class="cafegridpanel">
    <ul><li>보관된 게시판은 <c:out value="${opForm.keepDays}"/>&nbsp;일간 보관 후 자동삭제 되며, 삭제된 게시판은 복구가 불가능합니다.</li></ul>
	<form id="trash_listForm" name="trash_listForm" style="display:inline" action="" method="post" onsubmit="return false;">
	  <table id="grid-table" width="100%" border="0" cellspacing="0" cellpadding="0">
		<thead>
		  <tr><td colspan="100" height="5"></td></tr>
		  <tr><td colspan="100" height="2" class="cafegridlimit"></td></tr>
		  <tr style="cursor: pointer;">
			<th class="cafegridheader" align="center" width="30px">
			  <input type="checkbox" id="delCheck" onclick="cfOp.m_checkBox.chkAll(this)"/>
			</th>
			<th class="cafegridheader"><span>게시판명</span></th>
			<th class="cafegridheader"><span>게시글수</span></th>
			<th class="cafegridheader"><span>삭제자</span></th>
			<th class="cafegridheader"><span>삭제일</span></th>	
			<th class="cafegridheaderlast"><span>보관최종일</span></th>	
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
				<span class="btn_pack small">
					<a href="#" onclick="javascript:cfOp.menuMng.getTrash().doRecover()">복구</a>
				</span>
			  </span>
			</td>
		  </tr>
		</tbody>
	  </table>
	</form>
  </div>
</div>
