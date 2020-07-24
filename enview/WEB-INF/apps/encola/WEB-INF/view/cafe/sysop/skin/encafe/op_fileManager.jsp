<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title><util:message key="cf.prop.fileUpload"/></title>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/hancer/css/tool/fileManager.css" type="text/css">
		<c:if test="${windowId == null}" var="result">
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/messageResource_<c:out value="${langKnd}"/>.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${cmntVO.langKnd}"/>_mm.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${cmntVO.langKnd}"/>_ev.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${cmntVO.langKnd}"/>_cf.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${cmntVO.langKnd}"/>_eb.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common.js"></script> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		</c:if>
		<script type="text/javascript">
			var contextPath = "<%= request.getContextPath()%>";
		</script> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/face/javascript/main.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/face/javascript/tool/multipart.js"></script>
		<script type="text/javascript">
			function selectFile(obj){
				$('#downloadFile').val($(obj).attr('id'));
				$('.downFile').removeClass('selected');
				$(obj).addClass('selected');
				
				$('.del_btn').css('display', 'none');
				$('.down_btn').css('display', 'none');
				$('#del_btn_' + $(obj).attr('id')).css('display', 'block');
				$('#down_btn_' + $(obj).attr('id')).css('display', 'block');
			}
			
			function fileDownload(fileId, fileName){
		   		<c:if test="${langKnd eq 'ko' }">
					if(confirm('\'' + fileName  + '\'를 다운로드 하시겠습니까?')){
						var url = '<%=request.getContextPath() %>/hancer/fileManager.hanc?m=download&fileId=' + fileId + '&appsName=<%=request.getParameter("appsName")%>' + '&limitedAmount=' + <%=request.getParameter("limitedAmount")%>;;
						location.href= url;
					}
				</c:if>
				<c:if test="${langKnd eq 'en' }">
					if(confirm('Do you want to download \'' + fileName  + '\'')){
						var url = '<%=request.getContextPath() %>/hancer/fileManager.hanc?m=download&fileId=' + fileId + '&appsName=<%=request.getParameter("appsName")%>' + '&limitedAmount=' + <%=request.getParameter("limitedAmount")%>;;
						location.href= url;
					}
				</c:if>
			}
			
			function fileDelete(fileId, fileName){
		   		<c:if test="${langKnd eq 'ko' }">
		   			if(confirm('\'' + fileName + '\'를 삭제하시겠습니까?')){
				</c:if>
				<c:if test="${langKnd eq 'en' }">
					if(confirm('Do you want to delete \'' + fileName + '\')){
				</c:if>
					var fileIds = '<%=request.getParameter("fileIds")%>';
					fileIds.replace(fileId +':', '');
					var url = '<%=request.getContextPath() %>/hancer/fileManager.hanc?m=delete';
					var data = '&fileId=' + fileId + 
								'&appsName=' + '<%=request.getParameter("appsName")%>' + 
								'&limitedAmount=' + '<%=request.getParameter("limitedAmount")%>' + 
								'&fileIds=<c:out value="${fileIds}"/>';
					url += data;
					location.href= url;
				}
			}
			
			function concatAppsName(){
				if($('#multipartFile').val() == ''){
					alert("<util:message key="cf.info.selectFile"/>");
					return false;
				}
				var form = $('#uploadForm');
				var action = form.attr('action') + 
							'&appsName=' + '<%=request.getParameter("appsName")%>' + 
							'&limitedAmount=' + '<%=request.getParameter("limitedAmount")%>' +
							'&fileIds=<c:out value="${fileIds}"/>';
				form.attr('action', action);
				return true;
			}
			
			function searchFile(){
				var fileNames = $('#multipartFile').val().split("\\");
				$('#fileInput').val(fileNames[fileNames.length-1]);
			}
			
			function uploadFile(){
				var limitedAmount = <%=request.getParameter("limitedAmount")%>;
				if(limitedAmount != null && limitedAmount <= $('.downFile').length){
				   	<c:if test="${langKnd eq 'ko' }">
			   			alert('파일은 총 ' + limitedAmount + '개만 첨부가능합니다.');
					</c:if>
					<c:if test="${langKnd eq 'en' }">
						alert('Only  ' + limitedAmount + 'files can be attached.');
					</c:if>
					return false;
				}
				var form = $('#uploadForm');
				form.submit();
			}
			$(document).ready(function(){
				var IE = document.all ? true : false;
				
				var mX = 0;
				var mY = 0;
				
				if(!IE){
					document.addEventListener("mousemove", getMousePosition, false);
				}
				
				function getMousePosition(event){
					mX = event.clientX + document.body.scrollLeft;
					mY = event.clientY + document.body.scrollTop;
				}
				
				function getMouseX(){
					if(IE){
						return (event.clientX + document.body.scrollLeft);
					}
					else{
						return mX;
					}
				}
				
				function getMouseY(){
					if(IE){
						return (event.clientY + document.body.scrollTop);
					}else{
						return mY;
					}
				}
				
				$('#multipartFile').mousemove(function(){
					var x = getMouseX();
					var y = getMouseY();
					if(308 <= x && x <= 349 && 9 <= y && y <= 27){
						$('#multipartFile').css('cursor', 'pointer');
						$('#search_btn').css('border', '1px solid #323232');
						$('#search_btn').css('background-color', '#EEE');
					}else{
						$('#multipartFile').css('cursor', 'default');
						$('#search_btn').css('border', '1px solid #858585');
						$('#search_btn').css('background-color', '#DDD');
					}
				});
				
				$('#multipartFile').mouseout(function(){
					$('#multipartFile').css('cursor', 'default');
					$('#search_btn').css('border', '1px solid #858585');
					$('#search_btn').css('background-color', '#DDD');
				});
			});
			
			
			
			function changeCSS(method){
				if(method == 'down') {
					$('#search_btn').css('background-color', '#ADF');
					$('#search_btn').css('border', '1px solid #323232');
				}
				else if(method == 'up') {
					$('#search_btn').css('background-color', '#EEE');
					$('#search_btn').css('border', '1px solid #858585');
				}
			}
			
				
		</script>
	</head>
	<body>
		<div id="fileListPanel" class="fileListPanel">
			<form id="uploadForm" class="uploadForm" action="<%=request.getContextPath() %>/hancer/fileManager.hanc?m=upload" method="post" enctype="multipart/form-data" onsubmit="return concatAppsName()">
				<input type="text" id="fileInput" name="fileInput" class="fileInput" readonly="readonly"/>
				<!-- input id="upload" class="up_btn" type="submit" value="전송"/-->
				<div id="upload" class="up_btn" onclick="uploadFile()"><c:out value="${lang.transForm }"/></div>
				<div id="search_btn" class="search_btn"><c:out value="${ lang.discover }"/></div>
				<input type="file" size="34" id="multipartFile" name="multipartFile" class="uploadFileInput" onchange="searchFile()" onmousedown="changeCSS('down')" onmouseup="changeCSS('up')"/>
			</form>
			<div id="uploadedFileList" class="fileList">
				<c:forEach items="${ fileList }" var="fileVo">
					<div id="<c:out value="${fileVo.fileId }"/>" class="downFile" onclick="javascript:selectFile(this)"><div id="fileName" class="fileName"><c:out value="${fileVo.originalFileName }"/>(<c:out value="${fileVo.fileSize }"/><c:out value="${fileVo.fileUnit }"/>)</div><div id="del_btn_<c:out value="${fileVo.fileId }"/>" class="del_btn" onclick="javascript:fileDelete('<c:out value="${fileVo.fileId }"/>', '<c:out value="${fileVo.originalFileName }"/>');">x</div><div id="down_btn_<c:out value="${fileVo.fileId }"/>" class="down_btn" onclick="javascript:fileDownload('<c:out value="${fileVo.fileId }"/>', '<c:out value="${fileVo.originalFileName }"/>');">▼</div></div>
				</c:forEach>
			</div>
		</div>
		<input id="sfileIds" name="fileIds" type="hidden" value="<c:out value="${fileIds}"/>"/>
	</body>
	<script>
		$('.del_btn').css('display', 'none');
		$('.down_btn').css('display', 'none');
	</script>
</html>