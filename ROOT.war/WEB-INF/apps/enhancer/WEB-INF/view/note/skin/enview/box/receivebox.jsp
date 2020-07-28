<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<form id="receivebox" name="receivebox" method="post" onsubmit="return false;">
	<div id="popupMenu" class="popupMenu">
		<div id="block" class="block" onclick="javascript:enNote.blockUser('Receive',<c:out value="${notePage.currentPage}"/>);"><util:message key="hn.note.label.block"/></div>
		<div id="unblock" class="block" onclick="javascript:enNote.unblockUser('Receive',<c:out value="${notePage.currentPage}"/>);"><util:message key="hn.note.label.unblock"/></div>		
	</div>
	<div class="searchArea">
		<h1 class="title"><util:message key="hn.note.label.receiveBox"/></h1>
		<p class="search">
			<select name="선택" class="select" id="searchType">
				<c:forEach items="${receiveSearchType }" var="search" varStatus="status">
					<option class="searchTypes" value="<c:out value="${search.code }"/>" <c:if test="{search.code == form.searchType}">selected="selected"</c:if>><c:out value="${search.codeName}"/></option>
				</c:forEach>
			</select>
			<input type="text" class="txt_110" id="searchValue" value="<c:out value="${form.searchValue}"/>" onkeyup="enNote.searchReceiveNotes(event);"/>
			<a onclick="javascript:enNote.searchReceiveNotes(event);" class="btn_type02"><span><util:message key="hn.note.label.search"/></span></a>
			<input type="hidden" id="viewBox" name="viewBox" value="<c:out value="${form.viewBox}"/>"/>
			<input type="hidden" id="currentPage" name="currentPage" value="<c:out value="${notePage.currentPage}"/>"/>
		</p>
	</div>
	<div class="message">
		<div class="searchMessage"><c:out value="${form.searchMessage }"/></div>
		<div class="unreadMessage"><c:out value="${form.unreadMessage }"/></div>
	</div>
	<!-- 버튼영역 -->
	<div class="btnArea">
		<a href="javascript:enNote.deleteReceiveNotes();" class="btn_type01" title="delete"><span><util:message key="hn.note.label.delete"/></span></a> <a href="javascript:enNote.storeReceiveNotes();" class="btn_type01" title="store"><span><util:message key="hn.note.label.store"/></span></a>
		<span class="pageBtn">
			<a href="javascript:enNote.reload();" class="btn_type01"><span><util:message key="hn.note.label.reload"/></span></a><a href="javascript:enNote.prevPage();"><img src="<%=request.getContextPath()%>/hancer/images/note/enview/list_prev.gif" alt="이전페이지"/></a> <a href="javascript:enNote.nextPage();"><img src="<%=request.getContextPath()%>/hancer/images/note/enview/list_next.gif" alt="다음페이지"/></a>
		</span>
	</div>
	<!-- 버튼영역//-->
	<!-- 테이블 -->
	<div class="tableArea">
		<table class="box_table table_type01" summary="메세지입니다">
		<caption>메세지리스트입니다.</caption>
			<colgroup>
			<col width="3%" />
			<col width="25%" />
			<col width="*%" />
			<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><input type="checkbox" id="checkAll" name="checkAll"  class="chek checkbox" onclick="enNote.checkAllNotes()" /></th>
					<th scope="col"><util:message key="hn.note.label.sender"/></th>
					<th scope="col" class="left"><util:message key="hn.note.label.title"/></th>
					<th scope="col"><util:message key="hn.note.label.sendTime"/></th>
				</tr>
			</thead>
			<tbody>
				<tr><td colspan="4" class="padding"></td></tr>
			<c:if test="${empty form.noteFormList}">
				<tr><td colspan="4"><util:message key="hn.note.label.hasNotReceiveNote"/></td></tr>
			</c:if>
			<c:forEach items="${form.noteFormList}" var="note" varStatus="idx">
				<tr class="dataRow">
					<td class="first"><input type="checkbox" id="<c:out value="${note.noteId}"/>" name="check" class="checkbox"/></td>
					<td id="send_<c:out value="${note.noteId }"/>"><a class="<c:if test="${note.isBlocked == 1}">blocked</c:if>" href="javascript:enNote.popupMenu(<c:out value="${note.noteId }"/>,'<c:out value="${note.senderName}"/>','<c:out value="${note.senderId}"/>',<c:out value="${ note.isBlocked }"/>);"><c:out value="${note.senderName}"/>(<c:out value="${note.senderId}"/>)</a></td>
					<td class="left"><a class="<c:if test="${note.states == 0 }"> unread</c:if>" href="javascript:enNote.readReceiveNote('<c:out value="${note.noteId }"/>');"><c:out value="${note.title}"/></a><c:if test="${( note.fileIds != null && note.fileIds !='' )  }"><img src="<%=request.getContextPath()%>/hancer/images/note/enview/icon_file.png"/></c:if></td>
					<td><c:out value="${note.sendTime}"/></td>
				</tr>
			</c:forEach>
				<tr><td colspan="4" class="padding"></td></tr>
			</tbody>
		</table>
	</div>
	<!-- 버튼영역 -->
	<div class="btnArea">
		<a href="javascript:enNote.deleteReceiveNotes();" class="btn_type01" title="delete"><span><util:message key="hn.note.label.delete"/></span></a> <a href="javascript:enNote.storeReceiveNotes();" class="btn_type01" title="store"><span><util:message key="hn.note.label.store"/></span></a>
		<span class="pageBtn">
			<a href="javascript:enNote.reload();" class="btn_type01"><span><util:message key="hn.note.label.reload"/></span></a><a href="javascript:enNote.prevPage();"><img src="<%=request.getContextPath()%>/hancer/images/note/enview/list_prev.gif" alt="이전페이지"/></a> <a href="javascript:enNote.nextPage();"><img src="<%=request.getContextPath()%>/hancer/images/note/enview/list_next.gif" alt="다음페이지"/></a>
		</span>
	</div>
	<!-- 버튼영역//-->
	<!-- paging -->
	<div class="paging">
		<a href="javascript:enNote.firstPage();" class="first"><img src="<%=request.getContextPath()%>/hancer/images/note/enview/btn_first.gif" alt="first" /></a>
		<a href="javascript:enNote.prevPage();" class="prev"><img src="<%=request.getContextPath()%>/hancer/images/note/enview/btn_prev.gif" alt="prev" /></a>
		<c:if test="${notePage.currentStartPage == 1 and notePage.currentEndPage == 0 }">
			<a class="selected">1</a>
		</c:if>
		<c:forEach begin="${notePage.currentStartPage}" end="${notePage.currentEndPage}" var="i">
			<a <c:if test = "${notePage.currentPage == i }" var="notCurrentPage" >class="selected"</c:if><c:if test="${not notCurrentPage }"> href="javascript:enNote.goPage(<c:out value="${i}"/>)"</c:if>>
				<c:out value="${i}"/>
			</a>
		</c:forEach>
		<a href="javascript:enNote.nextPage();" class="next"><img src="<%=request.getContextPath()%>/hancer/images/note/enview/btn_next.gif" alt="next" /></a>
		<a href="javascript:enNote.lastPage();" class="last"><img src="<%=request.getContextPath()%>/hancer/images/note/enview/btn_last.gif" alt="last" /></a>
	</div>
</form>
<script type="text/javascript">
	enNote.autoResizeNoteList(<c:out value="${form.length}"/>);
	enNote.autoResizePagingLayer(<c:out value="${notePage.currentEndPage - notePage.currentStartPage + 1}"/>);
	enNote.initSeachForm(<c:out value="${form.searchType }"/>, '<c:out value="${form.searchValue }"/>');
	enNote.m_currentPage = <c:out value="${notePage.currentPage}"/>;
	enNote.m_lastPage = <c:out value="${notePage.pages}"/>;
</script>