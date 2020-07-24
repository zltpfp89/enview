if ( ! window.enview )
    window.enview = new Object();
if ( ! window.enview )
    window.enview = new Object();
if ( ! window.enview.event )
    window.enview.event = new Object();
if ( ! window.enview.event.view )
    window.enview.event.view = new Object();
if ( ! window.enview.event.control )
    window.enview.event.control = new Object();
if ( ! window.enview.event.model )
    window.enview.event.model = new Object();
if ( ! window.enview.event.model.vo )
    window.enview.event.model.vo = new Object();

$(document).ready(function() {
	var mini = new enview.event.view.MainPanel(options);
	mini.init();
});


/******************************************************************************************************/
enview.event.view.MainPanel = function(options){
	if(options == undefined || options == null || options == 'null'){

	}
	else {
		this.m_options.isMini 		= (options.isMini		==	undefined ? this.m_options.isMini		: options.isMini	);
		this.m_options.isCalMode 	= (options.isCalMode	==	undefined ? this.m_options.isCalMode	: options.isCalMode	);
		this.m_options.year 		= (options.year			==	undefined ? this.m_options.year			: options.year		);
		this.m_options.month 		= (options.month		==	undefined ? this.m_options.month		: options.month		);
		this.m_options.day 		    = (options.day		    ==	undefined ? this.m_options.day		    : options.day		);
		this.m_options.bgColor 		= (options.bgColor		==	undefined ? this.m_options.bgColor		: options.bgColor	);
		this.m_options.weekBgColor 	= (options.weekBgColor	==	undefined ? this.m_options.weekBgColor	: options.weekBgColor	);
		this.m_options.todayOrder 	= (options.todayOrder	==	undefined ? this.m_options.todayOrder	: options.todayOrder	);
		this.m_options.todayColor 	= (options.todayColor	==	undefined ? this.m_options.todayColor	: options.todayColor	);
		this.m_options.todayBgColor = (options.todayBgColor	==	undefined ? this.m_options.todayBgColor	: options.todayBgColor	);
		this.m_options.typeColor	= (options.typeColor	==	undefined ? this.m_options.typeColor	: options.typeColor	);
		this.m_options.isDateColor 	= (options.isDateColor	==	undefined ? this.m_options.isDateColor	: options.isDateColor	);
		this.m_options.isWeekColor 	= (options.isWeekColor	==	undefined ? this.m_options.isWeekColor	: options.isWeekColor	);
		this.m_options.isDayOver 	= (options.isDayOver	==	undefined ? this.m_options.isDayOver	: options.isDayOver	);
		this.m_options.weekFont 	= (options.weekFont		==	undefined ? this.m_options.weekFont		: options.weekFont	);
		this.m_options.dateFont 	= (options.dateFont		==	undefined ? this.m_options.dateFont		: options.dateFont	);
		
		this.m_options.tdWidth 		= (options.tdWidth		==	undefined ? this.m_options.tdWidth		: options.tdWidth	);
		this.m_options.tdWidth      = (this.m_options.tdWidth < 20 ? 20 : this.m_options.tdWidth);
		this.m_options.tdHeight 	= (options.tdHeight		==	undefined ? this.m_options.tdHeight 	: options.tdHeight	);
		this.m_options.tdHeight     = (this.m_options.tdHeight < 18 ? 18 : this.m_options.tdHeight);
		this.m_options.todayCount 	= (options.todayCount	==	undefined ? this.m_options.todayCount	: options.todayCount);
		this.m_options.allDayOnly 	= (options.allDayOnly	==	undefined ? this.m_options.allDayOnly	: options.allDayOnly);
		this.m_options.publicOnly 	= (options.publicOnly	==	undefined ? this.m_options.publicOnly	: options.publicOnly);
		this.m_options.isTodayHidden= (options.isTodayHidden==	undefined ? this.m_options.isTodayHidden: options.isTodayHidden);
		this.m_options.typeClass 	= (options.typeClass	==	undefined ? this.m_options.typeClass	: options.typeClass	);
		this.m_options.typeText 	= (options.typeText		==	undefined ? this.m_options.typeText		: options.typeText	);
		this.m_options.weeks 		= (options.weeks		==	undefined ? this.m_options.weeks		: options.weeks		);
		this.m_options.href 		= (options.href			==	undefined ? this.m_options.href			: options.href		);
		this.m_options.target 		= (options.target		==	undefined ? this.m_options.target		: options.target	);
	}
	/**
	 * jquery function 안에서 this를 참조 할 수 있도록 하기 위한 절차
	 */
	var $this = this;
	
	/**
	 * 오늘보기 등, 오늘의 날짜를 이요할 때 쓰는 변수
	 */
	var today = new Date();
	
	/** 
	 * 자식 객체 생성.
	 * enview.event.month: 달력의 숫자를 표시 해주는 부분
	 * enview.event.today: mini보드일 경우 오늘의 일정 표시해주는 부분
	 */
	this.controlPanel = new enview.event.view.ControlPanel(this);
	this.monthPanel = new enview.event.view.MonthPanel(this);
	/**
	 * calendar가 미니보드용일 경우 event.event.today 객체 생성
	 */
	if(this.m_options.isMini && !this.m_options.isCalMode){
		//this.todayPanel = new enview.event.view.TodayPanel(this);
	}
	
	this.controlPanel.setMonthPanel(this.monthPanel);
};

/******************************************************************************************************/
enview.event.view.MainPanel.prototype = {
	/* default options	*/
	m_options: {
		isMiniMode:		false,
		isCalMode:		true,
		year:			new Date().getFullYear(),
		month:			new Date().getMonth(),
		day:			new Date().getDate()+1,
		bgColor:		'#ececec',
		weekBgColor:	'#a7a7a7',
		todayOrder:		false,
		todayColor:		'#fff',
		todayBgColor:	'#ececed',
		typeColor:		['#3A3', '', '', '', '', '', '', '', '', '', '#00F'],
		isDateColor:	false,
		isWeekColor:	true,
		isDayOver:		true,
		weekFont:		{ 'font-size': '11px', 'font-family': 'gulim', 'font-weight': 'bold' },
		dateFont:		{ 'font-size': '11px', 'font-family': 'gulim' },
		tdWidth:		25,
		tdHeight:		22,
		todayCount:		0, // 0 이하는 모두 보여주기, 1~5개 까지 보여줄  수 있음
		allDayOnly:		true,
		overClass:		['public-over','','','','','','','','','private-over'],
		typeClass:		['public', '', '', '', '', '', '', '', '', 'private'],	
		typeText:		['공개일정','','','','','','','','','개인일정'],
		weeks:			['Sun','Mon','Tue','Wed','Thu','Fri','Sat'],
		href:			(more_src == null ? contextPath + '/event/privateEvent.face' : more_src),
		target:			(more_src_target == null ? '_self' : more_src_target)
	},

	/* member varies */
	controlPanel:	null,		//조작 패널
	monthPanel:		null,		//달력 패널
	todayPanel:		null,		//오늘의 일정 패널
	
	getTypeClass:	function(index){
		return	this.m_options.typeClass[index];
	},
	getTypeText:	function(index){
		return	this.m_options.typeText[index];
	},
	init:	function(){
		this.controlPanel.init();
		this.monthPanel.init();
		
		if(this.m_options.isMini && !this.m_options.isCalMode){
			//this.todayPanel.init();
		}
		
		$('.me').css('background-color', this.m_options.bgColor);
	}
};

/******************************************************************************************************/
enview.event.view.ControlPanel = function(parent){
	var $this = this;
	this.m_mini = parent;

	this.controlPanelController = new enview.event.control.ControlPanelController(this);
	this.m_year = this.m_mini.m_options.year;//new Date().getFullYear();
	this.m_month = this.m_mini.m_options.month;//new Date().getMonth() + 1;
	this.m_today = this.m_mini.m_options.day;//new Date().getDate();
	
	/**
	 * control panel(header)에 onClick 이벤트 핸들러 적용
	 * todayButton (이번 달)
	 * prevButton (이전 달)
	 * nextButtin (다음 달)
	 */
	$('#today_button').click(function(){
		$this.viewToday();
	});
	$('#prev_button').click(function(){
		$this.viewPrevMonth();
	});
	$('#next_button').click(function(){
		$this.viewNextMonth();
	});
	
	this.createYearImage(this.m_year);
	this.changeMonthImage(this.m_month);
};

/******************************************************************************************************/
enview.event.view.ControlPanel.prototype = {
	m_mini:		null,
	m_year:		null,
	m_month:	null,
	m_today:	null,
	
	monthPanel:	null,
	controlPanelController: null,
	
	/**
	 * setter function - for broadcasting to monthPanel
	 */
	setMonthPanel:	function(monthPanel){
		this.monthPanel = monthPanel;
	},
	
	init:	function(){
		this.controlPanelController.init();
		this.initSize();
		
		$('td.week').css('background-color', this.m_mini.m_options.weekBgColor);
	},
	/**
	 * initializing for ControlPanel Size & Images
	 */
	initSize:	function(){
		var options = this.m_mini.m_options;
		
		/* width */
		var width = options.tdWidth * 7 + 8;
		$('.me').css('width', width);
		$('.me-header').css('width', width);
		$('.me-header-left').css('width', options.tdWidth * 2);
		$('.me-header-center').css('width', width - options.tdWidth * 4);
		$('.me-header-right').css('width', options.tdWidth * 2);
		
		/* height */
		$('.me-header').css('height', width * 0.18);
		
		$('.me-header-left').css('height', width * 0.18);
		$('.me-header-left img.today').css('top', (width * 0.18 * 0.5) - ($('.me-header-left img.today').css('height').replace('px','')/2));
		
		$('.me-header-center').css('height', width * 0.18);
		
		var deltaHeight = $('.me-header-center img.month').css('height').replace('px','') - $('.me-header-center img.prev-button').css('height').replace('px','');
		
		$('.me-header-center img.prev-button').css('top', (width * 0.18 * 0.5) - ($('.me-header-center img.prev-button').css('height').replace('px','')/2) - deltaHeight);
		$('.me-header-center img.month').css('top', (width * 0.18 * 0.5) - ($('.me-header-center img.month').css('height').replace('px','')/2));
		$('.me-header-center img.next-button').css('top', (width * 0.18 * 0.5) - ($('.me-header-center img.next-button').css('height').replace('px','')/2) - deltaHeight);
		
		$('.me-header-center .blank').css('width', Math.floor(width * 0.05));
		
		$('.me-header-right').css('height', width * 0.18);
		$('.me-header-right img.year').css('top', (width * 0.18 * 0.5) - ($('.me-header-right img.year').css('height').replace('px','')/2));
	},
	createYearImage:	function(year){
		for(var i = 0 ; i < year.toString().length ; i++){
			var $img = $('<img class="year year_' + i + '" src="' + contextPath + '/images/eventCommon/mng/calendar/year/year'+ year.toString().charAt(i) + '.png"/>');
			$img.appendTo($('.me-header-right'));
		}
	},
	changeYearImage:	function(year){
		for(var i = 0 ; i < year.toString().length ; i++){
			var $img = $('img.year_' + i);
			$img.attr('src', contextPath + '/images/eventCommon/mng/calendar/year/year'+ year.toString().charAt(i) + '.png');
		}
	},
	changeMonthImage:	function(month){
		var $img = $('img#month');
		$img.attr('src', contextPath + '/images/eventCommon/mng/calendar/month/month' + month + '.png');
	},
	/**
	 * Event Handlers (default event: onClick)
	 */
	viewToday:	function(){
		this.monthPanel.today();
		this.changeMonthImage(this.monthPanel.getCurrentMonth());
		this.changeYearImage(this.monthPanel.getCurrentYear());
	},
	viewPrevMonth:	function(){
		this.monthPanel.prevMonth();
		this.changeMonthImage(this.monthPanel.getCurrentMonth());
		this.changeYearImage(this.monthPanel.getCurrentYear());
	},
	viewNextMonth:	function(){
		this.monthPanel.nextMonth();
		this.changeMonthImage(this.monthPanel.getCurrentMonth());
		this.changeYearImage(this.monthPanel.getCurrentYear());
	}
}
/******************************************************************************************************/
enview.event.control.ControlPanelController = function(parent){
	this.m_parent = parent;
}
/******************************************************************************************************/
enview.event.control.ControlPanelController.prototype = {
	m_parent:	null,
	
	init:	function(){
		
	}
}

/******************************************************************************************************/
enview.event.view.MonthPanel = function(parent){
	this.m_mini = parent; 
	this.monthController = new enview.event.control.MonthPanelController(this);
	/**
	 * 일 ~ 토 까지 생성
	 */
	for(var col = 0 ; col < 7; col++){
		var extraClass = '';
		if(this.m_mini.m_options.isWeekColor){
			if(col == 0){
				extraClass += ' sun';
			}
			else if(col == 6){
				extraClass += ' sat';
			}
		}
		var $td = $('<td class="week col_' + col + extraClass + '">' + this.m_mini.m_options.weeks[col] + '</td>');
		$td.appendTo($('.me-calendar-weeks'));
	}
};

enview.event.view.MonthPanel.prototype = {
	m_mini:				null,
	monthController:	null,
	
	init:	function(){
		this.monthController.init();
		this.popEvents();
		this.initDateRows();
		this.initSize();
		this.initFont();
		
	},
	today:		function(){
		this.monthController.today();
		this.popEvents();
		this.initDateRows();
		this.initSize();
		this.initFont();
	},
	prevMonth:	function(){
		this.monthController.prevMonth();
		this.popEvents();
		this.initDateRows();
		this.initSize();
		this.initFont();
	},
	nextMonth:	function(){
		this.monthController.nextMonth();
		this.popEvents();
		this.initDateRows();
		this.initSize();
		this.initFont();
	},
	getCurrentYear:		function(){
		return this.monthController.getMonthVo().getYear();
	},
	getCurrentMonth:	function(){
		return this.monthController.getMonthVo().getMonth();
	},
	
	initSize:	function(){
		var options = this.m_mini.m_options;
		/* width */
		var width = options.tdWidth * 7 + 8;
		$('.me-calendar').css('width', width);
		$('.me-calendar-table').css('width', width);
		$('.me-calendar-table td').css('width', options.tdWidth);
		
		/* height */
		$('.me-calendar-table td').css('height', options.tdHeight);
	},
	initFont:	function(){
		var options = this.m_mini.m_options;
		$('td.week').each(function(){
			$(this).css(options.weekFont);
		});
		$('td.date').each(function(){
			$(this).css(options.dateFont);
		});
	},
	
	/**
	 * 달력의 날짜를 초기화 해주는 함수
	 */
	initDateRows:	function(){
		var $table = $('#date_table');
		if($table.children().length > 0){
			$('tr.week').remove();
		}
		var $tri = $('.triangle');
		if($tri.length > 0){
			$tri.remove();
		}
		
		/**
		 * 아래 로직을 이용하여 각 날짜에 필요한 클래스들을 삽입할 수 있다.
		 * extraClass 변수에 += 연산을 이용하여 ' className' 텍스트를 이어 붙인다.
		 */
		var options	=	this.m_mini.m_options;
		var monthVo	=	this.monthController.getMonthVo();
		var today	=	new Date();
		var startWeek	=	monthVo.getStartWeek();
		var maxDate		=	monthVo.getMaxDate();
		var prevMaxDate	=	monthVo.getPrevMaxDate();
		
		for(var row = 0 ; row < 6; row++){
			var $tr = $('<tr id="row_' + row + '" class="week row_' + row + '">');
			for(var col = 0; col < 7; col++){
				var year = monthVo.getYear();
				var month =	monthVo.getMonth();
				var date = row * 7 - startWeek + col + 1;
				var extraClass = '';
				if(date <= 0){
					month = month - 1;
					date = prevMaxDate + date;
					
					if(month < 1){
						year = year - 1;
						month = 12;
						extraClass += ' other_year';
					}
					extraClass += ' other_month';
				}
				else if(date > maxDate){
					month = month + 1;
					date = date - maxDate;
					
					if(month > 12){
						year = year + 1;
						month = 1;
						extraClass += ' other_year';
					}
					extraClass += ' other_month';
				}
				if(options.isWeekColor){
					if(col == 0){
						extraClass += ' sun';
					}
					else if(col == 6){
						extraClass += ' sat';
					}
				}
				//오늘보기 클릭시 오늘날짜에 color:green , underline
				if(year == today.getFullYear() && month == (today.getMonth()+1) && date == today.getDate()){
					extraClass += ' today';
				}
				//조회한 날짜에 color:green , underline
				if(year == options.year && month == options.month && date == options.day){
					extraClass += ' today';
				}
				var $td = $('<td id="' + year + '-' + (month < 10 ? '0' + month : month) + '-' + (date < 10 ? '0' + date : date) + '" class="date col_' + col + extraClass + '"' + 'onclick="parent.retriveEvent(2,'+year+(month < 10 ? '0' + month : month)+(date < 10 ? '0' + date : date)+')"'+'>' + date + '</td>');
				$td.appendTo($tr);
			}
			$tr.appendTo($table);
		}
	},
	
	popEvents:	function(){
		this.monthController.popEvents();
	},
	/**
	 * 이벤트 리스트를 가져와서 각 이벤트의 날짜에 이벤트 핸들러를 등록하는 함수
	 */
	pushEvents:	function(events){
		var monthVo = this.monthController.getMonthVo();
		
		var startWeek = monthVo.getStartWeek();
		var maxDate = monthVo.getMaxDate();
		var prevMaxDate = monthVo.getPrevMaxDate();
		
		var options = this.m_mini.m_options;
		for(var i = 0 ; i < events.length ; i++){
			var event = events[i];
			var e = new enview.event.model.vo.EventVo(event);
			var id = e.getId();
			var type = e.getType();
			
			var start = e.getStart().substring(0,10);
			var sDates = start.split("-");
			var sYear = sDates[0];
			var sMonth = sDates[1];
			var sDate = sDates[2];
			
			var end = e.getEnd().substring(0,10);
			var eDates = end.split("-");
			var eYear = eDates[0];
			var eMonth = eDates[1];
			var eDate = eDates[2];
			
			var typeClass = options.typeClass[type];
			var $td = $('#' + start);
			$td.attr('eventId', id);
			
			if(options.isDateColor){
				if(typeClass == options.typeClass[9] && $td.hasClass(options.typeClass[0])){
				}
				else if(typeClass == options.typeClass[0] && $td.hasClass(options.typeClass[9])){
					$td.removeClass(options.typeClass[9]);
					$td.addClass(typeClass);
				}
				else{
					$td.addClass(typeClass);
				}
			}else {
				/**
				 * triangle div가 있는지 확인.
				 * 있으면: 색깔 확인.
				 * 	public이면 pass.
				 * 	private이고, type이 9이면 통과.
				 * 	private이고, type이 0이면 색깔 변경
				 * 없으면: 생성.
				 * 	생성 후, type에 맞는 색 지정
				 */
				for(var j = sDate ; j <= (eDate < sDate ? maxDate : eDate) ; j++){
					var $triangle = $('div#tri' + sYear + '-' + sMonth + '-' + j);
					if($triangle.attr('id') != undefined){
						var color = $triangle.css('border-left-color');
						if(color == options.typeColor[9]){
							if(type == 0){
								$triangle.css('border-left-color', options.typeColor[type]);
							}
						}
					}
					else{
						var tri = $('<div id=\'tri' + sYear + '-' + sMonth + '-' + j + '\' class=\'triangle\'>');
						tri.appendTo($('body'));
						tri.css('border-top-width', 0);
						tri.css('border-right-width', this.m_mini.m_options.tdWidth * 0.2);
						tri.css('border-bottom-width', this.m_mini.m_options.tdWidth * 0.2);
						tri.css('border-left-width', this.m_mini.m_options.tdWidth * 0.2);
						tri.css('top', getAbsTop(sYear + '-' + sMonth + '-' + j));
						tri.css('left',getAbsLeft(sYear + '-' + sMonth + '-' + j));
						tri.css('border-left-color', options.typeColor[type]);
						var $td = $('#' + sYear + '-' + sMonth + '-' + j);
						$td.addClass('hasEvents');
					}
				}
			}
		}
		/**
		 * 오늘 날짜에 이벤트 핸들러 등록
		 */
		if(!options.isCalMode){
			var $todayTd = $('td.today');
			var today = new Date();
	
			if(options.todayOrder){
				$todayTd.css('background-color', options.todayBgColor);
				$todayTd.css('color', options.todayColor);
			}
			$todayTd.click(function(){
				var year = today.getFullYear();
				var month = today.getMonth();
				
				var link_href = options.href + '?year=' + year + '&month=' + month;
				var link_target = options.target; 
				
				/*
				if(more_src_target == '_self'){
					location.href = link_href;
				}
				else {
					window.open(link_href, 'popup', 'menubar=no, toolbar=no, location=no, status=no, scrollbars=no, width=800, height=650');
				}
				*/
			});
		}
		if(options.isDayOver){
			var $td = $('td.hasEvents');
			$td.mouseover(function(){
				var $this = $(this);
				$this.css('background-color', '#ccf');
			});
			
			$td.mouseout(function(){
				var $this = $(this);
				if($this.hasClass('today')){
					$this.css('background-color', options.todayBgColor);
				}else{
					$this.css('background-color', options.bgColor);
				}
			});
		}
	}
};

/******************************************************************************************************/
enview.event.control.MonthPanelController = function(parent){
	this.m_parent = parent;
	this.m_eventManager = new enview.event.model.EventManager(this);
}

/******************************************************************************************************/
enview.event.control.MonthPanelController.prototype = {
	m_parent:	null,
	m_eventManager:	null,
	m_monthVo:	null,
	m_events:	[],
	
	init:	function(){
		this.m_eventManager.init();
		
	},
	
	popEvents:	function(){
		this.m_eventManager.popAllEvents();
	},
	pushEvents:	function(events){
		this.m_events = events;
		this.m_parent.pushEvents(this.m_events);
	},
	getMonthVo:	function(){
		this.m_monthVo = this.m_eventManager.getMonthVo();
		return this.m_monthVo;
	},
	today:		function(){
		var monthVo = this.getMonthVo();
		var today = new Date();
		monthVo.setYear(today.getFullYear());
		monthVo.setMonth(today.getMonth()+1);
	},
	prevMonth:	function(){
		var monthVo = this.getMonthVo();
		if(monthVo.getMonth() == 1){
			monthVo.setMonth(12);
			monthVo.setYear(monthVo.getYear()-1);
		}
		else{
			monthVo.setMonth(monthVo.getMonth()-1);
		}
	},
	nextMonth:	function(){
		var monthVo = this.getMonthVo();
		if(monthVo.getMonth() == 12){
			monthVo.setMonth(1);
			monthVo.setYear(monthVo.getYear()+1);
		}
		else{
			monthVo.setMonth(monthVo.getMonth()+1);
		}
	}
}


/******************************************************************************************************/
enview.event.view.TodayPanel = function(parent) { 
	this.m_mini = parent; 
	this.m_events = new Array();
	
	var content = $('<div id=\'todayEvents\' class=\'me-content\'>');
	var title = $('<div class=\'me-content-title\'>');
	var img = $('<img src=\'' + contextPath + '/face/images/event/today/title_today.gif\' alt=\'오늘의 일정\' >');
	
	img.appendTo(title);
	title.appendTo(content);
	content.appendTo($('#mini_calendar'));
	
	this.todayController = new enview.event.control.TodayPanelController(this);
};

/******************************************************************************************************/
enview.event.view.TodayPanel.prototype = {
	m_mini:	null,
	todayController: null,
	
	initSize:	function(){
		var options = this.m_mini.m_options;
		/* width */
		var width = options.tdWidth * 7 + 8;
		$('.me-content').css('width', width);
		$('.me-content-event').css('width', width-15);
		$('.me-content-noevents').css('width', width-15);
		
		/* height */
		$('.me-content-event').css('height', Math.ceil(options.tdHeight*0.81));
		$('.me-content-event').css('line-height', Math.ceil(options.tdHeight*0.81)+'px');
		$('.me-content-noevents').css('height', Math.ceil(options.tdHeight*0.81));
		$('.me-content-noevents').css('line-height', Math.ceil(options.tdHeight*0.81)+'px');
	},
	init:	function(){
		this.todayController.init();
		this.popEvents();
	},
	popEvents:	function(){
		this.todayController.popEvents();
	},
	pushEvents:	function(events){
		var options = this.m_mini.m_options;
		var div = $('#todayEvents');
		if(events.length <= 0){
			var todayDiv = $('<div class=\'me-content-noevents\'>');
			var noeventsDiv = $('<label class=\'noevents\' name=\'noevents\'/>');
			var noeventText = "일정이 없습니다.";
			noeventsDiv.text(noeventText);
			noeventsDiv.appendTo(todayDiv);
			todayDiv.appendTo(div);
		}
		else if(events.length > 0) {
			var count = 0;
			for(var i = 0 ; i < (options.todayCount <= 0 ? (events.length > 5 ? 5 : events.length) : (options.todayCount > events.length ? events.length : options.todayCount)) ; i++){
				var e = events[i];
				var id = e.id;
				var ttl = e.title;
				var cntt = e.content;
				var allDay = e.allDay;
				var type = e.type;
				
				if(options.publicOnly){
					if(type != 0){
						continue;
					}
				}
				if(options.allDayOnly){
					if(!allDay){
						continue;
					}
				}
				count++;
				var startTime = e.startTime;
				var typeNm = options.typeText[e.type];
				
				var todayDiv = $('<div id=\'' + id + '\' class=\'me-content-event ' + options.typeClass[e.type] +  '\'>');
				
				if(allDay == true){
					startTime = '하루종일';
				}
				if(type == 0){
					startTime = options.typeText[type];
				}
				var todayText = '[' + startTime + '] ' + ttl;
				todayDiv.text(todayText);
				
				var todayTypeNm = $('<input name=\'typeNm\' type=\'hidden\' value=\'' + typeNm + '\'/>');
				var todayTtl = $('<input name=\'ttl\' type=\'hidden\' value=\'' + ttl + '\'/>');
				var todayAD = $('<input name=\'allDay\' type=\'hidden\' value=\'' + allDay + '\'/>');
				var todayST = $('<input name=\'startTime\' type=\'hidden\' value=\'' + startTime + '\'/>');
				var todayCntt = $('<input name=\'cntt\' type=\'hidden\' value=\'' + cntt + '\'/>');
				
				todayTypeNm.appendTo(todayDiv);
				todayTtl.appendTo(todayDiv);
				todayAD.appendTo(todayDiv);
				todayST.appendTo(todayDiv);
				todayCntt.appendTo(todayDiv);
				todayDiv.appendTo(div);
			}
			if(count == 0 ){
				var todayDiv = $('<div class=\'me-content-noevents\'>');
				var noeventsDiv = $('<label class=\'noevents\' name=\'noevents\'/>');
				var noeventText = "공개 일정이 없습니다.";
				noeventsDiv.text(noeventText);
				noeventsDiv.appendTo(todayDiv);
				todayDiv.appendTo(div);
			}
		}
		else if(events == undefined || events == null || events == 'null'){
			var todayDiv = $('<div class=\'me-content-error\'>');
			var noeventsDiv = $('<label class=\'error\' name=\'error\'/>');
			var noeventText = "오늘의 일정을 불러오는데 실패하였습니다.";
			noeventsDiv.text(noeventText);
			noeventsDiv.appendTo(todayDiv);
			todayDiv.appendTo(div);
		}
		this.initSize();
	}
}

enview.event.control.TodayPanelController = function(parent){
	this.m_parent = parent;
	this.m_eventManager = new enview.event.model.EventManager(this);
}

/******************************************************************************************************/
enview.event.control.TodayPanelController.prototype = {
	m_parent:	null,
	m_eventManager:	null,
	m_monthVo:	null,
	m_events:	[],
	
	init:	function(){
		this.m_eventManager.init();
		
	},
	popEvents:	function(){
		this.m_eventManager.popTodayEvents();
	},
	pushEvents:	function(events){
		this.m_events = events;
		this.m_parent.pushEvents(this.m_events);
	}
	
};


/****************************************************************************************************
 * 이벤트가 있는 날짜를 싱글 클릭 하면 TodayPanel을 덮는 EventListPanel이 보이도록 한다.
 * 클릭 한 후, 해당 날짜가 아닌 날짜를 클릭 할 경우 사라지게 된다.
 * 만약 이벤트가 있는 다른 날짜를 클릭하면, 기존 정보를 해당 날짜의 EventList 정보로 바꾸어 보여준다.
 * 이 EventListPanel은 해당 날짜의 모든 이벤트(일정) 목록을 보여준다.
 * 그 정보는 타입, 제목, 하루종일여부, 시작일, 종료일, 태그, 내용 모두이다.
 * 2011-11-01 개발 시작 예정
 ****************************************************************************************************/
enview.event.view.EventListPanel = function(parent) { 
	
};

enview.event.view.EventListPanel.prototype = {
		
}

/******************************************************************************************************/
/**
 * 데이터를 주고 받는 Event Manager 객체
 */
enview.event.model.EventManager = function(parent) {
	this.m_parent = parent;
	this.m_monthVo = new enview.event.model.vo.MonthVo();
	this.m_allEvents = new Array();
	this.m_todayEvents = new Array();
};

/******************************************************************************************************/
enview.event.model.EventManager.prototype = {
	m_parent:	null,
	m_monthVo:	null,
	m_allEvents:	[],
	m_todayEvents:	[],
	
	init:	function(){
	},
	popAllEvents:	function(){
		if(!this.m_parent.m_parent.m_mini.m_options.isCalMode){
			var parent = this.m_parent;
			var allEvents = [];
			$.ajax({
				type: 'POST',
				url: contextPath + '/event/miniEvent.face', 
				data:
				{
					'a':		'allEventList', 
					'year':		this.m_monthVo.getYear(), 
					'month':	this.m_monthVo.getMonth(),
					'dummy':	Math.random()*1000
				},
				dataType: 'json',
				success: function(data, textStatus){
					this.m_allEvents = data.events;
					parent.pushEvents(this.m_allEvents);
				},
				error: function(x, e){
					
				}
			});
		}
	},
	popTodayEvents:	function(){
		var parent = this.m_parent;
		$.ajax({
			type: 'POST',
			url: contextPath + '/event/miniEvent.face', 
			data:
			{
				'a':		'allTodayEventList', 
				'dummy':	Math.random()*1000
			},
			dataType: 'json',
			success: function(data, textStatus){
				this.m_todayEvents = data.events;
				parent.pushEvents(this.m_todayEvents);
			},
			error: function(x, e){
				
			}
		});
	},
	getMonthVo:	function(){
		return this.m_monthVo;
	}
};


/******************************************************************************************************/
/**
 * MonthPanel의 데이터를 캡슐화하는 MonthVo 객체
 */
enview.event.model.vo.MonthVo = function(){
	//alert(enview.event.view.MainPanel.prototype.m_options.year+" : "+enview.event.view.MainPanel.prototype.m_options.month+" : "+enview.event.view.MainPanel.prototype.m_options.day);
	var date = new Date(enview.event.view.MainPanel.prototype.m_options.year , enview.event.view.MainPanel.prototype.m_options.month-1 , enview.event.view.MainPanel.prototype.m_options.day);
	this.m_year = date.getFullYear();
	this.m_month = date.getMonth()+1;
	this.m_today = date.getDate();
	
	this.m_startWeek = this.calcStartWeek();
	this.m_maxDate = this.calcMaxDate();
	this.m_prevMaxDate = this.calcPrevMaxDate();
}

/******************************************************************************************************/
enview.event.model.vo.MonthVo.prototype = {
	m_year:			null,
	m_month:		null,
	m_today:		null,
	
	m_startWeek:	null,
	m_maxDate:		null,
	m_prevMaxDate:	null,
	
	getYear:	function(){
		return this.m_year;
	},
	getMonth:	function(){
		return this.m_month;
	},
	getToday:	function(){
		return this.m_today;
	},
	getEvents:	function(){
		return this.m_events;
	},
	getJSON:	function(){
		return this.m_json;
	},
	getStartWeek:	function(){
		return this.m_startWeek;
	},
	getMaxDate:		function(){
		return this.m_maxDate;
	},
	getPrevMaxDate:	function(){
		return this.m_prevMaxDate;
	},
	
	setYear:	function(year){
		this.m_year = year;
		this.m_startWeek = this.calcStartWeek();
		this.m_maxDate = this.calcMaxDate();
		this.m_prevMaxDate = this.calcPrevMaxDate();
	},
	setMonth:	function(month){
		this.m_month = month;
		this.m_startWeek = this.calcStartWeek();
		this.m_maxDate = this.calcMaxDate();
		this.m_prevMaxDate = this.calcPrevMaxDate();
	},
	isLeafYear:		function(){ //윤년 판별 함수
		if((this.m_year%4==0) && (this.m_year%100!=0)) return true;
		if(this.m_year%400==0)return true;
		return false;
	},

	calcMaxDate:		function(){ //마지막날짜 판별 함수
		if((this.m_month==1)||(this.m_month==3)||(this.m_month==5)||(this.m_month==7)||(this.m_month==8)||(this.m_month==10)||(this.m_month==12)) return 31;
		else if((this.m_month==4)||(this.m_month==6)||(this.m_month==9)||(this.m_month==11)) return 30;
		else if(this.m_month==2){
			if(this.isLeafYear(this.m_year)) return 29;
			else return 28;
		}
		return -1;
	},
	
	calcPrevMaxDate:		function(){ //마지막날짜 판별 함수
		var month = this.m_month - 1 == 0 ? 12 : this.m_month - 1;
		if((month==1)||(month==3)||(month==5)||(month==7)||(month==8)||(month==10)||(month==12)) return 31;
		else if((month==4)||(month==6)||(month==9)||(month==11)) return 30;
		else if(month==2){
			if(this.isLeafYear()) return 29;
			else return 28;
		}
		return -1;
	},

	calcStartWeek:	function(){ //1일의 요일 판별 함수
		var sum1=0;
		var sum2=0;
		var sum3=0;
		var allsum=0;
		for(var i=1; i<this.m_month;i++){
			if((i==1)||(i==3)||(i==5)||(i==7)||(i==8)||(i==10)||(i==12)) sum1 += 31;
			else if((i==4)||(i==6)||(i==9)||(i==11)) sum2 += 30;
			else if(i==2){
				if(this.isLeafYear(this.m_year)==0) sum3 = 28;
				else if(this.isLeafYear(this.m_year)==1) sum3 = 29;
			}
			allsum = sum1 + sum2 + sum3;
		}
		/**
		* 날짜 계산 오류로 인해 수정 2013. 05. 10 - Saltware
		*/
		var total = ((this.m_year-1)*365) + Math.floor((this.m_year-1)/4) + Math.floor((this.m_year-1)/400) - Math.floor((this.m_year-1)/100) + allsum + 1;
		return total%7;
	}
}

/******************************************************************************************************/
/**
 * Event model에서 받아온 데이터를 캡슐화하는 EventVo 객체
 */
enview.event.model.vo.EventVo = function(event){
	this.m_id = event.id;
	this.m_title = event.title;
	this.m_start = event.start;
	this.m_end = event.end;
	this.m_allDay = event.allDay;
	this.m_tags = event.tags;
	this.m_content = event.content;
	this.m_type = event.type;
	this.m_editable = event.editable;
}
/******************************************************************************************************/
enview.event.model.vo.EventVo.prototype = {
	m_userId:	null,
	m_editable:	false,
	m_langKnd : "ko",
	
	/**
	 * In DB Data
	 */
	m_id:		null,
	m_title:	null,
	m_start:	null,
	m_end:		null,
	m_allDay:	false,
	m_tags:		null,
	m_content:	null,
	m_type:		0,

	getParent:	function(){
		return  this.m_parent;
	},
	getUserId:	function(){
		return	this.m_userId;
	},
	isEditable:	function(){
		return	this.editable;
	},
	getLangKnd:	function(){
		return	this.m_langKnd;
	},
	getId:		function(){
		return	this.m_id;
	},
	getUserId:	function(){
		return	this.m_userId;
	},
	getTitle:	function(){
		return	this.m_title;
	},
	getStart:	function(){
		return	this.m_start;
	},
	getEnd:		function(){
		return	this.m_end;
	},
	isAllDay:	function(){
		return	this.m_allDay;
	},
	getTags:	function(){
		return	this.m_tags;
	},
	getContent:	function(){
		return	this.m_content;
	},
	getType:	function(){
		return	this.m_type;
	},
	getTypeClass:	function(){
		return	this.m_parent.getTypeClass(this.m_type);
	},
	getTypeText:	function(){
		return	this.m_parent.getTypeText(this.m_type);
	},
	
	setUserId:	function(userId){
		this.m_userId = userId;
	},
	setEditable:	function(editable){
		this.m_editable = editable;
	},
	setId:	function(id){
		this.m_id = id;
	},
	setTitle:	function(title){
		this.m_title = title;
	},
	setStart:	function(start){
		this.m_start = start;
	},
	setEnd:		function(end){
		this.m_end = end;
	},
	setAllDay:	function(allDay){
		this.m_allDay = allDay;
	},
	setTags:	function(tags){
		this.m_tags = tags;
	},
	setContent:	function(content){
		this.m_content = content;
	},
	setType:	function(type){
		this.m_type = type;
	},
	
	toJSON:		function(){
		return '{' + 
					'\'id\':\'' + this.m_id + '\', \'title\'=\'' + this.m_title + 
				    '\', \'start\'=\'' + this.m_start + '\', \'end\'=\'' + this.m_end + 
				    '\', \'allDay\'=\'' + this.m_allDay +'\', \'tag\'=\'' + this.m_tags + 
				    '\', \'content\'=\'' + this.m_content + '\'type\'=\'' + this.m_type + 
				    '\', \'editable\'=\'' + this.m_editable + '\'' +
			    '}';
	}
}

function getAbsLeft(element){ 
	if(typeof element!='object') element=document.getElementById(element); 
	var LEFT=0; 
	while(element){ 
		LEFT+=element.offsetLeft; 
		element=element.offsetParent; 
	} 

	return LEFT; 
} 


function getAbsTop(element){ 
	if(typeof element!='object') element=document.getElementById(element); 
	var TOP=0; 
	while(element){ 
		TOP+=element.offsetTop; 
		element=element.offsetParent; 
	} 

	return TOP; 
}