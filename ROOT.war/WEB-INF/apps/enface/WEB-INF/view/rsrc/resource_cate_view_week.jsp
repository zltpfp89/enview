<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.saltware.enface.util.DateUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="rfrc" uri="/WEB-INF/tld/reference.tld" %>
<%
    request.setAttribute("cPath", request.getContextPath());
    request.setAttribute("today", DateUtil.getCurrentDate("yyyy.MM.dd"));
    request.setAttribute("currentMonth", DateUtil.getCurrentDate("yyyy.MM"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>:: 경기신용보증재단 ::1111111111111</title>
    
    <%-- 공통 스크립트 --%>
    <%@ include file="/sjpb/reference/common/commonScriptInclude.jsp"  %>
    <%-- 공통 스크립트 --%>
    
    <%-- 작성화면용 에디터 + upload 처리 --%>
    <script type="text/javascript" src="${cPath }/board/smarteditor/js/HuskyEZCreator.js"></script>
    <script type="text/javascript" src="${cPath }/sjpb/reference/js/ekr_editor.js"></script>
    <%-- // end --%>
    
    <script type="text/javascript">
        
        var sch_type = '1';
        
	    function fn_search (){
	    	if(sch_type == '1') {
	    		$('#month_label').show();
	    		$('#calendar_label').hide();
	    		$('.calendar_table').show();
	    		$('.subject_calendar').hide();
	    		fn_monthSearch();
	    	}
	    	else if(sch_type == '2') {
	    		$('#month_label').hide();
	    		$('#calendar_label').show();
	    		$('.calendar_table').hide();
	    		$('.subject_calendar').show();
	    		fn_weekSearch();
	    	}
	    	else if(sch_type == '3') {
	    		$('#month_label').hide();
	    		$('#calendar_label').show();
	    		$('.calendar_table').hide();
	    		$('.subject_calendar').show();
	    		fn_daySearch();
	    	}
	    }
	    
	    //월간조회
	    function fn_monthSearch(page){
	    	if(page == undefined) {
	    		page = "";
            }
	    	fn_ajax({
                url : "${cPath}/rsrc/selectResourceViewMonthAjax.face?page="+page,
              param : $('#frm').serialize(),
           callback : {success : function (data) {fn_monthSearchSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
          });
	    }
	    
	    //월간현황조회 콜백
        function fn_monthSearchSuccess(data){
        	$('#month_data').children().remove();
            if (data.status == "SUCCESS") {
                if(data.calendar.length > 0){
                	var html = "";
                	var rsrc_id = $('#frm [name="rsrc_id"]').val();
                	
                	$(data.calendar).each(function(index){
                		html += '<tr class="">';
                		html += '    <td onclick="javascript:fn_absControl(\''+this.SUN+'\',\'0900\',\''+(rsrc_id !=  null ? rsrc_id : '')+'\',\'EM\',\'EM\')" class="first sun"><div><span id=\''+this.SUN+'\' class=\''+(this.CURR_YN_1 == 'N' ? 'date gray' : 'date')+'\'>'+this.DAY1+'</span></div></td>';
                		html += '    <td onclick="javascript:fn_absControl(\''+this.MON+'\',\'0900\',\''+(rsrc_id !=  null ? rsrc_id : '')+'\',\'EM\',\'EM\')" class=""><span  id=\''+this.MON+'\' class=\''+(this.CURR_YN_2 == 'N' ? 'date gray' : 'date')+'\'>'+this.DAY2+'</span></td>';
                		html += '    <td onclick="javascript:fn_absControl(\''+this.TUE+'\',\'0900\',\''+(rsrc_id !=  null ? rsrc_id : '')+'\',\'EM\',\'EM\')" class=""><span  id=\''+this.TUE+'\' class=\''+(this.CURR_YN_3 == 'N' ? 'date gray' : 'date')+'\'>'+this.DAY3+'</span></td>';
                		html += '    <td onclick="javascript:fn_absControl(\''+this.WED+'\',\'0900\',\''+(rsrc_id !=  null ? rsrc_id : '')+'\',\'EM\',\'EM\')" class=""><span  id=\''+this.WED+'\' class=\''+(this.CURR_YN_4 == 'N' ? 'date gray' : 'date')+'\'>'+this.DAY4+'</span></td>';
                		html += '    <td onclick="javascript:fn_absControl(\''+this.THU+'\',\'0900\',\''+(rsrc_id !=  null ? rsrc_id : '')+'\',\'EM\',\'EM\')" class=""><span  id=\''+this.THU+'\' class=\''+(this.CURR_YN_5 == 'N' ? 'date gray' : 'date')+'\'>'+this.DAY5+'</span></td>';
                		html += '    <td onclick="javascript:fn_absControl(\''+this.FRI+'\',\'0900\',\''+(rsrc_id !=  null ? rsrc_id : '')+'\',\'EM\',\'EM\')" class=""><span  id=\''+this.FRI+'\' class=\''+(this.CURR_YN_6 == 'N' ? 'date gray' : 'date')+'\'>'+this.DAY6+'</span></td>';
                		html += '    <td onclick="javascript:fn_absControl(\''+this.SAT+'\',\'0900\',\''+(rsrc_id !=  null ? rsrc_id : '')+'\',\'EM\',\'EM\')" class="sat last"><span  id=\''+this.SAT+'\' class=\''+(this.CURR_YN_7 == 'N' ? 'date gray' : 'date')+'\'>'+this.DAY7+'</span></td>';
                		html += '</tr>';
                	})
                	$('#month_data').append(html);
                }
                
                var html2 = "";
                
                if(data.list.length > 0){
                	$(data.list).each(function(index){
                		
                		if((this.YN).indexOf('NO') != -1) {
                			var len = Number(this.YN.length) - 2;
                				$('#'+ this.DAYS).after('<a class="btn impossible" href="javascript:fn_rsrcAbleDetail(\''+this.RSRC_ID+'\',\''+(this.YN).substr(2,len)+'\')">불가</a>');
                		}
                		if((this.YN).indexOf('0F') != -1) {
                				$('#'+ this.DAYS).after('<a class="btn confirm2" href="javascript:fn_absControl(\''+this.DAYS+'\',\'090000\', \''+this.RSRC_ID+'\', \''+this.OPR_ID+'\', \''+this.YN+'\')">신청</a>');
                		}
                	    if((this.YN).indexOf('0T') != -1) {
                				$('#'+ this.DAYS).after('<a class="btn confirm" href="javascript:fn_absControl(\''+this.DAYS+'\',\'090000\', \''+this.RSRC_ID+'\', \''+this.OPR_ID+'\', \''+this.YN+'\')">신청</a>');
                		}
                	    if((this.YN).indexOf('1F') != -1) {
                				$('#'+ this.DAYS).after('<a class="btn confirm2" href="javascript:fn_absControl(\''+this.DAYS+'\',\'090000\', \''+this.RSRC_ID+'\', \''+this.OPR_ID+'\', \''+this.YN+'\')">승인</a>');
                		}
                	    if((this.YN).indexOf('1T') != -1) {
                            	$('#'+ this.DAYS).after('<a class="btn confirm" href="javascript:fn_absControl(\''+this.DAYS+'\',\'090000\', \''+this.RSRC_ID+'\', \''+this.OPR_ID+'\', \''+this.YN+'\')">승인</a>');
                        }
                	});
                }
                
                $( ".impossible, .confirm, .confirm2" ).click(function( event ) {
                    event.stopPropagation();
                });
                
                var date = data.month;
                $('#select_month').val(date);
                // 페이징 삭제
                $('.board_page').children().remove();
                $('.board_page').text("");
                
                var txt =  date.substr(0,4) + "년 "+date.substr(5,2)+"월";
                var html3 = "";
                html3 += '<a href="#" class="page_prev" onclick="fn_monthSearch(\'prev\')">&nbsp;';
                html3 += '<a href="#">&nbsp;<label><strong>'+txt+'</strong></label>&nbsp;</a>';
                html3 += '<a href="#" class="page_next" onclick="fn_monthSearch(\'next\')">&nbsp;</a>';
                $('.board_page').append(html3);
                
                autoResize();
//                 if(parent.autoresize_iframe_portlets) parent.autoresize_iframe_portlet();
            } else {
                //alert(data);
            }
        }
        // 주간조회	    
        function fn_weekSearch(week){
	    	if(week == undefined) {
	    		week = "";
	    	}
	    	url = "/rsrc/selectResourceViewWeekAjax.face?week="+ week;
            $.ajax({
                type : "post",
                url : url,
                data : $('#frm').serialize(),
                dataType :"json",
                async:false,
                cache:false,
                success : function(json, textStatus){
                	$('.subject_calendar colgroup col:eq(0)').css('width','55px');
                	$('.subject_calendar tbody tr:eq(0) th:eq(0)').text('날짜/시간');
                	$('.subject_calendar').each(function(){$(this).find('tr:gt(1)').remove()});
                	var rsrc_id = $('select[name="rsrc_id"]').val();
                    if(json.total_cnt > 0) {
                    	if(rsrc_id != null){
                    		for(var i=0;i<json.total_cnt;i++) {
                                var val  = new Array();
                                var time = new Array();
                                var yyyymmdd = json.data[i].YYYYMMDD;
                                var k_day = json.data[i].K_DAY;
                                var e_day = json.data[i].E_DAY;
                                var dd    = json.data[i].DD;
                                
                                val.push(json.data[i].T1);  val.push(json.data[i].T2);  val.push(json.data[i].T3);  
                                val.push(json.data[i].T4);  val.push(json.data[i].T5);  val.push(json.data[i].T6);
                                val.push(json.data[i].T7);  val.push(json.data[i].T8);  val.push(json.data[i].T9);  
                                val.push(json.data[i].T10); val.push(json.data[i].T11); val.push(json.data[i].T12);
                                val.push(json.data[i].T13); val.push(json.data[i].T14); val.push(json.data[i].T15); 
                                val.push(json.data[i].T16); val.push(json.data[i].T17); val.push(json.data[i].T18);
                                val.push(json.data[i].T19); val.push(json.data[i].T20); val.push(json.data[i].T21);
                                val.push(json.data[i].T22); val.push(json.data[i].T23); val.push(json.data[i].T24);
                                val.push(json.data[i].T25); val.push(json.data[i].T26); val.push(json.data[i].T27);
                                val.push(json.data[i].T28); val.push(json.data[i].T29); val.push(json.data[i].T30);
                                
                                
                                time.push('0900'); time.push('0930'); time.push('1000');
                                time.push('1030'); time.push('1100'); time.push('1130');
                                time.push('1200'); time.push('1230'); time.push('1300');
                                time.push('1330'); time.push('1400'); time.push('1430');
                                time.push('1500'); time.push('1530'); time.push('1600');
                                time.push('1630'); time.push('1700'); time.push('1730');
                                time.push('1800'); time.push('1830'); time.push('1900');
                                time.push('1930'); time.push('2000'); time.push('2030');
                                time.push('2100'); time.push('2130'); time.push('2200');
                                time.push('2230'); time.push('2300'); time.push('2330');
                                
                                var color = e_day == 'SAT' ? 'blue' : (e_day == 'SUN' ? 'red' : 'black');
                                var first_day = (json.data[0].YYYYMMDD).substr(4,2) + '월 ' + (json.data[0].YYYYMMDD).substr(6,2) + '일';
                                var last_day  = (json.data[6].YYYYMMDD).substr(4,2) + '월 ' + (json.data[6].YYYYMMDD).substr(6,2) + '일';
                                
                                var html = "";
                                html += '<tr>';
                                html +=     '<th scope="row"><font color="'+color+'">'+dd+'('+k_day+')</font></th>';
                                for(var j=0; j<val.length;j++) {
                                       html += '<td style="cursor:pointer"';
                                    if(val[j].indexOf('NO') != -1)  {
                                        var len = Number(val[j].length) - 2;
                                        html +=    'onclick="fn_rsrcAbleDetail(\''+rsrc_id+'\',\''+val[j].substr(2,len)+'\')">';
                                    } else{  
                                        var len = Number(val[j].length) - 2;    
                                        var opr_id = val[j] == 'EM' ? 'EM' : +val[j].substr(2,len);
                                        html +=    'onclick="fn_absControl(\''+yyyymmdd+'\',\''+time[j]+'\', \''+rsrc_id+'\', \''+opr_id+'\', \''+val[j]+'\')">';
                                    }
                                    if(val[j].search('NO')  != -1)     { 
                                        html +=    '<div class="impossible">불가</div>'; } // 사용불가
                                    else if(val[j].indexOf('0F')!= -1) { 
                                        html +=    '<div class="self_req">신청</div>'; }  // 본인신청
                                    else if(val[j].indexOf('0T')!= -1) { 
                                        html +=    '<div class="other_req">신청</div>'; } // 타인신청
                                    else if(val[j].indexOf("1F") != -1)  { 
                                        html +=    '<div class="self_req">승인</div>'; }   // 승인
                                    else if(val[j].indexOf("1T") != -1)  { 
                                        html +=    '<div class="other_req">승인</div>'; }   // 승인 
                                    else { 
                                        html +=    '<div class=""></div>';}
                                        html +=    '<input type="hidden" id="'+i+'_'+time[j]+'" value="'+val[j]+'"/>';
                                        html += '</td>';
                                }
                                html += '</tr>';
                              $('.subject_calendar').append(html); // 테이블을 그림
                            }
                    		var date = json.data[0].YYYYMMDD;
                            $('#select_date').val(date.substr(0,4) + "." + date.substr(4,2) + "." + date.substr(6,2)); // 날짜값 세팅
                            
                            
                            // 페이징 삭제
                            $('.board_page').children().remove();
                            $('.board_page').text("");
                            
                            var html2 = "";
                            html2 += '<a href="#" class="page_prev" onclick="fn_weekSearch(\'prev\')">&nbsp;</a>';
                            html2 += '&nbsp;<a href="#">&nbsp;<label><strong>'+first_day+'</strong></label>&nbsp;</a>';
                            html2 += ' ~ ';
                            html2 += '<a href="#">&nbsp;<label><strong>'+last_day+'</strong></label>&nbsp;</a>';
                            html2 += '&nbsp;<a href="#" class="page_next" onclick="fn_weekSearch(\'next\')">&nbsp;</a>';
                            $('.board_page').append(html2);
                    	} else {
                    		// 조회된 자원이 없을 시
                            var html = "";
                            var select_date = $('#select_date').val();
                            html += '<tr>';
                            html +=     '<td colspan="21" align="center" style="text-algn:center">';
                            html +=         '조회된 자원이 없습니다.';
                            html +=     '</td>';
                            html += '</tr>';
                            $('.subject_calendar').append(html); 
                            
                            // 페이징 삭제
                            $('.board_page').children().remove();
                            $('.board_page').text("");
                    	}
                        
                    } else {
                        //alert(json.msg);
                    }
                    
                    autoResize();
                    //location.reload();
                    //if(parent.autoresize_iframe_portlets) parent.autoresize_iframe_portlets();
                },
                error : function(e){
                    //alert(JSON.stringify(e));
                }
            });
        }
	    
        // 예약현황(일간)
        function fn_daySearch(day){
        	if(day == undefined) {
        		day = "";
            }
            url = "/rsrc/selectResourceViewDayAjax.face?day="+day;
            $.ajax({
                type : "post",
                url : url,
                data : $('#frm').serialize(),
                dataType :"json",
                async:false,
                cache:false,
                success : function(json, textStatus){
                	$('.subject_calendar colgroup col:eq(0)').css('width','74px');
                	$('.subject_calendar tbody tr:eq(0) th:eq(0)').text('자원명/시간');
                	$('.subject_calendar').each(function(){$(this).find('tr:gt(1)').remove()});
                    if(json.data.length > 0) {
                        for(var i=0;i<json.data.length;i++) {
                            var val  = new Array();
                            var time = new Array();
                            var select_date = json.data[i].SELECT_DATE;
                            
                            val.push(json.data[i].T1);  val.push(json.data[i].T2);  val.push(json.data[i].T3);  
                            val.push(json.data[i].T4);  val.push(json.data[i].T5);  val.push(json.data[i].T6);
                            val.push(json.data[i].T7);  val.push(json.data[i].T8);  val.push(json.data[i].T9);  
                            val.push(json.data[i].T10); val.push(json.data[i].T11); val.push(json.data[i].T12);
                            val.push(json.data[i].T13); val.push(json.data[i].T14); val.push(json.data[i].T15); 
                            val.push(json.data[i].T16); val.push(json.data[i].T17); val.push(json.data[i].T18);
                            val.push(json.data[i].T19); val.push(json.data[i].T20); val.push(json.data[i].T21);
                            val.push(json.data[i].T22); val.push(json.data[i].T23); val.push(json.data[i].T24);
                            val.push(json.data[i].T25); val.push(json.data[i].T26); val.push(json.data[i].T27);
                            val.push(json.data[i].T28); val.push(json.data[i].T29); val.push(json.data[i].T30);
                            
                            time.push('0900'); time.push('0930'); time.push('1000');
                            time.push('1030'); time.push('1100'); time.push('1130');
                            time.push('1200'); time.push('1230'); time.push('1300');
                            time.push('1330'); time.push('1400'); time.push('1430');
                            time.push('1500'); time.push('1530'); time.push('1600');
                            time.push('1630'); time.push('1700'); time.push('1730');
                            time.push('1800'); time.push('1830'); time.push('1900');
                            time.push('1930'); time.push('2000'); time.push('2030');
                            time.push('2100'); time.push('2130'); time.push('2200');
                            time.push('2230'); time.push('2300'); time.push('2330');
                            
                            var html = "";
                            html += '<tr>';
                            html +=     '<th scope="row" style="text-align:left">'+" "+json.data[i].RSRC_NM+'</th>';
                            for(var j=0; j<val.length;j++) {
                                   html += '<td style="cursor:pointer"';
                                if(val[j].indexOf('NO') != -1)  {
                                    var len = Number(val[j].length) - 2;
                                    html +=    'onclick="fn_rsrcAbleDetail(\''+json.data[i].RSRC_ID+'\',\''+val[j].substr(2,len)+'\')">';
                                } else{  
                                    var len = Number(val[j].length) - 2;    
                                    var opr_id = val[j] == 'EM' ? 'EM' : +val[j].substr(2,len);
                                    html +=    'onclick="fn_absControl(\''+select_date+'\',\''+time[j]+'\', \''+json.data[i].RSRC_ID+'\', \''+opr_id+'\', \''+val[j]+'\')">';
                                }
                                if(val[j].search('NO')  != -1)     { 
                                    html +=    '<div class="impossible">불가</div>'; } // 사용불가
                                else if(val[j].indexOf('0F')!= -1) { 
                                    html +=    '<div class="self_req">신청</div>'; }  // 본인신청
                                else if(val[j].indexOf('0T')!= -1) { 
                                    html +=    '<div class="other_req">신청</div>'; } // 타인신청
                                else if(val[j].indexOf("1F") != -1)  { 
                                    html +=    '<div class="self_req">승인</div>'; }   // 승인
                                else if(val[j].indexOf("1T") != -1)  { 
                                    html +=    '<div class="other_req">승인</div>'; }   // 승인 
                                else { 
                                    html +=    '<div class=""></div>';}
                                    html +=    '<input type="hidden" id="'+i+'_'+time[j]+'" value="'+val[j]+'"/>';
                                    html += '</td>';
                            }
                            html += '</tr>';
                            
                          $('.subject_calendar').append(html); // 테이블을 그림
                          
                          var date = json.data[0].SELECT_DATE;
                          $('#select_date').val(date.substr(0,4) + "." + date.substr(4,2) + "." + date.substr(6,2)); // 날짜값 세팅
                        }
                        
                        
                        // 페이징 삭제
                        $('.board_page').children().remove();
                        $('.board_page').text("");
                        var txt =  select_date.substr(0,4) + "년 " + select_date.substr(4,2) + "월 " + select_date.substr(6,2) + "일";
                        var html2 = "";
                        html2 += '<a href="#" class="page_prev" onclick="fn_daySearch(\'prev\')">&nbsp;';
                        html2 += '<a href="#">&nbsp;<label><strong>'+txt+'</strong></label>&nbsp;</a>';
                        html2 += '<a href="#" class="page_next" onclick="fn_daySearch(\'next\')">&nbsp;</a>';
                        $('.board_page').append(html2);
                    } else {
                    	// 조회된 자원이 없을 시
                    	var html = "";
                    	var select_date = $('#select_date').val();
                        html += '<tr>';
                        html +=     '<td colspan="21" align="center" style="text-algn:center">';
                        html +=         '조회된 자원이 없습니다.';
                        html +=     '</td>';
                        html += '</tr>';
                        $('.subject_calendar').append(html); 
                        
                        // 페이징 삭제
                        $('.board_page').children().remove();
                        $('.board_page').text("");
                        
                        //alert(json.msg);
                    }
                    autoResize();
                    //location.reload();
                    //if(parent.autoresize_iframe_portlets) parent.autoresize_iframe_portlets();
                },
                error : function(e){
                    //alert(JSON.stringify(e));
                }
            });
        }
	    
        // 자원목록조회
        function fn_selectRsrcId(){
            fn_ajax({
                  url : "${cPath}/rsrc/selectResourceListAjax.face",
                param : $('#frm').serialize(),
             callback : {success : function (data) {fn_selectRsrcIdSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
            });
        }
        //  자원목록조회
        function fn_selectRsrcIdSuccess(data){
            if (data.status == "SUCCESS") {
            	$('#frm select[name="rsrc_id"] option').remove();
                if (data.data.length > 0){
                    var html = "";
                    $(data.data).each(function () {
                        html += "<option value=" + this.RSRC_ID+ ">" + this.RSRC_NM + "</option>";
                    });
                    $('#frm select[name="rsrc_id"]').append(html);
                }
                fn_search();
            }
        }
        
        function fn_btn_control(obj){
            var btn_class = $(obj).attr('class');
            var btn_name  = $(obj).attr('name');
            
            
            if(btn_name == 'btn_month') {
            	$('a[name="btn_month"]').removeClass().addClass('btn_black');
            	$('a[name="btn_week"]').removeClass().addClass('btn_white');
                $('a[name="btn_day"]').removeClass().addClass('btn_white');
                $('#frm select[name="rsrc_id"]').css('display','');
                $('#frm select[name="rsrc_id"]').prop('disabled','');
                sch_type = '1';
            } else if(btn_name == 'btn_week') {
            	$('a[name="btn_month"]').removeClass().addClass('btn_white');
            	$('a[name="btn_week"]').removeClass().addClass('btn_black');
                $('a[name="btn_day"]').removeClass().addClass('btn_white');
                $('#frm select[name="rsrc_id"]').css('display','');
                $('#frm select[name="rsrc_id"]').prop('disabled','');
                $('#frm h4').text('자원예약(주간)');
                sch_type = '2';
            } else if(btn_name == 'btn_day') {
            	$('a[name="btn_month"]').removeClass().addClass('btn_white');
            	$('a[name="btn_week"]').removeClass().addClass('btn_white');
                $('a[name="btn_day"]').removeClass().addClass('btn_black');
                $('#frm select[name="rsrc_id"]').css('display','none');
                $('#frm select[name="rsrc_id"]').prop('disabled','true');
                $('#frm h4').text('자원예약(일간)');
                sch_type = '3';
            }
            fn_search(); // 로딩시 조회
            
    		if(parent.autoresize_iframe_portlet){
    			parent.autoresize_iframe_portlet(); 
    		}
            
        }
        $(document).ready(function(){
        	
        	$( "#select_date" ).datepicker({
                showOn: "both",
                buttonImage: "${cPath }/sjpb/reference/images/icon_calendar.png",
                buttonImageOnly: true,
                buttonText: "일자선택" 
            });
        	
        	// 부서코드 체인지 이벤트
            $('select[name="dept_cd"]').change(function(event){
                fn_selectRsrcId(); // 자원목록조회
            });
            $('select[name="rsrc_clsf"]').change(function(event){
                fn_selectRsrcId(); // 자원목록조회
            });
            $('select[name="rsrc_id"]').change(function(event){
                fn_search();       // 예약현황조회
            });
            
            // 버튼 이벤트
            $('a[name*="btn"]').bind('click',function(event){
                switch (this.name){
                    case "btn_search" : fn_search();              break; // 조회
                    case "btn_week"   : fn_btn_control($(this));  break;
                    case "btn_day"    : fn_btn_control($(this));  break;
                    case "btn_month"  : fn_btn_control($(this));  break;
                }
            });
            
            $('#select_month').val("${currentMonth}");
            $('#select_date').val("${today}");
            
            
            fn_search();
        });
        
    </script>
    <style type="text/css">
	    .subject_calendar td .self_req{color:#a5c667;  padding-top:30px; margin-top:-10px; text-align:center; background:url(/sjpb/reference/images/icon_flag_green.png) no-repeat 10px center;}
	    .subject_calendar td .other_req{color:#fa4f03; padding-top:30px; margin-top:-10px; text-align:center; background:url(/sjpb/reference/images/icon_flag_orange.png) no-repeat 10px center;}
	    .subject_calendar td .impossible{color:#c5c5c5; padding-top:30px; margin-top:-10px;  text-align:center; background:url(/sjpb/reference/images/icon_flag_gray.png) no-repeat 10px center; }
    </style>
</head>
<body>
    <jsp:include page="layer_popup_list.jsp"/>
    <div class="sub_container">
        <form name="frm" id="frm" method="post" >
        <!-- content start -->
        <div id="content">
            <h4>자원예약(주간)</h4>
            <!-- 목록상단 -->
            <div class="board_search">
                <fieldset>
                 <select name="dept_cd">
                     <c:forEach var="dept" items="${dept}" varStatus="status">
                         <option value="${dept.CODE}" <c:if test="${dept.CODE eq param.dept_cd}"> selected="selected" </c:if>>${dept.NAME}</option>
                     </c:forEach>
                 </select>
                 
                 <select name="rsrc_clsf">
                     <c:forEach var="rsrc_clsf" items="${rsrc_clsf}" varStatus="status">
                     	<c:if test="${rsrc_clsf.CODE eq param.rsrc_clsf}">
                         <option value="${rsrc_clsf.CODE}" <c:if test="${rsrc_clsf.CODE eq param.rsrc_clsf}"> selected="selected" </c:if>>${rsrc_clsf.NAME}</option>
                        </c:if>
                        <c:if test="${rsrc_clsf.CODE ne param.rsrc_clsf}">
                         <option value="${rsrc_clsf.CODE}" <c:if test="${rsrc_clsf.CODE eq param.rsrc_clsf}"> </c:if>>${rsrc_clsf.NAME}</option>
                        </c:if>
                     </c:forEach>
                 </select>
                 
                 <select name="rsrc_id">
                    <c:forEach var="rsrc" items="${rsrc}" varStatus="status">
                         <option value="${rsrc.RSRC_ID}" <c:if test="${rsrc.RSRC_ID eq param.rsrc_id}"> selected="selected" </c:if>>${rsrc.RSRC_NM}</option>
                     </c:forEach>
                 </select>
                 
                 <script>
                 $(function(){
                     $(".date-picker").datepicker({
                         changeMonth: true,
                         changeYear: true,
                         showButtonPanel: true,
                         closeText : "선택",
                         onClose: function(dateText, inst) {
                             var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                             var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                             $(this).val( $.datepicker.formatDate('yy.mm', new Date(year, month, 1)) );
                         },
                         showOn: "both",
                         buttonImage: "${cPath }/sjpb/reference/images/icon_calendar.png",
                     	 buttonImageOnly: true,
                     	 buttonText: "일자선택"
                     });
                     
                     $(".date-picker").focus(function () {
                         $(".ui-datepicker-calendar").hide();
                         $("#ui-datepicker-div").position({
                             my: "center top",
                             at: "center bottom",
                             of: $(this)
                         });
                     });
                 });
                 </script>
                 <label for="" class="cursor" id="month_label">
                    <input type="text" id="select_month" name="select_month" class="date-picker w70" readonly value="<c:out value="${param.select_month}" escapeXml="false"/>" maxlength=""/> 
                 </label>
                 
                 <script>
                 	$(function() {
                 		$( "#select_date").datepicker({
                 			dateFormat:'yy.mm.dd', 
                 			onClose: function(dateText, inst){;$('#select_month').val((dateText).substr(0,7));}
                 		});
                 	});
                 </script>
                 <label for="" class="cursor" id="calendar_label">
                    <input type="text" id="select_date" name="select_date" readonly  class="w80" value="<c:out value="${param.select_date}" escapeXml="false"/>"maxlength=""/> 
                 </label>
                 <a href="#" class="btn_white" name="btn_search"><span class="icon_search"></span>검색</a>
                 </fieldset>
            </div>

            <div class="board_top">
                <div class="board_btn_R">
                    <a href="#" class="btn_black" name="btn_month">월간</a> 
                    <a href="#" class="btn_white" name="btn_week">주간</a>
                    <a href="#" class="btn_white" name="btn_day">일간</a>
                </div>                      
            </div>
            <!-- 주간 목록 -->
            <table summary="" class="subject_calendar">
                <caption></caption>
                <colgroup>
                    <col style="width:55px" />
                    <col style="width:auto" />
                </colgroup>
                <tbody>
                    <tr class="bdb">
                        <th rowspan="2" scope="col" class="bdrb">날짜/시간</th>
                        <th scope="colgroup" colspan="2">9시</th>
                        <th scope="colgroup" colspan="2">10시</th>
                        <th scope="colgroup" colspan="2">11시</th>
                        <th scope="colgroup" colspan="2">12시</th>
                        <th scope="colgroup" colspan="2">13시</th>
                        <th scope="colgroup" colspan="2">14시</th>
                        <th scope="colgroup" colspan="2">15시</th>
                        <th scope="colgroup" colspan="2">16시</th>
                        <th scope="colgroup" colspan="2">17시</th>
                        <th scope="colgroup" colspan="2">18시</th>
                        <th scope="colgroup" colspan="2">19시</th>
                        <th scope="colgroup" colspan="2">20시</th>
                        <th scope="colgroup" colspan="2">21시</th>
                        <th scope="colgroup" colspan="2">22시</th>
                        <th scope="colgroup" colspan="2">23시</th>
                    </tr>
                    <tr>
                        <th scope="col" class="bdrb">00</th>
                        <th scope="col" class="bdrb">30</th>
                        <th scope="col" class="bdrb">00</th>
                        <th scope="col" class="bdrb">30</th>
                        <th scope="col" class="bdrb">00</th>
                        <th scope="col" class="bdrb">30</th>
                        <th scope="col" class="bdrb">00</th>
                        <th scope="col" class="bdrb">30</th>
                        <th scope="col" class="bdrb">00</th>
                        <th scope="col" class="bdrb">30</th>
                        <th scope="col" class="bdrb">00</th>
                        <th scope="col" class="bdrb">30</th>
                        <th scope="col" class="bdrb">00</th>
                        <th scope="col" class="bdrb">30</th>
                        <th scope="col" class="bdrb">00</th>
                        <th scope="col" class="bdrb">30</th>
                        <th scope="col" class="bdrb">00</th>
                        <th scope="col" class="bdrb">30</th>
                        <th scope="col" class="bdrb">00</th>
                        <th scope="col" class="bdrb">30</th>
                        <th scope="col" class="bdrb">00</th>
                        <th scope="col" class="bdrb">30</th>
                        <th scope="col" class="bdrb">00</th>
                        <th scope="col" class="bdrb">30</th>      
                        <th scope="col" class="bdrb">00</th>
                        <th scope="col" class="bdrb">30</th>
                        <th scope="col" class="bdrb">00</th>
                        <th scope="col" class="bdrb">30</th>
                        <th scope="col" class="bdrb">00</th>
                        <th scope="col" class="bdrb">30</th>                                                                                                                                                              
                    </tr>
                </tbody>
            </table>
            
            <table class="calendar_table" summary="" >
                 <caption>자원예약 월간보기</caption>
                 <colgroup>
                     <col width="*" />
                 </colgroup>
                 <thead>
                     <tr>
                         <th scope="col" class="sun">일</th>
                         <th scope="col">월</th>
                         <th scope="col">화</th>
                         <th scope="col">수</th>
                         <th scope="col">목</th>
                         <th scope="col">금</th>
                         <th scope="col" class="sat last">토</th>
                     </tr>
                 </thead>
                 <tbody id="month_data">
                 </tbody>
            </table>
            
            <!-- //주간 목록 -->

            <div class="board_bottom">
                <div class="board_btn_R">
                    <a href="#" class="btn_black" name="btn_month">월간</a> 
                    <a href="#" class="btn_white" name="btn_week">주간</a>
                    <a href="#" class="btn_white" name="btn_day">일간</a>
                </div>                      
            </div>

            <div class="board_page">
            </div>
            <!-- //페이징 -->
            <!-- 자원예약 안내 -->
            <ul class="guide_list">
                <li>부재등록 및 조회방법 - 해당 날짜와 시간의 네모칸을 선택하여 등록 및 조회를 하시길 바랍니다.</li>
                <li>아이콘을 클릭하면 상세내역을 보실 수 있습니다. <span class="confirm">타인예약중</span> <span class="confirm2">본인예약중</span> <span class="impossible">사용불가</span></li>
            </ul>
            <!-- // 자원예약 안내 -->
        </div>
        <!-- //content end -->
        </form>
    </div>
</body>
</html>

        