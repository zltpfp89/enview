<%@page import="java.util.List"%>
<%@page import="com.saltware.enview.sso.EnviewSSOManager"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page contentType="text/html; charset=UTF-8"%>
<pre>
<%
	Map userInfoMap = EnviewSSOManager.getUserInfoMap(request);
	String status ="";
	String id ="";
	String pwd ="";
	String clsid ="";
	String dsdcode ="";
	String name ="";
	String enname ="";
	String deptcode ="";
	String deptname ="";
	String positioncode="";
	String positionname="";
	String rolecode ="";
	String rolename="";
	String exdata ="";
	
	
	String eq = "@@EQUAL@@";
	String gubun = "@@DELIM@@";
	status = "LOGIN";
	id = (String)userInfoMap.get("userId");
	pwd = (String)userInfoMap.get("encPassword");
	clsid ="{1CEB70FD-234E-40BD-A5CC-CFF6ACCAC133}";
	dsdcode = "0100000000001610";
	name = (String)userInfoMap.get("nmKor");
	enname = (String)userInfoMap.get("nmKor");
	deptcode = (String)userInfoMap.get("orgcd");
	deptname = (String)userInfoMap.get("orgName");
	positioncode = "01";
	positionname ="수사관";
	rolecode = "01";
	rolename ="수사관";
	exdata = "01";
	
	String url = "status"+eq+status+gubun+"id"+eq+id+gubun+"pwd"+eq+pwd+gubun+"clsid"+eq+clsid+gubun+
	"dsdcode"+eq+dsdcode+gubun+"name"+eq+name+gubun+"enname"+eq+enname+gubun+"deptcode"+eq+deptcode+gubun+
	"deptname"+eq+deptname+gubun+"positioncode"+eq+positioncode+gubun+"rolecode"+eq+rolecode+gubun+"rolename"+eq+rolename+gubun+"exdata"+eq+exdata;
	

	byte[] encoded = Base64.encodeBase64(url.getBytes());
	url = new String(encoded);
	url =  java.net.URLEncoder.encode(url);
	
	

%>
</pre>
<html lang="ko-KR">
	<head>
		<meta charset="UTF-8">
		<title>수사정보포털시스템</title>
	</head>
	<!--
		<script>
			location.href ="fssoexcast://setuserinfo?msg=<%=url%>";
		</script>
	-->
</html>