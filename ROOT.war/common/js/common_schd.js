
<!--
if( ! window.common )
    window.common = new Object();

common.schd = function() {
	this.isMobile = false;
};

common.schd.prototype = {
	isMobile : false,	
	initCalendar : function( isMobile) {
		if( isMobile!=null) {
			commonSchd.isMobile = isMobile;
		}
		
		var header = {};
		if( commonSchd.isMobile) {
			header= { left: '', center: 'prev title next', right: '' };
		} else {
			header= { left: 'today', center: 'prev title next', right: 'month agendaWeek agendaDay' };
		}
			
		$("#calendar").fullCalendar( {
			// display
			defaultView: 'month',
			aspectRatio: 1.35,
			header: header,
			weekends: true,
			weekNumbers: false,
			weekNumberCalculation: 'iso',
			weekNumberTitle: 'W',
			weekMode : 'variable',
//			contentHeight: 'auto',
			
			allDayDefault: true,
			ignoreTimezone: true,
			
			// event ajax
//			lazyFetching: true,
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
			timeFormat: {'': 'HH:mm'},
			
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
			editable : false,
			
			events : function(start, end, callback) {
				var sf = start.format("yyyyMMdd");
				var ef = end.format("yyyyMMdd");
				var schdClsf = $("#schdList_schdClsf").val();
//				var params = "start=" + sf + "&end=" + ef + "&schdClsf=" + schdClsf;
//				alert( params);
				var params = {"start" :  sf,"end" : ef, "schdClsf" : schdClsf};
				$.ajax( {
					url : '/schd/selectEventList.common',
					type : "post",
					data : params,
					success : function( data) {
						callback( data);
					},
					error : function ( xhr, status, error) {
						alert('데이터 전송오류 ' + status + ", " + error );
					}
				});
			},
			
			/*
			events : 
				[
					{
						title: '종일 일정',
						start: '2016-01-01'
					},
					{
						title: '긴 일정',
						start: '2016-01-07',
						end: '2016-01-10',
						color : 'red'
					},
					{
						title: '회의',
						start: '2016-01-11',
						end: '2016-01-13'
						, color : 'blue'
					},
					{
						title: '미팅',
						start: '2016-01-12 10:30:00.0',
						end: '2016-01-12 12:30:00.0',
						allDay : false
						, color : 'green'
					},
					{
						title: '점심약속',
						start: '2016-01-12 12:00:00',
						allDay : false
					},
					{
						title: '업무회의',
						start: '2016-01-12 14:30:00',
						allDay : false
					},
					{
						title: '여가 활동',
						start: '2016-01-12 17:30:00',
						allDay : false
					},
					{
						title: '저녁식사',
						start: '2016-01-12 20:00:00',
						allDay : false
					},
					{
						title: '생일파티',
						start: '2016-01-13 07:00:00',
						allDay : false
					},
					{
						title: '구글 바로가기',
						url: 'http://google.com/',
						start: '2016-01-28',
						allDay : false
					}
				]
			,
			*/
			dayClick : function( date,  jsEvent, view ){
				if( isMobile) {
		    		var s = date.format('yyyy.MM.dd');;
		    		$("#calendar").fullCalendar( "changeView", "agendaDay");
		    		commonSchd.gotoDate( s);
					
				} else {
					var today = new Date();
		    		var s = date.format('yyyyMMdd') + today.format("HHmm");
		    		var e = date.format('yyyyMMdd') + '180000';
		    		commonSchd.showSchedule( '', 'edit', s, e);
					/*
		    		var s = date.format('yyyyMMdd') + '090000';
		    		var e = date.format('yyyyMMdd') + '100000';
		    		commonSchd.showSchedule( '', 'edit', s, e);
		    		*/
					
					/*
					var today = new Date();
					var t = today.format("yyyyMMdd");
					var d = date.format('yyyyMMdd');
					if( d >= t) {
			    		var s = today.format("yyyyMMddHHmm");
			    		var e = d + '180000';
			    		commonSchd.showSchedule( '', 'edit', s, e);	    		
					} else {
			    		var s = d + '090000';
			    		var e = today.format('yyyyMMddHHmm');
			    		commonSchd.showSchedule( '', 'edit', s, e);	    		
					}
					*/
				}
	    	},
	    	eventClick : function(calEvent, jsEvent, view){
	    		// 0 이면 회신기안
	    		if( calEvent.id > '0') {
	    			commonSchd.showSchedule( calEvent.id);
	    		}
	    	}
			
		});
	},
	
	refreshCalendar : function() {
		// fullCalendar 다시읽기
		if( $("#calendar").attr('id')!=null) {
			$("#calendar").fullCalendar( 'refetchEvents');
		}
		
		// 미니 Calendar 다시읽기
		if( typeof fn_refreshMiniCalendar == 'function' ) {
			fn_refreshMiniCalendar();
		}
	},				

	gotoDate : function( date) {
		var y = date.substring( 0, 4);
		var m = date.substring( 5, 7);
		var d = date.substring( 8, 10);
		m = m - 1;
		$("#calendar").fullCalendar( "gotoDate", y, m, d);
		
	},				
	
	showSchedule : function( schdId, mode, schdStrtDt, schdEndDt) {
		if( schdId=='0') {
			// 기안회신인경우 아무일도 안함
			return;
		}
		if( mode==null) {
			mode='view';
		}
		var formData = { schdId : schdId, mode : mode};
		if( schdStrtDt!=null) {
			formData.schdStrtDt = schdStrtDt;
		}
		if( schdEndDt!=null) {
			formData.schdEndDt = schdEndDt;
		}
		
		$.ajax( {
			url : '/schd/selectScheduleDetail.common',
			type : "post",
			data : formData,
			success : function( data) {
				if( mode=='view') {
					commonSchd.makeDiv('schdPopup');
					$("#schdPopup").html( data);
					var schdEditable = $("#schdDetail_schdEditable").attr("value");
					var buttons = {};
					if( schdEditable=='true') {
						buttons =  [ { text : "수정",  class:"btn_black" ,	click: function() { commonSchd.showSchedule( schdId, 'edit');}},
						             { text : "삭제",  class:"btn_orange",  click: function() { commonSchd.deleteSchedule( schdId);}},
						             { text : "닫기",  class:"btn_black",	click: function() { $("#schdPopup").dialog("close");}}];
					} else {
						buttons =  [ { text : "닫기",  class:"btn_black",	click: function() { $("#schdPopup").dialog("close");}}];
					}
					if( commonSchd.isMobile) {
						$("#schdList").hide();
						$("#schdPopup").show();
						$(".btnSchdList").click( function() {
							$("#schdList").show();
							$("#schdPopup").hide();
						});
					} else {
						$("#schdPopup").dialog({
							  title : "일정",
							  width:600,
							  height:650,
							  modal : true,
							  buttons : buttons
					    });
						
					}
				} else {
					$("#schdPopup").dialog("close");
											
					commonSchd.makeDiv('schdEditPopup');
					$("#schdEditPopup").html( data);
					var schdEditable = $("#schdDetail_schdEditable").attr("value");
					var buttons = {};
					if( schdId == '' ||  schdEditable=='true') {
						buttons = [
								    { text : "등록", 
								      class:"btn_black"  ,
								      click: function() { commonSchd.saveSchedule();}
								    },
								    { text : "취소", 
								      class:"btn_orange",  
								      click: function() { $("#schdEditPopup").dialog("close");}
								    }
								 ]
						
					}
					$("#schdEditPopup").dialog({
							  title : "일정등록",
							  width:800,
							  height:650,
							  modal : true,
							  buttons : buttons
				        });
					$("#schdEdit_schdCntt").commonEditor({
						skin : "SmartEditor2Skin"
					});
					commonFile.edit_init();
				}
			},
			error : function ( xhr, status, error) {
				alert('데이터 전송오류 ' + status + ", " + error );
			}
			
		});
		
	},
	
	makeDiv : function( id) {
		var check = $("#" + id).attr("id");
		if( check==null) {
			var html = "<div id='" + id + "'></div>";
			$("body").append(html);
		}
	},
	
	saveSchedule : function() {
		
		var formData = {};
		
		// 일정ID
		formData.schdId = $("#schdEdit_schdId").val();

		var url = '';
		if( formData.schdId==0) {
			url = '/schd/insertScheduleAjax.common';
		}  else {
			url = '/schd/updateScheduleAjax.common';
		}
		
		// 일정분류
		formData.schdClsf = $("#schdEdit_schdClsf").val();
		if(formData.schdClsf == '1' ){
			formData.schdTgdeptCd = $("#schdEdit_schdTgdeptCd").val();
			if( formData.schdTgdeptCd == null || formData.schdTgdeptCd=='') {
				alert('부서 조회를 통해 부서를 입력해 주십시요');
				return false;
			}
			formData.schdTgdeptSubClsf = $("input:checkbox[id='schdEdit_schdTgdeptSubClsf']").is(":checked") ? 'Y' : 'N';
		}			
		if(formData.schdClsf == '4' ){
			formData.schdTgusrId = $("#schdEdit_schdTgusrId").val();
			if( formData.schdTgusrId == null || formData.schdTgusrId=='') {
				alert('임원선택을 통해 임원을 입력해 주십시요');
				return false;
			}
		}
		
		// 일정 옵션
		formData.schdOptClsf = $("#schdEdit_schdOptClsf").val();

		// 제목
		formData.schdTitl = $("#schdEdit_schdTitl").val();
		if( formData.schdTitl=='') {
			alert('제목을 입력하십시오.');
			$("#schdEdit_schdTitl").focus();
			return false;
		}
		
		// 장소
		formData.schdPlce = $("#schdEdit_schdPlce").val();
		formData.schdRsrcId = $("#schdEdit_schdRsrcId").val()=='' ? 0 : $("#schdEdit_schdRsrcId").val();
		formData.schdOprId = $("#schdEdit_schdOprId").val() =='' ? 0 : $("#schdEdit_schdOprId").val();
		
		// 시간
		var strtDt = $("#schdEdit_schdStrtDt").val();
		var endDt = $("#schdEdit_schdEndDt").val();
		
		var strtTm =$("#schdEdit_schdStrtHr").val() + $("#schdEdit_schdStrtMn").val()+'00';
		var endTm  =$("#schdEdit_schdEndHr").val() + $("#schdEdit_schdEndMn").val()+'00';
		
		strtDt = strtDt.replace(/\./g,"");
		endDt = endDt.replace(/\./g,"");

		if ( strtDt == endDt && strtTm >= endTm ) { 
			alert('종료시간이 시작시간보다 작습니다');
			$("#schdEdit_schdEndHr").focus();
			return false;
		}
		
		formData.schdStrtDt = strtDt + strtTm;
		formData.schdEndDt = endDt + endTm;

		
		// 반복
		formData.schdRptClsf = $("input:radio[id='schdEdit_schdRptClsf']:checked").val();

		// 반복:요일별
		if( formData.schdRptClsf=='1') {
			formData.schdRptSun = $("input:checkbox[id='schdEdit_schdRptSun']").is(":checked") ? 'Y' : 'N';
			formData.schdRptMon = $("input:checkbox[id='schdEdit_schdRptMon']").is(":checked") ? 'Y' : 'N';
			formData.schdRptTue = $("input:checkbox[id='schdEdit_schdRptTue']").is(":checked") ? 'Y' : 'N';
			formData.schdRptWed = $("input:checkbox[id='schdEdit_schdRptWed']").is(":checked") ? 'Y' : 'N';
			formData.schdRptThu = $("input:checkbox[id='schdEdit_schdRptThu']").is(":checked") ? 'Y' : 'N';
			formData.schdRptFri = $("input:checkbox[id='schdEdit_schdRptFri']").is(":checked") ? 'Y' : 'N';
			formData.schdRptSat = $("input:checkbox[id='schdEdit_schdRptSat']").is(":checked") ? 'Y' : 'N';
			if( formData.schdRptSun=='N' 
				&& formData.schdRptMon=='N'
				&& formData.schdRptTue=='N'
				&& formData.schdRptWed=='N'
				&& formData.schdRptThu=='N'
				&& formData.schdRptFri=='N'
				&& formData.schdRptSat=='N' ) {
				alert('반복요일을 선택하세요');
				$("input:checkbox[id='schdEdit_schdRptClsf']").focus();
				return;
			}
		}
		// 반복:월별/년별
		if( formData.schdRptClsf=='2' || formData.schdRptClsf=='3') {
			formData.schdRptFrt = $("#schdEdit_schdRptFrt").val();
			if( formData.schdRptFrt == '' || formData.schdRptFrt == '0') {
				$("#schdEdit_schdRptFrt").focus();
				alert('반복횟수를 입력하세요');
				return;
			}
		}

		// 중요도
		formData.schdImplv = $("input:radio[id='schdEdit_schdImplv']:checked").val();

		// 공개
		if( formData.schdClsf=='0') {
			formData.schdOpenYn = 'N';
		} else {
			formData.schdOpenYn = $("input:checkbox[id='schdEdit_schdOpenYn']").is(":checked") ? 'Y' : 'N';
		}

		// 공유
		formData.schdPublYn = $("input:checkbox[id='schdEdit_schdPublYn']").is(":checked") ? 'Y' : 'N';
		if( formData.schdPublYn=='Y') {
			formData.openCwnrIds = $("#schdEidt_openCwnrIds").val();
			if( formData.openCwnrIds=='') {
				alert('공유 사용자를 추가하세요');
				return;
			}
		}
		// 알람
		formData.schdNtcYn = $("input:checkbox[id='schdEdit_schdNtcYn']").is(":checked") ? 'Y' : 'N';
		
		if( formData.schdNtcYn == 'Y') {
			if( $("input:radio[id='schdEdit_schdNtcTm']:checked")==null) {
				alert('알람시간을 선택하세요');
				return;
			} 
			formData.schdNtcTm = $("input:radio[id='schdEdit_schdNtcTm']:checked").val();
		}
		
		// 내용 
		formData.htmlCntns = oEditors.getById["schdEdit_schdCntt"].getIR();
		
		// 첨부파일
		formData.fileId = '';
		formData.fileNm = '';
		formData.fileSize = '';
		formData.fileType = '';
		formData.filePath = '';
		formData.fileCtype = '';
		formData.fileCnt = 0;
		if( commonFile.limitCount > 0 && document.setUpload) {
			var totalLimit = commonFile.limitSize * 1;
			var maxSize = document.setUpload.totalsize.value * 1;
//			alert("maxSize=["+maxSize+"], totalLimit=["+totalLimit+"]");
			if( maxSize > totalLimit ) {
				alert( '업로드 가능한 파일 용량을 초과하였습니다.');
				return;
			}
			
			// list객체가 없으면 jquery-ui selectable 사용
			$("#uploadFileList li").each( function(){
				formData.fileCnt++;
				var data = $(this).attr('data');
				var ary = data.split("^");
				formData.fileId += ary[0] + "|";
				formData.fileNm += ary[1] + "|";
				formData.fileSize += ary[2] + "|";
				formData.fileType += ary[3] + "|";
				formData.filePath += ary[4] + "|";
				formData.fileCtype += ary[5] + "|";
			});
			
			// DB에서 삭제할 파일 정보 입력
			formData.delFileIds = "";
			var delFileList = document.setFileList.delList.value;
			if (delFileList != null && delFileList != "") {
				var delArr = delFileList.split("|");
				$(delArr).each(function (index) {
					var data =  $(this).attr('data');
					var ary = data.split("^");
					
					formData.delFileIds += ary[0] + "|";
				});
			}			
		}			

		$.ajax( {
			url : url,
			type : "post",
			data : formData,
			success : function( data) {
				if( data.status=='success') {
					alert( '저장되었습니다');
					$("#schdEditPopup").dialog("close");
					commonSchd.refreshCalendar();
				} else {
					alert( data.msg);
				}
			},
			error : function ( xhr, status, error) {
				alert('데이터 전송오류 ' + status + ", " + error );
			}
			
		});
		
	},

	deleteSchedule : function ( schdId) {
		var formData = { schdId : schdId};
		if( ! confirm('일정을 삭제하시겠습니까?')) {
			return;
		}
		$.ajax( {
			url : '/schd/deleteScheduleAjax.common',
			type : "post",
			data : formData,
			success : function( data) {
				if( data.status=='success') {
					$("#schdPopup").dialog("close");
					$("#schdEditPopup").dialog("close");
					commonSchd.refreshCalendar();
				} else {
					alert( 'msg ' + data.msg);
				}
			},
			error : function ( xhr, status, error) {
				alert('데이터 전송오류 ' + status + ", " + error );
			}
		});
	},
	
	insertScheduleOpn : function ( schdId) {
		var cntns = $("#pop_memo_write").val();
		if( cntns=='') {
			alert( "메모를 입력하세요");
			$("#pop_memo_write").focus();
			return;
		}
		var formData = { schdId : schdId, cntns : cntns};
		
		$.ajax( {
			url : '/schd/insertScheduleOpnAjax.common',
			type : "post",
			data : formData,
			success : function( data) {
				if( data.status=='success') {
					commonSchd.showSchedule( schdId);
				} else {
					alert( data.msg);
				}
			},
			error : function ( xhr, status, error) {
				alert('데이터 전송오류 ' + status + ", " + error );
			}
		});
	},
	
	deleteScheduleOpn : function ( schdId, opnId) {
		var formData = { schdId : schdId, opnId : opnId};
		
		$.ajax( {
			url : '/schd/deleteScheduleOpnAjax.common',
			type : "post",
			data : formData,
			success : function( data) {
				if( data.status=='success') {
					commonSchd.showSchedule( schdId);
				} else {
					alert( data.msg);
				}
			},
			error : function ( xhr, status, error) {
				alert('데이터 전송오류 ' + status + ", " + error );
			}
		});
	},
		
	// 체크박스가 체크되었으면 지정된 영역을 보이고 체크안되었으면 숨긴다.
	setCheckDiv : function( input, div) {
		if( input.checked == true) {
			$(div).show();
		} else {
			$(div).hide();
		}
	},
	
	// 체크박스가 체크되었으면 지정된 영역을 숨기고 체크안되었으면 표시한다
	setCheckDivHide : function( input, div) {
		if( input.checked == true) {
			$(div).hide();
		} else {
			$(div).show();
		}
	},
	
	//반복유형에 따라 영역 표시 
	setSchdRptClsf : function ( input) {
		if( input.value=='0') {
			$("#schdRptWeekDiv").hide();
			$("#schdRptFrtDiv").hide();
		} else  if( input.value=='1') {
			$("#schdRptWeekDiv").show();
			$("#schdRptFrtDiv").hide();
		} else {
			$("#schdRptWeekDiv").hide();
			$("#schdRptFrtDiv").show();
		}

	},
	
	//종일처리 
	setAllday : function () {
		$("#schdEdit_schdStrtHr").val("00");
		$("#schdEdit_schdStrtMn").val("00");
		$("#schdEdit_schdEndHr").val("23");
		$("#schdEdit_schdEndMn").val("59");
	},
	
	schdClsfChanged : function() {
		var schdClsf = $("#schdEdit_schdClsf").val();
		$("#schdEdit_schdTgdeptDiv").hide();
		$("#schdEdit_schdTgusrDiv").hide();
		// 개인일정이면 공개불가
		if( schdClsf == '0') {
			$("#schedEdit_schdOpenYnDiv").hide();
		} else {
			$("#schedEdit_schdOpenYnDiv").show();
		}
		
		if( schdClsf == '1') {
			$("#schdEdit_schdTgdeptDiv").show();
		} else if( schdClsf == '4') {
			$("#schdEdit_schdTgusrDiv").show();
		}
	},
	selectDept : function() {
		commonDeptPopup.showLayerPopup( function( data) {
			if( data!=null) {
				$.each(data, function() {
					$("#schdEdit_schdTgdeptCd").val( this.id);
					$("#schdEdit_schdTgdeptNm").text(this.text);
				});					
			}
		});
	},
	selectExct : function() {
		commonExctPopup.showLayerPopup( function( data) {
			if( data!=null) {
				$("#schdEdit_schdTgusrId").val( data.id);
				$("#schdEdit_schdTgusrNm").text( data.text);
			}
		});
	}
};

var commonSchd = new common.schd();

-->