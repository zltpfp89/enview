if( ! window.hancer )
    window.hancer = new Object();

if( ! window.hancer.cal )
    window.hancer.cal = new Object();

if( ! window.hancer.cal.calendarUser )
	window.hancer.cal.calendarUser = new Object();

if( ! window.hancer.cal.scheduleUser )
	window.hancer.cal.scheduleUser = new Object();

hancer.cal = function() {
	this.m_ajax = new enview.util.Ajax();
	this.m_contextPath = '';
	this.m_encodeing = encodeURIComponent;
}

hancer.cal.prototype = {
	m_contextPath : null,
	m_ajax : null,
	m_calendars : [],
	m_calendarIds : [],
	m_calendar : null,
	
//	m_schedules : [],
	m_start: null,
	m_end: null,
	
	m_selectedEvent : null,
	
//	m_scheduleUsers : [],
	m_calendarUsers : [],
	
	m_encodeing : null,
	
	m_validateParams : ['name', 'nameList'],
	
	m_isJointModified : null,
	
	m_skin : 'default',
	
	m_dateFormat: 'yyyy.MM.dd',
	m_dateTimeFormat: 'HH:mm:ss',
	m_dateDelemeter : '.',
	
	m_CalendarOption : {

		// display
		defaultView: 'month',
		aspectRatio: 1.35,
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month,agendaWeek,agendaDay'
		},
		
		mobileHeader : {
			left: 'title',
			center: '',
			right: 'today prev,next'
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
			month: 'MMMM yyyy',
			week: "MMM d[ yyyy]{ '&#8212;'[ MMM] d yyyy}",
			day: 'dddd, MMM d, yyyy'
		},
		columnFormat: {
			month: 'ddd',
			week: 'ddd M/d',
			day: 'dddd M/d'
		},
		timeFormat: { // for event elements
			'': 'h(:mm)t' // default
		},
		mobileTimeFormat : {
			'': 'hh:mmt' 
		},
		
		// locale
		isRTL: false,
		firstDay: 0,
		monthNames: ['January','February','March','April','May','June','July','August','September','October','November','December'],
		monthNamesShort: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
		dayNames: ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'],
		dayNamesShort: ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'],
		buttonText: {
			prev: "<span class='fc-text-arrow'>&lsaquo;</span>",
			next: "<span class='fc-text-arrow'>&rsaquo;</span>",
			prevYear: "<span class='fc-text-arrow'>&laquo;</span>",
			nextYear: "<span class='fc-text-arrow'>&raquo;</span>",
			today: 'today',
			month: 'month',
			week: 'week',
			day: 'day'
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
		
		allDayText: 'all-day',
		axisFormat: 'h(:mm)tt'
		
	},
	
	m_viewName : null,
	
	m_isCalListOpen : false,
	m_calSliderFixed : false,
	
	m_isPrintLog : true,
	log : function(logText, level){
		try {
			if(enCal.m_isPrintLog){
				if(level){
					eval("console." + level + "('" + logText + "')");
				}
				else console.log(logText);
			}			
		} catch (e) {
			
		}
	},
	
	getOption : function(option){
		var optionText = 'enCalSkin.' + option;
		if(enCal.m_viewName == 'mobile'){
			optionText = 'enCalSkin.mobile' + option.substring(0, 1).toUpperCase() + option.substring(1);
			if(!eval(optionText)) {
				optionText = 'enCal.m_CalendarOption.mobile' + option.substring(0, 1).toUpperCase() + option.substring(1);
			}
		}
		if(!eval(optionText)) {
			optionText = 'enCalSkin.' + option;
		}
		if(!eval(optionText)) {
			optionText = 'enCal.m_CalendarOption.' + option;
		}
		enCal.log('Calendar Option loaded \'' + optionText + ': ' + eval(optionText) + '\'.');
		return eval(optionText);
	},
	
	init : function () {
		if(!document.getElementById('calendar')) return;
		
		enCal.log('calendar.init start');
		
		var viewName = $('#viewName');
		if(viewName) this.m_viewName = viewName.val();
		
		this.m_calendarIds = [];
		this.m_calendars = [];
		this.m_schedules = [];
		if(enCal.m_viewName == 'mobile') {
			enCal.initMobileEventHandlers();
		}
		else enCal.initEventHandlers();
		enCal.initCalendar();
		
		enCal.log('calendar.init complete');
		
		enCal.log('calendar view mode is \''+viewName.val()+'\'');
	},
	
	initEventHandlers : function (){
		if(!document.getElementById('calendar')) return;
		
		enCal.log('calendar.initEventhandlers start');
		
		$('#myCalendar').click(function(){
			enCal.showOrHideCalendarList('myCalendar');
		});
		
		$('#myCalendarLabel').click(function(){
			enCal.showOrHideCalendarList('myCalendar');
		});
		
		$('#publicCalendar').click(function(){
			enCal.showOrHideCalendarList('publicCalendar')
		});
		
		$('#publicCalendarLabel').click(function(){
			enCal.showOrHideCalendarList('publicCalendar');
		});
		
		$('.calendarInfo').click(function(){
			enCal.removePopups();
			var $this = $(this);
			var calendarId = $this.attr('id').split("_")[0];
			var selected = $('input[name=' + calendarId + '_selected]').val();
			var orgBgColor = $('#' + calendarId + '_bgColor').val();
			var bgColor = $('#' + calendarId + '_calendarBgColor').css('background-color');
			
			if(selected == 0) {
				$('#' + calendarId + '_calendarBgColor').css('border-color', orgBgColor);
				$('#' + calendarId + '_calendarBgColor').css('background-color', orgBgColor);
				$('input[name=' + calendarId + '_selected]').val(1);
				$('#calendar').fullCalendar( 'refetchEvents' );
			} else {
				$('#' + calendarId + '_calendarBgColor').css('border-color', 'gray');
				$('#' + calendarId + '_calendarBgColor').css('background-color', 'rgba(0, 0, 0, 0)');
				enCal.removeEvents(calendarId);
			}
		});
		
		$('.calendarInfo').hover(
			function(){
				var $this = $(this);
				var calendarId = $this.attr('id').split("_")[0];
				var orgBgColor = $('#' + calendarId + '_bgColor').val();
				var bgColor = $('#' + calendarId + '_calendarBgColor').css('background-color');
				
				$('#' + calendarId + '_calendarBgColor').css('border-color', orgBgColor);
				$('#' + calendarId + '_calendarBgColor').css('background-color', orgBgColor);
				$this.find('.triangleButton').css('display', 'block');
			},
			function(){
				var $this = $(this);
				var calendarId = $this.attr('id').split("_")[0];
				var selected = $('input[name=' + calendarId + '_selected]').val();
				var orgBgColor = $('#' + calendarId + '_bgColor').val();
				var bgColor = $('#' + calendarId + '_calendarBgColor').css('background-color');
				
				if(selected == 0){
					$('#' + calendarId + '_calendarBgColor').css('border-color', 'gray');
					$('#' + calendarId + '_calendarBgColor').css('background-color', 'rgba(0, 0, 0, 0)');
				}
				$this.find('.triangleButton').css('display', 'none');
			}
		);
		
		$('#myCalPop').click(function(event){
			event.stopPropagation();
			enCal.removePopups();
			var $this = $(this);
			var param = 'cmd=my';
			if(enCal.m_viewName != null ) param += '&viewName='+ enCal.m_viewName;
			enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/popupMenu.hanc", param, false, {
				success: function(data){
					$('#calendarPopup').remove();
					$(data).appendTo($(document.body));
					$('#calendarPopup').offset( { top: $this.offset().top + 15, left: $this.offset().left } );
					enCal.initPopupEventHandlers();
					
					$('#calendarPopup').hover(
						function(){
						}, 
						function(){
							$('#calendarPopup').remove();
						}
					);
				},
				error: function(data, e){
					//alert(data.Reason + '\n잠시 후에 다시 시도 해주십시오.');
				}
			});
		});
		
		
		$('.calendarPopupButton').click(function(event){
			event.stopPropagation();
			enCal.removePopups();
			var $this = $(this);
			var calendarId = $this.attr('calendarId');
			var param = 'calendarId=' + calendarId;
			param += '&isOwner=' + $('#' + calendarId + '_isOwner').val();
			param += '&isDefault=' + $('#' + calendarId + '_isDefault').val();
			param += '&isPublic=' + $('#' + calendarId + '_isPublic').val();
			param += '&isUserPublic=' + $('#' + calendarId + '_isUserPublic').val();
			enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/popupMenu.hanc", param, false, {
				success: function(data){
					$('#calendarPopup').remove();
					$(data).appendTo($(document.body));
					$('#calendarPopup').offset( { top: $this.offset().top + 15, left: $this.offset().left } );
					enCal.initPopupEventHandlers($this.attr('calendarId'));
					
					$('#calendarPopup').hover(
						function(){
						}, 
						function(){
							$('#calendarPopup').remove();
						}
					);
				},
				error: function(data, e){
					//alert(data.Reason + '\n잠시 후에 다시 시도 해주십시오.');
				}
			});
		});
		
		enCal.log('calendar.initEventhandlers complete');
	},
	
	initMobileEventHandlers : function (){
		if(!document.getElementById('calendar')) return;
		
		enCal.log('calendar.initMobileEventHandlers start');
		
		$('.myCalendarList').css('display', 'block');
		$('.publicCalendar').css('display', 'block');
		
		$('.calToggle').click(function(){
			enCal.removePopups();
			var $this = $(this);
			var calendarId = $this.attr('id').split("_")[0];
			var selected = $('input[name=' + calendarId + '_selected]').val();
			var orgBgColor = $('#' + calendarId + '_bgColor').val();
			var bgColor = $('#' + calendarId + '_calendarBgColor').css('background-color');
			
			if(selected == 0) {
				$('#' + calendarId + '_calendarBgColor').css('border-color', orgBgColor);
				$('#' + calendarId + '_calendarBgColor').css('background-color', orgBgColor);
				$('input[name=' + calendarId + '_selected]').val(1);
				$('#calendar').fullCalendar( 'refetchEvents' );
			} else {
				$('#' + calendarId + '_calendarBgColor').css('border-color', 'gray');
				$('#' + calendarId + '_calendarBgColor').css('background-color', 'rgba(0, 0, 0, 0)');
				enCal.removeEvents(calendarId);
			}
		});
		
		$('#calendarListPin').click(function(){
			var $this = $(this);
			if($this.hasClass('ui-icon-pin-w')){
				$this.removeClass('ui-icon-pin-w');
				$this.addClass('ui-icon-pin-s');
				enCal.m_calSliderFixed = true;
			} else if($this.hasClass('ui-icon-pin-s')){
				$this.removeClass('ui-icon-pin-s');
				$this.addClass('ui-icon-pin-w');
				enCal.m_calSliderFixed = false;
			}
		});
		
		enCal.log('calendar.initMobileEventHandlers complete');
	},
	
	initPopupEventHandlers : function (calendarId){
		enCal.log('calendar.initPopupEventHandlers start');
		
		$('#edit').click(calendarId + '_edit', function(event){
			event.stopPropagation();
			
			if(calendarId){
				var frm = $('#' + calendarId + '_modifyForm');
				frm.submit();
			}
			else {
				var frm = document.addForm;
				frm.submit();
			}
		});
		
		$('.color').each(function(){
			var $this = $(this);
			if($this.css('background-color') == $('#' + calendarId + '_calendarBgColor').css('background-color')){
				$this.addClass('ui-icon');
				$this.addClass('ui-icon-check');
			}
		});
		
		$('.color').click(function(){
			var selectedColor = $(this).css('background-color');
			enCal.changeUserCalendarColor(calendarId, selectedColor);
		});
		
		enCal.log('calendar.initPopupEventHandlers complete');
	},
	
	changeUserCalendarColor : function(calendarId, selectedColor){
		var isOwner = $('#' + calendarId + '_isOwner').val();
		var isPublic = $('#' + calendarId + '_isPublic').val();
		var param = 'calendarId=' + calendarId;
		param += '&isOwner=' + isOwner;
		param += '&bgColor=' + selectedColor;
		param += '&isPublic=' + isPublic;
		param += '&isUserPublic=' + $('#' + calendarId + '_isUserPublic').val();
		this.m_ajax.send("POST", enCal.m_contextPath + "/calendar/changeUserBgColor.hanc", param, false, {
			success: function(data){
				var events = $('#calendar').fullCalendar('clientEvents');
				for(var j = 0 ; j < events.length ; j++){
					if(events[j].calendarId != calendarId) continue;
					events[j].borderColor = selectedColor;
					events[j].backgroundColor = selectedColor;
					$('#calendar').fullCalendar('updateEvent', events[j]);
				}
				$('#' + calendarId + '_bgColor').val(selectedColor);
				$('#calendarPopup').remove();
				var selected = $('input[name=' + calendarId + '_selected]').val();
				if(selected == 1) {
					$('#' + calendarId + '_calendarBgColor').css('border-color', selectedColor);
					$('#' + calendarId + '_calendarBgColor').css('background-color', selectedColor);
				}
			},
			error: function(data, e){
				//alert(data.Reason + '\n잠시 후에 다시 시도 해주십시오.');
			}
		});
	},
	
	showOrHideCalendarList: function(objId){
		var $btn = $('#' + objId + 'CaratButton');
		if($btn.hasClass('ui-icon-carat-1-s')){
			$btn.removeClass('ui-icon-carat-1-s');
			$btn.addClass('ui-icon-carat-1-e');
			$('.' + objId +'List').css('display', 'none');
		} else {
			$btn.removeClass('ui-icon-carat-1-e');
			$btn.addClass('ui-icon-carat-1-s');
			$('.' + objId +'List').css('display', 'block');
		}
		enCal.autoResize();
	},
	
	renderEvents : function(calendarId){
		var events = [];
		var isOwner = $('#' + calendarId + '_isOwner').val();
		var isDefault = $('#' + calendarId + '_isDefault').val();
		var isPublic = $('#' + calendarId + '_isPublic').val();
		var param = 'calendarId=' + calendarId;
		param += '&isDefault=' + isDefault;
		param += '&isOwner=' + isOwner;
		param += '&isPublic=' + isPublic;
		param += '&start=' + enCal.m_start;
		param += '&end=' + enCal.m_end;
		param += '&dummy=' + Math.random()*1000;
		param += '&isUserPublic=' + $('#' + calendarId + '_isUserPublic').val();
		this.m_ajax.send("POST", enCal.m_contextPath + "/calendar/scheduleList.hanc", param, false, {
			success: function(data){
				events = data.Data;
			},
			error: function(data, e){
				//alert(data.Reason + '\n잠시 후에 다시 시도 해주십시오.');
			}
		});
		return events;
	},
	
	removeEvents : function(calendarId){
		$('#calendar').fullCalendar( 'removeEvents', function(e){
			return e.calendarId == calendarId;
		});
		$('input[name=' + calendarId + '_selected]').val(0);
		enCal.removePopups();
	},
	
	initMonthSchedulePopupPosition : function(data, target, calEvent, jsEvent, view) {
		$(data).appendTo($(document.body));
		
		var width = $('#contentsArea').width();
		var popWidth = $('#schedulePops').outerWidth();
		var leftWidth = $('#contentsArea').offset().left;

		var top = target.offset().top;
		var left = jsEvent.pageX-leftWidth;

		if(left <= 15 + popWidth/2) left = 12;
		else if(15 + popWidth/2 < left && left < parseInt(width - popWidth/2)) left -= $('#schedulePops').width()/2 + 15;
		else if(parseInt(width - popWidth/2) <= left) left = width - popWidth - 15;
		
		left += leftWidth;
		if(top < 280) {
			top += target.height() + 9;
			$('#triangleBottom').remove();
		}else {
			top -= $('#schedulePops').height() + 22;
			$('#triangleTop').remove();
		}
		
		if(jsEvent.pageX - left <= 20) $('.triangle').offset( { left: 20 });
		else if(20 < jsEvent.pageX - left && jsEvent.pageX - left <= popWidth - 30  ) $('.triangle').offset( { left: jsEvent.pageX - left - $('.triangle').width()/2 });
		else if(popWidth - 30 < jsEvent.pageX - left ){ $('.triangle').offset( { left: popWidth - 30}); }
		$('#schedulePops').offset( { top: top, left: left } );
	},
	
	//week mode
	initWeekSchedulePopupPosition : function(data, target, calEvent, jsEvent, view) {
		if(calEvent.allDay) $(data).appendTo($($('.fc-event-container')[0]));
		else $(data).appendTo($($('.fc-event-container')[1]));
		
		var width = $('#contentsArea').width();
		var popWidth = $('#schedulePops').outerWidth();
		var leftWidth = $('#contentsArea').offset().left;

		var top = jsEvent.pageY + 9;
		var left = jsEvent.pageX-leftWidth;

		if(left <= 15 + popWidth/2) left = 12;
		else if(15 + popWidth/2 < left && left < parseInt(width - popWidth/2)) left -= $('#schedulePops').width()/2 + 15;
		else if(parseInt(width - popWidth/2) <= left) left = width - popWidth - 20;
		
		left += leftWidth;
		if(top < 280) {
			top += target.height() + 9;
		}else {
			top -= $('#schedulePops').height() + 22;
		}
		
		$('.triangle').remove();
		$('#schedulePops').offset( { top: top, left: left } );
	},
	
	initDaySchedulePopupPosition : function(data, target, calEvent, jsEvent, view) {
		if(calEvent.allDay) $(data).appendTo($($('.fc-event-container')[0]));
		else $(data).appendTo($($('.fc-event-container')[1]));
		
		var width = $('#contentsArea').width();
		var popWidth = $('#schedulePops').outerWidth();
		var leftWidth = $('#contentsArea').offset().left;

		var top = jsEvent.pageY + 9;
		var left = jsEvent.pageX-leftWidth;

		if(left <= 15 + popWidth/2) left = 12;
		else if(15 + popWidth/2 < left && left < parseInt(width - popWidth/2)) left -= $('#schedulePops').width()/2 + 15;
		else if(parseInt(width - popWidth/2) <= left) left = width - popWidth - 20;
		
		left += leftWidth;
		if(top < 280) {
			top += target.height() + 9;
		}else {
			top -= $('#schedulePops').height() + 22;
		}
		$('.triangle').remove();
		$('#schedulePops').offset( { top: top, left: left } );
	},
	
	progress : function() {
		var val = $('#progressbar').progressbar( "value" ) || 0;
		if(val >= $('#progressbar').progressbar("option", "max")) val = -20;
		$('#progressbar').progressbar( "value", val + 20);
		setTimeout( enCal.progress, 250 );
	},
	
	initCalendar : function(){
		enCal.log('calendar.initCalendar start');
		
		if(!document.getElementById('calendar')) return;
		
		$('input[name=calendarId]').each(function(index){
			var $this = $(this);
			enCal.m_calendarIds[index] = $this.val();
		});
		
		$('#calendar').fullCalendar({
			//options setting
			timeFormat: enCal.getOption('timeFormat'),
			defaultView: enCal.getOption('defaultView'),
			header: enCal.getOption('header'),
			titleFormat: enCal.getOption('titleFormat'),
			monthNames: enCal.getOption('monthNames'),
			monthNamesShort: enCal.getOption('monthNamesShort'),
			dayNames: enCal.getOption('dayNames'),
			dayNamesShort: enCal.getOption('dayNamesShort'),
			buttonText: enCal.getOption('buttonText'),
			allDayText: enCal.getOption('allDayText'),
			axisFormat: enCal.getOption('axisFormat'),
					
			editable: true,
			events : function(start, end, callback) {
				var events = new Array();
				var totalEvents = new Array();
				enCal.m_start = start.format("yyyy-MM-dd");
				enCal.m_end = end.format("yyyy-MM-dd");
				
				for(var i = 0 ; i < enCal.m_calendarIds.length ; i++){
					var selected = $('input[name=' + enCal.m_calendarIds[i] + '_selected]').val();
					if(selected == 1) {
						events = enCal.renderEvents(enCal.m_calendarIds[i]);
						totalEvents = totalEvents.concat(events);
					}
				}
				callback(totalEvents);
				enCal.removePopups();
	    	},
	    	
	    	dayClick : function( date, allDay, jsEvent, view ){
	    		var isPass = true;
	    		$('input[name=calPermissions]').each(function(){
	    			if(!isPass) return;
	    			if($(this).val().indexOf('C') >= 0 || $(this).val().indexOf('U') >= 0) isPass = false;
	    		});
	    		if(isPass) return;
    			var param = 'start=' + date.format(enCal.m_dateFormat);
    			param += '&end=' + date.format(enCal.m_dateFormat);
    			param += '&cmd=WRITE';
    			if($('#isSpecific').val() == 'Y') {
    				var cid = $('input[name=calendarId]').val();
    				param += '&calendarId=' + cid;
    				param += '&isPublic=' + $('#' + cid + '_isPublic').val();
    			}
    			enCal.showScheduleDetail(new Object(), param);
	    	},
	    	eventClick : function(calEvent, jsEvent, view){
	    		if(enCal.m_selectedEvent && enCal.m_selectedEvent.scheduleId == calEvent.scheduleId) return;
	    		var $this = $(this);
	    		var isOwner = $('#' + calEvent.calendarId + '_isOwner').val();
	    		var isDefault = $('#' + calEvent.calendarId + '_isDefault').val();
	    		var isPublic = $('#' + calEvent.calendarId + '_isPublic').val();
	    		var bgColor = $('#' + calEvent.calendarId + '_bgColor').val();
	    		var param = 'scheduleId=' + calEvent.scheduleId;
	    		param += '&isJointSchedule=' + calEvent.isJoint;
	    		param += '&isDefault=' + isDefault;
	    		param += '&isOwner=' + isOwner;
	    		param += '&isPublic=' + isPublic;
	    		param += '&isUserPublic=' + $('#' + calEvent.calendarId + '_isUserPublic').val();
	    		param += '&skin=' + enCal.m_skin;
	    		param += '&start=' + calEvent.start.format(enCal.m_dateFormat);
	    		if(calEvent.end != null) param += '&end=' + calEvent.end.format(enCal.m_dateFormat);
	    		else  param += '&end=' + calEvent.start.format(enCal.m_dateFormat);
	    		if(enCal.m_viewName != null ) param += '&viewName='+ enCal.m_viewName;
	    		enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/schedule.hanc", param, false, {
	    			success: function(data){
	    				enCal.removePopups();
						
						if(view.name == 'month') enCal.initMonthSchedulePopupPosition(data, $this, calEvent, jsEvent, view);
						else if( view.name == 'week' || view.name == 'agendaWeek' ) enCal.initWeekSchedulePopupPosition(data, calEvent, jsEvent, view);
						else if( view.name == 'day' || view.name == 'agendaDay') enCal.initDaySchedulePopupPosition(data, $this, calEvent, jsEvent, view);
						
						$('#scheduleName').css('color', bgColor);
						$('#scheduleClose').click(function(event){
							enCal.removePopups();
						});			
						$(document.body, 'schedulePops').keyup(function(event){
							var keyCode = event.keyCode;
							if(keyCode == 27) enCal.removePopups();
						});
						
						$('#schedulePops', 'schedulePops').keyup(function(event){
							var keyCode = event.keyCode;
							if(keyCode == 27) enCal.removePopups();
						});
						
						$('#schedulePops').focus();
						enCal.m_selectedEvent = calEvent;
	    			}
	    		});
	    	},
	    	eventDrop : function( event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view ) {
	    		var scheduleId = event.scheduleId;
	    		var start = event.start;
	    		var end = event.end;
	    		
	    		var param = 'scheduleId=' + scheduleId;
	    		param += '&start=' + start.format("yyyy-MM-dd HH:mm");
	    		if(end) param += '&end=' + end.format("yyyy-MM-dd HH:mm");
	    		else param += '&end=' + start.format("yyyy-MM-dd HH:mm");
	    		enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/moveSchedule.hanc", param, false, {
	    			success: function(data){
//	    				$('#calendar').fullCalendar('updateEvent', event);
	    				enCal.autoResize();
	    			}
	    		});
	    	},
	    	eventResize : function( event, dayDelta, minuteDelta, revertFunc, jsEvent, ui, view ) {
	    		var scheduleId = event.scheduleId;
	    		var start = event.start;
	    		var end = event.end;

	    		var param = 'scheduleId=' + scheduleId;
	    		param += '&start=' + start.format("yyyy-MM-dd HH:mm");
	    		if(end) param += '&end=' + end.format("yyyy-MM-dd HH:mm");
	    		else param += '&end=' + start.format("yyyy-MM-dd HH:mm");
	    		enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/resizeSchedule.hanc", param, false, {
	    			success: function(data){
//	    				$('#calendar').fullCalendar('updateEvent', event);
	    				enCal.autoResize();
	    			}
	    		});
	    	}
		});
		
		enCal.log('calendar.initCalendar complete!');	//console.log => enCal.log로 변경.
	},
	
	today : function() {
		$('#calendar').fullCalendar().today();
	},
	
	showCalendarDetail : function(cmd, calendarId) {
		var param = 'cmd=' + cmd;
		if(calendarId) param += '&calendarId=' + calendarId;
		param += '&isOwner=' + $('#' + calendarId + '_isOwner').val();
		param += '&isDefault=' + $('#' + calendarId + '_isDefault').val();
		param += '&isPublic=' + $('#' + calendarId + '_isPublic').val();
		param += '&isUserPublic=' + $('#' + calendarId + '_isUserPublic').val();
		if(enCal.m_viewName != null ) param += '&viewName='+ enCal.m_viewName;
		param += '&skin=' + enCal.m_skin;
		this.m_ajax.send("POST", enCal.m_contextPath + "/calendar/calendarDetail.hanc", param, false, {
			success: function(data){
				enCal.removePopups();
				enCal.modalLayer();
				$(data).appendTo($(document.body));
				$('#calendarDetails').css('z-index', 3000);
				$('#calendarDetails').offset( {top: $(document.body).height()/2 - $('#calendarDetails').height() +10, left: $(document.body).width()/2 - $('#calendarDetails').width()/2 });
				
				$('#calendarDetailClose').click(function(event){
					enCal.removePopups();
				});
				
				$(document.body).bind('keyup bodyESC', function(event){
					var keyCode = event.keyCode;
					if(keyCode == 27) enCal.removePopups();
				});
				
				$('#calendarDetails').bind('keyup calendarDetailsESC', function(event){
					var keyCode = event.keyCode;
					if(keyCode == 27) enCal.removePopups();
				});

				$('#searchUser').bind('keyup searchUserEnter', function(event){
					var keyCode = event.keyCode;
					if(keyCode == 13){
						if($('#searchUser').val().length > 1) {
							enCal.searchUser('searchUser', 'PANEL', enCal.addCalendarUser);
						} else{
							alert(enCal.getMessage('hn.info.search.required.words', 2));
						}
					}
				});
				$('#searchUserButton').bind('click searchUserButtonClick', function(event){
					if($('#searchUser').val().length > 1) {
						enCal.searchUser('searchUser', 'PANEL', enCal.addCalendarUser);
					} else {
						alert(enCal.getMessage('hn.info.search.required.words', 2));
					}
				});
				
				$('#calendarDetails').focus();
				//$("#calendarDetails").draggable({ containment: "parent" });
				
				$('.calendarUser').filter(':not(:first)').each(function(idx){
					var $this = $(this);
					var user = new hancer.cal.calendarUser($this.attr('userId'));
					user.setUserNm($this.attr('userName'));
					enCal.m_calendarUsers.push(user);
				});
			}
		});
	},
	
	addCalendarUser : function(userId, userName, title){
		var isOverrap = false;
		for(var i = 0 ; i < enCal.m_calendarUsers.length; i++){
			if(enCal.m_calendarUsers[i].getUserId() == userId) {
				isOverrap = true;
				break;
			}
		}
		if(isOverrap) return;
		var addUser = '<div userId="'+userId+'" class="calendarUser"><div class="name" title="'+ title +'">'+ title +'</div>' +
					  '<select id="'+userId+'_permissions" name="'+userId+'_permissions" onchange="enCal.onchangePermissions(\'' + userId + '\')">' + 
					  '<option value="RU">' + enCal.getMessage('hn.info.title.calendar.permissions.ru')+'</option>' + 
					  '<option value="R" selected="selected">' + enCal.getMessage('hn.info.title.calendar.permissions.r')+'</option>' + 
					  '</select>' + 
					  '<span class="deleteUser ui-icon ui-icon-trash" onclick="enCal.deleteCalendarUser(this);"></span>' +
					  '</div>';
		$(addUser).appendTo($('#attends'));
		var user = new hancer.cal.calendarUser(userId);
		user.setUserNm(userName);
		enCal.m_calendarUsers.push(user);
		$('#searchUserList').remove();
		enCal.m_isJointModified = 'Y';
	},
	
	onchangePermissions : function(userId){
		var permissions = $('#' + userId + '_permissions').val();
		for(var i = 0 ; i < enCal.m_calendarUsers.length; i++){
			if(enCal.m_calendarUsers[i].getUserId() == userId) {
				enCal.m_calendarUsers[i].setPermissions(permissions);
				break;
			}
		}
		enCal.m_isJointModified = 'Y';
	},
	
	deleteCalendarUser: function(obj){
		$this = $(obj);
		var deleteUser = $this.parent();
		for(var i = 0 ; i < enCal.m_calendarUsers.length; i++){
			if(enCal.m_calendarUsers[i].getUserId() == deleteUser.attr('userId')) {
				enCal.m_calendarUsers.splice(i, 1);
				break;
			}
		}
		deleteUser.remove();
		enCal.m_isJointModified = 'Y';
	},
	
	saveCalendar : function(calendarId){
		if(!confirm(enCal.getMessage('hn.info.confirm.save'))) return;
		
		var langKndList = '';
		var name = '';
		var $nameList = $('input[name="nameList"]');
		var modifiedName = '';
		if($nameList.length > 0){
			$nameList.each(function(){
				var $this = $(this);
				langKndList += '&langKndList=' + $this.attr('langKnd');
				name += '&nameList=' + enCal.m_encodeing($this.val());
				if($this.attr('langKnd') == $('#langKnd').val()) modifiedName = $this.val();
			});
		}else {
			name = '&name=' + enCal.m_encodeing($('#name').val());
			modifiedName = $('#name').val();
		}
		
		var comments = '';
		var $commentsList = $('textarea[name="commentsList"]');
		if($commentsList.length > 0){
			$commentsList.each(function(){
				var $this = $(this);
				comments += '&commentsList=' + enCal.m_encodeing($this.val());
			});
		} else {
			comments = '&comments=' + enCal.m_encodeing($('#calendarComments').text());
		}
		
		var calendarUserId = '';
		var permissions = '';
		for(var i=0 ; enCal.m_calendarUsers.length; i++){
			var user = enCal.m_calendarUsers.pop();
			calendarUserId += '&calendarUserId=' + user.getUserId();
			permissions += '&calPermissions=' + user.getPermissions();
		}
		var cmd = $('#cmd').val();
		var param = 'cmd=' + cmd;
		if(cmd == 'MODIFY') {
			var isPublic = $('#' + calendarId + '_isPublic').val();
			var isUserPublic = $('#' + calendarId + '_isUserPublic').val();
			param += '&calendarId=' + calendarId;
			param += '&isPublic=' + isPublic;
			param += '&isUserPublic=' + isUserPublic;
		}else {
			param += '&isPublic=N';
			param += '&isUserPublic=N';
		}
		param += langKndList;
		param += name;
		param += comments;
		param += calendarUserId;
		param += permissions;
		param += '&isJointModified=' + enCal.m_isJointModified;
		if(enCal.m_viewName != null ) param += '&viewName='+ enCal.m_viewName;
		enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/saveCalendar.hanc", param, false, {
			success: function(data){
//				if(cmd == 'MODIFY') {
//					$('#' + calendarId + '_CalToggle').attr('title', modifiedName);
//					$('#' + calendarId + '_CalToggle > label.calendarName').text(modifiedName);
//					enCal.removePopups();
//				} else {
//					window.location.reload();
//				}
				window.location.reload();
			}
		});
	},
	
	deleteCalendar : function(calendarId) {
		var isDefault = $('#' + calendarId + '_isDefault').val();
		if(isDefault == 'Y') {
			alert(enCal.getMessage('hn.info.invalid.delete.owner'));
			return;
		}
		
		var isOwner = $('#' + calendarId + '_isOwner').val();
		if(isOwner == 'Y') msgCd = 'hn.info.confirm.delete.calendar';
		else msgCd = 'hn.info.confirm.delete.joint';
		if(!confirm(enCal.getMessage(msgCd))) return;
		
		var param = 'calendarId=' + calendarId;
		param += '&isOwner=' + isOwner;
		param += '&isDefault=' + isDefault;
		enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/deleteCalendar.hanc", param, false, {
			success: function(data){
				if(data.Status != 'fail') window.location.reload();
				else {
					alert(data.Reason);
				}
			}
		});
	},
	
	goCalendar : function(){
		window.location.href = this.m_contextPath + "/calendar/moboileCalendar.hanc?skin=" + enCal.m_skin;
	},
	
	searchUser : function(searchFieldId, cmd, selectCallback){
		var searchField = $('#' + searchFieldId);
		var searchUser = searchField.val();
		if(searchUser != null || searchUser != ''){
			var param = 'searchUser=' + searchUser;
			param += "&cmd=PANEL";
			if(enCal.m_viewName != null ) param += '&viewName='+ enCal.m_viewName;
			param += '&skin=' + enCal.m_skin;
			this.m_ajax.send("POST", enCal.m_contextPath + "/calendar/searchUser.hanc", param, false, {
				success: function(data){
					$('#searchUserList').remove();
					$(data).appendTo(searchField.parent().parent());
					$('#searchUserList').offset( { top: searchField.offset().top - $('#searchUserList').height() - 7, left: searchField.offset().left - $('#searchUserList').width() + searchField.width() + 8 } );

					if($('.searchedUserRow:first').hasClass('noUser')){
						$(data).bind('keyup noUser', function(event){
							event.stopPropagation();
							var keyCode = event.keyCode;
							if(keyCode == 27) $('#searchUserList').remove();
						});
						$(data).focus();
					} else {
						$('.searchedUser').click(function(){
							var $this = $(this);
							selectCallback($this.attr('userId'), $this.attr('userName'), $this.attr('title'));
						});
					}
				}
			});
		} else {
			alert(enCal.getMessage('hn.info.input.required.user'));
			$('#searchUser').select();
		}
	},
	
	toggleCalendarList : function(){
		if(enCal.m_viewName == 'mobile'){
			var effect = "blind";
			var options = { };
			if(!enCal.m_isCalListOpen) {
				enCal.removePopups();
				$("#toggleCalendarListButton").css('top', '-6px');
				$("#leftArea").show( effect, options, 500, function(){
					enCal.m_isCalListOpen = true;
					$("#toggleCalendarListButton").css('line-height', '14px');
					$("#toggleCalendarListButton").text("▲");
				});
			} else {
				$("#toggleCalendarListButton").css('top', '-3px');
				$("#leftArea").hide(effect, options, 500, function(){
					enCal.m_isCalListOpen = false;
					$("#toggleCalendarListButton").css('line-height', '20px');
					$("#toggleCalendarListButton").text("▼");
				});
			}
			$("#calendarListPin").removeClass('ui-icon-pin-s');
			$("#calendarListPin").addClass('ui-icon-pin-w');
			enCal.m_calSliderFixed = false;
		}else {
			return;
		}
	},
	
	closeCalendarList : function(){
		if(enCal.m_viewName == 'mobile'){
			if(!enCal.m_calSliderFixed) {
				var effect = "blind";
				var options = { };
				if(enCal.m_isCalListOpen) {
					$("#toggleCalendarListButton").css('top', '-3px');
					$("#leftArea").hide(effect, options, 500, function(){
						enCal.m_isCalListOpen = false;
						$("#toggleCalendarListButton").css('line-height', '20px');
						$("#toggleCalendarListButton").text("▼");
					});
				}
			}
		} else {
			return;
		}
	},
	
	renderOnlyThis : function(calendarId){
		$('#calendar').fullCalendar( 'removeEvents');
		$('.calendarBgColor').css('border-color', 'gray');
		$('.calendarBgColor').css('background-color', 'rgba(0, 0, 0, 0)');
		$("input[name$='_selected']").val(0);
		$('input[name=' + calendarId + '_selected]').val(1);
		$('#calendar').fullCalendar( 'refetchEvents' );
		var orgBgColor = $('#' + calendarId + '_bgColor').val();
		$('#' + calendarId + '_calendarBgColor').css('border-color', orgBgColor);
		$('#' + calendarId + '_calendarBgColor').css('background-color', orgBgColor);
	},
	
	modalLayer : function(){
		var layer = $('<div id="modalLayer" class="modalLayer"></div>');
		layer.width($('#wrap').width() == 0 ? $('#contentsArea').outerWidth() : $('#wrap').outerWidth());
		layer.height($('#wrap').height() == 0 ? $('#contentsArea').outerHeight() : $('#wrap').outerHeight());
		layer.appendTo($('#wrap'));
	},
	
	removePopups : function(){
		enCal.m_selectedEvent = null;
//		enCal.m_scheduleUsers = [];
		enCal.m_calendarUsers = [];
		enCal.m_isJointModified = 'N';
		$('#schedulePops').remove();
		$('#scheduleDetails').remove();
		$('#calendarPopup').remove();
		$('#calendarDetails').remove();
		$('#icalMenu').remove();
		$('#modalLayer').remove();
		
		enCal.closeCalendarList();
		enCal.autoResize();
		$(document.body).focus();
	},
	
	modifySchedule : function(){
		var calEvent = enCal.m_selectedEvent;
		var scheduleId = calEvent.scheduleId;
		var calendarId = calEvent.calendarId;
		var isOwner = $('#detail_isOwner').val();
		var isDefault = $('#detail_isDefault').val();
		var isJointSchedule = calEvent.isJoint;
		var isPublic = $('#' + calendarId  + '_isPublic').val();
		var isUserPublic= $('#' + calendarId + '_isUserPublic').val();
		var param = 'scheduleId=' + scheduleId;
		param += '&calendarId=' + calendarId;
		param += '&isOwner=' + isOwner;
		param += '&isDefault=' + isDefault;
		param += '&isJointSchedule=' + isJointSchedule;
		param += '&cmd=MODIFY'; 
		param += '&isPublic=' + isPublic;
		param += '&isUserPublic=' + isUserPublic;
		param += '&start=' + calEvent.start.format(enCal.m_dateFormat);
		if(calEvent.end != null) param += '&end=' + calEvent.end.format(enCal.m_dateFormat);
		else  param += '&end=' + calEvent.start.format(enCal.m_dateFormat);
		enCal.showScheduleDetail(calEvent, param);
	},
	
//	addScheduleUser : function(userId, userName){
//		var isOverrap = false;
//		for(var i = 0 ; i < enCal.m_scheduleUsers.length; i++){
//			if(enCal.m_scheduleUsers[i].getUserId() == userId) {
//				isOverrap = true;
//				break;
//			}
//		}
//		if(isOverrap) return;
//		var user = new hancer.cal.scheduleUser();
//		user.setUserId(userId);
//		user.setUserNm(userName);
//		enCal.m_scheduleUsers.push(user);
//		var addUser = $('<div userId="'+userId+'" class="scheduleUser"><div class="name" title="'+ userName + '(' + userId +')">'+userName + '(' + userId +')</div><span class="deleteUser ui-icon ui-icon-trash" onclick="enCal.deleteUser(this);"></span></div>');
//		addUser.appendTo($('#attends'));
//		$('#searchUserList').remove();
//	},
	
	showScheduleDetailForCalendar : function(calendarId){
		var date = new Date().format(enCal.m_dateFormat + ' ' + enCal.m_dateTimeFormat);
		var isPublic = $('#' + calendarId + '_isPublic').val();
		var isOwner = $('#' + calendarId + '_isOwner').val();
		var isUserPublic= $('#' + calendarId + '_isUserPublic').val();
		var param = 'start=' + date;
		param += '&end=' + date;
		param += '&cmd=WRITE';
		param += '&calendarId=' + calendarId;
		param += '&isPublic=' + isPublic;
		param += '&isOwner=' + isOwner;
		param += '&isUserPublic=' + isUserPublic;
		enCal.showScheduleDetail(new Object(), param);
	},
	
	showScheduleDetail : function(calEvent, param) {
		if($('#isPublicOnly').val() != null) {
			param += '&publicOnly=true';
			if(param.indexOf('isPublic') < 0) param += '&isPublic=Y';
		}
		if(enCal.m_viewName != null ) param += '&viewName='+ enCal.m_viewName;
		param += '&isWithUserPublic=' + $('#isWithUserPublic').val();
		param += '&isOnlyUserPublic=' + $('#isOnlyUserPublic').val();
		param += '&isSpecific=' + $('#isSpecific').val();
		param += '&skin=' + enCal.m_skin;
		enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/scheduleDetail.hanc", param, false, {
			success: function(data){
				enCal.removePopups();
				enCal.modalLayer();
				$(data).appendTo($('#wrap'));
				$('#scheduleDetails').css('z-index', 3000);
				var dTop = $('#wrap').height()/2 - $('#scheduleDetails').height()/2;
				if(enCal.m_viewName == 'mobile') dTop = 10;
				var dLeft = $('#wrap').outerWidth()/2 - $('#scheduleDetails').outerWidth()/2;
				$('#scheduleDetails').offset( {top: dTop, left: dLeft });
				
				$('#scheduleDetailClose').click(function(event){
					enCal.removePopups();
				});
				
				$(document.body).bind('keyup bodyESC', function(event){
					var keyCode = event.keyCode;
					if(keyCode == 27) enCal.removePopups();
				});
				
				$('#scheduleDetails').bind('keyup scheduleDetailsESC', function(event){
					var keyCode = event.keyCode;
					if(keyCode == 27) enCal.removePopups();
				});

//				if($('#' + $('#prevCalendarId').val()  + '_isPublic').val() == 'N'){
//					$('#searchUser').bind('keyup searchUserEnter', function(event){
//						var keyCode = event.keyCode;
//						if(keyCode == 13){
//							if($('#searchUser').val().length > 1) {
//								enCal.searchUser('searchUser', 'PANEL', enCal.addScheduleUser);
//							} else{
//								alert(enCal.getMessage('hn.info.search.required.words', 2));
//							}
//						}
//					});
//					$('#searchUserButton').bind('click searchUserButtonClick', function(event){
//						if($('#searchUser').val().length > 1) {
//							enCal.searchUser('searchUser', 'PANEL', enCal.addScheduleUser);
//						} else {
//							alert(enCal.getMessage('hn.info.search.required.words', 2));
//						}
//					});
//					
//					$('#permissionU').bind('change permissionUChange', function(event){
//						if($('#permissionU').is(':checked')){
//							$('#permissionA').prop('checked', 'checked');
//							$('#permissionA').prop('disabled', 'disabled');
//							$('#permissionR').prop('checked', 'checked');
//							$('#permissionR').prop('disabled', 'disabled');
//						} else {
//							$('#permissionA').prop('disabled', '');
//							$('#permissionR').prop('disabled', '');
//						}
//					});
//				}
				
				$('#scheduleDetails').focus();
				
				
				$('#start').datepicker({ dateFormat: "yy.mm.dd", onClose: function(dateText, inst){
					enCal.initIntervalSelect();
				} });
				$('#end').datepicker({ dateFormat: "yy.mm.dd", onClose: function(dateText, inst){
					enCal.initIntervalSelect();
				} });
				
				enCal.initIntervalSelect();
				if($('#orgInterval').val() != '') $('#interval').val($('#orgInterval').val());
				
				if($('#allday').is(':checked')){
					$('.dateTime').css('display', 'none');
				}
				
				$('#allday').change(function(event){
					$('#timepicker').remove();
					var allday = $('#allday').is(':checked');
					if(allday) {
						$('.dateTime').css('display', 'none');
					} else {
						$('.dateTime').css('display', 'inline-block');
					}
				});
				
				if(!$('#alarmPattern').is(':checked')){
					$('.scheduleAlarm label.valLabel').addClass('disabled');
					$('input[name="alarmPattern"]').prop('disabled', true);
				}
				
				$('#alarmPattern').change(function(event){
					var alarmPattern = $('#alarmPattern').is(':checked');
					if(!alarmPattern) {
						$('.scheduleAlarm label.valLabel').addClass('disabled');
						$('input[name="alarmPattern"]').prop('disabled', true);
					} else {
						$('.scheduleAlarm label.valLabel').removeClass('disabled');
						$('input[name="alarmPattern"]').prop('disabled', false);
					}
				});
				
				if(!$('#rrule').is(':checked')){
					$('.scheduleRrule label.valLabel').addClass('disabled');
					$('.scheduleRruleFreq label.valLabel').addClass('disabled');
					$('.scheduleRruleByday label.valLabel').addClass('disabled');
					$('.scheduleRruleBymonthday label.valLabel').addClass('disabled');
					$('#freq').prop('disabled', true);
					$('#interval').prop('disabled', true);
					$('input[name="byday"]').prop('disabled', true);
					$('.scheduleRruleDate label').addClass('disabled');
				} else {
					enCal.initRruleText();
				}
				
				$('#rrule').change(function(event){
					if($('#rrule').is(':checked')) {
						$('.scheduleRrule label.valLabel').removeClass('disabled');
						$('.scheduleRruleFreq label.valLabel').removeClass('disabled');
						$('.scheduleRruleByday label.valLabel').removeClass('disabled');
						$('.scheduleRruleBymonthday label.valLabel').removeClass('disabled');
						$('.scheduleRruleDate label').removeClass('disabled');
						$('#freq').prop('disabled', false);
						$('#interval').prop('disabled', false);
						$('input[name="byday"]').prop('disabled', false);
						$('input[name="bymonthday"]').prop('disabled', false);
						$('input[name="untilType"]').prop('disabled', false);
						$('#until').prop('disabled', ($('input[name="untilType"]:checked').val() != 'limited'));
						$($('input[name="byday"]')[$('#start').datepicker("getDate").getDay()]).prop('checked', 'checked');
					} else {
						$('.scheduleRrule label.valLabel').addClass('disabled');
						$('.scheduleRruleFreq label.valLabel').addClass('disabled');
						$('.scheduleRruleByday label.valLabel').addClass('disabled');
						$('.scheduleRruleBymonthday label.valLabel').addClass('disabled');
						$('.scheduleRruleDate label').addClass('disabled');
						$('#freq').prop('disabled', true);
						$('#interval').prop('disabled', true);
						$('input[name="byday"]').prop('disabled', true);
						$('input[name="bymonthday"]').prop('disabled', true);
						$('input[name="untilType"]').prop('disabled', true);
						$('#until').prop('disabled', true);
					}
					enCal.initRruleText();
				});
				
				$('#interval').change(function(){
					enCal.initRruleText();
				});
				
				$('input[name="byday"]').change(function(){
					enCal.initRruleText();
				});
				
				$('input[name="bymonthday"]').change(function(){
					enCal.initRruleText();
				});
				
				$('#until').prop('disabled', ($('input[name="untilType"]:checked').val() != 'limited'));
						
				$('input[name="untilType"]').change(function(){
					var $this = $(this);
					$('#until').prop('disabled', ($this.val() != 'limited'));
					if($this.val() == 'limited'){
						$('#until').val($('#start').datepicker('getDate').format(enCal.m_dateFormat));
					} else {
						$('#until').val('');
					}
					enCal.initRruleText();
				});
				
				$('#scheduleRruleByday').addClass($('#freq').val().toLowerCase());
				$('#scheduleRruleBymonthday').addClass($('#freq').val().toLowerCase());
				
				$('#freq').change(function(event){
					var freq = $('#freq').val();
					$('#scheduleRruleByday').removeClass('daily');
					$('#scheduleRruleByday').removeClass('weekly');
					$('#scheduleRruleByday').removeClass('monthly');
					$('#scheduleRruleByday').removeClass('yearly');
					$('#scheduleRruleByday').addClass(freq.toLowerCase());
					
					$('#scheduleRruleBymonthday').removeClass('daily');
					$('#scheduleRruleBymonthday').removeClass('weekly');
					$('#scheduleRruleBymonthday').removeClass('monthly');
					$('#scheduleRruleBymonthday').removeClass('yearly');
					$('#scheduleRruleBymonthday').addClass(freq.toLowerCase());
					
					$($('input[name="byday"]')[$('#start').datepicker("getDate").getDay()]).prop('checked', 'checked');
					
					enCal.initRruleText();
				});
				
				$('#until').datepicker({ dateFormat: "yy.mm.dd" });
				
				enCal.m_selectedEvent = calEvent;
//				$("#scheduleDetails").draggable({ containment: "parent" });
				
//				$('.scheduleUser').filter(':not(:first)').each(function(idx){
//					var $this = $(this);
//					var user = new hancer.cal.scheduleUser();
//					user.setUserId($this.attr('userId'));
//					enCal.m_scheduleUsers.push(user);
//				});
				
				$('#selectedCalendarId').change(function(event){
					$this = $(this);
					var isPublic = $('#' + $this.val()  + '_isPublic').val();
					var originIsPublic = $('#' + $('#prevCalendarId').val()  + '_isPublic').val();
					$('#prevCalendarId').val($this.val());
//					if(isPublic != originIsPublic) {
						var scheduleId = calEvent ? calEvent.scheduleId : 0;
						var calendarId = $('#selectedCalendarId').val();
						var isOwner = $('#' + calendarId + '_isOwner').val();
						var isDefault = $('#' + calendarId + '_isDefault').val();
						var isJointSchedule = calEvent.isJoint;
						var cmd = $('#cmd').val();
						var isPublic = $('#' + calendarId  + '_isPublic').val();
						var isUserPublic= $('#' + calendarId + '_isUserPublic').val();
						var param = 'scheduleId=' + scheduleId;
						param += '&calendarId=' + calendarId;
						param += '&isOwner=' + isOwner;
						param += '&isDefault=' + isDefault;
						param += '&isJointSchedule=' + isJointSchedule;
						param += '&cmd=' + cmd; 
						param += '&isPublic=' + isPublic;
						param += '&isUserPublic=' + $('#' + calendarId + '_isUserPublic').val();
						
						var allday = $('#allday').is(':checked');
						var start = $('#start').datepicker("getDate");
						var startTime = allday ? '' : ' ' + $('#startTime > input[name="times"]').val();
						var end = $('#end').datepicker("getDate");
						var endTime = allday ? '' : ' ' + $('#endTime > input[name="times"]').val();
						var alarmPattern = $('input[name="alarmPattern"]:checked').val();
						if(!$('#alarmPattern').is(':checked')) alarmPattern = '';

						var freq = $('#freq').val();
						var interval = $('#interval').val();
						var bydays = $('input[name="byday"]:checked').toArray();
						var byday = null;
						var bymonthdays = $('input[name="bymonthday"]:checked').val();
						var bymonthday = null;
						if(freq.toUpperCase() == 'DAILY'){
							byday = null;
						}
						else if(freq.toUpperCase() == 'WEEKLY'){
							for(var i = 0; i < bydays.length ; i++){
								byday += bydays[i].value;
								if(i < bydays.length-1) byday += ',';
							}
						}
						else if(freq.toUpperCase() == 'MONTHLY'){
							if(bymonthdays == 'bymonthday') {
								bymonthday = start.format('dd');
							} else {
								var tempDate = new Date(start.format('yyyy-MM-dd'));
								tempDate.setDate(1);
								byday = Math.floor((tempDate.getDay() + parseInt(start.format('dd')))/7)+1 + $('input[name="byday"]').toArray()[start.getDay()].value;
							}
						}
						else if(freq.toUpperCase() == 'YEARLY'){
							for(var i = 0; i < bydays.length ; i++){
								byday += bydays[i].value;
								if(i < bydays.length-1) byday += ',';
							}
						}
						
						var until = null;
						if($('input[name="untilType"]:checked').val() == 'limited'){
							until = $('#until').val();
							if(until == null || until == '') {
								alert(enCal.getMessage('hn.info.required.schedule.rrule.until'));
								return;
							}
							until = $('#until').datepicker("getDate").format("yyyyMMdd");
						}
						
						if(!$('#rrule').is(':checked')) {
							freq = null;
							interval = null;
							byday = null;
							until = null;
						} else {
							if(freq == 'WEEKLY' && bydays.length == 0){
								alert(enCal.getMessage('hn.info.required.schedule.byday'));
								return;
							}
							
						}
						var $nameList = $('input[name="nameList"]');
						var nameList = '';
						var langKndList = '';
						var name = $('#name').val();
						if($nameList.length > 0){
							$nameList.each(function(idx){
								var $this = $(this);
								langKndList += '&langKndList=' + $this.attr('langKnd');
								nameList += '&nameList=' + enCal.m_encodeing($this.val());
								if( $this.attr('langKnd') == $('#langKnd').val()) name = $this.val();
								
							});
						}
						
						var $placeList = $('input[name="placeList"]');
						var placeList = '';
						if($placeList.length > 0){
							$placeList.each(function(){
								var $this = $(this);
								placeList += '&placeList=' + enCal.m_encodeing($this.val());
							});
						}
						var place = $('#schedulePlace').val();
						
						var $commentsList = $('textarea[name="commentsList"]');
						var commentsList = '';
						if($commentsList.length > 0){
							$commentsList.each(function(){
								var $this = $(this);
								commentsList += '&commentsList=' + enCal.m_encodeing($this.val());
							});
						}
						var comments = $('#scheduleComments').val();
						
						param += '&start=' + start.format(enCal.m_dateFormat) + startTime;
						param += '&end=' + end.format(enCal.m_dateFormat) + endTime ;
						param += '&allday=' + (allday ? 1:0);
						if(alarmPattern != null && alarmPattern != '') param += '&alarmPattern=' + alarmPattern;
						if(freq && freq != null && freq != ''){
							param += '&freq=' + freq;
							if(interval != null) param += '&interval=' + interval;
							if(bymonthday != null) param += '&bymonthday=' + bymonthday;
							if(byday != null) param += '&byday=' + byday;
							if(until != null) param += '&until=' + until;
						}
						param += langKndList;
						param += nameList;
						if($nameList.length <= 0) param += '&name=' + enCal.m_encodeing(name);
						param += placeList;
						if($placeList.length <= 0) param += '&place=' + enCal.m_encodeing(place);
						param += commentsList;
						if($commentsList.length <= 0) param += '&comments=' + enCal.m_encodeing(comments);
						enCal.removePopups();
						enCal.showScheduleDetail(calEvent, param);
//					}
				});
				
				$('.dateTime').click(function(){
					$('#timepicker').remove();
					var $this = $(this);
					var param = '';
					if(enCal.m_viewName != null ) param += '&viewName='+ enCal.m_viewName;
					param += '&skin=' + enCal.m_skin;
					enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/timepicker.hanc", param, false, {
		    			success: function(data){
		    				$(data).appendTo($this.parent());
		    				$('#timepicker').offset( { top: $this.offset().top + 33, left: $this.offset().left } );
		    				$('.times').click(function(){
		    					$this.html($(this).html());
		    					$('#timepicker').remove();
		    				});
		    			}
		    		});
				});
			}
		});
	},
	
	initRruleText : function(){
		var rruleText = '';
		var start = $('#start').datepicker("getDate");
		var freq = $('#freq');
		var interval = $('#interval').val();
		var bydays = $('input[name="byday"]:checked').toArray();
		var bymonthday = $('#bymonthday').val();
		
		if($('#rrule').is(':checked')) {
			rruleText = freq.find('option:selected').text(); 
			if(interval > 1) {
				rruleText = interval + freq.find('option:selected').text().substring(1) + '마다';
			} 
			
			if(freq.val() == 'WEEKLY') {
				if(bydays.length > 0){
					if(bydays.length == 7){
						rruleText += ' ' + enCal.getMessage('hn.info.schedule.rrule.byday.all');
					}
					else if(bydays.length == 5 && bydays[0].value.indexOf('su') < 0 && bydays[bydays.length-1].value.indexOf('sa') < 0 ){
						rruleText += ' ' + enCal.getMessage('hn.info.schedule.rrule.byday.weekdays');
					}
					else {
						for(var i = 0 ; i < bydays.length; i++){
							if(i > 0) rruleText += ',';
							rruleText += ' ' + enCal.getMessage('hn.info.schedule.rrule.byday.' + bydays[i].value);
						}
					}
				}
			} else if(freq.val() == 'MONTHLY') {
				var bymonthday = $('input[name="bymonthday"]:checked').val();
				if(bymonthday == 'bymonthday') {
					rruleText += ' ' + start.format('dd') + '일';
				} else {
					var tempDate = new Date(start.format('yyyy-MM-dd'));
					tempDate.setDate(1);
					rruleText += ' ' + (Math.floor((tempDate.getDay() + parseInt(start.format('dd')))/7)+1) + '번째 ' +  enCal.getMessage('hn.info.schedule.rrule.byday.' + $('input[name="byday"]').toArray()[start.getDay()].value);
				}
			}
		} else {
			rruleText = enCal.getMessage('hn.info.schedule.rrule.noRepeat');	//반복일정이 해제됩니다.
		}
		$('#rruleText').text(rruleText);
	},
	
	initIntervalSelect : function() {
		var rangeDay = ($('#end').datepicker('getDate') -$('#start').datepicker('getDate')) / ( 24 * 60 * 60 * 1000);
		var freq = $('#freq').val();
		var interval = $('#interval');
		var options = '';
		var i = 0;
		if(freq == 'DAILY'){
			i = rangeDay;
		} else if(freq == 'WEEKLY'){
			i = Math.floor(rangeDay/7);
		} else if(freq == 'MONTHLY'){
			i = Math.floor(rangeDay/31);
		} else if(freq == 'YEARLY'){
			i = Math.floor(rangeDay/365);
		}
		
		$('#interval').val(i+1);	//20150202 수정 - why for문을 돌려 처리했을까????
		
		/*
		var selected = '';
		
		for(; i < 30; i++){
			options += '<option value="'+(i+1) + '"' + selected + '>' + (i+1) + '</option>';
		}
		interval.html(options);
		*/
	},
	
//	deleteUser: function(obj){
//		$this = $(obj);
//		var deleteUser = $this.parent();
//		for(var i = 0 ; i < enCal.m_scheduleUsers.length; i++){
//			if(enCal.m_scheduleUsers[i].getUserId() == deleteUser.attr('userId')) {
//				enCal.m_scheduleUsers.splice(i, 1);
//				break;
//			}
//		}
//		deleteUser.remove();
//		enCal.m_isJointModified = 'Y';
//	},
	
	deleteSchedule : function(){
		if(!confirm(enCal.getMessage('hn.info.confirm.delete.schedule'))) return;
		var scheduleId = $('#detail_scheduleId').val();
		var param = 'scheduleId=' + scheduleId;
		enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/deleteSchedule.hanc", param, false, {
			success: function(data){
				$('#calendar').fullCalendar('removeEvents', 's_' + scheduleId);
				enCal.removePopups();
			}
		});
	},
	
	saveSchedule : function() {
		var calEvent = enCal.m_selectedEvent;
		var scheduleId = calEvent ? calEvent.scheduleId : 0;
		var calendarId = $('#selectedCalendarId').val();
		var allday = $('#allday').is(':checked');
		var start = $('#start').datepicker("getDate");
		var startTime = allday ? '' : ' ' + $('#startTime > input[name="times"]').val();
		var end = $('#end').datepicker("getDate");
		var endTime = allday ? '' : ' ' + $('#endTime > input[name="times"]').val();
		var alarmPattern = $('input[name="alarmPattern"]:checked').val();
		if(!$('#alarmPattern').is(':checked')) alarmPattern = '';

		var freq = $('#freq').val();
		var interval = $('#interval').val();
		var bydays = $('input[name="byday"]:checked').toArray();
		var byday = '';
		var bymonthdays = $('input[name="bymonthday"]:checked').val();
		var bymonthday = '';
		if(freq.toUpperCase() == 'DAILY'){
			byday = '';
		}
		else if(freq.toUpperCase() == 'WEEKLY'){
			for(var i = 0; i < bydays.length ; i++){
				byday += bydays[i].value;
				if(i < bydays.length-1) byday += ',';
			}
		}
		else if(freq.toUpperCase() == 'MONTHLY'){
			if(bymonthdays == 'bymonthday') {
				bymonthday = start.format('dd');
			} else {
				var tempDate = new Date(start.format('yyyy-MM-dd'));
				tempDate.setDate(1);
				byday = Math.floor((tempDate.getDay() + parseInt(start.format('dd')))/7)+1 + $('input[name="byday"]').toArray()[start.getDay()].value;
			}
		}
		else if(freq.toUpperCase() == 'YEARLY'){
			for(var i = 0; i < bydays.length ; i++){
				byday += bydays[i].value;
				if(i < bydays.length-1) byday += ',';
			}
		}
		
		var until = '';
		if($('input[name="untilType"]:checked').val() == 'limited'){
			until = $('#until').val();
			if(until == null || until == '') {
				alert(enCal.getMessage('hn.info.required.schedule.rrule.until'));
				return;
			}
			until = $('#until').datepicker("getDate").format("yyyyMMdd");
		}
		
		if(!$('#rrule').is(':checked')) {
			freq = '';
			interval = '';
			byday = '';
			until = '';
		} else {
			if(freq == 'WEEKLY' && bydays.length == 0){
				alert(enCal.getMessage('hn.info.required.schedule.byday'));
				return;
			}
			
		}
		var $nameList = $('input[name="nameList"]');
		var nameList = '';
		var langKndList = '';
		var name = $('#name').val();
		if($nameList.length > 0){
			$nameList.each(function(idx){
				var $this = $(this);
				langKndList += '&langKndList=' + $this.attr('langKnd');
				nameList += '&nameList=' + enCal.m_encodeing($this.val());
				if( $this.attr('langKnd') == $('#langKnd').val()) name = $this.val();
				
			});
		}
		
		var $placeList = $('input[name="placeList"]');
		var placeList = '';
		if($placeList.length > 0){
			$placeList.each(function(){
				var $this = $(this);
				placeList += '&placeList=' + enCal.m_encodeing($this.val());
			});
		}
		var place = $('#schedulePlace').val();
		
		var $commentsList = $('textarea[name="commentsList"]');
		var commentsList = '';
		if($commentsList.length > 0){
			$commentsList.each(function(){
				var $this = $(this);
				commentsList += '&commentsList=' + enCal.m_encodeing($this.val());
			});
		}
		var comments = $('#scheduleComments').val();
		
		
//		var scheduleUserId = ''; 
//		for(var i=0 ; enCal.m_scheduleUsers.length; i++){
//			var user = enCal.m_scheduleUsers.pop();
//			scheduleUserId += '&scheduleUserId=' + user.getUserId();
//		}
//		
//		var permissionU = $('#permissionU').is(':checked') ? 'U' : '';
//		var permissionA = $('#permissionA').is(':checked') ? 'A' : '';
//		var permissionR = $('#permissionR').is(':checked') ? 'R' : '';
//		var permissions = permissionU + permissionA + permissionR;
		
		var isPublic = $('#' + calendarId + '_isPublic').val();
		var isOwner = $('#' + calendarId + '_isOwner').val();
		var isUserPublic = $('#' + calendarId + '_isUserPublic').val();
		var cmd = $('#cmd').val();
		var param = 'cmd=' + cmd;
		param += '&calendarId=' + calendarId;
		param += '&isPublic=' + isPublic;
		param += '&isOwner=' + isOwner;
		param += '&isUserPublic=' + isUserPublic;
		if(cmd == 'MODIFY') param += '&scheduleId=' + scheduleId;
		if(cmd != 'MODIFY' || ( cmd == 'MODIFY' && !$('#rrule').is(':checked') )) param += '&start=' + start.format("yyyy-MM-dd") + startTime;
		if(cmd != 'MODIFY' || ( cmd == 'MODIFY' && !$('#rrule').is(':checked') )) param += '&end=' + end.format("yyyy-MM-dd") + endTime ;
		param += '&allday=' + (allday ? 1:0);
		if(alarmPattern != null && alarmPattern != '') param += '&alarmPattern=' + alarmPattern;
		
		//if(freq && freq != null && freq != ''){	//반복했다가 반복체크해제하면 여기안타서 반복해제가 안되는데..왜막았을까?
			param += '&freq=' + freq;
			param += '&interval=' + interval;
			param += '&bymonthday=' + bymonthday;
			param += '&byday=' + byday;
			param += '&until=' + until;
		//}
		
		param += langKndList;
		param += nameList;
		if($nameList.length <= 0) param += '&name=' + enCal.m_encodeing(name);
		param += placeList;
		if($placeList.length <= 0) param += '&place=' + enCal.m_encodeing(place);
		param += commentsList;
		if($commentsList.length <= 0) param += '&comments=' + enCal.m_encodeing(comments);
//		param += scheduleUserId;
//		param += '&permissions=' + permissions;
//		param += '&isJointModified=' + enCal.m_isJointModified;
		if(!enCal.requiredParameter(param, 'schedule') || !enCal.validationDate()) return;
		if(!confirm(enCal.getMessage('hn.info.confirm.save'))) return;
		enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/saveSchedule.hanc", param, false, {
			success: function(data){
				if(cmd == 'MODIFY') enCal.m_selectedEvent.scheduleId = scheduleId;
				else {
					enCal.m_selectedEvent.scheduleId = data.Data;
					enCal.m_selectedEvent.id= 's_' + data.Data;
				}
				enCal.m_selectedEvent.calendarId = calendarId;
				enCal.m_selectedEvent.start = start.format("yyyy-MM-dd") + startTime;
				enCal.m_selectedEvent.end = end.format("yyyy-MM-dd") + endTime;
				enCal.m_selectedEvent.allDay = allday;
				enCal.m_selectedEvent.title = name;
				enCal.m_selectedEvent.place = place;
				enCal.m_selectedEvent.comments = comments;
				enCal.m_selectedEvent.borderColor = $('#' + calendarId + '_bgColor').val();
				enCal.m_selectedEvent.backgroundColor = $('#' + calendarId + '_bgColor').val();
				
				$('#calendar').fullCalendar('refetchEvents');
//				if(cmd == 'MODIFY') $('#calendar').fullCalendar( 'updateEvent', enCal.m_selectedEvent);
//				else $('#calendar').fullCalendar( 'renderEvent', enCal.m_selectedEvent, false);
				enCal.removePopups();
			}
		});
	},
	
	moveSchedule : function(calEvent) {
		var scheduleId = calEvent.scheduleId;
		var calendarId = $('#selectedCalendarId').val();
		var allday = $('#allday').is(':checked');
		var start = $('#start').datepicker("getDate");
		var startTime = allday ? '' : ' ' + $('#startTime').val();
		var end = $('#end').datepicker("getDate");
		var endTime = allday ? '' : ' ' + $('#endTime').val();
		
		var param = 'scheduleId=' + scheduleId;
		param += '&start=' + start.format("yyyy-MM-dd") + startTime;
		param += '&end=' + end.format("yyyy-MM-dd") + endTime;
		enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/moveSchedule.hanc", param, false, {
			success: function(data){
				enCal.m_selectedEvent.calendarId = calendarId;
				enCal.m_selectedEvent.start = start.format("yyyy-MM-dd");
				enCal.m_selectedEvent.startTime = startTime.trim();
				enCal.m_selectedEvent.end = end.format("yyyy-MM-dd");
				enCal.m_selectedEvent.endTime = endTime.trim();
				enCal.m_selectedEvent.allDay = allday;
				enCal.m_selectedEvent.title = name;
				enCal.m_selectedEvent.place = place;
				enCal.m_selectedEvent.comments = comments;
				enCal.m_selectedEvent.borderColor = $('#' + calendarId + '_bgColor').val();
				enCal.m_selectedEvent.backgroundColor = $('#' + calendarId + '_bgColor').val();
				$('#calendar').fullCalendar('updateEvent', enCal.m_selectedEvent);
				enCal.removePopups();
			}
		});
	},
	
	validationDate : function(){
		var isValid = true;
		var allday = $('#allday').is(':checked');
		var start = $('#start').datepicker("getDate").format("yyyyMMdd");
		var startTime = allday ? '0000' : $('#startTime > input').val().replace(":", "");
		var end = $('#end').datepicker("getDate").format("yyyyMMdd");
		var endTime = allday ? '0000' : $('#endTime > input').val().replace(":", "");
		if(parseInt(start + startTime) - parseInt(end + endTime) > 0) {
			var msgCd = 'hn.info.save.invaild.date';
			
			if(start == end) {
				if(startTime - endTime > 0) {
					msgCd = 'hn.info.save.invaild.time';
					alert(enCal.getMessage(msgCd));
					$('#endTime').click();
				}
			}
			else {
				alert(enCal.getMessage(msgCd));
				$('#end').focus();
			}
			isValid = false;
		}
		return isValid;
	},
	
	requiredParameter : function(param, type){
		var isPass = true;
		var params = param.split("&");
		for(var i = 0 ; i < params.length; i++){
			if(!isPass) break;
			var paramSet = params[i].split("=");
			var paramName = paramSet[0];
			var paramValue = paramSet[1];
			for(var j = 0 ; j < enCal.m_validateParams.length; j++){
				var validateParam = enCal.m_validateParams[j];
				if(paramName == validateParam){
					if(!paramValue || paramValue == null || paramValue.length <= 0){
						//alert('파라미터['+paramName+']의 값이 잘못 되었습니다.');
						enCal.alertRequiredResult(paramName, type);
						isPass = false;
						break;
					}
				}
			}
		}
		return isPass;
	},
	
	alertRequiredResult : function(paramName, type){
		var msgCd = 'hn.info.save.required.';
		if(type && type != null && type.length > 1) msgCd += type + '.';
		msgCd += paramName;
		alert(enCal.getMessage(msgCd));
		$('#' + paramName).focus();
	},
	getMessage : function() {
		var retMsg = null;
		var arr = arguments;
		if (arr != null && arr.length > 0) {
			if (!portalPage) {
				portalPage = new enview.portal.Page();
			}
			retMsg = portalPage.getMessageResource (arr[0]);
			if(retMsg == null) {
				alert(arr[0]);
				return "";
			}
			for (var i=0; i<arr.length; i++) {
				var pattern = "{" + i + "}";
				retMsg = retMsg.replace(pattern, arr[i+1]);
			}
		}
		return retMsg;
	},
	
	iCalendar : function(calendarId, action){
		var param = 'calendarId=' + calendarId;
		if(enCal.m_viewName != null ) param += '&viewName='+ enCal.m_viewName;
		param += '&skin=' + enCal.m_skin;
		param += '&action=' + action;
		enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/icalMenu.hanc", param, false, {
			success: function(data){
				enCal.removePopups();
				enCal.modalLayer();
				$(data).appendTo($("#wrap"));
				var calendarName = $('#' + calendarId + '_CalToggle').attr('title');

				$('#icalClose').click(function(event){
					enCal.removePopups();
				});
				
				$(document.body).bind('keyup bodyESC', function(event){
					var keyCode = event.keyCode;
					if(keyCode == 27) enCal.removePopups();
				});
				
				$('#icalMenu').bind('keyup icalMenuESC', function(event){
					var keyCode = event.keyCode;
					if(keyCode == 27) enCal.removePopups();
				});
				$('#icalMenuHeaderLabel').css('color', $('#' + calendarId + '_bgColor').val());
				$('.icsLink').text(calendarName);
				$('#icalMenu').offset( {top: $("#contentsArea").height()/2 - $('#icalMenu').height()/2, left: $("#contentsArea").width()/2 - $('#icalMenu').width()/2 + $('#contentsArea').offset().left/2 });
				$(document.body).focus();
			}
		});
	},
	
	exportICS : function(calendarId){
		var href = $('#icsExportLink').attr('url');
		var param = '?year=' + $('#icalYear').val();
		param += '&langKnd=' + $('#icalLangKnd').val();
		param += '&isUsers=' + $('#' + calendarId + '_isUsers').val();
		href += param;
		window.open(href, '_blank');
		enCal.removePopups();
	},
	
	checkeFileExtension : function(obj){
		var $fileInput = $(obj);
		var fileName = $fileInput.val();
		var pos = fileName.lastIndexOf(".");
		if(pos > 0 && fileName.length > 1){
			var extension = fileName.substring(pos+1, fileName.length);
			if(extension == 'ics') {
				pos = fileName.lastIndexOf("\\");
				$('#importFileName').val(fileName.substring(pos+1, fileName.length));
				enCal.importICS();
				return;
			}
		}
		alert(enCal.getMessage('hn.info.alert.file.extension.incorrect', extension, 'ics'));
	},
	
	importICS : function(){
		if(!confirm(enCal.getMessage('hn.info.confirm.upload', $('#importFileName').val()))) return;
		var calendarId = $('#icalCalendarId').val();
		$('#icsImportForm').ajaxForm({
			dataType: "text",
			success: function(){
				enCal.removePopups();
				$('#calendar').fullCalendar( 'refetchEvents' );
			}
		});
		
		$('#icsImportForm').submit();
	},
	
	autoResize : function() {
		if(parent.autoresize_iframe_portlets) parent.autoresize_iframe_portlets();
		else if(parent.snsUtil){
			if(parent.snsUtil.autoresize_iframe_portlets) parent.snsUtil.autoresize_iframe_portlets();
		}
	}
}

hancer.cal.calendarUser = function(userId) {
	this.m_userId = userId;
	this.m_permissions = $('#' + userId + '_permissions').val();
}

hancer.cal.calendarUser.prototype = {
	m_userId: null,
	m_userNm : null,
	m_permissions : null,
	
	setUserId : function(userId){
		this.m_userId = userId;
	},
	getUserId : function(){
		return this.m_userId;
	},
	setUserNm : function(userNm){
		this.m_userNm = userNm;
	},
	getUserNm : function(){
		return this.m_userNm;
	},
	setPermissions : function(permissions){
		this.m_permissions = permissions;
	},
	getPermissions : function(){
		return this.m_permissions;
	},
	toString : function(){
		return this.m_userId + ':' + this.m_permissions;
	}
}

hancer.cal.scheduleUser = function() {
}

hancer.cal.scheduleUser.prototype = {
	m_userId: null,
	m_userNm : null,
	
	setUserId : function(userId){
		this.m_userId = userId;
	},
	getUserId : function(){
		return this.m_userId;
	},
	setUserNm : function(userNm){
		this.m_userNm = userNm;
	},
	getUserNm : function(){
		return this.m_userNm;
	},
	toString : function(){
		return this.m_userId;
	}
}

var enCal = new hancer.cal();

$(document).ready(function(){
	enCal.init();
});
