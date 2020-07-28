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
		
		<script type="text/javascript" src="${cPath}/javascript/message/mrbun_${langKnd}_mm.js"></script>
		<script type="text/javascript" src="${cPath}/javascript/message/mrbun_${langKnd}_hn.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/javascript/utility.js"></script> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
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
	<body style="float: left; width: 100%; height: 100%; margin: 0px;">
		<input type="hidden" id="viewName" value="mobile"/>
		<input type="hidden" id="langKnd" value="${langKnd}"/>
		<div id="wrap" class="wrap mobile">
			<div class="calendarListButton">
				<div id="leftArea" class="leftArea mobile">
					<div class="myCalendarArea mobile">
						<div id="myCalendar" class="caratToggle calendarInfo mobile">
							<span id="myCalendarCaratButton" class="caratButton ui-icon <c:if test="${empty calList }"> ui-icon-carat-1-s</c:if><c:if test="${not empty calList }"> ui-icon-carat-1-s</c:if>"></span>
							<label id="myCalendarLabel" class="myCalendarLabel" for="myCalendarCaratButton"><util:message key='hn.title.calendar.my'/></label><div id="calendarListPin" class="calendarListPin ui-icon ui-icon-pin-w"></div>
						</div>
						<div class="myCalendarList calendarList mobile" id="myCalendarList">
							<c:forEach items="${calList}" var="cal" varStatus="status">
								<div class="calendarInfo calToggle mobile" id="<c:out value="${cal.calendarId}"/>_CalToggle" title="<c:out value="${cal.name}"/>">
									<div id="<c:out value="${cal.calendarId}"/>_calendarBgColor" class="calendarBgColor<c:if test="${cal.hasJoint == 'Y'}"> ui-icon-link ui-icon-link2</c:if>" style="border: 1px solid <c:out value="${cal.bgColor}"/>; background-color:<c:out value="${cal.bgColor}"/>"></div>
									<input type="hidden" id="<c:out value="${cal.calendarId}"/>_bgColor" name="bgColor" value="<c:out value="${cal.bgColor}"/>"/>
									<label class="calendarName"><c:out value="${cal.name}"/></label>
									<input type="hidden" name="calendarId" value="<c:out value="${cal.calendarId}"/>"/>
									<input type="hidden" name="<c:out value="${cal.calendarId}"/>_selected" value="1"/>
									<input type="hidden" id="<c:out value="${cal.calendarId}"/>_isPublic" value="N"/>
									<input type="hidden" id="<c:out value="${cal.calendarId}"/>_isOwner" value="Y"/>
									<input type="hidden" id="<c:out value="${cal.calendarId}"/>_isDefault" value="<c:out value="${cal.isDefault}"/>"/>
								</div>
							</c:forEach>
						</div>
						<div class="myCalendarList calendarList mobile" id="jointCalendarList">
							<c:forEach items="${jointCalList}" var="cal">
								<div class="calendarInfo calToggle mobile" id="<c:out value="${cal.calendarId}"/>_CalToggle" title="<c:out value="${cal.name}"/>">
									<div id="<c:out value="${cal.calendarId}"/>_calendarBgColor" class="calendarBgColor ui-icon ui-icon-link ui-icon-link2" style="border: 1px solid <c:out value="${cal.bgColor}"/>; background-color:<c:out value="${cal.bgColor}"/>"></div>
									<input type="hidden" id="<c:out value="${cal.calendarId}"/>_bgColor" name="bgColor" value="<c:out value="${cal.bgColor}"/>"/>
									<label class="calendarName"><c:out value="${cal.name}"/></label>
									<input type="hidden" name="calendarId" value="<c:out value="${cal.calendarId}"/>"/>
									<input type="hidden" name="<c:out value="${cal.calendarId}"/>_selected" value="1"/>
									<input type="hidden" id="<c:out value="${cal.calendarId}"/>_isPublic" value="N"/>
									<input type="hidden" id="<c:out value="${cal.calendarId}"/>_isOwner" value="N"/>
									<input type="hidden" id="<c:out value="${cal.calendarId}"/>_isDefault" value="N"/>
								</div>
							</c:forEach>
						</div>
					</div>
					<div class="publicCalendarArea mobile">
						<div id="publicCalendar" class="caratToggle calendarInfo mobile">
							<span id="publicCalendarCaratButton" class="caratButton ui-icon<c:if test="${empty publicCalList }"> ui-icon-carat-1-s</c:if><c:if test="${not empty publicCalList }"> ui-icon-carat-1-s</c:if>"></span>
							<label id="publicCalendarLabel" class="publicCalendarLabel" for="publicCalendarCaratButton"><util:message key='hn.title.calendar.public'/></label>
						</div>
						<div class="publicCalendarList calendarList" id="publicCalendarList">
							<c:forEach items="${publicCalList}" var="cal">
								<div class="calendarInfo calToggle mobile" id="<c:out value="${cal.calendarId}"/>_CalToggle" title="<c:out value="${cal.name}"/>">
									<div id="<c:out value="${cal.calendarId}"/>_calendarBgColor" class="calendarBgColor" style="border: 1px solid <c:out value="${cal.bgColor}"/>; background-color:<c:out value="${cal.bgColor}"/>"></div>
									<input type="hidden" id="<c:out value="${cal.calendarId}"/>_bgColor" name="bgColor" value="<c:out value="${cal.bgColor}"/>"/>
									<label class="calendarName"><c:out value="${cal.name}"/></label>
									<input type="hidden" name="calendarId" value="<c:out value="${cal.calendarId}"/>"/>
									<input type="hidden" name="<c:out value="${cal.calendarId}"/>_selected" value="1"/>
									<input type="hidden" id="<c:out value="${cal.calendarId}"/>_isPublic" value="Y"/>
									<c:if test="${cal.ownerId == form.userId }">
										<input type="hidden" id="<c:out value="${cal.calendarId}"/>_isOwner" value="Y"/>
									</c:if>
									<c:if test="${cal.ownerId != form.userId }">
										<input type="hidden" id="<c:out value="${cal.calendarId}"/>_isOwner" value="N"/>
									</c:if>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<label class="toggleCalendarListButton" id="toggleCalendarListButton" onclick="enCal.toggleCalendarList();">▼</label>
			</div>
			
			<div id="contentsArea" class="contentsArea mobile">
				<div id="calendar"></div>
			</div>
		</div>
	</body>
</html>