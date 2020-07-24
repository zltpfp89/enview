<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
<c:if test="${cmntVO == null }">
	<div class="rcmdCafe">
		<div class="rcmdCafeInfo">
			<label class="rcmdCafeName empty">
				<a><util:message key="cf.error.not.exist.rcmd.cafe"/></a>
			</label>
		</div>
	</div>
</c:if>
<c:if test="${cmntVO != null }">
	<div class="rcmdCafe" onclick="cfHome.go2Cafe('<c:out value="${cmntVO.cmntUrl}"/>')">
		<div class="rcmdCafeImg">
			<a class="rcmdCafeImgLink" href="<%=evcp%>/cafe/<c:out value="${cmntVO.cmntUrl}"/>"><img class="rcmdCafeImgLinkImg" src="${cmntVO.imgCmntImgUrl}" onerror="this.src='<%=evcp%>/cola/cafe/each/no.png'"/></a>
		</div>
		<div class="rcmdCafeInfo">
			<label class="rcmdCafeName">
				<a href="<%=evcp%>/cafe/<c:out value="${cmntVO.cmntUrl}"/>"><c:out value="${cmntVO.cmntNm}"/></a>
			</label>
			<label class="rcmdCafeIntro ellipsis" title="<c:out value="${cmntVO.cmntIntro}"/>"><c:out value="${cmntVO.cmntIntro}"/></label>
			<label class="rcmdCafeCateNm">카테고리: <c:out value="${cmntVO.cateIdNm}"/>&nbsp;/&nbsp;</label><label class="rcmdCafeLevel">등급: <c:out value="${cmntVO.cmntLevel}"/></label>
			<label class="rcmdCafeMmbrTot">회원수: <c:out value="${cmntVO.mmbrTotCF}"/> 명</label>
			<label class="rcmdCafeMakerNm">카페지기: <c:out value="${cmntVO.makerIdName}"/> 님</label>
		</div>
	</div>
</c:if>
<c:set var="rcmdCount" value="0"/>
<c:forEach items="${rcmdList}" var="rcmd" varStatus="status">
	<c:set var="rcmdCount" value="${status.count }"/>
	<div class="rcmdCafe other<c:if test="${status.index+1 >= 3 }"> last</c:if>" onclick="cfHome.go2Cafe('<c:out value="${rcmd.cmntUrl}"/>')">
		<div class="rcmdCafeImg">
			<a class="rcmdCafeImgLink" href="<%=evcp%>/cafe/<c:out value="${rcmd.cmntUrl}"/>"><img class="rcmdCafeImgLinkImg" src="${rcmd.imgCmntImgUrl}" onerror="this.src='<%=evcp%>/cola/cafe/each/no.png'"/></a>
		</div>
		<div class="rcmdCafeInfo other">
			<label class="rcmdCafeName">
				<a href="<%=evcp%>/cafe/<c:out value="${rcmd.cmntUrl}"/>"><c:out value="${rcmd.cmntNm}"/></a>
			</label>
			<label class="rcmdCafeIntro ellipsis" title="<c:out value="${rcmd.cmntIntro}"/>"><c:out value="${rcmd.cmntIntro}"/></label>
			<label class="rcmdCafeCateNm"><c:out value="${rcmd.cateIdNm}"/>&nbsp;/&nbsp;</label><label class="rcmdCafeLevel"><c:out value="${rcmd.cmntLevel}"/></label>
			<label class="rcmdCafeMmbrTot"><c:out value="${rcmd.mmbrTotCF}"/> 명</label>
			<label class="rcmdCafeMakerNm"><c:out value="${rcmd.makerIdName}"/> 님</label>
		</div>
	</div>
</c:forEach>
<c:forEach begin="1" end="${4-rcmdCount}" var="rcmd" varStatus="status">
	<div class="rcmdCafe other<c:if test="${4-rcmdCount - status.count < 2}"> last</c:if>"></div>
</c:forEach>