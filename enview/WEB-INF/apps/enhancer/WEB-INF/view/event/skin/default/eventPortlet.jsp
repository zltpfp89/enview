<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.saltware.enhancer.event.service.EventUserVO"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %>
<%@ page import="java.util.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>행사/이벤트</title>
     
    <link href="<%=request.getContextPath()%>/hancer/css/event/style.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/hancer/css/event/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/event/main.js"></script>
</head>
<body style='overflow-x:hidden; background-image: none;' >
<%
	String site_name = (String)request.getAttribute("site_name");
	String langKnd = (String)request.getAttribute("langKnd");
	String detailPage = request.getContextPath() + "/portal" + site_name + "/detailEvent"; 
 	String morePage = request.getContextPath() + "/portal" + site_name + "/selectMainEventList"; 
 	
 	List<EventUserVO> eventPortletList = (List<EventUserVO>)request.getAttribute("eventPortletList");
%>
<!-- 이벤트 -->
<div id="rightArea" style="height: 195px; border-top: 0px;">
	<div class="portlet_r">
           	<h2>행사/이벤트<a href="<%=morePage%>" target="_parent" ><span>더보기</span></a></h2>
               <div class="back event" style="height:120px;">
               <c:if test="${fn:length(eventPortletList) != 0}">
               	<c:forEach items="${eventPortletList}" var="item" varStatus="status" begin="0" end="1">
                	<dl <c:if test="${status.index == 0}">class="first"</c:if>>
                		<c:if test="${item.eventImagePath != null }">
                       		<dd><a href="<%=detailPage%>?HIST_BACK_TYPE=MAIN&EVENT_SEQ=<c:out value ="${item.eventSeq }"/>" target="_parent" ><img src="<%=request.getContextPath() %><c:out value="${item.eventImagePath }"/>" style="width: 75px; height: 55px;" alt="이벤트행사 이미지" /></a></dd>
                       	</c:if>
                       	<c:if test="${item.eventImagePath == null }">
                       		<dd><a href="<%=detailPage%>??IST_BACK_TYPE=MAIN&EVENT_SEQ=<c:out value ="${item.eventSeq }"/>" target="_parent" ><img src="<%=request.getContextPath() %>/hancer/images/eventCommon/mng/event/default04.gif" style="width: 75px; height: 55px;" alt="이벤트행사 이미지" /></a></dd>
                       	</c:if>
                        <dt><a href="<%=detailPage%>?HIST_BACK_TYPE=MAIN&EVENT_SEQ=<c:out value ="${item.eventSeq }"/>" target="_parent" >[<c:out value="${item.eventCategoryNm }"/>] </a><br/>
                       		<a href="<%=detailPage%>?HIST_BACK_TYPE=MAIN&EVENT_SEQ=<c:out value ="${item.eventSeq }"/>" target="_parent" ><c:out value="${item.eventTitle }"/> </a>
                        </dt>
                    </dl>
               	</c:forEach>
               	</c:if>
               	<c:if test="${fn:length(eventPortletList) == 0}">
               		<dt>
               			등록된 이벤트가 없습니다.
               		</dt>
               	</c:if>
               </div>
       </div>
</div>
</body>
</html>