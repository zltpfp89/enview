<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="portlet">
	<h2>팀별 <span>사건현황</span></h2>
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
				<c:forEach items="${tmList }" var="tm">
					<tr>
						<td class="C first_txt">${tm.criTmNm}</td>
						<td class="C">${tm.secinv }</td>
						<td class="C">${tm.papstmp }</td>
						<td class="C">${tm.prsct }</td>
						<td class="C">${tm.invst }</td>
						<td class="C">${tm.invstCmnd }</td>
						<td class="C">${tm.trnsr }</td>
						<td class="C">${tm.dsps }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<a href="#" class="more"><img src="/sjpb/images/icon_more.png" alt="더보기버튼"></a>
</div>
