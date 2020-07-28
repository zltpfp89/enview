<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setAttribute("cPath", request.getContextPath());
%>
<%--
<html>
<head>
</head>
<body>
    <div class="sub_layer_popup" id="reserve_pop">
        <div class="layer_popup_header">자원예약
            <a href="javascript:void(0);" onclick="$('#reserve_pop').hide();" target="_self" class="popup_close" title="닫기" >닫기</a>
        </div>
 --%>        
        <form id="reserve_frm">
        <c:if test="${opr_id != '' || opr_id != null}">
            <input type="hidden" name="opr_id" value="${opr_id}">
        </c:if>
        <div class="layer_popup_white">
            <div class="layerpopup_top">
                <div class="layerpopup_L">
                    <label id="rsrc_nm"></label>
                </div>
            </div>
            <div>
                <select name="dept_cd">
                    <option value="">전체부서</option>
                    <c:forEach var="dept" items="${dept}" varStatus="status">
                        <option value="${dept.CODE}">${dept.NAME}</option>
                    </c:forEach>
                </select>
                
                <select name="rsrc_clsf">
                    <option value="">자원구분</option>
                    <c:forEach var="rsrc_clsf" items="${rsrc_clsf}" varStatus="status">
                        <option value="${rsrc_clsf.CODE}" >${rsrc_clsf.NAME}</option>
                    </c:forEach>
                </select>
                <select name="rsrc_id">
                   <c:forEach var="rsrc" items="${rsrc}" varStatus="status">
                        <option value="${rsrc.RSRC_ID}" >${rsrc.RSRC_NM}</option>
                    </c:forEach>
               </select>
               <c:if test="${not empty param.cnfrPopChk }">
               	    <a class="cursor btn_black" style="float: right;" onclick="javascript: fn_getResourceListForCnfr();">예약현황조회</a>
               </c:if>
            </div>
            <table class="popup_board_table" summary="자원예약" style="margin-top:20px;">
                <caption>자원예약</caption>
                <colgroup>
                    <col style="width:120px;" />
                    <col style="width:auto;" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">예약일시</th>
                        <td>
                            <!-- <script>$(function() {$( "#opr_strt_dt, #opr_end_dt" ).datepicker({dateFormat:'yy.mm.dd'});});</script> -->
                            <label for="opr_strt_dt" class="cursor">
                            	<input type="text" id="opr_strt_dt" name="opr_strt_dt" readonly="readonly" value="${empty vo.opr_strt_dt ? today : vo.opr_strt_dt}" class="w80" maxlength="10" />
                            	 <%-- <img src="${cPath}/sjpb/reference/images/icon_calendar.png" alt="" /> --%>
                            </label>
                            <select name="opr_strt_tm">
                                <option value="0900" <c:if test="${vo.opr_strt_tm eq '0900' }">selected="selected"</c:if>>09:00</option>
                                <option value="0930" <c:if test="${vo.opr_strt_tm eq '0930' }">selected="selected"</c:if>>09:30</option>
                                <option value="1000" <c:if test="${vo.opr_strt_tm eq '1000' }">selected="selected"</c:if>>10:00</option>
                                <option value="1030" <c:if test="${vo.opr_strt_tm eq '1030' }">selected="selected"</c:if>>10:30</option>
                                <option value="1100" <c:if test="${vo.opr_strt_tm eq '1100' }">selected="selected"</c:if>>11:00</option>
                                <option value="1130" <c:if test="${vo.opr_strt_tm eq '1100' }">selected="selected"</c:if>>11:30</option>
                                <option value="1200" <c:if test="${vo.opr_strt_tm eq '1200' }">selected="selected"</c:if>>12:00</option>
                                <option value="1230" <c:if test="${vo.opr_strt_tm eq '1230' }">selected="selected"</c:if>>12:30</option>
                                <option value="1300" <c:if test="${vo.opr_strt_tm eq '1300' }">selected="selected"</c:if>>13:00</option>
                                <option value="1330" <c:if test="${vo.opr_strt_tm eq '1330' }">selected="selected"</c:if>>13:30</option>
                                <option value="1400" <c:if test="${vo.opr_strt_tm eq '1400' }">selected="selected"</c:if>>14:00</option>
                                <option value="1430" <c:if test="${vo.opr_strt_tm eq '1430' }">selected="selected"</c:if>>14:30</option>
                                <option value="1500" <c:if test="${vo.opr_strt_tm eq '1500' }">selected="selected"</c:if>>15:00</option>
                                <option value="1530" <c:if test="${vo.opr_strt_tm eq '1530' }">selected="selected"</c:if>>15:30</option>
                                <option value="1600" <c:if test="${vo.opr_strt_tm eq '1600' }">selected="selected"</c:if>>16:00</option>
                                <option value="1630" <c:if test="${vo.opr_strt_tm eq '1630' }">selected="selected"</c:if>>16:30</option>
                                <option value="1700" <c:if test="${vo.opr_strt_tm eq '1700' }">selected="selected"</c:if>>17:00</option>
                                <option value="1730" <c:if test="${vo.opr_strt_tm eq '1730' }">selected="selected"</c:if>>17:30</option>
                                <option value="1800" <c:if test="${vo.opr_strt_tm eq '1800' }">selected="selected"</c:if>>18:00</option>
                                <option value="1830" <c:if test="${vo.opr_strt_tm eq '1830' }">selected="selected"</c:if>>18:30</option>
                            </select>
                            ~ 
                            <label for="opr_end_dt" class="cursor">
                            	<input type="text" id="opr_end_dt" name="opr_end_dt" readonly="readonly" value="${empty vo.opr_end_dt ? today : vo.opr_strt_dt}" class="w80" maxlength="10"  />
                            	 <%-- <img src="${cPath}/sjpb/reference/images/icon_calendar.png" alt="" /> --%>
                           	</label>             
                            <select name="opr_end_tm">
                                <option value="0930" <c:if test="${vo.opr_end_tm eq '0930' }">selected="selected"</c:if>>09:30</option>
                                <option value="1000" <c:if test="${vo.opr_end_tm eq '1000' }">selected="selected"</c:if>>10:00</option>
                                <option value="1030" <c:if test="${vo.opr_end_tm eq '1030' }">selected="selected"</c:if>>10:30</option>
                                <option value="1100" <c:if test="${vo.opr_end_tm eq '1100' }">selected="selected"</c:if>>11:00</option>
                                <option value="1130" <c:if test="${vo.opr_end_tm eq '1100' }">selected="selected"</c:if>>11:30</option>
                                <option value="1200" <c:if test="${vo.opr_end_tm eq '1200' }">selected="selected"</c:if>>12:00</option>
                                <option value="1230" <c:if test="${vo.opr_end_tm eq '1230' }">selected="selected"</c:if>>12:30</option>
                                <option value="1300" <c:if test="${vo.opr_end_tm eq '1300' }">selected="selected"</c:if>>13:00</option>
                                <option value="1330" <c:if test="${vo.opr_end_tm eq '1330' }">selected="selected"</c:if>>13:30</option>
                                <option value="1400" <c:if test="${vo.opr_end_tm eq '1400' }">selected="selected"</c:if>>14:00</option>
                                <option value="1430" <c:if test="${vo.opr_end_tm eq '1430' }">selected="selected"</c:if>>14:30</option>
                                <option value="1500" <c:if test="${vo.opr_end_tm eq '1500' }">selected="selected"</c:if>>15:00</option>
                                <option value="1530" <c:if test="${vo.opr_end_tm eq '1530' }">selected="selected"</c:if>>15:30</option>
                                <option value="1600" <c:if test="${vo.opr_end_tm eq '1600' }">selected="selected"</c:if>>16:00</option>
                                <option value="1630" <c:if test="${vo.opr_end_tm eq '1630' }">selected="selected"</c:if>>16:30</option>
                                <option value="1700" <c:if test="${vo.opr_end_tm eq '1700' }">selected="selected"</c:if>>17:00</option>
                                <option value="1730" <c:if test="${vo.opr_end_tm eq '1730' }">selected="selected"</c:if>>17:30</option>
                                <option value="1800" <c:if test="${vo.opr_end_tm eq '1800' }">selected="selected"</c:if>>18:00</option>
                                <option value="1830" <c:if test="${vo.opr_end_tm eq '1830' }">selected="selected"</c:if>>18:30</option>
                                <option value="1900" <c:if test="${vo.opr_end_tm eq '1900' }">selected="selected"</c:if>>19:00</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">신청자</th>
                        <td><input type="hidden" name="req_usr_id" value="${req_usr_id}"/>
                            ${req_usr_nm}
                        </td>
                    </tr>
                    <tr style="display: none;">
                        <th class="" scope="row"><label for="opr_use_plc"><span class="essentia" style="color:#ff0000;">*</span> 사용장소</label></th>
                        <td><input type="text" name="opr_use_plc"  maxlength=""  class="w_p100 required" id="opr_use_plc" readonly="readonly" /></td>
                    </tr>
                    <tr>
                        <th class="" scope="row"><label for="opr_cntns"><span class="essentia" style="color:#ff0000;">*</span> 사용목적</label></th>
                        <td><input type="text" name="opr_cntns"  maxlength=""  class="w_p100 required" id="opr_cntns" /></td>
                    </tr>
<!--                     <tr> -->
<!--                         <th class="" scope="row"><label for="opr_use_cntns"><span class="essentia" style="color:#ff0000;">*</span> 참석대상</label></th> -->
<!--                         <td><input type="text" name="opr_use_cntns"  maxlength=""  class="w_p100 required" id="opr_use_cntns" placeholder="(입력 예 : ooo외 00명)" /></td> -->
<!--                     </tr> -->
<!--                     <tr> -->
<!--                         <th scope="row">자원위치</th> -->
<!--                         <td><label id="rsrc_lctn" class="rsrc_info"></label></td> -->
<!--                     </tr> -->
                    <tr>
                        <th scope="row">자원설명</th>
                        <td><label id="rsrc_cntns" class="rsrc_info"></label></td>
                    </tr>
<!--                     <tr> -->
<!--                         <th scope="row">좌석수</th> -->
<!--                         <td><label id="rsrc_cnt" class="rsrc_info"></label></td> -->
<!--                     </tr> -->
                    <tr>
                        <th scope="row">운영자</th>
                        <td>
                        	<label id="rsrc_mgt_nm" class="rsrc_info"></label>
                        	<input type="hidden" id="rsrc_mgt_id" name="rsrc_mgt_id" value="" />
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">신청가능일</th>
                        <td><label id="rsrc_ddcnt" class="rsrc_info"></label></td>
                    </tr>
                </tbody>
            </table>
            <div class="layerpopup_bottom tx_c">
                <c:if test="${opr_id eq '' }">
                <a href="#" class="btn_black" id="resve_add"    name="btn_resve_save">신청</a>
                </c:if>
                <c:if test="${opr_id ne ''}">
                <a href="#" class="btn_black" id="resve_modify" name="btn_resve_save">수정</a>
                <a href="#" class="btn_black" id="btn_resve_del" name="btn_resve_del">삭제</a>
                </c:if>
                <a href="#" class="btn_orange" onclick="$('#resourceViewLayer').dialog('close');">닫기</a>
                <!-- //사용관리등록 -->
            </div>
        </div>
        </form>
        <script type="text/javascript">
        
	        /**
	         * 자원목록조회
	         */
	        function fn_selectRsrcId(){
	            fn_ajax({
	                  url : "${cPath}/rsrc/selectResourceListAjax.face",
	                param : $('#reserve_frm').serialize(),
	             callback : {success : function (data) {fn_selectRsrcIdSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
	            });
	        }
	        //  자원목록조회
	        function fn_selectRsrcIdSuccess(data){
	            if (data.status == "SUCCESS") {
	                $('#reserve_frm select[name="rsrc_id"] option').remove();
	                $('.rsrc_info').text('');
	                if (data.data.length > 0){
	                    var html = "";
	                    $(data.data).each(function () {
	                        html += "<option value=" + this.RSRC_ID+ ">" + this.RSRC_NM + "</option>";
	                    });
	                    $('#reserve_frm select[name="rsrc_id"]').append(html);
	                }
	                fn_selectRsrcInfo();
	            }
	        }
	        /**
	        * 선택한 자원의 정보를 조회
	        */
	        function fn_selectRsrcInfo() {
	        	fn_ajax({
                    url : "${cPath}/rsrc/selectResourceDetailAJax.face",
                  param : $('#reserve_frm').serialize(),
               callback : {success : function (data) {fn_selectRsrcInfoSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
              });
	        }
	        
	        //자원목록조회
            function fn_selectRsrcInfoSuccess(data){
                if (data.status == "SUCCESS") {
//                 	var rsrc_lctn      = data.rsrc.RSRC_LCTN   == null ? '' : data.rsrc.RSRC_LCTN;
                	var rsrc_cntns     = data.rsrc.RSRC_CNTNS  == null ? '' : data.rsrc.RSRC_CNTNS;
//                 	var rsrc_cnt       = data.rsrc.RSRC_CNT    == null ? '' : data.rsrc.RSRC_CNT;
                	var rsrc_mgt_nm    = data.rsrc.RSRC_MGT_NM == null ? '' : data.rsrc.RSRC_MGT_NM;
                	var rsrc_mgt_id	   = data.rsrc.RSRC_MGT_ID == null ? '' : data.rsrc.RSRC_MGT_ID;
                	var rsrc_ddcnt     = data.rsrc.RSRC_DDCNT  == null ? '' : data.rsrc.RSRC_DDCNT;
                	
                	if(data.resve != null) { // 수정,삭제시
                		//$('#reserve_frm input[name="opr_use_plc"]').val(data.resve.OPR_USE_PLC);
                        $('#reserve_frm input[name="opr_cntns"]').val(data.resve.OPR_CNTNS);
//                         $('#reserve_frm input[name="opr_use_cntns"]').val(data.resve.OPR_USE_CNTNS);
                        
                        $('#reserve_frm input[name="opr_strt_dt"]').val(data.resve.OPR_STRT_DT);
                        $('#reserve_frm input[name="opr_end_dt"]').val(data.resve.OPR_END_DT);
                        $('#reserve_frm select[name="opr_strt_tm"]').val(data.resve.OPR_STRT_TM);
                        $('#reserve_frm select[name="opr_end_tm"]').val(data.resve.OPR_END_TM);
                        
                        $('#reserve_frm input[id="opr_strt_dt"]').attr('disabled',true);
                        $('#reserve_frm input[id="opr_end_dt"]').attr('disabled',true);
                        $('#reserve_frm select[name="opr_strt_tm"]').attr('disabled',true);
                        $('#reserve_frm select[name="opr_end_tm"]').attr('disabled',true);
                	}
//                 	$('#reserve_frm label[id="rsrc_lctn"]').text(rsrc_lctn);            //자원위치
                    $('#reserve_frm label[id="rsrc_cntns"]').text(rsrc_cntns);          //자원설명
//                     $('#reserve_frm label[id="rsrc_cnt"]').text(rsrc_cnt);              //좌석수
                    $('#reserve_frm label[id="rsrc_mgt_nm"]').text(rsrc_mgt_nm);        //운영자
                    $('#reserve_frm input[id="rsrc_mgt_id"]').val(rsrc_mgt_id);        //운영자
                    $('#reserve_frm label[id="rsrc_ddcnt"]').text(rsrc_ddcnt + "일 전");//신청가능일
                }
            }
            function fn_ajaxError(data){
            }
            
            // 자원 예약가능여부 체크
            function fn_rsrcUseCheck(){
                fn_ajax({
                    url : "${cPath}/rsrc/selectRsrcUseChkAjax.face",
                    param : $('#reserve_frm').serialize(),
                    callback : {success : function (data) {fn_rsrcUseCheckSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
                });
            }
            
            // 자원 예약가능여부 체크 콜백
            function fn_rsrcUseCheckSuccess(data){
                if (data.status == "SUCCESS") {
                    use_cnk = data.use_chk;
                    fn_rsrcResveInsert();
                }
            }
            
            var use_cnk;
            function fn_rsrcResveInsert(upd){
            	alert("2");
            	alert(use_cnk);
            	
            	
            	var rsrc_id     = $('#reserve_frm select[name="rsrc_id"]').val();
                var opr_strt_dt = $('[name="opr_strt_dt"]').val();
                var opr_strt_tm = $('[name="opr_strt_tm"]').val();
                var opr_end_dt  = $('[name="opr_end_dt"]').val();
                var opr_end_tm  = $('[name="opr_end_tm"]').val();
                
                var startDate = (opr_strt_dt + opr_strt_tm+"00").replace(/\./g,"");
                var endDate   = (opr_end_dt + opr_end_tm+"00").replace(/\./g,"");
                
                if(rsrc_id == '' || rsrc_id == null){
                	alert(" 자원을 선택해주세요.");
                	return;
                }
                
                if (startDate >= endDate ){
                    alert(" 예약시작일시보다 예약종료일시가 빠르거나 같습니다.");
                    return;
                }
                if(use_cnk == "N"){
                    alert("등록하려는 일정에 이미 등록된 예약이 존재합니다.");
                    return;
                }
                
                $('#opr_use_plc').val($('#reserve_frm select[name="rsrc_id"] option:selected').text());
                
                if(fn_valid($('#reserve_frm'))){
                    if(confirm('저장하시겠습니까?')){
                        $('#reserve_frm input[id="opr_strt_dt"]').attr('disabled',false);
                        $('#reserve_frm input[id="opr_end_dt"]').attr('disabled',false);
                        $('#reserve_frm select[name="opr_strt_tm"]').attr('disabled',false);
                        $('#reserve_frm select[name="opr_end_tm"]').attr('disabled',false);
                        
                        fn_ajax({
                            url : "${cPath}/rsrc/insertRsrcResveAjax.face",
                            param : $('#reserve_frm').serialize(),
                            callback : {success : function (data) {fn_rsrcResveInsertSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
                        });
                    }
                }
            }
            // 자원예약등록 콜백
            function fn_rsrcResveInsertSuccess(data){
                if (data.status == "SUCCESS") {
                    alert("정상적으로 처리되었습니다.");
//                    $('#reserve_pop').hide();
					$('#resourceViewLayer').dialog('close');
                    eval(${rtnfn}(data));
                }
            }
            /*자원예약일정 삭제*/
            function fn_rsrcResveDelete(){
                if(confirm('예약일정을삭제하시겠습니까?')){
                    fn_ajax({
                        url : "${cPath}/rsrc/deleteRsrcResveAjax.face",
                        param : $('#reserve_frm').serialize(),
                        callback : {success : function (data) {fn_rsrcResveDeleteSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
                    });
                }
            }
            
            // 자원예약삭제 콜백
            function fn_rsrcResveDeleteSuccess(data){
                if (data.status == "SUCCESS") {
                    alert("정상적으로 처리되었습니다.");
//                    $('#reserve_pop').hide();
                    $('#resourceViewLayer').dialog('close');
                }
            }
            
            // validate
            function fn_valid(form){
                var rtn = "Y";
                var obj = $(form).find('select.required,input.required,textarea.required');
                
                $(obj).each(function(){
                    var val  = $(this).val();
                    var text = $(this).parents('td:first').prev('th:first').text().replace("*","");
                    
                    if(val == ""){
                        alert(text.replace(" ","") + "은(는) 필수 입력사항입니다.");
                        $(this).focus();
                        rtn = "N";
                        return false;
                    } else {
                        rtn = "Y";
                    } 
                });
                return rtn == "Y" ? true : false;
            }
	        
            <c:if test="${not empty param.cnfrPopChk }">
            	function fn_getResourceListForCnfr(){
            		var id = $('#reserve_frm select[name="rsrc_id"]').val();
            		
            		if(!isDefined(id)) {
            			alert("선택된 자원이없습니다. 선택 후 조회하십시오.");
            			return;
            		}
            		
           			var url = getContextPath() + "/rsrc/resourceListForCnfr.face?RSRC_ID="+id;
           			
           			fn_showDialogPopup({
           				showAreaId : "resourceListForCnfrLayer",
           				url : url,
           				title : "자원예약현황",
           				width : 1100,
           				height : "auto",
           				modal : true,
           				buttons : [{ text : "닫기", class : "btn_gray", click : function () {$("#resourceListForCnfrLayer").dialog("close");} }]
           		    });
            	}
            	
            </c:if>
            
	        $(document).ready(function(){
	            
	            // 버튼 이벤트
	            $('a[name*="btn"]').bind('click',function(event){
	                switch (this.name){
	                    case "btn_resve_save": if(this.id == 'resve_add') fn_rsrcUseCheck();  
	                                           else {use_cnk = "Y";fn_rsrcResveInsert('upd');} 
	                                           break; 
	                    case "btn_resve_del" : fn_rsrcResveDelete();
	                }
	            });
	            // 부서코드 체인지 이벤트
	            $('select[name="dept_cd"]').change(function(event){
	                fn_selectRsrcId(); // 자원목록조회
	            });
	            $('select[name="rsrc_clsf"]').change(function(event){
	                fn_selectRsrcId(); // 자원목록조회
	            });
	            $('select[name="rsrc_id"]').change(function(event){
	            	fn_selectRsrcInfo();
	            });
	            fn_selectRsrcInfo();
	            
	            $( "#opr_strt_dt, #opr_end_dt" ).datepicker({
	            	dateFormat:'yy.mm.dd',
	            	showOn: "both",
	            	buttonImage: "${cPath}/sjpb/reference/images/icon_calendar.png",
	            	buttonImageOnly: true,
	            	buttonText: "일자선택",
	            	 /* fix buggy IE focus functionality */
	                fixFocusIE: false,
	                
	                /* blur needed to correctly handle placeholder text */
	                onSelect: function(dateText, inst) {
	                      this.fixFocusIE = true;
	                      $(this).blur().change().focus();
	                },
	                onClose: function(dateText, inst) {
	                      this.fixFocusIE = true;
	                      this.focus();
	                },
	                beforeShow: function(input, inst) {
	                	var result = true;
	                	if (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) {
							// 처리 로직 작성
	                		result = !this.fixFocusIE
	               		}  
					this.fixFocusIE = false;
					return result;
	                }
	            });
	            
	         // 시작일자를 지정하면 종료일자를 시작일자 이후로만 지정되도록 처리
	         // 종료일자는 오늘 이전을 지정 할 수 없다.
	         $("#opr_end_dt").datepicker("option", "minDate", $("#opr_strt_dt").val());
	         $("#opr_strt_dt").datepicker("option", "onClose", function (date) {
	         	$("#opr_end_dt").datepicker("option", "minDate", date);
	         });
	        });
	    </script>
	<%--    
    </div>
     --%>
</body>
</html>
