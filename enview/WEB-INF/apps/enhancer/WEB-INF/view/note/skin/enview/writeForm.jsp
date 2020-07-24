<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<c:if test="${note.receiverIds != 'undefined'}" var="isPopup" />
<form name="writeForm" id="writeForm" action="write.hanc" method="post">
	<!-- title 영역 -->
	<div class="searchArea">
		<h1 id="workTitle" class="title"><util:message key="hn.note.label.noteWrite"/></h1>
	</div>
	<div class="result" style="height: 0px; "></div>
	<c:if test="${!isPopup }">	
		<!-- 버튼영역 -->
		<div class="btnArea">
			<span class="pageBtn">
				<a href="javascript:enNote.viewReceiveBox();" class="btn_type01"><span><util:message key="hn.note.label.list"/></span></a>
			</span>
		</div>
	</c:if>
	<!-- 테이블 -->
	<div class="tableArea">
		<input type="hidden" id="receiverIds" name="receiverIds" value="<c:out value="${note.receiverIds }"/>">
		<table class="table_type02" summary="메세지쓰기폼입니다">
		<caption>메세지쓰기폼입니다.</caption>
			<colgroup>
			<col width="15%" />
			<col width="*%" />
			</colgroup>
			<tbody>
				<c:if test="${!isPopup }">
				<tr>
					<th scope="col" class="first left"><util:message key="hn.note.label.receiver"/></th>
					<td class="first left">
						<input type="text" id="receiverNames" name="receiverNames" class="txt<c:if test="${isPopup }">_pop</c:if>" readonly="readonly" value="<c:out value="${note.receiverNames }"/>"> <a href="javascript:enNote.search();" class="btn_type01"><span><util:message key="hn.note.label.receiver"/></span></a>
					</td>
				</tr>
				</c:if>
				<tr>
					<th scope="col" class="left"><util:message key="hn.note.label.title"/></th>
					<td class="left"><input type="text" id="title" name="title" class="txt<c:if test="${isPopup }">_pop</c:if>" value="<c:out value="${note.title }"/>"></td>
				</tr>
				<tr>
					<th scope="col" class="left"><util:message key="hn.note.label.contents"/></th>
					<td class="left"><textarea id="contents" name="contents" style="height: 145px;" onkeyup="javascript:enNote.checkLength();"><c:out value="${note.contents }"/></textarea><div id="limits" class="limits">0/1000</div></td>
				</tr>
				<tr>
					<th scope="col" class="left"><util:message key="hn.note.label.files"/></th>
					<td class="left">
						<iframe class="write_fileManager" id="fileManager" name="fileManager" src="<%=request.getContextPath()%>/tool/fileManager.hanc" width="511px" height="118px" frameborder=0></iframe>
					</td>
				</tr>
				<tr>
					<th scope="col" class="left"><util:message key="hn.note.label.readCheck"/></th>
					<td class="left">
						<input id="checkY" class="input_radio" type="radio" value="1" name="readCheck">
						<label class="label_checkYN" for="checkY"><util:message key="hn.note.label.yes"/></label>
						<input id="checkN" class="input_radio" type="radio" checked="checked" value="0" name="readCheck">
						<label class="label_checkYN" for="checkN"><util:message key="hn.note.label.no"/></label>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- 테이블//-->
	<div class="btnArea_C">
		<a class="btn_type03"><span style="cursor:pointer;" onclick="javascript:enNote.validationWrite();"><util:message key="hn.note.label.send"/></span></a>
	</div>
	<c:if test="${!isPopup }">
	<div class="btnArea">
		<span class="pageBtn">
			<a href="javascript:enNote.viewReceiveBox();" class="btn_type01"><span><util:message key="hn.note.label.list"/></span></a>
		</span>
	</div>
	</c:if>
</form>
<input type="hidden" id="isPopup" />