<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.saltware.enboard.vo.BulletinVO"%>
<div id="errorMessage" style="display:none;"></div>
<% int ellipsisLen = 0;%>
<c:set var="frameType"  value="${param.frameType}"/>
<c:set var="brdGrpType" value="${param.brdGrpType}"/>
<c:set var="brdType"    value="${param.brdType}"/>
<c:if test="${brdGrpType == 'FLT10' || brdGrpType == 'FLT20'}">
	<c:if test="${frameType == 'ONE' || frameType == 'TWO1' || frameType == 'TWO2'}">
		<% ellipsisLen = 110;%>
	</c:if>
	<c:if test="${frameType != 'ONE' && frameType != 'TWO1' && frameType != 'TWO2'}">
		<% ellipsisLen = 86;%>
	</c:if>
</c:if> 
<c:if test="${brdGrpType != 'FLT10' && brdGrpType != 'FLT20'}">
	<c:if test="${frameType == 'ONE' || frameType == 'TWO1' || frameType == 'TWO2'}">
		<% ellipsisLen = 48;%>
	</c:if>
	<c:if test="${frameType != 'ONE' && frameType != 'TWO1' && frameType != 'TWO2'}">
		<% ellipsisLen = 40;%>
	</c:if>
</c:if>
<c:if test="${brdGrpType == 'MLT10' || brdGrpType == 'MRT10'}">
	<c:set var="rowCnt" value="1"/>
</c:if>
<c:if test="${brdGrpType == 'FLT10'}">
	<c:set var="rowCnt" value="2"/>
</c:if>
<c:if test="${brdGrpType == 'FLT20' || brdGrpType == 'MLT20' || brdGrpType == 'MRT20'}">
	<c:set var="rowCnt" value="5"/>
</c:if>
<div class="boardNameBorder CF0501_nmBrdrStyle CF0501_nmBrdrWidth CF0501_nmBrdrColor">			
	<div class="title">
		<a class="boardName CF0501_nmFontColor CF0501_nmFontNm" href="javascript:cfCntt.readBulletin('<c:out value="${boardVO.boardId}"/>');"><c:out value="${boardVO.boardNm}"/></a>
	</div>
	<div class="more">
		<a class="more_view" onclick="cfCntt.readBulletin('<c:out value="${boardVO.boardId}"/>')">
			<util:message key="ev.prop.more"/>+
		</a>
	</div>
</div>
<div class="edotor_boardDesc"><c:out value="${boardVO.boardTtl}"/></div>
<div class="boardList one_<c:out value="${brdGrpType}"/>">
	<input type="hidden" id="userNick_<%=request.getParameter("brdIndex")%>" name="userNick" value='<c:out value="${secPmsnVO.userNick}"/>'/>
	<input type="hidden" id="bltnSubj_<%=request.getParameter("brdIndex")%>" name="bltnSubj" value="한줄메모"/>
	<div class="editorCntt_div one_editor_<c:out value="${brdGrpType}"/>">
		<textarea id="editorCntt_<%=request.getParameter("brdIndex")%>" class="editorCntt CF0802_bgColor CF0802_extraBrdrColor" name="editorCntt" spellcheck="false"
			<c:if test="${secPmsnVO.ableWrite != true }"> readonly="readonly"</c:if>><c:if test="${secPmsnVO.ableWrite != true }">쓰기 권한이 없습니다.</c:if></textarea>
		<input type="hidden" name="bltnOrgCntt">
		<div class="editorCntt_limit">최대 600 Byte
		<input type="hidden" id="editorCnttMaxBytes_<%=request.getParameter("brdIndex")%>" name="editorCnttMaxBytes" value="600">
		</div>
	</div>
	<div class="editor_btn_div">
		<a class="editor_btn" name="memoReplyBtn_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>"<c:if test="${secPmsnVO.ableWrite == true }"> onclick="javascript:cfCntt.saveOnList('<%=request.getParameter("brdIndex")%>', '<c:out value="${boardVO.boardId}"/>');return false;"</c:if>>
			<span class="btn_bg bg01"></span><span class="btn_txt bt01" id="submit_<c:out value="${list.bltnNo}"/>_<c:out value="${mList.memoSeq}"/>">등록</span>
		</a>
	</div>
	<div class="one_list one_list_<c:out value="${brdGrpType}"/>">
		<table class="listTable"> 
			<!-- Bulletins are not exist.. -->
			<c:if test="${empty bltnList}">
				<tr class="listTr one">
					<td class="listTd one">등록된 게시글이 없습니다</td>
				</tr>
				<c:forEach begin="1" end="${rowCnt-1}" varStatus="status">	
				<tr class="listTr<c:if test="${status.last}"> last</c:if>">
					<td></td>
				</tr>					
				</c:forEach>
			</c:if>
			<!-- List of Bulletin -->
			<c:if test="${!empty bltnList}">
			<c:forEach items="${bltnList}" var="list" begin="0" end="${rowCnt-1}" varStatus="status">
			<tr class="listTr one CF0802_extraBrdrColor">
				<td class="listTd one">
					<span class="one_userNick"><c:out value="${list.userNick}"/></span>
					<span class="one_regDatim"><c:out value="${list.smartRegDatimSF}"/></span>
				</td>
			</tr>
			<tr class="listTr CF0802_extraBrdrColor">
				<td class="listTd">
					<% String bltnCnttEllipsis = ((BulletinVO)pageContext.getAttribute("list")).getBltnCnttEllipsis(ellipsisLen);%>
					<%=bltnCnttEllipsis%>
					<c:if test="${boardVO.ttlNewYn == 'Y'}">
						<span style="padding-right:10px"><c:if test="${list.recentBltn == 'Y'}"><img src="<%=request.getContextPath()%>/board/images/board/skin/cafe.one/imgNew.gif"/></c:if></span>
					</c:if>
				</td>
			</tr>
			</c:forEach>
			</c:if>		
		</table>
	</div>
</div>