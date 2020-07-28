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
    
    <link rel="stylesheet" href="${cPath }/javascript/jstree/themes/default/style.min.css" />
    
    <script type="text/javascript" src="${cPath }/sjpb/reference/js/ekr_dept.js" ></script>
    <script type="text/javascript" src="${cPath }/javascript/jstree/jstree.min.js" ></script>
    
    <script type="text/javascript">
        $(document).ready(function(){
        	fn_selectRsrcDeptTree();
        });
        
		function fn_selectDept(){
			ekrDeptPopup.showLayerPopup( function( data) {
				if( data != null) {
					$.each(data, function() {
						$("#dept_cd").val(this.id);
						$("#newDept_cd").val(this.id);
						$("#dept_nm").val(this.text);
					});					
				}
			});
		}
		
		//부서목록
		function fn_selectRsrcDeptTree(){
			$("#jstree").jstree('destroy');
			
			fn_ajax({
				url : "${cPath}/rsrc/resourceAdminDeptTree.face",
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
								$("#dept_odr").val("");
								
								for(var i = 0; i < cnt; i++) {
									tmp += e.target.firstChild.childNodes[i].id;
									if(i != cnt - 1) tmp += ",";
								}
								
								$("#dept_odr").val(tmp);
								fn_saveRsrcOrder();
							});
							
							$('#jstree').on("select_node.jstree", function (e, data) {
								$("#dept_cd").val(data.node.id);
								$("#selected_nm").val(data.node.text);
								fn_selectRsrcDeptInfo();
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
		
		//부서 정보 및 담당자
		function fn_selectRsrcDeptInfo(){
			$(".rsrcAdminContents").empty();
			
			fn_ajax({
				url : "${cPath}/rsrc/resourceAdminUserList.face",
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
		
		//부서 등록화면
		function fn_viewRsrcDept(){
			$(".rsrcAdminContents").empty();
			
			fn_ajax({
				url : "${cPath}/rsrc/resourceAdminAdd.face",
				dataType : "html",
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
		
		//담당자 등록화면
		function fn_viewRsrcDeptUser(){
			$(".rsrcAdminContents").empty();
			
			fn_ajax({
				url : "${cPath}/rsrc/resourceAdminUserAdd.face",
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
		
		//사용자 선택 후 콜백함수
		function fn_getChkUserInfo() {
            var tmp = 0;
            $("input[name='chkValue']").each(function () {
                if ($(this).prop("checked")) {
                	tmp ++;
                	if(tmp == 1) {
                		var arr = $(this).val().split("|");
                       	if(arr[0] == '${userInfo.userId }') {
                            alert("본인 외 담당자를 지정해주십시오.");
                            return;
                        }
                        $('#setForm input[name="usr_id"]').val(arr[0]);
                        $('#setForm input[name="usr_nm"]').val(arr[1]);
                        $("#userSearch").hide();
                	}
                }
            });
        }
		
		//부서 등록
		function fn_addRsrcDept(){
			if(!isDefined($("#dept_cd").val()) || !isDefined($("#newDept_cd").val())){
				alert("부서코드가 비어있습니다. 부서를 선택하십시오.");
				return;
			}
			if(!isDefined($("#dept_nm").val())){
				alert("부서명이 비어있습니다. 부서를 선택하십시오.");
				return;
			}
			
			fn_ajax({
				url : "${cPath}/rsrc/resourceAdminAddDept.face",
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
		
		//담당자 등록
		function fn_addRsrcDeptUser(){
			if(!isDefined($("#dept_cd").val())){
				alert("부서코드가 비어있습니다. 부서를 선택하십시오.");
				return;
			}
			if(!isDefined($("#usr_id").val())){
				alert("사용자 ID가 비어있습니다. 사용자를 선택하십시오.");
				return;
			}
			if(!isDefined($("#usr_nm").val())){
				alert("사용자서명이 비어있습니다. 사용자를 선택하십시오.");
				return;
			}
			
			fn_ajax({
				url : "${cPath}/rsrc/resourceAdminAddUser.face",
				param : $("#setForm").serialize(),
				callback : {
					success : function (data) {
						if(data.status == "success"){
							alert("처리가 완료되었습니다.");
							fn_selectRsrcDeptInfo();
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
		
		//부서 사용여부
		function fn_useChangeRsrc(type){
			if(!isDefined($("#dept_cd").val())){
				alert("부서코드가 비어있습니다. 부서를 선택하십시오.");
				return;
			}
			if(!isDefined(type)){
				alert("사용여부값이 비어있습니다. 관리자에게 문의하십시오.");
				return;
			}
			
			var proc = "사용안함";
			if(type == "N") proc = "사용";
			if(type == "D") proc = "삭제";
			
			$("#dept_del").val(type);
			
			if(confirm("자원부서 '" + $("#selected_nm").val() + "'을(를) '" + proc + "' 하겠습니까?")){
				fn_ajax({
					url : "${cPath}/rsrc/resourceAdminDeleteDept.face",
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
		}
		
		//담당자 삭제
		function fn_deleteRsrcUser(obj){
			if(!isDefined($("#dept_cd").val())){
				alert("부서코드가 비어있습니다. 부서를 선택하십시오.");
				return;
			}
			
			var id = $(obj).attr("usrid");
			var nm = $(obj).attr("usrnm");
			
			
			if(!isDefined(id)){
				alert("삭제할 사용자 ID값이 비었습니다. 관리자에게 문의하십시오.");
				return;
			}
			
			$("#usr_id").val(id);
			
			if(confirm("자원부서 '" + $("#selected_nm").val() + "'의 담당자 '" + nm + "'을(를) 삭제하시겠습니까?")){
				fn_ajax({
					url : "${cPath}/rsrc/resourceAdminDeleteUser.face",
					param : $("#setForm").serialize(),
					callback : {
						success : function (data) {
							if(data.status == "success"){
								alert("처리가 완료되었습니다.");
								fn_selectRsrcDeptInfo();
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
		}
		
		//자원부서 순서 저장
		function fn_saveRsrcOrder(){
			if(!isDefined($("#dept_odr").val())){
				alert("자원부서코드목록이 비어있습니다. 관리자에게 문의하십시오.");
				return;
			}
			
			fn_ajax({
				url : "${cPath}/rsrc/resourceAdminSaveDeptOrder.face",
				param : $("#setForm").serialize(),
				callback : {
					success : function (data) {
						if(data.status == "success"){
							alert("처리가 완료되었습니다.");
						} else {
							alert(data.msg);
						}
						
						fn_selectRsrcDeptTree();
					},
					error : function (data) {
						alert("오류가 발생하였습니다.");
					}
				}
			});
		}
		
		//취소
		function fn_cancelRsrc(){
			fn_selectRsrcDeptInfo();
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
					<h5>자원관리 부서</h5>
					<a class="btn_black cursor" onclick="javascript: fn_viewRsrcDept();">신규등록</a>
				</div>
				<div class="helper_search_wrap h450" style="min-height: 580px;">
					<div id="jstree">
					</div>
				</div>
			</div>
			<form id="setForm" name="setForm">
				<input type="hidden" id="dept_cd" name="dept_cd" />
				<input type="hidden" id="selected_nm" name="selected_nm" />
				<input type="hidden" id="dept_odr" name="dept_odr" />
				<div class="rsrcAdminContents">
					<div class="w_p73 fr">
						<div class="sub_title">
							<h5>자원관리 부서정보</h5>
						</div>
	
						<table class="basic_table" summary="메뉴얼 목차">
							<caption>메뉴얼 목차</caption>
							<tr>
								<td class="left">
									<strong>신규등록</strong> : 좌측 상단의 '신규등록' 버튼을 클릭하여 자원관리 부서를 등록<br />
									<strong>정보조회</strong> : 좌측 자원관리 부서 목록에서 변경을 원하는 자원관리 부서를 클릭 
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

        