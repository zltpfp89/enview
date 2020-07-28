<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%@ page import="java.util.List,java.util.Map"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@ page import="com.saltware.enview.security.UserInfo"%>

<%
    UserInfo userInfo = EnviewSSOManager.getUserInfo(request);
    Map userInfoMap = userInfo.getUserInfoMap();
    String userId = (String)userInfoMap.get("userId");
    request.setAttribute("userId", userId);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Enview Appliance 비밀번호수정</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/statics/password/css/password.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
<script type="text/javascript">


$(document).ready(function(){
	var errorMessage = "<c:out value="${errorMessage}"/>";
    if( errorMessage != "null" && errorMessage.length > 0 ) {
      alert( errorMessage );
    }
})
    

function goLogout(){
    parent.location.href="<%=request.getContextPath()%>/user/logout.face";
}

function goAfterChange(){
    parent.location.href="<%=request.getContextPath()%>/portal";
}


function editPwSave(){
    var form = document.getElementById("editPwForm");
    
    //  비밀번호에 공백 체크
    if(form["passwordNew"].value.indexOf(" ") > -1){
        alert("비밀번호에는 공백이 들어갈수없습니다.");
        return;
    }
    
    //  새 비밀번호 확인
    if(form["passwordNew"].value != form["passwordConfirm"].value){
        alert("비밀번호 재입력이 일치하지 않습니다.");
        return;
    }
    
    //  비밀번호 자릿수 체크
    if(form["passwordNew"].value.length < 9 || form["passwordNew"].value.length > 12 ){
        alert("비밀번호는 9~12자리까지 변경하실수 있습니다.");
        return;
    }
    
    //  아이디와 비밀번호가 일치하는지 체크
    if('${userId}' == form["passwordNew"].value){
        alert("아이디와 비밀번호가 같게 입력할 수 없습니다");
        return;
    }
    
    //  영문, 숫자, 특문 조합 비밀번호 체크
    if(!form["passwordNew"].value.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/)){
        alert("비밀번호는 영문자 및 숫자와 특수문자의 조합만 사용가능합니다.");
        return;
    }
    
    form.action="<%=request.getContextPath()%>/user/changePasswordProcess.face";
    form.target="_parent";
    form.submit();
}
</script>

</head>
<body>
    <!-- contents -->
    <div id="contents" class="con_br">
        <!-- sub contents-->
        <div class="sub_contents">
            <!-- member info -->
            <form id="editPwForm" name="editPwForm" method="post">
            <input type="hidden" id="pwdChgReq" name="pwdChgReq" value="true"/>
            <table class="board03">
             <caption>비밀번호수정 표 : 현재 비밀번호, 새로운 비밀번호, 비밀번호 재입력 목록</caption> 
             <colgroup> 
                <col style="width12%;" />
                <col style="width:88%;" />
             </colgroup> 
             <tbody>
             <tr>
                <th scope="row"><label for="pw">현재 비밀번호</label></th>
                <td><input type="password" id="password" name="password" class="w30p" /></td>
              </tr>
               <tr>
                <th scope="row"><label for="newpw">새로운 비밀번호</label></th>
                <td><input type="password" id="passwordNew" name="passwordNew" class="w30p" /></td>
              </tr>
               <tr>
                <th scope="row"><label for="newpwre">비밀번호 재입력</label></th>
                <td><input type="password" id="passwordConfirm" name="passwordConfirm" class="w30p" /></td>
              </tr>
              </tbody>
            </table>
            </form>
            <!-- //member info -->
            <div class="noti_bg">
                <h4 class="noti_tit fl">주의사항</h4>
                <ul class="noti_list fl ml15">
                    <li>1.비밀번호는 숫자, 문자만으로 구성할 수 없으며, 영문자 및 숫자와 특수문자(!@#$)의 조합만 사용 가능합니다.</li>
                    <li>2.비밀번호는 9~12자리까지 변경하실수 있습니다.</li>
                    <li>3.비밀번호에 공백을 입력할 수 없습니다.</li>
                    <li>4.비밀번호에 주민등록번호를 넣으시면 안됩니다.</li>
                    <li>5.아이디와 비밀번호를 같게 입력하시면 안됩니다.</li>
                </ul>
            </div>
            <!-- btn -->
            <p class="mt20 tc cb">
                <span class="btn_gray"><a href="#none;" onclick="goLogout()">취소</a></span>
                <span class="btn_gray"><a href="#none;" onclick="goAfterChange()">다음에변경하기</a></span>
                <span class="btn_gray"><a href="#none;" onclick="editPwSave()">저장</a></span>
            </p>
            <!-- //btn -->
        </div>
        <!-- //sub contents-->
    </div>
    <!-- //contents -->

</body>
</html>