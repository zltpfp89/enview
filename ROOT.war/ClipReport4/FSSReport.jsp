<%@page import="com.clipsoft.clipreport.oof.connection.OOFConnectionMemo"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="com.clipsoft.clipreport.oof.OOFFile"%>
<%@page import="com.clipsoft.clipreport.oof.OOFDocument"%>
<%@page import="java.io.File"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="com.clipsoft.clipreport.server.service.ReportUtil"%>

<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
OOFDocument oof = OOFDocument.newOOF();

request.setCharacterEncoding("UTF-8");

String url = request.getRequestURL().toString();
String reptNm = request.getParameter("reptNm") == null?"":request.getParameter("reptNm");
String SEQNUM = request.getParameter("SEQNUM");
String POLICENAME = request.getParameter("POLICENAME");

System.out.println("파라미터(매개변수 필드)==>> SEQNUM : " + SEQNUM );

OOFFile file = oof.addFile("crf.root", "%root%/crf/"+reptNm);

oof.addField("SEQNUM",SEQNUM);
oof.addField("POLICENAME",POLICENAME);

if(url.contains("localhost")){
	//로컬에 연결
    oof.addConnectionData("*","oracle1");
}else{
    //운영에 연결
    oof.addConnectionData("*","oracle2"); 
}

%><%@include file="/ClipReport4/Property.jsp"%><%
//세션을 활용하여 리포트키들을 관리하지 않는 옵션
//request.getSession().setAttribute("ClipReport-SessionList-Allow", false);
String resultKey =  ReportUtil.createReport(request, oof, "false", "false", request.getRemoteAddr(), propertyPath);
//리포트의 특정 사용자 ID를 부여합니다.
//clipreport4.properties 의 useuserid 옵션이 true 일 때만 적용됩니다. 
//clipreport4.properties 의 useuserid 옵션이 true 이고 기본 예제[String resultKey =  ReportUtil.createReport(request, oof, "false", "false", request.getRemoteAddr(), propertyPath);] 사용 했을 때 세션ID가 userID로 사용 됩니다.
//String resultKey =  ReportUtil.createReport(request, oof, "false", "false", request.getRemoteAddr(), propertyPath, "userID");

//리포트key의 사용자문자열을 추가합니다.(문자숫자만 가능합니다.)
//String resultKey =  ReportUtil.createReport(request, oof, "false", "false", request.getRemoteAddr(), propertyPath, "", "usetKey");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" type="text/css" href="/ClipReport4/css/clipreport.css">
<link rel="stylesheet" type="text/css" href="/ClipReport4/css/UserConfig.css">
<link rel="stylesheet" type="text/css" href="/ClipReport4/css/font.css">
<script type='text/javascript' src='/ClipReport4/js/jquery-1.11.1.js'></script>
<script type='text/javascript' src='/ClipReport4/js/clipreport.js'></script>
<script type='text/javascript' src='/ClipReport4/js/UserConfig.js'></script>
<script type='text/javascript'>
var urlPath = document.location.protocol + "//" + document.location.host;
	
function html2xml(divPath){	
	var reportkey = "<c:out value="${ resultKey }" />";
    
	//var report = createImportJSPReport(urlPath + "/ClipReport4/ClipAndFasoo.jsp", reportkey, document.getElementById(divPath));
	var report = createImportJSPReport(urlPath + "/ClipReport4/Clip.jsp", reportkey, document.getElementById(divPath));
	
	report.setPrintSelectNames("html","프린트");
	//report.setSavingFileOption(false);   
   
	//리포트 실행
    report.view();
}
</script>
</head>
<body onload="html2xml('targetDiv1')">
<div id='targetDiv1' style='position:absolute;top:5px;left:5px;right:5px;bottom:5px;'></div>
</body>
</html>
