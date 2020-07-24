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
	this.m_encodeingCallback = encodeURIComponent;
}

hancer.cal.prototype = {
	m_contextPath : null,
	m_ajax : null,
	m_calendars : [],
	m_calendarIds : [],
	m_calendar : null,
	
	m_schedules : [],
	m_start: null,
	m_end: null,
	
	m_selectedEvent : null,
	
	m_scheduleUsers : [],
	m_calendarUsers : [],
	
	m_encodeingCallback : null,
	
	init : function () {
		if(!document.getElementById('calendar')) return;
		this.m_calendarIds = [];
		this.m_calendars = [];
		this.m_schedules = [];
	},
	
	initEventHandlers : function (){
		if(!document.getElementById('calendar')) return;
		
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
				enCal.renderEvents(calendarId);
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
					alert(data.Reason + '\n잠시 후에 다시 시도 해주십시오.');
				}
			});
		});
		
		
		$('.calendarPopupButton').click(function(event){
			event.stopPropagation();
			enCal.removePopups();
			var $this = $(this);
			var param = 'calendarId=' + $this.attr('calendarId');
			param += '&isOwner=' + $this.attr('isOwner');
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
					alert(data.Reason + '\n잠시 후에 다시 시도 해주십시오.');
				}
			});
		});
	},
	
	initPopupEventHandlers : function (calendarId){
		
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
	},
	
	changeUserCalendarColor : function(calendarId, selectedColor){
		var isOwner = $('#' + calendarId + '_isOwner').val();
		var param = 'calendarId=' + calendarId;
		param += '&isOwner=' + isOwner;
		param += '&bgColor=' + selectedColor;
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
				alert(data.Reason + '\n잠시 후에 다시 시도 해주십시오.');
			}
		});
	},
	
	showOrHideCalendarList: function(objId){
		var $btn = $('#' + objId + 'CaratButton');
		if($btn.hasClass('ui-icon-carat-1-s')){
			$btn.removeClass('ui-icon-carat-1-s');
			$btn.addClass('ui-icon-carat-1-e');
			$('#' + objId +'List').css('display', 'none');
		} else {
			$btn.removeClass('ui-icon-carat-1-e');
			$btn.addClass('ui-icon-carat-1-s');
			$('#' + objId +'List').css('display', 'block');
		}
	},
	
	renderEvents : function(calendarId){
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
		this.m_ajax.send("POST", enCal.m_contextPath + "/calendar/scheduleList.hanc", param, false, {
			success: function(data){
				for(var i = 0 ; i <data.Data.length ; i++){
					var event = data.Data[i];
					enCal.m_schedules.push(event);
					$('#calendar').fullCalendar( 'renderEvent', event, false);
				}
				$('input[name=' + calendarId + '_selected]').val(1);
				enCal.removePopups();
			},
			error: function(data, e){
				alert(data.Reason + '\n잠시 후에 다시 시도 해주십시오.');
			}
		});
	},
	
	removeEvents : function(calendarId){
		for(var i = 0 ; i < this.m_schedules.length ; i++){
			var calId = this.m_schedules[i].calendarId;
			if(calId == calendarId){
				var scheduleId = this.m_schedules[i].scheduleId;
				$('#calendar').fullCalendar( 'removeEvents', 's_' + scheduleId);
			}
		}
		$('input[name=' + calendarId + '_selected]').val(0);
		enCal.removePopups();
	},
	
	initCalendar : function(){
		if(!document.getElementById('calendar')) return;
		
		$('input[name=calendarId]').each(function(index){
			var $this = $(this);
			enCal.m_calendarIds[index] = $this.val();
		});
		
		$('#calendar').fullCalendar({
			editable: true,
			events : function(start, end, callback) {
				enCal.m_start = start.format("yyyy-MM-dd");
				enCal.m_end = end.format("yyyy-MM-dd");
				for(var i = 0 ; i < enCal.m_calendarIds.length ; i++){
					var selected = $('input[name=' + enCal.m_calendarIds[i] + '_selected]').val();
					if(selected == 1) {
						enCal.renderEvents(enCal.m_calendarIds[i]);
					}
				}
				enCal.removePopups();
	    	},
	    	dayClick : function( date, allDay, jsEvent, view ){
	    		if (allDay) {
	    			var param = 'start=' + date.format("yyyy-MM-dd");
	    			param += '&end=' + date.format("yyyy-MM-dd");
	    			param += '&cmd=WRITE';
	    			enCal.showScheduleDetail(new Object(), param);
	    		}
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
	    		enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/schedule.hanc", param, false, {
	    			success: function(data){
	    				enCal.removePopups();
						$(data).appendTo($(document.body));
						
						var top = $this.offset().top;
						var left = jsEvent.pageX;
						if(left <= 363.5) left = 183.5;
						else if(363.5 < left && left < 758.5) left -= $('#schedulePops').width()/2 + 4;
						else if(left >= 758.5) left = 580;
						
						if(top < 280) {
							top += $this.height() + 7;
							$('#triangleBottom').remove();
						}else {
							top -= $('#schedulePops').height() + 6;
							$('#triangleTop').remove();
						}
						
						if(jsEvent.pageX <= 295) $('.triangle').offset( { left: 20 });
						else if(295 < jsEvent.pageX && jsEvent.pageX <= 854) $('.triangle').offset( { left: jsEvent.pageX - left - 7.5 });
						else if(854 < jsEvent.pageX) $('.triangle').offset( { left: $('#schedulePops').width() - 30});
						$('#schedulePops').offset( { top: top, left: left } );
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
	    		//alert('event=['+event.title+']\ndayDelta=['+dayDelta+']\nminuteDelta=['+minuteDelta+']\nallDay=['+allDay+']\nrevertFunc=['+revertFunc+']\nui=['+ui+']\nview=['+view+']');
	    		var scheduleId = event.scheduleId;
	    		var start = event.start;
	    		var startTime = allDay ? '' : event.startTime;
	    		var end = event.end;
	    		var endTime = allDay ? '' : event.endTime;
	    		
	    		var param = 'scheduleId=' + scheduleId;
	    		param += '&start=' + start.format("yyyy-MM-dd") + ' ' + startTime;
	    		if(end) param += '&end=' + end.format("yyyy-MM-dd") + ' ' + endTime;
	    		else param += '&end=' + start.format("yyyy-MM-dd") + ' ' + endTime;
	    		enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/moveSchedule.hanc", param, false, {
	    			success: function(data){
//	    				$('#calendar').fullCalendar('updateEvent', event);
	    			}
	    		});
	    	},
	    	eventResize : function( event, dayDelta, minuteDelta, revertFunc, jsEvent, ui, view ) { 
	    		//alert('event=['+event.title+']\ndayDelta=['+dayDelta+']\nminuteDelta=['+minuteDelta+']\nrevertFunc=['+revertFunc+']\nui=['+ui+']\nview=['+view+']');
	    		var scheduleId = event.scheduleId;
	    		var start = event.start;
	    		var startTime = event.startTime;
	    		var end = event.end;
	    		var endTime = event.endTime;

	    		var param = 'scheduleId=' + scheduleId;
	    		param += '&start=' + start.format("yyyy-MM-dd") + ' ' + startTime;
	    		if(end) param += '&end=' + end.format("yyyy-MM-dd") + ' ' + endTime;
	    		else param += '&end=' + start.format("yyyy-MM-dd") + ' ' + endTime;
	    		enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/resizeSchedule.hanc", param, false, {
	    			success: function(data){
//	    				$('#calendar').fullCalendar('updateEvent', event);
	    			}
	    		});
	    	}
		});
	},
	
	showCalendarDetail : function(cmd, calendarId) {
		var param = 'cmd=' + cmd;
		if(calendarId) param += '&calendarId=' + calendarId;
		param += '&isOwner=' + $('#' + calendarId + '_isOwner').val();
		param += '&isDefault=' + $('#' + calendarId + '_isDefault').val();
		param += '&isPublic=' + $('#' + calendarId + '_isPublic').val();
		this.m_ajax.send("POST", enCal.m_contextPath + "/calendar/calendarDetail.hanc", param, false, {
			success: function(data){
				enCal.removePopups();
				enCal.modalLayer();
				$(data).appendTo($(document.body));
				$('#calendarDetails').css('z-index', 3000);
				$('#calendarDetails').offset( {top: $(document.body).height()/2 - $('#calendarDetails').height()/2, left: $(document.body).width()/2 - $('#calendarDetails').width()/2 });
				
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
							alert('검색어를 2글자 이상 입력해주세요.');
						}
					}
				});
				$('#searchUserButton').bind('click searchUserButtonClick', function(event){
					if($('#searchUser').val().length > 1) {
						enCal.searchUser('searchUser', 'PANEL', enCal.addCalendarUser);
					} else {
						alert('검색어를 2글자 이상 입력해주세요.');
					}
				});
				
				$('#calendarDetails').focus();
				$("#calendarDetails").draggable({ containment: "parent" });
				
				$('.calendarUser').filter(':not(:first)').each(function(idx){
					var $this = $(this);
					var user = new hancer.cal.calendarUser($this.attr('userId'));
					user.setUserNm($this.attr('userName'));
					enCal.m_calendarUsers.push(user);
				});
			}
		});
	},
	
	addCalendarUser : function(userId, userName){
		var isOverrap = false;
		for(var i = 0 ; i < enCal.m_calendarUsers.length; i++){
			if(enCal.m_calendarUsers[i].getUserId() == userId) {
				isOverrap = true;
				break;
			}
		}
		if(isOverrap) return;
		var addUser = $('<div userId="'+userId+'" class="calendarUser"><div class="name" title="'+ userName + '('+ userId +')">'+userName + '('+ userId +')</div><select id="'+userId+'_permissions" name="'+userId+'_permissions" onchange="enCal.onchangePermissions(\'' + userId + '\')"><option value="CRUDA">일정 및 공유 관리</option><option value="RU">일정 변경</option><option value="R" selected="selected">일정 보기</option></select><span class="deleteUser ui-icon ui-icon-trash" onclick="enCal.deleteCalendarUser(this);"></span></div>');
		addUser.appendTo($('#attends'));
		var user = new hancer.cal.calendarUser(userId);
		user.setUserNm(userName);
		enCal.m_calendarUsers.push(user);
		$('#searchUserList').remove();
	},
	
	onchangePermissions : function(userId){
		var permissions = $('#' + userId + '_permissions').val();
		for(var i = 0 ; i < enCal.m_calendarUsers.length; i++){
			if(enCal.m_calendarUsers[i].getUserId() == userId) {
				enCal.m_calendarUsers[i].setPermissions(permissions);
				break;
			}
		}
		
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
	},
	
	saveCalendar : function(calendarId){
		if(!confirm("변경 사항을 저장하시겠습니까?")) return;
		
		var $nameList = $('input[name="nameList"]');
		var nameList = '';
		var langKndList = '';
		var name = $('#name').val();
		if($nameList.length > 0){
			$nameList.each(function(){
				var $this = $(this);
				langKndList += '&langKndList=' + $this.attr('langKnd');
				nameList += '&nameList=' + $this.val();
				if( $this.attr('langKnd') == $('#langKnd').val()) name = $this.val();
			});
		}
		
		var $commentsList = $('textarea[name="commentsList"]');
		var commentsList = '';
		if($commentsList.length > 0){
			$commentsList.each(function(){
				var $this = $(this);
				commentsList += '&commentsList=' + $this.val();
			});
		}
		var comments = $('#calendarComments').text();
		
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
			param += '&calendarId=' + calendarId;
			param += '&isPublic=' + isPublic;
		}else {
			param += '&isPublic=N';
		}
		param += langKndList;
		param += nameList;
		param += '&name=' + name;
		param += commentsList;
		param += '&comments=' + comments;
		param += calendarUserId;
		param += permissions;
		enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/saveCalendar.hanc", param, false, {
			success: function(data){
				if(cmd == 'MODIFY') {
					$('#' + calendarId + '_CalToggle > div.calendarName').text(name);
					enCal.removePopups();
				} else {
					window.location.reload();
				}
			}
		});
	},
	
	deleteCalendar : function(calendarId) {
		if(!confirm("캘린더를 삭제하면 복구할 수 없습니다.\n이 캘린더를 지우시겠습니까?")) return;
		var isOwner = $('#' + calendarId + '_isOwner').val();
		var isDefault = $('#' + calendarId + '_isDefault').val();
		var param = 'calendarId=' + calendarId;
		param += '&isOwner=' + isOwner;
		param += '&isDefault=' + isDefault;
		enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/deleteCalendar.hanc", param, false, {
			success: function(data){
				window.location.reload();
			}
		});
	},
	
	goCalendar : function(){
		window.location.href = this.m_contextPath + "/calendar/calendar.hanc";
	},
	
	searchUser : function(searchFieldId, cmd, selectCallback){
		var searchField = $('#' + searchFieldId);
		var searchUser = searchField.val();
		if(searchUser != null || searchUser != ''){
			var param = 'searchUser=' + searchUser;
			param += "&cmd=PANEL";
			this.m_ajax.send("POST", enCal.m_contextPath + "/calendar/searchUser.hanc", param, false, {
				success: function(data){
					$('#searchUserList').remove();
					$(data).appendTo(searchField.parent().parent());
					$('#searchUserList').offset( { top: searchField.offset().top - $('#searchUserList').height() - 7, left: searchField.offset().left } );

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
							selectCallback($this.attr('userId'), $this.attr('userName'));
						});
					}
				}
			});
		} else {
			alert('사용자 아이디 혹은 이름을 입력하세요.');
			$('#searchUser').select();
		}
	},
	
	renderOnlyThis : function(calendarId){
		$('#calendar').fullCalendar( 'removeEvents');
		$('.calendarBgColor').css('border-color', 'gray');
		$('.calendarBgColor').css('background-color', 'rgba(0, 0, 0, 0)');
		$("input[name$='_selected']").val(0);
		this.renderEvents(calendarId);
		var orgBgColor = $('#' + calendarId + '_bgColor').val();
		$('#' + calendarId + '_calendarBgColor').css('border-color', orgBgColor);
		$('#' + calendarId + '_calendarBgColor').css('background-color', orgBgColor);
	},
	
	modalLayer : function(){
		var layer = $('<div id="modalLayer" class="modalLayer"></div>');
		layer.width($(document.body).width());
		layer.height($(document.body).height());
		layer.appendTo($(document.body));
	},
	
	removePopups : function(){
		enCal.m_selectedEvent = null;
		enCal.m_scheduleUsers = [];
		enCal.m_calendarUsers = [];
		$('#schedulePops').remove();
		$('#scheduleDetails').remove();
		$('#calendarPopup').remove();
		$('#calendarDetails').remove();
		$('#modalLayer').remove();
	},
	
	modifySchedule : function(){
		var calEvent = enCal.m_selectedEvent;
		var scheduleId = calEvent.scheduleId;
		var calendarId = calEvent.calendarId;
		var isOwner = $('#detail_isOwner').val();
		var isDefault = $('#detail_isDefault').val();
		var isJointSchedule = calEvent.isJoint;
		var isPublic = $('#' + calendarId  + '_isPublic').val();
		var param = 'scheduleId=' + scheduleId;
		param += '&calendarId=' + calendarId;
		param += '&isOwner=' + isOwner;
		param += '&isDefault=' + isDefault;
		param += '&isJointSchedule=' + isJointSchedule;
		param += '&cmd=MODIFY'; 
		param += '&isPublic=' + isPublic;
		enCal.showScheduleDetail(calEvent, param);
	},
	
	addScheduleUser : function(userId, userName){
		var isOverrap = false;
		for(var i = 0 ; i < enCal.m_scheduleUsers.length; i++){
			if(enCal.m_scheduleUsers[i].getUserId() == userId) {
				isOverrap = true;
				break;
			}
		}
		if(isOverrap) return;
		var user = new hancer.cal.scheduleUser();
		user.setUserId(userId);
		user.setUserNm(userName);
		enCal.m_scheduleUsers.push(user);
		var addUser = $('<div userId="'+userId+'" class="scheduleUser"><div class="name" title="'+ userName + '(' + userId +')">'+userName + '(' + userId +')</div><span class="deleteUser ui-icon ui-icon-trash" onclick="enCal.deleteUser(this);"></span></div>');
		addUser.appendTo($('#attends'));
		$('#searchUserList').remove();
	},
	
	showScheduleDetailForCalendar : function(calendarId){
		var date = new Date().format("yyyy-MM-dd HH:mm:ss");
		var isPublic = $('#' + calendarId + '_isPublic').val();
		var param = 'start=' + date;
		param += '&end=' + date;
		param += '&cmd=WRITE';
		param += '&calendarId=' + calendarId;
		param += '&isPublic=' + isPublic;
		enCal.showScheduleDetail(new Object(), param);
	},
	
	showScheduleDetail : function(calEvent, param) {
		enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/scheduleDetail.hanc", param, false, {
			success: function(data){
				enCal.removePopups();
				enCal.modalLayer();
				$(data).appendTo($(document.body));
				$('#scheduleDetails').css('z-index', 3000);
				$('#scheduleDetails').offset( {top: $(document.body).height()/2 - $('#scheduleDetails').height()/2, left: $(document.body).width()/2 - $('#scheduleDetails').width()/2 });
				
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

				if($('#' + $('#prevCalendarId').val()  + '_isPublic').val() == 'N'){
					$('#searchUser').bind('keyup searchUserEnter', function(event){
						var keyCode = event.keyCode;
						if(keyCode == 13){
							if($('#searchUser').val().length > 1) {
								enCal.searchUser('searchUser', 'PANEL', enCal.addScheduleUser);
							} else{
								alert('검색어를 2글자 이상 입력해주세요.');
							}
						}
					});
					$('#searchUserButton').bind('click searchUserButtonClick', function(event){
						if($('#searchUser').val().length > 1) {
							enCal.searchUser('searchUser', 'PANEL', enCal.addScheduleUser);
						} else {
							alert('검색어를 2글자 이상 입력해주세요.');
						}
					});
					
					$('#permissionU').bind('change permissionUChange', function(event){
						if($('#permissionU').is(':checked')){
							$('#permissionA').prop('checked', 'checked');
							$('#permissionA').prop('disabled', 'disabled');
							$('#permissionR').prop('checked', 'checked');
							$('#permissionR').prop('disabled', 'disabled');
						} else {
							$('#permissionA').prop('disabled', '');
							$('#permissionR').prop('disabled', '');
						}
					});
				}
				
				$('#scheduleDetails').focus();
				
				$('#start').datepicker({ dateFormat: "yy.mm.dd" });
				$('#end').datepicker({ dateFormat: "yy.mm.dd" });
				
				if($('#allday').is(':checked')){
					$('.dateTime').css('display', 'none');
				}
				
				$('#allday').change(function(event){
					var allday = $('#allday').is(':checked');
					if(allday) {
						$('.dateTime').css('display', 'none');
					} else {
						$('.dateTime').css('display', 'inline-block');
					}
				});
				
				enCal.m_selectedEvent = calEvent;
				$("#scheduleDetails").draggable({ containment: "parent" });
				
				$('.scheduleUser').filter(':not(:first)').each(function(idx){
					var $this = $(this);
					var user = new hancer.cal.scheduleUser();
					user.setUserId($this.attr('userId'));
					enCal.m_scheduleUsers.push(user);
				});
				
				$('#selectedCalendarId').change(function(event){
					$this = $(this);
					var isPublic = $('#' + $this.val()  + '_isPublic').val();
					var originIsPublic = $('#' + $('#prevCalendarId').val()  + '_isPublic').val();
					$('#prevCalendarId').val($this.val());
					if(isPublic != originIsPublic) {
						var scheduleId = calEvent ? calEvent.scheduleId : 0;
						var calendarId = $('#selectedCalendarId').val();
						var isOwner = $('#' + calendarId + '_isOwner').val();
						var isDefault = $('#' + calendarId + '_isDefault').val();
						var isJointSchedule = calEvent.isJoint;
						var cmd = $('#cmd').val();
						var isPublic = $('#' + calendarId  + '_isPublic').val();
						var param = 'scheduleId=' + scheduleId;
						param += '&calendarId=' + calendarId;
						param += '&isOwner=' + isOwner;
						param += '&isDefault=' + isDefault;
						param += '&isJointSchedule=' + isJointSchedule;
						param += '&cmd=' + cmd; 
						param += '&isPublic=' + isPublic;
					
						enCal.removePopups();
						enCal.showScheduleDetail(calEvent, param);
					}
				});
			}
		});
	},
	
	deleteUser: function(obj){
		$this = $(obj);
		var deleteUser = $this.parent();
		for(var i = 0 ; i < enCal.m_scheduleUsers.length; i++){
			if(enCal.m_scheduleUsers[i].getUserId() == deleteUser.attr('userId')) {
				enCal.m_scheduleUsers.splice(i, 1);
				break;
			}
		}
		deleteUser.remove();
	},
	
	deleteSchedule : function(){
		if(!confirm("정말 삭제하시겠습니까?")) return;
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
		if(!confirm("변경 사항을 저장하시겠습니까?")) return;
		var calEvent = enCal.m_selectedEvent;
		var scheduleId = calEvent ? calEvent.scheduleId : 0;
		var calendarId = $('#selectedCalendarId').val();
		var allday = $('#allday').is(':checked');
		var start = $('#start').datepicker("getDate");
		var startTime = allday ? '' : $('#startTime').val();
		var end = $('#end').datepicker("getDate");
		var endTime = allday ? '' : $('#endTime').val();
		
		var $nameList = $('input[name="nameList"]');
		var nameList = '';
		var langKndList = '';
		var name = $('#name').val();
		if($nameList.length > 0){
			$nameList.each(function(idx){
				var $this = $(this);
				langKndList += '&langKndList=' + $this.attr('langKnd');
				nameList += '&nameList=' + enCal.m_encodeingCallback($this.val());
				if( $this.attr('langKnd') == $('#langKnd').val()) name = $this.val();
				
			});
		}
		
		var $placeList = $('input[name="placeList"]');
		var placeList = '';
		if($placeList.length > 0){
			$placeList.each(function(){
				var $this = $(this);
				placeList += '&placeList=' + enCal.m_encodeingCallback($this.val());
			});
		}
		var place = $('#schedulePlace').val();
		
		var $commentsList = $('textarea[name="commentsList"]');
		var commentsList = '';
		if($commentsList.length > 0){
			$commentsList.each(function(){
				var $this = $(this);
				commentsList += '&commentsList=' + enCal.m_encodeingCallback($this.val());
			});
		}
		var comments = $('#scheduleComments').val();
		
		
		var scheduleUserId = ''; 
		for(var i=0 ; enCal.m_scheduleUsers.length; i++){
			var user = enCal.m_scheduleUsers.pop();
			scheduleUserId += '&scheduleUserId=' + user.getUserId();
		}
		
		var permissionU = $('#permissionU').is(':checked') ? 'U' : '';
		var permissionA = $('#permissionA').is(':checked') ? 'A' : '';
		var permissionR = $('#permissionR').is(':checked') ? 'R' : '';
		var permissions = permissionU + permissionA + permissionR;
		
		var isPublic = $('#' + calendarId + '_isPublic').val();
		var cmd = $('#cmd').val();
		var param = 'cmd=' + cmd;
		param += '&calendarId=' + calendarId;
		param += '&isPublic=' + isPublic;
		if(cmd == 'MODIFY') param += '&scheduleId=' + scheduleId;
		param += '&start=' + start.format("yyyy-MM-dd") + ' ' + startTime;
		param += '&end=' + end.format("yyyy-MM-dd") + ' ' + endTime ;
		param += '&allday=' + (allday ? 1:0);
		param += langKndList;
		param += nameList;
		if($nameList.length <= 0) param += '&name=' + enCal.m_encodeingCallback(name);
		param += placeList;
		if($placeList.length <= 0) param += '&place=' + enCal.m_encodeingCallback(place);
		param += commentsList;
		if($commentsList.length <= 0) param += '&comments=' + enCal.m_encodeingCallback(comments);
		param += scheduleUserId;
		param += '&permissions=' + permissions;

		enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/saveSchedule.hanc", param, false, {
			success: function(data){
				if(cmd == 'MODIFY') enCal.m_selectedEvent.scheduleId = scheduleId;
				else {
					enCal.m_selectedEvent.scheduleId = data.Data;
					enCal.m_selectedEvent.id= 's_' + data.Data;
				}
				enCal.m_selectedEvent.calendarId = calendarId;
				enCal.m_selectedEvent.start = start.format("yyyy-MM-dd");
				enCal.m_selectedEvent.startTime = startTime;
				enCal.m_selectedEvent.end = end.format("yyyy-MM-dd");
				enCal.m_selectedEvent.endTime = endTime;
				enCal.m_selectedEvent.allDay = allday;
				enCal.m_selectedEvent.title = name;
				enCal.m_selectedEvent.place = place;
				enCal.m_selectedEvent.comments = comments;
				enCal.m_selectedEvent.borderColor = $('#' + calendarId + '_bgColor').val();
				enCal.m_selectedEvent.backgroundColor = $('#' + calendarId + '_bgColor').val();
				enCal.removeEvents(calendarId);
				enCal.renderEvents(calendarId);
				enCal.removePopups();
			}
		});
	},
	
	moveSchedule : function(calEvent) {
		var scheduleId = calEvent.scheduleId;
		var calendarId = $('#selectedCalendarId').val();
		var allday = $('#allday').is(':checked');
		var start = $('#start').datepicker("getDate");
		var startTime = allday ? '' : $('#startTime').val();
		var end = $('#end').datepicker("getDate");
		var endTime = allday ? '' : $('#endTime').val();
		
		var param = 'scheduleId=' + scheduleId;
		param += '&start=' + start.format("yyyy-MM-dd") + ' ' + startTime;
		param += '&end=' + end.format("yyyy-MM-dd") + ' ' + endTime ;
		enCal.m_ajax.send("POST", enCal.m_contextPath + "/calendar/moveSchedule.hanc", param, false, {
			success: function(data){
				enCal.m_selectedEvent.calendarId = calendarId;
				enCal.m_selectedEvent.start = start.format("yyyy-MM-dd");
				enCal.m_selectedEvent.startTime = startTime;
				enCal.m_selectedEvent.end = end.format("yyyy-MM-dd");
				enCal.m_selectedEvent.endTime = endTime;
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
	enCal.initEventHandlers();
	enCal.initCalendar();
});
