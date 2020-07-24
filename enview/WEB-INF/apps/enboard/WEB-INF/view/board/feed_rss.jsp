<%@ page contentType="text/xml;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<rss version="2.0">
	<channel>
		<title><c:out value="${boardVO.boardTtl}"/></title>
		<link>/board/bltnMngr?boardId=<c:out value="${boardVO.boardId}"/></link>
		<description></description>
		<language>ko</language>
		<pubDate></pubDate>
		<generator></generator>
		<managingEditor>Saltware Co.,Ltd</managingEditor>
		<c:forEach items="${bltnList}" var="list">
			<item>
				<title><![CDATA[<c:out value="${list.bltnOrgSubj}" escapeXml="false"/>]]></title>
				<link>/board/list.brd?boardId=<c:out value="${boardVO.boardId}"/></link>
				<description><![CDATA[<c:out value="${list.bltnCntt}" escapeXml="false"/>]]></description>
				<category></category>
				<author><![CDATA[<c:out value="${list.userNick}" escapeXml="false"/>]]></author>
				<guid>/board/list.brd?boardId=<c:out value="${boardVO.boardId}"/></guid>
				<comments></comments>
				<pubDate><c:out value="${list.regDatim}"/></pubDate>
				<c:if test="${!empty list.fileList}">
					<c:set var="fileList" value="${list.fileList}"/>
					<c:forEach items="${fileList}" var="file">
						<c:if test="${boardVO.mergeType == 'A'}">
							<attachedFile uri="/fileMngr?cmd=down&amp;boardId=<c:out value="${boardVO.boardRid}"/>&amp;bltnNo=<c:out value="${file.bltnNo}"/>&amp;fileSeq=<c:out value="${file.fileSeq}"/>&amp;subId=sub06"/>
						</c:if>
						<c:if test="${boardVO.mergeType != 'A'}">
							<attachedFile uri="/fileMngr?cmd=down&amp;boardId=<c:out value="${list.eachBoardVO.boardRid}"/>&amp;bltnNo=<c:out value="${file.bltnNo}"/>&amp;fileSeq=<c:out value="${file.fileSeq}"/>&amp;subId=sub06"/>
						</c:if>
					</c:forEach>
				</c:if>
			</item>
		</c:forEach>
	</channel>
</rss>