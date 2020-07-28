<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String type = "";

	if(request.getServerName().indexOf("dev") > -1 || request.getServerName().indexOf("local") > -1){
		type = "dev";
	}
	
	request.setAttribute("type", type);
%>
<!-- pop content-->
<div class="pop_content">
    <!-- table-->
    <table cellpadding="0" cellspacing="0" summary="게시판읽기" class="view">
    <caption>게시판읽기</caption>
        <colgroup>
            <col width="23%" />
            <col width="*%" />
            <col width="40%" />
        </colgroup>
        <tr>
          <th class="L">성명</th>
          <td class="L">
          	<c:out value="${user.empNm }" />
          </td>
          <td rowspan="6" class="C">
          	<div class="imgArea">
				<img src="http://${type }hr.ssu.or.kr/employeeImage?emp_id=<c:out value="${user.empNo }" />&image_type=P" width="100%" height="100%" />
			</div>
          </td>
        </tr>
        <tr>
            <th class="L">사번</th>
			<td class="L">
				<c:out value="${user.empNo }" />
			</td>
        </tr>
        <tr>
            <th class="L">부서</th>
			<td class="L">
				<c:out value="${user.orgNm }" />
			</td>
        </tr>
        <tr>
            <th class="L">직급</th>
			<td class="L">
				<c:out value="${user.posGrdNm }" />
			</td>
        </tr>
        <tr>
            <th class="L">직위</th>
			<td class="L">
				<c:out value="${user.posNm }" />
			</td>
        </tr>
        <tr>
            <th class="L">사무실전화</th>
			<td class="L">
				<c:out value="${user.ofcTelno1 }" />-<c:out value="${user.ofcTelno2 }" />-<c:out value="${user.ofcTelno3 }" />
				<c:if test="${not empty user.ofcShortNo }">
					(<c:out value="${user.ofcShortNo }" />)
				</c:if>
			</td>
        </tr>
        <tr>
            <th class="L">Mobile</th>
            <td colspan="2" class="L">
            	<c:out value="${user.mobTelno1 }" />-<c:out value="${user.mobTelno2 }" />-<c:out value="${user.mobTelno3 }" />
            </td>
        </tr>
        <tr>
            <th class="L">전자메일</th>
            <td colspan="2"class="L">
            	<c:out value="${user.email }" />
            </td>
        </tr>
        <tr>
            <th class="L">직무</th>
            <td colspan="2" class="L">
            	<c:out value="${user.jobNm }" />
            </td>
        </tr>
    </table>
    <!-- table//--> 
</div>
<!-- //pop content-->