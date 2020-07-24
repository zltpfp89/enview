<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="baseInfoTabs" class="tab_wrap m1">
	<ul>
		<li class="m1">
			<a href="javascript:cfOp.baseInfo.selectTab(0);"><span>기본정보</span></a>
			<div id="baseInfoBaseTab" class="tab_list"></div>
		</li>
		<li class="m2">
			<a href="javascript:cfOp.baseInfo.selectTab(1);"><span>운영회칙</span></a>
			<div id="baseInfoRuleTab" class="tab_list"></div>
		</li>
		<li class="m3">
			<a href="javascript:cfOp.baseInfo.selectTab(2);"><span>폐    쇄</span></a>
			<div id="baseInfoCloseTab" class="tab_list"></div>
		</li>
	</ul>
</div>