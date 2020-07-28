<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="regMmbrTabs">
  <ul>
    <li><a href="#regMmbrAllTab" onclick="cfOp.regMmbr.selectTab(0)">전제 회원</a></li>   
    <li><a href="#regMmbrGupTab" onclick="cfOp.regMmbr.selectTab(1)">등업 대기</a></li>
	<c:if test="${cmntVO.openYn != 'Y' || cmntVO.regType != 'A'}">
      <li><a href="#regMmbrInvTab" onclick="cfOp.regMmbr.selectTab(2)">초대/가입 신청</a></li>
    </c:if>
  </ul>
  <div id="regMmbrAllTab" style="width:100%;"></div>
  <div id="regMmbrGupTab" style="width:100%;"></div>
  <c:if test="${cmntVO.openYn != 'Y' || cmntVO.regType != 'A'}">
    <div id="regMmbrInvTab" style="width:100%;"></div>
  </c:if>
</div><!--div id="regMmbrTabs"-->
