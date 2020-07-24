<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<div id="icalMenu" class="icalMenu">
	<div id="icalMenuHeader" class="icalMenuHeader">
		<label id="icalMenuHeaderLabel" class="icalMenuHeaderLabel"><util:message key='hn.title.${form.action}'/></label><div id="icalClose" class="icalClose escapeButton ui-icon ui-icon-closethick"></div>
	</div>
	<c:if test="${form.action == 'export' }">
		<div id="icalMenuContent" class="icalMenuContent">
			<div class="icalCalendarName">
				<label class="icalCalendarNameLabel"><util:message key='hn.title.export.calendarName'/></label>
				<a class="icsLink" id="icsExportLink" url="<%=request.getContextPath() %>/calendar/<c:out value="${form.calendarId}"/>/ics/exportSchedule.hanc" href="javascript:enCal.exportICS('<c:out value="${form.calendarId}"/>');"></a>
			</div>
			<div class="icalYearSelect">
				<label class="icalYearLabel"><util:message key='hn.title.export.year'/></label>
				<select id="icalYear">
					<c:if test="${empty results }"><option value="<c:out value="${defaultYear}"/>" selected="selected"><c:out value="${defaultYear}"/></option></c:if>
					<c:forEach items="${results }" var="year" varStatus="status">
						<option value="<c:out value="${year}"/>"<c:if test="${defaultYear == year}"> selected="selected"</c:if>><c:out value="${year}"/></option>
					</c:forEach>
				</select>
				</div>
				<div class="icalLangKndSelect">
				<label class="icalLangKndLabel"><util:message key='hn.title.export.lang'/></label>
				<select id="icalLangKnd">
					<option value="ko"<c:if test="${form.langKnd == 'ko'}"> selected="selected"</c:if>><util:message key='hn.title.export.lang.ko'/></option>
					<option value="en"<c:if test="${form.langKnd == 'en'}"> selected="selected"</c:if>><util:message key='hn.title.export.lang.en'/></option>
				</select>
			</div>
		</div>
	</c:if>
	<c:if test="${form.action == 'import' }">
		<div id="icalMenuContent" class="icalMenuContent">
			<div class="icalCalendarName">
				<label class="icalCalendarNameLabel"><util:message key='hn.title.export.calendarName'/></label>
				<a class="icsLink" id="icsImportLink" url="<%=request.getContextPath() %>/calendar/<c:out value="${form.calendarId}"/>/ics/exportSchedule.hanc" href="javascript:enCal.exportICS();"></a>
			</div>
			<div class="icalICSBrowse">
				<input type="file" id="icsFile" onchange="enCal.checkeFileExtension(this);"/>
			</div>
		</div>
	</c:if>
</div>