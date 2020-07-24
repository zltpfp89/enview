<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%
	Map param = (Map)request.getAttribute("paramMap");
	String srchStartDate = (String)param.get("baseDate");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>calendar</title>
	<link rel='stylesheet' type='text/css' href="<%=request.getContextPath()%>/hancer/css/event/ev_miniCal.css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.7.2.min.js"></script>
	<script type="text/javascript">
		var contextPath = "<%=request.getContextPath()%>/hancer";
		var more_src = <%=request.getAttribute("MORE_SRC")%>;
		var more_src_target = <%=request.getAttribute("MORE_SRC_TARGET")%>;
		var baseDate = '<%=srchStartDate%>';
		var baseYear = '';
		var baseMonth = '';
		var baseDay = '';

		if(baseDate == '' || baseDate == null || baseDate == 'null' || baseDate == undefined){
			var date = new Date();
			baseYear = date.getFullYear();
			baseMonth = date.getMonth()+1;
			baseDay = date.getDate();
		}else{
			baseYear = baseDate.substr(0,4);
			if(baseDate.substr(4,1) == '0')
				baseMonth = baseDate.substr(5,1); 
			if(baseDate.substr(4,1) == '1')
				baseMonth = baseDate.substr(4,2); 
			baseDay = baseDate.substr(6,2);
		}

		var options = {
				isMini:			false,	//미니보드 여부
				isCalMode:		true,	//달력만 보고 싶을 땐 true
				year:			baseYear,
				month:			baseMonth,
				day:			baseDay,
				bgColor:		'#f9f9f9',
				weekBgColor:	'#dedede',
				todayOrder:		true,
				todayColor:		'#000',
				todayBgColor:	'#ececec',
				typeColor:		['#3a3', '', '', '', '', '', '', '', '', '', '#00f'],
				isDateColor:	false,
				isWeekColor:	true,
				isDayOver:		true,
				weekFont:		{ 'font-size': '8pt', 'font-family': 'gulim', 'font-weight': 'bold' },
				dateFont:		{ 'font-size': '8pt', 'font-family': 'gulim' },
				tdWidth:		<%=request.getAttribute("tdWidth")%> == null ? 28 : <%=request.getAttribute("tdWidth")%>, // total width: 32 * 7 + 8 = 232, 24 * 7 + 8 = 176
				tdHeight:		<%=request.getAttribute("tdHeight")%> == null ? 18 : <%=request.getAttribute("tdHeight")%>, 
				todayCount:		4, // 0 이하는 모두 보여주기, 1~5개 까지 보여줄  수 있음
				allDayOnly:		false,	//오늘의 일정에 하루종일인 것만 보여줄 것인지 정하는 변수
				publicOnly:		false,
				typeClass:		['public', '', '', '', '', '', '', '', '', 'private'],	
				typeText:		['학사일정','','','','','','','','','개인일정'],
				weeks:			['sun','mon','tue','wen','thu','fri','sat'],
				href:			(more_src == null ? contextPath + '/event/privateEvent.hanc' : more_src),
				target:			(more_src_target == null ? '_blank' : more_src_target)				
		};
	</script>
	<script type='text/javascript' src="<%=request.getContextPath()%>/hancer/javascript/event/event.js"></script>
</head>
<body>
	<div id="mini_calendar" class="me">
		<div class="me-header">
			<div class="me-header-left"><img id="today_button" class="today" src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/calendar/btn/btn_today_en.gif" alt="today" /></div>
			<div class="me-header-center">
				<img id="prev_button" class="prev-button" src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/calendar/btn/btn_prev.gif" alt="preview" />
				<img id="month" class="month" alt="month" />
				<img id="next_button" class="next-button" src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/calendar/btn/btn_next.gif" alt="next" />
			</div>
			<div class="me-header-right">
			</div>
		</div>
		<div class="me-calendar">
			<table id="date_table" class="me-calendar-table" >
				<tr class="me-calendar-weeks"></tr>
			</table>
		</div>
	</div>
</body>
</html>