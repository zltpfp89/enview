<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setAttribute("cPath", request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>:: 금융감독원 수사지원시스템 ::</title>
	<link rel="stylesheet" type="text/css" href="${cPath}/fss/css/contents.css" />
	<link rel="stylesheet" type="text/css" href="${cPath}/fss/js/dhtmlx/suite/dhtmlx.css" />
	<script type="text/javascript" src="${cPath}/javascript/jquery/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="${cPath}/fss/js/main.js"></script>
	<script type="text/javascript" src="${cPath}/fss/reference/js/ekr_fileUpload_seal.js"></script>
	<script type="text/javascript" src="${cPath}/fss/reference/js/ekr_fileUpload_id.js"></script>
	<script type="text/javascript" src="${cPath}/fss/reference/js/ekr_fileUpload_sign.js"></script>
	<script>
		$(function(){
			ekrFile_seal.edit_init();
			ekrFile_id.edit_init();
			ekrFile_sign.edit_init();
		});	
	
		//직인정보 등록 ajax
		function uploadSealData(){
			ekrFile_seal.setForm();
			
			var fileMap = {
				"fileId" : $("#editForm_seal > input[name=fileId]").val() ,
				"fileNm" : $("#editForm_seal > input[name=fileNm]").val() ,
				"fileSize" : $("#editForm_seal > input[name=fileSize]").val() ,
				"fileType" : $("#editForm_seal > input[name=fileType]").val() ,
				"filePath" : $("#editForm_seal > input[name=filePath]").val() ,
				"fileCtype" : $("#editForm_seal > input[name=fileCtype]").val() ,
				"fileCnt" : $("#editForm_seal > input[name=fileCnt]").val() ,
				"delFileIds" : $("#editForm_seal > input[name=delFileIds]").val() ,
				"idType" : "seal"
			};

			$.ajax({
		        type : 'post',
		        url : '/fss/mypage/insertMypageDta.face',
		        dataType : 'json',
		        data : fileMap ,
		        success:function(json){
		        	if(json.status == "SUCCESS"){
		        		callBackInsertSealDtaSuccess(json);
		        	} else {
		        		alert(json.msg);
		        	}
		        }, error:function(request,status,error){
	                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		        } 
	   		});
		}
		
		function callBackInsertSealDtaSuccess(json){
			ekrFile_seal.fileUploadCallback();
			
			//img src 바꾸기
			if(json.uploadPath.indexOf("_pdf") == -1){
				$("#img_seal").attr("src", json.uploadPath.substring(0, json.uploadPath.lastIndexOf(",")));
			} else {
				$("#img_seal").attr("src", "/fss/images/pdf_img_1.gif");
			}
			
			var sealHtml="";
			sealHtml += '<a href="${cPath}/sjpb/Z/AddOnDownload.face?isPid=Y&fileId=' + json.fileId + '" target="invisible"><img src="${cPath}/common/images/icon_file.png" alt="첨부파일" />';
			sealHtml += '<span>직인파일</span>';
			sealHtml += '</a>';
			
			$("#sealPdf").html(sealHtml);
			
			alert("등록되었습니다.");
		}
		
		//신분증정보 등록 ajax
		function uploadIdData(){
			ekrFile_id.setForm();
			
			var fileMap = {
				"fileId" : $("#editForm_id > input[name=fileId]").val() ,
				"fileNm" : $("#editForm_id > input[name=fileNm]").val() ,
				"fileSize" : $("#editForm_id > input[name=fileSize]").val() ,
				"fileType" : $("#editForm_id > input[name=fileType]").val() ,
				"filePath" : $("#editForm_id > input[name=filePath]").val() ,
				"fileCtype" : $("#editForm_id > input[name=fileCtype]").val() ,
				"fileCnt" : $("#editForm_id > input[name=fileCnt]").val() ,
				"delFileIds" : $("#editForm_id > input[name=delFileIds]").val() ,
				"idType" : "id"
			};

			$.ajax({
		        type : 'post',
		        url : '/fss/mypage/insertMypageDta.face',
		        dataType : 'json',
		        data : fileMap ,
		        success:function(json){
		        	if(json.status == "SUCCESS"){
		        		callBackInsertIdDtaSuccess(json);
		        	} else {
		        		alert(json.msg);
		        	}
		        }, error:function(request,status,error){
	                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		        } 
	   		});
		}
		
		function callBackInsertIdDtaSuccess(json){
			ekrFile_id.fileUploadCallback();
			
			//img src 바꾸기
			if(json.uploadPath.indexOf("_pdf") == -1){
				$("#img_id").attr("src", json.uploadPath.substring(0, json.uploadPath.lastIndexOf(",")));
			} else {
				$("#img_id").attr("src", "/fss/images/pdf_img_1.gif");
			}
			
			var idHtml="";
			idHtml += '<a href="${cPath}/sjpb/Z/AddOnDownload.face?isPid=Y&fileId=' + json.fileId + '" target="invisible"><img src="${cPath}/common/images/icon_file.png" alt="첨부파일" />';
			idHtml += '<span>신분증파일</span>';
			idHtml += '</a>';
			
			$("#iodPdf").html(idHtml);
			
			alert("등록되었습니다.");
		}
		
		//서명정보 등록 ajax
		function uploadSignData(){
			ekrFile_sign.setForm();
			
			var fileMap = {
				"fileId" : $("#editForm_sign > input[name=fileId]").val() ,
				"fileNm" : $("#editForm_sign > input[name=fileNm]").val() ,
				"fileSize" : $("#editForm_sign > input[name=fileSize]").val() ,
				"fileType" : $("#editForm_sign > input[name=fileType]").val() ,
				"filePath" : $("#editForm_sign > input[name=filePath]").val() ,
				"fileCtype" : $("#editForm_sign > input[name=fileCtype]").val() ,
				"fileCnt" : $("#editForm_sign > input[name=fileCnt]").val() ,
				"delFileIds" : $("#editForm_sign > input[name=delFileIds]").val() ,
				"idType" : "sign"
			};

			$.ajax({
		        type : 'post',
		        url : '/fss/mypage/insertMypageDta.face',
		        dataType : 'json',
		        data : fileMap , 
		        success:function(json){
		        	if(json.status == "SUCCESS"){
		        		callBackInsertSignDtaSuccess(json);
		        	} else {
		        		alert(json.msg);
		        	}
		        }, error:function(request,status,error){
	                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		        } 
	   		});
		}
		
		function callBackInsertSignDtaSuccess(json){
			ekrFile_sign.fileUploadCallback();
			
			//img src 바꾸기
			if(json.uploadPath.indexOf("_pdf") == -1){
				$("#img_sign").attr("src", json.uploadPath.substring(0, json.uploadPath.lastIndexOf(",")));
			} else {
				$("#img_sign").attr("src", "/fss/images/pdf_img_1.gif");
			}
			
			var signHtml="";
			signHtml += '<a href="${cPath}/sjpb/Z/AddOnDownload.face?isPid=Y&fileId=' + json.fileId + '" target="invisible"><img src="${cPath}/common/images/icon_file.png" alt="첨부파일" />';
			signHtml += '<span>서명파일</span>';
			signHtml += '</a>';
			
			$("#signPdf").html(signHtml);
			
			alert("등록되었습니다.");
		}
		
		//직인, 신분증 사본, 서명 삭제
		function deleteMypageDta(idType){
			if(confirm("삭제하시겠습니까?")){
				$.ajax({
			        type : 'post',
			        url : '/fss/mypage/deleteMypageDta.face',
			        dataType : 'json',
			        data : { "idType" : idType } , 
			        success:function(json){
			        	if(idType == "seal"){
			        		$("#img_" + idType).attr("src", "${cPath}/fss/images/no_img_1.gif");
			        	} else if(idType =="id"){
			        		$("#img_" + idType).attr("src", "${cPath}/fss/images/no_img_2.gif");
			        	} else {
			        		$("#img_" + idType).attr("src", "${cPath}/fss/images/no_img_3.gif");
			        	}
			        	if(idType == "id"){
			        		$("#iodPdf").empty();
			        	} else {
			        		$("#" + idType + "Pdf").empty();
			        	}
			        	alert("삭제가 완료되었습니다.");
			        }, error:function(request,status,error){
		                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			        } 
		   		});
			}
		}
		
		//Fax 전송에 필요한 기본정보 저장
		function insertBasicInfo(){
			$.ajax({
		        type : 'post',
		        url : '/fss/mypage/insertBasicInfo.face',
		        dataType : 'json',
		        data : $("#basicForm").serialize(), 
		        success:function(json){
		        	alert("저장 완료되었습니다.");
		        }, error:function(request,status,error){
	                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		        } 
	   		});
		}
		
	</script>
</head>
<body class="iframe">
    <div class="list">
        <table class="list mar_0" cellpadding="0" cellspacing="0">
            <caption>게시판쓰기</caption>
            <colgroup>
                <col width="20%" />
                <col width="40%" />
            </colgroup>
	        <tbody>
	            <tr>
	                <th class="C th_line ">성명</th>
	                <td class="L td_line ">${user.nmKor}</td>
	            </tr>
	            <tr>
	                <th class="C th_line ">기본정보</th>
	                <td class="L td_line ">
	                	<div style="display: inline-block; float: left; width: 15%;">
	                		<ul>
	                            <li><span>팩스 번호</span></li>
	                            <li><span>사무실 전화번호</span></li>
	                            <li><span>이메일</span></li>
                            </ul>
                        </div>
                        <form id="basicForm" name="basicForm" method="post" action="/fss/mypage/insertBasicInfo.face">
                        <div style="display: inline-block; float: left; width: 70%;">
                            <ul>
	                            <li><input type="text" name="faxNo" id="faxNo" value="${user.faxNo}" /></li>
	                            <li><input type="text" name="offcTel" id="offcTel" value="${user.offcTel}" /></li>
	                            <li><input type="text" name="emailAddr" id="emailAddr" value="${user.emailAddr}" /></li>
                            </ul>
	                	</div>
	                	<div style="display: inline-block; float: left; width: 15%; margin-top: 44px;">
	                		<a href="javascript:insertBasicInfo();" class="btn_file"><span>저장</span></a>
                		</div>
	                	</form>
	                </td>
	            </tr>
	            <tr>
	                <th class="C th_line ">직인등록정보</th>
	                <td class="L td_line ">
	                    <div class="fileArea">
	                    	<c:if test="${not empty user.userInfo01}">
	                    		<c:if test="${not fn:containsIgnoreCase(user.userInfo01, 'pdf')}"><img src="/upload${user.userInfo01}" id="img_seal" alt="직인" width="100%" height="100%" /></c:if>
	                    		<c:if test="${fn:containsIgnoreCase(user.userInfo01, 'pdf')}"><img src="/fss/images/pdf_img_1.gif" id="img_seal" alt="직인" width="100%" height="100%" /></c:if>
	                    	</c:if>
	                    	<c:if test="${empty user.userInfo01}">
	                    		<img src="${cPath}/fss/images/no_img_1.gif" id="img_seal" alt="직인" width="100%" height="100%" />
	                    	</c:if>
	                    </div>
	                    <p class="fax_title">
	                    	※ 직인을 등록하지 않으면, 시스템 기능 사용에 제약이 있을 수 있습니다.(수사관 개인 직인이 포함되는 서식출력 등의 기능 사용 제한)<br />
	                    	※ .jpg, .jpeg, .png, .gif 파일 등록 가능합니다.<br />
	                    	<span id="sealPdf"><c:if test="${not empty user.userInfo01}"><a href="${cPath}/sjpb/Z/AddOnDownload.face?isPid=Y&fileId=${user.userInfo04}" target="invisible"><img src="${cPath}/common/images/icon_file.png" alt="첨부파일" /><span>직인파일</span></a></c:if></span>
	                    </p>
	                    <div style="height: 50px;">
							<form id="editForm_seal" name="editForm_seal" method="post" action="" style="display: inline-block; visibility: hidden;">
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
					      	</form>
							<form name="setFileList_seal" method="post" target="invisible" action="<%=request.getContextPath()%>/comm/fileMngr?cmd=delete" style="display: inline-block; visibility: hidden;">					
								<div class="addFile">
									<div class="filelist">
			                        	<ul id="uploadFileList_seal">
			                        	</ul>
									</div>
								</div>
			                	<input type="hidden" name="semaphore" value="${semaphore}" />
				                <input type="hidden" name="vaccum" />
				                <input type="hidden" name="unDelList" />
				                <input type="hidden" name="delList" />						
							</form>
							<form name="setUpload_seal" method="post" enctype="multipart/form-data" target="invisible" action="<%=request.getContextPath()%>/comm/fileMngr?cmd=upload" style="display: inline-block;">
					            <input type="hidden" name="viewsize" readonly value='총 파일 크기: 0KB' />
					            <input type="hidden" name="totalsize" value="0" />
					            <input type="hidden" name="mode" value="attach" />
					            <input type="hidden" name="idType" value="seal" />
					            <input type="file" name="filename"  maxlength="" size="26" class="file_input" id="selectFileName_seal" accept=".jpg,.jpeg,.png,.gif" style="position: absolute; left: -500px;" onchange="ekrFile_seal.uploadFile();" />
				                <span id="uploading" style="display: none;">
			                   		<img src="<%=request.getContextPath()%>/board/images/board/skin/lesNotice/imgLoading.gif" align="middle"/>
				                   	<span id="uploadStatus"></span>
				               	</span>
				               	<input type="hidden" name="iesucks" value="iesucks" />
				            </form>
	                    </div>
	                    <a href="#" class="btn_file" onclick="$('#selectFileName_seal').click();"><span>등록</span></a> 
						<a href="javascript:deleteMypageDta('seal');" class="btn_file"><span>삭제</span></a>
	                </td>
	            </tr>
	            <tr>
	                <th class="C th_line ">특사경 신분증 등록정보</th>
	                <td class="L td_line ">
	                	<div class="mg10">
	                        <div class="fileArea2">
	                        	<c:if test="${not empty user.userInfo02}">
		                    		<c:if test="${not fn:containsIgnoreCase(user.userInfo02, 'pdf')}"><img src="/upload${user.userInfo02}" id="img_id" alt="신분증" width="100%" height="100%" /></c:if>
		                    		<c:if test="${fn:containsIgnoreCase(user.userInfo02, 'pdf')}"><img src="/fss/images/pdf_img_1.gif" id="img_id" alt="신분증" width="100%" height="100%" /></c:if>
		                    	</c:if>
		                    	<c:if test="${empty user.userInfo02}">
		                    		<img src="${cPath}/fss/images/no_img_2.gif" id="img_id" alt="신분증" width="100%" height="100%" />
		                    	</c:if>
	                        </div>
	                        <p class="fax_title">
                           		※신분증을 등록하지 않으면, 시스템 기능 사용에 제약이 있을 수 있습니다.<br />
                           		 (수사관 신분증이 사용되는 전자FAX 등의 기능 사용 제한)<br />
                           		※신분증 앞면, 뒷면을 A4용지 한페이지 내에 스캔하여 업로드하셔야 합니다.<br />
                           		※.jpg, .jpeg, .png, .gif, .pdf 파일 등록 가능합니다.<br />
	                            <span id="iodPdf"><c:if test="${not empty user.userInfo02}"><a href="${cPath}/sjpb/Z/AddOnDownload.face?isPid=Y&fileId=${user.userInfo05}" target="invisible"><img src="${cPath}/common/images/icon_file.png" alt="첨부파일" /><span>신분증파일</span></a></c:if></span>
	                        </p>
	                        <div style="height: 80px;">
	                        	<form id="editForm_id" name="editForm_id" method="post" action="" style="display: inline-block; visibility: hidden;">
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
						      	</form>
	                        	<form name="setFileList_id" method="post" target="invisible" action="<%=request.getContextPath()%>/comm/fileMngr?cmd=delete" style="display: inline-block; visibility: hidden;">					
									<div class="addFile">
										<div class="filelist">
				                        	<ul id="uploadFileList_id">
				                        	</ul>
										</div>
									</div>
				                	<input type="hidden" name="semaphore" value="${semaphore}" />
					                <input type="hidden" name="vaccum" />
					                <input type="hidden" name="unDelList" />
					                <input type="hidden" name="delList" />						
								</form>
								<form name="setUpload_id" method="post" enctype="multipart/form-data" target="invisible" action="<%=request.getContextPath()%>/comm/fileMngr?cmd=upload" style="display: inline-block;">
						            <input type="hidden" name="viewsize" readonly value='총 파일 크기: 0KB' />
						            <input type="hidden" name="totalsize" value="0" />
						            <input type="hidden" name="mode" value="attach" />
						            <input type="hidden" name="idType" value="id" />
						            <input type="file" name="filename"  maxlength="" size="26" class="file_input" id="selectFileName_id" accept=".jpg,.jpeg,.png,.gif,.pdf" style="position: absolute; left: -500px;" onchange="ekrFile_id.uploadFile();" />
					                <span id="uploading" style="display: none;">
				                   		<img src="<%=request.getContextPath()%>/board/images/board/skin/lesNotice/imgLoading.gif" align="middle"/>
					                   	<span id="uploadStatus"></span>
					               	</span>
					               	<input type="hidden" name="iesucks" value="iesucks" />
					            </form>
	                        </div>
	                        <a href="#" class="btn_file" onclick="$('#selectFileName_id').click();"><span>등록</span></a> 
							<a href="javascript:deleteMypageDta('id');" class="btn_file"><span>삭제</span></a>
	                    </div>    
	                </td>
	           	</tr>
	            <tr>
	                <th class="C th_line ">특사경 서명 등록정보</th>
	                <td class="L td_line ">
	                    <div class="fileArea3">
	                    	<c:if test="${not empty user.userInfo03}">
	                    		<c:if test="${not fn:containsIgnoreCase(user.userInfo03, 'pdf')}"><img src="/upload${user.userInfo03}" id="img_sign" alt="서명" width="100%" height="100%" /></c:if>
	                    		<c:if test="${fn:containsIgnoreCase(user.userInfo03, 'pdf')}"><img src="/fss/images/pdf_img_1.gif" id="img_sign" alt="서명" width="100%" height="100%" /></c:if>
	                    	</c:if>
	                    	<c:if test="${empty user.userInfo03}">
	                    		<img src="${cPath}/fss/images/no_img_3.gif" id="img_sign" alt="서명" width="100%" height="100%" />
	                    	</c:if>
	                    </div>
	                    <p class="fax_title">
	                    	※서명을 등록하지 않으면, 시스템 기능 사용에 제약이 있을 수 있습니다.(수사관 서명이 사용되는 수사대장 등의 기능 사용 제한)<br />
	                    	※.jpg, .jpeg, .png, .gif 파일 등록 가능합니다.<br />
                           	<span id="signPdf"><c:if test="${not empty user.userInfo03}"><a href="${cPath}/sjpb/Z/AddOnDownload.face?isPid=Y&fileId=${user.userInfo06}" target="invisible"><img src="${cPath}/common/images/icon_file.png" alt="첨부파일" /><span>서명파일</span></a></c:if></span>
	                    </p>
	                    <div style="height: 30px;">
	                    	<form id="editForm_sign" name="editForm_sign" method="post" action="" style="display: inline-block; visibility: hidden;">
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
					      	</form>
	                    	<form name="setFileList_sign" method="post" target="invisible" action="<%=request.getContextPath()%>/comm/fileMngr?cmd=delete" style="display: inline-block; visibility: hidden;">					
								<div class="addFile">
									<div class="filelist">
			                        	<ul id="uploadFileList_sign">
			                        	</ul>
									</div>
								</div>
			                	<input type="hidden" name="semaphore" value="${semaphore}" />
				                <input type="hidden" name="vaccum" />
				                <input type="hidden" name="unDelList" />
				                <input type="hidden" name="delList" />						
							</form>
							<form name="setUpload_sign" method="post" enctype="multipart/form-data" target="invisible" action="<%=request.getContextPath()%>/comm/fileMngr?cmd=upload" style="display: inline-block;">
					            <input type="hidden" name="viewsize" readonly value='총 파일 크기: 0KB' />
					            <input type="hidden" name="totalsize" value="0" />
					            <input type="hidden" name="mode" value="attach" />
					            <input type="hidden" name="idType" value="sign" />
					            <input type="file" name="filename"  maxlength="" size="26" class="file_input" id="selectFileName_sign" accept=".jpg,.jpeg,.png,.gif" style="position: absolute; left: -500px;" onchange="ekrFile_sign.uploadFile();" />
				                <span id="uploading" style="display: none;">
			                   		<img src="<%=request.getContextPath()%>/board/images/board/skin/lesNotice/imgLoading.gif" align="middle"/>
				                   	<span id="uploadStatus"></span>
				               	</span>
				               	<input type="hidden" name="iesucks" value="iesucks" />
				            </form>
	                    </div>
	                    <a href="#" class="btn_file" onclick="$('#selectFileName_sign').click();"><span>등록</span></a> 
						<a href="javascript:deleteMypageDta('sign');" class="btn_file"><span>삭제</span></a>
                	</td>
	           	</tr>
	        </tbody>
	    </table>
	</div>
<iframe name='invisible' frameborder="0" width="0" height="0"></iframe>
</body>
</html>
