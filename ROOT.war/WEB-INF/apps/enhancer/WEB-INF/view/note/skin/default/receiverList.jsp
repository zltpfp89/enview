<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<form id="readForm" name="readForm" method="post">
	<!-- 테이블 -->
	<div class="tableArea" style="height:173px">
		<table class="table_type01" summary="받는사람리스트">
			<colgroup>
			<col width="3%" />
			<col width="60%" />
			<col width="*%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><util:message key="hn.note.label.number"/></th>
					<th scope="col"><util:message key="hn.note.label.receiver"/></th>
					<th scope="col"><util:message key="hn.note.label.readTime"/></th>
				</tr>
			</thead>
			<tbody>
				<tr><td colspan="3" class="padding"></td></tr>
			<c:if test="${empty receiverList}">
				<tr><td colspan="3"><util:message key="hn.note.label.hasNotReceiver"/></td></tr>
			</c:if>
			<c:forEach items="${receiverList}" var="receiver" varStatus="idx">
				<tr>
					<td class="first"><c:out value="${page.currentStartRow + idx.count - 1}"/></td>
					<td><c:out value="${receiver.userName}"/>(<c:out value="${receiver.userId}"/>)</td>
					<td><c:out value="${receiver.textReadTime }"/></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	<!-- paging -->
	<div id="receiverPaging" class="paging">
		<img src="<%=request.getContextPath()%>/hancer/images/note/default/page_prev02.gif" alt="first" onclick="javascript:enNote.viewReceivers(1);"/>
		<img src="<%=request.getContextPath()%>/hancer/images/note/default/page_prev.gif" alt="prev" onclick="javascript:enNote.viewReceivers(<c:out value="${page.prevPage}"/>);"/>
		<c:if test="${page.currentStartPage == 1 and page.currentEndPage == 0 }">
			<a class="selected">1</a>
		</c:if>
		<c:forEach begin="${page.currentStartPage}" end="${page.currentEndPage}" var="i">
			<a <c:if test = "${page.currentPage == i }" var="notCurrentPage" >class="selected"</c:if><c:if test="${not notCurrentPage }"> href="javascript:enNote.viewReceivers(<c:out value="${i }"/>);"</c:if>>
				<c:out value="${i}"/>
			</a>
		</c:forEach>
		<img src="<%=request.getContextPath()%>/hancer/images/note/default/page_next.gif" alt="next" onclick="javascript:enNote.viewReceivers(<c:out value="${page.nextPage}"/>);"/>
		<img src="<%=request.getContextPath()%>/hancer/images/note/default/page_next02.gif" alt="last" onclick="javascript:enNote.viewReceivers(<c:out value="${page.pages}"/>);"/>
	</div>
	<input type="hidden" id="currentPage" value="<c:out value="${page.currentPage }"/>">
</form>