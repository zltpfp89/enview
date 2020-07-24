<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<c:if test="${note.receiverIds != 'undefined'}" var="isPopup" />
<form name="writeForm" id="writeForm" action="write.hanc" method="post">
	<input type="hidden" id="receiverIds" name="receiverIds" value="<c:out value="${note.receiverIds }"/>">
	<div class="workForm<c:if test="${isPopup }">_pop</c:if>">
		<div id="workTitle" class="work"><util:message key="hn.note.label.noteWrite"/></div>
	</div>
	<c:if test="${!isPopup }">
	<div class="controlPanel">
		<div class="noteButton list" onclick="javascript:enNote.viewReceiveBox();"><util:message key="hn.note.label.list"/></div>
	</div>
	<div class="write_attr write_receivers">
		<div class="write_column"><util:message key="hn.note.label.receiver"/> | </div>
		<div class="write_value<c:if test="${isPopup }">_pop</c:if>">
			<input type="text" id="receiverNames" name="receiverNames" class="inputField input_receivers" readonly="readonly" value="<c:out value="${note.receiverNames }"/>"/><div class="noteButton write_rcvr_button" id="rcvrButton" onclick="javbascript:enNote.search();"><util:message key="hn.note.label.receiver"/></div>
		</div>
	</div>
	</c:if>
	<div class="write_attr write_title<c:if test="${isPopup }">_pop</c:if>">
		<div class="write_column"><util:message key="hn.note.label.title"/> | </div>
		<div class="write_value<c:if test="${isPopup }">_pop</c:if>">
			<input type="text" id="title" name="title" class="inputField input_title" value="<c:out value="${note.title }"/>"/>
		</div>
	</div>
	<div class="write_attr write_contents<c:if test="${isPopup }">_pop</c:if>">
		<div class="write_column"><util:message key="hn.note.label.contents"/> | </div>
		<div class="write_value<c:if test="${isPopup }">_pop</c:if>">
			<textarea rows="15" cols="70" id="contents" name="contents" class="inputField textArea_contents" onkeyup="javascript:enNote.checkLength();"><c:out value="${note.contents }"/></textarea>
			<div id="limits" class="limits">0/1000</div>
		</div>
	</div>
	<div class="write_attr write_file<c:if test="${isPopup }">_pop</c:if>">
		<div class="write_column"><util:message key="hn.note.label.files"/> | </div>
		<div class="write_value<c:if test="${isPopup }">_pop</c:if>" style="padding-left: 8px;">
			<iframe class="write_fileManager" id="fileManager" name="fileManager" src="<%=request.getContextPath()%>/tool/fileManager.hanc" width="504px" height="102px"></iframe>
		</div>
	</div>
	<div class="write_attr write_readcheck<c:if test="${isPopup }">_pop</c:if>">
		<div class="write_column"><util:message key="hn.note.label.readCheck"/> | </div>
		<div class="write_value<c:if test="${isPopup }">_pop</c:if>">
			<input id="checkY" type="radio" class="input_radio" name="readCheck" value="1"/><label for="checkY" class="label_checkYN"><util:message key="hn.note.label.yes"/></label><input id="checkN" type="radio" class="input_radio" name="readCheck" value="0" checked="checked"/><label for="checkN" class="label_checkYN"><util:message key="hn.note.label.no"/></label>
		</div>
	</div>
	<div class="write_attr write_button<c:if test="${isPopup }">_pop</c:if>">
		<input type="button" id="writeButton" class="input_write<c:if test="${isPopup }">_pop</c:if>" value="<util:message key="hn.note.label.send"/>" onclick="javascript:enNote.validationWrite();"/>
	</div>
	<c:if test="${!isPopup }">
	<div class="controlPanel">
		<div class="noteButton list" onclick="javascript:enNote.viewReceiveBox();"><util:message key="hn.note.label.list"/></div>
	</div>
	</c:if>
</form>
<input type="hidden" id="isPopup" />