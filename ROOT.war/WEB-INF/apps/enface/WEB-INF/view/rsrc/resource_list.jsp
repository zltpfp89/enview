<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="rfrc" uri="/WEB-INF/tld/reference.tld" %>
<%
    request.setAttribute("cPath", request.getContextPath());
    request.setAttribute("usrId",  EnviewSSOManager.getUserInfo(request).getUserId()); // 로그인사용자
    request.setAttribute("admin",  EnviewSSOManager.getUserInfo(request).getHasRole("ROLE_MNG_RSRC")); // 자원예약관리자
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>:: 경기신용보증재단 ::</title>
    
    <%-- 공통 스크립트 --%>
    <%@ include file="/sjpb/reference/common/commonScriptInclude.jsp"  %>
    <%-- 공통 스크립트 --%>
    
    <%-- 작성화면용 에디터 + upload 처리 --%>
    <script type="text/javascript" src="${cPath }/board/smarteditor/js/HuskyEZCreator.js"></script>
    <script type="text/javascript" src="${cPath }/sjpb/reference/js/jquery.ekrEditor-1.0.js"></script>
    <script type="text/javascript" src="${cPath }/sjpb/reference/js/ekr_editor.js"></script>
    <%-- // end --%>
    
    <%-- 자원예약용 --%>
    <script type="text/javascript" src="${cPath }/sjpb/reference/js/resource.js"></script>
    
    <script type="text/javascript">
        <!--
        window.onload = ekrFile.edit_init;
        //-->
	    function fn_search(){
	        fn_page();
	    }
	    // 페이지 조회
        function fn_page(page) {
            if(page == undefined) page = 1;
            //$('#frm').attr({action:'/rsrc/selectResourceList.face?cPage='+page}).submit();
            $('#frm').attr({action:'/rsrc/selectResourceList.face'}).submit();
        }
	    
	    function fn_ajaxRsrcSearchSuccess(data) {
            if (data.status == "SUCCESS") {
                $('#reserve_frm label[id="req_usr_nm"]').text(data.data.REQ_USR_NM);
//                 $('#reserve_frm label[id="rsrc_lctn"]').text(data.data.RSRC_LCTN);
                $('#reserve_frm label[id="rsrc_cntns"]').text(data.data.RSRC_CNTNS);
//                 $('#reserve_frm label[id="rsrc_cnt"]').text(data.data.RSRC_CNT);
                $('#reserve_frm label[id="rsrc_mgt_nm"]').text(data.data.RSRC_MGT_NM);
                $('#reserve_frm label[id="rsrc_ddcnt"]').text(data.data.RSRC_DDCNT + "일 전");
            }
        }
        
        function fn_ajaxError(data) {
        }
	    
	    // 예약현황
        function fn_reservation(obj,rsrc_id,week){
	    	
        	var week = week == undefined ? '' : week;
	    	var btn_class = $(obj).find('span').attr('class');
	    	
	    	if(btn_class != undefined) {
	    		if(btn_class == 'icon_slidedown') {
	    			
	    			 if(parent.autoresize_iframe_etc_portlet) parent.autoresize_iframe_etc_portlet();
	    			$('#select_date').val("");
	    		} else {
	    			 if(parent.autoresize_iframe_etc_portlet) parent.autoresize_iframe_etc_portlet();
	    			return;
	    		}
	    	}
	    	$('#rsrc_id').val(rsrc_id);
	    	url = "/rsrc/selectResourceViewWeekAjax.face?rsrc_id="+rsrc_id+"&week="+week;
            $.ajax({
                type : "post",
                url : url,
                data : $('#frm').serialize(),
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
                            var first_day = json.data[0].YYYYMMDD.substr(4,2) + '월 ' + json.data[0].YYYYMMDD.substr(6,2) + '일';
                            var last_day  = json.data[6].YYYYMMDD.substr(4,2) + '월 ' + json.data[6].YYYYMMDD.substr(6,2) + '일';
                            
                            var html = "";
                            html += '<tr>';
                            html +=     '<th scope="row"><font color="'+color+'">'+dd+'('+k_day+')</font></th>';
                            
                            for(var j=0; j<val.length;j++) {
                            	   html += '<td style="cursor:pointer"';
                            	if(val[j].search('NO') != -1)  {
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
                            
                          $('#' + rsrc_id + '_table').append(html);
                          $('#' + rsrc_id + '_first_day').html('<strong>'+first_day+'</strong>');
                          $('#' + rsrc_id + '_last_day').html('<strong>'+last_day+'</strong>');
                          
                          $('#select_date').val(json.data[0].YYYYMMDD); // 날짜값 세팅
                          
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
            
            if(parent.autoresize_iframe_etc_portlet) parent.autoresize_iframe_etc_portlet();
        }
	    
        // 자원삭제
        function fn_resourceDel(){
        	var chk_len = $('.basic_table tr input:checkbox:gt(0):checked').length;
        	if(chk_len <= 0) {
        		alert("자원을 1개 이상 선택해주세요");
        		return;
        	}
        	
        	if(confirm("선택한 자원을 삭제하시겠습니까?")){
        		fn_ajax({
                    url : "${cPath}/rsrc/deleteResourceAjax.face",  
                    param : $('#frm').serialize() + "&" + $("[id=check]").serialize(), 
                    callback : {success : function (data) {resourceDelSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
                });	
        	}
        }
        // 자원삭제 콜백
        function resourceDelSuccess(data){
        	if (data.status == "SUCCESS") {
                alert("정상적으로 처리되었습니다.");
                fn_search();
            }
        }
        
        //전체체크
        function fn_checkAll(){
        	var chk_len = $('#AllCheck:checked').length;
            $checkboxs = $('.basic_table input:checkbox:gt(0)');
            
            if(chk_len > 0){
            	$checkboxs.prop('checked', true);   
            }else{
            	$checkboxs.prop('checked',false);
            }
        }
        
        function fn_showResourceImg(url) {
        	
           framecode = "<frameset rows='1*'>" 
        	   + "<frame name=main src='" + url + "'>" 
        	   + "</frameset>"; 

        	   page = window.open(""); 
        	   page.document.open(); 
        	   page.document.write(framecode); 
        	   page.document.close(); 
        }
        
        $(document).ready(function(){
            
            // list count 변경 이벤트
            $('select[name*="list_cnt"]').change(function(event){
                $('select[name*="list_cnt"]').val(this.value);
                $('#list_cnt').val(this.value);
                fn_search();
            });
            
            // 버튼 이벤트
            $('a[name*="btn"]').bind('click',function(event){
                switch (this.name){
                    case "btn_search"   : fn_search(); break; // 조회
                    case "btn_rsrc_reg" : fn_resourceAdd(); break; // 자원등록
                    case "btn_rsrc_del" : fn_resourceDel(); break; // 자원삭제
                }
            });
            
            $('fieldset input:text').keydown(function(key){ //검색 필드 엔터키 입력시 조회
                if(key.keyCode == '13') fn_search();
            });
        });
        
    </script>
    <style type="text/css">
	    .subject_calendar td .self_req{color:#a5c667; text-align:center;   padding-top:27px; background:url(/sjpb/reference/images/icon_flag_green.png) no-repeat 10px center;}
	    .subject_calendar td .other_req{color:#fa4f03; text-align:center;  padding-top:27px; background:url(/sjpb/reference/images/icon_flag_orange.png) no-repeat 10px center;}
	    .subject_calendar td .impossible{color:#c5c5c5; text-align:center; padding-top:27px; background:url(/sjpb/reference/images/icon_flag_gray.png) no-repeat 10px center;}
    </style>
</head>
<body>
    <jsp:include page="layer_popup_list.jsp"/>
    <div class="sub_container">
        <!-- content start -->
        <div id="content">
            <h4>자원현황</h4>
            <div class="board_search">
                <form name="frm" id="frm" method="post" target="_self">
	            <fieldset>
	                <select name="dept_cd">
                        <option value="">전체부서</option>
                        <c:forEach var="dept" items="${dept}" varStatus="status">
                            <option value="${dept.CODE}" <c:if test="${dept.CODE eq sMap.dept_cd}"> selected="selected" </c:if>>${dept.NAME}</option>
                        </c:forEach>
                    </select>
                    
	                <select name="rsrc_clsf">
                        <option value="">자원구분</option>
                        <c:forEach var="rsrc_clsf" items="${rsrc_clsf}" varStatus="status">
                            <option value="${rsrc_clsf.CODE}" <c:if test="${rsrc_clsf.CODE eq sMap.rsrc_clsf}"> selected="selected" </c:if>>${rsrc_clsf.NAME}</option>
                        </c:forEach>
                    </select>
	                <label class="hide "for="" >자원구분</label><input type="text" id="rsrc_nm" name="rsrc_nm" placeholder="자원명" />
	                <input type="hidden" id="list_cnt" name="list_cnt" value="${sMap.list_cnt}"/>
	                <input type="hidden" id="select_date" name="select_date"/>
	                
	                <a href="#" class="btn_white" name="btn_search"><span class="icon_search"></span>검색</a>
	            </fieldset>
	            </form>
            </div>
            
            <div class="board_top">
                <div class="board_total board_btn_L">
                    총 <strong>${page.total }</strong>건 <strong>(${page.currentPage }/${page.pages })</strong>
                    <select  id="list_cnt_top" name="list_cnt_top">
                        <option value="10" <c:if test="${sMap.list_cnt eq '10'}"> selected="selected" </c:if>>10개</option>
                        <option value="20" <c:if test="${sMap.list_cnt eq '20'}"> selected="selected" </c:if>>20개</option>
                        <option value="50" <c:if test="${sMap.list_cnt eq '50'}"> selected="selected" </c:if>>50개</option>
                    </select>
                </div>
                <div class="board_btn_R">
                        <c:if test="${adminChk eq 'Y' || admin eq 'true'}">
		                    <a href="#" class="btn_white" name="btn_rsrc_del">삭제</a>
		                    <a href="#" class="btn_black" name="btn_rsrc_reg">등록</a>
		                </c:if>
                    </div>
                </div>

                <!-- 목록 -->
                <table class="basic_table" summary="">
                    <caption>자원현황 목록</caption>
                    <colgroup>
                        <c:if test="${admin eq 'true' || adminChk eq 'Y'}">
                        <col width="80" />
                        </c:if>
                        <col width="*" />
                        <col width="200" />
<%--                         <col width="100" /> --%>
<%--                         <col width="90" /> --%>
                    </colgroup>
                    <thead>
                        <tr>
                            <c:if test="${admin eq 'true' || adminChk eq 'Y'}">
                            <th scope="col"><label for="AllCheck" class="hide">전체선택</label><input type="checkbox" id="AllCheck" onclick="fn_checkAll()"/></th>
                            </c:if>
                            <th scope="col">자원</th>
                            <th scope="col">운영자</th>
<!--                             <th scope="col">위치</th> -->
<!--                             <th scope="col" class="last">좌석수</th> -->
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="list" items="${list}" varStatus="status">
                     <tr class="">
                        <c:if test="${admin eq 'true' || adminChk eq 'Y'}">
                        <td class="num"><label for="BoardList2" class="hide">선택</label><input type="checkbox" name="check" value="${list.RSRC_ID}" id="check"/></td>
                        </c:if>
                        <td class="subject">
                            <div class="subject_reserved">
                                <div class="thum">
                                    <c:choose>
                                        <c:when test="${list.FILE_ID ne null}">
                                            <img src="/upload/common/attach/${list.FILE_PATH}" alt="" width="98" height="58" />
                                            <button name="" title="원본보기" onclick="javascript:fn_showResourceImg('/upload/common/attach/${list.FILE_PATH}')">사진 크게보기</button>
                                        </c:when>
                                        <c:when test="${list.FILE_ID eq null || list.FILE_ID eq ''}">
                                        	<%-- 
                                        	<img src="${cPath}/sjpb/reference/images/img_subject_reserved.gif" alt="" width="98" height="58" />
                                        	 --%>
                                            <img src="${cPath}/upload/board/thumb/no.gif" alt="" width="98" height="58" />
                                        </c:when>
                                    </c:choose>
                                </div>
                                <div class="text">
                                <c:choose>
                                    <c:when test="${admin eq 'true' || adminChk eq 'Y'}">
                                        <a href="javascript:fn_resourceDetail('${list.RSRC_ID}')"><strong><c:out value="${list.RSRC_NM}"/></strong><br/></a>
                                    </c:when>
                                    <c:otherwise>
                                        <strong><c:out value="${list.RSRC_NM}"/></strong><br />
                                    </c:otherwise>
                                </c:choose>
                                    신청- <c:out value="${list.RSRC_DDCNT}"/>일전/자원사용:<c:out value="${list.ABLE eq 'Y' ? '가능' : '불가능'}" /><c:if test="${list.ABLE eq 'N' && list.ABLE ne ''}"><font color="red">(<c:out value="${list.ABLE_RSN}"/>)</font></c:if> 
                                </div>
                                <div class="btn">
                                    <c:if test="${admin eq 'true' || adminChk eq 'Y' || list.RSRC_MGT_ID eq usrId}">
                                    <a href="#" class="btn_green" onclick="fn_rsrcAble(${list.RSRC_ID})">사용관리</a>
                                    </c:if>
                                    <a class="btn_darkorange" onclick="fn_reservation(this,'${list.RSRC_ID}','')">예약하기<span class="icon_slidedown"></span></a>
                                </div>
                            </div>
                        </td>
                        <td class=""><a href="javascript:fn_getUserInfoPopup('${list.RSRC_MGT_ID}')"><span class="icon_user" style="cursor: pointer;" ></span>${list.RSRC_MGT_NM}</a></br>
                        <c:if test="${list.RSRC_MGT_DEPT_NM ne null || list.RSRC_MGT_DEPT_NM ne ''}"><c:out value="${list.RSRC_MGT_DEPT_NM}"/></c:if></td>
<%--                         <td class=""><c:out value="${list.RSRC_LCTN}"/></td> --%>
<%--                         <td class=""><c:out value="${list.RSRC_CNT}"/></td> --%>
                    </tr>
                    <tr class="view">
                       <td colspan='<c:out value="${(admin eq 'true' || adminChk eq 'Y') ? '3' : '2'}" />'>
                           <table summary="" class="subject_calendar" id="<c:out value="${list.RSRC_ID}"/>_table">
						       <caption></caption>
						       <colgroup>
						           <col style="width:54px" />
						           <col style="width:auto" />
						       </colgroup>
						       <tbody>
				                    <tr class="bdb">
				                        <th rowspan="2" scope="col"">날짜/시간</th>
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
                            <div class="board_page" style="margin-top:10px;">
                                <a href="#" class="page_prev" onclick="fn_reservation(this,'${list.RSRC_ID}','prev')">이전 페이지</a>&nbsp;
                                    <a href="#">&nbsp;<label id="${list.RSRC_ID}_first_day"></label>&nbsp;</a>
							         ~
                                    <a href="#">&nbsp;<label id="${list.RSRC_ID}_last_day"></label>&nbsp;</a>
                                    &nbsp;<a href="#" class="page_next" onclick="fn_reservation(this,'${list.RSRC_ID}','next')">다음 페이지</a>
                            </div>
                       </td>
                   </tr>
                    </c:forEach>
                     <c:if test="${empty list}">
                    <tr class="">
                        <td colspan='<c:out value="${(admin eq 'true' || adminChk eq 'Y') ? '5' : '4'}" />'>조회된 결과가 없습니다.</td>
                    </tr>
                    </c:if>
                 </tbody>
             </table>
             <div class="board_bottom">
                <div class="board_total board_btn_L">
                    총 <strong>${page.total }</strong>건 <strong>(${page.currentPage }/${page.pages })</strong>
                    <select  id="list_cnt_bot" name="list_cnt_bot">
                        <option value="10" <c:if test="${sMap.list_cnt eq '10'}"> selected="selected" </c:if>>10개</option>
                        <option value="20" <c:if test="${sMap.list_cnt eq '20'}"> selected="selected" </c:if>>20개</option>
                        <option value="50" <c:if test="${sMap.list_cnt eq '50'}"> selected="selected" </c:if>>50개</option>
                    </select>
                </div>
                <div class="board_btn_R">
                    <c:if test="${admin eq 'true' || adminChk eq 'Y'}">
                    <a href="#" class="btn_white" name="btn_rsrc_del">삭제</a>
                    <a href="#" class="btn_black" name="btn_rsrc_reg">등록</a>
                    </c:if>
                </div>
            </div>
    
            <div class="board_page">
                <div class="paging_c">
                    <c:choose>
                        <c:when test="${page.currentPage == 1 }">
                            <a href="#allpre" class="page_first">처음</a>
                        </c:when>
                        <c:otherwise>
                            <a href="#allpre" class=page_first onclick="fn_page(1);">처음</a>
                        </c:otherwise>
                    </c:choose>
                    
                    <c:choose>
                        <c:when test="${page.currentBeforePage == 1 }">
                            <a href="#pre" class="page_prev">&lt;</a>
                        </c:when>
                        <c:otherwise>
                            <a href="#pre" class="page_prev" onclick="fn_page(${page.currentBeforePage});">&lt;</a>
                        </c:otherwise>
                    </c:choose>
                    
                    <c:if test="${empty list}">
                        <a href="#num">1</a>
                    </c:if>
            
                    <c:if test="${!empty list}">
                        <c:forEach begin="${page.currentStartPage }" end="${page.currentEndPage }" var="i">
                            <c:if test="${page.currentPage != i }"> <!-- 현재 페이지 x -->
                                <a href="#num" onclick="fn_page('<c:out value="${i}" escapeXml="true"/>');">${i }</a>
                            </c:if>
                            <c:if test="${page.currentPage == i }"> <!-- 현재 페이지 o -->
                                <!-- <a href="#num" class="pg_on">${i }</a> -->
                                <a href="#num" ><strong>${i}</strong></a>
                            </c:if>
                        </c:forEach>
                    </c:if>
                    <c:choose>
                        <c:when test="${(page.currentNextPage == page.pages && page.pages%page.pageCount != 1) || (page.pages == 1)}">
                            <a href="#next" class="page_next">&gt;</a>
                        </c:when>
                        <c:otherwise>
                            <a href="#next" class="page_next" onclick="fn_page(<c:out value="${page.currentNextPage}" escapeXml="true"/>);">&gt;</a>
                        </c:otherwise>
                    </c:choose>
            
                    <c:choose>
                        <c:when test="${page.currentPage == page.pages}">
                            <a href="#all_next" class="page_last">마지막</a>
                        </c:when>
                        <c:otherwise>
                            <a href="#all_next" class="page_last" onclick="fn_page(<c:out value="${page.pages}" escapeXml="true"/>);">마지막</a>
                        </c:otherwise>
                    </c:choose>
                </div>    
            </div>
        </div>
        
        <!-- //content end -->
    </div>
</body>
</html>

        