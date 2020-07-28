<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="portlet">
	<h2>업무공지</h2>
	<div class="listArea">
		<ul class="list_scroll">
			<c:if test="${not empty noticeList}">
				<c:forEach items="${noticeList }" var="nL">
					<li>
						<a href="javascript:void();" class="lmenuOpen" id="tm004_sm001" data-root="tm004" data-title="업무공지" rel="/board/read.brd?boardId=sjpbnotice&&bltnNo=${nL.bltnNo}">
							${nL.bltnSubj}
							<c:if test="${nL.newYn == 1}">
								<img src="/sjpb/images/icon_new.png" alt="새 글" />
							</c:if>
						</a>
						<span class="date">${nL.regDatim }</span>
					</li>
				</c:forEach>
			</c:if>
			<c:if test="${empty noticeList}">
				업무 공지사항이 없습니다.
			</c:if>
		</ul>
		<a href="javascript:void();" class="lmenuOpen more" id="tm004_sm001" data-root="tm004" data-title="업무공지" rel="/board/list.brd?boardId=sjpbnotice"><img src="/sjpb/images/icon_more.png" alt="더보기버튼"></a>
	</div>   
</div>