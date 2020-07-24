<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../../include/cafe_header.jsp"/>
<table border="1" width="100%" cellspacing="0" cellpadding="0" height="100%">
  <tr>
    <td width=0><jsp:include page="../../include/cafe_left.jsp"/></td>
    <td align=center>
<%---------------------------------------------------------------------------------------------------------------------%>
<table width=800 border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan=2>
	  <table width=800 border="1" cellspacing="0" cellpadding="0">
	    <tr align=left>
		  <td width="100" align="center"><a href="javascript:cfHome.initCafeHome('')"><util:message key="cf.title.cafeHome"/></a></td>
		  <td width="100" align="center"><a href="javascript:cfHome.initCafeHome('mine.all')">내 카페</a></td>
		  <td width="100" align="center"><a href="javascript:cfHome.initCafeHome('cate.init')"><util:message key="mm.title.category"/><%--카테고리--%></a></td>
		</tr>
	  </table>
	</td>
  </tr>
  <tr>
    <td colspan=2 align="right">
	  <form method="POST" id="srchCafeExtnForm" name="srchCafeExtnForm" onsubmit="cfHome.searchCafeExtn(document.srchCafeExtnForm); return false;">
		<select id="srchType" name="srchType">
		  <option value="nm" <c:if test="${homeForm.srchType == 'nm'}">selected</c:if>><util:message key="cf.title.cafe.name"/><%--카페이름--%></option>
		  <option value="tag" <c:if test="${homeForm.srchType == 'tag'}">selected</c:if>><util:message key="cf.title.cafe.tag"/><%--카페태그--%></option>
		  <%--option value="nm" <c:if test="${homeForm.srchType == 'bltn'}">selected</c:if>>카페글</option--%>
		</select>
		<input type="text" id="srchKey" name="srchKey" value="<c:out value="${homeForm.srchKey}"/>"/>
		<input type="button" value="검색" onclick="cfHome.searchCafeExtn(document.srchCafeExtnForm)"/>
	  </form>
	</td>
  </tr>
  <tr>
    <td width=200 valign=top align=left>
	  <div id="loginArea" style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;">
	    <ul style="list-style-type:none">
		  <li>로그인영역</li>
		  <li><a href="javascript:cfHome.uiMakeCafe()">카페만들기</a></li>
		</ul>
	  </div>
	  <div id="topHitArea" style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;">
	    <ul style="list-style-type:none">
		  <li>랭킹상위</li>
		</ul>
	  </div>
	  <div id="topMileArea" style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;">
	    <ul style="list-style-type:none">
		  <li>게시물상위</li>
		</ul>
	  </div>
	  <div id="topMmbrArea" style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;">
	    <ul style="list-style-type:none">
		  <li>회원수상위</li>
		</ul>
	  </div>
	  <div id="mineMenuArea" style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;">
	    <ul style="list-style-type:none">
		  <li style="padding:5px 10px 5px 0px" onclick="cfHome.initCafeHome('mine.all')">내 카페 목록</li>
		  <li style="padding:5px 10px 5px 0px" onclick="cfHome.initCafeHome('mine.favor')">자주가는 카페</li>
		</ul>
	  </div>
	  <div id="cateMenuArea" style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;">
	    <ul style="list-style-type:none">
		  <li><util:message key="mm.title.category"/><%--카테고리--%></li>
		</ul>
	  </div>
	</td>
	<td width=600 valign="top">
	  <div id="cnttTopArea" style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;"></div>
	  <div id="cntt2ndArea" style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;"></div>
	  <div id="cntt3rdArea" style="border-style: solid solid solid solid; border-color: rgb(198,198,198); border-width: 1px;"></div>
	</td>
  </tr>  
</table>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/cola/cafe/css/styles.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/cola/cafe/javascript/cafe_home.js"></script>
<script type="text/javascript">
  <!--
  cfHome.initCafeHome('<c:out value="${homeForm.initView}"/>');
  //-->
</script>
<%---------------------------------------------------------------------------------------------------------------------%>
	</td>
    <td width=0><jsp:include page="../../include/cafe_right.jsp"/></td>
  </tr>
</table>
<jsp:include page="../../include/cafe_footer.jsp"/>
