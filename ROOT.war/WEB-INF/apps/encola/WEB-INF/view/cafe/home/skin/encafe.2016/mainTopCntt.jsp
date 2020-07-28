<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
	<li class="m1">
		<a href="javascript:cfHome.selectMainTopTab(0);"><span>추천카페</span></a>
		<div id="mainRcmdTab" class="tab_list"></div>
	</li>
	<li class="m2">
		<a href="javascript:cfHome.selectMainTopTab(1);"><span>자주가는카페</span></a>
		<div id="mainFavorTab" class="tab_list"></div>
	</li>
	<li class="m3">
		<a href="javascript:cfHome.selectMainTopTab(2);"><span>최근방문한카페</span></a>
		<div id="mainRcntTab" class="tab_list"></div>
	</li>
</ul>