<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
					
	<div class="cafeadm_top">
		<h3><util:message key="cf.title.restore.board"/></h3>
		<ul class="location">
			<li>HOME<span class="nextbar"></span></li>
			<li><util:message key="cf.title.mng.menuBoard"/><span class="nextbar"></span></li>
			<li class="last"><util:message key="cf.title.restore.board"/></li>
		</ul>
		<div class="title_text">
			<p class="">util:message key="cf.info.keep.board" param="${opForm.keepDays}"/></p>
		</div>
	</div>

	<form id="trash_listForm" name="trash_listForm" style="display:inline" action="" method="post" onsubmit="return false;">
	<table class="table_type01" summary="게시판">
	<caption>게시판</caption>
	<colgroup>
		<col width="80px;">
		<col width="auto;">
		<col width="120px;">
		<col width="120px;">
		<col width="120px;">
		<col width="120px;">
	</colgroup>
	<thead>
		<tr>
			<th><input type="checkbox" name="board_check"></th>
			<th><util:message key="eb.info.ttl.boardNm"/></th>
			<th><util:message key="eb.title.bltnCnt"/></th>
			<th><util:message key="ev.title.delete.user"/></th>
			<th><util:message key="ev.title.delete.date"/></th>
			<th><util:message key="ev.title.keep.date"/></th>
		</tr>
	</thead>
	<tbody id="trash_listBody">
		<c:if test="${empty delMenuList}">
			<tr>
				<td colspan="6"><util:message key="ev.search.no.result"/></td>
			</tr>
		</c:if>
		<c:if test="${!empty delMenuList}">
			<c:forEach items="${delMenuList}" var="delMenu" varStatus="status">
				<tr ch="<c:out value="${status.index}"/>" style="cursor:pointer;" class="<c:if test="{$status % 2 != 0}">cafegridline</c:if>">
					<td>
						 <input type="checkbox" id="trash_checkRow" name="trash_checkRow" class="cafecheckbox" value="<c:out value="${delMenu.menuId}"/>"/>
					</td>
					<td class="left"><c:out value="${delMenu.menuNm}"/></td>
					<td><c:out value="${delMenu.bltnCnt}"/></td>
					<td><c:out value="${delMenu.delUserId}"/></td>
					<td><c:out value="${delMenu.delDatimSF}"/></td>
					<td><c:out value="${delMenu.keepDatimSF}"/></td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
	</table>
	<div class="board_btn_wrap">				
		<div class="board_btn_wrap_center">
			<a href="#" onclick="javascript:cfOp.menuMng.getTrash().doRecover()" class="btn black"><util:message key="cf.title.restore"/></a>
		</div>
	</div>
