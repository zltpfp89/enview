<%@page import="com.clipsoft.clipreport.oof.connection.OOFConnectionMemo"%>

<%@page import="com.clipsoft.clipreport.oof.OOFFile"%>
<%@page import="com.clipsoft.clipreport.oof.OOFDocument"%>
<%@page import="java.io.File"%>
<%@page import="com.clipsoft.clipreport.server.service.ReportUtil"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
OOFDocument oof = OOFDocument.newOOF();

OOFFile file = oof.addFile("crf.root", "%root%/crf/CLIP.crf");

//oof.addConnectionData("*", "oracle1");

oof.addField("ADMIN", "admin");
String data = "<rexdataset><rexrow><ID><![CDATA[3]]></ID><Factory><![CDATA[Paris]]></Factory><Item><![CDATA[TV]]></Item><Production><![CDATA[36]]></Production><Badness><![CDATA[3]]></Badness><Stock><![CDATA[36]]></Stock></rexrow><rexrow><ID><![CDATA[4]]></ID><Factory><![CDATA[Paris]]></Factory><Item><![CDATA[Refrigerator]]></Item><Production><![CDATA[27]]></Production><Badness><![CDATA[5]]></Badness><Stock><![CDATA[78]]></Stock></rexrow><rexrow><ID><![CDATA[5]]></ID><Factory><![CDATA[Paris]]></Factory><Item><![CDATA[Washer]]></Item><Production><![CDATA[16]]></Production><Badness><![CDATA[7]]></Badness><Stock><![CDATA[132]]></Stock></rexrow><rexrow><ID><![CDATA[6]]></ID><Factory><![CDATA[Tokyo]]></Factory><Item><![CDATA[TV]]></Item><Production><![CDATA[68]]></Production><Badness><![CDATA[9]]></Badness><Stock><![CDATA[12]]></Stock></rexrow><rexrow><ID><![CDATA[7]]></ID><Factory><![CDATA[Paris]]></Factory><Item><![CDATA[Video]]></Item><Production><![CDATA[23]]></Production><Badness><![CDATA[12]]></Badness><Stock><![CDATA[78]]></Stock></rexrow><rexrow><ID><![CDATA[8]]></ID><Factory><![CDATA[Tokyo]]></Factory><Item><![CDATA[Audio]]></Item><Production><![CDATA[12]]></Production><Badness><![CDATA[3]]></Badness><Stock><![CDATA[63]]></Stock></rexrow><rexrow><ID><![CDATA[9]]></ID><Factory><![CDATA[London]]></Factory><Item><![CDATA[Electric Fan]]></Item><Production><![CDATA[78]]></Production><Badness><![CDATA[27]]></Badness><Stock><![CDATA[71]]></Stock></rexrow><rexrow><ID><![CDATA[10]]></ID><Factory><![CDATA[Tokyo]]></Factory><Item><![CDATA[Electric Fan]]></Item><Production><![CDATA[53]]></Production><Badness><![CDATA[2]]></Badness><Stock><![CDATA[23]]></Stock></rexrow><rexrow><ID><![CDATA[11]]></ID><Factory><![CDATA[London]]></Factory><Item><![CDATA[Audio]]></Item><Production><![CDATA[23]]></Production><Badness><![CDATA[10]]></Badness><Stock><![CDATA[56]]></Stock></rexrow><rexrow><ID><![CDATA[12]]></ID><Factory><![CDATA[London]]></Factory><Item><![CDATA[TV]]></Item><Production><![CDATA[89]]></Production><Badness><![CDATA[25]]></Badness><Stock><![CDATA[30]]></Stock></rexrow><rexrow><ID><![CDATA[13]]></ID><Factory><![CDATA[Paris]]></Factory><Item><![CDATA[Air Conditioner]]></Item><Production><![CDATA[9]]></Production><Badness><![CDATA[2]]></Badness><Stock><![CDATA[20]]></Stock></rexrow><rexrow><ID><![CDATA[14]]></ID><Factory><![CDATA[Tokyo]]></Factory><Item><![CDATA[Air Conditioner]]></Item><Production><![CDATA[2]]></Production><Badness><![CDATA[0]]></Badness><Stock><![CDATA[18]]></Stock></rexrow><rexrow><ID><![CDATA[15]]></ID><Factory><![CDATA[Tokyo]]></Factory><Item><![CDATA[Washer]]></Item><Production><![CDATA[89]]></Production><Badness><![CDATA[20]]></Badness><Stock><![CDATA[0]]></Stock></rexrow><rexrow><ID><![CDATA[16]]></ID><Factory><![CDATA[London]]></Factory><Item><![CDATA[Refrigerator]]></Item><Production><![CDATA[23]]></Production><Badness><![CDATA[10]]></Badness><Stock><![CDATA[36]]></Stock></rexrow></rexdataset>";

OOFConnectionMemo c = oof.addConnectionMemo("*", data);
c.addContentParamXML("*", "UTF-8", "%dataset.xml.root%");

%><%@include file="Property.jsp"%><%
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
<link rel="stylesheet" type="text/css" href="./css/clipreport.css">
<link rel="stylesheet" type="text/css" href="./css/UserConfig.css">
<link rel="stylesheet" type="text/css" href="./css/font.css">
<script type='text/javascript' src='./js/jquery-1.11.1.js'></script>
<script type='text/javascript' src='./js/clipreport.js'></script>
<script type='text/javascript' src='./js/UserConfig.js'></script>
<script type='text/javascript'>
var urlPath = document.location.protocol + "//" + document.location.host;
	
function html2xml(divPath){	
    var reportkey = "<%=resultKey%>";
	var report = createImportJSPReport(urlPath + "/ClipReport4/Clip.jsp", reportkey, document.getElementById(divPath));
   
	//리포트 실행
    report.view();
}
</script>
</head>
<body onload="html2xml('targetDiv1')">
<div id='targetDiv1' style='position:absolute;top:5px;left:5px;right:5px;bottom:5px;'></div>
</body>
</html>
