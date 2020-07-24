<%@page import="com.saltware.enview.util.StringUtil"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.saltware.enview.Enview" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script language="javascript">
<!--
<%

	String systemId  = (String)request.getAttribute("systemId");
	String fileName = (String)request.getAttribute("fileName");
	String fileMask = (String)request.getAttribute("fileMask");
	String fileSize = (String)request.getAttribute("fileSize");
	String fileSizeSF = (String)request.getAttribute("fileSizeSF");
	String atchType = (String)request.getAttribute("atchType");
	String message  = (String)request.getAttribute("message");
	
	String callback_func  = (String)request.getAttribute("callback_func");	//2014.08.14 smarteditor인 경우 callback_func를 반드시 넣어줘야함.
	
	if ("1".equals( Enview.getConfiguration().getString("board.upload.encode")))
		fileName = new String(fileName.getBytes("EUC-KR"),"8859_1");
	else if ("2".equals( Enview.getConfiguration().getString("board.upload.encode")))
		fileName = new String(fileName.getBytes("8859_1"),"KSC5601");
	else if ("3".equals( Enview.getConfiguration().getString("board.upload.encode")))
		fileName = new String(fileName.getBytes("KSC5601"),"8859_1");
	
	String downloadPath = Enview.getConfiguration().getString("download." + systemId + ".path");
	if (downloadPath==null || "".equals(downloadPath)) {
		downloadPath = "/upload/" + systemId;
	}
	
	String fileYm = fileMask.substring( 1, 7);
	String fileUrl = request.getContextPath() + downloadPath + "/editor/" + fileYm + "/" + fileMask;
	//String fileUrl = request.getContextPath() + "/upload/" + systemId + "/editor/" + fileYm + "/" + fileMask;
	request.setAttribute( "fileUrl", fileUrl );
%>	
<%	
	if (message != null) { 
		message = StringUtil.forJava( message );
%>		
		alert('<%=message%>');
		
<%		if ("E".equals(atchType)) { %>
			// 이미지 첨부 팝업을 닫는다.
			window.close();
<%		} else { %>
			// 업로드 상태창를 숨긴다
			parent.attachFileManager.closeUpload();
<%		}
		return;
	}
%>

<%	if( "E".equals(atchType) || "S".equals(atchType)) { %>
		var atchType = '<%=atchType%>';
		
		if (atchType == 'S') {
			var imageTag = "<img src='<c:out value="${fileUrl}"/>' alt='<c:out value="${fileName}"/>'/>";
			parent.pasteHTML( imageTag);
	       	parent.parent.attachFileManager.handleUpload( '<%=fileName%>', '<%=fileMask%>', <%=fileSize%>, '<%=fileSizeSF%>');
		} else {
			parent.uploadImage('<%=fileUrl%>');
			parent.parent.parent.attachFileManager.handleUpload( '<%=fileName%>', '<%=fileMask%>', <%=fileSize%>, '<%=fileSizeSF%>');
			location.href = '_blank';
		}
<%	} else { %>
		parent.parent.parent.attachFileManager.handleUpload( '<%=fileName%>', '<%=fileMask%>', <%=fileSize%>, '<%=fileSizeSF%>');
		location.href = '_blank';
<%	} %>



//-->
</script>
	 
