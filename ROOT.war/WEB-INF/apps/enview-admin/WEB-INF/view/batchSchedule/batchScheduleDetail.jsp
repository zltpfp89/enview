
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/styles.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/admin/javascript/batchScheduleManager.js"></script>

<form id="BatchScheduleManager_EditForm" style="display:inline" action="" method="post">
	<input type="hidden" id="BatchScheduleManager_isCreate">
	<input type="hidden" id="BatchScheduleManager_actionId" name="actionId" />
	<input type="hidden" id="BatchScheduleManager_scheduleId" name="scheduleId" />
	<input type="hidden" id="BatchScheduleManager_executeWeeks" name="executeWeeks" />			
	<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
 		<caption>게시판</caption>
		<colgroup>
			<col width="140px" />
			<col width="*" />
			<col width="140px" />
			<col width="*" />
		</colgroup>
		<tr>
			<th class="L"><util:message key='ev.prop.batchAction.actionName'/> <em>*</em></th>
			<td class="L">
				<input type="text" id="BatchScheduleManager_actionName0" name="actionName0" value="<c:out value="${aBatchScheduleVO.actionName0}"/>" maxLength="" style="width:75%;" readOnly="true" label="<util:message key='ev.prop.batchAction.actionName'/>" class="txt_200" />
				<a href="javascript:aBatchScheduleManager.getBatchActionChooser().doShow(aBatchScheduleManager.setBatchActionChooserCallback)" class="btn_O"><span><util:message key='ev.title.selectBatchAction'/></span></a>
			</td>
			<th class="L"><util:message key='ev.prop.batchSchedule.isLogging'/></th>
			<td class="L"><input type="checkbox" id="BatchScheduleManager_isLogging" name="isLogging" value="<c:out value="${aBatchScheduleVO.isLogging}"/>" label="<util:message key='ev.prop.isLogging'/>" class="txt_100" /></td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.batchSchedule.executeDay'/></th>
			<td class="L" colspan="3">
				<span>
					<div class="sel_100">
						<select id="BatchScheduleManager_executeCycle" name="executeCycle" class='txt_100' onchange="aBatchScheduleManager.doChangeExecuteCycle(this)">
							<c:forEach items="${executeCycleList}" var="executeCycle">
							<option value="<c:out value="${executeCycle.code}"/>"><c:out value="${executeCycle.codeName}"/></option>
							</c:forEach>
						</select>
					</div>
				</span>
				<span id="BatchScheduleManager_selectYear" style="display:none;"> 
					<div class="sel_100">
						<select id="BatchScheduleManager_executeYear" label="<util:message key='ev.title.batchSchedule.year'/>" class="txt_100" >
							<option value="2007">2007</option>
							<option value="2008">2008</option>
							<option value="2009">2009</option>
							<option value="2010">2010</option>
							<option value="2011">2011</option>
							<option value="2012">2012</option>
							<option value="2013">2013</option>
							<option value="2014">2014</option>
							<option value="2015">2015</option>
							<option value="2016">2016</option>
							<option value="2017">2017</option>
							<option value="2018">2018</option>
							<option value="2019">2019</option>
							<option value="2020">2020</option>
							<option value="2021">2021</option>
							<option value="2022">2022</option>
							<option value="2023">2023</option>
							<option value="2024">2024</option>
							<option value="2025">2025</option>
							<option value="2026">2026</option>
							<option value="2027">2027</option>
							<option value="2028">2028</option>
							<option value="2029">2029</option>
							<option value="2030">2030</option>
						</select>
					</div>
					<span class="sel_txt"><util:message key='ev.title.batchSchedule.year'/></span>
					<div class="sel_100">						
						<select id="BatchScheduleManager_executeYearMonth" label="<util:message key='ev.title.batchSchedule.month'/>" class="txt_100" >
							<option value="01">1</option>
							<option value="02">2</option>
							<option value="03">3</option>
							<option value="04">4</option>
							<option value="05">5</option>
							<option value="06">6</option>
							<option value="07">7</option>
							<option value="08">8</option>
							<option value="09">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select>
					</div>
					<span class="sel_txt"><util:message key='ev.title.batchSchedule.month'/></span>
					<div class="sel_100">
						<select id="BatchScheduleManager_executeYearMonthDay" label="<util:message key='ev.title.batchSchedule.day'/>" class="txt_100" >
							<option value="01">1</option>
							<option value="02">2</option>
							<option value="03">3</option>
							<option value="04">4</option>
							<option value="05">5</option>
							<option value="06">6</option>
							<option value="07">7</option>
							<option value="08">8</option>
							<option value="09">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
						</select>
					</div>
					<span class="sel_txt"><util:message key='ev.title.batchSchedule.day'/></span>
				</span>
				<span id="BatchScheduleManager_selectMonthDay" style="display:none;"> 
					<div class="sel_100">
						<select id="BatchScheduleManager_executeMonth" label="<util:message key='ev.title.batchSchedule.month'/>" class="txt_100" >
							<option value="01">1</option>
							<option value="02">2</option>
							<option value="03">3</option>
							<option value="04">4</option>
							<option value="05">5</option>
							<option value="06">6</option>
							<option value="07">7</option>
							<option value="08">8</option>
							<option value="09">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select>
					</div>
					<span class="sel_txt"><util:message key='ev.title.batchSchedule.month'/></span>
					<div class="sel_100">
						<select id="BatchScheduleManager_executeMonthDay" label="<util:message key='ev.title.batchSchedule.day'/>" class="txt_100" >
							<option value="01">1</option>
							<option value="02">2</option>
							<option value="03">3</option>
							<option value="04">4</option>
							<option value="05">5</option>
							<option value="06">6</option>
							<option value="07">7</option>
							<option value="08">8</option>
							<option value="09">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
						</select>
					</div>
					<span class="sel_txt"><util:message key='ev.title.batchSchedule.day'/></span>
				</span>
				<span id="BatchScheduleManager_selectDay" style="display:none;">
					<div class="sel_100">
						<select id='BatchScheduleManager_executeDay' label="<util:message key='ev.title.batchSchedule.day'/>" class='txt_100'>
							<option value="01">1</option>
							<option value="02">2</option>
							<option value="03">3</option>
							<option value="04">4</option>
							<option value="05">5</option>
							<option value="06">6</option>
							<option value="07">7</option>
							<option value="08">8</option>
							<option value="09">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
						</select>
					</div>
					<span class="sel_txt"><util:message key='ev.title.batchSchedule.day'/></span>
				</span>
				<span id="BatchScheduleManager_selectWeek" style="display:none;">
					SUN<input type="checkbox" id="BatchScheduleManager_executeWeek1" class="webcheckbox" />&nbsp;
					MON<input type="checkbox" id="BatchScheduleManager_executeWeek2" class="webcheckbox" />&nbsp;
					TUE<input type="checkbox" id="BatchScheduleManager_executeWeek3" class="webcheckbox" />&nbsp;
					WEB<input type="checkbox" id="BatchScheduleManager_executeWeek4" class="webcheckbox" />&nbsp;
					THU<input type="checkbox" id="BatchScheduleManager_executeWeek5" class="webcheckbox" />&nbsp;
					FRI<input type="checkbox" id="BatchScheduleManager_executeWeek6" class="webcheckbox" />&nbsp;
					SAT<input type="checkbox" id="BatchScheduleManager_executeWeek7" class="webcheckbox" />
				</span>
				<span>
					&nbsp;&nbsp;&nbsp;
					<span id="BatchScheduleManager_selectHour">
						<div class="sel_100">
							<select id="BatchScheduleManager_executeHour" label="<util:message key='ev.prop.batchSchedule.executeHour'/>" class='txt_100'> 
								<option value="0">0</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
								<option value="13">13</option>
								<option value="14">14</option>
								<option value="15">15</option>
								<option value="16">16</option>
								<option value="17">17</option>
								<option value="18">18</option>
								<option value="19">19</option>
								<option value="20">20</option>
								<option value="21">21</option>
								<option value="22">22</option>
								<option value="23">23</option>
							</select>
						</div>
						<span class="sel_txt"><util:message key='ev.prop.batchSchedule.executeHour'/></span>
					</span>
					<span id="BatchScheduleManager_selectMin">
						<div class="sel_100">
							<select id="BatchScheduleManager_executeMin" label="<util:message key='ev.prop.batchSchedule.executeMin'/>" class='txt_100'> 
								<option value="0">0</option>
								<option value="5">5</option>
								<option value="10">10</option>
								<option value="15">15</option>
								<option value="20">20</option>
								<option value="25">25</option>
								<option value="30">30</option>
								<option value="35">35</option>
								<option value="40">40</option>
								<option value="45">45</option>
								<option value="50">50</option>
								<option value="55">55</option>
							</select>
						</div>	
						<span class="sel_txt"><util:message key='ev.prop.batchSchedule.executeMin'/></span>	
						<div class="sel_100">
							<select id="BatchScheduleManager_executeSec" label="<util:message key='ev.prop.batchSchedule.executeSec'/>" class='txt_100'> 
								<option value="0">0</option>
								<option value="5">5</option>
								<option value="10">10</option>
								<option value="15">15</option>
								<option value="20">20</option>
								<option value="25">25</option>
								<option value="30">30</option>
								<option value="35">35</option>
								<option value="40">40</option>
								<option value="45">45</option>
								<option value="50">50</option>
								<option value="55">55</option>
							</select>
						</div>
						<span class="sel_txt"><util:message key='ev.prop.batchSchedule.executeSec'/></span>							
					</span>	
				</span>
			</td>
		</tr>
		<tr>
			<th class="L"><util:message key='ev.prop.batchSchedule.updUserId'/></th>
			<td class="L">
				<input type="text" id="BatchScheduleManager_updUserId" name="updUserId" value="<c:out value="${aBatchScheduleVO.updUserId}"/>" maxLength="" label="<util:message key='ev.prop.batchSchedule.updUserId'/>" class="txt_100" />
			</td>
			<th class="L"><util:message key='ev.prop.batchSchedule.updDatim'/></th>
			<td class="L"><input type="text" id="BatchScheduleManager_updDatim" name="updDatim" value="<c:out value="${aBatchScheduleVO.updDatim}"/>" label="<util:message key='ev.prop.batchSchedule.updDatim'/>" class="txt_200" /></td>
		</tr>
	</table>
	<!-- btnArea-->
	<div class="btnArea">
		<div class="rightArea">
			<a href="javascript:aBatchScheduleManager.doRun()" class="btn_B"><span><util:message key='ev.title.run'/></span></a>
			<a href="javascript:aBatchScheduleManager.doUpdate()" class="btn_B"><span><util:message key='ev.title.save'/></span></a>
		</div>
	</div>
	<!-- btnArea//-->
</form>	