<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="java.util.List" %>
<%@ page import="com.saltware.enview.login.LoginConstants" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.saltware.enview.multiresource.MultiResourceBundle"%>
<%@ page import="com.saltware.enview.multiresource.EnviewMultiResourceManager"%>
<%@ page import="com.saltware.enview.sso.EnviewSSOManager" %> 
<%@ page import="com.saltware.enview.Enview" %> 
<%@ page import="com.saltware.enview.domain.DomainInfo" %> 

<%
 Map userInfoMap = null;
 userInfoMap = EnviewSSOManager.getUserInfoMap(request);
 String langKnd = (String)userInfoMap.get("lang_knd");
 MultiResourceBundle msgs = null;
 msgs = EnviewMultiResourceManager.getInstance().getBundle(langKnd);
 
 DomainInfo domain = Enview.getUserDomain();
 String domainId = domain.getDomainId();
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>카테고리 관리</title>
	<%-- 
	<link href="<%=request.getContextPath()%>/hancer/css/super/event/core_approval.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/hancer/css/super/event/cssbasic.css" rel="stylesheet" type="text/css" />
	 --%>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/css/contents.css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/super/event/jquery-1.4.2.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/super/event/json2.js"></script>
	<%
		List categoryList = (List)request.getAttribute("categoryList");
		int len = categoryList.size();
		request.setAttribute("cateListLen",len);
	%>
	<script type="text/javascript">
		var rootPath = '<c:out value="${pageContext.request.contextPath}"/>';
		var resPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/hancer";
		var actPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/hancer/event";
		var cateListLen = 0;
		var userId = '<c:out value="${paramMap.USER_ID}"/>';
		var domainId = '<c:out value="${paramMap.DOMAIN_ID}"/>';
		var adminRole = '<c:out value="${paramMap.ADMIN_ROLE}"/>';
		
		//카테고리 리스트 초기화
		function initCateList(){
			var len = '<c:out value="${cateListLen}" />';
			cateListLen = len;
			if(cateListLen == 0){//추가할 목록만 초기화
				if(adminRole=="Y"){
					document.getElementById("domain0").disabled = true;
				}
				document.getElementById("nmKor0").disabled = true;
				document.getElementById("nmEng0").disabled = true;
				document.getElementById("sort0").disabled = true;
			}
			if(cateListLen > 0){
				for(var i=0;i<eval(cateListLen)+1;i++){
					if(adminRole=="Y"){
						document.getElementById("domain"+i).disabled = true;
					}
				document.getElementById("nmKor"+i).disabled = true;
				document.getElementById("nmEng"+i).disabled = true;
				document.getElementById("sort"+i).disabled = true;
			}
			}
		}
		
		//숫자체크
		function onlyNum(){ 
			var key = event.keyCode;
			if(!(key==8||key==9||key==13||key==46||key==144||(key>=48&&key<=57)||key==110||key==190)){ 
				alert('<%=msgs.getString("ev.hnevent.msg.event.enterNumber")%>'); 
				event.returnValue = false; 
			} 
		}

		//체크박스전체 선택or해제
		function controlMcheck(){
			var chkFalg = document.getElementById("chkAll").checked;
			if(chkFalg){//checkbox 체크했을때
				for(var i=0;i<eval(cateListLen)+1;i++){
					document.getElementById("chkNo"+i).checked =  true;
					if(adminRole=="Y"){
						document.getElementById("domain"+i).disabled = false;
					}
					document.getElementById("nmKor"+i).disabled = false;
					document.getElementById("nmEng"+i).disabled = false;
					document.getElementById("sort"+i).disabled = false;
				}
				//신규Row가추가된 상태에서만 체크
				if(document.getElementById("add_data").style.display == "block"){
					document.getElementById("chkNo0").checked =  true;
					if(adminRole=="Y"){
						document.getElementById("domain0").disabled = false;
					}
					document.getElementById("nmKor0").disabled = false;
					document.getElementById("nmEng0").disabled = false;
					document.getElementById("sort0").disabled = false;
				}
			}else{
				for(var i=0;i<eval(cateListLen)+1;i++){
					document.getElementById("chkNo"+i).checked =  false;
					if(adminRole=="Y"){
						document.getElementById("domain"+i).disabled = true;
					}
					document.getElementById("nmKor"+i).disabled = true;
					document.getElementById("nmEng"+i).disabled = true;
					document.getElementById("sort"+i).disabled = true;
				}
			}
		}
		
		//체크박스 Single 선택 or 해제
		function controlScheck(idx){
			var chkFalg = document.getElementById("chkNo"+idx).checked;
			if(chkFalg){//checkbox 체크했을때
				document.getElementById("chkNo"+idx).checked =  true;
				if(adminRole=="Y"){
					document.getElementById("domain"+idx).disabled = false;
				}
				document.getElementById("nmKor"+idx).disabled = false;
				document.getElementById("nmEng"+idx).disabled = false;
				document.getElementById("sort"+idx).disabled = false;
			}else{
				document.getElementById("chkNo"+idx).checked =  false;
				if(adminRole=="Y"){
					document.getElementById("domain"+idx).disabled = true;
				}
				document.getElementById("nmKor"+idx).disabled = true;
				document.getElementById("nmEng"+idx).disabled = true;
				document.getElementById("sort"+idx).disabled = true;
			}
		}
		
		//추가버튼클릭시 Row추가
		function addRow(){
			document.getElementById("add_data").style.visibility = "visible";
			document.getElementById("add_data").style.display = "";
		}
		
		//더보기버튼 클릭시 5건씩 리스트에 추가
		var dispCnt = '<c:out value="${paramMap.PAGE_SIZE}"/>';
		function moreCategory(n){
			dispCnt = eval(dispCnt) + n;
			document.getElementById("PAGE_NUM").value = "1";
			document.getElementById("PAGE_SIZE").value = dispCnt;
			document.getElementById("cateListForm").submit();
		}
		
		/************************멀티체크 데이터처리(다중)**************************/
		function procMultiData(flag){//저장 OR 삭제 구분
			var dataArr = new Array(); 
			var chkCnt = 0;
			if(flag == 'save'){
				for(var i=0; i<eval(cateListLen)+1; i++){
					if(document.getElementById("chkNo"+i).checked){//선택한 카테고리만 추출
						if(adminRole=="Y"){
							var e = document.getElementById("domain"+i);
							domainId = e.options[e.selectedIndex].value;
						} 
						var nmKor = document.getElementById("nmKor"+i).value;
						var nmEng = document.getElementById("nmEng"+i).value;
						var sort = document.getElementById("sort"+i).value;
						
						if(nmKor!="" && nmEng!="" && sort!=""){
							var row = {CATEGORY_SEQ : document.getElementById("chkNo"+i).name,
									   NM_KOR : document.getElementById("nmKor"+i).value,
									   NM_ENG : document.getElementById("nmEng"+i).value,
									   DSP_ORDER : document.getElementById("sort"+i).value,
									   UPD_USER_ID : userId, DOMAIN_ID : domainId
									};
							dataArr[i] = row;
							chkCnt++;
						}else if(nmKor=="" || (nmKor=="" && nmEng=="") || (nmKor=="" && nmEng=="" && sort=="")){
							alert('<%=msgs.getString("ev.hnevent.msg.event.enterCateKor")%>');
							document.getElementById("nmKor0").focus();
							return;
						}else if(nmEng=="" || (nmEng=="" && sort=="")){
							alert('<%=msgs.getString("ev.hnevent.msg.event.enterCateEng")%>');
							document.getElementById("nmEng0").focus();
							return;
						}else{
							alert('<%=msgs.getString("ev.hnevent.msg.event.enterSort")%>');
							document.getElementById("sort0").focus();
							return;
						}
					}
				}
				if(chkCnt == 0){
					alert('<%=msgs.getString("ev.hnevent.msg.event.noSelectCategory")%>');
					return;
				}
				var jsonStr = dataArr.toJSONString();
				var jsonArray = '{data:'+jsonStr+'}';
				$.ajax({ 
				   type: "POST", 
				   url: actPath+"/insertCate.hanc", 
				   data: "mode=save&data="+jsonArray ,
				   dataType:"text",
				   success: function(data){ 
						alert(data);
						location.reload();
				   }, 
				   error: function(request, status, error) {
						alert('<%=msgs.getString("ev.hnevent.msg.event.networkError")%>');
						//alert(request.responseText);
				   }
				});
			}
			if(flag == 'delete'){
				for(var i=1; i<eval(cateListLen)+1; i++){
					if(document.getElementById("chkNo"+i).checked){//선택한 카테고리만 추출
						var row = {CATEGORY_SEQ : document.getElementById("chkNo"+i).name};
						dataArr[i] = row;
						chkCnt++;
					}
				}
				if(chkCnt == 0){
					alert("선택한 카테고리목록이 없습니다.");
					return;
				}
				var jsonStr = dataArr.toJSONString();
				var jsonArray = '{data:'+jsonStr+'}';
				$.ajax({ 
				   type: "POST", 
				   url: actPath+"/insertCate.hanc", 
				   data: "mode=del&data="+jsonArray ,
				   dataType:"text",
				   success: function(data){ 
						alert(data);
						location.reload();
				   }, 
				   error: function(request, status, error) {
						alert('<%=msgs.getString("ev.hnevent.msg.event.networkError")%>');
						//alert(request.responseText);
				   }
				});
			}
		}
	</script>
</head>
<body onload="initCateList();" style="min-width:1000px;">
	<!-- board first -->
	<div class="board first">
		<!-- searchArea-->
		<div class="tsearchArea">
			<!--pageTitle -->
			<h1><%=msgs.getString("ev.hnevent.label.eventCategoryManagement")%></h1>
			<!--pageTitle// -->
			<fieldset>
				<a href="#link" style="cursor:pointer;" onclick="javascript:addRow();" class="btn_W"><span><%=msgs.getString("ev.hnevent.label.add")%></span></a>
				<a href="#link" style="cursor:pointer;" onclick="javascript:procMultiData('save');" class="btn_W"><span><%=msgs.getString("ev.hnevent.label.bannerSave")%></span></a>
				<a href="#link" style="cursor:pointer;" onclick="javascript:procMultiData('delete');" class="btn_W"><span><%=msgs.getString("ev.hnevent.label.delete")%></span></a>
			</fieldset>		
		</div>
		<!-- searchArea// -->
		<form id="cateListForm" name="cateListForm" action="<%=request.getContextPath()%>/event/selectCateList.hanc" method="post">
			<input type="hidden" id="PAGE_NUM" name="PAGE_NUM" value="<c:out value='${paramMap.PAGE_NUM}'/>"/>
			<input type="hidden" id="PAGE_SIZE" name="PAGE_SIZE" value="<c:out value='${paramMap.PAGE_SIZE}'/>"/>
			<table id="grid-table" cellpadding="0" cellspacing="0" summary="게시판" class="table_board"> 
				<caption>게시판</caption>
				<colgroup>
					<col width="5%" />
					<col width="*" />
					<col width="*" />
					<col width="*" />
					<col width="*" />
				</colgroup>
				<thead>
					<tr>
						<th class="first" scope="col"><span class="table_title"><input name="" title="check all" type="checkbox" id="chkAll" value="" onclick="controlMcheck();" /></span></th>
						<c:if test="${adminRole == 'Y'}">
							<th scope="col"><span class="table_title"><%=msgs.getString("ev.hnevent.label.domainNm")%></span></th>
						</c:if>
						<th scope="col"><span class="table_title"><%=msgs.getString("ev.hnevent.label.categoryNameKor")%></span></th>
						<th scope="col"><span class="table_title"><%=msgs.getString("ev.hnevent.label.categoryNameEng")%></span></th>
						<th scope="col"><span class="table_title"><%=msgs.getString("ev.hnevent.label.sort")%></span></th>
					</tr>
				</thead>
				<tbody>
					<tr id="add_data"  style="visibility: hidden; display: none;"><!--추가버튼클릭시 데이터 입력할 Row -->
						<td class="C"><input type="checkbox" name="" title="chkNo0" id="chkNo0" onclick="controlScheck(0);" /></td>
						<c:if test="${adminRole == 'Y'}">
							<td class="C">
								<div class="sel_100">
									<select id="domain0" name="domain0" class="txt_100">
										<c:forEach items="${domainList}" var="domainInfo">
											<option value="<c:out value="${domainInfo.domainId}"/>"><c:out value="${domainInfo.domainNm}"/></option>
										</c:forEach>
									</select>
								</div>
							</td>
						</c:if>
						<td class="C"><input type="text" class="ts_250" name="" title="nmKor0" id="nmKor0" /></td>
						<td class="C"><input type="text" class="ts_300" name="" title="nmEng0" id="nmEng0" /></td>
						<td class="C"><input type="text" class="ts_50"  name="" title="sort0" id="sort0" style="ime-mode:disabled" onkeypress="onlyNum();"/></td>
					</tr>
					<c:forEach var="item" items="${categoryList}" varStatus="status">
					<tr>
						<td class="C"><input type="checkbox" title="chkNo<c:out value="${status.count}"/>" id="chkNo<c:out value="${status.count}"/>" name="<c:out value="${item.CATEGORY_SEQ}"/>" onclick="controlScheck(<c:out value="${status.count}"/>)" /></td>
							<c:if test="${adminRole == 'Y'}">
								<td class="C">
									<div class="sel_100">
										<select id="domain<c:out value="${status.count}"/>" name="domain" class="txt_100">
											<c:forEach items="${domainList}" var="domainInfo">
													<option value="<c:out value="${domainInfo.domainId}"/>" <c:if test="${item.DOMAIN_ID eq domainInfo.domainId}">selected</c:if>><c:out value="${domainInfo.domainNm}"/></option>
											</c:forEach>
										</select>
									</div>
								</td>
							</c:if>
						<td class="C"><input type="text" class="ts_250" title="nmKor<c:out value="${status.count}"/>" id="nmKor<c:out value="${status.count}"/>" name="" value="<c:out value="${item.NM_KOR}"/>" /></td>
						<td class="C"><input type="text" class="ts_300" title="nmEng<c:out value="${status.count}"/>" id="nmEng<c:out value="${status.count}"/>" name="" value="<c:out value="${item.NM_ENG}"/>" /></td>
						<td class="C"><input type="text" class="ts_50"  title="sort<c:out value="${status.count}"/>"id="sort<c:out value="${status.count}"/>"  name="" value="<c:out value="${item.DSP_ORDER}"/>" style="ime-mode:disabled" onkeypress="onlyNum();" /></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>		
	</div>
	<!-- board first// -->
</body>
</html>