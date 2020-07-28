<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<form id="settingForm" name="settingForm" method="post">
	<div class="emptyBoxLayer">
		<div class="emptyLabel"><util:message key="hn.note.label.emptyLabel"/></div>
		<div class="emptyDescription"><util:message key="hn.note.label.emptyDescription"/></div>
		<div class="emptyDescription"><util:message key="hn.note.label.emptyDescription2"/></div>
		<div class="optionRows emptyReceiveBox">
			<div class="noteButton emptyButton" onclick="javascript:enNote.emptyReceiveBox();"><util:message key="hn.note.label.emptyBox"/></div>
			<div class="optionAmount allReceiveNoteAmount"><c:out value="${ option.allReceiveNoteAmount }"/></div>
			<div class="emptyReceiveBoxLabel"><util:message key="hn.note.label.receiveBox"/></div>
		</div>
		<div class="optionRows emptySendBox">
			<div class="noteButton emptyButton" onclick="javascript:enNote.emptySendBox();"><util:message key="hn.note.label.emptyBox"/></div>
			<div class="optionAmount allSendNoteAmount"><c:out value="${ option.allSendNoteAmount }"/></div>
			<div class="emptySendBoxLabel"><util:message key="hn.note.label.sendBox"/></div>
		</div>
		<div class="optionRows emptyReadCheckBox">
			<div class="noteButton emptyButton" onclick="javascript:enNote.emptyReadCheckBox();"><util:message key="hn.note.label.emptyBox"/></div>
			<div class="optionAmount allReadCheckNoteAmount"><c:out value="${ option.allReadCheckNoteAmount }"/></div>
			<div class="emptyReadCheckBoxLabel"><util:message key="hn.note.label.readCheckBox"/></div>
		</div>
		<div class="optionRows emptyRecyclebinBox">
			<div class="noteButton emptyButton" onclick="javascript:enNote.emptyRecyclebinBox();"><util:message key="hn.note.label.emptyBox"/></div>
			<div class="optionAmount allRecyclebinNoteAmount"><c:out value="${ option.allRecyclebinNoteAmount }"/></div>
			<div class="emptyRecyclebinBoxLabel"><util:message key="hn.note.label.recyclebinBox"/></div>
		</div>
	</div>
	
	<div class="backupNotesLayer">
		<div class="backupLabel"><util:message key="hn.note.label.backupLabel"/></div>
		<div class="backupDescription"><util:message key="hn.note.label.backupDescription"/></div>
		<div class="backupDescription"><util:message key="hn.note.label.backupDescription2"/></div>
		<div class="optionRows backupReceiveNotes">
			<div class="backupReceiveNotesLabel"><util:message key="hn.note.label.receiveBox"/></div>
			<div class="noteButton backupButton" onclick="javascript:enNote.backupReceiveBox();"><util:message key="hn.note.label.backupBox"/></div>
			<div class="optionAmount allReceiveNoteAmount"><c:out value="${ option.allReceiveNoteAmount }"/></div>
		</div>
		<div class="optionRows backupSendNotes">
			<div class="backupSendNotesLabel"><util:message key="hn.note.label.sendBox"/></div>
			<div class="noteButton backupButton" onclick="javascript:enNote.backupSendBox();"><util:message key="hn.note.label.backupBox"/></div>
			<div class="optionAmount allSendNoteAmount"><c:out value="${ option.allSendNoteAmount }"/></div>
		</div>
		<div class="optionRows backupStoreNotes">
			<div class="backupStoreNotesLabel"><util:message key="hn.note.label.storeBox"/></div>
			<div class="noteButton backupButton" onclick="javascript:enNote.backupStoreBox();"><util:message key="hn.note.label.backupBox"/></div>
			<div class="optionAmount allStoreNoteAmount"><c:out value="${ option.allStoreNoteAmount }"/></div>
		</div>
	</div>
	<div class="unreadToReadNotesLayer">
		<div class="unreadToReadLabel"><util:message key="hn.note.label.unreadToReadLabel"/></div>
		<div class="unreadToReadDescription"><util:message key="hn.note.label.unreadToReadDescription"/></div>
		<div class="unreadToReadDescription"><util:message key="hn.note.label.unreadToReadDescription2"/></div>
		<div class="optionRows unreadToReadNotes">
			<div class="unreadToReadNotesLabel"><util:message key="hn.note.label.unreadNote"/></div>
			<div class="noteButton unreadToReadButton" onclick="javascript:enNote.readAllNotes();"><util:message key="hn.note.label.unreadToRead"/></div>
			<div class="optionAmount allunreadNoteAmount"><c:out value="${ option.allUnreadNoteAmount }"/></div>
		</div>
	</div>
	<div class="isReceiveNoteLayer">
		<div class="isReceiveNoteLabel"><util:message key="hn.note.label.receiveSettingLabel"/></div>
		<div class="isReceiveNoteDescription"><util:message key="hn.note.label.receiveSettingDescription"/></div>
		<div class="isReceiveNotes">
			<div class="radioButtons">
				<input type="radio" class="input_radio" id="isReceiveNoteY" name="isReceiveNote" value="1" checked="checked"/><label for="isReceiveNoteY"><util:message key="hn.note.label.receiveYes"/></label>
				<input type="radio" class="input_radio" id="isReceiveNoteN" name="isReceiveNote" value="0"/><label for="isReceiveNoteN"><util:message key="hn.note.label.receiveNo"/></label>
			</div>
			<div class="noteButton isReceiveNoteButton" onclick="javascript:enNote.receiveSetting();"><util:message key="hn.note.label.receiveSetting"/></div>
		</div>			
	</div>
	<script type="text/javascript">
		$('.input_radio').each(function(){
			if($(this).val() == <c:out value="${option.isReceiveNote}"/>){
				$(this).prop('checked', true);
			}
		});
	</script>
</form>