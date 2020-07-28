<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="portlet">
	<h2>(과)월별 <span>사건현황</span></h2>
	<div class="graph_box">
		<table>
			<tr>
				<th>구분</th>
				<th>내사</th>
				<th>입건</th>
			</tr>
			<c:forEach items="${monCountList }" var="mL">
				<tr>
					<td>${mL.month}</td>	
					<td>${mL.secinv }</td>
					<td>${mL.prsct }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<a href="#" class="more"><img src="/sjpb/images/icon_more.png" alt="더보기버튼"></a>
</div>
