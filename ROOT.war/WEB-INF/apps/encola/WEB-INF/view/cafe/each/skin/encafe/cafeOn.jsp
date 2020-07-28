<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/cola/cafe/css/skin/encafe/cafe_on.css" type="text/css" />
<div class="cafe_on">
	<h2>카페ON <em>(1)</em><span>숨기<input type="checkbox" /></span></h2>
	<div class="person">
		<ul>
			<li><a href="#"><img src="/enview/cola/cafe/images/portlet/a_level_<c:out value="${ mmbrVO.mmbrGrd }"/>.gif" alt="" />카레</a></li>
			<li><a href="#"><img src="/enview/cola/cafe/images/portlet/a_level_<c:out value="${ mmbrVO.mmbrGrd }"/>.gif" alt="" />카레</a></li>
			<li><a href="#"><img src="/enview/cola/cafe/images/portlet/a_level_<c:out value="${ mmbrVO.mmbrGrd }"/>.gif" alt="" />카레</a></li>
			<li><a href="#"><img src="/enview/cola/cafe/images/portlet/a_level_<c:out value="${ mmbrVO.mmbrGrd }"/>.gif" alt="" />카레</a></li>
			<li><a href="#"><img src="/enview/cola/cafe/images/portlet/a_level_<c:out value="${ mmbrVO.mmbrGrd }"/>.gif" alt="" />카레</a></li>
		</ul>
	</div>
	<p class="search"><input type="text" /><a href="#"><img src="/enview/cola/cafe/images/portlet/btn_search.gif" alt="검색" /></a></p>
</div>