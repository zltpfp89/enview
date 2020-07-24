<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<div class="cafegridpanel" style="width:100%;"> 
  <table style="width:100%;">
	<tr>
	  <td width="100%">
   		<c:if test="${langKnd eq 'ko' }">
			<span>선택한 회원을 <b><font color="blue"><c:out value="${stateFlagNm}"/></font></b> 하시겠습니까?</span>
			<br>
			<span><c:out value="${stateFlagNm}"/> 사유를 선택해 주십시오.</span>
		</c:if>
		<c:if test="${langKnd eq 'en' }">
			<span> Are you sure you want to <b> <font color = "blue"> <c:out value = "$ {stateFlagNm}" /> </font> </b> select members? </span>
			<br>
			<span>Please select a reason about <c:out value = "$ {stateFlagNm}" />.</span>
		</c:if>
	  </td>
	</tr>
	<tr><td height=1 colspan=2></td></tr>
	<tr>
	  <td width="100%">
		<div class="cafepanel">
		  <c:forEach items="${stateCodeList}" var="stateCode" varStatus="status">
			<input type="radio" id="stateCodeGetter_stateCode" name="stateCodeGetter_stateCode" value="<c:out value="${stateCode.code}"/>"/><c:out value="${stateCode.codeName}"/>
			<br>
		  </c:forEach>
		  <textarea id="stateCodeGetter_stateDesc" name="stateCodeGetter_stateDesc" style="width:98%;height:100px;overflow:auto;word-wrap:break-word"></textarea>
		</div>
	  </td>
	</tr>
  </table>
</div>
