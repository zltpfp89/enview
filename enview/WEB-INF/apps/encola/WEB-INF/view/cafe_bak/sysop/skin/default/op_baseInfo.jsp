<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="baseInfoTabs">
  <ul>
    <li><a href="#baseInfoBaseTab" onclick="cfOp.baseInfo.selectTab(0)">기본정보</a></li>   
    <li><a href="#baseInfoRuleTab" onclick="cfOp.baseInfo.selectTab(1)">운영회칙</a></li>
    <li><a href="#baseInfoCloseTab" onclick="cfOp.baseInfo.selectTab(2)">폐    쇄</a></li>
    <%--li><a href="#baseInfoTranTab" onclick="cfOp.baseInfo.selectTab(3)">양    도</a></li--%>
  </ul>
  <div id="baseInfoBaseTab" style="width:100%;"></div>
  <div id="baseInfoRuleTab" style="width:100%;"></div>
  <div id="baseInfoCloseTab" style="width:100%;"></div>
  <%--div id="baseInfoTranTab" style="width:100%;"></div--%>
</div><!--div id="baseInfoTabs"-->

