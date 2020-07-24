<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tld/utility.tld" %>
<%@ page import="com.saltware.enview.test.TestManager"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Iterator"%>
<%
	String imei = request.getParameter("imei");
	String latitude = request.getParameter("latitude");
	String longitude = request.getParameter("longitude");
	
	if( imei != null ) {
		Map tmpMap = TestManager.getInstance().getData(imei);
		tmpMap.put("y", latitude);
		tmpMap.put("x", longitude);
	}
	
	//System.out.println("##### imei=" + imei + ", latitude=" + latitude + ", longitude=" + longitude);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <title>Google Maps JavaScript API Example</title>
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAOXAu51UBWIKrbn5D94RclBRKNPDrBZQXJ7Ct7DWouoUfznTWgBTkz3ayJ8y_fYYHpi8ms8sc14pgRw"
      type="text/javascript"></script>
    <script type="text/javascript">
	

    function GM_load() {

		var point = null;
		var map = new GMap2(document.getElementById("map")); 
		map.setUIToDefault();
<%
		Hashtable allData = TestManager.getInstance().getData();
		for(Iterator it=allData.keySet().iterator(); it.hasNext(); ) {
			String key = (String)it.next();
			Map tmpMap = (Map)allData.get(key);
			if( tmpMap != null ) {
				String name = (String)tmpMap.get("name");
				System.out.println("###### name=" + name);
				String x = (String)tmpMap.get("x");
				String y = (String)tmpMap.get("y");
%>
		point = new GLatLng("<%=y%>","<%=x%>");
		var marker = new GMarker(point, {
		  //icon : myicon,
		  title :'<%=name%>'
		});
		map.addOverlay(marker); 
<%
			}
		}
%>
		if( point ) {
			map.setCenter(point, 15); 
		}
		else {
			point = new GLatLng("<%=latitude%>","<%=longitude%>");
			map.setCenter(point, 15); 
		}
		
		window.setInterval('window.location.reload()', 60000);
	}
    
   </script>
  </head>
  <body onload="GM_load()" onunload="GUnload()">
    <div id="map" style="width:100%;height:800px"></div>
  </body>
</html>
