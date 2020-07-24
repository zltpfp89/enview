<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
out.clear();
out = pageContext.pushBody();
BufferedInputStream bin = null;
BufferedOutputStream bos = null;
try {
	bin = new BufferedInputStream(new FileInputStream((File)request.getAttribute("downloadFile")));
	bos = new BufferedOutputStream(response.getOutputStream());
      		
	byte[] buf = new byte[2048]; //buffer size 2K.
	int read = 0;
	while ((read = bin.read(buf)) != -1) 
		bos.write(buf,0,read);
}finally{
	if( bin !=null) {
		bin.close();
	}
	if( bos !=null) {
		bos.close();
	}
}
%>