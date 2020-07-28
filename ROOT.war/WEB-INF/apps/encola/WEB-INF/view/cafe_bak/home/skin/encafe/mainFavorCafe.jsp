<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
<c:if test="${!mmbrVO.isLogin}">
	<li style="padding-top:3px; margin-left: 15px;"><util:message key="eb.error.need.login"/></li><%--�α��� �ϼž� �մϴ�.--%>
</c:if>
<c:if test="${mmbrVO.isLogin}">
	<!-- 
	<c:if test="${empty favorList}">
		<li style="padding-top:3px; margin-left: 15px;"><util:message key="cf.error.not.exist.favor.cafe"/></li><%--등록된 자주가는 카페가 없습니다.--%>
	</c:if>
	<c:if test="${!empty favorList}">
		<table class="table_type1" summary="추천카페">
			<caption>추천카페 리스트입니다</caption>
			<colgroup>
				<col width="120px" />
				<col width="365px" />
				<col width="93px" />
				<col width="50px" />
				<col width="*px" />
			</colgroup>
			<c:forEach items="${favorList}" var="favor">
			<tr>
				<td scope="row" class="title">
					<div class="txt_over_el main_cafeLink" onclick="javascript:cfHome.go2Cafe('<c:out value="${favor.cmntUrl}"/>');"><c:out value="${favor.cmntNm}"/></div>
				</td>
				<td class="type"><a class="txt_over_el"><c:out value="${favor.cateIdNm}"/></a></td>
				<td class="member">회원수</td>
				<td class="num Right"><c:out value="${favor.mmbrTotCF}"/></td>
			</tr>
			</c:forEach>
		</table>
	</c:if>
	-->
	<!-- 2013.03.28 추가. Daum 카페의 자주가는 카페와 같은 UI controller에서 mmbrList 객체를 받아서 이용한다. -->
	<c:if test="${empty mmbrList}">
		<li style="padding-top:3px; margin-left: 15px;"><util:message key="cf.error.not.exist.favor.cafe"/></li><%--등록된 자주가는 카페가 없습니다.--%>
	</c:if>
	<c:if test="${!empty mmbrList}">
		<table class="table_type1" summary="자주가는카페">
			<caption>자주가는카페 리스트입니다</caption>
			<colgroup>
				<col width="120px" />
				<col width="365px" />
				<col width="93px" />
				<col width="50px" />
				<col width="*px" />
			</colgroup>
			<c:forEach items="${mmbrList}" var="mmbr">
			<tr>
				<td scope="row" class="title">
					<div class="txt_over_el main_cafeLink" onclick="javascript:cfHome.go2Cafe('<c:out value="${mmbr.cmntVO.cmntUrl}"/>');"><c:out value="${mmbr.cmntVO.cmntNm}"/></div>
				</td>
				<td class="type"><a class="txt_over_el"><c:out value="${mmbr.mmbrGrdNm}"/></a></td>
			</tr>
			</c:forEach>
		</table>
	</c:if>
</c:if>