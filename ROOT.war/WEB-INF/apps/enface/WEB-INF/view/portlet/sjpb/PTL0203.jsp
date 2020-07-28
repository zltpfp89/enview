<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="portlet" uri="http://java.sun.com/portlet_2_0" %>
<div class="portlet monitering">
	<h2>(과)사건현황 <span>모니터링</span></h2>
	<div class="graph_wrap">
		<div class="graph_box">
			${dpCount.criTmNm }<br>
			송치 : ${dpCount.trnsrPer }<br>
			입건 : ${dpCount.prsctPer }<br>
		</div>
		<div class="graph_box">
			전체<br>
			송치 : ${totalCount.trnsrPer }<br>
			입건 : ${totalCount.prsctPer }<br>	
		</div>
	</div>
	<a href="#" class="more"><img src="/sjpb/images/icon_more.png" alt="더보기버튼"></a>
</div>
