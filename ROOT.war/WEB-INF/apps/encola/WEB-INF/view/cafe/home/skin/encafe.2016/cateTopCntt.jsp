<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String evcp = request.getContextPath();
%>
<c:if test="${empty cmntVO && empty cmntList}">
	<div class="cateCafe">
		<div class="cateCafeInfo">
			<label class="cateCafeName empty">
				<a>해당 카테고리에 카페가 존재하지 않습니다.</a>
			</label>
		</div>
	</div>
</c:if>
<c:if test="${!empty cmntVO || !empty cmntList}">
	<div class="cateCafe" onclick="cfHome.go2Cafe('<c:out value="${cmntVO.cmntUrl}"/>')">
		<div class="cateCafeImg">
			<a class="cateCafeImgLink" href="<%=evcp%>/cafe/<c:out value="${cmntVO.cmntUrl}"/>"><img class="cateCafeImgLinkImg" src="${cmntVO.imgCmntImgUrl}" onerror="this.src='<%=evcp%>/cola/cafe/each/no.png'"/></a>
		</div>
		<div class="cateCafeInfo">
			<label class="cateCafeName">
				<a href="<%=evcp%>/cafe/<c:out value="${cmntVO.cmntUrl}"/>"><c:out value="${cmntVO.cmntNm}"/></a>
			</label>
			<label class="cateCafeIntro ellipsis" title="<c:out value="${cmntVO.cmntIntro}"/>"><c:out value="${cmntVO.cmntIntro}"/></label>
			<label class="cateCafeLevel">등급: <c:out value="${cmntVO.cmntLevel}"/></label>
			<label class="cateCafeMmbrTot">회원수: <c:out value="${cmntVO.mmbrTotCF}"/> 명</label>
			<label class="cateCafeMakerNm">카페지기: <c:out value="${cmntVO.makerIdName}"/> 님</label>
		</div>
	</div>
	<c:forEach items="${cmntList}" var="cmnt" varStatus="status" begin="0" end="3">
		<div class="cateCafe<c:if test="${status.last }"> last</c:if>" onclick="cfHome.go2Cafe('<c:out value="${cmnt.cmntUrl}"/>')">
			<div class="cateCafeImg">
				<a class="cateCafeImgLink" href="<%=evcp%>/cafe/<c:out value="${cmnt.cmntUrl}"/>"><img class="cateCafeImgLinkImg" src="${cmnt.imgCmntImgUrl}" onerror="this.src='<%=evcp%>/cola/cafe/each/no.png'"/></a>
			</div>
			<div class="cateCafeInfo">
				<label class="cateCafeName">
					<a href="<%=evcp%>/cafe/<c:out value="${cmnt.cmntUrl}"/>"><c:out value="${cmnt.cmntNm}"/></a>
				</label>
				<label class="cateCafeIntro ellipsis"><c:out value="${cmnt.cmntIntro}"/></label>
				<label class="cateCafeLevel">등급: <c:out value="${cmntVO.cmntLevel}"/></label>
				<label class="cateCafeMmbrTot">회원수: <c:out value="${cmnt.mmbrTotCF}"/> 명</label>
				<label class="cateCafeMakerNm">카페지기: <c:out value="${cmntVO.makerIdName}"/> 님</label>
			</div>
		</div>
	</c:forEach>
</c:if>