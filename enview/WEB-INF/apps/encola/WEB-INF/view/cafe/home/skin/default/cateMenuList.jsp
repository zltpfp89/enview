<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<ul style="list-style-type:none">
<c:forEach items="${cateList}" var="cate">
<c:if test="${cate.cateLevel == '1'}">
  <li>
    <font id="cate_font_<c:out value="${cate.cateId}"/>" 
	      <c:if test="${homeForm.cateHier == '1' || (homeForm.cateHier != '1' && empty cate.childList)}">
		    style="cursor:hand" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'"
			onclick="cfHome.selectCateMenu('<c:out value="${cate.cateId}"/>',<c:out value="${cate.cateLevel}"/>)"
		  </c:if>
	>
	  <b><c:out value="${cate.cateNm}"/></b>
	</font>
  </li>
</c:if>
<c:if test="${cate.cateLevel == '2'}">
  <c:set var="cate3List" value="${cate.childList}"/>
  <li>
    <font id="cate_font_<c:out value="${cate.cateId}"/>" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'"
	      <c:if test="${homeForm.cateHier == '3' && !empty cate3List}">
		    onclick="cfHome.show3rdCateMenu('<c:out value="${cate.cateId}"/>')"
		  </c:if>
		  <c:if test="${homeForm.cateHier == '2' || (homeForm.cateHier == '3' && empty cate3List)}">
		    onclick="cfHome.selectCateMenu('<c:out value="${cate.cateId}"/>',<c:out value="${cate.cateLevel}"/>)"
		  </c:if>    
	>
	  <c:out value="${cate.cateNm}"/>
	</font>
	<c:if test="${!empty cate3List}">
	  <ul id="cate_ul_<c:out value="${cate.cateId}"/>" style="padding-left:0px;list-style-type:none;display:none">
	  <c:forEach items="${cate3List}" var="cate3">
		<li>
		  <span style="padding:0px 5px 0px 3px">.</span>
		  <font id="cate_font_<c:out value="${cate3.cateId}"/>" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'"
 		        onclick="cfHome.selectCateMenu('<c:out value="${cate3.cateId}"/>',<c:out value="${cate3.cateLevel}"/>)"	      
		  >
		    <c:out value="${cate3.cateNm}"/>
		  </font>
	    </li>
	  </c:forEach>
	  </ul>
	</c:if>
  </li>
</c:if>
</c:forEach>
</ul>