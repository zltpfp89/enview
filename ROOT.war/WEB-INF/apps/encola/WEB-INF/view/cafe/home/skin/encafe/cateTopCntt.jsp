<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%
	String evcp = request.getContextPath();
%>

<!-- 가입 신청한 카페 start -->
<div class="board_btn_wrap" style="margin-top:30px;">
	<div class="board_btn_wrap_left">
		<h3 class=""><util:message key="mm.title.category"/><%--카테고리--%><span> &gt; ${homeForm.cateNm}</span></h3>
	</div>
</div>
<c:if test="${empty cmntList}">
	<div class="sub_cafe_wrap">
		<div class="sub_cafe_cont" id="sub_cafe_tab1">
			<ul>
				<li style="border-top:1px solid #ddd">
					<div>
						<util:message key="cf.error.not.exist.cafe2"/>
					</div>
				</li>
			</ul>
		</div>
	</div>
</c:if>
<c:if test="${!empty cmntList}">
	<div class="sub_cafe_wrap">
		<div class="sub_cafe_cont" id="sub_cafe_tab1">
			<ul>
			<c:forEach items="${cmntList}" var="cmnt" >
				<li>
					<div class="img">
						<a class="cateCafeImgLink" href="<%=evcp%>/cafe/<c:out value="${cmnt.cmntUrl}"/>"><img src="${cmnt.imgCmntImgUrl}" onerror="this.src='<%=evcp%>/cola/cafe/each/no.png'"/></a>
					</div>
					<div class="txt">
						<div class="title">
							<a href="<%=evcp%>/cafe/<c:out value="${cmnt.cmntUrl}"/>"><c:out value="${cmnt.cmntNm}"/></a>
						</div>
						<div class="info">
							<span><util:message key="ev.title.grade"/><%--등급 --%> : <c:out value="${cmnt.cmntLevel}"/></span><span><util:message key="cf.title.mmbrCnt"/> : <c:out value="${cmnt.mmbrTotCF}"/> 명</span><span><util:message key="cf.title.sysop"/> : <c:out value="${cmnt.makerIdNm}"/> <util:message key="cf.prop.user"/></span>
						</div>
						<div class="cont ellipsis">
							<c:out value="${cmnt.cmntIntro}"/>
						</div>
					</div>
				</li>
			</c:forEach>
			</ul>
		</div>
	</div>
</c:if>