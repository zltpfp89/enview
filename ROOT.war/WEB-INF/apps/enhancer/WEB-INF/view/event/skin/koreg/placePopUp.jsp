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
<title><%=msgs.getString("ev.hnevent.label.selectPlace")%></title>
<link href="<%=request.getContextPath()%>/hancer/css/event/cssbasic.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
	var rootPath = '<c:out value="${pageContext.request.contextPath}"/>';
	var resPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/hancer";
	var actPath = '<c:out value="${pageContext.request.contextPath}"/>'+"/event";
	var rtnValue = "";
	var langKnd = '<c:out value="${paramMap.lang_knd}"/>'
	var checkedRdoVal = "srch";

	window.onload = function(){
		document.srchPlace.place[1].checked = true;
		document.getElementById("pNmSelf").disabled = true;
		document.getElementById("add").disabled = true;
		document.getElementById("list").disabled = false;
		document.getElementById("pName").disabled = false;
		document.getElementById("srch").disabled = false;
		document.getElementById("place_list").disabled = false;
		document.getElementById("list").focus();
	}
	window.onunload = function(){
		if(checkedRdoVal == 'srch')
			opener.setPlaceData(rtnValue); 
		if(checkedRdoVal == 'self')
			opener.setPlaceDataSelf(rtnValue); 
	}
	
	//라디오버튼 클릭 제어
	function setRadio(){
		//직접입력 체크
		if(document.srchPlace.place[0].checked){
			checkedRdoVal = "self";
			//직접입력필드 able
			document.getElementById("pNmSelf").disabled = false;
			document.getElementById("add").disabled = false;
			//학내검색필드 disable
			document.getElementById("list").disabled = true;
			document.getElementById("pName").disabled = true;
			document.getElementById("srch").disabled = true;
			document.getElementById("place_list").style.visibility = 'hidden';
		}
		//학내검색 체크
		if(document.srchPlace.place[1].checked){
			checkedRdoVal = "srch";
			//직접입력필드 disable
			document.getElementById("pNmSelf").disabled = true;
			document.getElementById("add").disabled = true;
			//학내검색필드 able
			document.getElementById("list").disabled = false;
			document.getElementById("pName").disabled = false;
			document.getElementById("srch").disabled = false;
			document.getElementById("place_list").style.visibility = 'visible';
		}
	}

	//직접입력
	function addEvPlaceSelf(){
		var pName = document.getElementById("pNmSelf").value;
		if(trim(pName) == ""){
			alert('<%=msgs.getString("ev.hnevent.msg.event.enterPlace")%>');
			document.getElementById("pNmSelf").focus();
			return;
		}else{
			rtnValue = pName;
			self.close();
		}
	}
	function trim(str){
		str = str.replace(/(^\s*)|(\s*$)/g, "");
		return str;
	}

	//학내검색
	function srchEvPlace(){
		var sel = document.getElementById("list");
		var srchType = sel.options[sel.selectedIndex].value
		var srchText = document.getElementById("pName").value;
		if(document.getElementById("pName").value != ""){
			$.ajax({ 
			   type: "POST", 
			   url: actPath+"/searchPlace.hanc", 
			   data: "SRCH_TYPE="+srchType+"&SRCH_TEXT="+srchText,
			   dataType:"json",
			   success: function(data){ 
					var msg = data.errorMsg;
					var moreEv = data.data;
					var html = '<ul>';
					if(msg == 'NoError'){
						if(moreEv.length <= 0){
							html+='<li>'+'<%=msgs.getString("ev.hnevent.msg.event.noFoundPlace")%>'+'</li>';
						}else{
							for ( var i = 0; i < moreEv.length; i++) {
							var ndata = moreEv[i];
							if(langKnd == 'ko')
								html+='<li style="cursor:pointer;" onmouseover="addUnderLine(this);" onmouseout="delUnderLine(this);"><dl onclick="setPlace('+i+')"><dd id="place'+i+'">'+ndata.PLACE_NO+'/'+ndata.PLACE_BUILDING_KOR+'</dd><dd style="display:none;" id="latLon'+i+'">'+ndata.PLACE_BUILDING_ENG+'/'+ndata.PLACE_SUB_NO+'/'+ndata.LATITUDE+'/'+ndata.LONGITUDE+'</dd></dl></li>';
							if(langKnd == 'en')
								html+='<li style="cursor:pointer;" onmouseover="addUnderLine(this);" onmouseout="delUnderLine(this);"><dl onclick="setPlace('+i+')"><dd id="place'+i+'">'+ndata.PLACE_NO+'/'+ndata.PLACE_BUILDING_ENG+'</dd><dd style="display:none;" id="latLon'+i+'">'+ndata.PLACE_BUILDING_KOR+'/'+ndata.PLACE_SUB_NO+'/'+ndata.LATITUDE+'/'+ndata.LONGITUDE+'</dd></dl></li>';
							}
						}
						html+='</ul>';
						document.getElementById("place_list").innerHTML = html;
					}else{
						alert(msg);
					}
			   }, 
			   error: function(request, status, error) {
					alert('<%=msgs.getString("ev.hnevent.msg.event.networkError")%>');
			   }
			}); 
		}else{
			alert('<%=msgs.getString("ev.hnevent.msg.event.enterSearchTerm")%>');
			document.getElementById("pName").focus();
			return;
		}
	}
	
	function setPlace(idx){
		if(document.srchPlace.place[1].checked){
			var pName = (document.getElementById("place"+idx).textContent)?document.getElementById("place"+idx).textContent : document.getElementById("place"+idx).innerText;
			var pLatLon = (document.getElementById("latLon"+idx).textContent)?document.getElementById("latLon"+idx).textContent : document.getElementById("latLon"+idx).innerText;
			rtnValue = pName +":"+pLatLon;
			self.close();
		}
	}

	//엔터키로검색
	function fn_EnterKey(obj){
		if(event.keyCode == 13){
			if(obj.id == "pName" && document.getElementById("pName").value != ""){
				srchEvPlace();
				event.returnValue=false;
			}else{
				alert('<%=msgs.getString("ev.hnevent.msg.event.enterSearchTerm")%>');
				document.getElementById("pName").focus();
				return;
			}
		}	
	}

	//마우스 오버시 폰트Red
	function addUnderLine(obj){
		obj.style.color='blue';
	}
	//마우스 아웃시 폰트Black
	function delUnderLine(obj){
		obj.style.color='black';
	}

	//닫기버튼으로 팝업닫기
	function closePop(){
		self.close();
	}
</script>
</head>
<body>
	<div class="popup_wrap">
		<div class="header"><h1><%=msgs.getString("ev.hnevent.label.selectPlace")%></h1></div>
		<div class="content">
			<fieldset>
				<legend></legend>
				<div class="table_list">
					<div class="list">
						<form name="srchPlace" id="srchPlace" action="" method="post">
							<table class="tabletype3" id="" border="0" cellspacing="0" summary="장소선택 입니다.">
								<caption><%=msgs.getString("ev.hnevent.label.selectPlace")%></caption>
								<colgroup>
								<col width="100px;" />
								<col width="*" />
								</colgroup>
								<tr>
									<th scope="row"><input type="radio" name="place" value="self" onclick="setRadio();"/><%=msgs.getString("ev.hnevent.label.directInput")%></th>
									<td><input type="text" title="place name" name="pNmSelf" id="pNmSelf" class="ts_200" />&nbsp;&nbsp;<input type="button" name="add" id="add" value="<%=msgs.getString("ev.hnevent.label.input")%>" onclick="addEvPlaceSelf();"/></td>
								</tr>
								<tr>
									<th scope="row"><input type="radio" name="place" value="srch" onclick="setRadio();"/><%=msgs.getString("ev.hnevent.label.searchInUniv")%></th>
									<td>
										<select name="list" id="list" class="ts_50" title="place list">
											<option value="name"><%=msgs.getString("ev.hnevent.label.name")%></option>
											<option value="dong"><%=msgs.getString("ev.hnevent.label.dong")%></option>											
										</select>
										<input type="text" title="place name" name="pName" id="pName" class="ts_150" onkeydown="javascript:fn_EnterKey(this);" onpaste="javascript:return false;" />&nbsp;
										<input type="button" name="srch" id="srch" value="<%=msgs.getString("ev.hnevent.label.search")%>" onclick="srchEvPlace();"/>
									</td>
								</tr>
								<tr><td colspan="2"><div id="place_list"><font color="red"><center>[<%=msgs.getString("ev.hnevent.msg.event.limitMapInfo")%>]<center></font></div></td></tr>
							</table>
						</form>
					</div>
					<div class="btn right">
						<span class="btn_s">
							<a href="#btnclose" style="cursor:pointer;" onclick="javascript:closePop();">닫기</a>
						</span>
					</div>
				</div>
			</fieldset>
		</div>
	</div>
</body>
</html>


