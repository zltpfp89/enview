<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
	

	<!-- 카페 <util:message key="mm.title.category"/><%--카테고리--%> start -->
	<div class="commu_category_wrap tm20">
		<div class="commu_category_title">
			<div class="commu_category_title_left"><util:message key="cf.title.category"/></div>
			<div class="commu_category_title_right"><util:message key="ev.title.all"/> <c:out value="${cafeTotal}"/><util:message key="eb.title.count"/> <a href="javascript:cfHome.initCafeHome('cate.init')"> <util:message key="cf.title.viewAll"/></a></div>
		</div>
		<ul class="commu_category_list">
			<c:forEach items="${cateList}" var="cate" varStatus="status">
				<li>
					<a href="#" onclick="cfHome.selectCateMenu('<c:out value="${cate.cateNm}"/>',<c:out value="${cate.cateId}"/>,<c:out value="${cate.cateLevel}"/>,'Y');" >
						<c:out value="${cate.cateNm}"/> (<c:out value="${cate.itemCnt}"/>) 
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
<!-- //카페 <util:message key="mm.title.category"/><%--카테고리--%> end -->
	<div class="main_cafe_wrap tm20">
		<ul class="main_cafe_list">
			<li class="main_cafe_tab on" id="tab0"><a href="javascript:cfHome.selectMainTopTab(0);" onclick="main_cafe_tab1"><util:message key="cf.title.rcmd.cafe"/></a>
				<div class="main_cafe_cont" id="main_cafe_tab1">
				</div>
			</li>
			<li class="main_cafe_tab" id="tab1"><a href="javascript:cfHome.selectMainTopTab(1);" onclick="main_cafe_tab2"><util:message key="ev.title.favor.cafe"/></a>
				<div class="main_cafe_cont" id="main_cafe_tab2">
				</div>
			</li>
			<li class="main_cafe_tab" id="tab2"><a href="javascript:cfHome.selectMainTopTab(2);" onclick="main_cafe_tab3"><util:message key="cf.title.rcnt.cafe"/></a> <%--최근방문한카페 --%>
				<div class="main_cafe_cont" id="main_cafe_tab3">
				</div>
			</li>
		</ul>
	</div>