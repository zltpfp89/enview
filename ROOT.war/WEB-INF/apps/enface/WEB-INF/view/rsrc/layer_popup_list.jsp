<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %>
<%
    request.setAttribute("cPath", request.getContextPath());
    request.setAttribute("usrId", EnviewSSOManager.getUserInfo(request).getUserId()); // 로그인사용자
    request.setAttribute("admin",  EnviewSSOManager.getUserInfo(request).getHasRole("ROLE_MNG_RSRC")); // 자원예약관리자
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <script type="text/javascript" src="${cPath}/javascript/jquery/jquery.blockUI.js"></script>
    <script type="text/javascript" src="${cPath}/sjpb/js/Z/common.js"></script>
    <script type="text/javascript">
    
    var G_rsrc_id  = "";
    var G_opr_id   = "";
    var G_able_seq = "";
    var today      = "${today}";
    
    today = today.substr(0,4) + "." + today.substr(4,2) + "." + today.substr(6,2);
     
    // 자원예약 팝업
    function fn_absControl(p_date,p_time,p_rsrc_id,p_opr_id,status) {
    	
    	if(p_rsrc_id == null || p_rsrc_id == ''){
    		alert('조회된 자원이 없습니다.');
    		return;
    	}
    	$('#reserve_frm input[name="opr_id"],input[name="rsrc_id"]').remove();
    	
        G_rsrc_id = p_rsrc_id;
        G_opr_id  = p_opr_id;
        if(status.indexOf('0F')!= -1 || status.indexOf('EM')!= -1) { // 신청상태
        	$('#reserve_frm input[id="opr_strt_dt"]').attr('disabled',false);
            $('#reserve_frm input[id="opr_end_dt"]').attr('disabled',false);
            $('#reserve_frm select[name="opr_strt_tm"]').attr('disabled',false);
            $('#reserve_frm select[name="opr_end_tm"]').attr('disabled',false);
        }
        else if(status.indexOf('0T')!= -1 || status.indexOf("1F") != -1 || status.indexOf("1T") != -1)  { // 타인신청,본인신청,승인된건은 수정할수 없음 
        	$('#reserve_frm input[id="opr_strt_dt"]').attr('disabled',true);
            $('#reserve_frm input[id="opr_end_dt"]').attr('disabled',true);
            $('#reserve_frm select[name="opr_strt_tm"]').attr('disabled',true);
            $('#reserve_frm select[name="opr_end_tm"]').attr('disabled',true); 
        }   
        $('#resve_add').focus();
        
        var date = String(p_date); // 예약일
        date = date.substr(0,4) + "." + date.substr(4,2) + "." + date.substr(6,2);
        /*예약일시*/
        $('#opr_strt_dt').val(date);
        $('#opr_end_dt').val(date);
        $('select[name="opr_strt_tm"]').val(p_time);
        $('select[name="opr_end_tm"]').val(p_time);

        if(p_opr_id != 'EM') { // 예약번호가 있을경우
            $('#reserve_frm').append('<input type="hidden" name="opr_id" value="'+p_opr_id+'"/>');
            $('#resve_add').hide();
            $('#resve_modify').show();
            $('#btn_resve_del').show();
        }else {
            $('#resve_add').show();
            $('#resve_modify').hide();
            $('#btn_resve_del').hide();
        }
        
        
        $('#reserve_frm').append('<input type="hidden" name="rsrc_id" value="'+p_rsrc_id+'"/>'); // 자원번호를 그려줌;
        fn_ajax({
            url : "${cPath}/rsrc/selectResourceDetailAJax.face"
            , param : $("#reserve_frm").serialize()
            , callback : {success : function (data) {fn_absControlSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
        });
        
        /*팝업을 보여줌*/
        //$('#reserve_pop').draggable();
        //$('#reserve_pop').show();
    }
    //자원예약
    function fn_absControlSuccess(data) {
    	
    	$('#reserve_frm .required').prop('readonly',false);
    	
        if (data.status == "SUCCESS") {
            if(data.resve == null) {
            	$('#reserve_frm input[name="req_usr_id"]').val(data.reqst_id); //신청자id
            	$('#reserve_frm label[id="req_usr_nm"]').text(data.reqst_nm);  //신청자명
            	$('#reserve_frm input[name="chr_usr_id"]').val(data.reqst_id); //담당수사관id
            	$('#reserve_frm input[id="chr_usr_nm"]').val(data.reqst_nm);  //담당수사관 이름
            	$('#reserve_frm input[name="opr_use_plc"]').val(data.rsrc.RSRC_NM);          //예약자원
            } else {
            	$('#reserve_frm input[name="req_usr_id"]').val(data.resve.OPR_REQ_RGSRT_ID); //신청자id
                $('#reserve_frm label[id="req_usr_nm"]').text(data.resve.OPR_REQ_RGSRT_NM);  //신청자명
                $('#reserve_frm input[name="chr_usr_id"]').val(data.resve.OPR_CHR_RGSRT_ID); //담당수사관id
            	$('#reserve_frm input[id="chr_usr_nm"]').val(data.resve.OPR_CHR_RGSRT_NM);  //담당수사관 이름
                $('#reserve_frm input[name="opr_strt_dt"]').val(data.resve.OPR_STRT_DT);    //예약시작일
                $('#reserve_frm select[name="opr_strt_tm"]').val(data.resve.OPR_STRT_TM);   //예약시작시간
                $('#reserve_frm input[name="opr_end_dt"]').val(data.resve.OPR_END_DT);      //예약종료일  
                $('#reserve_frm select[name="opr_end_tm"]').val(data.resve.OPR_END_TM);     //예약종료시간
            	$('#reserve_frm input[name="opr_use_plc"]').val(data.resve.OPR_USE_PLC);    //사용장소
            	$('#reserve_frm input[name="opr_cntns"]').val(data.resve.OPR_CNTNS);        //사용목적
//             	$('#reserve_frm input[name="opr_use_cntns"]').val(data.resve.OPR_USE_CNTNS);//참석대상
            	$('#reserve_frm input[name="opr_use_plc"]').val(data.resve.OPR_USE_PLC);    //예약자원
            	
            	//승인된 예약일경우 수정할수 없음
            	
            	if('${usrId}' == data.rsrc.RSRC_MGT_ID){
            		$('#reserve_frm input[id="opr_strt_dt"]').attr('disabled',false);
                    $('#reserve_frm input[id="opr_end_dt"]').attr('disabled',false);
                    $('#reserve_frm select[name="opr_strt_tm"]').attr('disabled',false);
                    $('#reserve_frm select[name="opr_end_tm"]').attr('disabled',false); 
            		$('#resve_modify').show();
                    $('#btn_resve_del').show();
            	}else{
	            	if(data.resve.OPR_APV_CLSF == '1') {
	            		$('#resve_modify').hide();
	            		if('${usrId}' == data.resve.OPR_REQ_RGSRT_ID){
	            			$('#btn_resve_del').show();
	            		}else $('#btn_resve_del').hide();
	                    $('#reserve_frm .required').prop('readonly',true);
	            	} else if('${usrId}' == data.resve.OPR_REQ_RGSRT_ID) {
	            		$('#resve_modify').show();
	                    $('#btn_resve_del').show();
	                    $('#reserve_frm .required').prop('readonly',false);
	            	} else if('${usrId}' != data.resve.OPR_REQ_RGSRT_ID) {
	                    $('#resve_modify').hide();
	                    $('#btn_resve_del').hide();
	                    $('#reserve_frm .required').prop('readonly',true);
	                }
            	}
            	
            	
            }
            
            
//             $('#reserve_frm label[id="rsrc_lctn"]').text(data.rsrc.RSRC_LCTN);            //자원위치
            $('#reserve_frm label[id="rsrc_cntns"]').text(data.rsrc.RSRC_CNTNS);          //자원설명
//             $('#reserve_frm label[id="rsrc_cnt"]').text(data.rsrc.RSRC_CNT);              //좌석수
            $('#reserve_frm label[id="rsrc_mgt_nm"]').text(data.rsrc.RSRC_MGT_NM);        //운영자
            $('#reserve_frm label[id="rsrc_ddcnt"]').text(data.rsrc.RSRC_DDCNT + "일 전");//신청가능일
        }
        
        $('#reserve_frm input[name="opr_use_plc"]').prop('readonly',true);
        
        $('#reserve_pop').draggable();
        $.blockUI({ 
            message : $("#reserve_pop") , 
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
        
    function fn_ajaxError(data) {
        //console.log(data)
    }
        
        // 자원사용불가 사유 조회
        function fn_rsrcAble(p_rsrc_id){
        	
        	G_rsrc_id = p_rsrc_id;
        	
        	var len = $('#rsrc_able_frm [name="rsrc_id"]').length;
        	if(len > 0) $('#rsrc_able_frm [name="rsrc_id"]').remove();
        	
            $('#rsrc_able_frm').append('<input type="hidden" name="rsrc_id" value=\"'+G_rsrc_id+'\"/>')
            fn_ajax({
                url : "${cPath}/rsrc/selectRsrcAbleAjax.face", 
              param : $('#rsrc_able_frm').serialize(),
           callback : {success : function (data) {fn_rsrcAbleSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
            });
            $('#rsrc_able_frm [name="rsrc_id"]').remove();
        }
        // 자원사용불가 사유 조회 콜백
        function fn_rsrcAbleSuccess(data){
            var html = "";
            $('#rsrc_able_frm table:eq(1) tr:gt(0)').remove();
            
            if (data.status == "SUCCESS") {
                $('label[name="able_rsrc_nm"]').text(data.rsrc_nm);
                if (data.data.length > 0) {
                    $(data.data).each(function () {
                        html += "<tr>";
                        html += "   <td><input type='radio'  name='able_seq' value="+this.ABLE_SEQ+">";
                        html += "   </td>";
                        html += "   <td>" + this.ABLE_STRT_TM + " ~ " + this.ABLE_END_TM + "</td>";
                        html += "   <td style='text-align:left'>" + this.ABLE_RSN + "</td>";
                        html += "</tr>";
                    });
                } else {
                    html += "<tr>";
                    html += "   <td colspan='3'>";
                    html += "       조회된 데이터가 없습니다.";
                    html += "   </td>";
                    html += "</tr>";
                }              
            } else {
                html += "<tr>";
                html += "   <td colspan='3'>";
                html += "       조회된 데이터가 없습니다.";
                html += "   </td>";
                html += "</tr>";
            }
            
            
            $('#rsrc_able_frm table:eq(1)').append(html);
            $('#able_list_pop').show();
            $('#able_list_pop').draggable();
        }
        
        // 자원관리 등록팝업
        function fn_resourceAdd(){
        	
            //$('#resource_reg_pop').show();
            $('#resource_reg_pop').draggable();
            fn_rsrcClsfCode();
            fn_rsrcDeptCode();
            
            $.blockUI({ 
                message : $("#resource_reg_pop") , 
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
        
        // 자원 상세조회 팝업 호출
        function fn_resourceDetail(rsrc_id){
        	
        	$('#editForm input[name="rsrc_id"]').remove();
        	
            $('#resource_reg_pop').show();
            $('#resource_reg_pop').draggable();
           
            
            fn_ajax({
                url : "${cPath}/rsrc/selectResourceDetailViewAjax.face?rsrc_id="+rsrc_id 
                , callback : {success : function (data) {fn_resourceDetailSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
            });
            fn_rsrcClsfCode();
            fn_rsrcDeptCode();
            
        }
        
        // 자원 상세조회 콜백
        function fn_resourceDetailSuccess(data){
            if (data.status == "SUCCESS") {
            	$('#editForm select[name="rsrc_clsf"]').val(data.detail.RSRC_CLSF);
            	$('#editForm select[name="dept_cd"]').val(data.detail.DEPT_CD);
            	$('#editForm select[name="dept_cd"]').change();
            	setTimeout("fn_mgtid('"+data.detail.RSRC_MGT_ID+"')",100);
            	$('#editForm input[name="rsrc_nm"]').val(data.detail.RSRC_NM);
//             	$('#editForm input[name="rsrc_lctn"]').val(data.detail.RSRC_LCTN);
//             	$('#editForm input[name="rsrc_cnt"]').val(data.detail.RSRC_CNT);
            	$('#editForm textarea[name="rsrc_cntns"]').val(data.detail.RSRC_CNTNS);
            	$('#editForm input[name="rsrc_ddcnt"]').val(data.detail.RSRC_DDCNT);
            	//setTimeout("fn_mgtRsrcClsCode('"+data.detail.RSRC_CLSF+"')",500);
            }
            $('#editForm').append('<input type="hidden" name="rsrc_id" value=\"'+data.detail.RSRC_ID+'\"/>');
        }
        
        function fn_mgtid(data){
        	$('#editForm select[name="rsrc_mgt_id"]').val(data);
        }
 
        // 자원구분조회
        function fn_rsrcClsfCode(){
            fn_ajax({
                url : "${cPath}/rsrc/selectResourceCodeAjax.face" 
                , callback : {success : function (data) {fn_rsrcClsfCodeSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
            });
        }
        // 자원구분조회 콜백
        function fn_rsrcClsfCodeSuccess(data){
            if (data.status == "SUCCESS") {
                if (data.data.length > 0){
                    $('#editForm select[name="rsrc_clsf"]').children().remove();
                    var html = "";
                    $(data.data).each(function () {
                        html += "<option value=" + this.CODE+ ">" + this.NAME + "</option>";
                    });
                    $('#editForm select[name="rsrc_clsf"]').append(html);
                }
            }
        }
        // 자원부서조회
        function fn_rsrcDeptCode(){
            
            fn_ajax({
                url : "${cPath}/rsrc/selectRsrcDeptCodeAjax.face" 
                , callback : {success : function (data) {fn_rsrcDeptCodeSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
            });
        }
        // 자원부서조회 콜백
        function fn_rsrcDeptCodeSuccess(data){
            if (data.status == "SUCCESS") {
                if (data.data.length > 0){
                    $('#editForm select[name="dept_cd"]').children().remove();
                    var html = "";
                    $(data.data).each(function () {
                        html += "<option value=" + this.CODE+ ">" + this.NAME + "</option>";
                    });
                    $('#editForm select[name="dept_cd"]').append(html);
                }
                fn_rsrcAdminCode();
            }
        }
        
        // 자원부서 관리자조회
        function fn_rsrcAdminCode(){
            var dept_cd = $('#editForm select[name="dept_cd"] option:selected').val();
            fn_ajax({
                url : "${cPath}/rsrc/selectRsrcAdminCodeAjax.face",  
                param : $('#editForm').serialize(), 
                callback : {success : function (data) {fn_rsrcAdminCodeSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
            });
        }
        // 자원부서 관리자조회 콜백
        function fn_rsrcAdminCodeSuccess(data){
            if (data.status == "SUCCESS") {
                if (data.data.length > 0){
                    $('#editForm select[name="rsrc_mgt_id"]').children().remove();
                    var html = "";
                    //html += "<option value=''>운영자선택</option>";
                    $(data.data).each(function () {
                        html += "<option value=" + this.USR_ID+ ">" + this.USR_NM + "</option>";
                    });
                    $('#editForm select[name="rsrc_mgt_id"]').append(html);
                }
            }
        }
        
        // 자원등록
        function fn_rsrcSave(){
        	ekrFile.setForm();
        	
        	if(ekrFile.isCancel) return;
        	
       		fn_ajax({
				url : "${cPath}/rsrc/insertResourceAjax.face",  
				param : $('#editForm').serialize(), 
				callback : {success : function (data) {fn_rsrcSaveSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
			});
        }
        // 자원등록 콜백
        function fn_rsrcSaveSuccess(data){
            if (data.status == "SUCCESS") {
                alert("정상적으로 처리되었습니다.");
                fn_search();
                $.unblockUI();
            }
        }
        
        // 자원등록저장
        function fn_resourceSave(){
            
            if(fn_valid($('#editForm'))){
                if(confirm('저장하시겠습니까?')){
                    fn_rsrcSave();
                }
            }   
        }
        
        // 자원사용불가사유 등록
        function fn_rsrcAbleAdd(){
            
            $('#able_list_pop').hide();
            $('#able_udt_pop').show();
            $('#able_udt_pop').draggable();
            
          $('#able_strt_dt').val(today);
          $('#able_end_dt').val(today);
            
            $('#rsrc_able_frm input[name="able_seq"]').val(null);
            
        }
        // 자원불가사유 수정
        function fn_rsrcAbleUpt(rsrc_seq){
                $radio  = $('#rsrc_able_frm input:radio:checked');
                var chk_len = $radio.length;
                
                if(chk_len <= 0) {
                    alert("자원 불가 시간일정을 선택해주세요");
                    return;
                } else {
                    fn_rsrcAbleDetail(G_rsrc_id,$radio.val());
                }   
            
        }
        // 자원사용불가사유 조회
        function fn_rsrcAbleDetail(p_rsrc_id,p_able_seq){
        	
        	G_rsrc_id  = p_rsrc_id;
        	G_able_seq = p_able_seq;
        	
            var rsrc_len      = $('#rsrc_able_frm input[name="rsrc_id"]').length;
            var able_seq_len  = $('#rsrc_able_frm input[name="able_seq"]').length;
            
            if(rsrc_len == 0){
            	$('#rsrc_able_frm').append('<input type="hidden" name="rsrc_id" value="'+G_rsrc_id+'">');
            }
            if(able_seq_len == 0){
                $('#rsrc_able_frm').append('<input type="hidden" name="able_seq" value="'+G_able_seq+'">');
            }
        	
            fn_ajax({
                url : "${cPath}/rsrc/selectRsrcAbleAjax.face",
                param : $('#rsrc_able_frm').serialize(),
                callback : {success : function (data) {fn_rsrcAbleDetailSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
            });
            $('#rsrc_able_frm input[name="rsrc_id"]').remove();
            $('#rsrc_able_frm input[name="able_seq"]').remove();
            if('${adminChk}' == 'Y' || '${admin}' == 'true') {
            	$('#rsrc_able_frm [name="btn_able_save"]').show();
            	$('#rsrc_able_frm [name*="able"]').prop('disabled',false)
            } else {
            	$('#rsrc_able_frm [name="btn_able_save"]').hide();
            	$('#rsrc_able_frm [name*="able"]').prop('disabled',true)
            }
            		
        }
        // 자원사용불가사유 조회 콜백
        function fn_rsrcAbleDetailSuccess(data){
        	$('#rsrc_able_frm input:hidden[name="able_seq"]').remove();
            if (data.status == "SUCCESS") {
                $('#able_list_pop').hide();
                $('#able_udt_pop').show();
                $('#able_udt_pop').draggable();
                
                if (data.data.length > 0) {
                    $(data.data).each(function () {
                        $('#rsrc_able_frm textarea[name="able_rsn"]').val(this.ABLE_RSN);
                        $('#rsrc_able_frm input[name="able_strt_dt"]').val(this.ABLE_STRT_DT);
                        $('#rsrc_able_frm input[name="able_end_dt"]').val(this.ABLE_END_DT);
                        $('#rsrc_able_frm select[name="able_strt_tm"]').val(this.ABLE_STRT_HM);
                        $('#rsrc_able_frm select[name="able_end_tm"]').val(this.ABLE_END_HM);
                    });
                }
            }
        }
        
        // 자원불가사유 등록
        function fn_rsrcAbleSave(){
        	
        	var able_strt_dt = $('[name="able_strt_dt"]').val();
            var able_strt_tm = $('[name="able_strt_tm"]').val();
            var able_end_dt = $('[name="able_end_dt"]').val();
            var able_end_tm = $('[name="able_end_tm"]').val();
            
            var rsrc_len      = $('#rsrc_able_frm input[name="rsrc_id"]').length;
            var able_seq_len  = $('#rsrc_able_frm input[name="able_seq"]').length;
            
            if(rsrc_len == 0){
                $('#rsrc_able_frm').append('<input type="hidden" name="rsrc_id" value="'+G_rsrc_id+'">');
            }
            if(able_seq_len == 0){
                $('#rsrc_able_frm').append('<input type="hidden" name="able_seq" value="'+G_able_seq+'">');
            }
            
        	if(fn_valid($('#rsrc_able_frm'))){
                var startDate = (able_strt_dt + able_strt_tm+"00").replace(/\./g,"");
                var endDate   = (able_end_dt + able_end_tm+"00").replace(/\./g,"");
                
                if (startDate >= endDate ){
                    alert(" 불가시작일시보다 불가종료일시가 빠르거나 같습니다.");
                    return false;
                }
                
        		if(confirm('저장하시겠습니까?')){
                    fn_ajax({
                        url : "${cPath}/rsrc/insertRsrcAbleAjax.face",
                        param : $('#rsrc_able_frm').serialize(),
                        callback : {success : function (data) {fn_rsrcAbleSaveSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
                    });
                }
        		
        		$('#rsrc_able_frm input[name="rsrc_id"]').remove();
                $('#rsrc_able_frm input[name="able_seq"]').remove();
        	}
        }
        
        // 자원불가사유 등록 콜백
        function fn_rsrcAbleSaveSuccess(data){
            if (data.status == "SUCCESS") {
                alert("정상적으로 처리되었습니다.");
                $('#able_udt_pop').hide();
                $.unblockUI();
                fn_search();
            }
        }
        
        // 자원사용불가사유 삭제
        function fn_rsrcAbleDelete(){
            
            $radio  = $('#rsrc_able_frm input:radio:checked');
            var chk_len = $radio.length;
            var rsrc_id = $radio.next().val();
            
            if(chk_len <= 0) {
                alert("자원 불가 시간일정을 선택해주세요");
                return;
            } else {
                if(confirm('삭제하시겠습니까?')){
                    fn_ajax({
                        url : "${cPath}/rsrc/deleteRsrcAbleAjax.face",
                        param : $('#rsrc_able_frm').serialize(),
                        callback : {success : function (data) {fn_rsrcAbleDeleteSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
                    });
                }
            }
        }
        
        // 자원불가사유 등록 콜백
        function fn_rsrcAbleDeleteSuccess(data){
            if (data.status == "SUCCESS") {
                alert("정상적으로 처리되었습니다.");
                $.unblockUI();
                fn_search();
            }
        }
        // validate
        function fn_valid(form){
        	
            var rtn = "Y";
            var obj = $(form).find('.required,.integer');
            
            $(obj).each(function(){
                var val  = $(this).val();
                var text = $(this).parents('td:first').prev('th:first').text().replace("*","");
                
                if(val == ""){
                    alert(text.replace(" ","") + "은(는) 필수 입력사항입니다.");
                    $(this).focus();
                    rtn = "N";
                    return false;
                }
                if($(this).prop('class').indexOf('integer') != -1) {
                	rtn =  fn_numberChk(this,val);
                	return rtn == "Y" ? true : false;
                } else {
                    rtn = "Y";
                } 
            });
            return rtn == "Y" ? true : false;
        }
        
        // 넘버체크
        function fn_numberChk(obj,val){
        	var val  = $(obj).val();
            var text = $(obj).parents('td:first').prev('th:first').text().replace("*","");
            
            if(isNaN(val) == true) {
                alert(text + '은(는) 숫자만 입력가능합니다.');
                obj.focus();
                return "N";
            } else {
            	return "Y";
            }
        }
        
        
        // 자원사용 신청
        var use_cnk;
        function fn_rsrcResveInsert(upd){
        	var opr_strt_dt = $('[name="opr_strt_dt"]').val();
        	var opr_strt_tm = $('[name="opr_strt_tm"]').val();
        	var opr_end_dt = $('[name="opr_end_dt"]').val();
        	var opr_end_tm = $('[name="opr_end_tm"]').val();
        	
        	var startDate = (opr_strt_dt + opr_strt_tm+"00").replace(/\./g,"");
        	var endDate   = (opr_end_dt + opr_end_tm+"00").replace(/\./g,"");
        	
        	if (startDate >= endDate ){
                alert(" 예약시작일시보다 예약종료일시가 빠르거나 같습니다.");
                return false;
            }
        	if(use_cnk == "N"){
                alert("등록하려는 일정에 이미 등록된 예약이 존재합니다.");
                return;
            }
        	// 자원id 필드를 동적으로 만들어 줌
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
                $('#reserve_pop').hide();
                $.unblockUI();
                fn_search();
            }
        }

        
     // 자원 예약가능여부 체크
        function fn_rsrcAvailableUseCheck(){
        	fn_ajax({
                url : "${cPath}/rsrc/selectRsrcAvaleChkAjax.face",
                param : $('#reserve_frm').serialize(),
                callback : {success : function (data) {fn_rsrcAvailableUseCheckSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
            });
        }
        
        // 자원 예약가능여부 체크 콜백
        function fn_rsrcAvailableUseCheckSuccess(data){
            if (data.status == "SUCCESS") {
            	availableChk = data.availableChk;
            	if(availableChk =='Y'){
            		fn_rsrcUseCheck();
            	}else {
            		 alert("해당 자원은 "+ data.rsrcDdcnt +"일전에 신청이 가능합니다.");
                     return false;
            	}
            }
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
        	debugger;
            if (data.status == "SUCCESS") {
            	use_cnk = data.use_chk;
            	fn_rsrcResveInsert();
            }
        }
        
        // 자원 예약가능여부 체크
        function fn_rsrcResveInsertSave(){
            
            fn_ajax({
                url : "${cPath}/rsrc/selectRsrcResveSaveAjax.face",
                param : param,
                callback : {success : function (data) {fn_rsrcResveInsertSaveSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
            });
        }
        
        // 자원 예약가능여부 체크 콜백
        function fn_rsrcResveInsertSaveSuccess(data){
            if (data.status == "SUCCESS") {
                use_cnk = data.use_chk;
                fn_rsrcResveInsert();
            }
        }
        
        /*자원예약일정 삭제*/
        function fn_rsrcResveDelete(){
        	
        	var opr_id_len = $('#reserve_frm input:hidden[name="opr_id"]').length;
            if(opr_id_len > 0 )$('#reserve_frm input:hidden[name="opr_id"]').remove();
            
            $('#reserve_frm').append('<input type="hidden" name="opr_id" value="'+G_opr_id+'">');
            
        	if(confirm('예약일정을삭제하시겠습니까?')){
                fn_ajax({
                    url : "${cPath}/rsrc/deleteRsrcResveAjax.face",
                    param : $('#reserve_frm').serialize(),
                    callback : {success : function (data) {fn_rsrcResveDeleteSuccess(data);}, error : function (data) {fn_ajaxError(data);}}
                });
            }
        	$('#reserve_frm input[name="opr_id"]').remove();
        }
        
        // 자원예약삭제 콜백
        function fn_rsrcResveDeleteSuccess(data){
            if (data.status == "SUCCESS") {
            	$('#reserve_pop').hide()
                alert("정상적으로 처리되었습니다.");
            	$.unblockUI();
                fn_search();
            }
        }
        
        function fn_srchUser(){
        	commonLayerPopup.openLayerPopup('/sjpb/Z/layerPopupList.face?chkType=radio', "1206px", "600px", function(data) { callBackSetCriMbSuccess(data)});	//참조수사관
        }
        
        
        function callBackSetCriMbSuccess(data){
        	var JsonData = JSON.parse(data);
        	
        	$('#reserve_frm input[name="chr_usr_id"]').val(JsonData.person[0].userId); //신청자id
        	$('#reserve_frm input[id="chr_usr_nm"]').val(JsonData.person[0].userName);  //신청자명
        }
        $(document).ready(function(){
            $('.popup_close,.btn_close').click(function(){
                $(this).each(function(){
                    $(this).parents('div:last').hide();
                    $(this).parents('form').children().find('input,textarea').each(function(){
                    	$(this).val('');
                    })
                })
                
                $.unblockUI();
            });
            $('#editForm select[name="dept_cd"]').on('change',function(){
                fn_rsrcAdminCode();
            });
            
            $( "#opr_strt_dt, #opr_end_dt, #able_strt_dt, #able_end_dt" ).datepicker({
            	dateFormat:'yy.mm.dd',
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
			
			// 시작일자를 지정하면 종료일자를 시작일자 이후로만 지정되도록 처리
			// 종료일자는 오늘 이전을 지정 할 수 없다.
			$("#able_end_dt").datepicker("option", "minDate", $("#able_strt_dt").val());
			$("#able_strt_dt").datepicker("option", "onClose", function (date) {
				$("#able_end_dt").datepicker("option", "minDate", date);
			});
            
            // 버튼 이벤트
            $('a[name*="btn"]').bind('click',function(event){
                switch (this.name){
                    case "btn_rsrc_save" : fn_resourceSave();  break; // 자원저장
                    case "btn_able_add"  : fn_rsrcAbleAdd();   break; // 자원사용불가 사유 등록
                    case "btn_able_upt"  : fn_rsrcAbleUpt();   break; // 자원사용불가 사유 수정
                    case "btn_able_save" : fn_rsrcAbleSave();  break; // 자원사용불가 사유 저장
                    case "btn_able_del"  : fn_rsrcAbleDelete();break; // 자원사용불가 사유 삭제
                    case "btn_resve_save": fn_rsrcAvailableUseCheck(); break;
                    case "btn_srch_user": fn_srchUser(); break;
                    /*
                    case "btn_resve_save": if(this.id == 'resve_add') fn_rsrcUseCheck();  
                                           else {use_cnk = "Y";fn_rsrcResveInsert('upd');} 
                                           break;
                    */
                    case "btn_resve_del" :fn_rsrcResveDelete();
                }
            });
        });
        
        
    </script>
	<style>			
		#iframeContainer {width:80%; height: 50%; top: 100px; left:50%; display: none; position: fixed; transform: translate(-50%); background:#FFF; border: 1px solid #666;border: 1px solid #555;box-shadow: 2px 2px 40px #222;z-index: 999999;}
		#iframeContainer iframe {display:none; width: 100%; height: 100%; position: absolute; border: none; }
		#iframeLoader {background-repeat:no-repeat;  width: 250px; height: 250px; margin:auto;}			
		#iframeBlock {background: #000; opacity:0.6;  position: fixed; width: 100%; height: 100%; top:0; left:0; display:none;z-index: 999998;}​
	</style> 	    
</head>
<body>
<div id="iframeBlock"></div>
<div id="iframeContainer" class="popup">		    
    <div id="iframeLoader"></div>
    <iframe></iframe>
</div>  

    <div class="sub_layer_popup" id="reserve_pop" style="width:600px; display:none; margin-top:-300px; margin-left:-300px;" >
    <form id="reserve_frm">
        <div class="layer_popup_header">자원예약
            <a class="popup_close" title="닫기" >닫기</a>
        </div>
        <div class="layer_popup_white">
            <div class="layerpopup_top">
                <div class="layerpopup_L">
                    <label id="rsrc_nm"></label>
                </div>
            </div>
            <table class="popup_board_table" summary="자원예약">
                <caption>자원예약</caption>
                <colgroup>
                    <col style="width:120px;" />
                    <col style="width:auto;" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">예약일시</th>
                        <td>
                            <label for="" class="cursor"><input type="text" id="opr_strt_dt" name="opr_strt_dt" readonly   class="w80" maxlength="" /></label>
                            <select name="opr_strt_tm">
                                <option value="0900">09:00</option>
                                <option value="0930">09:30</option>
                                <option value="1000">10:00</option>
                                <option value="1030">10:30</option>
                                <option value="1100">11:00</option>
                                <option value="1130">11:30</option>
                                <option value="1200">12:00</option>
                                <option value="1230">12:30</option>
                                <option value="1300">13:00</option>
                                <option value="1330">13:30</option>
                                <option value="1400">14:00</option>
                                <option value="1430">14:30</option>
                                <option value="1500">15:00</option>
                                <option value="1530">15:30</option>
                                <option value="1600">16:00</option>
                                <option value="1630">16:30</option>
                                <option value="1700">17:00</option>
                                <option value="1730">17:30</option>
                                <option value="1800">18:00</option>
                                <option value="1830">18:30</option>
                                <option value="1900">19:00</option>
                                <option value="1930">19:30</option>
                                <option value="2000">20:00</option>
                                <option value="2030">20:30</option>
                                <option value="2100">21:00</option>
                                <option value="2130">21:30</option>
                                <option value="2200">22:00</option>
                                <option value="2230">22:30</option>
                                <option value="2300">23:00</option>
                                <option value="2330">23:30</option>     
                            </select>
                            ~ 
                            <label for="" class="cursor"><input type="text" id="opr_end_dt" name="opr_end_dt" readonly   class="w80" maxlength="" /></label>             
                            <select name="opr_end_tm">
                                <option value="0900">09:00</option>
                                <option value="0930">09:30</option>
                                <option value="1000">10:00</option>
                                <option value="1030">10:30</option>
                                <option value="1100">11:00</option>
                                <option value="1130">11:30</option>
                                <option value="1200">12:00</option>
                                <option value="1230">12:30</option>
                                <option value="1300">13:00</option>
                                <option value="1330">13:30</option>
                                <option value="1400">14:00</option>
                                <option value="1430">14:30</option>
                                <option value="1500">15:00</option>
                                <option value="1530">15:30</option>
                                <option value="1600">16:00</option>
                                <option value="1630">16:30</option>
                                <option value="1700">17:00</option>
                                <option value="1730">17:30</option>
                                <option value="1800">18:00</option>
                                <option value="1830">18:30</option>
                                <option value="1900">19:00</option>
                                <option value="1930">19:30</option>
                                <option value="2000">20:00</option>
                                <option value="2030">20:30</option>
                                <option value="2100">21:00</option>
                                <option value="2130">21:30</option>
                                <option value="2200">22:00</option>
                                <option value="2230">22:30</option>
                                <option value="2300">23:00</option>
                                <option value="2330">23:30</option>     
                                <option value="2359">23:59</option>                             
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">신청자</th>
                        <td><input type="hidden" name="req_usr_id">
                            <label id="req_usr_nm"></label></td>
                    </tr>
                    <tr>
                     	<th class="" scope="row"><label for="opr_use_plc"><span class="essentia" style="color:#ff0000;">*</span> 담당수사관</label></th>
                        <td><input type="text" name="chr_usr_nm"   maxlength="" readOnly class="w_p50 required" id="chr_usr_nm" />
                        	<input type="hidden" name="chr_usr_id"  id="chr_usr_id" />
                         <a href="#" class="btn_orange" name="btn_srch_user">검색</a></td>
                    </tr>                    
                    <tr>
                        <th class="" scope="row"><label for="opr_use_plc"><span class="essentia" style="color:#ff0000;">*</span> 예약자원</label></th>
                        <td><input type="text" name="opr_use_plc"   maxlength=""  class="w_p100 required" id="opr_use_plc" readonly/></td>
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
<!--                         <td><label id="rsrc_lctn"></label></td> -->
<!--                     </tr> -->
                    <tr>
                        <th scope="row">자원설명</th>
                        <td><label id="rsrc_cntns"></label></td>
                    </tr>
<!--                     <tr> -->
<!--                         <th scope="row">좌석수</th> -->
<!--                         <td><label id="rsrc_cnt"></label></td> -->
<!--                     </tr> -->
                    <tr>
                        <th scope="row">운영자</th>
                        <td><label id="rsrc_mgt_nm"></label></td>
                    </tr>
                    <tr>
                        <th scope="row">신청가능일</th>
                        <td><label id="rsrc_ddcnt"></label></td>
                    </tr>
                </tbody>
            </table>
            <div class="layerpopup_bottom tx_c">
                <a href="#" class="btn_black" id="resve_add"    name="btn_resve_save">신청</a>
                <a href="#" class="btn_black" id="resve_modify" name="btn_resve_save">수정</a>
                <a href="#" class="btn_black" id="btn_resve_del" name="btn_resve_del">삭제</a>
                <a href="#" class="btn_orange btn_close">닫기</a>
                <!-- //사용관리등록 -->
            </div>
        </div>
    </form>
    </div>
    
    <div class="sub_layer_popup" id="resource_reg_pop" style="width:600px; display:none; margin-top:-380px; margin-left:-300px;">
        <div class="layer_popup_header">자원관리
            <a class="popup_close" title="닫기" >닫기</a>
        </div>
        <div class="layer_popup_white" style="overflow: scroll;">
            <form id="editForm" name="editForm" method="post" action="" >
            <table class="popup_board_table basic_table_view" summary="자원관리">
                <caption>자원관리</caption>
                <colgroup>
                    <col style="width:140px" />
                    <col style="auto" />
                </colgroup>
                <tbody>
                    <tr>
                        <th class="" scope="row"><label for=""><span class="essentia">*</span> 자원구분</label></th>
                        <td>
	                         <textarea id="editorCntt" name="editorCntt" style="width: 90%; min-width: 832px; height: 300px; display: none" ><c:out value="${result.cntns }" escapeXml="false" /></textarea>
                             <input type="hidden" name="cmd"         id="cmd" value="WRITE"/>           <%-- 작성 : WRITE, 수정 : MODIFY --%>
	                         <input type="hidden" name="maxFileCnt"  id="maxFileCnt" value="1"/>        <%-- 최대파일 갯수 --%>
	                         <input type="hidden" name="limitSize"   id="limitSize"  value="10485760"/> <%-- 파일별 최대 용량 --%>
	                         <input type="hidden" name="totFileSize" id="totFileSize" />                <%-- 전체 파일사이즈 --%>
	                         <input type="hidden" name="sizeSF"      id="sizeSF" />                     <%-- 파일 사이즈 format --%>
	                         <input type="hidden" name="contents"    id="contents" />                   <%-- 본문내용, 저장시 여기 값이 저장 --%>
	                         <input type="hidden" name="fileId"      id="fileId" />                      
	                         <input type="hidden" name="fileNm"      id="fileNm" />
	                         <input type="hidden" name="fileSize"    id="fileSize" />
	                         <input type="hidden" name="fileType"    id="fileType" />
	                         <input type="hidden" name="filePath"    id="filePath" />
	                         <input type="hidden" name="fileCtype"   id="fileCtype" />
	                         <input type="hidden" name="fileCnt"     id="fileCnt" value="0" />
                            <input type="hidden" name="delFileIds"  id="delFileIds" />
                            <select name="rsrc_clsf" class="required">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th class="" scope="row"><label for=""><span class="essentia">*</span> 자원부서</label></th>
                        <td>
                            <div>
                                <select name="dept_cd" class="required" >
                                   <option value="">부서선택</option>
                                </select>
                                <select name="rsrc_mgt_id" class="required">
                                    <option value="">운영자선택</option>
                                </select>
                            </div>
                            <!-- 
                            <ul class="label_list">
                                <li><label><input type="checkbox" name="" value="" /> 운영자1</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자2</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자3</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자4</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자5</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자6</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자7</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자8</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자9</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자10</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자11</label></li>
                                <li><label><input type="checkbox" name="" value="" /> 운영자12</label></li>
                            </ul>
                             -->
                        </td>
                    </tr>
                    <tr>
                        <th class="first" scope="row"><label for="rsrc_nm" ><span class="essentia">*</span> 자원명</label></th>
                        <td><input type="text" name="rsrc_nm"  maxlength="60"  class="w_p100 required" id="rsrc_nm" /></td>
                    </tr>
<!--                     <tr> -->
<!--                         <th class="" scope="row"><label for="ResourcesPos">위치</label></th> -->
<!--                         <td><input type="text" name="rsrc_lctn"  maxlength=""  class="w_p100" id="ResourcesPos" /></td> -->
<!--                     </tr> -->
<!--                     <tr> -->
<!--                         <th class="" scope="row"><label for="">좌석수</label></th> -->
<!--                         <td><input type="text" name="rsrc_cnt"  maxlength="4"  id="" class="w60 integer"/></td> -->
<!--                     </tr> -->
                    <tr>
                        <th class="" scope="row"><label for="rsrc_cntns"><span class="essentia">*</span> 자원설명</label></th>
                        <td><textarea id="rsrc_cntns" name="rsrc_cntns" class="required"></textarea></td>
                    </tr>
                    <tr>
                        <th class="" scope="row"><label for="rsrc_ddcnt"><span class="essentia">*</span> 예약신청가능일</label></th>
                        <td><input type="text" name="rsrc_ddcnt"  maxlength="3"  id="rsrc_ddcnt"  class="w60 required integer"/> 일전
                        </td>
                        
                    </tr>
                    </tbody>
            </table>
            </form>
            <table class="popup_board_table basic_table_view" summary="자원관리" style="border-top:0px">
             <caption>자원관리</caption>
             <colgroup>
                 <col style="width:140px" />
                 <col style="auto" />
             </colgroup>
             <tbody>
                    <tr>
                        <th class="" scope="row"><label for="file">사진</label></th>
                        <td>
                            <form name="setFileList" method="post" target="invisible" action="<%=request.getContextPath()%>/comm/fileMngr?cmd=delete">
                             <div class="file_list">
                                 <div>파일은 <span>1개까지</span> 첨부할 수 있으며, 전체 용량은 <span>100Mbyte</span>를 넘을 수 없습니다.</div>
                                 <ul id="uploadFileList">
                                 </ul>
                             </div>
                             <input type="hidden" name="semaphore" value="${semaphore}" />
                             <input type="hidden" name="vaccum" />
                             <input type="hidden" name="unDelList" />
                             <input type="hidden" name="delList" />
                         </form>
                         <form name="setUpload" method="post" enctype="multipart/form-data" target="invisible" action="<%=request.getContextPath()%>/comm/fileMngr?cmd=upload">
                             <input type="hidden" name="viewsize" readonly value='총 파일 크기: 0KB' />
                             <input type="hidden" name="totalsize" value="0" />
                             <input type="hidden" name="mode" value="attach" />
                             <input type="file" name="filename"  maxlength="" size="26" id="selectFileName"/>
                              <span id="uploading" style="display: none;" >
                                 <img src="<%=request.getContextPath()%>/board/images/board/skin/lesNotice/imgLoading.gif" align="absmiddle"/>
                                 <span id="uploadStatus"></span>
                             </span>
                             <a href="#" class="btn_white" onclick="ekrFile.uploadFile();$('#selectFileName').val('')">+ 추가</a>
                             <a href="#" class="btn_white" onclick="ekrFile.deleteFile();">- 삭제</a>
                         </form>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="layerpopup_bottom tx_c">
                <a href="#" class="btn_black" name="btn_rsrc_save">저장</a>
                <a href="#" class="btn_orange btn_close">닫기</a>
            </div>
        </div>
        <div id="uploading" class="loading" style="display: none;" >로딩중</div>
        <iframe name='invisible' frameborder="0" width="0" height="0"></iframe>
    </div>
    
    <form id="rsrc_able_frm">    
    <div class="sub_layer_popup" id="able_udt_pop" style="width:600px; display:none; margin-top:-200px; margin-left:-300px;" >
        <div class="layer_popup_header">
            사용관리
            <a class="popup_close" title="닫기" >닫기</a>
        </div>
        <div class="layer_popup_white">
            <div class="layerpopup_top">
                <div class="layerpopup_L">
                    <label name="able_rsrc_nm"></label>
                </div>
            </div>
            <table class="popup_board_table" summary="사용관리 등록">
                <caption>사용관리 등록</caption>
                <colgroup>
                    <col style="width:120px;" />
                    <col style="width:auto" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">불가시간</th>
                        <td>
                            <label for="" class="cursor"><input type="text" id="able_strt_dt" name="able_strt_dt" readonly   class="w80" maxlength="" /></label>
                            <select name="able_strt_tm">
                                <option value="0900">09:00</option>
                                <option value="0930">09:30</option>
                                <option value="1000">10:00</option>
                                <option value="1030">10:30</option>
                                <option value="1100">11:00</option>
                                <option value="1130">11:30</option>
                                <option value="1200">12:00</option>
                                <option value="1230">12:30</option>
                                <option value="1300">13:00</option>
                                <option value="1330">13:30</option>
                                <option value="1400">14:00</option>
                                <option value="1430">14:30</option>
                                <option value="1500">15:00</option>
                                <option value="1530">15:30</option>
                                <option value="1600">16:00</option>
                                <option value="1630">16:30</option>
                                <option value="1700">17:00</option>
                                <option value="1730">17:30</option>
                                <option value="1800">18:00</option>
                                <option value="1830">18:30</option>
                            </select>
                            ~ 
                            <label for="" class="cursor"><input type="text" id="able_end_dt" name="able_end_dt" readonly   class="w80" maxlength="" /></label>             
                            <select name="able_end_tm">
                                <option value="0900">09:00</option>
                                <option value="0930">09:30</option>
                                <option value="1000">10:00</option>
                                <option value="1030">10:30</option>
                                <option value="1100">11:00</option>
                                <option value="1130">11:30</option>
                                <option value="1200">12:00</option>
                                <option value="1230">12:30</option>
                                <option value="1300">13:00</option>
                                <option value="1330">13:30</option>
                                <option value="1400">14:00</option>
                                <option value="1430">14:30</option>
                                <option value="1500">15:00</option>
                                <option value="1530">15:30</option>
                                <option value="1600">16:00</option>
                                <option value="1630">16:30</option>
                                <option value="1700">17:00</option>
                                <option value="1730">17:30</option>
                                <option value="1800">18:00</option>
                                <option value="1830">18:30</option>
                                <option value="1900">19:00</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><span class="essentia" style="color:#ff0000;">*</span> 불가사유</th>
                        <td><textarea name="able_rsn" class="required"></textarea></td>
                    </tr>
                </tbody>
            </table>
            <div class="layerpopup_bottom tx_c">
                <a href="#" class="btn_black" name="btn_able_save">저장</a>
                <!-- <a href="#" class="btn_orange btn_close">취소</a> -->
                <a href="#" class="btn_orange btn_close">닫기</a>
                <!-- //사용관리등록 -->
            </div>
        </div>
    </div>


    <div class="sub_layer_popup" id="able_list_pop" style="width:600px; display:none; margin-top:-200px; margin-left:-300px;" >
        <div class="layer_popup_header">사용관리
            <a class="popup_close" title="닫기" >닫기</a>
        </div>
        <div class="layer_popup_white">
            <div class="layerpopup_top">
                <div class="layerpopup_L">
                    <label name="able_rsrc_nm"></label>
                </div>
            </div>
            <table class="popup_basic_table" summary="">
                <caption>사용관리</caption>
                <colgroup>
                    <col style="width:50px;" />
                    <col style="auto" />
                    <col style="auto" />
                </colgroup>
                <thead>
                    <th class="first">선택</th>
                    <th scope="col">불가시간</th>
                    <th class="last" scope="col">불가사유</th>
                </thead>
                <tbody>
                </tbody>
            </table>
            <div class="layerpopup_bottom tx_c">
                <a href="#" class="btn_black" name="btn_able_add">등록</a>
                <a href="#" class="btn_black" name="btn_able_upt">수정</a>
                <a href="#" class="btn_orange" name="btn_able_del">삭제</a>
                <a href="#" class="btn_orange btn_close" >닫기</a>
                <!-- //사용관리등록 -->
            </div>
        </div>
    </div>
    </form>
</body>
</html>
