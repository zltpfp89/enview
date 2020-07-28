<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>파일업로드</title>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/face/css/tool/searchZip.css" type="text/css">
		<c:if test="${windowId == null}" var="result">
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common.js"></script> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery/jquery-1.10.2.min.js"></script>
		<script type='text/javascript' src="<%=request.getContextPath()%>/javascript/jquery/jquery-ui-1.9.2.custom.min.js"></script>
		</c:if>
		<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/message/mrbun_<c:out value="${langKnd}"/>_hn.js"></script>
		<script type="text/javascript">
			var contextPath = "<%= request.getContextPath()%>";
		</script> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/face/javascript/tool/multipart.js"></script>
		<script type="text/javascript">
			
		</script>
	</head>
	<body>
		<form id="uploadForm" action="<%=request.getContextPath() %>/hancer/fileManager.hanc" method="post" enctype="multipart/form-data">
			<label>File </label><input type="file" id="multipartFile" name="multipartFile"/><input id="upload" type="submit" value="upload"/>
		</form>
		<div id="uploadOutput"></div>
		<c:out value="${fileName }"/>, <c:out value="${fileSize }"/>MB, <c:out value="${fileType }"/>
	</body>
</html>