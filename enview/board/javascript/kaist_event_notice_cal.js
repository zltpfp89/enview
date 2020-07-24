enBoardCalendar = new Object();
enBoardCalendar = function (){
	this.m_ajax = new enview.util.Ajax();
	this.m_contextPath = '';
}

enBoardCalendar.prototype = {
	m_ajax: null,
	
	m_start : new Date().format('yyyy-MM-dd'),
	m_end : new Date().format('yyyy-MM-dd'),
	
	onedayList: function(start, end){
		var param = 'boardId=' + document.setForm.boardId.value;
		param += '&start=' + start.format("yyyy-MM-dd");
		param += '&end=' + end.format("yyyy-MM-dd");
		param += '&dummy=' + Math.random()*1000;
		param += '&__ajax_call__=true';
		enBCal.m_ajax.send("POST", enBCal.m_contextPath + '/board/onedayScheduleList.brd', param, false, {
			success: function(data){
				$('#onedayList').html(data);
				parent.autoresize_iframe_portlets();
			},
			error: function(data, e){
				alert(data.Reason + '\n잠시 후에 다시 시도 해주십시오.');
			}
		});
	},
	
	init : function() {
		var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
	
	    $('#calendar').fullCalendar({
			timeFormat: {
				'': 'hh:mmt' //event time setting
			},
	    	selectable: true,
			selectHelper: true,
			select: function(start, end, allDay) {
				enBCal.onedayList(start, end);
			},
			editable: false,
	        events : function(start, end, callback) {
	        	enBCal.m_start = start.format("yyyy-MM-dd");
	        	enBCal.m_end = end.format("yyyy-MM-dd");
	        	var param = 'boardId=' + document.setForm.boardId.value;
	    		param += '&start=' + start.format("yyyy-MM-dd");
	    		param += '&end=' + end.format("yyyy-MM-dd");
	    		param += '&dummy=' + Math.random()*1000;
	    		param += '&__ajax_call__=true';
	    		enBCal.m_ajax.send("POST", enBCal.m_contextPath + '/board/scheduleList.brd', param, false, {
	    			success: function(data){
	    				for(var i = 0 ; i <data.Data.length ; i++){
	    					var event = data.Data[i];
	    					$('#calendar').fullCalendar( 'renderEvent', event, false);
	    				}
	    			},
	    			error: function(data, e){
	    				alert(data.Reason + '\n잠시 후에 다시 시도 해주십시오.');
	    			}
	    		});
	    	},
	        eventClick : function(event, jsEvent, view) {
	        	ebList.readBulletin(event.calendarId, event.scheduleId);
	        }
	    });
	    this.onedayList(new Date(), new Date());
	},
	
	changeViewMode : function(viewMode){
		$('#viewMode').val(viewMode);
		if(document.setForm.start.value == '') document.setForm.start.value = enBCal.m_start;
		if(document.setForm.end.value == '') document.setForm.end.value = enBCal.m_end;	
		document.setForm.method = "post";
		document.setForm.action = "list.brd";		
		document.setForm.submit();
	}
}

function errorControl(x, e){
	if(x.status==0){
		alert('You are offline!!\n Please Check Your Network.');
		}else if(x.status==404){
		alert('Requested URL not found.');
		}else if(x.status==500){
		alert('Internel Server Error.');
		}else if(e=='parsererror'){
		alert('Error.\nParsing JSON Request failed.');
		}else if(e=='timeout'){
		alert('Request Time out.');
		}else {
		alert('Unknow Error.\n'+x.responseText);
		}
}

var enBCal = new enBoardCalendar();

$(document).ready(function() {
	enBCal.init();
});