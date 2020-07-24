<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
	<div class="cafeadm_top">
		<h3><util:message key="cf.title.basicInfo"/></h3>
		<ul class="location">
			<li>HOME<span class="nextbar"></span></li>
			<li><util:message key="cf.title.mng.cafeInfo"/><span class="nextbar"></span></li>
			<li class="last"><util:message key="cf.title.basicInfo"/></li>
		</ul>
	</div>
					
	<div class="cafeadm_tabmenu nbdb">
	<%--
		<ul>
			<li class="on" id="tab0">
				<a href="javascript:cfOp.baseInfo.selectTab(0);" onclick="baseInfoBaseTab"><span><util:message key="cf.title.basicInfo.short"/></span></a>
			</li>
			<li class="" id="tab1">
				<a href="javascript:cfOp.baseInfo.selectTab(1);" onclick="baseInfoRuleTab"><span><util:message key="cf.title.operatingRule"/></span></a>
			</li>
			<li class="" id="tab2">
				<a href="javascript:cfOp.baseInfo.selectTab(2);" onclick="baseInfoCloseTab"><span><util:message key="cf.title.closed.cafe"/></span></a>
			</li>
		</ul>
		 --%>
		<ul>
			<li class="on" id="tab0" onclick="cfOp.baseInfo.selectTab(0);">
				<a href="javascript:cfOp.baseInfo.selectTab(0);" onclick="baseInfoBaseTab"><span><util:message key="cf.title.basicInfo.short"/></span></a>
			</li>
			<li class="" id="tab1" onclick="cfOp.baseInfo.selectTab(1);">
				<a href="javascript:cfOp.baseInfo.selectTab(1);" onclick="baseInfoRuleTab"><span><util:message key="cf.title.operatingRule"/></span></a>
			</li>
			<li class="" id="tab2" onclick="cfOp.baseInfo.selectTab(2);">
				<a href="javascript:cfOp.baseInfo.selectTab(2);" onclick="baseInfoCloseTab"><span><util:message key="cf.title.closed.cafe"/></span></a>
			</li>
			
		</ul>
	</div>
	
	<div id="baseInfoBaseTab" class="tabcontent"></div>
	<div id="baseInfoRuleTab" class="tabcontent"></div>
	<div id="baseInfoCloseTab" class="tabcontent"></div>