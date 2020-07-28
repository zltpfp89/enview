<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<input type="hidden" id="reg_curQstnCnt" name="reg_curQstnCnt" value="<c:out value="${opForm.curQstnCnt}"/>"/>
   <c:forEach items="${qstnList}" var="qstn">
  <li id="reg_regQstn<c:out value="${qstn.qstnSeq}"/>">
    <span><b><c:out value="${qstn.qstnSeq}"/>.</b>&nbsp;<c:out value="${qstn.contents}"/></span>
	<a href="#" class="btn white"  onclick="cfOp.regInfo.deleteRegQstn(<c:out value="${qstn.qstnSeq}"/>)" color="#666"><util:message key="ev.info.menu.delete"/></a>
	<c:if test="${qstn.qstnType=='A'}">
	  <c:set var="answList" value="${qstn.answList}"/>
	  <jsp:useBean id="answList" type="java.util.List"/>
	  <c:forEach items="${answList}" var="answ">
	    <p>
	      <span style="margin-left:20px">
		    <img src="<%=request.getContextPath()%>/cola/cafe/images/sysop/encafe/answ.gif" width="17" height="17" align="absmiddle"/>
		    <c:out value="${answ.contents}"/>
		  </span>
	    </p>
	  </c:forEach>
	</c:if>
  </li>
</c:forEach>
