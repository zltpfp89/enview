<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>비밀번호수정</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sjpb/css/board.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/sjpb/js/Z/jquery.js"></script>
<script type="text/javascript" src="/sjpb/js/rulemng.js"></script>

		<script>
			$(document).ready(function() {
				
				if(pRule != null) {
					pRule.init("pwChangeForm", document.pwChangeForm);
					$("#ruleComment").append(pRule.writeRuleComment());
				}
				
				$("#btnChangePwd").click(function() {
					var form = $("#pwChangeForm");
					var nowpwd = form.find("#nowpwd");
					var pwd = form.find("#pwd");
					var repwd = form.find("#repwd");
					
					if(nowpwd.val() == "") {
						alert("현재 비밀번호를 입력해주세요.");
						nowpwd.focus();
						return;
					}
					
					if(pwd.val() == "") {
						alert("새 비밀번호를 입력해주세요.");
						pwd.focus();
						return;
					}
					
					if(repwd.val() == "") {
						alert("새 비밀번호 확인을 입력해주세요.");
						repwd.focus();
						return;
					}
					
					if(pwd.val() != repwd.val()) {
						alert("새 비밀번호가 다릅니다. \n다시 입력해주시길 바랍니다.");
						return;
					}
					
					if(passVali(pwd.val()) == false) {
						return;
					}
					
					if(pRule.checkUsePrePwd(nowpwd.val())) {
						alert("현재 비밀번호를 잘못 입력하셨습니다.");
						nowpwd.focus();
						return;
					}
					
					if(!pRule.checkUsePrePwd(pwd.val())) {
						alert("이전 비밀번호는 사용하실 수 없습니다.");
						pwd.focus();
						return;
					}
					
					$.ajax({
						type : 'POST',
						url : '/common/changePassword.face',
						data : {
							nowpwd : nowpwd.val(),
							pwd : pwd.val()
						},
						async : false,
						dataType : 'json',
						success : function(data, textStatus){
							if(data.result == "success") {
								alert("비밀번호가 성공적으로 변경되었습니다.");
								location.href ="/portal"
							} else {
								alert(data.msg);
							}
						},
						error : function(x, e, textStatus, errorThrown, XMLHttpRequest){
							alert("통신 장애가 발생했습니다.");
						}
					});
				});
				
				$("#btnClose").click(function() {
					parent.blockClose();
				});
				
			});
			
		
			
			function passVali(pass) {
				// 밸리테이션 체크 실행
				// 위반되는 정책이 있을 경우 메시지를 return
				// 위반되는 정책이 없을 경우 공백 메시지가 return
				var rst = pRule.checkPwd(pass);
				
				if(rst != null && rst != "") {
					alert(rst);
					return false;
				} else {
					return true;
				}
			}
		</script>


</head>
<body style="min-width:0;">
<div class="sub_layout">
<h1><a href="#">민생사법경찰단 수사정보 포털시스템</a></h1>
<!-- body -->
<div id="body">
	<!-- body_wrap -->
	<div id="body_wrap">
    	<!-- sub -->
        <div id="sub">
            <h3>비밀번호를 변경해주세요.</h3>
            	<p>오랫동안 비밀번호를 변경하지 않고 같은 비밀번호를 사용하고 계시거나  <br />소중한 개인정보를 안전하기 지키기 위하여 비밀번호를 변경해주시길 바랍니다.</p>
            <div class="board">
				<div class="info">
					<h4>안내사항</h4>
					<p id="ruleComment" ></p>
				</div>
				<form name="pwChangeForm" id="pwChangeForm">
				<table cellpadding="0" cellspacing="0" summary="게시판리스트" class="list left_title" >  
					<colgroup>
						<col width="20%" />
						<col width="*%" />
					</colgroup>
					<tbody>
						<tr>
							<th class="C first th_line" scope="col" ><span class="table_title">현재 비밀번호</span></th>
							<td class="L td_line" ><input type="password" autocomplete="off" class="w100per" id="nowpwd" name="nowpwd"  /><label for="nowpwd"></label></td>
						</tr>
						<tr>
							<th class="C first th_line" scope="col" ><span class="table_title">새 비밀번호</span></th>
							<td class="L td_line" ><input type="password" autocomplete="off" class="w100per" id="pwd" name="pwd"/><label for="pwd"></label></td>
						</tr>
						<tr>
							<th class="C first th_line" scope="col" ><span class="table_title">새 비밀번호</span></th>
							<td class="L td_line" ><input type="password" autocomplete="off" class="w100per" id="repwd" name="repwd" /><label for="repwd"></label></td>
						</tr>
					</tbody>
				</table>
				</form>
				<div class="btnArea">
					<div class="C"><a href="#" id="btnChangePwd" class="btn_blue"><span>확인</span></a></div>
				</div>
			</div>
        </div>
        <!-- sub //-->
	</div>
	<!-- body_wrap //-->
</div>
<!-- body //-->
</div>
</body>
</html>