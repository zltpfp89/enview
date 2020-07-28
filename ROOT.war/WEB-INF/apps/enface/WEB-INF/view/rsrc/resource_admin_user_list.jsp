<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="rfrc" uri="/WEB-INF/tld/reference.tld" %>
<%
    request.setAttribute("cPath", request.getContextPath());
%>
<c:if test="${not empty errorMessage}">
	<script type="text/javascript">
		alert("<c:out value='${errorMessage }' />");
	</script>
</c:if>
<input type="hidden" id="usr_id" name="usr_id" />
<input type="hidden" id="dept_del" name="dept_del" />
<div class="w_p73 fr">
	<div class="sub_title">
		<h5>자원관리 부서정보</h5>
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
				<td class="left"><c:out value="${deptInfo.dept_cd }" /></td>
			</tr>
			<tr>
				<th>자원관리 부서명</th>
				<td class="left"><c:out value="${deptInfo.dept_nm }" /></td>
			</tr>
		</thead>
	</table>
</div>

<div class="w_p73 fr">
	<div class="sub_title">
		<h5>자원관리 담당자</h5>
		<a class="btn_black cursor" onclick="javascript: fn_viewRsrcDeptUser();">신규등록</a>
	</div>

	<table class="basic_table" summary="메뉴얼 목차">
		<caption>메뉴얼 목차</caption>
		<colgroup>
			<col style="width: 130px" />
			<col style="width: 150px" />
			<col style="width: 150px" />
			<col style="width: auto" />
			<col style="width: 100px" />
		</colgroup>
		<thead>
			<tr>
				<th>아이디</th>
				<th>성명</th>
				<th>직급</th>
				<th>담당자 소속</th>
				<th class="last"></th>
			</tr>
		</thead>
	</table>
	<div class="h400 overflow_y">
		<table class="basic_table bdno" summary="메뉴얼 목차">
			<caption>메뉴얼 목차</caption>
			<colgroup>
				<col style="width: 130px" />
				<col style="width: 150px" />
				<col style="width: 150px" />
				<col style="width: auto" />
				<col style="width: 100px" />
			</colgroup>
			<tbody>
				<c:choose>
					<c:when test="${not empty deptUserList }">
						<c:forEach items="${deptUserList }" var="info">
							<tr>
								<td><c:out value="${info.userId }" /></td>
								<td><a href="javascript:fn_getUserInfoPopup('<c:out value="${info.userId }" />');" target="_self" title="사용자 정보"><span class="icon_user"></span><c:out value="${info.nmKor }" /></a></td>
								<td><c:out value="${info.criMbPosiNm }" /></td>
								<td class="left"><c:out value="${info.orgName }" /></td>
								<td><a usrid="<c:out value="${info.userId }" />" usrnm="<c:out value="${info.nmKor }" />" class="btn_white cursor" onclick="javascript: fn_deleteRsrcUser(this);">삭제</a></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="5">등록된 담당자가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
</div>
<div class="w_p73 fr">
	<div class="sub_title">
		<c:choose>
			<c:when test="${deptInfo.dept_del eq 'Y' }">
				<a class="btn_white cursor" onclick="javascript: fn_useChangeRsrc('D');" style="margin: 5px;">삭제</a>
				<a class="btn_black cursor" onclick="javascript: fn_useChangeRsrc('N');" style="margin: 5px;">사용</a>
			</c:when>
			<c:otherwise>
				<a class="btn_black cursor" onclick="javascript: fn_useChangeRsrc('Y');" style="margin: 5px;">사용안함</a>
			</c:otherwise>
		</c:choose>
	</div>
</div>
