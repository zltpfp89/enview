<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
<c:if test="${!mmbrVO.isLogin}">
	<li style="padding-top:3px; margin-left: 15px;"><util:message key="eb.error.need.login"/></li>
</c:if>
<c:if test="${mmbrVO.isLogin}">
		<!-- 2013.03.28 추가. Daum 카페의 자주가는 카페와 같은 UI controller에서 mmbrList 객체를 받아서 이용한다. -->
	<c:if test="${empty rcntList}">
		<li style="padding-top:3px; margin-left: 15px;"><util:message key="cf.error.not.exist.rcnt.cafe"/></li><%--최근 방문한 카페가 존재하지 않습니다.--%>
	</c:if>
	<c:if test="${!empty rcntList}">
		<table class="table_type1" summary="추천카페">
			<caption>추천카페 리스트입니다</caption>
			<colgroup>
				<col width="120px" />
				<col width="365px" />
				<col width="93px" />
				<col width="*px" />
			</colgroup>
			<c:forEach items="${rcntList}" var="rcnt">
			<tr>
				<td scope="row" class="title">
					<div class="txt_over_el main_cafeLink" onclick="javascript:cfHome.go2Cafe('<c:out value="${rcnt.cmntUrl}"/>');"><c:out value="${rcnt.cmntNm}"/></div>
				</td>
				<td><div class="txt_over_el main_cafeIntro"><c:out value="${rcnt.cmntIntro}"/></div></td>
				<td class="type"><a class="txt_over_el"><c:out value="${rcnt.cateIdNm}"/></a></td>
				<td class="num Right" style="text-decoration: none;"><c:out value="${rcnt.accessDatimTPF}"/></td>
			</tr>
			</c:forEach>
		</table>
	</c:if>
</c:if>