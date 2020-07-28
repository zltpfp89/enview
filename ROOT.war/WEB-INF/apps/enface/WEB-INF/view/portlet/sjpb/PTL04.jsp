<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="portlet">
	<h2>${part}<span>사건현황</span></h2>
	<div class="event_list">
		<div class="table_title">
			<table class="list" cellpadding="0" cellspacing="0">
				<colgroup>
					<col width="*%" />
					<col width="12%" />
					<col width="12%" />
					<col width="12%" />
					<col width="12%" />
					<col width="12%" />
					<col width="12%" />
				</colgroup>  
				<thead>
					<tr class="top">
						<th rowspan="2" class="C">구분</th>
						<th rowspan="2" class="C">내사</th>
						<th colspan="2" class="C">수사중</th>
						<th rowspan="2" class="C">지휘</th>
						<th colspan="2" class="C">송치</th>
					</tr>
					<tr>
						<th class="C">고발</th>
						<th class="C">인지</th>
						<th class="C">고발</th>
						<th class="C">인지</th>
					</tr>
				</thead>
			</table>
		</div>
		<div class="event_scroll">
			<table class="list" cellpadding="0" cellspacing="0">
				<colgroup>
					<col width="*%" />
					<col width="12%" />
					<col width="12%" />
					<col width="12%" />
					<col width="12%" />
					<col width="12%" />
					<col width="12%" />
				</colgroup>                        
				<tbody>
					<c:forEach items="${sortList}" var="sL" varStatus="status">
						<tr <c:if test="${status.index == 0 }">class="txt_on"</c:if>>
							<td class="C first_txt">${sL.sort}</td>
							<td class="C">${sL.secinv}</td>
							<td class="C">${sL.accuse}</td>
							<td class="C">${sL.papstmp}</td>
							<td class="C">${sL.cmnd}</td>
							<td class="C">${sL.trnAccus}</td>
							<td class="C">${sL.trnPapst}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>