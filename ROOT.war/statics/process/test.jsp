<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="com.saltware.enface.util.HttpClientUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%

	String data  ="";
	/*
	StringBuffer json = new StringBuffer();
    String line = null;
    try {
        BufferedReader reader = request.getReader();
        while((line = reader.readLine()) != null) {
            json.append(line);
        }
 
    }catch(Exception e) {
        System.out.println("Error reading JSON string: " + e.toString());
    }
	data =  json.toString();
	*/
	
	
	HttpClientUtil util = new HttpClientUtil();
	
	data = util.getBody(request);
	
    

	System.out.println("11111");
	System.out.println(data);
	
	JSONParser parser = new JSONParser(); 
	JSONObject result = (JSONObject) parser.parse(data);
	
	
	JSONObject header = (JSONObject)result.get("header");
	String licenseKey = (String) header.get("licenseKey");
	String apiTp = (String) header.get("apiTp");
	String groupSeq = (String) header.get("groupSeq");
	System.out.println("licenseKey = "+  licenseKey);
	System.out.println("apiTp = "+  apiTp);
	System.out.println("groupSeq = "+  groupSeq);

	JSONObject body = (JSONObject)result.get("body");
	String checkPolicy = (String) body.get("checkPolicy");
	String loginId = (String) body.get("loginId");
	String passwdNew = (String) body.get("passwdNew");
	
	
	System.out.println("checkPolicy = "+  checkPolicy);
	System.out.println("loginId = "+  loginId);
	System.out.println("passwdNew = "+  passwdNew);
		
	
	
	

%>