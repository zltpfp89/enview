<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%
	String _cPath = request.getContextPath();
%>
<style>
	.dateTime {
	 	float: none;
	 	margin-bottom : 7px;
	 }
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("#startDay_img").click(function(){ $("#start").focus(); });
		$("#start").datepicker({ dateFormat: "yy.mm.dd", });
		
		$("#endDay_img").click(function(){ $("#end").focus(); });
		$("#end").datepicker({
			dateFormat: "yy.mm.dd",
		});
		
		$("#add_Attends").click(function(){
			if($("input:checkbox[id='add_Attends']").is(":checked")==true){
				$("#add_Attends_Tr").attr("style","display:''");
				$("#add_Attends_Tr2").attr("style","display:''");
			}else if($("input:checkbox[id='add_Attends']").is(":checked")==false){
				$("#add_Attends_Tr").attr("style","display:none;");
				$("#add_Attends_Tr2").attr("style","display:none;");
			}
		});
		
		
	});
</script>
		<form>
			<fieldset>
				<legend>글쓰기</legend>
				<div class="write_body" style="background-color: white;">
					<table class="tbl_normal" style="width: 100%; ">
						<caption>일정</caption>
						<colgroup></colgroup>
						<tbody>
							<tr>
								<th scope="row" style="text-align: left;"colspan="2">
									<input type="hidden" id="isJoint" name="isJoint" value="<c:out value="${form.isJoint }"/>"/>								
									<input type="hidden" id="cmd" name="cmd" value="<c:out value="${form.cmd }"/>"/>
									<span>
										<c:if test="${form.cmd == 'MODIFY' }"><util:message key='hn.title.schedule.modify'/></c:if><c:if test="${form.cmd != 'MODIFY' }"><util:message key='hn.title.schedule.add'/></c:if>
									</span>	
								</th>
							</tr>						
							<tr>
								<td colspan="2">
									<div style="width: 100%; display: inline; margrin-left:10px;">
										<input type="hidden" id="prevCalendarId" value="<c:out value="${form.calendarId}"/>"/><util:message key='kaist.mobile.fullmenu.calendar'/>
										<select name="calendarId" id="selectedCalendarId" style="margin-left:10px;">
											<c:forEach items="${calendarList }" var="calendar" varStatus="status">
												<c:if test="${fn:indexOf(calendar.permissions, 'C') > -1 || fn:indexOf(calendar.permissions, 'U') > -1 }">
													<option value="<c:out value="${calendar.calendarId}"/>" <c:if test="${calendar.calendarId == form.calendarId}">selected="selected"</c:if>><c:out value="${calendar.name}" escapeXml="false"/></option>
												</c:if>
											</c:forEach>
										</select>
									</div>
									<div class="title_box2" style="margin-top: 7px;">
										<label for="inp_3" class="title"><util:message key='kaist.mobile.calendar.date'/></label>
										<p class="inp_info" style="width: 92%;">
											<span class="inp_span" >
												<input type="text" style="width:75px;" class="date" readonly="readonly" id="start" name="start" value="<c:out value="${schedule.startDate }"/>"  />
												<button type="button" class="btn_img" id="startDay_img"><img style="margin-left:5px;" src="<%=_cPath%>/kaist/images/mobile/btn_cal.png" alt="달력선택"> ~ </button>
											</span>										
											<span class="inp_span">
												<input type="text" style="width:75px;" class="date" readonly="readonly" id="end" name="end" value="<c:out value="${schedule.endDate }"/>"   />
												<button type="button" class="btn_img" id="endDay_img"><img style="margin-left:5px;" src="<%=_cPath%>/kaist/images/mobile/btn_cal.png" alt="달력선택"></button>
											</span>
											<div class="dateTime" id="startTime" style="margin-left:50px; width:69px; margin-top: 7px; "><c:out value="${schedule.startTime12 }"/>
												<input type="hidden" name="times" value="<c:out value="${schedule.startTime23 }"/>"/>
											</div>
											<img style="display:none;" class="dateTime_img" src="<%=_cPath%>/kaist/images/mobile/btn_time.png">
											<span class="dateTime_img" style="display:none;" >~</span>
												<div class="dateTime" id="endTime" style="margin-left:0px; width:69px; "><c:out value="${schedule.endTime12 }"/>
													<input  type="hidden" name="times" value="<c:out value="${schedule.startTime23 }"/>"/>
												</div>
												<img style="display:none;" class="dateTime_img" src="<%=_cPath%>/kaist/images/mobile/btn_time.png">	
										</p>
										<input type="checkbox" style="margin-left: 50px;" name="allday" id="allday" <c:if test="${schedule.allday == true }">checked="checked"</c:if>/>
										<util:message key='hn.title.schedule.allday'/> 
									</div>
									<c:if test="${form.isPublic == 'Y' }">
										<c:forEach items="${scheduleLangList }" var="lang" varStatus="status">
											<div id="scheduleName" class="title_box2">
												<label for="inp_3" class="title"><util:message key='kaist.req.subject'/></label>
												<p class="inp_info">
													<input type="text" langKnd="<c:out value="${lang.langKnd }"/>" name="nameList" value="<c:out value="${lang.name }" escapeXml="false"/>"/>
												</p>
											</div>
										</c:forEach>
									</c:if>
									<c:if test="${form.isPublic != 'Y' }">
										<div id="scheduleName" class="title_box2">
											<label for="inp_3" class="title"><util:message key='kaist.req.subject'/></label>
											<p class="inp_info">
												<input type="text" id="name" name="name" value="<c:out value="${scheduleLang.name }" escapeXml="false"/>"/>
											</p>
										</div>
									</c:if>
									<c:if test="${form.isPublic == 'Y' }">			
										<c:forEach items="${scheduleLangList }" var="lang" varStatus="status">
											<div class="title_box2">
												<label for="inp_3" class="title"><util:message key='hn.title.schedule.place'/></label>
												<p class="inp_info">
													<input type="text" langKnd="<c:out value="${lang.langKnd }"/>" name="placeList" value="<c:out value="${lang.place }"/>"/>
												</p>
											</div>
											<div class="title_box2">
												<label for="inp_3" class="title"><util:message key='hn.title.schedule.comments'/></label>
												<p class="inp_info">
													<textarea langKnd="<c:out value="${lang.langKnd }"/>" name="commentsList" cols="58" rows="3"><c:out value="${lang.comments }"/></textarea>
												</p>
											</div>
										</c:forEach>					
									</c:if>
									<c:if test="${form.isPublic != 'Y' }">				
										<div class="title_box2">
											<label for="inp_3" class="title"><util:message key='hn.title.schedule.place'/></label>
											<p class="inp_info">
												<input type="text" id="schedulePlace" name="place" value="<c:out value="${scheduleLang.place }"/>"/>
											</p>
										</div>
										<div class="title_box2">
											<label for="inp_3" class="title"><util:message key='hn.title.schedule.comments'/></label>
											<p class="inp_info">
												<textarea name="comments"  id="scheduleComments"cols="58" rows="3"><c:out value="${scheduleLang.comments }"/></textarea>
											</p>
										</div>				
									</c:if>
								</td>
							</tr>						
							<tr id="add_Attends_Tr" style="display: none;">
								<td valign="top"  style="border-right-color: white; border-bottom-color: white;" >
									<c:if test="${form.isPublic != 'Y' && ( schedule.isOwner || fn:indexOf(schedule.calPermissions, 'U') > -1 || fn:indexOf(schedule.permissions, 'U') > -1 || fn:indexOf(schedule.permissions, 'A') > -1 ) }">
										<div class="title_box2" >
											<label for="inp_3" class="title"><util:message key='hn.title.schedule.attends'/><br><util:message key='kaist.mobile.staffnotebook.search'/></label>
											<p class="inp_info" >
												<span class="inp_span"  style="margin-top: 10px;" >
													<input type="text" name="searchUser" id="searchUser" style="width: 70px;"/>
													<a id="searchUserButton" ><img src="<%=_cPath%>/kaist/images/mobile/btn_srch.png" alt="검색" /></a>
												</span>
											</p>
										</div>
									</c:if>
								</td>
								<td style="border-bottom-color: white;  width:100px; table-layout: fixed;" >
									<div id="attends" class="attends" style="display:inline-block; ">
										<c:forEach items="${scheduleUserList }" var="user" varStatus="status">
											<div userId="<c:out value="${user.userId}"/>" userName="<c:out value="${user.userName}" escapeXml="false"/>" class="scheduleUser"<c:if test="${user.isOwner == 'Y' }"> style="color:#ccc"</c:if>>
												<div class="name" title="<c:out value="${user.userName}"/>(<c:out value="${user.userId}"/>)"><c:out value="${user.userName}" escapeXml="false"/>(<c:out value="${user.userId}"/>)</div>
												<c:if test="${user.isOwner != 'Y' }"><span class="deleteUser ui-icon ui-icon-trash" onclick="enCal.deleteUser(this)"></span></c:if>
											</div>
										</c:forEach>
									</div>
								</td>
							</tr>
							<tr id="add_Attends_Tr2" style="display: none;">
								<td colspan="2" >
									<c:if test="${form.isPublic != 'Y' && ( schedule.isOwner || fn:indexOf(schedule.calPermissions, 'U') > -1 || fn:indexOf(schedule.permissions, 'U') > -1 || fn:indexOf(schedule.permissions, 'A') > -1 ) }">
										<div style="display: inline;">
											<div id="scheduleUserPermissions" class="scheduleUserPermissions"  style="margin-bottom: 10px;"><util:message key='hn.title.schedule.attends.permission'  /></div>
											<div id="permissions" class="permissions" >
											<div class="permission" style="display: inline;">
												<input class="permissionCheck" id="permissionU" type="checkbox" name="permissionU" value="U" <c:if test="${fn:indexOf(schedule.permissions, 'U') > -1 }">checked="chekced"</c:if>/><util:message key='hn.title.schedule.attends.permission.u'/>
											</div>
											<div class="permission" style="display: inline;">
												<input class="permissionCheck" id="permissionA" type="checkbox" name="permissionA" value="A" <c:if test="${fn:indexOf(schedule.permissions, 'A') > -1 }">checked="chekced"</c:if><c:if test="${fn:indexOf(schedule.permissions, 'U') > -1 }"> disabled="disabled"</c:if>/><util:message key='hn.title.schedule.attends.permission.a'/>
											</div>
											<div class="permission" style="display: inline;">
												<input class="permissionCheck" id="permissionR" type="checkbox" name="permissionR" value="R" <c:if test="${fn:indexOf(schedule.permissions, 'R') > -1 }">checked="chekced"</c:if><c:if test="${fn:indexOf(schedule.permissions, 'U') > -1 }"> disabled="disabled"</c:if>/><util:message key='hn.title.schedule.attends.permission.r'/>
											</div>
											</div>
										</div>
									</c:if>	
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div id="scheduleDetailFooter" class="" style="text-align: right;">
										<div class="">
											<div class="btn medium white" onclick="edit_cancel();"><util:message key='ev.title.cancel'/></div>
											<div class="btn medium white" onclick="enCal.saveSchedule('<c:out value="${form.scheduleId }"/>');" ><util:message key='hn.title.schedule.save'/></div>
										</div>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</fieldset>
		</form>
