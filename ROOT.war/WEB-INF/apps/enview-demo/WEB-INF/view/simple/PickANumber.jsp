<%--
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements.  See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to You under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License.  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--%>
<%@ page language="java" session="true" %>
<!--%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %-->
<!--%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %-->

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet"%>
<%@ page import="javax.portlet.PortletSession"%>
<portlet:defineObjects/>

<fmt:setBundle basename="com.saltware.demo.portlet.simple.resources.PickANumberResources"/>

<portlet:actionURL var="myAction">
	<portlet:param name="myParam" value="testParam"/>
</portlet:actionURL>

<portlet:actionURL var="myRedirect">
	<portlet:param name="redirect-test" value="true"/>
</portlet:actionURL>

<%
    PortletSession portletSession = renderRequest.getPortletSession(true);
    Long value = (Long)portletSession.getAttribute("LastGuess", PortletSession.APPLICATION_SCOPE);    
    long LastGuess = 0;
    if (value != null)
    {
    	LastGuess = value.longValue();
    }       	
%>

<c:set var="GuessCount" scope="session" value="${GuessCount}"/>
<c:set var="TargetValue" scope="session" value="${TargetValue}"/>
<c:set var="LastGuess" scope="session" value="${LastGuess}"/>
<c:set var="TopRange" scope="session" value="${TopRange}"/>

<h2>
<fmt:message key="pickanumber.label.pickanumberguess"/>
</h2>

<c:choose>
<c:when test="${empty GuessCount}">
</c:when>
<c:when test="${TargetValue == LastGuess}">
</c:when>
<c:otherwise>
<fmt:message key="pickanumber.label.guessthusfar">
	<fmt:param><c:out value="${GuessCount}"/></fmt:param>
</fmt:message>
</c:otherwise>
</c:choose>

<c:choose>
<c:when test="${TargetValue == LastGuess}">
<p>
<fmt:message key="pickanumber.label.startnewgame"/><br/><fmt:message key="pickanumber.label.enternumber"><fmt:param><c:out value="${TopRange}"/></fmt:param></fmt:message>
</p>
</c:when>
<c:otherwise>
<p>
<fmt:message key="pickanumber.label.enternumber"><fmt:param><c:out value="${TopRange}"/></fmt:param></fmt:message>
</p>
</c:otherwise>
</c:choose>

<p>
zzz
  <c:choose>
    <c:when test="${empty TargetValue}">
       <fmt:message key="pickanumber.label.readytostartanewgame"/>
    </c:when>  
    <c:when test="${empty LastGuess}">
       <fmt:message key="pickanumber.label.readytostartanewgame"/>
    </c:when>      
    <c:when test="${TargetValue == LastGuess}">
      <center><strong><fmt:message key="pickanumber.label.guessiscorrect"><fmt:param><%=LastGuess%></fmt:param><fmt:param><c:out value="${GuessCount}"/></fmt:param></fmt:message></strong></center>
      <c:remove var="TargetValue" scope="session"/> 
    </c:when>
    <c:when test="${TargetValue < LastGuess}">
      <fmt:message key="pickanumber.label.guessedtohigh"/>
    </c:when>
    <c:when test="${TargetValue > LastGuess}">
      <fmt:message key="pickanumber.label.guessedtolow"/>
    </c:when>
    <c:otherwise>
       <fmt:message key="pickanumber.label.readytostartanewgame"/>
    </c:otherwise>
  </c:choose>
</p>
<p>
  <form action="<%=myAction%>" method="POST">
  
    <input type="text" name="Guess" value="<%=LastGuess%>"/>
    <input type="submit" value='<fmt:message key="pickanumber.label.guess"/>'/>
  </form>
</p>

<portlet:renderURL var="helpMe" portletMode='help'/>
<portlet:renderURL var="editMe" portletMode='Edit'/>
<portlet:renderURL var="maxMe" windowState='Maximized'/>
<portlet:renderURL var="minMe" windowState='Minimized'/>
<portlet:renderURL var="normalMe" windowState='Normal' portletMode='View'/>

<a href='<%=helpMe%>'>Help</a>
<a href='<%=editMe%>'>Edit</a>
<c:if test="${renderRequest.windowState != 'popup'}">
  <a href='<%=maxMe%>'>Max</a>
  <a href='<%=minMe%>'>Min</a>
  <a href='<%=normalMe%>'>Normal</a>
</c:if>

<a href='<%=myRedirect%>'>Redirect Test</a>
