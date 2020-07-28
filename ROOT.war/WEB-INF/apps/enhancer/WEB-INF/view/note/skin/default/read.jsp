<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<form id="readForm" name="readForm" method="post">
	<input type="hidden" id="noteId" value="<c:out value="${note.noteId }"/>">
	<div class="workForm">
		<div class="work"><util:message key="hn.note.label.noteRead"/></div>
	</div>
	<div class="controlPanel">
		<div class="noteButton deleteButton" onclick="javascript:enNote.deleteNote(<c:out value="${note.noteId}"/>, <c:out value="${note.noteType}"/>, <c:out value="${note.viewBox}"/>);"><util:message key="hn.note.label.delete"/></div>
		<c:if test="${note.states == 1 }"><div class="noteButton storeButton" onclick="javascript:enNote.storeNote(<c:out value="${note.noteId}"/>, <c:out value="${note.noteType}"/>);"><util:message key="hn.note.label.store"/></div></c:if>
		<c:if test="${note.viewBox == 4 }"><div class="noteButton storeButton" onclick="javascript:enNote.restoreNote(<c:out value="${note.noteId}"/>, <c:out value="${note.noteType}"/>);"><util:message key="hn.note.label.restore"/></div></c:if>
		<c:if test="${note.viewBox < 4 and note.noteType == 1 }"><div class="noteButton replyButton" onclick="javascript:enNote.viewReplyForm();"><util:message key="hn.note.label.reply"/></div></c:if>
		<div class="noteButton list" onclick="javascript:enNote.viewBox('<c:out value="${ viewBoxName }"/>', <c:out value="${ note.currentPage }"/>);"><util:message key="hn.note.label.list"/></div>
	</div>
	<div class="view_attr view_sender">
		<div class="view_column"><util:message key="hn.note.label.sender"/> | </div>
		<div class="view_value">
			<div class="view_senderName">
				<c:out value="${note.senderName}"/>(<c:out value="${note.senderId}"/>)
			</div>
			<div class="view_sendTime">
				<c:out value="${note.sendTime }"/>
			</div>
		</div>
	</div>
	<div class="view_attr view_receiver">
		<div class="view_column"><util:message key="hn.note.label.receiver"/> | </div>
		<div class="view_value">
			<div id="deleRcvr" class="deleRcvr"><c:out value="${note.deleRcvrName}"/>(<c:out value="${note.deleRcvrId}"/>)<c:if test="${note.receiverAmount > 1 }"> <util:message key="hn.note.label.etal"/> <c:out value="${note.receiverAmount-1 }"/> <util:message key="hn.note.label.peopleAmount"/></c:if></div>
			<c:if test="${note.receiverAmount > 1 }">
				<div id="viewButton" class="viewButton" onclick="javascript:enNote.viewReceivers();"><util:message key="hn.note.label.detail"/></div>
				<span id="receivers" class="receivers" style="display:none;"><c:out value="${note.receivers}"/></span>
			</c:if>
		</div>
	</div>
	<div class="view_attr view_title">
		<div class="view_column"><util:message key="hn.note.label.title"/> | </div>
		<div class="view_value">
			<c:out value="${note.title}"/>
		</div>
	</div>
	<div id="contents" class="view_attr2 view_contents">
		<div class="view_column"><util:message key="hn.note.label.contents"/> | </div>
		<div class="view_value"><br><div class="view_value2"><c:out value="${note.contents }"/></div></div>
	</div>
	<div class="view_attr view_file" id="files">
		<div class="view_column"><util:message key="hn.note.label.files"/> | </div>
		<div class="view_value">
			<c:if test="${( note.fileIds != null && note.fileIds != '') }" var="yes_file">
				<iframe class="view_fileManager" id="fileManager" name="fileManager" src="<%=request.getContextPath()%>/tool/fileManager.hanc?m=downloadList&appsId=<c:out value="${note.noteId }"/>" width="650px" height="85px"></iframe>
			</c:if>
			<c:if test="${ yes_file == false }">
				<util:message key="hn.note.label.noFiles"/>
				<script>
					$('#files').css('height', '30px');
				</script>
			</c:if>
		</div>
	</div>
	<c:if test="${ note.noteType == 0 }">
	<div class="view_attr view_readcheck">
		<div class="view_column"><util:message key="hn.note.label.readCheck"/> | </div>
		<div class="view_value">
			<input id="checkY" type="radio" class="input_radio" name="readCheck" value="1" disabled="disabled"/><label for="checkY" class="label_checkYN"><util:message key="hn.note.label.yes"/></label><input id="checkN" type="radio" class="input_radio" name="readCheck" value="0" checked="checked" disabled="disabled"/><label for="checkN" class="label_checkYN"><util:message key="hn.note.label.no"/></label>
		</div>
	</div>
	<script type="text/javascript">
		$('.input_radio').each(function(){
			if($(this).val() == <c:out value="${note.readCheck}"/>){
				$(this).attr('checked', 'checked');
			}
		});
	</script>
	</c:if>
	<div class="controlPanel">
		<div class="noteButton deleteButton" onclick="javascript:enNote.deleteNote('<c:out value="${note.noteId}"/>', '<c:out value="${note.noteType}"/>');"><util:message key="hn.note.label.delete"/></div>
		<c:if test="${note.states == 1 }"><div class="noteButton storeButton" onclick="javascript:enNote.storeNote('<c:out value="${note.noteId}"/>', '<c:out value="${note.noteType}"/>');"><util:message key="hn.note.label.store"/></div></c:if>
		<c:if test="${note.viewBox == 4 }"><div class="noteButton storeButton" onclick="javascript:enNote.restoreNote('<c:out value="${note.noteId}"/>', '<c:out value="${note.noteType}"/>');"><util:message key="hn.note.label.restore"/></div></c:if>
		<c:if test="${note.viewBox < 4 and note.noteType == 1 }"><div class="noteButton replyButton" onclick="javascript:enNote.viewReplyForm();"><util:message key="hn.note.label.reply"/></div></c:if>
		<div class="noteButton list" onclick="javascript:enNote.viewBox('<c:out value="${ viewBoxName }"/>', <c:out value="${ note.currentPage }"/>);"><util:message key="hn.note.label.list"/></div>
	</div>
	<input type="hidden" id="searchType" name="searchType" value="<c:out value="${note.searchType }"/>"/>
	<input type="hidden" id="searchValue" name="searchValue" value="<c:out value="${note.searchValue }"/>"/>
	<input type="hidden" id="currentPage" name="currentPage" value="<c:out value="${note.currentPage }"/>"/>
	<input type="hidden" id="senderId" name="senderId" value="<c:out value="${note.senderId }"/>"/>
	<input type="hidden" id="senderName" name="senderName" value="<c:out value="${note.senderName }"/>"/>
</form>
<script type="text/javascript">
	var height = document.getElementById("contents").scrollHeight;
	
	var fileIds = '<c:out value="${note.fileIds}"/>';
	if(fileIds == ''){
		height = 250;
	}else{
		height = 195;
	}
	
	$('#contents').css('height', height);
	$('#contents .view_value').css('height', height-5);
	$('#contents .view_value2').css('height', height-30);
</script>