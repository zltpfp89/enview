<%@ page import="com.saltware.enview.test.TestManager"%>
<%
	String imei = request.getParameter("imei");
	String latitude = request.getParameter("latitude");
	String longitude = request.getParameter("longitude");
	
	TestManager.getInstance().setData(imei, latitude, longitude);
	
	System.out.println("##### imei=" + imei + ", latitude=" + latitude + ", longitude=" + longitude + ", session=" + session.getId());
%>
