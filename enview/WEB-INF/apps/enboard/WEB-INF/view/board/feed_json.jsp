<%@ page contentType="text/xml;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<jsp:scriptlet>
	pageContext.setAttribute("fromNewLine", "\r\n");
	pageContext.setAttribute("toNewLine", "\\n");
</jsp:scriptlet>
[
<c:if test="${empty bltnList}">
	{
		"boardId": "no",
		"bltnNo": "no",
		"bltnSubj": "등록된 글이 없습니다.",
		"regDatim": "",
		"bltnCntt": "",
		"fileList": [],
		"isFirst": true,
		"isLast": true
	}
</c:if>
<c:forEach items="${bltnList}" var="list" varStatus="status">
	{
		"boardId": "<c:out value="${list.boardId }"/>",
		"bltnNo": "<c:out value="${list.bltnNo }"/>",
		"bltnSubj": "<util:json value="${list.bltnOrgSubj}"/>",
		"regDatim": "<c:out value="${fn:substring(list.regDatimSF, 5, fn:length(list.regDatimSF))}"/>",
		"bltnCntt": "<util:json value="${list.bltnOrgCntt}"/>",
		"fileList": [
		<c:if test="${!empty list.fileList}">
			<c:set var="fileList" value="${list.fileList}"/>
			<c:forEach items="${fileList}" var="file" varStatus="fileStatus">
				<c:if test="${boardVO.mergeType == 'A'}">
					{ "url": "/fileMngr?cmd=down&amp;boardId=<c:out value="${boardVO.boardRid}"/>&amp;bltnNo=<c:out value="${file.bltnNo}"/>&amp;fileSeq=<c:out value="${file.fileSeq}"/>&amp;subId=sub06" }
				</c:if>
				<c:if test="${boardVO.mergeType != 'A'}">
					{ "url": "/fileMngr?cmd=down&amp;boardId=<c:out value="${list.eachBoardVO.boardRid}"/>&amp;bltnNo=<c:out value="${file.bltnNo}"/>&amp;fileSeq=<c:out value="${file.fileSeq}"/>&amp;subId=sub06" }
				</c:if>
				<c:if test="${!fileStatus.last}">,</c:if>
			</c:forEach>
		</c:if>
		],
		"isFirst": "<c:out value="${status.first}"/>",
		"isLast": "<c:out value="${status.last}"/>"
	} <c:if test="${!status.last}">,</c:if>
</c:forEach>
]