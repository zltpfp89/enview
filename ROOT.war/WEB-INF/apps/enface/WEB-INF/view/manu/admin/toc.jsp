<%@page import="com.saltware.enface.util.DateUtil"%>
<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@page import="com.saltware.enview.Enview"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- <%@ taglib prefix="manu" uri="/WEB-INF/tld/manu.tld" %> --%>
<%
	String today = DateUtil.getCurrentDate("yyyy.MM.dd");
	request.setAttribute("today", today);
	request.setAttribute( "isManuManager", (EnviewSSOManager.getUserInfo(request)).getHasRole("ROLE_MNG_MD"));
	request.setAttribute( "userInfoMap", EnviewSSOManager.getUserInfoMap(request));
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>:: 전자매뉴얼 ::</title>
	
	<%-- 공통 스크립트 --%>
	<%@ include file="/common/common/commonScriptInclude.jsp"  %>
	<%-- 공통 스크립트 --%>
	
	<%-- 작성화면용 에디터 + upload 처리 --%>
	<script type="text/javascript" src="${cPath }/board/smarteditor/js/HuskyEZCreator.js"></script>
	<script type="text/javascript" src="/dhtmlx/vault/dhtmlxvault.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/sjpb/js/Z/jquery.sjpbEditor-1.0.js"></script>
	<link rel="stylesheet" type="text/css" href="/dhtmlx/vault/dhtmlxvault.css" />
	<script type="text/javascript" src="/sjpb/js/Z/enface_fileUpload.js"></script>

	<%-- // end --%>
	

	
	<script type="text/javascript">
		var sjpbFile = new SjpbEditManager();

	
		var uploadInitFlag = false;  //vaultUploader 업로드 호출 여부 플래그
		function initEditActionManager() {
			if(uploadInitFlag == false){
				uploadInitFlag = sjpbFile.init(); //vaultUploader 업로드 호출이 안되어있을시에만 업로드 모듈 초기화
			}
		}
	
		domHeight=0;
		
		$(document).ready(function () {
			
			initEditActionManager();		 
			
			$("#tocText").sjpbEditor({
				skin : "SmartEditor2SkinSjpbNoDRM"
			});
			
			//2016.05.20 김승식 : DOM ready 시 iframe resize
			try
			{
				domHeight = parseInt($("#sub_container_contents").height()) + 350;
				parent.document.getElementById(window.name).style.height = parseInt(domHeight)+"px";
				parent.parent.iframe_setHeightResize(parent.window.name,parseInt(domHeight));
				$(parent.window).scrollTop(0);
			}
			catch(e)
			{}
			
			
			$('input[type="radio"][name="ctgyYn"]').click(function(){
				var applState;
				//클릭 이벤트 발생한 요소가 체크 상태인 경우
				if ($(this).prop('checked')) {
					var value = $('input:radio[name="ctgyYn"]:checked').val();
					var tocArea = $('[name="tocArea"]');
					if(value =='N'){
						applState ="";
					}else{
						applState ="none";
					}
					for(var i = 1; i <= tocArea.length ; i++){
						$("#toc"+i).css("display",applState); 
					}
				}
			});

		});

		function fn_list() {
			$("#searchForm").submit();
		}
		
		function fn_detail() {
			$("#searchForm").attr("action", "${cPath}/cnfr/view.face?cnfrId=" + $("#cnfrId").val());
			$("#searchForm").submit();
			$("#searchForm").attr("action", "${cPath}/cnfr/list.face");
		}
		
		function fn_tempSave() {
			
		}
		
		function fn_save() {
			// vaildation
			
			var frm = document.getElementById("editForm");
			if ($("#tocDetail_subj").val() == null || $("#tocDetail_subj").val() == "") {
				alert("제목을 입력하십시오.");
				$("#tocDetail_subj").focus();
				return; 
			}
			  
			if 
			(
				oEditors.getById["tocText"].getIR() == null || 
				oEditors.getById["tocText"].getIR() == "" || 
				oEditors.getById["tocText"].getIR() == "<p>&nbsp;</p>" || 
				oEditors.getById["tocText"].getIR() == "<p></p>"
			) 
			{
				alert("내용을 입력하십시오.");
				return;
			}
			
			$("#tocText").getEditorHtml();
			
			
			
							
			// 선행작업
			var bfTocIds = '';
			$("div[id^='bf']").each( function() {
				var id = $(this).attr('id');
				var data = id.split('_');
				bfTocIds += data[1] + '|';
			});
			$("#tocDetail_bfTocIds").val( bfTocIds);
			
			// 후행작업
			var afTocIds = '';
			$("div[id^='af']").each( function() {
				var id = $(this).attr('id');
				var data = id.split('_');
				afTocIds += data[1] + '|';
			});
			$("#tocDetail_afTocIds").val( afTocIds);
			
			
			//$("#fileCnt").val($("#uploadFileList li").length);

			//2016.05.18 김승식 : 관련명령 input 데이터 가져오는 방식 변경 
			var cmds = document.getElementsByName("cmds");
			var cmdsDatas = "";
			for(var i=0 ; i < cmds.length ; i++)
			{
				cmdsDatas += "," + cmds[i].value;
			}
			$("#cmdsDatas").val(cmdsDatas.substring(1));
			
			
			if (sjpbFile.vaultUploader) {
				sjpbFile.vaultUploader.attachEvent("onUploadComplete", function (files) {		
					var fileList = sjpbFile.vaultUploader.getData();
					if (files.length > 0) {  
						for (var i = 0 ; i < fileList.length ; i++) {
							frm.fileId.value += fileList[i].serverName + "|";
							frm.fileNm.value += fileList[i].name + "|";
							frm.fileMask.value += fileList[i].serverName + "|";
							frm.fileSize.value += fileList[i].size + "|";
						}
						$('#fileCnt').val(files.length);
					}
					sjpbFile.isNewFile = false;
					sjpbFile.isCancel = false;		
					
					
					fn_ajax({
						url : "${cPath}/manu/admin/saveTocForAjax.face",  
						param : $('#editForm').serialize(), 
						callback : {success : function (data) {fn_saveSuccess(data);}, error : function (data) {alert(data.status);}}
					});			
					
					
				});	
				
				if (sjpbFile.isNewFile) { //업로드 대상이 있는 경우			
					sjpbFile.vaultUploader.upload();
				} else {  //업로드 대상이 없는 경우			
					frm.fileId.value = "";
					frm.fileNm.value = "";
					frm.fileMask.value = "";
					frm.fileSize.value = "";

					var fileList = sjpbFile.vaultUploader.getData();
					if (fileList.length > 0) {
						for (var i = 0 ; i < fileList.length ; i++) {
							frm.fileId.value += fileList[i].serverName + "|";
							frm.fileNm.value += fileList[i].name + "|";
							frm.fileMask.value += fileList[i].serverName + "|";
							frm.fileSize.value += fileList[i].size + "|";
						}
						$('#fileCnt').val(fileList.length);
					}
					sjpbFile.isCancel = false;

					fn_ajax({
						url : "${cPath}/manu/admin/saveTocForAjax.face",  
						param : $('#editForm').serialize(), 
						callback : {success : function (data) {fn_saveSuccess(data);}, error : function (data) {alert(data.status);}}
					});	
					
				} 
			}

		}
		
		function fn_saveSuccess(data){
			if (data.status == "SUCCESS") {
				alert("성공적으로 저장하였습니다.");
			} else {
				alert("처리중 오류가 발생하였습니다.");
			}
			try {
				//parent.fn_searchTocTree();

			}catch(e){}
			
//			fn_list();
window.close();
		}
		
		function fn_move() {
			parent.fn_selectTocPopup('move', 
					function ( data, moveType) {
						if( data.length > 0) {
							toc = data[0].original;
							if( toc.lev==0) {
								// 모듈 이동
								fn_move_it( moveType, toc.md_id, toc.md_id, 1, toc.parent);
							} else {
								fn_move_it( moveType, toc.md_id, toc.id, toc.seq, toc.parent);
							}
						}
						return true;
					});
		}
		
		
		function fn_move_it( moveType, mdId, tocId, seq, upTocId) {
			
			if( !confirm( '목차를 이동하시겠습니까?')) {
				return;
			}			
			
			var param = { srcId : $("#tocDetail_tocId").val(),
						moveType : moveType,
						tocId : tocId,
						mdId : mdId,
						seq : seq,
						upTocId : upTocId,
			};
			
			var url = "${cPath}/manu/admin/moveTocForAjax.face";
			fn_ajax({
				url : url,
				param : $.param(param),
				callback : {
					success : function (data) {
						if (data.data > 0) {
							alert("성공적으로 이동하였습니다.");
						}
						try {
							parent.fn_searchTocTree();
						}catch(e){}
						fn_list();
					},
					error : function (data) {
						alert(data.msg);
					}
				}
			});
		}
		
		function fn_delete() {
			if( !confirm( '목차를 삭제하시겠습니까?')) {
				return;
			}
			var tocId = $("#tocDetail_tocId").val();
			
			var param = 'tocId=' + tocId;
			
			var url = "${cPath}/manu/admin/deleteTocForAjax.face";
			fn_ajax({
				url : url,
				param : param,
				callback : {
					success : function (data) {
						alert("삭제하였습니다.");
						try {
							parent.fn_searchTocTree();
						}catch(e){}
						fn_list();
					},
					error : function (data) {
						alert(data.msg);
					}
				}
			});
		}
		

		function autoResize(height,m) {
			try {
// 				parent.autoresize_iframe_portlets();
				//2016.05.20 김승식 추가 
				if(height != null && height != "" && height != "undefined")
				{
					if("+" == m)
					{
						domHeight = parseInt(domHeight) + parseInt(height);
					}
					else if("-" == m)
					{
						domHeight = parseInt(domHeight) - parseInt(height);
					}
					
					/* parent.document.getElementById(window.name).style.height = parseInt(domHeight)+"px";	
					parent.parent.document.getElementById(parent.window.name).style.height = parseInt(domHeight)+"px";			 */	
					parent.document.getElementById(window.name).style.height = parseInt(domHeight)+"px";
					parent.parent.iframe_setHeightResize(parent.window.name,parseInt(domHeight));
				}
			} catch(e) {
			}
		}

		// 명령 추가
		function fn_addCmd() {
			$("#tocDetail_cmdTd").append(' <input type="text" name="cmds" maxlength="50" size="50" value=""/>');
			autoResize('30','+');
		}
		
		// 선행작업 추가
		function fn_addBf() {
			parent.fn_selectTocPopup('bf', 
				function ( data) {
					if( data.length > 0) {
						for( var i = 0; i < data.length; i++ ) {
							toc = data[i].original;
							if( toc.lev==0) {
								alert( '목차를 선택하세요');
								return false;
							}
							var toc_id = toc.id;
							var p = toc.text.indexOf(' ');
							var toc_nm = toc.text.substring( p); 
							var html = "<div id='bf_" + toc_id + "'>";
							html += "["  + toc.md_nm + "] " + toc_nm; 
	    					html += " <a href=\"javascript:fn_delBf('" +toc_id  + "')\" class=\"font_color_red\" title=\"삭제\">X</a>&nbsp;&nbsp;"
							html += " <div>"
							$("#tocDetail_bfTd").append( html);
						}
					}
					autoResize('10','+');
					return true;
				}		
			);
		}
		
		function fn_delBf( id) { 
			$("#bf_" + id).remove();
			autoResize('10','-');
		}
		
		// 선행작업 추가
		function fn_addAf() {
			parent.fn_selectTocPopup('af', 
				function ( data) {
					if( data.length > 0) {
						for( var i = 0; i < data.length; i++ ) {
							toc = data[i].original;
							if( toc.lev==0) {
								alert( '목차를 선택하세요');
								return false;
							}
							var toc_id = toc.id;
							var p = toc.text.indexOf(' ');
							var toc_nm = toc.text.substring( p); 
							var html = "<div id='af_" + toc_id + "'>";
							html += "["  + toc.md_nm + "] " + toc_nm; 
	    					html += " <a href=\"javascript:fn_delAf('" +toc_id  + "')\" class=\"font_color_red\" title=\"삭제\">X</a>&nbsp;&nbsp;"
							html += " <div>"
							$("#tocDetail_afTd").append( html);
						}
					}
					autoResize('10','+');
					return true;
				}		
			);
		}
		
		function fn_delAf( id) { 
			$("#af_" + id).remove();
			autoResize('10','-');
		}
		

		function fn_getChkUserInfo() {
			var html = "";
			var ptcpIds = $("#ptcpIds").val();
    		$("input[name='chkValue']").each(function () {
    			if ($(this).prop("checked")) {
    				//this.id + "|" + this.name + "|" + this.dept + "|" + this.oflv
					var arr = $(this).val().split("|");
					
    				if ($("#" + arr[0]).attr("class") == null || $("#" + arr[0]).attr("class") == "") {
    					html += "<div class=\"name_popup_open cursor\" style=\"vertical-align: middle\" id=\"" + arr[0] + "\">";
    				html += "		<span class=\"icon_user\"></span>" + arr[1] + "(" + arr[2] + ")";
    					html += "	<a href=\"javascript:fn_delPtcpUser('" + arr[0]  + "')\" class=\"font_color_red\" title=\"삭제\">X</a>&nbsp;&nbsp;"
    					html += "</div>";
    					
    					ptcpIds += arr[0] + "|";
    				}
    			}
    		});
    		$("#ptcpList").append(html);
    		$("#ptcpIds").val(ptcpIds);
    	}
		
		function fn_delPtcpUser(userId) {
			if (confirm("해당 참석자를 삭제 하시겠습니까?")) {
				var ptcpIds = $("#ptcpIds").val();
				var replaceId = userId + "|";
				$("#ptcpIds").val(ptcpIds.replace(replaceId, ""));
				$("#" + userId).remove();
			}
		}
		
		function fn_setResource(data) {
			var strtTm = data.data.oprStrtTm;
			var endTm = data.data.oprEndTm;
			
			var strtDt = strtTm.substring(0,4) + "." + strtTm.substring(4,6) + "." + strtTm.substring(6,8);
			var strtTime = strtTm.substring(8,12);
			var endDt = endTm.substring(0,4) + "." + endTm.substring(4,6) + "." + endTm.substring(6,8);
			var endTime = endTm.substring(8,12);
			
			$("#cnfrOprId").val(data.data.oprId);
			$("#cnfrRsrcId").val(data.data.rsrcId);
			$("#cnfrPlceClsf").val(data.data.oprApvClsf);
			$("#cnfrPlceNm").val(data.data.oprUsePlc);
			$("#strtDt").val(strtDt);
			$("#startTime").val(strtTime);
			$("#endDt").val(endDt);
			$("#endTime").val(endTime);
			$("#cnfrPtcpTxt").val(data.data.oprUseCntns);
		}
		
		function fn_close(){
			window.close();
		}
		

	</script>
</head>

<body>
	<div class="sub_container" id="sub_container_contents" style="min-width: 717px;">
		<!-- content start -->
		<div id="content">
			<h4>목차관리 <c:out value="${empty param.tocId ? '등록' : '수정' }"/></h4>
<!-- 			<div class="board_top "> -->
<!-- 				<div class="board_btn_R"> -->
<%-- 					<c:if test="${!empty param.tocId}"> --%>
<%-- 						<c:if test="${userInfoMap.userId == toc.tocCrUsr}"> --%>
<!-- 					<a href="javascript:fn_save();" target="_self" class="btn_black">저장</a> -->
<!-- 					<a href="javascript:fn_delete();" target="_self" class="btn_black">삭제</a> -->
<!-- 					<a href="javascript:fn_move();" target="_self" class="btn_black">이동</a> -->
<%-- 					</c:if> --%>
<%-- 						</c:if> --%>
<%-- 					<c:if test="${empty param.tocId}"> --%>
<!-- 						<a href="javascript:fn_save();" target="_self" class="btn_black">저장</a> -->
<%-- 					</c:if> --%>
<!-- 					<a href="javascript:fn_list();" target="_self" class="btn_white">목록</a> -->
<!-- 				</div> -->
<!-- 			</div> -->
			
			<table class="basic_table_write " summary="목차관리 제목,">
				<caption>목차관리 글작성</caption>
				<colgroup>
					<col style="width:96px" />
					<col style="width:auto" />
					<col style="width:120px" />
					<col style="width:auto" />
				</colgroup>
				
				<tbody>
					<form id="editForm" name="editForm" method="post" action="" >
					<input type="hidden" name="cmd"         id="cmd" value="<c:out value='${param.cmd}' />"/>		<%-- 작성 : WRITE, 수정 : MODIFY --%>
					<input type="hidden" name="maxFileCnt"  id="maxFileCnt" value="10"/>			<%-- 최대파일 갯수 --%>
					<input type="hidden" name="limitSize"   id="limitSize"  value="10485760"/>		<%-- 파일별 최대 용량 --%>
					<input type="hidden" name="totFileSize" id="totFileSize" />						<%-- 전체 파일사이즈 --%>
					<input type="hidden" name="sizeSF"      id="sizeSF" />							<%-- 파일 사이즈 format --%>
					<input type="hidden" name="fileId"    	id="fileId" />						
					<input type="hidden" name="fileNm"    	id="fileNm" />
					<input type="hidden" name="fileMask"    id="fileMask" />
					<input type="hidden" name="fileSize"    id="fileSize" />
					<input type="hidden" name="fileCnt"    	id="fileCnt" value="10" />
					<input type="hidden" name="delFileIds" 	id="delFileIds" />
					<input type="hidden" name="tocId" 		id="tocDetail_tocId" value="${toc.tocId}"/>
					<input type="hidden" name="upTocId" 	id="tocDetail_upTocId" value="${toc.upTocId}"/>
					<input type="hidden" name="mdId" 		id="tocDetail_mdId" value="${toc.mdId}"/>
					<input type="hidden" name="afTocIds" 	id="tocDetail_afTocIds" />
					<input type="hidden" name="bfTocIds" 	id="tocDetail_bfTocIds" />
					<!-- 2016.05.18 김승식 추가 -->
					<input type="hidden" name="cmdsDatas" 	id="cmdsDatas" />
					
					<c:if test="${isManuManager}">
					<tr>
						<th class="">
							<label for="ctgyYn"><span class="essentia">*</span>카테고리/모듈 선택</label>
						</th>
						<td colspan="3">
							<input type="radio" id="ctgyYn1" name="ctgyYn" value="N" checked /><label for='ctgyYn1'>모듈</label>
							<input type="radio" id="ctgyYn2" name="ctgyYn" value="Y"  /><label for='ctgyYn2'>카테고리</label>
						</td>
					</tr>
					</c:if>
					<c:if test="${!isManuManager}">
						<input type="hidden" id="ctgyYn" name="ctgyYn" value="N"  />
					</c:if>
					
					<tr>
						<th class="">
							<label for="tocDetail_subj"><span class="essentia">*</span> 제목</label>
						</th>
						<td colspan="3">
							<input type="text" id="tocDetail_subj" name="subj" maxlength="33" class="w_p100" value="${toc.subj}" />
						</td>
					</tr>
					<tr id="toc1" name="tocArea">
						<th class=""><span class="essentia">*</span> 내용</th>
						<td colspan="3">
							<div id="smarteditor">
								<textarea id="tocText" name="contents" style="display: none;"><c:out value="${toc.contents}" escapeXml="false" /></textarea>
							</div>
						</td>
					</tr>
					
<%-- 					<tr id="toc2" name="tocArea">
						<th class="">관련명령
						<a href="javascript:fn_addCmd();" target="_self" class="btn_white">추가</a>						
						</th>
						<td colspan="3" id="tocDetail_cmdTd">
						<c:forEach items="${toc.cmdList}" var="cmd">
						<input type="text" name="cmds" maxlength="50" size="50" value="${cmd.tCd}"/>
						</c:forEach> 
						<input type="text" name="cmds" maxlength="50" size="50" value=""/>
						</td>
					</tr>
					<tr id="toc3" name="tocArea">
						<th class="">선행작업
						<a href="javascript:fn_addBf();" target="_self" class="btn_white">추가</a>				
						</th>
						<td colspan="3" id="tocDetail_bfTd">
						<c:forEach items="${toc.bfList}" var="toc">
						<div id="bf_${toc.tocId}">
						[<c:out value="${toc.mdNm}"/>] <c:out value="${toc.SUBJ}"/>
    					<a href="javascript:fn_delBf('${toc.tocId}')" class="font_color_red" title="삭제">X</a>
						</div>							
						</c:forEach> 
						</td>
					</tr>
					<tr id="toc4" name="tocArea">
						<th class="">후행작업
						<a href="javascript:fn_addAf();" target="_self" class="btn_white">추가</a>						
						</th>
						<td colspan="3" id="tocDetail_afTd">
						<c:forEach items="${toc.afList}" var="toc">
						<div id="af_${toc.tocId}">
						[<c:out value="${toc.mdNm}"/>] <c:out value="${toc.SUBJ}"/>
    					<a href="javascript:fn_delAf('${toc.tocId}')" class="font_color_red" title="삭제">X</a>
						</div>							
						</c:forEach> 
					</tr> --%>
					</form>
					<tr id="toc2" name="tocArea">
						<th class=""><label for="file">파일첨부</label></th>
						<td colspan="3">
							 <div id = "vault_upload" class="righr_box"></div>
							 <c:set var="fileList" value="${toc.fileList}"/>
							 <ul id="vault_fileList" style="display: none;">
							 	<c:forEach items="${fileList}" var="file">
									<li data-name="<c:out value='${file.fileNm}'/>" data-mask="<c:out value='${file.fileMask}'/>" data-size="<c:out value='${file.fileSize}'/>"><c:out value="${file.fileNm}"/></li>
								</c:forEach>	
							 </ul>
						<form name="setFileList" method="post" target="invisible" action="/comm/AddOnfileMngr?cmd=delete">
							<input type=hidden name=semaphore value="">
							<input type=hidden name=vaccum>
							<input type=hidden name=delBoardId value="">
							<input type=hidden name=unDelList>
							<input type=hidden name=delList>
							<input type=hidden name=subId value=sub01>
						</form>								 
						</td>
					</tr>
				</tbody>
			</table>
		
			<!-- 하단버튼영역 start -->
			<div class="board_bottom">
				<div class="board_btn_R">
					<c:if test="${!empty param.tocId}">
						<c:if test="${userInfoMap.userId == toc.tocCrUsr}">
					<a href="javascript:fn_save();" target="_self" class="btn_black">저장</a>
					<a href="javascript:fn_delete();" target="_self" class="btn_black">삭제</a>
					<a href="javascript:fn_move();" target="_self" class="btn_black">이동</a>
					</c:if>
						</c:if>
					<c:if test="${empty param.tocId}">
						<a href="javascript:fn_save();" target="_self" class="btn_black">저장</a>
					</c:if>
					<!-- <a href="javascript:fn_list();" target="_self" class="btn_white">목록</a> -->
					<a href="javascript:fn_close();" target="_self" class="btn_blue">닫기</a>

				</div>
			</div>
			<!-- //하단버튼영역 end -->
		</div>
		<!-- //content end -->
	</div>
	<iframe name='invisible' frameborder="0" width="0" height="0"></iframe>
	
	<form id="searchForm" action="${cPath }/manu/admin/selectTocList.face" target="_self" method="post">
	<input type="hidden" name="tocId" 		id="tocDetail_tocId" value="${toc.tocId}"/>
	<input type="hidden" name="upTocId" 	id="tocDetail_upTocId" value="${toc.upTocId}"/>
	<input type="hidden" name="mdId" 		id="tocDetail_mdId" value="${toc.mdId}"/>
	</form>
	
	<div id="uploading" class="loading" style="display: none;" >로딩중</div>
</body>
</html>