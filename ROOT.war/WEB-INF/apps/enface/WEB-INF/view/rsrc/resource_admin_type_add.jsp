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
		<h5>자원구분정보</h5>
	</div>
	
	<table class="basic_table" summary="메뉴얼 목차">
		<caption>메뉴얼 목차</caption>
		<colgroup>
			<col style="width:200px" />
			<col style="width:auto" />
		</colgroup>
		<thead>
			<tr>
				<th>자원구분명</th>
				<td class="left" style="padding: 4px;">
					<c:if test="${procType eq 'M' }">
						<input type="text" id="name" name="name" size="30" value="${typeInfo.name }" />
					</c:if>
					<c:if test="${procType ne 'M' }">
						<input type="text" id="name" name="name" size="30" value="" />
					</c:if>
				</td>
			</tr>
		</thead>
	</table>
</div>
<div class="w_p73 fr">
	<div class="sub_title">
		<c:if test="${procType eq 'M' }">
			<a class="btn_white cursor" onclick="javascript: fn_addRsrcType();" style="margin: 5px;">수정</a>
			<a class="btn_white cursor" onclick="javascript: fn_deleteRsrcType();" style="margin: 5px;">삭제</a>
		</c:if>
		<c:if test="${procType ne 'M' }">
			<a class="btn_white cursor" onclick="javascript: fn_addRsrcType();" style="margin: 5px;">등록</a>
		</c:if>
		<a class="btn_black cursor" onclick="javascript: fn_cancelRsrc();" style="margin: 5px;">취소</a>
	</div>
</div>
