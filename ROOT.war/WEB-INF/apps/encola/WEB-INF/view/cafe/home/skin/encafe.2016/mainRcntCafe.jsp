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
		<div class="rcntCafe">
			<div class="rcntCafeInfo">
				<label class="rcntCafeName empty">
					<a><util:message key="cf.error.not.exist.rcnt.cafe"/></a>
				</label>
			</div>
		</div>
	</c:if>
	<c:if test="${!empty rcntList}">
		<c:forEach items="${rcntList}" end="2" var="rcnt" varStatus="status">
			<div class="rcntCafe <c:if test="${status.index == 2}">last</c:if>" onclick="cfHome.go2Cafe('<c:out value="${rcnt.cmntUrl}"/>')">
				<div class="rcntCafeImg">
					<a class="rcntCafeImgLink" href="<%=evcp%>/cafe/<c:out value="${rcnt.cmntUrl}"/>"><img class="rcntCafeImgLinkImg" src="${rcnt.imgCmntImgUrl}" onerror="this.src='<%=evcp%>/cola/cafe/each/no.png'"/></a>
				</div>
				<div class="rcntCafeInfo">
					<label class="rcntCafeName">
						<a href="<%=evcp%>/cafe/<c:out value="${rcnt.cmntUrl}"/>"><c:out value="${rcnt.cmntNm}"/></a>
					</label>
					<label class="rcntCafeIntro ellipsis" title="<c:out value="${rcnt.cmntIntro}"/>"><c:out value="${rcnt.cmntIntro}"/></label>
					<label class="rcntCafeCateNm">카테고리: <c:out value="${rcnt.cateIdNm}"/></label>
					<label class="rcntCafeMakerNm">방문일시: <c:out value="${rcnt.accessDatimTPF}"/></label>
				</div>
			</div>
		</c:forEach>
	</c:if>
</c:if>