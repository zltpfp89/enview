<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<div id="schedulePops" class="scheduleEdit schedulePops">

				<div class="tsearchArea">
                    <p><strong>일정상세</strong></p>
                    <div id="scheduleClose" class="escapeButton ui-icon ui-icon-closethick" style="margin-top: 12px; margin-right: 10px;"></div>
                </div>
                <table cellpadding="0" cellspacing="0" summary="게시판리스트"  style="margin-top:0;">
                <caption>게시판리스트</caption>
                    <colgroup>
                        <col width="17%" />
                        <col width="83%" />
                    </colgroup>
                    <tr>
                        <th class="first L">제목</th>
                        <td>
                        	<input type="hidden" id="selectedSchedule" value="<c:out value="${schedule.scheduleId }"/>"/>
							<div id="scheduleDetailHeader" class="schedulePop header">
								<c:out value="${scheduleLang.name }" escapeXml="false"/>
							</div>
                        </td>
                    </tr>
                    <tr>
                    	<th class="first L">날짜</th>
                    	<td>
                    		<div class="scheduleDate"><c:out value="${schedule.schedule }"/></div>
                    	</td>
                    </tr>
                    <tr>
                        <th class="first L">내용</th>
                        <td>
							<c:out value="${scheduleLang.comments }" escapeXml="false" />
                    	</td>
                    </tr>
                </table>

                <c:if test="${ fn:indexOf(schedule.calPermissions, 'U') > -1 }">
					<div id="scheduleDetailFooter" class="schedulePop footer">
						<input type="hidden" id="detail_scheduleId" name="scheduleId" value="<c:out value="${form.scheduleId }"/>"/>
						<input type="hidden" id="detail_calendarId" name="calendarId" value="<c:out value="${schedule.calendarId }"/>"/>
						<input type="hidden" id="detail_isOwner" name="isOwner" value="<c:out value="${form.isOwner }"/>"/>
						<input type="hidden" id="detail_isDefault" name="isDefault" value="<c:out value="${form.isDefault }"/>"/>
						<input type="hidden" id="detail_isJointSchedule" name="isJointSchedule" value="<c:out value="${form.isJoint }"/>"/>
						<div>
							<c:if test="${ fn:indexOf(schedule.calPermissions, 'D') > -1 }">
								<div class="leftArea"><a href="#" class="btn_gray" onclick="enCal.deleteSchedule();"><span><util:message key='hn.title.schedule.delete'/></span></a></div>
							</c:if>
							<div class="rightArea" style="text-align: right; margin-top: 5px; margin-right: 5px; ">
								<a href="#" class="btn_gray" onclick="enCal.modifySchedule();">
									<span><util:message key='hn.title.schedule.modify'/></span>
								</a>
							</div>
						</div>
					</div>
				</c:if>

<!--                 <div class="btnArea"> -->
<!--                     <div class="rightArea"><a href="#" class="btn_gray"><span>취 소</span></a> <a href="#" class="btn_gray"><span>등 록</span></a></div> -->
<!--                 </div> -->



</div>