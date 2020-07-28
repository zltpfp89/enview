<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String evcp = request.getContextPath();
%>
<%--BEGIN::내가 가입한 카페--%>
<c:if test="${homeForm.initView == 'mine.all'}">
  <ul style="list-style-type:none">
  <c:if test="${!mmbrVO.isLogin}">
    <li style="padding-top:3px"><util:message key="eb.error.need.login"/></li><%--로그인 하셔야 합니다.--%>
  </c:if>
  <c:if test="${mmbrVO.isLogin}">
  <c:if test="${empty myAllList}">
    <li style="padding-top:3px"><util:message key="cf.error.not.exist.my.cafe"/></li><%--가입한 카페가 없습니다.--%>
  </c:if>
  <c:if test="${!empty myAllList}">
  <c:forEach items="${myAllList}" var="myAll">
    <li style="padding-top:3px">
	  <span>
	    <c:if test="${mmbrVO.loginId == myAll.makerId}">개설</c:if>
	    <c:if test="${mmbrVO.loginId != myAll.makerId}">가입</c:if>
	  </span>
	  <span><a href="<%=evcp%>/cafe/<c:out value="${myAll.cmntUrl}"/>"><c:out value="${myAll.cmntNm}"/></a></span>
	</li>
  </c:forEach>
  </c:if>
  </c:if>
  </ul>
</c:if>
<%--END::내가 가입한 카페--%>
<%--BEGIN::자주가는 카페--%>
<c:if test="${homeForm.initView == 'mine.favor'}">
  <div align="right" style="padding-top:10px;padding-right:10px">
  <c:if test="${mmbrVO.isLogin}">
	<span class="btn_pack small"><a href="javascript:cfHome.showFavorCafeEdit()"><util:message key="pt.ev.button.edit"/></a></span>
  </c:if>
  </div>
  <ul style="list-style-type:none">
  <c:if test="${!mmbrVO.isLogin}">
    <li style="padding-top:3px"><util:message key="eb.error.need.login"/></li><%--로그인 하셔야 합니다.--%>
  </c:if>
  <c:if test="${mmbrVO.isLogin}">
  <c:if test="${empty favorList}">
    <li style="padding-top:3px"><util:message key="cf.error.not.exist.favor.cafe"/></li><%--등록된 자주가는 카페가 없습니다.--%>
  </c:if>
  <c:if test="${!empty favorList}">
  <c:forEach items="${favorList}" var="favor">
    <li style="padding-top:3px"><a href="<%=evcp%>/cafe/<c:out value="${favor.cmntUrl}"/>"><c:out value="${favor.cmntNm}"/></a></li>
  </c:forEach>
  </c:if>
  </c:if>
  </ul>
</c:if>
<%--END::자주가는 카페--%>
<%--BEGIN::자주가는 카페 편집--%>
<c:if test="${homeForm.initView == 'mine.favorEdit'}">
  <c:if test="${!mmbrVO.isLogin}">
    <div><util:message key="eb.error.need.login"/></div><%--로그인 하셔야 합니다.--%>
  </c:if>
  <c:if test="${mmbrVO.isLogin}">
  <table>
    <tr>
	  <td width="280" style="border-style:solid;border-width:1px">
		<ul id="favor_edit_allUl" style="list-style-type:none">
		<c:if test="${empty myAllList}">
		  <li style="padding-top:3px"><util:message key="cf.error.not.exist.my.cafe"/></li><%--가입한 카페가 없습니다.--%>
		</c:if>
		<c:if test="${!empty myAllList}">
		<c:forEach items="${myAllList}" var="myAll">
		  <li id="favor_edit_allLi" cmntId="<c:out value="${myAll.cmntId}"/>"
		      <c:if test="${myAll.alreadyFavor}">style="padding:3px;color:#BDBDBD"</c:if>
		      <c:if test="${!myAll.alreadyFavor}">style="padding:3px" onclick="cfHome.getFavorMngr().selectList(this)"</c:if>
		  >
		    <span style="padding-right:10px">
			  <c:if test="${myAll.makerId == mmbrVO.loginId}">개설</c:if>
			  <c:if test="${myAll.makerId != mmbrVO.loginId}">가입</c:if>
			</span>
		    <c:out value="${myAll.cmntNm}"/>
		  </li>
		</c:forEach>
		</c:if>
		</ul>
	  </td>
	  <td width="40" align="center">
		<span class="btn_pack small"><a href="javascript:cfHome.getFavorMngr().add()">추가 ></a></span>
		<br>
		<span class="btn_pack small"><a href="javascript:cfHome.getFavorMngr().rem()">< 제거</a></span>
	  </td>
	  <td width="280" style="border-style:solid;border-width:1px">
		<ul id="favor_edit_favorUl" style="list-style-type:none">
		<c:forEach items="${favorList}" var="favor">
		  <li id="favor_edit_favorLi" style="padding:3px" cmntId="<c:out value="${favor.cmntId}"/>"
		      onclick="cfHome.getFavorMngr().selectList(this)"
		  >
		    <c:out value="${favor.cmntNm}"/>
		  </li>
		</c:forEach>
		</ul>
	  </td>
	</tr>
	<tr>
	  <td colspan="3" align="right">
	    <img src="<%=request.getContextPath()%>/cola/cafe/images/button/btn_up_first.gif" onclick="cfHome.getFavorMngr().move('first')"/>
	    <img src="<%=request.getContextPath()%>/cola/cafe/images/button/btn_up.gif" onclick="cfHome.getFavorMngr().move('up')"/>
	    <img src="<%=request.getContextPath()%>/cola/cafe/images/button/btn_down.gif" onclick="cfHome.getFavorMngr().move('down')"/>
	    <img src="<%=request.getContextPath()%>/cola/cafe/images/button/btn_down_last.gif" onclick="cfHome.getFavorMngr().move('last')"/>
	  </td>
	</tr>
	<tr>
	  <td colspan="3" align="center">
		<span class="btn_pack medium"><a href="javascript:cfHome.getFavorMngr().save()"><util:message key="pt.ev.button.save"/></a></span>
		<span class="btn_pack medium"><a href="javascript:cfHome.getFavorMngr().cancel()"><util:message key="pt.ev.button.cancel"/></a></span>
      </td>
	</tr>
  </table>
  </c:if>
</c:if>
<%--END::자주가는 카페 편집--%>
