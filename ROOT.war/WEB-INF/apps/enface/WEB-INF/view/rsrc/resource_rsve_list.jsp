<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %>
<%@page import="com.saltware.enface.util.DateUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="rfrc" uri="/WEB-INF/tld/reference.tld" %>
<%
    request.setAttribute("cPath", request.getContextPath());
    request.setAttribute("fromDate", DateUtil.getCurrentDate("yyyy.MM.dd"));
    request.setAttribute("toDate", DateUtil.formatDate(DateUtil.addDay(DateUtil.getCurrentDate(), +7),"."));
    request.setAttribute("usrId",  EnviewSSOManager.getUserInfo(request).getUserId()); // 로그인사용자
    //request.setAttribute("admin",  true);
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
    <script type="text/javascript" src="${cPath }/sjpb/reference/js/ekr_editor.js"></script>
    <script type="text/javascript" src="${cPath}/javascript/jquery/jquery.blockUI.js"></script>
    <%-- // end --%>
    
    <script type="text/javascript">
	    function fn_search(){
	        //fn_page();
			$('#frm').attr({action:'/rsrc/selectResourceMyRsveList.face'}).submit();
	    }
	    // 페이지 조회
        function fn_page(page) {
            if(page == undefined) page = 1;
            $('select[name*="list_cnt"]').val(this.value);
            $("#cPage").val(page);
            $('#frm').attr({action:'/rsrc/selectResourceMyRsveList.face'}).submit();
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
            	$('#frm select[name="rsrc_id"] option:gt(0)').remove();
                if (data.data.length > 0){
                    var html = "";
                    $(data.data).each(function () {
                        html += "<option value=" + this.RSRC_ID+ ">" + this.RSRC_NM + "</option>";
                    });
                    $('#frm select[name="rsrc_id"]').append(html);
                }
            }
        }
        
        function fn_ajaxError(data) {
        }
	    
        //전체선택,해제
        function fn_checkAll(){
        	var chk_len = $('#AllCheck:checked').length;
            $checkboxs = $('.basic_table input:checkbox:gt(0)');
            
            if(chk_len > 0){
            	$checkboxs.prop('checked', true);   
            }else{
            	$checkboxs.prop('checked',false);
            }
        }
        
        // 자원예약삭제
        function fn_bookDel(){
        	// 전체선택이 없다.
            var chk_len = $('.basic_table tr input:checkbox:checked').length;
            if(chk_len <= 0) {
                alert("자원예약을 1개 이상 선택해주세요");
                return;
            } 
            if(confirm("선택한 자원예약을 삭제하시겠습니까?")){
                fn_ajax({
                    url : "${cPath}/rsrc/deleteRsrcResveAjax.face",  
                    param : $('#frm').serialize(), 
                    callback : {success : function (data) {fn_bookDelSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
                }); 
            }
        }
        // 자원예약삭제 콜백
        function fn_bookDelSuccess(data){
            if (data.status == "SUCCESS") {
                alert("정상적으로 처리되었습니다.");
                fn_search();
            }
        }

        //접수처리 팝업
        function fn_rceptView(opr_id,opr_nm){
        	$('div.layerpopup_L').text(opr_nm);
            fn_ajax({
                url : "${cPath}/rsrc/selectResveDetailAjax.face"
                , param : "opr_id="+ opr_id
                , callback : {success : function (data) {fn_rceptViewSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
            });
        }
        // 자원예약정보
        function fn_rceptViewSuccess(data){
            if (data.status == "SUCCESS") {
            	/*팝업을 보여줌*/
                $('#rcept_pop').draggable();
                //$('#rcept_pop').show();
                
                var obj     = data.resve;
                var strt_tm = obj.OPR_STRT_TM.substr(0,2) +":"+ obj.OPR_STRT_TM.substr(2,2);
                var end_tm  = obj.OPR_END_TM.substr(0,2)  +":"+ obj.OPR_END_TM.substr(2,2);
                
                $('#opr_req_rgsrt_nm').text(obj.OPR_REQ_RGSRT_NM);
                $('#opr_req_rgsrt_dept_nm').text(obj.OPR_REQ_RGSRT_DEPT_NM);
                $('#opr_cntns').text(obj.OPR_CNTNS);
                $('#opr_tm').text(obj.OPR_STRT_DT + " " + strt_tm + " 부터 " + obj.OPR_END_DT + " " + end_tm + " 까지");
                $('#opr_use_plc').text(obj.OPR_USE_PLC);
                $('#opr_apv_cntns').val(obj.OPR_APV_CNTNS);
                
                $('form[id="rcept_frm"] input[name="opr_id"]').val(obj.OPR_ID);
                
                if (obj.OPR_APV_CLSF == 0 || obj.OPR_APV_CLSF == 2) {
                	$("#btn_approval").show();
                	$("#btn_return").hide();
                } else {
                	$("#btn_approval").hide();
                	$("#btn_return").show();
                }
                
                $.blockUI({ 
                    message : $("#rcept_pop") , 
                        css : { border : 'none'
                              , top : '25%'
                              , cursor : 'default'
                              }, 
                  focusInput: false,
                  overlayCSS: { backgroundColor: '#000'
                              , opacity: 0.6
                              , cursor:  'default' 
                              } 
                });
            }
        }
        
        function fn_ajaxError(data) {
        }
        
        //접수처리 
        function fn_rceptSave(div){
        	$('form[id="rcept_frm"] input[name="opr_apv_clsf"]').val(div);        	
        	var txt = div == "1"? "승인" : "승인취소";
        	if(confirm(txt+"처리 하시겠습니까?")){
	            fn_ajax({
	               param: $('#rcept_frm').serialize(),
	                url : "${cPath}/rsrc/updateBookJudgeAjax.face"
	                , callback : {success : function (data) {fn_rceptSaveSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
	            });
        	}
        }
        // 접수처리 콜백
        function fn_rceptSaveSuccess(data){
            if (data.status == "SUCCESS") {
            	alert("정상적으로 처리되었습니다");
                fn_search();                
            }
        }
        
        function fn_saveExcel() {
        	$('#frm').attr({action:'${cPath }/rsrc/excelDownload.face'}).submit();
        }
        
        $(document).ready(function(){
        	
        	$( "#opr_strt_dt, #opr_end_dt" ).datepicker({
                showOn: "both",
                buttonImage: "${cPath }/sjpb/reference/images/icon_calendar.png",
                buttonImageOnly: true,
                buttonText: "일자선택" 
            });
        	
        	// 시작일자를 지정하면 종료일자를 시작일자 이후로만 지정되도록 처리
        	// 종료일자는 오늘 이전을 지정 할 수 없다.
        	$("#opr_end_dt").datepicker("option", "minDate", $("#opr_strt_dt").val());
        	$("#opr_strt_dt").datepicker("option", "onClose", function (date) {
        		$("#opr_end_dt").datepicker("option", "minDate", date);
        	});
        	
            // list count 변경 이벤트
            $('select[name*="list_cnt"]').change(function(event){
                $('select[name*="list_cnt"]').val(this.value);
                $('#list_cnt').val(this.value);
                fn_search();
            });
            // 부서코드 체인지 이벤트
            $('select[name="dept_cd"]').change(function(event){
            	fn_selectRsrcId(); // 자원목록조회
            });
            $('select[name="rsrc_clsf"]').change(function(event){
            	fn_selectRsrcId(); // 자원목록조회
            });
            
            // 버튼 이벤트
            $('a[name*="btn"]').bind('click',function(event){
                switch (this.name){
                    case "btn_search"   : fn_search();  break;       // 조회
                    case "btn_book_del" : fn_bookDel(); break;       // 자원예약삭제
                    case "btn_approval" : fn_rceptSave("1"); break;  // 자원예약승인
                    case "btn_return"   : fn_rceptSave("2"); break;  // 자원예약승인취소
                }
            });
            // 팝업닫기
            $('.popup_close,.btn_close').click(function(){
                
                $(this).each(function(){
                    $(this).parents('div:last').hide();
                    $(this).parents('form').each(function(){this.reset();});
                    $.unblockUI();
                })
            });
        });
    </script>
</head>
<body>
    <div class="sub_container">
        <form name="frm" id="frm" method="post" >
        <input type="hidden" id="authChk" name="authChk" value="Y" />
        <div id="content">
            <h4>자원심사</h4>
            <div class="board_search">
	            <fieldset>
                    <legend>게시물 검색</legend>
                    <select name="opr_apv_clsf"  >
                        <option value="" <c:if test="${ ''  eq param.opr_apv_clsf}"> selected="selected" </c:if> >상태전체</option>
                        <option value="0"<c:if test="${ '0' eq param.opr_apv_clsf}"> selected="selected" </c:if>>승인신청</option>
                        <option value="1"<c:if test="${ '1' eq param.opr_apv_clsf}"> selected="selected" </c:if>>승인완료</option>
                        <option value="2"<c:if test="${ '2' eq param.opr_apv_clsf}"> selected="selected" </c:if>>승인취소</option>
                    </select>
                    <select name="dept_cd">
                        <option value="">전체부서</option>
                        <c:forEach var="dept" items="${dept}" varStatus="status">
                            <option value="${dept.CODE}" <c:if test="${dept.CODE eq param.dept_cd}"> selected="selected" </c:if>>${dept.NAME}</option>
                        </c:forEach>
                    </select>
                    
                    <select name="rsrc_clsf">
                        <option value="">자원구분</option>
                        <c:forEach var="rsrc_clsf" items="${rsrc_clsf}" varStatus="status">
                            <option value="${rsrc_clsf.CODE}" <c:if test="${rsrc_clsf.CODE eq param.rsrc_clsf}"> selected="selected" </c:if>>${rsrc_clsf.NAME}</option>
                        </c:forEach>
                    </select>
                    <select name="rsrc_id"  >
                        <option value="">자원목록</option>
                        <c:forEach var="rsrc" items="${rsrc}" varStatus="status">
                            <option value="${rsrc.RSRC_ID}" <c:if test="${rsrc.RSRC_ID eq param.rsrc_id}"> selected="selected" </c:if>>${rsrc.RSRC_NM}</option>
                        </c:forEach>
                    </select>
                    <%--
                    <script>
                    	$(function() {
                    		$( "#opr_strt_dt, #opr_end_dt" ).datepicker({
                    			dateFormat:'yy.mm.dd'
                    		});
                    	});
                    </script>
                     --%>
                    <label for="" class="cursor"><input type="text" id="opr_strt_dt" name="opr_strt_dt" readonly   class="w80" maxlength="" value="${param.opr_strt_dt eq null ? fromDate : param.opr_strt_dt}"/> </label> ~ 
                    <label for="" class="cursor" ><input type="text" id="opr_end_dt" name="opr_end_dt" readonly  class="w80"  maxlength=""  value="${param.opr_end_dt eq null ? toDate : param.opr_end_dt}"/> </label>
                    <a href="#" class="btn_white" name="btn_search"><span class="icon_search" ></span>검색</a>
                    <input type="hidden" id="list_cnt" name="list_cnt" value="${page.listCount}"/><!-- rowcount 수 -->
                    <input type="hidden" id="cPage" name="cPage" value="<c:out value="${empty param.cPage ? '1' : param.cPage }"/>"/>
                </fieldset>
            </div>
            
            <div class="board_top">
                <div class="board_total board_btn_L">
                    총 <strong>${page.total }</strong>건 <strong>(${page.currentPage }/${page.pages })</strong>
                    <select  id="list_cnt_top" name="list_cnt_top">
                        <option value="10" <c:if test="${param.list_cnt eq '10'}"> selected="selected" </c:if>>10개</option>
                        <option value="20" <c:if test="${param.list_cnt eq '20'}"> selected="selected" </c:if>>20개</option>
                        <option value="50" <c:if test="${param.list_cnt eq '50'}"> selected="selected" </c:if>>50개</option>
                    </select>
                </div>
                <div class="board_btn_R">
                	<%-- 
                    <a href="javascript:void(0);" onclick="fn_saveExcel();" class="btn_white">엑셀</a>
                    <c:if test="${admin eq true}">
                    <a href="javascript:void(0);" target="_self" onclick="fn_print('list');" class="btn_white" ><span class="icon_print"></span>인쇄</a>
                    </c:if>
                     --%>
                </div>
            </div>
                <!-- 목록 -->
            <div id="list">
            <table class="basic_table" summary="">
                <caption>자원심사 목록</caption>
                <colgroup>
                    <col width="80" />
                    <col width="90" />
                    <col width="*" />
                    <col width="300" />
                    <col width="140" />
                    <col width="140" />
                </colgroup>
                <thead>
                    <tr>
                        <!-- <th scope="col"><label for="AllCheck" class="hide">전체선택</label> -->
                        <th scope="col">상태</th>
                        <th scope="col">신청일</th>
                        <th scope="col">자원(예약일자)</th>
                        <th scope="col">신청내역</th>
                        <th scope="col">담당수사관</th>
                        <th scope="col">신청자</th>
                    </tr>
                </thead>
                <tbody>
	                <c:forEach var="list" items="${list}" varStatus="status">
	                <tr class="">
	                    <td class="">
	                     <c:if test="${list.OPR_APV_CLSF eq '0'}"><font color='blue'>승인신청</font></c:if>
	                     <c:if test="${list.OPR_APV_CLSF eq '1'}"><font color='red'>승인완료</font></c:if>
	                     <c:if test="${list.OPR_APV_CLSF ne '0' && list.OPR_APV_CLSF ne '1'}">승인취소</c:if>
	                    </td>
	                    <td class=""><c:out value="${list.OPR_REQ_RGSRT_DT}"/></td>
	                    <td class="subject">
	                        <b><strong><c:out value="${list.RSRC_NM}"/></strong></b><br/>
	                        <c:out value="${list.OPR_STRT_TM}"/> ~ <c:out value="${list.OPR_END_TM}"/><br/>
	                    </td>
	                    <td class="left">
	                        <strong><c:out value="${list.OPR_CNTNS}"/></strong><br />
<%-- 	                        <font color="blue">참여대상:<c:out value="${list.OPR_USE_CNTNS}"/></font> --%>
	                    </td>
	                    <td class=""><a href="javascript:fn_getUserInfoPopup('${list.OPR_CHR_RGSRT_ID}')" ><span class="icon_user" style="cursor: pointer;"></span><c:out value="${list.OPR_CHR_RGSRT_NM}"/></a></br>
	                       	<c:out value="${list.OPR_CHR_RGSRT_DEPT_NM}"/>
	                    </td>	                    
	                    <td class=""><a href="javascript:fn_getUserInfoPopup('${list.OPR_REQ_RGSRT_ID}')" ><span class="icon_user" style="cursor: pointer;"></span><c:out value="${list.OPR_REQ_RGSRT_NM}"/></a></br>
	                       	<c:out value="${list.OPR_REQ_RGSRT_DEPT_NM}"/>
	                    </td>
	                    <!--<c:out value="${list.OPR_ID}"/>-->
	                </tr>
	                </c:forEach>
	                 <c:if test="${empty list}">
	                <tr class="">
	                    <td colspan="6">조회된 결과가 없습니다.</td>
	                </tr>
	                </c:if>
	             </tbody>
	         </table>
	         </div>
	         <div class="board_bottom">
	            <div class="board_total board_btn_L">
	                총 <strong>${page.total }</strong>건 <strong>(${page.currentPage }/${page.pages })</strong>
	                <select  id="list_cnt_bot" name="list_cnt_bot">
	                    <option value="10" <c:if test="${param.list_cnt eq '10'}"> selected="selected" </c:if>>10개</option>
	                    <option value="20" <c:if test="${param.list_cnt eq '20'}"> selected="selected" </c:if>>20개</option>
	                    <option value="50" <c:if test="${param.list_cnt eq '50'}"> selected="selected" </c:if>>50개</option>
	                </select>
	            </div>
	            <div class="board_btn_R">
	            	<%-- 
	                <a href="javascript:void(0);" onclick="fn_saveExcel();" class="btn_white">엑셀</a>
	                <c:if test="${admin eq true}">
	                <a href="javascript:void(0);" target="_self" onclick="fn_print('list');" class="btn_white" ><span class="icon_print"></span>인쇄</a>
	                </c:if>
	                 --%>
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
        </form>
        <!-- //content end -->
    </div>
    
    <!-- GNB090507xx start -->
    
    <div class="sub_layer_popup" id="rcept_pop" style="width:600px; display:none; margin-top:-200px; margin-left:-300px;" >
    <form id="rcept_frm">
        <div class="layer_popup_header">자원심사
            <a class="popup_close" title="닫기" >닫기</a>
        </div>
        <div class="layer_popup_white">
            <div class="layerpopup_top">
                <div class="layerpopup_L">
                </div>
                <!-- 
                <div class="layerpopup_R">
                    <a href="#" class="btn_white">심사내역 엑셀다운</a>
                </div>
                 -->
            </div>
            <table class="popup_board_table" summary="자원심사">
                <caption>자원심사</caption>
                <colgroup>
                    <col style="width:120px;" />
                    <col style="width:auto;" />
                </colgroup>
                <tbody>
                    <tr>
                         
                        <th scope="row">신청자</th>
                        <td><input type="hidden" name="opr_id" />
                            <input type="hidden" name="opr_apv_clsf"/>     
                            <label id="opr_req_rgsrt_nm"></label> /
                            <label id="opr_req_rgsrt_dept_nm"></label>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">사용목적</th>
                        <td><label id="opr_cntns"></label></td>
                    </tr>
                    <tr>
                        <th scope="row">예약일시</th>
                        <td><label id="opr_tm"></label></td>
                    </tr>
                    <tr>
                        <th scope="row">사용장소</th>
                        <td><label id="opr_use_plc"></label></td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="">심사의견</label></th>
                        <td><textarea id="opr_apv_cntns"name="opr_apv_cntns"></textarea></td>
                    </tr>
                </tbody>
            </table>
            <div class="layerpopup_bottom tx_c">
                <a href="#" class="btn_black" id="btn_approval" name="btn_approval">승인</a>
                <a href="#" class="btn_black" id="btn_return" name="btn_return">승인취소</a>
                <a href="#" class="btn_orange btn_close">닫기</a>
                <!-- //사용관리등록 -->
            </div>
        </div>
    </form>
    </div>
</body>
</html>

        