<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
<c:if test="${cmntVO == null }">
	<li style="padding-top:3px; margin-left: 15px;"><util:message key="cf.error.not.exist.rcmd.cafe"/></li><%--추천카페가 존재하지 않습니다.--%>
</c:if>
<c:if test="${cmntVO != null }">
<dl>
	<dt><a href="<%=evcp%>/cafe/<c:out value="${cmntVO.cmntUrl}"/>"><c:out value="${cmntVO.thumbImgCmntImg}" escapeXml="false"/></a></dt>
	<dd class="title"><c:out value="${cmntVO.cmntNm}"/></dd>
	<dd class="cafe_pr"><c:out value="${cmntVO.cmntIntro}"/></dd>
	<dd class="mamberNum">회원수 <span><c:out value="${cmntVO.mmbrTotCF}"/></span></dd>
</dl>
</c:if>
<table class="table_type1" summary="추천카페">
	<caption>추천카페 리스트입니다</caption>
	<colgroup>
		<col width="120px" />
		<col width="365px" />
		<col width="93px" />
		<col width="50px" />
		<col width="*px" />
	</colgroup>
	<c:forEach items="${rcmdList}" var="rcmd">
	<tr>
		<td scope="row" class="title">
			<div class="txt_over_el main_cafeLink" onclick="javascript:cfHome.go2Cafe('<c:out value="${rcmd.cmntUrl}"/>');"><c:out value="${rcmd.cmntNm}"/></div>
		</td>
		<td><div class="txt_over_el main_cafeIntro"><c:out value="${rcmd.cmntIntro}"/></div></td>
		<td class="type"><a class="txt_over_el"><c:out value="${rcmd.cateIdNm}"/></a></td>
		<td class="member">회원수</td>
		<td class="num Right"><c:out value="${rcmd.mmbrTotCF}"/></td>
	</tr>
	</c:forEach>
</table>