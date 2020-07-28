<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="cafeProfileTabs">
  <ul>
    <li><a href="#cafeProfileBaseTab" onclick="cfCntt.m_profile.selectTab(0)">기본정보</a></li>   
    <li><a href="#cafeProfileRuleTab" onclick="cfCntt.m_profile.selectTab(1)">운영회칙</a></li>
    <!--li><a href="#cafeProfileHistTab" onclick="cfCntt.m_profile.selectTab(2)">히스토리</a></li-->
    <!--li><a href="#cafeProfileRankTab" onclick="cfCntt.m_profile.selectTab(3)">랭킹정보</a></li-->
    <li><a href="#cafeProfileStaffTab" onclick="cfCntt.m_profile.selectTab(2)">운영진</a></li>
  </ul>
  <div id="cafeProfileBaseTab" style="width:100%;" class="adgridpanel"></div>
  <div id="cafeProfileRuleTab" style="width:100%;" class="adgridpanel"></div>
  <!--div id="cafeProfileHistTab" style="width:100%;" class="adgridpanel"></div-->
  <!--div id="cafeProfileRAnkTab" style="width:100%;" class="adgridpanel"></div-->
  <div id="cafeProfileStaffTab" style="width:100%;" class="adgridpanel"></div>
</div><!--div id="cafeProfileTabs"-->
