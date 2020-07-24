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
	<c:if test="${empty mmbrList}">
		<div class="favorCafe first empty" onclick="cfHome.go2Cafe('<c:out value="${mmbr.cmntVO.cmntUrl}"/>')">
			<div class="favorCafeInfo">
				<label class="favorCafeName empty">
					<a><util:message key="cf.error.not.exist.mmbr.cmntVO.cafe"/></a>
				</label>
			</div>
		</div>
	</c:if>
	<c:if test="${!empty mmbrList}">
		<c:set var="favorCount" value="0"/>
		<c:forEach items="${mmbrList}" var="mmbr" varStatus="status" end="5">
			<c:set var="favorCount" value="${status.count }"/>
			<div class="favorCafe other<c:if test="${status.index < 2 }"> first</c:if><c:if test="${status.index+1 >= 5 }"> last</c:if>" onclick="cfHome.go2Cafe('<c:out value="${mmbr.cmntVO.cmntUrl}"/>')">
				<div class="favorCafeImg">
					<a class="favorCafeImgLink" href="<%=evcp%>/cafe/<c:out value="${mmbr.cmntVO.cmntUrl}"/>"><img class="favorCafeImgLinkImg" src="${mmbr.cmntVO.imgCmntImgUrl}" onerror="this.src='<%=evcp%>/cola/cafe/each/no.png'"/></a>
				</div>
				<div class="favorCafeInfo other">
					<label class="favorCafeName">
						<a href="<%=evcp%>/cafe/<c:out value="${mmbr.cmntVO.cmntUrl}"/>"><c:out value="${mmbr.cmntVO.cmntNm}"/></a>
					</label>
					<label class="favorCafeIntro ellipsis" title="<c:out value="${mmbr.cmntVO.cmntIntro}"/>"><c:out value="${mmbr.cmntVO.cmntIntro}"/></label>
					<label class="favorCafeCateNm"><c:out value="${mmbr.cmntVO.cateIdNm}"/>&nbsp;/&nbsp;</label><label class="favorCafeLevel"><c:out value="${mmbr.cmntVO.cmntLevel}"/></label>
					<label class="favorCafeMmbrTot"><c:out value="${mmbr.cmntVO.mmbrTotCF}"/> 명</label>
					<label class="favorCafeMakerNm"><c:out value="${mmbr.cmntVO.makerIdName}"/> 님</label>
				</div>
			</div>
		</c:forEach>
		<c:if test="${favorCount <= 4 }">
			<c:forEach begin="1" end="${4-favorCount}" var="favor" varStatus="status">
				<div class="favorCafe other<c:if test="${4-favorCount - status.count < 2}"> last</c:if>"></div>
			</c:forEach>
		</c:if>
	</c:if>
</c:if>
