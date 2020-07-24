if( ! window.hancer )
    window.hancer = new Object();

if( ! window.hancer.cal )
    window.hancer.cal = new Object();

if( ! window.hancer.cal.skin )
	window.hancer.cal.skin = new Object();

hancer.cal.skin = function() {
	enCal.m_skin = this.m_skin;
}

hancer.cal.skin.prototype = {
	m_contextPath : null,
		
	// display
	defaultView: 'month',
	aspectRatio: 1.35,
	header: {
		left: 'agendaDay agendaWeek month',
		center: 'prev title next',
		right: 'today'
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
		week: "yyyy년 MMM월 d일{ '&#8212;' [yyyy년 ][MMM월 ]d일}",
		day: 'yyyy년 MMM월 d일, dddd'
	},
	columnFormat: {
		month: 'ddd',
		week: 'ddd M/d',
		day: 'dddd M/d'
	},
	timeFormat: {'': 'hh(:mm)t'},
	
	// locale
	isRTL: false,
	firstDay: 0,
	monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
	dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
	dayNamesShort: ['일','월','화','수','목','금','토'],
	buttonText: {
		prev: "<span class='fc-text-arrow'>&lsaquo;</span>",
		next: "<span class='fc-text-arrow'>&rsaquo;</span>",
		prevYear: "<span class='fc-text-arrow'>&laquo;</span>",
		nextYear: "<span class='fc-text-arrow'>&raquo;</span>",
		today: '오늘(Today)',
		month: '월(Month)',
		week: '주(Week)',
		day: '일(Day)'
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
	
	m_skin : 'tile'
	
};

var enCalSkin = new hancer.cal.skin();