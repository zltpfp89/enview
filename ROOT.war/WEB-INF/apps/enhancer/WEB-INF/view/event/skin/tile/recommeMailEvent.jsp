<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<%@ page import="java.util.*" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.saltware.enview.multiresource.MultiResourceBundle"%>
<%@ page import="com.saltware.enview.multiresource.EnviewMultiResourceManager"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %> 
<%
 Map userInfoMap = null;
userInfoMap = EnviewSSOManager.getUserInfoMap(request);
 String langKnd = (String)userInfoMap.get("lang_knd");
 MultiResourceBundle msgs = null;
 msgs = EnviewMultiResourceManager.getInstance().getBundle(langKnd);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
<title><%=msgs.getString("ev.hnevent.label.emailRcmd")%></title>
<link href="<%=request.getContextPath()%>/hancer/css/event/core_popup.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	var rootPath = '<c:out value="${pageContext.request.contextPath}"/>';
	var resPath  = '<c:out value="${pageContext.request.contextPath}"/>'+"/hancer";
	var actPath  = '<c:out value="${pageContext.request.contextPath}"/>'+"/event";
	var eventSeq = '<c:out value="${paramMap.EVENT_SEQ}"/>';

	//이메일이 올바른지 체크
	function emailCheck (emailStr) { 
		// Email check 함수 
		var emailPat=/^(.+)@(.+)$/ 
		var specialChars="\\(\\)<>@,;:\\\\\\\"\\.\\[\\]" 
		var validChars="\[^\\s" + specialChars + "\]" 
		var firstChars=validChars 
		var quotedUser="(\"[^\"]*\")" 
		var ipDomainPat=/^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/ 
		var atom="(" + firstChars + validChars + "*" + ")" 
		var word="(" + atom + "|" + quotedUser + ")" 
		var userPat=new RegExp("^" + word + "(\\." + word + ")*$") 
		var domainPat=new RegExp("^" + atom + "(\\." + atom +")*$") 


		var matchArray=emailStr.match(emailPat) 
		if (matchArray==null) { 
			//alert("e-mail 주소가 정확하지 않습니다.\n @ 와 . 을 확인하십시오") 
			return false 
		} 
		var user=matchArray[1] 
		var domain=matchArray[2] 

		if (user.match(userPat)==null) { 
			//alert("메일 아이디가 정확한 것 같지 않습니다.") 
			return false 
		} 

		var IPArray=domain.match(ipDomainPat) 
		if (IPArray!=null) { 
			for (var i=1;i<=4;i++) { 
			if (IPArray[i]>255) { 
			//alert("IP가 정확하지 않습니다.") 
			return false 
		} 
		} 
		return true 
		} 

		var domainArray=domain.match(domainPat) 

		if (domainArray==null) { 
			//alert("도메인 이름이 정확한 것 같지 않습니다.") 
			return false 
		} 
		var atomPat=new RegExp(atom,"g") 
		var domArr=domain.match(atomPat) 
		var len=domArr.length 

		if (domArr[domArr.length-1].length<2 || 
			domArr[domArr.length-1].length>3) { 
			//alert("도메인명의 국가코드는 2자보다 크고 3자보다 작아야 합니다.") 
			return false 
		} 

		if (domArr[domArr.length-1].length==2 && len<3) { 
			var errStr="This address ends in two characters, which is a country" 
			errStr+=" code. Country codes must be preceded by " 
			errStr+="a hostname and category (like com, co, pub, pu, etc.)" 
			//alert(errStr) 
			return false 
		} 

		if (domArr[domArr.length-1].length==3 && len<2) { 
			//var errStr="이 주소는 호스트명이 일치하지 않습니다." 
			//alert(errStr) 
			return false 
		} 
		return true; 
	}

	//이메일로 추천하기
	function rcmdEmail(){
		var name = document.getElementById("receiverName");
		var addr = document.getElementById("receiverAddr");
		if(name.value == ""){
			alert('<%=msgs.getString("ev.hnevent.msg.event.enterRecipient")%>');
			name.focus();
			return;
		}
		if(addr.value == ""){
			alert('<%=msgs.getString("ev.hnevent.msg.evnet.enterRecAddr")%>');
			addr.focus();
			return;
		}
		if(addr.value != ""){
			if(!emailCheck(addr.value)){
				alert('<%=msgs.getString("ev.hnevent.msg.event.emailCheck")%>');
				addr.focus();
				return;
			}
		}
		//이메일로 추천하기
		$.ajax({ 
		   type: "POST", 
		   url: actPath+"/recommeMailSend.hanc", 
		   data: "EVENT_SEQ="+eventSeq+"&receiverNm="+name.value+"&receiverAddr="+addr.value,
		   dataType:"text",
		   success: function(data){ 
				alert(data);
				self.close();
		   }, 
		   error: function(request, status, error) {
				alert('<%=msgs.getString("ev.hnevent.msg.event.networkError")%>');
		   }
		}); 
	}
</script>
</head>
<body>
	<div class="popup_wrap">
		<div class="header">
			<h1><%=msgs.getString("ev.hnevent.label.emailRcmd")%></h1>
		</div>
		<div class="content">
			<fieldset>
				<legend>
				</legend>
				<form id="googleSchedule" name="googleSchedule" action="" method="post">	
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabletype1" summary="Email-Infomation">
					<caption>Email-Infomation</caption>
					<colgroup>
						<col width="40%" />
						<col width="*" />
					</colgroup>
					<tr>
						<th scope="row"><label for="receiverName"><%=msgs.getString("ev.hnevent.label.recepient")%></label></th>
						<td><input type="text" name="receiverName" id="receiverName" /></td>
					</tr>
					<tr>
						<th scope="row"><label for="receiverAddr"><%=msgs.getString("ev.hnevent.label.emailAddr")%></label></th>
						<td><input type="text" name="receiverAddr" id="receiverAddr" /></td>
					</tr>
				</table>
				</form>
				<div class="btn_s_0 btn_C">
					<span class="btn_s"><img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/btn_s_a_icon.gif" alt="arrow" class="icon"><a href="#link" onclick="rcmdEmail()"><%=msgs.getString("ev.hnevent.label.confirm")%></a></span>
				</div>
			</fieldset>
		</div>
	</div>
</body>
</html>


