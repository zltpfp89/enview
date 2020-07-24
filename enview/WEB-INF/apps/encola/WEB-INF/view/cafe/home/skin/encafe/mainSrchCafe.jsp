<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
	pageContext.setAttribute("newLine", "\n"); 
%>
<link rel="stylesheet" href="${cPath}/cola/cafe/encafe/css/reset.css"/>
<link rel="stylesheet" href="${cPath}/cola/cafe/encafe/css/common.css"/>
<link rel="stylesheet" href="${cPath}/cola/cafe/encafe/css/layout.css"/>
<script src="${cPath}/cola/cafe/encafe/js/jquery.min.js" type="text/javascript" ></script>
<script src="${cPath}/cola/cafe/encafe/js/slide.js" type="text/javascript" ></script>
<script src="${cPath}/cola/cafe/encafe/js/js.js" type="text/javascript" ></script>
<c:if test="${homeForm.view == 'init'}">
<div class="tabmenu_wrap tm20">
	<ul>
		<li class="first">
			<a href="#" onclick="cfHome.changeSrchType('nm')"> 
				<font style="margin-right:20px;cursor:pointer" OnMouseOver="this.style.textDecoration='underline'" OnMouseOut="this.style.textDecoration='none'">
					<util:message key="cf.title.cafe.name"/><%--<util:message key="cf.title.cafe.name"/><%--카페이름--%> 
				</font>
			</a>
		</li>
		<li><a href="#" onclick="cfHome.changeSrchType('tag')">
				<font style="margin-right:20px;cursor:pointer" OnMouseOver="this.style.textDecoration='underline'" OnMouseOut="this.style.textDecoration='none'" >
					<util:message key="cf.title.cafe.tag"/><%--<util:message key="cf.title.cafe.tag"/><%--카페태그--%> 
				</font>
			</a>
		</li>
		<li>
			<a href="#" onclick="cfHome.changeSrchType('bltn')">
				<font style="margin-right:20px;cursor:pointer" OnMouseOver="this.style.textDecoration='underline'" OnMouseOut="this.style.textDecoration='none'" >
					<util:message key="cf.title.cafe.url"/> <%--카페URL --%>
				</font>
			</a>
		</li>
		<li>
			<a href="#" onclick="cfHome.changeSrchSort('hit')">
				<font style="margin-right:20px;cursor:pointer" OnMouseOver="this.style.textDecoration='underline'" OnMouseOut="this.style.textDecoration='none'" >
					<util:message key="cf.title.rank.hit"/><%--인기랭킹 --%>
				</font>
			</a>
		</li>
		<li>
			<a href="#" onclick="cfHome.changeSrchSort('mile')">
				<font style="margin-right:20px;cursor:pointer" OnMouseOver="this.style.textDecoration='underline'" OnMouseOut="this.style.textDecoration='none'" >
					<util:message key="cf.title.rank.mile"/> <%-- 활동랭킹 --%>
				</font>
			</a>
		</li>
		<li>
			<a href="#" onclick="cfHome.changeSrchSort('mmbr')">
				<font style="margin-right:20px;cursor:pointer" OnMouseOver="this.style.textDecoration='underline'" OnMouseOut="this.style.textDecoration='none'" >
					<util:message key="cf.title.member"/> <%-- 회원 --%>
				</font>
			</a>
		</li>
		<li>
			<a href="#" onclick="cfHome.changeSrchSort('reg')">
				<font style="margin-right:20px;cursor:pointer" OnMouseOver="this.style.textDecoration='underline'" OnMouseOut="this.style.textDecoration='none'" >
					<util:message key="eb.title.ordDatim"/><%--생성일역순 --%>
				</font>
			</a>
		</li>
	</ul>
</div>
<div id="srchCafeRsltListDiv"></div>
</c:if>
<c:if test="${homeForm.view == 'list'}">
<div class="sub_cafe_wrap tm20">
	<div class="sub_cafe_cont">
		<ul class="sub">
		    <c:if test="${empty rsltList}">
			  <li style="padding-top:3px">
				<span style="padding-right:20px"><util:message key="cf.error.not.exist.cafe2"/></span>
			  </li>
			</c:if>
			<c:if test="${!empty rsltList}">
				<c:forEach items="${rsltList}" var="rslt" varStatus="status"  end="4">
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
							<label class="cafe_title"><util:message key="cf.title.sysop"/><%--시샵 --%></label>
							 :&nbsp;<c:out value="${rslt.makerIdNm}"/>
						</span>&nbsp;
						<span>
							<label class="cafe_title"><util:message key="cf.title.member"/><%--회원 --%></label>
							 :&nbsp;<c:out value="${rslt.mmbrTotCF}"/> <util:message key="cf.title.persons"/><%--명 --%></span>
						</div>
						<div class="cont" style="overflow: hidden;height:44px;">
							${fn:replace( fn:escapeXml(rslt.cmntIntro), newLine, '<br/>')}
							<%--<c:out value="${fn:replace(rslt.cmntIntro, newLine, '<br/>')}"/>--%>
						</div>
					</div>
				 </li>
				 </c:forEach>
			</c:if>
		</ul>
	</div>
	<!-- 페이징 start -->
	<div class="paging tm20">
		 <div id="srchCafe_pageIndex"></div>
	</div>
	<!-- //페이징 end -->
	<input type="hidden" id="srchCafe_pageNo"    name="srchCafe_pageNo" value="<c:out value="${homeForm.pageNo}"/>"/>
	<input type="hidden" id="srchCafe_totalPage" name="srchCafe_totalPage" value="<c:out value="${homeForm.totalPage}"/>"/>
</div>
</c:if>