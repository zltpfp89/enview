<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
<%--BEGIN::최초호출시 상단 검색기준--%>
<c:if test="${homeForm.view == 'init'}">
<div>
  <form method="POST" id="srchCafeForm" name="srchCafeForm" onsubmit="cfHome.searchCafeList(); return false;">
    <select id="srchType" name="srchType">
	  <option value="nm" <c:if test="${homeForm.srchType == 'nm'}">selected</c:if>><util:message key="cf.title.cafe.name"/><%--카페이름--%></option>
	  <option value="tag" <c:if test="${homeForm.srchType == 'tag'}">selected</c:if>><util:message key="cf.title.cafe.tag"/><%--카페태그--%></option>
	  <option value="url" <c:if test="${homeForm.srchType == 'url'}">selected</c:if>>카페URL</option--%>
	</select>
	<input type="text" id="srchKey" name="srchKey" value="<c:out value="${homeForm.srchKey}"/>"/>
	<input type="button" value="검색" onclick="cfHome.searchCafeList()"/>
	<input type="hidden" id="srchSort" name="srchSort" value="<c:out value="${homeForm.srchSort}"/>"/> 
	<input type="hidden" id="pageSize" name="pageSize" value="5"/>
  </form>
</div>
<div>
  <font style="margin-right:20px;cursor:pointer" OnMouseOver="this.style.textDecoration='underline'" OnMouseOut="this.style.textDecoration='none'" onclick="cfHome.changeSrchType('nm')"><util:message key="cf.title.cafe.name"/><%--카페이름--%></font>
  <font style="margin-right:20px;cursor:pointer" OnMouseOver="this.style.textDecoration='underline'" OnMouseOut="this.style.textDecoration='none'" onclick="cfHome.changeSrchType('tag')"><util:message key="cf.title.cafe.tag"/><%--카페태그--%></font>
  <font style="margin-right:20px;cursor:pointer" OnMouseOver="this.style.textDecoration='underline'" OnMouseOut="this.style.textDecoration='none'" onclick="cfHome.changeSrchType('bltn')">카페URL</font>
<div>
<div>
  <font style="padding-right:20px;cursor:pointer" OnMouseOver="this.style.textDecoration='underline'" OnMouseOut="this.style.textDecoration='none'" onclick="cfHome.changeSrchSort('hit')">인기도</font>
  <font style="padding-right:20px;cursor:pointer" OnMouseOver="this.style.textDecoration='underline'" OnMouseOut="this.style.textDecoration='none'" onclick="cfHome.changeSrchSort('mile')">랭킹</font>
  <font style="padding-right:20px;cursor:pointer" OnMouseOver="this.style.textDecoration='underline'" OnMouseOut="this.style.textDecoration='none'" onclick="cfHome.changeSrchSort('mmbr')"><util:message key="cf.title.mmbrCnt"/></font>
  <font style="padding-right:20px;cursor:pointer" OnMouseOver="this.style.textDecoration='underline'" OnMouseOut="this.style.textDecoration='none'" onclick="cfHome.changeSrchSort('reg')">생성일역순</font>
<div>
<div id="srchCafeRsltListDiv"></div>
</c:if>
<%--END::최초호출시 상단 검색기준--%>
<%--BEGIN::하단 검색결과 목록--%>
<c:if test="${homeForm.view == 'list'}">
  <ul style="list-style-type:none;padding:10px 5px 10px 5px">
    <c:if test="${empty rsltList}">
	  <li style="padding-top:3px">
		<span style="padding-right:20px">해당 카페가 존재하지 않습니다.</span>
	  </li>
	</c:if>
	<c:forEach items="${rsltList}" var="rslt">
	  <li style="padding-top:3px">
		<span style="padding-right:20px"><a href="<%=evcp%>/cafe/<c:out value="${rslt.cmntUrl}"/>"><c:out value="${rslt.cmntNm}"/></a></span>
	  </li>
	</c:forEach>
  </ul>
  <div id="srchCafe_pageIndex" align="center"></div>
  <input type="hidden" id="srchCafe_pageNo"    name="srchCafe_pageNo" value="<c:out value="${homeForm.pageNo}"/>"/>
  <input type="hidden" id="srchCafe_totalPage" name="srchCafe_totalPage" value="<c:out value="${homeForm.totalPage}"/>"/>
</c:if>
