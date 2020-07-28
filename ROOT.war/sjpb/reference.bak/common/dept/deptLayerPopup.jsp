<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.Map"%>
<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ taglib prefix="rfrc" uri="/WEB-INF/tld/reference.tld" %>
<style>
.tree_box{background:#fff; border:1px solid #b6b6b6; box-sizing:border-box; width:100%; height:300px;  overflow-y:auto; margin-bottom:10px;}
</style>
	<Script>
	ekrDeptPopup.usrDeptCd='${_enview_info_.orgId}';
	</Script>
	<div class="layerpopup_top">
		<div class="layerpopup_search">
			<label for="pop_meetroon_reserv" class="hide">검색</label><input id="deptPopup_deptNm" type="text" name="" maxlength="" id="pop_meetroon_reserv"/>
			<a href="#" class="btn_white" id="deptPopup_searchBtn"><span class="icon_zoom"></span>검색</a>
		</div>
	</div>
	
	<div class="layerpopup_white ">      
	<div class="tree_box">
	<div id="deptPopup_deptTree" >
	</div>
	</div>
	</div>
