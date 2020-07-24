<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<form id="settingForm" name="settingForm" method="post">
	<ul class="setBox">
		<li class="title"><util:message key="hn.note.label.emptyLabel"/></li>
		<li class="explain"><util:message key="hn.note.label.emptyDescription"/><br />
		<util:message key="hn.note.label.emptyDescription2"/>
			<ul class="btn_box">
				<li><util:message key="hn.note.label.receiveBox"/><strong><c:out value="${ option.allReceiveNoteAmount }"/></strong><a href="javascript:enNote.emptyReceiveBox();" class="btn_type01"><span><util:message key="hn.note.label.emptyBox"/></span></a></li>
				<li><util:message key="hn.note.label.sendBox"/><strong><c:out value="${ option.allSendNoteAmount }"/></strong><a href="javascript:enNote.emptySendBox();" class="btn_type01"><span><util:message key="hn.note.label.emptyBox"/></span></a></li>
				<li><util:message key="hn.note.label.readCheckBox"/><strong><c:out value="${ option.allReadCheckNoteAmount }"/></strong><a href="javascript:enNote.emptyReadCheckBox();" class="btn_type01"><span><util:message key="hn.note.label.emptyBox"/></span></a></li>
				<li><util:message key="hn.note.label.recyclebinBox"/><strong><c:out value="${ option.allRecyclebinNoteAmount }"/></strong><a href="javascript:enNote.emptyRecyclebinBox();" class="btn_type01"><span><util:message key="hn.note.label.emptyBox"/></span></a></li>
			</ul>
		</li>
	</ul>
	<ul class="setBox">
		<li class="title"><util:message key="hn.note.label.backupLabel"/></li>
		<li class="explain"><util:message key="hn.note.label.backupDescription"/><br />
		<util:message key="hn.note.label.backupDescription2"/>
			<ul class="btn_box ">
				<li><util:message key="hn.note.label.receiveBox"/><strong><c:out value="${ option.allReceiveNoteAmount }"/></strong><a href="javascript:enNote.backupReceiveBox();" class="btn_type01"><span><util:message key="hn.note.label.backupBox"/></span></a></li>
				<li><util:message key="hn.note.label.sendBox"/><strong><c:out value="${ option.allSendNoteAmount }"/></strong><a href="javascript:enNote.backupSendBox();" class="btn_type01"><span><util:message key="hn.note.label.backupBox"/></span></a></li>
				<li><util:message key="hn.note.label.storeBox"/><strong><c:out value="${ option.allStoreNoteAmount }"/></strong><a href="javascript:enNote.backupStoreBox();" class="btn_type01"><span><util:message key="hn.note.label.backupBox"/></span></a></li>
			</ul>
		</li>
	</ul>
	<ul class="setBox">
		<li class="title"><util:message key="hn.note.label.unreadToReadLabel"/></li>
		<li class="explain"><util:message key="hn.note.label.unreadToReadDescription"/><br />
		<util:message key="hn.note.label.unreadToReadDescription2"/>
			<ul class="btn_box">
				<li><span><util:message key="hn.note.label.unreadNote"/><strong><c:out value="${ option.allUnreadNoteAmount }"/></strong></span><a href="javascript:enNote.readAllNotes();" class="btn_type01"><span><util:message key="hn.note.label.unreadToRead"/></span></a></li>
			</ul>
		</li>
	</ul>
	<ul class="setBox">
		<li class="title"><util:message key="hn.note.label.receiveSettingLabel"/></li>
		<li class="explain"><util:message key="hn.note.label.receiveSettingDescription"/></li>
			<ul class="btn_box">
				<li><span><input id="isReceiveNoteY" name="isReceiveNote" value="1" checked="checked" class="input_radio" type="radio">
					<label class="label_checkYN" for="isReceiveNoteY"><util:message key="hn.note.label.receiveYes"/></label>
					<input id="isReceiveNoteN" name="isReceiveNote" value="0" class="input_radio" type="radio">
					<label class="label_checkYN" for="isReceiveNoteN"><util:message key="hn.note.label.receiveNo"/></label></span>
					<a href="javascript:enNote.receiveSetting();" class="btn_type01"><span><util:message key="hn.note.label.receiveSetting"/></span></a></li>
			</ul>
		</li>
	</ul>
	<script type="text/javascript">
		$('.input_radio').each(function(){
			if($(this).val() == <c:out value="${option.isReceiveNote}"/>){
				$(this).prop('checked', true);
			}
		});
	</script>
</form>