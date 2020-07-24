<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<form id="readcheckbox" name="readcheckbox" method="post" onsubmit="return false;">
	<div id="popupMenu" class="popupMenu">
		<div id="block" class="block" onclick="javascript:enNote.blockUser('ReadCheck',<c:out value="${notePage.currentPage}"/>);"><util:message key="hn.note.label.block"/></div>
		<div id="unblock" class="block" onclick="javascript:enNote.unblockUser('ReadCheck',<c:out value="${notePage.currentPage}"/>);"><util:message key="hn.note.label.unblock"/></div>		
	</div>
	<div class="searchArea">
		<h1 class="title"><util:message key="hn.note.label.readCheckBox"/></h1>
		<p class="search">
			<select name="선택" class="select" id="searchType">
				<c:forEach items="${sendSearchType }" var="search" varStatus="status">
					<option class="searchTypes" value="<c:out value="${search.code }"/>" <c:if test="{search.code == form.searchType}">selected="selected"</c:if>><c:out value="${search.codeName}"/></option>
				</c:forEach>
			</select>
			<input type="text" class="txt_110" id="searchValue" value="<c:out value="${form.searchValue}"/>" onkeyup="javascript:enNote.searchReadCheckNotes(event);"/>
			<a href="javascript:enNote.searchReadCheckNotes(event);" class="btn_type02"><span><util:message key="hn.note.label.search"/></span></a>
			<input type="hidden" id="viewBox" name="viewBox" value="<c:out value="${form.viewBox}"/>"/>
			<input type="hidden" id="currentPage" name="currentPage" value="<c:out value="${notePage.currentPage}"/>"/>
		</p>
	</div>
	<div class="message">
		<div class="searchMessage"><c:out value="${form.searchMessage }"/></div>
	</div>
	<!-- 버튼영역 -->
	<div class="btnArea">
		<a href="javascript:enNote.deleteReadCheckNotes();" class="btn_type01" title="delete"><span><util:message key="hn.note.label.delete"/></span></a>
		<span class="pageBtn">
			<a href="javascript:enNote.reload();" class="btn_type01"><span><util:message key="hn.note.label.reload"/></span></a><a href="javascript:enNote.prevPage();"><img src="<%=request.getContextPath()%>/hancer/images/note/enview/list_prev.gif" alt="이전페이지"/></a> <a href="javascript:enNote.nextPage();"><img src="<%=request.getContextPath()%>/hancer/images/note/enview/list_next.gif" alt="다음페이지"/></a>
		</span>
	</div>
	<!-- 버튼영역//-->
	<!-- 테이블 -->
	<div class="tableArea">
		<table class="table_type01" summary="메세지입니다">
		<caption>메세지리스트입니다.</caption>
			<colgroup>
			<col width="3%" />
			<col width="20%" />			
			<col width="*%" />
			<col width="15%" />
			<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><input type="checkbox" id="checkAll" name="checkAll"  class="chek checkbox" onclick="enNote.checkAllNotes()" /></th>
					<th scope="col"><util:message key="hn.note.label.receiver"/></th>
					<th scope="col" class="left"><util:message key="hn.note.label.title"/></th>
					<th scope="col"><util:message key="hn.note.label.sendTime"/></th>
					<th scope="col"><util:message key="hn.note.label.readTime"/></th>
				</tr>
			</thead>
			<tbody>
				<tr><td colspan="5" class="padding"></td></tr>
			<c:if test="${empty form.noteFormList}">
				<tr><td colspan="5"><util:message key="hn.note.label.hasNotReadCheckNote"/></td></tr>
			</c:if>
			<c:forEach items="${form.noteFormList}" var="note" varStatus="idx">
				<tr class="dataRow">
					<td class="first"><input type="checkbox" id="<c:out value="${note.noteId}"/>:<c:out value="${note.receiverId}"/>" name="check" class="checkbox" value="<c:out value="${note.noteId}"/>"/></td>
					<td><c:out value="${note.receiverName}"/>(<c:out value="${note.receiverId}"/>)</td>
					<td class="left">
						<a href="javascript:enNote.readSendNote('<c:out value="${note.noteId }"/>');"><c:out value="${note.title}"/></a>
						<c:if test="${( note.fileIds != null && note.fileIds !='' )  }"><img src="<%=request.getContextPath()%>/hancer/images/note/enview/icon_file.png"/></c:if></td>
					<td><c:out value="${note.sendTime2}"/></td>
					<td><c:out value="${note.readTime}"/></td>
				</tr>
			</c:forEach>
				<tr><td colspan="5" class="padding"></td></tr>
			</tbody>
		</table>
	</div>
	<!-- 버튼영역 -->
	<!-- 버튼영역 -->
	<div class="btnArea">
		<a href="javascript:enNote.deleteReadCheckNotes();" class="btn_type01" title="delete"><span><util:message key="hn.note.label.delete"/></span></a>
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