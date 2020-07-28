<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="rfrc" uri="/WEB-INF/tld/reference.tld" %>
<%
    request.setAttribute("cPath", request.getContextPath());
	request.setAttribute("userInfo",  EnviewSSOManager.getUserInfo(request)); // 로그인사용자정보
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
    
    <script type="text/javascript" src="${cPath }/sjpb/reference/js/ekr_dept.js" ></script>
	<script type="text/javascript" src="${cPath}/javascript/jstree/jstree.js"></script>
	<link rel="stylesheet" href="${cPath }/javascript/jstree/themes/default/style.min.css" />
    
    <script type="text/javascript">
        $(document).ready(function(){
        	fn_selectRsrcTypeTree();
        });
		
		//자원구분 목록
		function fn_selectRsrcTypeTree(){
			$("#jstree").jstree('destroy');
			
			fn_ajax({
				url : "${cPath}/rsrc/resourceAdminTypeTree.face",
				callback : {
					success : function (data) {
						if(data.status == "success"){
							$("#jstree").jstree({ 
								core : {
							    	'data' : data.list,
							    	'check_callback' : function(operation, node, node_parent, node_position, more) {
							    		//필요시 함수 추가
										return true;
							    	}
								},
								types : {
									"#" : {
										"valid_children" : ["folder"]
									},
									"folder" : {
										"max_children" : 0
									}
								},
				                plugins : [ "dnd", "types" ]
							}).bind("move_node.jstree", function(e, data) {
								//변경시 서버에 저장
								var tmp = "";
								var cnt = e.target.firstChild.childNodes.length;
								$("#ordr").val("");
								
								for(var i = 0; i < cnt; i++) {
									tmp += e.target.firstChild.childNodes[i].id;
									if(i != cnt - 1) tmp += ",";
								}
								
								$("#ordr").val(tmp);
								fn_saveRsrcTypeOrder();
							});
							
							$('#jstree').on("select_node.jstree", function (e, data) {
								$("#code").val(data.node.id);
								$("#selected_nm").val(data.node.text);
								fn_selectRsrcTypeInfo();
							});
						} else {
							alert(data.msg);
						}
					},
					error : function (data) {
						alert("오류가 발생하였습니다.");
					}
				}
			});
		}
		
		//자원구분 정보
		function fn_selectRsrcTypeInfo(){
			$(".rsrcAdminContents").empty();
			
			fn_ajax({
				url : "${cPath}/rsrc/resourceAdminTypeInfo.face",
				dataType : "html",
				param : $("#setForm").serialize(),
				callback : {
					success : function (data) {
						$(".rsrcAdminContents").html(data);
					},
					error : function (data) {
						alert("오류가 발생하였습니다.");
					}
				}
			});
		}
		
		//자원구분 등록화면
		function fn_viewRsrcType(){
			$(".rsrcAdminContents").empty();
			
			fn_ajax({
				url : "${cPath}/rsrc/resourceAdminTypeAdd.face",
				dataType : "html",
				callback : {
					success : function (data) {
						$(".rsrcAdminContents").html(data);
						$("#code").val("");
					},
					error : function (data) {
						alert("오류가 발생하였습니다.");
					}
				}
			});
		}
		
		//자원구분 등록 및 수정
		function fn_addRsrcType(){
			if(!isDefined($("#name").val())){
				alert("자원구분명이 비어있습니다. 자원구분명을 입력하십시오.");
				return;
			}
			
			fn_ajax({
				url : "${cPath}/rsrc/resourceAdminAddType.face",
				param : $("#setForm").serialize(),
				callback : {
					success : function (data) {
						if(data.status == "success"){
							alert("처리가 완료되었습니다.");
							location.reload(true);
						} else {
							alert(data.msg);
						}
					},
					error : function (data) {
						alert("오류가 발생하였습니다.");
					}
				}
			});
		}
		
		//자원구분 삭제
		function fn_deleteRsrcType(){
			if(!isDefined($("#code").val())){
				alert("자원구분 코드가 비어있습니다. 관리자에게 문의하십시오.");
				return;
			}
			
			fn_ajax({
				url : "${cPath}/rsrc/resourceAdminDeleteType.face",
				param : $("#setForm").serialize(),
				callback : {
					success : function (data) {
						if(data.status == "success"){
							alert("처리가 완료되었습니다.");
							location.reload(true);
						} else {
							alert(data.msg);
						}
					},
					error : function (data) {
						alert("오류가 발생하였습니다.");
					}
				}
			});
		}
		
		//자원구분 순서 저장
		function fn_saveRsrcTypeOrder(){
			if(!isDefined($("#ordr").val())){
				alert("자원구분 목록이 비어있습니다. 관리자에게 문의하십시오.");
				return;
			}
			
			fn_ajax({
				url : "${cPath}/rsrc/resourceAdminSaveTypeOrder.face",
				param : $("#setForm").serialize(),
				callback : {
					success : function (data) {
						if(data.status == "success"){
							alert("처리가 완료되었습니다.");
						} else {
							alert(data.msg);
						}
						
						fn_selectRsrcTypeTree();
					},
					error : function (data) {
						alert("오류가 발생하였습니다.");
					}
				}
			});
		}
		
		//취소
		function fn_cancelRsrc(){
			fn_selectRsrcTypeInfo();
		}
    </script>
</head>
<body>
    <div class="sub_container">
        <!-- content start -->
   		<div id="content">
			<h4>도움말 모듈관리</h4>


			<div class="w_p25 fl">
				<div class="sub_title">
					<h5>자원 구분목록</h5>
					<a class="btn_black cursor" onclick="javascript: fn_viewRsrcType();">신규등록</a>
				</div>
				<div class="helper_search_wrap h450" style="min-height: 580px;">
					<div id="jstree">
					</div>
				</div>
			</div>
			<form id="setForm" name="setForm">
				<input type="hidden" id="code" name="code" />
				<input type="hidden" id="selected_nm" name="selected_nm" />
				<input type="hidden" id="ordr" name="ordr" />
				<div class="rsrcAdminContents">
					<div class="w_p73 fr">
						<div class="sub_title">
							<h5>자원구분 정보</h5>
						</div>
	
						<table class="basic_table" summary="메뉴얼 목차">
							<caption>메뉴얼 목차</caption>
							<tr>
								<td class="left">
									<strong>신규등록</strong> : 좌측 상단의 '신규등록' 버튼을 클릭하여 자원구분을 등록<br />
									<strong>정보조회</strong> : 좌측 자원구분 목록에서 변경을 원하는 자원구분을 클릭 
								</td>
							</tr>
						</table>
					</div>
				</div>
			</form>
		</div>
        <!-- //content end -->
    </div>
</body>
</html>

        