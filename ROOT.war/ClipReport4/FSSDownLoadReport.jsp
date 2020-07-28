<%@page import="java.util.StringTokenizer"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.clipsoft.clipreport.oof.connection.OOFConnectionMemo"%>
<%@page import="com.clipsoft.clipreport.export.option.PDFOption"%>
<%@page import="com.clipsoft.clipreport.oof.OOFFile"%>
<%@page import="com.clipsoft.clipreport.oof.OOFDocument"%>
<%@page import="com.clipsoft.clipreport.server.service.ClipReportExport"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="com.saltware.enview.Enview"%>
<%@page import="com.saltware.enface.util.DateUtil"%>
<%@page import="com.saltware.enface.util.StringUtil"%>

<%@page import="com.clipsoft.clipreport.server.service.ReportUtil"%>
<%@include file="/ClipReport4/Property.jsp"%>

<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
try{
	
OOFDocument oof = OOFDocument.newOOF();

request.setCharacterEncoding("UTF-8");

String url = request.getRequestURL().toString();
String reptNm = request.getParameter("reptNm") == null?"":request.getParameter("reptNm");
String SEQNUM = request.getParameter("SENDNUM");
String POLICENAME = request.getParameter("POLICENAME"); //아이디 
String isMulti = request.getParameter("isMulti"); //아이디 

System.out.println("파라미터(매개변수 필드)==>> SENDNUM : " + SENDNUM );
System.out.println("파라미터(매개변수 필드)==>> POLICENAME : " + POLICENAME );

OOFFile file = oof.addFile("crf.root", "%root%/crf/"+reptNm);

String uploadPath = null;
File localFileSave = null;
FileOutputStream fileStream = null;
PDFOption option = null;
String sendNo = null;

int statusType = 0;
if("Y".equals(isMulti)){
	StringTokenizer stnzSendNo = new StringTokenizer(StringUtil.isNullToString(SENDNUM, ""), ",");
	while(stnzSendNo.hasMoreTokens()){
		sendNo = stnzSendNo.nextToken();
		oof.addField("SENDNUM",sendNo);
		oof.addField("POLICENAME",POLICENAME);
		
		oof.addConnectionData("*","oracle2"); 
		
		//서버에 파일로 저장할 때
		uploadPath = Enview.getConfiguration().getString("sjpb.file.fax.main.path");
		if(url.contains("localhost")){
			localFileSave = new File("D:\\" + sendNo + ".pdf");
		} else {
			localFileSave = new File(uploadPath + sendNo + ".pdf");
		}
		
		fileStream = new FileOutputStream(localFileSave);
		
		statusType = ClipReportExport.createExportForPDF(request, fileStream, propertyPath, oof, option);
	}
} else {
	oof.addField("SENDNUM",sendNo);
	oof.addField("POLICENAME",POLICENAME);
	
	oof.addConnectionData("*","oracle2"); 
	
	//서버에 파일로 저장할 때
	uploadPath = Enview.getConfiguration().getString("sjpb.file.fax.main.path");
	if(url.contains("localhost")){
		localFileSave = new File("D:\\" + sendNo + ".pdf");
	} else {
		localFileSave = new File(uploadPath + sendNo + ".pdf");
	}
	
	fileStream = new FileOutputStream(localFileSave);
	
	statusType = ClipReportExport.createExportForPDF(request, fileStream, propertyPath, oof, option);
}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type='text/javascript'>
try{
	if("<%= isMulti %>" == "Y"){
		parent.afterPdfMulti("<%= SENDNUM %>");
	} else {
		parent.afterPdfMade("<%= SENDNUM %>");
	}
}catch(e){
	alert(e);
}
</script>
</head>
<body></body>
</html>
<% }catch(Exception e){
	e.printStackTrace(new PrintWriter(out));
}%>
