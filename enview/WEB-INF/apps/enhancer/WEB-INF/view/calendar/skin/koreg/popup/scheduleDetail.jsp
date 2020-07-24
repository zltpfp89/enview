<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="com.saltware.enview.security.EVSubject"
	import="com.saltware.enview.security.UserInfo"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
UserInfo userInfo = EVSubject.getUserInfo();
%>
<c:set var="userInfo" value="<%= userInfo.getUserInfoMap() %>" />

<%-- <link rel="stylesheet" type="text/css" href="${cPath }/koreg/css/board.css" /> --%>

<div id="scheduleDetails" class="scheduleEdit scheduleDetails<c:if test="${calendar.bilingual && calendar.isPublic }">Public</c:if>" style="width: 80%" >

		<div class="tsearchArea">
             <p style="padding-top: 1.5px;"><strong ><c:if test="${form.cmd == 'MODIFY' }">일정 수정</c:if><c:if test="${form.cmd != 'MODIFY' }">일정 등록</c:if></strong></p>
			<input type="hidden" id="isJoint" name="isJoint" value="<c:out value="${calendar.isJoint }"/>"/>
			<input type="hidden" id="cmd" name="cmd" value="<c:out value="${form.cmd }"/>"/>
        </div>

		<table cellpadding="0" cellspacing="0" summary="게시판리스트"  style="margin-top:0;">
                <caption>게시판리스트</caption>
                    <colgroup>
                        <col width="10%" />
                        <col width="90%" />
                    </colgroup>

                    <tr style="display: none;">
                        <th class="first L">달력</th>
                        <td>
                        	<select name="calendarId" id="selectedCalendarId" class="selectedCalendar" >
								<c:forEach items="${calendarList }" var="calendar" varStatus="status">
									<c:if test="${fn:indexOf(calendar.permissions, 'C') > -1 || fn:indexOf(calendar.permissions, 'U') > -1 }">
										<option value="<c:out value="${calendar.calendarId}"/>" <c:if test="${calendar.calendarId == form.calendarId}">selected="selected"</c:if>><c:out value="${calendar.name}" escapeXml="false"/></option>
									</c:if>
								</c:forEach>
							</select>
                        </td>
                    </tr>


                    <tr>
                        <th class="first L">제목 </th>
                        <td>
                        	<input type="hidden" id="prevCalendarId" value="<c:out value="${form.calendarId}"/>"/>
							<c:if test="${!calendar.bilingual || !calendar.isPublic }">
<!-- 								<div class="scheduleName" id="scheduleName" > -->
									<input class="subject" maxlength="100" type="text" id="name" name="name" value="<c:out value="${scheduleLang.name }" escapeXml="false"/>"/>
<!-- 								</div> -->
							</c:if>
                        </td>
                    </tr>
<!--                     <tr> -->
<!--                         <th class="first L">유형</th> -->
<!--                         <td> -->
<!--                             <div class="sel_150"> -->
<!--                                 <select class="txt_150"> -->
<!--                                     <option>개인</option> -->
<!--                                     <option>기념일</option> -->
<!--                                     <option>업무</option> -->
<!--                                 </select> -->
<!--                             </div> -->
<!--                     	</td> -->
<!--                     </tr> -->
                    <tr>
                        <th class="first L" rowspan="2">시간</th>
                        <td class="selzone" style="padding-top: 10px;">
	                        <div class="scheduleDate">
								<div id="startDates" class="startDates">
									<input type="text" class="date" readonly="readonly" id="start" name="start" value="<c:out value="${schedule.startDate }"/>" <c:if test="${schedule.rrule != null && schedule.startDate != schedule.repeatStartDate }">disabled="disabled"</c:if>/>
									<div class="dateTime ${langKnd }" style="padding:5px; height:12px;" id="startTime"><c:out value="${schedule.startTime12ap }"/><input type="hidden" name="times" value="<c:out value="${schedule.startTime23 }"/>"/></div>
								</div>
								<label class="dateRange">&nbsp;~&nbsp;</label>
								<div id="endDates" class="endDates">
									<input type="text" class="date" readonly="readonly" id="end" name="end" value="<c:out value="${schedule.endDate }"/>" <c:if test="${schedule.rrule != null && schedule.startDate != schedule.repeatStartDate }">disabled="disabled"</c:if>/>
									<div class="dateTime ${langKnd }" style="padding:5px; height:12px;" id="endTime"><c:out value="${schedule.endTime12ap }"/><input type="hidden" name="times" value="<c:out value="${schedule.endTime23 }"/>"/></div>
								</div>
							</div>
                    	</td>
                   </tr>
                   <tr>
                        <td style="border-top:0 none;">
                            <div class="scheduleAllday">
								<input type="checkbox" name="allday" id="allday" <c:if test="${schedule.allday == true }">checked="checked"</c:if>/><label for="allday"><util:message key='hn.title.schedule.allday'/></label>
							</div>
                        </td>
                    </tr>

                    <tr>
                        <th class="first L">공유</th>
                        <td>
                            <fieldset>
                                <form id="share" name="share" method="post" action="">
                                    <c:forEach items="${calendarList }" var="calendar" varStatus="status">
										<c:if test="${fn:indexOf(calendar.permissions, 'C') > -1 || fn:indexOf(calendar.permissions, 'U') > -1 }">
											<input type="radio" name="calSelectRaido" value="<c:out value="${calendar.calendarId}"/>"  <c:if test="${calendar.calendarId == form.calendarId}">checked="checked" </c:if>  />
											<c:if test="${calendar.name eq userInfo['user_id'] }">개인 </c:if>
											<c:if test="${calendar.name ne userInfo['user_id'] }">${calendar.name } </c:if>
										</c:if>
									</c:forEach>
                                </form>
                            </fieldset>
                    	</td>
                    </tr>

                    <tr>
                        <th class="first L">알림</th>
                        <td>
                            <form id="notice" name="notice" method="post" action="">
                            	<input type="checkbox" id="alarmPattern" <c:if test="${schedule.alarmPattern != null }">checked="checked"</c:if>/><label for="alarmPattern">&nbsp;사용</label>
								<input type="radio" name="alarmPattern" id="alarmPattern_b10m"  value="b10m" disabled="disabled" checked="checked" /><label for="alarmPattern_b10m">&nbsp;<util:message key='hn.title.schedule.alarmPattern.b10m'/></label>
								<input type="radio" name="alarmPattern" id="alarmPattern_b20m"  value="b20m" disabled="disabled" <c:if test="${schedule.alarmPattern == 'b20m' }">checked="checked"</c:if>/><label for="alarmPattern_b20m">&nbsp;<util:message key='hn.title.schedule.alarmPattern.b20m'/></label>
								<input type="radio" name="alarmPattern" id="alarmPattern_b1h"   value="b1h"  disabled="disabled" <c:if test="${schedule.alarmPattern == 'b1h'  }">checked="checked"</c:if>/><label for="alarmPattern_b1h">&nbsp;<util:message key='hn.title.schedule.alarmPattern.b1h'/></label>
								<input type="radio" name="alarmPattern" id="alarmPattern_b12h"  value="b12h" disabled="disabled" <c:if test="${schedule.alarmPattern == 'b12h' }">checked="checked"</c:if>/><label for="alarmPattern_b12h">&nbsp;<util:message key='hn.title.schedule.alarmPattern.b12h'/></label>
								<input type="radio" name="alarmPattern" id="alarmPattern_b1d"   value="b1d"  disabled="disabled" <c:if test="${schedule.alarmPattern == 'b1d'  }">checked="checked"</c:if>/><label for="alarmPattern_b1d">&nbsp;<util:message key='hn.title.schedule.alarmPattern.b1d'/></label>
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <th class="first L">반복</th>
                        <td>
                    		<div class="scheduleRrule">
								<input type="checkbox" name="rruleLabel" id="rrule" <c:if test="${schedule.rrule != null && schedule.startDate != schedule.repeatStartDate }">disabled="disabled"</c:if><c:if test="${schedule.rrule != null && schedule.freq != 'MONTHLY' && schedule.freq != 'YEARLY' }">checked="checked"</c:if>/><label for="rrule"><util:message key='hn.title.schedule.rrule'/></label>
								<label class="valLabel"><util:message key='hn.title.schedule.rrule.text'/></label>: <label class="valLabel" id="rruleText"><util:message key='hn.title.schedule.rrule.noRepeat'/></label> 
							</div>
							<div class="scheduleRrule">
								<label class="valLabel"><util:message key='hn.title.schedule.rrule.freq'/>:</label>
								<select id="freq" name="freq">
									<option value="DAILY" <c:if test="${schedule.freq == 'DAILY'}">selected="selected"</c:if>><util:message key='hn.title.schedule.rrule.freq.daily'/></option>
									<option value="WEEKLY" <c:if test="${schedule.freq == 'WEEKLY'}">selected="selected"</c:if>><util:message key='hn.title.schedule.rrule.freq.weekly'/></option>
									<%-- <option value="MONTHLY" <c:if test="${schedule.freq == 'MONTHLY'}">selected="selected"</c:if>><util:message key='hn.title.schedule.rrule.freq.monthly'/></option> --%>
									<%-- <option value="YEARLY" <c:if test="${schedule.freq == 'YEARLY'}">selected="selected"</c:if>><util:message key='hn.title.schedule.rrule.freq.yearly'/></option> --%>
								</select>
								<label class="valLabel"><util:message key='hn.title.schedule.rrule.interval'/>:</label>
								<input type="hidden" id="orgInterval" value="${schedule.interval}"/>
								<select id="interval" name="interval">
									<c:forEach begin="1" end="30" var="interval">
										<option value="${interval}" <c:if test="${schedule.interval == interval}">selected="selected"</c:if>>${interval}</option>
									</c:forEach>
								</select>
							</div>
							<div class="scheduleRrule" id="scheduleRruleByday">
								<label class="valLabel"><util:message key='hn.title.schedule.rrule.byday'/>:</label>
								<input type="checkbox" name="byday" id="su" value="su" <c:if test="${fn:indexOf(schedule.byday, 'su') > -1}">checked="checked"</c:if>/><label class="valLabel" for="su"><util:message key='hn.title.schedule.rrule.byday.su'/></label>
								<input type="checkbox" name="byday" id="mo" value="mo" <c:if test="${fn:indexOf(schedule.byday, 'mo') > -1}">checked="checked"</c:if>/><label class="valLabel" for="mo"><util:message key='hn.title.schedule.rrule.byday.mo'/></label>
								<input type="checkbox" name="byday" id="tu" value="tu" <c:if test="${fn:indexOf(schedule.byday, 'tu') > -1}">checked="checked"</c:if>/><label class="valLabel" for="tu"><util:message key='hn.title.schedule.rrule.byday.tu'/></label>
								<input type="checkbox" name="byday" id="we" value="we" <c:if test="${fn:indexOf(schedule.byday, 'we') > -1}">checked="checked"</c:if>/><label class="valLabel" for="we"><util:message key='hn.title.schedule.rrule.byday.we'/></label>
								<input type="checkbox" name="byday" id="th" value="th" <c:if test="${fn:indexOf(schedule.byday, 'th') > -1}">checked="checked"</c:if>/><label class="valLabel" for="th"><util:message key='hn.title.schedule.rrule.byday.th'/></label>
								<input type="checkbox" name="byday" id="fr" value="fr" <c:if test="${fn:indexOf(schedule.byday, 'fr') > -1}">checked="checked"</c:if>/><label class="valLabel" for="fr"><util:message key='hn.title.schedule.rrule.byday.fr'/></label>
								<input type="checkbox" name="byday" id="sa" value="sa" <c:if test="${fn:indexOf(schedule.byday, 'sa') > -1}">checked="checked"</c:if>/><label class="valLabel" for="sa"><util:message key='hn.title.schedule.rrule.byday.sa'/></label>
							</div>
							<div class="scheduleRrule" id="scheduleRruleBymonthday">
								<label class="valLabel"><util:message key='hn.title.schedule.rrule.bymonthday'/>:</label>
								<input type="radio" name="bymonthday" id="bymonthday" value="bymonthday" <c:if test="${schedule.byday == null}">checked="checked"</c:if>/><label class="valLabel" for="bymonthday"><util:message key='hn.title.schedule.rrule.bymonthday'/></label>
								<input type="radio" name="bymonthday" id="byday" value="byday" <c:if test="${schedule.byday != null}">checked="checked"</c:if>/><label class="valLabel" for="byday"><util:message key='hn.title.schedule.rrule.byday'/></label>
							</div>
							<div class="scheduleRruleDate" id="scheduleRruleStartDate">
								<label class="valLabel"><util:message key='hn.title.schedule.startDate'/>:</label>
								<div id="rruleStartDates" class="rruleStartDates">
									<input type="text" class="rruleDate" readonly="readonly" disabled="disabled" id="rruleStart" name="rruleStart" value="<c:if test="${schedule.repeatStart != null }"><c:out value="${schedule.repeatStartDate }"/></c:if>"/>
								</div>
							</div>
							<div class="scheduleRruleDate" id="scheduleRruleEndDate">
							<label class="valLabel"><util:message key='hn.title.schedule.endDate'/>:</label>
								<input type="radio" name="untilType" id="untilType_unlimited" value="unlimited" <c:if test="${schedule.until == null }">checked="checked"</c:if> /><label class="valLabel" for="untilType_unlimited"><util:message key='hn.title.schedule.endDate.unlimited'/></label>
								<input type="radio" name="untilType" id="untilType_limited" value="limited" <c:if test="${schedule.until != null }">checked="checked"</c:if>/><label class="valLabel" for="untilType_limited"><util:message key='hn.title.schedule.endDate.unlimited'/>:</label>
								<div id="rruleEndDates" class="rruleEndDates">
									<input type="text" class="rruleDate" readonly="readonly" id="until" name="until" value="<c:if test="${schedule.until != null }"><c:out value="${schedule.untilDate }"/></c:if>"/>
								</div>
							</div>
                    	</td>
                    </tr>
                    <tr>
                        <th class="first L">내용</th>
                        <td>
                        	<c:if test="${ !calendar.bilingual || !calendar.isPublic }">
								<div class="scheduleComments">
									<textarea name="comments" id="scheduleComments"cols="58" rows="3"><c:out value="${scheduleLang.comments }"/></textarea>
								</div>
							</c:if>
                        </td>
                    </tr>
                </table>

                <div class="btnArea" style="width: 100%;">
                	<div class="leftArea" style="text-align: left;" id="scheduleDetailClose"><a href="#" class="btn_gray"><span>취 소</span></a></div>
                    <div class="rightArea" style="text-align: right; margin-right: 4px; margin-top: 6px;"><a href="#" class="btn_gray" onclick="enCal.saveSchedule();"><span>등 록</span></a></div>
                </div>



</div>