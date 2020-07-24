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
				<label class="rcmdCafeName empty">
					<a><util:message key="eb.error.need.login"/></a>
				</label>
			</div>
		</li>
	</ul>
</c:if>
<c:if test="${mmbrVO.isLogin}">
	<c:if test="${cmntVO == null }">
		<ul>
			<li>
				<div>
					<label class="rcmdCafeName empty">
						<a><util:message key="cf.error.not.exist.rcmd.cafe"/></a>
					</label>
				</div>
			</li>
		</ul>
	</c:if>
	<c:if test="${cmntVO != null }">
		<c:set var="rcmdCount" value="0"/>
		<ul>
		<c:if test="${cmntVO != null }">
			<li>
				<div class="img">
					<a href="<%=evcp%>/cafe/<c:out value="${cmntVO.cmntUrl}"/>"><img class="rcmdCafeImgLinkImg" src="${cmntVO.imgCmntImgUrl}" onerror="this.src='<%=evcp%>/cola/cafe/each/no.png'"/></a>
				</div>
				<div class="txt">
					<div class="title"><a href="<%=evcp%>/cafe/<c:out value="${cmntVO.cmntUrl}"/>"><c:out value="${cmntVO.cmntNm}"/></a></div>
					<div class="info">
						<span><label class="cafe_title"><util:message key="ev.title.category"/><%--분류 --%></label>
							:&nbsp;<c:out value="${cmntVO.cateIdNm}"/></span>&nbsp;
						<span><label class="cafe_title"><util:message key="cf.title.sysop"/><%--시샵 --%></label>
							:&nbsp;<c:out value="${cmntVO.makerIdNm}"/></span>&nbsp; 
						<span><label class="cafe_title"><util:message key="cf.title.member"/><%--회원--%></label>
							:&nbsp;<c:out value="${cmntVO.mmbrTotCF}"/><util:message key="cf.title.persons"/><%--명 --%>
						</span>
					</div>
					<div class="cont">
						<c:out value="${cmntVO.cmntIntro}"/>
					</div>
				</div>
			</li>
		</c:if>
		<c:forEach items="${rcmdList}" var="rcmd" varStatus="status">
			<c:set var="rcmdCount" value="${status.count }"/>
			<li>
				<div class="img">
					<a href="<%=evcp%>/cafe/<c:out value="${rcmd.cmntUrl}"/>"><img class="rcmdCafeImgLinkImg" src="${rcmd.imgCmntImgUrl}" onerror="this.src='<%=evcp%>/cola/cafe/each/no.png'"/></a>
				</div>
				<div class="txt">
					<div class="title"><a href="<%=evcp%>/cafe/<c:out value="${rcmd.cmntUrl}"/>"><c:out value="${rcmd.cmntNm}"/></a></div>
					<div class="info">
						<span><label class="cafe_title"><util:message key="ev.title.category"/><%--분류 --%></label>
						 :&nbsp;<c:out value="${rcmd.cateIdNm}"/>
						</span>&nbsp;
						<span><label class="cafe_title"><util:message key="cf.title.sysop"/><%--시샵 --%></label>
						 :&nbsp;<c:out value="${rcmd.makerIdNm}"/>
						</span>&nbsp;
						<span><label class="cafe_title"><util:message key="cf.title.member"/><%--회원 --%></label>
						 :&nbsp;<c:out value="${rcmd.mmbrTotCF}"/><util:message key="cf.title.persons"/><%--명 --%>
						</span>
					</div>
					<div class="cont">
						<c:out value="${rcmd.cmntIntro}"/>
					</div>
				</div>
			</li>
		</c:forEach>
		</ul>
		<a href="#" onclick="cfHome.initCafeHome('mine.favor')" class="more"><util:message key="ev.prop.more"/> +</a>
	</c:if>
</c:if>
	