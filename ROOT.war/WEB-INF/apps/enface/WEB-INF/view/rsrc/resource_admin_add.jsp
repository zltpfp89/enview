<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="rfrc" uri="/WEB-INF/tld/reference.tld" %>
<%
    request.setAttribute("cPath", request.getContextPath());
%>

<div class="w_p73 fr">
	<div class="sub_title">
		<h5>자원관리 부서정보</h5>
		<a class="btn_black cursor" onclick="javascript: fn_selectDept();">부서검색</a>
	</div>
	
	<table class="basic_table" summary="메뉴얼 목차">
		<caption>메뉴얼 목차</caption>
		<colgroup>
			<col style="width:200px" />
			<col style="width:auto" />
		</colgroup>
		<thead>
			<tr>
				<th>자원관리 부서코드</th>
				<td class="left" style="padding: 4px;">
					<input type="text" id="newDept_cd" name="newDept_cd" readonly="readonly" size="30" style="background: #ddd;"/>
				</td>
			</tr>
			<tr>
				<th>자원관리 부서명</th>
				<td class="left" style="padding: 4px;">
					<input type="text" id="dept_nm" name="dept_nm" readonly="readonly" size="30" style="background: #ddd;"/>
				</td>
			</tr>
		</thead>
	</table>
</div>
<div class="w_p73 fr">
	<div class="sub_title">
		<a class="btn_white cursor" onclick="javascript: fn_addRsrcDept();" style="margin: 5px;">등록</a>
		<a class="btn_black cursor" onclick="javascript: fn_cancelRsrc();" style="margin: 5px;">취소</a>
	</div>
</div>