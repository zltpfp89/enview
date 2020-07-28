<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title><util:message key="hn.note.label.noteTitle"/></title>
		<link href="<%=request.getContextPath() %>/hancer/css/note/enview/default.css" rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath() %>/hancer/css/note/enview/massege.css" rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath() %>/hancer/css/note/enview/dialog.css" rel="stylesheet" type="text/css" />
	<c:if test="${windowId == null}" var="result">
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/portal_new.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/utility.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/validator.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/board/javascript/enboard_util.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${langKnd}"/>_mm.js"></script>
	</c:if>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${langKnd}"/>_hn.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/hancer/javascript/note/enview/note.js"></script>
		<script type="text/javascript">
			enNote.loginUserId('<c:out value="${userInfo.userId}"/>');
			enNote.logoutUrl('<c:out value="${logoutUrl}"/>');
			$(document).ready(function(event){
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
			});
		</script>
	</head>
	<body>
		<div id="wrap" class="wrap">
			<div id="menuLayer" class="menulayer">
				<!-- 메세지 -->
				<div id="menuLayer1" class="menuLayer1">
					<ul>
						<li class="read"><span><a class="workmenu selected" id="readNote" href="javascript:enNote.viewBox('receive');"><util:message key="hn.note.label.noteRead"/></a></span></li>
						<li class="write"><span><a class="workmenu" id="writeNote" href="javascript:enNote.viewWriteForm();"><util:message key="hn.note.label.noteWrite"/></a></span></li>
						<li class="setup"><span><a class="workmenu" id="userOption"href="javascript:enNote.viewUserOptionForm();"><util:message key="hn.note.label.setting"/></a></span></li>
					</ul>
				</div>
				<!-- 메세지 //-->
				<!-- 메세지함 -->
				<div id="menuLayer2" class="menuLayer2">
					<ul>
						<li><span><a id="receiveboxmenu" class="boxmenu selected" href="javascript:enNote.viewBox('receive');"><util:message key="hn.note.label.receiveBox"/></a></span><strong id="newNote">0</strong></li>
						<li><span><a id="sendboxmenu" class="boxmenu" href="javascript:enNote.viewBox('send');"><util:message key="hn.note.label.sendBox"/></a></span></li>
						<li><span><a id="storeboxmenu" class="boxmenu" href="javascript:enNote.viewBox('store');"><util:message key="hn.note.label.storeBox"/></a></span></li>
						<li><span><a id="readcheckboxmenu" class="boxmenu" href="javascript:enNote.viewBox('readCheck');"><util:message key="hn.note.label.readCheckBox"/></a></span></li>
						<li><span><a id="recyclebinboxmenu" class="boxmenu" href="javascript:enNote.viewBox('recyclebin');"><util:message key="hn.note.label.recyclebinBox"/></a></span></li>
					</ul>
				</div>
				<!-- 메세지함//-->
			</div>
			<!-- 메뉴//-->
			<div id="contentsLayer" class="contentsLayer"></div>
		</div>
	</body>
</html>