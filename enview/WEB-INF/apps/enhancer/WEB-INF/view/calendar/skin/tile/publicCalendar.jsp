<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<html>
	<head>
		<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/javascript/jquery/css/redmond/jquery-ui-1.9.2.custom.min.css" />
		<link rel='stylesheet' type='text/css' href="<%=request.getContextPath()%>/hancer/css/calendar/fullcalendar.css" />
		<link rel='stylesheet' type='text/css' href="<%=request.getContextPath()%>/hancer/css/calendar/fullcalendar.print.css" media='print'/>
		<link rel='stylesheet' type='text/css' href="<%=request.getContextPath()%>/hancer/css/calendar/calendar.css" />
		<link rel='stylesheet' type='text/css' href="<%=request.getContextPath()%>/hancer/css/calendar/skin/${skin.skinPath}.css" />
		
		<script type="text/javascript" src="${cPath}/javascript/message/mrbun_${langKnd}_mm.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/message/mrbun_${langKnd}_hn.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/javascript/utility.js"></script> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery.form.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/hancer/javascript/calendar/fullcalendar.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/hancer/javascript/calendar/calendar.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/hancer/javascript/calendar/skin/${skin.skinPath}.js"></script>
		<script type='text/javascript'>
			$(document).ready(function(){
				enCal.m_contextPath = '<%=request.getContextPath()%>';
				enCalSkin.m_contextPath = '<%=request.getContextPath()%>';
			});
		</script>		
	</head>
	<body class="calbody">
		<input type="hidden" id="isOnlyUserPublic" value="N"/>
		<input type="hidden" id="isWithUserPublic" value="N"/>
		<input type="hidden" id="isPublicOnly" value="true"/>
		<input type="hidden" id="isSpecific" value="N"/>
		<input type="hidden" id="langKnd" value="${langKnd}"/>
		<input type="hidden" id="viewName" value="${form.viewName}"/>
		<div id="wrap" class="wrap">
			<div id="leftArea" class="leftArea">
				<div class="publicCalendarArea">
					<div id="publicCalendar" class="caratToggle calendarInfo">
						<span id="publicCalendarCaratButton" class="caratButton ui-icon<c:if test="${empty publicCalList }"> ui-icon-carat-1-e</c:if><c:if test="${not empty publicCalList }"> ui-icon-carat-1-s</c:if>"></span>
						<label id="publicCalendarLabel" class="publicCalendarLabel" for="publicCalendarCaratButton"><util:message key='hn.title.calendar.public'/></label>
					</div>
					<div class="publicCalendarList calendarList" id="publicCalendarList">
						<c:forEach items="${publicCalList}" var="cal">
							<div class="calendarInfo" id="<c:out value="${cal.calendarId}"/>_CalToggle" title="<c:out value="${cal.name}"/>">
								<div id="<c:out value="${cal.calendarId}"/>_calendarBgColor" class="calendarBgColor" style="border: 1px solid <c:out value="${cal.bgColor}"/>; background-color:<c:out value="${cal.bgColor}"/>"></div>
								<input type="hidden" id="<c:out value="${cal.calendarId}"/>_bgColor" name="bgColor" value="<c:out value="${cal.bgColor}"/>"/>
								<label class="calendarName"><c:out value="${cal.name}"/></label><span class="calendarPopupButton triangleButton publicCalendarRButton ui-icon ui-icon-triangle-1-s" calendarId="<c:out value="${cal.calendarId}"/>"></span>
								<input type="hidden" name="calendarId" value="<c:out value="${cal.calendarId}"/>"/>
								<input type="hidden" name="<c:out value="${cal.calendarId}"/>_selected" value="1"/>
								<input type="hidden" id="<c:out value="${cal.calendarId}"/>_isPublic" value="Y"/>
								<input type="hidden" id="<c:out value="${cal.calendarId}"/>_isUserPublic" value="<c:out value="${cal.isUserPublic}"/>"/>
								<input type="hidden" name="calPermissions" id="<c:out value="${cal.calendarId}"/>_permissions" value="<c:out value="${cal.permissions}"/>"/>
								<c:if test="${cal.ownerId == form.userId }">
									<input type="hidden" id="<c:out value="${cal.calendarId}"/>_isOwner" value="Y"/>
								</c:if>
								<c:if test="${cal.ownerId != form.userId }">
									<input type="hidden" id="<c:out value="${cal.calendarId}"/>_isOwner" value="N"/>
								</c:if>
								<input type="hidden" id="<c:out value="${cal.calendarId}"/>_isUsers" value="N"/>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<div id="contentsArea" class="contentsArea">
				<div id="calendar"></div>
			</div>
		</div>
	</body>
</html>