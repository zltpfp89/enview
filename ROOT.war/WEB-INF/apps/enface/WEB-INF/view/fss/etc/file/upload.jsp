<%@ page import="com.saltware.enboard.util.FormatUtil"%>
<%@ page import="com.saltware.enboard.util.Constants"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.saltware.enview.Enview" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%
	String fileSubDir = null;
	String fileId = null;
	String fileName = null;
	String fileMask = null;
	String fileSize = null;
	String fileType = null;
	String contentType = null;
	String mode = null; 
	String message = null;  
	String callback_func = null;
	String year = null;
	String month = null;
	String idType = null;

	if(request.getAttribute("fileSubDir") != null) fileSubDir = (String)request.getAttribute("fileSubDir");	
	if(request.getAttribute("fileName") != null) fileName = (String)request.getAttribute("fileName");
	if(request.getAttribute("fileMask") != null) fileMask = (String)request.getAttribute("fileMask");
	if(request.getAttribute("fileSize") != null) fileSize = (String)request.getAttribute("fileSize");
	if(request.getAttribute("mode") != null) mode     = (String)request.getAttribute("mode");
	if(request.getAttribute("message") != null) message  = (String)request.getAttribute("message");
	if(request.getAttribute("year") != null) year  = (String)request.getAttribute("year");
	if(request.getAttribute("month") != null) month  = (String)request.getAttribute("month");
	if(request.getAttribute("contentType") != null) contentType  = (String)request.getAttribute("contentType");
	if(request.getAttribute("fileId") != null) fileId  = (String)request.getAttribute("fileId");
	if(request.getAttribute("fileType") != null) fileType  = (String)request.getAttribute("fileType");
	if(request.getAttribute("idType") != null) idType  = (String)request.getAttribute("idType");

	//2014.08.14 smarteditor인 경우 callback_func를 반드시 넣어줘야함.
	if(request.getAttribute("callback_func") != null) callback_func  = (String)request.getAttribute("callback_func");	
	if (fileName != null) {
		if ("1".equals( Enview.getConfiguration().getString("board.upload.encode"))){
			fileName = new String(fileName.getBytes("EUC-KR"),"8859_1");
		}else if ("2".equals( Enview.getConfiguration().getString("board.upload.encode"))){
			fileName = new String(fileName.getBytes("8859_1"),"KSC5601");
		}else if ("3".equals( Enview.getConfiguration().getString("board.upload.encode"))){
			fileName = new String(fileName.getBytes("KSC5601"),"8859_1");	
		}
	} else {
		throw new NullPointerException("File Name is null");
	}
	
	String imageFileUrl = "/upload/common/editor/" + year + "/" + month + "/" + fileMask;
	String fileInfo = fileId + "^" + fileName + "^" + fileSize + "^" + fileType + "^" + year + "/" + month + "^" + contentType;
%>

<%if (message != null) { // UploadMngr 에서 Exception 을 catch 한 경우.%>
<script language="javascript">
<!--
	alert('<%=message%>');
<%	if ("editor".equals(mode) || "smarteditor".equals(mode)) { %>
	window.close();
<%	} else { 
		if("seal".equals(idType)){	%>
			parent.ekrFile_seal.closeUpload();
		<%		} else if("id".equals(idType)){	%>
			parent.ekrFile_id.closeUpload();
		<%		} else if("sign".equals(idType)){	%>
			parent.ekrFile_sign.closeUpload();
		<%		} else {	%>
			parent.ekrFile.closeUpload();
		<%		}	
// 	parent.ekrFile.closeUpload(); // Progress bar(id='uploading') 의 style 을 'none' 으로 바꾼다.
	} %>
//-->
</script>
<%
	return;
}
%>


<script language="javascript">
<!--
<%------------------------------------------------------%>
<%if ("icon".equals(mode)) { %>
	if ("<%=fileMask%>" == "" || "<%=fileMask%>" == "null")
		alert('<eb:message bundle="lcBun" key="attach.upload.fail"/>');

	window.opener.pasteImage("<%=fileMask%>");
	window.close();
<%	} else if ("photo".equals(mode)) { %>
	if ("<%=fileMask%>" == "" || "<%=fileMask%>" == "null")
		alert('<eb:message bundle="lcBun" key="attach.upload.fail"/>');

	window.opener.pastePhoto("<%=fileMask%>");
	window.close();

<%------------------------------------------------------%>
<%} else if ("editor".equals(mode) || "flash".equals(mode) || "smarteditor".equals(mode)) { %>
	if ("<%=fileMask%>" == "" || "<%=fileMask%>" == "null")
		alert('파일 업로드에 실패하였습니다.');

	var mode = '<%=mode%>';
	if(mode == 'smarteditor') {
        // execute callback script
        var sUrl = "";
		sUrl += "callback_func=<%=callback_func%>";
		sUrl += "&bNewLine=true";
		sUrl += "&sFileName=<%=fileMask%>";
		sUrl += "&sFileURL=<%=imageFileUrl%>";
        
		if (sUrl != "blank") {
	        var oParameter = {}; // query array

	        sUrl.replace(/([^=]+)=([^&]*)(&|$)/g, function(){
	            oParameter[arguments[1]] = arguments[2];
	            return "";
	        });
	        
	        if ((oParameter.errstr || '').length) { // on error
	            (parent.jindo.FileUploader._oCallback[oParameter.callback_func+'_error'])(oParameter);
	        } else {
		        (parent.jindo.FileUploader._oCallback[oParameter.callback_func+'_success'])(oParameter);
		   }
	      // parent.opener.parent.ekrFile.rebuildFile("<%=fileName%>", "<%=fileMask%>", <%=fileSize%>);
		}
	} else {
		parent.uploadImage("<%=imageFileUrl%>");
		// parent.parent.parent.ekrFile.rebuildFile("<%=fileName%>", "<%=fileMask%>", <%=fileSize%>);				
	}

<%------------------------------------------------------%>
<%	} else if ("attach".equals(mode)) { // 첨부파일을 업로드 하는 경우.	
		if("seal".equals(idType)){	%>
			parent.ekrFile_seal.closeUpload();
<%		} else if("id".equals(idType)){	%>
			parent.ekrFile_id.closeUpload();
<%		} else if("sign".equals(idType)){	%>
			parent.ekrFile_sign.closeUpload();
<%		} else {	%>
			parent.ekrFile.closeUpload();
<%		}	%>
	
	if ("<%=fileMask%>" == "" || "<%=fileMask%>" == "null")
		alert('파일업로드중 문제가 발생하였습니다.\n관리자에게 문의해주세요.');
	else {
		<%--
		  1. 전체 파일 크기에 방금 업로드된 파일의 크기를 더해주고,
		  2. 전체 파일 크기의 단위(B,KB,MB)를 정하고,
		  3. 파일 목록을 보여주는 'select' boxt에 방금 업로드된 파일을 추가하고,
		  4. iframe 의 location.href 를 blank.brd 로 바꾸어버린다.
		--%>
		var filesize = <%=fileSize%>;

<%	if("seal".equals(idType)){	%>
		var totalsize = eval("parent.document.setUpload_seal.totalsize.value");
<%	} else if("id".equals(idType)){	%>
		var totalsize = eval("parent.document.setUpload_id.totalsize.value");
<%	} else if("sign".equals(idType)){	%>
		var totalsize = eval("parent.document.setUpload_sign.totalsize.value");
<%	} else {	%>
		var totalsize = eval("parent.document.setUpload.totalsize.value");
<%	}	%>
		
		totalsize = eval(totalsize) + eval(filesize);

		var unit = "";
		var calsize = "";
    	if ((totalsize > 1024) && (totalsize < 1024 * 1024)) {
			unit = " KB";
    		calsize = (totalsize/1024)+"";
		} else if (totalsize >= 1024 * 1024) {
			unit = " MB";
			calsize = (totalsize/(1024*1024))+"";
		} else {
			unit = " Bytes";
    		calsize = totalsize+"";
		}

		if (calsize.indexOf(".") > -1) {
			var sosu = calsize.substring(calsize.indexOf("."), calsize.length);

			if (sosu.length > 4)
				calsize = calsize.substring(0,calsize.indexOf("."))+sosu.substring(0,4);
		}

<%	if("seal".equals(idType)){	%>
		parent.document.setUpload_seal.totalsize.value = totalsize;
		parent.document.setUpload_seal.viewsize.value = "총 파일 크기: "+calsize+unit;
<%	} else if("id".equals(idType)){	%>
		parent.document.setUpload_id.totalsize.value = totalsize;
		parent.document.setUpload_id.viewsize.value = "총 파일 크기: "+calsize+unit;
<%	} else if("sign".equals(idType)){	%>
		parent.document.setUpload_sign.totalsize.value = totalsize;
		parent.document.setUpload_sign.viewsize.value = "총 파일 크기: "+calsize+unit;
<%	} else {	%>
		parent.document.setUpload.totalsize.value = totalsize;
		parent.document.setUpload.viewsize.value = "총 파일 크기: "+calsize+unit;
<%	}	%>

		var val = "<%=fileInfo%>";
		var fsize = eval(filesize); var funit = "";
		if ((fsize > 1024) && (fsize < 1024 * 1024)) {
			funit = " KB";
			fsize = fsize/1024 + "";
		} else if (fsize >= 1024 * 1024) {
			funit = " MB";
			fsize = fsize/(1024*1024) + "";
		} else {
			funit = " Bytes";
			fsize = fsize + "";
		}
		if (fsize.indexOf(".") > -1) {
			var fsosu = fsize.substring(fsize.indexOf("."), fsize.length);
			if (fsosu.length > 4)
				fsize = fsize.substring(0,fsize.indexOf("."))+fsosu.substring(0,4);
		}
		<%-- 파일명 뒤에 파일 사이즈를 같이 보여준 --%>
		var text = "<%=fileName%> (" + fsize + funit + ")";
		
<%	if("seal".equals(idType)){	%>
		parent.ekrFile_seal.handleUpload( text, val);
		parent.uploadSealData();
<%	} else if("id".equals(idType)){	%>
		parent.ekrFile_id.handleUpload( text, val);
		parent.uploadIdData();
<%	} else if("sign".equals(idType)){	%>
		parent.ekrFile_sign.handleUpload( text, val);
		parent.uploadSignData();
<%	} else {	%>
		parent.ekrFile.handleUpload( text, val);
<%	}	%>
		
		location.href = '/comm/file/blank.face';
	}
<% 	} %>
//-->
</script>
