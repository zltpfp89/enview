<%@page import="com.saltware.enface.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="manu" uri="/WEB-INF/tld/manu.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>:: 솔트웨어 ::</title>
	
	<%-- 공통 스크립트 --%>
	<%@ include file="/common/common/commonScriptInclude.jsp"  %>
	<%-- 공통 스크립트 --%>
	
	<script type="text/javascript">
		$(document).ready(function () {
			//2016.05.20 김승식 : DOM Ready 시, 스크롤 top 
			try
			{
				parent.document.documentElement.scrollTop = 0;
			}
			catch(e)
			{}
			
			//2016.05.20 김승식 : DOM ready 시 iframe resize
			try
			{
				var doc = parseInt($("#sub_container").height()) + 50;
				parent.document.getElementById(window.name).style.height = parseInt(doc)+"px";	
			}
			catch(e)
			{}
		});
		
		function fn_list() {
			location.href='./selectMdList.face';
		}
		
		function fn_save() {
			// vaildation
			if ($("#mdDetail_mdId").val() == "") {
				alert("모듈아이디를 입력하십시오.");
				$("#edit.jsp").focus();
				return;
			}
			
			if ($("#mdDetail_mdNm").val() == "") {
				alert("모듈명을 입력하십시오.");
				$("#mdDetail_mdNm").focus();
				return;
			}
			
			var url = "${cPath}/manu/admin/saveMdForAjax.face";
			
			fn_ajax({
				url : url,
				param : $("#editForm").serialize(),
				callback : {
					success : function (data) {
						if (data.status == "SUCCESS") {
								alert("성공적으로 저장하였습니다.");
						} else {
							alert("처리중 오류가 발생하였습니다.");
						}
						
						fn_list();
					},
					error : function (data) {
						alert("처리중 오류가 발생하였습니다.");
						//fn_list();
					}
				}
			});
			
			
		}

	</script>
</head>

<body>
	<div class="sub_container" id="sub_container">
		<!-- content start -->
		<div id="content">
			<h4>모듈관리 <c:out value="${empty param.mdId ? '등록' : '수정' }"/></h4>
			<div class="board_top ">
				<div class="board_btn_R">
					<!-- <a href="javascript:fn_tempSave();" target="_self" class="btn_white">임시서장</a> -->
					<a href="javascript:fn_save();" target="_self" class="btn_black">저장</a>
					<a href="javascript:fn_list();" target="_self" class="btn_white">목록</a>
				</div>
			</div>
			
			<table class="basic_table_write " summary="모듈관리 제목,">
				<caption>모듈관리 글작성</caption>
				<colgroup>
					<col style="width:120px" />
					<col style="width:auto" />
				</colgroup>
				
				<tbody>
					<form id="editForm" name="editForm" method="post" action="" >
					<tr>
						<th class="">
							<label for="mdDetail_mdId"><span class="essentia">*</span> 모듈ID</label>
						</th>
						<td>
							<input type="text" id="mdDetail_mdId" name="mdId" style="ime-mode:inactive;" maxlength="10" size="10" value="${md.mdId}" />
						</td>
					</tr>
					<tr>
						<th class="">
							<label for="mdDetail_mdId"><span class="essentia">*</span> 모듈명칭</label>
						</th>
						<td>
							<input type="text" id="mdDetail_mdNm" name="mdNm" maxlength="33" class="w_p100" value="${md.mdNm}" />
						</td>
					</tr>
				</tbody>
			</table>
		
			<!-- 하단버튼영역 start -->
			<div class="board_bottom">
				<div class="board_btn_R">
					<!-- <a href="javascript:fn_tempSave();" target="_self" class="btn_white">임시서장</a> -->
					<a href="javascript:void(0);" onclick="fn_save();" target="_self" class="btn_black">저장</a>
					<a href="javascript:fn_list();" target="_self" class="btn_white">목록</a>
				</div>
			</div>
			<!-- //하단버튼영역 end -->
		</div>
		<!-- //content end -->
	</div>
	
	<div id="uploading" class="loading" style="display: none;" >로딩중</div>
</body>
</html>
