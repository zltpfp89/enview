<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<form id="readForm" name="readForm" method="post">
	<input type="hidden" id="noteId" value="<c:out value="${note.noteId }"/>">
	<!-- title 영역 -->
	<div class="searchArea">
		<h1 class="title"><util:message key="hn.note.label.noteRead"/></h1>
	</div>
	<!-- title 영역// -->	
	<div class="result"></div>
	<!-- 버튼영역 -->
	<div class="btnArea">
		<a href="javascript:enNote.deleteNote(<c:out value="${note.noteId}"/>, <c:out value="${note.noteType}"/>, <c:out value="${note.viewBox}"/>);" class="btn_type01"><span><util:message key="hn.note.label.delete"/></span></a>
		<c:if test="${note.states == 1 }">
			<a href="javascript:enNote.storeNote(<c:out value="${note.noteId}"/>, <c:out value="${note.noteType}"/>);" class="btn_type01"><span><util:message key="hn.note.label.store"/></span></a>
		</c:if>
		<c:if test="${note.viewBox == 4 }">
			<a href="javascript:enNote.restoreNote(<c:out value="${note.noteId}"/>, <c:out value="${note.noteType}"/>);" class="btn_type01"><span><util:message key="hn.note.label.restore"/></span></a>
		</c:if>
		<c:if test="${note.viewBox < 4 and note.noteType == 1 }">
			<a href="javascript:enNote.viewReplyForm();" class="btn_type01"><span><util:message key="hn.note.label.reply"/></span></a>
		</c:if>
		<span class="pageBtn"><a href="javascript:enNote.viewBox('<c:out value="${ viewBoxName }"/>', <c:out value="${ note.currentPage }"/>);" class="btn_type01"><span><util:message key="hn.note.label.list"/></span></a></span>
	</div>
	<!-- 버튼영역//-->
	<!-- 테이블 -->
	<div class="tableArea">
		<table class="table_type02" summary="메세지쓰기폼입니다">
		<caption>메세지쓰기폼입니다.</caption>
			<colgroup>
			<col width="15%" />
			<col width="*%" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="col" class="first left"><util:message key="hn.note.label.sender"/></th>
					<td class="first left"><c:out value="${note.senderName}"/>(<c:out value="${note.senderId}"/>) <em><c:out value="${note.sendTime }"/></em></td>
				</tr>
				<tr>
					<th scope="col" class="left"><util:message key="hn.note.label.receiver"/></th>
					<td class="left get">
						<span id="deleRcvr" class="deleRcvr"><c:out value="${note.deleRcvrName}"/>(<c:out value="${note.deleRcvrId}"/>)<c:if test="${note.receiverAmount > 1 }"> <util:message key="hn.note.label.etal"/> <c:out value="${note.receiverAmount-1 }"/> <util:message key="hn.note.label.recepeopleAmountiver"/></c:if></span>
						<c:if test="${note.receiverAmount > 1 }">
							<a id="viewButton" href="javascript:enNote.viewReceivers();" class="btn_type01"><span><util:message key="hn.note.label.detail"/></span></a>
							<span id="receivers" style="display:none;"><c:out value="${note.receivers}"/></span>
						</c:if>
					</td>
				</tr>
				<tr>
					<th scope="col" class="left"><util:message key="hn.note.label.title"/></th>
					<td class="left"><c:out value="${note.title}"/></td>
				</tr>
				<tr>
					<th scope="col" class="left"><util:message key="hn.note.label.contents"/></th>
					<td class="left"><textarea id="contents" name="contents" style="height: 145px;" readonly="readonly"><c:out value="${note.contents }"/></textarea></td>
				</tr>
				<tr>
					<th scope="col" class="left"><util:message key="hn.note.label.files"/></th>
					<td class="left">
						<c:if test="${( note.fileIds != null && note.fileIds != '') }" var="yes_file">
							<iframe class="view_fileManager" id="fileManager" name="fileManager" src="<%=request.getContextPath()%>/tool/fileManager.hanc?m=downloadList&appsId=<c:out value="${note.noteId }"/>" width="511px" height="85px" frameborder="0"></iframe>
						</c:if>
						<c:if test="${ yes_file == false }">
						<util:message key="hn.note.label.noFiles"/>
						<script>
							$('#files').css('height', '30px');
						</script>
					</c:if>
					</td>
				</tr>
				<c:if test="${ note.noteType == 0 }">
				<tr>
					<th scope="col" class="left"><util:message key="hn.note.label.readCheck"/></th>
					<td class="left">
						<input id="checkY" class="input_radio" type="radio" value="1" name="readCheck" disabled="disabled">
						<label class="label_checkYN" for="checkY"><util:message key="hn.note.label.yes"/></label>
						<input id="checkN" class="input_radio" type="radio" checked="checked" value="0" name="readCheck" disabled="disabled">
						<label class="label_checkYN" for="checkN"><util:message key="hn.note.label.no"/></label>
						<script type="text/javascript">
						$('.input_radio').each(function(){
							if($(this).val() == <c:out value="${note.readCheck}"/>){
								$(this).attr('checked', 'checked');
							}
						});
					</script>
					</td>
				</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	<!-- 테이블//-->
	<!-- 버튼영역 -->
	<div class="btnArea">
		<a href="javascript:enNote.deleteNote(<c:out value="${note.noteId}"/>, <c:out value="${note.noteType}"/>, <c:out value="${note.viewBox}"/>);" class="btn_type01"><span><util:message key="hn.note.label.delete"/></span></a>
		<c:if test="${note.states == 1 }">
			<a href="javascript:enNote.storeNote(<c:out value="${note.noteId}"/>, <c:out value="${note.noteType}"/>);" class="btn_type01"><span><util:message key="hn.note.label.store"/></span></a>
		</c:if>
		<c:if test="${note.viewBox == 4 }">
			<a href="javascript:enNote.restoreNote(<c:out value="${note.noteId}"/>, <c:out value="${note.noteType}"/>);" class="btn_type01"><span><util:message key="hn.note.label.restore"/></span></a>
		</c:if>
		<c:if test="${note.viewBox < 4 and note.noteType == 1 }">
			<a href="javascript:enNote.viewReplyForm();" class="btn_type01"><span><util:message key="hn.note.label.reply"/></span></a>
		</c:if>
		<span class="pageBtn"><a href="javascript:enNote.viewBox('<c:out value="${ viewBoxName }"/>', <c:out value="${ note.currentPage }"/>);" class="btn_type01"><span><util:message key="hn.note.label.list"/></span></a></span>
	</div>
	<!-- 버튼영역//-->
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