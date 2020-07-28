<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title><util:message key="hn.note.label.noteTitle"/></title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/hancer/css/note/default/note.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/hancer/css/note/default/dialog.css" />
	<c:if test="${windowId == null}" var="result">
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_util.js"></script>
	</c:if>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${langKnd}"/>_hn.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/hancer/javascript/note/default/note.js"></script>
		<script type="text/javascript">
			enNote.loginUserId('<c:out value="${userInfo.userId}"/>');
			enNote.logoutUrl('<c:out value="${logoutUrl}"/>');
			$(document).ready(function(){
				//초기에는 받은 쪽지함을 보여준다.
				enNote.viewBox('receive');
		
				//새로 받은 쪽지의 갯수를 불러온다.
				enNote.initNewNoteAmount();
				//body 키 이벤트 핸들러 등록: F2 키를 누르면 검색필드로 focus 이동하여 바로 입력 할 수 있다.
				$('body').keyup(function(event){
					var key = null;
					if(window.event) key = window.event.keyCode;
					else if(event) key = event.which;
					if(key == null) return;
					if(key == 113){ //f2 key
						$('#searchValue').focus();
					}else if(key == 27){ //esc key
						$('#popupMenu').css('display','none');
					}
				});
				
				//body전역에 마우스 다운 이벤트 핸들러 등록
				$('body').mousedown(function(){
					var popup = document.getElementById('popupMenu');
					if(popup == undefined || popup == null){
						return;
					}
					//popupMenu의 절대 위치
					var absLeft = enNote.getAbsLeft('popupMenu');
					var absTop = enNote.getAbsTop('popupMenu');
					
					//popupMenu의 너비와 높이
					var width = eval($('#popupMenu').css('width').replace('px',''));
					var height = eval($('#popupMenu').css('height').replace('px',''));
	
					//마우스 절대 위치
					var x = event.clientX;
					var y = event.clientY;
					
					//클릭된 마우스 버튼(숫자로 리턴:1은 왼쪽, 2는 오른쪽)
					var button = event.button;
					switch(button){
						//마우스 왼쪽 버튼
						case 1: {
							if(absLeft <= x && x <= eval(absLeft + width) &&
							   absTop <= y && y <= eval(absTop + height)){
							}
							else {
								$('#popupMenu').css('display','none');
							}
							break;
						}
						//마우스 오른쪽 버튼
						case 2: {
							break;
						}
					}
				});
				
				$('#langKnd').change(function(){
					enNote.changeLanguage();
				});
			});
		</script>
	</head>
	<body>
		<div class="wrap">
			<div id="userLayer" class="userLayer">
				<div id="changeLangKndLabel" class="changeLangKndLabel"><util:message key="hn.note.label.changeLang"/></div>
				<div id="changeLangKndSelect" class="changeLangSelect">
					<form name="langKndForm" class="langKndForm" id="langKndForm" method="post">
						<select id="langKnd" class="inputField langKnd" name="langKnd">
							<c:forEach items="${langKndList}" var="langKnd">
							<option value="<c:out value="${langKnd.code}"/>"><c:out value="${langKnd.codeName}"/></option>
							</c:forEach>
						</select>
						<script type="text/javascript">
							$('#langKnd').val('<c:out value="${langKnd}"/>');
						</script>
					</form>
					
				</div>
				<div id="homeButton" class="noteButton homeButton" onclick="javascript:enNote.goHome();"><util:message key="hn.note.label.home"/></div>
				<div id="logoutButton" class="noteButton logoutButton" onclick="javascript:enNote.logout();"><util:message key="hn.note.label.logout"/></div>
				<div id="welcomeMessage" class="welcomeMessage"><util:message key="hn.note.label.welcomeMessage"/></div>
			</div>
			<div id="menuLayer" class="menulayer">
				<div  id="menuLayer1" class="menuLayer1">
					<div>
						<div class="workmenu selected" id="readNote"><a href="javascript:enNote.viewBox('receive');"><util:message key="hn.note.label.noteRead"/></a></div>
						<div class="workmenu" id="writeNote"><a href="javascript:enNote.viewWriteForm();"><util:message key="hn.note.label.noteWrite"/></a></div>
						<div class="workmenu" id="userOption"><a href="javascript:enNote.viewUserOptionForm();"><util:message key="hn.note.label.setting"/></a></div>
					</div>
				</div>
				<div id="menuLayer2" class="menuLayer2">
						<div class="receiveboxmenu boxmenu selected" id="receiveboxmenu"><a href="javascript:enNote.viewBox('receive');"><util:message key="hn.note.label.receiveBox"/></a><div id="newNote" class="newNote">0</div></div>
						<c:forEach begin="2" end="0" var="i">
							<div class="userBox"><a href="javascript:enNote.viewBox('receive');">받은쪽지함</a><c:out value="${i}"/></div>
							<div class="userBox">사용자 보관함 <c:out value="${i}"/></div>
						</c:forEach>
						<div class="boxmenu" id="sendboxmenu"><a href="javascript:enNote.viewBox('send');"><util:message key="hn.note.label.sendBox"/></a></div>
						<div class="boxmenu" id="storeboxmenu"><a href="javascript:enNote.viewBox('store');"><util:message key="hn.note.label.storeBox"/></a></div>
						<div class="boxmenu" id="readcheckboxmenu"><a href="javascript:enNote.viewBox('readCheck');"><util:message key="hn.note.label.readCheckBox"/></a></div>
						<div class="boxmenu" id="recyclebinboxmenu"><a href="javascript:enNote.viewBox('recyclebin');"><util:message key="hn.note.label.recyclebinBox"/></a></div>
				</div>
			</div>
			<div id="contentsLayer" class="contentsLayer"></div>
		</div>
	</body>
</html>