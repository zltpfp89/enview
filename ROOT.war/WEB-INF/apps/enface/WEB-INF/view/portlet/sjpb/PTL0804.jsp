<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="portlet">
	<h2><span>전체일정</span></h2>
	<div class="listArea">
		<ul class="list_scroll">
			<c:if test="${not empty  totalScheList}">
				<c:forEach items="${totalScheList }" var="sL">
					<li><a href="#">${sL.name}</a><span class="date">${sL.startDatim }</span></li>
				</c:forEach>
			</c:if>
			<c:if test="${empty totalScheList}">
				전체일정이 없습니다.
			</c:if>
		</ul>
		<a href="#" class="more"><img src="/sjpb/images/icon_more.png" alt="더보기버튼"></a>
	</div>   
</div>