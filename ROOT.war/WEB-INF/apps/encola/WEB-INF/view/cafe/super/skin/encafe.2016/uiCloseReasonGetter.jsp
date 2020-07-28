<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="adgridpanel" style="width:100%;"> 
  <table style="width:100%;">
	<tr>
	  <td width="100%">
		<span>선택한 카페를 <b><font color="blue">강제폐쇄</font></b> 하시겠습니까?</span>
		<br>
		<span>강제폐쇄 사유를 선택해 주십시오.</span>
	  </td>
	</tr>
	<tr><td height=1 colspan=2></td></tr>
	<tr>
	  <td width="100%">
		<div class="adpanel">
		  <c:forEach items="${reasonList}" var="reason" varStatus="status">
			<input type="radio" id="closeReasonGetter_closeReason" name="closeReasonGetter_closeReason" value="<c:out value="${reason.code}"/>"/><c:out value="${reason.codeName}"/>
			<br>
		  </c:forEach>
		  <textarea id="closeReasonGetter_closeRemark" name="closeReasonGetter_closeRemark" style="width:98%;height:100px;overflow:auto;word-wrap:break-word"></textarea>
		</div>
	  </td>
	</tr>
  </table>
</div>
