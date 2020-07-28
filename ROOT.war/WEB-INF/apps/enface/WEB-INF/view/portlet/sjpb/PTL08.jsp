<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="portlet">
	<h2>부서<span>일정</span></h2>
	<div class="listDeptArea">
		<ul class="list_scroll">
			<c:if test="${not empty  ScheList}">
				<c:forEach items="${ScheList }" var="sL">
					<li><a href="javascript:void(0);" class="lmenuOpen" id="tm004_sm003" target="_self" rel="/calendar/calendar.hanc" rel2="" data-root="tm004" data-title="부서일정" style="">${sL.name}</a><span class="date">${sL.startDatim }~${sL.endDatim }</span></li>
				</c:forEach>
			</c:if>
			<c:if test="${empty ScheList}">
				부서일정이 없습니다.
			</c:if>
		</ul>
		<a href="javascript:void(0);" class="lmenuOpen more" id="tm004_sm003" target="_self" rel="/calendar/calendar.hanc" rel2="" data-root="tm004" data-title="부서일정"><img src="/sjpb/images/icon_more.png" alt="더보기버튼"></a>
	</div>   
</div>