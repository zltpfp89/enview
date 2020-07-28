<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
	
	<div class="cafeadm_top">
		<h3><util:message key="cf.title.mng.bulletin"/></h3>
		<ul class="location">
			<li>HOME<span class="nextbar"></span></li>
			<li><util:message key="cf.title.mng.menuBoard"/><span class="nextbar"></span></li>
			<li class="last"><util:message key="cf.title.mng.bulletin"/></li>
		</ul>
	</div>

<div class="cafeadm_tabmenu">
  <ul>
    <li class="on" id="bltn_tab0">
    	<a href="javascript:cfOp.bltnMng.selectTab(0);" onclick="bltnMngAllTab"><util:message key="cf.title.bulletin"/></a>
    </li>   
    <%--
    <li id="bltn_tab1">
    	<a href="javascript:cfOp.bltnMng.selectTab(1);" onclick="bltnMngNtcTab"><util:message key="cf.title.mng.notice"/></a>
    </li>
     --%>
  </ul>
</div>

  <div id="bltnMngAllTab" class="tabcontent"></div>
  <div id="bltnMngNtcTab" class="tabcontent"></div>
