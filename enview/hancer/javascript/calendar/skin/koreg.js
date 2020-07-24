if( ! window.hancer )
    window.hancer = new Object();

if( ! window.hancer.cal )
    window.hancer.cal = new Object();

if( ! window.hancer.cal.skin )
	window.hancer.cal.skin = new Object();

hancer.cal.skin = function() {
	enCal.m_skin = this.m_skin;
	this.m_contextPath = '';
}

hancer.cal.skin.prototype = {
	m_contextPath : '',

	// display
	defaultView: 'month',
	aspectRatio: 1.35,
	header: {
		left:'',
		center:'prev,title,next',
		right:'agendaDay,agendaWeek,month'
	},
	weekends: true,
	weekNumbers: false,
	weekNumberCalculation: 'iso',
	weekNumberTitle: 'W',

	// editing
	//editable: false,
	//disableDragging: false,
	//disableResizing: false,

	allDayDefault: true,
	ignoreTimezone: true,

	// event ajax
	lazyFetching: true,
	startParam: 'start',
	endParam: 'end',

	// time formats
	titleFormat: {
		month: 'yyyy년 MMMM',
		week: "yyyy년 MMM월 d일{ '~' [yyyy년 ][MMM월 ]d일}",
		day: 'yyyy년 MMM월 d일, dddd'
	},
	columnFormat: {
		month: 'ddd',
		week: 'M/d ddd',
		day: 'M월d일 dddd'
	},
	timeFormat: { // for event elements
		'': 'hh(:mm)t' // default
	},

	// locale
	isRTL: false,
	firstDay: 0,
	monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
	dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
	dayNamesShort: ['일','월','화','수','목','금','토'],
	buttonText: {
		prev: "<img alt='이전달' src='/hancer/images/calendar/koreg/sub/arr_perv_day.gif' style='margin-top:5px;'>",
		next: "<img alt='다음달' src='/hancer/images/calendar/koreg/sub/arr_next_day.gif' style='margin-top:5px;'>",
		//today: 'today',
		month:'월(Month)',
		week:'주(Week)',
		day:'일(Day)'
	},

	// jquery-ui theming
	theme: false,
	buttonIcons: {
		prev: 'circle-triangle-w',
		next: 'circle-triangle-e'
	},

	//selectable: false,
	unselectAuto: true,

	dropAccept: '*',

	handleWindowResize: true,

	allDayText:'종일',
	axisFormat:'SO hh:mm',

	m_skin : 'koreg'
};

var enCalSkin = new hancer.cal.skin();

//========================//
//=== 신용보증재단 커스터마이징 ===//
//========================//

function initCalendarStyle(){

	//title 날짜 옆 아이콘 스타일 변경
	$(".fc-header-left").attr("style","border:0px;");
	$(".fc-header-center").attr("style","border:0px;");
	$(".fc-header-right").attr("style","border:0px;");
	$(".fc-header-center>").eq(0).attr("class","").attr("style","margin-right:10px;");
	$(".fc-header-center>").eq(2).attr("class","").attr("style","margin-left:10px;");
}

$(document).ready(function(){
	initCalendarStyle();




});

