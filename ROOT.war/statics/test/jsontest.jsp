<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.saltware.enview.util.json.JSONArray"%>
<%@ page import="com.saltware.enview.util.json.JSONObject"%>
<% 
	String layoutStr = "[{fragment : {page_id:2354}, preference : {WIDTH : 120, HEIGHT : 300}},{fragment : {page_id:1234}, preference : {}}]";
	try {
		System.out.println("########## layoutStr=" + layoutStr);
		JSONArray jsonArray = new JSONArray(layoutStr);
		System.out.println("########## array=" + jsonArray);
		for(int i=0; i<jsonArray.length(); i++) {
			JSONObject fragment = (JSONObject)jsonArray.getJSONObject(i).get("fragment");
    		JSONObject preference = (JSONObject)jsonArray.getJSONObject(i).get("preference");
			JSONArray prefKeys = preference.names();
			if( prefKeys != null ) {
				for(int j=0; j<prefKeys.length(); j++) {
					System.out.println("########## prefKey=" + prefKeys.getString(j));
				}
			}
			System.out.println("########## page_id=" + fragment.get("page_id"));
		}
	}
	catch(Exception e) {
		e.printStackTrace();
	}

%>
