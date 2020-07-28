<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="portlet">
	<h2>디지털포렌식센터 <span>업무일정</span></h2>
	<div class="listArea">
		<ul class="list_scroll">
			<c:if test="${not empty forsScheduleList }">
				<c:forEach items="${forsScheduleList }" var="fL">
					<li>
						<a href="javascript:void();" class="lmenuOpen" id="tm002_sm004_lm001" data-root="tm002" data-title="포렌식수사지원요청" rel="/sjpb/G/G0101.face">
							<font color="#064594">[${fL.sort }]</font>${fL.criTmNm} 
						</a>
						<span class="date">${fL.fiDt }</span>
					</li>
				</c:forEach> 
			</c:if>
			<c:if test="${empty forsScheduleList }">
				디지털포렌식 업무일정이 없습니다.
			</c:if>
		</ul>
		<a href="javascript:void();" class="lmenuOpen more" id="tm002_sm004_lm001" data-root="tm002" data-title="포렌식수사지원요청" rel="/sjpb/G/G0101.face"><img src="/sjpb/images/icon_more.png" alt="더보기버튼"></a>
	</div>       
</div>        