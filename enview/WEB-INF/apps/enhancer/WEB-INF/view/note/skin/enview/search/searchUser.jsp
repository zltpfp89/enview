<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<div class="message">
	<div class="searchMessage"><c:out value="${form.searchUserMessage }"/></div>
</div>
<div class="layer userLayer">
	<div class="search_label"><util:message key="hn.note.label.user"/></div>
	<select id="userList" multiple="multiple" class="list userList">
		<c:forEach items="${form.userList }" var="user" varStatus="i">
			<option id="<c:out value="${user.userId }"/>" class="user" value="<c:out value="${user.userName }"/>"><c:if test="${form.searchType == 3 }">[<c:out value="${user.groupName }"/>]</c:if><c:out value="${ user.userName }"/>(<c:out value="${user.userId }"/>)</option>
		</c:forEach>
	</select>
</div>
<div class="controls">
	<div class="noteButton addButton" onclick="javascript:add();"><util:message key="hn.note.label.add"/></div>
	<div class="noteButton removeButton" onclick="javascript:remove();"><util:message key="hn.note.label.remove"/></div>
</div>
<div class="layer receiverLayer">
	<div class="search_label"><util:message key="hn.note.label.receiver"/></div>
	<select id="receiverList" multiple="multiple" class="list receiverList"></select>
</div>
<script type="text/javascript">
	$('#userList').dblclick(add);
	$('#receiverList').dblclick(remove);
</script>