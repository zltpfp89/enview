<%@ page language="java" contentType="text/html; charset=UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<form id="sendbox" name="sendbox" method="post" action="sendBox.hanc" onsubmit="return false;">
	<div id="popupMenu" class="popupMenu">
		<div id="block" class="block" onclick="javascript:enNote.blockUser('Send',<c:out value="${notePage.currentPage}"/>);"><util:message key="hn.note.label.block"/></div>
		<div id="unblock" class="block" onclick="javascript:enNote.unblockUser('Send',<c:out value="${notePage.currentPage}"/>);"><util:message key="hn.note.label.unblock"/></div>		
	</div>
	<div class="searchForm">
		<div class="work"><util:message key="hn.note.label.sendBox"/></div>
		<div class="searchButton" onclick="javascript:enNote.searchSendNotes(event);"><util:message key="hn.note.label.search"/></div>
		<input type="text" name="searchValue" id="searchValue" class="inputField searchValue" onkeyup="javascript:enNote.searchSendNotes(event);">
		<select id="searchType" name="searchType" class="inputField searchType">
		<c:forEach items="${sendSearchType }" var="search" varStatus="status">
			<option class="searchTypes" value="<c:out value="${search.code }"/>" <c:if test="{search.code == form.searchType}">selected="selected"</c:if>><c:out value="${search.codeName}"/></option>
		</c:forEach>
		</select>
		<input type="hidden" id="viewBox" name="viewBox" value="<c:out value="${form.viewBox}"/>"/>
		<input type="hidden" id="currentPage" name="currentPage" value="<c:out value="${notePage.currentPage}"/>"/>
	</div>
	<div class="message">
		<div class="searchMessage"><c:out value="${form.searchMessage }"/></div>
	</div>
	<div class="controlPanel">
		<div title="delete" class="noteButton deleteButton" onclick="javascript:enNote.deleteSendNotes();"><util:message key="hn.note.label.delete"/></div>
		<div title="store" class="noteButton storeButton" onclick="javascript:enNote.storeSendNotes();"><util:message key="hn.note.label.store"/></div>
		<div title="nextPage" class="noteButton2 next" onclick="javascript:enNote.nextPage();"><util:message key="hn.note.label.next"/></div>
		<div title="prevPage" class="noteButton2 prev" onclick="javascript:enNote.prevPage();"><util:message key="hn.note.label.prev"/></div>
		<div title="reload" class="noteButton reload" onclick="javascript:enNote.reload();"><util:message key="hn.note.label.reload"/></div>
	</div>
	<div class="columnLayer">
		<div id="allcheck" class="check"><input type="checkbox" id="checkAll" name="checkAll"  class="checkbox" onclick="enNote.checkAllNotes()" /></div>
		<div class="receiverName"><util:message key="hn.note.label.receiver"/></div>
		<div class="note_title"><util:message key="hn.note.label.title"/></div>
		<div class="sendTime"><util:message key="hn.note.label.sendTime"/></div>
	</div>
	<div id="noteList" class="noteList">
<c:if test="${empty form.noteFormList}">
	<div class="noNoteList"><util:message key="hn.note.label.hasNotSendNote"/></div>
</c:if>
<c:forEach items="${form.noteFormList}" var="note" varStatus="idx">
		<div class="noteRow row">
			<div class="check column"><input type="checkbox" id="<c:out value="${note.noteId}"/>" name="check" class="checkbox" value="<c:out value="${note.noteId}"/>"/></div>
			<div class="receiverName column" title="<c:out value="${note.deleRcvrName}"/>(<c:out value="${note.deleRcvrId}"/>)<c:if test="${note.receiverAmount > 1 }"> <util:message key="hn.note.label.etal"/> <c:out value="${note.receiverAmount-1 }"/> <util:message key="hn.note.label.peopleAmount"/></c:if>">
				<c:out value="${note.deleRcvrName}"/>(<c:out value="${note.deleRcvrId}"/>)<c:if test="${note.receiverAmount > 1 }"> <util:message key="hn.note.label.etal"/>< <c:out value="${note.receiverAmount-1 }"/> <util:message key="hn.note.label.peopleAmount"/></c:if>
			</div>
			<div class="note_title column2">
				<a class="noteLink" href="javascript:enNote.readSendNote('<c:out value="${note.noteId }"/>');"><c:out value="${note.title}"/></a>
				<c:if test="${( note.fileIds != null && note.fileIds !='' )  }"><img src="<%=request.getContextPath()%>/hancer/images/note/default/icon_file.png"/></c:if>
			</div>
			<div class="sendTime column"><c:out value="${note.sendTime}"/></div>
		</div>
</c:forEach>
	</div>
	<div class="controlPanel">
		<div title="delete" class="noteButton deleteButton" onclick="javascript:enNote.deleteSendNotes();"><util:message key="hn.note.label.delete"/></div>
		<div title="store" class="noteButton storeButton" onclick="javascript:enNote.storeSendNotes();"><util:message key="hn.note.label.store"/></div>
		<div title="nextPage" class="noteButton2 next" onclick="javascript:enNote.nextPage();"><util:message key="hn.note.label.next"/></div>
		<div title="prevPage" class="noteButton2 prev" onclick="javascript:enNote.prevPage();"><util:message key="hn.note.label.prev"/></div>
		<div title="reload" class="noteButton reload" onclick="javascript:enNote.reload();"><util:message key="hn.note.label.reload"/></div>
	</div>
	<div class="pagingLayer">
		<div id="pagingButtons" class="pagingButtons">
			<div class="pageButton firstPage" onclick="javascript:enNote.firstPage();"><img src="<%=request.getContextPath() %>/hancer/images/note/default/page_prev02.gif" title="맨 처음으로"/></div>
			<div class="pageButton prevPage" onclick="javascript:enNote.prevPage();"><img src="<%=request.getContextPath() %>/hancer/images/note/default/page_prev.gif" title="열 페이지 앞으로"/></div>
			<c:if test="${notePage.currentStartPage == 1 and notePage.currentEndPage == 0 }">
				<div class="num currentPage">1</div>
			</c:if>
			<c:forEach begin="${notePage.currentStartPage}" end="${notePage.currentEndPage}" var="i">
				<div class="num<c:if test = "${notePage.currentPage == i }" var="notCurrentPage" > currentPage</c:if>"<c:if test="${not notCurrentPage }"> onclick="javascript:enNote.goPage(<c:out value="${i}"/>)"</c:if>>
					<c:out value="${i}"/>
				</div>
			</c:forEach>
			<div class="pageButton nextPage" onclick="javascript:enNote.nextPage();"><img src="<%=request.getContextPath() %>/hancer/images/note/default/page_next.gif" title="열 페이지 뒤로"/></div>
			<div class="pageButton lastPage" onclick="javascript:enNote.lastPage();"><img src="<%=request.getContextPath() %>/hancer/images/note/default/page_next02.gif" title="맨 마지막으로"/></div>
		</div>
	</div>
</form>
<script type="text/javascript">
	enNote.autoResizeNoteList(<c:out value="${form.length}"/>);
	enNote.autoResizePagingLayer(<c:out value="${notePage.currentEndPage - notePage.currentStartPage + 1}"/>);
	enNote.initSeachForm(<c:out value="${form.searchType }"/>, '<c:out value="${form.searchValue }"/>');
</script>