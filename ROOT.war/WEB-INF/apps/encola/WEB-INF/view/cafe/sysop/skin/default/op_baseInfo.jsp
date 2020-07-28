<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="baseInfoTabs">
  <ul>
    <li onclick="cfOp.baseInfo.selectTab(0)"><a href="#baseInfoBaseTab" >기본정보</a></li>   
    <li onclick="cfOp.baseInfo.selectTab(1)"><a href="#baseInfoRuleTab" >운영회칙</a></li>
    <li onclick="cfOp.baseInfo.selectTab(2)"><a href="#baseInfoCloseTab" >폐    쇄</a></li>
    <%--li><a href="#baseInfoTranTab" onclick="cfOp.baseInfo.selectTab(3)">양    도</a></li--%>
  </ul>
  <div id="baseInfoBaseTab" style="width:100%;"></div>
  <div id="baseInfoRuleTab" style="width:100%;"></div>
  <div id="baseInfoCloseTab" style="width:100%;"></div>
  <%--div id="baseInfoTranTab" style="width:100%;"></div--%>
</div><!--div id="baseInfoTabs"-->

