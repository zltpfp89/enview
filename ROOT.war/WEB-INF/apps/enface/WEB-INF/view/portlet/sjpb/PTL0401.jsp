<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="portlet">
	<h2>팀원 <span>사건현황</span></h2>
	<div class="event_list">
		<table class="list" cellpadding="0" cellspacing="0">
			<colgroup>
				<col width="*%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="*%" />
				<col width="10%" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th class="C">구분</th>
					<th class="C">내사</th>
					<th class="C">인지</th>
					<th class="C">입건</th>
					<th class="C">수사</th>
					<th class="C">수사지휘 건의</th>
					<th class="C">송치</th>
					<th class="C">처분</th>
				</tr>
			</thead>
		</table>
		<table class="list event_scroll" cellpadding="0" cellspacing="0">
			<colgroup>
				<col width="*%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="*%" />
				<col width="10%" />
				<col width="10%" />
			</colgroup>                        
			<tbody>
				<c:forEach items="${tMateList }" var="tM">
					<tr>
						<td class="C first_txt">${tM.nmKor}</td>
						<td class="C">${tM.secinv }</td>
						<td class="C">${tM.papstmp }</td>
						<td class="C">${tM.prsct }</td>
						<td class="C">${tM.invst }</td>
						<td class="C">${tM.invstCmnd }</td>
						<td class="C">${tM.trnsr }</td>
						<td class="C">${tM.dsps }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<a href="#" class="more"><img src="/sjpb/images/icon_more.png" alt="더보기버튼"></a>
</div>