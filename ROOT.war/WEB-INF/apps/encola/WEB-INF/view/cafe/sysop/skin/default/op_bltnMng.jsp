<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="bltnMngTabs">
  <ul>
    <li><a href="#bltnMngAllTab" onclick="cfOp.bltnMng.selectTab(0)">게시글 관리</a></li>
    <%--   
    <li><a href="#bltnMngNtcTab" onclick="cfOp.bltnMng.selectTab(1)">공지글 관리</a></li>
     --%>
    <%--li><a href="#bltnMngBadTab" onclick="cfOp.bltnMng.selectTab(2)">스팸글 관리</a></li--%>
  </ul>
  <div id="bltnMngAllTab" style="width:100%;"></div>
  <div id="bltnMngNtcTab" style="width:100%;"></div>
  <%--div id="bltnMngBadTab" style="width:100%;"></div--%>
</div>
