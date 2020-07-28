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
				<label class="rcntCafeName empty">
					<a><util:message key="eb.error.need.login"/></a>
				</label>
			</div>
		</li>
	</ul>
</c:if>
<c:if test="${mmbrVO.isLogin}">
		<!-- 2013.03.28 추가. Daum 카페의 자주가는 카페와 같은 UI controller에서 mmbrList 객체를 받아서 이용한다. -->
	<c:if test="${empty rcntList}">
		<ul>
		<li>
			<div>
				<label class="rcmdCafeName empty">
					<a><util:message key="cf.error.not.exist.rcnt.cafe"/></a>
				</label>
			</div>
		</li>
	</ul>
	</c:if>
	<c:if test="${!empty rcntList}">
	<c:set var="rcntCount" value="0"/>
		<ul>
			<c:forEach items="${rcntList}" var="rslt" varStatus="status" >
				<c:set var="rcmdCount" value="${status.count }"/>
				<li>
					<div class="img">
						<a href="<%=evcp%>/cafe/<c:out value="${rslt.cmntUrl}"/>"><img src="${rslt.imgCmntImgUrl}" onerror="this.src='<%=evcp%>/cola/cafe/each/no.png'"/></a>
					</div>
					<div class="txt">
						<div class="title"><a href="<%=evcp%>/cafe/<c:out value="${rslt.cmntUrl}"/>"><c:out value="${rslt.cmntNm}"/></a></div>
						<div class="info">
							<span>
								<label class="cafe_title"><util:message key="ev.title.category"/><%--분류 --%></label>
								 :&nbsp;<c:out value="${rslt.cateIdNm}"/>
							</span>&nbsp;
							<span>
								<label class="cafe_title"><util:message key="cf.title.last.visited"/><%--방문일시 --%></label>
								 :&nbsp;<c:out value="${rslt.accessDatimTPF}"/>
							</span>
						</div>
						<div class="cont">
							<c:out value="${rslt.cmntIntro}"/>
						</div>
					</div>
				</li>
			</c:forEach>
		</ul>
		<a href="#" onclick="cfHome.initCafeHome('mine.favor')" class="more"><util:message key="ev.prop.more"/> +</a>
		<div id="srchCafe_pageIndex" align="center"></div>
	    <input type="hidden" id="srchCafe_pageNo"    name="srchCafe_pageNo" value="<c:out value="${homeForm.pageNo}"/>"/>
	    <input type="hidden" id="srchCafe_totalPage" name="srchCafe_totalPage" value="<c:out value="${homeForm.totalPage}"/>"/>
	</c:if>
</c:if>