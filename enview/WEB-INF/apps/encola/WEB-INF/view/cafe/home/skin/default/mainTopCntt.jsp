<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="mainTopTabs">
  <ul>
    <li><a href="#mainRcmdTab"  onclick="cfHome.selectMainTopTab(0)">추천카페</a></li>   
    <li><a href="#mainFavorTab" onclick="cfHome.selectMainTopTab(1)">자주가는카페</a></li>
    <li><a href="#mainRcntTab"  onclick="cfHome.selectMainTopTab(2)">최근방문한카페</a></li>
    <li><a href="#mainSrchTab"  onclick="cfHome.selectMainTopTab(3)">카페찾기</a></li>
  </ul>
  <div id="mainRcmdTab" style="width:99%;">
  </div> <!-- End mainRcmdTab -->
  <div id="mainRcmdTab" style="width:100%;"></div>
  <div id="mainFavorTab" style="width:100%;"></div>
  <div id="mainRcntTab" style="width:100%;"></div>
  <div id="mainSrchTab" style="width:100%;"></div>
</div><!--div id="mainTopTabs"-->

