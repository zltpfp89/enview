<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
<%--BEGIN::상단 주제 목록--%>
<c:if test="${homeForm.view == 'init'}">
  <table>
    <tr>
	  <td>
	  <c:forEach items="${cateList}" var="cate">
		<font style="cursor:pointer;padding:0px 5px 0px 5px" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'"
              onclick="cfHome.selectHotCate('<c:out value="${cate.cateId}"/>')"
		>
		  <c:out value="${cate.cateNm}"/>
		</font>
	  </c:forEach>
	  </td>
	</tr>
	<tr><td height="10"></td></tr>
  </table>
  <div id="hotCateCafeArea">
    <ul style="list-style-type:none">
    <c:forEach items="${cafeList}" var="cafe">
      <li style="padding-top:3px"><a href="<%=evcp%>/cafe/<c:out value="${cafe.cmntUrl}"/>"><c:out value="${cafe.cmntNm}"/></a></li>
    </c:forEach>
    </ul>
  </div>
</c:if>
<%--END::상단 주제 목록--%>
<%--BEGIN::하단 주제 카페 목록--%>
<c:if test="${homeForm.view == 'cafe'}">
  <ul style="list-style-type:none">
  <c:forEach items="${cafeList}" var="cafe">
    <li style="padding-top:3px"><a href="<%=evcp%>/cafe/<c:out value="${cafe.cmntUrl}"/>"><c:out value="${cafe.cmntNm}"/></a></li>
  </c:forEach>
  </ul>
</c:if>
<%--END::하단 주제 카페 목록--%>
