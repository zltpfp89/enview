<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="rfrc" uri="/WEB-INF/tld/reference.tld" %>
<%
    request.setAttribute("cPath", request.getContextPath());
    request.setAttribute("usrId",  EnviewSSOManager.getUserInfo(request).getUserId()); // 로그인사용자
    request.setAttribute("admin",  EnviewSSOManager.getUserInfo(request).getHasRole("ROLE_MNG_RSRC")); // 자원예약관리자
%>
    <script type="text/javascript">
	    // 예약현황
        function fn_reservation(rsrc_id, week){
        	var week = week == undefined ? '' : week;
        	var sd = $('#select_date').val();
	    	var url = "/rsrc/selectResourceViewWeekAjax.face?rsrc_id="+rsrc_id+"&week="+week+"&select_date="+sd;
	    	
            $.ajax({
                type : "post",
                url : url,
                dataType :"json",
                async:false,
                cache:false,
                success : function(json, textStatus){
                	$('[id*="_table"] tbody').each(function(){$(this).find('tr:gt(1)').remove()});
                	
                    if(json.total_cnt > 0) {
                        for(var i=0;i<json.total_cnt;i++) {
                        	
                        	var val  = new Array();
                        	var time = new Array();
                        	var yyyymmdd = json.data[i].YYYYMMDD;
                            var k_day = json.data[i].K_DAY;
                            var e_day = json.data[i].E_DAY;
                            var dd    = json.data[i].DD;
                            
                        	val.push(json.data[i].T1); 	val.push(json.data[i].T2);  val.push(json.data[i].T3);  
                        	val.push(json.data[i].T4); 	val.push(json.data[i].T5);  val.push(json.data[i].T6);
                        	val.push(json.data[i].T7);  val.push(json.data[i].T8);  val.push(json.data[i].T9);  
                        	val.push(json.data[i].T10); val.push(json.data[i].T11); val.push(json.data[i].T12);
                        	val.push(json.data[i].T13); val.push(json.data[i].T14); val.push(json.data[i].T15); 
                        	val.push(json.data[i].T16); val.push(json.data[i].T17); val.push(json.data[i].T18);
                        	val.push(json.data[i].T19); val.push(json.data[i].T20);
                        	
                        	time.push('0900'); time.push('0930'); time.push('1000');
                            time.push('1030'); time.push('1100'); time.push('1130');
                            time.push('1200'); time.push('1230'); time.push('1300');
                            time.push('1330'); time.push('1400'); time.push('1430');
                            time.push('1500'); time.push('1530'); time.push('1600');
                            time.push('1630'); time.push('1700'); time.push('1730');
                            time.push('1800'); time.push('1830'); 	
                        	
                        	var color = e_day == 'SAT' ? 'blue' : (e_day == 'SUN' ? 'red' : 'black');
                            var first_day = json.data[0].YYYYMMDD.substr(4,2) + '월 ' + json.data[0].YYYYMMDD.substr(6,2) + '일';
                            var last_day  = json.data[6].YYYYMMDD.substr(4,2) + '월 ' + json.data[6].YYYYMMDD.substr(6,2) + '일';
                            
                            var html = "";
                            html += '<tr>';
                            html +=     '<th scope="row"><font color="'+color+'">'+dd+'('+k_day+')</font></th>';
                            
                            for(var j=0; j<val.length;j++) {
                            	   html += '<td ';
                            	if(val[j].search('NO') != -1)  {
                            	    var len = Number(val[j].length) - 2;
                                    //html +=    'onclick="fn_rsrcAbleDetail(\''+rsrc_id+'\',\''+val[j].substr(2,len)+'\')">';
                                    html +=    '>';
                            	} else{  
                            		var len = Number(val[j].length) - 2;    
                                    var opr_id = val[j] == 'EM' ? 'EM' : +val[j].substr(2,len);
                                    //html +=    'onclick="fn_absControl(\''+yyyymmdd+'\',\''+time[j]+'\', \''+rsrc_id+'\', \''+opr_id+'\', \''+val[j]+'\')">';
                                    html +=    '>';
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
                          
                          $('#' + rsrc_id + '_table').append(html);
                          $('#' + rsrc_id + '_first_day').html('<strong>'+first_day+'</strong>');
                          $('#' + rsrc_id + '_last_day').html('<strong>'+last_day+'</strong>');
                          
                          //$('#select_date').val(json.data[0].YYYYMMDD); // 날짜값 세팅
                          
                        }
                    } else {
                        alert(json.msg);
                    }
                    //location.reload();
                },
                error : function(e){
                    //alert(JSON.stringify(e));
                }
            });
        }
        
        $(document).ready(function(){
        	fn_reservation('${param.RSRC_ID }', '');
        });
    </script>
    <style type="text/css">
	    .subject_calendar td .self_req{color:#a5c667; text-align:center; background:url(/sjpb/reference/images/icon_flag_green.png) no-repeat 2px center;}
	    .subject_calendar td .other_req{color:#fa4f03; text-align:center; background:url(/sjpb/reference/images/icon_flag_orange.png) no-repeat 2px center;}
	    .subject_calendar td .impossible{color:#c5c5c5; text-align:center; background:url(/sjpb/reference/images/icon_flag_gray.png) no-repeat 2px center;}
    </style>

	<div class="sub_container" style="min-height: 400px;">
		<!-- content start -->
		<div id="content">
			<input type="hidden" id="select_date" name="select_date"/>
			
			<div class="board_top">
				<!-- 목록 -->
				<table class="basic_table" summary="">
					<caption>자원현황 목록</caption>
					<colgroup>
						<col width="*" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col" class="last">자원예약현황</th>
						</tr>
					</thead>
					<tbody>
						<tr class="view" style="display: block;">
							<td>
								<table summary="" class="subject_calendar" id="<c:out value="${param.RSRC_ID}"/>_table">
									<caption></caption>
									<colgroup>
										<col style="width:104px" />
										<col style="width:auto" />
									</colgroup>
									<tbody>
										<tr>
											<th rowspan="2" scope="col">날짜/시간</th>
											<th scope="col" colspan="2">9시</th>
											<th scope="col" colspan="2">10시</th>
											<th scope="col" colspan="2">11시</th>
											<th scope="col" colspan="2">12시</th>
											<th scope="col" colspan="2">13시</th>
											<th scope="col" colspan="2">14시</th>
											<th scope="col" colspan="2">15시</th>
											<th scope="col" colspan="2">16시</th>
											<th scope="col" colspan="2">17시</th>
											<th scope="col" colspan="2">18시</th>
										</tr>
										<tr>
											<th scope="col">00</th>
											<th scope="col">30</th>
											<th scope="col">00</th>
											<th scope="col">30</th>
											<th scope="col">00</th>
											<th scope="col">30</th>
											<th scope="col">00</th>
											<th scope="col">30</th>
											<th scope="col">00</th>
											<th scope="col">30</th>
											<th scope="col">00</th>
											<th scope="col">30</th>
											<th scope="col">00</th>
											<th scope="col">30</th>
											<th scope="col">00</th>
											<th scope="col">30</th>
											<th scope="col">00</th>
											<th scope="col">30</th>
											<th scope="col">00</th>
											<th scope="col">30</th>
										</tr>
									</tbody>
								</table>
								<div class="board_page" style="margin-top:10px;">
								<a class="page_prev cursor" onclick="fn_reservation('${param.RSRC_ID}','prev')">이전 페이지</a>
								&nbsp;
								<a class="cursor"><label id="${param.RSRC_ID}_first_day"></label></a>
								~
								<a class="cursor"><label id="${param.RSRC_ID}_last_day"></label></a>
								&nbsp;
								<a class="page_next cursor" onclick="fn_reservation('${param.RSRC_ID}','next')">다음 페이지</a>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!-- //content end -->
	</div>

        