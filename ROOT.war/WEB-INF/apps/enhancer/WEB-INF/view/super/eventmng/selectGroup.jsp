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
<%-- <link href="<%=request.getContextPath()%>/hancer/css/super/event/cssbasic.css" rel="stylesheet" type="text/css" /> --%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/contents.css" />
<%
	List targetGroupList = (List)request.getAttribute("targetGroupList");
	int len = targetGroupList.size();
	request.setAttribute("targetGroupLen",len);
%>
<script type="text/javascript">
	var rootPath = '<c:out value="${pageContext.request.contextPath}"/>';
	var resPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/hancer";
	var actPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/hancer/event";
	var rtnValue = "";
	var targetGroupLen = '<c:out value="${targetGroupLen}"/>';
	
	window.onload=function(){
		var arg = '<c:out value="${paramMap.target_cd}"/>';
		for(var i=0;i<eval(targetGroupLen)+1;i++){
			if(document.getElementById("rdoNo"+i).value == arg){
				document.getElementById("rdoNo"+i).checked = true;
			}
		}
	}
	
	window.onunload = function(){			
		opener.setSrchGroup(rtnValue);
	}
	
	function forwardTargetGp(){
		var gpCode = "";
		var gpName = "";		
		for(var i=0;i<eval(targetGroupLen)+1;i++){

			if(document.getElementById("rdoNo"+i).checked){
				//선택한 신분코드
				gpCode = document.getElementById("rdoNo"+i).value;

				//선택한 신분명
				gpName = document.getElementById("rdoNo"+i).title;
			}
		}

		rtnValue = gpCode +"/"+gpName;
		self.close();
	}
	
	//닫기버튼으로 팝업닫기
	function closePop(){
		self.close();
	}
</script>
</head>
<body style="min-width: auto">
	<!-- sub_contents -->
	<div class="sub_contents">
		<!-- detail -->
		<div class="detail">
			<!-- board first -->
			<div class="board first">
				<!-- searchArea-->
				<div class="tsearchArea">
					<!--pageTitle -->
					<h1><%=msgs.getString("ev.hnevent.label.selectTarget")%></h1>
					<!--pageTitle// -->
				</div>
				<!-- searchArea//-->
				<form name="targetGpForm" id="targetGpForm" action="" method="post">
					<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board">
						<caption>게시판</caption>
						<colgroup>
							<col width="30px" />
							<col width="*" />
						</colgroup>
						<tr>
							<th class="L" scope="row">
								<input type="radio" id="rdoNo0" name="group" title='<%=msgs.getString("ev.hnevent.label.selectAll")%>' value="" />
							</th>
							<td class="L">
								<%=msgs.getString("ev.hnevent.label.selectAll")%>
							</td>
						</tr>
						<c:forEach  items="${targetGroupList}" var="data" varStatus="status">
							<tr>
								<th class="L" scope="row">
									<input type="radio" id="rdoNo<c:out value="${status.count}"/>" name="group" title="<c:out value="${data.PRINCIPAL_NAME}"/>" value="<c:out value="${data.PRINCIPAL_ID}"/>" />
								</th>
								<td class="L">
									<c:out value="${data.PRINCIPAL_NAME}"/>
								</td>
							</tr>
						</c:forEach>
					</table>
				</form>
				<!-- btnArea-->
				<a href="#btn" onclick="javascript:forwardTargetGp();" class="btn_B"><span><%=msgs.getString("ev.hnevent.label.confirm")%></span></a>
				<a href="#btnclose" onclick="javascript:closePop();" class="btn_B"><span>닫기</span></a>				
			</div>
			<!-- board first// -->		
		</div>
		<!-- detail// -->
	</div>
	<!-- sub_contents// -->
</body>
</html>