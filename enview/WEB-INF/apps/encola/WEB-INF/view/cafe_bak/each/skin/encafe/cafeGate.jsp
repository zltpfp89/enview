<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--개별카페홈 최초 로딩 시에만 eachForm.view 에 'eachHome'이 할당된다/되어야 한다--%>
<input id="editorHeight" name="editorHeight" type="hidden" value="419px"/>
<c:if test="${eachForm.view == 'eachHome'}">
<div id="cafe_gate_wrap" class="cafe_gate_wrap">
	<div id="div_cafe_gate" class="cafe_gate CF0201_bgColor">
		<c:if test="${!param.isEditMode}">
			<div id="gateHtmlDiv" class="gateHtmlDiv">
				<c:out value="${gateHtml}" escapeXml="false"/>
			</div>
			<%--BEGIN::카페 공지글--%>
			<c:if test="${!empty noticeList}">
			<div class="boardNameBorder CF0501_nmBrdrStyle CF0501_nmBrdrColor">
				<div class="title">
					<a class="boardName CF0501_nmFontColor CF0501_nmFontNm">카페 공지</a>
				</div>
				<span class="boardPipe">|</span>
				<span class="boardDesc">알립니다!</span>
			</div>
			<div class="boardList">
				<table class="listTable"> 
					<c:forEach items="${noticeList}" var="notice" varStatus="status">						
						<tr class="listTr<c:if test="${status.last}"> last</c:if>">
							<td class="listTd CF0501_subjFontColor CF0501_subjFontSize CF0501_subjFontNm">
								<a class="bulLink" onclick="cfGate.showNoticeContent(true,'<c:out value="${notice.noticeId}"/>')">
								<c:out value="${notice.title}"/>
								</a>
							</td>
							<td class="listTd_userNick CF0501_subjFontColor CF0501_subjFontSize CF0501_subjFontNm" style="width: 150px;">
								<c:out value="${notice.updUserIdNm}"/>
							</td>
							<td class="listTd_regDatim CF0501_subjFontColor CF0501_subjFontSize CF0501_subjFontNm" style="width: 150px;">
								<c:out value="${notice.startDateSF}"/> ~ <c:out value="${notice.endDateSF}"/>
							</td>
						</tr>
						<tr id="noticeContent<c:out value="${notice.noticeId}"/>" name="noticeContent<c:out value="${notice.noticeId}"/>" style="border-width:1px;border-style:solid;border-color:#BDBDBD;display:none">
							<td colspan="2" style="padding:10px;word-wrap:break-word;word-break:break-all"><c:out value="${notice.contentOrg}" escapeXml="false"/></td>
							<td align="right" valign="top" style="margin-right:10px;width:70px">
								<span style="cursor:pointer" onclick="cfGate.showNoticeContent(false,'<c:out value="${notice.noticeId}"/>')" alt="닫기"><b>&nbsp;X&nbsp;</b></span>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			</c:if>
			<%--END::카페 공지글--%>
		</c:if>
		<c:if test="${param.isEditMode}">
			<div id="gateHtmlDiv" align=center style="overflow:hidden">
				<textarea id=gateHtmlEditor style="width:99%;height:500px;"><c:out value="${gateHtml}"/></textarea>
				<input type=hidden id=langKnd name=langKnd value="<c:out value="${cmntVO.langKnd}"/>"/>
				<input type=hidden id=cmntId  name=cmntId  value="<c:out value="${cmntVO.cmntId}"/>"/><br />
				<div class="apply_box">HTML 편집 후 저장하시면 대문영역에 나타납니다.</div>
				<a class="save_btn" onclick="javascript:cfGate.applyGateHtml(); return false;" style="padding-left:0px;">
					<span class="btn_bg bt03" style="width:4px;"></span>
					<span class="btn_txt bt03 w03" style="padding-right: 4px;"><util:message key="ev.title.save"/></span>
				</a>
			</div>
		</c:if>
	</div>
</div>
<div id="div_cafe_gate_blank" class="blank_area"></div>
</c:if>