<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="com.saltware.enface.util.HttpClientUtil"%>
<%@ page import="org.json.simple.JSONObject" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%

	String paramStr = "";
	
	String url = "http://portal.yonam.ac.kr/enview/yonam/pwdChgAdapter.face";
	JSONObject body =new JSONObject();
	JSONObject header = new JSONObject();
	JSONObject param = new JSONObject();
	
	HttpClientUtil util = new HttpClientUtil();
	

	header.put("apiCode", "yonamenviewduzone");

	param.put("userId", "20162003");
	param.put("newPwd", "choidr14!!");

	
	body.put("header", header);
	body.put("body", param);
	

	paramStr = body.toJSONString();
	try {
		org.json.JSONObject result = new org.json.JSONObject(util.getHttpClientPostJson(url, paramStr, 3));
		/*
		if (result != null && result.get("resultCode") != null) {
			if ("SUCCESS".equals(result.get("resultCode"))) {
			   // log.info("result.get('resultMessage') ===="+ result.get("resultMessage") );
			} else {
			   // log.info("result.get('resultMessage') ===="+ result.get("resultMessage") );
			}
		}*/
		
		System.out.println("result  === " +  result);
	} catch (Exception e) {
		e.printStackTrace();
	}               



%>