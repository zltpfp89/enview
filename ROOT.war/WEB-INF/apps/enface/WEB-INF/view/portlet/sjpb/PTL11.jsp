<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="portlet" uri="http://java.sun.com/portlet_2_0" %>

<div class="portlet p_22">
	<h2>기소중지<span> 현황</span></h2>
	<div class="table_title">
		<table class="list" cellpadding="0" cellspacing="0">
			<colgroup>
				<col width="20%" />
				<col width="12%" />
				<col width="*%" />
				<col width="12%" />
			</colgroup>   
			<thead>
				<tr class="top">
					<th class="C">사건번호</th>
					<th class="C">수사분야</th>
					<th class="C">사건내용</th>
					<th class="C">담당수사관</th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="event_scroll">
		
		<table class="list" cellpadding="0" cellspacing="0">
			<colgroup>
				<col width="20%" />
				<col width="12%" />
				<col width="*%" />
				<col width="12%" />
			</colgroup>                        
			<tbody>
				<c:if test="${not empty stopProcList}">
					<c:forEach items="${stopProcList}" var="stop">
						<tr>
							<td class="C first_txt"><a href="javascript:void();" class="lmenuOpen" id="tm001_sm002" data-root="tm001" data-title="사건관리(인지/고발)" rel="/sjpb/B/B0101.face?rcptNum=${stop.rcptNum }">${stop.rcptIncNum }</a></td>
							<td class="L">${stop.fdCdDesc }</td>
							<td class="C"><a href="javascript:void();" class="lmenuOpen" id="tm001_sm002" data-root="tm001" data-title="사건관리(인지/고발)" rel="/sjpb/B/B0101.face?rcptNum=${stop.rcptNum }">${stop.vioCont }</a></td>
							<td class="C">${stop.nmKor }</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty stopProcList}">
					<tr>
						<td class="C" colspan="4">
							기소중지 현황이 없습니다.
						</td>
					</tr>
				</c:if>					
			</tbody>
		</table>	
	</div>
</div>