<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div>
팀원 사건현황<br>
<table>
	<tr>
		<th>구분</th>
		<th>내사</th>
		<th>인지</th>
		<th>입건</th>
		<th>수사</th>
		<th>수사지휘건</th>
		<th>송치</th>
		<th>처분</th>
	</tr>
	<c:forEach items="${tmList }" var="tm">
		<tr>	
			<td>${tm.secinv }</td>
			<td>${tm.papstmp }</td>
			<td>${tm.prsct }</td>
			<td>${tm.invst }</td>
			<td>${tm.invstCmnd }</td>
			<td>${tm.trnsr }</td>
			<td>${tm.dsps }</td>
		</tr>
	</c:forEach>
</table>
</div>