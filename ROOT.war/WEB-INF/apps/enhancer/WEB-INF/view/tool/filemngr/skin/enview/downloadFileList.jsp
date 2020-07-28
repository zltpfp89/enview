<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>파일업로드</title>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/hancer/css/tool/enview/fileManager.css" type="text/css">
		<c:if test="${windowId == null}" var="result">
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common.js"></script> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		</c:if>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${langKnd}"/>_hn.js"></script>
		<script type="text/javascript">
			var contextPath = "<%= request.getContextPath()%>";
		</script> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/hancer/javascript/tool/multipart.js"></script>
		<script type="text/javascript">
			function selectFile(obj){
				$('#downloadFile').val($(obj).attr('id'));
				$('.downFile').removeClass('selected');
				$(obj).addClass('selected');
				
				$('.down_btn').css('display', 'none');
				$('#down_btn_' + $(obj).attr('id')).css('display', 'block');
			}
			
			function fileDownload(fileId, fileName){
				if(confirm('\'' + fileName  + '\'를 다운로드 하시겠습니까?')){
					var url = '<%=request.getContextPath() %>/tool/fileManager.hanc?m=download&fileId=' + fileId;
					location.href= url;
				}
			}
		</script>
	</head>
	<body>
		<div id="fileListPanel" class="downFileListPanel">
			<div id="uploadedFileList" class="downFileList">
				<c:forEach items="${ fileList }" var="fileVo">
					<div id="<c:out value="${fileVo.fileId }"/>" class="downFile" onclick="javascript:selectFile(this)"><div id="fileName" class="fileName"><c:out value="${fileVo.originalFileName }"/>(<c:out value="${fileVo.fileSize }"/><c:out value="${fileVo.fileUnit }"/>)</div><div id="down_btn_<c:out value="${fileVo.fileId }"/>" class="down_btn" onclick="javascript:fileDownload('<c:out value="${fileVo.fileId }"/>', '<c:out value="${fileVo.originalFileName }"/>');">▼</div></div>
				</c:forEach>
			</div>
		</div>
		<input id="fileIds" name="fileIds" type="hidden" value="<c:out value="${fileIds}"/>"/>
	</body>
	<script>
		$('.down_btn').css('display', 'none');
	</script>
</html>