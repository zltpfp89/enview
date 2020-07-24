<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="java.util.List" %>

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
<title><%=msgs.getString("ev.hnevent.label.selectTarget")%></title>
<link href="<%=request.getContextPath()%>/hancer/css/event/cssbasic.css" rel="stylesheet" type="text/css" />
<%
	List targetGroupList = (List)request.getAttribute("targetGroupList");
	int len = targetGroupList.size();
	request.setAttribute("targetGroupLen",len);
	request.setAttribute("guestGroupNo",len+1);
%>
<script type="text/javascript">
	var rootPath = '<c:out value="${pageContext.request.contextPath}"/>';
	var resPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/hancer";
	var actPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/event";
	var rtnValue = "";
	var targetGroupLen = '<c:out value="${targetGroupLen}"/>';
	
	window.onload=function(){
		var arg = '<c:out value="${paramMap.target_cd}"/>';
		var pArgCd = arg.split(',');
		
		//수정일경우 이전에 선택했던 대상그룹은 checked
		for(var i=1;i<eval(targetGroupLen)+2;i++){
			for(var j=0;j<pArgCd.length;j++){
				if(document.getElementById("chkNo"+i).name == pArgCd[j]){
					document.getElementById("chkNo"+i).checked = true;
				}
			}
		}
	}
	
	window.onunload = function(){			
		opener.document.getElementById("eventFeeKor").focus();
		opener.setEvTarget(rtnValue);
	}
	
	function forwardTargetGp(){
		var gpCode = "";
		var gpName = "";		
		for(var i=1;i<eval(targetGroupLen)+2;i++){

			if(document.getElementById("chkNo"+i).checked){
				//선택한 대상그룹코드
				gpCode+= document.getElementById("chkNo"+i).name + ",";

				//선택한 대상그룹명
				gpName+= document.getElementById("chkNo"+i).value + ",";
			}
		}

		//마지막일경우 ','를 붙이지 않음
		if(gpCode.substr(gpCode.lastIndexOf(','),1) == ','){
			gpCode = gpCode.substr(0,gpCode.length-1)
			gpName = gpName.substr(0,gpName.length-1)
		}
		rtnValue = gpCode +"/"+gpName;
		self.close();
	}
	
	//체크박스전체 선택or해제
	function controlMcheck(){
		var chkFalg = document.getElementById("chkAll").checked;
		if(chkFalg){//checked
			for(var i=1;i<eval(targetGroupLen)+2;i++){
				document.getElementById("chkNo"+i).checked =  true;
			}
		}else{//unchecked
			for(var i=1;i<eval(targetGroupLen)+2;i++){
				document.getElementById("chkNo"+i).checked =  false;
			}
		}
	}

	//닫기버튼으로 팝업닫기
	function closePop(){
		self.close();
	}
</script>
</head>
<body>
	<form name="targetGpForm" id="targetGpForm" action="" method="post">
		<div class="popup_wrap">
			<div class="header">
				<h1><%=msgs.getString("ev.hnevent.label.selectTarget")%></h1>
			</div>
			<div class="content">
				<fieldset>
				<legend></legend>
				 <div class="table_list">
						<div class="list">
							<table class="tabletype3" id="" border="0" cellspacing="0" summary="대상그룹 찾기 입니다.">
								<caption>대상그룹선택</caption>
								<colgroup>
									<col width="4px" />
									<col width="*" />
								</colgroup>
									<tr>
										<th scope="row"><input type="checkbox" title="check all" id="chkAll" name="chkAll" value="" onclick="controlMcheck();" /></th>
										<td><%=msgs.getString("ev.hnevent.label.selectAll")%></td>
									</tr>
									<c:forEach  items="${targetGroupList}" var="data" varStatus="status">
									<tr>
										<th scope="row"><input title="<c:out value="${data.PRINCIPAL_NAME}"/>" type="checkbox" id="chkNo<c:out value="${status.count}"/>" name="<c:out value="${data.PRINCIPAL_ID}"/>" value="<c:out value="${data.PRINCIPAL_NAME}"/>" /></th>
										<td ><c:out value="${data.PRINCIPAL_NAME}"/></td>
									</tr>
									</c:forEach>
									<tr>
										<th scope="row"><input title="비회원(guest)" type="checkbox" id="chkNo<c:out value='${guestGroupNo}'/>" name="guest" value="비회원(guest)" /></th>
										<td>비회원(guest)</td>
									</tr>
							</table>
						</div>
						<div class="btn_s_0 btn_C">
							<span class="btn_s">
								<img src="<%=request.getContextPath()%>/hancer/images/eventCommon/mng/btn_s_a_icon.gif" alt="arrow" class="icon"/>
								<a href="#btn" style="cursor:pointer;" onclick="javascript:forwardTargetGp();"><%=msgs.getString("ev.hnevent.label.confirm")%></a>
							</span>
							<span class="btn_s">
								<a href="#btnclose" style="cursor:pointer;" onclick="javascript:closePop();">닫기</a>
							</span>
						</div>
					</div>
				</fieldset>
			</div>
		</div>
	</form>
</body>
</html>


