<%@page import="com.saltware.enview.Enview"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<html>
	<head>
		<title>소스 편집</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="robots" content="noindex, nofollow" />
	</head>
	<body>
		<div id="smarteditor" style="display:none;"></div>
		<textarea id="FileManagerEditor_content" name="FileManagerEditor_content" style="width:100%;min-height:450px;" value="" maxLength=""> </textarea>
		<!-- btnArea-->
		<div class="btnArea"> 
			<div class="rightArea">
				<a href="javascript:aFileManager.changeContents()" class="btn_W"><span><util:message key='ev.title.save'/></span></a>
			</div>
		</div>
		<!-- btnArea//-->
		
		<!--<input type="button" value="소스를 가지고 있는 객체보기" onclick="aFileManager.GetContents()"/> -->
	</body>
</html>