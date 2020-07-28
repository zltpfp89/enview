<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
<c:if test="${!mmbrVO.isLogin}">
	<ul>
		<li>
			<div>
				<label class="mmbrCafeName empty">
					<a><util:message key="eb.error.need.login"/></a>
				</label>
			</div>
		</li>
	</ul>
</c:if>
<c:if test="${mmbrVO.isLogin}">
	<!-- 2013.03.28 추가. Daum 카페의 자주가는 카페와 같은 UI controller에서 mmbrList 객체를 받아서 이용한다. -->
	<c:if test="${empty mmbrList}">
		<ul>
			<li>
				<div>
					<label class="mmbrCafeName empty">
						<a><util:message key="cf.error.not.exist.mmbr.cmntVO.cafe"/></a>
					</label>
				</div>
			</li>
		</ul>
	</c:if>
	<c:if test="${!empty mmbrList}">
	<ul>
		<c:set var="favorCount" value="0"/>
		<c:forEach items="${mmbrList}" var="mmbr" varStatus="status" >
			<c:set var="favorCount" value="${status.count }"/>
			<li>
				<div class="img">
					<a href="<%=evcp%>/cafe/<c:out value="${mmbr.cmntVO.cmntUrl}"/>"><img class="favorCafeImgLinkImg" src="${mmbr.cmntVO.imgCmntImgUrl}" onerror="this.src='<%=evcp%>/cola/cafe/each/no.png'"/></a>
				</div>
				<div class="txt">
					<div class="title"><a href="<%=evcp%>/cafe/<c:out value="${mmbr.cmntVO.cmntUrl}"/>"><c:out value="${mmbr.cmntVO.cmntNm}"/></div>
					<div class="info">
						<span><label class="cafe_title"><util:message key="ev.title.category"/><%--분류 --%></label>
							 :&nbsp;<c:out value="${mmbr.cmntVO.cateIdNm}"/>
						</span>&nbsp;
						<span><label class="cafe_title"><util:message key="cf.title.sysop"/><%--시샵 --%></label>
							 :&nbsp;<c:out value="${mmbr.cmntVO.makerIdNm}"/>
						</span>&nbsp;
						<span><label class="cafe_title"><util:message key="cf.title.member"/><%--회원 --%></label>
							 :&nbsp;<c:out value="${mmbr.cmntVO.mmbrTotCF}"/><util:message key="cf.title.persons"/><%--명 --%>
						</span>
					</div>
					<div class="cont">
						<c:out value="${mmbr.cmntVO.cmntIntro}"/>
					</div>
				</div>
			</li>
		</c:forEach>
	</ul>
	<a href="#" onclick="cfHome.initCafeHome('mine.favor')" class="more"><util:message key="ev.prop.more"/> +</a>
	</c:if>
</c:if>
